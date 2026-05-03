# Agent: Onboarding Upsell Screen

The `'premium'` stage of onboarding is the most important conversion screen in the product. A user has just seen their personalised roadmap. They're emotionally invested. This is the moment to close. Current screen undersells. Fix it.

## File: `src/app/onboarding/page.tsx`

Read the full file. Find the section that renders when `stage === 'premium'`.

### What to change

**Headline**
Current: whatever is there now
Replace with: `You're one step away from the full path.`

**Subtext**
Add: `Join [X] others who switched careers using this exact roadmap.` (hardcode a credible number like 1,200 for now — update with real data when available)

**PREMIUM_FEATURES list (line 75–82)**
Current list is generic. Replace with outcome-framed benefits:
```ts
const PREMIUM_FEATURES = [
  { emoji: '🗺️', text: 'Full path unlocked — all modules, no paywalls' },
  { emoji: '✅', text: 'Quizzes after every module — prove you actually learned it' },
  { emoji: '🛠️', text: 'Real projects to show in job interviews' },
  { emoji: '🏆', text: 'Certificate you can share on LinkedIn' },
  { emoji: '💬', text: 'Private community of career switchers like you' },
  { emoji: '↩️', text: '7-day money-back — no questions asked' },
]
```

**Pricing display**
Show two options side by side:
- Monthly: `$29/month` with a "Start free 7-day trial" button
- Annual: `$149/year` with a "Founding Member — 500 spots left" badge (link `founding-member.md` for the spot counter logic)

If Founding Member spots are full (>= 500 subscriptions with founding type), show `$199/year` instead.

**Primary CTA button**
Text: `Start my 7-day free trial →`
Links to `/api/polar/checkout?plan=monthly`

**Secondary CTA**
Text: `Get annual access — $149/year`
Links to `/api/polar/checkout?plan=founding` (or `annual` if founding is full)

**Skip link**
Keep the existing "skip for now" / "continue free" option — do not remove it. Users who skip are still in the funnel.

**Social proof micro-copy below CTA**
Add one line: `No credit card required to start your trial.`

## Done when
- Onboarding premium screen shows outcome-focused benefits
- Two pricing CTAs visible (monthly trial + annual)
- "No credit card required" copy is present
- Skip option still works
