'use client'

import { motion } from 'framer-motion'
import type { PRMock, Avatar } from '@/lib/dive-github-pr'

// Mock GitHub PR header — looks like real github.com but rendered in pure CSS.
// Designed to feel like an artifact, not a description.

export function PRMockCard({ pr, expanded = false }: { pr: PRMock; expanded?: boolean }) {
  return (
    <div style={card}>
      {/* Title row */}
      <div style={{ padding: '0.95rem 1.1rem', borderBottom: '1px solid var(--line)' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.4rem' }}>
          <StatePill state={pr.state} />
          <span style={{ color: 'var(--muted)', fontSize: '0.75rem' }}>#{pr.number}</span>
          {pr.linkedIssue && (
            <span style={linkPill}>↳ closes #{pr.linkedIssue}</span>
          )}
        </div>
        <div style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--cream)', lineHeight: 1.3 }}>
          {pr.title}
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginTop: '0.55rem', flexWrap: 'wrap' }}>
          <AvatarChip av={pr.author} />
          <span style={{ color: 'var(--muted)', fontSize: '0.78rem' }}>wants to merge</span>
          <BranchChip branch={pr.branch} />
          <span style={{ color: 'var(--muted)', fontSize: '0.78rem' }}>→</span>
          <BranchChip branch="main" />
        </div>
      </div>

      {/* Stats row */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '1.25rem', padding: '0.7rem 1.1rem', borderBottom: '1px solid var(--line)', flexWrap: 'wrap', fontSize: '0.78rem' }}>
        <Stat label="files" value={String(pr.filesChanged)} tone={pr.filesChanged > 20 ? 'warn' : 'normal'} />
        <Stat label="+" value={String(pr.additions)} tone="add" />
        <Stat label="−" value={String(pr.deletions)} tone="del" />
        <Stat label="comments" value={String(pr.comments)} tone="normal" />
        <CIBadge status={pr.ciStatus} />
      </div>

      {/* Description body */}
      {expanded && (
        <div style={{ padding: '1rem 1.1rem' }}>
          <div style={{ fontSize: '0.7rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: '0.55rem' }}>
            Description
          </div>
          {pr.description ? (
            <DescriptionBody text={pr.description} hasScreenshot={pr.hasScreenshot} />
          ) : (
            <div style={emptyDesc}>
              <span style={{ opacity: 0.5 }}>No description provided.</span>
            </div>
          )}

          <div style={{ marginTop: '1rem', display: 'flex', gap: '1rem', alignItems: 'center', flexWrap: 'wrap', fontSize: '0.75rem' }}>
            <span style={{ color: 'var(--muted)' }}>Reviewers:</span>
            {pr.reviewers.length === 0 ? (
              <span style={{ color: 'var(--muted)', opacity: 0.6 }}>none requested</span>
            ) : (
              <div style={{ display: 'flex', gap: 4 }}>
                {pr.reviewers.map((r, i) => <AvatarBlob key={i} av={r} />)}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  )
}

// ─── Pieces ───────────────────────────────────────────────────────────────────

function StatePill({ state }: { state: PRMock['state'] }) {
  const map = {
    open: { bg: '#1f6feb', label: 'Open' },
    merged: { bg: '#8957e5', label: 'Merged' },
    draft: { bg: '#6b7280', label: 'Draft' },
  } as const
  const c = map[state]
  return (
    <span style={{ background: c.bg, color: '#fff', padding: '0.15rem 0.55rem', borderRadius: 999, fontSize: '0.7rem', fontWeight: 700, letterSpacing: '0.02em' }}>
      ● {c.label}
    </span>
  )
}

function BranchChip({ branch }: { branch: string }) {
  return (
    <span style={{
      fontFamily: 'ui-monospace, monospace', fontSize: '0.72rem',
      padding: '0.18rem 0.5rem', background: 'var(--bg)', color: 'var(--cream)',
      border: '1px solid var(--line)', borderRadius: 6,
    }}>{branch}</span>
  )
}

function AvatarChip({ av }: { av: Avatar }) {
  return (
    <span style={{ display: 'inline-flex', alignItems: 'center', gap: '0.35rem', fontSize: '0.78rem', color: 'var(--cream)' }}>
      <AvatarBlob av={av} />
      <span style={{ fontWeight: 600 }}>{av.initials.toLowerCase()}</span>
    </span>
  )
}

function AvatarBlob({ av }: { av: Avatar }) {
  return (
    <span style={{
      width: 22, height: 22, borderRadius: '50%', background: av.color, color: '#000',
      display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
      fontSize: '0.65rem', fontWeight: 800, letterSpacing: '-0.02em',
    }}>{av.initials}</span>
  )
}

function Stat({ label, value, tone }: { label: string; value: string; tone: 'normal' | 'warn' | 'add' | 'del' }) {
  const colorMap = { normal: 'var(--cream)', warn: '#FF6B51', add: '#10B981', del: '#EF4444' }
  return (
    <span style={{ display: 'inline-flex', alignItems: 'baseline', gap: 4 }}>
      <span style={{ color: colorMap[tone], fontWeight: 800 }}>{label === '+' || label === '−' ? `${label}${value}` : value}</span>
      {label !== '+' && label !== '−' && <span style={{ color: 'var(--muted)' }}>{label}</span>}
    </span>
  )
}

function CIBadge({ status }: { status: PRMock['ciStatus'] }) {
  if (status === 'none') return null
  const map = {
    pass: { bg: 'rgba(16,185,129,0.15)', color: '#10B981', label: '✓ checks passing' },
    fail: { bg: 'rgba(239,68,68,0.15)', color: '#EF4444', label: '✕ checks failing' },
    pending: { bg: 'rgba(245,200,66,0.15)', color: '#F5C842', label: '● checks running' },
  } as const
  const c = map[status]
  return (
    <span style={{ background: c.bg, color: c.color, padding: '0.2rem 0.55rem', borderRadius: 6, fontWeight: 700, fontSize: '0.72rem' }}>
      {c.label}
    </span>
  )
}

function DescriptionBody({ text, hasScreenshot }: { text: string; hasScreenshot: boolean }) {
  // Tiny markdown — **bold**, [x] checklist, headings via **What**
  const lines = text.split('\n')
  return (
    <div style={{ fontSize: '0.88rem', color: 'var(--cream)', lineHeight: 1.6 }}>
      {lines.map((line, i) => {
        if (line.startsWith('**') && line.endsWith('**')) {
          return <div key={i} style={{ fontWeight: 800, marginTop: i === 0 ? 0 : '0.85rem', marginBottom: '0.3rem', color: 'var(--cream)' }}>{line.slice(2, -2)}</div>
        }
        if (line.startsWith('- [x]') || line.startsWith('- [ ]')) {
          const checked = line.startsWith('- [x]')
          const rest = line.slice(5).trim()
          return (
            <div key={i} style={{ display: 'flex', gap: '0.5rem', alignItems: 'flex-start', margin: '0.25rem 0' }}>
              <span style={{
                width: 16, height: 16, borderRadius: 4, border: '1.5px solid var(--line)',
                background: checked ? '#10B981' : 'transparent', color: '#000', flexShrink: 0,
                display: 'inline-flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.7rem', fontWeight: 900,
                marginTop: 2,
              }}>{checked ? '✓' : ''}</span>
              <span style={{ opacity: checked ? 0.85 : 1 }}>{renderInline(rest)}</span>
            </div>
          )
        }
        if (line.startsWith('[') && line.endsWith(']') && hasScreenshot) {
          // image placeholder
          return <ScreenshotPlaceholder key={i} name={line.slice(1, -1)} />
        }
        if (line.trim() === '') return <div key={i} style={{ height: '0.4rem' }} />
        return <div key={i} style={{ whiteSpace: 'pre-wrap' }}>{renderInline(line)}</div>
      })}
    </div>
  )
}

function renderInline(text: string) {
  // basic inline: **bold**, `code`, #123 → issue ref
  const html = text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/`([^`]+)`/g, '<code style="background:var(--bg);padding:1px 6px;border-radius:4px;font-size:0.85em;border:1px solid var(--line);font-family:ui-monospace,monospace">$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/(#\d{2,5})/g, '<span style="color:#58a6ff">$1</span>')
  return <span dangerouslySetInnerHTML={{ __html: html }} />
}

function ScreenshotPlaceholder({ name }: { name: string }) {
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.96 }} animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.4 }}
      style={{
        margin: '0.8rem 0', borderRadius: 10, overflow: 'hidden',
        border: '1px solid var(--line)', background: 'linear-gradient(135deg, #1a1a1a, #2a2a2a)',
        aspectRatio: '16 / 9', display: 'flex', alignItems: 'center', justifyContent: 'center',
        position: 'relative',
      }}
    >
      {/* Fake UI mock — a "screenshot" of an import flow */}
      <div style={{
        position: 'absolute', inset: '12% 14%', background: 'var(--surface)', border: '1px solid var(--line)',
        borderRadius: 6, display: 'flex', flexDirection: 'column', overflow: 'hidden',
      }}>
        <div style={{ height: 18, background: 'var(--bg)', borderBottom: '1px solid var(--line)',
          display: 'flex', alignItems: 'center', gap: 4, paddingLeft: 6 }}>
          <span style={dot('#ff5f57')}></span><span style={dot('#febc2e')}></span><span style={dot('#28c840')}></span>
        </div>
        <div style={{ flex: 1, padding: '0.5rem 0.75rem', display: 'flex', flexDirection: 'column', gap: 4 }}>
          <div style={{ fontSize: '0.55rem', color: 'var(--cream)', fontWeight: 800 }}>Import Contacts</div>
          <div style={{ height: 1, background: 'var(--line)' }} />
          <div style={{
            border: '1.5px dashed var(--green)', borderRadius: 4, padding: '0.5rem',
            color: 'var(--green)', fontSize: '0.5rem', textAlign: 'center', marginTop: 2,
          }}>📂 Drop CSV here</div>
          <div style={{ display: 'flex', gap: 4, marginTop: 2 }}>
            <div style={{ flex: 1, height: 4, background: 'var(--green)', borderRadius: 2 }} />
            <div style={{ width: 12, height: 4, background: 'var(--line)', borderRadius: 2 }} />
          </div>
          <div style={{ fontSize: '0.45rem', color: '#10B981' }}>✓ 497 imported · 3 errors</div>
        </div>
      </div>
      <div style={{ position: 'absolute', bottom: 6, right: 8, fontSize: '0.62rem', color: 'var(--muted)', fontFamily: 'ui-monospace, monospace' }}>
        {name}
      </div>
    </motion.div>
  )
}

const dot = (c: string): React.CSSProperties => ({ width: 7, height: 7, borderRadius: '50%', background: c, display: 'inline-block' })

// ─── Styles ───────────────────────────────────────────────────────────────────

const card: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)', borderRadius: 14,
  overflow: 'hidden', width: '100%',
}

const linkPill: React.CSSProperties = {
  fontSize: '0.7rem', color: '#58a6ff', background: 'rgba(88,166,255,0.1)',
  padding: '0.15rem 0.5rem', borderRadius: 999,
}

const emptyDesc: React.CSSProperties = {
  padding: '1.5rem', background: 'var(--bg)', border: '1px dashed var(--line)',
  borderRadius: 8, textAlign: 'center', color: 'var(--muted)', fontSize: '0.85rem',
  fontStyle: 'italic',
}
