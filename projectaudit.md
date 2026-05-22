Reading repo structure first.

Let me check a few remaining files quickly.

Good — middleware is missing, meaning route protection via `proxy.ts` is completely non-functional. Now I have everything needed.

---

# VibeLearning — Project Audit Document

---

## 1. 📁 Repository File Map

```
VibeLearning/
├── .env.local                          — env vars (Supabase, Gemini, Resend, Polar)
├── .vercel/project.json                — Vercel project linkage
├── vercel.json                         — Cron job config (streak-reset daily)
├── package.json                        — Dependencies manifest
├── tsconfig.json                       — TypeScript config
├── eslint.config.mjs                   — ESLint rules
├── postcss.config.mjs                  — PostCSS/Tailwind config
├── CLAUDE.md / AGENTS.md               — AI agent instructions
├── LAUNCH.md                           — Launch checklist/notes
├── README.md                           — Project readme
│
├── public/
│   ├── logo.png                        — App logo
│   └── *.svg                           — Default Next.js placeholder SVGs
│
├── scripts/
│   ├── seed.ts                         — DB seeder script
│   ├── seed-flashcards.ts              — Flashcard seeder via Gemini AI
│   └── generate-sql.ts                 — SQL generation helper
│
├── supabase-schema.sql                 — Core DB schema (paths→courses→modules→lessons→quizzes)
├── supabase-phase2-migration.sql       — Adds bookmarks, reflections tables
├── supabase-phase3-migration.sql       — Unknown (not read, but referenced)
├── supabase-phase4-migration.sql       — Adds certificates, path_enrollments, course_intro_views
├── supabase-assessments-migration.sql  — Assessments + questions + user_assessments tables + 5 seed Qs each
├── supabase-fix-enrollment-rls.sql     — RLS policy fix for enrollments
├── supabase-flashcard-cache-migration.sql — Adds flashcard_data JSONB column to courses
├── seed-data.sql                       — Seed data SQL
│
└── src/
    ├── proxy.ts                        — ⚠️ Dead code: middleware logic exported from wrong path (should be middleware.ts)
    │
    ├── lib/
    │   ├── supabase.ts                 — Browser Supabase client factory
    │   ├── supabase-server.ts          — Server Supabase client + admin client
    │   ├── email.ts                    — Resend email helpers (welcome, streak nudge)
    │   ├── recommend.ts                — Course recommendation scoring logic
    │   ├── roadmap-data.ts             — Hardcoded onboarding role/roadmap definitions
    │   └── category-constants.ts       — Category→gradient color map
    │
    ├── app/
    │   ├── layout.tsx                  — Root layout with nav, theme provider
    │   ├── globals.css                 — CSS custom properties, design tokens, utility classes
    │   ├── page.tsx                    — Landing page with hero, paths grid, social proof
    │   ├── icon.png                    — Favicon
    │   │
    │   ├── auth/callback/route.ts      — Supabase OAuth callback handler
    │   ├── onboarding/page.tsx         — 6-stage onboarding flow (profile→role→story→generate→roadmap→premium)
    │   ├── dashboard/page.tsx          — Authenticated dashboard (progress, XP, streak)
    │   ├── paths/
    │   │   ├── page.tsx               — Browse all career paths
    │   │   └── [slug]/page.tsx         — Path detail with courses list
    │   ├── courses/
    │   │   ├── page.tsx               — Course catalog
    │   │   └── [slug]/page.tsx         — Course detail (syllabus, enroll)
    │   ├── course-intro/[courseSlug]/page.tsx — Pre-lesson course intro/orientation
    │   ├── learn/[courseSlug]/[moduleSlug]/page.tsx — Lesson player page
    │   ├── quiz/[moduleId]/page.tsx    — Module quiz (auto-passes if no questions)
    │   ├── assessments/
    │   │   ├── page.tsx               — Assessment catalog grid
    │   │   ├── [slug]/page.tsx         — Assessment detail
    │   │   └── [slug]/take/page.tsx    — Take assessment
    │   ├── bookmarks/page.tsx          — Saved bookmarks
    │   ├── certificate/[id]/page.tsx   — Shareable certificate view
    │   ├── profile/page.tsx            — Public/private user profile
    │   ├── settings/page.tsx           — Account settings
    │   ├── upgrade/page.tsx            — Pricing/upgrade page
    │   │
    │   └── api/
    │       ├── assessments/recommend/route.ts  — Scoring-based course/path recommendations post-assessment
    │       ├── assessments/report/route.ts     — Per-topic score breakdown generation
    │       ├── assessments/submit/route.ts     — Save completed assessment + award XP
    │       ├── bookmarks/route.ts              — Create bookmark / list bookmarks
    │       ├── bookmarks/[id]/route.ts         — Delete bookmark
    │       ├── certificate/generate/route.ts   — Upsert certificate record
    │       ├── course/flashcards/route.ts      — Serve cached flashcard_data (Gemini-generated, fallback static)
    │       ├── cron/streak-reset/route.ts      — Bearer-gated cron: resets expired streaks
    │       ├── enroll/course/route.ts          — Enroll user in a course
    │       ├── enroll/path/route.ts            — Enroll user in path + all its courses
    │       ├── enrollments/route.ts            — List user enrollments
    │       ├── polar/checkout/route.ts         — Create Polar checkout session, redirect
    │       ├── profile/update/route.ts         — Update profile fields
    │       ├── progress/lesson/route.ts        — Mark lesson done, award XP, update streak
    │       ├── progress/quiz/route.ts          — Submit quiz score, award XP, mark module complete
    │       ├── settings/update/route.ts        — Save settings changes
    │       └── webhooks/polar/route.ts         — HMAC-verified Polar subscription webhook
    │
    └── components/
        ├── AppShell.tsx                — App shell wrapper
        ├── AuthModal.tsx               — Email/password + Google OAuth modal
        ├── BookmarkButton.tsx          — Toggle bookmark UI
        ├── LayoutWrapper.tsx           — Conditional nav layout
        ├── Nav.tsx                     — Top navigation bar
        ├── PathsGrid.tsx               — Reusable paths grid component
        ├── Sidebar.tsx                 — Sidebar nav
        ├── ThemeProvider.tsx           — next-themes dark/light wrapper
        ├── assessments/
        │   ├── AssessmentDetail.tsx    — Assessment info + start CTA
        │   ├── AssessmentQuiz.tsx      — Full timed quiz engine + results report
        │   └── AssessmentsGrid.tsx     — Assessment catalog card grid
        ├── bookmarks/BookmarksClient.tsx — Bookmarks list UI
        ├── certificate/CertificateDesign.tsx — Printable certificate + LinkedIn share
        ├── course-intro/CourseIntroClient.tsx — Course intro/orientation UI
        ├── courses/
        │   ├── CourseEnrollButton.tsx  — Enroll CTA button
        │   ├── CourseSyllabus.tsx      — Module/lesson list display
        │   └── CoursesClient.tsx       — Course catalog client component
        ├── dashboard/
        │   ├── ContinueLearning.tsx    — Resume learning widget
        │   ├── EnrolledCoursesBlock.tsx — Enrolled courses with progress bars
        │   ├── GettingStarted.tsx      — Checklist widget for new users
        │   ├── PathRoadmapWidget.tsx   — Sidebar roadmap preview
        │   ├── RecommendedCourses.tsx  — Suggested courses widget
        │   └── StreakTracker.tsx        — Streak display widget
        ├── learn/LessonPlayer.tsx      — YouTube embed + lesson nav + mark-done + XP float
        ├── paths/PathDetailClient.tsx  — Path detail client component
        ├── profile/ProfileClient.tsx   — Profile client component
        ├── quiz/QuizClient.tsx         — Module quiz UI (pass/fail + XP)
        ├── roadmap/RoadmapClient.tsx   — Roadmap visualization
        └── settings/SettingsClient.tsx — Settings form
```

