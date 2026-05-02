'use client'

import { useState, useEffect, useRef, useCallback } from 'react'
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
  topic: string | null
}

interface Props {
  assessmentId: string
  assessmentTitle: string
  assessmentSlug: string
  questions: Question[]
  isLoggedIn: boolean
  userProfile?: { full_name: string | null; career_goal: string | null } | null
}

interface TopicResult {
  topic: string
  correct: number
  total: number
  pct: number
}

interface RecommendedCourse {
  id: string
  title: string
  slug: string
  level: string
  description: string | null
}

interface Report {
  totalCorrect: number
  totalQ: number
  pct: number
  xp: number
  percentile: number
  topics: TopicResult[]
  strengths: TopicResult[]
  weaknesses: TopicResult[]
  timeTaken: number
  summary?: string
  recommendedPath?: { id: string; name: string; slug: string; description: string; category: string } | null
  recommendedCourses?: RecommendedCourse[]
}

const QUESTION_TIME = 30
const XP_PER_CORRECT = 30

const CATEGORY_COLORS: Record<string, string> = {
  AI: '#6366F1', Design: '#C084FC', Product: '#F5C842',
  Marketing: '#FB923C', Data: '#34D399',
}

export default function AssessmentQuiz({
  assessmentId, assessmentTitle, assessmentSlug, questions, isLoggedIn, userProfile,
}: Props) {
  const router = useRouter()
  const [qIdx, setQIdx] = useState(0)
  const [selected, setSelected] = useState<string | null>(null)
  const [showFeedback, setShowFeedback] = useState(false)
  const [isCorrect, setIsCorrect] = useState(false)
  const [timeLeft, setTimeLeft] = useState(QUESTION_TIME)
  const [floatingXP, setFloatingXP] = useState(false)
  const [state, setState] = useState<'playing' | 'submitting' | 'report'>('playing')
  const [report, setReport] = useState<Report | null>(null)
  const [answers, setAnswers] = useState<Array<{
    questionId: string; selected: number | null; correct: number; topic: string; isCorrect: boolean
  }>>([])
  const startTimeRef = useRef(Date.now())
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null)

  const optionKeys = ['a', 'b', 'c', 'd'] as const
  const current = questions[qIdx]

  const recordAndAdvance = useCallback((selectedKey: string | null) => {
    if (timerRef.current) clearInterval(timerRef.current)

    const correctKey = current?.correct_option
    const correct = selectedKey === correctKey
    const selectedIdx = selectedKey ? optionKeys.indexOf(selectedKey as any) : null
    const correctIdx = optionKeys.indexOf(correctKey as any)

    setIsCorrect(correct)
    setSelected(selectedKey)
    setShowFeedback(true)

    const newAnswer = {
      questionId: current.id,
      selected: selectedIdx,
      correct: correctIdx,
      topic: current.topic ?? 'General',
      isCorrect: correct,
    }

    if (correct) {
      setFloatingXP(true)
      setTimeout(() => setFloatingXP(false), 1200)
    }

    const updatedAnswers = [...answers, newAnswer]
    setAnswers(updatedAnswers)

    // Auto-advance after feedback
    setTimeout(() => {
      setShowFeedback(false)
      setSelected(null)

      if (qIdx >= questions.length - 1) {
        submitResults(updatedAnswers)
      } else {
        setQIdx(i => i + 1)
        setTimeLeft(QUESTION_TIME)
      }
    }, correct ? 900 : 1400)
  }, [current, qIdx, questions, answers])

  // Timer
  useEffect(() => {
    if (state !== 'playing' || showFeedback) return
    setTimeLeft(QUESTION_TIME)
    timerRef.current = setInterval(() => {
      setTimeLeft(t => {
        if (t <= 1) {
          clearInterval(timerRef.current!)
          recordAndAdvance(null) // auto-skip, mark wrong
          return QUESTION_TIME
        }
        return t - 1
      })
    }, 1000)
    return () => { if (timerRef.current) clearInterval(timerRef.current) }
  }, [qIdx, state, showFeedback])

  const handleSelect = (key: string) => {
    if (selected !== null || showFeedback) return
    recordAndAdvance(key)
  }

  const submitResults = async (finalAnswers: typeof answers) => {
    setState('submitting')
    const timeTaken = Math.round((Date.now() - startTimeRef.current) / 1000)

    try {
      const [reportRes, recommendRes] = await Promise.all([
        fetch('/api/assessments/report', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ assessmentId, answers: finalAnswers, questions, timeTaken }),
        }),
        fetch('/api/assessments/recommend', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            assessmentSlug,
            weaknesses: finalAnswers.filter(a => !a.isCorrect).reduce((acc, a) => {
              const topic = a.topic
              if (!acc.find((x: any) => x.topic === topic)) acc.push({ topic })
              return acc
            }, [] as { topic: string }[]),
            strengths: finalAnswers.filter(a => a.isCorrect).reduce((acc, a) => {
              const topic = a.topic
              if (!acc.find((x: any) => x.topic === topic)) acc.push({ topic })
              return acc
            }, [] as { topic: string }[]),
            pct: Math.round((finalAnswers.filter(a => a.isCorrect).length / finalAnswers.length) * 100),
            careerGoal: userProfile?.career_goal ?? '',
          }),
        }),
      ])

      const reportData = await reportRes.json()
      const recommendData = await recommendRes.json()

      setReport({ ...reportData, ...recommendData })
    } catch {
      const correct = finalAnswers.filter(a => a.isCorrect).length
      const pct = Math.round((correct / finalAnswers.length) * 100)
      setReport({
        totalCorrect: correct,
        totalQ: finalAnswers.length,
        pct,
        xp: correct * XP_PER_CORRECT,
        percentile: 50,
        topics: [],
        strengths: [],
        weaknesses: [],
        timeTaken: Math.round((Date.now() - startTimeRef.current) / 1000),
      })
    }
    setState('report')
  }

  const getOptionStyle = (key: string): React.CSSProperties => {
    const base: React.CSSProperties = {
      width: '100%', textAlign: 'left', padding: '1rem 1.25rem', borderRadius: 14,
      borderWidth: '2px', borderStyle: 'solid', borderColor: 'var(--line)',
      background: 'var(--dim)', color: 'var(--cream)',
      fontSize: '1rem', cursor: selected ? 'default' : 'pointer',
      transition: 'all 0.15s', display: 'flex', alignItems: 'center', gap: '0.75rem', fontWeight: 500,
    }
    if (!showFeedback) {
      if (selected === key) return { ...base, borderColor: 'var(--accent)', background: 'color-mix(in srgb, var(--accent) 10%, transparent)' }
      return base
    }
    if (key === current.correct_option) return { ...base, borderColor: '#22C55E', background: 'rgba(34,197,94,0.12)', color: '#22C55E' }
    if (key === selected && key !== current.correct_option) return { ...base, borderColor: 'var(--coral)', background: 'rgba(255,107,81,0.1)', color: 'var(--coral)' }
    return { ...base, opacity: 0.35 }
  }

  const progressPct = (qIdx / questions.length) * 100
  const timerPct = (timeLeft / QUESTION_TIME) * 100
  const timerColor = timeLeft <= 5 ? '#FF6B51' : timeLeft <= 10 ? '#F5C842' : '#34D399'

  // ─── SUBMITTING ───
  if (state === 'submitting') {
    return (
      <div style={{ minHeight: '100vh', background: 'var(--ink)', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '1.5rem' }}>
        <motion.div
          animate={{ rotate: 360 }}
          transition={{ duration: 1.2, repeat: Infinity, ease: 'linear' }}
          style={{ width: 56, height: 56, borderRadius: '50%', border: '4px solid var(--line)', borderTopColor: 'var(--accent)' }}
        />
        <p style={{ color: 'var(--muted)', fontSize: '1rem' }}>Generating your report…</p>
      </div>
    )
  }

  // ─── REPORT ───
  if (state === 'report' && report) {
    const passed = report.pct >= 70
    const initials = userProfile?.full_name
      ? userProfile.full_name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase()
      : '?'

    const formatTime = (s: number) => {
      const m = Math.floor(s / 60)
      const sec = s % 60
      return m > 0 ? `${m}m ${sec}s` : `${sec}s`
    }

    return (
      <div style={{ minHeight: '100vh', background: 'var(--ink)', overflowY: 'auto' }}>
        {/* Header */}
        <div style={{ background: 'var(--dim)', borderBottom: '1px solid var(--line)', padding: '1rem 1.5rem', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <button onClick={() => router.push(`/assessments/${assessmentSlug}`)} style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--muted)', display: 'flex', alignItems: 'center', gap: '0.4rem', fontSize: '0.85rem' }}>
            ← Back
          </button>
          <span style={{ color: 'var(--muted)', fontSize: '0.85rem' }}>Assessment Complete</span>
          <div style={{ width: 60 }} />
        </div>

        <div style={{ maxWidth: 720, margin: '0 auto', padding: '2.5rem 1.5rem' }}>

          {/* Hero score card */}
          <motion.div
            initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }}
            style={{
              background: 'var(--dim)', border: '1.5px solid var(--line)',
              borderRadius: 24, padding: '2rem', marginBottom: '1.5rem',
              display: 'flex', alignItems: 'center', gap: '1.5rem', flexWrap: 'wrap',
            }}
          >
            {/* Avatar */}
            <div style={{
              width: 64, height: 64, borderRadius: '50%', background: 'var(--accent)',
              color: 'var(--ink)', display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontWeight: 700, fontSize: '1.5rem', flexShrink: 0,
            }}>
              {initials}
            </div>

            <div style={{ flex: 1, minWidth: 180 }}>
              <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.1em', marginBottom: '0.2rem' }}>
                {assessmentTitle}
              </div>
              <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 3vw, 1.9rem)', color: 'var(--cream)', marginBottom: '0.3rem' }}>
                {userProfile?.full_name ?? 'Your'} Results
              </h1>
              {userProfile?.career_goal && (
                <div style={{ fontSize: '0.8rem', color: 'var(--muted)' }}>
                  Goal: <span style={{ color: 'var(--accent)', textTransform: 'capitalize' }}>{userProfile.career_goal.replace(/-/g, ' ')}</span>
                </div>
              )}
            </div>

            {/* Score ring */}
            <div style={{ textAlign: 'center', flexShrink: 0 }}>
              <div style={{ position: 'relative', width: 96, height: 96 }}>
                <svg width="96" height="96" style={{ transform: 'rotate(-90deg)' }}>
                  <circle cx="48" cy="48" r="40" fill="none" stroke="var(--line)" strokeWidth="8" />
                  <motion.circle
                    cx="48" cy="48" r="40" fill="none"
                    stroke={passed ? '#34D399' : report.pct >= 50 ? '#F5C842' : 'var(--coral)'}
                    strokeWidth="8" strokeLinecap="round"
                    strokeDasharray={`${2 * Math.PI * 40}`}
                    initial={{ strokeDashoffset: 2 * Math.PI * 40 }}
                    animate={{ strokeDashoffset: 2 * Math.PI * 40 * (1 - report.pct / 100) }}
                    transition={{ duration: 1.2, ease: 'easeOut', delay: 0.3 }}
                  />
                </svg>
                <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                  <div style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--cream)', lineHeight: 1 }}>{report.pct}%</div>
                  <div style={{ fontSize: '0.6rem', color: 'var(--muted)', marginTop: '0.1rem' }}>{report.totalCorrect}/{report.totalQ}</div>
                </div>
              </div>
              <div style={{ fontSize: '0.72rem', color: passed ? '#34D399' : 'var(--coral)', fontWeight: 700, marginTop: '0.4rem' }}>
                {passed ? '✓ Passed' : '✗ Needs work'}
              </div>
            </div>
          </motion.div>

          {/* Stats row */}
          <motion.div
            initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }}
            style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '0.75rem', marginBottom: '1.5rem' }}
            className="stats-grid"
          >
            {[
              { label: 'Score', value: `${report.pct}%`, color: passed ? '#34D399' : 'var(--coral)' },
              { label: 'Percentile', value: `Top ${100 - report.percentile}%`, color: 'var(--accent)' },
              { label: 'XP Earned', value: `+${report.xp}`, color: '#F5C842' },
              { label: 'Time', value: formatTime(report.timeTaken), color: 'var(--muted)' },
            ].map((s, i) => (
              <motion.div
                key={s.label}
                initial={{ opacity: 0, scale: 0.85 }} animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: 0.2 + i * 0.06 }}
                style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 14, padding: '1rem', textAlign: 'center' }}
              >
                <div style={{ fontSize: '1.3rem', fontWeight: 700, color: s.color, marginBottom: '0.2rem' }}>{s.value}</div>
                <div style={{ fontSize: '0.72rem', color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.07em' }}>{s.label}</div>
              </motion.div>
            ))}
          </motion.div>

          {/* Where you are → where you want to be */}
          {report.summary && (
            <motion.div
              initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}
              style={{ background: 'color-mix(in srgb, var(--accent) 8%, var(--dim))', border: '1px solid color-mix(in srgb, var(--accent) 20%, var(--line))', borderRadius: 16, padding: '1.25rem 1.5rem', marginBottom: '1.5rem' }}
            >
              <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--accent)', textTransform: 'uppercase', letterSpacing: '0.1em', marginBottom: '0.5rem' }}>
                📍 Where you stand
              </div>
              <p style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.6, margin: 0 }}>
                {report.summary}
              </p>
              {userProfile?.career_goal && (
                <p style={{ color: 'var(--muted)', fontSize: '0.85rem', marginTop: '0.5rem', marginBottom: 0 }}>
                  🎯 Your goal: <strong style={{ color: 'var(--cream)', textTransform: 'capitalize' }}>{userProfile.career_goal.replace(/-/g, ' ')}</strong>
                </p>
              )}
            </motion.div>
          )}

          {/* Topic breakdown */}
          {report.topics.length > 0 && (
            <motion.div
              initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.35 }}
              style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 20, padding: '1.5rem', marginBottom: '1.5rem' }}
            >
              <h2 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1.25rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                📊 Topic Breakdown
              </h2>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.875rem' }}>
                {report.topics.map((t, i) => (
                  <motion.div
                    key={t.topic}
                    initial={{ opacity: 0, x: -15 }} animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: 0.4 + i * 0.05 }}
                  >
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.35rem', fontSize: '0.85rem' }}>
                      <span style={{ color: 'var(--cream)', fontWeight: 500 }}>{t.topic}</span>
                      <span style={{ color: t.pct >= 70 ? '#34D399' : t.pct >= 50 ? '#F5C842' : 'var(--coral)', fontWeight: 700 }}>
                        {t.correct}/{t.total} · {t.pct}%
                      </span>
                    </div>
                    <div style={{ height: 7, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
                      <motion.div
                        initial={{ width: 0 }}
                        animate={{ width: `${t.pct}%` }}
                        transition={{ duration: 0.8, ease: 'easeOut', delay: 0.45 + i * 0.05 }}
                        style={{
                          height: '100%', borderRadius: 999,
                          background: t.pct >= 70 ? '#34D399' : t.pct >= 50 ? '#F5C842' : 'var(--coral)',
                        }}
                      />
                    </div>
                  </motion.div>
                ))}
              </div>

              {/* Strengths + Weaknesses */}
              {(report.strengths.length > 0 || report.weaknesses.length > 0) && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1.5rem' }} className="sw-grid">
                  {report.strengths.length > 0 && (
                    <div style={{ background: 'rgba(34,197,94,0.06)', border: '1px solid rgba(34,197,94,0.2)', borderRadius: 12, padding: '1rem' }}>
                      <div style={{ fontSize: '0.72rem', fontWeight: 700, color: '#34D399', textTransform: 'uppercase', letterSpacing: '0.1em', marginBottom: '0.6rem' }}>💪 Strengths</div>
                      {report.strengths.map(s => (
                        <div key={s.topic} style={{ fontSize: '0.82rem', color: 'var(--cream)', marginBottom: '0.3rem' }}>✓ {s.topic}</div>
                      ))}
                    </div>
                  )}
                  {report.weaknesses.length > 0 && (
                    <div style={{ background: 'rgba(255,107,81,0.06)', border: '1px solid rgba(255,107,81,0.2)', borderRadius: 12, padding: '1rem' }}>
                      <div style={{ fontSize: '0.72rem', fontWeight: 700, color: 'var(--coral)', textTransform: 'uppercase', letterSpacing: '0.1em', marginBottom: '0.6rem' }}>🎯 To improve</div>
                      {report.weaknesses.map(w => (
                        <div key={w.topic} style={{ fontSize: '0.82rem', color: 'var(--cream)', marginBottom: '0.3rem' }}>→ {w.topic}</div>
                      ))}
                    </div>
                  )}
                </div>
              )}
            </motion.div>
          )}

          {/* Recommended path */}
          {report.recommendedPath && (
            <motion.div
              initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.5 }}
              style={{ marginBottom: '1.5rem' }}
            >
              <h2 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                🚀 Recommended Career Path
              </h2>
              <Link href={`/paths/${report.recommendedPath.slug}`} style={{ textDecoration: 'none' }}>
                <motion.div
                  whileHover={{ y: -3, boxShadow: `0 12px 40px ${CATEGORY_COLORS[report.recommendedPath.category] ?? '#6366F1'}30` }}
                  style={{
                    background: 'var(--dim)', border: `2px solid ${CATEGORY_COLORS[report.recommendedPath.category] ?? '#6366F1'}40`,
                    borderRadius: 18, padding: '1.25rem 1.5rem',
                    display: 'flex', alignItems: 'center', gap: '1rem',
                    transition: 'box-shadow 0.2s',
                  }}
                >
                  <div style={{
                    width: 48, height: 48, borderRadius: 12, flexShrink: 0,
                    background: `${CATEGORY_COLORS[report.recommendedPath.category] ?? '#6366F1'}25`,
                    display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem',
                  }}>🗺️</div>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: '0.7rem', fontWeight: 700, color: CATEGORY_COLORS[report.recommendedPath.category] ?? '#6366F1', textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '0.2rem' }}>
                      {report.recommendedPath.category} · Career Path
                    </div>
                    <div style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.3rem' }}>{report.recommendedPath.name}</div>
                    <div style={{ fontSize: '0.82rem', color: 'var(--muted)', lineHeight: 1.5 }}>{report.recommendedPath.description?.slice(0, 100)}…</div>
                  </div>
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--muted)" strokeWidth="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </motion.div>
              </Link>
            </motion.div>
          )}

          {/* Recommended courses */}
          {report.recommendedCourses && report.recommendedCourses.length > 0 && (
            <motion.div
              initial={{ opacity: 0, y: 15 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.55 }}
              style={{ marginBottom: '2.5rem' }}
            >
              <h2 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                📚 Courses We Recommend
              </h2>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '0.875rem' }}>
                {report.recommendedCourses.map((c, i) => (
                  <motion.div
                    key={c.id}
                    initial={{ opacity: 0, scale: 0.92 }} animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: 0.6 + i * 0.06, type: 'spring', stiffness: 200 }}
                    whileHover={{ y: -3 }}
                  >
                    <Link href={`/courses/${c.slug}`} style={{ textDecoration: 'none' }}>
                      <div style={{ background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 14, padding: '1rem', height: '100%' }}>
                        <div style={{ fontSize: '0.68rem', fontWeight: 700, color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: '0.4rem' }}>
                          {c.level ?? 'Beginner'}
                        </div>
                        <div style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--cream)', lineHeight: 1.4, marginBottom: '0.5rem' }}>{c.title}</div>
                        {c.description && (
                          <div style={{ fontSize: '0.78rem', color: 'var(--muted)', lineHeight: 1.5 }}>{c.description.slice(0, 80)}…</div>
                        )}
                        <div style={{ marginTop: '0.75rem', fontSize: '0.78rem', color: 'var(--accent)', fontWeight: 600 }}>Enroll →</div>
                      </div>
                    </Link>
                  </motion.div>
                ))}
              </div>
            </motion.div>
          )}

          {/* Actions */}
          <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap' }}>
            <button onClick={() => router.push('/assessments')} className="btn-primary" style={{ padding: '0.75rem 1.75rem' }}>
              More assessments →
            </button>
            <button
              onClick={() => { setQIdx(0); setAnswers([]); setTimeLeft(QUESTION_TIME); startTimeRef.current = Date.now(); setState('playing') }}
              className="btn-outline"
            >
              Retake
            </button>
            {isLoggedIn && (
              <Link href="/profile" className="btn-outline" style={{ textDecoration: 'none' }}>
                View profile
              </Link>
            )}
          </div>
        </div>

        <style>{`
          @media (max-width: 600px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr) !important; }
            .sw-grid { grid-template-columns: 1fr !important; }
          }
        `}</style>
      </div>
    )
  }

  // ─── QUIZ PLAYING ───
  return (
    <div style={{ minHeight: '100vh', background: 'var(--ink)', display: 'flex', flexDirection: 'column' }}>
      {/* Top bar */}
      <div style={{ padding: '0.875rem 1.5rem', display: 'flex', alignItems: 'center', gap: '1rem', borderBottom: '1px solid var(--line)', background: 'var(--dim)', flexShrink: 0 }}>
        <button onClick={() => router.push(`/assessments/${assessmentSlug}`)}
          style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--muted)', padding: '0.25rem', display: 'flex', flexShrink: 0 }}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M18 6L6 18M6 6l12 12"/></svg>
        </button>
        {/* Progress bar */}
        <div style={{ flex: 1, height: 8, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
          <motion.div
            animate={{ width: `${progressPct}%` }}
            transition={{ duration: 0.4, ease: 'easeOut' }}
            style={{ height: '100%', background: 'var(--accent)', borderRadius: 999 }}
          />
        </div>
        <span style={{ fontSize: '0.78rem', color: 'var(--muted)', flexShrink: 0 }}>
          {qIdx + 1}/{questions.length}
        </span>
      </div>

      {/* Question area */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '2rem 1.5rem', paddingBottom: showFeedback ? '14rem' : '2rem' }}>
        <div style={{ width: '100%', maxWidth: 580 }}>

          {/* Timer */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.5rem' }}>
            <div style={{ flex: 1, height: 6, background: 'var(--line)', borderRadius: 999, overflow: 'hidden' }}>
              <motion.div
                animate={{ width: `${timerPct}%` }}
                transition={{ duration: 0.5 }}
                style={{ height: '100%', background: timerColor, borderRadius: 999, transition: 'background 0.3s' }}
              />
            </div>
            <motion.div
              key={timeLeft}
              animate={timeLeft <= 5 ? { scale: [1, 1.3, 1] } : {}}
              transition={{ duration: 0.3 }}
              style={{ fontSize: '0.88rem', fontWeight: 700, color: timerColor, minWidth: 28, textAlign: 'right', fontVariantNumeric: 'tabular-nums' }}
            >
              {timeLeft}s
            </motion.div>
          </div>

          <div style={{ color: 'var(--muted)', fontSize: '0.72rem', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.08em', marginBottom: '1.25rem' }}>
            {current?.topic && <span style={{ color: 'var(--accent)', marginRight: '0.5rem' }}>{current.topic} ·</span>}
            Question {qIdx + 1} of {questions.length}
          </div>

          {/* Floating XP */}
          <AnimatePresence>
            {floatingXP && (
              <motion.div key="xp" initial={{ opacity: 1, y: 0 }} animate={{ opacity: 0, y: -70 }} transition={{ duration: 1 }}
                style={{ position: 'fixed', top: '40%', left: '50%', transform: 'translate(-50%,-50%)', zIndex: 9999, pointerEvents: 'none', fontWeight: 700, fontSize: '2rem', color: 'var(--accent)' }}>
                +{XP_PER_CORRECT} XP
              </motion.div>
            )}
          </AnimatePresence>

          <AnimatePresence mode="wait">
            <motion.div
              key={qIdx}
              initial={{ opacity: 0, x: 40 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: -40 }}
              transition={{ duration: 0.2 }}
            >
              <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.25rem, 3.5vw, 1.75rem)', color: 'var(--cream)', marginBottom: '2rem', lineHeight: 1.45 }}>
                {current?.question}
              </h2>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.875rem' }}>
                {optionKeys.map(key => (
                  <motion.button key={key} style={getOptionStyle(key)} onClick={() => handleSelect(key)}
                    disabled={showFeedback} whileHover={!showFeedback ? { scale: 1.01 } : {}} whileTap={!showFeedback ? { scale: 0.99 } : {}}>
                    <span style={{
                      display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                      width: 30, height: 30, borderRadius: 7, flexShrink: 0,
                      background: showFeedback && key === current.correct_option ? 'rgba(34,197,94,0.2)'
                        : showFeedback && key === selected && key !== current.correct_option ? 'rgba(255,107,81,0.2)'
                        : 'rgba(255,255,255,0.06)',
                      fontSize: '0.82rem', fontWeight: 700, textTransform: 'uppercase',
                    }}>
                      {showFeedback && key === current.correct_option ? '✓'
                        : showFeedback && key === selected && key !== current.correct_option ? '✗'
                        : key}
                    </span>
                    {({ a: current?.option_a, b: current?.option_b, c: current?.option_c, d: current?.option_d } as any)[key]}
                  </motion.button>
                ))}
              </div>
            </motion.div>
          </AnimatePresence>
        </div>
      </div>

      {/* Bottom feedback */}
      <AnimatePresence>
        {showFeedback && (
          <motion.div
            initial={{ y: '100%' }} animate={{ y: 0 }} exit={{ y: '100%' }}
            transition={{ type: 'spring', stiffness: 400, damping: 35 }}
            style={{
              position: 'fixed', bottom: 0, left: 0, right: 0,
              background: isCorrect ? 'rgba(34,197,94,0.12)' : 'rgba(255,107,81,0.1)',
              borderTop: `2px solid ${isCorrect ? '#22C55E' : 'var(--coral)'}`,
              padding: '1.25rem 1.5rem', zIndex: 500,
            }}
          >
            <div style={{ maxWidth: 580, margin: '0 auto', display: 'flex', alignItems: 'flex-start', gap: '1rem' }}>
              <div style={{ flex: 1 }}>
                <div style={{ fontWeight: 700, fontSize: '1rem', color: isCorrect ? '#22C55E' : 'var(--coral)', marginBottom: '0.35rem', display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
                  {isCorrect
                    ? <><span>✓</span> Correct! <span style={{ fontSize: '0.85rem', color: 'var(--accent)' }}>+{XP_PER_CORRECT} XP</span></>
                    : selected === null
                      ? <><span>⏰</span> Time&apos;s up!</>
                      : <><span>✗</span> Incorrect</>}
                </div>
                {!isCorrect && (
                  <div style={{ color: 'var(--muted)', fontSize: '0.85rem', marginBottom: '0.3rem' }}>
                    Answer: <strong style={{ color: 'var(--cream)' }}>
                      ({current.correct_option.toUpperCase()}) {({ a: current?.option_a, b: current?.option_b, c: current?.option_c, d: current?.option_d } as any)[current.correct_option]}
                    </strong>
                  </div>
                )}
                {current.explanation && (
                  <div style={{ color: 'var(--muted)', fontSize: '0.82rem', lineHeight: 1.55 }}>{current.explanation}</div>
                )}
              </div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  )
}
