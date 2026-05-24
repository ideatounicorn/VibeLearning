'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { ROLES, type RoleData, type RoadmapItem, type CarouselSlide } from '@/lib/roadmap-data'
import { supabase } from '@/lib/supabase'
import AuthModal from '@/components/AuthModal'
import { useRouter } from 'next/navigation'

type Stage = 'profile' | 'role' | 'story' | 'generating' | 'roadmap' | 'premium'

interface ProfileAnswers {
  userType: string
  goal: string
  hoursPerWeek: string
  heardFrom: string
}

const PROFILE_QUESTIONS = [
  {
    id: 'userType' as keyof ProfileAnswers,
    question: 'First things first — who are you?',
    sub: 'Helps us personalise your experience from day one.',
    options: [
      { value: 'student', emoji: '🎓', label: 'Student', sub: 'Currently studying' },
      { value: 'professional', emoji: '💼', label: 'Working Professional', sub: 'Employed, looking to upskill' },
      { value: 'career-switch', emoji: '🔄', label: 'Career Switcher', sub: 'Moving into a new field' },
      { value: 'exploring', emoji: '🔍', label: 'Just Exploring', sub: "Curious about what's possible" },
    ],
  },
  {
    id: 'goal' as keyof ProfileAnswers,
    question: "What's your main goal?",
    sub: "We'll prioritise content that gets you there fastest.",
    options: [
      { value: 'get-hired', emoji: '🚀', label: 'Get hired in tech', sub: 'Land a role in 6–12 months' },
      { value: 'upskill', emoji: '📈', label: 'Level up at work', sub: 'Grow in your current role' },
      { value: 'freelance', emoji: '💻', label: 'Go freelance', sub: 'Build an independent income' },
      { value: 'curiosity', emoji: '🧠', label: 'Learn for curiosity', sub: 'No pressure, just growth' },
    ],
  },
  {
    id: 'hoursPerWeek' as keyof ProfileAnswers,
    question: 'How much time can you invest each week?',
    sub: "We'll set milestones you can actually hit.",
    options: [
      { value: '1-2h', emoji: '⚡', label: '1–2 hours', sub: 'About 15 minutes a day' },
      { value: '3-5h', emoji: '🔥', label: '3–5 hours', sub: '30–45 minutes daily' },
      { value: '5-10h', emoji: '💪', label: '5–10 hours', sub: 'An hour or more a day' },
      { value: '10h+', emoji: '🚀', label: '10+ hours', sub: 'Full throttle — rapid results' },
    ],
  },
  {
    id: 'heardFrom' as keyof ProfileAnswers,
    question: 'How did you find VibeLearn?',
    sub: 'Helps us reach more learners like you.',
    options: [
      { value: 'social', emoji: '📱', label: 'Social Media', sub: 'Instagram, TikTok, X/Twitter' },
      { value: 'friend', emoji: '👥', label: 'Friend or Colleague', sub: 'Word of mouth' },
      { value: 'google', emoji: '🔍', label: 'Google Search', sub: 'Found us organically' },
      { value: 'ad', emoji: '🎯', label: 'Online Ad', sub: 'Paid or promoted content' },
    ],
  },
]

const GENERATING_TEXTS = [
  'Analysing your goals…',
  'Mapping your career path…',
  'Sequencing your learning…',
  'Adding real-world projects…',
  'Your roadmap is ready.',
]

const PREMIUM_FEATURES = [
  { emoji: '🗺️', text: 'Full roadmap access — all milestones unlocked' },
  { emoji: '🎬', text: '20+ curated video courses with expert instructors' },
  { emoji: '🛠️', text: 'Real-world projects with detailed feedback' },
  { emoji: '🏆', text: 'Official completion certificate for your profile' },
  { emoji: '💬', text: 'Private Slack community — 500+ active learners' },
  { emoji: '📚', text: '2+ bonus communication & soft-skill courses' },
  { emoji: '⚡', text: 'Priority Q&A support from instructors' },
]

const TYPE_COLORS: Record<string, string> = {
  course: 'var(--green)',
  assessment: 'var(--amber)',
  project: 'var(--violet)',
  graduation: 'var(--cream)',
}

function getProgress(
  stage: Stage,
  profileStep: number,
  slideIndex: number,
  totalSlides: number,
) {
  if (stage === 'profile') return 4 + profileStep * 6
  if (stage === 'role') return 28
  if (stage === 'story') return 36 + (slideIndex / Math.max(1, totalSlides - 1)) * 26
  if (stage === 'generating') return 68
  if (stage === 'roadmap') return 82
  if (stage === 'premium') return 95
  return 0
}

