'use client'

import Link from 'next/link'

interface Course {
  slug: string
  name: string
  category: string
  description: string
  color: string
  emoji: string
  modules: number
  hours: number
}

interface RecommendedCoursesProps {
  courses: Course[]
  pathSlug: string | null
}

const ALL_COURSES: Course[] = [
  { slug: 'ai-product-building', name: 'AI Product Building', category: 'AI', description: 'Build real AI products, not just prompts.', color: '#6366F1', emoji: '🤖', modules: 24, hours: 40 },
  { slug: 'ux-design', name: 'UX Design', category: 'Design', description: 'Design flows that feel obvious.', color: '#C084FC', emoji: '🎨', modules: 18, hours: 32 },
  { slug: 'product-management', name: 'Product Management', category: 'Product', description: 'Ship products people actually want.', color: '#F5C842', emoji: '📦', modules: 22, hours: 38 },
  { slug: 'digital-marketing', name: 'Digital Marketing', category: 'Marketing', description: 'Growth, content, ads, and SEO.', color: '#FB923C', emoji: '📈', modules: 20, hours: 35 },
]

export function RecommendedCourses({ pathSlug }: RecommendedCoursesProps) {
  const recommended = pathSlug
    ? ALL_COURSES.filter(c => c.slug === pathSlug || c.category !== 'Data').slice(0, 3)
    : ALL_COURSES.slice(0, 3)

  return (
    <div>
      <h2 style={{ fontSize: '1.1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '1rem' }}>
        Recommended for You
      </h2>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '1rem' }}>
        {recommended.map(course => (
          <Link
            key={course.slug}
            href={`/paths/${course.slug}`}
            style={{ textDecoration: 'none' }}
          >
            <div
              style={{
                background: 'var(--surface)',
                border: '1px solid var(--border)',
                borderRadius: 14,
                padding: '1.25rem',
                cursor: 'pointer',
                transition: 'border-color 0.15s',
                position: 'relative',
                overflow: 'hidden',
              }}
              onMouseEnter={e => (e.currentTarget.style.borderColor = 'color-mix(in srgb, var(--accent) 40%, transparent)')}
              onMouseLeave={e => (e.currentTarget.style.borderColor = 'var(--border)')}
            >
              <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: 3, background: course.color, borderRadius: '14px 14px 0 0' }} />
              <div style={{ fontSize: '2rem', marginBottom: '0.75rem' }}>{course.emoji}</div>
              <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.3rem' }}>
                {course.category}
              </div>
              <h3 style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.4rem' }}>
                {course.name}
              </h3>
              <p style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: '0.75rem', lineHeight: 1.4 }}>
                {course.description}
              </p>
              <div style={{ display: 'flex', gap: '0.75rem', fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                <span>📚 {course.modules} modules</span>
                <span>⏱ {course.hours}h</span>
              </div>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}
