'use client'

import { useState } from 'react'

interface BookmarkButtonProps {
  contentType: 'lesson' | 'course' | 'path'
  contentId: string
  initialBookmarked?: boolean
}

export function BookmarkButton({ contentType, contentId, initialBookmarked = false }: BookmarkButtonProps) {
  const [bookmarked, setBookmarked] = useState(initialBookmarked)
  const [loading, setLoading] = useState(false)

  const toggle = async () => {
    if (loading) return
    setLoading(true)
    try {
      if (bookmarked) {
        const res = await fetch('/api/bookmarks', { method: 'GET' })
        const { bookmarks } = await res.json()
        const match = bookmarks?.find((b: { content_type: string; content_id: string; id: string }) =>
          b.content_type === contentType && b.content_id === contentId
        )
        if (match) {
          await fetch(`/api/bookmarks/${match.id}`, { method: 'DELETE' })
          setBookmarked(false)
        }
      } else {
        const res = await fetch('/api/bookmarks', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ content_type: contentType, content_id: contentId }),
        })
        if (res.ok || res.status === 409) setBookmarked(true)
      }
    } finally {
      setLoading(false)
    }
  }

  return (
    <button
      onClick={toggle}
      disabled={loading}
      title={bookmarked ? 'Remove bookmark' : 'Bookmark'}
      style={{
        background: 'none',
        border: 'none',
        cursor: loading ? 'wait' : 'pointer',
        color: bookmarked ? 'var(--accent)' : 'var(--text-muted)',
        padding: '0.3rem',
        display: 'flex',
        alignItems: 'center',
        transition: 'color 0.15s',
      }}
    >
      <svg width="18" height="18" viewBox="0 0 24 24" fill={bookmarked ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M19 21l-7-5-7 5V5a2 2 0 012-2h10a2 2 0 012 2z"/>
      </svg>
    </button>
  )
}
