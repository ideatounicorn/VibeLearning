import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(request: NextRequest) {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { moduleId, score, total } = await request.json()
  const passed = score >= Math.ceil(total * 0.67)
  const xp = passed ? 150 : 50

  // Upsert module progress
  await db.from('module_progress').upsert(
    {
      user_id: user.id,
      module_id: moduleId,
      completed_at: new Date().toISOString(),
      quiz_score: score,
      quiz_passed: passed,
      quiz_attempts: 1,
      xp_awarded: xp,
    },
    { onConflict: 'user_id,module_id' }
  )

  // Update streak & XP
  const { data: profile } = await db.from('profiles').select('xp_total').eq('id', user.id).single()
  await db
    .from('profiles')
    .update({
      last_activity_date: new Date().toDateString(),
      xp_total: (profile?.xp_total || 0) + xp,
    })
    .eq('id', user.id)

  // Check if entire course is now complete → generate course certificate
  let courseCertificate = null
  let pathCertificate = null

  if (passed) {
    // Find which course this module belongs to
    const { data: module } = await db
      .from('modules')
      .select('course_id')
      .eq('id', moduleId)
      .single()

    if (module?.course_id) {
      // Check if all modules in this course are now passed
      const { data: allModules } = await db
        .from('modules')
        .select('id')
        .eq('course_id', module.course_id)

      const moduleIds = (allModules ?? []).map(m => m.id)
      const { data: passedProgress } = await db
        .from('module_progress')
        .select('module_id')
        .eq('user_id', user.id)
        .eq('quiz_passed', true)
        .in('module_id', moduleIds)

      const allPassed = passedProgress?.length === moduleIds.length && moduleIds.length > 0

      if (allPassed) {
        // Issue course certificate
        const { data: course } = await db
          .from('courses')
          .select('title, path_id')
          .eq('id', module.course_id)
          .single()

        const { data: profile2 } = await db
          .from('profiles')
          .select('full_name')
          .eq('id', user.id)
          .single()

        const recipientName = profile2?.full_name ?? user.email?.split('@')[0] ?? 'Learner'

        const { data: cert } = await db
          .from('certificates')
          .upsert(
            {
              user_id: user.id,
              type: 'course',
              reference_id: module.course_id,
              reference_name: course?.title ?? 'Course',
              recipient_name: recipientName,
            },
            { onConflict: 'user_id,type,reference_id' }
          )
          .select()
          .single()

        courseCertificate = cert

        // Check if entire path is now complete
        if (course?.path_id) {
          const { data: pathCourses } = await db
            .from('courses')
            .select('id')
            .eq('path_id', course.path_id)
            .eq('is_hidden', false)

          const pathCourseIds = (pathCourses ?? []).map(c => c.id)

          // For each path course, check all modules passed
          let allPathDone = true
          for (const cId of pathCourseIds) {
            const { data: cModules } = await db
              .from('modules')
              .select('id')
              .eq('course_id', cId)

            const cModuleIds = (cModules ?? []).map(m => m.id)
            const { data: cPassed } = await db
              .from('module_progress')
              .select('module_id')
              .eq('user_id', user.id)
              .eq('quiz_passed', true)
              .in('module_id', cModuleIds)

            if (cPassed?.length !== cModuleIds.length) {
              allPathDone = false
              break
            }
          }

          if (allPathDone) {
            const { data: path } = await db
              .from('paths')
              .select('name')
              .eq('id', course.path_id)
              .single()

            const { data: pathCert } = await db
              .from('certificates')
              .upsert(
                {
                  user_id: user.id,
                  type: 'path',
                  reference_id: course.path_id,
                  reference_name: path?.name ?? 'Career Path',
                  recipient_name: recipientName,
                },
                { onConflict: 'user_id,type,reference_id' }
              )
              .select()
              .single()

            pathCertificate = pathCert
          }
        }
      }
    }
  }

  return NextResponse.json({ ok: true, passed, xp, courseCertificate, pathCertificate })
}
