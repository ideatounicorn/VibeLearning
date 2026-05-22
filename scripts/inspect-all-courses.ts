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
    .select(`
      id,
      title,
      slug,
      path_id,
      paths (
        id,
        name,
        slug
      )
    `)
  
  if (error) {
    console.error('Error fetching courses:', error)
    return
  }

  console.log('=== ALL COURSES IN DB ===')
  console.log(JSON.stringify(courses, null, 2))
}

run()
