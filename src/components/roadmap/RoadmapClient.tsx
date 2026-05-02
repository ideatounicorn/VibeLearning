'use client'

import { useState } from 'react'
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
  modules: Module[]
}

interface Props {
  courses: Course[]
  completedModuleIds: string[]
  isPro: boolean
  isLoggedIn: boolean
}

export default function RoadmapClient({ courses, completedModuleIds, isPro, isLoggedIn }: Props) {
  const router = useRouter()
  const [showAuth, setShowAuth] = useState(false)
  const [showPaywall, setShowPaywall] = useState(false)
  const [selectedModule, setSelectedModule] = useState<Module | null>(null)

  // Flatten modules in order to determine "current"
  const allModules = courses.flatMap(c =>
    [...(c.modules ?? [])].sort((a, b) => a.order_index - b.order_index)
  )
  const firstIncompleteIdx = allModules.findIndex(m => !completedModuleIds.includes(m.id))
  const currentModuleId = firstIncompleteIdx >= 0 ? allModules[firstIncompleteIdx]?.id : null

  // Find the course that contains the current module
  const initialExpandedCourseId = currentModuleId 
    ? courses.find(c => c.modules?.some(m => m.id === currentModuleId))?.id 
    : courses[0]?.id

  const [expandedCourseId, setExpandedCourseId] = useState<string | null>(initialExpandedCourseId ?? null)

  const getModuleState = (module: Module, modIndex: number) => {
    if (completedModuleIds.includes(module.id)) return 'done'
    if (module.id === currentModuleId) return 'current'
    if (!module.is_free && !isPro && modIndex > 1) return 'locked'
    return 'unlocked'
  }

  const handleModuleClick = (module: Module, state: string, courseSlug: string) => {
    if (!isLoggedIn) { setShowAuth(true); return }
    if (state === 'locked') { setSelectedModule(module); setShowPaywall(true); return }
    if (state === 'done' || state === 'current' || state === 'unlocked') {
      router.push(`/learn/${courseSlug}/${module.id}`)
    }
  }

  return (
    <div style={{ maxWidth: 760, margin: '0 auto', padding: '3rem 1.5rem' }}>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
        {courses.map((course, ci) => {
          const sortedModules = [...(course.modules ?? [])].sort((a, b) => a.order_index - b.order_index)
          const isExpanded = expandedCourseId === course.id
          
          // Calculate course progress
          const totalModules = sortedModules.length
          const completedInCourse = sortedModules.filter(m => completedModuleIds.includes(m.id)).length
          const progressPercent = totalModules > 0 ? (completedInCourse / totalModules) * 100 : 0

          return (
            <div 
              key={course.id} 
              style={{ 
                background: 'var(--dim)',
                border: isExpanded ? '1.5px solid var(--cream)' : '1.5px solid var(--line)',
                borderRadius: '16px',
                overflow: 'hidden',
                transition: 'all 0.2s',
                boxShadow: isExpanded ? '0 8px 30px rgba(0,0,0,0.12)' : 'none'
              }}
            >
              {/* Course Header (Accordion Toggle) */}
              <div 
                onClick={() => setExpandedCourseId(isExpanded ? null : course.id)}
                style={{ 
                  padding: '1.5rem', 
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: '1rem',
                  background: isExpanded ? 'rgba(255,255,255,0.02)' : 'transparent'
                }}
              >
                <div style={{ flex: 1 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.5rem' }}>
                    <div style={{ 
                      background: 'var(--line)', 
                      color: 'var(--cream)', 
                      width: 24, height: 24, 
                      borderRadius: '50%', 
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                      fontSize: '0.8rem', fontWeight: 600
                    }}>
                      {ci + 1}
                    </div>
                    <h2 style={{ fontSize: '1.25rem', fontWeight: 600, color: 'var(--cream)' }}>
                      {course.title}
                    </h2>
                  </div>
                  {course.description && (
                    <p style={{ color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.5, paddingLeft: '2.25rem' }}>
                      {course.description}
                    </p>
                  )}
                  {/* Mini Progress Bar */}
                  {totalModules > 0 && (
                    <div style={{ paddingLeft: '2.25rem', marginTop: '1rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                      <div className="progress-bar" style={{ flex: 1, maxWidth: 200, height: 6, background: 'var(--line)' }}>
                        <div className="progress-bar-fill" style={{ width: `${progressPercent}%`, background: progressPercent === 100 ? 'var(--green)' : 'var(--amber)' }} />
                      </div>
                      <span style={{ fontSize: '0.75rem', color: 'var(--muted)', fontWeight: 500 }}>
                        {completedInCourse} / {totalModules}
                      </span>
                    </div>
                  )}
                </div>
                <div style={{ 
                  width: 32, height: 32, 
                  borderRadius: '50%', 
                  background: 'var(--line)', 
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  color: 'var(--cream)',
                  transform: isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                  transition: 'transform 0.2s'
                }}>
                  ▼
                </div>
              </div>

              {/* Modules List (Expanded State) */}
              {isExpanded && (
                <motion.div 
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: 'auto' }}
                  exit={{ opacity: 0, height: 0 }}
                  style={{ 
                    borderTop: '1px solid var(--line)',
                    padding: '1.5rem',
                    background: 'var(--ink)'
                  }}
                >
                  <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                    {sortedModules.map((module, mi) => {
                      const state = getModuleState(module, mi)
                      return (
                        <div
                          key={module.id}
                          className={`roadmap-node ${state}`}
                          onClick={() => handleModuleClick(module, state, course.slug)}
                          style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: '1rem',
                            padding: '1rem 1.25rem',
                            borderRadius: '12px',
                            border: state === 'current' ? '1.5px solid var(--cream)' : '1px solid var(--line)',
                            background: state === 'current' ? 'var(--dim)' : 'transparent',
                            cursor: 'pointer',
                            transition: 'all 0.15s'
                          }}
                        >
                          {/* Status Icon */}
                          <div style={{
                            width: 28, height: 28, borderRadius: '50%',
                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                            fontSize: '0.8rem', fontWeight: 600,
                            background: state === 'done' ? 'rgba(34,197,94,0.15)' : state === 'locked' ? 'rgba(255,255,255,0.05)' : 'var(--line)',
                            color: state === 'done' ? '#22C55E' : state === 'locked' ? 'var(--muted)' : 'var(--cream)'
                          }}>
                            {state === 'done' ? '✓' : state === 'locked' ? '🔒' : state === 'current' ? '▶' : mi + 1}
                          </div>

                          {/* Title */}
                          <div style={{ flex: 1, minWidth: 0 }}>
                            <div style={{
                              fontSize: '0.95rem',
                              fontWeight: state === 'current' ? 600 : 500,
                              color: state === 'current' ? 'var(--cream)' : state === 'done' ? 'var(--muted)' : 'var(--cream)',
                              textDecoration: state === 'done' ? 'line-through' : 'none',
                            }}>
                              {module.title}
                            </div>
                          </div>

                          {/* Badges */}
                          <div style={{ display: 'flex', gap: '0.5rem' }}>
                            {state === 'current' && (
                              <span className="pill" style={{ fontSize: '0.7rem', color: 'var(--ink)', background: 'var(--cream)', borderColor: 'var(--cream)' }}>
                                Up Next
                              </span>
                            )}
                            {!module.is_free && (
                              <span className="pill pill-amber" style={{ fontSize: '0.7rem' }}>PRO</span>
                            )}
                          </div>
                        </div>
                      )
                    })}
                  </div>
                </motion.div>
              )}
            </div>
          )
        })}
      </div>

      {/* Paywall Modal */}
      {showPaywall && (
        <div
          onClick={() => setShowPaywall(false)}
          style={{
            position: 'fixed',
            inset: 0,
            background: 'rgba(0,0,0,0.7)',
            zIndex: 2000,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            padding: '1rem',
          }}
        >
          <div
            onClick={e => e.stopPropagation()}
            style={{
              background: 'var(--dim)',
              border: '1px solid var(--line)',
              borderRadius: 20,
              padding: '2rem',
              maxWidth: 400,
              width: '100%',
              textAlign: 'center',
            }}
          >
            <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>🔒</div>
            <h3
              style={{
                fontFamily: 'var(--font-serif)',
                fontSize: '1.6rem',
                color: 'var(--cream)',
                marginBottom: '0.5rem',
              }}
            >
              Unlock all modules
            </h3>
            <p style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '1.5rem', lineHeight: 1.6 }}>
              Get unlimited access to all 5 career paths, every module, and priority support.
            </p>
            <div
              style={{
                background: 'rgba(184,245,102,0.06)',
                border: '1px solid rgba(184,245,102,0.2)',
                borderRadius: 12,
                padding: '1.25rem',
                marginBottom: '1.5rem',
              }}
            >
              <div style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--cream)', marginBottom: '0.2rem' }}>
                $9.99<span style={{ fontSize: '1rem', color: 'var(--muted)' }}>/mo</span>
              </div>
              <div style={{ color: 'var(--muted)', fontSize: '0.85rem' }}>or $79/yr (save 34%)</div>
            </div>
            <a
              href={`https://polar.sh/vibelearn/subscribe?product_id=${process.env.NEXT_PUBLIC_POLAR_PRODUCT_ID ?? ''}`}
              target="_blank"
              rel="noopener noreferrer"
              className="btn-primary"
              style={{ display: 'block', textDecoration: 'none', marginBottom: '0.75rem' }}
            >
              Upgrade to PRO →
            </a>
            <button
              onClick={() => setShowPaywall(false)}
              style={{ background: 'none', border: 'none', color: 'var(--muted)', cursor: 'pointer', fontSize: '0.85rem' }}
            >
              Maybe later
            </button>
          </div>
        </div>
      )}

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
