import { NextRequest, NextResponse } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase-server'
import crypto from 'crypto'

function verifySignature(body: string, signature: string, secret: string): boolean {
  try {
    const expectedSig = crypto
      .createHmac('sha256', secret)
      .update(body)
      .digest('hex')
    return crypto.timingSafeEqual(
      Buffer.from(signature),
      Buffer.from(expectedSig)
    )
  } catch {
    return false
  }
}

export async function POST(request: NextRequest) {
  const body = await request.text()
  const signature = request.headers.get('x-polar-signature') ?? ''
  const secret = process.env.POLAR_WEBHOOK_SECRET ?? ''

  if (secret && !verifySignature(body, signature, secret)) {
    return NextResponse.json({ error: 'Invalid signature' }, { status: 401 })
  }

  const event = JSON.parse(body)
  const db = supabaseAdmin()

  const { type, data } = event

  // Extract user email from subscription data
  const email = data?.customer?.email
  const subscriptionId = data?.id
  const customerId = data?.customer?.id
  const periodEnd = data?.current_period_end

  if (!email) {
    return NextResponse.json({ error: 'No email in payload' }, { status: 400 })
  }

  // Look up user by email
  const { data: { users } } = await db.auth.admin.listUsers()
  const user = users.find((u: any) => u.email === email)
  if (!user) {
    // User not yet registered — store anyway for when they sign up
    return NextResponse.json({ ok: true, note: 'User not found' })
  }

  switch (type) {
    case 'subscription.created':
    case 'subscription.updated':
    case 'subscription.active': {
      await db.from('subscriptions').upsert(
        {
          user_id: user.id,
          polar_subscription_id: subscriptionId,
          polar_customer_id: customerId,
          status: 'active',
          current_period_end: periodEnd,
          updated_at: new Date().toISOString(),
        },
        { onConflict: 'polar_subscription_id' }
      )
      break
    }

    case 'subscription.canceled':
    case 'subscription.revoked': {
      await db.from('subscriptions')
        .update({ status: 'cancelled', updated_at: new Date().toISOString() })
        .eq('polar_subscription_id', subscriptionId)
      break
    }
  }

  return NextResponse.json({ ok: true })
}
