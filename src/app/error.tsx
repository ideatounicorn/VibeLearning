'use client'

import { useEffect } from 'react'

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  useEffect(() => {
    // Log to console in development; in production wire to Sentry / error tracker
    console.error('Uncaught error:', error)
  }, [error])

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
        <div style={{ fontSize: '3.5rem', marginBottom: '1rem' }}>⚡</div>

        <h2
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(1.5rem, 4vw, 2rem)',
            color: 'var(--cream)',
            marginBottom: '0.75rem',
            fontWeight: 400,
          }}
        >
          Something went wrong.
        </h2>

        <p
          style={{
            color: 'var(--muted)',
            fontSize: '0.95rem',
            lineHeight: 1.65,
            marginBottom: '2rem',
          }}
        >
          An unexpected error occurred. Our team has been notified.
          Try refreshing the page or head back home.
        </p>

        {error.digest && (
          <p
            style={{
              color: 'var(--muted)',
              fontSize: '0.78rem',
              fontFamily: 'monospace',
              marginBottom: '1.75rem',
              opacity: 0.6,
            }}
          >
            Error ID: {error.digest}
          </p>
        )}

        <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'center', flexWrap: 'wrap' }}>
          <button
            onClick={reset}
            className="btn-primary"
            style={{ fontSize: '0.95rem', padding: '0.7rem 1.75rem' }}
          >
            Try again
          </button>
          <a
            href="/"
            className="btn-outline"
            style={{ fontSize: '0.95rem', padding: '0.7rem 1.75rem', textDecoration: 'none' }}
          >
            Go home
          </a>
        </div>
      </div>
    </div>
  )
}
