'use client'

import Link from 'next/link'
import { ROLES } from '@/lib/roadmap-data'

const TYPE_COLORS: Record<string, string> = {
  course: 'var(--success)',
  assessment: 'var(--warning, #f5c842)',
  project: 'var(--accent)',
  graduation: 'var(--text-primary)',
}

interface PathRoadmapWidgetProps {
  careerGoal: string | null
  pathSlug: string | null
  completedModuleCount: number
  hasStartedLesson: boolean
}

// Simple unlock heuristic: each milestone ~= 3 quiz-passing modules
function getStageStatus(
  index: number,
  hasStartedLesson: boolean,
  completedModuleCount: number,
): 'ready' | 'in-progress' | 'locked' {
  const unlockThreshold = index * 3
  if (completedModuleCount >= unlockThreshold) {
    if (index === 0 && hasStartedLesson) return 'in-progress'
    if (completedModuleCount > unlockThreshold) return 'ready'
    return index === 0 ? 'ready' : 'locked'
  }
  return 'locked'
}

export function PathRoadmapWidget({
  careerGoal,
  pathSlug,
  completedModuleCount,
  hasStartedLesson,
}: PathRoadmapWidgetProps) {
  if (!careerGoal) return null

  const role = ROLES.find(r => r.id === careerGoal)
  if (!role) return null

  const unlockedCount = role.roadmap.filter(
    (_, i) => getStageStatus(i, hasStartedLesson, completedModuleCount) !== 'locked',
  ).length

  return (
    <div
      style={{
        background: 'var(--surface)',
        border: '1px solid var(--border)',
        borderRadius: 14,
        padding: '1.25rem',
        marginBottom: '1.5rem',
      }}
    >
      {/* Header */}
      <div
        style={{
          display: 'flex',
          alignItems: 'flex-start',
          justifyContent: 'space-between',
          marginBottom: '1.1rem',
          gap: '0.5rem',
        }}
      >
        <div>
          <div
            style={{
              fontSize: '0.72rem',
              fontWeight: 700,
              color: 'var(--text-muted)',
              textTransform: 'uppercase',
              letterSpacing: '0.07em',
              marginBottom: '0.25rem',
            }}
          >
            Your Roadmap
          </div>
          <div
            style={{
              fontSize: '0.95rem',
              fontWeight: 600,
              color: 'var(--text-primary)',
              display: 'flex',
              alignItems: 'center',
              gap: '0.4rem',
            }}
          >
            {role.emoji} {role.goalTitle}
          </div>
        </div>
        <div
          style={{
            fontSize: '0.75rem',
            color: 'var(--text-muted)',
            background: 'var(--border)',
            borderRadius: 999,
            padding: '0.2rem 0.6rem',
            whiteSpace: 'nowrap',
            flexShrink: 0,
          }}
        >
          {unlockedCount}/{role.roadmap.length} unlocked
        </div>
      </div>

      {/* Progress bar */}
      <div
        style={{
          height: 4,
          background: 'var(--border)',
          borderRadius: 999,
          marginBottom: '1rem',
          overflow: 'hidden',
        }}
      >
        <div
          style={{
            height: '100%',
            width: `${(unlockedCount / role.roadmap.length) * 100}%`,
            background: 'var(--accent)',
            borderRadius: 999,
            transition: 'width 0.4s ease',
          }}
        />
      </div>

      {/* Roadmap items */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem' }}>
        {role.roadmap.map((item, i) => {
          const status = getStageStatus(i, hasStartedLesson, completedModuleCount)
          const isLocked = status === 'locked'
          const isActive = status === 'in-progress'
          const color = TYPE_COLORS[item.type] ?? 'var(--text-muted)'

          return (
            <div
              key={i}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '0.65rem',
                padding: '0.55rem 0.7rem',
                borderRadius: 9,
                background: isActive
                  ? `color-mix(in srgb, var(--accent) 8%, var(--surface))`
                  : isLocked
                    ? 'transparent'
                    : `color-mix(in srgb, ${color} 5%, var(--surface))`,
                border: `1px solid ${
                  isActive
                    ? 'color-mix(in srgb, var(--accent) 25%, var(--border))'
                    : 'var(--border)'
                }`,
                opacity: isLocked ? 0.4 : 1,
                transition: 'opacity 0.2s',
              }}
            >
              {/* Icon */}
              <span
                style={{
                  width: 28,
                  height: 28,
                  borderRadius: 7,
                  background: isLocked ? 'var(--border)' : `color-mix(in srgb, ${color} 14%, var(--surface))`,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '0.85rem',
                  flexShrink: 0,
                }}
              >
                {isLocked ? '🔒' : item.emoji}
              </span>

              {/* Text */}
              <div style={{ flex: 1, minWidth: 0 }}>
                <div
                  style={{
                    fontSize: '0.65rem',
                    fontWeight: 700,
                    color: isLocked ? 'var(--text-muted)' : color,
                    textTransform: 'uppercase',
                    letterSpacing: '0.07em',
                    marginBottom: '0.1rem',
                  }}
                >
                  {item.tag}
                </div>
                <div
                  style={{
                    fontSize: '0.82rem',
                    color: 'var(--text-primary)',
                    overflow: 'hidden',
                    textOverflow: 'ellipsis',
                    whiteSpace: 'nowrap',
                  }}
                >
                  {item.title}
                </div>
              </div>

              {/* CTA for first unlocked item */}
              {i === 0 && pathSlug && !isLocked && (
                <Link
                  href={`/paths/${pathSlug}`}
                  style={{
                    fontSize: '0.75rem',
                    fontWeight: 700,
                    color: 'var(--accent)',
                    textDecoration: 'none',
                    whiteSpace: 'nowrap',
                    flexShrink: 0,
                  }}
                >
                  {isActive ? 'Continue →' : 'Start →'}
                </Link>
              )}

              {/* FREE badge */}
              {item.isFree && !isLocked && i === 0 && (
                <span
                  style={{
                    fontSize: '0.62rem',
                    fontWeight: 700,
                    color: 'var(--success)',
                    background: 'color-mix(in srgb, var(--success) 10%, transparent)',
                    border: '1px solid color-mix(in srgb, var(--success) 25%, transparent)',
                    borderRadius: 999,
                    padding: '0.1rem 0.4rem',
                    flexShrink: 0,
                  }}
                >
                  FREE
                </span>
              )}
            </div>
          )
        })}
      </div>

      {pathSlug && (
        <Link
          href={`/paths/${pathSlug}`}
          style={{
            display: 'block',
            marginTop: '0.85rem',
            padding: '0.55rem 0.75rem',
            borderRadius: 9,
            background: 'color-mix(in srgb, var(--accent) 8%, transparent)',
            border: '1px solid color-mix(in srgb, var(--accent) 18%, transparent)',
            textDecoration: 'none',
            color: 'var(--accent)',
            fontSize: '0.82rem',
            fontWeight: 600,
            textAlign: 'center',
          }}
        >
          View full path details →
        </Link>
      )}
    </div>
  )
}
