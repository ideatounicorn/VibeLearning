import type { Metadata } from 'next'
import Link from 'next/link'
import { supabaseServer } from '@/lib/supabase-server'
import {
  absoluteUrl,
  breadcrumbJsonLd,
  faqJsonLd,
  jsonLdScriptProps,
  SITE_NAME,
} from '@/lib/seo'

export const revalidate = 3600

export const metadata: Metadata = {
  title: 'VibeLearn for Teams — Upskill your company on AI, Product, Design & more',
  description:
    'Train your whole team on AI, product, design, marketing, and data. Bulk seats, manager dashboards, SSO, skill-gap reports, and shareable certificates. Plans from $19/seat/month.',
  alternates: { canonical: '/teams' },
  openGraph: {
    title: 'VibeLearn for Teams',
    description:
      'Structured career learning for engineering, product, and design teams. Manager dashboards, SSO, certificates.',
    url: '/teams',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'VibeLearn for Teams',
    description: 'Structured career learning for engineering, product, and design teams.',
  },
}

const FAQS = [
  {
    q: 'How does VibeLearn for Teams pricing work?',
    a: 'Teams start at $19 per seat per month, billed annually. Volume discounts at 25, 50, and 100+ seats. Enterprise plans include SSO, dedicated support, and custom learning paths.',
  },
  {
    q: 'Can we use SSO and SCIM?',
    a: 'Yes — Enterprise plans include SAML SSO, SCIM provisioning, and audit logs. Teams plans include Google and Microsoft sign-in.',
  },
  {
    q: 'Do you offer custom learning paths for our team?',
    a: 'Yes. We work with L&D and engineering managers to assemble custom paths from our catalog — for example, an internal "AI for PMs" or "Vibe coding for engineers" rollout.',
  },
  {
    q: 'How is progress tracked?',
    a: 'Managers get a dashboard with seat-level progress, completion rates, quiz scores, and skill-gap heatmaps. Reports can be exported as CSV or pushed to your BI stack.',
  },
  {
    q: 'How quickly can we onboard?',
    a: 'Self-serve teams (under 25 seats) can launch in under 10 minutes. Enterprise rollouts with SSO typically go live within a week.',
  },
  {
    q: 'Do you offer a free pilot?',
    a: 'Yes — free 14-day pilot with up to 10 seats. Talk to sales to set one up.',
  },
]

const TIERS = [
  {
    name: 'Team',
    price: '$19',
    unit: '/seat/month',
    cta: 'Start free pilot',
    href: 'mailto:sales@vibelearn.app?subject=Team%20pilot',
    description: 'For startups and growing teams (5–50 seats).',
    features: [
      '5+ seats, billed annually',
      'All career paths & courses',
      'Manager dashboard',
      'Google & Microsoft SSO',
      'Team certificates',
      'CSV progress exports',
    ],
    accent: false,
  },
  {
    name: 'Business',
    price: '$15',
    unit: '/seat/month',
    cta: 'Talk to sales',
    href: 'mailto:sales@vibelearn.app?subject=Business%20plan',
    description: 'For scaling companies (50–500 seats).',
    features: [
      'Everything in Team',
      'Skill-gap reports',
      'Custom learning paths',
      'Slack integration',
      'Quarterly business reviews',
      'Priority support',
    ],
    accent: true,
  },
  {
    name: 'Enterprise',
    price: 'Custom',
    unit: '',
    cta: 'Contact sales',
    href: 'mailto:sales@vibelearn.app?subject=Enterprise',
    description: 'For 500+ seats with security & compliance needs.',
    features: [
      'Everything in Business',
      'SAML SSO + SCIM',
      'Audit logs & DPA',
      'Dedicated CSM',
      'Custom integrations',
      'Volume discounts',
    ],
    accent: false,
  },
]

const LOGOS = ['Deloitte', 'Dropbox', 'TikTok', 'Paypal', 'Unicef', 'IBM', 'Firestone']

