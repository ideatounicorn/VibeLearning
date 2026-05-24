'use client'

import React, { useState, useEffect } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { supabase } from '@/lib/supabase'
import type { User } from '@supabase/supabase-js'

// ── Icon Components ─────────────────────────────────────────

function HomeIcon({ active }: { active?: boolean }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill={active ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 12L12 3l9 9" />
      <path d="M9 21V12h6v9" />
      <path d="M5 21h14" />
    </svg>
  )
}

function BookmarkIcon({ active }: { active?: boolean }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill={active ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <path d="M19 21l-7-5-7 5V5a2 2 0 012-2h10a2 2 0 012 2z" />
    </svg>
  )
}

function CoursesIcon({ active }: { active?: boolean }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <rect x="2" y="3" width="20" height="14" rx="2" fill={active ? 'currentColor' : 'none'} />
      <path d="M8 21h8M12 17v4" strokeOpacity={active ? '0.7' : '1'} />
    </svg>
  )
}

function AssessmentsIcon({ active }: { active?: boolean }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z" fill={active ? 'currentColor' : 'none'} fillOpacity="0.15" />
      <polyline points="14 2 14 8 20 8" />
      <line x1="9" y1="13" x2="15" y2="13" />
      <polyline points="9 9 10.5 10.5 9 12" />
    </svg>
  )
}


function TeamsIcon({ active }: { active?: boolean }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2" />
      <circle cx="9" cy="7" r="4" fill={active ? 'currentColor' : 'none'} fillOpacity="0.2" />
      <path d="M23 21v-2a4 4 0 00-3-3.87" />
      <path d="M16 3.13a4 4 0 010 7.75" />
    </svg>
  )
}



function ProfileIcon({ active }: { active?: boolean }) {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="8" r="4" fill={active ? 'currentColor' : 'none'} fillOpacity="0.2" />
      <path d="M4 20c0-4 3.6-7 8-7s8 3 8 7" />
    </svg>
  )
}

function HelpIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="10" />
      <path d="M9.09 9a3 3 0 015.83 1c0 2-3 3-3 3" />
      <circle cx="12" cy="17" r="0.5" fill="currentColor" />
    </svg>
  )
}

function SparkleIcon() {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 2l2.4 7.6L22 12l-7.6 2.4L12 22l-2.4-7.6L2 12l7.6-2.4z" fill="currentColor" />
    </svg>
  )
}

function DiscordIcon() {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
      <path d="M20.317 4.37a19.791 19.791 0 00-4.885-1.515.074.074 0 00-.079.037c-.21.375-.444.864-.608 1.25a18.27 18.27 0 00-5.487 0 12.64 12.64 0 00-.617-1.25.077.077 0 00-.079-.037A19.736 19.736 0 003.677 4.37a.07.07 0 00-.032.027C.533 9.046-.32 13.58.099 18.057a.082.082 0 00.031.057 19.9 19.9 0 005.993 3.03.078.078 0 00.084-.028 14.09 14.09 0 001.226-1.994.076.076 0 00-.041-.106 13.107 13.107 0 01-1.872-.892.077.077 0 01-.008-.128 10.2 10.2 0 00.372-.292.074.074 0 01.077-.01c3.928 1.793 8.18 1.793 12.062 0a.074.074 0 01.078.01c.12.098.246.198.373.292a.077.077 0 01-.006.127 12.299 12.299 0 01-1.873.892.077.077 0 00-.041.107c.36.698.772 1.362 1.225 1.993a.076.076 0 00.084.028 19.839 19.839 0 006.002-3.03.077.077 0 00.032-.054c.5-5.177-.838-9.674-3.549-13.66a.061.061 0 00-.031-.03z" />
    </svg>
  )
}

// ── Nav Data ─────────────────────────────────────────────────

const NAV_ITEMS = [
  { href: '/dashboard', label: 'Home', icon: HomeIcon },
  { href: '/bookmarks', label: 'Saved', icon: BookmarkIcon },
  { href: '/profile', label: 'Profile', icon: ProfileIcon },
]

const LEARN_ITEMS = [
  { href: '/courses', label: 'Courses', icon: CoursesIcon },
  { href: '/assessments', label: 'Assessments', icon: AssessmentsIcon },
]

const GROW_ITEMS = [
  { href: '/teams', label: 'Teams', icon: TeamsIcon },
]

