'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { useRouter } from 'next/navigation'

interface GlossaryTerm {
  term: string
  definition: string
  example: string
}

interface QuizQuestion {
  question: string
  options: string[]
  correctIndex: number
  term: string
}

interface IntroData {
  titleCard: { headline: string; subheadline: string; emoji: string }
  glossary: GlossaryTerm[]
  glossaryQuiz: QuizQuestion[]
  courseMap: { overview: string; steps: string[] }
}

interface Props {
  courseId: string
  courseTitle: string
  startHref: string
}

type Phase = 'loading' | 'title' | 'glossary' | 'quiz' | 'map' | 'ready'

const PHASE_COUNT = 5

export default function CourseIntroClient({ courseId, courseTitle, startHref }: Props) {
  const router = useRouter()
  const [phase, setPhase] = useState<Phase>('loading')
  const [data, setData] = useState<IntroData | null>(null)
  const [glossaryIdx, setGlossaryIdx] = useState(0)
  const [quizIdx, setQuizIdx] = useState(0)
  const [selected, setSelected] = useState<number | null>(null)
  const [showAnswer, setShowAnswer] = useState(false)
  const [quizScore, setQuizScore] = useState(0)
  const [flipCard, setFlipCard] = useState(false)

  useEffect(() => {
    fetch('/api/course/flashcards', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ courseId }),
    })
      .then(r => r.json())
      .then(d => {
        setData(d)
        setPhase('title')
      })
      .catch(() => setPhase('title'))
  }, [courseId])

  useEffect(() => {
    if (phase === 'ready') {
      const timer = setTimeout(() => {
        router.push(startHref)
      }, 1500)
      return () => clearTimeout(timer)
    }
  }, [phase, router, startHref])

  const goNext = () => {
    if (phase === 'title') setPhase('glossary')
    else if (phase === 'glossary') {
      if (!data || glossaryIdx < data.glossary.length - 1) {
        setGlossaryIdx(i => i + 1)
        setFlipCard(false)
      } else {
        setPhase('quiz')
        setQuizIdx(0)
        setSelected(null)
        setShowAnswer(false)
      }
    } else if (phase === 'quiz') {
      if (!data || quizIdx < data.glossaryQuiz.length - 1) {
        setQuizIdx(i => i + 1)
        setSelected(null)
        setShowAnswer(false)
      } else {
        setPhase('map')
      }
    } else if (phase === 'map') {
      setPhase('ready')
    } else if (phase === 'ready') {
      router.push(startHref)
    }
  }

  const progressPct = {
    loading: 0, title: 10, glossary: 35, quiz: 65, map: 85, ready: 100,
  }[phase]

  const selectQuizAnswer = (idx: number) => {
    if (showAnswer) return
    setSelected(idx)
    setShowAnswer(true)
    if (data && idx === data.glossaryQuiz[quizIdx].correctIndex) {
      setQuizScore(s => s + 1)
    }
  }

  return (
    <div style={{
      position: 'fixed', inset: 0, zIndex: 9999,
      background: 'var(--ink)',
      display: 'flex', flexDirection: 'column',
    }}>
      {/* Top bar */}
      <div style={{
        padding: '1rem 1.5rem',
        display: 'flex', alignItems: 'center', gap: '1rem',
        borderBottom: '1px solid var(--line)',
        background: 'var(--dim)',
        flexShrink: 0,
      }}>
        <button
          onClick={() => router.back()}
          style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--muted)', padding: '0.25rem', display: 'flex', flexShrink: 0 }}
          title="Exit intro"
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M18 6L6 18M6 6l12 12"/></svg>
        </button>
        <div style={{ flex: 1, height: 8, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
          <motion.div
            animate={{ width: `${progressPct}%` }}
            transition={{ duration: 0.5, ease: 'easeOut' }}
            style={{ height: '100%', background: 'var(--accent)', borderRadius: 999 }}
          />
        </div>
        <div style={{ fontSize: '0.75rem', color: 'var(--muted)', flexShrink: 0 }}>
          {phase === 'loading' ? 'Preparing…' : `${courseTitle}`}
        </div>
      </div>

      {/* Body */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '2rem 1.5rem', overflowY: 'auto' }}>
        <AnimatePresence mode="wait">

          {/* LOADING */}
          {phase === 'loading' && (
            <motion.div
              key="loading"
              initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
              style={{ textAlign: 'center' }}
            >
              <motion.div
                animate={{ rotate: 360 }}
                transition={{ duration: 1.5, repeat: Infinity, ease: 'linear' }}
                style={{ width: 48, height: 48, borderRadius: '50%', border: '3px solid var(--line)', borderTopColor: 'var(--accent)', margin: '0 auto 1.5rem' }}
              />
              <p style={{ color: 'var(--muted)', fontSize: '1rem' }}>Personalizing your intro…</p>
            </motion.div>
          )}

          {/* TITLE CARD */}
          {phase === 'title' && data && (
            <motion.div
              key="title"
              initial={{ opacity: 0, scale: 0.92, y: 30 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: -20 }}
              transition={{ type: 'spring', stiffness: 200, damping: 22 }}
              style={{ textAlign: 'center', maxWidth: 560 }}
            >
              <motion.div
                initial={{ scale: 0 }} animate={{ scale: 1 }}
                transition={{ type: 'spring', stiffness: 300, delay: 0.15 }}
                style={{ fontSize: '5rem', marginBottom: '1.5rem' }}
              >
                {data.titleCard.emoji}
              </motion.div>
              <motion.div
                initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.25 }}
                style={{ fontSize: '0.7rem', fontWeight: 700, letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--accent)', marginBottom: '0.75rem' }}
              >
                Course Intro
              </motion.div>
              <motion.h1
                initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
                style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.8rem, 5vw, 3rem)', color: 'var(--cream)', lineHeight: 1.2, marginBottom: '1rem' }}
              >
                {data.titleCard.headline}
              </motion.h1>
              <motion.p
                initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4 }}
                style={{ fontSize: '1.05rem', color: 'var(--muted)', lineHeight: 1.65, marginBottom: '2.5rem' }}
              >
                {data.titleCard.subheadline}
              </motion.p>
              <motion.div
                initial={{ opacity: 0 }} animate={{ opacity: 1 }}
                transition={{ delay: 0.5 }}
                style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', alignItems: 'center', fontSize: '0.85rem', color: 'var(--muted)', marginBottom: '2.5rem' }}
              >
                {['📖 Learn key terms with flashcards', '🧠 Quick vocabulary check', '🗺️ See your full learning journey'].map((s, i) => (
                  <motion.div key={i} initial={{ opacity: 0, x: -15 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: 0.55 + i * 0.08 }}>
                    {s}
                  </motion.div>
                ))}
              </motion.div>
              <motion.button
                initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.7 }}
                whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
                onClick={goNext}
                className="btn-primary"
                style={{ padding: '0.875rem 2.5rem', fontSize: '1rem', borderRadius: 12 }}
              >
                Let&apos;s go →
              </motion.button>
            </motion.div>
          )}

          {/* GLOSSARY FLASHCARDS */}
          {phase === 'glossary' && data && (
            <motion.div
              key={`glossary-${glossaryIdx}`}
              initial={{ opacity: 0, x: 60 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -60 }}
              transition={{ type: 'spring', stiffness: 280, damping: 28 }}
              style={{ width: '100%', maxWidth: 520, textAlign: 'center' }}
            >
              <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--muted)', letterSpacing: '0.1em', textTransform: 'uppercase', marginBottom: '1rem' }}>
                Flashcard {glossaryIdx + 1} of {data.glossary.length}
              </div>

              {/* Flip card */}
              <div
                style={{ perspective: 1000, cursor: 'pointer', marginBottom: '2rem' }}
                onClick={() => setFlipCard(f => !f)}
              >
                <motion.div
                  animate={{ rotateY: flipCard ? 180 : 0 }}
                  transition={{ duration: 0.55, ease: 'easeInOut' }}
                  style={{ transformStyle: 'preserve-3d', position: 'relative', minHeight: 220 }}
                >
                  {/* Front */}
                  <div style={{
                    position: 'absolute', inset: 0,
                    backfaceVisibility: 'hidden', WebkitBackfaceVisibility: 'hidden',
                    background: 'var(--dim)', border: '2px solid var(--line)',
                    borderRadius: 20, padding: '2.5rem 2rem',
                    display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
                  }}>
                    <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>📚</div>
                    <div style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 4vw, 2rem)', color: 'var(--cream)', fontWeight: 700 }}>
                      {data.glossary[glossaryIdx].term}
                    </div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--muted)', marginTop: '1rem' }}>Tap to flip →</div>
                  </div>
                  {/* Back */}
                  <div style={{
                    position: 'absolute', inset: 0,
                    backfaceVisibility: 'hidden', WebkitBackfaceVisibility: 'hidden',
                    transform: 'rotateY(180deg)',
                    background: 'color-mix(in srgb, var(--accent) 8%, var(--dim))',
                    border: '2px solid color-mix(in srgb, var(--accent) 30%, var(--line))',
                    borderRadius: 20, padding: '2rem',
                    display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '0.75rem',
                  }}>
                    <div style={{ fontSize: '0.68rem', fontWeight: 700, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.1em' }}>
                      {data.glossary[glossaryIdx].term}
                    </div>
                    <p style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.6, textAlign: 'center' }}>
                      {data.glossary[glossaryIdx].definition}
                    </p>
                    <p style={{ color: 'var(--muted)', fontSize: '0.82rem', lineHeight: 1.5, fontStyle: 'italic', textAlign: 'center' }}>
                      e.g. {data.glossary[glossaryIdx].example}
                    </p>
                  </div>
                </motion.div>
              </div>

              <motion.button
                whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
                onClick={goNext}
                className="btn-primary"
                style={{ padding: '0.75rem 2rem', fontSize: '0.95rem', borderRadius: 12 }}
              >
                {glossaryIdx < data.glossary.length - 1 ? 'Next term →' : 'Take the quiz →'}
              </motion.button>
            </motion.div>
          )}

          {/* GLOSSARY QUIZ */}
          {phase === 'quiz' && data && (
            <motion.div
              key={`quiz-${quizIdx}`}
              initial={{ opacity: 0, x: 60 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -60 }}
              transition={{ type: 'spring', stiffness: 280, damping: 28 }}
              style={{ width: '100%', maxWidth: 540 }}
            >
              <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--muted)', letterSpacing: '0.1em', textTransform: 'uppercase', marginBottom: '1.5rem', textAlign: 'center' }}>
                Quick check · {quizIdx + 1} of {data.glossaryQuiz.length}
              </div>

              <motion.h2
                initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }}
                style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.2rem, 3.5vw, 1.7rem)', color: 'var(--cream)', marginBottom: '2rem', lineHeight: 1.4, textAlign: 'center' }}
              >
                {data.glossaryQuiz[quizIdx].question}
              </motion.h2>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginBottom: '1.5rem' }}>
                {data.glossaryQuiz[quizIdx].options.map((opt, i) => {
                  const isCorrect = i === data.glossaryQuiz[quizIdx].correctIndex
                  const isSelected = i === selected
                  let bg = 'var(--dim)'
                  let border = 'var(--line)'
                  let color = 'var(--cream)'
                  if (showAnswer) {
                    if (isCorrect) { bg = 'rgba(34,197,94,0.12)'; border = '#22C55E'; color = '#22C55E' }
                    else if (isSelected && !isCorrect) { bg = 'rgba(255,107,81,0.1)'; border = 'var(--coral)'; color = 'var(--coral)' }
                    else { color = 'var(--muted)' }
                  } else if (isSelected) {
                    bg = 'color-mix(in srgb, var(--accent) 10%, transparent)'
                    border = 'var(--accent)'
                  }
                  return (
                    <motion.button
                      key={i}
                      whileHover={!showAnswer ? { scale: 1.01 } : {}}
                      whileTap={!showAnswer ? { scale: 0.99 } : {}}
                      onClick={() => selectQuizAnswer(i)}
                      disabled={showAnswer}
                      style={{
                        width: '100%', textAlign: 'left', padding: '0.9rem 1.25rem',
                        borderRadius: 12, border: `2px solid ${border}`,
                        background: bg, color, fontSize: '0.95rem', cursor: showAnswer ? 'default' : 'pointer',
                        fontWeight: 500, transition: 'all 0.15s',
                        display: 'flex', alignItems: 'center', gap: '0.75rem',
                      }}
                    >
                      <span style={{
                        width: 28, height: 28, borderRadius: 6, background: 'rgba(255,255,255,0.06)',
                        display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                        fontSize: '0.78rem', fontWeight: 700, flexShrink: 0, textTransform: 'uppercase',
                      }}>
                        {showAnswer && isCorrect ? '✓' : showAnswer && isSelected && !isCorrect ? '✗' : String.fromCharCode(65 + i)}
                      </span>
                      {opt}
                    </motion.button>
                  )
                })}
              </div>

              <AnimatePresence>
                {showAnswer && (
                  <motion.div
                    initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0 }}
                    style={{ marginBottom: '1.5rem', textAlign: 'center' }}
                  >
                    <div style={{ fontSize: '1.5rem', marginBottom: '0.5rem' }}>
                      {selected === data.glossaryQuiz[quizIdx].correctIndex ? '🎉' : '💡'}
                    </div>
                    <p style={{ color: 'var(--muted)', fontSize: '0.85rem' }}>
                      {selected === data.glossaryQuiz[quizIdx].correctIndex
                        ? 'Correct! You got it.'
                        : `The answer is: ${data.glossaryQuiz[quizIdx].options[data.glossaryQuiz[quizIdx].correctIndex]}`}
                    </p>
                  </motion.div>
                )}
              </AnimatePresence>

              {showAnswer && (
                <div style={{ textAlign: 'center' }}>
                  <motion.button
                    initial={{ opacity: 0, scale: 0.9 }} animate={{ opacity: 1, scale: 1 }}
                    whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
                    onClick={goNext}
                    className="btn-primary"
                    style={{ padding: '0.75rem 2rem', fontSize: '0.95rem', borderRadius: 12 }}
                  >
                    {quizIdx < data.glossaryQuiz.length - 1 ? 'Next question →' : `See your path →`}
                  </motion.button>
                </div>
              )}
            </motion.div>
          )}

          {/* COURSE MAP */}
          {phase === 'map' && data && (
            <motion.div
              key="map"
              initial={{ opacity: 0, scale: 0.94, y: 30 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.96, y: -20 }}
              transition={{ type: 'spring', stiffness: 200, damping: 24 }}
              style={{ textAlign: 'center', maxWidth: 520 }}
            >
              {/* Quiz score */}
              {data.glossaryQuiz.length > 0 && (
                <motion.div
                  initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}
                  style={{ marginBottom: '1.5rem' }}
                >
                  <div className="pill pill-green" style={{ fontSize: '0.9rem', padding: '0.4rem 1rem', display: 'inline-block' }}>
                    Vocab score: {quizScore}/{data.glossaryQuiz.length} ✓
                  </div>
                </motion.div>
              )}

              <motion.div
                initial={{ scale: 0 }} animate={{ scale: 1 }}
                transition={{ type: 'spring', stiffness: 250, delay: 0.1 }}
                style={{ fontSize: '3.5rem', marginBottom: '1rem' }}
              >🗺️</motion.div>

              <motion.h2
                initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }}
                style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 4vw, 2rem)', color: 'var(--cream)', marginBottom: '0.75rem' }}
              >
                Your learning journey
              </motion.h2>

              <motion.p
                initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.2 }}
                style={{ color: 'var(--muted)', fontSize: '0.92rem', lineHeight: 1.65, marginBottom: '2rem' }}
              >
                {data.courseMap.overview}
              </motion.p>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginBottom: '2.5rem', textAlign: 'left' }}>
                {data.courseMap.steps.map((step, i) => (
                  <motion.div
                    key={i}
                    initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.25 + i * 0.08 }}
                    style={{
                      display: 'flex', alignItems: 'center', gap: '1rem',
                      padding: '0.875rem 1.25rem',
                      background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 12,
                    }}
                  >
                    <div style={{
                      width: 28, height: 28, borderRadius: '50%', flexShrink: 0,
                      background: 'var(--accent)', color: 'var(--ink)',
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                      fontSize: '0.78rem', fontWeight: 700,
                    }}>
                      {i + 1}
                    </div>
                    <span style={{ color: 'var(--cream)', fontSize: '0.9rem', lineHeight: 1.45 }}>{step}</span>
                    {i === data.courseMap.steps.length - 1 && (
                      <span style={{ marginLeft: 'auto', fontSize: '1rem' }}>🏆</span>
                    )}
                  </motion.div>
                ))}
              </div>

              <motion.button
                initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.6 }}
                whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
                onClick={goNext}
                className="btn-primary"
                style={{ padding: '0.875rem 2.5rem', fontSize: '1rem', borderRadius: 12 }}
              >
                I&apos;m ready — start learning →
              </motion.button>
            </motion.div>
          )}

          {/* READY */}
          {phase === 'ready' && (
            <motion.div
              key="ready"
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ type: 'spring', stiffness: 200, damping: 18 }}
              style={{ textAlign: 'center' }}
            >
              <motion.div
                animate={{ scale: [1, 1.15, 1], rotate: [0, 10, -10, 0] }}
                transition={{ duration: 0.7, delay: 0.1 }}
                style={{ fontSize: '5rem', marginBottom: '1.5rem' }}
              >
                🚀
              </motion.div>
              <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--cream)', marginBottom: '0.5rem' }}>
                You&apos;re ready!
              </h2>
              <p style={{ color: 'var(--muted)', marginBottom: '2rem' }}>Jumping to your first lesson…</p>
              <motion.div
                animate={{ rotate: 360 }}
                transition={{ duration: 1, repeat: Infinity, ease: 'linear' }}
                style={{ width: 32, height: 32, borderRadius: '50%', border: '3px solid var(--line)', borderTopColor: 'var(--accent)', margin: '0 auto' }}
              />
            </motion.div>
          )}

        </AnimatePresence>
      </div>
    </div>
  )
}
