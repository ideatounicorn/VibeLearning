'use client'

interface StreakTrackerProps {
  streakDays: number
}

const DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

export function StreakTracker({ streakDays }: StreakTrackerProps) {
  const today = new Date().getDay()
  // 0=Sunday, so convert to Mon=0 ... Sun=6
  const todayIndex = (today + 6) % 7

  return (
    <div
      style={{
        background: 'var(--surface)',
        border: '1px solid var(--border)',
        borderRadius: 14,
        padding: '1.25rem',
        marginBottom: '1rem',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1rem' }}>
        <h3 style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--text-primary)', margin: 0 }}>
          🔥 Daily Streak
        </h3>
        <span style={{ fontSize: '1.1rem', fontWeight: 700, color: 'var(--streak-color)' }}>
          {streakDays} {streakDays === 1 ? 'day' : 'days'}
        </span>
      </div>
      <div style={{ display: 'flex', gap: '0.4rem', justifyContent: 'space-between' }}>
        {DAYS.map((day, i) => {
          const isActive = i <= todayIndex && streakDays > (todayIndex - i)
          const isToday = i === todayIndex
          return (
            <div key={day} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '0.3rem', flex: 1 }}>
              <div
                style={{
                  width: '100%',
                  aspectRatio: '1',
                  borderRadius: '50%',
                  background: isActive
                    ? 'var(--streak-color)'
                    : 'var(--border)',
                  border: isToday ? '2px solid var(--streak-color)' : '2px solid transparent',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '0.65rem',
                  color: isActive ? '#fff' : 'var(--text-muted)',
                }}
              >
                {isActive ? '✓' : ''}
              </div>
              <span style={{ fontSize: '0.65rem', color: isToday ? 'var(--text-primary)' : 'var(--text-muted)', fontWeight: isToday ? 600 : 400 }}>
                {day}
              </span>
            </div>
          )
        })}
      </div>
    </div>
  )
}
