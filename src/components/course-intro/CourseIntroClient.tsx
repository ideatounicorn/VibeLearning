'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { useRouter } from 'next/navigation'

interface GlossaryTerm {
  term: string
  definition: string
  example: string
  emoji?: string
  imageKeyword?: string
}

interface QuizQuestion {
  question: string
  options: string[]
  correctIndex: number
  term: string
}

interface IntroData {
  titleCard: { headline: string; subheadline: string; emoji: string; imageKeyword?: string }
  courseOverview?: {
    welcome: string
    modules: Array<{ title: string; description: string; emoji: string }>
  }
  glossary: GlossaryTerm[]
  glossaryQuiz: QuizQuestion[]
  courseMap: { overview: string; steps: string[] }
}

interface Props {
  courseId: string
  courseTitle: string
  startHref: string
}

type Phase = 'loading' | 'title' | 'overview' | 'glossary' | 'quiz' | 'map' | 'ready'

// Pre-curated Unsplash images for common tech keywords to guarantee premium visual styling
const KEYWORD_IMAGES: Record<string, string> = {
  terminal: 'https://images.unsplash.com/photo-1629654297299-c8506221ca97?auto=format&fit=crop&w=800&q=80',
  github: 'https://images.unsplash.com/photo-1618401471353-b98aedd07871?auto=format&fit=crop&w=800&q=80',
  git: 'https://images.unsplash.com/photo-1618401471353-b98aedd07871?auto=format&fit=crop&w=800&q=80',
  database: 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?auto=format&fit=crop&w=800&q=80',
  sql: 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?auto=format&fit=crop&w=800&q=80',
  cloud: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
  aws: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
  api: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&w=800&q=80',
  code: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
  server: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=800&q=80',
  design: 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?auto=format&fit=crop&w=800&q=80',
  ui: 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?auto=format&fit=crop&w=800&q=80',
  ux: 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?auto=format&fit=crop&w=800&q=80',
  marketing: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=800&q=80',
  ads: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=800&q=80',
  analytics: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
  product: 'https://images.unsplash.com/photo-1531403009284-440f080d1e12?auto=format&fit=crop&w=800&q=80',
  figma: 'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?auto=format&fit=crop&w=800&q=80',
}

function getConceptImage(keyword?: string): string {
  if (!keyword) return 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=800&q=80'
  return KEYWORD_IMAGES[keyword.toLowerCase()] ?? 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=800&q=80'
}

