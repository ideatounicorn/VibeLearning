'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import { MEET_CLAUDE_DIVE as D } from '@/lib/dive-meet-claude'
import StoryStage from './StoryStage'
import { Capy, CapyBubble } from './Capy'
import { startDive, updateStage, completeDive, getProgress } from '@/lib/vibe-progress'

type Stage = 'story' | 'quiz' | 'done'
const STAGES: Stage[] = ['story', 'quiz', 'done']

export default function MeetClaudeDive() {
  const [stage, setStage] = useState<Stage>('story')
  const [score, setScore] = useState<{ correct: number; total: number } | null>(null)
  const [quitOpen, setQuitOpen] = useState(false)
  const router = useRouter()

  useEffect(() => {
    startDive(D.slug)
  }, [])

  useEffect(() => {
    updateStage(D.slug, stage)
    if (stage === 'done' && score) completeDive(D.slug, score)
  }, [stage, score])

  const handleExit = () => {
    if (stage === 'done') router.push('/')
    else setQuitOpen(true)
  }

  return (
    <div style={shell}>
      <TopBar label={D.topicLabel} onExit={handleExit} />

      <div style={scrollArea}>
        <AnimatePresence mode="wait">
          {stage === 'story' && (
            <motion.div key="story" initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} style={{ height: '100%' }}>
              <StoryStage panels={D.panels} onComplete={() => setStage('quiz')} />
            </motion.div>
          )}
          {stage === 'quiz' && <Quiz key="quiz" onDone={(s) => { setScore(s); setStage('done') }} />}
          {stage === 'done' && <Done key="done" score={score} onReset={() => setStage('story')} />}
        </AnimatePresence>
      </div>

      <AnimatePresence>
        {quitOpen && (
          <QuitModal onStay={() => setQuitOpen(false)} onLeave={() => router.push('/')} />
        )}
      </AnimatePresence>
    </div>
  )
}

// ═══ Top bar ══════════════════════════════════════════════════════════════════
function TopBar({ label, onExit }: { label: string; onExit: () => void }) {
  return (
    <div style={topBar}>
      <button onClick={onExit}
        style={{ color: 'var(--muted)', background: 'transparent', border: 'none', fontSize: '0.85rem', cursor: 'pointer', padding: 0 }}>
        ← exit
      </button>
      <div style={{ fontSize: '0.7rem', color: 'var(--muted)', letterSpacing: '0.15em', textTransform: 'uppercase', textAlign: 'right' }}>{label}</div>
    </div>
  )
}

// ═══ Quiz ═════════════════════════════════════════════════════════════════════
function Quiz({ onDone }: { onDone: (score: { correct: number; total: number }) => void }) {
  const [qIdx, setQIdx] = useState(0)
  const [picks, setPicks] = useState<number[]>([])
  const q = D.quiz.questions[qIdx]
  const total = D.quiz.questions.length

  const pick = (i: number) => {
    if (picks.length > qIdx) return
    const nextPicks = [...picks, i]
    setPicks(nextPicks)
    setTimeout(() => {
      if (qIdx < total - 1) setQIdx(qIdx + 1)
      else {
        const correct = nextPicks.reduce((acc, p, idx) => acc + (D.quiz.questions[idx].options[p].correct ? 1 : 0), 0)
        onDone({ correct, total })
      }
    }, 2400)
  }

  const picked = picks[qIdx]

  return (
    <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      style={wrapStyle} key={qIdx}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
        <div style={eyebrowStyle}>{D.quiz.eyebrow}</div>
        <span style={{ color: 'var(--muted)', fontSize: '0.75rem' }}>· Q{qIdx + 1}/{total}</span>
      </div>
      <h1 style={h1SmallStyle}>{q.q}</h1>

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
    </motion.div>
  )
}

