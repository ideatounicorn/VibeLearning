'use client'

import { useRef } from 'react'

interface CertificateProps {
  recipientName: string
  certificateType: 'course' | 'path' | 'assessment'
  referenceName: string
  issuedAt: string
  certificateNumber: string
  showShareButtons?: boolean
  shareUrl?: string
}

const CATEGORY_COLORS: Record<string, [string, string]> = {
  course:      ['#6366F1', '#818CF8'],
  path:        ['#F5C842', '#FDE68A'],
  assessment:  ['#34D399', '#6EE7B7'],
}

// Stylized SVG signature for Chirag Gupta
function ChiragSignature({ color = '#1a1a2e' }: { color?: string }) {
  return (
    <svg width="160" height="52" viewBox="0 0 160 52" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M8 38 C12 22, 20 14, 30 18 C38 21, 36 32, 28 34 C20 36, 18 28, 24 24"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      <path
        d="M32 18 C38 10, 50 8, 56 14 C60 18, 56 26, 48 26 C42 26, 40 22, 44 18"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      <path
        d="M54 16 C60 8, 70 8, 74 16 C77 22, 72 30, 66 30 C60 30, 58 24, 62 20 C66 16, 72 18, 74 24"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      <path
        d="M72 14 L78 32 M75 14 C82 10, 90 12, 92 20 C94 28, 88 34, 82 32"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      <path
        d="M94 20 C98 14, 106 12, 110 18 C112 22, 110 28, 106 30 C102 32, 98 28, 100 24 C102 20, 108 20, 110 24"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      <path
        d="M112 18 L114 34 M112 26 C118 22, 126 24, 128 30 C130 36, 126 42, 120 40"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      <path
        d="M130 28 C136 22, 144 22, 148 30 C150 34, 148 40, 142 40 C136 40, 134 34, 138 30"
        stroke={color} strokeWidth="1.8" strokeLinecap="round" fill="none"
      />
      {/* Underline flourish */}
      <path
        d="M6 46 C30 42, 80 44, 152 46"
        stroke={color} strokeWidth="1.2" strokeLinecap="round" fill="none" opacity="0.5"
      />
    </svg>
  )
}

