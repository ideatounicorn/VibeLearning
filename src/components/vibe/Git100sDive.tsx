'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { GIT_100S_DIVE as D } from '@/lib/dive-git-100s'
import { TVPlayer } from './TVPlayer'
import { Capy, CapyBubble } from './Capy'
import Git100sWatch from './Git100sWatch'
import { startDive, updateStage, completeDive, getProgress } from '@/lib/vibe-progress'

type Stage = 'intro' | 'watch' | 'recap' | 'quiz' | 'done'
const STAGES: Stage[] = ['intro', 'watch', 'recap', 'quiz', 'done']

export default function Git100sDive() {
  const [stage, setStage] = useState<Stage>('intro')
  const [score, setScore] = useState<{ correct: number; total: number } | null>(null)
  const [prev, setPrev] = useState<ReturnType<typeof getProgress>>(null)
  const [quitOpen, setQuitOpen] = useState(false)
  const router = useRouter()

  useEffect(() => {
    setPrev(getProgress(D.slug))
    startDive(D.slug)
  }, [])

  useEffect(() => {
    updateStage(D.slug, stage)
    if (stage === 'done' && score) completeDive(D.slug, score)
  }, [stage, score])

  const idx = STAGES.indexOf(stage)
  const pct = (idx / (STAGES.length - 1)) * 100
  const next = () => idx < STAGES.length - 1 && setStage(STAGES[idx + 1])

  const handleExit = () => {
    if (stage === 'intro' || stage === 'done') router.push('/')
    else setQuitOpen(true)
  }

  return (
    <div style={shell}>
      <TopBar pct={pct} label={D.topicLabel} onExit={handleExit} />
      <div style={scrollArea}>
        <AnimatePresence mode="wait">
          {stage === 'intro' && <Intro key="i" onNext={next} prev={prev} onResume={(s: Stage) => setStage(s)} />}
          {stage === 'watch' && <Git100sWatch key="w" onNext={next} />}
          {stage === 'recap' && <Recap key="r" onNext={next} />}
          {stage === 'quiz' && <Quiz key="q" onDone={(s) => { setScore(s); setStage('done') }} />}
          {stage === 'done' && <Done key="d" score={score} onReset={() => setStage('intro')} />}
        </AnimatePresence>
      </div>

      <AnimatePresence>
        {quitOpen && (
          <QuitModal
            stageIdx={idx}
            onStay={() => setQuitOpen(false)}
            onLeave={() => router.push('/')}
          />
        )}
      </AnimatePresence>
    </div>
  )
}

