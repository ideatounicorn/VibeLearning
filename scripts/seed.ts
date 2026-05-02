#!/usr/bin/env tsx
/**
 * VibeLearn Seed Script
 * Usage: npx tsx scripts/seed.ts
 *
 * Requirements: .env.local must have NEXT_PUBLIC_SUPABASE_URL,
 *               SUPABASE_SERVICE_ROLE_KEY, and GEMINI_API_KEY set.
 *
 * Idempotent: safe to re-run. Skips existing records.
 */

import * as fs from 'fs'
import * as path from 'path'
import { createClient } from '@supabase/supabase-js'
import { parse } from 'csv-parse/sync'
import { GoogleGenerativeAI } from '@google/generative-ai'
import * as dotenv from 'dotenv'

// Load env
dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!
const GEMINI_KEY = process.env.GEMINI_API_KEY!

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('❌ Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env.local')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
})

const genAI = GEMINI_KEY ? new GoogleGenerativeAI(GEMINI_KEY) : null

// ── Helpers ─────────────────────────────────────────────

const sleep = (ms: number) => new Promise(res => setTimeout(res, ms))

function extractVideoId(url: string): string | null {
  try {
    const u = new URL(url)
    if (u.hostname.includes('youtu.be')) return u.pathname.slice(1)
    const v = u.searchParams.get('v')
    if (v) return v
    // Playlist-only URLs → no embed
    if (u.searchParams.get('list') && !v) return null
    return null
  } catch {
    return null
  }
}

function slugify(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '')
}

// ── Path definitions ─────────────────────────────────────

const PATHS = [
  {
    name: 'AI Product Building',
    slug: 'ai-product-building',
    description: 'Build real AI products using LLMs, APIs, and no-code tools. From idea to shipped.',
    category: 'AI',
    hero_color: '#6366F1',
    order_index: 1,
    salary_range: '$60K–$140K/yr',
    is_published: true,
    is_coming_soon: false,
  },
  {
    name: 'UX Design',
    slug: 'ux-design',
    description: 'Design intuitive products people love. Figma, user research, and prototyping.',
    category: 'Design',
    hero_color: '#C084FC',
    order_index: 2,
    salary_range: '$55K–$120K/yr',
    is_published: true,
    is_coming_soon: false,
  },
  {
    name: 'Product Management',
    slug: 'product-management',
    description: 'Lead products from 0 to 1. PRDs, roadmaps, stakeholder management.',
    category: 'Product',
    hero_color: '#F5C842',
    order_index: 3,
    salary_range: '$70K–$150K/yr',
    is_published: true,
    is_coming_soon: false,
  },
  {
    name: 'Digital Marketing',
    slug: 'digital-marketing',
    description: 'Grow brands with content, ads, SEO, and email. Full-stack modern marketing.',
    category: 'Marketing',
    hero_color: '#FB923C',
    order_index: 4,
    salary_range: '$45K–$100K/yr',
    is_published: true,
    is_coming_soon: false,
  },
  {
    name: 'Data Analysis',
    slug: 'data-analysis',
    description: 'Turn raw data into decisions. SQL, Python, visualization, and storytelling.',
    category: 'Data',
    hero_color: '#34D399',
    order_index: 5,
    salary_range: '$55K–$130K/yr',
    is_published: false,
    is_coming_soon: true,
  },
]

// Course → path mapping (adjust based on your CSV data)
const COURSE_PATH_MAP: Record<string, string> = {
  'ui-ux-design': 'ux-design',
  'ux-design': 'ux-design',
  'figma': 'ux-design',
  'product-management': 'product-management',
  'product-strategy': 'product-management',
  'agile': 'product-management',
  'digital-marketing': 'digital-marketing',
  'seo': 'digital-marketing',
  'content-marketing': 'digital-marketing',
  'social-media': 'digital-marketing',
  'email-marketing': 'digital-marketing',
  'data-analysis': 'data-analysis',
  'python': 'data-analysis',
  'sql': 'data-analysis',
  'excel': 'data-analysis',
  'ai': 'ai-product-building',
  'machine-learning': 'ai-product-building',
  'chatgpt': 'ai-product-building',
  'prompt-engineering': 'ai-product-building',
}

