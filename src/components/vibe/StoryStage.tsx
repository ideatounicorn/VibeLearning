'use client'

import { useState, useEffect, useCallback, useRef } from 'react'
import { motion, AnimatePresence, useMotionValue, useTransform } from 'framer-motion'
import Image from 'next/image'
import type { Panel, Sticky, Bubble } from '@/lib/dive-meet-claude'
import { Capy } from './Capy'
import { TVPlayer } from './TVPlayer'
import StickyStack from './StickyStack'
import SpotItPanel from './SpotItPanel'

// Story stage — panel sequencer.
// Nav: click side-arrows, swipe horizontally, press ← / → keys.
// Pacing: stay until click. Arrow pulses after 8s (no auto-fire).
// Each insight panel adds a sticky to StickyStack.
// Spot panels and big-spot use SpotItPanel.

export default function StoryStage({
  panels,
  onComplete,
}: {
  panels: Panel[]
  onComplete: () => void
}) {
  const [idx, setIdx] = useState(0)
  const [stickies, setStickies] = useState<Sticky[]>([])
  const [highlightedStickies, setHighlightedStickies] = useState<string[]>([])
  const [completedPanels, setCompletedPanels] = useState<Set<string>>(new Set())
  const [pulseArrow, setPulseArrow] = useState(false)
  const x = useMotionValue(0)

  const panel = panels[idx]
  const isFirst = idx === 0
  const isLast = idx === panels.length - 1

  // Reset pulse + start 8s timer per panel
  useEffect(() => {
    setPulseArrow(false)
    const t = setTimeout(() => setPulseArrow(true), 8000)
    return () => clearTimeout(t)
  }, [idx])

  // Add sticky when entering an insight panel
  useEffect(() => {
    if (panel.type === 'insight') {
      const newSticky = panel.addsSticky
      setStickies((s) => s.find((x) => x.id === newSticky.id) ? s : [...s, newSticky])
    }
  }, [idx, panel])

  const next = useCallback(() => {
    if (isLast) {
      onComplete()
      return
    }
    setIdx((i) => i + 1)
  }, [isLast, onComplete])

  const prev = useCallback(() => {
    if (isFirst) return
    setIdx((i) => i - 1)
  }, [isFirst])

  // Keyboard nav
  useEffect(() => {
    const h = (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight' || e.key === ' ') next()
      else if (e.key === 'ArrowLeft') prev()
    }
    window.addEventListener('keydown', h)
    return () => window.removeEventListener('keydown', h)
  }, [next, prev])

  // For spot panels — block forward nav until completed
  const requiresCompletion = panel.type === 'spot' || panel.type === 'big-spot' || panel.type === 'video'
  const canAdvance = !requiresCompletion || completedPanels.has(panel.id)

  const markComplete = useCallback(() => {
    setCompletedPanels((s) => new Set(s).add(panel.id))
    // Small delay before advancing automatically on completion
    setTimeout(() => next(), 600)
  }, [panel.id, next])

  // Big-spot pins a sticky-highlight as user finds each area
  const handlePinSticky = useCallback((label: string) => {
    const matchingSticky = stickies.find((s) => s.label === label)
    if (matchingSticky) {
      setHighlightedStickies((h) => h.includes(matchingSticky.id) ? h : [...h, matchingSticky.id])
    }
  }, [stickies])

  return (
    <div style={shell}>
      {/* Persistent sticky stack */}
      <StickyStack stickies={stickies} highlightedIds={highlightedStickies} />

      {/* Top progress dots */}
      <div style={dotRow}>
        {panels.map((p, i) => (
          <div
            key={p.id}
            style={{
              ...dot,
              background: i === idx ? 'var(--green)' : i < idx ? 'var(--cream)' : 'var(--line)',
              width: i === idx ? 24 : 8,
            }}
          />
        ))}
      </div>

      {/* Swipeable panel area */}
      <motion.div
        style={{ x, ...panelArea }}
        drag="x"
        dragConstraints={{ left: 0, right: 0 }}
        dragElastic={0.2}
        onDragEnd={(_, info) => {
          if (info.offset.x < -80 && canAdvance) next()
          else if (info.offset.x > 80) prev()
        }}
      >
        <AnimatePresence mode="wait">
          <motion.div
            key={panel.id}
            initial={{ opacity: 0, x: 40 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -40 }}
            transition={{ duration: 0.3 }}
            style={panelInner}
          >
            <PanelRender
              panel={panel}
              onSpotComplete={markComplete}
              onPinSticky={handlePinSticky}
            />
          </motion.div>
        </AnimatePresence>
      </motion.div>

      {/* Side arrow buttons (desktop) */}
      {!isFirst && (
        <button onClick={prev} style={{ ...arrowBtn, left: 12 }} aria-label="Previous">
          ←
        </button>
      )}
      {canAdvance && (
        <motion.button
          onClick={next}
          animate={pulseArrow ? { scale: [1, 1.12, 1], boxShadow: ['0 0 0 0 rgba(200,255,0,0.4)', '0 0 0 14px rgba(200,255,0,0)'] } : {}}
          transition={pulseArrow ? { duration: 1.4, repeat: Infinity } : {}}
          style={{ ...arrowBtn, right: 12 }}
          aria-label="Next"
        >
          →
        </motion.button>
      )}

      {/* Mobile: bottom advance hint */}
      <div style={mobileHint}>
        {canAdvance
          ? <span>Swipe or tap → · {idx + 1} of {panels.length}</span>
          : <span>Finish the activity to continue · {idx + 1} of {panels.length}</span>
        }
      </div>
    </div>
  )
}

