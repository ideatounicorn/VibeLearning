import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function run() {
  const { data: courses, error } = await supabase
    .from('courses')
    .select('id, title, slug, flashcard_data')
    .eq('slug', 'master-claude-ai-zero-to-pro')
    .single()
  
  if (error) {
    console.error('Error fetching course:', error)
    return
  }

  console.log(`\n=== COURSE: ${courses.title} ===`)
  
  const { data: modules, error: modErr } = await supabase
    .from('modules')
    .select('id, title, order_index, lessons(title, order_index)')
    .eq('course_id', courses.id)
    .order('order_index')

  if (modErr) {
    console.error('Error fetching modules:', modErr)
    return
  }

  for (const m of modules || []) {
    console.log(`\nModule: ${m.title} (Order: ${m.order_index})`)
    const sortedLessons = ((m.lessons as any[]) || []).sort((a, b) => a.order_index - b.order_index)
    for (const l of sortedLessons) {
      console.log(`  - Lesson: ${l.title}`)
    }
  }
}

run()