export default async function TeamsPage() {
  const db = await supabaseServer()
  const { data: paths } = await db
    .from('paths')
    .select('name, slug, description, category, total_hours, total_modules')
    .eq('is_published', true)
    .order('order_index')

  const crumbs = breadcrumbJsonLd([
    { name: 'Home', url: '/' },
    { name: 'For Teams', url: '/teams' },
  ])
  const faqSchema = faqJsonLd(FAQS)
  const productSchema = {
    '@context': 'https://schema.org',
    '@type': 'Product',
    name: `${SITE_NAME} for Teams`,
    description:
      'B2B learning platform for AI, product, design, marketing, and data teams. Manager dashboards, SSO, skill tracking, certificates.',
    brand: { '@type': 'Brand', name: SITE_NAME },
    offers: {
      '@type': 'AggregateOffer',
      lowPrice: '15',
      highPrice: '19',
      priceCurrency: 'USD',
      offerCount: 3,
    },
  }

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)', color: 'var(--cream)' }}>
      <script {...jsonLdScriptProps(productSchema)} />
      <script {...jsonLdScriptProps(crumbs)} />
      <script {...jsonLdScriptProps(faqSchema)} />
      <link rel="canonical" href={absoluteUrl('/teams')} />

      {/* Hero */}
      <section style={{ maxWidth: 1100, margin: '0 auto', padding: '5rem 1.5rem 3rem', textAlign: 'center' }}>
        <div style={{ display: 'inline-block', fontSize: '0.75rem', fontWeight: 700, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '1rem', padding: '0.3rem 0.75rem', border: '1px solid var(--border)', borderRadius: 999 }}>
          VibeLearn for Teams
        </div>
        <h1 style={{ fontSize: 'clamp(2rem, 5vw, 3.4rem)', fontWeight: 700, lineHeight: 1.1, marginBottom: '1.25rem' }}>
          Upskill your team on AI, product, and design — without the corporate-training tax.
        </h1>
        <p style={{ fontSize: '1.1rem', color: 'var(--text-muted)', lineHeight: 1.6, maxWidth: 720, margin: '0 auto 2rem' }}>
          Structured career paths, real outcomes, manager dashboards, SSO, and shareable certificates. From $19 per seat — not $499.
        </p>
        <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'center', flexWrap: 'wrap' }}>
          <a href="mailto:sales@vibelearn.app?subject=Team%20pilot" style={{
            background: 'var(--accent)', color: 'var(--ink)', fontWeight: 700,
            fontSize: '1rem', padding: '0.85rem 1.75rem', borderRadius: 12, textDecoration: 'none',
          }}>
            Start free pilot
          </a>
          <a href="#pricing" style={{
            background: 'transparent', color: 'var(--cream)', fontWeight: 600,
            fontSize: '1rem', padding: '0.85rem 1.75rem', borderRadius: 12,
            textDecoration: 'none', border: '1px solid var(--border)',
          }}>
            See pricing
          </a>
        </div>
        <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginTop: '1rem' }}>
          Free 14-day pilot. No credit card. Up to 10 seats.
        </p>
      </section>

      {/* Logo strip */}
      <section style={{ borderTop: '1px solid var(--border)', borderBottom: '1px solid var(--border)', padding: '2rem 1.5rem' }}>
        <div style={{ maxWidth: 1100, margin: '0 auto', textAlign: 'center' }}>
          <p style={{ fontSize: '0.82rem', color: 'var(--text-muted)', marginBottom: '1rem' }}>
            Trusted by learners at
          </p>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1.5rem', justifyContent: 'center' }}>
            {LOGOS.map(l => (
              <span key={l} style={{
                fontSize: '0.85rem', fontWeight: 700, color: 'var(--text-muted)',
                letterSpacing: '0.05em', textTransform: 'uppercase',
                padding: '0.5rem 1rem', border: '1px solid var(--border)', borderRadius: 8,
              }}>{l}</span>
            ))}
          </div>
        </div>
      </section>

      {/* Value props */}
      <section style={{ maxWidth: 1100, margin: '0 auto', padding: '4rem 1.5rem' }}>
        <h2 style={{ fontSize: 'clamp(1.5rem, 3vw, 2.2rem)', fontWeight: 700, marginBottom: '0.75rem', textAlign: 'center' }}>
          The fastest way to roll out modern career training
        </h2>
        <p style={{ color: 'var(--text-muted)', textAlign: 'center', maxWidth: 680, margin: '0 auto 2.5rem', lineHeight: 1.6 }}>
          Built for engineering, product, and design orgs that need real outcomes — not 6-hour PDFs from 2018.
        </p>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: '1rem' }}>
          {[
            { icon: '🎯', title: 'Role-based paths', text: 'AI Engineer, AI PM, UX Designer, Growth Marketer, Data Analyst — each a complete 4–8 week path.' },
            { icon: '📊', title: 'Manager dashboards', text: 'See progress per seat, completion rates, quiz scores, and skill-gap heatmaps in one view.' },
            { icon: '🔐', title: 'SSO & SCIM', text: 'SAML SSO and SCIM provisioning on Enterprise. Google & Microsoft sign-in on Team plans.' },
            { icon: '🏆', title: 'Real certificates', text: 'Shareable, verifiable certificates your team can post on LinkedIn — drives retention and brand pull.' },
            { icon: '⚡', title: 'Live curriculum', text: 'Curated from the best practitioners working today. Updated continuously, not annually.' },
            { icon: '💸', title: 'Honest pricing', text: 'From $19/seat/month. No 5-figure annual contracts. No surprise add-ons.' },
          ].map(card => (
            <div key={card.title} style={{
              background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 16, padding: '1.5rem',
            }}>
              <div style={{ fontSize: '1.75rem', marginBottom: '0.5rem' }}>{card.icon}</div>
              <h3 style={{ fontSize: '1.05rem', fontWeight: 700, marginBottom: '0.4rem' }}>{card.title}</h3>
              <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.6 }}>{card.text}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Paths available to teams */}
      {paths && paths.length > 0 && (
        <section style={{ background: 'var(--surface)', borderTop: '1px solid var(--border)', borderBottom: '1px solid var(--border)' }}>
          <div style={{ maxWidth: 1100, margin: '0 auto', padding: '4rem 1.5rem' }}>
            <h2 style={{ fontSize: 'clamp(1.5rem, 3vw, 2.2rem)', fontWeight: 700, marginBottom: '0.75rem', textAlign: 'center' }}>
              Paths your team can roll out today
            </h2>
            <p style={{ color: 'var(--text-muted)', textAlign: 'center', maxWidth: 680, margin: '0 auto 2.5rem', lineHeight: 1.6 }}>
              Mix and match across {paths.length} role-based paths. Custom paths available on Business and Enterprise.
            </p>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: '1rem' }}>
              {paths.map(p => (
                <Link key={p.slug} href={`/paths/${p.slug}`} style={{ textDecoration: 'none' }}>
                  <div style={{
                    background: 'var(--ink)', border: '1px solid var(--border)', borderRadius: 16, padding: '1.5rem', height: '100%',
                  }}>
                    <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '0.5rem' }}>
                      {p.category}
                    </div>
                    <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.4rem' }}>{p.name}</h3>
                    <p style={{ color: 'var(--text-muted)', fontSize: '0.88rem', lineHeight: 1.55, marginBottom: '0.75rem' }}>
                      {p.description}
                    </p>
                    <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                      {p.total_modules ? `${p.total_modules} modules` : 'Multi-module'}
                      {p.total_hours ? ` · ${p.total_hours}h` : ''}
                    </div>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Pricing */}
      <section id="pricing" style={{ maxWidth: 1100, margin: '0 auto', padding: '4rem 1.5rem' }}>
        <h2 style={{ fontSize: 'clamp(1.5rem, 3vw, 2.2rem)', fontWeight: 700, marginBottom: '0.75rem', textAlign: 'center' }}>
          Team pricing
        </h2>
        <p style={{ color: 'var(--text-muted)', textAlign: 'center', marginBottom: '2.5rem' }}>
          Annual billing. Volume discounts kick in at 25 seats.
        </p>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '1rem' }}>
          {TIERS.map(t => (
            <div key={t.name} style={{
              background: t.accent ? 'linear-gradient(180deg, var(--surface), var(--ink))' : 'var(--surface)',
              border: t.accent ? '2px solid var(--accent)' : '1px solid var(--border)',
              borderRadius: 20, padding: '2rem', position: 'relative',
            }}>
              {t.accent && (
                <div style={{ position: 'absolute', top: -12, left: '50%', transform: 'translateX(-50%)', background: 'var(--accent)', color: 'var(--ink)', fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em', padding: '0.3rem 0.75rem', borderRadius: 999 }}>
                  Most popular
                </div>
              )}
              <h3 style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '0.4rem' }}>{t.name}</h3>
              <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', lineHeight: 1.5, marginBottom: '1rem' }}>
                {t.description}
              </p>
              <div style={{ marginBottom: '1.25rem' }}>
                <span style={{ fontSize: '2.25rem', fontWeight: 700 }}>{t.price}</span>
                <span style={{ color: 'var(--text-muted)', fontSize: '0.95rem' }}>{t.unit}</span>
              </div>
              <a href={t.href} style={{
                display: 'block', textAlign: 'center', marginBottom: '1.25rem',
                background: t.accent ? 'var(--accent)' : 'transparent',
                color: t.accent ? 'var(--ink)' : 'var(--cream)',
                fontWeight: 700, fontSize: '0.9rem', padding: '0.7rem',
                borderRadius: 10, textDecoration: 'none',
                border: t.accent ? 'none' : '1px solid var(--border)',
              }}>
                {t.cta}
              </a>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                {t.features.map(f => (
                  <div key={f} style={{ display: 'flex', gap: '0.5rem', alignItems: 'flex-start', fontSize: '0.85rem', color: 'var(--text-muted)' }}>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#34D399" strokeWidth="2.5" style={{ marginTop: 3, flexShrink: 0 }}>
                      <polyline points="20 6 9 17 4 12"/>
                    </svg>
                    <span>{f}</span>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* FAQ */}
      <section style={{ background: 'var(--surface)', borderTop: '1px solid var(--border)' }}>
        <div style={{ maxWidth: 820, margin: '0 auto', padding: '4rem 1.5rem' }}>
          <h2 style={{ fontSize: 'clamp(1.5rem, 3vw, 2.2rem)', fontWeight: 700, marginBottom: '2rem', textAlign: 'center' }}>
            Frequently asked questions
          </h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
            {FAQS.map((f, i) => (
              <details key={i} open={i === 0} style={{
                background: 'var(--ink)', border: '1px solid var(--border)',
                borderRadius: 12, padding: '1rem 1.25rem',
              }}>
                <summary style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--cream)', cursor: 'pointer', listStyle: 'none' }}>
                  {f.q}
                </summary>
                <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.65, marginTop: '0.75rem' }}>
                  {f.a}
                </p>
              </details>
            ))}
          </div>
        </div>
      </section>

      {/* Final CTA */}
      <section style={{ background: 'var(--cream)', padding: '4rem 1.5rem', textAlign: 'center' }}>
        <div style={{ maxWidth: 720, margin: '0 auto' }}>
          <h2 style={{ fontSize: 'clamp(1.5rem, 3vw, 2.2rem)', fontWeight: 700, color: 'var(--ink)', marginBottom: '1rem' }}>
            Ready to roll out modern training?
          </h2>
          <p style={{ color: 'var(--ink)', opacity: 0.75, marginBottom: '1.5rem', lineHeight: 1.6 }}>
            Free 14-day pilot. No credit card. Live in 10 minutes.
          </p>
          <a href="mailto:sales@vibelearn.app?subject=Team%20pilot" style={{
            background: 'var(--ink)', color: 'var(--cream)', fontWeight: 700,
            fontSize: '1rem', padding: '0.85rem 1.75rem', borderRadius: 12, textDecoration: 'none',
          }}>
            Start your pilot
          </a>
        </div>
      </section>
    </div>
  )
}
