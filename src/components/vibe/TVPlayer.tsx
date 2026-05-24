'use client'

import { motion } from 'framer-motion'
import { Capy } from './Capy'

// TV-shaped frame around YouTube embed.
// Now with: power LED, sticker decals, scanline overlay, Capy peeking corner,
// persistent thought bubble that cycles tips.

export function TVPlayer({
  youtubeId,
  caption,
}: {
  youtubeId: string
  caption?: string
}) {
  return (
    <div style={{ position: 'relative', width: '100%', maxWidth: 760, margin: '0 auto', paddingTop: 40 }}>
      <motion.div
        initial={{ opacity: 0, scale: 0.92, rotate: -1 }}
        animate={{ opacity: 1, scale: 1, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 110, damping: 14 }}
        style={{ position: 'relative' }}
      >
        <Antennae />

        {/* Sticker decals on the bezel — top corners */}
        <Sticker style={{ top: 44, left: -8, rotate: -8, bg: '#FF6B51' }}>GIT 101</Sticker>
        <Sticker style={{ top: 52, right: -10, rotate: 6, bg: '#c8ff00' }}>★ Cap’s pick</Sticker>

        {/* Bezel */}
        <div style={bezel}>
          {/* ON AIR + power LED */}
          <div style={onAir}>
            <motion.span animate={{ opacity: [1, 0.3, 1] }} transition={{ duration: 1.4, repeat: Infinity }}
              style={{ width: 7, height: 7, borderRadius: '50%', background: '#FF3B30', display: 'inline-block' }} />
            <span>ON AIR</span>
          </div>

          {/* Screen with scanline overlay */}
          <div style={screen}>
            <iframe
              src={`https://www.youtube.com/embed/${youtubeId}?rel=0&modestbranding=1`}
              title="YouTube video player"
              allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowFullScreen
              style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', border: 0 }}
            />
            {/* Scanline + vignette overlay */}
            <div style={scanlines} />
            <div style={vignette} />
          </div>

          {/* Caption strip */}
          {caption && (
            <div style={captionStrip}>
              <span style={{ fontFamily: 'ui-monospace, monospace', fontSize: '0.75rem' }}>📺</span>
              <span style={{ flex: 1 }}>{caption}</span>
              <PowerLED />
            </div>
          )}

          {/* Knobs row */}
          <div style={knobsRow}>
            <div style={speakerGrille} />
            <div style={knobsCluster}>
              <Knob />
              <Knob filled />
              <Knob />
            </div>
          </div>
        </div>

        {/* Wood base + feet */}
        <div style={base} />
        <div style={feet}>
          <div style={foot} />
          <div style={foot} />
        </div>

      </motion.div>
    </div>
  )
}

// ─── Antennae ─────────────────────────────────────────────────────────────────
function Antennae() {
  return (
    <svg viewBox="0 0 220 60"
      style={{ position: 'absolute', top: -2, left: '50%', transform: 'translateX(-50%)', width: 220, height: 60, pointerEvents: 'none' }}>
      <line x1="110" y1="54" x2="58" y2="8" stroke="#1a1a1a" strokeWidth="3.5" strokeLinecap="round" />
      <circle cx="58" cy="8" r="7" fill="#c8ff00" stroke="#000" strokeWidth="2.5" />
      <line x1="110" y1="54" x2="162" y2="14" stroke="#1a1a1a" strokeWidth="3.5" strokeLinecap="round" />
      <circle cx="162" cy="14" r="7" fill="#FFB58A" stroke="#000" strokeWidth="2.5" />
      <circle cx="110" cy="54" r="6" fill="#2a2a2a" stroke="#000" strokeWidth="2" />
    </svg>
  )
}

