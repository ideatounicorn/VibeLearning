'use client'

import React, { useState, useEffect } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { supabase } from '@/lib/supabase'
import type { User } from '@supabase/supabase-js'

const NAV_ITEMS = [
  { href: '/dashboard', label: 'Home', icon: HomeIcon },
  { href: '/bookmarks', label: 'Bookmarks', icon: BookmarkIcon },
]

const LEARN_ITEMS = [
  { href: '/courses', label: 'Courses', icon: CoursesIcon },
  { href: '/paths', label: 'Career Paths', icon: PathsIcon },
  { href: '/assessments', label: 'Assessments', icon: AssessmentsIcon },
]

const GROW_ITEMS: never[] = [] // Removed Profile and Settings as they go to header dropdown

function HomeIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
      <polyline points="9 22 9 12 15 12 15 22"/>
    </svg>
  )
}

function BookmarkIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M19 21l-7-5-7 5V5a2 2 0 012-2h10a2 2 0 012 2z"/>
    </svg>
  )
}

function CoursesIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
      <rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
    </svg>
  )
}

function PathsIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 3h7v7H3zM14 3h7v7h-7zM14 14h7v7h-7zM3 14h7v7H3z"/>
      <path d="M10 6.5h4M6.5 10v4M17.5 10v4M10 17.5h4"/>
    </svg>
  )
}

function ProfileIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/>
      <circle cx="12" cy="7" r="4"/>
    </svg>
  )
}

function SettingsIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="3"/>
      <path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83-2.83l.06-.06A1.65 1.65 0 004.68 15a1.65 1.65 0 00-1.51-1H3a2 2 0 010-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 012.83-2.83l.06.06A1.65 1.65 0 009 4.68a1.65 1.65 0 001-1.51V3a2 2 0 014 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 2.83l-.06.06A1.65 1.65 0 0019.4 9a1.65 1.65 0 001.51 1H21a2 2 0 010 4h-.09a1.65 1.65 0 00-1.51 1z"/>
    </svg>
  )
}

function AssessmentsIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M9 11l3 3L22 4"/>
      <path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/>
    </svg>
  )
}

function HelpIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="10"/>
      <path d="M9.09 9a3 3 0 015.83 1c0 2-3 3-3 3"/>
      <line x1="12" y1="17" x2="12.01" y2="17"/>
    </svg>
  )
}

function UpgradeIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
    </svg>
  )
}

interface NavItemProps {
  href: string
  label: string
  icon: () => React.ReactElement
  isActive: boolean
}

function NavItem({ href, label, icon: Icon, isActive }: NavItemProps) {
  return (
    <Link
      href={href}
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: '0.65rem',
        padding: '0.6rem 0.75rem',
        borderRadius: 9999,
        textDecoration: 'none',
        color: isActive ? 'var(--btn-text)' : 'var(--text-muted)',
        background: isActive ? 'var(--green)' : 'transparent',
        fontWeight: isActive ? 600 : 400,
        fontSize: '0.9rem',
        transition: 'all 0.15s',
        justifyContent: 'flex-start',
        whiteSpace: 'nowrap',
        overflow: 'hidden',
      }}
    >
      <span style={{ flexShrink: 0, color: isActive ? 'var(--btn-text)' : 'var(--text-muted)' }}>
        <Icon />
      </span>
      <span>{label}</span>
    </Link>
  )
}

interface SidebarProps {
  mobileOpen: boolean
  onMobileClose: () => void
}

export function Sidebar({ mobileOpen, onMobileClose }: SidebarProps) {
  const pathname = usePathname()
  const [user, setUser] = useState<User | null>(null)
  const db = supabase()

  useEffect(() => {
    db.auth.getUser().then(({ data }) => setUser(data.user))
  }, [])

  const sidebarWidth = 220

  const sidebarContent = (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        padding: '1rem 0.75rem',
        gap: '0.25rem',
      }}
    >
      {/* Logo row */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'flex-start',
          padding: '0.25rem 0.5rem 1rem',
          marginBottom: '0.5rem',
        }}
      >
        <Link href="/dashboard" style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', textDecoration: 'none' }}>
          <img src="/logo.png" alt="VibeLearn" style={{ width: 32, height: 32, objectFit: 'contain', flexShrink: 0 }} />
          <span style={{ color: 'var(--text-primary)', fontWeight: 800, fontSize: '1.2rem', letterSpacing: '-0.02em' }}>VibeLearn</span>
        </Link>
      </div>

      {/* Main nav */}
      {NAV_ITEMS.map(item => (
        <NavItem key={item.href} {...item} isActive={pathname === item.href} />
      ))}

      {/* LEARN section */}
      <div style={{ marginTop: '1rem' }}>
        <div style={{ color: 'var(--text-muted)', fontSize: '0.7rem', fontWeight: 600, letterSpacing: '0.08em', textTransform: 'uppercase', padding: '0 0.75rem', marginBottom: '0.35rem' }}>
          Learn
        </div>
        {LEARN_ITEMS.map(item => (
          <NavItem key={item.href} {...item} isActive={pathname.startsWith(item.href)} />
        ))}
      </div>

      {/* Spacer */}
      <div style={{ flex: 1 }} />

      {/* Help */}
      <Link
        href="mailto:support@vibelearn.co"
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '0.65rem',
          padding: '0.6rem 0.75rem',
          borderRadius: 10,
          textDecoration: 'none',
          color: 'var(--text-muted)',
          fontSize: '0.9rem',
          justifyContent: 'flex-start',
        }}
      >
        <HelpIcon />
        Help
      </Link>
    </div>
  )

  return (
    <>
      {/* Desktop sidebar */}
      <aside
        style={{
          position: 'fixed',
          top: 0,
          left: 0,
          bottom: 0,
          width: sidebarWidth,
          background: 'var(--sidebar-bg)',
          borderRight: '1px solid var(--border)',
          zIndex: 100,
          transition: 'width 0.2s ease',
          overflowX: 'hidden',
          overflowY: 'auto',
          display: 'none',
        }}
        className="sidebar-desktop"
      >
        {sidebarContent}
      </aside>

      {/* Mobile drawer overlay */}
      {mobileOpen && (
        <div
          style={{ position: 'fixed', inset: 0, zIndex: 200, display: 'flex' }}
          onClick={onMobileClose}
        >
          <div style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.5)' }} />
          <aside
            style={{
              position: 'relative',
              width: 220,
              background: 'var(--sidebar-bg)',
              height: '100%',
              zIndex: 201,
              overflowY: 'auto',
            }}
            onClick={e => e.stopPropagation()}
          >
            <div style={{ paddingTop: '1rem' }}>
              {sidebarContent}
            </div>
          </aside>
        </div>
      )}

      {/* Inject responsive style */}
      <style>{`
        @media (min-width: 768px) {
          .sidebar-desktop { display: block !important; }
        }
      `}</style>
    </>
  )
}
