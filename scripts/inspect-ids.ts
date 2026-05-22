import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)

async function run() {
  const { data: paths } = await supabase.from('paths').select('id, name, slug')
  console.log('--- PATHS IN DB ---')
  console.table(paths)

  const { data: courses } = await supabase.from('courses').select('id, path_id, title, slug')
  console.log('\n--- COURSES IN DB ---')
  console.table(courses?.map(c => ({
    id: c.id,
    path_id: c.path_id,
    title: c.title,
    path_slug: paths?.find(p => p.id === c.path_id)?.slug || 'UNKNOWN'
  })))
}

run()
