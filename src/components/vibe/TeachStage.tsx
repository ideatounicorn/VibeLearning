'use client'

import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Capy } from './Capy'

// Teach stage — interactive A/B/C cards that teach the concept BEFORE the video.
// Each card: prompt → options → pick → reveal (with teaching content) → next.
// After final card: fires onComplete (parent advances to next stage, typically Watch).

export type TeachCard = {
  prompt: string
  options: { label: string; correct: boolean }[]
  reveal: {
    emoji: string
    headline: string
    body: string
  }
}

export type TeachContent = {
  eyebrow: string
  headline: string
  sub: string
  cards: TeachCard[]
  transitionCta: string
}

export default function TeachStage({
  content,
  onComplete,
}: {
  content: TeachContent
  onComplete: () => void
}) {
  const [idx, setIdx] = useState(0)
  const [picked, setPicked] = useState<number | null>(null)
  const [showReveal, setShowReveal] = useState(false)

  const card = content.cards[idx]
  const total = content.cards.length
  const isLast = idx === total - 1

  const pick = (i: number) => {
    if (picked !== null) return
    setPicked(i)
    // Slight delay before showing the reveal panel, so the option color flash registers
    setTimeout(() => setShowReveal(true), 400)
  }

  const next = () => {
    if (isLast) {
      onComplete()
      return
    }
    setIdx(idx + 1)
    setPicked(null)
    setShowReveal(false)
  }

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.35 }}
      style={{
        maxWidth: 720, margin: '0 auto', padding: '2rem 1.25rem 4rem',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        textAlign: 'center', gap: '0.75rem',
      }}
    >
      {/* Section header (only on first card) */}
      {idx === 0 && (
        <>
          <div style={eyebrow}>{content.eyebrow}</div>
          <h1 style={h1Style}>{content.headline}</h1>
          <p style={ledeStyle}>{content.sub}</p>
        </>
      )}

      {/* Card counter */}
      <div style={{ marginTop: idx === 0 ? '1.5rem' : '0.25rem', fontSize: '0.7rem', color: 'var(--muted)', letterSpacing: '0.2em', textTransform: 'uppercase', fontWeight: 700 }}>
        {idx + 1} / {total}
      </div>

      {/* Card */}
      <motion.div
        key={idx}
        initial={{ opacity: 0, x: 30 }} animate={{ opacity: 1, x: 0 }}
        transition={{ duration: 0.35 }}
        style={teachCard}
      >
        <div style={promptText}>{card.prompt}</div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem', width: '100%', marginTop: '1.25rem' }}>
          {card.options.map((o, i) => {
            const reveal = picked !== null
            const isPick = picked === i
            // For "self-assessment" cards where every option is correct (the final teach card),
            // we treat any pick as neutral-positive (no red flash)
            const allCorrect = card.options.every((opt) => opt.correct)

            let bg = 'var(--surface)', color: string = 'var(--cream)', border = '2px solid var(--line)'
            if (reveal) {
              if (allCorrect && isPick) { bg = 'var(--green)'; color = '#000'; border = '2px solid var(--green)' }
              else if (allCorrect) { color = 'var(--muted)' }
              else if (o.correct) { bg = 'var(--green)'; color = '#000'; border = '2px solid var(--green)' }
              else if (isPick) { bg = 'var(--coral)'; color = '#000' }
              else { color = 'var(--muted)' }
            }

            return (
              <motion.button
                key={i}
                whileTap={picked === null ? { scale: 0.98 } : {}}
                whileHover={picked === null ? { x: 4 } : {}}
                onClick={() => pick(i)}
                style={{
                  padding: '0.9rem 1.1rem', borderRadius: 12, cursor: picked === null ? 'pointer' : 'default',
                  textAlign: 'left', width: '100%', background: bg, color, border,
                  fontWeight: 700, fontSize: '0.95rem', lineHeight: 1.4,
                }}
              >
                {o.label}
              </motion.button>
            )
          })}
        </div>
      </motion.div>

      {/* Reveal panel */}
      <AnimatePresence>
        {showReveal && (
          <motion.div
            initial={{ opacity: 0, y: 12 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -12 }}
            transition={{ type: 'spring', stiffness: 140, damping: 16 }}
            style={revealCard}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.7rem', marginBottom: '0.6rem' }}>
              <motion.div
                initial={{ scale: 0.5, rotate: -8 }} animate={{ scale: 1, rotate: 0 }}
                transition={{ type: 'spring', stiffness: 160 }}
                style={{ fontSize: '2rem', lineHeight: 1 }}
              >
                {card.reveal.emoji}
              </motion.div>
              <div style={{ fontSize: '1.15rem', fontWeight: 900, color: 'var(--cream)', letterSpacing: '-0.01em' }}>
                {card.reveal.headline}
              </div>
            </div>
            <div style={{ color: 'var(--cream)', fontSize: '0.92rem', lineHeight: 1.6, textAlign: 'left' }}>
              {card.reveal.body}
            </div>

            <motion.button
              whileHover={{ scale: 1.04 }} whileTap={{ scale: 0.96 }}
              onClick={next}
              style={{ ...nextBtn, marginTop: '1.1rem' }}
            >
              {isLast ? content.transitionCta : 'Next →'}
            </motion.button>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Cap encouragement (subtle, after first card) */}
      {idx > 0 && !showReveal && (
        <motion.div
          initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.3 }}
          style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', marginTop: '0.75rem', color: 'var(--muted)', fontSize: '0.75rem' }}
        >
          <Capy pose="thinking" size={24} />
          <span>Cap is taking notes…</span>
        </motion.div>
      )}
    </motion.div>
  )
}

// ─── Styles ───────────────────────────────────────────────────────────────────

const eyebrow: React.CSSProperties = {
  fontSize: '0.7rem', letterSpacing: '0.3em', textTransform: 'uppercase',
  color: 'var(--green)', fontWeight: 700,
}

const h1Style: React.CSSProperties = {
  fontSize: 'clamp(1.6rem, 4vw, 2.4rem)',
  fontWeight: 900, color: 'var(--cream)', letterSpacing: '-0.015em',
  lineHeight: 1.2, margin: 0,
}

const ledeStyle: React.CSSProperties = {
  color: 'var(--muted)', fontSize: '1rem', lineHeight: 1.55,
  margin: '0.25rem 0 0', maxWidth: 560,
}

const teachCard: React.CSSProperties = {
  width: '100%', maxWidth: 600,
  background: 'var(--surface)', border: '2px solid var(--line)',
  borderRadius: 18, padding: '1.5rem 1.4rem',
  marginTop: '0.5rem',
  boxShadow: '4px 4px 0 rgba(0,0,0,0.5)',
}

const promptText: React.CSSProperties = {
  fontSize: 'clamp(1.05rem, 2.5vw, 1.3rem)',
  fontWeight: 800, color: 'var(--cream)',
  lineHeight: 1.3, textAlign: 'center',
  letterSpacing: '-0.01em',
}

const revealCard: React.CSSProperties = {
  width: '100%', maxWidth: 600,
  background: 'var(--bg)', border: '2px solid var(--green)',
  borderRadius: 16, padding: '1.1rem 1.2rem',
  boxShadow: '4px 4px 0 rgba(200,255,0,0.15)',
  marginTop: '0.6rem',
}

const nextBtn: React.CSSProperties = {
  padding: '0.85rem 1.6rem', background: 'var(--green)', color: '#000',
  border: 'none', borderRadius: 999, fontWeight: 800, fontSize: '0.98rem',
  cursor: 'pointer', letterSpacing: '-0.01em',
}
