'use client'

import { useState, useEffect, useCallback } from 'react'
import { motion, AnimatePresence, useMotionValue, useTransform } from 'framer-motion'
import Link from 'next/link'
import type { VibeTopic, PrimerSlide, VibeCard } from '@/lib/vibe-topics'

type Phase = 'intro' | 'primer' | 'transition' | 'check' | 'result'

const ACCENT: Record<NonNullable<PrimerSlide['accent']>, string> = {
  green: '#c8ff00',
  violet: '#C084FC',
  amber: '#F5C842',
  coral: '#FF6B51',
}

export default function VibeExperience({ topic }: { topic: VibeTopic }) {
  const [phase, setPhase] = useState<Phase>('intro')
  const [primerIdx, setPrimerIdx] = useState(0)
  const [cardIdx, setCardIdx] = useState(0)
  const [answers, setAnswers] = useState<boolean[]>([])

  return (
    <div style={shellStyle}>
      <TopBar phase={phase} primerIdx={primerIdx} primerTotal={topic.primer.length} cardIdx={cardIdx} cardTotal={topic.vibeCheck.length} />

      <AnimatePresence mode="wait">
        {phase === 'intro' && (
          <Intro key="intro" topic={topic} onStart={() => setPhase('primer')} />
        )}
        {phase === 'primer' && (
          <Primer
            key="primer"
            topic={topic}
            idx={primerIdx}
            onNext={() => {
              if (primerIdx < topic.primer.length - 1) setPrimerIdx(primerIdx + 1)
              else setPhase('transition')
            }}
            onBack={() => primerIdx > 0 && setPrimerIdx(primerIdx - 1)}
          />
        )}
        {phase === 'transition' && (
          <Transition key="t" onGo={() => setPhase('check')} />
        )}
        {phase === 'check' && (
          <CheckDeck
            key="check"
            topic={topic}
            idx={cardIdx}
            onAnswer={(correct) => {
              setAnswers((a) => [...a, correct])
              if (cardIdx < topic.vibeCheck.length - 1) {
                setTimeout(() => setCardIdx(cardIdx + 1), 1200)
              } else {
                setTimeout(() => setPhase('result'), 1200)
              }
            }}
          />
        )}
        {phase === 'result' && (
          <Result
            key="r"
            topic={topic}
            answers={answers}
            onRetry={() => {
              setAnswers([])
              setCardIdx(0)
              setPhase('check')
            }}
          />
        )}
      </AnimatePresence>
    </div>
  )
}

// ─── Shell ────────────────────────────────────────────────────────────────────

const shellStyle: React.CSSProperties = {
  position: 'fixed',
  inset: 0,
  background: 'var(--bg)',
  color: 'var(--cream)',
  display: 'flex',
  flexDirection: 'column',
  overflow: 'hidden',
  fontFamily: 'system-ui, -apple-system, sans-serif',
}

