'use client'

import { useState, useMemo, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import Link from 'next/link'
import { CLAUDE_MODELS_DIVE as D } from '@/lib/dive-claude-models'
import { Capy, CapyBubble as SharedCapyBubble } from './Capy'
import { startDive, updateStage, completeDive, getProgress } from '@/lib/vibe-progress'

type Stage = 'hook' | 'prompt' | 'compare' | 'verdicts' | 'insight' | 'match' | 'check' | 'done'

const STAGE_ORDER: Stage[] = ['hook', 'prompt', 'compare', 'verdicts', 'insight', 'match', 'check', 'done']
const DIVE_SLUG = 'claude-models'

const MODEL_COLOR: Record<string, string> = {
  haiku: '#F5C842',
  sonnet: '#c8ff00',
  opus: '#C084FC',
}

export default function ClaudeModelsDive() {
  const [stage, setStage] = useState<Stage>('hook')
  const [prevProgress, setPrevProgress] = useState<ReturnType<typeof getProgress>>(null)

  useEffect(() => {
    setPrevProgress(getProgress(DIVE_SLUG))
    startDive(DIVE_SLUG)
  }, [])

  useEffect(() => {
    updateStage(DIVE_SLUG, stage)
    if (stage === 'done') completeDive(DIVE_SLUG)
  }, [stage])
  const idx = STAGE_ORDER.indexOf(stage)
  const pct = (idx / (STAGE_ORDER.length - 1)) * 100

  const go = (s: Stage) => setStage(s)
  const next = () => {
    const i = STAGE_ORDER.indexOf(stage)
    if (i < STAGE_ORDER.length - 1) setStage(STAGE_ORDER[i + 1])
  }

  return (
    <div style={shell}>
      <TopBar pct={pct} label={D.topicLabel} />

      <div style={scrollArea}>
        <AnimatePresence mode="wait">
          {stage === 'hook' && <Hook key="h" onNext={next} prevProgress={prevProgress} onResume={(s) => setStage(s)} />}
          {stage === 'prompt' && <PromptStage key="p" onNext={next} />}
          {stage === 'compare' && <Compare key="c" onNext={next} />}
          {stage === 'verdicts' && <Verdicts key="v" onNext={next} />}
          {stage === 'insight' && <Insight key="i" onNext={next} />}
          {stage === 'match' && <Match key="m" onNext={next} />}
          {stage === 'check' && <Check key="ch" onNext={next} />}
          {stage === 'done' && <Done key="d" onRestart={() => go('hook')} />}
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
      <div style={{ fontSize: '0.7rem', color: 'var(--muted)', minWidth: 130, textAlign: 'right', letterSpacing: '0.08em', textTransform: 'uppercase' }}>{label}</div>
    </div>
  )
}

// ═══ Stage: Hook ══════════════════════════════════════════════════════════════

function Hook({ onNext, prevProgress, onResume }: { onNext: () => void; prevProgress: ReturnType<typeof getProgress>; onResume: (s: Stage) => void }) {
  const canResume = prevProgress?.lastStage && prevProgress.lastStage !== 'hook' && prevProgress.lastStage !== 'done' && STAGE_ORDER.includes(prevProgress.lastStage as Stage)
  return (
    <StageWrap>
      <motion.div initial={{ scale: 0.5, rotate: -8 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}
        style={{ fontSize: 'clamp(4.5rem, 14vw, 7rem)' }}>🧠</motion.div>
      <Eyebrow>{D.hook.eyebrow}</Eyebrow>
      <H1>{D.hook.headline}</H1>
      <Lede>{D.hook.sub}</Lede>
      {prevProgress?.completedAt && (
        <div style={completeBadge}>✓ You’ve completed this dive before · welcome back</div>
      )}
      <CapyBubble pose="hi">{D.hook.capy}</CapyBubble>
      <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        {canResume && (
          <PrimaryBtn onClick={() => onResume(prevProgress!.lastStage as Stage)}>Resume from {prevProgress!.lastStage} →</PrimaryBtn>
        )}
        <button onClick={onNext} style={canResume ? { ...primaryBtnStyle, background: 'transparent', color: 'var(--cream)', border: '1px solid var(--line)' } : primaryBtnStyle}>
          {canResume ? 'Start over' : 'Show me the prompt →'}
        </button>
      </div>
    </StageWrap>
  )
}

// ═══ Stage: Prompt ════════════════════════════════════════════════════════════

function PromptStage({ onNext }: { onNext: () => void }) {
  return (
    <StageWrap align="start">
      <Eyebrow>The setup</Eyebrow>
      <H1 small>{D.prompt.title}</H1>
      <div style={promptCard}>
        <div style={{ fontSize: '1rem', color: 'var(--cream)', lineHeight: 1.6, marginBottom: '1rem' }}>
          {D.prompt.body}
        </div>
        <pre style={codeBlock}><code>{D.prompt.code}</code></pre>
      </div>
      <CapyBubble pose="thinking">This is a real bug. I sent it to Haiku, Sonnet, and Opus. Now read each answer and *judge them yourself* before I tell you which is which.</CapyBubble>
      <PrimaryBtn onClick={onNext}>Read the three answers →</PrimaryBtn>
    </StageWrap>
  )
}

// ═══ Stage: Compare (blind read) ══════════════════════════════════════════════

function Compare({ onNext }: { onNext: () => void }) {
  const [readCount, setReadCount] = useState(0)
  const [opened, setOpened] = useState<Set<number>>(new Set())

  const open = (i: number) => {
    if (opened.has(i)) return
    const s = new Set(opened); s.add(i); setOpened(s)
    setReadCount(opened.size + 1)
  }

  return (
    <StageWrap align="start">
      <Eyebrow>Read each one</Eyebrow>
      <H1 small>Same prompt, three brains. Tap to read.</H1>
      <div style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>
        Don’t look at the labels yet — just judge the *quality* of each answer.
      </div>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem', width: '100%' }}>
        {D.responses.map((r, i) => {
          const isOpen = opened.has(i)
          return (
            <motion.div key={i} layout style={{ ...responseCard, borderColor: isOpen ? 'var(--line)' : 'var(--line)' }}>
              <button onClick={() => open(i)} style={responseHeader}>
                <span style={{ fontWeight: 800, fontSize: '1rem' }}>{r.label}</span>
                <span style={{ color: 'var(--muted)', fontSize: '0.8rem' }}>{isOpen ? '▾' : '▸ tap to read'}</span>
              </button>
              <AnimatePresence>
                {isOpen && (
                  <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: 'auto', opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }} transition={{ duration: 0.3 }}
                    style={{ overflow: 'hidden' }}>
                    <div style={{ padding: '0 1.2rem 1.2rem' }}>
                      <Markdown text={r.body} />
                      <div style={metaRow}>
                        <Meta label="response time">{r.seconds}s</Meta>
                        <Meta label="tokens out">{r.tokensOut}</Meta>
                        <Meta label="cost">{r.cost}</Meta>
                      </div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          )
        })}
      </div>

      {readCount >= 3 ? (
        <PrimaryBtn onClick={onNext}>Reveal which is which →</PrimaryBtn>
      ) : (
        <div style={{ marginTop: '1.5rem', color: 'var(--muted)', fontSize: '0.85rem', textAlign: 'center' }}>
          Read all three to continue · {readCount}/3
        </div>
      )}
    </StageWrap>
  )
}

// ═══ Stage: Verdicts (reveal + critique) ══════════════════════════════════════

function Verdicts({ onNext }: { onNext: () => void }) {
  return (
    <StageWrap align="start">
      <Eyebrow>Reveal</Eyebrow>
      <H1 small>Here’s who said what — and why it matters.</H1>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', width: '100%' }}>
        {D.responses.map((r, i) => {
          const c = MODEL_COLOR[r.modelKey]
          return (
            <motion.div key={i} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}
              transition={{ delay: i * 0.15 }} style={{ ...verdictCard, borderLeft: `4px solid ${c}` }}>
              <div style={{ display: 'flex', alignItems: 'baseline', gap: '0.75rem', flexWrap: 'wrap', marginBottom: '0.6rem' }}>
                <span style={{ color: 'var(--muted)', fontSize: '0.8rem' }}>{r.label} was</span>
                <span style={{ color: c, fontWeight: 900, fontSize: '1.6rem', textTransform: 'capitalize', letterSpacing: '-0.01em' }}>{r.modelKey}</span>
                <span style={pillTag}>{r.verdict.depth}</span>
                <span style={pillTag}>{r.verdict.accuracy}</span>
              </div>
              <div style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.6 }}>{r.verdict.critique}</div>
            </motion.div>
          )
        })}
      </div>

      <PrimaryBtn onClick={onNext}>The takeaway →</PrimaryBtn>
    </StageWrap>
  )
}

