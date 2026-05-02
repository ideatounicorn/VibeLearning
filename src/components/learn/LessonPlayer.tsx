'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { motion, AnimatePresence } from 'framer-motion'

interface Lesson {
  id: string
  title: string
  youtube_url: string
  youtube_video_id: string | null
  order_index: number
  why_this_video: string | null
  skills_gained: string[] | null
  duration_minutes: number | null
}

interface Module {
  id: string
  title: string
  slug: string
  course: {
    id: string
    title: string
    slug: string
    path: { id: string; name: string; slug: string } | null
  }
}

interface Props {
  module: Module
  lessons: Lesson[]
  completedLessonIds: string[]
  userId: string
  isPro: boolean
  courseModuleTotal: number
  courseModuleCompleted: number
}

function BrandedLoader({ title }: { title: string }) {
  const dots = [0, 1, 2, 3]
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      transition={{ duration: 0.3 }}
      style={{
        position: 'absolute', inset: 0, zIndex: 20,
        background: 'linear-gradient(135deg, #0d0d1a 0%, #111126 50%, #0a0a18 100%)',
        display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
        gap: '1.5rem',
      }}
    >
      {/* Animated logo */}
      <motion.div
        animate={{ scale: [1, 1.08, 1], opacity: [0.8, 1, 0.8] }}
        transition={{ duration: 2, repeat: Infinity, ease: 'easeInOut' }}
        style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '0.5rem' }}
      >
        <motion.img
          src="/logo.png"
          alt="VibeLearn"
          animate={{ rotate: [0, 360] }}
          transition={{ duration: 8, repeat: Infinity, ease: 'linear' }}
          style={{
            width: 40, height: 40, objectFit: 'contain',
            filter: 'drop-shadow(0 0 20px rgba(99,102,241,0.4))'
          }}
        />
        <span style={{ fontSize: '1.3rem', fontWeight: 700, color: '#fff', letterSpacing: '-0.02em' }}>VibeLearn</span>
      </motion.div>

      {/* Pulsing ring */}
      <div style={{ position: 'relative', width: 72, height: 72 }}>
        <motion.div
          animate={{ scale: [1, 1.4, 1], opacity: [0.5, 0, 0.5] }}
          transition={{ duration: 1.6, repeat: Infinity, ease: 'easeOut' }}
          style={{ position: 'absolute', inset: -8, borderRadius: '50%', border: '2px solid #6366F1' }}
        />
        <motion.div
          animate={{ rotate: 360 }}
          transition={{ duration: 1.5, repeat: Infinity, ease: 'linear' }}
          style={{ width: 72, height: 72, borderRadius: '50%', border: '3px solid rgba(99,102,241,0.2)', borderTopColor: '#6366F1' }}
        />
        <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.5rem' }}>
          🎬
        </div>
      </div>

      {/* Title */}
      <div style={{ textAlign: 'center', maxWidth: 300, padding: '0 1rem' }}>
        <motion.p
          initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}
          style={{ color: 'rgba(255,255,255,0.7)', fontSize: '0.85rem', marginBottom: '0.4rem' }}
        >
          Loading lesson
        </motion.p>
        <motion.p
          initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}
          style={{ color: '#fff', fontSize: '1rem', fontWeight: 600, lineHeight: 1.4 }}
        >
          {title}
        </motion.p>
      </div>

      {/* Dot loader */}
      <div style={{ display: 'flex', gap: '0.4rem' }}>
        {dots.map(i => (
          <motion.div
            key={i}
            animate={{ y: [0, -8, 0], opacity: [0.4, 1, 0.4] }}
            transition={{ duration: 0.8, delay: i * 0.15, repeat: Infinity, ease: 'easeInOut' }}
            style={{ width: 6, height: 6, borderRadius: '50%', background: '#6366F1' }}
          />
        ))}
      </div>
    </motion.div>
  )
}

