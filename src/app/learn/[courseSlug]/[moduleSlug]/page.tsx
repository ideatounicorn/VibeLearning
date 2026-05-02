import { notFound, redirect } from 'next/navigation'
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

  // Fetch module with lessons
  const { data: module } = await db
    .from('modules')
    .select(`
      *,
      course:courses!inner (
        id, title, slug, path_id,
        path:paths ( id, name, slug )
      ),
      lessons ( id, title, youtube_url, youtube_video_id, order_index, why_this_video, skills_gained, duration_minutes )
    `)
    .eq('id', moduleSlug)
    .single()

  if (!module) notFound()

  // Sort lessons
  const lessons = [...(module.lessons ?? [])].sort((a: { order_index: number }, b: { order_index: number }) => a.order_index - b.order_index)

  // Fetch lesson progress
  const { data: lessonProgress } = await db
    .from('lesson_progress')
    .select('lesson_id, completed_at')
    .eq('user_id', user.id)
    .in('lesson_id', lessons.map((l: { id: string }) => l.id))

  const completedLessonIds = (lessonProgress ?? [])
    .filter((p: { completed_at: string | null }) => p.completed_at)
    .map((p: { lesson_id: string }) => p.lesson_id)

  // Check pro status + fetch course-level module progress
  const courseId = (module.course as any)?.id
  const [{ data: sub }, { data: allCourseModules }, { data: completedCourseModules }] = await Promise.all([
    db.from('subscriptions').select('status').eq('user_id', user.id).eq('status', 'active').maybeSingle(),
    db.from('modules').select('id').eq('course_id', courseId),
    db.from('module_progress').select('module_id').eq('user_id', user.id).eq('quiz_passed', true),
  ])
  const isPro = !!sub

  const courseModuleTotal = allCourseModules?.length ?? 0
  const courseModuleIds = new Set((allCourseModules ?? []).map((m: any) => m.id))
  const courseModuleCompleted = (completedCourseModules ?? []).filter((p: any) => courseModuleIds.has(p.module_id)).length

  return (
    <LessonPlayer
      module={module}
      lessons={lessons}
      completedLessonIds={completedLessonIds}
      userId={user.id}
      isPro={isPro}
      courseModuleTotal={courseModuleTotal}
      courseModuleCompleted={courseModuleCompleted}
    />
  )
}