// ═══ Top bar ══════════════════════════════════════════════════════════════════
function TopBar({ pct, label, onExit }: { pct: number; label: string; onExit: () => void }) {
  return (
    <div style={topBar}>
      <button onClick={onExit}
        style={{ color: 'var(--muted)', background: 'transparent', border: 'none', fontSize: '0.85rem', cursor: 'pointer', padding: 0 }}>
        ← exit
      </button>
      <div style={{ flex: 1, height: 6, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
        <motion.div animate={{ width: `${pct}%` }} transition={{ type: 'spring', stiffness: 120, damping: 20 }}
          style={{ height: '100%', background: 'var(--green)' }} />
      </div>
      <div style={{ fontSize: '0.7rem', color: 'var(--muted)', minWidth: 140, textAlign: 'right', letterSpacing: '0.08em', textTransform: 'uppercase' }}>{label}</div>
    </div>
  )
}

// ═══ Intro ════════════════════════════════════════════════════════════════════
function Intro({ onNext, prev, onResume }: { onNext: () => void; prev: ReturnType<typeof getProgress>; onResume: (s: Stage) => void }) {
  const canResume = prev?.lastStage && prev.lastStage !== 'intro' && prev.lastStage !== 'done' && STAGES.includes(prev.lastStage as Stage)
  return (
    <Wrap>
      <Placard rotate={-3}>{D.intro.placard}</Placard>
      <motion.div initial={{ scale: 0.5, rotate: -6 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}>
        <Capy pose="celebrating" size={120} />
      </motion.div>
      <Eyebrow>{D.intro.eyebrow}</Eyebrow>
      <H1>{D.intro.headline}</H1>
      <Lede>{D.intro.sub}</Lede>

      {/* Cap's pick context card */}
      <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}
        style={pickCard}>

        <div style={{ display: 'flex', gap: '0.85rem', alignItems: 'center' }}>
          <div style={{ width: 56, height: 56, borderRadius: 12, background: '#FF0000', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.4rem', flexShrink: 0, color: '#fff' }}>▶</div>
          <div style={{ flex: 1, textAlign: 'left' }}>
            <div style={{ fontWeight: 800, color: 'var(--cream)', fontSize: '1.05rem', lineHeight: 1.25 }}>{D.video.title}</div>
            <div style={{ color: 'var(--muted)', fontSize: '0.8rem', marginTop: 3 }}>
              by {D.video.creator} · {D.video.duration} · YouTube
            </div>
          </div>
        </div>

        {/* Cap's stat row */}
        <div style={{ display: 'flex', gap: '0.5rem', marginTop: '0.9rem', flexWrap: 'wrap' }}>
          <Stat label="Picked from" value={`${D.video.pickedFrom} videos`} />
          <Stat label="Difficulty" value={'●'.repeat(D.video.difficulty) + '○'.repeat(5 - D.video.difficulty)} />
          <Stat label="Watch time" value={D.video.duration} />
        </div>

        {/* Skills */}
        <div style={{ marginTop: '1rem', padding: '0.8rem 0.9rem', background: 'var(--bg)', borderRadius: 10, border: '1px solid var(--line)' }}>
          <div style={{ fontSize: '0.7rem', letterSpacing: '0.15em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: '0.55rem' }}>
            After this you’ll know
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
            {D.video.skillsAfter.map((s) => (
              <div key={s.label} style={{ display: 'flex', alignItems: 'center', gap: '0.55rem', fontSize: '0.88rem', color: 'var(--cream)' }}>
                <span style={{ fontSize: '1.05rem' }}>{s.emoji}</span>
                <span>{s.label}</span>
              </div>
            ))}
          </div>
        </div>

        <div style={{ marginTop: '0.95rem', fontSize: '0.85rem', color: 'var(--cream)', lineHeight: 1.55, fontStyle: 'italic', borderLeft: '2px solid var(--green)', paddingLeft: '0.7rem' }}>
          “{D.video.whyThisOne}” — Cap
        </div>
      </motion.div>

      <CapyBubble pose="hi">{D.intro.capySays}</CapyBubble>

      <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        {canResume && (
          <PrimaryBtn onClick={() => onResume(prev!.lastStage as Stage)}>Resume from {prev!.lastStage} →</PrimaryBtn>
        )}
        <button onClick={onNext} style={canResume ? secondaryBtnStyle : primaryBtnStyle}>
          {canResume ? 'Start over' : 'Watch with Cap →'}
        </button>
      </div>
    </Wrap>
  )
}

function Stat({ label, value }: { label: string; value: string }) {
  return (
    <div style={{
      flex: '1 1 auto', minWidth: 90, padding: '0.5rem 0.7rem',
      background: 'var(--bg)', border: '1px solid var(--line)', borderRadius: 10,
    }}>
      <div style={{ fontSize: '0.6rem', letterSpacing: '0.12em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: 2 }}>{label}</div>
      <div style={{ fontSize: '0.82rem', color: 'var(--cream)', fontWeight: 700, letterSpacing: '0.02em' }}>{value}</div>
    </div>
  )
}

// ═══ Watch — TV with everything around it ═════════════════════════════════════
function Watch({ onNext }: { onNext: () => void }) {
  return (
    <Wrap>
      <Placard rotate={2}>{D.watch.placard}</Placard>

      {/* Pre-video "watch for" mini-card */}
      <motion.div initial={{ opacity: 0, y: -6 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }}
        style={watchForCard}>
        <div style={{ fontSize: '0.65rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--green)', fontWeight: 800, marginBottom: '0.6rem' }}>
          👀 Watch for three things
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.35rem' }}>
          {D.video.watchFor.map((w, i) => (
            <div key={i} style={{ display: 'flex', alignItems: 'flex-start', gap: '0.5rem', fontSize: '0.82rem', color: 'var(--cream)', lineHeight: 1.5 }}>
              <span style={{ color: 'var(--green)', fontWeight: 900, flexShrink: 0 }}>{i + 1}.</span>
              <span>{w}</span>
            </div>
          ))}
        </div>
      </motion.div>

      <TVPlayer
        youtubeId={D.video.youtubeId}
        caption={`${D.video.title} · ${D.video.creator}`}
      />

      <div style={{ marginTop: '4rem' }} /> {/* space for capy that hangs below TV */}

      <PrimaryBtn onClick={onNext}>{D.watch.cta}</PrimaryBtn>
    </Wrap>
  )
}

// ═══ Recap ════════════════════════════════════════════════════════════════════
function Recap({ onNext }: { onNext: () => void }) {
  return (
    <Wrap align="start">
      <Eyebrow>{D.recap.eyebrow}</Eyebrow>
      <H1>{D.recap.headline}</H1>
      <Lede>{D.recap.sub}</Lede>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '0.85rem', width: '100%', marginTop: '1.5rem' }}>
        {D.recap.cards.map((c, i) => (
          <motion.div key={c.title} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}
            transition={{ delay: i * 0.08 }}
            style={{ ...recapCard, borderLeft: `4px solid ${c.color}` }}>
            <div style={{ display: 'flex', gap: '0.85rem', alignItems: 'flex-start' }}>
              <div style={{ fontSize: '1.8rem', lineHeight: 1, flexShrink: 0 }}>{c.emoji}</div>
              <div>
                <div style={{ fontWeight: 800, color: 'var(--cream)', fontSize: '1.05rem', marginBottom: 4 }}>{c.title}</div>
                <div style={{ color: 'var(--muted)', fontSize: '0.9rem', lineHeight: 1.55 }}>
                  <Md text={c.body} />
                </div>
              </div>
            </div>
          </motion.div>
        ))}
      </div>

      <CapyBubble pose="hi">{D.recap.capySays}</CapyBubble>
      <PrimaryBtn onClick={onNext}>Quick check →</PrimaryBtn>
    </Wrap>
  )
}

// inline code in recap body — handles `foo` segments
function Md({ text }: { text: string }) {
  const html = text
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/`([^`]+)`/g, '<code style="background:var(--surface);padding:1px 6px;border-radius:4px;font-size:0.88em;border:1px solid var(--line);font-family:ui-monospace,monospace;color:var(--cream)">$1</code>')
  return <span dangerouslySetInnerHTML={{ __html: html }} />
}

// ═══ Quiz ═════════════════════════════════════════════════════════════════════
function Quiz({ onDone }: { onDone: (score: { correct: number; total: number }) => void }) {
  const [qIdx, setQIdx] = useState(0)
  const [picks, setPicks] = useState<number[]>([])
  const q = D.quiz.questions[qIdx]
  const total = D.quiz.questions.length

  const pick = (i: number) => {
    if (picks.length > qIdx) return
    const next = [...picks, i]
    setPicks(next)
    setTimeout(() => {
      if (qIdx < total - 1) setQIdx(qIdx + 1)
      else {
        const correct = next.reduce((acc, p, idx) => acc + (D.quiz.questions[idx].options[p].correct ? 1 : 0), 0)
        onDone({ correct, total })
      }
    }, 2400)
  }

  const picked = picks[qIdx]

  return (
    <Wrap align="start" key={qIdx}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
        <Eyebrow>{D.quiz.eyebrow}</Eyebrow>
        <span style={{ color: 'var(--muted)', fontSize: '0.75rem' }}>· Q{qIdx + 1}/{total}</span>
      </div>
      <H1 small>{q.q}</H1>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.7rem', width: '100%', marginTop: '1.25rem' }}>
        {q.options.map((o, i) => {
          const reveal = picked !== undefined
          const isPick = picked === i
          const bg = !reveal ? 'var(--surface)' : o.correct ? 'var(--green)' : isPick ? 'var(--coral)' : 'var(--surface)'
          const color = !reveal ? 'var(--cream)' : (o.correct || isPick) ? '#000' : 'var(--muted)'
          const border = !reveal ? '2px solid var(--line)' : o.correct ? '2px solid var(--green)' : '2px solid var(--line)'
          return (
            <motion.button key={i} whileTap={picked === undefined ? { scale: 0.98 } : {}}
              whileHover={picked === undefined ? { x: 4 } : {}}
              onClick={() => pick(i)}
              style={{ padding: '1rem 1.15rem', borderRadius: 12, cursor: 'pointer', textAlign: 'left', width: '100%', background: bg, color, border }}>
              <div style={{ fontWeight: 700, fontSize: '0.98rem', lineHeight: 1.35 }}>{o.label}</div>
              {reveal && (isPick || o.correct) && (
                <div style={{ marginTop: '0.65rem', fontSize: '0.83rem', lineHeight: 1.5, fontWeight: 400 }}>{o.why}</div>
              )}
            </motion.button>
          )
        })}
      </div>
    </Wrap>
  )
}

// ═══ Done — pride moment ══════════════════════════════════════════════════════
function Done({ score, onReset }: { score: { correct: number; total: number } | null; onReset: () => void }) {
  const pct = score ? Math.round((score.correct / score.total) * 100) : 0
  const verdict =
    pct === 100 ? { emoji: '🏆', label: 'Perfect.', sub: 'You got every one.' } :
    pct >= 60  ? { emoji: '🎯', label: 'You did it.', sub: 'Solid. The shape of git is in your head now.' } :
                 { emoji: '🌱', label: 'Good start.', sub: 'Run it back once. The second pass sticks fast.' }

  return (
    <Wrap>
      <motion.div initial={{ scale: 0.5, rotate: -20 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}>
        <Capy pose="celebrating" size={130} />
      </motion.div>

      <Placard rotate={-2}>YOU DID THE THING</Placard>

      <Eyebrow>Dive complete</Eyebrow>
      <H1>{verdict.label}</H1>
      <Lede>{verdict.sub}</Lede>

      {score && (
        <div style={scoreCard}>
          <span style={{ fontSize: '2.5rem', fontWeight: 900, color: 'var(--green)' }}>{score.correct}</span>
          <span style={{ fontSize: '1rem', color: 'var(--muted)' }}>/ {score.total} on the check</span>
        </div>
      )}

      {/* Pride card — what you can now do */}
      <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}
        style={prideCard}>
        <div style={{ fontSize: '0.7rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: '#000', fontWeight: 900, marginBottom: '0.6rem' }}>
          ✦ Receipt of skill
        </div>
        <div style={{ fontSize: '1.15rem', fontWeight: 900, color: '#000', marginBottom: '0.8rem', lineHeight: 1.25 }}>
          {D.pride.headline}
        </div>
        <div style={{ fontSize: '0.9rem', color: '#000', opacity: 0.85, marginBottom: '0.85rem', lineHeight: 1.5 }}>
          {D.pride.body}
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
          {D.pride.skills.map((s) => (
            <div key={s} style={{ display: 'flex', alignItems: 'flex-start', gap: '0.5rem', fontSize: '0.88rem', color: '#000', fontWeight: 600 }}>
              <span style={{ color: '#000', fontWeight: 900 }}>✓</span>
              <span>{s}</span>
            </div>
          ))}
        </div>
      </motion.div>

      <CapyBubble pose="celebrating">{verdict.emoji} That’s how it works. One video, with context, and your brain holds it. Want me to find the next one?</CapyBubble>

      <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        <button onClick={onReset} style={primaryBtnStyle}>Replay dive</button>
        <Link href="/" style={{ ...secondaryBtnStyle, textDecoration: 'none' }}>Back to VibeLearn</Link>
      </div>
    </Wrap>
  )
}

// ═══ Quit modal ═══════════════════════════════════════════════════════════════
function QuitModal({ stageIdx, onStay, onLeave }: { stageIdx: number; onStay: () => void; onLeave: () => void }) {
  return (
    <motion.div
      initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
      style={{
        position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.7)', backdropFilter: 'blur(6px)',
        display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: '1.5rem',
      }}
      onClick={onStay}
    >
      <motion.div
        initial={{ scale: 0.85, y: 20 }} animate={{ scale: 1, y: 0 }} exit={{ scale: 0.85, y: 20 }}
        transition={{ type: 'spring', stiffness: 200, damping: 18 }}
        onClick={(e) => e.stopPropagation()}
        style={{
          background: 'var(--surface)', border: '3px solid var(--line)', borderRadius: 22,
          padding: '1.75rem 1.5rem 1.5rem', maxWidth: 380, width: '100%',
          textAlign: 'center', boxShadow: '0 12px 0 rgba(0,0,0,0.5)',
        }}
      >
        <motion.div animate={{ rotate: [0, -8, 8, -5, 0] }} transition={{ duration: 0.8 }}
          style={{ display: 'flex', justifyContent: 'center', marginBottom: '0.5rem' }}>
          <Capy pose="oops" size={80} />
        </motion.div>
        <h2 style={{ fontSize: '1.4rem', fontWeight: 900, color: 'var(--cream)', margin: '0.5rem 0 0.4rem', letterSpacing: '-0.01em' }}>
          {D.quit.headline}
        </h2>
        <p style={{ color: 'var(--muted)', fontSize: '0.92rem', lineHeight: 1.5, margin: 0 }}>
          {D.quit.body} You’re {stageIdx + 1}/{STAGES.length} of the way through.
        </p>

        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem', marginTop: '1.4rem' }}>
          <button onClick={onStay} style={{ ...primaryBtnStyle, marginTop: 0, width: '100%' }}>
            {D.quit.stay} →
          </button>
          <button onClick={onLeave} style={{
            ...secondaryBtnStyle, marginTop: 0, width: '100%',
            color: 'var(--coral)', borderColor: 'rgba(255,107,81,0.4)',
          }}>
            {D.quit.leave}
          </button>
        </div>
      </motion.div>
    </motion.div>
  )
}

// ═══ Bits ═════════════════════════════════════════════════════════════════════

function Wrap({ children, align = 'center' }: { children: React.ReactNode; align?: 'center' | 'start' }) {
  return (
    <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.35 }}
      style={{
        maxWidth: 800, margin: '0 auto', padding: '2rem 1.25rem 4rem',
        display: 'flex', flexDirection: 'column', alignItems: align === 'center' ? 'center' : 'flex-start',
        textAlign: align === 'center' ? 'center' : 'left', gap: '0.75rem',
      }}>{children}</motion.div>
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
  return <p style={{ color: 'var(--muted)', fontSize: '1.05rem', lineHeight: 1.55, margin: '0.25rem 0 0', maxWidth: 620 }}>{children}</p>
}

function PrimaryBtn({ children, onClick }: { children: React.ReactNode; onClick: () => void }) {
  return (
    <motion.button whileHover={{ scale: 1.04 }} whileTap={{ scale: 0.96 }} onClick={onClick}
      style={primaryBtnStyle}>{children}</motion.button>
  )
}

function Placard({ children, rotate = -3 }: { children: React.ReactNode; rotate?: number }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: -8, rotate: rotate - 4 }}
      animate={{ opacity: 1, y: 0, rotate }}
      transition={{ type: 'spring', stiffness: 120 }}
      style={{
        display: 'inline-block', background: '#F5E1A4', color: '#000',
        padding: '0.45rem 1.1rem', borderRadius: 6, fontWeight: 800, fontSize: '0.8rem',
        letterSpacing: '0.04em', border: '2.5px solid #000',
        boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
        marginBottom: '0.5rem',
      }}>
      {children}
    </motion.div>
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
  marginTop: '1.5rem', padding: '0.95rem 1.75rem', background: 'var(--green)', color: '#000',
  border: 'none', borderRadius: 999, fontWeight: 800, fontSize: '1rem', cursor: 'pointer', letterSpacing: '-0.01em',
}

const secondaryBtnStyle: React.CSSProperties = {
  marginTop: '1.5rem', padding: '0.95rem 1.75rem', background: 'transparent', color: 'var(--cream)',
  border: '1px solid var(--line)', borderRadius: 999, fontWeight: 700, fontSize: '1rem',
  display: 'inline-block', cursor: 'pointer',
}

const pickCard: React.CSSProperties = {
  width: '100%', maxWidth: 580, background: 'var(--surface)', border: '1px solid var(--line)',
  borderRadius: 14, padding: '1.1rem 1.2rem', marginTop: '1rem', textAlign: 'left',
}

const watchForCard: React.CSSProperties = {
  width: '100%', maxWidth: 580,
  background: 'var(--surface)', border: '2px dashed rgba(200,255,0,0.35)',
  borderRadius: 14, padding: '0.95rem 1.1rem', marginBottom: '0.5rem', textAlign: 'left',
}

const recapCard: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)', borderRadius: 12, padding: '1rem 1.1rem',
}

const scoreCard: React.CSSProperties = {
  marginTop: '1rem', padding: '0.85rem 1.5rem', background: 'var(--surface)', border: '2px solid var(--green)',
  borderRadius: 16, display: 'flex', alignItems: 'baseline', gap: '0.5rem',
}

const prideCard: React.CSSProperties = {
  width: '100%', maxWidth: 460, marginTop: '1.5rem',
  background: 'var(--green)',
  border: '3px solid #000', borderRadius: 16,
  padding: '1.2rem 1.3rem',
  boxShadow: '5px 5px 0 rgba(0,0,0,0.85)',
  textAlign: 'left',
  transform: 'rotate(-1.5deg)',
}
