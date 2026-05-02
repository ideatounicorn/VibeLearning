'use client'

import { useState } from 'react'
import Link from 'next/link'

interface Profile {
  full_name: string | null
  topic_snippets_enabled: boolean | null
  sound_effects_enabled: boolean | null
}

interface Subscription {
  status: string
  current_period_end: string | null
}

interface SettingsClientProps {
  profile: Profile
  email: string
  subscription: Subscription | null
}

type Tab = 'account' | 'subscription' | 'notifications'

function Toggle({ checked, onChange }: { checked: boolean; onChange: (v: boolean) => void }) {
  return (
    <button
      role="switch"
      aria-checked={checked}
      onClick={() => onChange(!checked)}
      style={{
        width: 40,
        height: 22,
        borderRadius: 999,
        background: checked ? 'var(--accent)' : 'var(--border)',
        border: 'none',
        cursor: 'pointer',
        position: 'relative',
        transition: 'background 0.2s',
        flexShrink: 0,
      }}
    >
      <span
        style={{
          position: 'absolute',
          top: 2,
          left: checked ? 20 : 2,
          width: 18,
          height: 18,
          borderRadius: '50%',
          background: '#fff',
          transition: 'left 0.2s',
          boxShadow: '0 1px 3px rgba(0,0,0,0.2)',
        }}
      />
    </button>
  )
}

