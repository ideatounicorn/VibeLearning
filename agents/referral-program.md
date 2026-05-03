# Agent: Referral Program

Build a "give 1 month free, get 1 month free" referral mechanic. Every Pro user gets a unique referral link. When a friend subscribes via their link, both get one month free.

## Database changes
Add to `profiles` table (or create `referrals` table):
```sql
referral_code   text unique  -- short code like "marcus-t-x3k2"
referred_by     uuid references profiles(id)
referral_count  int default 0
```

Generate `referral_code` on profile creation: `{first-name-slug}-{random 4 chars}`.

## Referral link
Format: `https://vibelearn.app/?ref={referral_code}`

When a visitor lands with `?ref=`, store the code in a cookie (7-day expiry).
On signup, read the cookie and write `referred_by` to the new user's profile.

## Reward logic — `src/app/api/webhooks/polar/route.ts`
When a new subscription webhook fires, check if the new subscriber has a `referred_by` value.
If yes:
1. Credit the referrer: extend their subscription by 1 month (via Polar API or store as `free_months_credit` on their subscription row)
2. Credit the new subscriber: apply 1 month free to their subscription
3. Increment `referral_count` on the referrer's profile

## UI — `src/components/dashboard/` (add a new widget)
Create `src/components/dashboard/ReferralWidget.tsx`.

Only show to Pro users. Content:
```
Refer a friend — give them 1 month free, you get 1 month free.
[Your link: vibelearn.app/?ref=marcus-t-x3k2]   [Copy]
[X] friends referred · [X] free months earned
```

Add this widget to the dashboard page (`src/app/dashboard/page.tsx`) below the streak tracker.

## Email trigger
When a referral converts (referred friend subscribes), send the referrer a one-line email:
Subject: `[Name] just joined using your link — you earned a free month`

## Done when
- Every Pro user has a referral code and sees the widget
- Referral link correctly attributes signups
- Both users receive 1 month free on conversion
- Dashboard widget shows referral count and free months earned