// ── Story slide renderer (full-screen) ───────────────────────────────
function StorySlide({ slide, role }: { slide: CarouselSlide; role: RoleData }) {
  if (slide.type === 'prose') {
    return (
      <div style={{ maxWidth: 780 }}>
        <p style={{
          fontSize: '0.8rem',
          fontWeight: 700,
          color: role.color,
          letterSpacing: '0.12em',
          textTransform: 'uppercase',
          marginBottom: '1.5rem',
        }}>
          Day in the Life
        </p>
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: 'clamp(1.8rem, 4vw, 3rem)',
          color: 'var(--cream)',
          marginBottom: '2rem',
          lineHeight: 1.2,
        }}>
          {slide.title}
        </h2>
        <p style={{
          fontSize: 'clamp(1.05rem, 2vw, 1.25rem)',
          color: 'var(--muted)',
          lineHeight: 1.85,
          borderLeft: `3px solid ${role.color}`,
          paddingLeft: '1.5rem',
        }}>
          {slide.content as string}
        </p>
      </div>
    )
  }

  if (slide.type === 'checklist') {
    return (
      <div style={{ maxWidth: 780 }}>
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: 'clamp(1.6rem, 4vw, 2.6rem)',
          color: 'var(--cream)',
          marginBottom: '2.5rem',
        }}>
          {slide.title}
        </h2>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.1rem' }}>
          {(slide.content as string[]).map((skill, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: i * 0.07 }}
              style={{ display: 'flex', alignItems: 'center', gap: '1.25rem' }}
            >
              <span style={{
                fontFamily: 'var(--font-serif)',
                fontSize: 'clamp(2rem, 4vw, 3.2rem)',
                fontWeight: 700,
                color: role.color,
                opacity: 0.3,
                lineHeight: 1,
                minWidth: 68,
                textAlign: 'right',
                flexShrink: 0,
              }}>
                {String(i + 1).padStart(2, '0')}
              </span>
              <span style={{
                fontSize: 'clamp(0.95rem, 2vw, 1.15rem)',
                color: 'var(--cream)',
                fontWeight: 500,
                lineHeight: 1.4,
              }}>
                {skill}
              </span>
            </motion.div>
          ))}
        </div>
      </div>
    )
  }

  if (slide.type === 'hierarchy') {
    return (
      <div style={{ maxWidth: 680 }}>
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: 'clamp(1.6rem, 4vw, 2.6rem)',
          color: 'var(--cream)',
          marginBottom: '2.5rem',
        }}>
          {slide.title}
        </h2>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
          {slide.hierarchy!.map((level: any, i: number, arr: any[]) => {
            const isTop = i === arr.length - 1
            return (
              <motion.div
                key={i}
                initial={{ opacity: 0, y: 16 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.1 }}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  padding: '1.25rem 1.5rem',
                  background: isTop ? `${role.color}14` : 'var(--dim)',
                  border: `1.5px solid ${isTop ? role.color + '55' : 'var(--line)'}`,
                  borderRadius: 14,
                }}
              >
                <div>
                  <div style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--cream)' }}>{level.title}</div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--muted)', marginTop: '0.2rem' }}>{level.years}</div>
                </div>
                <div style={{
                  fontSize: '1.15rem',
                  fontWeight: 700,
                  color: i === 0 ? 'var(--muted)' : isTop ? role.color : 'var(--amber)',
                }}>
                  {level.salary}
                </div>
              </motion.div>
            )
          })}
        </div>
      </div>
    )
  }

  if (slide.type === 'tools') {
    return (
      <div style={{ maxWidth: 780 }}>
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: 'clamp(1.6rem, 4vw, 2.6rem)',
          color: 'var(--cream)',
          marginBottom: '0.75rem',
        }}>
          {slide.title}
        </h2>
        <p style={{ color: 'var(--muted)', fontSize: '1.05rem', marginBottom: '2.5rem' }}>
          Tools you&apos;ll use every day — and master completely.
        </p>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.75rem' }}>
          {slide.tools!.map((tool: any, i: number) => (
            <motion.span
              key={i}
              initial={{ opacity: 0, scale: 0.85 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: i * 0.05 }}
              style={{
                padding: '0.65rem 1.35rem',
                background: 'var(--dim)',
                border: '1px solid var(--line)',
                borderRadius: 999,
                fontSize: 'clamp(0.9rem, 1.5vw, 1.05rem)',
                color: 'var(--cream)',
                fontWeight: 500,
              }}
            >
              {tool}
            </motion.span>
          ))}
          <motion.span
            initial={{ opacity: 0, scale: 0.85 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: slide.tools!.length * 0.05 }}
            style={{
              padding: '0.65rem 1.35rem',
              background: `${role.color}14`,
              border: `1px solid ${role.color}44`,
              borderRadius: 999,
              fontSize: 'clamp(0.9rem, 1.5vw, 1.05rem)',
              color: role.color,
              fontWeight: 700,
            }}
          >
            + 20 more tools
          </motion.span>
        </div>
      </div>
    )
  }

  return null
}

function parseLearnings(description: string): string[] {
  return description
    .replace(/—/g, ',')
    .split(/,\s+/)
    .flatMap(chunk => chunk.split(/\s+and\s+(?=[a-z])/))
    .map(s => s.trim().replace(/\.$/, '').replace(/^[a-z]/, c => c.toUpperCase()))
    .filter(s => s.length > 8)
    .slice(0, 4)
}

