'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import AuthModal from '@/components/AuthModal'
import { supabase } from '@/lib/supabase'
import { CATEGORY_GRADIENTS } from '@/lib/category-constants'

const PATHS = [
  {
    slug: 'ai-product-building',
    name: 'AI Product Building',
    category: 'AI',
    description: 'Build real AI products, not just prompts. Go from curious to shipping.',
    color: 'var(--accent)',
    emoji: '🤖',
    modules: 24,
    hours: 40,
    badge: 'Most Popular',
  },
  {
    slug: 'ux-design',
    name: 'UX Design',
    category: 'Design',
    description: 'Design flows that feel obvious. Figma, prototyping, and user research.',
    color: '#C084FC',
    emoji: '🎨',
    modules: 18,
    hours: 32,
    badge: null,
  },
  {
    slug: 'product-management',
    name: 'Product Management',
    category: 'Product',
    description: 'Ship products people actually want. PRDs, roadmaps, stakeholder alignment.',
    color: '#F5C842',
    emoji: '📦',
    modules: 22,
    hours: 38,
    badge: null,
  },
  {
    slug: 'digital-marketing',
    name: 'Digital Marketing',
    category: 'Marketing',
    description: 'Growth, content, ads, and SEO — the full stack of modern marketing.',
    color: '#FB923C',
    emoji: '📈',
    modules: 20,
    hours: 35,
    badge: null,
  },
  {
    slug: 'data-analysis',
    name: 'Data Analysis',
    category: 'Data',
    description: 'Go from spreadsheets to dashboards. SQL, Python, and storytelling with data.',
    color: '#34D399',
    emoji: '📊',
    modules: 26,
    hours: 44,
    badge: 'Coming Soon',
  },
]

const SOCIAL_PROOF = [
  { name: 'Priya M.', role: 'Got a UX internship @ Swiggy', avatar: '👩🏾', quote: 'The structured sequence was everything. I stopped doom-scrolling tutorials.' },
  { name: 'Arjun K.', role: 'Landed PM role @ Series B startup', avatar: '👨🏽', quote: '150 XP for a quiz is weirdly motivating. I finished 3 modules in a weekend.' },
  { name: 'Nisha R.', role: 'AI tools lead @ agency', avatar: '👩🏼', quote: "The 'why this video' context before each lesson is what makes it different." },
]

interface InProgressCourse {
  courseId: string
  title: string
  slug: string
  pathName: string
  pathCategory: string
  progressTotal: number
  progressCompleted: number
  lastLessonHref: string | null
}

