'use client'

import { useState } from 'react'
import Link from 'next/link'

interface Bookmark {
  id: string
  content_type: 'lesson' | 'course' | 'path'
  content_id: string
  created_at: string
}

interface BookmarksClientProps {
  initialBookmarks: Bookmark[]
}

type Tab = 'lesson' | 'course'

export function BookmarksClient({ initialBookmarks }: BookmarksClientProps) {
  const [bookmarks, setBookmarks] = useState(initialBookmarks)
  const [tab, setTab] = useState<Tab>('lesson')
  const [search, setSearch] = useState('')
  const [sort, setSort] = useState<'newest' | 'oldest'>('newest')

  const filtered = bookmarks
    .filter(b => b.content_type === tab)
    .sort((a, b) => {
      const diff = new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
      return sort === 'newest' ? diff : -diff
    })

  const handleRemove = async (id: string) => {
    await fetch(`/api/bookmarks/${id}`, { method: 'DELETE' })
    setBookmarks(b => b.filter(x => x.id !== id))
  }

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg)', padding: '2rem 1.5rem' }}>
      <div style={{ maxWidth: 800, margin: '0 auto' }}>

        {/* Header */}
        <div style={{ marginBottom: '2rem' }}>
          <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
            Bookmarks
          </h1>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem' }}>
            Your saved lessons and courses.
          </p>
        </div>

        {/* Tabs + search */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', borderBottom: '1px solid var(--border)', marginBottom: '1.5rem', gap: '1rem' }}>
          <div style={{ display: 'flex', gap: '0.25rem' }}>
            {(['lesson', 'course'] as Tab[]).map(t => (
              <button
                key={t}
                onClick={() => setTab(t)}
                style={{
                  background: 'none',
                  border: 'none',
                  cursor: 'pointer',
                  padding: '0.65rem 1rem',
                  fontSize: '0.9rem',
                  fontWeight: tab === t ? 600 : 400,
                  color: tab === t ? 'var(--text-primary)' : 'var(--text-muted)',
                  borderBottom: tab === t ? '2px solid var(--accent)' : '2px solid transparent',
                  marginBottom: -1,
                  textTransform: 'capitalize',
                }}
              >
                {t}s ({bookmarks.filter(b => b.content_type === t).length})
              </button>
            ))}
          </div>

          <div style={{ display: 'flex', gap: '0.5rem', paddingBottom: '0.5rem' }}>
            <input
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Search…"
              style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.4rem 0.75rem', color: 'var(--text-primary)', fontSize: '0.85rem', width: 160 }}
            />
            <select
              value={sort}
              onChange={e => setSort(e.target.value as 'newest' | 'oldest')}
              style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.4rem 0.75rem', color: 'var(--text-primary)', fontSize: '0.85rem', cursor: 'pointer' }}
            >
              <option value="newest">Newest</option>
              <option value="oldest">Oldest</option>
            </select>
          </div>
        </div>

        {/* List */}
        {filtered.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '4rem 2rem', color: 'var(--text-muted)' }}>
            <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🔖</div>
            <h2 style={{ fontSize: '1.1rem', color: 'var(--text-primary)', marginBottom: '0.5rem' }}>
              No bookmarks yet
            </h2>
            <p style={{ fontSize: '0.9rem', marginBottom: '1.5rem' }}>
              Save {tab}s while you learn to find them here later.
            </p>
            <Link href="/paths" className="btn-primary">
              Browse courses
            </Link>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
            {filtered.map(b => (
              <div
                key={b.id}
                style={{
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: 12,
                  padding: '1rem 1.25rem',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: '1rem',
                }}
              >
                <div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.2rem', textTransform: 'capitalize' }}>
                    {b.content_type}
                  </div>
                  <div style={{ fontSize: '0.92rem', color: 'var(--text-primary)', fontWeight: 500 }}>
                    ID: {b.content_id}
                  </div>
                  <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginTop: '0.2rem' }}>
                    Saved {new Date(b.created_at).toLocaleDateString()}
                  </div>
                </div>
                <button
                  onClick={() => handleRemove(b.id)}
                  style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--danger)', fontSize: '0.85rem', padding: '0.4rem' }}
                  title="Remove bookmark"
                >
                  ✕
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
