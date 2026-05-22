'use client'

import { useState, useEffect, useCallback } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { motion, AnimatePresence } from 'framer-motion'

// ─── Types ────────────────────────────────────────────────────────────────────
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
  description?: string | null
  order_index?: number
  course: {
    id: string
    title: string
    slug: string
    path: { id: string; name: string; slug: string } | null
  }
}

interface CourseModule {
  id: string
  title: string
  slug: string
  order_index: number
  lessonCount: number
  lessonIds: string[]
}

interface Props {
  module: Module
  lessons: Lesson[]
  completedLessonIds: string[]
  userId: string
  isPro: boolean
  courseSlug: string
  allModules: CourseModule[]
  passedModuleIds: string[]
}

// ─── Constants ────────────────────────────────────────────────────────────────
const MODULE_EMOJIS = ['💡', '🖥️', '✍️', '📦', '📂', '🔌', '👥', '🔍', '💻', '⚙️']

// ─── 10-Slide Module Intro ─────────────────────────────────────────────────────
interface IntroData {
  overview?: string
  prerequisites?: string[]
  objectives?: string[]
}

function ModuleIntroSlideshow({
  module, lessons, introData, allModules, onStart,
}: {
  module: Module; lessons: Lesson[]; introData: IntroData; allModules: CourseModule[]; onStart: () => void
}) {
  const emoji = MODULE_EMOJIS[(module.order_index ?? 0) % MODULE_EMOJIS.length]
  const idx = (module.order_index ?? 0) + 1
  const total = allModules.length
  const objectives = introData.objectives ?? []
  const prereqs = introData.prerequisites ?? []
  const [current, setCurrent] = useState(0)

  const slides = [
    {
      id: 'welcome',
      content: (
        <div style={{ textAlign: 'center', maxWidth: 580, padding: '0 1rem' }}>
          <motion.div animate={{ y: [0, -12, 0] }} transition={{ duration: 3, repeat: Infinity }}
            style={{ fontSize: 'clamp(4rem, 12vw, 7rem)', lineHeight: 1, marginBottom: '1.5rem' }}>{emoji}</motion.div>
          <div style={{ fontSize: '0.7rem', fontWeight: 700, letterSpacing: '0.25em', textTransform: 'uppercase', color: 'var(--green)', marginBottom: '0.75rem' }}>
            Module {idx} of {total}
          </div>
          <h1 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.8rem, 5vw, 3rem)', fontWeight: 900, color: 'var(--cream)', lineHeight: 1.15, marginBottom: '1.25rem' }}>
            {module.title}
          </h1>
          {introData.overview && (
            <p style={{ color: 'var(--text-muted)', fontSize: 'clamp(0.9rem, 2vw, 1.05rem)', lineHeight: 1.75 }}>
              {introData.overview}
            </p>
          )}
        </div>
      ),
    },
    {
      id: 'path',
      content: (
        <div style={{ textAlign: 'center', maxWidth: 560, padding: '0 1rem' }}>
          <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🗺️</div>
          <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 4vw, 2rem)', fontWeight: 800, color: 'var(--cream)', marginBottom: '0.6rem' }}>Your Learning Path</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '2rem' }}>
            From first lesson to earning your module badge — here's the journey.
          </p>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', flexWrap: 'wrap', gap: '0.5rem' }}>
            {[
              { icon: '🎬', label: `${lessons.length} Videos`, color: 'var(--green)' },
              { icon: '→', arrow: true },
              { icon: '🃏', label: 'Flashcards', color: 'var(--violet)' },
              { icon: '→', arrow: true },
              { icon: '🧠', label: '15-Q Quiz', color: 'var(--coral)' },
              { icon: '→', arrow: true },
              { icon: '🏅', label: 'Badge', color: 'var(--amber)' },
            ].map((s, i) => s.arrow ? (
              <span key={i} style={{ color: 'var(--text-muted)', fontSize: '1.1rem' }}>→</span>
            ) : (
              <motion.div key={i} initial={{ opacity: 0, y: 16 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.1 }}
                style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '0.4rem', background: 'var(--surface)', border: '1.5px solid var(--line)', borderRadius: 16, padding: '0.875rem 1.125rem' }}>
                <span style={{ fontSize: '1.6rem' }}>{s.icon}</span>
                <span style={{ fontSize: '0.72rem', fontWeight: 700, color: s.color }}>{s.label}</span>
              </motion.div>
            ))}
          </div>
        </div>
      ),
    },
    {
      id: 'outcomes1',
      content: (
        <div style={{ width: '100%', maxWidth: 580, padding: '0 1rem' }}>
          <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
            <div style={{ fontSize: '2.5rem', marginBottom: '0.5rem' }}>🎯</div>
            <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.3rem, 3.5vw, 1.8rem)', fontWeight: 800, color: 'var(--cream)' }}>What You'll Master</h2>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
            {objectives.slice(0, Math.ceil(objectives.length / 2)).map((obj, i) => (
              <motion.div key={i} initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: i * 0.1 }}
                style={{ display: 'flex', gap: '0.875rem', alignItems: 'flex-start', background: 'var(--surface)', border: '1.5px solid var(--line)', borderRadius: 14, padding: '0.875rem 1.125rem' }}>
                <span style={{ color: 'var(--green)', fontWeight: 700, marginTop: '0.1rem', flexShrink: 0 }}>✦</span>
                <p style={{ color: 'var(--cream)', fontSize: '0.92rem', lineHeight: 1.55, margin: 0 }}>{obj}</p>
              </motion.div>
            ))}
          </div>
        </div>
      ),
    },
    {
      id: 'outcomes2',
      content: (
        <div style={{ width: '100%', maxWidth: 580, padding: '0 1rem' }}>
          <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
            <div style={{ fontSize: '2.5rem', marginBottom: '0.5rem' }}>🚀</div>
            <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.3rem, 3.5vw, 1.8rem)', fontWeight: 800, color: 'var(--cream)' }}>And You'll Also Learn…</h2>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
            {objectives.slice(Math.ceil(objectives.length / 2)).map((obj, i) => (
              <motion.div key={i} initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: i * 0.1 }}
                style={{ display: 'flex', gap: '0.875rem', alignItems: 'flex-start', background: 'var(--surface)', border: '1.5px solid var(--line)', borderRadius: 14, padding: '0.875rem 1.125rem' }}>
                <span style={{ color: 'var(--violet)', fontWeight: 700, marginTop: '0.1rem', flexShrink: 0 }}>✦</span>
                <p style={{ color: 'var(--cream)', fontSize: '0.92rem', lineHeight: 1.55, margin: 0 }}>{obj}</p>
              </motion.div>
            ))}
          </div>
        </div>
      ),
    },
    {
      id: 'lessons',
      content: (
        <div style={{ width: '100%', maxWidth: 560, padding: '0 1rem' }}>
          <div style={{ textAlign: 'center', marginBottom: '1.25rem' }}>
            <div style={{ fontSize: '2.5rem', marginBottom: '0.5rem' }}>🎬</div>
            <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.3rem, 3.5vw, 1.8rem)', fontWeight: 800, color: 'var(--cream)', marginBottom: '0.25rem' }}>{lessons.length} Video Lessons</h2>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.83rem' }}>Expert-curated, built in a logical learning sequence.</p>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.45rem', maxHeight: '40vh', overflowY: 'auto' }}>
            {lessons.map((l, i) => (
              <motion.div key={l.id} initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: i * 0.05 }}
                style={{ display: 'flex', gap: '0.7rem', alignItems: 'center', background: 'var(--surface)', border: '1.5px solid var(--line)', borderRadius: 10, padding: '0.65rem 0.875rem' }}>
                <span style={{ fontSize: '0.72rem', fontWeight: 700, color: 'var(--green)', background: 'color-mix(in srgb, var(--green) 12%, transparent)', borderRadius: 6, padding: '2px 6px', flexShrink: 0 }}>{i + 1}</span>
                <span style={{ color: 'var(--cream)', fontSize: '0.86rem', lineHeight: 1.35, flex: 1 }}>{l.title}</span>
                {l.duration_minutes && <span style={{ color: 'var(--text-muted)', fontSize: '0.7rem', flexShrink: 0 }}>{l.duration_minutes}m</span>}
              </motion.div>
            ))}
          </div>
        </div>
      ),
    },
    ...(prereqs.length > 0 ? [{
      id: 'prereqs',
      content: (
        <div style={{ width: '100%', maxWidth: 520, padding: '0 1rem' }}>
          <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
            <div style={{ fontSize: '2.5rem', marginBottom: '0.5rem' }}>✅</div>
            <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.3rem, 3.5vw, 1.8rem)', fontWeight: 800, color: 'var(--cream)', marginBottom: '0.35rem' }}>Before You Start</h2>
            <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem' }}>Make sure you're set up for success.</p>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.65rem' }}>
            {prereqs.map((p, i) => (
              <motion.div key={i} initial={{ opacity: 0, x: -16 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: i * 0.1 }}
                style={{ display: 'flex', gap: '0.75rem', alignItems: 'flex-start', background: 'color-mix(in srgb, var(--success) 6%, transparent)', border: '1.5px solid color-mix(in srgb, var(--success) 25%, transparent)', borderRadius: 12, padding: '0.8rem 1rem' }}>
                <span style={{ color: 'var(--success)', flexShrink: 0, fontWeight: 700 }}>✓</span>
                <span style={{ color: 'var(--cream)', fontSize: '0.9rem', lineHeight: 1.5 }}>{p}</span>
              </motion.div>
            ))}
          </div>
        </div>
      ),
    }] : []),
    {
      id: 'quiz',
      content: (
        <div style={{ textAlign: 'center', maxWidth: 480, padding: '0 1rem' }}>
          <motion.div animate={{ rotate: [0, 10, -10, 0] }} transition={{ duration: 2.5, repeat: Infinity }}
            style={{ fontSize: 'clamp(3rem, 10vw, 5rem)', marginBottom: '1rem', display: 'inline-block' }}>🧠</motion.div>
          <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 4vw, 2rem)', fontWeight: 800, color: 'var(--cream)', marginBottom: '0.6rem' }}>Module Quiz</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.7, marginBottom: '1.75rem' }}>
            After watching all lessons, take the <strong style={{ color: 'var(--coral)' }}>15-question module quiz</strong> to earn your badge and XP.
          </p>
          <div style={{ display: 'flex', gap: '0.6rem', flexWrap: 'wrap', justifyContent: 'center' }}>
            {['15 Questions', 'Multiple Choice', 'Instant Feedback', '+150 XP'].map((t, i) => (
              <motion.span key={t} initial={{ opacity: 0, scale: 0.85 }} animate={{ opacity: 1, scale: 1 }} transition={{ delay: i * 0.08 }}
                className="pill pill-violet">{t}</motion.span>
            ))}
          </div>
        </div>
      ),
    },
    {
      id: 'flashcards',
      content: (
        <div style={{ textAlign: 'center', maxWidth: 480, padding: '0 1rem' }}>
          <div style={{ fontSize: 'clamp(3rem, 10vw, 5rem)', marginBottom: '1rem' }}>🃏</div>
          <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 4vw, 2rem)', fontWeight: 800, color: 'var(--cream)', marginBottom: '0.6rem' }}>Flashcard Review</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.7, marginBottom: '1.75rem' }}>
            Flashcards lock in key concepts using <strong style={{ color: 'var(--amber)' }}>active recall</strong> — the fastest path from understanding to truly knowing.
          </p>
          <div style={{ display: 'flex', gap: '0.6rem', flexWrap: 'wrap', justifyContent: 'center' }}>
            {['Spaced Repetition', 'Key Terms', 'Concept Checks', 'Anytime Review'].map((t, i) => (
              <motion.span key={t} initial={{ opacity: 0, scale: 0.85 }} animate={{ opacity: 1, scale: 1 }} transition={{ delay: i * 0.08 }}
                className="pill pill-amber">{t}</motion.span>
            ))}
          </div>
        </div>
      ),
    },
    {
      id: 'skills',
      content: (
        <div style={{ textAlign: 'center', maxWidth: 500, padding: '0 1rem' }}>
          <div style={{ fontSize: 'clamp(3rem, 10vw, 5rem)', marginBottom: '1rem' }}>🏅</div>
          <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.4rem, 4vw, 2rem)', fontWeight: 800, color: 'var(--cream)', marginBottom: '0.6rem' }}>Skills You'll Earn</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', lineHeight: 1.65, marginBottom: '1.5rem' }}>
            By the end of this module, you'll have practical, job-ready skills:
          </p>
          <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap', justifyContent: 'center' }}>
            {[module.title, ...objectives.slice(0, 4).map(o => o.split(' ').slice(0, 5).join(' '))].map((s, i) => (
              <motion.span key={i} initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}
                className="pill pill-green">{s}</motion.span>
            ))}
          </div>
        </div>
      ),
    },
    {
      id: 'ready',
      content: (
        <div style={{ textAlign: 'center', maxWidth: 460, padding: '0 1rem' }}>
          <motion.div animate={{ scale: [1, 1.12, 1] }} transition={{ duration: 2, repeat: Infinity }}
            style={{ fontSize: 'clamp(3.5rem, 12vw, 6rem)', marginBottom: '1rem', display: 'inline-block' }}>🚀</motion.div>
          <h2 style={{ fontFamily: 'var(--font-serif)', fontSize: 'clamp(1.6rem, 5vw, 2.4rem)', fontWeight: 900, color: 'var(--cream)', marginBottom: '0.75rem' }}>
            You're All Set!
          </h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.7, marginBottom: '2rem' }}>
            Dive into <strong style={{ color: 'var(--cream)' }}>{module.title}</strong>. Take your time, rewatch as needed, and don't skip the quiz!
          </p>
          <div style={{ display: 'flex', gap: '1.25rem', justifyContent: 'center', fontSize: '0.82rem', color: 'var(--text-muted)' }}>
            <span>🎬 {lessons.length} lessons</span>
            <span>·</span>
            <span>🧠 15-Q quiz</span>
            <span>·</span>
            <span>🏅 Module badge</span>
          </div>
        </div>
      ),
    },
  ].slice(0, 10)

  const total2 = slides.length
  const next = useCallback(() => {
    if (current < total2 - 1) setCurrent(c => c + 1)
    else onStart()
  }, [current, total2, onStart])
  const prev = () => setCurrent(c => Math.max(0, c - 1))

  useEffect(() => {
    const h = (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight' || e.key === ' ') { e.preventDefault(); next() }
      if (e.key === 'ArrowLeft') { e.preventDefault(); prev() }
      if (e.key === 'Escape') onStart()
    }
    window.addEventListener('keydown', h)
    return () => window.removeEventListener('keydown', h)
  }, [next, onStart])

  return (
    <div style={{ position: 'fixed', inset: 0, zIndex: 9999, background: 'var(--bg)', display: 'flex', flexDirection: 'column' }}>
      {/* Top */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem 1.5rem', borderBottom: '1.5px solid var(--line)', flexShrink: 0 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          <span style={{ fontSize: '0.68rem', fontWeight: 700, letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--green)' }}>
            Module {idx} Intro
          </span>
          <span style={{ color: 'var(--text-muted)', fontSize: '0.78rem' }}>· {module.course.title}</span>
        </div>
        <button onClick={onStart} style={{ background: 'var(--surface)', border: '1.5px solid var(--line)', color: 'var(--text-muted)', borderRadius: 8, padding: '0.35rem 0.85rem', fontSize: '0.78rem', cursor: 'pointer' }}>
          Skip intro →
        </button>
      </div>

      {/* Progress dots */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: '0.35rem', padding: '0.875rem 0', flexShrink: 0 }}>
        {slides.map((_, i) => (
          <button key={i} onClick={() => setCurrent(i)} style={{
            width: i === current ? 22 : 7, height: 7, borderRadius: 99,
            background: i === current ? 'var(--green)' : i < current ? 'color-mix(in srgb, var(--green) 40%, transparent)' : 'var(--line)',
            border: 'none', cursor: 'pointer', padding: 0, transition: 'all 0.25s',
          }} />
        ))}
      </div>

      {/* Slide */}
      <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden', padding: '1rem' }}>
        <AnimatePresence mode="wait">
          <motion.div key={slides[current].id}
            initial={{ opacity: 0, x: 36, scale: 0.97 }}
            animate={{ opacity: 1, x: 0, scale: 1 }}
            exit={{ opacity: 0, x: -36, scale: 0.97 }}
            transition={{ duration: 0.28, ease: 'easeOut' }}
            style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', width: '100%', maxHeight: '100%', overflowY: 'auto' }}
          >
            {slides[current].content}
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Bottom nav */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem 1.5rem', borderTop: '1.5px solid var(--line)', flexShrink: 0, gap: '1rem' }}>
        <button onClick={prev} disabled={current === 0}
          style={{ background: 'var(--surface)', border: '1.5px solid var(--line)', color: current === 0 ? 'var(--text-muted)' : 'var(--cream)', borderRadius: 10, padding: '0.65rem 1.5rem', fontSize: '0.875rem', cursor: current === 0 ? 'default' : 'pointer', fontWeight: 600, opacity: current === 0 ? 0.4 : 1 }}>
          ← Back
        </button>
        <span style={{ color: 'var(--text-muted)', fontSize: '0.75rem' }}>{current + 1} / {total2}</span>
        <motion.button whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.97 }} onClick={next}
          className={current === total2 - 1 ? 'btn-primary' : 'btn-outline'}
          style={{ padding: '0.65rem 1.75rem', fontSize: '0.875rem', fontWeight: 700, borderRadius: 10 }}>
          {current === total2 - 1 ? '🚀 Start Module' : 'Next →'}
        </motion.button>
      </div>
    </div>
  )
}

