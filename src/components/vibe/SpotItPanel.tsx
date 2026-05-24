'use client'

import { useState, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import Image from 'next/image'
import type { Hotspot } from '@/lib/dive-meet-claude'
import { Capy } from './Capy'

// Render a screenshot with invisible tap-zones.
// Correct tap = animated checkmark + onComplete fires.
// Wrong tap = Cap hint bubble appears with arrow toward correct area.
//
// Two modes:
// - 'single': one correct area, complete on first correct tap
// - 'multi': multiple correct areas, each pins a sticky, complete when all found

export default function SpotItPanel({
  image,
  alt,
  prompt,
  hotspots,
  capyHint,
  mode = 'single',
  onComplete,
  onPinSticky,
}: {
  image: string
  alt: string
  prompt: string
  hotspots: Hotspot[]
  capyHint?: string
  mode?: 'single' | 'multi'
  onComplete: () => void
  onPinSticky?: (label: string, x: number, y: number) => void
}) {
  const [foundIdxs, setFoundIdxs] = useState<Set<number>>(new Set())
  const [wrongTap, setWrongTap] = useState<{ x: number; y: number } | null>(null)
  const wrapRef = useRef<HTMLDivElement>(null)

  const total = mode === 'multi' ? hotspots.length : 1
  const found = foundIdxs.size

  const handleClick = (e: React.MouseEvent) => {
    const rect = wrapRef.current?.getBoundingClientRect()
    if (!rect) return
    const xPct = ((e.clientX - rect.left) / rect.width) * 100
    const yPct = ((e.clientY - rect.top) / rect.height) * 100

    // Find which hotspot was hit
    let hitIdx = -1
    hotspots.forEach((h, i) => {
      if (xPct >= h.x && xPct <= h.x + h.w && yPct >= h.y && yPct <= h.y + h.h) {
        hitIdx = i
      }
    })

    if (hitIdx >= 0 && hotspots[hitIdx].correct && !foundIdxs.has(hitIdx)) {
      const next = new Set(foundIdxs); next.add(hitIdx)
      setFoundIdxs(next)
      setWrongTap(null)

      if (mode === 'multi' && hotspots[hitIdx].label && onPinSticky) {
        const h = hotspots[hitIdx]
        onPinSticky(h.label!, h.x + h.w / 2, h.y + h.h / 2)
      }

      // Trigger advance
      if (mode === 'single' || next.size === hotspots.length) {
        setTimeout(onComplete, 1100)
      }
    } else if (hitIdx === -1 || !hotspots[hitIdx].correct) {
      setWrongTap({ x: xPct, y: yPct })
    }
  }

  return (
    <div style={wrap}>
      <div style={promptBubble}>
        <Capy pose="thinking" size={32} />
        <div style={{ flex: 1 }} dangerouslySetInnerHTML={{ __html: renderInline(prompt) }} />
      </div>

      <div style={progressLabel}>
        {mode === 'multi' ? `${found} / ${total} found` : found === 0 ? 'Tap on the screenshot' : '✓ found'}
      </div>

      <div ref={wrapRef} onClick={handleClick} style={imageWrap}>
        <Image
          src={image}
          alt={alt}
          width={1200}
          height={750}
          unoptimized
          style={{ width: '100%', height: 'auto', display: 'block' }}
          onError={() => {/* graceful: shows alt text via Next.js fallback */}}
        />

        {/* Successful hotspot rings */}
        {[...foundIdxs].map((i) => {
          const h = hotspots[i]
          return (
            <motion.div
              key={`hit-${i}`}
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ type: 'spring', stiffness: 200, damping: 14 }}
              style={{
                position: 'absolute',
                left: `${h.x}%`, top: `${h.y}%`,
                width: `${h.w}%`, height: `${h.h}%`,
                border: '3px solid #c8ff00',
                borderRadius: 8,
                boxShadow: '0 0 16px rgba(200,255,0,0.6), inset 0 0 0 100px rgba(200,255,0,0.12)',
                pointerEvents: 'none',
              }}
            >
              <div style={{
                position: 'absolute', top: -14, right: -14,
                background: '#c8ff00', color: '#000',
                width: 28, height: 28, borderRadius: '50%',
                border: '2.5px solid #000',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontWeight: 900, fontSize: '0.95rem',
                boxShadow: '2px 2px 0 rgba(0,0,0,0.7)',
              }}>✓</div>
              {h.label && (
                <div style={{
                  position: 'absolute', bottom: -32, left: '50%', transform: 'translateX(-50%)',
                  background: h.correct ? '#c8ff00' : '#FF6B51',
                  color: '#000', padding: '0.2rem 0.55rem',
                  border: '2px solid #000', borderRadius: 4,
                  fontSize: '0.7rem', fontWeight: 900, whiteSpace: 'nowrap',
                  boxShadow: '2px 2px 0 rgba(0,0,0,0.7)',
                }}>{h.label}</div>
              )}
            </motion.div>
          )
        })}

        {/* Wrong tap ripple + hint */}
        <AnimatePresence>
          {wrongTap && (
            <>
              <motion.div
                key="ripple"
                initial={{ scale: 0, opacity: 0.6 }}
                animate={{ scale: 4, opacity: 0 }}
                transition={{ duration: 0.7 }}
                style={{
                  position: 'absolute',
                  left: `${wrongTap.x}%`, top: `${wrongTap.y}%`,
                  width: 20, height: 20, borderRadius: '50%',
                  background: '#FF6B51',
                  transform: 'translate(-50%, -50%)',
                  pointerEvents: 'none',
                }}
              />
              {capyHint && (
                <motion.div
                  key="hint"
                  initial={{ opacity: 0, y: 8 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0 }}
                  style={hintBubble}
                >
                  <Capy pose="oops" size={28} />
                  <div style={{ flex: 1 }} dangerouslySetInnerHTML={{ __html: renderInline(capyHint) }} />
                </motion.div>
              )}
            </>
          )}
        </AnimatePresence>
      </div>
    </div>
  )
}

