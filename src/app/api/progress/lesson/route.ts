import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(request: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { lessonId } = await request.json()

  await db.from('lesson_progress').upsert(
    { user_id: user.id, lesson_id: lessonId, started_at: new Date().toISOString() },
    { onConflict: 'user_id,lesson_id', ignoreDuplicates: true }
  )

  return NextResponse.json({ ok: true })
}

export async function PATCH(request: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { lessonId } = await request.json()
  const now = new Date().toISOString()

  // Mark lesson complete
  await db.from('lesson_progress').upsert(
    { user_id: user.id, lesson_id: lessonId, completed_at: now },
    { onConflict: 'user_id,lesson_id' }
  )

  // Award XP (fallback since RPC doesn't exist)
  const { data: profile } = await db.from('profiles').select('xp_total').eq('id', user.id).single()
  const currentXp = profile?.xp_total || 0
  
  // Update streak & XP
  await db
    .from('profiles')
    .update({ 
      last_activity_date: new Date().toDateString(),
      xp_total: currentXp + 10
    })
    .eq('id', user.id)

  return NextResponse.json({ ok: true, xp: 10 })
}
