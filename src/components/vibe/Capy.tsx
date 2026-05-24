'use client'

import { useState } from 'react'
import Image from 'next/image'

export type CapyPose = 'hi' | 'thinking' | 'celebrating' | 'oops'

const FALLBACK_EMOJI: Record<CapyPose, string> = {
  hi: '🦫',
  thinking: '🤔',
  celebrating: '🦫',
  oops: '😅',
}

export function Capy({ pose = 'hi', size = 28 }: { pose?: CapyPose; size?: number }) {
  const [errored, setErrored] = useState(false)

  if (errored) {
    return <span style={{ fontSize: size * 0.92, lineHeight: 1, display: 'inline-block' }}>{FALLBACK_EMOJI[pose]}</span>
  }

  return (
    <Image
      src={`/capy/${pose}.png`}
      alt={`Capy ${pose}`}
      width={size}
      height={size}
      onError={() => setErrored(true)}
      style={{ flexShrink: 0, objectFit: 'contain' }}
      unoptimized // dev: render whatever is in public/capy/ without next/image processing
    />
  )
}

// Inline bubble — replaces the inline emoji + text capy bubble in dives.
export function CapyBubble({ pose = 'hi', children }: { pose?: CapyPose; children: React.ReactNode }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'flex-start', gap: '0.6rem', marginTop: '1rem',
      padding: '0.85rem 1rem', background: 'var(--surface)', border: '1px solid var(--line)',
      borderRadius: 18, maxWidth: 560, textAlign: 'left',
    }}>
      <Capy pose={pose} size={32} />
      <div style={{ fontSize: '0.92rem', color: 'var(--cream)', lineHeight: 1.5 }}>{children}</div>
    </div>
  )
}
