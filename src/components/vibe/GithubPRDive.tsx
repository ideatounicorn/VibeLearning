'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import Link from 'next/link'
import { GITHUB_PR_DIVE as D } from '@/lib/dive-github-pr'
import { PRMockCard } from './PRMockUI'
import { Capy, CapyBubble } from './Capy'
import { startDive, updateStage, completeDive, getProgress } from '@/lib/vibe-progress'

type Stage = 'hook' | 'setup' | 'compare' | 'verdict' | 'insight' | 'match' | 'check' | 'done'
const STAGES: Stage[] = ['hook', 'setup', 'compare', 'verdict', 'insight', 'match', 'check', 'done']

export default function GithubPRDive() {
  const [stage, setStage] = useState<Stage>('hook')
  const [prevProgress, setPrevProgress] = useState<ReturnType<typeof getProgress>>(null)

  useEffect(() => {
    setPrevProgress(getProgress(D.slug))
    startDive(D.slug)
  }, [])

  useEffect(() => {
    updateStage(D.slug, stage)
    if (stage === 'done') completeDive(D.slug)
  }, [stage])

  const idx = STAGES.indexOf(stage)
  const pct = (idx / (STAGES.length - 1)) * 100
  const next = () => idx < STAGES.length - 1 && setStage(STAGES[idx + 1])

  return (
    <div style={shell}>
      <TopBar pct={pct} label={D.topicLabel} />
      <div style={scrollArea}>
        <AnimatePresence mode="wait">
          {stage === 'hook' && <Hook key="h" onNext={next} prevProgress={prevProgress} onResume={(s: Stage) => setStage(s)} />}
          {stage === 'setup' && <Setup key="s" onNext={next} />}
          {stage === 'compare' && <Compare key="c" onNext={next} />}
          {stage === 'verdict' && <Verdict key="v" onNext={next} />}
          {stage === 'insight' && <Insight key="i" onNext={next} />}
          {stage === 'match' && <Match key="m" onNext={next} />}
          {stage === 'check' && <Check key="ch" onNext={next} />}
          {stage === 'done' && <Done key="d" onReset={() => setStage('hook')} />}
        </AnimatePresence>
      </div>
    </div>
  )
}

