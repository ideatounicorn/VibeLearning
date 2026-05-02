'use client'

import { useState } from 'react'
import Link from 'next/link'
import { motion, AnimatePresence } from 'framer-motion'
import { CATEGORY_GRADIENTS } from '@/lib/category-constants'

interface Profile {
  full_name: string | null
  bio: string | null
  cover_image_url: string | null
  available_for_work: boolean | null
  toolstack: string[] | null
  social_links: Record<string, string> | null
  xp_total: number
  streak_days: number
  career_goal: string | null
}

interface CompletedModule {
  id: string
  completed_at: string
  module: { title: string; course: { name: string; slug: string } | null } | null
}

interface Achievement {
  id: string
  type: string
  awarded_at: string
}

interface EnrolledCourse {
  courseId: string
  title: string
  slug: string
  pathName: string
  pathCategory: string
  enrolledAt: string
  progressTotal: number
  progressCompleted: number
  lastLessonHref: string | null
}

interface Certificate {
  id: string
  type: 'course' | 'path' | 'assessment'
  reference_name: string
  issued_at: string
  certificate_number: string
}

interface ProfileClientProps {
  profile: Profile | null
  email: string
  avatarUrl?: string | null
  completedModules: CompletedModule[]
  achievements: Achievement[]
  enrolledCourses: EnrolledCourse[]
  certificates: Certificate[]
}

const ACHIEVEMENT_META: Record<string, { label: string; icon: string }> = {
  first_lesson: { label: 'First Lesson', icon: '🎯' },
  first_quiz_pass: { label: 'Quiz Ace', icon: '✅' },
  streak_7: { label: '7-Day Streak', icon: '🔥' },
  path_complete: { label: 'Path Complete', icon: '🏆' },
}

type Tab = 'about' | 'learning' | 'certificates' | 'career'

