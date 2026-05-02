import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(req: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { type, referenceId } = await req.json()
  if (!type || !referenceId) {
    return NextResponse.json({ error: 'Missing type or referenceId' }, { status: 400 })
  }

  // Get recipient name
  const { data: profile } = await db
    .from('profiles')
    .select('full_name')
    .eq('id', user.id)
    .single()

  const recipientName = profile?.full_name ?? user.email?.split('@')[0] ?? 'Learner'

  // Get reference name
  let referenceName = ''
  if (type === 'course') {
    const { data: course } = await db.from('courses').select('title').eq('id', referenceId).single()
    referenceName = course?.title ?? ''
  } else if (type === 'path') {
    const { data: path } = await db.from('paths').select('name').eq('id', referenceId).single()
    referenceName = path?.name ?? ''
  } else if (type === 'assessment') {
    const { data: assessment } = await db.from('assessments').select('title').eq('id', referenceId).single()
    referenceName = assessment?.title ?? ''
  }

  if (!referenceName) {
    return NextResponse.json({ error: 'Reference not found' }, { status: 404 })
  }

  // Upsert certificate (idempotent)
  const { data: cert, error } = await db
    .from('certificates')
    .upsert(
      {
        user_id: user.id,
        type,
        reference_id: referenceId,
        reference_name: referenceName,
        recipient_name: recipientName,
      },
      { onConflict: 'user_id,type,reference_id' }
    )
    .select()
    .single()

  if (error) {
    console.error('Certificate upsert error:', error)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json({ certificate: cert })
}