---

## 2. 🛠️ Tech Stack

| Category | Technology |
|---|---|
| **Framework** | Next.js 16.2.4 (App Router, RSC) |
| **UI Library** | React 19 |
| **Styling** | Tailwind CSS v4, inline `style` objects (mixed approach) |
| **Animation** | Framer Motion 12 |
| **Database** | Supabase (PostgreSQL) with Row Level Security |
| **Auth** | Supabase Auth — email/password + Google OAuth |
| **ORM/Client** | @supabase/supabase-js v2, @supabase/ssr |
| **AI** | Google Gemini AI (@google/generative-ai 0.24) |
| **Payments** | Polar.sh (@polar-sh/sdk 0.47) |
| **Email** | Resend (resend 6.12) |
| **Theme** | next-themes 0.4 |
| **CSV parsing** | csv-parse 6.2 (scripts only) |
| **Deployment** | Vercel (project linked, cron configured) |
| **Language** | TypeScript 5 |
| **Runtime scripts** | tsx 4 |

---

## 3. 🧠 What Is Built (Product Summary)

VibeLearn is a structured YouTube-curated learning platform targeting career switchers and students trying to break into tech roles (UX Design, Product Management, AI, Digital Marketing, Data Analysis). Unlike raw YouTube playlists, it wraps curated video lessons in a course/module/quiz progression system that enforces comprehension before advancing. The product earns revenue through a freemium model via Polar.sh subscriptions, offering the first two modules of each path for free and gating the rest behind a Pro tier. It includes XP gamification, daily streaks, standalone skill assessments, sharable certificates, and a detailed onboarding flow that shows users a "day in the life" roadmap for their chosen career.

