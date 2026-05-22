import { notFound } from 'next/navigation'
import { supabaseServer } from '@/lib/supabase-server'
import PathDetailClient from '@/components/paths/PathDetailClient'
import {
  absoluteUrl,
  breadcrumbJsonLd,
  faqJsonLd,
  jsonLdScriptProps,
  learningPathJsonLd,
} from '@/lib/seo'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateMetadata({ params }: Props) {
  const { slug } = await params
  const db = await supabaseServer()
  const { data: path } = await db
    .from('paths')
    .select('name, description, slug, image_url, category, salary_range')
    .eq('slug', slug)
    .single()
  if (!path) return { title: 'Path not found', robots: { index: false } }

  const desc =
    path.description ??
    `Complete ${path.name} career learning path — courses, projects, quizzes, and a shareable certificate on VibeLearn.`
  const trimmed = desc.length > 158 ? `${desc.slice(0, 155)}…` : desc
  const url = `/paths/${path.slug}`
  return {
    title: `${path.name} Career Path — Free Courses + Certificate`,
    description: trimmed,
    alternates: { canonical: url },
    openGraph: {
      title: `${path.name} — Career Learning Path`,
      description: trimmed,
      url,
      type: 'article',
      images: path.image_url ? [{ url: path.image_url, width: 1200, height: 630 }] : undefined,
    },
    twitter: {
      card: 'summary_large_image',
      title: `${path.name} — Career Learning Path`,
      description: trimmed,
      images: path.image_url ? [path.image_url] : undefined,
    },
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

  const totalHours = Number(path.total_hours) || undefined
  const pathSchema = learningPathJsonLd({
    name: path.name,
    slug: path.slug,
    description: path.description,
    category: path.category,
    totalHours,
    totalCourses: (courses ?? []).length,
    salaryRange: path.salary_range,
  })
  const crumbs = breadcrumbJsonLd([
    { name: 'Home', url: '/' },
    { name: 'Paths', url: '/paths' },
    { name: path.name, url: `/paths/${path.slug}` },
  ])
  const faqs = [
    {
      q: `How long does the ${path.name} path take?`,
      a: `Most learners complete the ${path.name} path in 4–8 weeks at 30 minutes a day. It is fully self-paced.`,
    },
    {
      q: `Is the ${path.name} path free?`,
      a: `Yes — full curriculum access is free. A Pro plan unlocks the certificate, advanced projects, and team features.`,
    },
    {
      q: `What jobs can I get after completing ${path.name}?`,
      a: path.salary_range
        ? `Graduates pursue roles in ${path.name.toLowerCase()} with salary ranges around ${path.salary_range}.`
        : `Graduates pursue careers in ${path.name.toLowerCase()} across startups and large companies.`,
    },
    {
      q: `Can my team take this path together?`,
      a: `Yes. VibeLearn for Teams supports cohort enrollment, manager dashboards, and skill-gap reporting. See /teams.`,
    },
  ]
  const faqSchema = faqJsonLd(faqs)

  return (
    <>
      <script {...jsonLdScriptProps(pathSchema)} />
      <script {...jsonLdScriptProps(crumbs)} />
      <script {...jsonLdScriptProps(faqSchema)} />
      <link rel="canonical" href={absoluteUrl(`/paths/${path.slug}`)} />
    <PathDetailClient
      path={path}
      courses={courses ?? []}
      completedModuleIds={completedModuleIds}
      isPro={isPro}
      isLoggedIn={!!user}
      profile={profile}
      otherPaths={otherPaths ?? []}
    />
    </>
  )
}