// inline `code` + **bold**
function renderInline(text: string) {
  return text
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/`([^`]+)`/g, '<code style="background:var(--bg);padding:1px 5px;border-radius:4px;font-size:0.88em;border:1px solid var(--line);font-family:ui-monospace,monospace">$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
}

// ─── Styles ───────────────────────────────────────────────────────────────────

const wrap: React.CSSProperties = {
  width: '100%', maxWidth: 900, margin: '0 auto',
  display: 'flex', flexDirection: 'column', gap: '0.85rem',
}

const promptBubble: React.CSSProperties = {
  display: 'flex', gap: '0.6rem', alignItems: 'flex-start',
  background: 'var(--surface)', border: '2px solid var(--line)',
  borderRadius: 14, padding: '0.85rem 1rem',
  fontSize: '0.95rem', color: 'var(--cream)', lineHeight: 1.5, fontWeight: 600,
  textAlign: 'left',
}

const progressLabel: React.CSSProperties = {
  fontSize: '0.7rem', letterSpacing: '0.2em', textTransform: 'uppercase',
  color: 'var(--muted)', fontWeight: 700, textAlign: 'center',
}

const imageWrap: React.CSSProperties = {
  position: 'relative',
  border: '3px solid var(--line)', borderRadius: 14,
  overflow: 'hidden', cursor: 'crosshair',
  background: 'var(--surface)',
  aspectRatio: '16 / 10',
}

const hintBubble: React.CSSProperties = {
  position: 'absolute', bottom: 16, left: 16, right: 16,
  display: 'flex', gap: '0.55rem', alignItems: 'flex-start',
  background: '#fff', color: '#000',
  border: '2.5px solid #000', borderRadius: 12,
  padding: '0.65rem 0.85rem',
  fontSize: '0.85rem', fontWeight: 600, lineHeight: 1.4,
  boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
  zIndex: 10,
}
