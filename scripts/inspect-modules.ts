import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function run() {
  const { data: courses } = await supabase.from('courses').select('id, title, slug')
  const { data: modules } = await supabase.from('modules').select('id, course_id, title, order_index')
  const { data: lessons } = await supabase.from('lessons').select('id, module_id, title')

  console.log('=== COURSES WITH MODULES & LESSONS ===')
  
  const courseMap = new Map(courses?.map(c => [c.id, c]))
  const moduleMap = new Map(modules?.map(m => [m.id, m]))

  // Group modules by course
  const modulesByCourse = new Map<string, Array<NonNullable<typeof modules>[number]>>()
  for (const m of modules || []) {
    const list = modulesByCourse.get(m.course_id) || []
    list.push(m)
    modulesByCourse.set(m.course_id, list)
  }

  // Group lessons by module
  const lessonsByModule = new Map<string, Array<NonNullable<typeof lessons>[number]>>()
  for (const l of lessons || []) {
    const list = lessonsByModule.get(l.module_id) || []
    list.push(l)
    lessonsByModule.set(l.module_id, list)
  }

  for (const [courseId, mods] of modulesByCourse.entries()) {
    const course = courseMap.get(courseId)
    console.log(`\nCourse: ${course?.title} (Slug: ${course?.slug})`)
    console.log(`  Modules count: ${mods.length}`)
    
    // Sort modules by order_index
    mods.sort((a, b) => (a.order_index || 0) - (b.order_index || 0))
    for (const m of mods) {
      const lesCount = lessonsByModule.get(m.id)?.length || 0
      console.log(`    - Module: "${m.title}" (order: ${m.order_index}) -> ${lesCount} lessons`)
    }
  }
}

run()
