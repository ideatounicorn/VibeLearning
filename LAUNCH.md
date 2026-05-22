# VibeLearning Launch Checklist

> Update this file as tasks complete. Mark done with `[x]`. Last updated: 2026-05-04.

---

## 🔴 ESSENTIAL — Blockers (do not launch without these)

### Auth & Core Flow
- [ ] End-to-end test: sign up → onboarding → dashboard → enroll → watch lesson → quiz
- [ ] Verify Supabase RLS applied (`supabase-fix-enrollment-rls.sql` confirmed run on prod)
- [ ] Auth redirect works correctly after login (no loops, correct destination)

### Content
- [ ] Seed assessment questions (currently "Questions coming soon" on all assessments)
- [ ] Either populate Data Analysis path OR remove its "Coming Soon" card from landing page

### Payments
- [ ] Polar webhook → `subscriptions` table tested end-to-end (pay → Pro activates)
- [ ] Polar product ID confirmed pointing to correct live product (not sandbox)
- [ ] Upgrade page: remove League Leaderboard + Skill Graph from feature list if not built
- [ ] 7-day refund policy works (Polar configured to allow it)

### Database (prod Supabase)
- [ ] `supabase-schema.sql` applied
- [ ] `supabase-phase2-migration.sql` applied
- [ ] `supabase-phase3-migration.sql` applied
- [ ] `supabase-phase4-migration.sql` applied
- [ ] `supabase-assessments-migration.sql` applied
- [ ] `supabase-flashcard-cache-migration.sql` applied
- [ ] `supabase-fix-enrollment-rls.sql` applied
- [ ] Insert modules SQL applied (`insert_modules.sql`)

### Environment Variables (Vercel prod)
- [ ] `NEXT_PUBLIC_SUPABASE_URL`
- [ ] `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- [ ] `SUPABASE_SERVICE_ROLE_KEY`
- [ ] `POLAR_ACCESS_TOKEN`
- [ ] `NEXT_PUBLIC_POLAR_PRODUCT_ID`
- [ ] `NEXT_PUBLIC_SITE_URL` (set to `https://vibelearn.app`)
- [ ] `RESEND_API_KEY`
- [ ] `GOOGLE_GENERATIVE_AI_API_KEY`

### Legal (Polar requires these to accept payments)
- [ ] Privacy Policy page (`/privacy`)
- [ ] Terms of Service page (`/terms`)
- [ ] Cookie consent banner (minimal, covers analytics)

---

## 🟡 ESSENTIAL — Launch quality (ship within first week)

### Error Tracking — Sentry
- [ ] Install `@sentry/nextjs`
- [ ] Run `npx @sentry/wizard@latest -i nextjs` to generate config files
- [ ] Set `SENTRY_DSN` in Vercel env vars
- [ ] Confirm errors surface in Sentry dashboard after a test throw
- [ ] Set up Sentry alert → email/Slack on first occurrence of new error

### Analytics — PostHog
- [ ] Create PostHog project at posthog.com
- [ ] Install `posthog-js` and `posthog-node`
- [ ] Add PostHog provider to `layout.tsx`
- [ ] Set `NEXT_PUBLIC_POSTHOG_KEY` and `NEXT_PUBLIC_POSTHOG_HOST` in Vercel
- [ ] Implement funnel events (see PostHog Funnel Events section below)
- [ ] Create funnel dashboard in PostHog: Landing → Sign Up → Enroll → Lesson → Quiz → Upgrade

### Email — Resend
- [ ] Verify `vibelearn.app` domain in Resend dashboard (DNS records added)
- [ ] Confirm `hey@vibelearn.app` not hitting spam (test with mail-tester.com)
- [ ] Welcome email fires on sign up (test manually)
- [ ] Streak nudge cron fires correctly (check Vercel cron logs)
- [ ] Add: Upgrade confirmation email when Polar webhook fires
- [ ] Add: Certificate issued email when user completes a course

### SEO & Social
- [ ] Add OG image (1200×630) to `/public/og.png`
- [ ] Wire OG image in `layout.tsx` metadata: `openGraph.images`
- [ ] Add `twitter:card` metadata
- [ ] Verify `sitemap.xml` exists or generate one
- [ ] Verify `robots.txt` allows indexing