// ═══ Top bar ══════════════════════════════════════════════════════════════════
function TopBar({ pct, label }: { pct: number; label: string }) {
  return (
    <div style={topBar}>
      <Link href="/" style={{ color: 'var(--muted)', textDecoration: 'none', fontSize: '0.85rem' }}>← exit</Link>
      <div style={{ flex: 1, height: 6, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
        <motion.div animate={{ width: `${pct}%` }} transition={{ type: 'spring', stiffness: 120, damping: 20 }}
          style={{ height: '100%', background: 'var(--green)' }} />
      </div>
      <div style={{ fontSize: '0.7rem', color: 'var(--muted)', minWidth: 140, textAlign: 'right', letterSpacing: '0.08em', textTransform: 'uppercase' }}>{label}</div>
    </div>
  )
}

// ═══ Hook ═════════════════════════════════════════════════════════════════════
function Hook({ onNext, prevProgress, onResume }: { onNext: () => void; prevProgress: ReturnType<typeof getProgress>; onResume: (s: Stage) => void }) {
  const canResume = prevProgress?.lastStage && prevProgress.lastStage !== 'hook' && prevProgress.lastStage !== 'done'
  return (
    <Wrap>
      <motion.div initial={{ scale: 0.5, rotate: -8 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}>
        <GithubGlyph />
      </motion.div>
      <Eyebrow>{D.hook.eyebrow}</Eyebrow>
      <H1>{D.hook.headline}</H1>
      <Lede>{D.hook.sub}</Lede>
      {prevProgress?.completedAt && (
        <div style={completeBadge}>✓ You’ve completed this dive before · welcome back</div>
      )}
      <CapyBubble pose="hi">{D.hook.capy}</CapyBubble>
      <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        {canResume && (
          <PrimaryBtn onClick={() => onResume(prevProgress.lastStage as Stage)}>Resume from {prevProgress.lastStage} →</PrimaryBtn>
        )}
        <button onClick={onNext} style={canResume ? { ...primaryBtnStyle, background: 'transparent', color: 'var(--cream)', border: '1px solid var(--line)' } : primaryBtnStyle}>
          {canResume ? 'Start over' : 'Show me the two PRs →'}
        </button>
      </div>
    </Wrap>
  )
}

// ═══ Setup — show the ticket ══════════════════════════════════════════════════
function Setup({ onNext }: { onNext: () => void }) {
  return (
    <Wrap align="start">
      <Eyebrow>{D.setup.eyebrow}</Eyebrow>
      <H1>{D.setup.headline}</H1>
      <Lede>{D.setup.body}</Lede>

      {/* Ticket visual */}
      <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}
        style={ticketCard}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '0.4rem' }}>
          <span style={{ width: 14, height: 14, borderRadius: '50%', border: '2px solid #10B981', display: 'inline-block' }} />
          <span style={{ color: 'var(--muted)', fontSize: '0.75rem' }}>Issue #{D.setup.ticket.number}</span>
        </div>
        <div style={{ fontSize: '1.05rem', fontWeight: 700, color: 'var(--cream)' }}>{D.setup.ticket.title}</div>
        <div style={{ display: 'flex', gap: '0.4rem', marginTop: '0.65rem', flexWrap: 'wrap' }}>
          {D.setup.ticket.labels.map((l) => (
            <span key={l} style={labelChip}>{l}</span>
          ))}
        </div>
      </motion.div>

      <CapyBubble pose="thinking">Read both PRs. Don’t scroll past — actually read them. The difference is the lesson.</CapyBubble>
      <PrimaryBtn onClick={onNext}>Show me the PRs →</PrimaryBtn>
    </Wrap>
  )
}

// ═══ Compare — two PR cards stacked ═══════════════════════════════════════════
function Compare({ onNext }: { onNext: () => void }) {
  const [opened, setOpened] = useState<Set<string>>(new Set())
  const toggle = (id: string) => {
    const s = new Set(opened)
    if (s.has(id)) s.delete(id); else s.add(id)
    setOpened(s)
  }
  const bothOpened = opened.has('bad') && opened.has('good')

  return (
    <Wrap align="start">
      <Eyebrow>Two engineers, one ticket</Eyebrow>
      <H1 small>Tap each PR to expand. Read both before judging.</H1>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', width: '100%', marginTop: '0.5rem' }}>
        {(['bad', 'good'] as const).map((key) => {
          const pr = D.prs[key]
          const isOpen = opened.has(key)
          return (
            <div key={key}>
              <button onClick={() => toggle(key)} style={prToggleBtn}>
                <span style={{ fontSize: '0.7rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--muted)' }}>
                  {key === 'bad' ? 'PR from engineer A' : 'PR from engineer B'}
                </span>
                <span style={{ color: 'var(--muted)', fontSize: '0.78rem' }}>{isOpen ? '▾' : '▸ tap'}</span>
              </button>
              <PRMockCard pr={pr} expanded={isOpen} />
            </div>
          )
        })}
      </div>

      {bothOpened ? (
        <PrimaryBtn onClick={onNext}>Show me what the reviewer notices →</PrimaryBtn>
      ) : (
        <div style={{ marginTop: '1.5rem', color: 'var(--muted)', fontSize: '0.85rem', textAlign: 'center' }}>
          Expand both to continue · {opened.size}/2
        </div>
      )}
    </Wrap>
  )
}