---

## 4. ✅ Completed Features

| Feature | Status |
|---|---|
| Email/password signup + Google OAuth via Supabase | [Fully Built] |
| 6-stage animated onboarding flow (profile → role → story carousel → roadmap → premium upsell) | [Fully Built] |
| Auto-profile creation trigger on Supabase signup | [Fully Built] |
| Landing page with hero, paths grid, "how it works," social proof, in-progress course resume | [Fully Built] |
| Career path browsing + path detail pages | [Fully Built] |
| Course catalog + course detail/syllabus pages | [Fully Built] |
| Course enrollment (individual + full-path bulk enroll) | [Fully Built] |
| Course intro/orientation page before first lesson | [Fully Built] |
| YouTube lesson player with module sidebar, lesson progress, and XP float animation | [Fully Built] |
| "Mark as done" lesson progress tracking (PATCH `/api/progress/lesson`) | [Fully Built] |
| Module quiz (MCQ, 4 options, pass/fail, 2/3 threshold, XP award) | [Fully Built] |
| Auto-pass modules with no quiz questions | [Fully Built] |
| Next-module / next-course navigation after quiz pass | [Fully Built] |
| Dashboard with XP total, streak days, module count, enrolled courses, quick links | [Fully Built] |
| Streak tracking: increments on lesson completion, daily cron resets expired streaks | [Fully Built] |
| XP system: 10 XP/lesson, 50–150 XP/quiz, 30 XP/assessment question | [Fully Built] |
| Standalone assessment system: 8 assessments, timed (30s/question), per-topic breakdown, report | [Fully Built] |
| Post-assessment scoring-based course/path recommendations | [Fully Built] |
| Bookmark create/delete/list | [Fully Built] |
| Certificate generation (course/path/assessment types) with LinkedIn share + copy link | [Fully Built] |
| Upgrade/pricing page with feature comparison table | [Fully Built] |
| Polar.sh checkout redirect (create checkout session) | [Fully Built] |
| Polar webhook handler (subscription.created/updated/canceled) with HMAC verification | [Fully Built] |
| Pro subscription status check throughout app | [Fully Built] |
| User profile page | [Fully Built] |
| Settings page with update API | [Fully Built] |
| Dark/light theme toggle via next-themes | [Fully Built] |
| Flashcard system with Gemini-generated content (cached in DB, static fallback) | [Partially Built] |
| Vercel cron for streak reset at midnight daily | [Fully Built] |
| Welcome email template via Resend | [Partially Built] — defined but **never called** in auth flow |
| Streak nudge email template | [Partially Built] — defined but **no cron calls it** |

---

## 5. 🚧 Incomplete / Partially Built Features

