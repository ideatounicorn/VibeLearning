'use client'

import Link from 'next/link'

interface ActiveLesson {
  id: string
  title: string
  module: {
    id: string
    course: { slug: string; name: string } | null
  } | null
}

interface ContinueLearningProps {
  activeLesson: ActiveLesson | null
  pathName: string | null
  pathSlug?: string | null
}

export function ContinueLearning({ activeLesson, pathName, pathSlug }: ContinueLearningProps) {
  if (!activeLesson || !activeLesson.module?.course) {
    return (
      <div
        style={{
          background: 'var(--surface)',
          border: '1.5px dashed var(--border)',
          borderRadius: 16,
          padding: '2.5rem 2rem',
          textAlign: 'center',
          marginBottom: '1.5rem',
        }}
      >
        <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>🎯</div>
        <h2 style={{ fontSize: '1.25rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.5rem' }}>
          {pathSlug ? "Your Course 1 is ready to start" : "Ready to start learning?"}
        </h2>
        <p style={{ color: 'var(--text-muted)', marginBottom: '1.5rem', fontSize: '0.95rem' }}>
          {pathSlug
            ? "You're enrolled and your roadmap is set. Start your first lesson now — it's free."
            : "Pick a course from your path and start your first lesson."}
        </p>
        <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'center', alignItems: 'center', flexWrap: 'wrap' }}>
          <Link
            href={pathSlug ? `/paths/${pathSlug}` : '/paths'}
            className="btn-primary"
            style={{ fontSize: '0.9rem' }}
          >
            {pathSlug ? '▶ Start Course 1' : 'Browse Courses'}
          </Link>
          <span style={{ color: 'var(--text-muted)', fontSize: '0.85rem' }}>
            🟢 1,200+ people learning right now
          </span>
        </div>
      </div>
    )
  }

  const course = activeLesson.module.course

  return (
    <div
      style={{
        background: 'var(--surface)',
        border: '1.5px solid var(--border)',
        borderRadius: 16,
        padding: '1.75rem',
        marginBottom: '1.5rem',
        position: 'relative',
        overflow: 'hidden',
      }}
    >
      <div
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          bottom: 0,
          width: 4,
          background: 'var(--accent)',
          borderRadius: '4px 0 0 4px',
        }}
      />
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: '1rem' }}>
        <div style={{ flex: 1 }}>
          <div style={{ color: 'var(--text-muted)', fontSize: '0.78rem', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.4rem' }}>
            Continue Learning
          </div>
          <h2 style={{ fontSize: '1.2rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            {course.name}
          </h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>
            {activeLesson.title}
          </p>
          {pathName && (
            <div style={{ marginTop: '0.5rem' }}>
              <span style={{ fontSize: '0.8rem', color: 'var(--accent)', fontWeight: 500 }}>
                📍 {pathName}
              </span>
            </div>
          )}
        </div>
        <Link
          href={`/learn/${course.slug}/${activeLesson.module.id}`}
          className="btn-primary"
          style={{ fontSize: '0.9rem', whiteSpace: 'nowrap', flexShrink: 0 }}
        >
          ▶ Resume
        </Link>
      </div>
    </div>
  )
}
