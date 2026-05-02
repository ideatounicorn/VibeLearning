import { supabaseServer } from '@/lib/supabase-server'
import { redirect } from 'next/navigation'
import { BookmarksClient } from '@/components/bookmarks/BookmarksClient'

export const metadata = { title: 'Bookmarks — VibeLearn' }

export default async function BookmarksPage() {
  const db = await supabaseServer()
  const { data: { user } } = await db.auth.getUser()
  if (!user) redirect('/?auth=required')

  const { data: bookmarks } = await db
    .from('bookmarks')
    .select('*')
    .eq('user_id', user.id)
    .order('created_at', { ascending: false })

  return <BookmarksClient initialBookmarks={bookmarks ?? []} />
}
