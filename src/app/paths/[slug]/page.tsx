import { notFound } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import PathDetailClient from '@/components/paths/PathDetailClient'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateMetadata({ params }: Props) {
  const { slug } = await params
  return {
    title: `${slug.replace(/-/g, ' ')} — VibeLearn`,
    description: `Full learning roadmap for ${slug.replace(/-/g, ' ')}.`,
  }
}

export default async function PathPage({ params }: Props) {
  const { slug } = await params
  const db = await supabaseServer()

  const { data: path } = await db
    .from('paths')
    .select('*')
    .eq('slug', slug)
    .single()

  if (!path) notFound()

  const { data: courses } = await db
    .from('courses')
    .select(`
      id, title, slug, description, order_index, level, duration_hours,
      modules (
        id, title, slug, order_index, is_free, description
      )
    `)
    .eq('path_id', path.id)
    .eq('is_hidden', false)
    .order('order_index')

  const { data: otherPaths } = await db
    .from('paths')
    .select('id, name, slug, category, description')
    .eq('is_published', true)
    .neq('slug', slug)
    .order('order_index')
    .limit(3)

  const { data: { user } } = await db.auth.getUser()
  let completedModuleIds: string[] = []
  let isPro = false
  let profile = null

  if (user) {
    const { data: progress } = await db
      .from('module_progress')
      .select('module_id')
      .eq('user_id', user.id)
      .eq('quiz_passed', true)

    completedModuleIds = (progress ?? []).map(p => p.module_id)

    const { data: sub } = await db
      .from('subscriptions')
      .select('status')
      .eq('user_id', user.id)
      .eq('status', 'active')
      .single()

    isPro = !!sub

    const { data: p } = await db
      .from('profiles')
      .select('xp_total, streak_days')
      .eq('id', user.id)
      .single()
    profile = p
  }

  return (
    <PathDetailClient
      path={path}
      courses={courses ?? []}
      completedModuleIds={completedModuleIds}
      isPro={isPro}
      isLoggedIn={!!user}
      profile={profile}
      otherPaths={otherPaths ?? []}
    />
  )
}
