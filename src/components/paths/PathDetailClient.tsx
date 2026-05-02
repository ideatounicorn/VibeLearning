'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { motion } from 'framer-motion'
import { useRouter } from 'next/navigation'
import AuthModal from '../AuthModal'

interface Module {
  id: string
  title: string
  slug: string
  order_index: number
  is_free: boolean
  description: string | null
}

interface Course {
  id: string
  title: string
  slug: string
  description: string | null
  order_index: number
  level: string | null
  duration_hours: number | null
  modules: Module[]
}

interface Path {
  id: string
  name: string
  slug: string
  description: string
  category: string
  total_modules: number
  total_hours: number
  salary_range: string | null
  faq: Array<{ q: string; a: string }> | null
}

interface Props {
  path: Path
  courses: Course[]
  completedModuleIds: string[]
  isPro: boolean
  isLoggedIn: boolean
  profile: { xp_total: number; streak_days: number } | null
  otherPaths: Array<{ id: string; name: string; slug: string; category: string; description: string }>
}

const CERT_BENEFITS = [
  'Demonstrate your expertise — VibeLearn certificates are recognized by industry leaders',
  'Official, evergreen credentials — certificate has its own shareable page',
  'Join a network of certified professionals worldwide',
]

export default function PathDetailClient({ path, courses, completedModuleIds, isPro, isLoggedIn, profile, otherPaths }: Props) {
  const router = useRouter()
  const [showAuth, setShowAuth] = useState(false)
  const [showPaywall, setShowPaywall] = useState(false)
  const [expandedCourseId, setExpandedCourseId] = useState<string | null>(courses[0]?.id ?? null)
  const [enrolledCourseIds, setEnrolledCourseIds] = useState<string[]>([])
  const [isEnrolling, setIsEnrolling] = useState(false)

  // Fetch user enrollments on mount
  useEffect(() => {
    if (isLoggedIn) {
      fetch('/api/enrollments')
        .then(res => res.json())
        .then(data => setEnrolledCourseIds(data.enrolledCourseIds || []))
        .catch(console.error)
    }
  }, [isLoggedIn])

  // Flatten modules to find current one
  const allModules = courses.flatMap(c => [...(c.modules ?? [])].sort((a, b) => a.order_index - b.order_index))
  const firstIncompleteIdx = allModules.findIndex(m => !completedModuleIds.includes(m.id))
  const currentModuleId = firstIncompleteIdx >= 0 ? allModules[firstIncompleteIdx]?.id : null

  // Auto-expand the course that has the current module
  useEffect(() => {
    if (currentModuleId) {
      const courseWithCurrent = courses.find(c => 
        (c.modules ?? []).some(m => m.id === currentModuleId)
      )
      if (courseWithCurrent) {
        setExpandedCourseId(courseWithCurrent.id)
      }
    }
  }, [currentModuleId, courses])

  const totalCompleted = completedModuleIds.length
  const totalModules = allModules.length
  const progressPct = totalModules > 0 ? Math.round((totalCompleted / totalModules) * 100) : 0

  // Count enrolled courses in this path
  const enrolledInPathCount = courses.filter(c => enrolledCourseIds.includes(c.id)).length
  const isFullyEnrolledInPath = enrolledInPathCount === courses.length && courses.length > 0

  // Course unlock logic: course N is locked if course N-1 is not 100% complete
  const isCourseUnlocked = (ci: number): boolean => {
    if (ci === 0) return true
    const prevCourse = courses[ci - 1]
    const prevModules = prevCourse?.modules ?? []
    if (prevModules.length === 0) return true
    return prevModules.every(m => completedModuleIds.includes(m.id))
  }

  const getModuleState = (module: Module, modIndex: number) => {
    if (completedModuleIds.includes(module.id)) return 'done'
    if (module.id === currentModuleId) return 'current'
    if (!module.is_free && !isPro && modIndex > 1) return 'locked'
    return 'unlocked'
  }

  const handleModuleClick = async (module: Module, state: string, courseSlug: string, courseId: string) => {
    if (!isLoggedIn) { setShowAuth(true); return }
    if (state === 'locked') { setShowPaywall(true); return }
    
    // Check if enrolled in this course
    if (!enrolledCourseIds.includes(courseId)) {
      await handleCourseEnroll(courseId)
    }

    router.push(`/learn/${courseSlug}/${module.id}`)
  }

  const handleEnroll = async () => {
    if (!isLoggedIn) { setShowAuth(true); return }
    
    setIsEnrolling(true)
    try {
      const res = await fetch('/api/enroll/path', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ pathId: path.id }),
      })
      const data = await res.json()
      
      if (res.ok) {
        // Refresh enrollments
        const enrollmentsRes = await fetch('/api/enrollments')
        const enrollmentsData = await enrollmentsRes.json()
        setEnrolledCourseIds(enrollmentsData.enrolledCourseIds || [])
      }
    } catch (err) {
      console.error('Enrollment failed:', err)
    } finally {
      setIsEnrolling(false)
    }
  }

  const handleCourseEnroll = async (courseId: string) => {
    if (!isLoggedIn) { setShowAuth(true); return }
    
    try {
      const res = await fetch('/api/enroll/course', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ courseId }),
      })
      const data = await res.json()
      
      if (res.ok) {
        setEnrolledCourseIds(prev => [...prev, courseId])
      }
    } catch (err) {
      console.error('Course enrollment failed:', err)
    }
  }

  const faqs = path.faq ?? [
    { q: 'How long does this path take?', a: `The ${path.name} path takes approximately ${path.total_hours} hours to complete at a typical learning pace.` },
    { q: 'What will I be able to do after completing this path?', a: `You'll have the skills needed to work professionally in ${path.category}. You'll also earn a certificate you can share on LinkedIn.` },
    { q: 'Is this path suitable for beginners?', a: 'Yes. The path starts with foundational concepts and progressively builds to advanced, job-ready skills.' },
    { q: 'Do I need prior experience?', a: 'No prior experience is required. A willingness to learn and practice is all you need.' },
    { q: 'Will I earn a certificate?', a: 'Yes. Completing the path awards a shareable certificate recognized by industry professionals.' },
  ]

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      {/* Breadcrumb */}
      <div style={{ padding: '0.75rem 1.5rem', borderBottom: '1px solid var(--line)', background: 'var(--dim)' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem', color: 'var(--muted)' }}>
          <Link href="/paths" style={{ color: 'var(--muted)', textDecoration: 'none' }}>Career Paths</Link>
          <span>›</span>
          <span style={{ color: 'var(--cream)' }}>{path.name}</span>
        </div>
      </div>

      <div style={{ maxWidth: 1100, margin: '0 auto', padding: '3rem 1.5rem' }}>
        <div
          className="path-detail-grid"
          style={{ display: 'grid', gridTemplateColumns: '1fr 320px', gap: '3.5rem', alignItems: 'start' }}
        >
          {/* ======= LEFT COLUMN ======= */}
          <div>
            {/* Category badge + title */}
            <div className="pill pill-green" style={{ marginBottom: '1rem', display: 'inline-flex' }}>
              {path.category}
            </div>
            <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(2rem, 5vw, 3rem)', color: 'var(--cream)', marginBottom: '1rem', lineHeight: 1.15 }}>
              {path.name}
            </h1>
            <p style={{ color: 'var(--muted)', fontSize: '1rem', lineHeight: 1.75, marginBottom: '1.5rem' }}>
              {path.description}
            </p>

            {/* Meta row */}
            <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap', color: 'var(--muted)', fontSize: '0.875rem', marginBottom: '1.5rem' }}>
              <span>📚 {path.total_modules} modules</span>
              <span>⏱ ~{path.total_hours}h total</span>
              {path.salary_range && <span>💼 {path.salary_range}</span>}
              <span>🌐 English</span>
              {profile && (
                <>
                  <span style={{ color: 'var(--amber)' }}>🔥 {profile.streak_days} day streak</span>
                  <span style={{ color: 'var(--accent)' }}>⭐ {profile.xp_total.toLocaleString()} XP</span>
                </>
              )}
            </div>

            {/* Progress bar (if started) */}
            {isLoggedIn && totalCompleted > 0 && (
              <div style={{ marginBottom: '2rem' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem', fontSize: '0.85rem', color: 'var(--muted)' }}>
                  <span>Your progress</span>
                  <span>{totalCompleted}/{totalModules} modules · {progressPct}%</span>
                </div>
                <div className="progress-bar" style={{ height: 8 }}>
                  <div className="progress-bar-fill" style={{ width: `${progressPct}%` }} />
                </div>
              </div>
            )}

            {/* ======= SYLLABUS ======= */}
            <div style={{ marginBottom: '3rem' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)' }}>Syllabus</h2>
                <span style={{ color: 'var(--muted)', fontSize: '0.875rem' }}>
                  {courses.length} courses · {totalModules} modules
                </span>
              </div>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {courses.map((course, ci) => {
                  const sortedModules = [...(course.modules ?? [])].sort((a, b) => a.order_index - b.order_index)
                  const isExpanded = expandedCourseId === course.id
                  const completedInCourse = sortedModules.filter(m => completedModuleIds.includes(m.id)).length
                  const allDone = completedInCourse === sortedModules.length && sortedModules.length > 0
                  const unlocked = isCourseUnlocked(ci)
                  const prevCourseName = ci > 0 ? courses[ci - 1]?.title : null

                  return (
                    <motion.div
                      key={course.id}
                      initial={{ opacity: 0, y: 16 }}
                      animate={{ opacity: unlocked ? 1 : 0.55, y: 0 }}
                      transition={{ delay: ci * 0.07 }}
                      style={{
                        border: !unlocked ? '1.5px solid var(--line)' : isExpanded ? '1.5px solid var(--cream)' : '1.5px solid var(--line)',
                        borderRadius: 16,
                        overflow: 'hidden',
                        transition: 'border-color 0.2s',
                        filter: !unlocked ? 'grayscale(0.4)' : 'none',
                        position: 'relative',
                      }}
                    >
                      {/* Locked overlay hint */}
                      {!unlocked && (
                        <div style={{
                          position: 'absolute', top: 12, right: 12, zIndex: 2,
                          display: 'flex', alignItems: 'center', gap: '0.4rem',
                          background: 'var(--dim)', border: '1px solid var(--line)',
                          borderRadius: 999, padding: '0.25rem 0.6rem',
                          fontSize: '0.7rem', color: 'var(--muted)', fontWeight: 600,
                        }}>
                          🔒 Locked
                        </div>
                      )}

                      {/* Course header row */}
                      <button
                        onClick={() => unlocked && setExpandedCourseId(isExpanded ? null : course.id)}
                        style={{
                          width: '100%',
                          padding: '1.25rem 1.5rem',
                          background: isExpanded ? 'var(--dim)' : 'transparent',
                          border: 'none',
                          cursor: unlocked ? 'pointer' : 'default',
                          display: 'flex',
                          alignItems: 'center',
                          gap: '1rem',
                          textAlign: 'left',
                          transition: 'background 0.15s',
                        }}
                      >
                        {/* Number */}
                        <div style={{
                          width: 36, height: 36, borderRadius: 10, flexShrink: 0,
                          background: !unlocked ? 'var(--line)' : allDone ? 'rgba(34,197,94,0.15)' : isExpanded ? 'var(--cream)' : 'var(--line)',
                          color: !unlocked ? 'var(--muted)' : allDone ? '#22C55E' : isExpanded ? 'var(--ink)' : 'var(--cream)',
                          display: 'flex', alignItems: 'center', justifyContent: 'center',
                          fontWeight: 700, fontSize: '0.9rem',
                        }}>
                          {!unlocked ? '🔒' : allDone ? '✓' : ci + 1}
                        </div>

                        <div style={{ flex: 1, minWidth: 0, paddingRight: !unlocked ? '5rem' : '0' }}>
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap', marginBottom: '0.2rem' }}>
                            <span style={{ fontSize: '1rem', fontWeight: 600, color: unlocked ? 'var(--cream)' : 'var(--muted)' }}>{course.title}</span>
                            {ci === 0 && <span className="pill" style={{ fontSize: '0.65rem', borderColor: 'var(--line)', color: 'var(--muted)' }}>Start here</span>}
                          </div>
                          <div style={{ display: 'flex', gap: '1rem', fontSize: '0.8rem', color: 'var(--muted)' }}>
                            <span>{sortedModules.length} modules</span>
                            {course.duration_hours && <span>~{course.duration_hours}h</span>}
                            {course.level && <span>{course.level}</span>}
                            {completedInCourse > 0 && (
                              <span style={{ color: '#22C55E' }}>{completedInCourse}/{sortedModules.length} done</span>
                            )}
                          </div>
                          {!unlocked && prevCourseName && (
                            <div style={{ fontSize: '0.75rem', color: 'var(--muted)', marginTop: '0.3rem' }}>
                              Complete <em>{prevCourseName}</em> to unlock
                            </div>
                          )}
                        </div>

                        {/* Chevron (only if unlocked) */}
                        {unlocked && (
                          <svg
                            width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"
                            style={{ flexShrink: 0, color: 'var(--muted)', transform: isExpanded ? 'rotate(180deg)' : 'none', transition: 'transform 0.2s' }}
                          >
                            <polyline points="6 9 12 15 18 9" />
                          </svg>
                        )}
                      </button>

                      {/* Modules list */}
                      {isExpanded && (
                        <motion.div
                          initial={{ opacity: 0, height: 0 }}
                          animate={{ opacity: 1, height: 'auto' }}
                          style={{ borderTop: '1px solid var(--line)', background: 'var(--ink)', padding: '1rem 1.5rem' }}
                        >
                          {course.description && (
                            <p style={{ color: 'var(--muted)', fontSize: '0.875rem', lineHeight: 1.6, marginBottom: '1rem' }}>
                              {course.description}
                            </p>
                          )}
                          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
                            {sortedModules.map((module, mi) => {
                              const state = getModuleState(module, mi)
                              return (
                                <div
                                  key={module.id}
                                  onClick={() => handleModuleClick(module, state, course.slug, course.id)}
                                  style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '0.875rem',
                                    padding: '0.875rem 1rem',
                                    borderRadius: 12,
                                    border: state === 'current' ? '1.5px solid var(--accent)' : '1px solid var(--line)',
                                    background: state === 'current' ? 'color-mix(in srgb, var(--accent) 6%, transparent)' : 'transparent',
                                    cursor: state === 'locked' ? 'default' : 'pointer',
                                    opacity: state === 'done' ? 0.55 : state === 'locked' ? 0.4 : 1,
                                    transition: 'all 0.15s',
                                  }}
                                >
                                  {/* Status dot */}
                                  <div style={{
                                    width: 24, height: 24, borderRadius: '50%', flexShrink: 0,
                                    display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.75rem',
                                    background: state === 'done' ? 'rgba(34,197,94,0.15)' : state === 'current' ? 'color-mix(in srgb, var(--accent) 20%, transparent)' : 'var(--line)',
                                    color: state === 'done' ? '#22C55E' : state === 'current' ? 'var(--accent)' : 'var(--muted)',
                                    fontWeight: 700,
                                  }}>
                                    {state === 'done' ? '✓' : state === 'locked' ? '🔒' : state === 'current' ? '▶' : mi + 1}
                                  </div>

                                  <span style={{
                                    flex: 1, fontSize: '0.9rem', fontWeight: state === 'current' ? 600 : 400,
                                    color: state === 'current' ? 'var(--accent)' : 'var(--cream)',
                                    textDecoration: state === 'done' ? 'line-through' : 'none',
                                  }}>
                                    {module.title}
                                  </span>

                                  <div style={{ display: 'flex', gap: '0.4rem' }}>
                                    {state === 'current' && (
                                      <span className="pill" style={{ fontSize: '0.65rem', background: 'var(--accent)', borderColor: 'var(--accent)', color: 'var(--ink)' }}>Up Next</span>
                                    )}
                                    {!module.is_free && (
                                      <span className="pill pill-amber" style={{ fontSize: '0.65rem' }}>PRO</span>
                                    )}
                                  </div>
                                </div>
                              )
                            })}
                          </div>
                        </motion.div>
                      )}
                    </motion.div>
                  )
                })}
              </div>
            </div>

            {/* Certification section */}
            <div style={{ marginBottom: '3rem', padding: '2rem', background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 20 }}>
              <div style={{ display: 'flex', gap: '1.5rem', alignItems: 'flex-start', flexWrap: 'wrap' }}>
                <div style={{ fontSize: '3rem', flexShrink: 0 }}>🏆</div>
                <div style={{ flex: 1, minWidth: 200 }}>
                  <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.75rem' }}>
                    Earn a professional certificate
                  </h2>
                  <p style={{ color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.7, marginBottom: '1rem' }}>
                    Complete the {path.name} path to earn an industry-recognized certificate you can share on LinkedIn, your resume, or portfolio.
                  </p>
                  <ul style={{ listStyle: 'none', padding: 0, display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                    {CERT_BENEFITS.map(b => (
                      <li key={b} style={{ display: 'flex', gap: '0.6rem', fontSize: '0.875rem', color: 'var(--muted)' }}>
                        <span style={{ color: 'var(--accent)', flexShrink: 0 }}>✓</span>
                        {b}
                      </li>
                    ))}
                  </ul>
                    <button onClick={handleEnroll} disabled={isEnrolling || isFullyEnrolledInPath} className="btn-primary" style={{ marginTop: '1.25rem' }}>
                      {isEnrolling ? 'Enrolling...' : 
                       isFullyEnrolledInPath ? 'Fully Enrolled ✓' : 
                       'Enroll now →'}
                    </button>
                </div>
              </div>
            </div>

            {/* Explore more paths */}
            {otherPaths.length > 0 && (
              <div style={{ marginBottom: '3rem' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem' }}>
                  <h2 style={{ fontSize: '1.3rem', fontWeight: 700, color: 'var(--cream)' }}>Explore more career paths</h2>
                  <Link href="/paths" style={{ color: 'var(--muted)', fontSize: '0.875rem', textDecoration: 'none' }}>View all →</Link>
                </div>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '1rem' }}>
                  {otherPaths.slice(0, 3).map(p => (
                    <Link key={p.id} href={`/paths/${p.slug}`} style={{ textDecoration: 'none' }}>
                      <div style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 14, padding: '1.25rem', transition: 'transform 0.15s, border-color 0.15s', cursor: 'pointer' }}
                        onMouseEnter={e => { (e.currentTarget as HTMLDivElement).style.transform = 'translateY(-2px)'; (e.currentTarget as HTMLDivElement).style.borderColor = 'color-mix(in srgb, var(--accent) 30%, transparent)' }}
                        onMouseLeave={e => { (e.currentTarget as HTMLDivElement).style.transform = ''; (e.currentTarget as HTMLDivElement).style.borderColor = 'var(--line)' }}>
                        <div className="pill pill-green" style={{ fontSize: '0.7rem', marginBottom: '0.75rem' }}>{p.category}</div>
                        <div style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.4rem' }}>{p.name}</div>
                        <div style={{ fontSize: '0.8rem', color: 'var(--muted)', lineHeight: 1.5, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{p.description}</div>
                      </div>
                    </Link>
                  ))}
                </div>
              </div>
            )}

            {/* FAQ */}
            <div>
              <h2 style={{ fontSize: '1.4rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.5rem' }}>FAQs</h2>
              {faqs.map((faq, i) => (
                <details key={i} style={{ borderTop: '1px solid var(--line)', padding: '1.25rem 0' }}>
                  <summary style={{ fontSize: '1rem', fontWeight: 500, color: 'var(--cream)', cursor: 'pointer', listStyle: 'none', display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: '1rem' }}>
                    {faq.q}
                    <span style={{ color: 'var(--muted)', flexShrink: 0, fontSize: '1.25rem', fontWeight: 300 }}>+</span>
                  </summary>
                  <p style={{ color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.65, marginTop: '0.75rem', paddingRight: '2rem' }}>{faq.a}</p>
                </details>
              ))}
            </div>
          </div>

          {/* ======= RIGHT SIDEBAR ======= */}
          <div className="path-detail-sidebar" style={{ position: 'sticky', top: '5rem' }}>
            <div style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 20, overflow: 'hidden' }}>
               {/* Top enrollment card */}
              <div style={{ padding: '1.75rem' }}>
                <h3 style={{ fontSize: '1.15rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem' }}>
                  Start this career path
                </h3>
                <p style={{ color: 'var(--muted)', fontSize: '0.875rem', lineHeight: 1.6, marginBottom: '1.25rem' }}>
                  {path.description?.slice(0, 100)}…
                </p>
                <button 
                  onClick={handleEnroll}
                  disabled={isEnrolling || isFullyEnrolledInPath}
                  className="btn-primary" 
                  style={{ 
                    width: '100%', 
                    justifyContent: 'center', 
                    padding: '0.85rem', 
                    fontSize: '1rem', 
                    marginBottom: '0.75rem',
                    opacity: isEnrolling ? 0.7 : 1,
                    cursor: isEnrolling ? 'wait' : 'pointer'
                  }}
                >
                  {isEnrolling ? 'Enrolling...' : 
                   isFullyEnrolledInPath ? 'Fully Enrolled ✓' :
                   enrolledInPathCount > 0 ? `Enroll in Path (${courses.length - enrolledInPathCount} remaining)` : 
                   'Enroll now →'}
                </button>
                {isLoggedIn && totalCompleted > 0 && (
                  <div style={{ marginBottom: '1rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.8rem', color: 'var(--muted)', marginBottom: '0.4rem' }}>
                      <span>{progressPct}% complete</span>
                      <span>{totalCompleted}/{totalModules}</span>
                    </div>
                    <div className="progress-bar">
                      <div className="progress-bar-fill" style={{ width: `${progressPct}%` }} />
                    </div>
                  </div>
                )}
                {isLoggedIn && enrolledInPathCount > 0 && (
                  <div style={{ 
                    padding: '0.75rem', 
                    background: 'rgba(52,211,153,0.1)', 
                    border: '1px solid rgba(52,211,153,0.3)', 
                    borderRadius: 10, 
                    marginTop: '0.75rem',
                    fontSize: '0.85rem',
                    color: '#34D399'
                  }}>
                    ✓ Enrolled in {enrolledInPathCount}/{courses.length} courses
                  </div>
                )}

                {/* Stats */}
                <div style={{ borderTop: '1px solid var(--line)', paddingTop: '1.25rem', display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                  {[
                    { label: 'Courses', value: `${courses.length} courses` },
                    { label: 'Modules', value: `${path.total_modules} modules` },
                    { label: 'Duration', value: `~${path.total_hours}h` },
                    { label: 'Level', value: 'All levels' },
                    { label: 'Language', value: 'English' },
                    ...(path.salary_range ? [{ label: 'Avg salary', value: path.salary_range }] : []),
                  ].map(s => (
                    <div key={s.label} style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem' }}>
                      <span style={{ color: 'var(--muted)' }}>{s.label}</span>
                      <span style={{ color: 'var(--cream)', fontWeight: 500 }}>{s.value}</span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Certification CTA */}
              <div style={{ padding: '1.5rem', borderTop: '1px solid var(--line)', background: 'color-mix(in srgb, var(--accent) 5%, transparent)' }}>
                <div style={{ display: 'flex', gap: '0.75rem', alignItems: 'flex-start' }}>
                  <span style={{ fontSize: '1.5rem', flexShrink: 0 }}>🏆</span>
                  <div>
                    <div style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.3rem' }}>
                      Earn a certificate
                    </div>
                    <div style={{ fontSize: '0.8rem', color: 'var(--muted)', lineHeight: 1.5 }}>
                      Complete the path to get your shareable certificate.
                    </div>
                  </div>
                </div>
              </div>

              {/* Pro upgrade */}
              {!isPro && (
                <div style={{ padding: '1.5rem', borderTop: '1px solid var(--line)' }}>
                  <div style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.75rem' }}>
                    Get full access with Pro
                  </div>
                  <ul style={{ listStyle: 'none', padding: 0, display: 'flex', flexDirection: 'column', gap: '0.4rem', marginBottom: '1rem' }}>
                    {['60+ expert-created courses', 'Industry-recognized certificates', 'Guided career paths & more'].map(b => (
                      <li key={b} style={{ fontSize: '0.825rem', color: 'var(--muted)', display: 'flex', gap: '0.5rem' }}>
                        <span style={{ color: 'var(--accent)' }}>✓</span> {b}
                      </li>
                    ))}
                  </ul>
                  <Link href="/upgrade" className="btn-outline" style={{ display: 'block', textAlign: 'center', textDecoration: 'none', fontSize: '0.875rem' }}>
                    Upgrade now
                  </Link>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Responsive styles */}
      <style>{`
        @media (max-width: 768px) {
          .path-detail-grid { grid-template-columns: 1fr !important; }
          .path-detail-sidebar { display: none; }
        }
      `}</style>

      {/* Paywall modal */}
      {showPaywall && (
        <div onClick={() => setShowPaywall(false)} style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.7)', zIndex: 2000, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '1rem' }}>
          <div onClick={e => e.stopPropagation()} style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 20, padding: '2rem', maxWidth: 400, width: '100%', textAlign: 'center' }}>
            <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>🔒</div>
            <h3 style={{ fontFamily: 'var(--font-serif)', fontSize: '1.6rem', color: 'var(--cream)', marginBottom: '0.5rem' }}>Unlock all modules</h3>
            <p style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '1.5rem', lineHeight: 1.6 }}>
              Get unlimited access to all 5 career paths, every module, and priority support.
            </p>
            <div style={{ background: 'rgba(184,245,102,0.06)', border: '1px solid rgba(184,245,102,0.2)', borderRadius: 12, padding: '1.25rem', marginBottom: '1.5rem' }}>
              <div style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--cream)', marginBottom: '0.2rem' }}>
                $9.99<span style={{ fontSize: '1rem', color: 'var(--muted)' }}>/mo</span>
              </div>
              <div style={{ color: 'var(--muted)', fontSize: '0.85rem' }}>or $79/yr (save 34%)</div>
            </div>
            <Link href="/upgrade" className="btn-primary" style={{ display: 'block', textDecoration: 'none', marginBottom: '0.75rem' }}>
              Upgrade to PRO →
            </Link>
            <button onClick={() => setShowPaywall(false)} style={{ background: 'none', border: 'none', color: 'var(--muted)', cursor: 'pointer', fontSize: '0.85rem' }}>
              Maybe later
            </button>
          </div>
        </div>
      )}

      {showAuth && (
        <AuthModal mode="signup" onClose={() => setShowAuth(false)} onSuccess={() => setShowAuth(false)} />
      )}
    </div>
  )
}