function mapCourseToPath(courseSlug: string, courseTitle: string): string {
  const slug = courseSlug.toLowerCase()
  for (const [key, pathSlug] of Object.entries(COURSE_PATH_MAP)) {
    if (slug.includes(key) || courseTitle.toLowerCase().includes(key)) {
      return pathSlug
    }
  }
  // Default fallback
  return 'digital-marketing'
}

// ── Gemini generation ────────────────────────────────────

async function generateLessonContent(lessons: Array<{ id: string; title: string; youtube_url: string }>) {
  if (!genAI) {
    console.log('⚠️  Skipping Gemini generation — GEMINI_API_KEY not set')
    return
  }

  const model = genAI.getGenerativeModel({ model: 'gemini-1.5-flash' })

  const BATCH_SIZE = 8
  const batches = []
  for (let i = 0; i < lessons.length; i += BATCH_SIZE) {
    batches.push(lessons.slice(i, i + BATCH_SIZE))
  }

  console.log(`\n🤖 Generating lesson context for ${lessons.length} lessons in ${batches.length} batches...`)

  for (let bi = 0; bi < batches.length; bi++) {
    const batch = batches[bi]
    console.log(`  Batch ${bi + 1}/${batches.length} (${batch.length} lessons)`)

    const prompt = `You are a career education expert. For each YouTube lesson below, generate:
1. "why_this_video": A single compelling sentence (max 25 words) explaining WHY this specific video matters for career growth. Use "you" address. Be specific to the title.
2. "skills_gained": An array of 2-4 skill tags (1-3 words each).

Respond ONLY with a valid JSON array. Example format:
[{"id":"abc","why_this_video":"You'll learn...","skills_gained":["Skill A","Skill B"]}]

Lessons:
${batch.map(l => `{"id":"${l.id}","title":"${l.title.replace(/"/g, "'")}","url":"${l.youtube_url}"}`).join('\n')}`

    try {
      const result = await model.generateContent(prompt)
      const text = result.response.text().trim()
      const jsonMatch = text.match(/\[[\s\S]*\]/)
      if (!jsonMatch) throw new Error('No JSON array found in response')

      const generated = JSON.parse(jsonMatch[0]) as Array<{
        id: string
        why_this_video: string
        skills_gained: string[]
      }>

      for (const item of generated) {
        await supabase
          .from('lessons')
          .update({
            why_this_video: item.why_this_video,
            skills_gained: item.skills_gained,
          })
          .eq('id', item.id)
      }

      console.log(`  ✓ Batch ${bi + 1} done`)
    } catch (err) {
      console.error(`  ✗ Batch ${bi + 1} failed:`, err)
    }

    if (bi < batches.length - 1) await sleep(400)
  }
}

