'use client'

import React, { useState, useEffect, useRef, useCallback } from 'react'
import { useRouter } from 'next/navigation'
import { supabase } from '@/lib/supabase'

interface Question {
  question_id: string
  question_number: number
  title: string
  scenario: string
  difficulty: 'foundational' | 'intermediate' | 'advanced'
  product_company: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
}

interface AssessmentTestProps {
  subSkillId: string
  subSkillName: string
  questions: Question[]
  userId: string
  sessionId: string
}

// Simple Web Audio API sound synthesizer for feedback
const playSound = (type: 'correct' | 'incorrect') => {
  try {
    const ctx = new (window.AudioContext || (window as any).webkitAudioContext)()
    const osc = ctx.createOscillator()
    const gain = ctx.createGain()
    osc.connect(gain)
    gain.connect(ctx.destination)

    if (type === 'correct') {
      // Pleasant Ding
      osc.type = 'sine'
      osc.frequency.setValueAtTime(600, ctx.currentTime)
      osc.frequency.exponentialRampToValueAtTime(1200, ctx.currentTime + 0.1)
      gain.gain.setValueAtTime(0, ctx.currentTime)
      gain.gain.linearRampToValueAtTime(0.3, ctx.currentTime + 0.05)
      gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.5)
      osc.start(ctx.currentTime)
      osc.stop(ctx.currentTime + 0.5)
    } else {
      // Error Buzz
      osc.type = 'sawtooth'
      osc.frequency.setValueAtTime(150, ctx.currentTime)
      osc.frequency.exponentialRampToValueAtTime(100, ctx.currentTime + 0.2)
      gain.gain.setValueAtTime(0, ctx.currentTime)
      gain.gain.linearRampToValueAtTime(0.3, ctx.currentTime + 0.05)
      gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.3)
      osc.start(ctx.currentTime)
      osc.stop(ctx.currentTime + 0.3)
    }
  } catch (e) {
    console.log('Audio disabled or failed', e)
  }
}

