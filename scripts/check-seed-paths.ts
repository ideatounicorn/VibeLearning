import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

const SEED_PATH_IDS = [
  '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c', // AI Product Building
  '1d4aeeee-79cc-4887-9e02-01a6999ceaa1', // UX Design
  '3275b00a-58d7-4a4b-8472-a851a9231497', // Product Management
  '251e65a0-3e44-4a0e-b18a-78fe5d7a1366', // Digital Marketing
  'f4f7844a-e0a8-47a4-bdef-83b51c933b39', // Data Analysis
]

async function run() {
  const { data: paths, error } = await supabase
    .from('paths')
    .select('id, name, slug')
    .in('id', SEED_PATH_IDS)

  if (error) {
    console.error('Error fetching paths:', error)
    return
  }

  console.log('=== SEED PATHS IN DATABASE ===')
  console.log(paths)
}

run()