function TopBar({
  phase, primerIdx, primerTotal, cardIdx, cardTotal,
}: { phase: Phase; primerIdx: number; primerTotal: number; cardIdx: number; cardTotal: number }) {
  let pct = 0
  let label = ''
  if (phase === 'intro') { pct = 0; label = '' }
  else if (phase === 'primer') { pct = ((primerIdx + 1) / primerTotal) * 50; label = `Primer ${primerIdx + 1}/${primerTotal}` }
  else if (phase === 'transition') { pct = 50; label = '' }
  else if (phase === 'check') { pct = 50 + ((cardIdx + 1) / cardTotal) * 50; label = `Vibe check ${cardIdx + 1}/${cardTotal}` }
  else { pct = 100; label = 'Done' }

  return (
    <div style={{ padding: '1rem 1.25rem', display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
      <Link href="/" style={{ color: 'var(--muted)', textDecoration: 'none', fontSize: '0.85rem' }}>← exit</Link>
      <div style={{ flex: 1, height: 6, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
        <motion.div
          animate={{ width: `${pct}%` }}
          transition={{ type: 'spring', stiffness: 120, damping: 20 }}
          style={{ height: '100%', background: 'var(--green)' }}
        />
      </div>
      <div style={{ fontSize: '0.7rem', color: 'var(--muted)', minWidth: 80, textAlign: 'right', letterSpacing: '0.08em', textTransform: 'uppercase' }}>{label}</div>
    </div>
  )
}

// ─── Intro ────────────────────────────────────────────────────────────────────

function Intro({ topic, onStart }: { topic: VibeTopic; onStart: () => void }) {
  return (
    <motion.div
      initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
      style={centerStyle}
    >
      <motion.div
        initial={{ scale: 0.5, rotate: -10 }}
        animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 120 }}
        style={{ fontSize: 'clamp(5rem, 18vw, 9rem)', lineHeight: 1 }}
      >
        {topic.visual}
      </motion.div>
      <div style={{ marginTop: '1.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.75rem', letterSpacing: '0.25em', textTransform: 'uppercase', color: 'var(--green)', fontWeight: 700 }}>
        <span>Vibe Learn</span>
        <span style={{ opacity: 0.4 }}>·</span>
        <span style={{ color: 'var(--muted)' }}>~{topic.estMinutes} min</span>
      </div>
      <h1 style={{ fontSize: 'clamp(2.5rem, 8vw, 4.5rem)', fontWeight: 900, marginTop: '0.5rem', textAlign: 'center', letterSpacing: '-0.02em' }}>
        {topic.title}
      </h1>
      <p style={{ fontSize: 'clamp(1rem, 2.5vw, 1.25rem)', color: 'var(--muted)', marginTop: '0.75rem', maxWidth: 520, textAlign: 'center', lineHeight: 1.5 }}>
        {topic.tagline}
      </p>

      <CapyBubble>Hey, I’m Cap 🦫 — I’ll guide you. 90 seconds, then a quick vibe check. Ready?</CapyBubble>

      <motion.button
        whileHover={{ scale: 1.04 }} whileTap={{ scale: 0.96 }}
        onClick={onStart}
        style={primaryBtn}
      >
        Vibe learn it →
      </motion.button>
    </motion.div>
  )
}

// ─── Primer ───────────────────────────────────────────────────────────────────

function Primer({ topic, idx, onNext, onBack }: { topic: VibeTopic; idx: number; onNext: () => void; onBack: () => void }) {
  const slide = topic.primer[idx]
  const accent = ACCENT[slide.accent ?? 'green']

  // auto-advance timer (optional vibe — primers feel "alive")
  useEffect(() => {
    const t = setTimeout(onNext, 9000)
    return () => clearTimeout(t)
  }, [idx, onNext])

  // keyboard nav
  useEffect(() => {
    const h = (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight' || e.key === ' ') onNext()
      if (e.key === 'ArrowLeft') onBack()
    }
    window.addEventListener('keydown', h)
    return () => window.removeEventListener('keydown', h)
  }, [onNext, onBack])

  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -30 }}
      transition={{ duration: 0.4 }}
      style={{ ...centerStyle, cursor: 'pointer' }}
      onClick={onNext}
    >
      {slide.kicker && (
        <div style={{ fontSize: '0.7rem', letterSpacing: '0.3em', textTransform: 'uppercase', color: accent, fontWeight: 700, marginBottom: '1rem' }}>
          {slide.kicker}
        </div>
      )}

      <motion.div
        key={`v-${idx}`}
        initial={{ scale: 0.6, rotate: -8 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140, damping: 12 }}
        style={{ fontSize: 'clamp(4.5rem, 14vw, 8rem)', lineHeight: 1, marginBottom: '1.5rem' }}
      >
        {slide.visual}
      </motion.div>

      <h2 style={{ fontSize: 'clamp(1.75rem, 5vw, 2.75rem)', fontWeight: 900, textAlign: 'center', maxWidth: 720, letterSpacing: '-0.015em', lineHeight: 1.15 }}>
        {slide.headline}
      </h2>

      {slide.body && (
        <p style={{ fontSize: 'clamp(1rem, 2.2vw, 1.2rem)', color: 'var(--muted)', marginTop: '1rem', maxWidth: 620, textAlign: 'center', lineHeight: 1.6 }}>
          {slide.body}
        </p>
      )}

      {slide.capySays && <CapyBubble>{slide.capySays}</CapyBubble>}

      <div style={{ position: 'absolute', bottom: '2rem', fontSize: '0.75rem', color: 'var(--muted)', letterSpacing: '0.15em', textTransform: 'uppercase' }}>
        tap or → for next
      </div>
    </motion.div>
  )
}

