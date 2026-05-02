'use client'

import { useState } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import AuthModal from '../AuthModal'

interface Assessment {
  id: string
  title: string
  slug: string
  description: string | null
  short_description: string | null
  category: string
  icon_emoji: string
  icon_bg: string
  duration_minutes: number
  question_count: number
  attempts_count: number
  xp_reward: number
  difficulty: string
  tags: string[]
  is_pro: boolean
}

interface Props {
  assessment: Assessment
  popular: Assessment[]
  isLoggedIn: boolean
  isPro: boolean
  bestScore: number | null
}

const INSTRUCTIONS = [
  'The assessment has a time limit.',
  'Answer honestly — results reflect your actual skill level.',
  'Once you\'ve submitted an answer, you can\'t go back.',
  'If unsure, make your best guess — partial knowledge counts.',
  'You have 3 hearts (lives). Lose them all and the attempt ends.',
  'You can retake the assessment to improve your score.',
]

const DETAILS = [
  { label: 'Adaptive question pool', icon: '🎯' },
  { label: 'Comprehensive skill report', icon: '📋' },
  { label: 'Duolingo-style learning', icon: '❤️' },
  { label: 'Get learning recommendations', icon: '🗺️' },
  { label: 'Industry benchmarking', icon: '📊' },
  { label: 'English language', icon: '🌐' },
  { label: 'Complete at your own pace', icon: '⏰' },
  { label: 'XP rewards for correct answers', icon: '⭐' },
]

