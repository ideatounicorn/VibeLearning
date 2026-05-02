import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(request: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { courseId } = await request.json()

  if (!courseId) {
    return NextResponse.json({ error: 'courseId is required' }, { status: 400 })
  }

  // Check if course exists
  const { data: course, error: courseError } = await db
    .from('courses')
    .select('id, path_id')
    .eq('id', courseId)
    .single()

  if (courseError || !course) {
    return NextResponse.json({ error: 'Course not found' }, { status: 404 })
  }

  // Check if already enrolled
  const { data: existing } = await db
    .from('course_enrollments')
    .select('id')
    .eq('user_id', user.id)
    .eq('course_id', courseId)
    .single()

  if (existing) {
    return NextResponse.json({ enrolled: true, alreadyEnrolled: true })
  }

  // Enroll user in course
  const { error } = await db.from('course_enrollments').insert({
    user_id: user.id,
    course_id: courseId,
  })

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json({ enrolled: true, alreadyEnrolled: false })
}
