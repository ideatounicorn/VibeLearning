import { notFound } from 'next/navigation'
import Link from 'next/link'
import { supabaseServer } from '@/lib/supabase-server'
import CourseSyllabus from '@/components/courses/CourseSyllabus'
import CourseEnrollButton from '@/components/courses/CourseEnrollButton'
import contributingCreators from '@/lib/contributing_creators.json'
import {
  absoluteUrl,
  breadcrumbJsonLd,
  courseJsonLd,
  courseDefaultFaqs,
  faqJsonLd,
  jsonLdScriptProps,
} from '@/lib/seo'

interface Props {
  params: Promise<{ slug: string }>
}

const CATEGORY_GRADIENTS: Record<string, [string, string]> = {
  AI:        ['#6366F1', '#818CF8'],
  Design:    ['#C084FC', '#E879F9'],
  Product:   ['#F5C842', '#FDE68A'],
  Marketing: ['#FB923C', '#FCA5A5'],
  Data:      ['#34D399', '#6EE7B7'],
}

const CATEGORY_EMOJIS: Record<string, string[]> = {
  AI:        ['🤖', '🧠', '⚡', '🔮', '🛸', '💻'],
  Design:    ['🎨', '✏️', '🖌️', '💡', '🔷', '🎭'],
  Product:   ['📦', '🚀', '📊', '🗺️', '⚙️', '📋'],
  Marketing: ['📈', '🎯', '💬', '📣', '🌟', '📱'],
  Data:      ['📊', '🔬', '📉', '🗄️', '🔢', '🧮'],
}

const LEVEL_LABELS: Record<string, string> = {
  beginner: 'Beginner',
  intermediate: 'Intermediate',
  advanced: 'Advanced',
}

const COMPANY_LOGOS = [
  { name: 'Dropbox',   domain: 'dropbox.com'  },
  { name: 'TikTok',    domain: 'tiktok.com'   },
  { name: 'PayPal',    domain: 'paypal.com'   },
  { name: 'IBM',       domain: 'ibm.com'      },
  { name: 'Deloitte',  domain: 'deloitte.com' },
  { name: 'Unicef',    domain: 'unicef.org'   },
  { name: 'Stripe',    domain: 'stripe.com'   },
]

const SAMPLE_REVIEWS = [
  {
    name: 'Aria Zhai',
    role: 'UX Designer',
    text: "This course has been an incredible learning experience, equipping me with knowledge to design intuitive and visually compelling products. I've been able to apply these insights in real-world projects.",
    rating: 5,
  },
  {
    name: 'Diana Marcos',
    role: 'Product Designer',
    text: 'Used really to the Duolingo of UX/UI. It makes it very easy to learn the concepts, interactive and fun! All the content is extremely relevant. I\'ve learned tons already. I\'m very grateful!',
    rating: 5,
  },
  {
    name: 'Ryan Blackwell',
    role: 'Frontend Engineer',
    text: 'This course has helped me advance my design and increase my salary by over 35% annually since becoming a full-timer. Every time I log in, I learn something new. It\'s opened doors to entrepreneurial spirit and I look forward to each session.',
    rating: 5,
  },
]

export async function generateMetadata({ params }: Props) {
  const { slug } = await params
  const db = await supabaseServer()
  const { data: rows } = await db
    .from('courses')
    .select('title, description, short_description, slug, thumbnail_url, tags')
    .eq('slug', slug)
    .eq('is_hidden', false)
    .limit(1)
  const course = rows?.[0]
  if (!course) {
    return { title: 'Course not found', robots: { index: false } }
  }
  const desc =
    course.short_description ??
    course.description ??
    `Learn ${course.title} with structured lessons, quizzes, and a shareable certificate on VibeLearn.`
  const trimmed = desc.length > 158 ? `${desc.slice(0, 155)}…` : desc
  const url = `/courses/${course.slug}`
  return {
    title: `${course.title} — Free Course with Certificate`,
    description: trimmed,
    keywords: course.tags ?? undefined,
    alternates: { canonical: url },
    openGraph: {
      title: course.title,
      description: trimmed,
      url,
      type: 'article',
      images: course.thumbnail_url ? [{ url: course.thumbnail_url, width: 1200, height: 630 }] : undefined,
    },
    twitter: {
      card: 'summary_large_image',
      title: course.title,
      description: trimmed,
      images: course.thumbnail_url ? [course.thumbnail_url] : undefined,
    },
  }
}