// ═══ Done ═════════════════════════════════════════════════════════════════════
function Done({ score, onReset }: { score: { correct: number; total: number } | null; onReset: () => void }) {
  const pct = score ? Math.round((score.correct / score.total) * 100) : 0
  const verdict =
    pct === 100 ? { emoji: '🏆', label: 'Perfect.', sub: 'You got every one.' } :
    pct >= 60  ? { emoji: '🎯', label: 'You did it.', sub: 'The shape of Claude is in your head now.' } :
                 { emoji: '🌱', label: 'Good start.', sub: 'Run it back once. The second pass sticks fast.' }

  return (
    <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} style={wrapStyle}>
      <motion.div initial={{ scale: 0.5, rotate: -20 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140 }}>
        <Capy pose="celebrating" size={130} />
      </motion.div>

      <div style={placardYellow}>YOU DID THE THING</div>

      <div style={eyebrowStyle}>Dive complete</div>
      <h1 style={h1Style}>{verdict.label}</h1>
      <p style={ledeStyle}>{verdict.sub}</p>

      {score && (
        <div style={scoreCard}>
          <span style={{ fontSize: '2.5rem', fontWeight: 900, color: 'var(--green)' }}>{score.correct}</span>
          <span style={{ fontSize: '1rem', color: 'var(--muted)' }}>/ {score.total} on the check</span>
        </div>
      )}

      <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}
        style={prideCard}>
        <div style={{ fontSize: '0.7rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: '#000', fontWeight: 900, marginBottom: '0.6rem' }}>
          ✦ Receipt of skill
        </div>
        <div style={{ fontSize: '1.15rem', fontWeight: 900, color: '#000', marginBottom: '0.6rem', lineHeight: 1.25 }}>
          {D.pride.headline}
        </div>
        <div style={{ fontSize: '0.9rem', color: '#000', opacity: 0.85, marginBottom: '0.85rem', lineHeight: 1.5 }}>
          {D.pride.body}
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
          {D.pride.skills.map((s) => (
            <div key={s} style={{ display: 'flex', alignItems: 'flex-start', gap: '0.5rem', fontSize: '0.88rem', color: '#000', fontWeight: 600 }}>
              <span style={{ fontWeight: 900 }}>✓</span>
              <span>{s}</span>
            </div>
          ))}
        </div>
      </motion.div>

      {/* Next lesson teaser */}
      <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.6 }}
        style={nextLessonCard}>
        <div style={{ fontSize: '0.7rem', color: 'var(--green)', letterSpacing: '0.2em', textTransform: 'uppercase', fontWeight: 800, marginBottom: '0.4rem' }}>
          {D.pride.nextLesson.label}
        </div>
        <div style={{ fontSize: '1.05rem', fontWeight: 800, color: 'var(--cream)' }}>
          → {D.pride.nextLesson.title}
        </div>
      </motion.div>

      <CapyBubble pose="celebrating">Most people use Claude as a smarter Google. You don&apos;t anymore. That mental shift IS the lesson.</CapyBubble>

      <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        <button onClick={onReset} style={primaryBtnStyle}>Replay dive</button>
        <Link href="/" style={{ ...secondaryBtnStyle, textDecoration: 'none' }}>Back to VibeLearn</Link>
      </div>
    </motion.div>
  )
}

// ═══ Quit modal ═══════════════════════════════════════════════════════════════
function QuitModal({ onStay, onLeave }: { onStay: () => void; onLeave: () => void }) {
  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
      style={{
        position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.7)', backdropFilter: 'blur(6px)',
        display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: '1.5rem',
      }} onClick={onStay}>
      <motion.div initial={{ scale: 0.85, y: 20 }} animate={{ scale: 1, y: 0 }} exit={{ scale: 0.85, y: 20 }}
        transition={{ type: 'spring', stiffness: 200, damping: 18 }}
        onClick={(e) => e.stopPropagation()}
        style={{
          background: 'var(--surface)', border: '3px solid var(--line)', borderRadius: 22,
          padding: '1.75rem 1.5rem', maxWidth: 380, width: '100%',
          textAlign: 'center', boxShadow: '0 12px 0 rgba(0,0,0,0.5)',
        }}>
        <motion.div animate={{ rotate: [0, -8, 8, -5, 0] }} transition={{ duration: 0.8 }}
          style={{ display: 'flex', justifyContent: 'center', marginBottom: '0.5rem' }}>
          <Capy pose="oops" size={80} />
        </motion.div>
        <h2 style={{ fontSize: '1.4rem', fontWeight: 900, color: 'var(--cream)', margin: '0.5rem 0 0.4rem' }}>
          {D.quit.headline}
        </h2>
        <p style={{ color: 'var(--muted)', fontSize: '0.92rem', lineHeight: 1.5, margin: 0 }}>
          {D.quit.body}
        </p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem', marginTop: '1.4rem' }}>
          <button onClick={onStay} style={{ ...primaryBtnStyle, marginTop: 0, width: '100%' }}>{D.quit.stay} →</button>
          <button onClick={onLeave} style={{
            ...secondaryBtnStyle, marginTop: 0, width: '100%',
            color: 'var(--coral)', borderColor: 'rgba(255,107,81,0.4)',
          }}>{D.quit.leave}</button>
        </div>
      </motion.div>
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
  padding: '0.85rem 1.25rem', display: 'flex', alignItems: 'center', justifyContent: 'space-between',
  borderBottom: '1px solid var(--line)', flexShrink: 0,
}

