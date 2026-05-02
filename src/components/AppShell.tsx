'use client'

import { useState, useEffect, useRef } from 'react'
import { useTheme } from 'next-themes'
import Link from 'next/link'
import { supabase } from '@/lib/supabase'
import type { User } from '@supabase/supabase-js'
import { Sidebar } from './Sidebar'

interface AppShellProps {
  children: React.ReactNode
}

function MenuIcon() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <line x1="3" y1="12" x2="21" y2="12"/>
      <line x1="3" y1="6" x2="21" y2="6"/>
      <line x1="3" y1="18" x2="21" y2="18"/>
    </svg>
  )
}

function UpgradeIcon() {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
      <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
    </svg>
  )
}

function ProfileIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/>
      <circle cx="12" cy="7" r="4"/>
    </svg>
  )
}

function SettingsIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="3"/>
      <path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/>
    </svg>
  )
}

function SignOutIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
      <polyline points="16 17 21 12 16 7"></polyline>
      <line x1="21" y1="12" x2="9" y2="12"></line>
    </svg>
  )
}

export function AppShell({ children }: AppShellProps) {
  const [mobileOpen, setMobileOpen] = useState(false)
  const [user, setUser] = useState<User | null>(null)
  const [profile, setProfile] = useState<{ xp_total: number; streak_days: number; full_name: string | null } | null>(null)
  const [isPro, setIsPro] = useState(false)
  const [mounted, setMounted] = useState(false)
  const [profileMenuOpen, setProfileMenuOpen] = useState(false)
  const menuRef = useRef<HTMLDivElement>(null)
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
    if (!user) { setProfile(null); setIsPro(false); return }
    db.from('profiles')
      .select('xp_total, streak_days, full_name')
      .eq('id', user.id)
      .single()
      .then(({ data }) => setProfile(data))
    
    db.from('subscriptions')
      .select('status')
      .eq('user_id', user.id)
      .eq('status', 'active')
      .maybeSingle()
      .then(({ data }) => setIsPro(!!data))
  }, [user])

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (menuRef.current && !menuRef.current.contains(event.target as Node)) {
        setProfileMenuOpen(false)
      }
    }
    document.addEventListener("mousedown", handleClickOutside)
    return () => document.removeEventListener("mousedown", handleClickOutside)
  }, [])

  const handleSignOut = async () => {
    await db.auth.signOut()
    window.location.href = '/'
  }

  const initials = profile?.full_name
    ? profile.full_name.split(' ').map((n: string) => n[0]).join('').slice(0, 2).toUpperCase()
    : user?.email?.[0]?.toUpperCase() ?? '?'

  const avatarUrl = user?.user_metadata?.avatar_url

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg)' }}>
      {/* Top utility bar */}
      <header
        className="app-header"
        style={{
          position: 'fixed',
          top: 0,
          right: 0,
          height: 56,
          background: 'var(--bg)',
          borderBottom: '1px solid var(--border)',
          zIndex: 150,
          display: 'flex',
          alignItems: 'center',
          padding: '0 1.25rem',
          gap: '1.25rem',
          transition: 'left 0.2s ease',
        }}
      >
        {/* Mobile hamburger */}
        <button
          onClick={() => setMobileOpen(v => !v)}
          style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--text-muted)', display: 'none', padding: '0.2rem' }}
          className="mobile-hamburger"
        >
          <MenuIcon />
        </button>

        {/* Logo (mobile only) */}
        <Link href="/dashboard" style={{ display: 'none', alignItems: 'center', gap: '0.5rem', textDecoration: 'none' }} className="mobile-logo">
          <img src="/logo.png" alt="VibeLearn" style={{ width: 26, height: 26, objectFit: 'contain' }} />
          <span style={{ color: 'var(--text-primary)', fontWeight: 700, fontSize: '0.9rem' }}>VibeLearn</span>
        </Link>

        <div style={{ flex: 1 }} />
        
        {/* Upgrade Button */}
        {!isPro && user && (
          <Link
            href="/upgrade"
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.4rem',
              padding: '0.4rem 0.8rem',
              borderRadius: 999,
              background: 'var(--green)',
              color: 'var(--btn-text)',
              textDecoration: 'none',
              fontSize: '0.85rem',
              fontWeight: 700,
              boxShadow: '0 2px 10px color-mix(in srgb, var(--green) 30%, transparent)'
            }}
          >
            <UpgradeIcon /> Upgrade
          </Link>
        )}

        {/* XP + Streak */}
        {user && profile && (
          <>
            <span style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', fontSize: '0.82rem', fontWeight: 600, color: 'var(--streak-color)' }}>
              🔥 {profile.streak_days}d
            </span>
            <span style={{ display: 'flex', alignItems: 'center', gap: '0.3rem', fontSize: '0.82rem', fontWeight: 600, color: 'var(--xp-color)' }}>
              ⭐ {profile.xp_total.toLocaleString()}
            </span>
          </>
        )}

        {/* Theme toggle */}
        {mounted && (
          <button
            onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
            style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--text-muted)', fontSize: '1.1rem', padding: '0.2rem', display: 'flex', alignItems: 'center' }}
            title="Toggle theme"
          >
            {theme === 'dark' ? '☀️' : '🌙'}
          </button>
        )}

        {/* Avatar Dropdown */}
        {user && (
          <div style={{ position: 'relative' }} ref={menuRef}>
            <button
              onClick={() => setProfileMenuOpen(!profileMenuOpen)}
              title="Profile menu"
              style={{
                width: 32, height: 32,
                borderRadius: '50%',
                background: 'var(--accent)',
                color: 'var(--btn-text)',
                border: '1px solid var(--border)',
                cursor: 'pointer',
                fontWeight: 700,
                fontSize: '0.8rem',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                overflow: 'hidden',
                padding: 0,
                marginLeft: '0.25rem'
              }}
            >
              {avatarUrl ? (
                <img 
                  src={avatarUrl} 
                  alt="Profile" 
                  style={{ width: '100%', height: '100%', objectFit: 'cover' }} 
                  referrerPolicy="no-referrer"
                />
              ) : (
                initials
              )}
            </button>

            {profileMenuOpen && (
              <div 
                style={{ 
                  position: 'absolute', 
                  top: '100%', 
                  right: 0, 
                  marginTop: '0.75rem', 
                  background: 'var(--bg)', 
                  border: '1px solid var(--border)', 
                  borderRadius: 12, 
                  width: 240, 
                  padding: '0.5rem', 
                  display: 'flex', 
                  flexDirection: 'column', 
                  gap: '0.25rem',
                  boxShadow: '0 10px 25px rgba(0,0,0,0.15)',
                  zIndex: 200
                }}
              >
                <div style={{ padding: '0.5rem', borderBottom: '1px solid var(--border)', marginBottom: '0.25rem' }}>
                  <div style={{ fontWeight: 600, fontSize: '0.95rem', color: 'var(--text-primary)', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                    {profile?.full_name || 'User'}
                  </div>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                    {user.email}
                  </div>
                </div>
                <Link href="/profile" onClick={() => setProfileMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.5rem 0.6rem', textDecoration: 'none', color: 'var(--text-primary)', borderRadius: 8, fontSize: '0.9rem' }} className="menu-item">
                  <ProfileIcon /> Profile
                </Link>
                <Link href="/settings" onClick={() => setProfileMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.5rem 0.6rem', textDecoration: 'none', color: 'var(--text-primary)', borderRadius: 8, fontSize: '0.9rem' }} className="menu-item">
                  <SettingsIcon /> Settings
                </Link>
                <div style={{ height: 1, background: 'var(--border)', margin: '0.25rem 0' }} />
                <button onClick={handleSignOut} style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.5rem 0.6rem', background: 'none', border: 'none', color: 'var(--danger)', borderRadius: 8, fontSize: '0.9rem', cursor: 'pointer', width: '100%', textAlign: 'left', fontWeight: 500 }} className="menu-item">
                  <SignOutIcon /> Sign Out
                </button>
              </div>
            )}
          </div>
        )}
      </header>

      {/* Sidebar */}
      <Sidebar mobileOpen={mobileOpen} onMobileClose={() => setMobileOpen(false)} />

      {/* Main content */}
      <main
        style={{
          paddingTop: 56,
          minHeight: '100vh',
        }}
        className="app-main"
      >
        {children}
      </main>

      <style>{`
        .app-header { left: 0; }
        .menu-item:hover { background: color-mix(in srgb, var(--text-primary) 5%, transparent); }
        @media (max-width: 767px) {
          .mobile-hamburger { display: flex !important; }
          .mobile-logo { display: flex !important; }
          .app-main { margin-left: 0 !important; }
        }
        @media (min-width: 768px) {
          .app-main { margin-left: 220px; }
          .app-header { left: 220px; }
        }
      `}</style>
    </div>
  )
}
