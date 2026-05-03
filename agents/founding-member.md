# Agent: Founding Member Campaign

Add a Founding Member tier — $149/year, limited to 500 spots. This is the primary conversion hook for Month 1. Creates urgency, rewards early adopters, generates upfront cash.

## New Polar product needed (manual step first)
Create "VibeLearning Founding Member" in Polar dashboard: $149/year, annual billing.
Add to env: `POLAR_FOUNDING_PRODUCT_ID=<id>`

## Database — track founding member count
Add a utility function in `src/lib/founding-member.ts`:
```ts
export async function getFoundingMemberCount(): Promise<number>
export async function isFoundingMemberAvailable(): Promise<boolean> // count < 500
```
Query `subscriptions` table where `plan_type = 'founding'` (add this column if it doesn't exist, or use the Polar product ID to identify).

## `src/app/upgrade/page.tsx`
When `isFoundingMemberAvailable === true`, show a third option between Free and Pro:

```
╔══════════════════════════════╗
║  🏅 FOUNDING MEMBER          ║
║  $149/year                   ║
║  [XXX / 500 spots claimed]   ║
║  Lock in this price forever  ║
║  Start now →                 ║
╚══════════════════════════════╝
```

Spot counter: fetch count server-side and render `{count} of 500 spots claimed`.
Progress bar showing fill percentage (count/500 × 100%).

When spots are full: hide the Founding Member card entirely, show Annual at $199/year.

## `src/app/onboarding/page.tsx`
In the `'premium'` stage, the secondary CTA links to founding member checkout when available.
When full, it links to annual checkout.

See `agents/onboarding-upsell.md` for the full onboarding screen spec.

## `src/app/api/polar/checkout/route.ts`
Handle `plan=founding` → use `POLAR_FOUNDING_PRODUCT_ID`.
After successful founding payment, set `plan_type='founding'` on the subscription row.

## Announcement copy (for Reddit / Twitter / email)
```
We're opening 500 Founding Member spots at $149/year — locked in forever.
After that, it's $199/year. [X] spots claimed so far.
```
Post this everywhere on launch day. Update the count daily.

## Done when
- Founding Member card visible on upgrade page with live spot counter
- Checkout creates a founding subscription in Polar
- Webhook marks subscription as founding type in DB
- When 500 spots filled, card disappears automatically