// ─── Lesson Picker Drawer ──────────────────────────────────────────────────────
function LessonPickerDrawer({
  lessons, currentIdx, completedSet, onSelect, onClose,
}: {
  lessons: Lesson[]; currentIdx: number; completedSet: Set<string>; onSelect: (i: number) => void; onClose: () => void
}) {
  return (
    <div style={{ position: 'fixed', inset: 0, zIndex: 200, display: 'flex' }} onClick={onClose}>
      <div style={{ flex: 1 }} />
      <motion.div
        initial={{ x: '100%' }} animate={{ x: 0 }} exit={{ x: '100%' }}
        transition={{ type: 'spring', stiffness: 320, damping: 32 }}
        onClick={e => e.stopPropagation()}
        style={{ width: 320, height: '100%', background: 'var(--bg)', borderLeft: '1.5px solid var(--line)', display: 'flex', flexDirection: 'column' }}
      >
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '1rem 1.25rem', borderBottom: '1.5px solid var(--line)', flexShrink: 0 }}>
          <span style={{ fontWeight: 700, fontSize: '0.88rem', color: 'var(--cream)' }}>Lessons in this module</span>
          <button onClick={onClose} style={{ background: 'none', border: 'none', color: 'var(--text-muted)', cursor: 'pointer', fontSize: '1.1rem', padding: '0.25rem 0.5rem' }}>✕</button>
        </div>
        <div style={{ flex: 1, overflowY: 'auto' }}>
          {lessons.map((l, i) => {
            const done = completedSet.has(l.id)
            const active = i === currentIdx
            return (
              <button key={l.id} onClick={() => { onSelect(i); onClose() }}
                style={{
                  width: '100%', textAlign: 'left', padding: '0.875rem 1.25rem',
                  background: active ? 'color-mix(in srgb, var(--green) 8%, transparent)' : 'transparent',
                  borderLeft: active ? '3px solid var(--green)' : '3px solid transparent',
                  border: 'none', borderBottom: '1.5px solid var(--line)', cursor: 'pointer',
                  display: 'flex', alignItems: 'center', gap: '0.75rem',
                }}
              >
                <span style={{ fontSize: '0.78rem', color: done ? 'var(--success)' : active ? 'var(--green)' : 'var(--text-muted)', flexShrink: 0, fontWeight: 700 }}>
                  {done ? '✓' : active ? '▶' : i + 1}
                </span>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ fontSize: '0.84rem', color: active ? 'var(--cream)' : done ? 'var(--text-muted)' : 'var(--cream)', lineHeight: 1.4, textDecoration: done && !active ? 'line-through' : 'none' }}>
                    {l.title}
                  </div>
                  {l.duration_minutes && <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)', marginTop: '0.2rem' }}>{l.duration_minutes} min</div>}
                </div>
                {active && <span style={{ fontSize: '0.65rem', background: 'var(--green)', color: 'var(--btn-text)', borderRadius: 99, padding: '2px 8px', fontWeight: 700, flexShrink: 0 }}>Now</span>}
              </button>
            )
          })}
        </div>
      </motion.div>
    </div>
  )
}

