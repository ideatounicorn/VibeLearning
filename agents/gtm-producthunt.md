# Agent: Product Hunt Launch

Launch on Product Hunt on Day 15–20. A top-5 finish drives 800–2,000 signups in 24 hours. This is the single highest-leverage marketing event in the first 30 days.

## Positioning
Tagline: `The structured career path to your first tech job — no CS degree required`
Category: Education, Productivity
Maker: founder account (must have posting history — create account now if needed)

## Listing assets needed
- Logo: use existing `/public/logo.png`
- Thumbnail: 240×240px branded card with tagline
- Gallery images (4–5): screenshots of onboarding flow, roadmap, quiz screen, dashboard, certificate
- Video (optional but +30% upvotes): 60-second demo. Screen record the onboarding → quiz → dashboard flow.

## Launch copy

**Tagline (< 60 chars):** `Structured career paths to break into tech`

**Description:**
```
VibeLearning is for people switching into tech without a CS degree.

Instead of a random YouTube playlist or a $15K bootcamp, you get:
→ A structured sequence of lessons built by practitioners
→ Quizzes after every module (2/3 to unlock the next one)
→ Real projects to show in job interviews
→ A certificate you can post on LinkedIn

5 career paths: AI Product, Product Management, UX Design, Digital Marketing, Data Analysis.

Free to start. Pro is $29/month.
```

**First comment (post immediately after launch):**
```
Hey PH 👋 I built VibeLearning after watching friends struggle with the "I want to get into tech but don't know where to start" problem.

The issue isn't lack of content. YouTube has everything. The problem is there's no sequence, no accountability, no way to prove you learned it.

VibeLearning fixes that. Structured paths, quizzes that gate progress, real projects, certificates.

Special for PH: 3-month free trial (vs. the usual 7 days). Use code PRODUCTHUNT at checkout.

Happy to answer any questions — what path interests you most?
```

## PH-exclusive offer
Create a promo code `PRODUCTHUNT` in Polar that extends trial from 7 days to 90 days.
Display this offer on the `/upgrade` page when `?ref=producthunt` is in the URL:
```tsx
{searchParams.ref === 'producthunt' && (
  <div className="pill pill-green">Product Hunt special: 3-month free trial with code PRODUCTHUNT</div>
)}
```

## Upvote coordination — line these up before launch
- Personal network: 20 people
- Early users with accounts: email them the night before
- Twitter followers: tweet day-of "We're live on Product Hunt today — would mean the world if you upvote"
- Target: 50+ upvotes in first 2 hours (determines front page placement)

## Launch timing
- Day: Tuesday or Wednesday (highest traffic days on PH)
- Time: 12:01am PST (start of PH day)
- Stay available for comments all day — PH rewards makers who engage

## Post-launch
- Email all signups who came from PH within 2 hours of launch
- Tweet progress updates ("We hit #3 Product of the Day!")
- Convert PH traffic with the extended trial offer

## Done when
- PH listing live with all assets
- PRODUCTHUNT promo code active in Polar
- URL param check shows extended trial offer
- Launch email drafted and ready to send to upvoter list
