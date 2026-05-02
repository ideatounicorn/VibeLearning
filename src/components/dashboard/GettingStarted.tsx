'use client'

import Link from 'next/link'

interface GettingStartedProps {
  hasStartedLesson: boolean
  hasPassedQuiz: boolean
  isPro: boolean
}

export function GettingStarted({ hasStartedLesson, hasPassedQuiz, isPro }: GettingStartedProps) {
  const steps = [
    { label: 'Start your first course', done: hasStartedLesson, href: '/paths' },
    { label: 'Complete a lesson quiz', done: hasPassedQuiz, href: '/paths' },
    { label: 'Build your profile', done: false, href: '/profile' },
  ]

  const allDone = steps.every(s => s.done)
  if (allDone) return null

  return (
    <div
      style={{
        background: 'var(--surface)',
        border: '1px solid var(--border)',
        borderRadius: 14,
        padding: '1.25rem',
        marginBottom: '1rem',
      }}
    >
      <h3 style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', margin: '0 0 1rem' }}>
        Getting Started
      </h3>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
        {steps.map((step, i) => (
          <Link
            key={i}
            href={step.done ? '#' : step.href}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.65rem',
              textDecoration: 'none',
              color: step.done ? 'var(--text-muted)' : 'var(--text-primary)',
              fontSize: '0.88rem',
              opacity: step.done ? 0.6 : 1,
            }}
          >
            <span
              style={{
                width: 20,
                height: 20,
                borderRadius: '50%',
                border: step.done ? 'none' : '1.5px solid var(--border)',
                background: step.done ? 'var(--success)' : 'transparent',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                flexShrink: 0,
                fontSize: '0.7rem',
                color: step.done ? '#fff' : 'transparent',
              }}
            >
              ✓
            </span>
            <span style={{ textDecoration: step.done ? 'line-through' : 'none' }}>
              {step.label}
            </span>
          </Link>
        ))}
      </div>

      {!isPro && (
        <Link
          href="/upgrade"
          style={{
            display: 'block',
            marginTop: '1.25rem',
            padding: '0.6rem 0.75rem',
            borderRadius: 10,
            background: 'color-mix(in srgb, var(--accent) 10%, transparent)',
            border: '1px solid color-mix(in srgb, var(--accent) 20%, transparent)',
            textDecoration: 'none',
            color: 'var(--accent)',
            fontSize: '0.83rem',
            fontWeight: 600,
            textAlign: 'center',
          }}
        >
          ✦ Get full access with Pro
        </Link>
      )}
    </div>
  )
}
