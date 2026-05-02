'use client'

import Link from 'next/link'
import { CATEGORY_GRADIENTS, CATEGORY_EMOJIS } from '@/lib/category-constants'

interface Path {
  id: string
  name: string
  slug: string
  description: string
  category: string
  total_modules: number
  total_hours: number
  total_courses: number
  unit_count: number
  is_coming_soon: boolean
}

export default function PathsGrid({ paths }: { paths: Path[] }) {
  return (
    <div
      style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))',
        gap: '1.5rem',
      }}
    >
      {paths.map((path, index) => {
        const [gradFrom, gradTo] = CATEGORY_GRADIENTS[path.category] ?? ['#6366F1', '#818CF8']
        const emojis = CATEGORY_EMOJIS[path.category] ?? ['✨']
        const emoji = emojis[index % emojis.length]
        const href = path.is_coming_soon ? '#' : `/paths/${path.slug}`
        const unitCount = path.unit_count || path.total_courses || path.total_modules || 0

        return (
          <Link key={path.id} href={href} style={{ textDecoration: 'none' }}>
            <div
              style={{
                background: 'var(--surface)',
                border: '1px solid var(--border)',
                borderRadius: 16,
                overflow: 'hidden',
                height: '100%',
                display: 'flex',
                flexDirection: 'column',
                transition: 'box-shadow 0.2s, transform 0.2s',
                cursor: path.is_coming_soon ? 'default' : 'pointer',
                opacity: path.is_coming_soon ? 0.55 : 1,
              }}
              onMouseEnter={e => {
                if (!path.is_coming_soon) {
                  const el = e.currentTarget as HTMLDivElement
                  el.style.boxShadow = '0 8px 24px rgba(0,0,0,0.12)'
                  el.style.transform = 'translateY(-3px)'
                }
              }}
              onMouseLeave={e => {
                const el = e.currentTarget as HTMLDivElement
                el.style.boxShadow = 'none'
                el.style.transform = 'translateY(0)'
              }}
            >
              {/* Certification Badge */}
              <div style={{ padding: '0.75rem 1rem 0' }}>
                <span style={{
                  fontSize: '0.7rem',
                  fontWeight: 600,
                  color: 'var(--text-muted)',
                  textTransform: 'uppercase',
                  letterSpacing: '0.06em',
                  background: 'var(--ink)',
                  border: '1px solid var(--border)',
                  borderRadius: 6,
                  padding: '0.25rem 0.6rem',
                }}>
                  Certification
                </span>
              </div>

              {/* Illustration area */}
              <div
                style={{
                  margin: '0.75rem 1rem',
                  height: 160,
                  borderRadius: 12,
                  background: `linear-gradient(135deg, ${gradFrom}22, ${gradTo}44)`,
                  border: `1px solid ${gradFrom}33`,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  position: 'relative',
                  overflow: 'hidden',
                }}
              >
                {/* Decorative circles */}
                <div style={{
                  position: 'absolute',
                  top: -20,
                  right: -20,
                  width: 100,
                  height: 100,
                  borderRadius: '50%',
                  background: `${gradTo}33`,
                }} />
                <div style={{
                  position: 'absolute',
                  bottom: -15,
                  left: -15,
                  width: 70,
                  height: 70,
                  borderRadius: '50%',
                  background: `${gradFrom}22`,
                }} />
                <span style={{ fontSize: '3.5rem', position: 'relative', zIndex: 1 }}>{emoji}</span>
              </div>

              {/* Card content */}
              <div style={{ padding: '0 1rem 1.25rem', flex: 1, display: 'flex', flexDirection: 'column' }}>
                <div style={{
                  fontSize: '0.7rem',
                  fontWeight: 600,
                  color: 'var(--text-muted)',
                  textTransform: 'uppercase',
                  letterSpacing: '0.08em',
                  marginBottom: '0.4rem',
                }}>
                  Career Path
                </div>
                <h3 style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem', lineHeight: 1.3 }}>
                  {path.name}
                </h3>
                <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', lineHeight: 1.55, flex: 1, marginBottom: '1rem' }}>
                  {path.description}
                </p>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', color: 'var(--text-muted)', fontSize: '0.82rem' }}>
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <path d="M4 19.5A2.5 2.5 0 016.5 17H20"/>
                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 014 19.5v-15A2.5 2.5 0 016.5 2z"/>
                  </svg>
                  {unitCount > 0 ? `${unitCount} units` : `${path.total_hours || 0}h`}
                  {path.is_coming_soon && (
                    <span style={{
                      marginLeft: 'auto',
                      fontSize: '0.7rem',
                      fontWeight: 600,
                      color: gradFrom,
                      background: `${gradFrom}15`,
                      border: `1px solid ${gradFrom}30`,
                      borderRadius: 6,
                      padding: '0.2rem 0.5rem',
                    }}>
                      Coming Soon
                    </span>
                  )}
                </div>
              </div>
            </div>
          </Link>
        )
      })}
    </div>
  )
}