export default function LandingPage() {
  const [showAuth, setShowAuth] = useState(false)
  const [inProgressCourses, setInProgressCourses] = useState<InProgressCourse[] | null>(null)

  useEffect(() => {
    const db = supabase()
    db.auth.getUser().then(async ({ data: { user } }) => {
      if (!user) return

      const { data: enrollments } = await db
        .from('course_enrollments')
        .select('course_id, course:courses(id, title, slug, path:paths(name, category))')
        .eq('user_id', user.id)

      if (!enrollments || enrollments.length === 0) { setInProgressCourses([]); return }

      const courseIds = enrollments.map((e: any) => {
        const c = Array.isArray(e.course) ? e.course[0] : e.course
        return c?.id
      }).filter(Boolean)

      const [{ data: allModules }, { data: completedMods }, { data: lpRaw }] = await Promise.all([
        db.from('modules').select('id, course_id').in('course_id', courseIds),
        db.from('module_progress').select('module_id').eq('user_id', user.id).eq('quiz_passed', true),
        db.from('lesson_progress')
          .select('lesson_id, started_at, lesson:lessons(module_id, module:modules(id, course_id))')
          .eq('user_id', user.id)
          .order('started_at', { ascending: false }),
      ])

      const completedSet = new Set((completedMods ?? []).map((p: any) => p.module_id))
      const modulesByCourse: Record<string, { total: number; completed: number }> = {}
      for (const mod of (allModules ?? [])) {
        if (!modulesByCourse[mod.course_id]) modulesByCourse[mod.course_id] = { total: 0, completed: 0 }
        modulesByCourse[mod.course_id].total++
        if (completedSet.has(mod.id)) modulesByCourse[mod.course_id].completed++
      }

      const lastModulePerCourse: Record<string, string> = {}
      for (const lp of (lpRaw ?? [])) {
        const lesson = Array.isArray((lp as any).lesson) ? (lp as any).lesson[0] : (lp as any).lesson
        const mod = lesson ? (Array.isArray(lesson.module) ? lesson.module[0] : lesson.module) : null
        if (mod?.course_id && mod?.id && !lastModulePerCourse[mod.course_id]) {
          lastModulePerCourse[mod.course_id] = mod.id
        }
      }

      const courses: InProgressCourse[] = enrollments.map((e: any) => {
        const c = Array.isArray(e.course) ? e.course[0] : e.course
        const path = c ? (Array.isArray(c.path) ? c.path[0] : c.path) : null
        const progress = modulesByCourse[c?.id] ?? { total: 0, completed: 0 }
        const lastModuleId = c?.id ? lastModulePerCourse[c.id] : undefined
        return {
          courseId: c?.id ?? '',
          title: c?.title ?? '',
          slug: c?.slug ?? '',
          pathName: path?.name ?? '',
          pathCategory: path?.category ?? '',
          progressTotal: progress.total,
          progressCompleted: progress.completed,
          lastLessonHref: lastModuleId && c?.slug ? `/learn/${c.slug}/${lastModuleId}` : null,
        }
      }).filter((c: InProgressCourse) => c.progressCompleted < c.progressTotal) // only in-progress

      setInProgressCourses(courses)
    })
  }, [])

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>

      {/* Hero */}
      <section
        style={{
          minHeight: '90vh',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          textAlign: 'center',
          padding: '4rem 1.5rem 6rem',
          position: 'relative',
          overflow: 'hidden',
        }}
      >
        {/* Background glow */}
        <div
          style={{
            position: 'absolute',
            top: '20%',
            left: '50%',
            transform: 'translateX(-50%)',
            width: 600,
            height: 400,
            background: 'radial-gradient(ellipse, color-mix(in srgb, var(--accent) 12%, transparent) 0%, transparent 70%)',
            pointerEvents: 'none',
          }}
        />

        {/* Badge */}
        <div className="pill pill-green" style={{ marginBottom: '1.5rem' }}>
          ✦ Free to start — no credit card
        </div>

        {/* Headline */}
        <h1
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(2.5rem, 7vw, 5.5rem)',
            fontWeight: 400,
            lineHeight: 1.05,
            color: 'var(--cream)',
            letterSpacing: '-0.02em',
            maxWidth: 900,
            marginBottom: '1.25rem',
          }}
        >
          Your first tech job
          <br />
          <em style={{ color: 'var(--green)' }}>starts here.</em>
        </h1>

        {/* Sub */}
        <p
          style={{
            color: 'var(--muted)',
            fontSize: 'clamp(1rem, 2.5vw, 1.2rem)',
            maxWidth: 580,
            lineHeight: 1.65,
            marginBottom: '2.5rem',
          }}
        >
          Structured YouTube paths built by practitioners. No more guessing what to watch next — just learn, confirm, and progress.
        </p>

        {/* CTA Row */}
        <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap', justifyContent: 'center' }}>
          <button
            onClick={() => setShowAuth(true)}
            className="btn-primary"
            style={{ fontSize: '1rem', padding: '0.75rem 1.75rem' }}
          >
            Start for free →
          </button>
          <Link
            href="/paths"
            className="btn-outline"
            style={{ fontSize: '1rem', padding: '0.75rem 1.75rem' }}
          >
            Browse paths
          </Link>
        </div>

        {/* Stats */}
        <div
          style={{
            display: 'flex',
            gap: '2.5rem',
            marginTop: '4rem',
            flexWrap: 'wrap',
            justifyContent: 'center',
          }}
        >
          {[
            { n: '5', label: 'Career paths' },
            { n: '200+', label: 'Curated lessons' },
            { n: '100%', label: 'Free to explore' },
          ].map(stat => (
            <div key={stat.label} style={{ textAlign: 'center' }}>
              <div
                style={{
                  fontFamily: 'var(--font-serif)',
                  fontSize: '2.2rem',
                  color: 'var(--cream)',
                  lineHeight: 1,
                  marginBottom: '0.25rem',
                }}
              >
                {stat.n}
              </div>
              <div style={{ color: 'var(--muted)', fontSize: '0.85rem' }}>{stat.label}</div>
            </div>
          ))}
        </div>
      </section>

      {/* In-progress courses — shown for logged-in users with active enrollments */}
      {inProgressCourses && inProgressCourses.length > 0 && (
        <section style={{ maxWidth: 1100, margin: '0 auto', padding: '0 1.5rem 3rem' }}>
          <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 3vw, 2rem)', color: 'var(--cream)', marginBottom: '1.25rem' }}>
            Pick up where you left off.
          </h2>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
            {inProgressCourses.map(c => {
              const pct = c.progressTotal > 0 ? Math.round((c.progressCompleted / c.progressTotal) * 100) : 0
              const [g1, g2] = CATEGORY_GRADIENTS[c.pathCategory] ?? CATEGORY_GRADIENTS.AI
              return (
                <div key={c.courseId} style={{ background: 'var(--dim)', border: '1.5px solid var(--line)', borderRadius: 16, overflow: 'hidden' }}>
                  <div style={{ height: 4, background: `linear-gradient(90deg, ${g1}, ${g2})` }} />
                  <div style={{ padding: '1.25rem' }}>
                    <div style={{ fontSize: '0.72rem', fontWeight: 600, color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.4rem' }}>
                      {c.pathName}
                    </div>
                    <div style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '1rem', lineHeight: 1.4 }}>
                      {c.title}
                    </div>
                    <div style={{ marginBottom: '0.75rem' }}>
                      <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.78rem', color: 'var(--muted)', marginBottom: '0.4rem' }}>
                        <span>{c.progressCompleted}/{c.progressTotal} modules</span>
                        <span style={{ fontWeight: 600, color: 'var(--cream)' }}>{pct}%</span>
                      </div>
                      <div style={{ height: 5, background: 'rgba(255,255,255,0.08)', borderRadius: 999, overflow: 'hidden' }}>
                        <div style={{ height: '100%', borderRadius: 999, width: `${pct}%`, background: `linear-gradient(90deg, ${g1}, ${g2})`, transition: 'width 0.8s ease' }} />
                      </div>
                    </div>
                    <Link
                      href={c.lastLessonHref ?? `/courses/${c.slug}`}
                      style={{
                        display: 'block', textAlign: 'center', fontSize: '0.82rem', fontWeight: 600,
                        padding: '0.5rem', borderRadius: 8, textDecoration: 'none',
                        background: `color-mix(in srgb, ${g1} 15%, transparent)`,
                        color: g1, border: `1px solid ${g1}30`,
                      }}
                    >
                      Continue →
                    </Link>
                  </div>
                </div>
              )
            })}
          </div>
        </section>
      )}

      {/* How it works */}
      <section
        style={{
          maxWidth: 1100,
          margin: '0 auto',
          padding: '4rem 1.5rem',
        }}
      >
        <h2
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(1.8rem, 4vw, 2.8rem)',
            textAlign: 'center',
            marginBottom: '3rem',
            color: 'var(--cream)',
          }}
        >
          Actually finish what you start.
        </h2>

        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))',
            gap: '1.25rem',
          }}
        >
          {[
            {
              step: '01',
              title: 'Pick a path',
              body: 'Choose from 5 career tracks built by practitioners, not committees.',
              color: 'var(--accent)',
            },
            {
              step: '02',
              title: 'Watch in order',
              body: 'Every lesson is sequenced. You always know what\'s next and why.',
              color: 'var(--green)',
            },
            {
              step: '03',
              title: 'Prove you got it',
              body: '3-question quiz after each module. 2/3 to unlock the next one.',
              color: 'var(--amber)',
            },
            {
              step: '04',
              title: 'See your progress',
              body: 'Visual roadmap, XP, streaks. Feel the momentum building daily.',
              color: 'var(--coral)',
            },
          ].map(card => (
            <div
              key={card.step}
              style={{
                background: 'var(--dim)',
                border: '1.5px solid var(--line)',
                borderRadius: 16,
                padding: '1.5rem',
              }}
            >
              <div
                style={{
                  fontFamily: 'var(--font-serif)',
                  fontSize: '1rem',
                  color: card.color,
                  marginBottom: '0.75rem',
                  fontStyle: 'italic',
                }}
              >
                {card.step}
              </div>
              <h3
                style={{
                  fontSize: '1.1rem',
                  fontWeight: 600,
                  color: 'var(--cream)',
                  marginBottom: '0.5rem',
                }}
              >
                {card.title}
              </h3>
              <p style={{ color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.6 }}>
                {card.body}
              </p>
            </div>
          ))}
        </div>
      </section>

      {/* Paths Grid */}
      <section
        style={{
          maxWidth: 1100,
          margin: '0 auto',
          padding: '2rem 1.5rem 5rem',
        }}
      >
        <h2
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(1.8rem, 4vw, 2.8rem)',
            textAlign: 'center',
            marginBottom: '0.75rem',
            color: 'var(--cream)',
          }}
        >
          Choose your path.
        </h2>
        <p style={{ color: 'var(--muted)', textAlign: 'center', marginBottom: '2.5rem' }}>
          All free to explore. Upgrade to unlock full access.
        </p>

        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
            gap: '1.25rem',
          }}
        >
          {PATHS.map(path => (
            <Link
              key={path.slug}
              href={path.badge === 'Coming Soon' ? '#' : `/paths/${path.slug}`}
              style={{ textDecoration: 'none' }}
            >
              <div
                style={{
                  background: 'var(--dim)',
                  border: '1.5px solid var(--line)',
                  borderRadius: 18,
                  padding: '1.5rem',
                  height: '100%',
                  transition: 'border-color 0.2s, transform 0.2s',
                  cursor: path.badge === 'Coming Soon' ? 'default' : 'pointer',
                  opacity: path.badge === 'Coming Soon' ? 0.5 : 1,
                  position: 'relative',
                  overflow: 'hidden',
                }}
                onMouseEnter={e => {
                  if (path.badge !== 'Coming Soon') {
                    (e.currentTarget as HTMLDivElement).style.borderColor = path.color
                    ;(e.currentTarget as HTMLDivElement).style.transform = 'translateY(-2px)'
                  }
                }}
                onMouseLeave={e => {
                  ;(e.currentTarget as HTMLDivElement).style.borderColor = 'var(--line)'
                  ;(e.currentTarget as HTMLDivElement).style.transform = 'translateY(0)'
                }}
              >
                {/* Gradient accent */}
                <div
                  style={{
                    position: 'absolute',
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 3,
                    background: `linear-gradient(90deg, color-mix(in srgb, ${path.color} 53%, transparent), color-mix(in srgb, ${path.color} 13%, transparent))`,
                  }}
                />

                <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '1rem' }}>
                  <span style={{ fontSize: '2rem' }}>{path.emoji}</span>
                  {path.badge && (
                    <span
                      className="pill"
                      style={{
                        color: path.color,
                        borderColor: `color-mix(in srgb, ${path.color} 27%, transparent)`,
                        background: `color-mix(in srgb, ${path.color} 7%, transparent)`,
                        fontSize: '0.7rem',
                      }}
                    >
                      {path.badge}
                    </span>
                  )}
                </div>

                <h3
                  style={{
                    fontSize: '1.1rem',
                    fontWeight: 600,
                    color: 'var(--cream)',
                    marginBottom: '0.4rem',
                  }}
                >
                  {path.name}
                </h3>
                <p
                  style={{
                    color: 'var(--muted)',
                    fontSize: '0.875rem',
                    lineHeight: 1.55,
                    marginBottom: '1.25rem',
                  }}
                >
                  {path.description}
                </p>

                <div
                  style={{
                    display: 'flex',
                    gap: '1rem',
                    color: 'var(--muted)',
                    fontSize: '0.8rem',
                  }}
                >
                  <span>{path.modules} modules</span>
                  <span>·</span>
                  <span>{path.hours}h content</span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* Social proof */}
      <section
        style={{
          background: 'var(--dim)',
          borderTop: '1px solid var(--line)',
          borderBottom: '1px solid var(--line)',
          padding: '5rem 1.5rem',
        }}
      >
        <div style={{ maxWidth: 1100, margin: '0 auto' }}>
          <h2
            style={{
              fontFamily: 'var(--font-serif)',
              fontSize: 'clamp(1.8rem, 4vw, 2.8rem)',
              textAlign: 'center',
              marginBottom: '2.5rem',
              color: 'var(--cream)',
            }}
          >
            From learner to hired.
          </h2>
          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
              gap: '1.25rem',
            }}
          >
            {SOCIAL_PROOF.map((t, i) => (
              <div
                key={i}
                style={{
                  background: 'var(--ink)',
                  border: '1.5px solid var(--line)',
                  borderRadius: 16,
                  padding: '1.5rem',
                }}
              >
                <p
                  style={{
                    color: 'var(--cream)',
                    fontSize: '0.95rem',
                    lineHeight: 1.65,
                    fontFamily: 'var(--font-serif)',
                    fontStyle: 'italic',
                    marginBottom: '1rem',
                  }}
                >
                  &ldquo;{t.quote}&rdquo;
                </p>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                  <span style={{ fontSize: '1.5rem' }}>{t.avatar}</span>
                  <div>
                    <div style={{ fontWeight: 600, fontSize: '0.9rem', color: 'var(--cream)' }}>{t.name}</div>
                    <div style={{ color: 'var(--muted)', fontSize: '0.8rem' }}>{t.role}</div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Final CTA */}
      <section
        style={{
          padding: '6rem 1.5rem',
          textAlign: 'center',
          background: 'var(--ink)',
        }}
      >
        <h2
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(2rem, 5vw, 3.5rem)',
            color: 'var(--cream)',
            marginBottom: '1rem',
          }}
        >
          Ready to start?
        </h2>
        <p style={{ color: 'var(--muted)', marginBottom: '2rem', fontSize: '1rem' }}>
          Free forever for the first two modules of every path.
        </p>
        <button
          onClick={() => setShowAuth(true)}
          className="btn-primary"
          style={{ fontSize: '1.05rem', padding: '0.85rem 2rem' }}
        >
          Create free account →
        </button>
      </section>

      {/* Footer */}
      <footer
        style={{
          borderTop: '1px solid var(--line)',
          padding: '1.5rem',
          textAlign: 'center',
          color: 'var(--muted)',
          fontSize: '0.8rem',
        }}
      >
        © 2026 VibeLearn · Built with love for first-time job-seekers ·{' '}
        <a href="mailto:hey@vibelearn.app" style={{ color: 'var(--muted)' }}>hey@vibelearn.app</a>
      </footer>

      {showAuth && (
        <AuthModal
          mode="signup"
          onClose={() => setShowAuth(false)}
          onSuccess={() => setShowAuth(false)}
        />
      )}
    </div>
  )
}