export function SettingsClient({ profile, email, subscription }: SettingsClientProps) {
  const [tab, setTab] = useState<Tab>('account')
  const [form, setForm] = useState({
    full_name: profile.full_name ?? '',
    topic_snippets_enabled: profile.topic_snippets_enabled ?? true,
    sound_effects_enabled: profile.sound_effects_enabled ?? true,
  })
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [deleteConfirm, setDeleteConfirm] = useState(false)

  const isPro = subscription?.status === 'active'

  const handleSave = async () => {
    setSaving(true)
    try {
      const res = await fetch('/api/settings/update', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          full_name: form.full_name,
          topic_snippets_enabled: form.topic_snippets_enabled,
          sound_effects_enabled: form.sound_effects_enabled,
        }),
      })
      if (res.ok) {
        setSaved(true)
        setTimeout(() => setSaved(false), 3000)
      }
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async () => {
    await fetch('/api/settings/delete-account', { method: 'DELETE' })
    window.location.href = '/'
  }

  const TABS: { id: Tab; label: string }[] = [
    { id: 'account', label: 'Account' },
    { id: 'subscription', label: 'Subscription' },
    { id: 'notifications', label: 'Notifications' },
  ]

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg)', padding: '2rem 1.5rem' }}>
      <div style={{ maxWidth: 680, margin: '0 auto' }}>

        <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--text-primary)', marginBottom: '2rem' }}>
          Settings
        </h1>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: '0.25rem', borderBottom: '1px solid var(--border)', marginBottom: '2rem' }}>
          {TABS.map(t => (
            <button
              key={t.id}
              onClick={() => setTab(t.id)}
              style={{
                background: 'none',
                border: 'none',
                cursor: 'pointer',
                padding: '0.65rem 1rem',
                fontSize: '0.9rem',
                fontWeight: tab === t.id ? 600 : 400,
                color: tab === t.id ? 'var(--text-primary)' : 'var(--text-muted)',
                borderBottom: tab === t.id ? '2px solid var(--accent)' : '2px solid transparent',
                marginBottom: -1,
              }}
            >
              {t.label}
            </button>
          ))}
        </div>

        {/* Account tab */}
        {tab === 'account' && (
          <div>
            {saved && (
              <div style={{ padding: '0.6rem 1rem', background: 'color-mix(in srgb, var(--success) 12%, transparent)', border: '1px solid color-mix(in srgb, var(--success) 25%, transparent)', borderRadius: 8, color: 'var(--success)', fontSize: '0.85rem', marginBottom: '1.5rem' }}>
                Settings saved ✓
              </div>
            )}

            <section style={{ marginBottom: '2rem' }}>
              <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '1rem' }}>General</h2>

              <div style={{ marginBottom: '1rem' }}>
                <label style={{ display: 'block', fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '0.35rem' }}>Display name</label>
                <input
                  value={form.full_name}
                  onChange={e => setForm(f => ({ ...f, full_name: e.target.value }))}
                  style={{ width: '100%', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.55rem 0.75rem', color: 'var(--text-primary)', fontSize: '0.9rem' }}
                />
              </div>

              <div style={{ marginBottom: '1.5rem' }}>
                <label style={{ display: 'block', fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '0.35rem' }}>Email</label>
                <input
                  value={email}
                  disabled
                  style={{ width: '100%', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.55rem 0.75rem', color: 'var(--text-muted)', fontSize: '0.9rem', cursor: 'not-allowed' }}
                />
                <p style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginTop: '0.3rem' }}>
                  To change email, <a href="mailto:support@vibelearn.co" style={{ color: 'var(--accent)' }}>contact support</a>.
                </p>
              </div>

              <button onClick={handleSave} disabled={saving} className="btn-primary" style={{ fontSize: '0.9rem' }}>
                {saving ? 'Saving…' : 'Save changes'}
              </button>
            </section>

            <section style={{ marginBottom: '2rem' }}>
              <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '1rem' }}>Learning Settings</h2>

              {[
                { key: 'topic_snippets_enabled' as const, label: 'Topic snippets', desc: 'Show context snippets before each lesson' },
                { key: 'sound_effects_enabled' as const, label: 'Sound effects', desc: 'Play sounds on quiz results' },
              ].map(({ key, label, desc }) => (
                <div key={key} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '0.85rem 0', borderBottom: '1px solid var(--border)' }}>
                  <div>
                    <div style={{ fontSize: '0.9rem', color: 'var(--text-primary)', fontWeight: 500 }}>{label}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>{desc}</div>
                  </div>
                  <Toggle
                    checked={form[key]}
                    onChange={async v => {
                      setForm(f => ({ ...f, [key]: v }))
                      await fetch('/api/settings/update', {
                        method: 'PATCH',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ [key]: v }),
                      })
                    }}
                  />
                </div>
              ))}
            </section>

            <section style={{ borderTop: '1px solid var(--border)', paddingTop: '2rem' }}>
              <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--danger)', marginBottom: '0.5rem' }}>Danger Zone</h2>
              <p style={{ color: 'var(--text-muted)', fontSize: '0.88rem', marginBottom: '1rem' }}>
                Permanently delete your account and all data. This cannot be undone.
              </p>
              {!deleteConfirm ? (
                <button
                  onClick={() => setDeleteConfirm(true)}
                  className="btn-outline"
                  style={{ color: 'var(--danger)', borderColor: 'var(--danger)', fontSize: '0.88rem' }}
                >
                  Delete account
                </button>
              ) : (
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                  <span style={{ fontSize: '0.88rem', color: 'var(--text-muted)' }}>Are you sure?</span>
                  <button onClick={handleDelete} style={{ background: 'var(--danger)', color: '#fff', border: 'none', borderRadius: 8, padding: '0.5rem 1rem', cursor: 'pointer', fontSize: '0.88rem', fontWeight: 600 }}>
                    Yes, delete
                  </button>
                  <button onClick={() => setDeleteConfirm(false)} className="btn-outline" style={{ fontSize: '0.88rem' }}>
                    Cancel
                  </button>
                </div>
              )}
            </section>
          </div>
        )}

        {/* Subscription tab */}
        {tab === 'subscription' && (
          <div>
            <div style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 16, padding: '2rem', marginBottom: '1.5rem' }}>
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1rem' }}>
                <div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.25rem' }}>
                    Current Plan
                  </div>
                  <div style={{ fontSize: '1.5rem', fontWeight: 700, color: isPro ? 'var(--accent)' : 'var(--text-primary)' }}>
                    {isPro ? 'Pro ✦' : 'Free'}
                  </div>
                </div>
                {isPro && subscription?.current_period_end && (
                  <div style={{ textAlign: 'right', fontSize: '0.85rem', color: 'var(--text-muted)' }}>
                    Renews<br />
                    {new Date(subscription.current_period_end).toLocaleDateString()}
                  </div>
                )}
              </div>

              {isPro ? (
                <a
                  href={process.env.NEXT_PUBLIC_POLAR_PORTAL_URL ?? '#'}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="btn-outline"
                  style={{ fontSize: '0.88rem' }}
                >
                  Manage subscription ↗
                </a>
              ) : (
                <Link href="/upgrade" className="btn-primary" style={{ fontSize: '0.88rem' }}>
                  Upgrade to Pro →
                </Link>
              )}
            </div>
          </div>
        )}

        {/* Notifications tab */}
        {tab === 'notifications' && (
          <div>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>
              Notification preferences (email delivery coming soon).
            </p>
            {[
              { label: 'Email notifications', desc: 'Weekly learning progress digest' },
              { label: 'Streak reminders', desc: 'Alert when streak is at risk' },
            ].map(({ label, desc }) => (
              <div key={label} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '0.85rem 0', borderBottom: '1px solid var(--border)', opacity: 0.5 }}>
                <div>
                  <div style={{ fontSize: '0.9rem', color: 'var(--text-primary)', fontWeight: 500 }}>{label}</div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>{desc}</div>
                </div>
                <Toggle checked={false} onChange={() => {}} />
              </div>
            ))}
            <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '1rem' }}>
              These toggles will be active when email delivery is wired up.
            </p>
          </div>
        )}
      </div>
    </div>
  )
}
