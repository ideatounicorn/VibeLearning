import { supabaseServer } from '@/lib/supabase-server'
import Link from 'next/link'
import { redirect } from 'next/navigation'

export const metadata = {
  title: 'PM Assessments — VibeLearn',
}

export default async function AssessmentsPage() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()

  if (!user) {
    redirect('/?auth=required')
  }

  // Fetch all categories and their sub-skills
  const { data: categories, error } = await db
    .from('categories')
    .select(`
      id,
      name,
      slug,
      description,
      sub_skills (
        id,
        name,
        slug,
        description,
        display_questions,
        time_limit_minutes
      )
    `)
    .order('display_order')

  // We sort sub_skills using javascript to ensure predictable order
  const categoriesWithSortedSkills = categories?.map(cat => ({
    ...cat,
    sub_skills: [...(cat.sub_skills || [])].sort((a, b) => a.name.localeCompare(b.name))
  })) || []

  return (
    <div className="w-full max-w-5xl mx-auto px-4 py-8">
      {/* Top Filter */}
      <div className="flex items-center justify-between mb-10 border-b border-[var(--border)] pb-6">
        <div>
          <h1 className="text-3xl font-extrabold text-[var(--text-primary)] mb-2">Assessments</h1>
          <p className="text-[var(--text-muted)] text-sm">Validate your product management skills and earn proficiency badges.</p>
        </div>
        <div className="flex gap-2">
          <div className="px-4 py-1.5 rounded-full bg-[var(--green)] text-[var(--btn-text)] text-sm font-bold shadow-sm">
            PM (Product Management)
          </div>
        </div>
      </div>

      {categoriesWithSortedSkills.map((category) => (
        <div key={category.id} className="mb-12">
          <h2 className="text-xl font-bold text-[var(--text-primary)] mb-1">{category.name}</h2>
          <p className="text-sm text-[var(--text-muted)] mb-5">{category.description}</p>
          
          <div className="flex flex-wrap gap-3">
            {category.sub_skills?.map(skill => (
              <Link 
                key={skill.id} 
                href={`/assessments/${skill.id}`}
                className="group relative px-5 py-3 rounded-xl border border-[var(--border)] bg-[var(--bg-secondary)] hover:border-[var(--green)] hover:bg-color-mix(in srgb, var(--green) 5%, transparent) transition-all duration-200"
              >
                <div className="font-semibold text-[var(--text-primary)] text-sm mb-1 group-hover:text-[var(--green)] transition-colors">
                  {skill.name}
                </div>
                <div className="text-[0.65rem] text-[var(--text-muted)] font-medium uppercase tracking-wider">
                  {skill.display_questions} Qs • {skill.display_questions * 0.5} mins
                </div>
              </Link>
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}
