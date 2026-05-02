'use client'

import { useState } from 'react'
import Link from 'next/link'

interface Lesson {
  id: string
  title: string
  duration_minutes: number | null
  order_index: number
  youtube_video_id: string | null
}

interface Level {
  id: string
  title: string
  description: string | null
  order_index: number
  is_free: boolean
  lessons: Lesson[]
}

interface Props {
  levels: Level[]
  courseSlug: string
  isPro: boolean
  isLoggedIn: boolean
  completedModuleIds: string[]
}

export default function CourseSyllabus({ levels, courseSlug, isPro, isLoggedIn, completedModuleIds }: Props) {
  const [expandedId, setExpandedId] = useState<string | null>(levels[0]?.id ?? null)
  const [showAll, setShowAll] = useState(false)

  const totalLessons = levels.reduce((acc, l) => acc + l.lessons.length, 0)
  const totalMinutes = levels.reduce((acc, l) =>
    acc + l.lessons.reduce((a, les) => a + (les.duration_minutes ?? 0), 0), 0
  )
  const totalHours = (totalMinutes / 60).toFixed(0)

  const visibleLevels = showAll ? levels : levels.slice(0, 5)

  return (
    <div>
      {/* Header */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1.25rem', flexWrap: 'wrap', gap: '0.5rem' }}>
        <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>
          {levels.length} sections · {totalLessons} lessons · {totalHours}h total
        </p>
        {levels.length > 5 && (
          <button
            onClick={() => setShowAll(!showAll)}
            style={{ background: 'none', border: 'none', color: 'var(--accent)', fontSize: '0.9rem', cursor: 'pointer', fontWeight: 600 }}
          >
            {showAll ? 'Show less' : `Expand all ${levels.length} sections`}
          </button>
        )}
      </div>

      {/* Level accordions */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0' }}>
        {visibleLevels.map((level, li) => {
          const isExpanded = expandedId === level.id
          const isCompleted = completedModuleIds.includes(level.id)
          const isLocked = !level.is_free && !isPro
          const sortedLessons = [...level.lessons].sort((a, b) => a.order_index - b.order_index)
          const levelMinutes = sortedLessons.reduce((a, l) => a + (l.duration_minutes ?? 0), 0)

          return (
            <div key={level.id} style={{ borderTop: '1px solid var(--border)' }}>
              {/* Level header */}
              <div
                onClick={() => setExpandedId(isExpanded ? null : level.id)}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  padding: '1.25rem 0',
                  cursor: 'pointer',
                  gap: '1rem',
                }}
              >
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                    {/* Level number */}
                    <div style={{
                      width: 28,
                      height: 28,
                      borderRadius: '50%',
                      background: isCompleted
                        ? 'rgba(52,211,153,0.15)'
                        : 'var(--ink)',
                      border: '1.5px solid var(--border)',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      fontSize: '0.75rem',
                      fontWeight: 700,
                      color: isCompleted ? '#34D399' : 'var(--cream)',
                      flexShrink: 0,
                    }}>
                      {isCompleted ? '✓' : li + 1}
                    </div>
                    <div>
                      <div style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--cream)' }}>
                        {level.title}
                      </div>
                      {!isExpanded && level.description && (
                        <div style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginTop: '0.2rem', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', maxWidth: 400 }}>
                          {level.description}
                        </div>
                      )}
                    </div>
                  </div>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', flexShrink: 0 }}>
                  {/* Stats */}
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', textAlign: 'right' }}>
                    <div>{sortedLessons.length} lessons</div>
                    {levelMinutes > 0 && <div>{levelMinutes}m</div>}
                  </div>

                  {/* Start level CTA */}
                  {sortedLessons.length > 0 && !isLocked && (
                    <Link
                      href={`/learn/${courseSlug}/${level.id}`}
                      onClick={e => e.stopPropagation()}
                      style={{
                        fontSize: '0.82rem',
                        fontWeight: 600,
                        color: 'var(--accent)',
                        textDecoration: 'none',
                        whiteSpace: 'nowrap',
                        padding: '0.35rem 0.75rem',
                        border: '1px solid var(--accent)',
                        borderRadius: 8,
                      }}
                    >
                      Start level
                    </Link>
                  )}

                  {isLocked && (
                    <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>🔒 PRO</span>
                  )}

                  {/* Chevron */}
                  <svg
                    width="16"
                    height="16"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    style={{
                      color: 'var(--text-muted)',
                      transform: isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                      transition: 'transform 0.2s',
                    }}
                  >
                    <polyline points="6 9 12 15 18 9"/>
                  </svg>
                </div>
              </div>

              {/* Expanded: description + lessons */}
              {isExpanded && (
                <div style={{ paddingBottom: '1.25rem', paddingLeft: '2.75rem' }}>
                  {level.description && (
                    <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.65, marginBottom: '1rem' }}>
                      {level.description}
                    </p>
                  )}

                  {sortedLessons.length > 0 && (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0' }}>
                      {sortedLessons.map((lesson, li2) => (
                        <Link
                          key={lesson.id}
                          href={`/learn/${courseSlug}/${level.id}`}
                          style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: '0.75rem',
                            padding: '0.65rem 0',
                            borderTop: li2 === 0 ? 'none' : '1px solid var(--border)',
                            textDecoration: 'none',
                          }}
                        >
                          {/* Play/lock icon */}
                          <div style={{
                            width: 28,
                            height: 28,
                            borderRadius: 6,
                            background: isLocked && !level.is_free ? 'var(--ink)' : 'var(--ink)',
                            border: '1px solid var(--border)',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            color: 'var(--text-muted)',
                            flexShrink: 0,
                          }}>
                            {isLocked ? (
                              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M12 2a5 5 0 00-5 5v3H5a2 2 0 00-2 2v10a2 2 0 002 2h14a2 2 0 002-2V12a2 2 0 00-2-2h-2V7a5 5 0 00-5-5zm0 2a3 3 0 013 3v3H9V7a3 3 0 013-3z"/>
                              </svg>
                            ) : (
                              <svg width="10" height="12" viewBox="0 0 10 12" fill="currentColor">
                                <path d="M0 0l10 6-10 6z"/>
                              </svg>
                            )}
                          </div>

                          {/* Title */}
                          <span style={{ flex: 1, fontSize: '0.88rem', color: 'var(--cream)', lineHeight: 1.4 }}>
                            {lesson.title}
                          </span>

                          {/* Badge */}
                          {level.is_free && (
                            <span style={{
                              fontSize: '0.65rem',
                              fontWeight: 600,
                              color: '#34D399',
                              background: 'rgba(52,211,153,0.12)',
                              border: '1px solid rgba(52,211,153,0.3)',
                              borderRadius: 5,
                              padding: '0.15rem 0.4rem',
                            }}>FREE</span>
                          )}

                          {/* Duration */}
                          {lesson.duration_minutes && (
                            <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)', flexShrink: 0 }}>
                              {lesson.duration_minutes}m
                            </span>
                          )}
                        </Link>
                      ))}
                    </div>
                  )}

                  {sortedLessons.length === 0 && (
                    <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem' }}>Lessons coming soon.</p>
                  )}

                  <button
                    onClick={() => setExpandedId(null)}
                    style={{ background: 'none', border: 'none', color: 'var(--text-muted)', fontSize: '0.82rem', cursor: 'pointer', marginTop: '0.75rem', padding: 0 }}
                  >
                    Hide level details ↑
                  </button>
                </div>
              )}
            </div>
          )
        })}

        {/* Last border */}
        <div style={{ borderTop: '1px solid var(--border)' }} />
      </div>
    </div>
  )
}
