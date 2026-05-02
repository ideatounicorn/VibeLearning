import { supabaseServer } from '@/lib/supabase-server'
import Link from 'next/link'

export const metadata = { title: 'Upgrade to Pro — VibeLearn' }

const FEATURES = [
  { category: 'LEARN', rows: [
    { label: 'Structured career paths', free: true, pro: true },
    { label: 'First 2 modules per path', free: true, pro: false },
    { label: 'Unlimited course library', free: false, pro: true },
    { label: 'YouTube lesson player', free: true, pro: true },
    { label: 'Progress tracking', free: true, pro: true },
  ]},
  { category: 'PRACTICE', rows: [
    { label: 'Module quizzes', free: 'First 2', pro: 'Unlimited' },
    { label: 'XP & streak gamification', free: true, pro: true },
    { label: 'Skill assessments', free: '1/week', pro: '2/week' },
  ]},
  { category: 'GROW', rows: [
    { label: 'Public profile', free: true, pro: true },
    { label: 'Course certificates', free: false, pro: true },
    { label: 'Skill graph & benchmarks', free: false, pro: true },
    { label: 'Bookmarks', free: true, pro: true },
    { label: 'League leaderboard', free: false, pro: true },
  ]},
]

const FAQ = [
  { q: 'Who is Pro membership for?', a: 'Anyone serious about landing a tech job or leveling up their product/design/AI skills. Pro removes all paywalls and unlocks the full learning experience.' },
  { q: 'Can I cancel my subscription?', a: 'Yes, anytime. Your access continues until the end of your billing period with no penalty.' },
  { q: 'What happens to my progress if I cancel?', a: 'Your progress, XP, and profile are saved forever. You\'ll just lose access to Pro-only content and features.' },
  { q: 'Do you offer refunds?', a: 'We offer a 7-day money-back guarantee. Contact us at support@vibelearn.co if you\'re not satisfied.' },
]

function Check({ value }: { value: boolean | string }) {
  if (value === true) return <span style={{ color: 'var(--success)', fontWeight: 700 }}>✓</span>
  if (value === false) return <span style={{ color: 'var(--text-muted)' }}>—</span>
  return <span style={{ color: 'var(--text-primary)', fontSize: '0.85rem' }}>{value}</span>
}

