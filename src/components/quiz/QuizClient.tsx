'use client'

import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { useRouter } from 'next/navigation'
import Link from 'next/link'

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
  moduleIndex?: number
  totalModules?: number
  courseTitle?: string
  courseSlug?: string
  questions: Question[]
  userId: string
  nextPath: string
  nextModuleUrl?: string | null
}

type Phase = 'quiz' | 'results'

export default function QuizClient({
  moduleId, moduleTitle, moduleIndex = 0, totalModules = 10,
  courseTitle = 'Master Claude AI — Zero to Pro', courseSlug = 'master-claude-ai-zero-to-pro',
  questions, userId, nextPath, nextModuleUrl,
}: Props) {
  const router = useRouter()

  // Quiz state
  const [phase, setPhase] = useState<Phase>('quiz')
  const [qIdx, setQIdx] = useState(0)
  const [selected, setSelected] = useState<string | null>(null)
  const [revealed, setRevealed] = useState(false)
  const [score, setScore] = useState(0)
  const [answers, setAnswers] = useState<boolean[]>([]) // track per-Q result

  // Results state
  const [submitting, setSubmitting] = useState(false)
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

  const isCorrect = selected !== null && selected === current?.correct_option
  const isLast = qIdx === questions.length - 1
  const isAllModulesDone = totalModules > 0 && moduleIndex === totalModules - 1

  // Step 1: pick an answer
  const handleSelect = (key: string) => {
    if (revealed) return
    setSelected(key)
    const correct = key === current.correct_option
    if (correct) setScore(s => s + 1)
    setRevealed(true)
    setAnswers(prev => [...prev, correct])
  }

  // Step 2: manually advance
  const handleNext = async () => {
    if (!isLast) {
      setSelected(null)
      setRevealed(false)
      setQIdx(i => i + 1)
    } else {
      // Submit
      setSubmitting(true)
      try {
        const res = await fetch('/api/progress/quiz', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ moduleId, score, total: questions.length }),
        })
        const data = await res.json()
        setFinalXP(data.xp)
        setFinalPassed(data.passed)
        if (data.courseCertificate) setCourseCert(data.courseCertificate)
        if (data.pathCertificate) setPathCert(data.pathCertificate)
      } catch {
        setFinalXP(50)
        setFinalPassed(score >= Math.ceil(questions.length * 0.67))
      }
      setSubmitting(false)
      setPhase('results')
    }
  }

  const retryQuiz = () => {
    setQIdx(0); setSelected(null); setRevealed(false)
    setScore(0); setAnswers([]); setPhase('quiz')
  }

  // ── Option button style ──────────────────────────────────────────────────
  const getOptionStyle = (key: string): React.CSSProperties => {
    const base: React.CSSProperties = {
      width: '100%', textAlign: 'left',
      padding: '1rem 1.25rem',
      borderRadius: 14,
      border: '1.5px solid var(--line)',
      background: 'var(--surface)',
      color: 'var(--cream)',
      fontSize: '0.95rem', lineHeight: 1.5,
      cursor: revealed ? 'default' : 'pointer',
      transition: 'all 0.15s',
      display: 'flex', alignItems: 'flex-start', gap: '0.75rem',
    }
    if (!revealed) {
      if (selected === key) {
        return { ...base, borderColor: 'var(--accent)', background: 'color-mix(in srgb, var(--accent) 10%, transparent)' }
      }
      return base
    }
    if (key === current.correct_option) {
      return { ...base, borderColor: 'var(--success)', background: 'color-mix(in srgb, var(--success) 10%, transparent)', color: 'var(--success)' }
    }
    if (key === selected) {
      return { ...base, borderColor: 'var(--danger)', background: 'color-mix(in srgb, var(--danger) 10%, transparent)', color: 'var(--danger)' }
    }
    return { ...base, opacity: 0.35 }
  }

  // ── No questions fallback ────────────────────────────────────────────────
  if (!questions.length) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '1rem', background: 'var(--bg)' }}>
        <span style={{ fontSize: '3rem' }}>😴</span>
        <p style={{ color: 'var(--text-muted)' }}>Quiz questions coming soon for this module.</p>
        <button onClick={() => router.back()} className="btn-outline">Go back</button>
      </div>
    )
  }

  // ── Results screen ───────────────────────────────────────────────────────
  if (phase === 'results') {
    const pct = Math.round((score / questions.length) * 100)
    const showCertCard = !courseCert && !pathCert // Tease the cert if not yet earned

    return (
      <div style={{
        minHeight: '100vh', background: 'var(--bg)',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        padding: '0 1.25rem 4rem',
        overflowY: 'auto',
      }}>
        {/* Top bar */}
        <div style={{
          width: '100%', maxWidth: 640, display: 'flex', alignItems: 'center',
          justifyContent: 'space-between', padding: '1.25rem 0', marginBottom: '1.5rem',
        }}>
          <Link href={`/courses/${courseSlug}`} style={{ color: 'var(--text-muted)', fontSize: '0.82rem', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
            ← {courseTitle}
          </Link>
          <span style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>Module {moduleIndex + 1} of {totalModules}</span>
        </div>

        <div style={{ width: '100%', maxWidth: 640 }}>
          {/* Score card */}
          <motion.div
            initial={{ opacity: 0, y: 24 }} animate={{ opacity: 1, y: 0 }}
            style={{
              background: 'var(--surface)', border: '1.5px solid var(--line)',
              borderRadius: 20, padding: '2rem', textAlign: 'center', marginBottom: '1.25rem',
            }}
          >
            <motion.div
              initial={{ scale: 0.5 }} animate={{ scale: 1 }}
              transition={{ type: 'spring', stiffness: 280, delay: 0.1 }}
              style={{ fontSize: '4rem', marginBottom: '1rem' }}
            >
              {finalPassed ? '🎉' : '📚'}
            </motion.div>

            <motion.div
              initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.2 }}
              className="pill pill-green"
              style={{ fontSize: '0.9rem', padding: '0.35rem 1rem', marginBottom: '1rem', display: 'inline-flex' }}
            >
              +{finalXP} XP earned
            </motion.div>

            <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.8rem, 4vw, 2.4rem)', color: 'var(--cream)', marginBottom: '0.5rem' }}>
              {finalPassed ? 'Module complete!' : 'Good effort!'}
            </h1>
            <p style={{ color: 'var(--text-muted)', marginBottom: '0.25rem', fontSize: '1rem' }}>
              You scored <strong style={{ color: 'var(--cream)' }}>{score}/{questions.length}</strong>
              <span style={{ color: 'var(--text-muted)', marginLeft: '0.4rem' }}>({pct}%)</span>
            </p>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', marginBottom: '1.5rem' }}>
              {finalPassed
                ? 'You proved you got it. Next module unlocked! 🔓'
                : `Need ${Math.ceil(questions.length * 0.67)} correct to pass. Review the lessons and try again.`}
            </p>

            {/* Score bar */}
            <div style={{ background: 'var(--line)', borderRadius: 999, height: 8, overflow: 'hidden', marginBottom: '0.5rem' }}>
              <motion.div
                initial={{ width: 0 }} animate={{ width: `${pct}%` }} transition={{ duration: 0.8, delay: 0.3 }}
                style={{ height: '100%', borderRadius: 999, background: finalPassed ? 'var(--green)' : 'var(--coral)' }}
              />
            </div>
            <p style={{ fontSize: '0.72rem', color: 'var(--text-muted)' }}>Pass threshold: 67%</p>
          </motion.div>

          {/* Answer review dots */}
          <motion.div
            initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.4 }}
            style={{ marginBottom: '1.25rem', background: 'var(--surface)', border: '1.5px solid var(--line)', borderRadius: 16, padding: '1.25rem' }}
          >
            <p style={{ fontSize: '0.75rem', fontWeight: 700, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.1em', marginBottom: '0.75rem' }}>Question breakdown</p>
            <div style={{ display: 'flex', gap: '0.4rem', flexWrap: 'wrap' }}>
              {answers.map((correct, i) => (
                <motion.div
                  key={i} initial={{ scale: 0 }} animate={{ scale: 1 }} transition={{ delay: 0.05 * i + 0.4 }}
                  title={`Q${i + 1}: ${correct ? 'Correct' : 'Wrong'}`}
                  style={{
                    width: 28, height: 28, borderRadius: 8, display: 'flex', alignItems: 'center', justifyContent: 'center',
                    fontSize: '0.75rem', fontWeight: 700,
                    background: correct ? 'color-mix(in srgb, var(--success) 15%, transparent)' : 'color-mix(in srgb, var(--danger) 15%, transparent)',
                    border: `1.5px solid ${correct ? 'var(--success)' : 'var(--danger)'}`,
                    color: correct ? 'var(--success)' : 'var(--danger)',
                  }}
                >
                  {correct ? '✓' : '✗'}
                </motion.div>
              ))}
            </div>
          </motion.div>

          {/* Certificate earned */}
          {(courseCert || pathCert) && (
            <motion.div initial={{ opacity: 0, y: 16 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.5 }}
              style={{ marginBottom: '1.25rem', display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
              {pathCert && (
                <div style={{ padding: '1.25rem', background: 'color-mix(in srgb, var(--amber) 8%, transparent)', border: '1.5px solid color-mix(in srgb, var(--amber) 35%, transparent)', borderRadius: 16, display: 'flex', alignItems: 'center', gap: '1rem' }}>
                  <span style={{ fontSize: '2rem' }}>🏆</span>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: '0.68rem', fontWeight: 700, color: 'var(--amber)', letterSpacing: '0.12em', textTransform: 'uppercase', marginBottom: '0.25rem' }}>Path Certificate Earned!</div>
                    <div style={{ fontSize: '0.9rem', color: 'var(--cream)', fontWeight: 600 }}>{pathCert.reference_name}</div>
                  </div>
                  <button onClick={() => router.push(`/certificate/${pathCert.id}`)} className="btn-primary" style={{ padding: '0.45rem 1rem', fontSize: '0.8rem', borderRadius: 10 }}>View →</button>
                </div>
              )}
              {courseCert && !pathCert && (
                <div style={{ padding: '1.25rem', background: 'color-mix(in srgb, var(--green) 8%, transparent)', border: '1.5px solid color-mix(in srgb, var(--green) 35%, transparent)', borderRadius: 16, display: 'flex', alignItems: 'center', gap: '1rem' }}>
                  <span style={{ fontSize: '2rem' }}>🎓</span>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: '0.68rem', fontWeight: 700, color: 'var(--green)', letterSpacing: '0.12em', textTransform: 'uppercase', marginBottom: '0.25rem' }}>Course Certificate Earned!</div>
                    <div style={{ fontSize: '0.9rem', color: 'var(--cream)', fontWeight: 600 }}>{courseCert.reference_name}</div>
                  </div>
                  <button onClick={() => router.push(`/certificate/${courseCert.id}`)} className="btn-primary" style={{ padding: '0.45rem 1rem', fontSize: '0.8rem', borderRadius: 10 }}>View →</button>
                </div>
              )}
            </motion.div>
          )}

          {/* Certificate teaser — shown when course isn't done yet */}
          {showCertCard && (
            <motion.div
              initial={{ opacity: 0, y: 16 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.55 }}
              style={{
                marginBottom: '1.25rem', padding: '1.5rem',
                background: 'var(--surface)', border: '1.5px solid var(--line)',
                borderRadius: 18, position: 'relative', overflow: 'hidden',
              }}
            >
              {/* Dashed border preview */}
              <div style={{
                position: 'absolute', inset: 8, borderRadius: 12,
                border: '2px dashed color-mix(in srgb, var(--amber) 30%, transparent)',
                pointerEvents: 'none',
              }} />

              <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', position: 'relative', zIndex: 1 }}>
                <div style={{
                  width: 52, height: 52, borderRadius: 14,
                  background: 'color-mix(in srgb, var(--amber) 12%, transparent)',
                  border: '1.5px solid color-mix(in srgb, var(--amber) 30%, transparent)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.6rem', flexShrink: 0,
                }}>🎓</div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: '0.68rem', fontWeight: 700, color: 'var(--amber)', letterSpacing: '0.12em', textTransform: 'uppercase', marginBottom: '0.3rem' }}>
                    Your certificate awaits
                  </div>
                  <div style={{ fontSize: '0.92rem', fontWeight: 600, color: 'var(--cream)', marginBottom: '0.2rem' }}>
                    {courseTitle}
                  </div>
                  <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                    Complete all {totalModules} modules to unlock your certificate
                  </div>
                </div>
              </div>

              {/* Mini module progress dots */}
              <div style={{ display: 'flex', gap: '0.3rem', marginTop: '1rem', paddingLeft: '0.25rem', position: 'relative', zIndex: 1 }}>
                {Array.from({ length: totalModules }).map((_, i) => (
                  <div key={i} style={{
                    flex: 1, height: 4, borderRadius: 99,
                    background: i <= moduleIndex ? 'var(--green)' : 'var(--line)',
                    transition: 'background 0.3s',
                  }} />
                ))}
              </div>
              <p style={{ fontSize: '0.72rem', color: 'var(--text-muted)', marginTop: '0.5rem', position: 'relative', zIndex: 1 }}>
                {moduleIndex + 1} of {totalModules} modules complete
              </p>
            </motion.div>
          )}

          {/* CTA buttons */}
          <motion.div
            initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.65 }}
            style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap', justifyContent: 'center' }}
          >
            {nextModuleUrl && finalPassed && (
              <button onClick={() => router.push(nextModuleUrl + '?intro=1')} className="btn-primary" style={{ padding: '0.8rem 2rem', fontSize: '1rem', minWidth: 180 }}>
                Next Module →
              </button>
            )}
            {!finalPassed && (
              <button onClick={retryQuiz} className="btn-primary" style={{ padding: '0.8rem 2rem', fontSize: '1rem' }}>
                Retry Quiz
              </button>
            )}
            <button
              onClick={() => router.push(nextModuleUrl && !finalPassed ? `/learn/${courseSlug}/${moduleId.replace('quiz/', '')}` : nextPath)}
              className="btn-outline" style={{ padding: '0.8rem 1.75rem', fontSize: '0.95rem' }}
            >
              {finalPassed && !nextModuleUrl ? 'See my certificate →' : 'Back to course'}
            </button>
          </motion.div>
        </div>
      </div>
    )
  }

  // ── Quiz screen ──────────────────────────────────────────────────────────
  const progress = qIdx / questions.length

  return (
    <div style={{
      minHeight: '100vh', background: 'var(--bg)',
      display: 'flex', flexDirection: 'column', alignItems: 'center',
      padding: '0 1.25rem',
    }}>
      {/* Top bar */}
      <div style={{
        width: '100%', maxWidth: 640,
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '1.25rem 0 0.75rem',
        gap: '1rem',
      }}>
        <Link href={`/courses/${courseSlug}`} style={{ color: 'var(--text-muted)', fontSize: '0.82rem', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '0.35rem', flexShrink: 0 }}>
          ✕
        </Link>

        {/* Progress bar */}
        <div style={{ flex: 1, height: 6, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
          <motion.div
            animate={{ width: `${progress * 100}%` }} transition={{ duration: 0.4 }}
            style={{ height: '100%', background: 'var(--green)', borderRadius: 999 }}
          />
        </div>

        <span style={{ fontSize: '0.78rem', color: 'var(--text-muted)', flexShrink: 0 }}>
          {qIdx + 1}/{questions.length}
        </span>
      </div>

      {/* Module label */}
      <div style={{ width: '100%', maxWidth: 640, marginBottom: '1.5rem' }}>
        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontWeight: 500 }}>
          {moduleTitle} · Module Quiz
        </p>
      </div>

      {/* Question card */}
      <div style={{ width: '100%', maxWidth: 640, flex: 1 }}>
        <AnimatePresence mode="wait">
          <motion.div
            key={qIdx}
            initial={{ opacity: 0, x: 32 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -32 }}
            transition={{ duration: 0.22 }}
          >
            <h2 style={{
              fontFamily: 'var(--font-serif)',
              fontSize: 'clamp(1.25rem, 3.5vw, 1.65rem)',
              color: 'var(--cream)', lineHeight: 1.45,
              marginBottom: '1.5rem',
            }}>
              {current?.question}
            </h2>

            {/* Options */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginBottom: '1.25rem' }}>
              {optionKeys.map(key => (
                <motion.button
                  key={key}
                  whileHover={!revealed ? { y: -1 } : {}}
                  whileTap={!revealed ? { scale: 0.99 } : {}}
                  onClick={() => handleSelect(key)}
                  disabled={revealed}
                  style={getOptionStyle(key)}
                  className={
                    revealed && key === current.correct_option ? 'animate-correct-pop' :
                    revealed && key === selected && key !== current.correct_option ? 'animate-wrong-shake' : ''
                  }
                >
                  {/* Key badge */}
                  <span style={{
                    display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                    width: 24, height: 24, borderRadius: 7, flexShrink: 0,
                    fontSize: '0.72rem', fontWeight: 700, textTransform: 'uppercase',
                    background: revealed && key === current.correct_option ? 'var(--success)'
                      : revealed && key === selected ? 'var(--danger)'
                      : 'color-mix(in srgb, var(--cream) 10%, transparent)',
                    color: revealed && (key === current.correct_option || key === selected) ? 'var(--bg)' : 'var(--cream)',
                  }}>
                    {key}
                  </span>
                  <span style={{ flex: 1 }}>{optionValues[key]}</span>
                  {revealed && key === current.correct_option && <span style={{ flexShrink: 0, fontSize: '1rem' }}>✓</span>}
                  {revealed && key === selected && key !== current.correct_option && <span style={{ flexShrink: 0, fontSize: '1rem' }}>✗</span>}
                </motion.button>
              ))}
            </div>

            {/* Explanation */}
            <AnimatePresence>
              {revealed && current.explanation && (
                <motion.div
                  initial={{ opacity: 0, height: 0, marginBottom: 0 }}
                  animate={{ opacity: 1, height: 'auto', marginBottom: '1.25rem' }}
                  exit={{ opacity: 0, height: 0 }}
                  style={{
                    padding: '0.875rem 1.1rem',
                    background: isCorrect
                      ? 'color-mix(in srgb, var(--success) 8%, transparent)'
                      : 'color-mix(in srgb, var(--danger) 8%, transparent)',
                    borderRadius: 12,
                    borderLeft: `3px solid ${isCorrect ? 'var(--success)' : 'var(--danger)'}`,
                    overflow: 'hidden',
                  }}
                >
                  <p style={{ fontSize: '0.72rem', fontWeight: 700, letterSpacing: '0.1em', textTransform: 'uppercase', color: isCorrect ? 'var(--success)' : 'var(--danger)', marginBottom: '0.35rem' }}>
                    {isCorrect ? '✓ Correct!' : '✗ Not quite'}
                  </p>
                  <p style={{ color: 'var(--text-muted)', fontSize: '0.875rem', lineHeight: 1.6, margin: 0 }}>
                    {current.explanation}
                  </p>
                </motion.div>
              )}
            </AnimatePresence>

            {/* Next button — only appears after answer */}
            <AnimatePresence>
              {revealed && (
                <motion.div initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }}>
                  <button
                    onClick={handleNext}
                    disabled={submitting}
                    className="btn-primary"
                    style={{ width: '100%', padding: '0.875rem', fontSize: '1rem', borderRadius: 14 }}
                  >
                    {submitting ? 'Saving…' : isLast ? 'Finish Quiz →' : 'Next Question →'}
                  </button>
                </motion.div>
              )}
            </AnimatePresence>
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Bottom spacer */}
      <div style={{ height: '3rem' }} />
    </div>
  )
}
