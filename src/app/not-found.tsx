import Link from 'next/link'

export default function NotFound() {
  return (
    <div
      style={{
        minHeight: '100vh',
        background: 'var(--ink)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '2rem',
        textAlign: 'center',
      }}
    >
      <div style={{ maxWidth: 480 }}>
        {/* Large 404 number */}
        <div
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(5rem, 20vw, 10rem)',
            fontWeight: 400,
            color: 'var(--green)',
            lineHeight: 1,
            marginBottom: '0.5rem',
            opacity: 0.9,
          }}
        >
          404
        </div>

        <h1
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(1.5rem, 4vw, 2.2rem)',
            color: 'var(--cream)',
            marginBottom: '0.75rem',
            fontWeight: 400,
          }}
        >
          This page doesn&apos;t exist.
        </h1>

        <p
          style={{
            color: 'var(--muted)',
            fontSize: '1rem',
            lineHeight: 1.65,
            marginBottom: '2.5rem',
          }}
        >
          The URL you followed may be broken, or the page may have been moved.
          Let&apos;s get you back on track.
        </p>

        <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'center', flexWrap: 'wrap' }}>
          <Link href="/" className="btn-primary" style={{ fontSize: '0.95rem', padding: '0.7rem 1.75rem' }}>
            Go home →
          </Link>
          <Link href="/paths" className="btn-outline" style={{ fontSize: '0.95rem', padding: '0.7rem 1.75rem' }}>
            Browse paths
          </Link>
        </div>
      </div>
    </div>
  )
}