// ── Roadmap detail panel ──────────────────────────────────────────────
function RoadmapDetailPanel({
  item,
  roleColor,
  roleLabel,
}: {
  item: RoadmapItem
  roleColor: string
  roleLabel: string
}) {
  const color = TYPE_COLORS[item.type] ?? roleColor

  const TagBadge = () => (
    <div style={{
      display: 'inline-flex',
      alignItems: 'center',
      gap: '0.4rem',
      background: `${color}14`,
      border: `1px solid ${color}44`,
      borderRadius: 999,
      padding: '0.3rem 0.9rem',
      fontSize: '0.75rem',
      fontWeight: 700,
      color,
      textTransform: 'uppercase' as const,
      letterSpacing: '0.08em',
      marginBottom: '1.5rem',
    }}>
      {item.emoji} {item.tag}
    </div>
  )

  const WhyBlock = () => (
    <div style={{
      background: `${color}08`,
      border: `1px solid ${color}22`,
      borderRadius: 12,
      padding: '1rem 1.25rem',
      fontSize: '0.9rem',
      color: 'var(--muted)',
      fontStyle: 'italic',
      lineHeight: 1.6,
    }}>
      <strong style={{ color: 'var(--cream)', fontStyle: 'normal' }}>Why this matters: </strong>
      {item.why}
    </div>
  )

  if (item.type === 'graduation') {
    return (
      <div style={{ textAlign: 'center', paddingTop: '3rem' }}>
        <div style={{ fontSize: '4rem', marginBottom: '1.5rem' }}>{item.emoji}</div>
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: '2rem',
          color: 'var(--cream)',
          marginBottom: '1rem',
        }}>
          {item.title}
        </h2>
        <p style={{
          color: 'var(--muted)',
          fontSize: '1rem',
          lineHeight: 1.7,
          maxWidth: 380,
          margin: '0 auto 2.5rem',
        }}>
          {item.description}
        </p>
        <div style={{
          background: 'var(--dim)',
          border: '2px solid var(--cream)',
          borderRadius: 18,
          padding: '2rem',
          maxWidth: 300,
          margin: '0 auto',
        }}>
          <div style={{ fontSize: '2.5rem', marginBottom: '0.75rem' }}>🏆</div>
          <div style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.3rem' }}>
            Official Certificate
          </div>
          <div style={{ fontSize: '0.85rem', color: 'var(--muted)' }}>
            {roleLabel} — VibeLearn
          </div>
        </div>
      </div>
    )
  }

  if (item.type === 'assessment') {
    return (
      <div>
        <TagBadge />
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: 'clamp(1.3rem, 2.5vw, 2rem)',
          color: 'var(--cream)',
          marginBottom: '0.75rem',
          lineHeight: 1.3,
        }}>
          {item.title}
        </h2>
        <p style={{ color: 'var(--muted)', fontSize: '1rem', lineHeight: 1.7, marginBottom: '2rem' }}>
          {item.description}
        </p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginBottom: '2rem' }}>
          {[
            { icon: '⏱️', label: 'Duration', value: '60 minutes, timed assessment' },
            { icon: '📊', label: 'Format', value: 'Multiple choice + real-world scenario questions' },
            { icon: '📋', label: 'After completion', value: 'Detailed score report + personalised feedback' },
            { icon: '🔓', label: 'Unlocks', value: 'Next stage of your learning roadmap' },
          ].map((row, i) => (
            <div key={i} style={{
              display: 'flex',
              gap: '1rem',
              padding: '1rem',
              background: 'var(--dim)',
              border: '1px solid var(--line)',
              borderRadius: 12,
            }}>
              <span style={{ fontSize: '1.2rem', flexShrink: 0, marginTop: '0.1rem' }}>{row.icon}</span>
              <div>
                <div style={{ fontSize: '0.72rem', fontWeight: 700, color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: '0.2rem' }}>
                  {row.label}
                </div>
                <div style={{ fontSize: '0.92rem', color: 'var(--cream)' }}>{row.value}</div>
              </div>
            </div>
          ))}
        </div>
        <WhyBlock />
      </div>
    )
  }

  if (item.type === 'project') {
    return (
      <div>
        <TagBadge />
        <h2 style={{
          fontFamily: 'var(--font-serif)',
          fontSize: 'clamp(1.3rem, 2.5vw, 2rem)',
          color: 'var(--cream)',
          marginBottom: '0.75rem',
          lineHeight: 1.3,
        }}>
          {item.title}
        </h2>
        <p style={{ color: 'var(--muted)', fontSize: '1rem', lineHeight: 1.7, marginBottom: '2rem' }}>
          {item.description}
        </p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginBottom: '2rem' }}>
          {[
            { icon: '🎯', label: 'Type', value: 'Real-world, portfolio-quality project' },
            { icon: '🛠️', label: "What you'll build", value: item.description },
            { icon: '📁', label: 'Portfolio impact', value: 'Goes directly into your professional portfolio' },
            { icon: '✅', label: 'Review', value: 'Automated review + instructor feedback' },
          ].map((row, i) => (
            <div key={i} style={{
              display: 'flex',
              gap: '1rem',
              padding: '1rem',
              background: 'var(--dim)',
              border: '1px solid var(--line)',
              borderRadius: 12,
            }}>
              <span style={{ fontSize: '1.2rem', flexShrink: 0, marginTop: '0.1rem' }}>{row.icon}</span>
              <div>
                <div style={{ fontSize: '0.72rem', fontWeight: 700, color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.07em', marginBottom: '0.2rem' }}>
                  {row.label}
                </div>
                <div style={{ fontSize: '0.92rem', color: 'var(--cream)' }}>{row.value}</div>
              </div>
            </div>
          ))}
        </div>
        <WhyBlock />
      </div>
    )
  }

  // Course (default)
  const learnings = parseLearnings(item.description)
  return (
    <div>
      {/* Badges row */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', flexWrap: 'wrap', marginBottom: '1.5rem' }}>
        <div style={{
          display: 'inline-flex',
          alignItems: 'center',
          gap: '0.4rem',
          background: `${color}14`,
          border: `1px solid ${color}44`,
          borderRadius: 999,
          padding: '0.3rem 0.9rem',
          fontSize: '0.75rem',
          fontWeight: 700,
          color,
          textTransform: 'uppercase' as const,
          letterSpacing: '0.08em',
        }}>
          {item.emoji} {item.tag}
        </div>
        {item.isFree && (
          <div style={{
            display: 'inline-flex',
            background: 'rgba(200,255,0,0.1)',
            border: '1px solid rgba(200,255,0,0.3)',
            borderRadius: 999,
            padding: '0.3rem 0.7rem',
            fontSize: '0.72rem',
            fontWeight: 700,
            color: 'var(--green)',
          }}>
            FREE
          </div>
        )}
      </div>

      <h2 style={{
        fontFamily: 'var(--font-serif)',
        fontSize: 'clamp(1.3rem, 2.5vw, 2rem)',
        color: 'var(--cream)',
        marginBottom: '0.75rem',
        lineHeight: 1.3,
      }}>
        {item.title}
      </h2>
      <p style={{ color: 'var(--muted)', fontSize: '1rem', lineHeight: 1.7, marginBottom: '2rem' }}>
        {item.description}
      </p>

      {/* What you'll learn */}
      <div style={{ marginBottom: '2rem' }}>
        <div style={{
          fontSize: '0.72rem',
          fontWeight: 700,
          color: 'var(--muted)',
          textTransform: 'uppercase',
          letterSpacing: '0.09em',
          marginBottom: '0.85rem',
        }}>
          What you&apos;ll learn
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
          {learnings.map((point, i) => (
            <div key={i} style={{ display: 'flex', alignItems: 'flex-start', gap: '0.75rem' }}>
              <span style={{
                width: 22,
                height: 22,
                borderRadius: '50%',
                background: `${color}18`,
                border: `1.5px solid ${color}44`,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '0.6rem',
                color,
                flexShrink: 0,
                marginTop: '0.1rem',
                fontWeight: 700,
              }}>
                ✓
              </span>
              <span style={{ fontSize: '0.92rem', color: 'var(--cream)', lineHeight: 1.5 }}>
                {point}
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Course stats */}
      <div style={{ display: 'flex', gap: '0.6rem', flexWrap: 'wrap', marginBottom: '2rem' }}>
        {[
          { icon: '🎬', text: '8 video lessons' },
          { icon: '📝', text: '3 quizzes' },
          { icon: '🎯', text: '1 exercise' },
        ].map((s, i) => (
          <div key={i} style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.4rem',
            padding: '0.45rem 1rem',
            background: 'var(--dim)',
            border: '1px solid var(--line)',
            borderRadius: 999,
            fontSize: '0.82rem',
            color: 'var(--muted)',
          }}>
            {s.icon} {s.text}
          </div>
        ))}
      </div>

      <WhyBlock />
    </div>
  )
}

