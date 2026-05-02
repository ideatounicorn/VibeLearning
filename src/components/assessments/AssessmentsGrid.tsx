'use client'

import { useState } from 'react'
import Link from 'next/link'

interface Assessment {
  id: string
  title: string
  slug: string
  short_description: string | null
  category: string
  icon_emoji: string
  icon_bg: string
  duration_minutes: number
  question_count: number
  attempts_count: number
  xp_reward: number
  is_pro: boolean
}

interface Props {
  assessments: Assessment[]
}

const FILTERS = ['All', 'Skills', 'Tools'] as const

export default function AssessmentsGrid({ assessments }: Props) {
  const [filter, setFilter] = useState<string>('All')

  const filtered = filter === 'All' ? assessments : assessments.filter(a => a.category === filter)

  return (
    <div>
      {/* Filter tabs */}
      <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '2rem', flexWrap: 'wrap' }}>
        {FILTERS.map(f => (
          <button
            key={f}
            onClick={() => setFilter(f)}
            style={{
              padding: '0.5rem 1.25rem',
              borderRadius: 999,
              border: '1.5px solid',
              borderColor: filter === f ? 'var(--accent)' : 'var(--line)',
              background: filter === f ? 'color-mix(in srgb, var(--accent) 12%, transparent)' : 'transparent',
              color: filter === f ? 'var(--accent)' : 'var(--muted)',
              fontWeight: filter === f ? 600 : 400,
              fontSize: '0.9rem',
              cursor: 'pointer',
              transition: 'all 0.15s',
            }}
          >
            {f}
          </button>
        ))}
      </div>

      {/* Grid */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))',
          gap: '1.5rem',
        }}
      >
        {filtered.map(a => (
          <AssessmentCard key={a.id} assessment={a} />
        ))}
      </div>

      {filtered.length === 0 && (
        <div style={{ textAlign: 'center', padding: '4rem', color: 'var(--muted)' }}>
          No assessments in this category yet.
        </div>
      )}
    </div>
  )
}

function AssessmentCard({ assessment: a }: { assessment: Assessment }) {
  return (
    <Link
      href={`/assessments/${a.slug}`}
      style={{ textDecoration: 'none', display: 'block' }}
    >
      <div
        style={{
          background: 'var(--dim)',
          border: '1px solid var(--line)',
          borderRadius: 20,
          overflow: 'hidden',
          transition: 'transform 0.15s, box-shadow 0.15s, border-color 0.15s',
          cursor: 'pointer',
        }}
        onMouseEnter={e => {
          const el = e.currentTarget as HTMLDivElement
          el.style.transform = 'translateY(-3px)'
          el.style.boxShadow = '0 12px 40px rgba(0,0,0,0.15)'
          el.style.borderColor = 'color-mix(in srgb, var(--accent) 35%, transparent)'
        }}
        onMouseLeave={e => {
          const el = e.currentTarget as HTMLDivElement
          el.style.transform = ''
          el.style.boxShadow = ''
          el.style.borderColor = 'var(--line)'
        }}
      >
        {/* Icon area */}
        <div
          style={{
            height: 140,
            background: a.icon_bg,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '4rem',
            position: 'relative',
          }}
        >
          {a.icon_emoji}
          {a.is_pro && (
            <span
              className="pill pill-amber"
              style={{ position: 'absolute', top: 12, right: 12, fontSize: '0.7rem' }}
            >
              PRO
            </span>
          )}
        </div>

        {/* Content */}
        <div style={{ padding: '1.25rem' }}>
          <div style={{ color: 'var(--muted)', fontSize: '0.72rem', fontWeight: 600, letterSpacing: '0.08em', textTransform: 'uppercase', marginBottom: '0.4rem' }}>
            Assessment
          </div>
          <h3 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem', lineHeight: 1.3 }}>
            {a.title}
          </h3>
          {a.short_description && (
            <p style={{ color: 'var(--muted)', fontSize: '0.85rem', lineHeight: 1.55, marginBottom: '1rem', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
              {a.short_description}
            </p>
          )}
          <div style={{ display: 'flex', gap: '1rem', color: 'var(--muted)', fontSize: '0.8rem', flexWrap: 'wrap' }}>
            <span>⏱ {a.duration_minutes}m</span>
            <span>📝 {a.question_count} questions</span>
            <span>👥 {a.attempts_count.toLocaleString()}</span>
          </div>
        </div>
      </div>
    </Link>
  )
}
