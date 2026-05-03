# Agent: Messaging Overhaul

Rewrite landing page copy and social proof for US market. ICP is a 26–36 year old career switcher who is anxious about AI disrupting their non-tech job and wants a structured path into a tech-adjacent role (PM, AI Product, Digital Marketing) — without a CS degree or bootcamp.

## File: `src/app/page.tsx`

### Hero headline (line 201–203)
Current: `Your first tech job starts here.`
Replace with: `Your career pivot into tech starts here.`
Keep the `<em>` on "starts here."

### Hero sub-copy (line 215–216)
Current: `Structured YouTube paths built by practitioners. No more guessing what to watch next — just learn, confirm, and progress.`
Replace with: `Structured career paths for people switching into PM, AI, design, and marketing. No bootcamp. No CS degree. Just a clear sequence that works.`

### Stats row (lines 247–264)
Current: `5 Career paths · 200+ Curated lessons · 100% Free to explore`
Replace with: `5 Career paths · 200+ Curated lessons · No CS degree required`

### Social proof block — SOCIAL_PROOF constant (lines 67–71)
The current testimonials reference Swiggy (Indian company) and unnamed Indian startups. US visitors won't relate. Replace the entire SOCIAL_PROOF array:

```ts
const SOCIAL_PROOF = [
  {
    name: 'Marcus T.',
    role: 'Landed a PM role at a SaaS startup',
    avatar: '👨🏾',
    quote: 'I was in operations for 4 years with zero tech experience. The structured sequence finally made sense of everything I\'d been trying to self-teach.',
  },
  {
    name: 'Jamie L.',
    role: 'Now a junior AI Product Manager',
    avatar: '👩🏻',
    quote: 'The quiz gates are annoying until you realize they\'re the reason you actually remember things. I passed my first PM interview because of this.',
  },
  {
    name: 'Priya S.',
    role: 'Digital Marketing Manager at a Series A',
    avatar: '👩🏽',
    quote: 'Every other course I tried had me watching videos I already knew. Here you prove you got it before you move on. That difference is everything.',
  },
]
```

### "How it works" section heading (line 335)
Current: `Actually finish what you start.`
Keep — this is good.

### "Choose your path" subtext (line 428)
Current: `All free to explore. Upgrade to unlock full access.`
Replace with: `Free to start. Upgrade to go all-in.`

### Final CTA subtext (line 619)
Current: `Free forever for the first two modules of every path.`
Replace with: `Free to start. No credit card. Cancel anytime.`

### Footer (line 640)
Current: `Built with love for first-time job-seekers`
Replace with: `Built for career switchers breaking into tech`

## Done when
- No Indian company names in testimonials
- Hero speaks to career switching, not "first tech job"
- Stats row doesn't mislead with unverifiable numbers