| Gap | File(s) |
|---|---|
| **Route protection middleware is dead** — `src/proxy.ts` exports middleware logic but Next.js requires `src/middleware.ts`; auth guards on `/dashboard`, `/learn`, `/quiz` etc. are not enforced at edge, only by server-component redirects | `src/proxy.ts` |
| **Gemini API key not configured** — placeholder `your_gemini_api_key` means flashcard generation falls back to static data for all users | `.env.local` |
| **Resend API key not configured** — placeholder `your_resend_api_key` means no emails send | `.env.local` |
| **Welcome email never triggered** — `sendWelcomeEmail()` defined but no call site in auth flow (not called after signup in `AuthModal.tsx` or `auth/callback/route.ts`) | `src/lib/email.ts`, `src/components/AuthModal.tsx`, `src/app/auth/callback/route.ts` |
| **Streak nudge email never sent** — `sendStreakNudge()` defined but no cron or trigger calls it | `src/lib/email.ts` |
| **POLAR_ACCESS_TOKEN missing from `.env.local`** — checkout route reads `process.env.POLAR_ACCESS_TOKEN` which doesn't exist in the env file; checkout will always redirect to `/upgrade?error=missing_config` | `src/app/api/polar/checkout/route.ts`, `.env.local` |
| **POLAR_WEBHOOK_SECRET missing** — webhook signature verification skips when secret empty; not in `.env.local` | `src/app/api/webhooks/polar/route.ts` |
| **CRON_SECRET missing** — streak-reset cron has no secret configured, meaning the `Bearer undefined` check will always fail | `.env.local`, `src/app/api/cron/streak-reset/route.ts` |
| **Assessment questions are dev seeds only** — 5 questions seeded per assessment; comments say "Production: add full 25-question sets via admin panel." No admin panel exists | `supabase-assessments-migration.sql` line 148 |
| **Freemium gating not enforced** — upgrade page claims "first 2 modules free"; `LessonPlayer.tsx` and quiz pages receive `isPro` prop but no hard gate prevents free users from accessing paid modules beyond first 2 | `src/components/learn/LessonPlayer.tsx`, `src/app/learn/[courseSlug]/[moduleSlug]/page.tsx` |
| **Data Analysis path hardcoded "Coming Soon"** — `PATHS` array in `page.tsx` marks it `badge: 'Coming Soon'` and disables the link | `src/app/page.tsx:63` |
| **Recommendation engine relies on `courses.level` and `courses.tags` columns** — these columns are selected in `/api/assessments/recommend/route.ts` but not defined in `supabase-schema.sql` | `src/app/api/assessments/recommend/route.ts:19` |

---

## 6. ❌ Missing Features (Not Yet Started)

| Missing Feature | Evidence |
|---|---|
| **Admin content management panel** — no routes, no protected admin area for adding/editing assessments, courses, lessons, quiz questions | Assessment migration comment; no `/admin` routes anywhere |
| **League leaderboard** — listed as Pro feature in `upgrade/page.tsx` under "GROW" section | `src/app/upgrade/page.tsx:24` — no route or component |
| **Skill graph & benchmarks** — listed as Pro feature in upgrade page | `src/app/upgrade/page.tsx:23` — no route or component |
| **"Automated review + instructor feedback" for projects** — mentioned in onboarding roadmap `RoadmapDetailPanel` project type | `src/app/onboarding/page.tsx:464` — no backend for project submission |
| **Test suite** — zero test files, no Jest/Vitest/Playwright config | Entire repo |
| **Error pages (404, 500)** — no `not-found.tsx` or `error.tsx` anywhere in `src/app/` | `src/app/` |
| **SEO/Open Graph metadata** — only basic `title` metadata set on a few pages; no `og:image`, `og:description`, Twitter cards | `src/app/layout.tsx` |
| **Rate limiting on API routes** — no rate limiting on assessment submit, enrollment, quiz submission endpoints | All API routes |
| **Reflection/notes on lessons** — `reflections` table exists in schema but no UI or API routes use it | `supabase-schema.sql:144` |
| **Path completion detection + path certificate trigger** — `path_enrollments` table exists; `certificate/generate` supports `type=path`, but no logic detects when all path courses are complete and triggers a path certificate | `src/app/api/certificate/generate/route.ts` |
| **Streak nudge delivery** — email function defined, cron job NOT configured in `vercel.json` | `src/lib/email.ts:29`, `vercel.json` |
| **Waitlist / notify for "Coming Soon" Data Analysis path** | `src/app/page.tsx:63` |
| **User deletion / account management** | No route exists |