// ─── Knob ─────────────────────────────────────────────────────────────────────
function Knob({ filled }: { filled?: boolean } = {}) {
  return (
    <div style={{
      width: 30, height: 30, borderRadius: '50%',
      background: filled ? '#c8ff00' : '#3a2a1a',
      border: '2.5px solid #000', position: 'relative',
      boxShadow: 'inset 0 -3px 0 rgba(0,0,0,0.25), 0 2px 0 rgba(0,0,0,0.3)',
    }}>
      <div style={{
        position: 'absolute', top: 4, left: '50%', transform: 'translateX(-50%)',
        width: 3, height: 9, background: '#000', borderRadius: 2,
      }} />
    </div>
  )
}

function PowerLED() {
  return (
    <motion.div
      animate={{ opacity: [0.6, 1, 0.6] }}
      transition={{ duration: 1.8, repeat: Infinity }}
      style={{
        width: 9, height: 9, borderRadius: '50%', background: '#c8ff00',
        boxShadow: '0 0 8px #c8ff00, inset 0 0 4px rgba(0,0,0,0.3)',
      }}
    />
  )
}

// ─── Capy peeking corner ──────────────────────────────────────────────────────
import { useState, useEffect } from 'react'

function CapyCorner({ tips }: { tips: string[] }) {
  const [idx, setIdx] = useState(0)

  useEffect(() => {
    if (tips.length <= 1) return
    const t = setInterval(() => setIdx((i) => (i + 1) % tips.length), 5500)
    return () => clearInterval(t)
  }, [tips])

  if (tips.length === 0) return null

  return (
    <motion.div
      initial={{ opacity: 0, x: 30, y: 10 }}
      animate={{ opacity: 1, x: 0, y: 0 }}
      transition={{ delay: 0.6, type: 'spring' }}
      style={{
        position: 'absolute',
        right: -18,
        bottom: -32,
        display: 'flex',
        alignItems: 'flex-end',
        gap: 0,
        zIndex: 3,
      }}
    >
      {/* Speech bubble */}
      <motion.div
        key={idx}
        initial={{ opacity: 0, scale: 0.92 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.35 }}
        style={{
          background: '#fff', color: '#000',
          border: '2.5px solid #000', borderRadius: 14,
          padding: '0.55rem 0.8rem', maxWidth: 200,
          fontSize: '0.78rem', fontWeight: 600, lineHeight: 1.35,
          boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
          position: 'relative',
          marginRight: -6,
          marginBottom: 30,
        }}
      >
        {tips[idx]}
        {/* tail */}
        <div style={{
          position: 'absolute', right: -10, bottom: 8,
          width: 0, height: 0,
          borderLeft: '12px solid #000',
          borderTop: '6px solid transparent',
          borderBottom: '6px solid transparent',
        }} />
        <div style={{
          position: 'absolute', right: -7, bottom: 10,
          width: 0, height: 0,
          borderLeft: '9px solid #fff',
          borderTop: '4px solid transparent',
          borderBottom: '4px solid transparent',
        }} />
      </motion.div>

      {/* Capy sticker */}
      <motion.div
        animate={{ y: [0, -4, 0] }}
        transition={{ duration: 3, repeat: Infinity, ease: 'easeInOut' }}
        style={{ filter: 'drop-shadow(2px 2px 0 rgba(0,0,0,0.6))' }}
      >
        <Capy pose="thinking" size={84} />
      </motion.div>
    </motion.div>
  )
}

// ─── Sticker decal ────────────────────────────────────────────────────────────
function Sticker({ children, style }: { children: React.ReactNode; style: { top?: number; left?: number; right?: number; rotate: number; bg: string } }) {
  return (
    <div style={{
      position: 'absolute',
      top: style.top, left: style.left, right: style.right,
      transform: `rotate(${style.rotate}deg)`,
      background: style.bg, color: '#000',
      padding: '0.25rem 0.6rem', borderRadius: 6,
      fontSize: '0.7rem', fontWeight: 900,
      border: '2px solid #000',
      boxShadow: '2px 2px 0 rgba(0,0,0,0.85)',
      letterSpacing: '0.04em',
      zIndex: 2,
    }}>
      {children}
    </div>
  )
}

