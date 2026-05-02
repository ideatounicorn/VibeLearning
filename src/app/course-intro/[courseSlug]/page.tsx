import { notFound, redirect } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import CourseIntroClient from '@/components/course-intro/CourseIntroClient'

interface Props {
  params: Promise<{ courseSlug: string }>
  searchParams: Promise<{ next?: string }>
}

export default async function CourseIntroPage({ params, searchParams }: Props) {
  const { courseSlug } = await params
  const { next } = await searchParams
  const db = await supabaseServer()

  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect(`/auth/signup?redirect=/course-intro/${courseSlug}`)

  const { data: courseRows } = await db
    .from('courses')
    .select('id, title, slug')
    .eq('slug', courseSlug)
    .limit(1)

  const course = courseRows?.[0]
  if (!course) notFound()

  // Check enrollment
  const { data: enrollment } = await db
    .from('course_enrollments')
    .select('id')
    .eq('user_id', user.id)
    .eq('course_id', course.id)
    .single()

  if (!enrollment) redirect(`/courses/${courseSlug}`)

  // Determine first module href
  let startHref = next ?? `/courses/${courseSlug}`
  if (!next) {
    const { data: firstModule } = await db
      .from('modules')
      .select('id')
      .eq('course_id', course.id)
      .order('order_index')
      .limit(1)
      .single()

    if (firstModule) {
      startHref = `/learn/${courseSlug}/${firstModule.id}`
    }
  }

  return (
    <CourseIntroClient
      courseId={course.id}
      courseTitle={course.title}
      startHref={startHref}
    />
  )
}
