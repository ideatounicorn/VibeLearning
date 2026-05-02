import { supabaseServer } from '@/lib/supabase-server'
import CoursesClient from '@/components/courses/CoursesClient'

export const metadata = {
  title: 'Courses — VibeLearn',
  description: 'Browse expert-curated courses across AI, Design, Product, Marketing, and Data.',
}

export default async function CoursesPage() {
  const db = await supabaseServer()

  const { data: courses } = await db
    .from('courses')
    .select(`
      id, title, slug, level, enrolled_count, rating, duration_hours,
      instructor_name, tags, is_pro, is_hidden,
      path:paths (name, slug, category, hero_color)
    `)
    .eq('is_hidden', false)
    .order('enrolled_count', { ascending: false })

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      {/* Header */}
      <div style={{ padding: '3rem 1.5rem 2rem', borderBottom: '1px solid var(--border)' }}>
        <div style={{ maxWidth: 1200, margin: '0 auto' }}>
          <h1 style={{ fontSize: 'clamp(1.8rem, 4vw, 2.8rem)', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem' }}>
            Courses
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '1rem' }}>
            Browse our library of expert-curated courses across design, AI, product, and more.
          </p>
        </div>
      </div>

      {/* Content */}
      <div style={{ padding: '2.5rem 1.5rem', maxWidth: 1200, margin: '0 auto' }}>
        <CoursesClient courses={courses ?? []} />
      </div>
    </div>
  )
}
