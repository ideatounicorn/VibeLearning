'use client'

import { useState, useMemo, useEffect } from 'react'
import Link from 'next/link'
import { CATEGORY_GRADIENTS, CATEGORY_EMOJIS } from '@/lib/category-constants'

type FilterType = 'all' | 'free' | 'pro'

const LEVEL_COLORS: Record<string, string> = {
  beginner: '#34D399',
  intermediate: '#F5C842',
  advanced: '#FB923C',
}

interface PathInfo {
  name: string
  slug: string
  category: string
  hero_color: string | null
}

interface Course {
  id: string
  title: string
  slug: string
  level: string | null
  enrolled_count: number | null
  rating: number | null
  duration_hours: number | null
  instructor_name: string | null
  tags: string[] | null
  is_pro: boolean | null
  is_hidden: boolean | null
  path: PathInfo | PathInfo[] | null
}

function getPath(course: Course): PathInfo | null {
  if (!course.path) return null
  return Array.isArray(course.path) ? course.path[0] ?? null : course.path
}

function getCourseEmoji(course: Course, index: number): string {
  const cat = getPath(course)?.category ?? 'AI'
  const emojis = CATEGORY_EMOJIS[cat] ?? CATEGORY_EMOJIS.AI
  return emojis[index % emojis.length]
}

function getCourseGradient(course: Course): [string, string] {
  const cat = getPath(course)?.category ?? 'AI'
  return CATEGORY_GRADIENTS[cat] ?? CATEGORY_GRADIENTS.AI
}

function CourseCard({ course, index, isEnrolled, onEnroll }: { 
  course: Course
  index: number
  isEnrolled: boolean
  onEnroll: (courseId: string) => void
}) {
  const emoji = getCourseEmoji(course, index)
  const [gradFrom, gradTo] = getCourseGradient(course)
  const level = course.level ?? 'beginner'
  const levelColor = LEVEL_COLORS[level] ?? LEVEL_COLORS.beginner

  return (
    <div
      style={{
        background: 'var(--surface)',
        border: '1px solid var(--border)',
        borderRadius: 14,
        overflow: 'hidden',
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        transition: 'box-shadow 0.2s, transform 0.2s',
      }}
      onMouseEnter={e => {
        const el = e.currentTarget as HTMLDivElement
        el.style.boxShadow = '0 8px 24px rgba(0,0,0,0.1)'
        el.style.transform = 'translateY(-2px)'
      }}
      onMouseLeave={e => {
        const el = e.currentTarget as HTMLDivElement
        el.style.boxShadow = 'none'
        el.style.transform = 'translateY(0)'
      }}
    >
      {/* Thumbnail */}
      <Link href={`/courses/${course.slug}`} style={{ textDecoration: 'none' }}>
        <div
          style={{
            height: 148,
            background: `linear-gradient(135deg, ${gradFrom}20, ${gradTo}40)`,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            position: 'relative',
            overflow: 'hidden',
          }}
        >
          <div style={{ position: 'absolute', top: -20, right: -20, width: 90, height: 90, borderRadius: '50%', background: `${gradTo}30` }} />
          <div style={{ position: 'absolute', bottom: -12, left: 8, width: 60, height: 60, borderRadius: '50%', background: `${gradFrom}20` }} />
          <span style={{ fontSize: '3rem', position: 'relative', zIndex: 1 }}>{emoji}</span>

          {/* PRO badge */}
          {course.is_pro && (
            <div style={{
              position: 'absolute',
              top: 10,
              right: 10,
              background: '#F5C842',
              color: '#0C0C0C',
              fontSize: '0.65rem',
              fontWeight: 700,
              borderRadius: 6,
              padding: '0.2rem 0.5rem',
              textTransform: 'uppercase',
              letterSpacing: '0.05em',
            }}>
              PRO
            </div>
          )}

          {/* Lock icon for pro */}
          {course.is_pro && (
            <div style={{
              position: 'absolute',
              bottom: 10,
              right: 10,
              color: 'rgba(255,255,255,0.6)',
            }}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 2a5 5 0 00-5 5v3H5a2 2 0 00-2 2v10a2 2 0 002 2h14a2 2 0 002-2V12a2 2 0 00-2-2h-2V7a5 5 0 00-5-5zm0 2a3 3 0 013 3v3H9V7a3 3 0 013-3zm0 10a2 2 0 110 4 2 2 0 010-4z"/>
              </svg>
            </div>
          )}
        </div>
      </Link>

      {/* Content */}
      <div style={{ padding: '1rem', flex: 1, display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
        {/* Level badge */}
        <span style={{
          fontSize: '0.7rem',
          fontWeight: 600,
          color: levelColor,
          background: `${levelColor}18`,
          border: `1px solid ${levelColor}35`,
          borderRadius: 6,
          padding: '0.2rem 0.55rem',
          display: 'inline-block',
          width: 'fit-content',
          textTransform: 'capitalize',
        }}>
          {level}
        </span>

        {/* Title */}
        <h3 style={{
          fontSize: '0.95rem',
          fontWeight: 600,
          color: 'var(--cream)',
          lineHeight: 1.4,
          display: '-webkit-box',
          WebkitLineClamp: 2,
          WebkitBoxOrient: 'vertical',
          overflow: 'hidden',
        }}>
          {course.title}
        </h3>

        {/* Tags */}
        {course.tags && course.tags.length > 0 && (
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.3rem' }}>
            {course.tags.slice(0, 3).map(tag => (
              <span key={tag} style={{ fontSize: '0.72rem', color: 'var(--text-muted)', background: 'var(--ink)', borderRadius: 5, padding: '0.15rem 0.4rem', border: '1px solid var(--border)' }}>
                #{tag}
              </span>
            ))}
          </div>
        )}

        <div style={{ flex: 1 }} />

        {/* Stats row */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', paddingTop: '0.5rem', borderTop: '1px solid var(--border)' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', fontSize: '0.78rem', color: 'var(--text-muted)' }}>
            {course.enrolled_count && course.enrolled_count > 0 && (
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.2rem' }}>
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
                  <circle cx="9" cy="7" r="4"/>
                  <path d="M23 21v-2a4 4 0 00-3-3.87"/>
                  <path d="M16 3.13a4 4 0 010 7.75"/>
                </svg>
                {course.enrolled_count >= 1000
                  ? `${(course.enrolled_count / 1000).toFixed(0)}K`
                  : course.enrolled_count}
              </span>
            )}
            {course.duration_hours && (
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.2rem' }}>
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <circle cx="12" cy="12" r="10"/>
                  <polyline points="12 6 12 12 16 14"/>
                </svg>
                {Number(course.duration_hours).toFixed(0)}h
              </span>
            )}
          </div>
          {course.instructor_name && (
            <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontWeight: 500 }}>
              {course.instructor_name.split(' ').slice(0, 2).join(' ')}
            </span>
          )}
        </div>

        {/* Enroll button */}
        <button
          onClick={() => onEnroll(course.id)}
          disabled={isEnrolled}
          style={{
            marginTop: '0.75rem',
            padding: '0.5rem 1rem',
            fontSize: '0.85rem',
            fontWeight: 600,
            borderRadius: 8,
            border: 'none',
            cursor: isEnrolled ? 'default' : 'pointer',
            background: isEnrolled ? 'rgba(52,211,153,0.15)' : 'var(--accent)',
            color: isEnrolled ? '#34D399' : 'var(--ink)',
            transition: 'all 0.15s',
            width: '100%',
          }}
        >
          {isEnrolled ? '✓ Enrolled' : 'Enroll'}
        </button>
      </div>
    </div>
  )
}

