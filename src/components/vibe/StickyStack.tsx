'use client'

import { motion, AnimatePresence } from 'framer-motion'
import type { Sticky } from '@/lib/dive-meet-claude'

// Persistent corner stack of stickies earned across the story.
// Each insight panel adds one. They stay pinned through the rest of the dive.
// Used as the answer key in the big spot-it.

export default function StickyStack({
  stickies,
  highlightedIds = [],
}: {
  stickies: Sticky[]
  highlightedIds?: string[]   // for big-spot — pulses the relevant sticky as user finds it
}) {
  if (stickies.length === 0) return null

  return (
    <div
      style={{
        position: 'fixed',
        top: 78,           // below top bar
        right: 16,
        display: 'flex',
        flexDirection: 'column',
        gap: '0.5rem',
        zIndex: 50,
        pointerEvents: 'none',
      }}
    >
      <AnimatePresence>
        {stickies.map((s, i) => {
          const highlighted = highlightedIds.includes(s.id)
          return (
            <motion.div
              key={s.id}
              initial={{ opacity: 0, x: 60, rotate: 8 }}
              animate={{
                opacity: 1,
                x: 0,
                rotate: i % 2 === 0 ? -3 : 3,
                scale: highlighted ? [1, 1.1, 1] : 1,
              }}
              exit={{ opacity: 0, x: 60 }}
              transition={{ type: 'spring', stiffness: 140, damping: 16 }}
              style={{
                background: s.color,
                color: '#000',
                border: '2.5px solid #000',
                borderRadius: 6,
                padding: '0.4rem 0.75rem',
                fontWeight: 800,
                fontSize: '0.72rem',
                letterSpacing: '0.03em',
                boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
                minWidth: 120,
                textAlign: 'center',
              }}
            >
              <span style={{ opacity: 0.6, fontSize: '0.65rem', marginRight: 4 }}>{i + 1}.</span>
              {s.label}
            </motion.div>
          )
        })}
      </AnimatePresence>
    </div>
  )
}