// ═══ Verdict — side-by-side annotated diffs ═══════════════════════════════════
function Verdict({ onNext }: { onNext: () => void }) {
  return (
    <Wrap align="start">
      <Eyebrow>{D.verdict.eyebrow}</Eyebrow>
      <H1 small>{D.verdict.headline}</H1>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem', width: '100%', marginTop: '0.5rem' }}>
        {D.verdict.callouts.map((c, i) => (
          <motion.div key={c.signal} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}
            transition={{ delay: i * 0.08 }} style={calloutCard}>
            <div style={{ fontSize: '0.7rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: '0.55rem' }}>
              {c.signal}
            </div>
            <div style={{ display: 'flex', gap: '0.6rem', marginBottom: '0.5rem', flexWrap: 'wrap' }}>
              <div style={{ ...verdictPill, background: 'rgba(239,68,68,0.12)', color: '#FF6B51', borderColor: 'rgba(239,68,68,0.4)' }}>
                ✕ {c.bad}
              </div>
              <div style={{ ...verdictPill, background: 'rgba(16,185,129,0.12)', color: '#10B981', borderColor: 'rgba(16,185,129,0.4)' }}>
                ✓ {c.good}
              </div>
            </div>
            <div style={{ fontSize: '0.88rem', color: 'var(--cream)', lineHeight: 1.55 }}>{c.why}</div>
          </motion.div>
        ))}
      </div>

      <PrimaryBtn onClick={onNext}>The one idea →</PrimaryBtn>
    </Wrap>
  )
}

// ═══ Insight ══════════════════════════════════════════════════════════════════
function Insight({ onNext }: { onNext: () => void }) {
  return (
    <Wrap>
      <Eyebrow>{D.insight.eyebrow}</Eyebrow>
      <H1>{D.insight.headline}</H1>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', maxWidth: 620, marginTop: '1.5rem' }}>
        {D.insight.bullets.map((b, i) => (
          <motion.div key={b.k} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}
            transition={{ delay: i * 0.1 }} style={insightRow}>
            <div style={{ color: 'var(--green)', fontWeight: 900, fontSize: '1rem', minWidth: 110 }}>{b.k}</div>
            <div style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.5 }}>{b.v}</div>
          </motion.div>
        ))}
      </div>
      <CapyBubble pose="thinking">{D.insight.capy}</CapyBubble>
      <PrimaryBtn onClick={onNext}>Try it →</PrimaryBtn>
    </Wrap>
  )
}

// ═══ Match — title quality classifier ═════════════════════════════════════════
function Match({ onNext }: { onNext: () => void }) {
  const [picks, setPicks] = useState<Record<string, 'red' | 'green'>>({})
  const allDone = Object.keys(picks).length === D.matching.items.length

  return (
    <Wrap align="start">
      <Eyebrow>{D.matching.eyebrow}</Eyebrow>
      <H1 small>{D.matching.headline}</H1>
      <div style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '1rem' }}>{D.matching.sub}</div>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem', width: '100%' }}>
        {D.matching.items.map((it, i) => {
          const picked = picks[it.id]
          const correct = picked === it.verdict
          return (
            <motion.div key={it.id} initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.04 }} style={titleCard}>
              <div style={{
                fontFamily: 'ui-monospace, monospace', fontSize: '0.85rem', color: 'var(--cream)',
                padding: '0.55rem 0.75rem', background: 'var(--bg)', borderRadius: 8,
                border: '1px solid var(--line)', marginBottom: '0.75rem',
              }}>{it.title}</div>
              <div style={{ display: 'flex', gap: '0.5rem' }}>
                <TagBtn picked={picked} verdict={it.verdict as 'red' | 'green'} mine="green" onClick={() => !picked && setPicks((p) => ({ ...p, [it.id]: 'green' }))}>
                  ✓ Good title
                </TagBtn>
                <TagBtn picked={picked} verdict={it.verdict as 'red' | 'green'} mine="red" onClick={() => !picked && setPicks((p) => ({ ...p, [it.id]: 'red' }))}>
                  ✕ Bad title
                </TagBtn>
              </div>
              {picked && (
                <motion.div initial={{ opacity: 0, y: 5 }} animate={{ opacity: 1, y: 0 }}
                  style={{
                    marginTop: '0.7rem', padding: '0.65rem 0.8rem', background: 'var(--bg)',
                    border: `1px solid ${correct ? 'rgba(16,185,129,0.5)' : 'rgba(239,68,68,0.5)'}`,
                    borderRadius: 8, fontSize: '0.85rem', color: 'var(--cream)', lineHeight: 1.55,
                  }}>
                  <strong style={{ color: correct ? '#10B981' : '#FF6B51' }}>{correct ? '✓ ' : '— '}</strong>{it.why}
                </motion.div>
              )}
            </motion.div>
          )
        })}
      </div>

      {allDone ? (
        <PrimaryBtn onClick={onNext}>Final check →</PrimaryBtn>
      ) : (
        <div style={{ marginTop: '1.5rem', color: 'var(--muted)', fontSize: '0.85rem', textAlign: 'center' }}>
          Tag all {D.matching.items.length} to continue · {Object.keys(picks).length}/{D.matching.items.length}
        </div>
      )}
    </Wrap>
  )
}

