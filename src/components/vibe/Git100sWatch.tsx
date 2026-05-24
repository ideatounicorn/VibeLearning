'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { GIT_100S_DIVE as D } from '@/lib/dive-git-100s'
import { TVPlayer } from './TVPlayer'
import { Capy } from './Capy'

// Watch stage — fully redesigned.
// Goal: every element pushes user to finish the video.
// Desktop: 3 columns. Mobile: stacked.

const HUNT_EXPLAINERS = [
  { hint: 'Snapshot = a labeled photo of all your code, right now. Git keeps every one forever.', cap: 'You got the most important word in git.' },
  { hint: 'When the timeline forks into a Y, that’s a branch. A "what if" version that doesn’t touch main.', cap: 'Branches feel scary until you see one. Now you have.' },
  { hint: '`push` = your laptop → team. `pull` = team → your laptop. Direction is everything.', cap: 'You won’t mix these up again.' },
]

export default function Git100sWatch({ onNext }: { onNext: () => void }) {
  const [hunted, setHunted] = useState<Set<number>>(new Set())
  const isDesktop = useIsDesktop()

  const toggle = (i: number) => {
    const s = new Set(hunted)
    if (s.has(i)) s.delete(i)
    else s.add(i)
    setHunted(s)
  }

  const confidence = Math.round((hunted.size / 3) * 100)
  const ctaArmed = hunted.size >= 1

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.35 }}
      style={{
        maxWidth: 1280, margin: '0 auto', padding: '1.5rem 1rem 4rem', width: '100%',
      }}
    >
      <PlacardCentered>Cap is watching with you</PlacardCentered>

      <div
        style={{
          display: 'grid',
          gridTemplateColumns: isDesktop ? '280px minmax(0, 1fr) 280px' : '1fr',
          gap: isDesktop ? '1.25rem' : '1rem',
          alignItems: 'start',
          marginTop: '1.5rem',
        }}
      >
        {/* ─── LEFT PANEL ─────────────────────────────────────────────── */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
          <HuntPanel hunted={hunted} onToggle={toggle} />
          <ConfidenceMeter pct={confidence} />
          <RejectPile />
        </div>

        {/* ─── CENTER: TV ─────────────────────────────────────────────── */}
        <div>
          <TVPlayer
            youtubeId={D.video.youtubeId}
            caption={`${D.video.title} · ${D.video.creator}`}
          />
          {/* CTA right under TV */}
          <div style={{ display: 'flex', justifyContent: 'center', marginTop: '1.5rem' }}>
            <CTAButton armed={ctaArmed} onClick={onNext} hunted={hunted.size}>
              {hunted.size === 0 ? 'Tick at least one hunt to continue' :
               hunted.size === 3 ? 'You got all three — done →' :
               `I watched it (${hunted.size}/3 spotted) →`}
            </CTAButton>
          </div>
        </div>

        {/* ─── RIGHT PANEL ────────────────────────────────────────────── */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
          <CapyOnCouch huntedCount={hunted.size} />
          <CoWatchers />
          <NextUp />
        </div>
      </div>
    </motion.div>
  )
}

// ═══ Hunt panel ═══════════════════════════════════════════════════════════════

