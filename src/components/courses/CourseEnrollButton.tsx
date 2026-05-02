'use client'

import { useState } from 'react'
import Link from 'next/link'
import { motion } from 'framer-motion'

export default function CourseEnrollButton({ courseId, courseSlug, isEnrolled, isLoggedIn, startHref, variant = 'primary' }: {
  courseId: string
  courseSlug: string
  isEnrolled: boolean
  isLoggedIn: boolean
  startHref: string
  variant?: 'primary' | 'secondary'
}) {
  const [isEnrolling, setIsEnrolling] = useState(false)

  const handleEnroll = async () => {
    if (!isLoggedIn) {
      window.location.href = '/auth/signup'
      return
    }

    setIsEnrolling(true)
    try {
      const res = await fetch('/api/enroll/course', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ courseId }),
      })

      if (res.ok) {
        // After enrollment, go through intro
        window.location.href = `/course-intro/${courseSlug}`
      }
    } catch (err) {
      console.error('Enrollment failed:', err)
      setIsEnrolling(false)
    }
  }

  const buttonStyle = {
    display: 'inline-flex',
    alignItems: 'center',
    background: variant === 'primary' ? 'var(--cream)' : 'var(--accent)',
    color: 'var(--ink)',
    fontWeight: 700,
    fontSize: '0.95rem',
    padding: variant === 'primary' ? '0.8rem 2rem' : '0.7rem 1.25rem',
    borderRadius: 10,
    textDecoration: 'none',
    textAlign: 'center' as const,
    border: 'none',
    cursor: 'pointer',
  }

  if (isEnrolled) {
    return (
      <motion.div whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }} style={{ display: 'inline-block' }}>
        <Link href={`/course-intro/${courseSlug}`} style={buttonStyle}>
          Continue learning →
        </Link>
      </motion.div>
    )
  }

  return (
    <motion.button
      whileHover={{ scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      onClick={handleEnroll}
      disabled={isEnrolling}
      style={{ ...buttonStyle, opacity: isEnrolling ? 0.7 : 1, cursor: isEnrolling ? 'wait' : 'pointer' }}
    >
      {isEnrolling ? (
        <>
          <motion.span
            animate={{ rotate: 360 }}
            transition={{ duration: 0.8, repeat: Infinity, ease: 'linear' }}
            style={{ display: 'inline-block', width: 14, height: 14, borderRadius: '50%', border: '2px solid rgba(0,0,0,0.3)', borderTopColor: 'var(--ink)', marginRight: '0.5rem' }}
          />
          Enrolling…
        </>
      ) : 'Start course for free →'}
    </motion.button>
  )
}