export default function CourseIntroClient({ courseId, courseTitle, startHref }: Props) {
  const router = useRouter()
  const [phase, setPhase] = useState<Phase>('loading')
  const [data, setData] = useState<IntroData | null>(null)
  const [glossaryIdx, setGlossaryIdx] = useState(0)
  const [quizIdx, setQuizIdx] = useState(0)
  const [selected, setSelected] = useState<number | null>(null)
  const [showAnswer, setShowAnswer] = useState(false)
  const [quizScore, setQuizScore] = useState(0)

  useEffect(() => {
    // Check if orientation was already completed
    const completed = localStorage.getItem(`orientation_completed_${courseId}`)
    if (completed === 'true') {
      router.replace(startHref)
      return
    }

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
  }, [courseId, router, startHref])

  useEffect(() => {
    if (phase === 'ready') {
      localStorage.setItem(`orientation_completed_${courseId}`, 'true')
      const timer = setTimeout(() => {
        router.push(startHref)
      }, 1500)
      return () => clearTimeout(timer)
    }
  }, [phase, router, startHref, courseId])

  const goNext = () => {
    if (phase === 'title') {
      if (data?.courseOverview) {
        setPhase('overview')
      } else {
        setPhase('glossary')
        setGlossaryIdx(0)
      }
    } else if (phase === 'overview') {
      setPhase('glossary')
      setGlossaryIdx(0)
    } else if (phase === 'glossary') {
      if (!data || glossaryIdx < data.glossary.length - 1) {
        setGlossaryIdx(i => i + 1)
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
    loading: 0,
    title: 10,
    overview: 25,
    glossary: 55,
    quiz: 75,
    map: 90,
    ready: 100,
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
      background: 'var(--bg)',
      display: 'flex', flexDirection: 'column',
      color: 'var(--text-primary)',
    }}>
      {/* Top Bar */}
      <div style={{
        padding: '1rem 1.5rem',
        display: 'flex', alignItems: 'center', gap: '1.25rem',
        borderBottom: '1px solid var(--border)',
        background: 'var(--surface)',
        backdropFilter: 'blur(10px)',
        flexShrink: 0,
      }}>
        <button
          onClick={() => router.back()}
          style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--text-muted)', padding: '0.25rem', display: 'flex', flexShrink: 0 }}
          title="Exit intro"
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M18 6L6 18M6 6l12 12"/></svg>
        </button>
        <div style={{ flex: 1, height: 6, background: 'var(--border)', borderRadius: 999, overflow: 'hidden' }}>
          <motion.div
            animate={{ width: `${progressPct}%` }}
            transition={{ duration: 0.5, ease: 'easeOut' }}
            style={{ height: '100%', background: 'var(--accent)', borderRadius: 999 }}
          />
        </div>
        <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', flexShrink: 0 }}>
          {phase === 'loading' ? 'Preparing…' : `${courseTitle}`}
        </div>
        {phase !== 'loading' && phase !== 'ready' && (
          <button
            onClick={() => {
              localStorage.setItem(`orientation_completed_${courseId}`, 'true')
              router.push(startHref)
            }}
            style={{
              background: 'none',
              border: 'none',
              cursor: 'pointer',
              color: 'var(--text-muted)',
              fontSize: '0.82rem',
              fontWeight: 600,
              padding: '0.25rem 0.5rem',
              borderRadius: '6px',
              transition: 'color 0.15s',
            }}
            onMouseEnter={e => e.currentTarget.style.color = 'var(--text-primary)'}
            onMouseLeave={e => e.currentTarget.style.color = 'var(--text-muted)'}
          >
            Skip Intro
          </button>
        )}
      </div>

      {/* Main Page Area */}
      <div style={{ flex: 1, overflowY: 'auto', display: 'flex', flexDirection: 'column' }}>
        <div style={{
          width: '100%',
          maxWidth: '1200px',
          margin: 'auto',
          padding: '2.5rem 1.5rem',
          flex: 1,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}>
          <AnimatePresence mode="wait">

            {/* PHASE: LOADING */}
            {phase === 'loading' && (
              <motion.div
                key="loading"
                initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
                style={{ textAlign: 'center' }}
              >
                <motion.div
                  animate={{ rotate: 360 }}
                  transition={{ duration: 1.5, repeat: Infinity, ease: 'linear' }}
                  style={{ width: 48, height: 48, borderRadius: '50%', border: '3px solid var(--border)', borderTopColor: 'var(--accent)', margin: '0 auto 1.5rem' }}
                />
                <p style={{ color: 'var(--text-muted)', fontSize: '1rem' }}>Personalizing your orientation experience…</p>
              </motion.div>
            )}

            {/* PHASE: TITLE CARD */}
            {phase === 'title' && data && (
              <motion.div
                key="title"
                initial={{ opacity: 0, scale: 0.95, y: 15 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.95, y: -15 }}
                transition={{ duration: 0.4 }}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  textAlign: 'center',
                  width: '100%',
                  maxWidth: '640px',
                  margin: '0 auto',
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: '24px',
                  padding: '2.5rem 2rem',
                  boxShadow: '0 20px 40px rgba(0,0,0,0.02)',
                }}
              >
                {/* Large Centered Animated Emoji */}
                <motion.div
                  animate={{ y: [0, -10, 0] }}
                  transition={{ duration: 2.5, repeat: Infinity, ease: 'easeInOut' }}
                  style={{
                    fontSize: '4.5rem',
                    marginBottom: '1.5rem',
                    display: 'inline-flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    width: '100px',
                    height: '100px',
                    borderRadius: '50%',
                    background: 'var(--border)',
                  }}
                >
                  {data.titleCard.emoji}
                </motion.div>

                <div style={{ fontSize: '0.75rem', fontWeight: 700, letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--accent)', marginBottom: '0.75rem' }}>
                  Welcome to Course
                </div>
                <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.8rem, 3.5vw, 2.5rem)', color: 'var(--text-primary)', lineHeight: 1.2, marginBottom: '1rem', fontWeight: 800 }}>
                  {data.titleCard.headline}
                </h1>
                <p style={{ fontSize: '1rem', color: 'var(--text-muted)', lineHeight: 1.6, marginBottom: '2rem', maxWidth: '520px' }}>
                  {data.titleCard.subheadline}
                </p>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.8rem', width: '100%', maxWidth: '440px', marginBottom: '2.5rem', textAlign: 'left' }}>
                  {[
                    '📖 Core Syllabus & Overview',
                    '🧠 Glossary of Key Terms (without distractions)',
                    '⚡ Quick Vocabulary Comprehension Check',
                  ].map((bullet, i) => (
                    <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', fontSize: '0.9rem', color: 'var(--text-muted)' }}>
                      <span style={{ color: 'var(--accent)', fontWeight: 'bold' }}>✓</span> {bullet}
                    </div>
                  ))}
                </div>

                <button
                  onClick={goNext}
                  className="btn-primary"
                  style={{ padding: '0.9rem 2.75rem', fontSize: '1rem', borderRadius: '14px', width: '100%' }}
                >
                  Start Orientation →
                </button>
              </motion.div>
            )}

            {/* PHASE: COURSE OVERVIEW (Syllabus) */}
            {phase === 'overview' && data?.courseOverview && (
              <motion.div
                key="overview"
                initial={{ opacity: 0, scale: 0.95, y: 15 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.95, y: -15 }}
                transition={{ duration: 0.4 }}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  textAlign: 'center',
                  width: '100%',
                  maxWidth: '640px',
                  margin: '0 auto',
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: '24px',
                  padding: '2.5rem 2rem',
                  boxShadow: '0 20px 40px rgba(0,0,0,0.02)',
                }}
              >
                <div style={{
                  fontSize: '3rem',
                  marginBottom: '1rem',
                  display: 'inline-flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  width: '80px',
                  height: '80px',
                  borderRadius: '50%',
                  background: 'var(--border)',
                }}>
                  🎯
                </div>

                <div style={{ fontSize: '0.75rem', fontWeight: 700, letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--accent)', marginBottom: '0.5rem' }}>
                  Course Syllabus
                </div>
                <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.5rem, 3vw, 2rem)', color: 'var(--text-primary)', fontWeight: 800, marginBottom: '0.75rem', lineHeight: 1.2 }}>
                  Curriculum Breakdown
                </h2>
                <p style={{ fontSize: '0.9rem', color: 'var(--text-muted)', lineHeight: 1.5, marginBottom: '1.25rem', maxWidth: '540px' }}>
                  {data.courseOverview.welcome}
                </p>

                {/* Badge Grid of Course Metadata ("a few more things about the course") */}
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(2, 1fr)',
                  gap: '0.75rem',
                  width: '100%',
                  marginBottom: '1.5rem',
                }}>
                  <div style={{ padding: '0.75rem', background: 'var(--bg)', border: '1px solid var(--border)', borderRadius: '12px', fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '0.5rem', justifyContent: 'center' }}>
                    <span>📚</span>
                    <span style={{ fontWeight: 600, color: 'var(--text-primary)' }}>10 Core Modules</span>
                  </div>
                  <div style={{ padding: '0.75rem', background: 'var(--bg)', border: '1px solid var(--border)', borderRadius: '12px', fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '0.5rem', justifyContent: 'center' }}>
                    <span>🎥</span>
                    <span style={{ fontWeight: 600, color: 'var(--text-primary)' }}>20 Expert Videos</span>
                  </div>
                  <div style={{ padding: '0.75rem', background: 'var(--bg)', border: '1px solid var(--border)', borderRadius: '12px', fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '0.5rem', justifyContent: 'center' }}>
                    <span>👥</span>
                    <span style={{ fontWeight: 600, color: 'var(--text-primary)' }}>YouTube Guest Creators</span>
                  </div>
                  <div style={{ padding: '0.75rem', background: 'var(--bg)', border: '1px solid var(--border)', borderRadius: '12px', fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '0.5rem', justifyContent: 'center' }}>
                    <span>🏆</span>
                    <span style={{ fontWeight: 600, color: 'var(--text-primary)' }}>Official Certificate</span>
                  </div>
                </div>

                {/* Scrollable list of modules */}
                <div style={{
                  display: 'flex',
                  flexDirection: 'column',
                  gap: '0.75rem',
                  width: '100%',
                  maxHeight: '240px',
                  overflowY: 'auto',
                  paddingRight: '0.25rem',
                  marginBottom: '2rem',
                  textAlign: 'left',
                  scrollbarWidth: 'thin',
                }}>
                  {data.courseOverview.modules.map((mod, i) => (
                    <div
                      key={i}
                      style={{
                        display: 'flex',
                        alignItems: 'flex-start',
                        gap: '0.75rem',
                        padding: '0.85rem 1rem',
                        background: 'var(--bg)',
                        border: '1px solid var(--border)',
                        borderRadius: '12px',
                      }}
                    >
                      <span style={{ fontSize: '1.25rem', flexShrink: 0 }}>{mod.emoji}</span>
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.1rem' }}>
                        <span style={{ fontWeight: 600, fontSize: '0.88rem', color: 'var(--text-primary)' }}>
                          {i + 1}. {mod.title}
                        </span>
                        <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)', lineHeight: 1.4 }}>
                          {mod.description}
                        </span>
                      </div>
                    </div>
                  ))}
                </div>

                <button
                  onClick={goNext}
                  className="btn-primary"
                  style={{ padding: '0.9rem 2.75rem', fontSize: '1rem', borderRadius: '14px', width: '100%' }}
                >
                  Continue to Glossary →
                </button>
              </motion.div>
            )}

            {/* PHASE: GLOSSARY SLIDES (Visual Concept Slides) */}
            {phase === 'glossary' && data && (
              <motion.div
                key={`glossary-${glossaryIdx}`}
                initial={{ opacity: 0, x: 50 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -50 }}
                transition={{ duration: 0.35 }}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  textAlign: 'center',
                  width: '100%',
                  maxWidth: '640px',
                  margin: '0 auto',
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: '24px',
                  padding: '2.5rem 2rem',
                  boxShadow: '0 20px 40px rgba(0,0,0,0.02)',
                }}
              >
                {/* Large Centered Icon */}
                <div style={{
                  fontSize: '4.5rem',
                  marginBottom: '1.5rem',
                  display: 'inline-flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  width: '100px',
                  height: '100px',
                  borderRadius: '50%',
                  background: 'var(--border)',
                }}>
                  {data.glossary[glossaryIdx].emoji ?? '📖'}
                </div>

                <div style={{ fontSize: '0.75rem', fontWeight: 700, letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--accent)', marginBottom: '0.75rem' }}>
                  Concept {glossaryIdx + 1} of {data.glossary.length}
                </div>
                <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.6rem, 3.5vw, 2.2rem)', color: 'var(--text-primary)', fontWeight: 800, marginBottom: '1.25rem', lineHeight: 1.2 }}>
                  What is {data.glossary[glossaryIdx].term}?
                </h2>

                <p style={{ fontSize: '1.05rem', color: 'var(--text-primary)', lineHeight: 1.6, marginBottom: '2rem', textAlign: 'center' }}>
                  {data.glossary[glossaryIdx].definition}
                </p>

                {/* Real world example card */}
                <div style={{
                  width: '100%',
                  background: 'var(--bg)',
                  border: '1px solid var(--border)',
                  borderLeft: '4px solid var(--accent)',
                  padding: '1.25rem 1.5rem',
                  borderRadius: '0 16px 16px 0',
                  marginBottom: '2.5rem',
                  textAlign: 'left',
                }}>
                  <div style={{ fontSize: '0.75rem', fontWeight: 700, textTransform: 'uppercase', color: 'var(--accent)', marginBottom: '0.4rem', letterSpacing: '0.05em' }}>
                    💡 Practical Example
                  </div>
                  <p style={{ fontSize: '0.9rem', color: 'var(--text-muted)', lineHeight: 1.5, fontStyle: 'italic' }}>
                    {data.glossary[glossaryIdx].example}
                  </p>
                </div>

                <button
                  onClick={goNext}
                  className="btn-primary"
                  style={{ padding: '0.85rem 2.5rem', fontSize: '0.95rem', borderRadius: '12px', width: '100%' }}
                >
                  {glossaryIdx < data.glossary.length - 1 ? 'Next Concept →' : 'Comprehension Check →'}
                </button>
              </motion.div>
            )}

            {/* PHASE: GLOSSARY QUIZ */}
            {phase === 'quiz' && data && (
              <motion.div
                key={`quiz-${quizIdx}`}
                initial={{ opacity: 0, scale: 0.96 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.96 }}
                transition={{ duration: 0.3 }}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  width: '100%',
                  maxWidth: '640px',
                  margin: '0 auto',
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: '24px',
                  padding: '2.5rem 2rem',
                  boxShadow: '0 20px 40px rgba(0,0,0,0.02)',
                }}
              >
                <div style={{ fontSize: '0.75rem', fontWeight: 700, color: 'var(--accent)', letterSpacing: '0.15em', textTransform: 'uppercase', marginBottom: '1rem', textAlign: 'center' }}>
                  Comprehension Check · {quizIdx + 1} of {data.glossaryQuiz.length}
                </div>

                <h2 style={{
                  fontFamily: 'var(--font-serif)',
                  fontSize: 'clamp(1.3rem, 3vw, 1.8rem)',
                  color: 'var(--text-primary)',
                  marginBottom: '2rem',
                  lineHeight: 1.35,
                  textAlign: 'center',
                  fontWeight: 700,
                  maxWidth: '560px',
                }}>
                  {data.glossaryQuiz[quizIdx].question}
                </h2>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.8rem', width: '100%', marginBottom: '1.5rem' }}>
                  {data.glossaryQuiz[quizIdx].options.map((opt, i) => {
                    const isCorrect = i === data.glossaryQuiz[quizIdx].correctIndex
                    const isSelected = i === selected
                    let bg = 'var(--bg)'
                    let border = 'var(--border)'
                    let color = 'var(--text-primary)'
                    if (showAnswer) {
                      if (isCorrect) { bg = 'rgba(34,197,94,0.12)'; border = '#22C55E'; color = '#22C55E' }
                      else if (isSelected && !isCorrect) { bg = 'rgba(239,68,68,0.1)'; border = 'var(--danger)'; color = 'var(--danger)' }
                      else { color = 'var(--text-muted)' }
                    } else if (isSelected) {
                      bg = 'var(--border)'
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
                          width: '100%', textAlign: 'left', padding: '1rem 1.25rem',
                          borderRadius: '12px', border: `1.5px solid ${border}`,
                          background: bg, color, fontSize: '0.95rem', cursor: showAnswer ? 'default' : 'pointer',
                          fontWeight: 500, transition: 'all 0.15s',
                          display: 'flex', alignItems: 'center', gap: '0.75rem',
                        }}
                      >
                        <span style={{
                          width: 28, height: 28, borderRadius: 6, background: 'rgba(255,255,255,0.05)',
                          display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                          fontSize: '0.78rem', fontWeight: 700, flexShrink: 0, textTransform: 'uppercase',
                        }}>
                          {showAnswer && isCorrect ? '✓' : showAnswer && isSelected && !isCorrect ? '✗' : String.fromCharCode(65 + i)}
                        </span>
                        <span style={{ lineHeight: 1.4 }}>{opt}</span>
                      </motion.button>
                    )
                  })}
                </div>

                <AnimatePresence>
                  {showAnswer && (
                    <motion.div
                      initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0 }}
                      style={{ marginBottom: '2rem', textAlign: 'center' }}
                    >
                      <div style={{ fontSize: '1.5rem', marginBottom: '0.4rem', color: selected === data.glossaryQuiz[quizIdx].correctIndex ? 'var(--success)' : 'var(--danger)' }}>
                        {selected === data.glossaryQuiz[quizIdx].correctIndex ? '🎉 Correct!' : '💡 Keep Learning'}
                      </div>
                      <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', maxWidth: '400px', margin: '0 auto', lineHeight: 1.45 }}>
                        {selected === data.glossaryQuiz[quizIdx].correctIndex
                          ? `Great job! You clearly understand what "${data.glossaryQuiz[quizIdx].term}" represents.`
                          : `Not quite. "${data.glossaryQuiz[quizIdx].term}" is: ${data.glossaryQuiz[quizIdx].options[data.glossaryQuiz[quizIdx].correctIndex]}`}
                      </p>
                    </motion.div>
                  )}
                </AnimatePresence>

                {showAnswer && (
                  <motion.button
                    initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }}
                    onClick={goNext}
                    className="btn-primary"
                    style={{ padding: '0.8rem 2.5rem', fontSize: '0.95rem', borderRadius: '12px', width: '100%' }}
                  >
                    {quizIdx < data.glossaryQuiz.length - 1 ? 'Next question →' : 'See Your Journey →'}
                  </motion.button>
                )}
              </motion.div>
            )}

            {/* PHASE: COURSE MAP (journey roadmap) */}
            {phase === 'map' && data && (
              <motion.div
                key="map"
                initial={{ opacity: 0, scale: 0.95, y: 15 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.95, y: -15 }}
                transition={{ duration: 0.35 }}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  textAlign: 'center',
                  width: '100%',
                  maxWidth: '560px',
                  margin: '0 auto',
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: '24px',
                  padding: '2.5rem 2rem',
                  boxShadow: '0 20px 40px rgba(0,0,0,0.02)',
                }}
              >
                {data.glossaryQuiz.length > 0 && (
                  <motion.div
                    initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}
                    style={{ marginBottom: '1.5rem' }}
                  >
                    <div className="pill" style={{ fontSize: '0.85rem', padding: '0.4rem 1rem', display: 'inline-block', background: 'var(--bg)', border: '1px solid var(--border)', color: 'var(--accent)', borderRadius: '999px', fontWeight: 600 }}>
                      Comprehension Score: {quizScore}/{data.glossaryQuiz.length} Passed
                    </div>
                  </motion.div>
                )}

                <div style={{
                  fontSize: '3rem',
                  marginBottom: '1rem',
                  display: 'inline-flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  width: '80px',
                  height: '80px',
                  borderRadius: '50%',
                  background: 'var(--border)',
                }}>
                  🗺️
                </div>

                <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: '2rem', color: 'var(--text-primary)', marginBottom: '0.75rem', fontWeight: 700 }}>
                  Your Learning Roadmap
                </h2>

                <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.6, marginBottom: '2.5rem' }}>
                  {data.courseMap.overview}
                </p>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.8rem', marginBottom: '2.5rem', textAlign: 'left', width: '100%' }}>
                  {data.courseMap.steps.map((step, i) => (
                    <motion.div
                      key={i}
                      initial={{ opacity: 0, x: -15 }} animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: i * 0.08 }}
                      style={{
                        display: 'flex', alignItems: 'center', gap: '1rem',
                        padding: '0.9rem 1.25rem',
                        background: 'var(--bg)', border: '1px solid var(--border)', borderRadius: '14px',
                      }}
                    >
                      <div style={{
                        width: 28, height: 28, borderRadius: '50%', flexShrink: 0,
                        background: 'var(--accent)', color: 'var(--bg)',
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                        fontSize: '0.78rem', fontWeight: 700,
                      }}>
                        {i + 1}
                      </div>
                      <span style={{ color: 'var(--text-primary)', fontSize: '0.9rem', fontWeight: 500 }}>{step}</span>
                      {i === data.courseMap.steps.length - 1 && (
                        <span style={{ marginLeft: 'auto', fontSize: '1rem' }}>🏆</span>
                      )}
                    </motion.div>
                  ))}
                </div>

                <button
                  onClick={goNext}
                  className="btn-primary"
                  style={{ padding: '0.9rem 2.75rem', fontSize: '1rem', borderRadius: '14px', width: '100%' }}
                >
                  Start First Video Lesson →
                </button>
              </motion.div>
            )}

            {/* PHASE: READY */}
            {phase === 'ready' && (
              <motion.div
                key="ready"
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ type: 'spring', stiffness: 200, damping: 18 }}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  textAlign: 'center',
                  width: '100%',
                  maxWidth: '560px',
                  margin: '0 auto',
                  background: 'var(--surface)',
                  border: '1px solid var(--border)',
                  borderRadius: '24px',
                  padding: '2.5rem 2rem',
                  boxShadow: '0 20px 40px rgba(0,0,0,0.02)',
                }}
              >
                <motion.div
                  animate={{ scale: [1, 1.15, 1], rotate: [0, 8, -8, 0] }}
                  transition={{ duration: 0.7, delay: 0.1 }}
                  style={{ fontSize: '5rem', marginBottom: '1rem' }}
                >
                  🚀
                </motion.div>
                <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: '2.25rem', color: 'var(--text-primary)', marginBottom: '0.5rem', fontWeight: 700 }}>
                  You&apos;re Ready!
                </h2>
                <p style={{ color: 'var(--text-muted)', marginBottom: '2rem' }}>Diving into your first course video…</p>
                <motion.div
                  animate={{ rotate: 360 }}
                  transition={{ duration: 1, repeat: Infinity, ease: 'linear' }}
                  style={{ width: 32, height: 32, borderRadius: '50%', border: '3px solid var(--border)', borderTopColor: 'var(--accent)', margin: '0 auto' }}
                />
              </motion.div>
            )}

          </AnimatePresence>
        </div>
      </div>
    </div>
  )
}
