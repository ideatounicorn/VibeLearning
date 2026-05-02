import { notFound } from 'next/navigation'
import Link from 'next/link'
import { supabaseServer } from '@/lib/supabase-server'
import CourseSyllabus from '@/components/courses/CourseSyllabus'
import CourseEnrollButton from '@/components/courses/CourseEnrollButton'

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

const COMPANY_LOGOS = ['Deloitte', 'Dropbox', 'TikTok', 'Paypal', 'Unicef', 'IBM', 'Firestone']

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
  return {
    title: `${slug.replace(/-/g, ' ')} — VibeLearn`,
    description: `Learn ${slug.replace(/-/g, ' ')} with expert-curated content.`,
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

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      <div className="course-layout">
        {/* ====== HERO BACKGROUND ====== */}
        <div className="hero-bg" style={{ background: 'var(--surface)', borderBottom: '1px solid var(--border)' }} />

        {/* ====== HERO CONTENT ====== */}
        <div className="hero-content">
          {/* Breadcrumb */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '1.5rem', flexWrap: 'wrap' }}>
            <Link href="/courses" style={{ color: 'var(--text-muted)', textDecoration: 'none' }}>Courses</Link>
            <span>/</span>
            {courseWithPath.path && (
              <>
                <Link href={`/paths/${courseWithPath.path?.slug}`} style={{ color: 'var(--text-muted)', textDecoration: 'none' }}>
                  {courseWithPath.path?.name}
                </Link>
                <span>/</span>
              </>
            )}
            <span style={{ color: 'var(--cream)' }}>{course.title}</span>
          </div>

          <h1 style={{ fontSize: 'clamp(1.6rem, 3.5vw, 2.5rem)', fontWeight: 700, color: 'var(--cream)', lineHeight: 1.2, marginBottom: '1rem' }}>
            {course.title}
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '1rem', lineHeight: 1.65, marginBottom: '1.5rem' }}>
            {course.short_description ?? course.description}
          </p>

          {/* Stats row */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1.5rem', marginBottom: '1rem', fontSize: '0.88rem', color: 'var(--text-muted)' }}>
            {enrolledCount > 0 && (
              <span>
                <span style={{ color: 'var(--cream)', fontWeight: 600 }}>
                  {enrolledCount >= 1000 ? `${(enrolledCount / 1000).toFixed(0)},${String(enrolledCount).slice(-3)}` : enrolledCount}
                </span>{' '}learners
              </span>
            )}
            {rating > 0 && reviewsCount > 0 && (
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                <span style={{ color: '#F5C842', fontWeight: 600 }}>★ {rating}</span>
                <span>({reviewsCount} reviews)</span>
              </span>
            )}
            <span>Updated {updatedDate}</span>
          </div>

          {/* Tags */}
          {course.tags && course.tags.length > 0 && (
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.4rem', marginBottom: '2rem' }}>
              {course.tags.map((tag: string) => (
                <span key={tag} style={{
                  fontSize: '0.78rem',
                  color: 'var(--text-muted)',
                  background: 'var(--ink)',
                  border: '1px solid var(--border)',
                  borderRadius: 6,
                  padding: '0.25rem 0.6rem',
                }}>#{tag}</span>
              ))}
            </div>
          )}

          {/* CTA */}
          <CourseEnrollButton
            courseId={course.id}
            courseSlug={course.slug}
            isEnrolled={isEnrolled}
            isLoggedIn={!!user}
            startHref={startHref}
          />
        </div>

        {/* ====== RIGHT COLUMN (STICKY) ====== */}
        <div className="right-column">
          <div style={{ position: 'sticky', top: '2rem', display: 'flex', flexDirection: 'column', gap: '1.25rem', paddingBottom: '3rem' }}>
            {/* Certificate card */}
            <div style={{
              background: 'var(--ink)',
              border: '1px solid var(--border)',
              borderRadius: 16,
              overflow: 'hidden',
            }}>
              {/* Thumbnail */}
              <div style={{
                height: 160,
                background: `linear-gradient(135deg, ${gradFrom}25, ${gradTo}45)`,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                position: 'relative',
                overflow: 'hidden',
              }}>
                <div style={{ position: 'absolute', top: -20, right: -20, width: 100, height: 100, borderRadius: '50%', background: `${gradTo}30` }} />
                <div style={{ position: 'absolute', bottom: -15, left: 8, width: 70, height: 70, borderRadius: '50%', background: `${gradFrom}20` }} />
                <div style={{ position: 'relative', zIndex: 1, textAlign: 'center' }}>
                  <div style={{ fontSize: '3rem', marginBottom: '0.25rem' }}>{courseEmoji}</div>
                  <div style={{ fontSize: '0.7rem', color: 'rgba(255,255,255,0.7)', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Certificate</div>
                </div>
              </div>

              <div style={{ padding: '1.25rem' }}>
                <h3 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.35rem' }}>
                  Earn your course certificate
                </h3>
                <p style={{ fontSize: '0.82rem', color: 'var(--text-muted)', lineHeight: 1.5, marginBottom: '1rem' }}>
                  Complete this course and show your expertise with a shareable certificate.
                </p>
                <CourseEnrollButton
                  courseId={course.id}
                  courseSlug={course.slug}
                  isEnrolled={isEnrolled}
                  isLoggedIn={!!user}
                  startHref={startHref}
                  variant="secondary"
                />
                {/* Rating */}
                {reviewsCount > 0 && (
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.3rem', fontSize: '0.82rem', color: 'var(--text-muted)', marginTop: '0.75rem' }}>
                    <span style={{ color: '#F5C842' }}>{'★'.repeat(Math.round(rating))}{'☆'.repeat(5 - Math.round(rating))}</span>
                    <span>{rating} ({reviewsCount})</span>
                  </div>
                )}
              </div>
            </div>

            {/* Upgrade to teams card */}
            <div style={{
              background: 'var(--ink)',
              border: '1px solid var(--border)',
              borderRadius: 16,
              padding: '1.25rem',
            }}>
              {/* Tab selector */}
              <div style={{ display: 'flex', gap: '0', marginBottom: '1rem', background: 'var(--surface)', borderRadius: 8, padding: '0.2rem' }}>
                {['Individual', 'Team'].map(tab => (
                  <div key={tab} style={{
                    flex: 1,
                    textAlign: 'center',
                    padding: '0.4rem',
                    borderRadius: 6,
                    fontSize: '0.82rem',
                    fontWeight: tab === 'Individual' ? 600 : 400,
                    color: tab === 'Individual' ? 'var(--cream)' : 'var(--text-muted)',
                    background: tab === 'Individual' ? 'var(--ink)' : 'transparent',
                    cursor: 'pointer',
                    border: tab === 'Individual' ? '1px solid var(--border)' : 'none',
                  }}>
                    {tab}
                  </div>
                ))}
              </div>

              <h4 style={{ fontSize: '0.95rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.75rem' }}>
                Get full access with Pro
              </h4>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', marginBottom: '1rem' }}>
                {[
                  'All expert-created courses',
                  'Industry-recognized certificates',
                  'Career path plans & more',
                ].map(item => (
                  <div key={item} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.83rem', color: 'var(--text-muted)' }}>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#34D399" strokeWidth="2.5">
                      <polyline points="20 6 9 17 4 12"/>
                    </svg>
                    {item}
                  </div>
                ))}
              </div>
              <Link
                href="/upgrade"
                style={{
                  display: 'block',
                  textAlign: 'center',
                  background: 'var(--accent)',
                  color: 'var(--ink)',
                  fontWeight: 700,
                  fontSize: '0.9rem',
                  padding: '0.7rem',
                  borderRadius: 10,
                  textDecoration: 'none',
                }}
              >
                Upgrade now
              </Link>
            </div>

            {/* Related courses */}
            {related && related.length > 0 && (
              <div style={{ marginTop: '0.5rem' }}>
                <h3 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>Related courses</h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                  {related.map((rc, ri) => {
                    const [rg1, rg2] = CATEGORY_GRADIENTS[category] ?? CATEGORY_GRADIENTS.AI
                    const rEmojis = CATEGORY_EMOJIS[category] ?? CATEGORY_EMOJIS.AI
                    return (
                      <Link key={rc.id} href={`/courses/${rc.slug}`} style={{ textDecoration: 'none' }}>
                        <div className="related-card-sm" style={{
                          display: 'flex',
                          gap: '0.75rem',
                          padding: '0.75rem',
                          background: 'var(--surface)',
                          border: '1px solid var(--border)',
                          borderRadius: 12,
                          alignItems: 'center',
                          transition: 'border-color 0.15s',
                        }}>
                          <div style={{
                            width: 44,
                            height: 44,
                            borderRadius: 10,
                            background: `linear-gradient(135deg, ${rg1}30, ${rg2}50)`,
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            fontSize: '1.25rem',
                            flexShrink: 0,
                          }}>
                            {rEmojis[(ri + 2) % rEmojis.length]}
                          </div>
                          <div style={{ flex: 1, minWidth: 0 }}>
                            <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--cream)', lineHeight: 1.35, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                              {rc.title}
                            </div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
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
          {/* About this course */}
          <section style={{ marginBottom: '3rem' }}>
            <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>
              About this course
            </h2>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.7 }}>
              {course.description}
            </p>
          </section>

          {/* Course meta grid */}
          <section style={{ marginBottom: '3rem' }}>
            <div style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fill, minmax(180px, 1fr))',
              gap: '1rem',
            }}>
              {[
                { icon: '👨‍🏫', label: 'Instructor', value: course.instructor_name ?? 'Expert Instructor' },
                { icon: '🏆', label: 'Certificate', value: course.certificate_enabled ? 'Certificate of completion' : 'No certificate' },
                { icon: '🌐', label: 'Language', value: course.language ?? 'English' },
                { icon: '⏱️', label: 'Time to complete', value: `${computedHours}h total` },
                { icon: '📱', label: 'Learn on', value: 'iOS & Android' },
                { icon: '📚', label: 'Lessons', value: `${totalLessons} lessons` },
                { icon: '✅', label: 'Prerequisites', value: course.prerequisites ?? 'No prerequisites' },
                { icon: '📊', label: 'Level', value: levelLabel },
              ].map(item => (
                <div key={item.label} style={{
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: 12,
                  padding: '1rem',
                }}>
                  <div style={{ fontSize: '1.25rem', marginBottom: '0.35rem' }}>{item.icon}</div>
                  <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.2rem' }}>{item.label}</div>
                  <div style={{ fontSize: '0.88rem', fontWeight: 500, color: 'var(--cream)' }}>{item.value}</div>
                </div>
              ))}
            </div>
          </section>

          {/* Skills you'll gain */}
          {course.skills_gained && course.skills_gained.length > 0 && (
            <section style={{ marginBottom: '3rem' }}>
              <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem' }}>
                Skills you&apos;ll gain from this course:
              </h2>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                {course.skills_gained.map((skill: string, i: number) => (
                  <div key={i} style={{ display: 'flex', gap: '0.75rem', alignItems: 'flex-start' }}>
                    <div style={{
                      width: 20,
                      height: 20,
                      borderRadius: '50%',
                      background: 'rgba(52,211,153,0.15)',
                      border: '1.5px solid #34D399',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0,
                      marginTop: '0.1rem',
                    }}>
                      <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#34D399" strokeWidth="3">
                        <polyline points="20 6 9 17 4 12"/>
                      </svg>
                    </div>
                    <span style={{ color: 'var(--cream)', fontSize: '0.92rem', lineHeight: 1.5 }}>{skill}</span>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Syllabus */}
          <section style={{ marginBottom: '3rem' }}>
            <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.25rem' }}>
              Syllabus
            </h2>
            <CourseSyllabus
              levels={levels}
              courseSlug={course.slug}
              isPro={isPro}
              isLoggedIn={!!user}
              completedModuleIds={completedModuleIds}
            />
          </section>

          {/* Certificate of completion */}
          {course.certificate_enabled && (
            <section style={{
              marginBottom: '3rem',
              background: 'var(--surface)',
              border: '1px solid var(--border)',
              borderRadius: 20,
              padding: '2.5rem',
            }}>
              <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.25rem' }}>
                Earn a certificate of completion
              </h2>
              {/* Certificate preview */}
              <div style={{
                background: 'var(--ink)',
                border: '1px solid var(--border)',
                borderRadius: 14,
                padding: '2rem',
                marginBottom: '1.5rem',
                display: 'flex',
                alignItems: 'center',
                gap: '1.5rem',
              }}>
                <div style={{
                  width: 64,
                  height: 64,
                  borderRadius: 16,
                  background: `linear-gradient(135deg, ${gradFrom}, ${gradTo})`,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '1.75rem',
                  flexShrink: 0,
                }}>
                  {courseEmoji}
                </div>
                <div>
                  <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '0.25rem' }}>
                    VibeLearn Certificate
                  </div>
                  <div style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.25rem' }}>
                    {course.title}
                  </div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>
                    Issued upon course completion
                  </div>
                </div>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                {[
                  { icon: '✅', text: 'Validate your expertise — Earn an industry-recognized certificate showing your newly acquired skills and the hours of training you completed.' },
                  { icon: '🏅', text: 'Official, evergreen credentials — Once earned, your certificate can be yours forever. Unlike subscriptions, it never expires.' },
                  { icon: '🚀', text: 'Showcase your achievement — In addition to automatic exposure on your VibeLearn profile, you can add this certificate to your CV, resume, website, or LinkedIn profile.' },
                ].map((item, i) => (
                  <div key={i} style={{ display: 'flex', gap: '0.75rem', alignItems: 'flex-start' }}>
                    <span style={{ fontSize: '1rem', flexShrink: 0 }}>{item.icon}</span>
                    <span style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.6 }}>{item.text}</span>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Instructor */}
          {course.instructor_name && (
            <section style={{ marginBottom: '3rem' }}>
              <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.5rem' }}>
                Meet your course instructor
              </h2>
              <div style={{ display: 'flex', gap: '1.5rem', alignItems: 'flex-start' }}>
                {/* Avatar */}
                <div style={{
                  width: 72,
                  height: 72,
                  borderRadius: '50%',
                  background: `linear-gradient(135deg, ${gradFrom}, ${gradTo})`,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '1.5rem',
                  flexShrink: 0,
                  color: 'white',
                  fontWeight: 700,
                }}>
                  {course.instructor_name.charAt(0)}
                </div>
                <div>
                  <div style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.25rem' }}>
                    {course.instructor_name}
                  </div>
                  {courseWithPath.path && (
                    <div style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: '0.75rem' }}>
                      {courseWithPath.path?.name} Instructor
                    </div>
                  )}
                  <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.65 }}>
                    {course.instructor_bio ?? 'Expert instructor with years of industry experience, passionate about teaching practical skills that get results.'}
                  </p>
                </div>
              </div>
            </section>
          )}

          {/* Reviews */}
          {reviewsCount > 0 && (
            <section style={{ marginBottom: '3rem' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '1.5rem' }}>
                <span style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)' }}>★ {rating}</span>
                <span style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>({reviewsCount} reviews)</span>
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
                {SAMPLE_REVIEWS.map((review, i) => (
                  <div key={i} style={{
                    background: 'var(--surface)',
                    border: '1px solid var(--border)',
                    borderRadius: 14,
                    padding: '1.25rem',
                  }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.75rem' }}>
                      <div style={{
                        width: 36,
                        height: 36,
                        borderRadius: '50%',
                        background: `linear-gradient(135deg, ${gradFrom}80, ${gradTo}80)`,
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        fontWeight: 700,
                        color: 'white',
                        fontSize: '0.9rem',
                      }}>
                        {review.name.charAt(0)}
                      </div>
                      <div>
                        <div style={{ fontSize: '0.88rem', fontWeight: 600, color: 'var(--cream)' }}>{review.name}</div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>{review.role}</div>
                      </div>
                      <div style={{ marginLeft: 'auto', color: '#F5C842', fontSize: '0.8rem' }}>
                        {'★'.repeat(review.rating)}
                      </div>
                    </div>
                    <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', lineHeight: 1.6 }}>{review.text}</p>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Company logos */}
          <section style={{ marginBottom: '3rem' }}>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', marginBottom: '1rem', textAlign: 'center' }}>
              Loved by learners from world&apos;s top companies
            </p>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1.5rem', justifyContent: 'center', alignItems: 'center' }}>
              {COMPANY_LOGOS.map(logo => (
                <div key={logo} style={{
                  fontSize: '0.82rem',
                  fontWeight: 700,
                  color: 'var(--text-muted)',
                  letterSpacing: '0.04em',
                  textTransform: 'uppercase',
                  padding: '0.5rem 1rem',
                  border: '1px solid var(--border)',
                  borderRadius: 8,
                }}>
                  {logo}
                </div>
              ))}
            </div>
          </section>
        </div>
      </div>

      {/* ====== JOIN CTA BANNER ====== */}
      <section style={{
        background: 'var(--cream)',
        padding: '3rem 1.5rem',
        textAlign: 'center',
      }}>
        <div style={{ maxWidth: 700, margin: '0 auto' }}>
          <h2 style={{ fontSize: 'clamp(1.4rem, 3vw, 2rem)', fontWeight: 700, color: 'var(--ink)', marginBottom: '0.75rem' }}>
            Join over {enrolledCount > 1000 ? `${Math.floor(enrolledCount / 1000) * 1000}` : '5,000'}+ learners and start{' '}
            <span style={{ textDecoration: 'underline' }}>{course.title}</span>{' '}
            course today!
          </h2>
          <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', flexWrap: 'wrap' }}>
            <CourseEnrollButton
              courseId={course.id}
              courseSlug={course.slug}
              isEnrolled={isEnrolled}
              isLoggedIn={!!user}
              startHref={startHref}
              variant="primary"
            />
            <Link href="/upgrade" style={{
              background: 'transparent',
              color: 'var(--ink)',
              fontWeight: 600,
              fontSize: '0.95rem',
              padding: '0.8rem 2rem',
              borderRadius: 10,
              textDecoration: 'none',
              border: '2px solid var(--ink)',
            }}>
              Get full access with Pro
            </Link>
          </div>
        </div>
      </section>

      {/* ====== RELATED COURSES (full-width) ====== */}
      {related && related.length > 0 && (
        <section style={{ padding: '3rem 1.5rem', background: 'var(--ink)' }}>
          <div style={{ maxWidth: 1200, margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
              <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)' }}>Related courses</h2>
              <Link href="/courses" style={{ fontSize: '0.88rem', color: 'var(--accent)', textDecoration: 'none', fontWeight: 600 }}>
                Show all →
              </Link>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '1.25rem' }}>
              {related.map((rc, ri) => {
                const [rg1, rg2] = CATEGORY_GRADIENTS[category] ?? CATEGORY_GRADIENTS.AI
                const rEmojis = CATEGORY_EMOJIS[category] ?? CATEGORY_EMOJIS.AI
                return (
                  <Link key={rc.id} href={`/courses/${rc.slug}`} style={{ textDecoration: 'none' }}>
                    <div className="related-card" style={{
                      background: 'var(--surface)',
                      border: '1px solid var(--border)',
                      borderRadius: 14,
                      overflow: 'hidden',
                    }}>
                      <div style={{
                        height: 120,
                        background: `linear-gradient(135deg, ${rg1}20, ${rg2}40)`,
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        fontSize: '2.5rem',
                      }}>
                        {rEmojis[(ri + 3) % rEmojis.length]}
                      </div>
                      <div style={{ padding: '0.875rem' }}>
                        <div style={{ fontSize: '0.88rem', fontWeight: 600, color: 'var(--cream)', lineHeight: 1.4, marginBottom: '0.4rem' }}>
                          {rc.title}
                        </div>
                        <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                          {LEVEL_LABELS[rc.level ?? 'beginner']}
                          {rc.duration_hours && ` · ${Number(rc.duration_hours).toFixed(0)}h`}
                          {rc.enrolled_count && rc.enrolled_count > 0 && ` · ${rc.enrolled_count >= 1000 ? `${Math.floor(rc.enrolled_count / 1000)}K` : rc.enrolled_count} learners`}
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
        .hero-bg {
          grid-column: 1 / -1;
          grid-row: 1;
        }
        .hero-content {
          grid-column: 2;
          grid-row: 1;
          padding: 3rem 0;
        }
        .main-content {
          grid-column: 2;
          grid-row: 2;
          padding: 0 0 3rem 0;
        }
        .right-column {
          grid-column: 3;
          grid-row: 1 / 3;
          padding: 3rem 0;
        }

        @media (max-width: 1024px) {
          .course-layout {
            grid-template-columns: 1.5rem 1fr 1.5rem;
            grid-template-rows: auto auto auto;
            column-gap: 0;
          }
          .hero-bg {
            grid-column: 1 / -1;
            grid-row: 1;
          }
          .hero-content {
            grid-column: 2;
            grid-row: 1;
            padding: 2rem 0;
          }
          .right-column {
            grid-column: 2;
            grid-row: 2;
            padding: 0 0 2rem 0;
          }
          .main-content {
            grid-column: 2;
            grid-row: 3;
            padding: 0 0 2rem 0;
          }
        }

        .related-card { transition: transform 0.2s, box-shadow 0.2s; }
        .related-card:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        .related-card-sm { transition: border-color 0.15s; }
        .related-card-sm:hover { border-color: var(--cream) !important; }
      `}</style>
    </div>
  )
}