const scrollArea: React.CSSProperties = { flex: 1, overflow: 'hidden', position: 'relative' }

const wrapStyle: React.CSSProperties = {
  maxWidth: 760, margin: '0 auto', padding: '2rem 1.25rem 4rem',
  display: 'flex', flexDirection: 'column', alignItems: 'center',
  textAlign: 'center', gap: '0.75rem',
  height: '100%', overflowY: 'auto',
}

const eyebrowStyle: React.CSSProperties = {
  fontSize: '0.7rem', letterSpacing: '0.3em', textTransform: 'uppercase',
  color: 'var(--green)', fontWeight: 700,
}

const h1Style: React.CSSProperties = {
  fontSize: 'clamp(1.8rem, 5vw, 2.75rem)', fontWeight: 900,
  color: 'var(--cream)', letterSpacing: '-0.015em', lineHeight: 1.2, margin: 0,
}

const h1SmallStyle: React.CSSProperties = {
  fontSize: 'clamp(1.4rem, 3.5vw, 2rem)', fontWeight: 900,
  color: 'var(--cream)', letterSpacing: '-0.015em', lineHeight: 1.2, margin: 0,
}

const ledeStyle: React.CSSProperties = {
  color: 'var(--muted)', fontSize: '1.05rem', lineHeight: 1.55,
  margin: '0.25rem 0 0', maxWidth: 600,
}

const primaryBtnStyle: React.CSSProperties = {
  marginTop: '1.5rem', padding: '0.95rem 1.75rem', background: 'var(--green)', color: '#000',
  border: 'none', borderRadius: 999, fontWeight: 800, fontSize: '1rem', cursor: 'pointer', letterSpacing: '-0.01em',
}

const secondaryBtnStyle: React.CSSProperties = {
  marginTop: '1.5rem', padding: '0.95rem 1.75rem', background: 'transparent', color: 'var(--cream)',
  border: '1px solid var(--line)', borderRadius: 999, fontWeight: 700, fontSize: '1rem',
  display: 'inline-block', cursor: 'pointer',
}

const placardYellow: React.CSSProperties = {
  display: 'inline-block', background: '#F5E1A4', color: '#000',
  padding: '0.45rem 1.1rem', borderRadius: 6, fontWeight: 800, fontSize: '0.8rem',
  letterSpacing: '0.04em', border: '2.5px solid #000',
  boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
  marginBottom: '0.5rem', transform: 'rotate(-2deg)',
}

const scoreCard: React.CSSProperties = {
  marginTop: '1rem', padding: '0.85rem 1.5rem',
  background: 'var(--surface)', border: '2px solid var(--green)',
  borderRadius: 16, display: 'flex', alignItems: 'baseline', gap: '0.5rem',
}

const prideCard: React.CSSProperties = {
  width: '100%', maxWidth: 460, marginTop: '1.5rem',
  background: 'var(--green)',
  border: '3px solid #000', borderRadius: 16,
  padding: '1.2rem 1.3rem',
  boxShadow: '5px 5px 0 rgba(0,0,0,0.85)',
  textAlign: 'left', transform: 'rotate(-1.5deg)',
}

const nextLessonCard: React.CSSProperties = {
  width: '100%', maxWidth: 460, marginTop: '1.25rem',
  background: 'var(--surface)', border: '1px solid var(--line)',
  borderRadius: 12, padding: '0.85rem 1rem',
  textAlign: 'left',
}
