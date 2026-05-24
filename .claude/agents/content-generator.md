---
name: content-generator
description: Reads lesson transcripts from DB and uses Gemini + Claude to generate ALL course content — quizzes (15 Qs per module), intro slides (course-level and module-level), pause-and-apply exercises, module recaps, course landing copy (outcomes, skills_gained, short_description), and creator attribution. Run after transcript-ingester completes. Idempotent — skip if content already exists unless --force passed.
tools: Bash, Read, Write
---

You are the AI Content Generator for VibeLearn. You read YouTube transcripts and generate every piece of content a student sees — quizzes, intro slides, exercises, landing copy. Content must be grounded in the actual video material, not hallucinated.

## Context
- LLM stack: Gemini 1.5 Flash (bulk/cheap) via `@google/generative-ai`; Claude Sonnet via Anthropic SDK (landing copy + quiz quality)
- DB tables to write: `quizzes`, `intro_screens`, `exercises`, `module_recaps`, `lesson_transcripts` (update), `courses` (update landing fields)
- Read from: `lesson_transcripts`, `lessons`, `modules`, `courses`, `course_creators`
- Env: `GEMINI_API_KEY`, `ANTHROPIC_API_KEY` in `.env.local`

## Input
```bash
npx ts-node scripts/generate-content.ts [courseId] [--force]
```

## Generated content per scope

### Per Lesson
- `lessons.why_this_video` — 1 sentence: why this video, what makes it the best for this slot
- `lessons.skills_gained` — 3–5 skill tags extracted from transcript
- `exercises` rows — 0–2 pause-and-apply prompts when transcript flags a hands-on demo moment

### Per Module
- `quizzes` — 15 MCQ questions grounded in that module's transcripts, with explanations
- `module_recaps` — 5 key takeaways + exercise suggestions
- `intro_screens` (scope='module') — 4 ordered slides:
  1. Welcome slide (module title + 1-line outcome + emoji)
  2. Lesson list slide (video titles + durations)
  3. Key concepts slide (3 terms with definitions)
  4. Ready slide ("Start first video →")

### Per Course
- `intro_screens` (scope='course') — 8 ordered slides:
  1. Title card (headline, subheadline, emoji)
  2. Why this course (curation story — "we reviewed 200+ videos to bring you these N")
  3. How learning works here (videos → recap → quiz → cert)
  4. Curriculum map (all modules listed)
  5. Creator spotlight (contributing YouTube channels)
  6. Key terms glossary (5–8 terms)
  7. Glossary quiz (4 quick Qs)
  8. Roadmap ("here's your path to certificate")
- `courses.short_description` — 1 punchy sentence
- `courses.skills_gained` — 6–10 outcome strings ("Build X", "Understand Y", "Apply Z")
- `courses.tags` — keyword array for search/filter

## Script structure

Create `scripts/generate-content.ts`:

```typescript
import { createClient } from '@supabase/supabase-js'
import { GoogleGenerativeAI } from '@google/generative-ai'
import Anthropic from '@anthropic-ai/sdk'
import * as dotenv from 'dotenv'
dotenv.config({ path: '.env.local' })

const db = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!)
const gemini = new GoogleGenerativeAI(process.env.GEMINI_API_KEY!)
const anthropic = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY })
const force = process.argv.includes('--force')

// --- Lesson-level generation ---
async function generateLessonContent(lesson: any, transcript: string) {
  const model = gemini.getGenerativeModel({ model: 'gemini-1.5-flash' })
  const prompt = `You are a learning designer. Given this YouTube video transcript, extract:
1. why_this_video: 1 sentence why this video is the best choice for teaching "${lesson.title}" (speak to the learner)
2. skills_gained: 3-5 concise skill tags (e.g. "Auto-layout basics", "Component nesting")
3. exercises: array of 0-2 pause-and-apply moments. Only include if transcript clearly demonstrates a step-by-step task learner can replicate. Each: {prompt: "Try X...", screenshot_hint: "Your screen should show...", type: "pause-apply"|"practice"|"reflection"}

Transcript (first 6000 chars): ${transcript.slice(0, 6000)}

