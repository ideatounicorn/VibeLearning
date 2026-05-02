import { supabaseServer } from '@/lib/supabase-server'
import AssessmentsGrid from '@/components/assessments/AssessmentsGrid'

export const metadata = {
  title: 'Assessments — VibeLearn',
  description: 'Benchmark your skills and receive personalized learning recommendations.',
}

const ASSESSMENT_FAQS = [
  { q: 'What is a VibeLearn assessment?', a: 'Assessments are standalone skill benchmarks that measure your knowledge in a specific domain. They use a duolingo-style format with hearts (lives) and XP rewards for correct answers.' },
  { q: 'What kind of assessments does VibeLearn offer?', a: 'We offer assessments across Skills (UX, Product, AI, Data, Marketing) and Tools (Figma, SQL). Each assessment adapts to your level and delivers a personalized skill report.' },
  { q: 'How is an assessment different from a course quiz?', a: 'Course quizzes test knowledge from specific modules. Assessments are broader, standalone benchmarks with a game-like format — hearts, XP per question, and a comprehensive score report.' },
  { q: 'What is the cost of taking an assessment?', a: 'Most assessments are free. Pro assessments require a subscription, which unlocks all 5 career paths and every assessment.' },
  { q: 'Why are skill assessments important?', a: 'Assessments give you an objective view of your strengths and gaps, helping you focus your learning where it matters most.' },
  { q: 'Will taking assessments help my career?', a: 'Yes. Completing assessments demonstrates initiative and self-awareness. Your results can guide which career path to pursue and which skills to prioritize.' },
  { q: 'Can I retake an assessment?', a: 'Yes. You can retake assessments as many times as you like. Your best score is saved and displayed on your profile.' },
  { q: 'Are VibeLearn assessments credible for hiring?', a: 'Our assessments are designed around real industry skill standards. They are useful for self-evaluation and for communicating your skills to employers.' },
]

export default async function AssessmentsPage() {
  const db = await supabaseServer()
  const { data: assessments } = await db
    .from('assessments')
    .select('id, title, slug, short_description, category, icon_emoji, icon_bg, duration_minutes, question_count, attempts_count, xp_reward, is_pro')
    .eq('is_published', true)
    .order('order_index')

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)' }}>
      {/* Header */}
      <div style={{ padding: '3rem 1.5rem 2rem', borderBottom: '1px solid var(--border)' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto' }}>
          <h1 style={{ fontSize: 'clamp(1.8rem, 4vw, 2.8rem)', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem' }}>
            Assessments
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '1rem' }}>
            Discover your skill level and receive customized learning recommendations.
          </p>
        </div>
      </div>

      {/* Grid */}
      <div style={{ padding: '3rem 1.5rem' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto' }}>
          <AssessmentsGrid assessments={assessments ?? []} />
        </div>
      </div>

      {/* FAQ */}
      <div style={{ padding: '3rem 1.5rem', borderTop: '1px solid var(--border)' }}>
        <div style={{ maxWidth: 760, margin: '0 auto' }}>
          <h2 style={{ fontSize: '1.6rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '2rem' }}>FAQs</h2>
          <div>
            {ASSESSMENT_FAQS.map((faq, i) => (
              <details key={i} style={{ borderTop: '1px solid var(--border)', padding: '1.25rem 0' }}>
                <summary style={{ fontSize: '1rem', fontWeight: 500, color: 'var(--cream)', cursor: 'pointer', listStyle: 'none', display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: '1rem' }}>
                  {faq.q}
                  <span style={{ color: 'var(--text-muted)', flexShrink: 0, fontSize: '1.25rem', fontWeight: 300 }}>+</span>
                </summary>
                <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.65, marginTop: '0.75rem', paddingRight: '2rem' }}>
                  {faq.a}
                </p>
              </details>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
