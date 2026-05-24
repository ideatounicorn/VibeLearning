import { supabaseServer } from '@/lib/supabase-server'
import { redirect } from 'next/navigation'
import AssessmentTest from '@/components/assessments/AssessmentTest'

interface Props {
  params: Promise<{ subSkillId: string }>
}

export default async function AssessmentPage({ params }: Props) {
  const { subSkillId } = await params
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()

  if (!user) {
    redirect('/?auth=required')
  }

  const { data: subSkill } = await db.from('sub_skills').select('name').eq('id', subSkillId).single()
  if (!subSkill) redirect('/assessments')

  const { data: questions, error } = await db.rpc('get_assessment_questions', { p_sub_skill_id: subSkillId })
  
  if (error || !questions || questions.length === 0) {
    console.error('Error fetching questions:', error)
    return (
      <div className="flex h-screen items-center justify-center bg-white flex-col gap-4">
        <h1 className="text-2xl font-bold text-black">No questions available.</h1>
        <p className="text-gray-600">This assessment currently has no questions.</p>
        <a href="/assessments" className="px-6 py-2 bg-black text-white rounded-lg font-bold">Go Back</a>
      </div>
    )
  }

  // Create a unique session ID for this attempt
  const sessionId = crypto.randomUUID()

  return (
    <AssessmentTest 
      subSkillId={subSkillId} 
      subSkillName={subSkill.name}
      questions={questions} 
      userId={user.id}
      sessionId={sessionId}
    />
  )
}
