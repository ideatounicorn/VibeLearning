import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(req: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()

  const { assessmentId, answers, questions, timeTaken } = await req.json()
  // answers: Array<{ questionId: string, selected: number|null, correct: number, topic: string, isCorrect: boolean }>

  // Topic breakdown
  const topicMap: Record<string, { correct: number; total: number }> = {}
  for (const a of answers) {
    if (!topicMap[a.topic]) topicMap[a.topic] = { correct: 0, total: 0 }
    topicMap[a.topic].total++
    if (a.isCorrect) topicMap[a.topic].correct++
  }

  const totalCorrect = answers.filter((a: any) => a.isCorrect).length
  const totalQ = answers.length
  const pct = Math.round((totalCorrect / totalQ) * 100)

  // Determine strengths / weaknesses
  const topics = Object.entries(topicMap).map(([topic, s]) => ({
    topic,
    correct: s.correct,
    total: s.total,
    pct: Math.round((s.correct / s.total) * 100),
  })).sort((a, b) => b.pct - a.pct)

  const strengths = topics.filter(t => t.pct >= 70)
  const weaknesses = topics.filter(t => t.pct < 60)

  // Simple percentile based on score
  const percentile = Math.min(99, Math.round(pct * 0.95 + Math.random() * 4))

  // XP
  const xp = totalCorrect * 30 + (pct >= 80 ? 200 : pct >= 60 ? 100 : 50)

  // Save submission if logged in
  if (user) {
    const { data: profile } = await db.from('profiles').select('xp_total').eq('id', user.id).single()
    await db.from('user_assessments').upsert(
      { user_id: user.id, assessment_id: assessmentId, score: totalCorrect, total: totalQ, xp_awarded: xp },
      { onConflict: 'user_id,assessment_id' }
    )
    await db.from('profiles').update({ xp_total: (profile?.xp_total ?? 0) + xp }).eq('id', user.id)

    // Issue assessment certificate if passed (>=70%)
    if (pct >= 70) {
      const { data: assessment } = await db.from('assessments').select('title').eq('id', assessmentId).single()
      const { data: p } = await db.from('profiles').select('full_name').eq('id', user.id).single()
      await db.from('certificates').upsert(
        {
          user_id: user.id,
          type: 'assessment',
          reference_id: assessmentId,
          reference_name: assessment?.title ?? 'Assessment',
          recipient_name: p?.full_name ?? user.email?.split('@')[0] ?? 'Learner',
        },
        { onConflict: 'user_id,type,reference_id' }
      )
    }
  }

  return NextResponse.json({
    totalCorrect,
    totalQ,
    pct,
    xp,
    percentile,
    topics,
    strengths,
    weaknesses,
    timeTaken,
  })
}
