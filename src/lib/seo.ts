// SEO helpers — JSON-LD generators + canonical URL helpers.
// Pulls data live from Supabase rows passed in by the page.

export const SITE_URL = (process.env.NEXT_PUBLIC_SITE_URL || 'https://vibelearn.app').replace(/\/$/, '')
export const SITE_NAME = 'VibeLearn'

export const absoluteUrl = (path: string) =>
  `${SITE_URL}${path.startsWith('/') ? path : `/${path}`}`

type JsonLd = Record<string, unknown>

export const organizationJsonLd = (): JsonLd => ({
  '@context': 'https://schema.org',
  '@type': 'Organization',
  name: SITE_NAME,
  url: SITE_URL,
  logo: absoluteUrl('/logo.png'),
  sameAs: [
    'https://twitter.com/vibelearn',
    'https://www.linkedin.com/company/vibelearn',
  ],
})

export const websiteJsonLd = (): JsonLd => ({
  '@context': 'https://schema.org',
  '@type': 'WebSite',
  name: SITE_NAME,
  url: SITE_URL,
  potentialAction: {
    '@type': 'SearchAction',
    target: `${SITE_URL}/courses?q={search_term_string}`,
    'query-input': 'required name=search_term_string',
  },
})

export const breadcrumbJsonLd = (items: { name: string; url: string }[]): JsonLd => ({
  '@context': 'https://schema.org',
  '@type': 'BreadcrumbList',
  itemListElement: items.map((it, i) => ({
    '@type': 'ListItem',
    position: i + 1,
    name: it.name,
    item: absoluteUrl(it.url),
  })),
})

export const faqJsonLd = (faqs: { q: string; a: string }[]): JsonLd => ({
  '@context': 'https://schema.org',
  '@type': 'FAQPage',
  mainEntity: faqs.map(f => ({
    '@type': 'Question',
    name: f.q,
    acceptedAnswer: { '@type': 'Answer', text: f.a },
  })),
})

export type CourseSeoInput = {
  title: string
  slug: string
  description?: string | null
  category?: string | null
  pathName?: string | null
  totalLessons?: number
  totalHours?: number
  level?: string | null
  instructorName?: string | null
  rating?: number | null
  reviewsCount?: number | null
  enrolledCount?: number | null
  lastUpdated?: string | null
  skills?: string[] | null
}

export const courseJsonLd = (c: CourseSeoInput): JsonLd => {
  const url = absoluteUrl(`/courses/${c.slug}`)
  const node: JsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Course',
    name: c.title,
    description: c.description ?? `Learn ${c.title} with structured lessons and quizzes on ${SITE_NAME}.`,
    url,
    provider: {
      '@type': 'Organization',
      name: SITE_NAME,
      sameAs: SITE_URL,
    },
    educationalLevel: c.level ?? 'Beginner',
    inLanguage: 'en',
    hasCourseInstance: {
      '@type': 'CourseInstance',
      courseMode: 'online',
      courseWorkload: c.totalHours ? `PT${Math.max(1, Math.round(c.totalHours))}H` : 'PT10H',
    },
  }
  if (c.skills && c.skills.length) node.teaches = c.skills
  if (c.lastUpdated) node.dateModified = c.lastUpdated
  if (c.rating && c.reviewsCount && c.reviewsCount > 0) {
    node.aggregateRating = {
      '@type': 'AggregateRating',
      ratingValue: c.rating,
      reviewCount: c.reviewsCount,
      bestRating: 5,
      worstRating: 1,
    }
  }
  if (c.instructorName) {
    node.instructor = { '@type': 'Person', name: c.instructorName }
  }
  return node
}

export type PathSeoInput = {
  name: string
  slug: string
  description?: string | null
  category?: string | null
  totalHours?: number | null
  totalCourses?: number
  salaryRange?: string | null
}

export const learningPathJsonLd = (p: PathSeoInput): JsonLd => ({
  '@context': 'https://schema.org',
  '@type': 'Course',
  name: `${p.name} — Career Learning Path`,
  description: p.description ?? `Full ${p.name} career learning path on ${SITE_NAME}.`,
  url: absoluteUrl(`/paths/${p.slug}`),
  provider: { '@type': 'Organization', name: SITE_NAME, sameAs: SITE_URL },
  educationalCredentialAwarded: 'Certificate of Completion',
  hasCourseInstance: {
    '@type': 'CourseInstance',
    courseMode: 'online',
    courseWorkload: p.totalHours ? `PT${Math.round(p.totalHours)}H` : 'PT40H',
  },
})

export const jsonLdScriptProps = (data: JsonLd) => ({
  type: 'application/ld+json',
  dangerouslySetInnerHTML: { __html: JSON.stringify(data) },
})

// Standard FAQ used on every course page when course-specific FAQs are not set.
export const courseDefaultFaqs = (title: string, pathName?: string | null) => [
  {
    q: `Is the ${title} course free?`,
    a: `Yes. Every learner gets free access to the ${title} curriculum on ${SITE_NAME}. A Pro plan unlocks certificates, the full career path, and team features.`,
  },
  {
    q: `How long does ${title} take to complete?`,
    a: `Most learners finish in 2–4 weeks with 30 minutes a day. The course is self-paced, so you can move faster or slower.`,
  },
  {
    q: `Do I get a certificate at the end?`,
    a: `Pro learners receive a shareable certificate of completion that can be added to LinkedIn, resumes, and portfolios.`,
  },
  {
    q: `Is ${title} good for beginners?`,
    a: `Yes${pathName ? `, the ${pathName} path is designed to take you from zero to job-ready` : ''}. Lessons start from fundamentals and build into applied projects.`,
  },
  {
    q: `Can my team or company use ${SITE_NAME}?`,
    a: `Yes — ${SITE_NAME} for Teams provides bulk seats, manager dashboards, skill tracking, and SSO. See /teams for details.`,
  },
]
