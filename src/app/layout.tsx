import type { Metadata } from 'next'
import { Instrument_Serif, Inter } from 'next/font/google'
import './globals.css'
import { ThemeProvider } from '@/components/ThemeProvider'
import { LayoutWrapper } from '@/components/LayoutWrapper'

const serif = Instrument_Serif({
  subsets: ['latin'],
  weight: '400',
  style: ['normal', 'italic'],
  variable: '--font-serif',
})

const sans = Inter({
  subsets: ['latin'],
  variable: '--font-sans',
})

export const metadata: Metadata = {
  title: 'VibeLearn — Your first tech job starts here',
  description:
    'Free, structured career learning paths built from the best YouTube has to offer. Learn AI, UX, Product Management, Marketing, and Data Analysis with quizzes that confirm your understanding.',
  keywords: ['career learning', 'tech job', 'YouTube learning', 'AI course', 'UX design', 'product management'],
  openGraph: {
    title: 'VibeLearn — Your first tech job starts here',
    description: 'Structured YouTube learning paths with quizzes. Know exactly when you\'re done.',
    type: 'website',
  },
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" className={`${serif.variable} ${sans.variable}`} suppressHydrationWarning>
      <body
        className="grain"
        style={{ fontFamily: 'var(--font-sans), system-ui, sans-serif' }}
      >
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
          <LayoutWrapper>{children}</LayoutWrapper>
        </ThemeProvider>
      </body>
    </html>
  )
}