function TagBtn({ picked, verdict, mine, onClick, children }: {
  picked?: 'red' | 'green'; verdict: 'red' | 'green'; mine: 'red' | 'green';
  onClick: () => void; children: React.ReactNode;
}) {
  const reveal = !!picked
  const isPick = picked === mine
  const isCorrect = mine === verdict
  let bg = 'var(--surface)', color = 'var(--cream)', border = '1px solid var(--line)'
  if (reveal) {
    if (isCorrect) { bg = mine === 'green' ? '#10B981' : '#FF6B51'; color = '#000'; border = '1px solid transparent' }
    else if (isPick) { bg = 'var(--coral)'; color = '#000' }
    else { color = 'var(--muted)' }
  }
  return (
    <motion.button whileTap={{ scale: 0.97 }} onClick={onClick}
      style={{ flex: 1, padding: '0.6rem 0.8rem', borderRadius: 999, fontWeight: 700, fontSize: '0.82rem', cursor: 'pointer', background: bg, color, border }}>
      {children}
    </motion.button>
  )
}

// ═══ Check ════════════════════════════════════════════════════════════════════
function Check({ onNext }: { onNext: () => void }) {
  const [pick, setPick] = useState<number | null>(null)
  return (
    <Wrap align="start">
      <Eyebrow>{D.check.eyebrow}</Eyebrow>
      <H1 small>{D.check.prompt}</H1>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', marginTop: '1.25rem' }}>
        {D.check.options.map((o, i) => {
          const reveal = pick !== null
          const isPick = pick === i
          const bg = !reveal ? 'var(--surface)' : o.correct ? 'var(--green)' : isPick ? 'var(--coral)' : 'var(--surface)'
          const color = !reveal ? 'var(--cream)' : (o.correct || isPick) ? '#000' : 'var(--muted)'
          const border = !reveal ? '2px solid var(--line)' : o.correct ? '2px solid var(--green)' : '2px solid var(--line)'
          return (
            <motion.button key={i} whileTap={pick === null ? { scale: 0.98 } : {}} whileHover={pick === null ? { x: 4 } : {}}
              onClick={() => pick === null && setPick(i)}
              style={{ padding: '1.1rem 1.25rem', borderRadius: 14, cursor: 'pointer', textAlign: 'left', width: '100%', background: bg, color, border }}>
              <div style={{ fontWeight: 800, fontSize: '0.98rem' }}>{o.label}</div>
              {reveal && (isPick || o.correct) && (
                <div style={{ marginTop: '0.85rem', fontSize: '0.85rem', lineHeight: 1.55, fontWeight: 400 }}>{o.why}</div>
              )}
            </motion.button>
          )
        })}
      </div>

      {pick !== null && (
        <>
          <CapyBubble pose="hi">{D.check.capy}</CapyBubble>
          <PrimaryBtn onClick={onNext}>Wrap it →</PrimaryBtn>
        </>
      )}
    </Wrap>
  )
}

