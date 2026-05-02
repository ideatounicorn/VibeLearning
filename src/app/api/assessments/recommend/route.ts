import { NextRequest, NextResponse } from 'next/server'
import { supabaseServer } from '@/lib/supabase-server'

export async function POST(req: NextRequest) {
  const db = await supabaseServer()

  const { assessmentSlug, weaknesses, strengths, pct, careerGoal } = await req.json()

  // Fetch all published paths
  const { data: paths } = await db
    .from('paths')
    .select('id, name, slug, description, category')
    .eq('is_published', true)
    .order('order_index')

  // Fetch all courses (brief)
  const { data: courses } = await db
    .from('courses')
    .select('id, title, slug, description, level, path_id, tags')
    .eq('is_hidden', false)
    .order('order_index')

  // Scoring logic: match weak topics to course tags + path category
  const weakTopics = (weaknesses as Array<{ topic: string }>).map(w => w.topic.toLowerCase())
  const strongTopics = (strengths as Array<{ topic: string }>).map(s => s.topic.toLowerCase())
  const assessmentCategory = assessmentSlug?.split('-').slice(0, 2).join(' ')

  const scoredCourses = (courses ?? []).map(c => {
    let score = 0
    const tags = (c.tags ?? []).map((t: string) => t.toLowerCase())
    const titleWords = c.title.toLowerCase()

    // Boost courses matching weak topics (areas to improve)
    for (const wt of weakTopics) {
      if (tags.some((t: string) => t.includes(wt)) || titleWords.includes(wt)) score += 3
    }
    // Slight boost for strong topics (build on strengths)
    for (const st of strongTopics) {
      if (tags.some((t: string) => t.includes(st)) || titleWords.includes(st)) score += 1
    }
    // Boost beginner/intermediate based on score
    if (pct < 50 && c.level === 'beginner') score += 2
    if (pct >= 50 && pct < 75 && c.level === 'intermediate') score += 2
    if (pct >= 75 && c.level === 'advanced') score += 2

    // Career goal match
    if (careerGoal && titleWords.includes(careerGoal.toLowerCase())) score += 4

    return { ...c, _score: score }
  })

  const topCourses = scoredCourses
    .sort((a, b) => b._score - a._score)
    .slice(0, 4)
    .map(({ _score, ...c }) => c)

  // Recommend a path
  const scoredPaths = (paths ?? []).map(p => {
    let score = 0
    const pName = p.name.toLowerCase()
    const pCat = p.category.toLowerCase()
    for (const wt of weakTopics) {
      if (pName.includes(wt) || pCat.includes(wt)) score += 3
    }
    if (careerGoal && pName.includes(careerGoal.toLowerCase())) score += 5
    if (pct < 60 && pName.includes('fundamental')) score += 2
    return { ...p, _score: score }
  })

  const topPath = scoredPaths.sort((a, b) => b._score - a._score)[0]

  const summary = pct >= 80
    ? `You're in the top tier — build on your ${strongTopics.slice(0, 2).join(' & ')} strength with advanced courses.`
    : pct >= 60
    ? `Solid foundation. Focus on ${weakTopics.slice(0, 2).join(' & ')} to level up significantly.`
    : `Start with the fundamentals. ${weakTopics.slice(0, 2).join(' & ')} need the most attention — begin there.`

  return NextResponse.json({
    summary,
    recommendedPath: topPath ? { id: topPath.id, name: topPath.name, slug: topPath.slug, description: topPath.description, category: topPath.category } : null,
    recommendedCourses: topCourses,
  })
}
