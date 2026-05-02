import { redirect } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import QuizClient from '@/components/quiz/QuizClient'

interface Props {
  params: Promise<{ moduleId: string }>
}

export async function generateMetadata() {
  return { title: 'Module Quiz — VibeLearn' }
}

export default async function QuizPage({ params }: Props) {
  const { moduleId } = await params
  const db = await supabaseServer()

  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect('/?auth=required')

  const { data: module } = await db
    .from('modules')
    .select(`
      id, 
      title, 
      order_index,
      course_id,
      course:courses!inner(
        id, 
        slug, 
        path_id,
        path:paths(id, slug),
        modules(id, order_index)
      )
    `)
    .eq('id', moduleId)
    .single()

  if (!module) redirect('/')

  // Find next module in this course
  const courseModules = (module.course as any)?.modules ?? []
  const sortedModules = [...courseModules].sort((a, b) => a.order_index - b.order_index)
  const currentIdx = sortedModules.findIndex(m => m.id === moduleId)
  const nextModule = sortedModules[currentIdx + 1]

  let nextModuleUrl = null
  if (nextModule) {
    nextModuleUrl = `/learn/${(module.course as any).slug}/${nextModule.id}`
  } else if ((module.course as any).path_id) {
    // If last module of course, find next course in path
    const { data: nextCourses } = await db
      .from('courses')
      .select('id, slug, modules(id, order_index)')
      .eq('path_id', (module.course as any).path_id)
      .order('order_index')

    const currentCourseIdx = nextCourses?.findIndex(c => c.id === module.course_id) ?? -1
    const nextCourse = nextCourses?.[currentCourseIdx + 1]
    
    if (nextCourse && nextCourse.modules && nextCourse.modules.length > 0) {
      const firstModOfNextCourse = [...nextCourse.modules].sort((a, b) => a.order_index - b.order_index)[0]
      nextModuleUrl = `/learn/${nextCourse.slug}/${firstModOfNextCourse.id}`
    }
  }

  const pathSlug = (module.course as any)?.path?.slug
  const nextPath = pathSlug ? `/paths/${pathSlug}` : '/dashboard'

  const { data: questions } = await db
    .from('quizzes')
    .select('*')
    .eq('module_id', moduleId)
    .order('order_index')

  return (
    <QuizClient 
      moduleId={moduleId} 
      moduleTitle={module.title} 
      questions={questions ?? []}
      userId={user.id}
      nextPath={nextPath}
      nextModuleUrl={nextModuleUrl}
    />
  )
}
