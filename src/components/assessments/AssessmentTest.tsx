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
    
    // Auto advance removed: User must click Continue in the bottom banner
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
      <div className="flex h-[100dvh] items-center justify-center bg-white text-black p-4">
        <div className="bg-gray-50 p-10 md:p-14 rounded-[2.5rem] max-w-lg w-full text-center border border-gray-100 shadow-2xl relative overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-32 bg-gradient-to-b from-gray-100 to-transparent"></div>
          
          <div className="relative w-24 h-24 bg-white text-black rounded-full flex items-center justify-center mx-auto mb-8 shadow-md border border-gray-100 z-10">
            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
              <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
              <polyline points="22 4 12 14.01 9 11.01"></polyline>
            </svg>
          </div>
          
          <h2 className="relative z-10 text-3xl md:text-4xl font-black mb-3">Assessment Complete!</h2>
          <p className="relative z-10 text-gray-500 font-medium mb-10 text-lg">{subSkillName}</p>
          
          <div className="relative z-10 flex justify-center items-center gap-8 bg-white rounded-3xl p-8 mb-10 border border-gray-100 shadow-sm">
            <div className="text-center">
              <p className="text-xs text-gray-400 uppercase font-bold tracking-widest mb-2">Final Score</p>
              <p className="text-5xl font-black text-black">{pct}%</p>
            </div>
            <div className="w-px h-16 bg-gray-100"></div>
            <div className="text-center">
              <p className="text-xs text-gray-400 uppercase font-bold tracking-widest mb-2">Correct</p>
              <p className="text-3xl font-bold text-gray-800 mt-2">{score} <span className="text-xl text-gray-400">/ {questions.length}</span></p>
            </div>
          </div>
          
          <button 
            onClick={() => router.push('/assessments')}
            className="relative z-10 w-full py-5 bg-black text-white rounded-2xl font-bold text-lg hover:bg-gray-800 transition-all shadow-xl hover:shadow-2xl active:scale-95"
          >
            Return to Hub
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
      if (isActuallyCorrect) return 'border-green-500 bg-green-50/50 text-green-900 ring-2 ring-green-500 shadow-md z-10'
      if (isSelected && !isActuallyCorrect) return 'border-red-300 bg-red-50 text-red-900 opacity-60'
      return 'border-gray-200 bg-white opacity-40'
    }
    
    return 'border-gray-200 bg-white hover:border-black hover:shadow-md text-black'
  }

  return (
    <div className="flex flex-col h-[100dvh] bg-white text-black font-sans overflow-hidden">
      {/* Header */}
      <header className="flex items-center justify-between px-6 py-4 bg-white relative shrink-0 z-20">
        <button 
          onClick={() => router.push('/assessments')}
          className="w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-100 transition-colors text-gray-500 hover:text-black"
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        
        <div className="font-bold text-gray-400 tracking-widest text-xs uppercase flex items-center gap-2">
          <span className="hidden sm:inline">{subSkillName}</span>
          <span className="hidden sm:inline w-1 h-1 rounded-full bg-gray-300" />
          <span>{currentIndex + 1} / {questions.length}</span>
        </div>
        
        <div className={`font-black text-xl w-12 text-right tabular-nums transition-colors ${timeLeft <= 5 ? 'text-red-500' : 'text-black'}`}>
          0:{timeLeft.toString().padStart(2, '0')}
        </div>
      </header>
      
      {/* Progress Bar inside Header bottom */}
      <div className="h-1 w-full bg-gray-100 shrink-0 z-20">
        <div 
          className="h-full bg-black transition-all duration-300 ease-out" 
          style={{ width: `${(currentIndex / questions.length) * 100}%` }}
        />
      </div>

      {/* Main Content */}
      <main className="flex-1 overflow-y-auto px-4 py-8 md:py-12 relative z-10">
        <div className="max-w-6xl mx-auto h-full flex flex-col lg:flex-row items-stretch justify-center gap-8 lg:gap-16 pb-32">
          
          {/* Left Column: Context */}
          <div className="w-full lg:w-1/2 flex flex-col justify-center">
            <div className="mb-5 inline-block px-3 py-1 rounded-full bg-gray-100 text-gray-600 text-[0.65rem] font-bold uppercase tracking-widest w-fit">
              {currentQuestion.difficulty}
            </div>
            <h1 className="text-2xl md:text-3xl lg:text-4xl font-extrabold mb-6 leading-tight text-gray-900">
              {currentQuestion.title}
            </h1>
            <div className="text-base md:text-lg text-gray-700 leading-relaxed font-medium bg-gray-50/80 p-6 md:p-8 rounded-3xl border border-gray-100 shadow-sm">
              {currentQuestion.scenario}
            </div>
          </div>

          {/* Right Column: Options */}
          <div className="w-full lg:w-1/2 flex flex-col justify-center gap-3 md:gap-4">
            {[
              { label: 'A', text: currentQuestion.option_a },
              { label: 'B', text: currentQuestion.option_b },
              { label: 'C', text: currentQuestion.option_c },
              { label: 'D', text: currentQuestion.option_d },
            ].map(opt => (
              <button 
                key={opt.label}
                onClick={() => handleSelect(opt.label)}
                disabled={feedbackState !== 'idle'}
                className={`p-4 md:p-5 rounded-2xl border-2 text-left flex justify-between items-center transition-all duration-200 group ${getOptionStyle(opt.label)}`}
              >
                <span className="font-semibold text-base md:text-lg pr-4 leading-snug">{opt.text}</span>
                <span className="w-8 h-8 rounded-lg border border-current opacity-30 flex items-center justify-center font-bold text-xs shrink-0 group-hover:opacity-100 transition-opacity">
                  {opt.label}
                </span>
              </button>
            ))}
          </div>

        </div>
      </main>

      {/* Feedback Banner Footer */}
      <div 
        className={`fixed bottom-0 left-0 w-full z-30 transition-transform duration-300 ease-in-out ${feedbackState !== 'idle' ? 'translate-y-0' : 'translate-y-full'}`}
      >
        <div className={`w-full py-6 px-6 md:px-12 flex flex-col sm:flex-row items-center justify-between gap-6 border-t-2 ${feedbackState === 'correct' ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'}`}>
          <div className="flex items-center gap-4">
            {feedbackState === 'correct' ? (
              <div className="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center text-white shrink-0 shadow-lg shadow-green-500/30">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="4" strokeLinecap="round" strokeLinejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
              </div>
            ) : (
              <div className="w-12 h-12 bg-red-500 rounded-full flex items-center justify-center text-white shrink-0 shadow-lg shadow-red-500/30">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="4" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
              </div>
            )}
            <h3 className={`text-2xl font-black ${feedbackState === 'correct' ? 'text-green-700' : 'text-red-700'}`}>
              {feedbackState === 'correct' ? 'Correct!' : 'Incorrect'}
            </h3>
          </div>
          
          <button 
            onClick={handleNext}
            className={`w-full sm:w-auto px-10 py-4 rounded-2xl font-black text-lg text-white transition-all active:scale-95 shadow-xl hover:shadow-2xl ${feedbackState === 'correct' ? 'bg-green-600 hover:bg-green-700 shadow-green-600/20' : 'bg-red-600 hover:bg-red-700 shadow-red-600/20'}`}
          >
            Continue
          </button>
        </div>
      </div>
    </div>
  )
}
