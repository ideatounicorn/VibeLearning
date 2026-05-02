import { NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function GET() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'
  
  if (!user) {
    return NextResponse.redirect(new URL('/?auth=required', siteUrl))
  }

  const productId = process.env.NEXT_PUBLIC_POLAR_PRODUCT_ID
  const token = process.env.POLAR_ACCESS_TOKEN

  if (!productId || !token) {
    return NextResponse.redirect(new URL('/upgrade?error=missing_config', siteUrl))
  }

  try {
    const res = await fetch('https://api.polar.sh/v1/checkouts', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      },
      body: JSON.stringify({
        product_id: productId,
        customer_email: user.email,
        success_url: `${siteUrl}/dashboard?upgrade=success`,
      })
    })
    
    const data = await res.json()
    if (data.url) {
      return NextResponse.redirect(data.url)
    }
    
    return NextResponse.redirect(new URL('/upgrade?error=creation_failed', siteUrl))
  } catch (err) {
    return NextResponse.redirect(new URL('/upgrade?error=server_error', siteUrl))
  }
}
