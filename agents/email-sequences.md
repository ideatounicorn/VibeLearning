# Agent: Email Conversion Sequences

Wire up a 7-email sequence using the existing Resend integration. Every email has one job. No fluff.

## Trigger map

| Email | Trigger | Delay | Goal |
|-------|---------|-------|------|
| 1 | Signup | Immediate | Get them to start their path |
| 2 | Path selected | +1 day | Reinforce commitment |
| 3 | First quiz passed | Immediate | Celebrate + soft upgrade |
| 4 | No activity for 3 days | +3 days from last activity | Re-engage |
| 5 | Module 2 quiz passed (paywall approaching) | Immediate | Upgrade pitch |
| 6 | Trial started, day 5 | +5 days from trial start | Remind before trial ends |
| 7 | Trial ended, not converted | +1 day after trial end | Last chance offer |

## Email copy

### Email 1 — Welcome (immediate on signup)
Subject: `Your [path name] path is ready`
Body: Single CTA — "Start your first lesson →" linking to their path's first module.
Tone: quick, warm, no fluff. One sentence: "You picked [path]. Here's where you start."

### Email 2 — Day 1 check-in (+1 day after path selected)
Subject: `Quick question about your goal`
Body: "You said you want to [their goal from onboarding]. Here's what week 1 looks like on your path." Show 3 module titles they'll cover. CTA: "Continue where you left off →"

### Email 3 — First quiz celebration (immediate on first quiz pass)
Subject: `You just passed your first quiz ✓`
Body: "You scored [score]/3. +150 XP. That's how this works — watch, understand, prove it. Module 2 is unlocked." CTA: "Go to Module 2 →"

### Email 4 — Re-engagement (3 days no activity)
Subject: `Your streak is waiting`
Body: "You were on a roll. [Path name] is right where you left it." No guilt. CTA: "Pick up where you left off →"

### Email 5 — Pre-paywall pitch (immediate after module 2 quiz pass)
Subject: `You've finished the free preview`
Body: "You've completed 2 modules. Here's what's waiting in module 3: [actual module 3 title and description]. Unlock it for $29/month — or get the full year for $149 while Founding Member spots last." Two CTAs: monthly and founding/annual.

### Email 6 — Trial day 5 reminder
Subject: `2 days left on your trial`
Body: "Your 7-day trial ends [date]. You've completed [X] modules. Don't lose access." CTA: "Keep my access →" → `/upgrade`

### Email 7 — Trial expired, not converted
Subject: `Your trial ended — one thing before you go`
Body: "Your free trial ended. Your progress is saved. If cost is the issue — the annual plan is $16.60/month. That's less than one coffee." CTA: "See pricing →" → `/upgrade`

## Implementation notes
- Use existing Resend setup in the codebase
- Read `src/app/api/` to find existing email sending patterns
- Triggers for emails 3, 5 should fire from `src/app/api/progress/quiz/route.ts` after quiz submission
- Trigger for email 4 needs a cron job — check `src/app/api/cron/` for existing cron patterns
- Store email send state in a `email_sends` table or add flags to `profiles` to avoid duplicate sends

## Done when
- All 7 emails send at correct triggers
- No duplicate emails
- All CTAs link to correct pages
- Unsubscribe works
