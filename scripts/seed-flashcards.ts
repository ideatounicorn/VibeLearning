/**
 * One-time script: generate flashcard data for all courses and store in Supabase.
 * Run: npx tsx scripts/seed-flashcards.ts
 * Requires: NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, GEMINI_API_KEY in env
 */

import { createClient } from '@supabase/supabase-js'
import { GoogleGenerativeAI } from '@google/generative-ai'

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
)
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY!)

async function generateFlashcards(course: {
  id: string
  title: string
  description: string | null
  skills_gained: string[] | null
  modules: Array<{ title: string; lessons: Array<{ title: string }> }>
}) {
  const moduleList = course.modules.map(m => ({
    title: m.title,
    lessons: m.lessons.map(l => l.title),
  }))

  const prompt = `You are a learning designer for VibeLearn, an online education platform.

Generate a course intro experience for: "${course.title}"

Course description: ${course.description ?? 'N/A'}
Skills to gain: ${(course.skills_gained ?? []).join(', ')}
Modules: ${moduleList.map(m => `${m.title} (${m.lessons.slice(0, 3).join(', ')}${m.lessons.length > 3 ? '...' : ''})`).join(' | ')}

Return a JSON object with EXACTLY this structure:
{
  "titleCard": {
    "headline": "string (punchy 1-line course headline, max 8 words)",
    "subheadline": "string (what learner will be able to DO after this, max 15 words)",
    "emoji": "string (single relevant emoji)"
  },
  "glossary": [
    {
      "term": "string",
      "definition": "string (clear, simple, 1-2 sentences)",
      "example": "string (real-world example, 1 sentence)"
    }
  ],
  "glossaryQuiz": [
    {
      "question": "string",
      "options": ["string", "string", "string", "string"],
      "correctIndex": 0,
      "term": "string (which glossary term this tests)"
    }
  ],
  "courseMap": {
    "overview": "string (2-3 sentence journey description)",
    "steps": ["string"]
  }
}

Rules:
- glossary: exactly 5 terms, core vocabulary the learner MUST know before starting
- glossaryQuiz: exactly 4 questions testing the glossary terms
- courseMap.steps: exactly 4 steps
- Return ONLY the JSON, no markdown, no explanation.`

  const model = genAI.getGenerativeModel({ model: 'gemini-flash-latest' })
  const result = await model.generateContent(prompt)
  const text = result.response.text().trim()
  const cleaned = text.replace(/^```json?\n?/, '').replace(/\n?```$/, '').trim()
  return JSON.parse(cleaned)
}

async function main() {
  const { data: courses, error } = await db
    .from('courses')
    .select('id, title, description, skills_gained, flashcard_data, modules(title, order_index, lessons(title))')
    .eq('is_hidden', false)
    .order('title')

  if (error) { console.error('Failed to fetch courses:', error.message); process.exit(1) }

  console.log(`Found ${courses.length} courses`)

  for (const course of courses) {
    if (course.flashcard_data) {
      console.log(`  SKIP ${course.title} (already cached)`)
      continue
    }

    try {
      console.log(`  GEN  ${course.title}...`)
      const data = await generateFlashcards({
        ...course,
        modules: (course.modules as any[]).sort((a, b) => a.order_index - b.order_index),
      })

      const { error: updateError } = await db
        .from('courses')
        .update({ flashcard_data: data })
        .eq('id', course.id)

      if (updateError) throw new Error(updateError.message)
      console.log(`  OK   ${course.title}`)

      // Rate limit: 1 req/sec to stay under Gemini free tier
      await new Promise(r => setTimeout(r, 1100))
    } catch (err) {
      console.error(`  FAIL ${course.title}:`, err)
    }
  }

  console.log('Done.')
}

main()