// ─── Panel renderer (one per panel type) ──────────────────────────────────────

function PanelRender({
  panel,
  onSpotComplete,
  onPinSticky,
}: {
  panel: Panel
  onSpotComplete: () => void
  onPinSticky: (label: string) => void
}) {
  switch (panel.type) {
    case 'cover':       return <CoverPanel p={panel} />
    case 'scene':       return <ScenePanel p={panel} />
    case 'artifact':    return <ArtifactPanel p={panel} />
    case 'insight':     return <InsightPanel p={panel} />
    case 'spot':        return <SpotItPanel image={panel.image} alt={panel.alt} prompt={panel.prompt} hotspots={panel.hotspots} capyHint={panel.capyHint} mode="single" onComplete={onSpotComplete} />
    case 'big-spot':    return <SpotItPanel image={panel.image} alt={panel.alt} prompt={panel.prompt} hotspots={panel.hotspots} capyHint={panel.capyHint} mode="multi" onComplete={onSpotComplete} onPinSticky={(label) => onPinSticky(label)} />
    case 'video':       return <VideoPanel p={panel} onComplete={onSpotComplete} />
    case 'realization': return <RealizationPanel p={panel} />
  }
}

// ─── Cover ────────────────────────────────────────────────────────────────────
function CoverPanel({ p }: { p: Extract<Panel, { type: 'cover' }> }) {
  return (
    <div style={{ ...coverWrap }}>
      {/* Left half — Cap */}
      <motion.div
        initial={{ x: -40, opacity: 0 }}
        animate={{ x: 0, opacity: 1 }}
        transition={{ type: 'spring', stiffness: 140 }}
        style={coverLeft}
      >
        <Capy pose={p.capyPose} size={220} />
      </motion.div>

      {/* Right half — title block */}
      <motion.div
        initial={{ x: 40, opacity: 0 }}
        animate={{ x: 0, opacity: 1 }}
        transition={{ type: 'spring', stiffness: 140, delay: 0.1 }}
        style={coverRight}
      >
        <div style={topicChip}>● {p.topicChip}</div>
        <h1 style={coverTitle}>{p.title}</h1>
        <p style={coverSubtitle}>{p.subtitle}</p>
        <div style={{ marginTop: '1.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.78rem', color: 'var(--muted)', letterSpacing: '0.15em' }}>
          <span style={{ width: 10, height: 10, borderRadius: '50%', background: 'var(--green)', display: 'inline-block' }} />
          <span>DURATION: {p.duration}</span>
        </div>
        <div style={navHint}>
          Use <kbd style={kbd}>→</kbd> or click the arrow to view the story
        </div>
      </motion.div>
    </div>
  )
}

