import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function run() {
  const courseSlug = 'master-claude-ai-zero-to-pro'
  
  // Fetch course
  const { data: course } = await supabase
    .from('courses')
    .select('id, title')
    .eq('slug', courseSlug)
    .single()
    
  if (!course) {
    console.error('Course not found')
    return
  }
  
  // Fetch modules
  const { data: modules } = await supabase
    .from('modules')
    .select('id, title, order_index')
    .eq('course_id', course.id)
    .order('order_index', { ascending: true })
    
  if (!modules) {
    console.error('Modules not found')
    return
  }
  
  // Fetch lessons
  const moduleIds = modules.map(m => m.id)
  const { data: lessons } = await supabase
    .from('lessons')
    .select('id, module_id, title, youtube_url, order_index')
    .in('module_id', moduleIds)
    .order('order_index', { ascending: true })
    
  if (!lessons) {
    console.error('Lessons not found')
    return
  }
  
  // Group lessons by module_id
  const lessonMap = new Map<string, typeof lessons>()
  for (const l of lessons) {
    const list = lessonMap.get(l.module_id) || []
    list.push(l)
    lessonMap.set(l.module_id, list)
  }
  
  console.log(`=== LESSONS FOR ${course.title} ===`)
  for (const mod of modules) {
    console.log(`\nModule ${mod.order_index}: ${mod.title}`)
    const modLessons = lessonMap.get(mod.id) || []
    for (const les of modLessons) {
      console.log(`  - Lesson ${les.order_index}: ${les.title} (${les.youtube_url})`)
    }
  }
}

run().catch(console.error)