// ── Main component ────────────────────────────────────────────────────
export default function OnboardingPage() {
  const router = useRouter()
  const [stage, setStage] = useState<Stage>('profile')
  const [profileStep, setProfileStep] = useState(0)
  const [profileAnswers, setProfileAnswers] = useState<Partial<ProfileAnswers>>({})
  const [selectedRole, setSelectedRole] = useState<RoleData | null>(null)
  const [slideIndex, setSlideIndex] = useState(0)
  const [slideDir, setSlideDir] = useState<1 | -1>(1)
  const [genText, setGenText] = useState(GENERATING_TEXTS[0])
  const [selectedItemIdx, setSelectedItemIdx] = useState(0)
  const [roadmapItemIdx, setRoadmapItemIdx] = useState(0)
  const [showAuth, setShowAuth] = useState(false)
  const [authMode, setAuthMode] = useState<'free' | 'trial'>('free')
  const db = supabase()

  useEffect(() => {
    if (stage !== 'generating') return
    let i = 0
    const t = setInterval(() => {
      i++
      if (i < GENERATING_TEXTS.length) setGenText(GENERATING_TEXTS[i])
      else { clearInterval(t); setStage('roadmap') }
    }, 900)
    return () => clearInterval(t)
  }, [stage])

  const handleProfileSelect = (value: string) => {
    const q = PROFILE_QUESTIONS[profileStep]
    setProfileAnswers(prev => ({ ...prev, [q.id]: value }))
    setTimeout(() => {
      if (profileStep < PROFILE_QUESTIONS.length - 1) setProfileStep(p => p + 1)
      else setStage('role')
    }, 220)
  }

  const handleRoleSelect = (role: RoleData) => {
    setSelectedRole(role)
    setSlideIndex(0)
    setStage('story')
  }

  const goSlide = (dir: 1 | -1) => {
    if (!selectedRole) return
    const next = slideIndex + dir
    if (next < 0 || next >= selectedRole.carousel.length) return
    setSlideDir(dir)
    setSlideIndex(next)
  }

  const startGenerating = () => {
    setGenText(GENERATING_TEXTS[0])
    setStage('generating')
  }

  // Saves onboarding, enrolls user in path + all courses, returns first course slug
  const saveOnboardingAndEnroll = async (userId: string): Promise<string | null> => {
    if (!selectedRole) return null

    // Fetch path FIRST so we can include selected_path_id in the profile update
    const { data: path } = await db
      .from('paths')
      .select('id')
      .eq('slug', selectedRole.pathSlug)
      .single()

    if (!path) return null

    await Promise.all([
      db.from('onboarding_responses').upsert({
        user_id: userId,
        career_goal: selectedRole.id,
        recommended_path_slug: selectedRole.pathSlug,
      }),
      db.from('profiles').update({
        career_goal: selectedRole.id,
        onboarding_completed: true,
        selected_path_id: path.id,
      }).eq('id', userId),
    ])

    // Enroll in path + all its courses
    try {
      await fetch('/api/enroll/path', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ pathId: path.id }),
      })
    } catch {
      // Non-blocking — enroll failure shouldn't break navigation
    }

    // Fetch first course slug for direct navigation
    const { data: firstCourse } = await db
      .from('courses')
      .select('slug')
      .eq('path_id', path.id)
      .eq('is_hidden', false)
      .order('order_index', { ascending: true })
      .limit(1)
      .single()

    return firstCourse?.slug ?? null
  }

  const handleStart = async (trial: boolean) => {
    const { data: { user } } = await db.auth.getUser()
    if (!user) {
      setAuthMode(trial ? 'trial' : 'free')
      setShowAuth(true)
      return
    }
    const firstCourseSlug = await saveOnboardingAndEnroll(user.id)
    localStorage.setItem('vl_fresh_onboard', '1')
    if (trial) {
      const next = firstCourseSlug ? `/course-intro/${firstCourseSlug}` : '/dashboard'
      router.push(`/upgrade?trial=true&from=onboarding&next=${encodeURIComponent(next)}`)
    } else {
      router.push(firstCourseSlug ? `/course-intro/${firstCourseSlug}` : `/paths/${selectedRole!.pathSlug}`)
    }
  }

  const handleAuthSuccess = async () => {
    setShowAuth(false)
    const { data: { user } } = await db.auth.getUser()
    if (!user || !selectedRole) return
    const firstCourseSlug = await saveOnboardingAndEnroll(user.id)
    localStorage.setItem('vl_fresh_onboard', '1')
    if (authMode === 'trial') {
      const next = firstCourseSlug ? `/course-intro/${firstCourseSlug}` : '/dashboard'
      router.push(`/upgrade?trial=true&from=onboarding&next=${encodeURIComponent(next)}`)
    } else {
      router.push(firstCourseSlug ? `/course-intro/${firstCourseSlug}` : `/paths/${selectedRole.pathSlug}`)
    }
  }

  const totalSlides = selectedRole?.carousel.length ?? 5
  const progress = getProgress(stage, profileStep, slideIndex, totalSlides)

  return (
    <div style={{
      minHeight: '100vh',
      background: 'var(--ink)',
      position: 'relative',
      overflowX: 'hidden',
    }}>
      {/* Progress bar */}
      <div style={{
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
        height: 3,
        background: 'rgba(255,255,255,0.06)',
        zIndex: 200,
      }}>
        <motion.div
          style={{ height: '100%', background: 'var(--green)' }}
          animate={{ width: `${progress}%` }}
          transition={{ duration: 0.5, ease: 'easeOut' }}
        />
      </div>

      <AnimatePresence mode="wait">

        {/* ─── PROFILE QUESTIONS ─────────────────────────────────────────── */}
        {stage === 'profile' && (
          <motion.div
            key="profile-stage"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0, x: -40 }}
            style={{
              minHeight: '100vh',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              padding: '4rem 1.5rem 2rem',
            }}
          >
            <AnimatePresence mode="wait">
              <motion.div
                key={profileStep}
                initial={{ opacity: 0, x: 40 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -40 }}
                transition={{ duration: 0.28 }}
                style={{ maxWidth: 620, width: '100%' }}
              >
                <div style={{ textAlign: 'center', marginBottom: '2.75rem' }}>
                  <div style={{
                    fontSize: '0.75rem',
                    color: 'var(--muted)',
                    letterSpacing: '0.1em',
                    textTransform: 'uppercase',
                    marginBottom: '1.25rem',
                  }}>
                    {profileStep + 1} of {PROFILE_QUESTIONS.length}
                  </div>
                  <h1 style={{
                    fontFamily: 'var(--font-serif)',
                    fontSize: 'clamp(1.7rem, 4vw, 2.6rem)',
                    color: 'var(--cream)',
                    marginBottom: '0.65rem',
                    lineHeight: 1.2,
                  }}>
                    {PROFILE_QUESTIONS[profileStep].question}
                  </h1>
                  <p style={{ color: 'var(--muted)', fontSize: '1rem' }}>
                    {PROFILE_QUESTIONS[profileStep].sub}
                  </p>
                </div>

                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(2, 1fr)',
                  gap: '0.85rem',
                }}>
                  {PROFILE_QUESTIONS[profileStep].options.map(opt => (
                    <button
                      key={opt.value}
                      onClick={() => handleProfileSelect(opt.value)}
                      style={{
                        background: 'var(--dim)',
                        border: '1.5px solid var(--line)',
                        borderRadius: 18,
                        padding: '1.5rem',
                        cursor: 'pointer',
                        textAlign: 'left',
                        transition: 'all 0.15s',
                      }}
                      onMouseEnter={e => {
                        e.currentTarget.style.borderColor = 'var(--green)'
                        e.currentTarget.style.background = 'rgba(200,255,0,0.05)'
                        e.currentTarget.style.transform = 'translateY(-2px)'
                      }}
                      onMouseLeave={e => {
                        e.currentTarget.style.borderColor = 'var(--line)'
                        e.currentTarget.style.background = 'var(--dim)'
                        e.currentTarget.style.transform = 'translateY(0)'
                      }}
                    >
                      <div style={{ fontSize: '2.2rem', marginBottom: '0.85rem' }}>{opt.emoji}</div>
                      <div style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.3rem' }}>
                        {opt.label}
                      </div>
                      <div style={{ fontSize: '0.85rem', color: 'var(--muted)', lineHeight: 1.4 }}>
                        {opt.sub}
                      </div>
                    </button>
                  ))}
                </div>

                {profileStep > 0 && (
                  <div style={{ textAlign: 'center', marginTop: '1.5rem' }}>
                    <button
                      onClick={() => setProfileStep(p => p - 1)}
                      style={{
                        background: 'none',
                        border: 'none',
                        color: 'var(--muted)',
                        cursor: 'pointer',
                        fontSize: '0.85rem',
                      }}
                    >
                      ← Back
                    </button>
                  </div>
                )}
              </motion.div>
            </AnimatePresence>
          </motion.div>
        )}

        {/* ─── ROLE SELECTION ────────────────────────────────────────────── */}
        {stage === 'role' && (
          <motion.div
            key="role"
            initial={{ opacity: 0, x: 40 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -40 }}
            transition={{ duration: 0.32 }}
            style={{
              minHeight: '100vh',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              justifyContent: 'center',
              padding: '4rem 1.5rem 3rem',
            }}
          >
            <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
              <h1 style={{
                fontFamily: 'var(--font-serif)',
                fontSize: 'clamp(2rem, 5vw, 3.2rem)',
                color: 'var(--cream)',
                marginBottom: '0.75rem',
              }}>
                Choose your career path
              </h1>
              <p style={{ color: 'var(--muted)', fontSize: '1.05rem', maxWidth: 460, margin: '0 auto' }}>
                Pick the role that excites you most. We&apos;ll show you exactly how to get there.
              </p>
            </div>

            <div style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fill, minmax(230px, 1fr))',
              gap: '1rem',
              maxWidth: 900,
              width: '100%',
            }}>
              {ROLES.map((role: any) => (
                <button
                  key={role.id}
                  onClick={() => handleRoleSelect(role)}
                  style={{
                    background: 'var(--dim)',
                    border: '2px solid var(--line)',
                    borderRadius: 20,
                    padding: '2rem 1.5rem',
                    cursor: 'pointer',
                    textAlign: 'left',
                    transition: 'all 0.2s',
                  }}
                  onMouseEnter={e => {
                    e.currentTarget.style.borderColor = role.color
                    e.currentTarget.style.background = `${role.color}0d`
                    e.currentTarget.style.transform = 'translateY(-4px)'
                    e.currentTarget.style.boxShadow = `0 16px 40px ${role.color}22`
                  }}
                  onMouseLeave={e => {
                    e.currentTarget.style.borderColor = 'var(--line)'
                    e.currentTarget.style.background = 'var(--dim)'
                    e.currentTarget.style.transform = 'translateY(0)'
                    e.currentTarget.style.boxShadow = 'none'
                  }}
                >
                  <div style={{ fontSize: '3rem', marginBottom: '1.25rem' }}>{role.emoji}</div>
                  <div style={{ fontSize: '1.1rem', fontWeight: 700, color: 'var(--cream)', marginBottom: '0.5rem' }}>
                    {role.label}
                  </div>
                  <div style={{ fontSize: '0.875rem', color: 'var(--muted)', lineHeight: 1.55, whiteSpace: 'pre-line' }}>
                    {role.tagline}
                  </div>
                  <div style={{
                    marginTop: '1.25rem',
                    fontSize: '0.8rem',
                    fontWeight: 600,
                    color: role.color,
                  }}>
                    Explore path →
                  </div>
                </button>
              ))}
            </div>

            <button
              onClick={() => setStage('profile')}
              style={{
                background: 'none',
                border: 'none',
                color: 'var(--muted)',
                cursor: 'pointer',
                fontSize: '0.85rem',
                marginTop: '2rem',
              }}
            >
              ← Back
            </button>
          </motion.div>
        )}

        {/* ─── STORY CAROUSEL (full-screen immersive) ────────────────────── */}
        {stage === 'story' && selectedRole && (
          <motion.div
            key="story"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            style={{
              minHeight: '100vh',
              display: 'flex',
              flexDirection: 'column',
              position: 'relative',
              overflow: 'hidden',
            }}
          >

            {/* Ambient glow */}
            <div style={{
              position: 'absolute',
              top: -300,
              right: -300,
              width: 700,
              height: 700,
              borderRadius: '50%',
              background: `radial-gradient(circle, ${selectedRole.color}16 0%, transparent 70%)`,
              pointerEvents: 'none',
              zIndex: 0,
            }} />
            <div style={{
              position: 'absolute',
              bottom: -200,
              left: -200,
              width: 500,
              height: 500,
              borderRadius: '50%',
              background: `radial-gradient(circle, ${selectedRole.color}08 0%, transparent 70%)`,
              pointerEvents: 'none',
              zIndex: 0,
            }} />

            {/* Header bar */}
            <div style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              padding: '1.5rem 2rem',
              position: 'relative',
              zIndex: 2,
            }}>
              <button
                onClick={() => setStage('role')}
                style={{ background: 'none', border: 'none', color: 'var(--muted)', cursor: 'pointer', fontSize: '0.85rem' }}
              >
                ← Change role
              </button>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
                background: `${selectedRole.color}18`,
                border: `1px solid ${selectedRole.color}44`,
                borderRadius: 999,
                padding: '0.35rem 1rem',
                fontSize: '0.85rem',
                color: selectedRole.color,
                fontWeight: 600,
              }}>
                {selectedRole.emoji} {selectedRole.label}
              </div>
              <button
                onClick={startGenerating}
                style={{ background: 'none', border: 'none', color: 'var(--muted)', cursor: 'pointer', fontSize: '0.85rem' }}
              >
                Skip →
              </button>
            </div>

            {/* Slide area */}
            <div style={{
              flex: 1,
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              padding: 'clamp(1rem, 5vw, 3rem)',
              overflow: 'hidden',
              position: 'relative',
              zIndex: 2,
            }}>
              <AnimatePresence mode="wait">
                <motion.div
                  key={slideIndex}
                  initial={{ opacity: 0, x: slideDir * 60 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: slideDir * -60 }}
                  transition={{ duration: 0.28 }}
                  style={{ width: '100%' }}
                >
                  <StorySlide slide={selectedRole.carousel[slideIndex]} role={selectedRole} />
                </motion.div>
              </AnimatePresence>
            </div>

            {/* Bottom nav */}
            <div style={{
              padding: '2rem 2.5rem 3rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              position: 'relative',
              zIndex: 2,
            }}>
              <button
                onClick={() => goSlide(-1)}
                disabled={slideIndex === 0}
                style={{
                  background: 'none',
                  border: '1px solid var(--line)',
                  borderRadius: 999,
                  padding: '0.6rem 1.35rem',
                  color: slideIndex === 0 ? 'var(--line)' : 'var(--cream)',
                  cursor: slideIndex === 0 ? 'default' : 'pointer',
                  fontSize: '0.9rem',
                }}
              >
                ← Prev
              </button>

              <div style={{ display: 'flex', gap: '0.5rem' }}>
                {selectedRole.carousel.map((_: any, i: number) => (
                  <button
                    key={i}
                    onClick={() => { setSlideDir(i > slideIndex ? 1 : -1); setSlideIndex(i) }}
                    style={{
                      width: i === slideIndex ? 28 : 8,
                      height: 8,
                      borderRadius: 999,
                      background: i === slideIndex ? selectedRole.color : 'var(--line)',
                      border: 'none',
                      cursor: 'pointer',
                      padding: 0,
                      transition: 'all 0.2s',
                    }}
                  />
                ))}
              </div>

              {slideIndex < selectedRole.carousel.length - 1 ? (
                <button
                  onClick={() => goSlide(1)}
                  style={{
                    background: selectedRole.color,
                    border: 'none',
                    borderRadius: 999,
                    padding: '0.65rem 1.6rem',
                    color: 'var(--ink)',
                    cursor: 'pointer',
                    fontSize: '0.92rem',
                    fontWeight: 700,
                  }}
                >
                  Next →
                </button>
              ) : (
                <button
                  onClick={startGenerating}
                  style={{
                    background: 'var(--green)',
                    border: 'none',
                    borderRadius: 999,
                    padding: '0.65rem 1.6rem',
                    color: 'var(--ink)',
                    cursor: 'pointer',
                    fontSize: '0.92rem',
                    fontWeight: 700,
                  }}
                >
                  Build My Roadmap →
                </button>
              )}
            </div>
          </motion.div>
        )}

        {/* ─── GENERATING ANIMATION ──────────────────────────────────────── */}
        {stage === 'generating' && (
          <motion.div
            key="generating"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            style={{
              minHeight: '100vh',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '3rem',
            }}
          >
            {/* Animated node graph */}
            <div style={{ position: 'relative', width: 140, height: 140 }}>
              <svg style={{ position: 'absolute', inset: 0, width: '100%', height: '100%' }}>
                {[
                  [70, 20, 40, 60],
                  [70, 20, 100, 60],
                  [40, 60, 25, 100],
                  [40, 60, 70, 100],
                  [100, 60, 115, 100],
                ].map(([x1, y1, x2, y2], i) => (
                  <motion.line
                    key={i}
                    x1={x1} y1={y1} x2={x2} y2={y2}
                    stroke="var(--line)"
                    strokeWidth={1.5}
                    strokeDasharray="4 4"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: i * 0.15 + 0.2 }}
                  />
                ))}
              </svg>
              {[
                { x: 59, y: 9, color: 'var(--green)' },
                { x: 29, y: 49, color: 'var(--amber)' },
                { x: 89, y: 49, color: 'var(--violet)' },
                { x: 14, y: 89, color: 'var(--green)' },
                { x: 59, y: 89, color: 'var(--amber)' },
                { x: 104, y: 89, color: 'var(--cream)' },
              ].map((node, i) => (
                <motion.div
                  key={i}
                  initial={{ scale: 0, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  transition={{ delay: i * 0.12, type: 'spring', stiffness: 400 }}
                  style={{
                    position: 'absolute',
                    width: 22,
                    height: 22,
                    borderRadius: '50%',
                    background: node.color,
                    left: node.x,
                    top: node.y,
                  }}
                />
              ))}
            </div>

            <AnimatePresence mode="wait">
              <motion.p
                key={genText}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -10 }}
                transition={{ duration: 0.3 }}
                style={{
                  fontFamily: 'var(--font-serif)',
                  fontSize: 'clamp(1.3rem, 3vw, 1.9rem)',
                  color: 'var(--cream)',
                  fontStyle: 'italic',
                  textAlign: 'center',
                }}
              >
                {genText}
              </motion.p>
            </AnimatePresence>
          </motion.div>
        )}

        {/* ─── ROADMAP ONE-AT-A-TIME ─────────────────────────────────────── */}
        {stage === 'roadmap' && selectedRole && (
          <motion.div
            key="roadmap"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.4 }}
            style={{
              height: '100vh',
              overflow: 'hidden',
              display: 'flex',
              flexDirection: 'column',
            }}
          >
            {/* Header */}
            <div style={{
              padding: '1.25rem 2rem',
              borderBottom: '1px solid var(--line)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              background: 'var(--ink)',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <span style={{ fontSize: '1.5rem' }}>{selectedRole.emoji}</span>
                <div>
                  <h2 style={{
                    fontFamily: 'var(--font-serif)',
                    fontSize: '1.35rem',
                    color: 'var(--cream)',
                  }}>
                    Your path to {selectedRole.goalTitle}
                  </h2>
                  <p style={{ fontSize: '0.82rem', color: 'var(--muted)', marginTop: '0.15rem' }}>
                    Stage {roadmapItemIdx + 1} of {selectedRole.roadmap.length}
                  </p>
                </div>
              </div>
            </div>

            {/* Single item detail */}
            <div style={{ flex: 1, overflowY: 'auto', padding: '2.5rem clamp(1.5rem, 5vw, 4rem)' }}>
              <AnimatePresence mode="wait">
                <motion.div
                  key={roadmapItemIdx}
                  initial={{ opacity: 0, y: 16 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, y: -12 }}
                  transition={{ duration: 0.24 }}
                  style={{ maxWidth: 720, margin: '0 auto' }}
                >
                  <RoadmapDetailPanel
                    item={selectedRole.roadmap[roadmapItemIdx]}
                    roleColor={selectedRole.color}
                    roleLabel={selectedRole.label}
                  />
                </motion.div>
              </AnimatePresence>
            </div>

            {/* Bottom nav + footer */}
            <div style={{
              padding: '1.1rem 2rem',
              borderTop: '1px solid var(--line)',
              background: 'var(--ink)',
            }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                marginBottom: '0.65rem',
              }}>
                <button
                  onClick={() => {
                    if (roadmapItemIdx === 0) setStage('story')
                    else setRoadmapItemIdx(i => i - 1)
                  }}
                  style={{
                    background: 'none',
                    border: '1px solid var(--line)',
                    borderRadius: 999,
                    padding: '0.6rem 1.35rem',
                    color: 'var(--cream)',
                    cursor: 'pointer',
                    fontSize: '0.9rem',
                  }}
                >
                  ← Back
                </button>

                {roadmapItemIdx < selectedRole.roadmap.length - 1 ? (
                  <button
                    onClick={() => setRoadmapItemIdx(i => i + 1)}
                    className="btn-primary"
                    style={{ fontSize: '0.95rem', padding: '0.7rem 1.75rem' }}
                  >
                    Next: {selectedRole.roadmap[roadmapItemIdx + 1].title} →
                  </button>
                ) : (
                  <button
                    onClick={() => setStage('premium')}
                    className="btn-primary"
                    style={{ fontSize: '0.95rem', padding: '0.7rem 1.75rem' }}
                  >
                    Start My Journey →
                  </button>
                )}
              </div>
              <p style={{ fontSize: '0.88rem', color: 'var(--muted)', textAlign: 'center' }}>
                Course 1 is{' '}
                <strong style={{ color: 'var(--green)' }}>completely free</strong>
                {' '}— no credit card needed.
              </p>
            </div>
          </motion.div>
        )}

        {/* ─── PREMIUM UPSELL ────────────────────────────────────────────── */}
        {stage === 'premium' && selectedRole && (
          <motion.div
            key="premium"
            initial={{ opacity: 0, scale: 0.97 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.4 }}
            style={{
              minHeight: '100vh',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              padding: '4rem 1.5rem',
            }}
          >
            <div style={{ maxWidth: 520, width: '100%' }}>
              {/* Offer badge */}
              <div style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '0.4rem',
                background: 'rgba(200,255,0,0.1)',
                border: '1px solid rgba(200,255,0,0.28)',
                borderRadius: 999,
                padding: '0.3rem 0.95rem',
                fontSize: '0.8rem',
                fontWeight: 700,
                color: 'var(--green)',
                marginBottom: '1.5rem',
              }}>
                🎁 Limited offer — 50% off
              </div>

              <h1 style={{
                fontFamily: 'var(--font-serif)',
                fontSize: 'clamp(1.7rem, 4vw, 2.6rem)',
                color: 'var(--cream)',
                marginBottom: '0.75rem',
                lineHeight: 1.2,
              }}>
                Unlock your full roadmap to become{' '}
              {/^[AEIOU]/i.test(selectedRole.goalTitle) ? 'an' : 'a'} {selectedRole.goalTitle}
              </h1>
              <p style={{ color: 'var(--muted)', fontSize: '1rem', lineHeight: 1.65, marginBottom: '2rem' }}>
                Start your 7-day free trial — no credit card required.
              </p>

              {/* Features list */}
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.8rem', marginBottom: '2rem' }}>
                {PREMIUM_FEATURES.map((f, i) => (
                  <div key={i} style={{ display: 'flex', alignItems: 'flex-start', gap: '0.85rem' }}>
                    <span style={{
                      width: 34,
                      height: 34,
                      borderRadius: 9,
                      background: 'rgba(200,255,0,0.08)',
                      border: '1px solid rgba(200,255,0,0.2)',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      fontSize: '1rem',
                      flexShrink: 0,
                    }}>
                      {f.emoji}
                    </span>
                    <span style={{ color: 'var(--cream)', fontSize: '0.95rem', lineHeight: 1.5, paddingTop: '0.35rem' }}>
                      {f.text}
                    </span>
                  </div>
                ))}
              </div>

              {/* Price card */}
              <div style={{
                background: 'var(--dim)',
                border: '1px solid var(--line)',
                borderRadius: 16,
                padding: '1.25rem 1.5rem',
                marginBottom: '1.5rem',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
              }}>
                <div>
                  <div style={{ fontSize: '0.82rem', color: 'var(--muted)', marginBottom: '0.3rem' }}>
                    Pro Plan — Monthly
                  </div>
                  <div style={{ display: 'flex', alignItems: 'baseline', gap: '0.5rem' }}>
                    <span style={{
                      fontFamily: 'var(--font-serif)',
                      fontSize: '2rem',
                      fontWeight: 700,
                      color: 'var(--cream)',
                    }}>
                      $24.50
                    </span>
                    <span style={{ fontSize: '1rem', color: 'var(--muted)', textDecoration: 'line-through' }}>
                      $49
                    </span>
                    <span style={{ fontSize: '0.82rem', color: 'var(--green)', fontWeight: 700 }}>
                      /month
                    </span>
                  </div>
                </div>
                <div style={{
                  background: 'rgba(200,255,0,0.1)',
                  border: '1px solid rgba(200,255,0,0.25)',
                  borderRadius: 9,
                  padding: '0.4rem 0.85rem',
                  fontSize: '0.82rem',
                  fontWeight: 700,
                  color: 'var(--green)',
                }}>
                  50% OFF
                </div>
              </div>

              <button
                onClick={() => handleStart(true)}
                className="btn-primary"
                style={{ width: '100%', fontSize: '1.05rem', padding: '1rem', marginBottom: '0.75rem' }}
              >
                Start 7-Day Free Trial →
              </button>

              <button
                onClick={() => handleStart(false)}
                style={{
                  width: '100%',
                  background: 'none',
                  border: '1px solid var(--line)',
                  borderRadius: 12,
                  padding: '0.85rem',
                  color: 'var(--muted)',
                  cursor: 'pointer',
                  fontSize: '0.9rem',
                  transition: 'color 0.15s',
                }}
                onMouseEnter={e => { e.currentTarget.style.color = 'var(--cream)' }}
                onMouseLeave={e => { e.currentTarget.style.color = 'var(--muted)' }}
              >
                Skip for now — start with free content
              </button>

              <p style={{
                textAlign: 'center',
                fontSize: '0.76rem',
                color: 'var(--muted)',
                marginTop: '1rem',
                opacity: 0.65,
              }}>
                No credit card required for the trial. Cancel any time.
              </p>
            </div>
          </motion.div>
        )}

      </AnimatePresence>

      {showAuth && (
        <AuthModal
          mode="signup"
          onClose={() => setShowAuth(false)}
          onSuccess={handleAuthSuccess}
          redirectSlug={selectedRole?.pathSlug}
        />
      )}

    </div>
  )
}