// ─── Scene ────────────────────────────────────────────────────────────────────
function ScenePanel({ p }: { p: Extract<Panel, { type: 'scene' }> }) {
  const bgGradient =
    p.bgTint === 'warm' ? 'linear-gradient(180deg, #2a1a0a 0%, var(--bg) 100%)' :
    p.bgTint === 'cool' ? 'linear-gradient(180deg, #0a1a2a 0%, var(--bg) 100%)' :
    'var(--bg)'

  return (
    <div style={{ ...sceneWrap, background: bgGradient }}>
      {p.visual && p.visual.kind === 'emoji' && (
        <motion.div
          initial={{ scale: 0.5, rotate: -8 }}
          animate={{ scale: 1, rotate: 0 }}
          transition={{ type: 'spring', stiffness: 140 }}
          style={{ fontSize: 'clamp(5rem, 14vw, 9rem)', lineHeight: 1, marginBottom: '2rem' }}
        >
          {p.visual.value}
        </motion.div>
      )}

      <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', maxWidth: 640, width: '100%' }}>
        {p.bubbles.map((b, i) => (
          <BubbleRender key={i} bubble={b} delay={i * 0.2} />
        ))}
      </div>
    </div>
  )
}

// ─── Artifact ─────────────────────────────────────────────────────────────────
function ArtifactPanel({ p }: { p: Extract<Panel, { type: 'artifact' }> }) {
  return (
    <div style={artifactWrap}>
      <div style={artifactImageWrap}>
        <Image
          src={p.image}
          alt={p.alt}
          width={1200}
          height={750}
          unoptimized
          style={{ width: '100%', height: 'auto', display: 'block', borderRadius: 10 }}
        />
        {/* Arrow annotations on the artifact */}
        {p.arrows?.map((a, i) => (
          <motion.div
            key={i}
            initial={{ opacity: 0, scale: 0.6 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.4 + i * 0.2 }}
            style={{
              position: 'absolute',
              left: `${a.x}%`, top: `${a.y}%`,
              background: '#F5E1A4', color: '#000',
              border: '2.5px solid #000', borderRadius: 6,
              padding: '0.3rem 0.65rem',
              fontSize: '0.78rem', fontWeight: 800,
              boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
              transform: `rotate(${-2 + i * 1.5}deg)`,
              whiteSpace: 'nowrap',
            }}
          >
            {a.label}
          </motion.div>
        ))}
      </div>
      {p.caption && <div style={artifactCaption}>{p.caption}</div>}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%', maxWidth: 640 }}>
        {p.bubbles.map((b, i) => <BubbleRender key={i} bubble={b} delay={0.3 + i * 0.15} />)}
      </div>
    </div>
  )
}

// ─── Insight ──────────────────────────────────────────────────────────────────
function InsightPanel({ p }: { p: Extract<Panel, { type: 'insight' }> }) {
  return (
    <div style={insightWrap}>
      <motion.div
        initial={{ opacity: 0, x: 50, rotate: 2 }}
        animate={{ opacity: 1, x: 0, rotate: 0 }}
        transition={{ type: 'spring', stiffness: 140, damping: 18 }}
        style={insightCard}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.75rem' }}>
          <span style={{ fontSize: '1.8rem' }}>{p.emoji}</span>
          <span style={{ fontSize: '0.7rem', letterSpacing: '0.25em', color: 'var(--green)', fontWeight: 900 }}>
            {p.label}
          </span>
        </div>
        <h2 style={{ fontSize: 'clamp(1.6rem, 4vw, 2.2rem)', fontWeight: 900, color: 'var(--cream)', margin: '0 0 0.75rem', letterSpacing: '-0.01em' }}>
          {p.title}
        </h2>
        <p style={{ fontSize: '1rem', color: 'var(--cream)', lineHeight: 1.6, margin: 0 }}>
          {p.body}
        </p>
        <div style={insightSource}>— {p.source}</div>
      </motion.div>

      <motion.div
        initial={{ opacity: 0, y: 12 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.6 }}
        style={{ fontSize: '0.8rem', color: 'var(--muted)', marginTop: '1.5rem', textAlign: 'center' }}
      >
        ✦ <strong style={{ color: 'var(--green)' }}>{p.addsSticky.label}</strong> pinned to your stack
      </motion.div>
    </div>
  )
}

