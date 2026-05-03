# Agent: Pricing Update

Convert all pricing from ₹330 to USD. Add annual plan. No ₹ symbols anywhere in the UI after this.

## New pricing
- Free: $0
- Pro Monthly: $29/month
- Pro Annual: $199/year (show as "$16.60/mo · save 43%")
- Founding Member: $149/year (handled separately in `founding-member.md`)

## Files to change

### `src/app/upgrade/page.tsx`
- Line 75: `₹0` → `$0`
- Line 100: `₹330` → `$29`
- Line 101: `/month` stays
- Add a `useState<'monthly'|'annual'>('monthly')` toggle above the plan cards
- When annual is selected, Pro card shows `$199` with subtext `$16.60/mo · save 43%`
- Pass plan to checkout: `href={`/api/polar/checkout?plan=${plan}`}`
- Replace the 3 stats (line 163–170): swap `500k+ Active learners` → `7-day Money-back guarantee`; keep `4.7/5`; change `68% Report career impact` → `68% Improve skills in 30 days`

### `src/app/api/polar/checkout/route.ts`
- Read this file first to find the existing product ID env var
- Add logic: if `plan === 'annual'` use `process.env.POLAR_ANNUAL_PRODUCT_ID`, else use existing monthly product ID
- Founding Member uses `process.env.POLAR_FOUNDING_PRODUCT_ID`

### `src/app/onboarding/page.tsx`
- Search for any price display in the `'premium'` stage and update to `$29/month`

## Grep first
Run `grep -r "₹" src/ --include="*.tsx" --include="*.ts" -l` and fix every hit.

## Env vars needed (add to .env.local and Vercel)
```
POLAR_ANNUAL_PRODUCT_ID=
POLAR_FOUNDING_PRODUCT_ID=
```

## Done when
- US visitor sees $29/mo on upgrade page
- Annual toggle shows $199/yr
- Both checkout flows complete successfully
- Zero ₹ symbols in the UI