// ─── Transition ───────────────────────────────────────────────────────────────

function Transition({ onGo }: { onGo: () => void }) {
  useEffect(() => {
    const t = setTimeout(onGo, 1600)
    return () => clearTimeout(t)
  }, [onGo])
  return (
    <motion.div
      initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
      style={centerStyle}
    >
      <motion.div
        initial={{ scale: 0.5 }} animate={{ scale: [0.5, 1.2, 1] }}
        transition={{ duration: 1.2 }}
        style={{ fontSize: 'clamp(4rem, 12vw, 7rem)' }}
      >
        🦫
      </motion.div>
      <h2 style={{ fontSize: 'clamp(1.5rem, 4vw, 2.25rem)', fontWeight: 900, marginTop: '1rem' }}>
        Vibe check time.
      </h2>
      <p style={{ color: 'var(--muted)', marginTop: '0.5rem' }}>5 cards. No pressure.</p>
    </motion.div>
  )
}

// ─── Vibe Check ───────────────────────────────────────────────────────────────

function CheckDeck({ topic, idx, onAnswer }: { topic: VibeTopic; idx: number; onAnswer: (correct: boolean) => void }) {
  const card = topic.vibeCheck[idx]
  return (
    <motion.div
      key={`card-${idx}`}
      initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      style={centerStyle}
    >
      {card.kind === 'pick' ? (
        <PickCard card={card} onAnswer={onAnswer} />
      ) : (
        <TrueFalseCard card={card} onAnswer={onAnswer} />
      )}
    </motion.div>
  )
}

function PickCard({ card, onAnswer }: { card: Extract<VibeCard, { kind: 'pick' }>; onAnswer: (c: boolean) => void }) {
  const [chosen, setChosen] = useState<number | null>(null)
  const handle = (i: number) => {
    if (chosen !== null) return
    setChosen(i)
    onAnswer(i === card.correctIndex)
  }
  return (
    <div style={{ width: 'min(560px, 92vw)', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '1rem' }}>
      <h2 style={{ fontSize: 'clamp(1.5rem, 4vw, 2.25rem)', fontWeight: 900, textAlign: 'center', letterSpacing: '-0.01em', lineHeight: 1.2 }}>
        {card.prompt}
      </h2>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', marginTop: '1.5rem' }}>
        {card.options.map((opt, i) => {
          const isChosen = chosen === i
          const isCorrect = i === card.correctIndex
          const reveal = chosen !== null
          const bg = !reveal ? 'var(--surface)' : isCorrect ? 'var(--green)' : isChosen ? 'var(--coral)' : 'var(--surface)'
          const color = !reveal ? 'var(--cream)' : isCorrect ? '#000' : isChosen ? '#000' : 'var(--muted)'
          return (
            <motion.button
              key={i}
              whileHover={chosen === null ? { scale: 1.02, x: 4 } : {}}
              whileTap={chosen === null ? { scale: 0.98 } : {}}
              onClick={() => handle(i)}
              style={{
                ...optionBtn,
                background: bg,
                color,
                border: `2px solid ${reveal && isCorrect ? 'var(--green)' : 'var(--line)'}`,
              }}
            >
              {opt}
            </motion.button>
          )
        })}
      </div>
      {chosen !== null && (
        <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}>
          <CapyBubble>{card.explain}</CapyBubble>
        </motion.div>
      )}
    </div>
  )
}

