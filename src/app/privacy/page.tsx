import type { Metadata } from 'next'
import Link from 'next/link'

export const metadata: Metadata = {
  title: 'Privacy Policy — VibeLearn',
  description: 'How VibeLearn collects, uses, and protects your personal data.',
}

const EFFECTIVE_DATE = 'May 21, 2026'
const CONTACT_EMAIL = 'hey@vibelearn.app'
const SITE_URL = 'https://vibelearn.app'

export default function PrivacyPage() {
  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)', padding: '4rem 1.5rem' }}>
      <div style={{ maxWidth: 740, margin: '0 auto' }}>
        {/* Breadcrumb */}
        <Link
          href="/"
          style={{ color: 'var(--muted)', fontSize: '0.85rem', textDecoration: 'none', display: 'inline-flex', alignItems: 'center', gap: '0.35rem', marginBottom: '2.5rem' }}
        >
          ← Back to VibeLearn
        </Link>

        <h1
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(2rem, 5vw, 3rem)',
            color: 'var(--cream)',
            fontWeight: 400,
            marginBottom: '0.5rem',
          }}
        >
          Privacy Policy
        </h1>
        <p style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '3rem' }}>
          Effective date: {EFFECTIVE_DATE}
        </p>

        <div style={{ color: 'var(--muted)', lineHeight: 1.8, fontSize: '0.95rem' }}>

          <Section title="1. Who we are">
            VibeLearn (&quot;we,&quot; &quot;our,&quot; or &quot;us&quot;) operates the learning platform at{' '}
            <a href={SITE_URL} style={{ color: 'var(--green)' }}>{SITE_URL}</a>.
            We are committed to protecting your privacy.
          </Section>

          <Section title="2. Information we collect">
            <ul style={{ paddingLeft: '1.25rem' }}>
              <li><strong style={{ color: 'var(--cream)' }}>Account data:</strong> Name and email address when you sign up.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Learning data:</strong> Lesson progress, quiz scores, XP, streaks, and bookmarks.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Payment data:</strong> Subscription status managed by Polar.sh. We do not store card details.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Usage data:</strong> Pages visited and actions taken, collected via analytics tools.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Device data:</strong> Browser type and operating system for technical support.</li>
            </ul>
          </Section>

          <Section title="3. How we use your information">
            <ul style={{ paddingLeft: '1.25rem' }}>
              <li>To provide and improve the VibeLearn platform.</li>
              <li>To send transactional emails (welcome, streak reminders, certificates).</li>
              <li>To process subscription payments via Polar.sh.</li>
              <li>To analyze usage patterns and improve course recommendations.</li>
              <li>To comply with legal obligations.</li>
            </ul>
          </Section>

          <Section title="4. Sharing your information">
            We do not sell your personal data. We share data only with:
            <ul style={{ paddingLeft: '1.25rem', marginTop: '0.5rem' }}>
              <li><strong style={{ color: 'var(--cream)' }}>Supabase</strong> — database and authentication hosting.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Polar.sh</strong> — subscription and payment processing.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Resend</strong> — transactional email delivery.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Google (Gemini AI)</strong> — AI-generated flashcard content (no personal data shared).</li>
            </ul>
          </Section>

          <Section title="5. Cookies">
            We use session cookies for authentication (via Supabase) and may use analytics cookies.
            No advertising cookies are used.
          </Section>

          <Section title="6. Data retention">
            We retain your account data for as long as your account is active. You may request deletion at any time.
          </Section>

          <Section title="7. Your rights">
            Depending on your location you may have rights to access, correct, or delete your personal data.
            Contact us at{' '}
            <a href={`mailto:${CONTACT_EMAIL}`} style={{ color: 'var(--green)' }}>{CONTACT_EMAIL}</a>{' '}
            to exercise these rights.
          </Section>

          <Section title="8. Security">
            We use industry-standard security practices including encrypted connections (HTTPS) and
            row-level security on our database. However, no system is 100% secure.
          </Section>

          <Section title="9. Children">
            VibeLearn is not directed to children under 13. We do not knowingly collect data from children.
          </Section>

          <Section title="10. Changes to this policy">
            We may update this policy. Significant changes will be communicated via email or a notice on the platform.
          </Section>

          <Section title="11. Contact">
            Questions? Email us at{' '}
            <a href={`mailto:${CONTACT_EMAIL}`} style={{ color: 'var(--green)' }}>{CONTACT_EMAIL}</a>.
          </Section>
        </div>
      </div>
    </div>
  )
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div style={{ marginBottom: '2rem' }}>
      <h2 style={{ fontSize: '1.05rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.6rem' }}>
        {title}
      </h2>
      <div>{children}</div>
    </div>
  )
}