// ─── Video ────────────────────────────────────────────────────────────────────
function VideoPanel({ p, onComplete }: { p: Extract<Panel, { type: 'video' }>; onComplete: () => void }) {
  const [spotted, setSpotted] = useState<Set<string>>(new Set())

  const toggle = (id: string) => {
    const s = new Set(spotted)
    if (s.has(id)) s.delete(id); else s.add(id)
    setSpotted(s)
    if (s.size === p.parallelCards.length) {
      setTimeout(onComplete, 600)
    }
  }

  return (
    <div style={videoWrap}>
      <div style={{ flex: '1 1 600px', minWidth: 0 }}>
        <TVPlayer youtubeId={p.youtubeId} caption={`${p.title} · ${p.creator} · ${p.duration}`} />
      </div>
      <div style={{ flex: '0 1 240px', display: 'flex', flexDirection: 'column', gap: '0.6rem' }}>
        <div style={{ fontSize: '0.65rem', letterSpacing: '0.22em', textTransform: 'uppercase', color: 'var(--green)', fontWeight: 900 }}>
          👀 Spot each scene
        </div>
        {p.parallelCards.map((c) => {
          const done = spotted.has(c.stickyId)
          return (
            <motion.button
              key={c.stickyId}
              whileTap={{ scale: 0.97 }}
              onClick={() => toggle(c.stickyId)}
              style={{
                padding: '0.65rem 0.8rem', borderRadius: 10, textAlign: 'left', cursor: 'pointer',
                background: done ? 'rgba(200,255,0,0.12)' : 'var(--surface)',
                border: `1.5px solid ${done ? 'var(--green)' : 'var(--line)'}`,
                color: 'var(--cream)', fontSize: '0.82rem', lineHeight: 1.4, fontWeight: 600,
              }}
            >
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                <span style={{
                  width: 18, height: 18, borderRadius: 5, flexShrink: 0,
                  background: done ? 'var(--green)' : 'transparent',
                  border: `2px solid ${done ? 'var(--green)' : 'var(--line)'}`,
                  color: '#000', fontWeight: 900, fontSize: '0.72rem',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                }}>{done ? '✓' : ''}</span>
                <span style={{ fontWeight: 700, fontSize: '0.78rem' }}>{c.label}</span>
              </div>
              <div style={{ fontSize: '0.7rem', color: 'var(--muted)', marginTop: 4, marginLeft: 26 }}>{c.sceneHint}</div>
            </motion.button>
          )
        })}
        <div style={{ fontSize: '0.7rem', color: 'var(--muted)', marginTop: '0.5rem', textAlign: 'center' }}>
          {spotted.size === p.parallelCards.length ? '✓ all spotted — advancing…' : `${spotted.size} / ${p.parallelCards.length} spotted`}
        </div>
      </div>
    </div>
  )
}

