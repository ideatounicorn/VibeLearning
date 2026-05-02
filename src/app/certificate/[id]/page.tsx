import { notFound } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import CertificateDesign from '@/components/certificate/CertificateDesign'
import Link from 'next/link'

interface Props {
  params: Promise<{ id: string }>
}

export async function generateMetadata({ params }: Props) {
  const { id } = await params
  const db = await supabaseServer()
  const { data: cert } = await db
    .from('certificates')
    .select('recipient_name, reference_name, type')
    .eq('id', id)
    .single()

  if (!cert) return { title: 'Certificate — VibeLearn' }

  return {
    title: `${cert.recipient_name}'s ${cert.reference_name} Certificate — VibeLearn`,
    description: `${cert.recipient_name} earned a VibeLearn certificate for completing ${cert.reference_name}.`,
    openGraph: {
      title: `${cert.recipient_name} completed ${cert.reference_name}`,
      description: `Verified VibeLearn certificate of ${cert.type === 'path' ? 'career readiness' : 'completion'}.`,
    },
  }
}

export default async function CertificatePage({ params }: Props) {
  const { id } = await params
  const db = await supabaseServer()

  const { data: cert } = await db
    .from('certificates')
    .select('*')
    .eq('id', id)
    .single()

  if (!cert) notFound()

  const shareUrl = `${process.env.NEXT_PUBLIC_BASE_URL ?? 'https://vibelearn.com'}/certificate/${id}`

  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)', padding: '2rem 1.5rem' }}>
      <div style={{ maxWidth: 900, margin: '0 auto' }}>
        {/* Back link */}
        <div style={{ marginBottom: '2rem' }}>
          <Link href="/" style={{ color: 'var(--text-muted)', fontSize: '0.85rem', textDecoration: 'none', display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}>
            ← vibelearn.com
          </Link>
        </div>

        {/* Header */}
        <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
          <div style={{ fontSize: '0.75rem', fontWeight: 700, letterSpacing: '0.15em', textTransform: 'uppercase', color: 'var(--accent)', marginBottom: '0.5rem' }}>
            Verified Certificate
          </div>
          <h1 style={{ fontSize: 'clamp(1.4rem, 3vw, 2rem)', fontWeight: 700, color: 'var(--cream)', margin: 0 }}>
            {cert.recipient_name} earned a certificate
          </h1>
          <p style={{ color: 'var(--text-muted)', marginTop: '0.5rem', fontSize: '0.95rem' }}>
            {cert.type === 'path'
              ? `Completed the full ${cert.reference_name} career path`
              : `Completed ${cert.reference_name}`}
          </p>
        </div>

        <CertificateDesign
          recipientName={cert.recipient_name ?? 'Learner'}
          certificateType={cert.type}
          referenceName={cert.reference_name}
          issuedAt={cert.issued_at}
          certificateNumber={cert.certificate_number}
          showShareButtons={true}
          shareUrl={shareUrl}
        />

        {/* CTA */}
        <div style={{ textAlign: 'center', marginTop: '2.5rem', padding: '1.5rem', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 16 }}>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '1rem' }}>
            Want to earn your own certificate?
          </p>
          <Link href="/paths" style={{
            background: 'var(--accent)', color: 'var(--ink)', fontWeight: 700,
            fontSize: '0.95rem', padding: '0.75rem 1.75rem', borderRadius: 10,
            textDecoration: 'none', display: 'inline-block',
          }}>
            Explore career paths →
          </Link>
        </div>
      </div>
    </div>
  )
}