// ── NavItem Component ─────────────────────────────────────────

interface NavItemProps {
  href: string
  label: string
  icon: React.ComponentType<{ active?: boolean }>
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
        padding: '0.55rem 0.75rem',
        borderRadius: 10,
        textDecoration: 'none',
        color: isActive ? 'var(--text-primary)' : 'var(--text-muted)',
        background: isActive ? 'color-mix(in srgb, var(--green) 18%, transparent)' : 'transparent',
        fontWeight: isActive ? 600 : 400,
        fontSize: '0.88rem',
        transition: 'all 0.15s',
        justifyContent: 'flex-start',
        whiteSpace: 'nowrap',
        overflow: 'hidden',
        position: 'relative',
      }}
      className={`sidebar-nav-item${isActive ? ' active' : ''}`}
    >
      {isActive && (
        <span
          style={{
            position: 'absolute',
            left: 0,
            top: '20%',
            bottom: '20%',
            width: 3,
            borderRadius: '0 3px 3px 0',
            background: 'var(--green)',
          }}
        />
      )}
      <span style={{ flexShrink: 0, color: isActive ? 'var(--green)' : 'var(--text-muted)', display: 'flex' }}>
        <Icon active={isActive} />
      </span>
      <span>{label}</span>
    </Link>
  )
}

// ── Section Label ─────────────────────────────────────────────

function SectionLabel({ label }: { label: string }) {
  return (
    <div style={{
      color: 'var(--text-muted)',
      fontSize: '0.68rem',
      fontWeight: 700,
      letterSpacing: '0.1em',
      textTransform: 'uppercase',
      padding: '0 0.75rem',
      marginBottom: '0.25rem',
      marginTop: '0.25rem',
    }}>
      {label}
    </div>
  )
}

// ── Pro Upgrade Card ──────────────────────────────────────────

function ProCard() {
  return (
    <div
      style={{
        margin: '0 0.5rem',
        borderRadius: 14,
        background: 'linear-gradient(135deg, color-mix(in srgb, var(--green) 20%, transparent), color-mix(in srgb, var(--violet) 12%, transparent))',
        border: '1px solid color-mix(in srgb, var(--green) 30%, var(--border))',
        padding: '0.9rem',
        display: 'flex',
        flexDirection: 'column',
        gap: '0.5rem',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
        <span style={{ color: 'var(--green)', display: 'flex' }}>
          <SparkleIcon />
        </span>
        <span style={{ fontWeight: 700, fontSize: '0.82rem', color: 'var(--text-primary)' }}>
          Go Pro
        </span>
      </div>
      <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', lineHeight: 1.4, margin: 0 }}>
        Unlock all courses & certifications.
      </p>
      <Link
        href="/upgrade"
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          padding: '0.45rem 0.75rem',
          borderRadius: 8,
          background: 'var(--green)',
          color: 'var(--btn-text)',
          textDecoration: 'none',
          fontSize: '0.78rem',
          fontWeight: 700,
          transition: 'opacity 0.15s',
        }}
        className="sidebar-upgrade-btn"
      >
        Upgrade now →
      </Link>
    </div>
  )
}

// ── Community Card ────────────────────────────────────────────

function CommunityCard() {
  return (
    <div
      style={{
        margin: '0 0.5rem',
        borderRadius: 14,
        background: 'color-mix(in srgb, #5865F2 8%, transparent)',
        border: '1px solid color-mix(in srgb, #5865F2 25%, var(--border))',
        padding: '0.9rem',
        display: 'flex',
        flexDirection: 'column',
        gap: '0.5rem',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
        <span style={{ color: '#7289DA', display: 'flex' }}>
          <DiscordIcon />
        </span>
        <span style={{ fontWeight: 700, fontSize: '0.82rem', color: 'var(--text-primary)' }}>
          Community
        </span>
      </div>
      <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', lineHeight: 1.4, margin: 0 }}>
        Join 2,000+ learners on Discord.
      </p>
      <a
        href="https://discord.gg/vibelearn"
        target="_blank"
        rel="noopener noreferrer"
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          padding: '0.45rem 0.75rem',
          borderRadius: 8,
          background: '#5865F2',
          color: '#ffffff',
          textDecoration: 'none',
          fontSize: '0.78rem',
          fontWeight: 700,
          transition: 'opacity 0.15s',
        }}
        className="sidebar-discord-btn"
      >
        Join Discord →
      </a>
    </div>
  )
}