// ═══ Done ═════════════════════════════════════════════════════════════════════
function Done({ onReset }: { onReset: () => void }) {
  return (
    <Wrap>
      <motion.div initial={{ scale: 0.5, rotate: -20 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}>
        <GithubGlyph celebrate />
      </motion.div>
      <Eyebrow>Dive complete</Eyebrow>
      <H1>You can write PRs that get merged today.</H1>
      <Lede>Write for the reviewer. Conventional title. What/Why/Screenshot/Test plan. Green CI. Linked issue. Done.</Lede>
      <CapyBubble pose="celebrating">Want me to do the next GitHub dive? I’m thinking: “What recruiters actually see on your profile.”</CapyBubble>
      <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        <PrimaryBtn onClick={onReset}>Replay dive</PrimaryBtn>
        <Link href="/" style={{ ...secondaryBtnStyle, textDecoration: 'none' }}>Back to VibeLearn</Link>
      </div>
    </Wrap>
  )
}

// ═══ GitHub octocat-ish glyph (inline SVG, no asset needed) ═══════════════════
function GithubGlyph({ celebrate }: { celebrate?: boolean } = {}) {
  return (
    <motion.svg
      width="120" height="120" viewBox="0 0 100 100"
      animate={celebrate ? { rotate: [0, -10, 10, -8, 0] } : {}}
      transition={{ duration: 1.2 }}
    >
      <defs>
        <linearGradient id="ghbg" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0%" stopColor="#c8ff00" />
          <stop offset="100%" stopColor="#a0d800" />
        </linearGradient>
      </defs>
      <circle cx="50" cy="50" r="46" fill="url(#ghbg)" />
      <path d="M50 22c-15 0-27 12-27 27 0 12 8 22 19 25 1.4.3 1.9-.6 1.9-1.4v-5c-7.7 1.7-9.4-3.3-9.4-3.3-1.3-3.2-3.1-4.1-3.1-4.1-2.5-1.7.2-1.7.2-1.7 2.8.2 4.3 2.9 4.3 2.9 2.5 4.3 6.6 3 8.2 2.3.3-1.8 1-3 1.8-3.7-6.2-.7-12.7-3.1-12.7-13.8 0-3 1.1-5.5 2.9-7.5-.3-.7-1.3-3.6.3-7.5 0 0 2.4-.8 7.9 2.9 2.3-.6 4.7-1 7.1-1 2.4 0 4.8.3 7.1 1 5.4-3.7 7.8-2.9 7.8-2.9 1.6 3.9.6 6.8.3 7.5 1.8 2 2.9 4.5 2.9 7.5 0 10.7-6.5 13.1-12.7 13.8 1 .9 1.9 2.6 1.9 5.3v7.9c0 .8.5 1.7 1.9 1.4C69 71 77 61 77 49c0-15-12-27-27-27z" fill="#000"/>
    </motion.svg>
  )
}

// ═══ Reusable bits ════════════════════════════════════════════════════════════
function Wrap({ children, align = 'center' }: { children: React.ReactNode; align?: 'center' | 'start' }) {
  return (
    <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.35 }}
      style={{
        maxWidth: 720, margin: '0 auto', padding: '2rem 1.25rem 4rem',
        display: 'flex', flexDirection: 'column', alignItems: align === 'center' ? 'center' : 'flex-start',
        textAlign: align === 'center' ? 'center' : 'left', gap: '0.75rem',
      }}>{children}</motion.div>
  )
}

function Eyebrow({ children }: { children: React.ReactNode }) {
  return <div style={{ fontSize: '0.7rem', letterSpacing: '0.3em', textTransform: 'uppercase', color: 'var(--green)', fontWeight: 700, marginTop: '0.5rem' }}>{children}</div>
}

