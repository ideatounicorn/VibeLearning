import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(req: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { assessmentId, score, total } = await req.json()
  if (!assessmentId || score == null || !total) {
    return NextResponse.json({ error: 'Missing fields' }, { status: 400 })
  }

  const pct = score / total
  const baseXP = score * 30
  const bonusXP = pct >= 0.8 ? 150 : 0
  const xp = baseXP + bonusXP

  await db.from('user_assessments').insert({
    user_id: user.id,
    assessment_id: assessmentId,
    score,
    total,
    xp_awarded: xp,
  })

  // Increment XP on profile
  const { data: profile } = await db
    .from('profiles')
    .select('xp_total')
    .eq('id', user.id)
    .single()

  if (profile) {
    await db
      .from('profiles')
      .update({ xp_total: (profile.xp_total ?? 0) + xp })
      .eq('id', user.id)
  }

  return NextResponse.json({ xp, passed: pct >= 0.8, score, total })
}
