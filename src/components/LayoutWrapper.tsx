'use client'

import { usePathname } from 'next/navigation'
import { Nav } from './Nav'
import { AppShell } from './AppShell'

const PUBLIC_PATHS = ['/', '/login']
// These routes render completely full-screen — no header, no sidebar
const FULLSCREEN_PATHS = ['/onboarding', '/learn', '/course-intro', '/quiz', '/vibe']
const AUTH_PREFIXES = ['/dashboard', '/courses', '/profile', '/settings', '/bookmarks', '/upgrade', '/assessments']



export function LayoutWrapper({ children }: { children: React.ReactNode }) {
  const pathname = usePathname()

  if (FULLSCREEN_PATHS.some(p => pathname.startsWith(p))) {
    return <>{children}</>
  }

  const isPublic = PUBLIC_PATHS.includes(pathname)
  const isApp = AUTH_PREFIXES.some(p => pathname.startsWith(p))

  if (isApp && !isPublic) {
    return <AppShell>{children}</AppShell>
  }

  return (
    <>
      <Nav />
      <main style={{ paddingTop: 60 }}>{children}</main>
    </>
  )
}