export default function AssessmentTest({ subSkillId, subSkillName, questions, userId, sessionId }: AssessmentTestProps) {
  const router = useRouter()
  const db = supabase()
  
  const [currentIndex, setCurrentIndex] = useState(0)
  const [timeLeft, setTimeLeft] = useState(30)
  const [selectedOption, setSelectedOption] = useState<string | null>(null)
  const [feedbackState, setFeedbackState] = useState<'idle' | 'correct' | 'incorrect'>('idle')
  const [isFinished, setIsFinished] = useState(false)
  const [score, setScore] = useState(0)
  
  const timerRef = useRef<NodeJS.Timeout | null>(null)
  const [correctAnswersData, setCorrectAnswersData] = useState<Record<string, string>>({})

  const currentQuestion = questions[currentIndex]

  // Pre-fetch actual correct answers without exposing them in initial payload if possible, 
  // but for now we fetch it once selected or from a secure endpoint. 
  // Since we don't have a secure endpoint in this minimal setup, we verify via db during selection.
  
  const handleNext = useCallback(() => {
    setSelectedOption(null)
    setFeedbackState('idle')
    setTimeLeft(30)
    
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(prev => prev + 1)
    } else {
      finishAssessment()
    }
  }, [currentIndex, questions.length])

  const finishAssessment = async () => {
    setIsFinished(true)
    
    // Save final results
    const pct = Math.round((score / questions.length) * 100)
    let proficiency = 'weak'
    if (pct >= 90) proficiency = 'strong'
    else if (pct >= 75) proficiency = 'proficient'
    else if (pct >= 60) proficiency = 'developing'

    await db.from('assessment_results').insert({
      user_id: userId,
      sub_skill_id: subSkillId,
      session_id: sessionId,
      total_questions: questions.length,
      correct_answers: score,
      score_pct: pct,
      proficiency: proficiency,
      time_taken_secs: 0 // Simplification
    })
  }

  const handleSelect = async (optionLabel: string, isTimeout: boolean = false) => {
    if (selectedOption || feedbackState !== 'idle') return // prevent double click
    
    // Clear timer immediately
    if (timerRef.current) clearInterval(timerRef.current)
    
    const ansOption = isTimeout ? 'X' : optionLabel
    setSelectedOption(ansOption)

    // Verify answer in DB
    const { data: opts } = await db
      .from('question_options')
      .select('option_label, is_correct')
      .eq('question_id', currentQuestion.question_id)

    const correctOpt = opts?.find(o => o.is_correct)?.option_label || 'A'
    const isCorrect = correctOpt === ansOption

    setCorrectAnswersData(prev => ({ ...prev, [currentQuestion.question_id]: correctOpt }))

    if (isCorrect) {
      setFeedbackState('correct')
      playSound('correct')
      setScore(s => s + 1)
    } else {
      setFeedbackState('incorrect')
      playSound('incorrect')
    }

    // Save response
    if (!isTimeout) {
      await db.from('user_responses').insert({
        user_id: userId,
        question_id: currentQuestion.question_id,
        sub_skill_id: subSkillId,
        selected_option: ansOption as any,
        is_correct: isCorrect,
        time_taken_secs: 30 - timeLeft,
        session_id: sessionId
      })
    }

    // Auto advance after 1.5s
    setTimeout(() => {
      handleNext()
    }, 1500)
  }

  useEffect(() => {
    if (isFinished || feedbackState !== 'idle') return

    timerRef.current = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev <= 1) {
          clearInterval(timerRef.current!)
          handleSelect('X', true) // Timeout triggers incorrect
          return 0
        }
        return prev - 1
      })
    }, 1000)

    return () => {
      if (timerRef.current) clearInterval(timerRef.current)
    }
  }, [currentIndex, isFinished, feedbackState])

  if (isFinished) {
    const pct = Math.round((score / questions.length) * 100)
    return (
      <div className="flex h-screen items-center justify-center bg-gray-50 text-black">
        <div className="bg-white p-10 rounded-3xl shadow-xl max-w-md w-full text-center border border-gray-100">
          <div className="w-20 h-20 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-6">
            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="20 6 9 17 4 12" />
            </svg>
          </div>
          <h2 className="text-3xl font-extrabold mb-2">Assessment Complete!</h2>
          <p className="text-gray-500 mb-8">{subSkillName}</p>
          
          <div className="flex justify-between items-center bg-gray-50 rounded-2xl p-6 mb-8 border border-gray-100">
            <div className="text-left">
              <p className="text-xs text-gray-500 uppercase font-bold tracking-wider mb-1">Final Score</p>
              <p className="text-4xl font-black text-black">{pct}%</p>
            </div>
            <div className="text-right">
              <p className="text-xs text-gray-500 uppercase font-bold tracking-wider mb-1">Correct</p>
              <p className="text-2xl font-bold text-gray-800">{score} / {questions.length}</p>
            </div>
          </div>
          
          <button 
            onClick={() => router.push('/assessments')}
            className="w-full py-4 bg-black text-white rounded-xl font-bold text-lg hover:bg-gray-800 transition-colors shadow-lg"
          >
            Return to Assessments
          </button>
        </div>
      </div>
    )
  }

  if (!currentQuestion) return null

  const getOptionStyle = (label: string) => {
    const isSelected = selectedOption === label
    const isActuallyCorrect = correctAnswersData[currentQuestion.question_id] === label
    
    if (feedbackState !== 'idle') {
      if (isActuallyCorrect) return 'border-green-500 bg-green-50 text-green-800 scale-[1.02] shadow-sm ring-2 ring-green-500 ring-opacity-50'
      if (isSelected && !isActuallyCorrect) return 'border-red-500 bg-red-50 text-red-800 opacity-80'
      return 'border-gray-200 bg-white opacity-50'
    }
    
    return 'border-gray-200 bg-white hover:border-black hover:shadow-sm hover:bg-gray-50 text-black cursor-pointer'
  }

  return (
    <div className={`flex flex-col h-screen bg-gray-50 text-black font-sans transition-transform duration-100 ${feedbackState === 'incorrect' ? '-translate-x-2' : ''}`}>
      {/* Header */}
      <header className="flex items-center justify-between p-6 bg-white border-b border-gray-100 shrink-0 shadow-sm z-10 relative">
        <button 
          onClick={() => router.push('/assessments')}
          className="w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-100 transition-colors text-gray-500 hover:text-black"
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        
        <div className="font-bold text-gray-400 tracking-wider text-sm uppercase">
          {subSkillName} • {currentIndex + 1} / {questions.length}
        </div>
        
        <div className={`font-black text-2xl w-12 text-right transition-colors ${timeLeft <= 5 ? 'text-red-500' : 'text-black'}`}>
          0:{timeLeft.toString().padStart(2, '0')}
        </div>
      </header>
      
      {/* Progress Bar */}
      <div className="h-1.5 w-full bg-gray-200 shrink-0">
        <div 
          className="h-full bg-black transition-all duration-300 ease-out" 
          style={{ width: `${(currentIndex / questions.length) * 100}%` }}
        />
      </div>

      {/* Main Content */}
      <main className="flex-1 overflow-y-auto px-4 py-8 md:py-16">
        <div className="max-w-3xl mx-auto w-full">
          
          <div className="mb-4 inline-block px-3 py-1 rounded-full bg-gray-200 text-gray-700 text-xs font-bold uppercase tracking-widest">
            {currentQuestion.difficulty}
          </div>
          
          <h1 className="text-2xl md:text-4xl font-extrabold mb-6 leading-tight text-gray-900">
            {currentQuestion.title}
          </h1>
          
          <p className="text-lg md:text-xl text-gray-600 mb-10 leading-relaxed font-medium bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
            {currentQuestion.scenario}
          </p>

          <div className="grid gap-3">
            {[
              { label: 'A', text: currentQuestion.option_a },
              { label: 'B', text: currentQuestion.option_b },
              { label: 'C', text: currentQuestion.option_c },
              { label: 'D', text: currentQuestion.option_d },
            ].map(opt => (
              <div 
                key={opt.label}
                onClick={() => handleSelect(opt.label)}
                className={`p-5 rounded-2xl border-2 transition-all duration-200 flex gap-4 items-center ${getOptionStyle(opt.label)}`}
              >
                <div className="w-10 h-10 rounded-xl bg-gray-100 flex items-center justify-center font-bold shrink-0 text-gray-500">
                  {opt.label}
                </div>
                <div className="font-semibold text-lg">{opt.text}</div>
              </div>
            ))}
          </div>

        </div>
      </main>
      
      {/* Screen Shake Animation logic via CSS */}
      <style dangerouslySetInnerHTML={{__html: `
        .bg-gray-50 { background-color: #f9fafb; }
        .-translate-x-2 { animation: shake 0.4s cubic-bezier(.36,.07,.19,.97) both; }
        @keyframes shake {
          10%, 90% { transform: translate3d(-1px, 0, 0); }
          20%, 80% { transform: translate3d(2px, 0, 0); }
          30%, 50%, 70% { transform: translate3d(-4px, 0, 0); }
          40%, 60% { transform: translate3d(4px, 0, 0); }
        }
      `}} />
    </div>
  )
}