function TrueFalseCard({ card, onAnswer }: { card: Extract<VibeCard, { kind: 'truefalse' }>; onAnswer: (c: boolean) => void }) {
  const x = useMotionValue(0)
  const rotate = useTransform(x, [-200, 200], [-15, 15])
  const opacity = useTransform(x, [-200, -50, 0, 50, 200], [0.3, 1, 1, 1, 0.3])
  const [picked, setPicked] = useState<boolean | null>(null)

  const handle = (val: boolean) => {
    if (picked !== null) return
    setPicked(val)
    onAnswer(val === card.answer)
  }

  return (
    <div style={{ width: 'min(560px, 92vw)', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '1.25rem' }}>
      <motion.div
        drag={picked === null ? 'x' : false}
        dragConstraints={{ left: 0, right: 0 }}
        style={{ x, rotate, opacity, ...swipeCardStyle }}
        onDragEnd={(_, info) => {
          if (info.offset.x > 120) handle(true)
          else if (info.offset.x < -120) handle(false)
        }}
      >
        <div style={{ fontSize: '0.7rem', letterSpacing: '0.3em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: '1rem' }}>True or False</div>
        <p style={{ fontSize: 'clamp(1.4rem, 3.5vw, 2rem)', fontWeight: 800, textAlign: 'center', lineHeight: 1.25 }}>
          {card.prompt}
        </p>
        <div style={{ marginTop: '1.5rem', fontSize: '0.8rem', color: 'var(--muted)' }}>
          ← swipe false · true swipe →
        </div>
      </motion.div>

      <div style={{ display: 'flex', gap: '0.75rem' }}>
        <motion.button whileTap={{ scale: 0.95 }} onClick={() => handle(false)}
          style={{ ...pillBtn, background: picked === false ? (card.answer === false ? 'var(--green)' : 'var(--coral)') : 'var(--surface)', color: picked === false ? '#000' : 'var(--cream)' }}>
          ✕ False
        </motion.button>
        <motion.button whileTap={{ scale: 0.95 }} onClick={() => handle(true)}
          style={{ ...pillBtn, background: picked === true ? (card.answer === true ? 'var(--green)' : 'var(--coral)') : 'var(--surface)', color: picked === true ? '#000' : 'var(--cream)' }}>
          ✓ True
        </motion.button>
      </div>

      {picked !== null && (
        <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}>
          <CapyBubble>{card.explain}</CapyBubble>
        </motion.div>
      )}
    </div>
  )
}

// ─── Result ───────────────────────────────────────────────────────────────────

function Result({ topic, answers, onRetry }: { topic: VibeTopic; answers: boolean[]; onRetry: () => void }) {
  const correct = answers.filter(Boolean).length
  const total = answers.length
  const pct = Math.round((correct / total) * 100)

  const verdict =
    pct === 100 ? { emoji: '🏆', label: 'Vibed it.', sub: 'You actually know Claude.' } :
    pct >= 60  ? { emoji: '🎯', label: 'Solid vibe.', sub: 'You got the shape of it.' } :
                 { emoji: '🌱', label: 'Vibe planted.', sub: 'Run it back — it sticks fast.' }

  const share = useCallback(() => {
    const text = `Just vibe learned ${topic.title} in 2 min. ${correct}/${total} on the vibe check. → vibelearn.app/vibe/${topic.slug}`
    if (navigator.share) navigator.share({ text }).catch(() => {})
    else navigator.clipboard?.writeText(text)
  }, [topic, correct, total])

  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0 }}
      style={centerStyle}
    >
      <motion.div
        initial={{ scale: 0.4, rotate: -20 }} animate={{ scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140, damping: 12 }}
        style={{ fontSize: 'clamp(5rem, 16vw, 8rem)' }}
      >
        {verdict.emoji}
      </motion.div>
      <h1 style={{ fontSize: 'clamp(2rem, 6vw, 3.5rem)', fontWeight: 900, marginTop: '0.5rem', letterSpacing: '-0.02em' }}>{verdict.label}</h1>
      <p style={{ color: 'var(--muted)', fontSize: '1.1rem', marginTop: '0.25rem' }}>{verdict.sub}</p>

      <div style={{
        marginTop: '1.5rem', padding: '1rem 1.5rem', background: 'var(--surface)', border: '2px solid var(--green)',
        borderRadius: 16, display: 'flex', alignItems: 'baseline', gap: '0.5rem',
      }}>
        <span style={{ fontSize: '2.5rem', fontWeight: 900, color: 'var(--green)' }}>{correct}</span>
        <span style={{ fontSize: '1rem', color: 'var(--muted)' }}>/ {total} on the vibe check</span>
      </div>

      <CapyBubble>You just vibe learned {topic.title}. Tell someone. That’s how the verb spreads.</CapyBubble>

      <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1rem', flexWrap: 'wrap', justifyContent: 'center' }}>
        <motion.button whileTap={{ scale: 0.95 }} onClick={share} style={primaryBtn}>Share the vibe ↗</motion.button>
        <motion.button whileTap={{ scale: 0.95 }} onClick={onRetry} style={secondaryBtn}>Retry check</motion.button>
      </div>

      <div style={{ marginTop: '2rem', width: 'min(560px, 92vw)' }}>
        <div style={{ fontSize: '0.7rem', letterSpacing: '0.25em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: '0.75rem', textAlign: 'center' }}>Go deeper</div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
          {topic.goDeeper.map((g) => (
            <a key={g.href} href={g.href} target="_blank" rel="noopener" style={deepLink}>
              {g.label} <span style={{ color: 'var(--muted)' }}>↗</span>
            </a>
          ))}
        </div>
      </div>
    </motion.div>
  )
}

