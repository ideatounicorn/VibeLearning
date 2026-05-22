import Link from 'next/link'
import { CATEGORY_GRADIENTS } from '@/lib/category-constants'

export interface EnrolledCourse {
  courseId: string
  title: string
  slug: string
  pathName: string
  pathCategory: string
  progressTotal: number
  progressCompleted: number
  lastLessonHref: string | null
  hasStarted: boolean
}

interface Props {
  courses: EnrolledCourse[]
  pathSlug: string | null
}

export function EnrolledCoursesBlock({ courses, pathSlug }: Props) {
  if (courses.length === 0) {
    return (
      <div
        style={{
          background: 'var(--surface)',
          border: '1.5px dashed var(--border)',
          borderRadius: 16,
          padding: '2rem',
          textAlign: 'center',
          marginBottom: '1.5rem',
        }}
      >
        <div style={{ fontSize: '2rem', marginBottom: '0.75rem' }}>🎯</div>
        <h3 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.4rem' }}>
          No courses enrolled yet
        </h3>
        <p style={{ color: 'var(--text-muted)', fontSize: '0.875rem', marginBottom: '1.25rem' }}>
          Pick a path and start your first course — it's free.
        </p>
        <Link
          href={pathSlug ? `/paths/${pathSlug}` : '/paths'}
          className="btn-primary"
          style={{ fontSize: '0.875rem' }}
        >
          {pathSlug ? 'Start Course 1 →' : 'Browse paths →'}
        </Link>
      </div>
    )
  }

  return (
    <div style={{ marginBottom: '1.5rem' }}>
      <h3
        style={{
          fontSize: '0.8rem',
          fontWeight: 700,
          color: 'var(--text-muted)',
          textTransform: 'uppercase',
          letterSpacing: '0.07em',
          marginBottom: '0.75rem',
        }}
      >
        Continue Learning
      </h3>
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))',
          gap: '0.75rem',
        }}
      >
        {courses.map(c => {
          const pct = c.progressTotal > 0
            ? Math.round((c.progressCompleted / c.progressTotal) * 100)
            : 0
          const [g1, g2] = CATEGORY_GRADIENTS[c.pathCategory] ?? CATEGORY_GRADIENTS.AI
          const href = c.lastLessonHref ?? `/course-intro/${c.slug}`

          return (
            <div
              key={c.courseId}
              style={{
                background: 'var(--surface)',
                border: '1px solid var(--border)',
                borderRadius: 14,
                overflow: 'hidden',
              }}
            >
              {/* Category color bar */}
              <div
                style={{
                  height: 3,
                  background: `linear-gradient(90deg, ${g1}, ${g2})`,
                }}
              />

              <div style={{ padding: '1rem' }}>
                {/* Path label */}
                <div
                  style={{
                    fontSize: '0.68rem',
                    fontWeight: 700,
                    color: g1,
                    textTransform: 'uppercase',
                    letterSpacing: '0.06em',
                    marginBottom: '0.35rem',
                  }}
                >
                  {c.pathName}
                </div>

                {/* Course title */}
                <div
                  style={{
                    fontSize: '0.9rem',
                    fontWeight: 600,
                    color: 'var(--text-primary)',
                    lineHeight: 1.35,
                    marginBottom: '0.85rem',
                  }}
                >
                  {c.title}
                </div>

                {/* Progress */}
                <div style={{ marginBottom: '0.75rem' }}>
                  <div
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      fontSize: '0.72rem',
                      color: 'var(--text-muted)',
                      marginBottom: '0.35rem',
                    }}
                  >
                    <span>{c.progressCompleted}/{c.progressTotal} modules</span>
                    <span style={{ fontWeight: 600, color: 'var(--text-primary)' }}>{pct}%</span>
                  </div>
                  <div
                    style={{
                      height: 4,
                      background: 'var(--border)',
                      borderRadius: 999,
                      overflow: 'hidden',
                    }}
                  >
                    <div
                      style={{
                        height: '100%',
                        borderRadius: 999,
                        width: `${pct}%`,
                        background: `linear-gradient(90deg, ${g1}, ${g2})`,
                        transition: 'width 0.6s ease',
                      }}
                    />
                  </div>
                </div>

                {/* CTA */}
                <Link
                  href={href}
                  style={{
                    display: 'block',
                    textAlign: 'center',
                    fontSize: '0.8rem',
                    fontWeight: 600,
                    padding: '0.45rem',
                    borderRadius: 8,
                    textDecoration: 'none',
                    background: `color-mix(in srgb, ${g1} 12%, transparent)`,
                    color: g1,
                    border: `1px solid color-mix(in srgb, ${g1} 28%, transparent)`,
                  }}
                >
                  {c.hasStarted ? 'Continue learning →' : 'Start learning →'}
                </Link>
              </div>
            </div>
          )
        })}
      </div>
    </div>
  )
}
