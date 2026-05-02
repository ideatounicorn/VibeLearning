'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { supabase } from '@/lib/supabase'
import type { User } from '@supabase/supabase-js'
import AuthModal from './AuthModal'
import { useTheme } from 'next-themes'

export function Nav() {
  const [user, setUser] = useState<User | null>(null)
  const [profile, setProfile] = useState<{ xp_total: number; streak_days: number } | null>(null)
  const [showAuth, setShowAuth] = useState(false)
  const [authMode, setAuthMode] = useState<'signin' | 'signup'>('signup')
  const [mounted, setMounted] = useState(false)
  const { theme, setTheme } = useTheme()
  const db = supabase()

  useEffect(() => {
    setMounted(true)
    db.auth.getUser().then(({ data }) => setUser(data.user))
    const { data: { subscription } } = db.auth.onAuthStateChange((_, session) => {
      setUser(session?.user ?? null)
    })
    return () => subscription.unsubscribe()
  }, [])

  useEffect(() => {
    if (!user) { setProfile(null); return }
    db.from('profiles')
      .select('xp_total, streak_days')
      .eq('id', user.id)
      .single()
      .then(({ data }) => setProfile(data))
  }, [user])

  const handleSignOut = async () => {
    await db.auth.signOut()
    setUser(null)
    setProfile(null)
  }

  return (
    <>
      <nav
        style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          height: '60px',
          background: 'color-mix(in srgb, var(--ink) 95%, transparent)',
          backdropFilter: 'blur(12px)',
          WebkitBackdropFilter: 'blur(12px)',
          borderBottom: '1px solid var(--line)',
          zIndex: 1000,
          display: 'flex',
          alignItems: 'center',
          padding: '0 1.5rem',
          gap: '1rem',
        }}
      >
        {/* Logo */}
        <Link href={user ? '/dashboard' : '/'} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', textDecoration: 'none' }}>
          <img src="/logo.png" alt="VibeLearn" style={{ width: 30, height: 30, objectFit: 'contain', flexShrink: 0 }} />
          <span
            style={{
              color: 'var(--cream)',
              fontWeight: 600,
              fontSize: '1rem',
              letterSpacing: '-0.01em',
              fontFamily: 'var(--font-sans)',
            }}
          >
            VibeLearn
          </span>
        </Link>

        {/* Spacer */}
        <div style={{ flex: 1 }} />

        {/* Nav Links */}
        <Link
          href="/paths"
          style={{
            color: 'var(--muted)',
            textDecoration: 'none',
            fontSize: '0.9rem',
            fontWeight: 500,
            transition: 'color 0.15s',
          }}
          onMouseEnter={e => (e.currentTarget.style.color = 'var(--cream)')}
          onMouseLeave={e => (e.currentTarget.style.color = 'var(--muted)')}
        >
          Paths
        </Link>

        {/* XP + Streak pills (only when logged in) */}
        {user && profile && (
          <>
            <span className="pill pill-amber">
              🔥 {profile.streak_days} {profile.streak_days === 1 ? 'day' : 'days'}
            </span>
            <span className="pill pill-green">
              ⭐ {profile.xp_total.toLocaleString()} XP
            </span>
          </>
        )}

        {/* Theme Toggle */}
        {mounted && (
          <button
            onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
            style={{
              background: 'none',
              border: 'none',
              color: 'var(--muted)',
              cursor: 'pointer',
              fontSize: '1.2rem',
              padding: '0.2rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
            title="Toggle Theme"
          >
            {theme === 'dark' ? '☀️' : '🌙'}
          </button>
        )}

        {/* Auth CTA */}
        {user ? (
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <Link href="/dashboard" className="btn-outline" style={{ fontSize: '0.85rem', padding: '0.45rem 1rem' }}>
              Dashboard
            </Link>
            <button
              onClick={handleSignOut}
              style={{
                background: 'none',
                border: 'none',
                color: 'var(--muted)',
                cursor: 'pointer',
                fontSize: '0.8rem',
                padding: '0.3rem 0.5rem',
              }}
            >
              Sign out
            </button>
          </div>
        ) : (
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <button
              onClick={() => { setAuthMode('signin'); setShowAuth(true) }}
              className="btn-outline"
              style={{ fontSize: '0.85rem', padding: '0.45rem 1rem' }}
            >
              Sign in
            </button>
            <button
              onClick={() => { setAuthMode('signup'); setShowAuth(true) }}
              className="btn-primary"
              style={{ fontSize: '0.85rem', padding: '0.45rem 1rem' }}
            >
              Get started →
            </button>
          </div>
        )}
      </nav>

      {showAuth && (
        <AuthModal
          mode={authMode}
          onClose={() => setShowAuth(false)}
          onSuccess={() => setShowAuth(false)}
        />
      )}
    </>
  )
}