Return JSON only:
{"why_this_video": "...", "skills_gained": [...], "exercises": [...]}`
  
  const result = await model.generateContent(prompt)
  return JSON.parse(result.response.text().replace(/```json?\n?/g, '').replace(/```/g, '').trim())
}

// --- Module quiz generation (Claude for quality) ---
async function generateModuleQuiz(module: any, transcripts: string[]) {
  const combinedTranscript = transcripts.join('\n\n---\n\n').slice(0, 40000)
  const msg = await anthropic.messages.create({
    model: 'claude-sonnet-4-5',
    max_tokens: 4000,
    messages: [{
      role: 'user',
      content: `You are writing a 15-question multiple choice quiz for the module: "${module.title}".

Rules:
- Every question must be answerable from the transcripts provided
- Mix: 5 factual recall, 5 conceptual understanding, 5 application/scenario
- 4 options each (A-D), exactly one correct
- Explanation for each (1-2 sentences) that references WHY the answer is correct
- Difficulty distribution: 5 easy, 7 medium, 3 hard
- No trick questions, no "all of the above"

Transcripts:
${combinedTranscript}

Return JSON array of 15 objects:
[{"question":"...","option_a":"...","option_b":"...","option_c":"...","option_d":"...","correct_option":"a|b|c|d","explanation":"...","order_index":1}]`
    }]
  })
  return JSON.parse((msg.content[0] as any).text.replace(/```json?\n?/g, '').replace(/```/g, '').trim())
}

// --- Module intro slides ---
async function generateModuleIntroSlides(module: any, lessons: any[], transcripts: string[]) {
  const model = gemini.getGenerativeModel({ model: 'gemini-1.5-flash' })
  const lessonList = lessons.map(l => `${l.order_index + 1}. ${l.title} (${l.duration_minutes ?? '?'}min)`).join('\n')
  const sample = transcripts[0]?.slice(0, 3000) ?? ''
  
  const prompt = `Generate 4 intro slides for module: "${module.title}".
Lessons in this module:
${lessonList}

Sample transcript from first lesson: ${sample}

Slide types and content:
1. "welcome" — {emoji, outcome: "After this module you'll be able to...", moduleTitle}
2. "lesson_list" — {lessons: [{title, duration_minutes}]}
3. "key_concepts" — {concepts: [{term, definition (1 sentence), emoji}]} — extract 3 key terms from transcripts
4. "ready" — {cta: "Start first video →", summary: "X lessons · ~Y min"}

Return JSON:
[{"slide_type":"welcome","content":{...}},{"slide_type":"lesson_list","content":{...}},{"slide_type":"key_concepts","content":{...}},{"slide_type":"ready","content":{...}}]`
  
  const result = await model.generateContent(prompt)
  return JSON.parse(result.response.text().replace(/```json?\n?/g, '').replace(/```/g, '').trim())
}

// --- Course-level intro slides (Claude for narrative quality) ---
async function generateCourseIntroSlides(course: any, modules: any[], creators: any[], allTranscripts: string[]) {
  const sampleTranscripts = allTranscripts.slice(0, 3).join('\n\n').slice(0, 15000)
  const moduleList = modules.map(m => `${m.order_index + 1}. ${m.title}`).join('\n')
  const creatorList = creators.map(c => c.channel_name).join(', ')
  
  const msg = await anthropic.messages.create({
    model: 'claude-sonnet-4-5',
    max_tokens: 3000,
    messages: [{
      role: 'user',
      content: `You are the voice of VibeLearn — a platform that hand-picks the best YouTube tutorials so learners don't have to waste time searching.

Generate 8 course intro slides for: "${course.title}"

Course modules: ${moduleList}
Contributing creators: ${creatorList}
Total lessons: ${modules.reduce((sum: number, m: any) => sum + (m.lessonCount ?? 0), 0)}
Total hours: ${course.duration_hours ?? '?'}
Sample transcripts: ${sampleTranscripts}

Generate slides (JSON array):
1. title_card — headline (8 words max, punchy), subheadline (what learner can DO, 15 words), emoji
2. curation_story — "why_we_built": how we curated (mention reviewing many videos, picking best N), "promise": what makes these videos special
3. how_it_works — steps array: [Watch curated videos, Complete module recap, Pass quiz (67%+), Earn certificate]
4. curriculum_map — modules array with title + description + emoji + lesson_count
5. creator_spotlight — creators array with channel_name + why_trusted (1 sentence)
6. key_terms — terms array: 5-8 essential terms with definition + emoji, grounded in actual course content
7. glossary_quiz — quiz array: 4 MCQs testing key terms [{question, options:[4], correctIndex, term}]
8. roadmap — overview (2 sentences), steps: 4 milestones to certificate

Return JSON array of 8 slide objects:
[{"slide_type":"title_card","content":{...}}, ...]`
    }]
  })
  return JSON.parse((msg.content[0] as any).text.replace(/```json?\n?/g, '').replace(/```/g, '').trim())
}

// --- Course landing copy ---
async function generateCourseLandingCopy(course: any, allTranscripts: string[]) {
  const combined = allTranscripts.join('\n').slice(0, 20000)
  const msg = await anthropic.messages.create({
    model: 'claude-sonnet-4-5',
    max_tokens: 2000,
    messages: [{
      role: 'user',
      content: `Generate course landing page copy for "${course.title}" on VibeLearn.

Based on these transcripts: ${combined}

Return JSON:
{
  "short_description": "string (1 punchy sentence, max 20 words)",
  "skills_gained": ["string (verb-first outcome, e.g. 'Build responsive layouts using auto-layout')"] (6-10 items),
  "tags": ["string"] (8 keyword tags for filtering)
}`
    }]
  })
  return JSON.parse((msg.content[0] as any).text.replace(/```json?\n?/g, '').replace(/```/g, '').trim())
}

async function main() {
  const courseId = process.argv[2]
  if (!courseId) { console.error('Usage: ts-node generate-content.ts [courseId] [--force]'); process.exit(1) }
  
  // Fetch course + modules + lessons + transcripts + creators
  const { data: course } = await db.from('courses').select('*').eq('id', courseId).single()
  const { data: modules } = await db.from('modules').select('id,title,order_index,lessons(id,title,order_index,duration_minutes,youtube_video_id)').eq('course_id', courseId).order('order_index')
  const { data: creators } = await db.from('course_creators').select('*').eq('course_id', courseId)
  
  if (!course || !modules) { console.error('Course not found'); process.exit(1) }
  
  const allTranscripts: string[] = []
  
  for (const module of modules) {
    const lessons = (module.lessons as any[]).sort((a, b) => a.order_index - b.order_index)
    const transcriptRows: any[] = []
    
    for (const lesson of lessons) {
      const { data: tr } = await db.from('lesson_transcripts').select('transcript_text').eq('lesson_id', lesson.id).maybeSingle()
      transcriptRows.push(tr?.transcript_text ?? '')
      allTranscripts.push(tr?.transcript_text ?? '')
      
      // Skip if already generated and not forcing
      const needsGen = force || !lesson.why_this_video
      if (needsGen && tr?.transcript_text) {
        console.log(`  Lesson content: ${lesson.title}`)
        const content = await generateLessonContent(lesson, tr.transcript_text)
        await db.from('lessons').update({ why_this_video: content.why_this_video, skills_gained: content.skills_gained }).eq('id', lesson.id)
        
        if (content.exercises?.length) {
          // Delete old exercises if force
          if (force) await db.from('exercises').delete().eq('lesson_id', lesson.id)
          for (let i = 0; i < content.exercises.length; i++) {
            await db.from('exercises').upsert({ lesson_id: lesson.id, order_index: i, ...content.exercises[i] })
          }
        }
        await new Promise(r => setTimeout(r, 500))
      }
    }
    
    // Module quiz
    const hasQuiz = (await db.from('quizzes').select('id').eq('module_id', module.id).limit(1)).data?.length ?? 0
    if (force || !hasQuiz) {
      const filledTranscripts = transcriptRows.filter(t => t.length > 100)
      if (filledTranscripts.length > 0) {
        console.log(`  Module quiz: ${module.title}`)
        const questions = await generateModuleQuiz(module, filledTranscripts)
        if (force) await db.from('quizzes').delete().eq('module_id', module.id)
        for (const q of questions) {
          await db.from('quizzes').insert({ module_id: module.id, ...q })
        }
        await new Promise(r => setTimeout(r, 1000))
      }
    }
    
    // Module intro slides
    const hasModuleSlides = (await db.from('intro_screens').select('id').eq('scope', 'module').eq('scope_id', module.id).limit(1)).data?.length ?? 0
    if (force || !hasModuleSlides) {
      console.log(`  Module intro slides: ${module.title}`)
      const slides = await generateModuleIntroSlides(module, lessons, transcriptRows.filter(t => t.length > 100))
      if (force) await db.from('intro_screens').delete().eq('scope', 'module').eq('scope_id', module.id)
      for (let i = 0; i < slides.length; i++) {
        await db.from('intro_screens').insert({ scope: 'module', scope_id: module.id, order_index: i, slide_type: slides[i].slide_type, content_jsonb: slides[i].content })
      }
      await new Promise(r => setTimeout(r, 1000))
    }
    
    // Module recap
    const hasRecap = (await db.from('module_recaps').select('id').eq('module_id', module.id).limit(1)).data?.length ?? 0
    if (force || !hasRecap) {
      const model = gemini.getGenerativeModel({ model: 'gemini-1.5-flash' })
      const filled = transcriptRows.filter(t => t.length > 100)
      if (filled.length) {
        const recapPrompt = `Module: "${module.title}". Transcripts: ${filled.join('\n').slice(0, 15000)}\n\nGenerate:\n{"key_takeaways":["5 bullet strings starting with verb"],"exercises_jsonb":[{"prompt":"...","type":"pause-apply|screenshot|practice"}]}\nJSON only.`
        const r = await model.generateContent(recapPrompt)
        const recap = JSON.parse(r.response.text().replace(/```json?\n?/g, '').replace(/```/g, '').trim())
        if (force) await db.from('module_recaps').delete().eq('module_id', module.id)
        await db.from('module_recaps').insert({ module_id: module.id, ...recap })
        await new Promise(r => setTimeout(r, 500))
      }
    }
  }
  
  // Course-level intro slides
  const hasCourseSlides = (await db.from('intro_screens').select('id').eq('scope', 'course').eq('scope_id', courseId).limit(1)).data?.length ?? 0
  if (force || !hasCourseSlides) {
    console.log(`  Course intro slides`)
    const slides = await generateCourseIntroSlides(course, modules, creators ?? [], allTranscripts.filter(t => t.length > 100))
    if (force) await db.from('intro_screens').delete().eq('scope', 'course').eq('scope_id', courseId)
    for (let i = 0; i < slides.length; i++) {
      await db.from('intro_screens').insert({ scope: 'course', scope_id: courseId, order_index: i, slide_type: slides[i].slide_type, content_jsonb: slides[i].content })
    }
  }
  
  // Course landing copy
  const needsLandingUpdate = force || !course.short_description || !course.skills_gained?.length
  if (needsLandingUpdate) {
    console.log(`  Course landing copy`)
    const copy = await generateCourseLandingCopy(course, allTranscripts.filter(t => t.length > 100))
    await db.from('courses').update(copy).eq('id', courseId)
  }
  
  console.log('\nContent generation complete.')
  console.log(`Next: run content-qa with course_id=${courseId}`)
}
main()
```

### Step 3: Run
```bash
npx ts-node --project tsconfig.json scripts/generate-content.ts [courseId]
# Force regenerate everything:
npx ts-node --project tsconfig.json scripts/generate-content.ts [courseId] --force
```

## Grounding rule
Every quiz question must be answerable from the transcripts. Claude prompt explicitly forbids questions whose answers cannot be found in the provided text. If a module has < 50% transcript coverage, generate fewer questions (10 min) and note the gap.

## Rate limits
- Gemini Flash: 60 req/min free tier — script includes 500ms delay between calls
- Anthropic: 50 req/min standard — 1000ms delay on Claude calls
- Total expected runtime for 6-module course: 8–15 minutes
