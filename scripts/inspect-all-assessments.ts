import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

async function run() {
  const { data: assessments, error: aError } = await supabase
    .from('assessments')
    .select('id, title, slug, is_published, question_count')
  
  if (aError) {
    console.error('Error fetching assessments:', aError)
    return
  }

  const { data: questions, error: qError } = await supabase
    .from('assessment_questions')
    .select('assessment_id')

  if (qError) {
    console.error('Error fetching questions:', qError)
    return
  }

  console.log('=== STANDALONE ASSESSMENTS IN DB ===')
  const countsMap = new Map<string, number>()
  for (const q of questions || []) {
    countsMap.set(q.assessment_id, (countsMap.get(q.assessment_id) || 0) + 1)
  }

  const result = assessments?.map(a => ({
    id: a.id,
    title: a.title,
    slug: a.slug,
    is_published: a.is_published,
    expected_questions: a.question_count,
    actual_questions: countsMap.get(a.id) || 0,
    gap: (a.question_count || 0) - (countsMap.get(a.id) || 0)
  }))

  console.log(JSON.stringify(result, null, 2))
}

run()
