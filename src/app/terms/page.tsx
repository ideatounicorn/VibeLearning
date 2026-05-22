import type { Metadata } from 'next'
import Link from 'next/link'

export const metadata: Metadata = {
  title: 'Terms of Service — VibeLearn',
  description: 'Terms and conditions for using the VibeLearn platform.',
}

const EFFECTIVE_DATE = 'May 21, 2026'
const CONTACT_EMAIL = 'hey@vibelearn.app'
const SITE_URL = 'https://vibelearn.app'

export default function TermsPage() {
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
          Terms of Service
        </h1>
        <p style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '3rem' }}>
          Effective date: {EFFECTIVE_DATE}
        </p>

        <div style={{ color: 'var(--muted)', lineHeight: 1.8, fontSize: '0.95rem' }}>

          <Section title="1. Acceptance of terms">
            By accessing or using VibeLearn at{' '}
            <a href={SITE_URL} style={{ color: 'var(--green)' }}>{SITE_URL}</a>,
            you agree to be bound by these Terms of Service. If you do not agree, please do not use the platform.
          </Section>

          <Section title="2. Description of service">
            VibeLearn is a structured online learning platform providing curated YouTube-based career paths,
            quizzes, XP gamification, and certificates. Some features require a paid Pro subscription.
          </Section>

          <Section title="3. Account registration">
            You must be at least 13 years old to create an account. You are responsible for maintaining
            the security of your login credentials. You agree to provide accurate information and keep
            it up to date.
          </Section>

          <Section title="4. Free and Pro tiers">
            <ul style={{ paddingLeft: '1.25rem' }}>
              <li><strong style={{ color: 'var(--cream)' }}>Free tier:</strong> Access to the first 2 modules of each learning path at no charge.</li>
              <li><strong style={{ color: 'var(--cream)' }}>Pro tier:</strong> Monthly subscription (₹330/month) for unlimited course access, certificates, and assessment reports.</li>
              <li>Subscriptions are processed by Polar.sh. A 7-day refund policy applies.</li>
              <li>You may cancel at any time; access continues until end of billing period.</li>
            </ul>
          </Section>

          <Section title="5. Acceptable use">
            You agree not to:
            <ul style={{ paddingLeft: '1.25rem', marginTop: '0.5rem' }}>
              <li>Share your account credentials with others.</li>
              <li>Attempt to circumvent subscription or access controls.</li>
              <li>Use the platform for any unlawful purpose.</li>
              <li>Scrape, copy, or reproduce content without permission.</li>
              <li>Upload malicious code or content.</li>
            </ul>
          </Section>

          <Section title="6. Intellectual property">
            All VibeLearn content, branding, and platform design are owned by VibeLearn.
            Embedded YouTube videos remain the property of their respective creators and are subject
            to YouTube&apos;s Terms of Service. We operate as a licensed YouTube embed, not as a content host.
          </Section>

          <Section title="7. Certificates">
            Certificates are issued for educational completion only and do not constitute
            professional credentials, certifications, or guarantees of employment.
          </Section>

          <Section title="8. Disclaimer of warranties">
            VibeLearn is provided &quot;as is&quot; without warranties of any kind. We do not guarantee
            that the platform will be error-free, uninterrupted, or meet your specific requirements.
          </Section>

          <Section title="9. Limitation of liability">
            To the maximum extent permitted by law, VibeLearn is not liable for indirect, incidental,
            or consequential damages arising from your use of the platform. Our total liability
            shall not exceed the amount you paid us in the 3 months preceding the claim.
          </Section>

          <Section title="10. Termination">
            We reserve the right to suspend or terminate accounts that violate these terms.
            You may delete your account at any time by contacting us.
          </Section>

          <Section title="11. Governing law">
            These terms are governed by the laws of India. Any disputes shall be resolved
            in the courts of Mumbai, India.
          </Section>

          <Section title="12. Changes to terms">
            We may update these terms from time to time. Continued use of the platform after
            changes constitutes acceptance of the updated terms.
          </Section>

          <Section title="13. Contact">
            Questions about these terms? Email us at{' '}
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
