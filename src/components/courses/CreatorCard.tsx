'use client'

import type { FC } from 'react'

interface Creator {
  name: string
  channelUrl: string
  avatar: string
  subscribers: string
  featuredIn: string[]
}

const CreatorCard: FC<{ creator: Creator }> = ({ creator }) => (
  <a
    href={creator.channelUrl}
    target="_blank"
    rel="noopener noreferrer"
    style={{ textDecoration: 'none' }}
    className="creator-card"
  >
    <div style={{
      background: 'var(--surface)',
      border: '1px solid var(--border)',
      borderRadius: 14,
      padding: '1rem',
      display: 'flex',
      alignItems: 'center',
      gap: '0.875rem',
      transition: 'border-color 0.15s, transform 0.15s',
    }}>
      {/* Avatar */}
      <div style={{
        width: 44,
        height: 44,
        borderRadius: '50%',
        overflow: 'hidden',
        flexShrink: 0,
        border: '2px solid var(--border)',
        background: 'var(--border)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}>
        <img
          src={creator.avatar}
          alt={creator.name}
          width={44}
          height={44}
          style={{ width: '100%', height: '100%', objectFit: 'cover' }}
          referrerPolicy="no-referrer"
          onError={(e) => {
            // Hide broken avatar image gracefully
            const img = e.currentTarget
            img.style.display = 'none'
          }}
        />
      </div>

      {/* Info */}
      <div style={{ minWidth: 0 }}>
        <div style={{
          fontSize: '0.88rem',
          fontWeight: 600,
          color: 'var(--cream)',
          lineHeight: 1.3,
          overflow: 'hidden',
          textOverflow: 'ellipsis',
          whiteSpace: 'nowrap',
        }}>
          {creator.name}
        </div>
        <div style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.15rem' }}>
          {creator.subscribers} subscribers
        </div>
        <div style={{
          fontSize: '0.7rem',
          color: 'var(--text-muted)',
          marginTop: '0.15rem',
          overflow: 'hidden',
          textOverflow: 'ellipsis',
          whiteSpace: 'nowrap',
        }}>
          {creator.featuredIn.length} lesson{creator.featuredIn.length !== 1 ? 's' : ''}
        </div>
      </div>

      {/* YouTube icon */}
      <svg
        width="18"
        height="18"
        viewBox="0 0 24 24"
        fill="#FF0000"
        style={{ flexShrink: 0, marginLeft: 'auto', opacity: 0.8 }}
      >
        <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z" />
      </svg>
    </div>
  </a>
)

export default CreatorCard
