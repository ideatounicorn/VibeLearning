import type { MetadataRoute } from 'next'
import { supabaseServer } from '@/lib/supabase-server'
import { SITE_URL } from '@/lib/seo'

export const revalidate = 3600

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const db = await supabaseServer()

  const now = new Date()

  const staticEntries: MetadataRoute.Sitemap = [
    { url: `${SITE_URL}/`, lastModified: now, changeFrequency: 'weekly', priority: 1.0 },
    { url: `${SITE_URL}/courses`, lastModified: now, changeFrequency: 'daily', priority: 0.9 },
    { url: `${SITE_URL}/assessments`, lastModified: now, changeFrequency: 'weekly', priority: 0.8 },
    { url: `${SITE_URL}/teams`, lastModified: now, changeFrequency: 'monthly', priority: 0.9 },
    { url: `${SITE_URL}/upgrade`, lastModified: now, changeFrequency: 'monthly', priority: 0.5 },
    { url: `${SITE_URL}/privacy`, lastModified: now, changeFrequency: 'yearly', priority: 0.2 },
    { url: `${SITE_URL}/terms`, lastModified: now, changeFrequency: 'yearly', priority: 0.2 },
  ]

  const { data: courses } = await db
    .from('courses')
    .select('slug, created_at')
    .eq('is_hidden', false)

  const courseEntries: MetadataRoute.Sitemap = (courses ?? []).map(c => ({
    url: `${SITE_URL}/courses/${c.slug}`,
    lastModified: c.created_at ? new Date(c.created_at) : now,
    changeFrequency: 'weekly',
    priority: 0.85,
  }))

  const { data: subSkills } = await db
    .from('sub_skills')
    .select('slug, updated_at, categories!inner(slug)')

  const assessmentEntries: MetadataRoute.Sitemap = (subSkills ?? []).map((s: any) => ({
    url: `${SITE_URL}/assessments/${s.categories?.slug}/${s.slug}`,
    lastModified: s.updated_at ? new Date(s.updated_at) : now,
    changeFrequency: 'monthly',
    priority: 0.7,
  }))

  return [...staticEntries, ...courseEntries, ...assessmentEntries]
}
