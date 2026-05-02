import { supabaseServer } from '@/lib/supabase-server'
import PathsGrid from '@/components/PathsGrid'

export const metadata = {
  title: 'Career Paths — VibeLearn',
  description: 'Choose a career path and learn everything you need to become a professional.',
}

const FAQS = [
  { q: "What is a career path?", a: "A career path is a structured sequence of courses designed to take you from beginner to job-ready in a specific field. Each path includes curated courses, projects, and a certificate of completion." },
  { q: "What do I need to know before starting?", a: "No prior experience is required for most paths. Each path starts with foundational concepts and progressively builds your skills to an industry-ready level." },
  { q: "Which career path is right for me?", a: "Choose based on your interests. If you enjoy problem-solving and technology, try AI or Data. If you love creating experiences, explore Design or Product Management." },
  { q: "How much does a career path cost?", a: "You can start any path for free and access the first two levels of each course. Upgrade to Pro for unlimited access to all paths and courses." },
  { q: "Will this career path help me get a job?", a: "Yes. Each path covers exactly the skills employers look for. Paths end with portfolio-ready projects and an industry-recognized certificate." },
  { q: "Will I earn a certification upon completion?", a: "Yes. Completing a career path awards you a certificate you can share on LinkedIn, your resume, or your portfolio." },
  { q: "How is a career path different from a single course?", a: "Individual courses focus on specific skills. A career path bundles multiple related courses into a complete learning journey designed to get you job-ready." },
]

export default async function PathsPage() {
  const db = await supabaseServer()
  const { data: paths } = await db
    .from('paths')
    .select('*')
    .eq('is_published', true)
    .order('order_index')

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      {/* Header */}
      <div style={{ padding: '3rem 1.5rem 2rem', borderBottom: '1px solid var(--border)' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto' }}>
          <h1 style={{ fontSize: 'clamp(1.8rem, 4vw, 2.8rem)', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem' }}>
            Career Paths
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '1rem' }}>
            Learn all you need to begin a new career as a professional.
          </p>
        </div>
      </div>

      {/* Grid */}
      <div style={{ padding: '3rem 1.5rem' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto' }}>
          <PathsGrid paths={paths ?? []} />
        </div>
      </div>

      {/* FAQ */}
      <div style={{ padding: '3rem 1.5rem', borderTop: '1px solid var(--border)' }}>
        <div style={{ maxWidth: 760, margin: '0 auto' }}>
          <h2 style={{ fontSize: '1.6rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '2rem' }}>FAQs</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0' }}>
            {FAQS.map((faq, i) => (
              <FaqItem key={i} q={faq.q} a={faq.a} />
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}

function FaqItem({ q, a }: { q: string; a: string }) {
  return (
    <details
      style={{
        borderTop: '1px solid var(--border)',
        padding: '1.25rem 0',
      }}
    >
      <summary
        style={{
          fontSize: '1rem',
          fontWeight: 500,
          color: 'var(--cream)',
          cursor: 'pointer',
          listStyle: 'none',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          gap: '1rem',
        }}
      >
        {q}
        <span style={{ color: 'var(--text-muted)', flexShrink: 0, fontSize: '1.25rem', fontWeight: 300 }}>+</span>
      </summary>
      <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.65, marginTop: '0.75rem', paddingRight: '2rem' }}>
        {a}
      </p>
    </details>
  )
}
