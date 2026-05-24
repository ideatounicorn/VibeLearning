// Local progress for vibe dives — no auth, no DB. Just stash in localStorage.

const KEY = 'vibelearn.dives.v1'

export type DiveProgress = {
  slug: string
  startedAt: number
  completedAt?: number
  lastStage?: string
  score?: { correct: number; total: number }
  replayCount: number
}

type Store = Record<string, DiveProgress>

function read(): Store {
  if (typeof window === 'undefined') return {}
  try {
    const raw = window.localStorage.getItem(KEY)
    return raw ? JSON.parse(raw) as Store : {}
  } catch {
    return {}
  }
}

function write(s: Store) {
  if (typeof window === 'undefined') return
  try { window.localStorage.setItem(KEY, JSON.stringify(s)) } catch {}
}

export function getProgress(slug: string): DiveProgress | null {
  return read()[slug] ?? null
}

export function startDive(slug: string) {
  const s = read()
  const existing = s[slug]
  s[slug] = existing
    ? { ...existing, replayCount: existing.replayCount + 1, completedAt: undefined, lastStage: undefined }
    : { slug, startedAt: Date.now(), replayCount: 0 }
  write(s)
}

export function updateStage(slug: string, stage: string) {
  const s = read()
  if (!s[slug]) s[slug] = { slug, startedAt: Date.now(), replayCount: 0 }
  s[slug].lastStage = stage
  write(s)
}

export function completeDive(slug: string, score?: { correct: number; total: number }) {
  const s = read()
  if (!s[slug]) s[slug] = { slug, startedAt: Date.now(), replayCount: 0 }
  s[slug].completedAt = Date.now()
  if (score) s[slug].score = score
  write(s)
}

export function allCompleted(): string[] {
  return Object.values(read()).filter((p) => p.completedAt).map((p) => p.slug)
}
