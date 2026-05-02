import { notFound } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import AssessmentDetail from '@/components/assessments/AssessmentDetail'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateMetadata({ params }: Props) {
  const { slug } = await params
  return {
    title: `${slug.replace(/-/g, ' ')} Assessment — VibeLearn`,
    description: `Benchmark your ${slug.replace(/-/g, ' ')} skills and get personalized learning recommendations.`,
  }
}

export default async function AssessmentPage({ params }: Props) {
  const { slug } = await params
  const db = await supabaseServer()

  const { data: assessment } = await db
    .from('assessments')
    .select('*')
    .eq('slug', slug)
    .eq('is_published', true)
    .single()

  if (!assessment) notFound()

  const { data: popular } = await db
    .from('assessments')
    .select('id, title, slug, description, short_description, category, icon_emoji, icon_bg, duration_minutes, question_count, attempts_count, xp_reward, is_pro, difficulty, tags')
    .eq('is_published', true)
    .neq('slug', slug)
    .order('attempts_count', { ascending: false })
    .limit(3)

  const { data: { user } } = await db.auth.getUser()
  let isLoggedIn = !!user
  let isPro = false
  let bestScore: number | null = null

  if (user) {
    const { data: sub } = await db
      .from('subscriptions')
      .select('status')
      .eq('user_id', user.id)
      .eq('status', 'active')
      .single()
    isPro = !!sub

    const { data: attempts } = await db
      .from('user_assessments')
      .select('score, total')
      .eq('user_id', user.id)
      .eq('assessment_id', assessment.id)
      .order('score', { ascending: false })
      .limit(1)

    if (attempts && attempts.length > 0) {
      bestScore = attempts[0].score / attempts[0].total
    }
  }

  return (
    <AssessmentDetail
      assessment={assessment}
      popular={popular ?? []}
      isLoggedIn={isLoggedIn}
      isPro={isPro}
      bestScore={bestScore}
    />
  )
}