export default async function UpgradePage() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()

  let isPro = false
  if (user) {
    const { data: sub } = await db.from('subscriptions').select('status').eq('user_id', user.id).eq('status', 'active').maybeSingle()
    isPro = !!sub
  }

  const checkoutUrl = '/api/polar/checkout'

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg)', padding: '2rem 1.5rem' }}>
      <div style={{ maxWidth: 900, margin: '0 auto' }}>

        {/* Hero */}
        <div style={{ textAlign: 'center', marginBottom: '3rem' }}>
          <div style={{ display: 'inline-block', background: 'color-mix(in srgb, var(--accent) 12%, transparent)', color: 'var(--accent)', fontSize: '0.8rem', fontWeight: 600, padding: '0.35rem 0.85rem', borderRadius: 999, marginBottom: '1rem', textTransform: 'uppercase', letterSpacing: '0.06em' }}>
            Pricing Plans
          </div>
          <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: '2.5rem', color: 'var(--text-primary)', marginBottom: '0.5rem' }}>
            Invest in your career
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '1.05rem' }}>
            Pay once per month, grow always.
          </p>
        </div>

        {/* Plan cards */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginBottom: '3rem' }}>
          {/* Free */}
          <div style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 20, padding: '2rem' }}>
            <div style={{ fontSize: '0.8rem', fontWeight: 600, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.5rem' }}>Free</div>
            <div style={{ fontSize: '2.5rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>₹0</div>
            <div style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>No credit card needed</div>
            {isPro ? (
              <div style={{ padding: '0.6rem', borderRadius: 10, background: 'var(--border)', textAlign: 'center', color: 'var(--text-muted)', fontSize: '0.9rem' }}>Current plan</div>
            ) : (
              <Link href="/dashboard" style={{ display: 'block', padding: '0.65rem', borderRadius: 10, border: '1.5px solid var(--border)', textAlign: 'center', color: 'var(--text-primary)', textDecoration: 'none', fontWeight: 600, fontSize: '0.9rem' }}>
                Get started free
              </Link>
            )}
            <ul style={{ listStyle: 'none', padding: 0, margin: '1.5rem 0 0', display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
              {['First 2 modules per path', 'Module quizzes (first 2)', 'XP & streak system', 'Public profile', 'Bookmarks'].map(f => (
                <li key={f} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.88rem', color: 'var(--text-primary)' }}>
                  <span style={{ color: 'var(--success)' }}>✓</span> {f}
                </li>
              ))}
            </ul>
          </div>

          {/* Pro */}
          <div style={{ background: 'var(--surface)', border: '2px solid var(--accent)', borderRadius: 20, padding: '2rem', position: 'relative' }}>
            <div style={{ position: 'absolute', top: -12, right: 20, background: 'var(--accent)', color: 'var(--bg)', fontSize: '0.75rem', fontWeight: 700, padding: '0.25rem 0.75rem', borderRadius: 999 }}>
              MOST VALUE
            </div>
            <div style={{ fontSize: '0.8rem', fontWeight: 600, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.5rem' }}>Pro</div>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: '0.4rem', marginBottom: '0.25rem' }}>
              <span style={{ fontSize: '2.5rem', fontWeight: 700, color: 'var(--text-primary)' }}>₹330</span>
              <span style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>/month</span>
            </div>
            <div style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>Cancel anytime</div>
            {isPro ? (
              <div style={{ padding: '0.6rem', borderRadius: 10, background: 'color-mix(in srgb, var(--accent) 15%, transparent)', textAlign: 'center', color: 'var(--accent)', fontSize: '0.9rem', fontWeight: 600 }}>Active plan ✓</div>
            ) : (
              <a
                href={checkoutUrl}
                style={{ display: 'block', padding: '0.65rem', borderRadius: 10, background: 'var(--accent)', textAlign: 'center', color: 'var(--bg)', textDecoration: 'none', fontWeight: 700, fontSize: '0.9rem' }}
              >
                Upgrade Now →
              </a>
            )}
            <ul style={{ listStyle: 'none', padding: 0, margin: '1.5rem 0 0', display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
              {['Unlimited course library', 'Unlimited module quizzes', 'Skill assessments (2×/week)', 'Course certificates', 'Skill graph & benchmarks', 'League leaderboard', 'Priority support'].map(f => (
                <li key={f} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.88rem', color: 'var(--text-primary)' }}>
                  <span style={{ color: 'var(--accent)' }}>✓</span> {f}
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Feature table */}
        <div style={{ marginBottom: '3rem' }}>
          <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '1.5rem', textAlign: 'center' }}>
            Full comparison
          </h2>
          <div style={{ border: '1px solid var(--border)', borderRadius: 16, overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ background: 'var(--surface)' }}>
                  <th style={{ padding: '0.85rem 1.25rem', textAlign: 'left', fontSize: '0.85rem', fontWeight: 600, color: 'var(--text-muted)', borderBottom: '1px solid var(--border)' }}>Feature</th>
                  <th style={{ padding: '0.85rem 1.25rem', textAlign: 'center', fontSize: '0.85rem', fontWeight: 600, color: 'var(--text-muted)', borderBottom: '1px solid var(--border)' }}>Free</th>
                  <th style={{ padding: '0.85rem 1.25rem', textAlign: 'center', fontSize: '0.85rem', fontWeight: 600, color: 'var(--accent)', borderBottom: '1px solid var(--border)' }}>Pro</th>
                </tr>
              </thead>
              <tbody>
                {FEATURES.map(section => (
                  <>
                    <tr key={section.category} style={{ background: 'color-mix(in srgb, var(--accent) 4%, var(--surface))' }}>
                      <td colSpan={3} style={{ padding: '0.5rem 1.25rem', fontSize: '0.72rem', fontWeight: 700, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.08em', borderBottom: '1px solid var(--border)' }}>
                        {section.category}
                      </td>
                    </tr>
                    {section.rows.map((row, i) => (
                      <tr key={row.label} style={{ borderBottom: i < section.rows.length - 1 ? '1px solid var(--border)' : 'none' }}>
                        <td style={{ padding: '0.75rem 1.25rem', fontSize: '0.88rem', color: 'var(--text-primary)' }}>{row.label}</td>
                        <td style={{ padding: '0.75rem 1.25rem', textAlign: 'center' }}><Check value={row.free} /></td>
                        <td style={{ padding: '0.75rem 1.25rem', textAlign: 'center' }}><Check value={row.pro} /></td>
                      </tr>
                    ))}
                  </>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Social proof */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '1rem', marginBottom: '3rem' }}>
          {[
            { stat: '500k+', label: 'Active learners' },
            { stat: '4.7/5', label: 'Average rating' },
            { stat: '68%', label: 'Report career impact' },
          ].map(item => (
            <div key={item.stat} style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 14, padding: '1.5rem', textAlign: 'center' }}>
              <div style={{ fontSize: '2rem', fontWeight: 700, color: 'var(--accent)', marginBottom: '0.25rem' }}>{item.stat}</div>
              <div style={{ color: 'var(--text-muted)', fontSize: '0.88rem' }}>{item.label}</div>
            </div>
          ))}
        </div>

        {/* FAQ */}
        <div>
          <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '1.5rem', textAlign: 'center' }}>
            Frequently asked questions
          </h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
            {FAQ.map(item => (
              <details
                key={item.q}
                style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 12, padding: '1.25rem', cursor: 'pointer' }}
              >
                <summary style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', listStyle: 'none', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  {item.q}
                  <span style={{ color: 'var(--text-muted)', fontSize: '1.2rem', lineHeight: 1 }}>+</span>
                </summary>
                <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginTop: '0.75rem', lineHeight: 1.6 }}>{item.a}</p>
              </details>
            ))}
          </div>
        </div>

      </div>

      <style>{`
        @media (max-width: 640px) {
          div[style*="grid-template-columns: 1fr 1fr"] {
            grid-template-columns: 1fr !important;
          }
          div[style*="grid-template-columns: repeat(3, 1fr)"] {
            grid-template-columns: 1fr !important;
          }
        }
      `}</style>
    </div>
  )
}