function HuntPanel({ hunted, onToggle }: { hunted: Set<number>; onToggle: (i: number) => void }) {
  return (
    <div style={panelCard}>
      <PanelHeader emoji="👀" label="THE HUNT" />
      <p style={panelLede}>Spot these in the video. Tap when you hear them.</p>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.55rem', marginTop: '0.85rem' }}>
        {D.video.watchFor.map((w, i) => {
          const checked = hunted.has(i)
          return (
            <motion.button
              key={i}
              onClick={() => onToggle(i)}
              whileTap={{ scale: 0.97 }}
              style={{
                ...huntItem,
                background: checked ? 'rgba(200,255,0,0.1)' : 'var(--bg)',
                borderColor: checked ? 'var(--green)' : 'var(--line)',
              }}
            >
              <div style={{ display: 'flex', gap: '0.6rem', alignItems: 'flex-start' }}>
                <motion.div
                  animate={checked ? { scale: [1, 1.3, 1], rotate: [0, 360] } : {}}
                  transition={{ duration: 0.5 }}
                  style={{
                    width: 22, height: 22, borderRadius: 6, flexShrink: 0,
                    border: '2px solid', borderColor: checked ? 'var(--green)' : 'var(--line)',
                    background: checked ? 'var(--green)' : 'transparent',
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    color: '#000', fontWeight: 900, fontSize: '0.85rem',
                  }}
                >
                  {checked ? '✓' : ''}
                </motion.div>
                <div style={{ flex: 1, textAlign: 'left' }}>
                  <div style={{
                    fontSize: '0.82rem', fontWeight: 700, color: 'var(--cream)',
                    lineHeight: 1.4, textDecoration: checked ? 'line-through' : 'none',
                    textDecorationColor: 'var(--green)', textDecorationThickness: 2,
                  }}>
                    <Inline text={w} />
                  </div>
                </div>
              </div>

              <AnimatePresence>
                {checked && (
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{ height: 'auto', opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }}
                    style={{ overflow: 'hidden' }}
                  >
                    <div style={{
                      marginTop: '0.65rem', padding: '0.55rem 0.7rem',
                      background: 'var(--surface)', border: '1px solid var(--line)',
                      borderRadius: 8, fontSize: '0.78rem', color: 'var(--cream)',
                      lineHeight: 1.5, textAlign: 'left',
                    }}>
                      <Inline text={HUNT_EXPLAINERS[i].hint} />
                      <div style={{ marginTop: '0.4rem', color: 'var(--green)', fontWeight: 700, fontSize: '0.72rem' }}>
                        — Cap: “{HUNT_EXPLAINERS[i].cap}”
                      </div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.button>
          )
        })}
      </div>
    </div>
  )
}

function ConfidenceMeter({ pct }: { pct: number }) {
  const label = pct === 100 ? 'Locked in' : pct >= 66 ? 'Almost' : pct >= 33 ? 'Warming up' : 'Just starting'
  return (
    <div style={{ ...panelCard, paddingTop: '0.85rem', paddingBottom: '0.85rem' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', marginBottom: '0.5rem' }}>
        <span style={{ fontSize: '0.65rem', letterSpacing: '0.2em', textTransform: 'uppercase', color: 'var(--muted)', fontWeight: 700 }}>
          Confidence
        </span>
        <span style={{ fontSize: '0.78rem', fontWeight: 800, color: 'var(--green)' }}>{label}</span>
      </div>
      <div style={{ height: 8, background: 'var(--bg)', border: '1px solid var(--line)', borderRadius: 999, overflow: 'hidden' }}>
        <motion.div
          animate={{ width: `${pct}%` }}
          transition={{ type: 'spring', stiffness: 120, damping: 18 }}
          style={{
            height: '100%',
            background: 'linear-gradient(90deg, var(--green) 0%, #FFE680 100%)',
          }}
        />
      </div>
      <div style={{ fontSize: '0.72rem', color: 'var(--muted)', marginTop: '0.4rem' }}>{pct}% of hunt spotted</div>
    </div>
  )
}

function RejectPile() {
  return (
    <div style={panelCard}>
      <PanelHeader emoji="🗂️" label="THE PILE" />
      <p style={panelLede}>Cap watched 47 git videos. Here’s the pile he rejected.</p>

      <div style={{ position: 'relative', height: 78, marginTop: '0.6rem' }}>
        {/* Stack of rejected videos */}
        {[0, 1, 2, 3, 4].map((i) => (
          <div key={i} style={{
            position: 'absolute',
            top: 22 + i * 1.5, left: 8 + i * 4, right: 70 - i * 4,
            height: 36, background: ['#3a2a2a', '#4a2a2a', '#5a2a2a', '#6a2a2a', '#7a2a2a'][i],
            border: '1.5px solid #000', borderRadius: 4,
            transform: `rotate(${-2 + i * 0.8}deg)`,
            display: 'flex', alignItems: 'center', justifyContent: 'flex-end', paddingRight: 8,
            opacity: 0.75 - i * 0.1,
          }}>
            <span style={{ color: '#FF6B51', fontSize: '1.4rem', fontWeight: 900 }}>✕</span>
          </div>
        ))}
        {/* The chosen one */}
        <motion.div
          animate={{ rotate: [-1, 1, -1] }}
          transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
          style={{
            position: 'absolute',
            top: 0, right: 0,
            width: 80, height: 56, background: '#c8ff00',
            border: '2.5px solid #000', borderRadius: 6,
            boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            color: '#000', fontWeight: 900, fontSize: '0.7rem', textAlign: 'center',
            lineHeight: 1.1,
          }}
        >
          ★<br/>THIS<br/>ONE
        </motion.div>
      </div>
      <div style={{ fontSize: '0.7rem', color: 'var(--muted)', marginTop: '0.55rem', fontStyle: 'italic', textAlign: 'center' }}>
        46 rejected · 1 kept
      </div>
    </div>
  )
}

// ═══ Right panel ══════════════════════════════════════════════════════════════

function CapyOnCouch({ huntedCount }: { huntedCount: number }) {
  const pose = huntedCount === 0 ? 'thinking' : huntedCount === 3 ? 'celebrating' : 'hi'
  const line =
    huntedCount === 0 ? 'I’m watching too. Just here. No pressure.' :
    huntedCount === 1 ? 'Nice spot. Two more.' :
    huntedCount === 2 ? 'Almost a full house.' :
    'You caught all three. I’m proud.'

  return (
    <div style={{ ...panelCard, padding: '1rem 1rem 0.85rem' }}>
      <PanelHeader emoji="🛋️" label="CO-WATCHING" />

      {/* Capy on couch scene */}
      <div style={{
        background: 'var(--bg)', border: '1px solid var(--line)', borderRadius: 12,
        padding: '1rem 0.8rem 0.5rem', marginTop: '0.55rem',
        display: 'flex', alignItems: 'flex-end', justifyContent: 'center',
        position: 'relative', minHeight: 132,
      }}>
        {/* Popcorn bowl (left) */}
        <div style={{
          position: 'absolute', bottom: 22, left: 14,
          width: 38, height: 26,
          background: 'linear-gradient(180deg, #FFE680 0%, #FFB58A 100%)',
          border: '2.5px solid #000',
          borderRadius: '0 0 18px 18px',
          boxShadow: '2px 2px 0 rgba(0,0,0,0.7)',
        }}>
          {/* popcorn puffs */}
          <div style={{ position: 'absolute', top: -8, left: 4, width: 10, height: 10, borderRadius: '50%', background: '#fff', border: '1.5px solid #000' }} />
          <div style={{ position: 'absolute', top: -10, left: 14, width: 10, height: 10, borderRadius: '50%', background: '#fff', border: '1.5px solid #000' }} />
          <div style={{ position: 'absolute', top: -8, right: 4, width: 10, height: 10, borderRadius: '50%', background: '#fff', border: '1.5px solid #000' }} />
        </div>

        {/* Capy seated */}
        <motion.div
          animate={{ y: [0, -2, 0] }}
          transition={{ duration: 2.4, repeat: Infinity, ease: 'easeInOut' }}
          style={{ position: 'relative', zIndex: 2 }}
        >
          <Capy pose={pose} size={88} />
        </motion.div>

        {/* Couch base */}
        <div style={{
          position: 'absolute', bottom: 0, left: '10%', right: '10%',
          height: 22, background: 'linear-gradient(180deg, #C084FC 0%, #8a5cc0 100%)',
          border: '2.5px solid #000',
          borderTopLeftRadius: 14, borderTopRightRadius: 14,
        }}>
          {/* couch arm rests */}
          <div style={{ position: 'absolute', bottom: 0, left: -8, width: 14, height: 24, background: '#C084FC', border: '2.5px solid #000', borderRadius: 6 }} />
          <div style={{ position: 'absolute', bottom: 0, right: -8, width: 14, height: 24, background: '#C084FC', border: '2.5px solid #000', borderRadius: 6 }} />
        </div>
      </div>

      <motion.div
        key={line}
        initial={{ opacity: 0, y: 4 }} animate={{ opacity: 1, y: 0 }}
        style={{
          marginTop: '0.7rem', padding: '0.55rem 0.75rem',
          background: 'var(--bg)', border: '1px dashed var(--line)', borderRadius: 10,
          fontSize: '0.8rem', color: 'var(--cream)', lineHeight: 1.45, fontStyle: 'italic',
          textAlign: 'center',
        }}
      >
        “{line}”
      </motion.div>
    </div>
  )
}

function CoWatchers() {
  const [count, setCount] = useState(3)
  useEffect(() => {
    const t = setInterval(() => setCount((c) => Math.max(1, c + (Math.random() > 0.5 ? 1 : -1))), 4500)
    return () => clearInterval(t)
  }, [])
  return (
    <div style={panelCard}>
      <PanelHeader emoji="👥" label="ALSO WATCHING" />
      <div style={{ display: 'flex', gap: -8, marginTop: '0.6rem', alignItems: 'center' }}>
        {[
          { initials: 'PR', color: '#FFB58A' },
          { initials: 'AJ', color: '#A8E6CF' },
          { initials: 'MK', color: '#C084FC' },
          { initials: 'EL', color: '#F5E1A4' },
        ].slice(0, Math.min(4, count + 1)).map((u, i) => (
          <div key={i} style={{
            width: 28, height: 28, borderRadius: '50%', background: u.color,
            border: '2px solid #000', color: '#000', fontWeight: 800, fontSize: '0.65rem',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            marginLeft: i === 0 ? 0 : -8,
            boxShadow: '1px 1px 0 rgba(0,0,0,0.6)',
          }}>
            {u.initials}
          </div>
        ))}
      </div>
      <div style={{ marginTop: '0.55rem', fontSize: '0.78rem', color: 'var(--cream)' }}>
        <strong style={{ color: 'var(--green)' }}>{count}</strong> {count === 1 ? 'person' : 'people'} on this dive right now
      </div>
    </div>
  )
}

function NextUp() {
  return (
    <div style={panelCard}>
      <PanelHeader emoji="📋" label="UP NEXT" />
      <div style={{ display: 'flex', flexDirection: 'column', gap: '0.45rem', marginTop: '0.55rem' }}>
        <NextRow num="1" label="Recap (5 cards)" />
        <NextRow num="2" label="5 quick questions" />
        <NextRow num="3" label="Your receipt" trophy />
      </div>
      <motion.div
        initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.4 }}
        style={{
          marginTop: '0.85rem', padding: '0.7rem 0.8rem',
          background: '#c8ff00', color: '#000',
          border: '2.5px solid #000', borderRadius: 10,
          boxShadow: '2px 2px 0 rgba(0,0,0,0.85)',
          transform: 'rotate(-1.5deg)',
          fontSize: '0.78rem', fontWeight: 800, textAlign: 'center',
        }}
      >
        ✦ Your receipt is being printed…
      </motion.div>
    </div>
  )
}

function NextRow({ num, label, trophy }: { num: string; label: string; trophy?: boolean }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'center', gap: '0.55rem',
      padding: '0.5rem 0.65rem', background: 'var(--bg)',
      border: '1px solid var(--line)', borderRadius: 8,
    }}>
      <div style={{
        width: 20, height: 20, borderRadius: '50%',
        background: trophy ? 'var(--green)' : 'var(--surface)',
        border: '1.5px solid var(--line)', color: trophy ? '#000' : 'var(--muted)',
        fontSize: '0.7rem', fontWeight: 900,
        display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
      }}>
        {trophy ? '🏆' : num}
      </div>
      <div style={{ fontSize: '0.8rem', color: 'var(--cream)', fontWeight: 600 }}>{label}</div>
    </div>
  )
}

