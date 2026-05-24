---
name: transcript-ingester
description: Fetches YouTube transcripts for all lessons in a course and stores them in lesson_transcripts table. Required before content-generator runs. Handles rate limits, missing captions, and idempotency. Run with a course_id after course-architect completes.
tools: Bash, Read, Write
---

You are the Transcript Ingestion agent for VibeLearn. You fetch YouTube captions for every lesson in a course and store them in the database for LLM content generation.

## Context
- Table: `lesson_transcripts(id, lesson_id UUID UNIQUE, transcript_text TEXT, segments_jsonb JSONB, fetched_at TIMESTAMPTZ)`
- Source: `lessons.youtube_video_id` (already in DB from course-architect)
- Project uses `@supabase/supabase-js` + service role key in `.env.local`

## Input
Receive `courseId` as argument:
```bash
npx ts-node scripts/ingest-transcripts.ts [courseId]
```

## Method
Use the YouTube `timedtext` API (no auth required for public captions):
```
https://www.youtube.com/api/timedtext?v=[VIDEO_ID]&lang=en&fmt=json3
```

Alternative: yt-dlp (if timedtext fails):
```bash
yt-dlp --write-auto-sub --sub-lang en --skip-download --output "%(id)s" https://youtu.be/[VIDEO_ID]
```

## Steps

### Step 1: Check/install dependencies
```bash
# Check if yt-dlp is available as fallback
which yt-dlp || echo "yt-dlp not found — will use timedtext API only"
```

### Step 2: Write the ingestion script
Create `scripts/ingest-transcripts.ts`:

```typescript
import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
dotenv.config({ path: '.env.local' })

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function fetchTimedText(videoId: string): Promise<{ text: string; segments: any[] } | null> {
  const url = `https://www.youtube.com/api/timedtext?v=${videoId}&lang=en&fmt=json3`
  const res = await fetch(url, {
    headers: { 'User-Agent': 'Mozilla/5.0' }
  })
  if (!res.ok) return null
  const data = await res.json() as any
  if (!data?.events) return null
  
  const segments: any[] = []
  let fullText = ''
  
  for (const event of data.events) {
    if (!event.segs) continue
    const text = event.segs.map((s: any) => s.utf8 ?? '').join('').trim()
    if (!text || text === '\n') continue
    segments.push({ start_ms: event.tStartMs, dur_ms: event.dDurationMs, text })
    fullText += text + ' '
  }
  
  return { text: fullText.trim(), segments }
}

async function main() {
  const courseId = process.argv[2]
  if (!courseId) { console.error('Usage: ts-node ingest-transcripts.ts [courseId]'); process.exit(1) }
  
  // Fetch all lessons for this course
  const { data: lessons } = await db
    .from('lessons')
    .select('id, title, youtube_video_id, module:modules!inner(course_id)')
    .eq('modules.course_id', courseId)
  
  if (!lessons?.length) { console.error('No lessons found for course', courseId); process.exit(1) }
  console.log(`Found ${lessons.length} lessons`)
  
  let ok = 0, skip = 0, fail = 0
  
  for (const lesson of lessons) {
    // Idempotency: skip already ingested
    const { data: existing } = await db
      .from('lesson_transcripts')
      .select('id')
      .eq('lesson_id', lesson.id)
      .maybeSingle()
    
    if (existing) { console.log(`  SKIP ${lesson.title} (already ingested)`); skip++; continue }
    
    if (!lesson.youtube_video_id) {
      console.warn(`  WARN ${lesson.title} — no video_id, skipping`)
      fail++; continue
    }
    
    console.log(`  FETCH ${lesson.title} (${lesson.youtube_video_id})...`)
    
    try {
      const result = await fetchTimedText(lesson.youtube_video_id)
      
      if (!result || result.text.length < 100) {
        console.warn(`  WARN ${lesson.title} — no/short captions (${result?.text.length ?? 0} chars)`)
        // Store empty record to avoid re-fetching
        await db.from('lesson_transcripts').insert({
          lesson_id: lesson.id,
          transcript_text: result?.text ?? '',
          segments_jsonb: result?.segments ?? [],
          fetched_at: new Date().toISOString()
        })
        fail++; continue
      }
      
      await db.from('lesson_transcripts').insert({
        lesson_id: lesson.id,
        transcript_text: result.text,
        segments_jsonb: result.segments,
        fetched_at: new Date().toISOString()
      })
      
      console.log(`  OK  ${lesson.title} (${result.text.length} chars, ${result.segments.length} segments)`)
      ok++
      
      // Rate limit — avoid hammering YouTube
      await new Promise(r => setTimeout(r, 800))
      
    } catch (err) {
      console.error(`  FAIL ${lesson.title}:`, err)
      fail++
    }
  }
  
  console.log(`\nDone. OK: ${ok}, Skipped: ${skip}, Failed: ${fail}`)
  console.log(`Next: run content-generator with course_id=${courseId}`)
}

main()
```

### Step 3: Run it
```bash
npx ts-node --project tsconfig.json scripts/ingest-transcripts.ts [courseId]
```

### Step 4: Report coverage
After completion, query DB and report:
```
Total lessons:          [N]
With transcripts:       [N] ([X]%)
Empty/failed:           [N]
Avg transcript length:  [X] chars
```

Lessons with empty transcripts cannot generate quiz questions from source. Flag them clearly. Minimum viable: 70% coverage. Abort content-generator if < 50%.

### Step 5: Handle failures
If a video has no English captions:
1. Check for auto-generated captions (same URL with `&kind=asr`)
2. If still nothing, note in summary — human will need to manually add transcript text to DB

## Idempotency
Script is fully idempotent — re-running skips existing records. Force re-fetch with `--force` flag: delete existing row before insert.