### Deployment
- [ ] Custom domain `vibelearn.app` pointed to Vercel
- [ ] HTTPS/SSL confirmed active
- [ ] Vercel cron (`/api/cron/streak-reset`) verified working in prod logs
- [ ] Build passes with zero TypeScript errors (`npm run build`)

---

## 🟢 GOOD TO HAVE — Post-launch (first month)

### Features
- [ ] League leaderboard (currently sold on upgrade page but not built)
- [ ] Skill graph & benchmarks (currently sold on upgrade page but not built)
- [ ] Email notification preferences (settings says "coming soon")
- [ ] Certificate: test PDF generation end-to-end for each path

### Monitoring
- [ ] Uptime monitor (UptimeRobot or Better Uptime on `vibelearn.app`)
- [ ] Vercel spend alert set (avoid surprise bills from AI API calls)
- [ ] PostHog session recordings enabled for onboarding flow

### Growth
- [ ] Google Search Console verified
- [ ] Submit sitemap to Google Search Console
- [ ] Set up Resend broadcast list for launch announcement
- [ ] Add referral/share prompt after certificate issued

---

## 📊 PostHog Funnel Events

Instrument these in client components and API routes. Goal: see exactly where users drop off.

### Acquisition
```
page_viewed          { page: '/' }
page_viewed          { page: '/paths' }
page_viewed          { page: '/courses' }
```

### Activation
```
auth_modal_opened    { trigger: 'cta' | 'enroll_gate' | 'quiz_gate' | 'nav' }
sign_up_started      { method: 'email' }
sign_up_completed    { method: 'email' }
sign_in_completed    { method: 'email' }
onboarding_started
onboarding_step_completed   { step: 1 | 2 | 3, goal: string }
onboarding_completed        { goal: string, experience: string }
```

### Engagement
```
path_viewed          { path_slug: string, path_name: string }
course_viewed        { course_slug: string, course_name: string, path_slug: string }
course_enrolled      { course_id: string, course_name: string, path_slug: string }
lesson_started       { lesson_id: string, module_id: string, course_slug: string, lesson_index: number }
lesson_completed     { lesson_id: string, module_id: string, course_slug: string, xp_earned: number }
module_completed     { module_id: string, course_slug: string, lessons_count: number }
course_completed     { course_id: string, course_name: string, path_slug: string }
```

### Retention
```
quiz_started         { module_id: string, course_slug: string }
quiz_completed       { module_id: string, score: number, xp_earned: number, passed: boolean }
quiz_failed          { module_id: string, score: number }
streak_milestone     { days: number }
bookmark_added       { content_type: 'lesson' | 'course', content_id: string }
assessment_started   { assessment_slug: string }
assessment_completed { assessment_slug: string, score: number, passed: boolean }
```

### Revenue
```
upgrade_page_viewed  { source: 'nav' | 'paywall' | 'quiz_gate' | 'certificate_gate' | 'direct' }
paywall_hit          { feature: 'module' | 'quiz' | 'certificate' | 'assessment', location: string }
checkout_started     { plan: 'pro_monthly' | 'pro_annual' }
subscription_activated   { plan: string, amount: number }
subscription_cancelled   { plan: string, days_active: number }
certificate_issued   { course_id: string, path_slug: string }
```

### Key Funnels to Build in PostHog Dashboard
1. **Signup funnel**: `page_viewed(/)` → `auth_modal_opened` → `sign_up_completed` → `onboarding_completed`
2. **Activation funnel**: `sign_up_completed` → `course_enrolled` → `lesson_completed` → `quiz_completed`
3. **Revenue funnel**: `upgrade_page_viewed` → `paywall_hit` → `checkout_started` → `subscription_activated`
4. **Retention funnel**: `lesson_completed` (day 1) → repeat (day 3) → repeat (day 7)

---

## 🔧 Quick Reference — Key Files

| What | Where |
|------|-------|
| Payments | `src/app/api/polar/checkout/route.ts` |
| Polar webhook | `src/app/api/webhooks/polar/route.ts` |
| Progress tracking | `src/app/api/progress/lesson/route.ts` |
| Email | `src/lib/email.ts` |
| Auth callback | `src/app/auth/callback/route.ts` |
| Upgrade page | `src/app/upgrade/page.tsx` |
| Lesson player | `src/components/learn/LessonPlayer.tsx` |
| Cron | `src/app/api/cron/streak-reset/route.ts` |
