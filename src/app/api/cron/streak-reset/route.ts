import { NextRequest, NextResponse } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase-server'

export async function GET(request: NextRequest) {
  const authHeader = request.headers.get('authorization')
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const db = supabaseAdmin()

  // Find all users who haven't had activity since yesterday
  // We'll approximate this by checking last_activity_date
  const yesterday = new Date()
  yesterday.setDate(yesterday.getDate() - 1)
  const yesterdayStr = yesterday.toDateString()

  // Reset streaks for users whose last activity was before yesterday
  const { data: expiredStreaks, error } = await db
    .from('profiles')
    .update({ streak_days: 0 })
    .lt('last_activity_date', yesterdayStr)
    .gt('streak_days', 0)
    .select('id')

  if (error) {
    console.error('Failed to reset streaks:', error)
    return NextResponse.json({ error: 'Failed to reset streaks' }, { status: 500 })
  }

  return NextResponse.json({ ok: true, resetCount: expiredStreaks?.length ?? 0 })
}
