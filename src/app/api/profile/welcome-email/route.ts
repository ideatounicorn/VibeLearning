import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'
import { sendWelcomeEmail } from '@/lib/email'

export async function POST(_req: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()

  if (!user || !user.email) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  // Fetch the user's display name from their profile
  const { data: profile } = await db
    .from('profiles')
    .select('full_name')
    .eq('id', user.id)
    .maybeSingle()

  const name = profile?.full_name || user.user_metadata?.full_name || ''

  await sendWelcomeEmail(user.email, name)

  return NextResponse.json({ ok: true })
}
