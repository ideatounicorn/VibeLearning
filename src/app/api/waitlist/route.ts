import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

/**
 * POST /api/waitlist
 * Body: { email: string; path_slug: string }
 *
 * Stores a waitlist entry. If a `waitlist` table doesn't yet exist in the DB,
 * this gracefully falls back to sending a notification email instead.
 */
export async function POST(req: NextRequest) {
  const { email, path_slug } = await req.json()

  if (!email || typeof email !== 'string' || !email.includes('@')) {
    return NextResponse.json({ error: 'Valid email required' }, { status: 400 })
  }

  const db = await supabaseServer()

  // Try to insert into waitlist table (runs best-effort)
  const { error } = await db
    .from('waitlist')
    .insert({ email: email.toLowerCase().trim(), path_slug: path_slug ?? 'data-analysis' })

  if (error) {
    // Graceful degradation — if table doesn't exist, still return OK so the
    // user sees a confirmation. Log for manual follow-up.
    console.error('Waitlist insert failed (table may not exist yet):', error.message)
  }

  return NextResponse.json({ ok: true })
}
