import { notFound, redirect } from 'next/navigation'
import { Suspense } from 'react'
import { supabaseServer } from '@/lib/supabase-server'
import LessonPlayer from '@/components/learn/LessonPlayer'

interface Props {
  params: Promise<{ courseSlug: string; moduleSlug: string }>
}

export default async function LearnPage({ params }: Props) {
  const { courseSlug, moduleSlug } = await params
  const db = await supabaseServer()

  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect('/?auth=required')

  // Fetch current module with lessons
  const { data: module } = await db
    .from('modules')
    .select(`
      id, title, slug, description, order_index,
      course:courses!inner (
        id, title, slug, path_id,
        path:paths ( id, name, slug )
      ),
      lessons ( id, title, youtube_url, youtube_video_id, order_index, why_this_video, skills_gained, duration_minutes )
    `)
    .eq('id', moduleSlug)
    .single()

  if (!module) notFound()

  // Check pro status
  const { data: sub } = await db.from('subscriptions').select('status').eq('user_id', user.id).eq('status', 'active').maybeSingle()
  const isPro = !!sub

  // Freemium gating: allow only first 2 modules
  if (!isPro && (module.order_index ?? 0) > 1) {
    redirect('/upgrade?source=paywall')
  }

  // Sort current module lessons
  const lessons = [...(module.lessons ?? [])].sort(
    (a: { order_index: number }, b: { order_index: number }) => a.order_index - b.order_index
  )

  // Normalize Supabase join result (course may be an array)
  const courseData = Array.isArray(module.course) ? module.course[0] : module.course
  const normalizedModule = {
    ...module,
    course: {
      ...courseData,
      path: Array.isArray(courseData?.path) ? (courseData.path[0] ?? null) : (courseData?.path ?? null),
    },
  }

  const courseId = normalizedModule.course?.id

  // Fetch ALL modules + their lesson IDs for the course sidebar
  const { data: allModulesRaw } = await db
    .from('modules')
    .select('id, title, slug, order_index, lessons ( id, order_index )')
    .eq('course_id', courseId)
    .order('order_index')

  const allModules = (allModulesRaw ?? []).map((m: any) => ({
    id: m.id,
    title: m.title,
    slug: m.slug,
    order_index: m.order_index,
    lessonCount: (m.lessons ?? []).length,
    lessonIds: (m.lessons ?? []).map((l: any) => l.id),
  }))

  // Fetch all lesson progress across the whole course
  const allLessonIds = allModules.flatMap(m => m.lessonIds)
  const { data: allLessonProgress } = await db
    .from('lesson_progress')
    .select('lesson_id, completed_at')
    .eq('user_id', user.id)
    .in('lesson_id', allLessonIds.length > 0 ? allLessonIds : ['__none__'])

  const completedLessonIds = (allLessonProgress ?? [])
    .filter((p: { completed_at: string | null }) => p.completed_at)
    .map((p: { lesson_id: string }) => p.lesson_id)

  // Module quiz pass status
  const { data: completedCourseModules } = await db
    .from('module_progress')
    .select('module_id')
    .eq('user_id', user.id)
    .eq('quiz_passed', true)

  const passedModuleIds = (completedCourseModules ?? []).map((p: any) => p.module_id)

  // Module recap (for recap screen after all lessons done)
  const { data: recapRow } = await db
    .from('module_recaps')
    .select('key_takeaways, exercises_jsonb')
    .eq('module_id', normalizedModule.id)
    .maybeSingle()

  const moduleRecap = recapRow ?? null

  // Course-wide progress counts
  const courseTotalLessons = allModules.reduce((sum, m) => sum + m.lessonCount, 0)
  const courseCompletedLessons = completedLessonIds.length

  return (
    <Suspense fallback={null}>
      <LessonPlayer
        module={normalizedModule}
        lessons={lessons}
        completedLessonIds={completedLessonIds}
        userId={user.id}
        isPro={isPro}
        courseSlug={courseSlug}
        allModules={allModules}
        passedModuleIds={passedModuleIds}
        moduleRecap={moduleRecap}
        courseCompletedLessons={courseCompletedLessons}
        courseTotalLessons={courseTotalLessons}
      />
    </Suspense>
  )
}