// ── Sidebar Component ─────────────────────────────────────────

interface SidebarProps {
  mobileOpen: boolean
  onMobileClose: () => void
}

export function Sidebar({ mobileOpen, onMobileClose }: SidebarProps) {
  const pathname = usePathname()
  const [user, setUser] = useState<User | null>(null)
  const [isPro, setIsPro] = useState(false)
  const db = supabase()

  useEffect(() => {
    db.auth.getUser().then(({ data }) => {
      setUser(data.user)
      if (data.user) {
        db.from('subscriptions')
          .select('status')
          .eq('user_id', data.user.id)
          .eq('status', 'active')
          .maybeSingle()
          .then(({ data: sub }) => setIsPro(!!sub))
      }
    })
  }, [])

  const sidebarWidth = 224

  const sidebarContent = (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        padding: '1rem 0.5rem',
        gap: '0.15rem',
      }}
    >
      {/* Logo */}
      <div style={{ padding: '0.25rem 0.5rem 1.25rem' }}>
        <Link href="/dashboard" style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', textDecoration: 'none' }}>
          <img src="/logo.png" alt="VibeLearn" style={{ width: 30, height: 30, objectFit: 'contain', flexShrink: 0 }} />
          <span style={{ color: 'var(--text-primary)', fontWeight: 800, fontSize: '1.15rem', letterSpacing: '-0.03em' }}>
            VibeLearn
          </span>
        </Link>
      </div>

      {/* Main nav */}
      {NAV_ITEMS.map(item => (
        <NavItem key={item.href} {...item} isActive={pathname === item.href || pathname.startsWith(item.href + '/')} />
      ))}

      {/* LEARN section */}
      <div style={{ marginTop: '1.25rem' }}>
        <SectionLabel label="Learn" />
        {LEARN_ITEMS.map(item => (
          <NavItem
            key={item.href}
            {...item}
            isActive={pathname === item.href || pathname.startsWith(item.href + '/')}
          />
        ))}
      </div>

      {/* GROW section */}
      <div style={{ marginTop: '1.25rem' }}>
        <SectionLabel label="Grow" />
        {GROW_ITEMS.map(item => (
          <NavItem
            key={item.href}
            {...item}
            isActive={pathname === item.href || pathname.startsWith(item.href + '/')}
          />
        ))}
      </div>

      {/* Spacer */}
      <div style={{ flex: 1 }} />

      {/* Cards */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.6rem', paddingBottom: '0.5rem' }}>
        {!isPro && <ProCard />}
        <CommunityCard />
      </div>

      {/* Help link */}
      <Link
        href="mailto:support@vibelearn.co"
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '0.55rem',
          padding: '0.5rem 0.75rem',
          borderRadius: 10,
          textDecoration: 'none',
          color: 'var(--text-muted)',
          fontSize: '0.82rem',
          justifyContent: 'flex-start',
          marginTop: '0.25rem',
        }}
        className="sidebar-nav-item"
      >
        <HelpIcon />
        Help & Support
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
          overflowX: 'hidden',
          overflowY: 'auto',
          display: 'none',
        }}
        className="sidebar-desktop"
      >
        {sidebarContent}
      </aside>

      {/* Mobile drawer */}
      {mobileOpen && (
        <div
          style={{ position: 'fixed', inset: 0, zIndex: 200, display: 'flex' }}
          onClick={onMobileClose}
        >
          <div style={{ position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.5)' }} />
          <aside
            style={{
              position: 'relative',
              width: sidebarWidth,
              background: 'var(--sidebar-bg)',
              height: '100%',
              zIndex: 201,
              overflowY: 'auto',
            }}
            onClick={e => e.stopPropagation()}
          >
            {sidebarContent}
          </aside>
        </div>
      )}

      <style>{`
        @media (min-width: 768px) {
          .sidebar-desktop { display: block !important; }
        }
        .sidebar-nav-item:hover:not(.active) {
          background: color-mix(in srgb, var(--text-primary) 5%, transparent) !important;
          color: var(--text-primary) !important;
        }
        .sidebar-upgrade-btn:hover { opacity: 0.85; }
        .sidebar-discord-btn:hover { opacity: 0.85; }
      `}</style>
    </>
  )
}