// ─── Realization ──────────────────────────────────────────────────────────────
function RealizationPanel({ p }: { p: Extract<Panel, { type: 'realization' }> }) {
  return (
    <div style={realWrap}>
      <motion.div initial={{ scale: 0.7, rotate: -8 }} animate={{ scale: 1, rotate: 0 }} transition={{ type: 'spring', stiffness: 140 }}>
        <Capy pose={p.capyPose} size={110} />
      </motion.div>
      <motion.h1
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.3 }}
        style={{ fontSize: 'clamp(1.8rem, 5vw, 3rem)', fontWeight: 900, color: 'var(--cream)', textAlign: 'center', lineHeight: 1.2, letterSpacing: '-0.02em', margin: '1.5rem 0 1rem', maxWidth: 760 }}
      >
        {p.big}
      </motion.h1>
      <motion.p
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.6 }}
        style={{ fontSize: '1.15rem', color: 'var(--muted)', textAlign: 'center', maxWidth: 560, lineHeight: 1.55 }}
      >
        {p.small}
      </motion.p>
    </div>
  )
}

// ─── Bubble ───────────────────────────────────────────────────────────────────
function BubbleRender({ bubble, delay = 0 }: { bubble: Bubble; delay?: number }) {
  const isCap = bubble.from === 'cap'
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay, type: 'spring', stiffness: 140 }}
      style={{
        display: 'flex',
        gap: '0.6rem',
        alignItems: 'flex-start',
        flexDirection: bubble.position === 'right' ? 'row-reverse' : 'row',
      }}
    >
      {isCap && <Capy pose={bubble.pose || 'hi'} size={44} />}
      <div style={{
        background: '#fff', color: '#000',
        border: '2.5px solid #000', borderRadius: 14,
        padding: '0.7rem 0.95rem',
        fontSize: '1rem', fontWeight: 600, lineHeight: 1.45,
        boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
        maxWidth: 480,
      }}
        dangerouslySetInnerHTML={{ __html: renderInline(bubble.text) }}
      />
    </motion.div>
  )
}