export default function LessonPlayer({ module, lessons, completedLessonIds, userId, isPro, courseModuleTotal, courseModuleCompleted }: Props) {
  const router = useRouter()
  const [activeLessonIdx, setActiveLessonIdx] = useState(() => {
    const firstIncomplete = lessons.findIndex(l => !completedLessonIds.includes(l.id))
    return firstIncomplete >= 0 ? firstIncomplete : 0
  })
  const [completed, setCompleted] = useState<Set<string>>(new Set(completedLessonIds))
  const [xpFloat, setXpFloat] = useState(false)
  const [marking, setMarking] = useState(false)
  const [videoLoading, setVideoLoading] = useState(true)

  const activeLesson = lessons[activeLessonIdx]

  if (lessons.length === 0) {
    return (
      <div style={{ minHeight: '100vh', background: 'var(--bg)', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '2rem' }}>
        <div style={{ textAlign: 'center', maxWidth: 400 }}>
          <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>😴</div>
          <h2 style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.5rem' }}>Lessons coming soon</h2>
          <p style={{ color: 'var(--text-muted)', marginBottom: '2rem' }}>This module doesn&apos;t have any video lessons yet. Check back soon!</p>
          <button onClick={() => router.back()} className="btn-secondary">Go back</button>
        </div>
      </div>
    )
  }

  if (!activeLesson) {
    return <div style={{ color: 'var(--text-muted)', padding: '4rem', textAlign: 'center' }}>Lesson not found</div>
  }

  // Reset loading state when lesson changes
  useEffect(() => {
    setVideoLoading(true)
    const t = setTimeout(() => setVideoLoading(false), 3500) // fallback
    return () => clearTimeout(t)
  }, [activeLessonIdx])

  const markDone = async () => {
    if (!activeLesson || completed.has(activeLesson.id) || marking) return
    setMarking(true)
    try {
      const res = await fetch('/api/progress/lesson', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ lessonId: activeLesson.id }),
      })
      if (res.ok) {
        setCompleted(prev => new Set([...prev, activeLesson.id]))
        setXpFloat(true)
        setTimeout(() => setXpFloat(false), 1200)

        if (activeLessonIdx === lessons.length - 1) {
          setTimeout(() => router.push(`/quiz/${module.id}`), 1000)
        } else {
          setTimeout(() => setActiveLessonIdx(i => i + 1), 600)
        }
      }
    } finally {
      setMarking(false)
    }
  }

  const embedUrl = activeLesson?.youtube_video_id
    ? `https://www.youtube.com/embed/${activeLesson.youtube_video_id}?rel=0&modestbranding=1&autoplay=1`
    : null

  return (
    <div
      style={{ display: 'grid', gridTemplateColumns: '1fr 320px', minHeight: 'calc(100vh - 60px)', background: 'var(--ink)' }}
      className="lesson-layout"
    >
      <style>{`
        @media (max-width: 768px) {
          .lesson-layout { grid-template-columns: 1fr !important; }
          .lesson-sidebar { display: none !important; }
        }
      `}</style>

      {/* Main */}
      <div style={{ padding: '2rem', borderRight: '1px solid var(--line)' }}>
        {/* Breadcrumb */}
        <motion.div
          initial={{ opacity: 0, y: -6 }} animate={{ opacity: 1, y: 0 }}
          style={{ color: 'var(--muted)', fontSize: '0.8rem', marginBottom: '1rem' }}
        >
          {module.course.path ? `${module.course.path.name} → ` : ''}{module.course.title} → {module.title}
        </motion.div>

        {/* Video */}
        <motion.div
          initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }}
          style={{ width: '100%', aspectRatio: '16/9', background: 'var(--dim)', borderRadius: 12, overflow: 'hidden', marginBottom: '1.5rem', position: 'relative' }}
        >
          <AnimatePresence>
            {videoLoading && embedUrl && (
              <BrandedLoader title={activeLesson?.title ?? ''} />
            )}
          </AnimatePresence>

          {embedUrl ? (
            <iframe
              key={activeLesson?.id}
              src={embedUrl}
              title={activeLesson?.title}
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowFullScreen
              onLoad={() => setVideoLoading(false)}
              style={{ width: '100%', height: '100%', border: 'none', opacity: videoLoading ? 0 : 1, transition: 'opacity 0.4s' }}
            />
          ) : (
            <motion.div
              initial={{ opacity: 0 }} animate={{ opacity: 1 }}
              style={{ width: '100%', height: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '0.75rem' }}
            >
              <div style={{ fontSize: '2rem' }}>📺</div>
              <p style={{ color: 'var(--muted)', fontSize: '0.9rem' }}>This lesson uses a playlist</p>
              <a href={activeLesson?.youtube_url} target="_blank" rel="noopener noreferrer" className="btn-outline" style={{ fontSize: '0.85rem' }}>
                Open on YouTube →
              </a>
            </motion.div>
          )}
        </motion.div>

        {/* Lesson title */}
        <AnimatePresence mode="wait">
          <motion.h1
            key={activeLesson?.id}
            initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -8 }}
            transition={{ duration: 0.2 }}
            style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.3rem, 3vw, 1.9rem)', color: 'var(--cream)', marginBottom: '0.75rem' }}
          >
            {activeLesson?.title}
          </motion.h1>
        </AnimatePresence>

        {/* Why this video */}
        {activeLesson?.why_this_video && (
          <motion.p
            initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.15 }}
            style={{ fontStyle: 'italic', color: 'var(--muted)', fontSize: '0.95rem', lineHeight: 1.65, borderLeft: '3px solid var(--green)', paddingLeft: '1rem', marginBottom: '1.25rem' }}
          >
            {activeLesson.why_this_video}
          </motion.p>
        )}

        {/* Skills gained */}
        {activeLesson?.skills_gained && activeLesson.skills_gained.length > 0 && (
          <motion.div
            initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.2 }}
            style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap', marginBottom: '1.5rem' }}
          >
            {activeLesson.skills_gained.map((skill, i) => (
              <motion.span
                key={skill}
                initial={{ opacity: 0, scale: 0.8 }} animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: 0.2 + i * 0.05 }}
                className="pill pill-violet"
                style={{ fontSize: '0.75rem' }}
              >
                {skill}
              </motion.span>
            ))}
          </motion.div>
        )}

        {/* Mark done CTA */}
        <div style={{ position: 'relative', display: 'inline-block' }}>
          <motion.button
            whileHover={!completed.has(activeLesson?.id ?? '') ? { scale: 1.03, y: -1 } : {}}
            whileTap={!completed.has(activeLesson?.id ?? '') ? { scale: 0.97 } : {}}
            onClick={markDone}
            disabled={completed.has(activeLesson?.id ?? '') || marking}
            className="btn-primary"
            style={{
              fontSize: '0.95rem', padding: '0.75rem 1.75rem',
              opacity: completed.has(activeLesson?.id ?? '') ? 0.5 : 1,
              cursor: completed.has(activeLesson?.id ?? '') ? 'default' : 'pointer',
            }}
          >
            {completed.has(activeLesson?.id ?? '')
              ? '✓ Done'
              : marking
              ? <span style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
                  <motion.span animate={{ rotate: 360 }} transition={{ duration: 0.8, repeat: Infinity, ease: 'linear' }} style={{ display: 'inline-block', width: 12, height: 12, borderRadius: '50%', border: '2px solid rgba(0,0,0,0.3)', borderTopColor: 'var(--ink)' }} />
                  Saving…
                </span>
              : 'Mark as done →'}
          </motion.button>

          <AnimatePresence>
            {xpFloat && (
              <motion.div
                initial={{ opacity: 1, y: 0 }} animate={{ opacity: 0, y: -50 }} exit={{ opacity: 0 }}
                transition={{ duration: 1 }}
                style={{ position: 'absolute', top: -10, left: '50%', transform: 'translateX(-50%)', color: 'var(--green)', fontWeight: 700, fontSize: '1rem', pointerEvents: 'none', whiteSpace: 'nowrap' }}
              >
                +10 XP ⭐
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>

      {/* Sidebar */}
      <div
        className="lesson-sidebar"
        style={{ padding: '1.5rem', overflowY: 'auto', maxHeight: 'calc(100vh - 60px)', position: 'sticky', top: '60px' }}
      >
        {/* Course-level progress */}
        {courseModuleTotal > 0 && (
          <div style={{ marginBottom: '1.25rem', padding: '0.75rem', background: 'var(--dim)', borderRadius: 8, border: '1px solid var(--line)' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.72rem', color: 'var(--muted)', marginBottom: '0.4rem', fontWeight: 600, letterSpacing: '0.05em', textTransform: 'uppercase' }}>
              <span>Course Progress</span>
              <span style={{ color: courseModuleCompleted === courseModuleTotal ? 'var(--green)' : 'var(--muted)' }}>
                {courseModuleCompleted}/{courseModuleTotal} modules
              </span>
            </div>
            <div style={{ height: 5, background: 'rgba(255,255,255,0.08)', borderRadius: 999, overflow: 'hidden' }}>
              <motion.div
                animate={{ width: `${courseModuleTotal > 0 ? (courseModuleCompleted / courseModuleTotal) * 100 : 0}%` }}
                transition={{ duration: 0.6, ease: 'easeOut' }}
                style={{
                  height: '100%', borderRadius: 999,
                  background: courseModuleCompleted === courseModuleTotal
                    ? 'linear-gradient(90deg, #34D399, #6EE7B7)'
                    : 'linear-gradient(90deg, #6366F1, #818CF8)',
                }}
              />
            </div>
          </div>
        )}

        <div style={{ fontSize: '0.8rem', color: 'var(--muted)', marginBottom: '0.75rem', fontWeight: 600, letterSpacing: '0.05em', textTransform: 'uppercase' }}>
          {module.title}
        </div>

        {/* Module lesson progress bar */}
        <div className="progress-bar" style={{ marginBottom: '1.25rem' }}>
          <motion.div
            className="progress-bar-fill"
            animate={{ width: `${(completed.size / lessons.length) * 100}%` }}
            transition={{ duration: 0.5, ease: 'easeOut' }}
          />
        </div>
        <div style={{ color: 'var(--muted)', fontSize: '0.8rem', marginBottom: '1.25rem' }}>
          {completed.size} of {lessons.length} lessons done
        </div>

        {/* Lesson list */}
        {lessons.map((lesson, idx) => {
          const isDone = completed.has(lesson.id)
          const isActive = idx === activeLessonIdx
          return (
            <motion.button
              key={lesson.id}
              whileHover={{ x: 2 }}
              onClick={() => setActiveLessonIdx(idx)}
              style={{
                width: '100%', textAlign: 'left', padding: '0.6rem 0.75rem', borderRadius: 8,
                border: '1px solid', borderColor: isActive ? 'rgba(244,239,228,0.2)' : 'transparent',
                background: isActive ? 'rgba(244,239,228,0.06)' : 'transparent',
                color: isDone ? 'var(--muted)' : isActive ? 'var(--cream)' : 'var(--muted)',
                cursor: 'pointer', display: 'flex', alignItems: 'flex-start', gap: '0.6rem',
                marginBottom: '0.25rem', transition: 'all 0.15s',
              }}
            >
              <span style={{ marginTop: 2, flexShrink: 0, color: isDone ? 'var(--green)' : 'var(--muted)', fontSize: '0.85rem' }}>
                {isDone ? '✓' : `${idx + 1}.`}
              </span>
              <span style={{ fontSize: '0.85rem', lineHeight: 1.45, textDecoration: isDone ? 'line-through' : 'none', opacity: isDone ? 0.5 : 1 }}>
                {lesson.title}
              </span>
            </motion.button>
          )
        })}

        {/* Quiz CTA */}
        <motion.div
          initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.3 }}
          style={{ marginTop: '1.5rem', padding: '1rem', background: 'var(--dim)', border: '1px solid var(--line)', borderRadius: 10, textAlign: 'center' }}
        >
          <div style={{ fontSize: '1.1rem', marginBottom: '0.4rem' }}>🧠</div>
          <div style={{ color: 'var(--cream)', fontSize: '0.85rem', fontWeight: 600, marginBottom: '0.3rem' }}>Module quiz</div>
          <div style={{ color: 'var(--muted)', fontSize: '0.78rem', marginBottom: '0.75rem' }}>
            {completed.size < lessons.length ? 'Complete all lessons to unlock' : 'Ready to take the quiz!'}
          </div>
          <motion.button
            whileHover={completed.size === lessons.length ? { scale: 1.03 } : {}}
            whileTap={completed.size === lessons.length ? { scale: 0.97 } : {}}
            onClick={() => completed.size === lessons.length && router.push(`/quiz/${module.id}`)}
            disabled={completed.size < lessons.length}
            className="btn-primary"
            style={{ width: '100%', fontSize: '0.82rem', padding: '0.55rem', opacity: completed.size === lessons.length ? 1 : 0.35 }}
          >
            Take quiz +150 XP
          </motion.button>
        </motion.div>
      </div>
    </div>
  )
}