// ═══ CTA ══════════════════════════════════════════════════════════════════════

function CTAButton({ armed, onClick, children, hunted }: { armed: boolean; onClick: () => void; children: React.ReactNode; hunted: number }) {
  return (
    <motion.button
      whileHover={armed ? { scale: 1.04 } : {}}
      whileTap={armed ? { scale: 0.96 } : {}}
      onClick={armed ? onClick : undefined}
      animate={hunted === 3 ? { boxShadow: ['0 0 0 0 rgba(200,255,0,0.4)', '0 0 0 12px rgba(200,255,0,0)'] } : {}}
      transition={hunted === 3 ? { duration: 1.4, repeat: Infinity } : {}}
      style={{
        padding: '1rem 1.85rem',
        background: armed ? 'var(--green)' : 'var(--surface)',
        color: armed ? '#000' : 'var(--muted)',
        border: armed ? 'none' : '2px dashed var(--line)',
        borderRadius: 999, fontWeight: 800, fontSize: '1.02rem',
        cursor: armed ? 'pointer' : 'not-allowed', letterSpacing: '-0.01em',
      }}
    >
      {children}
    </motion.button>
  )
}

// ═══ Building blocks ══════════════════════════════════════════════════════════

function PanelHeader({ emoji, label }: { emoji: string; label: string }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem' }}>
      <span style={{ fontSize: '0.95rem' }}>{emoji}</span>
      <span style={{ fontSize: '0.65rem', letterSpacing: '0.22em', textTransform: 'uppercase', color: 'var(--green)', fontWeight: 800 }}>
        {label}
      </span>
    </div>
  )
}

