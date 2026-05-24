import { notFound } from 'next/navigation'
import { TOPICS } from '@/lib/vibe-topics'
import VibeExperience from '@/components/vibe/VibeExperience'

export default async function VibePage({ params }: { params: Promise<{ topic: string }> }) {
  const { topic } = await params
  const data = TOPICS[topic]
  if (!data) notFound()
  return <VibeExperience topic={data} />
}

export async function generateStaticParams() {
  return Object.keys(TOPICS).map((topic) => ({ topic }))
}