// ─── Course Nav Sidebar ────────────────────────────────────────────────────────
function CourseSidebar({
  allModules, currentModuleId, courseSlug, completedLessonIds, passedModuleIds, isPro,
}: {
  allModules: CourseModule[]; currentModuleId: string; courseSlug: string;
  completedLessonIds: string[]; passedModuleIds: string[]; isPro: boolean
}) {
  const [expanded, setExpanded] = useState(currentModuleId)
  const completedSet = new Set(completedLessonIds)

  return (
    <div style={{ display: 'flex', flexDirection: 'column', height: '100%', overflowY: 'auto', background: 'var(--bg)' }}>
      <div style={{ padding: '0.875rem 1rem', borderBottom: '1.5px solid var(--line)', flexShrink: 0 }}>
        <p style={{ fontSize: '0.62rem', fontWeight: 700, letterSpacing: '0.18em', textTransform: 'uppercase', color: 'var(--green)', marginBottom: '0.2rem' }}>Course Content</p>
        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>{allModules.length} modules</p>
      </div>
      {allModules.map(mod => {
        const isActive = mod.id === currentModuleId
        const isExp = expanded === mod.id
        const passed = passedModuleIds.includes(mod.id)
        const locked = !isPro && mod.order_index > 1
        const done = mod.lessonIds.filter(id => completedSet.has(id)).length
        const pct = mod.lessonCount > 0 ? done / mod.lessonCount : 0
        const emoji = MODULE_EMOJIS[mod.order_index % MODULE_EMOJIS.length]

        return (
          <div key={mod.id}>
            <button onClick={() => !locked && setExpanded(isExp ? '' : mod.id)}
              style={{
                width: '100%', textAlign: 'left', padding: '0.7rem 1rem',
                background: isActive ? 'color-mix(in srgb, var(--green) 6%, transparent)' : 'transparent',
                borderLeft: isActive ? '3px solid var(--green)' : '3px solid transparent',
                border: 'none', borderBottom: '1.5px solid var(--line)',
                cursor: locked ? 'not-allowed' : 'pointer', display: 'flex', alignItems: 'center', gap: '0.5rem',
              }}>
              <span style={{ fontSize: '0.9rem', flexShrink: 0 }}>{locked ? '🔒' : passed ? '✅' : emoji}</span>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ fontSize: '0.73rem', fontWeight: 600, color: isActive ? 'var(--green)' : locked ? 'var(--text-muted)' : 'var(--cream)', lineHeight: 1.3, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                  {mod.order_index + 1}. {mod.title}
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', marginTop: '0.3rem' }}>
                  <div style={{ flex: 1, height: 3, background: 'var(--line)', borderRadius: 99, overflow: 'hidden' }}>
                    <div style={{ height: '100%', width: `${pct * 100}%`, background: passed ? 'var(--success)' : 'var(--green)', borderRadius: 99 }} />
                  </div>
                  <span style={{ fontSize: '0.6rem', color: 'var(--text-muted)', flexShrink: 0 }}>{done}/{mod.lessonCount}</span>
                </div>
              </div>
              {!locked && <span style={{ fontSize: '0.6rem', color: 'var(--text-muted)', transform: isExp ? 'rotate(180deg)' : 'none', transition: 'transform 0.2s', flexShrink: 0 }}>▼</span>}
            </button>
            <AnimatePresence>
              {isExp && !locked && (
                <motion.div initial={{ height: 0 }} animate={{ height: 'auto' }} exit={{ height: 0 }} transition={{ duration: 0.2 }} style={{ overflow: 'hidden' }}>
                  {isActive ? (
                    <div style={{ padding: '0.4rem 0', background: 'color-mix(in srgb, var(--green) 3%, transparent)' }}>
                      <p style={{ fontSize: '0.68rem', color: 'var(--text-muted)', padding: '0.3rem 1rem 0.5rem 2.5rem', fontStyle: 'italic' }}>Current module — use lesson picker to navigate</p>
                    </div>
                  ) : (
                    <Link href={`/learn/${courseSlug}/${mod.id}`} style={{ textDecoration: 'none', display: 'block', padding: '0.6rem 1rem 0.6rem 2.5rem', fontSize: '0.76rem', color: 'var(--text-muted)', borderBottom: '1.5px solid var(--line)' }}>
                      → Go to this module ({mod.lessonCount} lessons)
                    </Link>
                  )}
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.55rem 1rem 0.55rem 2.5rem', borderBottom: '1.5px solid var(--line)' }}>
                    <span style={{ fontSize: '0.7rem', color: passed ? 'var(--success)' : 'var(--text-muted)' }}>{passed ? '✓' : '○'}</span>
                    <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)' }}>Module Quiz (15 questions)</span>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        )
      })}
    </div>
  )
}

// ─── Main LessonPlayer ────────────────────────────────────────────────────────
export default function LessonPlayer({
  module, lessons, completedLessonIds, userId, isPro, courseSlug,
  allModules, passedModuleIds,
}: Props) {
  const router = useRouter()

  const [activeLessonIdx, setActiveLessonIdx] = useState(() => {
    const first = lessons.findIndex(l => !completedLessonIds.includes(l.id))
    return first >= 0 ? first : 0
  })
  const [completed, setCompleted] = useState<Set<string>>(new Set(completedLessonIds))
  const [marking, setMarking] = useState(false)
  const [xpFloat, setXpFloat] = useState(false)
  const [videoLoaded, setVideoLoaded] = useState(false)
  const [showIntro, setShowIntro] = useState(false)
  const [sidebarOpen, setSidebarOpen] = useState(false)  // closed by default — more screen real estate
  const [lessonPickerOpen, setLessonPickerOpen] = useState(false)

  // Parse module description
  let introData: IntroData = {}
  try {
    if (module.description?.startsWith('{')) introData = JSON.parse(module.description)
    else if (module.description) introData = { overview: module.description }
  } catch { /* fallback */ }

  const searchParams = useSearchParams()

  // Show intro:
  //  - Always on first-ever visit (localStorage key not set)
  //  - Always when arriving from a quiz via ?intro=1 (cross-module transition)
  useEffect(() => {
    const forceIntro = searchParams.get('intro') === '1'
    try {
      const dismissed = localStorage.getItem(`module_intro_dismissed_${module.id}`)
      if (forceIntro || dismissed !== 'true') {
        setShowIntro(true)
      }
    } catch { /* SSR */ }
    // Clean the ?intro param from the URL without a navigation
    if (forceIntro) {
      const url = new URL(window.location.href)
      url.searchParams.delete('intro')
      window.history.replaceState({}, '', url.toString())
    }
  }, [module.id, searchParams])

  const dismissIntro = useCallback(() => {
    try { localStorage.setItem(`module_intro_dismissed_${module.id}`, 'true') } catch { /* SSR */ }
    setShowIntro(false)
  }, [module.id])

  const activeLesson = lessons[activeLessonIdx]
  const isCurrentDone = completed.has(activeLesson?.id ?? '')
  const isLastLesson = activeLessonIdx === lessons.length - 1
  const allDone = completed.size >= lessons.length

  // Reset video load state on lesson change
  useEffect(() => {
    setVideoLoaded(false)
    const t = setTimeout(() => setVideoLoaded(true), 3500)
    return () => clearTimeout(t)
  }, [activeLessonIdx])

  const markDone = async () => {
    if (!activeLesson || isCurrentDone || marking) return
    setMarking(true)
    try {
      const res = await fetch('/api/progress/lesson', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ lessonId: activeLesson.id }),
      })
      if (res.ok) {
        const newCompleted = new Set([...completed, activeLesson.id])
        setCompleted(newCompleted)
        setXpFloat(true)
        setTimeout(() => setXpFloat(false), 1200)
        if (isLastLesson) {
          // All lessons done — go to quiz
          setTimeout(() => router.push(`/quiz/${module.id}`), 600)
        } else {
          setTimeout(() => setActiveLessonIdx(i => i + 1), 400)
        }
      }
    } finally { setMarking(false) }
  }

  const goToPrev = () => setActiveLessonIdx(i => Math.max(0, i - 1))
  const goToNext = () => setActiveLessonIdx(i => Math.min(lessons.length - 1, i + 1))

  if (lessons.length === 0) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', background: 'var(--bg)' }}>
        <span style={{ fontSize: '3rem', marginBottom: '1rem' }}>😴</span>
        <p style={{ color: 'var(--text-muted)', marginBottom: '1.5rem' }}>No lessons yet for this module.</p>
        <button onClick={() => router.back()} className="btn-outline">← Go back</button>
      </div>
    )
  }

  const embedUrl = activeLesson?.youtube_video_id
    ? `https://www.youtube.com/embed/${activeLesson.youtube_video_id}?rel=0&modestbranding=1&autoplay=1`
    : null

  const SIDEBAR_W = 280
  const TOP_BAR_H = 52
  const BOTTOM_BAR_H = 64

  return (
    <>
      {/* Module Intro Slideshow */}
      <AnimatePresence>
        {showIntro && (
          <ModuleIntroSlideshow
            module={module} lessons={lessons} introData={introData}
            allModules={allModules} onStart={dismissIntro}
          />
        )}
      </AnimatePresence>

      {/* Lesson Picker Drawer */}
      <AnimatePresence>
        {lessonPickerOpen && (
          <LessonPickerDrawer
            lessons={lessons} currentIdx={activeLessonIdx}
            completedSet={completed}
            onSelect={setActiveLessonIdx}
            onClose={() => setLessonPickerOpen(false)}
          />
        )}
      </AnimatePresence>

      {/* Full-screen layout */}
      <div style={{
        position: 'fixed', inset: 0, zIndex: 50,
        background: 'var(--bg)',
        display: 'flex', flexDirection: 'column',
      }}>
        {/* ── Top bar ── */}
        <div style={{
          height: TOP_BAR_H, flexShrink: 0,
          display: 'flex', alignItems: 'center', gap: '0.75rem',
          padding: '0 1rem',
          borderBottom: '1.5px solid var(--line)',
          background: 'var(--bg)',
        }}>
          {/* Course sidebar toggle */}
          <button
            onClick={() => setSidebarOpen(o => !o)}
            title="Course content"
            style={{
              display: 'flex', alignItems: 'center', gap: '0.4rem',
              background: sidebarOpen ? 'color-mix(in srgb, var(--green) 10%, transparent)' : 'var(--surface)',
              border: '1.5px solid var(--line)',
              color: sidebarOpen ? 'var(--green)' : 'var(--text-muted)',
              borderRadius: 8, padding: '0.35rem 0.7rem', fontSize: '0.78rem', fontWeight: 600,
              cursor: 'pointer', flexShrink: 0, transition: 'all 0.15s',
            }}
          >
            <span>☰</span>
            <span style={{ display: 'none' }}>Modules</span>
          </button>

          {/* Breadcrumb */}
          <div style={{ flex: 1, minWidth: 0, display: 'flex', alignItems: 'center', gap: '0.4rem', overflow: 'hidden' }}>
            <span style={{ fontSize: '0.72rem', color: 'var(--text-muted)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', flexShrink: 1 }}>
              {module.course.title}
            </span>
            <span style={{ color: 'var(--text-muted)', flexShrink: 0 }}>›</span>
            <span style={{ fontSize: '0.72rem', fontWeight: 600, color: 'var(--cream)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', flexShrink: 1 }}>
              {module.title}
            </span>
          </div>

          {/* Lesson counter pill */}
          <div style={{
            display: 'flex', alignItems: 'center', gap: '0.45rem',
            background: 'color-mix(in srgb, var(--green) 8%, transparent)',
            border: '1.5px solid color-mix(in srgb, var(--green) 22%, transparent)',
            borderRadius: 99, padding: '0.2rem 0.65rem', flexShrink: 0,
          }}>
            <div style={{ width: 6, height: 6, borderRadius: '50%', background: 'var(--green)' }} />
            <span style={{ fontSize: '0.68rem', fontWeight: 700, color: 'var(--green)' }}>
              {completed.size}/{lessons.length}
            </span>
          </div>

          {/* Lesson picker button — clearly different, distinct style */}
          <button
            onClick={() => setLessonPickerOpen(true)}
            title="Browse lessons"
            style={{
              display: 'flex', alignItems: 'center', gap: '0.4rem',
              background: 'var(--surface)', border: '1.5px solid var(--line)',
              color: 'var(--cream)', borderRadius: 8, padding: '0.35rem 0.7rem',
              fontSize: '0.75rem', fontWeight: 600, cursor: 'pointer', flexShrink: 0,
            }}
          >
            <span>📋</span>
            <span style={{ fontSize: '0.7rem' }}>Lessons</span>
          </button>

          {/* Close */}
          <Link href={`/courses/${courseSlug}`}
            style={{
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              width: 32, height: 32, borderRadius: 8, flexShrink: 0,
              background: 'var(--surface)', border: '1.5px solid var(--line)',
              color: 'var(--text-muted)', textDecoration: 'none', fontSize: '1rem',
              transition: 'background 0.15s',
            }}
            title="Back to course"
          >✕</Link>
        </div>

        {/* ── Content row (sidebar + video area) ── */}
        <div style={{ flex: 1, display: 'flex', overflow: 'hidden', minHeight: 0 }}>

          {/* Sidebar */}
          <AnimatePresence>
            {sidebarOpen && (
              <motion.div
                initial={{ width: 0, opacity: 0 }}
                animate={{ width: SIDEBAR_W, opacity: 1 }}
                exit={{ width: 0, opacity: 0 }}
                transition={{ duration: 0.22 }}
                style={{ flexShrink: 0, height: '100%', overflow: 'hidden', borderRight: '1.5px solid var(--line)' }}
              >
                <div style={{ width: SIDEBAR_W, height: '100%' }}>
                  <CourseSidebar
                    allModules={allModules} currentModuleId={module.id}
                    courseSlug={courseSlug} completedLessonIds={[...completed]}
                    passedModuleIds={passedModuleIds} isPro={isPro}
                  />
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          {/* Main video area */}
          <div style={{ flex: 1, minWidth: 0, display: 'flex', flexDirection: 'column', height: '100%', overflow: 'hidden' }}>

            {/* Video — fills available height, constrained by bottom bar */}
            <div style={{
              flex: 1, minHeight: 0, position: 'relative',
              background: '#000',
            }}>
              {/* Loading spinner */}
              <AnimatePresence>
                {!videoLoaded && embedUrl && (
                  <motion.div
                    initial={{ opacity: 1 }} exit={{ opacity: 0 }}
                    style={{ position: 'absolute', inset: 0, zIndex: 10, background: 'var(--bg)', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '1.25rem' }}
                  >
                    <motion.div animate={{ rotate: 360 }} transition={{ duration: 1, repeat: Infinity, ease: 'linear' }}
                      style={{ width: 44, height: 44, borderRadius: '50%', border: '3px solid var(--line)', borderTopColor: 'var(--green)' }} />
                    <span style={{ color: 'var(--text-muted)', fontSize: '0.8rem' }}>Loading video…</span>
                  </motion.div>
                )}
              </AnimatePresence>

              {embedUrl ? (
                <iframe
                  key={activeLesson?.id}
                  src={embedUrl}
                  title={activeLesson?.title}
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                  allowFullScreen
                  onLoad={() => setVideoLoaded(true)}
                  style={{ width: '100%', height: '100%', border: 'none', display: 'block', opacity: videoLoaded ? 1 : 0, transition: 'opacity 0.35s' }}
                />
              ) : (
                <div style={{ width: '100%', height: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: '1rem' }}>
                  <span style={{ fontSize: '2.5rem' }}>📺</span>
                  <a href={activeLesson?.youtube_url} target="_blank" rel="noopener noreferrer"
                    style={{ color: 'var(--green)', fontSize: '0.95rem', textDecoration: 'none', fontWeight: 600 }}>
                    Open on YouTube →
                  </a>
                </div>
              )}

              {/* Lesson title overlay — bottom of video */}
              <AnimatePresence mode="wait">
                <motion.div
                  key={activeLesson?.id}
                  initial={{ opacity: 0, y: 8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0 }}
                  style={{
                    position: 'absolute', bottom: 0, left: 0, right: 0,
                    background: 'linear-gradient(to top, rgba(0,0,0,0.85) 0%, transparent 100%)',
                    padding: '2rem 1.25rem 0.75rem',
                    pointerEvents: 'none',
                  }}
                >
                  <p style={{ fontSize: 'clamp(0.78rem, 1.5vw, 0.92rem)', fontWeight: 600, color: 'rgba(255,255,255,0.9)', lineHeight: 1.35, margin: 0 }}>
                    {activeLessonIdx + 1}. {activeLesson?.title}
                  </p>
                  {activeLesson?.why_this_video && (
                    <p style={{ fontSize: '0.72rem', color: 'rgba(255,255,255,0.55)', margin: '0.25rem 0 0', lineHeight: 1.4 }}>
                      {activeLesson.why_this_video}
                    </p>
                  )}
                </motion.div>
              </AnimatePresence>
            </div>
          </div>
        </div>

        {/* ── Bottom action bar (always visible) ── */}
        <div style={{
          height: BOTTOM_BAR_H, flexShrink: 0,
          display: 'flex', alignItems: 'center',
          padding: '0 1rem', gap: '0.75rem',
          borderTop: '1.5px solid var(--line)',
          background: 'var(--bg)',
        }}>
          {/* Prev lesson */}
          <button
            onClick={goToPrev}
            disabled={activeLessonIdx === 0}
            title="Previous lesson"
            style={{
              display: 'flex', alignItems: 'center', gap: '0.4rem',
              background: 'var(--surface)', border: '1.5px solid var(--line)',
              color: activeLessonIdx === 0 ? 'var(--text-muted)' : 'var(--cream)',
              borderRadius: 10, padding: '0.5rem 0.875rem', fontSize: '0.82rem', fontWeight: 600,
              cursor: activeLessonIdx === 0 ? 'not-allowed' : 'pointer',
              opacity: activeLessonIdx === 0 ? 0.4 : 1, flexShrink: 0,
            }}
          >
            ← Prev
          </button>

          {/* Lesson progress indicator */}
          <div style={{ flex: 1, minWidth: 0, display: 'flex', flexDirection: 'column', gap: '0.3rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)', fontWeight: 600 }}>
                Lesson {activeLessonIdx + 1} of {lessons.length}
              </span>
              {isCurrentDone && <span style={{ fontSize: '0.65rem', color: 'var(--success)', fontWeight: 700 }}>✓ Complete</span>}
            </div>
            <div style={{ height: 4, background: 'var(--line)', borderRadius: 99, overflow: 'hidden' }}>
              <motion.div
                animate={{ width: `${((activeLessonIdx + (isCurrentDone ? 1 : 0)) / lessons.length) * 100}%` }}
                transition={{ duration: 0.4 }}
                style={{ height: '100%', background: 'var(--green)', borderRadius: 99 }}
              />
            </div>
          </div>

          {/* Primary CTA — mark done or go to quiz */}
          <div style={{ position: 'relative', flexShrink: 0 }}>
            <AnimatePresence>
              {xpFloat && (
                <motion.div
                  initial={{ opacity: 1, y: 0 }} animate={{ opacity: 0, y: -40 }} transition={{ duration: 1 }}
                  style={{ position: 'absolute', top: -32, left: '50%', transform: 'translateX(-50%)', color: 'var(--green)', fontWeight: 800, fontSize: '0.9rem', pointerEvents: 'none', whiteSpace: 'nowrap' }}
                >+10 XP ⭐</motion.div>
              )}
            </AnimatePresence>

            {allDone ? (
              <motion.button whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
                onClick={() => router.push(`/quiz/${module.id}`)}
                className="btn-primary"
                style={{ padding: '0.55rem 1.25rem', fontSize: '0.88rem', borderRadius: 10, display: 'flex', alignItems: 'center', gap: '0.4rem' }}
              >
                🧠 Take Quiz →
              </motion.button>
            ) : isCurrentDone ? (
              <motion.button whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.97 }}
                onClick={goToNext}
                className="btn-primary"
                style={{ padding: '0.55rem 1.25rem', fontSize: '0.88rem', borderRadius: 10, display: 'flex', alignItems: 'center', gap: '0.4rem' }}
              >
                Next Lesson →
              </motion.button>
            ) : (
              <motion.button whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
                onClick={markDone}
                disabled={marking}
                style={{
                  background: 'var(--green)', color: 'var(--btn-text)',
                  border: 'none', borderRadius: 10, padding: '0.55rem 1.25rem',
                  fontSize: '0.88rem', fontWeight: 700, cursor: 'pointer',
                  display: 'flex', alignItems: 'center', gap: '0.4rem',
                  opacity: marking ? 0.7 : 1,
                }}
              >
                {marking ? 'Saving…' : '✓ Mark Complete'}
              </motion.button>
            )}
          </div>

          {/* Next lesson */}
          <button
            onClick={goToNext}
            disabled={activeLessonIdx === lessons.length - 1}
            title="Next lesson"
            style={{
              display: 'flex', alignItems: 'center', gap: '0.4rem',
              background: 'var(--surface)', border: '1.5px solid var(--line)',
              color: activeLessonIdx === lessons.length - 1 ? 'var(--text-muted)' : 'var(--cream)',
              borderRadius: 10, padding: '0.5rem 0.875rem', fontSize: '0.82rem', fontWeight: 600,
              cursor: activeLessonIdx === lessons.length - 1 ? 'not-allowed' : 'pointer',
              opacity: activeLessonIdx === lessons.length - 1 ? 0.4 : 1, flexShrink: 0,
            }}
          >
            Next →
          </button>
        </div>
      </div>
    </>
  )
}