function renderInline(text: string) {
  return text
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/`([^`]+)`/g, '<code style="background:#f0f0f0;padding:1px 5px;border-radius:4px;font-size:0.88em;border:1px solid #ccc;font-family:ui-monospace,monospace;color:#000">$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
}

// ─── Styles ───────────────────────────────────────────────────────────────────

const shell: React.CSSProperties = {
  position: 'relative', width: '100%', height: '100%',
  display: 'flex', flexDirection: 'column',
}

const dotRow: React.CSSProperties = {
  position: 'absolute', top: 12, left: 0, right: 0,
  display: 'flex', justifyContent: 'center', gap: 4,
  zIndex: 20, pointerEvents: 'none',
}

const dot: React.CSSProperties = {
  height: 4, borderRadius: 2,
  transition: 'all 0.3s ease',
}

const panelArea: React.CSSProperties = {
  flex: 1, overflow: 'auto', position: 'relative',
}

const panelInner: React.CSSProperties = {
  minHeight: '100%', display: 'flex', flexDirection: 'column',
  padding: '3rem 1.5rem 5rem',
  alignItems: 'center', justifyContent: 'center',
}

const arrowBtn: React.CSSProperties = {
  position: 'absolute',
  top: '50%', transform: 'translateY(-50%)',
  width: 48, height: 48, borderRadius: '50%',
  background: 'var(--surface)', color: 'var(--cream)',
  border: '2px solid var(--line)', fontSize: '1.4rem',
  cursor: 'pointer', zIndex: 30,
  display: 'flex', alignItems: 'center', justifyContent: 'center',
  fontWeight: 900,
}

const mobileHint: React.CSSProperties = {
  position: 'absolute', bottom: 14, left: 0, right: 0,
  textAlign: 'center', fontSize: '0.7rem', color: 'var(--muted)',
  letterSpacing: '0.15em', textTransform: 'uppercase', fontWeight: 700,
  pointerEvents: 'none',
}

// Cover
const coverWrap: React.CSSProperties = {
  display: 'flex', flexDirection: 'row', alignItems: 'center', justifyContent: 'center',
  gap: '2rem', flexWrap: 'wrap', width: '100%', maxWidth: 980,
  background: 'radial-gradient(ellipse at center, rgba(200,255,0,0.04) 0%, transparent 70%)',
}

const coverLeft: React.CSSProperties = {
  flex: '0 1 280px', display: 'flex', justifyContent: 'center', alignItems: 'center',
  minHeight: 280,
}

const coverRight: React.CSSProperties = {
  flex: '1 1 360px', textAlign: 'left',
}

const topicChip: React.CSSProperties = {
  display: 'inline-block',
  background: 'rgba(200,255,0,0.12)', color: 'var(--green)',
  border: '1.5px solid rgba(200,255,0,0.4)', borderRadius: 999,
  padding: '0.3rem 0.85rem',
  fontSize: '0.72rem', fontWeight: 800, letterSpacing: '0.2em',
  marginBottom: '1rem',
}

const coverTitle: React.CSSProperties = {
  fontFamily: 'var(--font-serif, Georgia), serif',
  fontSize: 'clamp(2.2rem, 6vw, 3.8rem)',
  fontWeight: 900, color: 'var(--cream)',
  letterSpacing: '-0.02em', lineHeight: 1.05,
  margin: '0 0 0.85rem',
}

const coverSubtitle: React.CSSProperties = {
  fontStyle: 'italic', fontSize: 'clamp(1rem, 2.5vw, 1.3rem)',
  color: 'var(--muted)', lineHeight: 1.45, margin: 0,
}

const navHint: React.CSSProperties = {
  marginTop: '2rem', fontSize: '0.78rem', color: 'var(--muted)',
  display: 'flex', alignItems: 'center', gap: '0.4rem',
}

const kbd: React.CSSProperties = {
  background: 'var(--surface)', color: 'var(--cream)',
  border: '1.5px solid var(--line)', borderRadius: 5,
  padding: '0.15rem 0.5rem', fontSize: '0.85rem',
  fontFamily: 'ui-monospace, monospace',
}

// Scene
const sceneWrap: React.CSSProperties = {
  display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
  width: '100%', maxWidth: 760,
  padding: '2rem 1rem', borderRadius: 18,
  minHeight: 320,
}

// Artifact
const artifactWrap: React.CSSProperties = {
  display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '1rem',
  width: '100%', maxWidth: 920,
}

const artifactImageWrap: React.CSSProperties = {
  position: 'relative', width: '100%',
  border: '3px solid var(--line)', borderRadius: 14,
  background: 'var(--surface)', overflow: 'hidden',
}

const artifactCaption: React.CSSProperties = {
  fontSize: '0.75rem', letterSpacing: '0.15em', textTransform: 'uppercase',
  color: 'var(--muted)', fontFamily: 'ui-monospace, monospace',
}

// Insight
const insightWrap: React.CSSProperties = {
  display: 'flex', flexDirection: 'column', alignItems: 'center',
  width: '100%', maxWidth: 640,
}

const insightCard: React.CSSProperties = {
  width: '100%',
  background: 'var(--surface)', border: '3px solid var(--green)',
  borderRadius: 16, padding: '1.5rem 1.6rem',
  boxShadow: '6px 6px 0 rgba(200,255,0,0.18)',
  textAlign: 'left',
}

const insightSource: React.CSSProperties = {
  marginTop: '1rem', paddingTop: '0.85rem',
  borderTop: '1px solid var(--line)',
  fontSize: '0.78rem', color: 'var(--muted)',
  fontStyle: 'italic',
}

// Video
const videoWrap: React.CSSProperties = {
  display: 'flex', gap: '1.25rem', flexWrap: 'wrap',
  width: '100%', maxWidth: 1080, alignItems: 'flex-start',
}

// Realization
const realWrap: React.CSSProperties = {
  display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
  width: '100%', maxWidth: 800,
  background: 'radial-gradient(ellipse at center, rgba(200,255,0,0.08) 0%, transparent 70%)',
  padding: '2rem 1rem', borderRadius: 18, minHeight: 360,
}
