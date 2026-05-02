'use client'

import { useState } from 'react'
import { supabase } from '@/lib/supabase'

interface AuthModalProps {
  mode: 'signin' | 'signup'
  onClose: () => void
  onSuccess: () => void
  redirectSlug?: string
}

export default function AuthModal({ mode, onClose, onSuccess, redirectSlug }: AuthModalProps) {
  const [activeMode, setActiveMode] = useState(mode)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [name, setName] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const db = supabase()

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')

    try {
      if (activeMode === 'signup') {
        const { error } = await db.auth.signUp({
          email,
          password,
          options: { data: { full_name: name } },
        })
        if (error) throw error
      } else {
        const { error } = await db.auth.signInWithPassword({ email, password })
        if (error) throw error
      }
      onSuccess()
      window.location.href = redirectSlug ? `/paths/${redirectSlug}` : '/dashboard'
    } catch (err: unknown) {
      setError((err as Error).message)
    } finally {
      setLoading(false)
    }
  }

  const handleGoogle = async () => {
    const next = redirectSlug ? `/paths/${redirectSlug}` : '/dashboard'
    await db.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: `${window.location.origin}/auth/callback?next=${encodeURIComponent(next)}`,
      },
    })
  }

  return (
    <div
      onClick={onClose}
      style={{
        position: 'fixed',
        inset: 0,
        background: 'rgba(0,0,0,0.7)',
        zIndex: 2000,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '1rem',
      }}
    >
      <div
        onClick={e => e.stopPropagation()}
        style={{
          background: 'var(--dim)',
          border: '1px solid var(--line)',
          borderRadius: 20,
          padding: '2rem',
          width: '100%',
          maxWidth: 420,
          position: 'relative',
        }}
      >
        {/* Close */}
        <button
          onClick={onClose}
          style={{
            position: 'absolute',
            top: '1rem',
            right: '1rem',
            background: 'none',
            border: 'none',
            color: 'var(--muted)',
            cursor: 'pointer',
            fontSize: '1.2rem',
          }}
        >
          ×
        </button>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1.5rem' }}>
          {(['signup', 'signin'] as const).map(m => (
            <button
              key={m}
              onClick={() => setActiveMode(m)}
              style={{
                flex: 1,
                padding: '0.5rem',
                borderRadius: 8,
                border: 'none',
                cursor: 'pointer',
                background: activeMode === m ? 'rgba(244,239,228,0.1)' : 'transparent',
                color: activeMode === m ? 'var(--cream)' : 'var(--muted)',
                fontWeight: activeMode === m ? 600 : 400,
                fontSize: '0.9rem',
              }}
            >
              {m === 'signup' ? 'Create account' : 'Sign in'}
            </button>
          ))}
        </div>

        {/* Google OAuth */}
        <button
          onClick={handleGoogle}
          style={{
            width: '100%',
            padding: '0.7rem',
            borderRadius: 10,
            border: '1.5px solid var(--line)',
            background: 'transparent',
            color: 'var(--cream)',
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '0.5rem',
            fontSize: '0.9rem',
            marginBottom: '1.25rem',
          }}
        >
          <svg width="18" height="18" viewBox="0 0 24 24">
            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
          </svg>
          Continue with Google
        </button>

        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.25rem' }}>
          <div style={{ flex: 1, height: 1, background: 'var(--line)' }} />
          <span style={{ color: 'var(--muted)', fontSize: '0.8rem' }}>or</span>
          <div style={{ flex: 1, height: 1, background: 'var(--line)' }} />
        </div>

        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
          {activeMode === 'signup' && (
            <input
              type="text"
              placeholder="Your name"
              value={name}
              onChange={e => setName(e.target.value)}
              required
              style={inputStyle}
            />
          )}
          <input
            type="email"
            placeholder="Email"
            value={email}
            onChange={e => setEmail(e.target.value)}
            required
            style={inputStyle}
          />
          <input
            type="password"
            placeholder="Password"
            value={password}
            onChange={e => setPassword(e.target.value)}
            required
            minLength={6}
            style={inputStyle}
          />

          {error && (
            <p style={{ color: 'var(--coral)', fontSize: '0.85rem', margin: 0 }}>
              {error}
            </p>
          )}

          <button
            type="submit"
            className="btn-primary"
            disabled={loading}
            style={{ width: '100%', marginTop: '0.25rem', opacity: loading ? 0.6 : 1 }}
          >
            {loading ? 'Loading...' : activeMode === 'signup' ? 'Create account →' : 'Sign in →'}
          </button>
        </form>

        <p style={{ color: 'var(--muted)', fontSize: '0.75rem', textAlign: 'center', marginTop: '1rem' }}>
          {activeMode === 'signup' ? 'Free forever. No credit card required.' : 'Welcome back to your learning path.'}
        </p>
      </div>
    </div>
  )
}

const inputStyle: React.CSSProperties = {
  width: '100%',
  padding: '0.7rem 0.9rem',
  borderRadius: 10,
  border: '1.5px solid var(--line)',
  background: 'rgba(244,239,228,0.04)',
  color: 'var(--cream)',
  fontSize: '0.9rem',
  outline: 'none',
}
