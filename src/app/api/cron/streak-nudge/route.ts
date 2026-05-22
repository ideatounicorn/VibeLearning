import { NextRequest, NextResponse } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase-server'
import { sendStreakNudge } from '@/lib/email'

export async function GET(request: NextRequest) {
  const authHeader = request.headers.get('authorization')
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const db = supabaseAdmin()

  // Find users who have an active streak (streak_days >= 2) but haven't been
  // active today — meaning their streak is at risk of being reset tonight.
  const today = new Date().toISOString().split('T')[0] // YYYY-MM-DD

  const { data: atRiskUsers, error } = await db
    .from('profiles')
    .select('id, full_name, streak_days, last_activity_date')
    .gte('streak_days', 2)
    .lt('last_activity_date', today)

  if (error) {
    console.error('Streak nudge cron failed to fetch users:', error)
    return NextResponse.json({ error: 'Failed to fetch users' }, { status: 500 })
  }

  if (!atRiskUsers || atRiskUsers.length === 0) {
    return NextResponse.json({ ok: true, nudgedCount: 0 })
  }

  // Look up emails for these users via auth.users (requires service role)
  let nudgedCount = 0
  for (const profile of atRiskUsers) {
    try {
      const { data: authUser } = await db.auth.admin.getUserById(profile.id)
      if (authUser?.user?.email) {
        await sendStreakNudge(authUser.user.email, profile.streak_days)
        nudgedCount++
      }
    } catch (err) {
      console.error(`Failed to nudge user ${profile.id}:`, err)
    }
  }

  return NextResponse.json({ ok: true, nudgedCount })
}
