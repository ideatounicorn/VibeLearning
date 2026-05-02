import { supabaseServer } from '@/lib/supabase-server'
import { redirect } from 'next/navigation'
import { ProfileClient } from '@/components/profile/ProfileClient'

export const metadata = { title: 'Profile — VibeLearn' }

export default async function ProfilePage() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect('/?auth=required')

  const avatarUrl: string | null = (user.user_metadata?.avatar_url as string | undefined) ?? null

  const { data: profile } = await db
    .from('profiles')
    .select('*')
    .eq('id', user.id)
    .single()

  const { data: completedModulesRaw } = await db
    .from('module_progress')
    .select('id, completed_at, module:modules(title, course:courses(name, slug))')
    .eq('user_id', user.id)
    .eq('quiz_passed', true)

  const completedModules = (completedModulesRaw ?? []).map((m: any) => ({
    id: m.id,
    completed_at: m.completed_at,
    module: Array.isArray(m.module)
      ? { ...m.module[0], course: Array.isArray(m.module[0]?.course) ? m.module[0].course[0] ?? null : m.module[0]?.course ?? null }
      : m.module
        ? { ...m.module, course: Array.isArray(m.module.course) ? m.module.course[0] ?? null : m.module.course ?? null }
        : null,
  }))

  const { data: achievements } = await db
    .from('achievements')
    .select('*')
    .eq('user_id', user.id)

  // Enrolled courses with progress
  const { data: enrollments } = await db
    .from('course_enrollments')
    .select('course_id, enrolled_at, course:courses(id, title, slug, path:paths(name, category))')
    .eq('user_id', user.id)

  // Get all module IDs for enrolled courses
  const courseIds = (enrollments ?? []).map((e: any) => {
    const c = Array.isArray(e.course) ? e.course[0] : e.course
    return c?.id
  }).filter(Boolean)

  let modulesByCourse: Record<string, { total: number; completed: number }> = {}

  // Last active lesson per course (for deep-link continue button)
  const lastModulePerCourse: Record<string, string> = {} // courseId -> moduleId
  if (courseIds.length > 0) {
    const { data: allModules } = await db
      .from('modules')
      .select('id, course_id')
      .in('course_id', courseIds)

    const { data: completedProgress } = await db
      .from('module_progress')
      .select('module_id')
      .eq('user_id', user.id)
      .eq('quiz_passed', true)

    const completedSet = new Set((completedProgress ?? []).map((p: any) => p.module_id))

    for (const mod of (allModules ?? [])) {
      if (!modulesByCourse[mod.course_id]) modulesByCourse[mod.course_id] = { total: 0, completed: 0 }
      modulesByCourse[mod.course_id].total++
      if (completedSet.has(mod.id)) modulesByCourse[mod.course_id].completed++
    }

    // Find last touched lesson per course via lesson_progress
    const { data: lpRaw } = await db
      .from('lesson_progress')
      .select('lesson_id, started_at, lesson:lessons(module_id, module:modules(id, course_id))')
      .eq('user_id', user.id)
      .order('started_at', { ascending: false })

    for (const lp of (lpRaw ?? [])) {
      const lesson = Array.isArray((lp as any).lesson) ? (lp as any).lesson[0] : (lp as any).lesson
      const mod = lesson ? (Array.isArray(lesson.module) ? lesson.module[0] : lesson.module) : null
      if (mod?.course_id && mod?.id && !lastModulePerCourse[mod.course_id]) {
        lastModulePerCourse[mod.course_id] = mod.id
      }
    }
  }

  const enrolledCourses = (enrollments ?? []).map((e: any) => {
    const c = Array.isArray(e.course) ? e.course[0] : e.course
    const path = c ? (Array.isArray(c.path) ? c.path[0] : c.path) : null
    const progress = modulesByCourse[c?.id] ?? { total: 0, completed: 0 }
    const lastModuleId = c?.id ? lastModulePerCourse[c.id] : undefined
    return {
      courseId: c?.id ?? '',
      title: c?.title ?? '',
      slug: c?.slug ?? '',
      pathName: path?.name ?? '',
      pathCategory: path?.category ?? '',
      enrolledAt: e.enrolled_at,
      progressTotal: progress.total,
      progressCompleted: progress.completed,
      lastLessonHref: lastModuleId && c?.slug ? `/learn/${c.slug}/${lastModuleId}` : null,
    }
  })

  // Certificates
  const { data: certificates } = await db
    .from('certificates')
    .select('*')
    .eq('user_id', user.id)
    .order('issued_at', { ascending: false })

  return (
    <ProfileClient
      profile={profile}
      email={user.email ?? ''}
      avatarUrl={avatarUrl}
      completedModules={completedModules}
      achievements={achievements ?? []}
      enrolledCourses={enrolledCourses}
      certificates={certificates ?? []}
    />
  )
}