function H1({ children, small }: { children: React.ReactNode; small?: boolean }) {
  return (
    <h1 style={{
      fontSize: small ? 'clamp(1.4rem, 3.5vw, 2rem)' : 'clamp(1.8rem, 5vw, 2.75rem)',
      fontWeight: 900, color: 'var(--cream)', letterSpacing: '-0.015em', lineHeight: 1.2, margin: 0,
    }}>{children}</h1>
  )
}

function Lede({ children }: { children: React.ReactNode }) {
  return <p style={{ color: 'var(--muted)', fontSize: '1.05rem', lineHeight: 1.55, margin: '0.25rem 0 0', maxWidth: 600 }}>{children}</p>
}

function PrimaryBtn({ children, onClick }: { children: React.ReactNode; onClick: () => void }) {
  return (
    <motion.button whileHover={{ scale: 1.04 }} whileTap={{ scale: 0.96 }} onClick={onClick}
      style={primaryBtnStyle}>{children}</motion.button>
  )
}

// ═══ Styles ═══════════════════════════════════════════════════════════════════
const shell: React.CSSProperties = {
  position: 'fixed', inset: 0, background: 'var(--bg)', color: 'var(--cream)',
  display: 'flex', flexDirection: 'column', overflow: 'hidden',
  fontFamily: 'system-ui, -apple-system, sans-serif',
}

const topBar: React.CSSProperties = {
  padding: '1rem 1.25rem', display: 'flex', alignItems: 'center', gap: '0.75rem',
  borderBottom: '1px solid var(--line)', flexShrink: 0,
}

const scrollArea: React.CSSProperties = { flex: 1, overflowY: 'auto' }

const primaryBtnStyle: React.CSSProperties = {
  marginTop: '1.75rem', padding: '0.95rem 1.75rem', background: 'var(--green)', color: '#000',
  border: 'none', borderRadius: 999, fontWeight: 800, fontSize: '1rem', cursor: 'pointer', letterSpacing: '-0.01em',
}

const secondaryBtnStyle: React.CSSProperties = {
  marginTop: '1.75rem', padding: '0.95rem 1.75rem', background: 'transparent', color: 'var(--cream)',
  border: '1px solid var(--line)', borderRadius: 999, fontWeight: 700, fontSize: '1rem', display: 'inline-block',
}

const ticketCard: React.CSSProperties = {
  width: '100%', background: 'var(--surface)', border: '1px solid var(--line)',
  borderRadius: 12, padding: '1rem 1.1rem', marginTop: '1rem',
}

const labelChip: React.CSSProperties = {
  fontSize: '0.7rem', padding: '0.18rem 0.55rem', background: 'rgba(88,166,255,0.12)', color: '#58a6ff',
  border: '1px solid rgba(88,166,255,0.3)', borderRadius: 999,
}

const prToggleBtn: React.CSSProperties = {
  width: '100%', padding: '0.4rem 0.4rem 0.55rem', background: 'transparent', border: 'none',
  display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'pointer',
}

const calloutCard: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)', borderRadius: 12, padding: '1rem 1.1rem',
}

const verdictPill: React.CSSProperties = {
  fontSize: '0.78rem', padding: '0.35rem 0.7rem', borderRadius: 8, border: '1px solid',
  fontFamily: 'ui-monospace, monospace', fontWeight: 700,
}

const insightRow: React.CSSProperties = {
  display: 'flex', gap: '1rem', alignItems: 'flex-start', padding: '0.95rem 1.1rem',
  background: 'var(--surface)', borderRadius: 12, textAlign: 'left', borderLeft: '4px solid var(--green)',
}

const titleCard: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)', borderRadius: 12, padding: '0.9rem 1rem',
}

const completeBadge: React.CSSProperties = {
  fontSize: '0.78rem', color: 'var(--green)', background: 'rgba(200,255,0,0.08)',
  border: '1px solid rgba(200,255,0,0.3)', padding: '0.4rem 0.85rem', borderRadius: 999,
  marginTop: '0.5rem',
}