// ─── Styles ───────────────────────────────────────────────────────────────────

const bezel: React.CSSProperties = {
  position: 'relative',
  background: 'linear-gradient(180deg, #D4A574 0%, #A87544 100%)',
  border: '3.5px solid #000',
  borderRadius: 26,
  padding: '16px 16px 10px',
  boxShadow: '0 8px 0 rgba(0,0,0,0.5), inset 0 2px 0 rgba(255,255,255,0.25), inset 0 -3px 0 rgba(0,0,0,0.15)',
  backgroundImage: `linear-gradient(180deg, #D4A574 0%, #A87544 100%),
    repeating-linear-gradient(90deg, transparent 0 8px, rgba(0,0,0,0.04) 8px 9px)`,
}

const screen: React.CSSProperties = {
  position: 'relative',
  width: '100%',
  paddingBottom: '56.25%', // 16:9
  background: '#000',
  border: '2.5px solid #000',
  borderRadius: 14,
  overflow: 'hidden',
  boxShadow: 'inset 0 0 18px rgba(0,0,0,0.7)',
}

const scanlines: React.CSSProperties = {
  position: 'absolute',
  inset: 0,
  background: 'repeating-linear-gradient(0deg, rgba(0,0,0,0.06) 0 2px, transparent 2px 4px)',
  pointerEvents: 'none',
  mixBlendMode: 'multiply',
}

const vignette: React.CSSProperties = {
  position: 'absolute',
  inset: 0,
  background: 'radial-gradient(ellipse at center, transparent 60%, rgba(0,0,0,0.4) 100%)',
  pointerEvents: 'none',
}

const onAir: React.CSSProperties = {
  position: 'absolute',
  top: -16,
  right: 28,
  background: '#1a1a1a',
  color: '#fff',
  fontSize: '0.65rem',
  fontWeight: 800,
  letterSpacing: '0.18em',
  padding: '5px 11px',
  borderRadius: 6,
  border: '2.5px solid #000',
  display: 'inline-flex',
  alignItems: 'center',
  gap: 6,
  zIndex: 2,
  boxShadow: '2px 2px 0 rgba(0,0,0,0.7)',
}

const captionStrip: React.CSSProperties = {
  marginTop: 12,
  padding: '8px 14px',
  background: '#1a1a1a',
  border: '2.5px solid #000',
  borderRadius: 8,
  color: '#FFE9D0',
  fontSize: '0.78rem',
  display: 'flex',
  alignItems: 'center',
  gap: 10,
  fontWeight: 600,
}

const knobsRow: React.CSSProperties = {
  display: 'flex',
  alignItems: 'center',
  gap: 14,
  marginTop: 12,
}

const speakerGrille: React.CSSProperties = {
  flex: 1,
  height: 26,
  background: 'repeating-linear-gradient(90deg, #2a2a2a 0 3px, #1a1a1a 3px 6px)',
  border: '2.5px solid #000',
  borderRadius: 6,
  boxShadow: 'inset 0 2px 0 rgba(0,0,0,0.4)',
}

const knobsCluster: React.CSSProperties = {
  display: 'flex',
  gap: 10,
}

const base: React.CSSProperties = {
  width: '46%',
  height: 14,
  background: 'linear-gradient(180deg, #A87544 0%, #6e4824 100%)',
  border: '3px solid #000',
  borderTop: 'none',
  borderBottomLeftRadius: 14,
  borderBottomRightRadius: 14,
  margin: '-4px auto 0',
}

const feet: React.CSSProperties = {
  display: 'flex',
  justifyContent: 'space-around',
  width: '52%',
  margin: '0 auto',
}

const foot: React.CSSProperties = {
  width: 30,
  height: 8,
  background: '#1a1a1a',
  border: '2px solid #000',
  borderTop: 'none',
  borderBottomLeftRadius: 4,
  borderBottomRightRadius: 4,
}
