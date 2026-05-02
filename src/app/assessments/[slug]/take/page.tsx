import { notFound, redirect } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import AssessmentQuiz from '@/components/assessments/AssessmentQuiz'

interface Props {
  params: Promise<{ slug: string }>
}

export default async function TakeAssessmentPage({ params }: Props) {
  const { slug } = await params
  const db = await supabaseServer()

  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect(`/assessments/${slug}`)

  const { data: assessment } = await db
    .from('assessments')
    .select('id, title, slug, question_count, is_pro')
    .eq('slug', slug)
    .eq('is_published', true)
    .single()

  if (!assessment) notFound()

  if (assessment.is_pro) {
    const { data: sub } = await db
      .from('subscriptions')
      .select('status')
      .eq('user_id', user.id)
      .eq('status', 'active')
      .single()
    if (!sub) redirect(`/assessments/${slug}`)
  }

  // Fetch up to 30 questions with topic field
  const { data: questions } = await db
    .from('assessment_questions')
    .select('id, question, option_a, option_b, option_c, option_d, correct_option, explanation, topic')
    .eq('assessment_id', assessment.id)
    .order('order_index')

  if (!questions || questions.length === 0) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: 'var(--ink)', color: 'var(--muted)', textAlign: 'center', padding: '2rem' }}>
        <div>
          <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🚧</div>
          <h2 style={{ color: 'var(--cream)', marginBottom: '0.5rem' }}>Questions coming soon</h2>
          <p>This assessment is being built. Check back shortly.</p>
        </div>
      </div>
    )
  }

  // Shuffle + take up to 30
  const shuffled = [...questions]
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]]
  }
  const finalQuestions = shuffled.slice(0, 30)

  // Fetch user profile for report
  const { data: userProfile } = await db
    .from('profiles')
    .select('full_name, career_goal')
    .eq('id', user.id)
    .single()

  return (
    <AssessmentQuiz
      assessmentId={assessment.id}
      assessmentTitle={assessment.title}
      assessmentSlug={assessment.slug}
      questions={finalQuestions}
      isLoggedIn={true}
      userProfile={userProfile}
    />
  )
}