export default async function CourseDetailPage({ params }: Props) {
  const { slug } = await params
  const db = await supabaseServer()

  // Fetch course (slug not unique — take first match)
  const { data: courseRows } = await db
    .from('courses')
    .select('*')
    .eq('slug', slug)
    .eq('is_hidden', false)
    .limit(1)

  const course = courseRows?.[0] ?? null
  if (!course) notFound()

  // Fetch path separately
  const { data: pathData } = course.path_id
    ? await db.from('paths').select('id, name, slug, category, hero_color').eq('id', course.path_id).single()
    : { data: null }

  const courseWithPath = { ...course, path: pathData }

  // Fetch levels (modules) with lessons
  const { data: rawLevels } = await db
    .from('modules')
    .select(`
      id, title, description, order_index, is_free,
      lessons (id, title, duration_minutes, order_index, youtube_video_id)
    `)
    .eq('course_id', course.id)
    .order('order_index')

  const levels = (rawLevels ?? []).map(l => ({
    ...l,
    lessons: (l.lessons ?? []) as { id: string; title: string; duration_minutes: number | null; order_index: number; youtube_video_id: string | null }[],
  }))

  // Compute stats from actual data
  const totalLessons = levels.reduce((acc, l) => acc + l.lessons.length, 0)
  const totalMinutes = levels.reduce((acc, l) =>
    acc + l.lessons.reduce((a, les) => a + (les.duration_minutes ?? 0), 0), 0
  )
  const computedHours = totalMinutes > 0 ? (totalMinutes / 60).toFixed(0) : course.duration_hours?.toFixed(0) ?? '0'

  // Fetch related courses (same path, different course)
  const { data: related } = await db
    .from('courses')
    .select('id, title, slug, level, enrolled_count, duration_hours, tags')
    .eq('path_id', course.path_id ?? '')
    .eq('is_hidden', false)
    .neq('id', course.id)
    .limit(3)

  // User state
  const { data: { user } } = await db.auth.getUser()
  let completedModuleIds: string[] = []
  let isPro = false
  let isEnrolled = false

  if (user) {
    const { data: progress } = await db
      .from('module_progress')
      .select('module_id')
      .eq('user_id', user.id)
      .eq('quiz_passed', true)
    completedModuleIds = (progress ?? []).map(p => p.module_id)

    const { data: sub } = await db
      .from('subscriptions')
      .select('status')
      .eq('user_id', user.id)
      .eq('status', 'active')
      .single()
    isPro = !!sub

    const { data: enrollment } = await db
      .from('course_enrollments')
      .select('id')
      .eq('user_id', user.id)
      .eq('course_id', course.id)
      .single()
    isEnrolled = !!enrollment
  }

  // Design tokens
  const category = courseWithPath.path?.category ?? 'AI'
  const [gradFrom, gradTo] = CATEGORY_GRADIENTS[category] ?? CATEGORY_GRADIENTS.AI
  const categoryEmojis = CATEGORY_EMOJIS[category] ?? CATEGORY_EMOJIS.AI
  const courseEmoji = categoryEmojis[course.order_index % categoryEmojis.length] ?? '📚'

  const rating = course.rating ?? 4.8
  const reviewsCount = course.reviews_count ?? 0
  const enrolledCount = course.enrolled_count ?? 0
  const levelLabel = LEVEL_LABELS[course.level ?? 'beginner'] ?? 'Beginner'
  const firstLevel = levels[0]
  const startHref = firstLevel ? `/learn/${course.slug}/${firstLevel.id}` : '#'

  const updatedDate = course.last_updated_at
    ? new Date(course.last_updated_at).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
    : 'Recent'

  const faqs = courseDefaultFaqs(course.title, courseWithPath.path?.name)
  const courseSchema = courseJsonLd({
    title: course.title,
    slug: course.slug,
    description: course.description ?? course.short_description,
    category,
    pathName: courseWithPath.path?.name,
    totalLessons,
    totalHours: Number(computedHours) || undefined,
    level: levelLabel,
    instructorName: course.instructor_name,
    rating,
    reviewsCount,
    enrolledCount,
    lastUpdated: course.last_updated_at,
    skills: course.skills_gained,
  })
  const crumbs = breadcrumbJsonLd([
    { name: 'Home', url: '/' },
    { name: 'Courses', url: '/courses' },
    ...(courseWithPath.path
      ? [{ name: courseWithPath.path.name, url: `/paths/${courseWithPath.path.slug}` }]
      : []),
    { name: course.title, url: `/courses/${course.slug}` },
  ])
  const faqSchema = faqJsonLd(faqs)

  // "What you'll learn" — prefer skills_gained, fall back to module titles
  const learnItems: string[] = course.skills_gained?.length
    ? course.skills_gained
    : levels.map((l: { title: string }) => l.title).filter(Boolean).slice(0, 8)

  // First lesson YouTube thumbnail — used as course card visual
  const firstVideoId = levels[0]?.lessons?.slice().sort((a, b) => (a.order_index ?? 0) - (b.order_index ?? 0))[0]?.youtube_video_id ?? null
  const courseThumbnail = firstVideoId ? `https://img.youtube.com/vi/${firstVideoId}/hqdefault.jpg` : null

  // "Who this is for" — structured icon cards
  type WhoCard = { icon: string; title: string; body: string }
  const WHO_FOR: Record<string, WhoCard[]> = {
    AI: [
      { icon: '🤖', title: 'Builders',        body: 'who want to ship AI products, not just talk about them' },
      { icon: '📦', title: 'PMs & founders',  body: 'adding AI features to their product roadmap' },
      { icon: '🔧', title: 'Engineers',       body: 'moving into AI product or solutions roles' },
      { icon: '🎯', title: 'Curious learners',body: 'tired of AI hype and ready to actually build' },
    ],
    Design: [
      { icon: '🎨', title: 'Aspiring designers', body: 'starting from zero, no design background needed' },
      { icon: '💻', title: 'Developers',         body: 'who want to design and ship their own interfaces' },
      { icon: '📋', title: 'Product managers',   body: 'who need to communicate fluently with design teams' },
      { icon: '🚀', title: 'Career-switchers',   body: 'targeting UX or product design roles' },
    ],
    Product: [
      { icon: '📋', title: 'Aspiring PMs',    body: 'who want real frameworks, not just theory' },
      { icon: '🔧', title: 'Engineers',       body: 'transitioning into product management' },
      { icon: '🏗️', title: 'Founders',       body: 'building their first 0-to-1 product' },
      { icon: '💡', title: 'Practitioners',  body: 'who want to level up their product craft' },
    ],
    Marketing: [
      { icon: '🚀', title: 'Founders',        body: 'running their own growth and acquisition' },
      { icon: '📈', title: 'Marketers',       body: 'levelling up from execution to strategy' },
      { icon: '✍️', title: 'Content creators',body: 'moving into performance marketing roles' },
      { icon: '📊', title: 'PMs',             body: 'who own growth and retention metrics' },
    ],
    Data: [
      { icon: '📊', title: 'Analysts',       body: 'moving from spreadsheets to SQL and Python' },
      { icon: '💻', title: 'PMs',            body: 'who want to own and interpret their own data' },
      { icon: '🔄', title: 'Career-switchers',body: 'targeting data analyst or BI roles' },
      { icon: '🏢', title: 'Business teams', body: 'building intuition around metrics and dashboards' },
    ],
  }
  const whoFor: WhoCard[] = WHO_FOR[category] ?? WHO_FOR.AI

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      <script {...jsonLdScriptProps(courseSchema)} />
      <script {...jsonLdScriptProps(crumbs)} />
      <script {...jsonLdScriptProps(faqSchema)} />
      <link rel="canonical" href={absoluteUrl(`/courses/${course.slug}`)} />

      <div className="course-layout">
        {/* ====== HERO BACKGROUND ====== */}
        <div className="hero-bg" style={{ background: 'var(--surface)', borderBottom: '1px solid var(--border)' }} />

        {/* ====== HERO CONTENT ====== */}
        <div className="hero-content">
          {/* Breadcrumb */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: '1.25rem', flexWrap: 'wrap' }}>
            <Link href="/courses" style={{ color: 'var(--text-muted)', textDecoration: 'none' }}>Courses</Link>
            <span>›</span>
            {courseWithPath.path && (
              <>
                <Link href={`/paths/${courseWithPath.path.slug}`} style={{ color: 'var(--text-muted)', textDecoration: 'none' }}>
                  {courseWithPath.path.name}
                </Link>
                <span>›</span>
              </>
            )}
            <span style={{ color: 'var(--cream)' }}>{course.title}</span>
          </div>

          {/* Category badge */}
          <div style={{ marginBottom: '0.75rem' }}>
            <span style={{
              fontSize: '0.72rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em',
              color: gradFrom, background: `${gradFrom}18`, border: `1px solid ${gradFrom}40`,
              borderRadius: 999, padding: '0.25rem 0.7rem',
            }}>
              {category}
            </span>
          </div>

          {/* Title */}
          <h1 style={{ fontSize: 'clamp(1.75rem, 3.5vw, 2.6rem)', fontWeight: 700, color: 'var(--cream)', lineHeight: 1.15, marginBottom: '0.875rem' }}>
            {course.title}
          </h1>

          {/* Description */}
          <p style={{ color: 'var(--text-muted)', fontSize: '1.05rem', lineHeight: 1.65, marginBottom: '1.25rem', maxWidth: 620 }}>
            {course.short_description ?? course.description}
          </p>

          {/* Social proof row */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1rem', alignItems: 'center', marginBottom: '1.5rem', fontSize: '0.875rem' }}>
            <span style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', color: '#F5C842', fontWeight: 600 }}>
              ★★★★★
              <span style={{ color: 'var(--text-muted)', fontWeight: 400 }}>4.8</span>
            </span>
            {enrolledCount > 0 && (
              <>
                <span style={{ color: 'var(--border)' }}>·</span>
                <span style={{ color: 'var(--text-muted)' }}>
                  <span style={{ color: 'var(--cream)', fontWeight: 600 }}>
                    {enrolledCount >= 1000 ? `${Math.floor(enrolledCount / 1000)}K+` : enrolledCount}
                  </span>{' '}enrolled
                </span>
              </>
            )}
            <span style={{ color: 'var(--border)' }}>·</span>
            <span style={{ color: 'var(--text-muted)' }}>{levelLabel}</span>
            <span style={{ color: 'var(--border)' }}>·</span>
            <span style={{ color: 'var(--text-muted)' }}>{computedHours}h{totalLessons > 0 ? ` · ${totalLessons} lessons` : ''}</span>
            <span style={{ color: 'var(--border)' }}>·</span>
            <span style={{ color: 'var(--text-muted)' }}>Updated {updatedDate}</span>
          </div>

          {/* Quick-win highlights */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem', marginBottom: '1.75rem' }}>
            {[
              '✓ Free to start',
              course.certificate_enabled ? '✓ Certificate included' : '✓ Self-paced',
              '✓ No prerequisites',
              '✓ Quizzes to confirm learning',
            ].map(h => (
              <span key={h} style={{
                fontSize: '0.82rem', color: 'var(--cream)', background: `${gradFrom}15`,
                border: `1px solid ${gradFrom}30`, borderRadius: 6, padding: '0.3rem 0.7rem',
              }}>
                {h}
              </span>
            ))}
          </div>

          {/* Primary CTA */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', flexWrap: 'wrap' }}>
            <CourseEnrollButton
              courseId={course.id}
              courseSlug={course.slug}
              isEnrolled={isEnrolled}
              isLoggedIn={!!user}
              startHref={startHref}
            />
            <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}>
              {isEnrolled ? 'Pick up where you left off' : 'Free forever · No credit card'}
            </span>
          </div>

          {/* Company logos anchored to hero */}
          <div style={{ marginTop: '2rem', paddingTop: '1.5rem', borderTop: '1px solid var(--border)' }}>
            <p style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginBottom: '0.875rem', textTransform: 'uppercase', letterSpacing: '0.08em' }}>
              Learners from
            </p>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.6rem', alignItems: 'center' }}>
              {COMPANY_LOGOS.map(logo => (
                <div key={logo.domain} style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', padding: '0.35rem 0.7rem', background: 'var(--ink)', border: '1px solid var(--border)', borderRadius: 8 }}>
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  <img
                    src={`https://www.google.com/s2/favicons?domain=${logo.domain}&sz=32`}
                    width={14}
                    height={14}
                    alt={logo.name}
                    style={{ borderRadius: 3, flexShrink: 0 }}
                  />
                  <span style={{ fontSize: '0.78rem', fontWeight: 600, color: 'var(--text-muted)', letterSpacing: '0.02em' }}>{logo.name}</span>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* ====== RIGHT COLUMN (STICKY) ====== */}
        <div className="right-column">
          <div style={{ position: 'sticky', top: '2rem', display: 'flex', flexDirection: 'column', gap: '1rem', paddingBottom: '3rem' }}>

            {/* Course card */}
            <div style={{ background: 'var(--ink)', border: '1px solid var(--border)', borderRadius: 16, overflow: 'hidden' }}>
              {/* Visual — YouTube thumbnail if available, gradient fallback */}
              <div style={{ height: 192, position: 'relative', overflow: 'hidden', background: `linear-gradient(135deg, ${gradFrom}30, ${gradTo}50)` }}>
                {courseThumbnail ? (
                  <>
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={courseThumbnail}
                      alt={course.title}
                      style={{ width: '100%', height: '100%', objectFit: 'cover', display: 'block' }}
                    />
                    {/* gradient overlay so text is legible */}
                    <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(to top, rgba(0,0,0,0.72) 40%, transparent 100%)' }} />
                  </>
                ) : (
                  <>
                    <div style={{ position: 'absolute', top: -24, right: -24, width: 110, height: 110, borderRadius: '50%', background: `${gradTo}25` }} />
                    <div style={{ position: 'absolute', bottom: -18, left: 10, width: 80, height: 80, borderRadius: '50%', background: `${gradFrom}18` }} />
                  </>
                )}
                {/* Category + emoji badge always shown */}
                <div style={{ position: 'absolute', bottom: '0.875rem', left: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                  <span style={{ fontSize: '1.4rem' }}>{courseEmoji}</span>
                  <span style={{ fontSize: '0.65rem', color: 'rgba(255,255,255,0.85)', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em', background: 'rgba(0,0,0,0.35)', padding: '0.2rem 0.45rem', borderRadius: 4 }}>
                    {category}
                  </span>
                </div>
              </div>

              <div style={{ padding: '1.25rem' }}>
                {/* Price clarity */}
                <div style={{ display: 'flex', alignItems: 'baseline', gap: '0.5rem', marginBottom: '0.25rem' }}>
                  <span style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--cream)' }}>Free</span>
                  <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}>to start</span>
                </div>
                <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', lineHeight: 1.4, marginBottom: '1rem' }}>
                  Certificate unlocked with Pro. Cancel anytime.
                </p>

                <CourseEnrollButton
                  courseId={course.id}
                  courseSlug={course.slug}
                  isEnrolled={isEnrolled}
                  isLoggedIn={!!user}
                  startHref={startHref}
                  variant="secondary"
                />

                {/* What's included */}
                <div style={{ marginTop: '1rem', display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                  {[
                    { icon: '📚', text: `${totalLessons} lessons · ${computedHours}h total` },
                    { icon: '✅', text: 'Quizzes after each module' },
                    { icon: '🔖', text: 'Bookmark lessons for later' },
                    { icon: '🏆', text: course.certificate_enabled ? 'Certificate of completion' : 'Self-paced, no deadline' },
                    { icon: '⚡', text: 'XP + streak tracking' },
                  ].map(item => (
                    <div key={item.text} style={{ display: 'flex', gap: '0.5rem', alignItems: 'center', fontSize: '0.82rem', color: 'var(--text-muted)' }}>
                      <span style={{ fontSize: '0.9rem', width: 18, flexShrink: 0 }}>{item.icon}</span>
                      <span>{item.text}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* Individual / Team toggle */}
            <div style={{ background: 'var(--ink)', border: '1px solid var(--border)', borderRadius: 14, padding: '1rem' }}>
              <div style={{ display: 'flex', gap: 0, marginBottom: '0.875rem', background: 'var(--surface)', borderRadius: 8, padding: '0.18rem' }}>
                <div style={{ flex: 1, textAlign: 'center', padding: '0.38rem', borderRadius: 6, fontSize: '0.8rem', fontWeight: 600, color: 'var(--cream)', background: 'var(--ink)', border: '1px solid var(--border)' }}>
                  Individual
                </div>
                <Link href="/teams" style={{ flex: 1, textAlign: 'center', padding: '0.38rem', borderRadius: 6, fontSize: '0.8rem', fontWeight: 400, color: 'var(--text-muted)', textDecoration: 'none' }}>
                  Team →
                </Link>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.45rem', marginBottom: '0.875rem' }}>
                {['Unlock all courses', 'Industry-recognized certificate', 'Full career path', 'Priority support'].map(f => (
                  <div key={f} style={{ display: 'flex', gap: '0.4rem', alignItems: 'center', fontSize: '0.81rem', color: 'var(--text-muted)' }}>
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#34D399" strokeWidth="2.5"><polyline points="20 6 9 17 4 12"/></svg>
                    {f}
                  </div>
                ))}
              </div>
              <Link href="/upgrade" style={{ display: 'block', textAlign: 'center', background: 'var(--accent)', color: 'var(--ink)', fontWeight: 700, fontSize: '0.88rem', padding: '0.65rem', borderRadius: 9, textDecoration: 'none' }}>
                Upgrade to Pro
              </Link>
            </div>

            {/* Related courses */}
            {related && related.length > 0 && (
              <div>
                <h3 style={{ fontSize: '0.88rem', fontWeight: 700, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.75rem' }}>Up next in this path</h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
                  {related.map((rc, ri) => {
                    const rEmojis = CATEGORY_EMOJIS[category] ?? CATEGORY_EMOJIS.AI
                    return (
                      <Link key={rc.id} href={`/courses/${rc.slug}`} style={{ textDecoration: 'none' }}>
                        <div className="related-card-sm" style={{ display: 'flex', gap: '0.65rem', padding: '0.65rem', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 10, alignItems: 'center' }}>
                          <div style={{ width: 38, height: 38, borderRadius: 8, background: `linear-gradient(135deg, ${gradFrom}25, ${gradTo}40)`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.1rem', flexShrink: 0 }}>
                            {rEmojis[(ri + 2) % rEmojis.length]}
                          </div>
                          <div style={{ flex: 1, minWidth: 0 }}>
                            <div style={{ fontSize: '0.82rem', fontWeight: 600, color: 'var(--cream)', lineHeight: 1.3, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{rc.title}</div>
                            <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.1rem' }}>
                              {LEVEL_LABELS[rc.level ?? 'beginner']}
                              {rc.duration_hours && ` · ${Number(rc.duration_hours).toFixed(0)}h`}
                            </div>
                          </div>
                        </div>
                      </Link>
                    )
                  })}
                </div>
              </div>
            )}
          </div>
        </div>

        {/* ====== MAIN CONTENT ====== */}
        <div className="main-content">

          {/* 1. WHAT YOU'LL LEARN */}
          {learnItems.length > 0 && (
            <section style={{ marginBottom: '2.5rem', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 16, padding: '1.75rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.25rem' }}>
                What you&apos;ll learn
              </h2>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '0.6rem' }}>
                {learnItems.map((item: string, i: number) => (
                  <div key={i} style={{ display: 'flex', gap: '0.6rem', alignItems: 'flex-start' }}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#34D399" strokeWidth="2.5" style={{ flexShrink: 0, marginTop: '0.2rem' }}>
                      <polyline points="20 6 9 17 4 12"/>
                    </svg>
                    <span style={{ color: 'var(--cream)', fontSize: '0.9rem', lineHeight: 1.5 }}>{item}</span>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* 2. WHO THIS IS FOR — visual icon cards */}
          <section style={{ marginBottom: '2.5rem' }}>
            <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>
              Who this course is for
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '0.75rem' }}>
              {whoFor.map((w, i) => (
                <div key={i} style={{ display: 'flex', gap: '0.875rem', alignItems: 'flex-start', padding: '1rem', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 12 }}>
                  <div style={{ width: 36, height: 36, borderRadius: 10, background: `linear-gradient(135deg, ${gradFrom}20, ${gradTo}35)`, border: `1px solid ${gradFrom}30`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.1rem', flexShrink: 0 }}>
                    {w.icon}
                  </div>
                  <div>
                    <div style={{ fontSize: '0.88rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.2rem' }}>{w.title}</div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', lineHeight: 1.45 }}>{w.body}</div>
                  </div>
                </div>
              ))}
            </div>
          </section>

          {/* 3. COURSE CONTENT */}
          <section style={{ marginBottom: '2.5rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', marginBottom: '1rem', flexWrap: 'wrap', gap: '0.5rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)' }}>
                Course content
              </h2>
              {(levels.length > 0 || totalLessons > 0) && (
                <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)' }}>
                  {levels.length > 0 && `${levels.length} modules`}{totalLessons > 0 && ` · ${totalLessons} lessons`}{Number(computedHours) > 0 && ` · ${computedHours}h`}
                </span>
              )}
            </div>
            <CourseSyllabus
              levels={levels}
              courseSlug={course.slug}
              isPro={isPro}
              isLoggedIn={!!user}
              completedModuleIds={completedModuleIds}
            />
          </section>

          {/* 5. TAUGHT BY (creators — Claude course only) */}
          {course.slug === 'master-claude-ai-zero-to-pro' && (
            <section style={{ marginBottom: '2.5rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.4rem' }}>
                Taught by expert creators
              </h2>
              <p style={{ color: 'var(--text-muted)', fontSize: '0.88rem', marginBottom: '1.25rem' }}>
                Curated from top YouTube educators — best practitioners working in AI today.
              </p>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '0.75rem' }}>
                {(contributingCreators as Array<{ name: string; channelUrl: string; avatar: string; subscribers: string; featuredIn: string[] }>).map((creator) => (
                  <a key={creator.channelUrl} href={creator.channelUrl} target="_blank" rel="noopener noreferrer" style={{ textDecoration: 'none' }} className="creator-card">
                    <div style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 12, padding: '0.875rem', display: 'flex', alignItems: 'center', gap: '0.75rem', transition: 'border-color 0.15s' }}>
                      <div style={{ width: 40, height: 40, borderRadius: '50%', overflow: 'hidden', flexShrink: 0, border: '2px solid var(--border)', background: `linear-gradient(135deg, ${gradFrom}50, ${gradTo}50)`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1rem', color: 'white', fontWeight: 700 }}>
                        {creator.name.charAt(0)}
                      </div>
                      <div style={{ minWidth: 0 }}>
                        <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--cream)', lineHeight: 1.3, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{creator.name}</div>
                        <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)', marginTop: '0.1rem' }}>{creator.subscribers} · {creator.featuredIn.length} lesson{creator.featuredIn.length !== 1 ? 's' : ''}</div>
                      </div>
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="#FF0000" style={{ flexShrink: 0, marginLeft: 'auto', opacity: 0.75 }}>
                        <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                      </svg>
                    </div>
                  </a>
                ))}
              </div>
            </section>
          )}

          {/* 6. REVIEWS — always shown */}
          <section style={{ marginBottom: '2.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.25rem', flexWrap: 'wrap' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)' }}>Learner reviews</h2>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', fontSize: '0.88rem' }}>
                <span style={{ color: '#F5C842' }}>★★★★★</span>
                <span style={{ color: 'var(--cream)', fontWeight: 600 }}>4.8</span>
                <span style={{ color: 'var(--text-muted)' }}>course rating</span>
              </div>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
              {SAMPLE_REVIEWS.map((review, i) => (
                <div key={i} style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 14, padding: '1.25rem' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem', marginBottom: '0.75rem' }}>
                    <div style={{ width: 34, height: 34, borderRadius: '50%', background: `linear-gradient(135deg, ${gradFrom}80, ${gradTo}80)`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, color: 'white', fontSize: '0.88rem', flexShrink: 0 }}>
                      {review.name.charAt(0)}
                    </div>
                    <div>
                      <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--cream)' }}>{review.name}</div>
                      <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>{review.role}</div>
                    </div>
                    <div style={{ marginLeft: 'auto', color: '#F5C842', fontSize: '0.78rem' }}>{'★'.repeat(review.rating)}</div>
                  </div>
                  <p style={{ color: 'var(--text-muted)', fontSize: '0.84rem', lineHeight: 1.6 }}>{review.text}</p>
                </div>
              ))}
            </div>
          </section>

          {/* 8. CERTIFICATE */}
          {course.certificate_enabled && (
            <section style={{ marginBottom: '2.5rem', background: `linear-gradient(135deg, ${gradFrom}12, ${gradTo}08)`, border: `1px solid ${gradFrom}30`, borderRadius: 16, padding: '2rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>
                Earn a certificate of completion
              </h2>
              <div style={{ display: 'flex', gap: '1.25rem', alignItems: 'center', background: 'rgba(0,0,0,0.2)', border: '1px solid var(--border)', borderRadius: 12, padding: '1.25rem', marginBottom: '1.25rem' }}>
                <div style={{ width: 56, height: 56, borderRadius: 14, background: `linear-gradient(135deg, ${gradFrom}, ${gradTo})`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem', flexShrink: 0 }}>
                  {courseEmoji}
                </div>
                <div>
                  <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '0.2rem' }}>VibeLearn Certificate</div>
                  <div style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.15rem' }}>{course.title}</div>
                  <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>Issued upon completion · Add to LinkedIn</div>
                </div>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
                {[
                  { icon: '✅', text: 'Validate your skills — industry-recognized, shows hours completed' },
                  { icon: '🏅', text: 'Yours forever — never expires, unlike your subscription' },
                  { icon: '🚀', text: 'Shareable on LinkedIn, CV, portfolio, and your VibeLearn profile' },
                ].map((item, i) => (
                  <div key={i} style={{ display: 'flex', gap: '0.6rem', alignItems: 'flex-start' }}>
                    <span style={{ fontSize: '0.95rem', flexShrink: 0 }}>{item.icon}</span>
                    <span style={{ color: 'var(--text-muted)', fontSize: '0.88rem', lineHeight: 1.55 }}>{item.text}</span>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* 9. FOR TEAMS */}
          <section style={{ marginBottom: '2.5rem', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 16, padding: '2rem' }}>
            <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '0.4rem' }}>For Teams</div>
            <h2 style={{ fontSize: '1.2rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.6rem' }}>
              Train your whole team on {course.title}
            </h2>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.6, marginBottom: '1rem', maxWidth: 560 }}>
              Bulk seats, manager dashboards, skill-gap reports, SSO, and shareable certificates — from $19/seat/mo.
            </p>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.6rem', marginBottom: '1rem' }}>
              {['👥 Bulk seats & SSO', '📊 Manager dashboard', '🎯 Skill-gap reports', '🏆 Team certificates'].map(b => (
                <span key={b} style={{ fontSize: '0.82rem', color: 'var(--cream)', background: 'var(--ink)', border: '1px solid var(--border)', borderRadius: 6, padding: '0.3rem 0.6rem' }}>{b}</span>
              ))}
            </div>
            <div style={{ display: 'flex', gap: '0.6rem', flexWrap: 'wrap' }}>
              <Link href="/teams" style={{ background: 'var(--accent)', color: 'var(--ink)', fontWeight: 700, fontSize: '0.88rem', padding: '0.65rem 1.1rem', borderRadius: 9, textDecoration: 'none' }}>
                Talk to sales
              </Link>
              <Link href="/teams" style={{ background: 'transparent', color: 'var(--cream)', fontWeight: 600, fontSize: '0.88rem', padding: '0.65rem 1.1rem', borderRadius: 9, textDecoration: 'none', border: '1px solid var(--border)' }}>
                See team pricing →
              </Link>
            </div>
          </section>

          {/* 10. FAQ */}
          <section style={{ marginBottom: '2.5rem' }}>
            <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>
              Frequently asked questions
            </h2>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
              {faqs.map((f, i) => (
                <details key={i} open={i === 0} style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 11, padding: '0.9rem 1.1rem' }}>
                  <summary style={{ fontSize: '0.92rem', fontWeight: 600, color: 'var(--cream)', cursor: 'pointer', listStyle: 'none' }}>
                    {f.q}
                  </summary>
                  <p style={{ color: 'var(--text-muted)', fontSize: '0.88rem', lineHeight: 1.65, marginTop: '0.65rem' }}>{f.a}</p>
                </details>
              ))}
            </div>
          </section>
        </div>
      </div>

      {/* ====== BOTTOM CTA ====== */}
      <section style={{ background: 'var(--cream)', padding: '3rem 1.5rem', textAlign: 'center' }}>
        <div style={{ maxWidth: 640, margin: '0 auto' }}>
          <div style={{ fontSize: '0.75rem', fontWeight: 700, color: `${gradFrom}`, textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '0.75rem' }}>
            {course.certificate_enabled ? 'Free course · Pro certificate' : 'Free course'}
          </div>
          <h2 style={{ fontSize: 'clamp(1.4rem, 3vw, 2rem)', fontWeight: 700, color: 'var(--ink)', lineHeight: 1.2, marginBottom: '0.75rem' }}>
            Start <span style={{ textDecoration: 'underline', textDecorationThickness: 2 }}>{course.title}</span> today — free.
          </h2>
          <p style={{ color: 'var(--ink)', opacity: 0.65, fontSize: '0.95rem', marginBottom: '1.5rem' }}>
            {enrolledCount > 0
              ? `Join ${enrolledCount >= 1000 ? `${Math.floor(enrolledCount / 1000)}K+` : enrolledCount} learners. `
              : ''}
            No credit card. Cancel anytime.
          </p>
          <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'center', flexWrap: 'wrap' }}>
            <CourseEnrollButton courseId={course.id} courseSlug={course.slug} isEnrolled={isEnrolled} isLoggedIn={!!user} startHref={startHref} variant="primary" />
            <Link href="/upgrade" style={{ background: 'transparent', color: 'var(--ink)', fontWeight: 600, fontSize: '0.95rem', padding: '0.8rem 1.5rem', borderRadius: 10, textDecoration: 'none', border: '2px solid var(--ink)' }}>
              Get Pro + Certificate →
            </Link>
          </div>
        </div>
      </section>

      {/* ====== RELATED COURSES ====== */}
      {related && related.length > 0 && (
        <section style={{ padding: '3rem 1.5rem', background: 'var(--surface)', borderTop: '1px solid var(--border)' }}>
          <div style={{ maxWidth: 1200, margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem' }}>
              <h2 style={{ fontSize: '1.2rem', fontWeight: 700, color: 'var(--cream)' }}>Continue learning</h2>
              <Link href="/courses" style={{ fontSize: '0.85rem', color: 'var(--accent)', textDecoration: 'none', fontWeight: 600 }}>Show all →</Link>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '1rem' }}>
              {related.map((rc, ri) => {
                const rEmojis = CATEGORY_EMOJIS[category] ?? CATEGORY_EMOJIS.AI
                return (
                  <Link key={rc.id} href={`/courses/${rc.slug}`} style={{ textDecoration: 'none' }}>
                    <div className="related-card" style={{ background: 'var(--ink)', border: '1px solid var(--border)', borderRadius: 14, overflow: 'hidden' }}>
                      <div style={{ height: 100, background: `linear-gradient(135deg, ${gradFrom}18, ${gradTo}35)`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2.25rem' }}>
                        {rEmojis[(ri + 3) % rEmojis.length]}
                      </div>
                      <div style={{ padding: '0.875rem' }}>
                        <div style={{ fontSize: '0.88rem', fontWeight: 600, color: 'var(--cream)', lineHeight: 1.4, marginBottom: '0.35rem' }}>{rc.title}</div>
                        <div style={{ fontSize: '0.76rem', color: 'var(--text-muted)' }}>
                          {LEVEL_LABELS[rc.level ?? 'beginner']}
                          {rc.duration_hours && ` · ${Number(rc.duration_hours).toFixed(0)}h`}
                        </div>
                      </div>
                    </div>
                  </Link>
                )
              })}
            </div>
          </div>
        </section>
      )}

      <style>{`
        .course-layout {
          display: grid;
          grid-template-columns: minmax(1.5rem, 1fr) minmax(0, calc(1200px - 360px - 3rem)) 360px minmax(1.5rem, 1fr);
          grid-template-rows: auto 1fr;
          column-gap: 3rem;
        }
        .hero-bg { grid-column: 1 / -1; grid-row: 1; }
        .hero-content { grid-column: 2; grid-row: 1; padding: 3rem 0; }
        .main-content { grid-column: 2; grid-row: 2; padding: 2rem 0 3rem; }
        .right-column { grid-column: 3; grid-row: 1 / 3; padding: 3rem 0; }

        @media (max-width: 1024px) {
          .course-layout {
            grid-template-columns: 1.5rem 1fr 1.5rem;
            grid-template-rows: auto auto auto;
            column-gap: 0;
          }
          .hero-bg { grid-column: 1 / -1; grid-row: 1; }
          .hero-content { grid-column: 2; grid-row: 1; padding: 2rem 0; }
          .right-column { grid-column: 2; grid-row: 2; padding: 0 0 1.5rem; }
          .main-content { grid-column: 2; grid-row: 3; padding: 0 0 2rem; }
        }

        details summary::-webkit-details-marker { display: none; }
        details summary::after { content: '+'; float: right; color: var(--text-muted); font-size: 1rem; }
        details[open] summary::after { content: '−'; }

        .related-card { transition: transform 0.18s, box-shadow 0.18s; }
        .related-card:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
        .related-card-sm { transition: border-color 0.12s; }
        .related-card-sm:hover { border-color: var(--cream) !important; }
        .creator-card div { transition: border-color 0.12s; }
        .creator-card:hover div { border-color: var(--cream) !important; }
      `}</style>
    </div>
  )
}
