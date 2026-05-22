import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)

async function run() {
  console.log('=== DATABASE INVENTORY & INTEGRITY REPORT ===\n')

  // 1. Paths
  const { data: paths, error: pathsErr } = await supabase.from('paths').select('*').order('order_index')
  if (pathsErr) {
    console.error('Error fetching paths:', pathsErr)
    return
  }
  console.log(`--- PATHS (${paths.length} total) ---`)
  console.table(paths.map(p => ({
    id: p.id,
    name: p.name,
    slug: p.slug,
    is_published: p.is_published,
    category: p.category,
    order_index: p.order_index
  })))

  // 2. Courses per Path
  const { data: courses, error: coursesErr } = await supabase.from('courses').select('*')
  if (coursesErr) {
    console.error('Error fetching courses:', coursesErr)
    return
  }

  console.log(`\n--- COURSES (${courses.length} total) ---`)
  const coursesPerPath: Record<string, number> = {}
  let nullPathCount = 0
  for (const c of courses) {
    if (c.path_id) {
      coursesPerPath[c.path_id] = (coursesPerPath[c.path_id] || 0) + 1
    } else {
      nullPathCount++
    }
  }

  console.log('Courses count per Path:')
  console.table(paths.map(p => ({
    path_name: p.name,
    path_slug: p.slug,
    course_count: coursesPerPath[p.id] || 0
  })))
  console.log(`Courses with NULL path_id: ${nullPathCount}`)

  // 3. Empty Courses (no modules)
  const { data: modules, error: modulesErr } = await supabase.from('modules').select('*')
  if (modulesErr) {
    console.error('Error fetching modules:', modulesErr)
    return
  }
  console.log(`\n--- MODULES (${modules.length} total) ---`)
  const modulesPerCourse: Record<string, number> = {}
  for (const m of modules) {
    modulesPerCourse[m.course_id] = (modulesPerCourse[m.course_id] || 0) + 1
  }

  const emptyCourses = courses.filter(c => !modulesPerCourse[c.id])
  console.log(`Empty courses (0 modules) count: ${emptyCourses.length}`)
  if (emptyCourses.length > 0) {
    console.log('Sample empty courses:')
    console.table(emptyCourses.slice(0, 10).map(c => ({ id: c.id, title: c.title, slug: c.slug })))
  }

  // 4. Empty Modules (no lessons)
  const { data: lessons, error: lessonsErr } = await supabase.from('lessons').select('*')
  if (lessonsErr) {
    console.error('Error fetching lessons:', lessonsErr)
    return
  }
  console.log(`\n--- LESSONS (${lessons.length} total) ---`)
  const lessonsPerModule: Record<string, number> = {}
  for (const l of lessons) {
    lessonsPerModule[l.module_id] = (lessonsPerModule[l.module_id] || 0) + 1
  }

  const emptyModules = modules.filter(m => !lessonsPerModule[m.id])
  console.log(`Empty modules (0 lessons) count: ${emptyModules.length}`)
  if (emptyModules.length > 0) {
    console.log('Sample empty modules:')
    console.table(emptyModules.map(m => {
      const parentCourse = courses.find(c => c.id === m.course_id)
      return {
        module_id: m.id,
        module_title: m.title,
        course_title: parentCourse?.title || 'UNKNOWN'
      }
    }))
  }

  // 5. Quizzes
  const { data: quizzes, error: quizzesErr } = await supabase.from('quizzes').select('*')
  if (quizzesErr) {
    console.error('Error fetching quizzes:', quizzesErr)
    return
  }
  console.log(`\n--- QUIZZES (${quizzes.length} total) ---`)
  const quizzesPerModule: Record<string, number> = {}
  for (const q of quizzes) {
    quizzesPerModule[q.module_id] = (quizzesPerModule[q.module_id] || 0) + 1
  }

  const modulesWithFewQuizzes = modules.map(m => ({
    module_title: m.title,
    course_title: courses.find(c => c.id === m.course_id)?.title || 'UNKNOWN',
    quiz_count: quizzesPerModule[m.id] || 0
  })).filter(m => m.quiz_count < 3)

  console.log(`Modules with less than 3 quiz questions: ${modulesWithFewQuizzes.length}`)
  if (modulesWithFewQuizzes.length > 0) {
    console.table(modulesWithFewQuizzes.slice(0, 10))
  }

  // 6. Assessments
  const { data: assessments, error: assessmentsErr } = await supabase.from('assessments').select('*')
  if (assessmentsErr) {
    console.error('Error fetching assessments:', assessmentsErr)
    return
  }
  const { data: assQuestions, error: assQuestionsErr } = await supabase.from('assessment_questions').select('*')
  if (assQuestionsErr) {
    console.error('Error fetching assessment questions:', assQuestionsErr)
    return
  }

  console.log(`\n--- STANDALONE ASSESSMENTS (${assessments.length} total) ---`)
  const questionsPerAssessment: Record<string, number> = {}
  for (const aq of assQuestions) {
    questionsPerAssessment[aq.assessment_id] = (questionsPerAssessment[aq.assessment_id] || 0) + 1
  }

  console.table(assessments.map(a => ({
    id: a.id,
    title: a.title,
    slug: a.slug,
    expected_questions: a.question_count,
    actual_questions: questionsPerAssessment[a.id] || 0,
    gap: (a.question_count || 0) - (questionsPerAssessment[a.id] || 0)
  })))
}

run()