// ═══ Stage: Insight ═══════════════════════════════════════════════════════════

function Insight({ onNext }: { onNext: () => void }) {
  return (
    <StageWrap>
      <Eyebrow>{D.insight.eyebrow}</Eyebrow>
      <H1>{D.insight.headline}</H1>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', maxWidth: 620, marginTop: '1.5rem' }}>
        {D.insight.bullets.map((b) => {
          const c = MODEL_COLOR[b.k.toLowerCase()]
          return (
            <motion.div key={b.k} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}
              style={{ ...insightRow, borderLeft: `4px solid ${c}` }}>
              <div style={{ color: c, fontWeight: 900, fontSize: '1.1rem', minWidth: 90 }}>{b.k}</div>
              <div style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.5 }}>{b.v}</div>
            </motion.div>
          )
        })}
      </div>
      <CapyBubble pose="thinking">{D.insight.capy}</CapyBubble>
      <PrimaryBtn onClick={onNext}>Try it yourself →</PrimaryBtn>
    </StageWrap>
  )
}

// ═══ Stage: Match (interactive) ═══════════════════════════════════════════════

function Match({ onNext }: { onNext: () => void }) {
  const [picks, setPicks] = useState<Record<string, string>>({})
  const allDone = Object.keys(picks).length === D.matching.scenarios.length

  const pick = (sid: string, model: string) => {
    if (picks[sid]) return
    setPicks((p) => ({ ...p, [sid]: model }))
  }

  return (
    <StageWrap align="start">
      <Eyebrow>{D.matching.eyebrow}</Eyebrow>
      <H1 small>{D.matching.headline}</H1>
      <div style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>{D.matching.sub}</div>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem', width: '100%' }}>
        {D.matching.scenarios.map((s, i) => {
          const picked = picks[s.id]
          const correct = picked === s.correct
          return (
            <motion.div key={s.id} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.05 }} style={matchCard}>
              <div style={{ display: 'flex', gap: '0.6rem', alignItems: 'baseline', marginBottom: '0.85rem' }}>
                <span style={{ color: 'var(--muted)', fontSize: '0.7rem', letterSpacing: '0.15em' }}>SCENARIO {i + 1}</span>
              </div>
              <div style={{ color: 'var(--cream)', fontSize: '1rem', lineHeight: 1.5, marginBottom: '1rem' }}>{s.text}</div>
              <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                {D.matching.models.map((m) => {
                  const isPick = picked === m.key
                  const isCorrect = m.key === s.correct
                  const reveal = !!picked
                  let bg = 'var(--surface)', color: string = 'var(--cream)', border = '1px solid var(--line)'
                  if (reveal) {
                    if (isCorrect) { bg = MODEL_COLOR[m.key]; color = '#000'; border = `2px solid ${MODEL_COLOR[m.key]}` }
                    else if (isPick) { bg = 'var(--coral)'; color = '#000' }
                    else { color = 'var(--muted)' }
                  }
                  return (
                    <motion.button key={m.key} whileTap={{ scale: 0.96 }}
                      onClick={() => pick(s.id, m.key)}
                      style={{ ...modelChip, background: bg, color, border }}>
                      <div style={{ fontWeight: 800 }}>{m.label}</div>
                      <div style={{ fontSize: '0.7rem', opacity: 0.7 }}>{m.sub}</div>
                    </motion.button>
                  )
                })}
              </div>
              {picked && (
                <motion.div initial={{ opacity: 0, y: 5 }} animate={{ opacity: 1, y: 0 }}
                  style={{ marginTop: '0.85rem', padding: '0.75rem 0.9rem', background: 'var(--bg)',
                    border: `1px solid ${correct ? MODEL_COLOR[s.correct] : 'var(--line)'}`,
                    borderRadius: 10, fontSize: '0.85rem', color: 'var(--cream)', lineHeight: 1.5 }}>
                  <strong style={{ color: correct ? MODEL_COLOR[s.correct] : 'var(--coral)' }}>{correct ? '✓ ' : '— Worth knowing: '}</strong>
                  {s.why}
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
          Answer all 4 to continue · {Object.keys(picks).length}/4
        </div>
      )}
    </StageWrap>
  )
}

// ═══ Stage: Check ═════════════════════════════════════════════════════════════

function Check({ onNext }: { onNext: () => void }) {
  const [pick, setPick] = useState<number | null>(null)
  const choose = (i: number) => { if (pick === null) setPick(i) }

  return (
    <StageWrap align="start">
      <Eyebrow>{D.check.eyebrow}</Eyebrow>
      <H1 small>{D.check.prompt}</H1>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', marginTop: '1.5rem' }}>
        {D.check.options.map((o, i) => {
          const reveal = pick !== null
          const isPick = pick === i
          const bg = !reveal ? 'var(--surface)' : o.correct ? 'var(--green)' : isPick ? 'var(--coral)' : 'var(--surface)'
          const color = !reveal ? 'var(--cream)' : (o.correct || isPick) ? '#000' : 'var(--muted)'
          const border = !reveal ? '2px solid var(--line)' : o.correct ? '2px solid var(--green)' : '2px solid var(--line)'
          return (
            <motion.button key={i} whileTap={pick === null ? { scale: 0.98 } : {}}
              whileHover={pick === null ? { x: 4 } : {}}
              onClick={() => choose(i)}
              style={{ ...checkOption, background: bg, color, border }}>
              <div style={{ fontWeight: 800, fontSize: '1.05rem' }}>{o.label}</div>
              <div style={{ fontSize: '0.78rem', opacity: 0.75, marginTop: 2 }}>{o.sub}</div>
              {reveal && isPick && (
                <div style={{ marginTop: '0.85rem', fontSize: '0.85rem', lineHeight: 1.55, fontWeight: 400 }}>{o.why}</div>
              )}
              {reveal && !isPick && o.correct && (
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
    </StageWrap>
  )
}

// ═══ Stage: Done ══════════════════════════════════════════════════════════════

function Done({ onRestart }: { onRestart: () => void }) {
  return (
    <StageWrap>
      <motion.div initial={{ scale: 0.5, rotate: -20 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}>
        <Capy pose="celebrating" size={120} />
      </motion.div>
      <Eyebrow>Dive 2 complete</Eyebrow>
      <H1>You can pick a Claude model now.</H1>
      <Lede>Default Sonnet. Drop to Haiku for volume + simple. Climb to Opus when stuck.</Lede>
      <CapyBubble pose="celebrating">That’s how a dive works. Read real artifacts, judge them, apply, then prove it. 4 more dives and you’ll know Claude better than 95% of devs.</CapyBubble>
      <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap', justifyContent: 'center', marginTop: '1rem' }}>
        <PrimaryBtn onClick={onRestart}>Replay dive</PrimaryBtn>
        <Link href="/vibe/learn-claude" style={{ ...secondaryBtnStyle, textDecoration: 'none' }}>Back to Claude</Link>
      </div>
    </StageWrap>
  )
}

// ═══ Tiny building blocks ═════════════════════════════════════════════════════

function StageWrap({ children, align = 'center' }: { children: React.ReactNode; align?: 'center' | 'start' }) {
  return (
    <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.35 }}
      style={{
        maxWidth: 720, margin: '0 auto', padding: '2rem 1.25rem 4rem',
        display: 'flex', flexDirection: 'column', alignItems: align === 'center' ? 'center' : 'flex-start',
        textAlign: align === 'center' ? 'center' : 'left', gap: '0.75rem',
      }}>
      {children}
    </motion.div>
  )
}

function Eyebrow({ children }: { children: React.ReactNode }) {
  return <div style={{ fontSize: '0.7rem', letterSpacing: '0.3em', textTransform: 'uppercase', color: 'var(--green)', fontWeight: 700 }}>{children}</div>
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
  return <p style={{ color: 'var(--muted)', fontSize: '1.05rem', lineHeight: 1.55, margin: '0.25rem 0 0', maxWidth: 560 }}>{children}</p>
}

function CapyBubble({ children, pose = 'hi' }: { children: React.ReactNode; pose?: 'hi' | 'thinking' | 'celebrating' | 'oops' }) {
  return <SharedCapyBubble pose={pose}>{children}</SharedCapyBubble>
}

function PrimaryBtn({ children, onClick }: { children: React.ReactNode; onClick: () => void }) {
  return (
    <motion.button whileHover={{ scale: 1.04 }} whileTap={{ scale: 0.96 }} onClick={onClick}
      style={primaryBtnStyle}>{children}</motion.button>
  )
}

function Meta({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div>
      <div style={{ fontSize: '0.65rem', color: 'var(--muted)', letterSpacing: '0.1em', textTransform: 'uppercase' }}>{label}</div>
      <div style={{ fontSize: '0.9rem', color: 'var(--cream)', fontWeight: 700, marginTop: 2 }}>{children}</div>
    </div>
  )
}

// Tiny markdown-ish renderer: **bold**, `inline code`, ```fenced``` blocks, line breaks
function Markdown({ text }: { text: string }) {
  const parts = useMemo(() => {
    const segments: Array<{ kind: 'code' | 'text'; body: string }> = []
    const re = /```(?:\w+)?\n([\s\S]*?)```/g
    let last = 0; let m: RegExpExecArray | null
    while ((m = re.exec(text)) !== null) {
      if (m.index > last) segments.push({ kind: 'text', body: text.slice(last, m.index) })
      segments.push({ kind: 'code', body: m[1] })
      last = m.index + m[0].length
    }
    if (last < text.length) segments.push({ kind: 'text', body: text.slice(last) })
    return segments
  }, [text])

  return (
    <div style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.65 }}>
      {parts.map((p, i) =>
        p.kind === 'code' ? (
          <pre key={i} style={codeBlock}><code>{p.body.trim()}</code></pre>
        ) : (
          <div key={i} style={{ whiteSpace: 'pre-wrap' }} dangerouslySetInnerHTML={{
            __html: p.body
              .replace(/&/g, '&amp;')
              .replace(/</g, '&lt;')
              .replace(/`([^`]+)`/g, '<code style="background:var(--bg);padding:2px 6px;border-radius:4px;font-size:0.85em;border:1px solid var(--line)">$1</code>')
              .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
          }} />
        )
      )}
    </div>
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

const completeBadge: React.CSSProperties = {
  fontSize: '0.78rem', color: 'var(--green)', background: 'rgba(200,255,0,0.08)',
  border: '1px solid rgba(200,255,0,0.3)', padding: '0.4rem 0.85rem', borderRadius: 999,
  marginTop: '0.5rem',
}

const primaryBtnStyle: React.CSSProperties = {
  marginTop: '1.75rem', padding: '0.95rem 1.75rem', background: 'var(--green)', color: '#000',
  border: 'none', borderRadius: 999, fontWeight: 800, fontSize: '1rem', cursor: 'pointer', letterSpacing: '-0.01em',
}

const secondaryBtnStyle: React.CSSProperties = {
  marginTop: '1.75rem', padding: '0.95rem 1.75rem', background: 'transparent', color: 'var(--cream)',
  border: '1px solid var(--line)', borderRadius: 999, fontWeight: 700, fontSize: '1rem',
  display: 'inline-block',
}

const promptCard: React.CSSProperties = {
  width: '100%', background: 'var(--surface)', border: '1px solid var(--line)',
  borderRadius: 14, padding: '1.25rem', marginTop: '1rem',
}

const codeBlock: React.CSSProperties = {
  background: 'var(--bg)', border: '1px solid var(--line)', borderRadius: 10,
  padding: '0.85rem 1rem', fontSize: '0.8rem', lineHeight: 1.55,
  fontFamily: 'ui-monospace, SFMono-Regular, Menlo, monospace',
  overflowX: 'auto', whiteSpace: 'pre', margin: '0.6rem 0', color: 'var(--cream)',
}

const responseCard: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)', borderRadius: 14, overflow: 'hidden',
}

const responseHeader: React.CSSProperties = {
  width: '100%', padding: '1rem 1.2rem', background: 'transparent', border: 'none',
  display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'pointer',
  color: 'var(--cream)', textAlign: 'left',
}

const metaRow: React.CSSProperties = {
  display: 'flex', gap: '1.5rem', marginTop: '1rem', paddingTop: '0.85rem',
  borderTop: '1px solid var(--line)',
}

const verdictCard: React.CSSProperties = {
  background: 'var(--surface)', borderRadius: 14, padding: '1.1rem 1.25rem',
  border: '1px solid var(--line)',
}

const pillTag: React.CSSProperties = {
  fontSize: '0.7rem', padding: '0.2rem 0.55rem', background: 'var(--bg)', border: '1px solid var(--line)',
  borderRadius: 999, color: 'var(--muted)', letterSpacing: '0.05em',
}

const insightRow: React.CSSProperties = {
  display: 'flex', gap: '1rem', alignItems: 'flex-start', padding: '0.95rem 1.1rem',
  background: 'var(--surface)', borderRadius: 12, textAlign: 'left',
}

const matchCard: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)', borderRadius: 14, padding: '1.1rem 1.25rem',
}

const modelChip: React.CSSProperties = {
  padding: '0.7rem 1rem', borderRadius: 12, cursor: 'pointer', textAlign: 'left', minWidth: 100,
  transition: 'background 0.2s',
}

const checkOption: React.CSSProperties = {
  padding: '1.1rem 1.25rem', borderRadius: 14, cursor: 'pointer', textAlign: 'left', width: '100%',
}