// ─── Capy bubble ──────────────────────────────────────────────────────────────

function CapyBubble({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }}
      transition={{ delay: 0.2 }}
      style={{
        display: 'flex', alignItems: 'flex-start', gap: '0.6rem', marginTop: '1.5rem',
        padding: '0.75rem 1rem', background: 'var(--surface)', border: '1px solid var(--line)',
        borderRadius: 18, maxWidth: 480,
      }}
    >
      <div style={{ fontSize: '1.5rem', lineHeight: 1, flexShrink: 0 }}>🦫</div>
      <div style={{ fontSize: '0.95rem', color: 'var(--cream)', lineHeight: 1.45 }}>{children}</div>
    </motion.div>
  )
}

// ─── Styles ───────────────────────────────────────────────────────────────────

const centerStyle: React.CSSProperties = {
  flex: 1,
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  justifyContent: 'center',
  padding: '2rem 1.5rem',
  position: 'relative',
}

const primaryBtn: React.CSSProperties = {
  marginTop: '1.5rem',
  padding: '1rem 2rem',
  background: 'var(--green)',
  color: '#000',
  border: 'none',
  borderRadius: 999,
  fontWeight: 800,
  fontSize: '1.05rem',
  cursor: 'pointer',
  letterSpacing: '-0.01em',
}

const secondaryBtn: React.CSSProperties = {
  marginTop: '1.5rem',
  padding: '1rem 2rem',
  background: 'transparent',
  color: 'var(--cream)',
  border: '1px solid var(--line)',
  borderRadius: 999,
  fontWeight: 700,
  fontSize: '1.05rem',
  cursor: 'pointer',
}

const optionBtn: React.CSSProperties = {
  padding: '1.1rem 1.25rem',
  borderRadius: 14,
  fontSize: '1.05rem',
  fontWeight: 700,
  textAlign: 'left',
  cursor: 'pointer',
  transition: 'background 0.2s, color 0.2s',
}

const pillBtn: React.CSSProperties = {
  padding: '0.85rem 1.75rem',
  borderRadius: 999,
  border: '1px solid var(--line)',
  fontWeight: 800,
  fontSize: '1rem',
  cursor: 'pointer',
}

const swipeCardStyle: React.CSSProperties = {
  width: '100%',
  minHeight: 240,
  background: 'var(--surface)',
  border: '2px solid var(--line)',
  borderRadius: 24,
  padding: '2rem 1.5rem',
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  justifyContent: 'center',
  cursor: 'grab',
  userSelect: 'none',
}

const deepLink: React.CSSProperties = {
  padding: '0.85rem 1.1rem',
  background: 'var(--surface)',
  border: '1px solid var(--line)',
  borderRadius: 12,
  color: 'var(--cream)',
  textDecoration: 'none',
  fontSize: '0.95rem',
  fontWeight: 600,
  display: 'flex',
  justifyContent: 'space-between',
  alignItems: 'center',
}
