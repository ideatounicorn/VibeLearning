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
    { url: `${SITE_URL}/paths`, lastModified: now, changeFrequency: 'weekly', priority: 0.9 },
    { url: `${SITE_URL}/assessments`, lastModified: now, changeFrequency: 'weekly', priority: 0.7 },
    { url: `${SITE_URL}/teams`, lastModified: now, changeFrequency: 'monthly', priority: 0.9 },
    { url: `${SITE_URL}/upgrade`, lastModified: now, changeFrequency: 'monthly', priority: 0.5 },
    { url: `${SITE_URL}/privacy`, lastModified: now, changeFrequency: 'yearly', priority: 0.2 },
    { url: `${SITE_URL}/terms`, lastModified: now, changeFrequency: 'yearly', priority: 0.2 },
  ]

  const { data: paths } = await db
    .from('paths')
    .select('slug, created_at')
    .eq('is_published', true)

  const pathEntries: MetadataRoute.Sitemap = (paths ?? []).map(p => ({
    url: `${SITE_URL}/paths/${p.slug}`,
    lastModified: p.created_at ? new Date(p.created_at) : now,
    changeFrequency: 'weekly',
    priority: 0.8,
  }))

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

  return [...staticEntries, ...pathEntries, ...courseEntries]
}
