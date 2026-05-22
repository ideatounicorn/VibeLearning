import type { Metadata } from 'next'
import { Instrument_Serif, Inter } from 'next/font/google'
import './globals.css'
import { ThemeProvider } from '@/components/ThemeProvider'
import { LayoutWrapper } from '@/components/LayoutWrapper'
import { jsonLdScriptProps, organizationJsonLd, websiteJsonLd, SITE_URL } from '@/lib/seo'

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
  metadataBase: new URL(SITE_URL),
  title: {
    default: 'VibeLearn — Career learning paths for AI, Product, Design, Marketing & Data',
    template: '%s | VibeLearn',
  },
  description:
    'Free, structured career learning paths with quizzes and certificates. Learn AI product building, UX design, product management, marketing, and data — solo or with your team.',
  keywords: [
    'AI course', 'AI product manager course', 'learn AI', 'vibe coding', 'UX design course',
    'product management course', 'digital marketing course', 'data analytics course',
    'team learning platform', 'corporate training', 'career learning paths',
  ],
  alternates: { canonical: '/' },
  authors: [{ name: 'VibeLearn' }],
  applicationName: 'VibeLearn',
  category: 'education',
  openGraph: {
    title: 'VibeLearn — Your first tech job starts here',
    description: 'Structured YouTube learning paths with quizzes. Know exactly when you\'re done.',
    type: 'website',
    url: '/',
    siteName: 'VibeLearn',
    images: [
      {
        url: '/og.png',
        width: 1200,
        height: 630,
        alt: 'VibeLearn — Your first tech job starts here',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'VibeLearn — Your first tech job starts here',
    description: 'Structured YouTube learning paths with quizzes. Know exactly when you\'re done.',
    images: ['/og.png'],
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
        <script {...jsonLdScriptProps(organizationJsonLd())} />
        <script {...jsonLdScriptProps(websiteJsonLd())} />
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
          <LayoutWrapper>{children}</LayoutWrapper>
        </ThemeProvider>
      </body>
    </html>
  )
}