export default function CoursesClient({ courses }: { courses: Course[] }) {
  const [filter, setFilter] = useState<FilterType>('all')
  const [enrolledCourseIds, setEnrolledCourseIds] = useState<string[]>([])
  const [isLoggedIn, setIsLoggedIn] = useState(false)

  // Check login status and fetch enrollments on mount
  useEffect(() => {
    const checkAuth = async () => {
      try {
        const res = await fetch('/api/enrollments')
        if (res.ok) {
          const data = await res.json()
          setEnrolledCourseIds(data.enrolledCourseIds || [])
          setIsLoggedIn(true)
        } else {
          setIsLoggedIn(false)
        }
      } catch {
        setIsLoggedIn(false)
      }
    }
    checkAuth()
  }, [])

  const filtered = useMemo(() => {
    if (filter === 'free') return courses.filter(c => !c.is_pro)
    if (filter === 'pro') return courses.filter(c => c.is_pro)
    return courses
  }, [courses, filter])

  const handleEnroll = async (courseId: string) => {
    if (!isLoggedIn) {
      window.location.href = '/auth/signup'
      return
    }

    try {
      const res = await fetch('/api/enroll/course', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ courseId }),
      })
      
      if (res.ok) {
        setEnrolledCourseIds(prev => [...prev, courseId])
      }
    } catch (err) {
      console.error('Enrollment failed:', err)
    }
  }

  const tabs: { key: FilterType; label: string }[] = [
    { key: 'all', label: `All (${courses.length})` },
    { key: 'free', label: `Free (${courses.filter(c => !c.is_pro).length})` },
    { key: 'pro', label: `Pro (${courses.filter(c => c.is_pro).length})` },
  ]

  return (
    <>
      {/* Filter Tabs */}
      <div style={{ display: 'flex', gap: '0.25rem', marginBottom: '2rem', borderBottom: '1px solid var(--border)', paddingBottom: '0' }}>
        {tabs.map(tab => (
          <button
            key={tab.key}
            onClick={() => setFilter(tab.key)}
            style={{
              padding: '0.6rem 1.25rem',
              fontSize: '0.9rem',
              fontWeight: filter === tab.key ? 600 : 400,
              color: filter === tab.key ? 'var(--cream)' : 'var(--text-muted)',
              background: 'none',
              border: 'none',
              borderBottom: filter === tab.key ? '2px solid var(--cream)' : '2px solid transparent',
              cursor: 'pointer',
              marginBottom: '-1px',
              transition: 'all 0.15s',
            }}
          >
            {tab.label}
          </button>
        ))}
        <div style={{ flex: 1 }} />
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: 'var(--text-muted)', fontSize: '0.85rem', paddingBottom: '0.6rem' }}>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"/></svg>
          {filtered.length} courses
        </div>
      </div>

      {/* Grid */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))',
        gap: '1.25rem',
      }}>
        {filtered.map((course, i) => (
          <CourseCard 
            key={course.id} 
            course={course} 
            index={i}
            isEnrolled={enrolledCourseIds.includes(course.id)}
            onEnroll={handleEnroll}
          />
        ))}
      </div>

      {filtered.length === 0 && (
        <div style={{ textAlign: 'center', padding: '4rem', color: 'var(--text-muted)' }}>
          No courses found.
        </div>
      )}
    </>
  )
}