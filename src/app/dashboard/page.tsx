import { supabaseServer } from '@/lib/supabase-server'
import { redirect } from 'next/navigation'
import { ContinueLearning } from '@/components/dashboard/ContinueLearning'
import { GettingStarted } from '@/components/dashboard/GettingStarted'
import { StreakTracker } from '@/components/dashboard/StreakTracker'
import { PathRoadmapWidget } from '@/components/dashboard/PathRoadmapWidget'
import Link from 'next/link'

export const metadata = {
  title: 'Dashboard — VibeLearn',
}

export default async function DashboardPage() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()

  if (!user) redirect('/?auth=required')

  const { data: profile } = await db
    .from('profiles')
    .select(`*, selected_path:paths ( id, name, slug, hero_color )`)
    .eq('id', user.id)
    .single()

  if (!profile) redirect('/')
  if (!profile.onboarding_completed) redirect('/onboarding')

  let pathCourses: { id: string; title: string; slug: string; order_index: number }[] = []
  if ((profile as any)?.selected_path?.id) {
    const { data: courses } = await db
      .from('courses')
      .select('id, title, slug, order_index')
      .eq('path_id', (profile as any).selected_path.id)
      .eq('is_hidden', false)
      .order('order_index', { ascending: true })
    pathCourses = courses ?? []
  }

  const [{ data: latestProgress }, { data: completedModules }, { data: subscription }] = await Promise.all([
    db.from('lesson_progress')
      .select('lesson:lessons(id, title, module:modules(id, course:courses(slug, name)))')
      .eq('user_id', user.id)
      .order('started_at', { ascending: false })
      .limit(1)
      .single(),

    db.from('module_progress')
      .select('id')
      .eq('user_id', user.id)
      .eq('quiz_passed', true),

    db.from('subscriptions')
      .select('status')
      .eq('user_id', user.id)
      .eq('status', 'active')
      .maybeSingle(),
  ])

  const activeLesson: any = (latestProgress as any)?.lesson
  const hasStartedLesson = !!latestProgress
  const hasPassedQuiz = !!(completedModules && completedModules.length > 0)
  const isPro = !!subscription

  const firstName = profile.full_name?.split(' ')[0] ?? 'Learner'

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg)' }}>
      <div style={{ maxWidth: 1100, margin: '0 auto', padding: '2rem 1.5rem' }}>

        {/* Header */}
        <div style={{ marginBottom: '2rem' }}>
          <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            Hey, {firstName} 👋
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem' }}>
            {profile.career_goal
              ? `On your way to becoming a ${profile.career_goal.replace(/-/g, ' ').replace(/\b\w/g, (c: string) => c.toUpperCase())}`
              : 'Ready to learn something today?'}
          </p>
        </div>

        {/* Two-column layout */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 300px', gap: '1.5rem', alignItems: 'start' }}>

          {/* Main content (left) */}
          <div>
            {/* Continue Learning */}
            <ContinueLearning
              activeLesson={activeLesson}
              pathName={profile.selected_path?.name ?? null}
              pathSlug={profile.selected_path?.slug ?? null}
            />

            {/* XP + Streak summary bar */}
            <div
              style={{
                display: 'flex',
                gap: '1rem',
                marginBottom: '2rem',
              }}
            >
              <div style={{ flex: 1, background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 12, padding: '1rem', textAlign: 'center' }}>
                <div style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--xp-color)' }}>
                  {profile.xp_total?.toLocaleString() ?? 0}
                </div>
                <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Total XP</div>
              </div>
              <div style={{ flex: 1, background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 12, padding: '1rem', textAlign: 'center' }}>
                <div style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--streak-color)' }}>
                  {profile.streak_days ?? 0}🔥
                </div>
                <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Day streak</div>
              </div>
              <div style={{ flex: 1, background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 12, padding: '1rem', textAlign: 'center' }}>
                <div style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--success)' }}>
                  {completedModules?.length ?? 0}
                </div>
                <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Modules done</div>
              </div>
            </div>

            {/* Your Path Courses */}
            {pathCourses.length > 0 && (
              <div style={{
                background: 'var(--surface)',
                border: '1px solid var(--border)',
                borderRadius: 14,
                padding: '1.25rem',
                marginBottom: '1.5rem',
              }}>
                <h3 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)', margin: '0 0 0.75rem' }}>
                  Your Path Courses
                </h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
                  {pathCourses.map((course, i) => (
                    <Link
                      key={course.id}
                      href={`/courses/${course.slug}`}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.65rem',
                        padding: '0.55rem 0.7rem',
                        borderRadius: 9,
                        background: 'transparent',
                        border: '1px solid var(--border)',
                        textDecoration: 'none',
                        color: 'var(--text-primary)',
                        fontSize: '0.88rem',
                        fontWeight: 500,
                      }}
                    >
                      <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)', minWidth: 20 }}>
                        {i + 1}.
                      </span>
                      {course.title}
                    </Link>
                  ))}
                </div>
              </div>
            )}

            {/* League teaser */}
            <div
              style={{
                marginTop: '2rem',
                background: 'linear-gradient(135deg, color-mix(in srgb, var(--accent) 8%, var(--surface)), var(--surface))',
                border: '1px solid color-mix(in srgb, var(--accent) 20%, var(--border))',
                borderRadius: 14,
                padding: '1.5rem',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                gap: '1rem',
              }}
            >
              <div>
                <div style={{ fontSize: '0.75rem', color: 'var(--accent)', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.25rem' }}>
                  Coming Soon
                </div>
                <h3 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
                  🏆 Quartz League
                </h3>
                <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>
                  Compete weekly with learners at your level. Advance tiers, earn badges.
                </p>
              </div>
              <button
                disabled
                style={{ padding: '0.5rem 1rem', borderRadius: 8, border: '1px solid var(--border)', background: 'transparent', color: 'var(--text-muted)', fontSize: '0.85rem', cursor: 'not-allowed', whiteSpace: 'nowrap' }}
              >
                Coming Soon
              </button>
            </div>
          </div>

          {/* Right sidebar */}
          <div>
            <PathRoadmapWidget
              careerGoal={profile.career_goal ?? null}
              pathSlug={profile.selected_path?.slug ?? null}
              completedModuleCount={completedModules?.length ?? 0}
              hasStartedLesson={hasStartedLesson}
            />

            <GettingStarted
              hasStartedLesson={hasStartedLesson}
              hasPassedQuiz={hasPassedQuiz}
              isPro={isPro}
            />

            <StreakTracker streakDays={profile.streak_days ?? 0} />

            {/* Quick links */}
            <div
              style={{
                background: 'var(--surface)',
                border: '1px solid var(--border)',
                borderRadius: 14,
                padding: '1.25rem',
              }}
            >
              <h3 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)', margin: '0 0 0.75rem' }}>
                Quick Links
              </h3>
              {[
                { href: '/paths', label: '📚 Browse all courses' },
                { href: '/profile', label: '👤 Edit profile' },
                { href: '/upgrade', label: '⭐ Upgrade to Pro' },
              ].map((link, i, arr) => (
                <Link
                  key={link.href}
                  href={link.href}
                  style={{
                    display: 'block',
                    padding: '0.5rem 0',
                    borderBottom: i < arr.length - 1 ? '1px solid var(--border)' : 'none',
                    textDecoration: 'none',
                    color: 'var(--text-muted)',
                    fontSize: '0.85rem',
                  }}
                >
                  {link.label}
                </Link>
              ))}
            </div>
          </div>
        </div>
      </div>

      <style>{`
        @media (max-width: 768px) {
          div[style*="grid-template-columns: 1fr 300px"] {
            grid-template-columns: 1fr !important;
          }
        }
      `}</style>
    </div>
  )
}