export function ProfileClient({
  profile, email, avatarUrl, completedModules, achievements,
  enrolledCourses, certificates,
}: ProfileClientProps) {
  const [tab, setTab] = useState<Tab>('about')
  const [editing, setEditing] = useState(false)
  const [form, setForm] = useState({
    full_name: profile?.full_name ?? '',
    bio: profile?.bio ?? '',
    available_for_work: profile?.available_for_work ?? false,
    toolstack: (profile?.toolstack ?? []).join(', '),
    portfolio: profile?.social_links?.portfolio ?? '',
    linkedin: profile?.social_links?.linkedin ?? '',
    github: profile?.social_links?.github ?? '',
  })
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [copiedId, setCopiedId] = useState<string | null>(null)

  const initials = profile?.full_name
    ? profile.full_name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase()
    : email[0]?.toUpperCase() ?? '?'

  const handleSave = async () => {
    setSaving(true)
    try {
      const res = await fetch('/api/profile/update', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          full_name: form.full_name,
          bio: form.bio,
          available_for_work: form.available_for_work,
          toolstack: form.toolstack.split(',').map(s => s.trim()).filter(Boolean),
          social_links: {
            portfolio: form.portfolio,
            linkedin: form.linkedin,
            github: form.github,
          },
        }),
      })
      if (res.ok) {
        setSaved(true)
        setEditing(false)
        setTimeout(() => setSaved(false), 3000)
      }
    } finally {
      setSaving(false)
    }
  }

  const handleCopyCert = (certId: string) => {
    const url = `${window.location.origin}/certificate/${certId}`
    navigator.clipboard.writeText(url)
    setCopiedId(certId)
    setTimeout(() => setCopiedId(null), 2000)
  }

  const TABS: { id: Tab; label: string }[] = [
    { id: 'about', label: 'About' },
    { id: 'learning', label: `Learning (${enrolledCourses.length})` },
    { id: 'certificates', label: `Certificates (${certificates.length})` },
    { id: 'career', label: 'Career' },
  ]

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg)' }}>
      <div style={{ maxWidth: 900, margin: '0 auto', padding: '2rem 1.5rem 3rem' }}>

        {/* Avatar row */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1.5rem' }}>
          <motion.div
            whileHover={{ scale: 1.05 }}
            style={{
              width: 72, height: 72, borderRadius: '50%',
              background: avatarUrl ? 'transparent' : 'var(--accent)', color: 'var(--bg)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontWeight: 700, fontSize: '1.5rem',
              border: '2px solid var(--border)', flexShrink: 0, cursor: 'default',
              overflow: 'hidden',
            }}
          >
            {avatarUrl
              ? <img src={avatarUrl} alt={profile?.full_name ?? 'Avatar'} style={{ width: '100%', height: '100%', objectFit: 'cover' }} referrerPolicy="no-referrer" />
              : initials
            }
          </motion.div>
          <motion.button
            whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.97 }}
            onClick={() => editing ? handleSave() : setEditing(true)}
            disabled={saving}
            className="btn-outline"
            style={{ fontSize: '0.85rem' }}
          >
            {editing ? (saving ? 'Saving…' : 'Save profile') : 'Edit profile'}
          </motion.button>
        </div>

        <AnimatePresence>
          {saved && (
            <motion.div
              initial={{ opacity: 0, y: -8 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -8 }}
              style={{ padding: '0.6rem 1rem', background: 'color-mix(in srgb, var(--success) 12%, transparent)', border: '1px solid color-mix(in srgb, var(--success) 25%, transparent)', borderRadius: 8, color: 'var(--success)', fontSize: '0.85rem', marginBottom: '1rem' }}
            >
              Profile saved ✓
            </motion.div>
          )}
        </AnimatePresence>

        {/* Name + meta */}
        <div style={{ marginBottom: '1.5rem' }}>
          {editing ? (
            <input
              value={form.full_name}
              onChange={e => setForm(f => ({ ...f, full_name: e.target.value }))}
              style={{ fontSize: '1.5rem', fontWeight: 700, color: 'var(--text-primary)', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.4rem 0.6rem', width: '100%', marginBottom: '0.5rem' }}
              placeholder="Full name"
            />
          ) : (
            <h1 style={{ fontSize: '1.75rem', fontWeight: 700, color: 'var(--text-primary)', marginBottom: '0.25rem' }}>
              {profile?.full_name ?? 'Your Name'}
            </h1>
          )}
          <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>{email}</p>

          <div style={{ display: 'flex', gap: '1.5rem', marginTop: '0.75rem', fontSize: '0.88rem', color: 'var(--text-muted)', flexWrap: 'wrap' }}>
            <span>⭐ {profile?.xp_total?.toLocaleString() ?? 0} XP</span>
            <span>🔥 {profile?.streak_days ?? 0} day streak</span>
            <span>📚 {completedModules.length} modules completed</span>
            <span>🎓 {certificates.length} certificates</span>
          </div>

          {(editing || profile?.available_for_work) && (
            <div style={{ marginTop: '0.75rem' }}>
              {editing ? (
                <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer', fontSize: '0.88rem', color: 'var(--text-primary)' }}>
                  <input type="checkbox" checked={form.available_for_work} onChange={e => setForm(f => ({ ...f, available_for_work: e.target.checked }))} />
                  Available for work
                </label>
              ) : (
                <motion.span
                  initial={{ opacity: 0, scale: 0.9 }} animate={{ opacity: 1, scale: 1 }}
                  style={{ padding: '0.25rem 0.65rem', borderRadius: 999, background: 'color-mix(in srgb, var(--success) 12%, transparent)', color: 'var(--success)', fontSize: '0.8rem', fontWeight: 600, display: 'inline-block' }}
                >
                  ✓ Open to work
                </motion.span>
              )}
            </div>
          )}
        </div>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: '0.25rem', borderBottom: '1px solid var(--border)', marginBottom: '2rem', overflowX: 'auto' }}>
          {TABS.map(t => (
            <button
              key={t.id}
              onClick={() => setTab(t.id)}
              style={{
                background: 'none', border: 'none', cursor: 'pointer',
                padding: '0.65rem 1rem', fontSize: '0.9rem', whiteSpace: 'nowrap',
                fontWeight: tab === t.id ? 600 : 400,
                color: tab === t.id ? 'var(--text-primary)' : 'var(--text-muted)',
                borderBottom: tab === t.id ? '2px solid var(--accent)' : '2px solid transparent',
                marginBottom: -1, transition: 'color 0.15s',
              }}
            >
              {t.label}
            </button>
          ))}
        </div>

        <AnimatePresence mode="wait">
          <motion.div
            key={tab}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            transition={{ duration: 0.18 }}
          >

            {/* ABOUT TAB */}
            {tab === 'about' && (
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 280px', gap: '2rem' }} className="profile-grid">
                <div>
                  <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.75rem' }}>Summary</h2>
                  {editing ? (
                    <textarea
                      value={form.bio}
                      onChange={e => setForm(f => ({ ...f, bio: e.target.value }))}
                      rows={5}
                      style={{ width: '100%', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 10, padding: '0.75rem', color: 'var(--text-primary)', fontSize: '0.9rem', resize: 'vertical' }}
                      placeholder="Tell your story…"
                    />
                  ) : (
                    <p style={{ color: profile?.bio ? 'var(--text-primary)' : 'var(--text-muted)', fontSize: '0.95rem', lineHeight: 1.6 }}>
                      {profile?.bio ?? 'No bio yet. Click "Edit profile" to add one.'}
                    </p>
                  )}

                  <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', margin: '2rem 0 0.75rem' }}>Links</h2>
                  {editing ? (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                      {(['portfolio', 'linkedin', 'github'] as const).map(key => (
                        <input
                          key={key}
                          value={form[key]}
                          onChange={e => setForm(f => ({ ...f, [key]: e.target.value }))}
                          placeholder={`${key.charAt(0).toUpperCase() + key.slice(1)} URL`}
                          style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.5rem 0.75rem', color: 'var(--text-primary)', fontSize: '0.88rem' }}
                        />
                      ))}
                    </div>
                  ) : (
                    <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap' }}>
                      {Object.entries(profile?.social_links ?? {}).filter(([, v]) => v).map(([key, url]) => (
                        <a key={key} href={url} target="_blank" rel="noopener noreferrer" className="btn-outline" style={{ fontSize: '0.83rem', padding: '0.35rem 0.75rem' }}>
                          {key.charAt(0).toUpperCase() + key.slice(1)} ↗
                        </a>
                      ))}
                      {!profile?.social_links || Object.values(profile.social_links).every(v => !v) ? (
                        <span style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>No links added yet.</span>
                      ) : null}
                    </div>
                  )}

                  <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', margin: '2rem 0 0.75rem' }}>Tool Stack</h2>
                  {editing ? (
                    <input
                      value={form.toolstack}
                      onChange={e => setForm(f => ({ ...f, toolstack: e.target.value }))}
                      placeholder="Figma, Notion, Cursor, Linear…"
                      style={{ width: '100%', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 8, padding: '0.5rem 0.75rem', color: 'var(--text-primary)', fontSize: '0.88rem' }}
                    />
                  ) : (
                    <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                      {(profile?.toolstack ?? []).length > 0
                        ? profile!.toolstack!.map(tool => (
                            <motion.span key={tool} whileHover={{ scale: 1.05 }} style={{ padding: '0.3rem 0.7rem', borderRadius: 999, background: 'var(--surface)', border: '1px solid var(--border)', fontSize: '0.82rem', color: 'var(--text-primary)', cursor: 'default' }}>{tool}</motion.span>
                          ))
                        : <span style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>No tools added yet.</span>
                      }
                    </div>
                  )}
                </div>

                {/* Right panel */}
                <div>
                  {achievements.length > 0 && (
                    <div style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 14, padding: '1.25rem', marginBottom: '1rem' }}>
                      <h3 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)', margin: '0 0 1rem' }}>Achievements</h3>
                      <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>
                        {achievements.map((a, i) => {
                          const meta = ACHIEVEMENT_META[a.type] ?? { label: a.type, icon: '🎖' }
                          return (
                            <motion.div
                              key={a.id}
                              initial={{ opacity: 0, scale: 0.6 }}
                              animate={{ opacity: 1, scale: 1 }}
                              transition={{ delay: i * 0.05 }}
                              title={meta.label}
                              whileHover={{ scale: 1.15, rotate: 5 }}
                              style={{ width: 44, height: 44, borderRadius: 10, background: 'color-mix(in srgb, var(--accent) 10%, var(--surface))', border: '1px solid color-mix(in srgb, var(--accent) 20%, var(--border))', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.3rem', cursor: 'default' }}
                            >
                              {meta.icon}
                            </motion.div>
                          )
                        })}
                      </div>
                    </div>
                  )}

                  <div style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 14, padding: '1.25rem' }}>
                    <h3 style={{ fontSize: '0.9rem', fontWeight: 600, color: 'var(--text-primary)', margin: '0 0 1rem' }}>Statistics</h3>
                    {[
                      { label: 'Total XP', value: (profile?.xp_total ?? 0).toLocaleString() },
                      { label: 'Streak', value: `${profile?.streak_days ?? 0} days` },
                      { label: 'Modules done', value: completedModules.length },
                      { label: 'Certificates', value: certificates.length },
                      { label: 'Achievements', value: achievements.length },
                    ].map(stat => (
                      <div key={stat.label} style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border)', fontSize: '0.88rem' }}>
                        <span style={{ color: 'var(--text-muted)' }}>{stat.label}</span>
                        <span style={{ color: 'var(--text-primary)', fontWeight: 600 }}>{stat.value}</span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            )}

            {/* LEARNING TAB */}
            {tab === 'learning' && (
              <div>
                {enrolledCourses.length === 0 ? (
                  <div style={{ textAlign: 'center', padding: '3rem', color: 'var(--text-muted)' }}>
                    <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>📚</div>
                    <p>No courses enrolled yet.</p>
                    <Link href="/paths" className="btn-primary" style={{ marginTop: '1rem', display: 'inline-flex' }}>Browse paths</Link>
                  </div>
                ) : (
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
                    {enrolledCourses.map((c, i) => {
                      const pct = c.progressTotal > 0 ? Math.round((c.progressCompleted / c.progressTotal) * 100) : 0
                      const [g1, g2] = CATEGORY_GRADIENTS[c.pathCategory] ?? CATEGORY_GRADIENTS.AI
                      const isComplete = pct === 100
                      return (
                        <motion.div
                          key={c.courseId}
                          initial={{ opacity: 0, y: 20 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: i * 0.06 }}
                          whileHover={{ y: -3, boxShadow: '0 8px 30px rgba(0,0,0,0.15)' }}
                          style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 16, overflow: 'hidden', transition: 'box-shadow 0.2s' }}
                        >
                          {/* Gradient top */}
                          <div style={{ height: 6, background: `linear-gradient(90deg, ${g1}, ${g2})` }} />
                          <div style={{ padding: '1.25rem' }}>
                            <div style={{ fontSize: '0.72rem', fontWeight: 600, color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: '0.4rem' }}>
                              {c.pathName}
                            </div>
                            <div style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '1rem', lineHeight: 1.4 }}>
                              {c.title}
                            </div>

                            {/* Progress bar */}
                            <div style={{ marginBottom: '0.5rem' }}>
                              <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.78rem', color: 'var(--text-muted)', marginBottom: '0.4rem' }}>
                                <span>{c.progressCompleted}/{c.progressTotal} modules</span>
                                <span style={{ fontWeight: 600, color: isComplete ? '#34D399' : 'var(--text-primary)' }}>
                                  {pct}%
                                </span>
                              </div>
                              <div style={{ height: 6, background: 'var(--border)', borderRadius: 999, overflow: 'hidden' }}>
                                <motion.div
                                  initial={{ width: 0 }}
                                  animate={{ width: `${pct}%` }}
                                  transition={{ duration: 0.8, ease: 'easeOut', delay: i * 0.06 + 0.2 }}
                                  style={{
                                    height: '100%', borderRadius: 999,
                                    background: isComplete
                                      ? 'linear-gradient(90deg, #34D399, #6EE7B7)'
                                      : `linear-gradient(90deg, ${g1}, ${g2})`,
                                  }}
                                />
                              </div>
                            </div>

                            <div style={{ display: 'flex', gap: '0.5rem', marginTop: '0.75rem' }}>
                              <Link
                                href={isComplete ? `/courses/${c.slug}` : (c.lastLessonHref ?? `/courses/${c.slug}`)}
                                style={{
                                  flex: 1, textAlign: 'center', fontSize: '0.82rem', fontWeight: 600,
                                  padding: '0.5rem', borderRadius: 8, textDecoration: 'none',
                                  background: isComplete ? 'color-mix(in srgb, #34D399 15%, transparent)' : `color-mix(in srgb, ${g1} 15%, transparent)`,
                                  color: isComplete ? '#34D399' : g1,
                                  border: `1px solid ${isComplete ? '#34D39930' : g1 + '30'}`,
                                }}
                              >
                                {isComplete ? '✓ Completed' : 'Continue →'}
                              </Link>
                            </div>
                          </div>
                        </motion.div>
                      )
                    })}
                  </div>
                )}
              </div>
            )}

            {/* CERTIFICATES TAB */}
            {tab === 'certificates' && (
              <div>
                {certificates.length === 0 ? (
                  <div style={{ textAlign: 'center', padding: '3rem', color: 'var(--text-muted)' }}>
                    <motion.div
                      animate={{ rotate: [0, -5, 5, -5, 0] }}
                      transition={{ duration: 0.6, delay: 0.3 }}
                      style={{ fontSize: '3rem', marginBottom: '1rem' }}
                    >📜</motion.div>
                    <p>Complete courses and paths to earn certificates.</p>
                    <Link href="/paths" className="btn-primary" style={{ marginTop: '1rem', display: 'inline-flex' }}>Browse courses</Link>
                  </div>
                ) : (
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
                    {certificates.map((cert, i) => {
                      const typeLabel = { course: 'Course', path: 'Career Path', assessment: 'Assessment' }[cert.type]
                      const typeColor = { course: '#6366F1', path: '#F5C842', assessment: '#34D399' }[cert.type]
                      return (
                        <motion.div
                          key={cert.id}
                          initial={{ opacity: 0, scale: 0.9 }}
                          animate={{ opacity: 1, scale: 1 }}
                          transition={{ delay: i * 0.07, type: 'spring', stiffness: 200 }}
                          whileHover={{ y: -4, boxShadow: `0 12px 40px ${typeColor}20` }}
                          style={{
                            background: 'var(--surface)', border: `1px solid ${typeColor}30`,
                            borderRadius: 16, padding: '1.5rem', position: 'relative', overflow: 'hidden',
                            transition: 'box-shadow 0.2s',
                          }}
                        >
                          {/* Background accent */}
                          <div style={{ position: 'absolute', top: -20, right: -20, width: 80, height: 80, borderRadius: '50%', background: `${typeColor}12` }} />

                          <div style={{ fontSize: '2rem', marginBottom: '0.75rem' }}>🎓</div>
                          <div style={{
                            fontSize: '0.68rem', fontWeight: 700, letterSpacing: '0.12em',
                            textTransform: 'uppercase', color: typeColor, marginBottom: '0.3rem',
                          }}>
                            {typeLabel} Certificate
                          </div>
                          <div style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.75rem', lineHeight: 1.4 }}>
                            {cert.reference_name}
                          </div>
                          <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', marginBottom: '1rem' }}>
                            Issued {new Date(cert.issued_at).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })}
                          </div>

                          <div style={{ display: 'flex', gap: '0.5rem' }}>
                            <Link
                              href={`/certificate/${cert.id}`}
                              target="_blank"
                              style={{
                                flex: 1, textAlign: 'center', fontSize: '0.78rem', fontWeight: 600,
                                padding: '0.45rem', borderRadius: 8, textDecoration: 'none',
                                background: `${typeColor}15`, color: typeColor,
                                border: `1px solid ${typeColor}30`,
                              }}
                            >
                              View →
                            </Link>
                            <a
                              href={`https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(`${typeof window !== 'undefined' ? window.location.origin : ''}/certificate/${cert.id}`)}`}
                              target="_blank"
                              rel="noopener noreferrer"
                              style={{
                                flex: 1, textAlign: 'center', fontSize: '0.78rem', fontWeight: 600,
                                padding: '0.45rem', borderRadius: 8, textDecoration: 'none',
                                background: '#0A66C215', color: '#0A66C2',
                                border: '1px solid #0A66C230',
                              }}
                            >
                              LinkedIn ↗
                            </a>
                            <motion.button
                              whileTap={{ scale: 0.9 }}
                              onClick={() => handleCopyCert(cert.id)}
                              title="Copy link"
                              style={{
                                padding: '0.45rem 0.65rem', borderRadius: 8,
                                background: copiedId === cert.id ? 'color-mix(in srgb, var(--success) 15%, transparent)' : 'var(--surface)',
                                color: copiedId === cert.id ? 'var(--success)' : 'var(--text-muted)',
                                border: '1px solid var(--border)', cursor: 'pointer', fontSize: '0.8rem',
                              }}
                            >
                              {copiedId === cert.id ? '✓' : '🔗'}
                            </motion.button>
                          </div>
                        </motion.div>
                      )
                    })}
                  </div>
                )}
              </div>
            )}

            {/* CAREER TAB */}
            {tab === 'career' && (
              <div style={{ maxWidth: 540 }}>
                <h2 style={{ fontSize: '1rem', fontWeight: 600, color: 'var(--text-primary)', marginBottom: '0.75rem' }}>Career Goal</h2>
                <p style={{ color: 'var(--text-primary)', fontSize: '0.95rem', textTransform: 'capitalize' }}>
                  {profile?.career_goal?.replace(/-/g, ' ') ?? 'Not set'}
                </p>

                <div style={{ marginTop: '2rem' }}>
                  <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer', fontSize: '0.95rem', color: 'var(--text-primary)' }}>
                    <input
                      type="checkbox"
                      checked={form.available_for_work}
                      onChange={async e => {
                        const val = e.target.checked
                        setForm(f => ({ ...f, available_for_work: val }))
                        await fetch('/api/profile/update', {
                          method: 'PATCH',
                          headers: { 'Content-Type': 'application/json' },
                          body: JSON.stringify({ available_for_work: val }),
                        })
                      }}
                    />
                    Available for work
                  </label>
                  <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', marginTop: '0.4rem' }}>
                    Let recruiters and hiring managers know you&apos;re open to opportunities.
                  </p>
                </div>
              </div>
            )}

          </motion.div>
        </AnimatePresence>
      </div>

      <style>{`
        @media (max-width: 768px) {
          .profile-grid { grid-template-columns: 1fr !important; }
        }
      `}</style>
    </div>
  )
}