async function generateQuizzes(modules: Array<{ id: string; title: string; lessons: Array<{ title: string }> }>) {
  if (!genAI) {
    console.log('⚠️  Skipping quiz generation — GEMINI_API_KEY not set')
    return
  }

  const model = genAI.getGenerativeModel({ model: 'gemini-1.5-flash' })

  const BATCH_SIZE = 4
  const batches = []
  for (let i = 0; i < modules.length; i += BATCH_SIZE) {
    batches.push(modules.slice(i, i + BATCH_SIZE))
  }

  console.log(`\n🧠 Generating quizzes for ${modules.length} modules in ${batches.length} batches...`)

  for (let bi = 0; bi < batches.length; bi++) {
    const batch = batches[bi]
    console.log(`  Batch ${bi + 1}/${batches.length}`)

    const prompt = `You are a career education expert creating quiz questions for learning modules.

For each module below, generate exactly 3 multiple-choice questions that test understanding of the concepts covered.

Rules:
- Questions must be answerable from the lesson titles/topics (conceptual knowledge)
- 4 options: a, b, c, d
- Exactly one correct answer
- Include a brief explanation (1 sentence) for why the correct answer is right
- Keep questions practical and career-relevant, not trivia

Respond ONLY with valid JSON:
[{"module_id":"...","questions":[{"question":"...","option_a":"...","option_b":"...","option_c":"...","option_d":"...","correct_option":"a","explanation":"..."},...]}]

Modules:
${batch.map(m => `{"module_id":"${m.id}","module_title":"${m.title.replace(/"/g, "'")}","lessons":${JSON.stringify(m.lessons.map(l => l.title).slice(0, 8))}}`).join('\n')}`

    try {
      const result = await model.generateContent(prompt)
      const text = result.response.text().trim()
      const jsonMatch = text.match(/\[[\s\S]*\]/)
      if (!jsonMatch) throw new Error('No JSON array found')

      const generated = JSON.parse(jsonMatch[0]) as Array<{
        module_id: string
        questions: Array<{
          question: string
          option_a: string
          option_b: string
          option_c: string
          option_d: string
          correct_option: string
          explanation: string
        }>
      }>

      for (const item of generated) {
        const quizRows = item.questions.map((q, i) => ({
          module_id: item.module_id,
          question: q.question,
          option_a: q.option_a,
          option_b: q.option_b,
          option_c: q.option_c,
          option_d: q.option_d,
          correct_option: q.correct_option,
          explanation: q.explanation,
          order_index: i + 1,
        }))

        await supabase.from('quizzes').upsert(quizRows, {
          onConflict: 'module_id,order_index',
          ignoreDuplicates: true,
        })
      }

      console.log(`  ✓ Batch ${bi + 1} done`)
    } catch (err) {
      console.error(`  ✗ Batch ${bi + 1} failed:`, err)
    }

    if (bi < batches.length - 1) await sleep(500)
  }
}

// ── Main seed function ───────────────────────────────────