---

## 7. 📊 Completion Estimate

**Overall: ~62%**

| Layer | % | Justification |
|---|---|---|
| **Frontend / UI** | 80% | All core pages built and polished. Missing: leaderboard, skill graph, error pages, Data Analysis path, admin UI |
| **Backend / API** | 65% | Core CRUD routes all present. Missing: freemium enforcement, admin routes, reflection API, path-completion trigger, rate limiting |
| **Database / Models** | 85% | Schema comprehensive with RLS. Missing: `courses.level`, `courses.tags` columns referenced but undefined; path-completion logic |
| **Auth & Security** | 45% | Supabase Auth works; Google OAuth works. **Critical gaps**: middleware dead (route protection not enforced at edge), Polar webhook secret unconfigured, CRON_SECRET unconfigured, freemium not enforced |
| **Integrations (Polar, Gemini, Resend)** | 25% | All three integrations have code skeletons but all three have placeholder/missing env vars — none work in production |
| **Testing** | 0% | Zero tests |
| **DevOps / Deployment** | 70% | Vercel linked, streak-reset cron configured, schema migrations organized. Missing: staging env, missing secrets, CI/CD pipeline |

---

## 8. 📝 Prioritized To-Do List

### 🔴 Critical

```
[ ] Fix route protection middleware — rename src/proxy.ts → src/middleware.ts so auth guards actually run at edge (currently /dashboard, /learn, /quiz are unprotected server-side only)
[ ] Add POLAR_ACCESS_TOKEN to .env.local + Vercel env — Polar checkout returns error for every user right now
[ ] Add POLAR_WEBHOOK_SECRET to env — subscription events processed without verification = security hole
[ ] Add CRON_SECRET to env + vercel.json — streak cron always returns 401, streaks never reset
[ ] Set real GEMINI_API_KEY — flashcard generation falls back to static data for all users
[ ] Set real RESEND_API_KEY — no emails send (welcome, streak nudge)
[ ] Add missing courses.level and courses.tags columns to schema — assessment recommendation query selects them; results silently wrong
```

### 🟠 High

```
[ ] Enforce freemium gating in lesson player — isPro prop exists but no hard gate; free users can access all modules, breaking the business model (src/app/learn/[courseSlug]/[moduleSlug]/page.tsx)
[ ] Wire welcome email call in auth callback — src/app/auth/callback/route.ts should call sendWelcomeEmail() after successful signup
[ ] Seed full 25-question sets for all 8 assessments — currently 5 dev questions each, assessment is too short for production
[ ] Add /api/cron/streak-nudge route + vercel.json cron entry — sendStreakNudge() is defined but never called
[ ] Add path completion detection — when user passes all courses in a path, generate a path certificate automatically
```

### 🟡 Medium

```
[ ] Add 404 (not-found.tsx) and 500 (error.tsx) error pages — Next.js App Router convention, currently crashes to framework defaults
[ ] Build admin panel for content management — assessments need full Q&A sets added without SQL access
[ ] Unlock Data Analysis path — "Coming Soon" is hardcoded in page.tsx:63, path exists in schema
[ ] Add OG metadata (og:image, og:description) to key pages for social sharing — certificate and path pages especially
[ ] Implement reflections UI — table exists in schema, no UI or API exposed
[ ] Add rate limiting to sensitive API routes — /api/assessments/submit, /api/enroll/course, /api/progress/quiz
```

### 🟢 Low

```
[ ] Build leaderboard page — listed as Pro feature in upgrade/page.tsx, no implementation
[ ] Build skill graph/benchmarks — listed as Pro feature, no implementation  
[ ] Add "Coming Soon" waitlist form for Data Analysis path
[ ] Add account deletion flow (GDPR) — no user deletion route exists
[ ] Replace hardcoded social proof testimonials with real user data
[ ] Add E2E test suite (Playwright recommended for Next.js) — currently 0% test coverage
[ ] Add SEO sitemap generation for paths/courses/assessments pages
```