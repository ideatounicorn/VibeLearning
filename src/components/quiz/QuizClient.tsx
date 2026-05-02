'use client'

import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { useRouter } from 'next/navigation'

interface Question {
  id: string
  question: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_option: 'a' | 'b' | 'c' | 'd'
  explanation: string | null
}

interface Props {
  moduleId: string
  moduleTitle: string
  questions: Question[]
  userId: string
  nextPath: string
  nextModuleUrl?: string | null
}

type AnswerState = 'idle' | 'correct' | 'wrong'

export default function QuizClient({ moduleId, moduleTitle, questions, userId, nextPath, nextModuleUrl }: Props) {
  const router = useRouter()
  const [qIdx, setQIdx] = useState(0)
  const [selected, setSelected] = useState<string | null>(null)
  const [answerState, setAnswerState] = useState<AnswerState>('idle')
  const [score, setScore] = useState(0)
  const [finished, setFinished] = useState(false)
  const [finalXP, setFinalXP] = useState(0)
  const [finalPassed, setFinalPassed] = useState(false)
  const [courseCert, setCourseCert] = useState<{ id: string; reference_name: string } | null>(null)
  const [pathCert, setPathCert] = useState<{ id: string; reference_name: string } | null>(null)

  const current = questions[qIdx]
  const optionKeys = ['a', 'b', 'c', 'd'] as const
  const optionValues: Record<string, string> = {
    a: current?.option_a ?? '',
    b: current?.option_b ?? '',
    c: current?.option_c ?? '',
    d: current?.option_d ?? '',
  }

  const handleSelect = (key: string) => {
    if (selected !== null) return
    setSelected(key)

    const isCorrect = key === current.correct_option
    setAnswerState(isCorrect ? 'correct' : 'wrong')
    if (isCorrect) setScore(s => s + 1)

    const delay = isCorrect ? 800 : 1200

    setTimeout(() => {
      setSelected(null)
      setAnswerState('idle')
      if (qIdx < questions.length - 1) {
        setQIdx(i => i + 1)
      } else {
        // Submit results
        const newScore = isCorrect ? score + 1 : score
        submitQuiz(newScore)
      }
    }, delay)
  }

  const submitQuiz = async (finalScore: number) => {
    try {
      const res = await fetch('/api/progress/quiz', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ moduleId, score: finalScore, total: questions.length }),
      })
      const data = await res.json()
      setFinalXP(data.xp)
      setFinalPassed(data.passed)
      if (data.courseCertificate) setCourseCert(data.courseCertificate)
      if (data.pathCertificate) setPathCert(data.pathCertificate)
    } catch {
      setFinalXP(50)
      setFinalPassed(false)
    }
    setFinished(true)
  }

  const getOptionClass = (key: string) => {
    if (selected === null) return 'quiz-option'
    if (key === selected && answerState === 'correct') return 'quiz-option correct animate-correct-pop'
    if (key === selected && answerState === 'wrong') return 'quiz-option wrong animate-wrong-shake'
    if (key === current.correct_option && answerState === 'wrong') return 'quiz-option correct'
    if (key !== selected) return 'quiz-option dimmed'
    return 'quiz-option'
  }

  if (!questions.length) {
    return (
      <div style={{ textAlign: 'center', padding: '4rem', color: 'var(--muted)' }}>
        No quiz questions available for this module yet.
      </div>
    )
  }

  if (finished) {
    return (
      <motion.div
        initial={{ opacity: 0, scale: 0.95 }}
        animate={{ opacity: 1, scale: 1 }}
        style={{
          minHeight: 'calc(100vh - 60px)',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          padding: '2rem',
          textAlign: 'center',
          background: 'var(--ink)',
        }}
      >
        {/* XP Explosion */}
        <motion.div
          initial={{ scale: 0, rotate: -10 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ type: 'spring', stiffness: 300, delay: 0.1 }}
          style={{
            fontSize: '4rem',
            marginBottom: '1.5rem',
          }}
        >
          {finalPassed ? '🎉' : '📚'}
        </motion.div>

        {/* XP award */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="pill pill-green"
          style={{ fontSize: '1rem', padding: '0.4rem 1rem', marginBottom: '1rem' }}
        >
          +{finalXP} XP earned
        </motion.div>

        <h1
          style={{
            fontFamily: 'var(--font-serif)',
            fontSize: 'clamp(2rem, 5vw, 3rem)',
            color: 'var(--cream)',
            marginBottom: '0.5rem',
          }}
        >
          {finalPassed ? 'Module complete!' : 'Good effort!'}
        </h1>
        <p style={{ color: 'var(--muted)', marginBottom: '0.5rem', fontSize: '1rem' }}>
          You scored <strong style={{ color: 'var(--cream)' }}>{score}/{questions.length}</strong>
        </p>
        <p style={{ color: 'var(--muted)', fontSize: '0.9rem', marginBottom: '2.5rem' }}>
          {finalPassed
            ? 'You proved you got it. Next module unlocked.'
            : 'You earned 50 XP. Review the lessons and try again anytime.'}
        </p>

        {/* Certificate earned banners */}
        {(courseCert || pathCert) && (
          <motion.div
            initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.6 }}
            style={{ marginBottom: '2rem', display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', maxWidth: 440 }}
          >
            {pathCert && (
              <div style={{ padding: '1rem 1.25rem', background: 'rgba(245,200,66,0.1)', border: '1.5px solid #F5C84240', borderRadius: 14, display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <span style={{ fontSize: '1.75rem' }}>🏆</span>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: '0.7rem', fontWeight: 700, color: '#F5C842', letterSpacing: '0.1em', textTransform: 'uppercase', marginBottom: '0.2rem' }}>Path Complete!</div>
                  <div style={{ fontSize: '0.85rem', color: 'var(--cream)', fontWeight: 600 }}>{pathCert.reference_name} Certificate</div>
                </div>
                <button onClick={() => router.push(`/certificate/${pathCert.id}`)} style={{ background: '#F5C842', color: '#1a1a2e', border: 'none', borderRadius: 8, padding: '0.4rem 0.8rem', fontSize: '0.78rem', fontWeight: 700, cursor: 'pointer' }}>View →</button>
              </div>
            )}
            {courseCert && !pathCert && (
              <div style={{ padding: '1rem 1.25rem', background: 'rgba(99,102,241,0.1)', border: '1.5px solid #6366F140', borderRadius: 14, display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <span style={{ fontSize: '1.75rem' }}>🎓</span>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: '0.7rem', fontWeight: 700, color: '#6366F1', letterSpacing: '0.1em', textTransform: 'uppercase', marginBottom: '0.2rem' }}>Certificate Earned!</div>
                  <div style={{ fontSize: '0.85rem', color: 'var(--cream)', fontWeight: 600 }}>{courseCert.reference_name}</div>
                </div>
                <button onClick={() => router.push(`/certificate/${courseCert.id}`)} style={{ background: '#6366F1', color: '#fff', border: 'none', borderRadius: 8, padding: '0.4rem 0.8rem', fontSize: '0.78rem', fontWeight: 700, cursor: 'pointer' }}>View →</button>
              </div>
            )}
          </motion.div>
        )}

        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1rem', justifyContent: 'center' }}>
          {nextModuleUrl && (
            <button
              onClick={() => router.push(nextModuleUrl)}
              className="btn-primary"
              style={{ padding: '0.8rem 2.5rem', fontSize: '1rem' }}
            >
              Next Module →
            </button>
          )}
          <button
            onClick={() => router.push(nextPath)}
            className={nextModuleUrl ? 'btn-secondary' : 'btn-primary'}
            style={{ padding: '0.8rem 2.5rem', fontSize: '1rem' }}
          >
            {nextModuleUrl ? 'Back to Path' : 'Continue path →'}
          </button>
          {!finalPassed && (
            <button
              onClick={() => { setQIdx(0); setScore(0); setFinished(false) }}
              className="btn-outline"
              style={{ fontSize: '0.9rem' }}
            >
              Retry quiz
            </button>
          )}
        </div>
      </motion.div>
    )
  }

  return (
    <div
      style={{
        minHeight: 'calc(100vh - 60px)',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '2rem 1.5rem',
        background: 'var(--ink)',
      }}
    >
      {/* Header */}
      <div style={{ width: '100%', maxWidth: 560, marginBottom: '2rem' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.75rem' }}>
          <div style={{ color: 'var(--muted)', fontSize: '0.8rem' }}>
            {moduleTitle}
          </div>
          <div style={{ color: 'var(--muted)', fontSize: '0.8rem' }}>
            {qIdx + 1} / {questions.length}
          </div>
        </div>
        {/* Progress */}
        <div className="progress-bar">
          <div
            className="progress-bar-fill"
            style={{ width: `${((qIdx) / questions.length) * 100}%` }}
          />
        </div>
      </div>

      {/* Question */}
      <AnimatePresence mode="wait">
        <motion.div
          key={qIdx}
          initial={{ opacity: 0, x: 30 }}
          animate={{ opacity: 1, x: 0 }}
          exit={{ opacity: 0, x: -30 }}
          transition={{ duration: 0.25 }}
          style={{ width: '100%', maxWidth: 560 }}
        >
          <h2
            style={{
              fontFamily: 'var(--font-serif)',
              fontSize: 'clamp(1.3rem, 3.5vw, 1.75rem)',
              color: 'var(--cream)',
              marginBottom: '1.5rem',
              lineHeight: 1.4,
            }}
          >
            {current?.question}
          </h2>

          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
            {optionKeys.map(key => (
              <button
                key={key}
                className={getOptionClass(key)}
                onClick={() => handleSelect(key)}
                disabled={selected !== null}
              >
                <span
                  style={{
                    display: 'inline-flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    width: 22,
                    height: 22,
                    borderRadius: 6,
                    background: 'rgba(244,239,228,0.08)',
                    fontSize: '0.75rem',
                    fontWeight: 600,
                    marginRight: '0.6rem',
                    flexShrink: 0,
                    textTransform: 'uppercase',
                  }}
                >
                  {key}
                </span>
                {optionValues[key]}
              </button>
            ))}
          </div>

          {/* Explanation after answer */}
          <AnimatePresence>
            {selected && current.explanation && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: 'auto' }}
                exit={{ opacity: 0, height: 0 }}
                style={{
                  marginTop: '1rem',
                  padding: '0.75rem 1rem',
                  background: answerState === 'correct' ? 'rgba(34,197,94,0.08)' : 'rgba(255,107,81,0.08)',
                  borderRadius: 10,
                  borderLeft: `3px solid ${answerState === 'correct' ? '#22C55E' : 'var(--coral)'}`,
                  color: 'var(--muted)',
                  fontSize: '0.875rem',
                  lineHeight: 1.6,
                }}
              >
                {current.explanation}
              </motion.div>
            )}
          </AnimatePresence>
        </motion.div>
      </AnimatePresence>
    </div>
  )
}