async function seed() {
  console.log('🌱 VibeLearn Seed Script\n')

  // ── Step 1: Seed paths ──
  console.log('📍 Step 1: Seeding paths...')
  const { data: existingPaths } = await supabase.from('paths').select('slug')
  const existingPathSlugs = new Set((existingPaths ?? []).map((p: { slug: string }) => p.slug))

  const pathsToInsert = PATHS.filter(p => !existingPathSlugs.has(p.slug))
  if (pathsToInsert.length > 0) {
    const { error } = await supabase.from('paths').insert(pathsToInsert)
    if (error) { console.error('Path insert error:', error); process.exit(1) }
    console.log(`  ✓ Inserted ${pathsToInsert.length} paths`)
  } else {
    console.log(`  ✓ All paths already exist`)
  }

  // Fetch path map
  const { data: allPaths } = await supabase.from('paths').select('id, slug')
  const pathIdMap: Record<string, string> = {}
  for (const p of allPaths ?? []) pathIdMap[p.slug] = p.id

  // ── Step 2: Parse & seed courses ──
  console.log('\n📚 Step 2: Seeding courses + modules from CSV...')

  const csvDir = path.join(process.cwd(), '..')  // YouSkill root
  const courseCsvPath = path.join(csvDir, 'Course_export.csv')

  if (!fs.existsSync(courseCsvPath)) {
    console.warn(`  ⚠️  Course_export.csv not found at ${courseCsvPath} — skipping`)
  } else {
    const courseRaw = fs.readFileSync(courseCsvPath, 'utf-8')
    const courses = parse(courseRaw, { columns: true, skip_empty_lines: true }) as Record<string, string>[]
    console.log(`  Parsed ${courses.length} courses from CSV`)

    for (const row of courses) {
      const slug = row.slug ?? slugify(row.title ?? row.name ?? '')
      if (!slug) continue

      const pathSlug = mapCourseToPath(slug, row.title ?? '')
      const pathId = pathIdMap[pathSlug]
      if (!pathId) continue

      // Check if course exists
      const { data: existing } = await supabase
        .from('courses')
        .select('id')
        .eq('slug', slug)
        .single()

      let courseId = existing?.id
      if (!courseId) {
        const { data: inserted } = await supabase
          .from('courses')
          .insert({
            path_id: pathId,
            title: row.title ?? row.name,
            slug,
            description: row.description ?? null,
            order_index: parseInt(row.order ?? '0') || 0,
          })
          .select('id')
          .single()
        courseId = inserted?.id
      }
    }
    console.log(`  ✓ Courses seeded`)
  }

  // ── Step 3: Parse & seed lessons ──
  console.log('\n🎬 Step 3: Seeding lessons from CSV...')

  const lessonCsvPath = path.join(csvDir, 'Lesson_export.csv')

  if (!fs.existsSync(lessonCsvPath)) {
    console.warn(`  ⚠️  Lesson_export.csv not found at ${lessonCsvPath} — skipping`)
  } else {
    const lessonRaw = fs.readFileSync(lessonCsvPath, 'utf-8')
    const lessons = parse(lessonRaw, { columns: true, skip_empty_lines: true }) as Record<string, string>[]
    console.log(`  Parsed ${lessons.length} lessons from CSV`)

    let inserted = 0
    let skipped = 0

    for (const row of lessons) {
      const legacyId = row._id ?? row.id ?? null
      if (!legacyId) continue

      // Find module by legacy ID or title
      const { data: module } = await supabase
        .from('modules')
        .select('id')
        .eq('legacy_id', row.moduleId ?? row.module_id ?? '')
        .single()

      if (!module) { skipped++; continue }

      const youtubeUrl = row.url ?? row.youtube_url ?? row.link ?? ''
      const videoId = extractVideoId(youtubeUrl)

      const { error } = await supabase.from('lessons').upsert(
        {
          module_id: module.id,
          legacy_id: legacyId,
          title: row.title ?? row.name,
          youtube_url: youtubeUrl,
          youtube_video_id: videoId,
          order_index: parseInt(row.order ?? row.orderIndex ?? '0') || 0,
          duration_minutes: row.duration ? parseFloat(row.duration) : null,
        },
        { onConflict: 'module_id,legacy_id', ignoreDuplicates: true }
      )
      if (!error) inserted++
      else skipped++
    }

    console.log(`  ✓ ${inserted} lessons inserted, ${skipped} skipped`)
  }

  // ── Step 4: Gemini lesson context ──
  console.log('\n🤖 Step 4: Generating lesson context with Gemini...')
  const { data: lessonsTodo } = await supabase
    .from('lessons')
    .select('id, title, youtube_url')
    .is('why_this_video', null)
    .limit(500)

  if (lessonsTodo && lessonsTodo.length > 0) {
    await generateLessonContent(lessonsTodo)
  } else {
    console.log('  ✓ All lessons already have context')
  }

  // ── Step 5: Generate quizzes ──
  console.log('\n🧠 Step 5: Generating module quizzes...')

  // Find modules without 3 quiz questions
  const { data: allModules } = await supabase
    .from('modules')
    .select('id, title')
    .limit(500)

  const modulesNeedingQuizzes: Array<{ id: string; title: string; lessons: Array<{ title: string }> }> = []

  for (const mod of allModules ?? []) {
    const { count } = await supabase
      .from('quizzes')
      .select('*', { count: 'exact', head: true })
      .eq('module_id', mod.id)

    if ((count ?? 0) < 3) {
      const { data: modLessons } = await supabase
        .from('lessons')
        .select('title')
        .eq('module_id', mod.id)
        .order('order_index')
        .limit(10)
      modulesNeedingQuizzes.push({ ...mod, lessons: modLessons ?? [] })
    }
  }

  if (modulesNeedingQuizzes.length > 0) {
    console.log(`  Found ${modulesNeedingQuizzes.length} modules needing quizzes`)
    await generateQuizzes(modulesNeedingQuizzes)
  } else {
    console.log('  ✓ All modules already have quizzes')
  }

  console.log('\n✅ Seed complete!\n')
}

seed().catch(console.error)
