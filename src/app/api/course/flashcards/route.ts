import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

const FALLBACK = (title: string) => ({
  titleCard: {
    headline: `Master ${title}`,
    subheadline: 'Go from beginner to job-ready with structured video lessons',
    emoji: '🚀',
    imageKeyword: 'code',
  },
  courseOverview: {
    welcome: `Hey! In this course, you will learn how to master ${title}. We have divided this into structured modules to build your path to job-ready skillsets. 🚀`,
    modules: [
      { title: 'Core Concepts', description: 'Understand the foundations and basic components.', emoji: '💡' },
      { title: 'Practical Application', description: 'Build and deploy real-world projects.', emoji: '⚙️' }
    ]
  },
  glossary: [
    { term: 'Module', definition: 'A structured chapter containing related lessons and a concept quiz.', example: 'Each module is followed by an assessment.', emoji: '📖', imageKeyword: 'code' },
    { term: 'Syllabus', definition: 'The structured outline of topics covered in the course.', example: 'Review the syllabus to understand the roadmap.', emoji: '🗺️', imageKeyword: 'design' },
    { term: 'XP', definition: 'Rewards earned for completing lessons and passing quizzes.', example: 'Earn 10 XP for each lesson completed.', emoji: '⭐', imageKeyword: 'analytics' },
    { term: 'Certificate', definition: 'A credential awarded upon completing the entire course.', example: 'Share your certificate on LinkedIn.', emoji: '🏆', imageKeyword: 'design' },
    { term: 'Quiz', definition: 'A brief assessment at the end of each module to test your knowledge.', example: 'Unlock the next module by passing the quiz.', emoji: '🧠', imageKeyword: 'server' }
  ],
  glossaryQuiz: [
    { question: 'What is a Module?', options: ['A video lesson', 'A chapter with lessons + quiz', 'A certificate', 'A career path'], correctIndex: 1, term: 'Module' },
    { question: 'What do you earn for completing lessons?', options: ['Badges', 'Certificates', 'XP', 'Credits'], correctIndex: 2, term: 'XP' },
    { question: 'When do you earn a Certificate?', options: ['After one lesson', 'After one module', 'After completing the full course', 'After signing up'], correctIndex: 2, term: 'Certificate' },
    { question: 'What is a Career Path?', options: ['A single course', 'A sequence of courses for job readiness', 'A quiz', 'A video playlist'], correctIndex: 1, term: 'Career Path' },
  ],
  courseMap: {
    overview: "You'll go through curated video lessons, test your knowledge with module quizzes, and prove your skills with a final assessment.",
    steps: ['Watch expert-curated video lessons', 'Complete module quizzes to unlock the next level', 'Pass the final module test', 'Earn your certificate + share it on LinkedIn'],
  },
})

export async function POST(req: NextRequest) {
  const { courseId } = await req.json()
  if (!courseId) return NextResponse.json({ error: 'Missing courseId' }, { status: 400 })

  const db = await supabaseServer()

  const { data: course } = await db
    .from('courses')
    .select('title, flashcard_data')
    .eq('id', courseId)
    .single()

  if (!course) return NextResponse.json({ error: 'Course not found' }, { status: 404 })

  return NextResponse.json(course.flashcard_data ?? FALLBACK(course.title))
}