function PlacardCentered({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ display: 'flex', justifyContent: 'center' }}>
      <motion.div
        initial={{ opacity: 0, y: -8, rotate: -6 }}
        animate={{ opacity: 1, y: 0, rotate: 2 }}
        transition={{ type: 'spring', stiffness: 120 }}
        style={{
          display: 'inline-block', background: '#F5E1A4', color: '#000',
          padding: '0.45rem 1.1rem', borderRadius: 6, fontWeight: 800, fontSize: '0.82rem',
          letterSpacing: '0.04em', border: '2.5px solid #000',
          boxShadow: '3px 3px 0 rgba(0,0,0,0.85)',
        }}
      >
        {children}
      </motion.div>
    </div>
  )
}

function Inline({ text }: { text: string }) {
  const html = text
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/`([^`]+)`/g, '<code style="background:var(--surface);padding:1px 6px;border-radius:4px;font-size:0.88em;border:1px solid var(--line);font-family:ui-monospace,monospace;color:var(--cream)">$1</code>')
  return <span dangerouslySetInnerHTML={{ __html: html }} />
}

// ═══ Media query hook ═════════════════════════════════════════════════════════
function useIsDesktop() {
  const [isDesktop, setIsDesktop] = useState(false)
  useEffect(() => {
    const mq = window.matchMedia('(min-width: 1024px)')
    const update = () => setIsDesktop(mq.matches)
    update()
    mq.addEventListener('change', update)
    return () => mq.removeEventListener('change', update)
  }, [])
  return isDesktop
}

// ═══ Styles ═══════════════════════════════════════════════════════════════════
const panelCard: React.CSSProperties = {
  background: 'var(--surface)', border: '1px solid var(--line)',
  borderRadius: 14, padding: '0.95rem 1rem',
}

const panelLede: React.CSSProperties = {
  fontSize: '0.78rem', color: 'var(--muted)', lineHeight: 1.45,
  margin: '0.35rem 0 0',
}

const huntItem: React.CSSProperties = {
  width: '100%', textAlign: 'left',
  background: 'var(--bg)', border: '1.5px solid var(--line)',
  borderRadius: 10, padding: '0.6rem 0.7rem',
  cursor: 'pointer',
}