export default function CertificateDesign({
  recipientName,
  certificateType,
  referenceName,
  issuedAt,
  certificateNumber,
  showShareButtons = true,
  shareUrl,
}: CertificateProps) {
  const printRef = useRef<HTMLDivElement>(null)
  const [gradFrom, gradTo] = CATEGORY_COLORS[certificateType]

  const formattedDate = new Date(issuedAt).toLocaleDateString('en-US', {
    year: 'numeric', month: 'long', day: 'numeric',
  })

  const typeLabel = {
    course: 'Certificate of Completion',
    path: 'Certificate of Career Readiness',
    assessment: 'Certificate of Assessment',
  }[certificateType]

  const typeSubtext = {
    course: 'has successfully completed the course',
    path: 'has completed the career path and is job-ready in',
    assessment: 'has demonstrated proficiency in',
  }[certificateType]

  const linkedInShareUrl = shareUrl
    ? `https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(shareUrl)}`
    : null

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '1.5rem' }}>
      {/* Certificate */}
      <div
        ref={printRef}
        style={{
          width: '100%',
          maxWidth: 820,
          background: '#FDFAF4',
          borderRadius: 4,
          position: 'relative',
          overflow: 'hidden',
          boxShadow: '0 20px 60px rgba(0,0,0,0.25), 0 4px 16px rgba(0,0,0,0.1)',
          fontFamily: '"Georgia", "Times New Roman", serif',
        }}
      >
        {/* Top accent bar */}
        <div style={{ height: 8, background: `linear-gradient(90deg, ${gradFrom}, ${gradTo})` }} />

        {/* Decorative corner borders */}
        <div style={{ position: 'absolute', top: 16, left: 16, width: 60, height: 60, borderTop: `3px solid ${gradFrom}`, borderLeft: `3px solid ${gradFrom}`, opacity: 0.6 }} />
        <div style={{ position: 'absolute', top: 16, right: 16, width: 60, height: 60, borderTop: `3px solid ${gradFrom}`, borderRight: `3px solid ${gradFrom}`, opacity: 0.6 }} />
        <div style={{ position: 'absolute', bottom: 16, left: 16, width: 60, height: 60, borderBottom: `3px solid ${gradFrom}`, borderLeft: `3px solid ${gradFrom}`, opacity: 0.6 }} />
        <div style={{ position: 'absolute', bottom: 16, right: 16, width: 60, height: 60, borderBottom: `3px solid ${gradFrom}`, borderRight: `3px solid ${gradFrom}`, opacity: 0.6 }} />

        {/* Watermark */}
        <div style={{
          position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center',
          opacity: 0.03, fontSize: '11rem', fontWeight: 900, color: '#000', pointerEvents: 'none',
          userSelect: 'none', letterSpacing: '-0.04em',
        }}>VL</div>

        {/* Inner decorative border */}
        <div style={{
          margin: '20px 20px 0',
          border: `1px solid ${gradFrom}30`,
          padding: '2.5rem 3rem 2rem',
        }}>
          {/* Header */}
          <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
            {/* Logo mark */}
            <div style={{
              display: 'inline-flex', alignItems: 'center', gap: '0.5rem',
              marginBottom: '1.25rem',
            }}>
              <img
                src="/logo.png"
                alt=""
                style={{
                  width: 36, height: 36, objectFit: 'contain'
                }}
              />
              <span style={{ fontSize: '1.1rem', fontWeight: 700, color: '#1a1a2e', fontFamily: 'sans-serif', letterSpacing: '-0.01em' }}>
                VibeLearn
              </span>
            </div>

            {/* Certificate title */}
            <div style={{
              fontSize: '0.65rem', fontWeight: 700, letterSpacing: '0.25em', textTransform: 'uppercase',
              color: gradFrom, fontFamily: 'sans-serif', marginBottom: '0.5rem',
            }}>
              {typeLabel}
            </div>

            <div style={{ width: 80, height: 1, background: `linear-gradient(90deg, transparent, ${gradFrom}, transparent)`, margin: '0.75rem auto' }} />
          </div>

          {/* Body */}
          <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
            <p style={{ fontSize: '0.8rem', color: '#666', fontFamily: 'sans-serif', marginBottom: '1rem', letterSpacing: '0.05em', textTransform: 'uppercase' }}>
              This is to certify that
            </p>

            <div style={{
              fontSize: 'clamp(1.6rem, 3vw, 2.4rem)', fontWeight: 700, color: '#1a1a2e',
              fontFamily: '"Georgia", serif', marginBottom: '0.25rem',
              borderBottom: `2px solid ${gradFrom}40`, paddingBottom: '0.5rem',
              display: 'inline-block', minWidth: '60%',
            }}>
              {recipientName || 'Learner'}
            </div>

            <p style={{ fontSize: '0.85rem', color: '#555', fontFamily: 'sans-serif', marginTop: '1.25rem', marginBottom: '0.5rem', lineHeight: 1.6 }}>
              {typeSubtext}
            </p>

            <div style={{
              fontSize: 'clamp(1rem, 2vw, 1.35rem)', fontWeight: 700, color: '#1a1a2e',
              fontFamily: '"Georgia", serif', padding: '0.5rem 1.5rem',
              background: `linear-gradient(135deg, ${gradFrom}12, ${gradTo}12)`,
              border: `1px solid ${gradFrom}30`, borderRadius: 6, display: 'inline-block',
              marginTop: '0.25rem',
            }}>
              {referenceName}
            </div>

            <p style={{ fontSize: '0.8rem', color: '#888', fontFamily: 'sans-serif', marginTop: '1.25rem' }}>
              Issued on {formattedDate}
            </p>
          </div>

          {/* Footer: signature + seal */}
          <div style={{
            display: 'flex', alignItems: 'flex-end', justifyContent: 'space-between',
            paddingTop: '1.5rem', borderTop: `1px solid ${gradFrom}25`,
            flexWrap: 'wrap', gap: '1rem',
          }}>
            {/* Signature */}
            <div style={{ textAlign: 'center' }}>
              <ChiragSignature color="#1a1a2e" />
              <div style={{ width: 160, borderTop: '1px solid #1a1a2e40', paddingTop: '0.4rem', marginTop: '-4px' }}>
                <div style={{ fontSize: '0.78rem', fontWeight: 700, color: '#1a1a2e', fontFamily: 'sans-serif' }}>
                  Chirag Gupta
                </div>
                <div style={{ fontSize: '0.68rem', color: '#888', fontFamily: 'sans-serif' }}>
                  Creator, VibeLearn
                </div>
              </div>
            </div>

            {/* Center seal */}
            <div style={{ textAlign: 'center', flex: 1, display: 'flex', justifyContent: 'center' }}>
              <div style={{
                width: 80, height: 80, borderRadius: '50%',
                background: `linear-gradient(135deg, ${gradFrom}, ${gradTo})`,
                display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
                boxShadow: `0 4px 20px ${gradFrom}50`,
                position: 'relative',
              }}>
                {/* Outer ring */}
                <div style={{
                  position: 'absolute', inset: -4, borderRadius: '50%',
                  border: `2px solid ${gradFrom}60`,
                }} />
                <div style={{ fontSize: '1.6rem' }}>🎓</div>
                <div style={{ fontSize: '0.42rem', fontWeight: 700, color: '#fff', fontFamily: 'sans-serif', letterSpacing: '0.1em', textTransform: 'uppercase', marginTop: '0.1rem' }}>
                  Verified
                </div>
              </div>
            </div>

            {/* Certificate ID */}
            <div style={{ textAlign: 'right' }}>
              <div style={{ fontSize: '0.65rem', color: '#aaa', fontFamily: 'sans-serif', marginBottom: '0.2rem', letterSpacing: '0.05em', textTransform: 'uppercase' }}>
                Certificate ID
              </div>
              <div style={{ fontSize: '0.75rem', fontWeight: 700, color: '#555', fontFamily: 'monospace', letterSpacing: '0.1em' }}>
                {certificateNumber}
              </div>
              <div style={{ fontSize: '0.6rem', color: '#bbb', fontFamily: 'sans-serif', marginTop: '0.3rem' }}>
                vibelearn.com/certificate
              </div>
            </div>
          </div>
        </div>

        {/* Bottom accent bar */}
        <div style={{ height: 4, background: `linear-gradient(90deg, ${gradTo}, ${gradFrom})`, margin: '20px 20px 0' }} />
        <div style={{ height: 20 }} />
      </div>

      {/* Share buttons */}
      {showShareButtons && (
        <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap', justifyContent: 'center' }}>
          {linkedInShareUrl && (
            <a
              href={linkedInShareUrl}
              target="_blank"
              rel="noopener noreferrer"
              style={{
                display: 'inline-flex', alignItems: 'center', gap: '0.5rem',
                background: '#0A66C2', color: '#fff', fontWeight: 700,
                fontSize: '0.9rem', padding: '0.7rem 1.5rem', borderRadius: 10,
                textDecoration: 'none', fontFamily: 'sans-serif',
              }}
            >
              <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 01-2.063-2.065 2.064 2.064 0 112.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
              </svg>
              Share on LinkedIn
            </a>
          )}
          {shareUrl && (
            <button
              onClick={() => navigator.clipboard.writeText(shareUrl)}
              style={{
                display: 'inline-flex', alignItems: 'center', gap: '0.5rem',
                background: 'var(--surface)', color: 'var(--text-primary)', fontWeight: 600,
                fontSize: '0.9rem', padding: '0.7rem 1.5rem', borderRadius: 10,
                border: '1px solid var(--border)', cursor: 'pointer', fontFamily: 'sans-serif',
              }}
            >
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <path d="M10 13a5 5 0 007.54.54l3-3a5 5 0 00-7.07-7.07l-1.72 1.71"/>
                <path d="M14 11a5 5 0 00-7.54-.54l-3 3a5 5 0 007.07 7.07l1.71-1.71"/>
              </svg>
              Copy link
            </button>
          )}
        </div>
      )}
    </div>
  )
}
