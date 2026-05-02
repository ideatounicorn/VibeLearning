import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(request: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { pathId } = await request.json()

  if (!pathId) {
    return NextResponse.json({ error: 'pathId is required' }, { status: 400 })
  }

  // Check if path exists and get all its courses
  const { data: path, error: pathError } = await db
    .from('paths')
    .select('id')
    .eq('id', pathId)
    .single()

  if (pathError || !path) {
    return NextResponse.json({ error: 'Path not found' }, { status: 404 })
  }

  const { data: courses, error: coursesError } = await db
    .from('courses')
    .select('id')
    .eq('path_id', pathId)
    .eq('is_hidden', false)

  if (coursesError) {
    return NextResponse.json({ error: coursesError.message }, { status: 500 })
  }

  if (!courses || courses.length === 0) {
    return NextResponse.json({ error: 'No courses found in this path' }, { status: 404 })
  }

  // Get already enrolled courses for this user
  const { data: existingEnrollments } = await db
    .from('course_enrollments')
    .select('course_id')
    .eq('user_id', user.id)

  const existingCourseIds = (existingEnrollments || []).map(e => e.course_id)

  // Filter out already enrolled courses
  const newEnrollments = courses
    .filter(c => !existingCourseIds.includes(c.id))
    .map(c => ({
      user_id: user.id,
      course_id: c.id,
    }))

  // Insert new course enrollments (skip duplicates)
  if (newEnrollments.length > 0) {
    const { error } = await db.from('course_enrollments').insert(newEnrollments)

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }
  }

  // Upsert path enrollment record
  const { error: pathEnrollError } = await db
    .from('path_enrollments')
    .upsert({ user_id: user.id, path_id: pathId }, { onConflict: 'user_id,path_id' })

  if (pathEnrollError) {
    return NextResponse.json({ error: pathEnrollError.message }, { status: 500 })
  }

  return NextResponse.json({
    enrolled: true,
    totalCourses: courses.length,
    newlyEnrolled: newEnrollments.length,
    alreadyEnrolled: existingCourseIds.length,
  })
}
