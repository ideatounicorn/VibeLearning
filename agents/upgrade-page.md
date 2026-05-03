# Agent: Upgrade Page Rebuild

The current upgrade page at `src/app/upgrade/page.tsx` shows ₹330, has no annual plan, and has inflated/unverifiable social proof stats. Rebuild it for a US audience with a monthly/annual toggle and honest copy.

## File: `src/app/upgrade/page.tsx`

Convert to a client component (`'use client'`) since the toggle needs state. Keep the Pro status check — move it to a server action or fetch on mount.

### New page structure (top to bottom)

1. **Badge** — `"Most popular for career switchers"`
2. **Headline** — `"Unlock your full career path"`
3. **Subtext** — `"Everything you need to go from learning to hired."`
4. **Billing toggle** — `[ Monthly ]  [ Annual — Save 43% ]`
5. **Plan cards** (2 columns, 1 column on mobile)
6. **Feature comparison table** (keep existing structure)
7. **3 stat boxes** (updated — see below)
8. **3 testimonial cards** (use same US personas from `messaging-overhaul.md`)
9. **FAQ** (keep existing, update refund email to `hey@vibelearn.app`)

### Plan card — Free
- Price: `$0`
- Subtext: `No credit card needed`
- CTA: `Continue free →` → `/dashboard`

### Plan card — Pro (Monthly, default)
- Price: `$29`
- Subtext: `/month · cancel anytime`
- Badge: `MOST VALUE` stays
- CTA: `Start 7-day free trial →` → `/api/polar/checkout?plan=monthly`

### Plan card — Pro (Annual, when toggle is annual)
- Price: `$199`
- Subtext: `/year · $16.60/month · save 43%`
- Highlight: add green "BEST VALUE" badge instead of "MOST VALUE"
- CTA: `Get annual access →` → `/api/polar/checkout?plan=annual`

### Stat boxes (replace the 3 current ones)
```
"7-day"        → "Money-back guarantee"
"$0"           → "To start — no credit card"
"4.7/5"        → "Average rating"
```

### Add testimonials section above FAQ
Use the 3 US personas from `agents/messaging-overhaul.md` (Marcus T., Jamie L., Priya S.) in simple quote cards. Same layout as the landing page social proof section.

### FAQ — update answers
- "Who is Pro for?" → mention career switchers specifically, not just "anyone serious"
- Refund email: make sure it's `hey@vibelearn.app`

## Done when
- Page loads with monthly pricing by default
- Toggle switches to annual pricing
- Both CTA buttons route to correct Polar checkout
- No ₹ anywhere
- Social proof is US-relevant