export default function AssessmentDetail({ assessment: a, popular, isLoggedIn, isPro, bestScore }: Props) {
  const router = useRouter()
  const [showAuth, setShowAuth] = useState(false)

  const handleStart = () => {
    if (!isLoggedIn) { setShowAuth(true); return }
    router.push(`/assessments/${a.slug}/take`)
  }

  const pctScore = bestScore != null ? Math.round((bestScore) * 100) : null

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      {/* Breadcrumb */}
      <div style={{ padding: '1rem 1.5rem', borderBottom: '1px solid var(--line)', background: 'var(--dim)' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem', color: 'var(--muted)' }}>
          <Link href="/assessments" style={{ color: 'var(--muted)', textDecoration: 'none' }}>Assessments</Link>
          <span>›</span>
          <span style={{ color: 'var(--cream)' }}>{a.title}</span>
        </div>
      </div>

      <div style={{ maxWidth: 1100, margin: '0 auto', padding: '3rem 1.5rem' }}>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 320px', gap: '3rem', alignItems: 'start' }}>

          {/* Left: main content */}
          <div>
            {/* Hero */}
            <div style={{ display: 'flex', alignItems: 'flex-start', gap: '1.5rem', marginBottom: '2rem' }}>
              <div style={{ width: 80, height: 80, borderRadius: 20, background: a.icon_bg, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2.5rem', flexShrink: 0 }}>
                {a.icon_emoji}
              </div>
              <div>
                <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '0.5rem', flexWrap: 'wrap' }}>
                  <span className="pill" style={{ fontSize: '0.75rem', borderColor: 'var(--line)', color: 'var(--muted)' }}>{a.category}</span>
                  {a.is_pro && <span className="pill pill-amber" style={{ fontSize: '0.75rem' }}>PRO</span>}
                  {bestScore != null && (
                    <span className="pill pill-green" style={{ fontSize: '0.75rem' }}>
                      Best: {pctScore}%
                    </span>
                  )}
                </div>
                <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.8rem, 4vw, 2.5rem)', color: 'var(--cream)', marginBottom: '0.75rem', lineHeight: 1.2 }}>
                  {a.title}
                </h1>
                {/* Stats */}
                <div style={{ display: 'flex', gap: '1.25rem', color: 'var(--muted)', fontSize: '0.9rem', flexWrap: 'wrap' }}>
                  <span>⏱ {a.duration_minutes}m</span>
                  <span>📝 {a.question_count} questions</span>
                  <span>👥 {a.attempts_count.toLocaleString()} attempts</span>
                  <span>⭐ {a.xp_reward} XP</span>
                </div>
              </div>
            </div>

            <button onClick={handleStart} className="btn-primary" style={{ marginBottom: '2.5rem', padding: '0.75rem 2rem', fontSize: '1rem' }}>
              Start assessment →
            </button>

            {/* About */}
            <section style={{ marginBottom: '2.5rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>
                About the {a.title} assessment
              </h2>
              <p style={{ color: 'var(--muted)', lineHeight: 1.75, fontSize: '0.95rem' }}>
                {a.description}
              </p>
            </section>

            {/* Details grid */}
            <section style={{ marginBottom: '2.5rem', padding: '1.5rem', background: 'var(--dim)', borderRadius: 16, border: '1px solid var(--line)' }}>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.75rem' }}>
                {DETAILS.map(d => (
                  <div key={d.label} style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', color: 'var(--muted)', fontSize: '0.875rem' }}>
                    <span>{d.icon}</span>
                    <span>{d.label}</span>
                  </div>
                ))}
              </div>
            </section>

            {/* Instructions */}
            <section style={{ marginBottom: '2.5rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>Instructions</h2>
              <ul style={{ listStyle: 'none', padding: 0, display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
                {INSTRUCTIONS.map((ins, i) => (
                  <li key={i} style={{ display: 'flex', gap: '0.75rem', alignItems: 'flex-start', color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.6 }}>
                    <span style={{ color: 'var(--accent)', fontWeight: 700, flexShrink: 0 }}>→</span>
                    {ins}
                  </li>
                ))}
              </ul>
            </section>

            {/* Tags */}
            {a.tags && a.tags.length > 0 && (
              <section style={{ marginBottom: '2.5rem' }}>
                <h2 style={{ fontSize: '0.8rem', fontWeight: 600, color: 'var(--muted)', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.06em' }}>Topics</h2>
                <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                  {a.tags.map(tag => (
                    <span key={tag} className="pill" style={{ borderColor: 'var(--line)', color: 'var(--muted)' }}>{tag}</span>
                  ))}
                </div>
              </section>
            )}

            {/* Popular assessments */}
            {popular.length > 0 && (
              <section style={{ marginTop: '3rem', paddingTop: '2rem', borderTop: '1px solid var(--line)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                  <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)' }}>Popular assessments</h2>
                  <Link href="/assessments" style={{ color: 'var(--muted)', fontSize: '0.875rem', textDecoration: 'none' }}>View all →</Link>
                </div>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '1rem' }}>
                  {popular.slice(0, 3).map(p => (
                    <Link key={p.id} href={`/assessments/${p.slug}`} style={{ textDecoration: 'none' }}>
                      <div style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 16, overflow: 'hidden', transition: 'transform 0.15s', cursor: 'pointer' }}
                        onMouseEnter={e => (e.currentTarget as HTMLDivElement).style.transform = 'translateY(-2px)'}
                        onMouseLeave={e => (e.currentTarget as HTMLDivElement).style.transform = ''}>
                        <div style={{ height: 80, background: p.icon_bg, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem' }}>{p.icon_emoji}</div>
                        <div style={{ padding: '0.875rem' }}>
                          <div style={{ fontSize: '0.7rem', color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.25rem' }}>Assessment</div>
                          <div style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.5rem' }}>{p.title}</div>
                          <div style={{ fontSize: '0.78rem', color: 'var(--muted)' }}>⏱ {p.duration_minutes}m · 📝 {p.question_count} questions · 👥 {p.attempts_count.toLocaleString()}</div>
                        </div>
                      </div>
                    </Link>
                  ))}
                </div>
              </section>
            )}

            {/* FAQ */}
            <section style={{ marginTop: '3rem', paddingTop: '2rem', borderTop: '1px solid var(--line)' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.5rem' }}>FAQs</h2>
              {[
                { q: `What is the ${a.title} assessment?`, a: `The ${a.title} assessment measures your proficiency and delivers a personalized skill report with learning recommendations.` },
                { q: 'How is this different from a course quiz?', a: 'Assessments are standalone skill benchmarks. They use a duolingo-style format with lives (hearts) and XP rewards per correct answer — more challenging and game-like than module quizzes.' },
                { q: 'Can I retake the assessment?', a: 'Yes. You can retake any assessment as many times as you want. Only your best score is displayed on your profile.' },
                { q: 'What happens when I complete the assessment?', a: `You earn up to ${a.xp_reward} XP and receive a breakdown of your score with correct answers and explanations.` },
                { q: 'Do I need to pay to take assessments?', a: a.is_pro ? 'This assessment requires a Pro subscription. Upgrade to unlock all assessments and courses.' : 'No — this assessment is free for all users.' },
              ].map((faq, i) => (
                <details key={i} style={{ borderTop: '1px solid var(--line)', padding: '1.25rem 0' }}>
                  <summary style={{ fontSize: '0.95rem', fontWeight: 500, color: 'var(--cream)', cursor: 'pointer', listStyle: 'none', display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: '1rem' }}>
                    {faq.q}
                    <span style={{ color: 'var(--muted)', flexShrink: 0, fontSize: '1.25rem', fontWeight: 300 }}>+</span>
                  </summary>
                  <p style={{ color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.65, marginTop: '0.75rem', paddingRight: '2rem' }}>{faq.a}</p>
                </details>
              ))}
            </section>
          </div>

          {/* Right: sticky sidebar */}
          <div style={{ position: 'sticky', top: '5rem' }}>
            <div style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 20, overflow: 'hidden' }}>
              {/* Icon preview */}
              <div style={{ height: 120, background: a.icon_bg, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '3.5rem' }}>
                {a.icon_emoji}
              </div>
              <div style={{ padding: '1.5rem' }}>
                <h3 style={{ fontSize: '1.1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem' }}>
                  Measure & benchmark your skills
                </h3>
                <p style={{ color: 'var(--muted)', fontSize: '0.875rem', marginBottom: '1.25rem', lineHeight: 1.6 }}>
                  Discover your skill level and receive customized learning recommendations.
                </p>
                <button onClick={handleStart} className="btn-primary" style={{ width: '100%', justifyContent: 'center', padding: '0.8rem', marginBottom: '0.5rem', fontSize: '0.95rem' }}>
                  Start assessment
                </button>
                <div style={{ textAlign: 'center', color: 'var(--muted)', fontSize: '0.8rem', marginBottom: '1.5rem' }}>
                  {bestScore != null ? `✓ Completed · Best score: ${pctScore}%` : `Earn ${a.xp_reward} XP`}
                </div>

                {/* Stats */}
                <div style={{ borderTop: '1px solid var(--line)', paddingTop: '1.25rem', display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                  {[
                    { label: 'Duration', value: `${a.duration_minutes} minutes` },
                    { label: 'Questions', value: `${a.question_count} questions` },
                    { label: 'Difficulty', value: a.difficulty },
                    { label: 'XP reward', value: `Up to ${a.xp_reward} XP` },
                    { label: 'Attempts', value: a.attempts_count.toLocaleString() },
                  ].map(s => (
                    <div key={s.label} style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem' }}>
                      <span style={{ color: 'var(--muted)' }}>{s.label}</span>
                      <span style={{ color: 'var(--cream)', fontWeight: 500 }}>{s.value}</span>
                    </div>
                  ))}
                </div>

                {!isPro && (
                  <div style={{ marginTop: '1.5rem', padding: '1.25rem', background: 'color-mix(in srgb, var(--accent) 6%, transparent)', border: '1px solid color-mix(in srgb, var(--accent) 20%, transparent)', borderRadius: 12 }}>
                    <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.75rem' }}>
                      Get full access with Pro
                    </div>
                    <ul style={{ listStyle: 'none', padding: 0, display: 'flex', flexDirection: 'column', gap: '0.4rem', marginBottom: '1rem' }}>
                      {['Unlimited assessments', 'All 5 career paths', 'Priority support', 'Certificate of completion'].map(b => (
                        <li key={b} style={{ fontSize: '0.825rem', color: 'var(--muted)', display: 'flex', gap: '0.5rem' }}>
                          <span style={{ color: 'var(--accent)' }}>✓</span> {b}
                        </li>
                      ))}
                    </ul>
                    <Link href="/upgrade" className="btn-primary" style={{ display: 'block', textAlign: 'center', textDecoration: 'none', fontSize: '0.875rem', padding: '0.6rem' }}>
                      Upgrade now
                    </Link>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Responsive: hide sidebar column on mobile */}
      <style>{`
        @media (max-width: 768px) {
          .assessment-detail-grid { grid-template-columns: 1fr !important; }
          .assessment-detail-sidebar { display: none; }
        }
      `}</style>

      {showAuth && (
        <AuthModal mode="signup" onClose={() => setShowAuth(false)} onSuccess={() => { setShowAuth(false); router.push(`/assessments/${a.slug}/take`) }} />
      )}
    </div>
  )
}
