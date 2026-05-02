import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

const FALLBACK = (title: string) => ({
  titleCard: {
    headline: `Master ${title}`,
    subheadline: 'Go from beginner to job-ready with structured video lessons',
    emoji: '🚀',
  },
  glossary: [
    { term: 'Module', definition: 'A chapter of the course containing multiple lessons and a quiz.', example: 'Module 1 covers the basics of the subject.' },
    { term: 'Quiz', definition: 'A short test at the end of each module to check your understanding.', example: 'Pass the quiz with 67% or more to unlock the next module.' },
    { term: 'XP', definition: 'Experience points you earn for completing lessons and quizzes.', example: 'You earn 10 XP for each lesson and 150 XP for passing a quiz.' },
    { term: 'Certificate', definition: 'A shareable credential you receive when you complete the full course.', example: 'Share your certificate on LinkedIn to show employers your skills.' },
    { term: 'Career Path', definition: 'A sequence of courses designed to make you job-ready in a specific field.', example: 'The AI Career Path includes 3 courses covering fundamentals to advanced topics.' },
  ],
  glossaryQuiz: [
    { question: 'What is a Module?', options: ['A video lesson', 'A chapter with lessons + quiz', 'A certificate', 'A career path'], correctIndex: 1, term: 'Module' },
    { question: 'What do you earn for completing lessons?', options: ['Badges', 'Certificates', 'XP', 'Credits'], correctIndex: 2, term: 'XP' },
    { question: 'When do you earn a Certificate?', options: ['After one lesson', 'After one module', 'After completing the full course', 'After signing up'], correctIndex: 2, term: 'Certificate' },
    { question: 'What is a Career Path?', options: ['A single course', 'A sequence of courses for job readiness', 'A quiz', 'A video playlist'], correctIndex: 1, term: 'Career Path' },
  ],
  courseMap: {
    overview: "You'll go through curated video lessons, test your knowledge with module quizzes, and prove your skills with a final assessment.",
    steps: ['Watch expert-curated video lessons', 'Complete module quizzes to unlock the next level', 'Pass the final module test', 'Earn your certificate + share it on LinkedIn'],
  },
})

export async function POST(req: NextRequest) {
  const { courseId } = await req.json()
  if (!courseId) return NextResponse.json({ error: 'Missing courseId' }, { status: 400 })

  const db = await supabaseServer()

  const { data: course } = await db
    .from('courses')
    .select('title, flashcard_data')
    .eq('id', courseId)
    .single()

  if (!course) return NextResponse.json({ error: 'Course not found' }, { status: 404 })

  return NextResponse.json(course.flashcard_data ?? FALLBACK(course.title))
}
