import { supabaseServer } from '@/lib/supabase-server'
import { redirect } from 'next/navigation'
import { SettingsClient } from '@/components/settings/SettingsClient'

export const metadata = { title: 'Settings — VibeLearn' }

export default async function SettingsPage() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect('/?auth=required')

  const { data: profile } = await db
    .from('profiles')
    .select('full_name, topic_snippets_enabled, sound_effects_enabled')
    .eq('id', user.id)
    .single()

  const { data: subscription } = await db
    .from('subscriptions')
    .select('status, current_period_end')
    .eq('user_id', user.id)
    .maybeSingle()

  return (
    <SettingsClient
      profile={profile ?? { full_name: null, topic_snippets_enabled: true, sound_effects_enabled: true }}
      email={user.email ?? ''}
      subscription={subscription ?? null}
    />
  )
}
