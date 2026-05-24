# Dive Spec

How to build a VibeLearn dive. Read this at the start of any session that touches dive content.

This is the source of truth. If anything in this file conflicts with code, the file wins until updated.

---

## 1. What a dive is

A **dive** is one self-contained micro-lesson that teaches **one concept** (or one tight cluster of concepts) using **repetition across multiple modalities**.

A dive is **anchored on a concept**, never on a video. A YouTube video is one of several teaching modalities a dive may use — not its center of gravity.

Target: a learner can finish a dive in **5–15 minutes** and walk away able to explain the concept to a friend.

### A dive is NOT
- A YouTube video with a quiz strapped to it
- A textbook chapter
- A standalone quiz
- A long course module
- A passive watch-only experience

### A dive IS
- A small, complete loop: **hook → teach → repeat → check → receipt**
- Concept-first. The video (if any) serves the concept, not the other way around.
- High-density. Every screen earns its place.
- Self-contained. No prerequisites assumed beyond the course's prior dive.

---

## 2. Core principles (non-negotiable)

### 2.1 Concept-first, video-optional

Pick the **concept** before you go looking for any video. If a tightly-aligned YouTube video exists, embed it. If one does not, write the dive without it. **Never** force-fit a video that drifts off-topic.

> **The drift test:** if a friend asks "what is this dive teaching?" after watching the embedded video alone, the answer must be the dive's stated concept. If the video drifts (e.g. dive concept is "basics of SEO" but video covers "App Store Optimization"), the video is wrong. Find another or skip it.

### 2.2 Repetition through modality

Every dive teaches the same concept **at least 3 times** through different modalities:
1. Hook framing (one-line analogy + Cap's pitch)
2. Main teaching block (video OR mock UI OR side-by-side artifacts OR concept explainer)
3. Recap cards (5 keepers, plain-English)
4. Quiz check (apply the idea, not recall words)

The same idea hits the learner four different ways. This is the mechanism. Not 60 minutes of video → 10 minutes of quiz. **Compression + repetition.**

### 2.3 8-year-old language test

If an 8-year-old can't follow the recap cards, rewrite them. Examples:
- ❌ "Git is a distributed version control system."
- ✅ "Git is a save button with memory — every save is a photo you can flip back to."

Same for the quiz. Same for Cap's lines. Same for the hook.

### 2.4 Cap voice

Capybara mascot is the narrator. Cap voice rules:
- First-person plural sometimes ("we'll see if it stuck")
- Specific, never generic ("Out of 47 git videos, this is the one" beats "I picked a great video")
- Never says "AI" about himself; he's a capybara, not a chatbot
- Mild self-deprecation, never sycophancy
- Numbers and details over adjectives ("4hrs" beats "carefully crafted")
- Short sentences. One idea each.

### 2.5 Receipt at the end

Every dive ends with a **pride moment**: a "receipt of skill" card that the learner can screenshot. Format:
- Headline: "You can now actually [do the thing]."
- Three concrete claims the learner has earned (e.g. "Explain git to a friend in one sentence")
- Visually high-contrast — designed to be share-worthy

---

## 3. Dive anatomy

Every dive is a state machine with these stages, in order:

| # | Stage | Purpose | Required? |
|---|---|---|---|
| 1 | **Intro** | Cap pitches the concept + previews skills earned | Always |
| 2 | **Watch** OR **Setup** | Embeds video in TV frame OR primes the main teaching artifact | Always (one or the other) |
| 3 | **Compare / Teach** | The teaching block — artifact, mock UI, concept explainer | Always (sometimes merged with Stage 2) |
| 4 | **Recap** | 5 plain-English cards. The keepers. | Always |
| 5 | **Quiz** | 5–7 questions, sequential, judgment-required | Always |
| 6 | **Done (receipt)** | Pride card + score + share + replay | Always |

For video-centered dives: Stage 2 is **Watch** (TV-framed YouTube embed with contextual panels around it). See `src/components/vibe/Git100sWatch.tsx`.

For artifact-centered dives: Stage 2 is **Setup** + Stage 3 is **Compare**. See `src/components/vibe/GithubPRDive.tsx`.

---

## 4. The video alignment rule

If the dive includes a video, the video must pass **all four** tests:

| Test | Pass condition |
|---|---|
| **Concept match** | Video's central topic = dive's central concept. No drift. |
| **Length** | Under 8 minutes ideal. Hard cap: 15 minutes. |
| **Quality** | Clear audio, no filler, watchable on mobile, decent production. |
| **Creator credit** | Creator named in dive UI. Link to channel respected. |

Cap should be able to honestly say "Out of N videos I watched, this is the one" — and N should be **real research effort**, not a number invented for the dive. If you've only watched 3 videos, say 3, not 47.

### Where to find videos

Search priority:
1. **Fireship** (`@Fireship`) — 100-second explainers, technically accurate
2. **Mr Beast / popular tutorials only if topic fits** — beware of slop
3. **Creator-specific channels** for the topic (e.g. The Net Ninja for web dev, Aarvee for design)
4. **Official channels** for tool-specific dives (Figma, Vercel, GitHub, Anthropic)

For each candidate video:
- Watch it end-to-end before greenlighting
- Note the timestamps where the dive's concept is taught
- If the video covers >50% adjacent material, reject it

### When to skip the video

Skip the video entirely if:
- No video on the topic passes all four tests
- The topic is so practical (e.g. "ship to Vercel") that a build-along beats a video
- The topic is so abstract (e.g. "referential equality in React") that side-by-side code beats a video

Skipping a video is **not a failure**. Forcing a bad video is.

---

## 5. Content rules per stage

### 5.1 Intro stage

Must contain:
- A **placard** (tilted yellow sticky-note style): "I found this for you ✦" or equivalent
- Cap sticker (pose: `celebrating` or `hi`)
- Eyebrow: "Cap curated" (or similar attribution)
- H1 in plain language (8-year-old test)
- 1-line subtitle (italic, muted)
- **Pre-video context card** with:
  - Video preview (red play tile + title + creator + duration) — only if video included
  - 3 stat pills: "Picked from N videos", "Difficulty ●●○○○", "Watch time X:XX"
  - "After this you'll know" mini-list (3 outcomes with emoji)
  - Cap's italic quote — why this one
- Cap bubble (pose `hi`) with a hook line
- Primary CTA: "Watch with Cap →" or "Show me →"

If resuming an in-progress dive: surface "Resume from {stage} →" primary + "Start over" secondary.

### 5.2 Watch stage (video-centered dives)

The video does not stand alone. It lives inside a designed scene that pushes the learner to finish watching.

**Layout** (desktop 3-column, mobile stacked):

| Left panel | Center | Right panel |
|---|---|---|
| 👀 **THE HUNT** — interactive checklist of 3 things to spot in the video. Tapping ticks + expands a plain-English explainer + Cap reaction. | TV frame (see `TVPlayer.tsx`) with antennae, stickers (GIT 101 / Cap's pick), ON AIR badge, scanlines, vignette, knobs, wood bezel, caption strip with power LED. | 🛋️ **CO-WATCHING** — Capy on a couch with popcorn, pose + quote changes with hunt count. |
| **CONFIDENCE** meter — fills as hunts ticked. Label: Just starting → Warming up → Almost → Locked in. | CTA below TV: muted dashed pill until ≥1 hunt ticked, neon when armed. Copy reflects state: "Tick at least one hunt to continue" → "I watched it (1/3 spotted) →" → "You got all three — done →" | 👥 **ALSO WATCHING** — N people on this dive right now (live-ticks). |
| 🗂️ **THE PILE** — visual stack of N rejected videos with ✕ marks, neon "★ THIS ONE" pulled out. Caption: "46 rejected · 1 kept". | (placard above TV: "Cap is watching with you") | 📋 **UP NEXT** — preview of Recap / Quiz / Receipt + tilted neon "✦ Your receipt is being printed…" sneak peek. |

**The hunt is the engagement mechanic.** Each hunt item is a phrase the learner must spot in the video. Examples:
- "The word 'snapshot' — that's the whole idea"
- "The Y-shape when branches split"
- "`push` vs `pull` — direction matters"

After ticking, the hunt item shows:
- A plain-English explainer of what the learner just spotted
- A Cap quote reinforcing the lesson

This is the **first repetition** of the concept.

### 5.3 Compare / Teach stage (artifact-centered dives)

Used when the dive teaches via comparison rather than video. Example: `GithubPRDive.tsx` shows two PRs side-by-side and asks the learner to read both before judgment.

Layout:
- Eyebrow + H1
- Cards or expandable rows. Each must be **opened** by the learner before they can advance.
- Counter showing progress ("Read all 3 to continue · 1/3")
- After all opened: reveal verdict + Cap critique per artifact

For dives that combine video + comparison: video first, then the compare stage uses content from the video for direct application.

### 5.4 Recap stage

**Exactly 5 cards.** No more, no fewer. Five is the keepers ceiling — research-backed for working memory.

Each card:
- 1 emoji (left, large)
- A title that an 8-year-old gets ("Git is a save button with memory")
- A 1–2 sentence body
- A color-coded left border (rotates through the palette: peach / mint / lilac / butter / neon)

Cap bubble at end summarizing the five.

Recap = **second repetition** of the concept.

### 5.5 Quiz stage

**5–7 questions.** Sequential. Auto-advance on pick after a 2-second reveal.

Each question:
- A real-world prompt that requires **judgment**, not recall
- 3 options (occasionally 4 if needed). One correct, two plausibly wrong.
- After picking: show the explanation for **both** the chosen option AND (if different) the correct option. The wrong answers teach as much as the right one.
- "Why" copy is 1–2 sentences. No fluff.

> **Quiz test:** if a learner could pass the quiz by skim-reading the recap cards, the quiz is too easy. Reframe questions to require *application*.

Quiz = **third repetition** of the concept (through judgment).

### 5.6 Done stage

Required elements:
- Cap celebrating (pose `celebrating`, large size 130)
- Verdict card (3 tiers): 100% = 🏆 Perfect / ≥60% = 🎯 Solid / <60% = 🌱 Seeds planted
- Score card (X / Y)
- **Pride card** — neon green, black border, hand-drawn shadow, slight tilt, contains:
  - "✦ Receipt of skill" eyebrow
  - Big headline ("You can now actually explain git.")
  - 1-line body that emphasizes how rare this is
  - 3 concrete skill claims with ✓ marks
- Cap bubble with closing line
- Two CTAs: Replay (primary) + Back to VibeLearn (secondary)

The pride card is the **fourth repetition** — it tells the learner what they now know, in their own future voice.

---

## 6. Quiz construction rules

| Rule | Why |
|---|---|
| **5–7 Qs per dive** | Long enough to feel earned, short enough to stay verb-able. |
| **One correct, two wrong** | Higher accuracy than 4 options, less guessing math. |
| **Wrong answers must be plausible** | A trivially-wrong option teaches nothing. Each wrong should be a real mistake people make. |
| **No "all of the above" or "none of the above"** | Lazy. Always rewrite. |
| **Plain language** | If you have to define a term in the question, the question is too jargon-heavy. |
| **Application > recall** | Test transfer. "Your team adds new code. You want it. Which command?" beats "What does `git pull` do?" |
| **Every option gets a `why`** | The chosen wrong + the correct, minimum. Best dives explain *all* options. |
| **One judgment Q at the end** | The hardest question, requiring synthesis of the whole dive. The "vibe check" Q. |

---

## 7. Production playbook (step by step)

### Step 1: Pick the concept

State the concept in **one sentence**. Examples:
- "A `commit` is a labeled snapshot of all your changes."
- "Pick Sonnet by default; upgrade to Opus when stuck."
- "A great PR is written for the reviewer, not the author."

If you can't state it in one sentence, your scope is too broad — split into two dives.

### Step 2: Decide the teaching mode

Pick **one primary mode** based on the concept:

| Concept type | Primary mode | Example |
|---|---|---|
| Abstract idea (what is X) | Video-curated + recap | Git in 100s |
| Comparison (X vs Y) | Artifact compare | Claude models, PR anatomy |
| Hands-on tool literacy | Build-along + mock UI | Future: "Ship to Vercel" |
| Mechanism (how X works) | Concept explainer (animated SVG) | Future: "Referential equality" |
| Synthesis (apply across) | Capstone with shareable artifact | Future: "Write your first PR" |

### Step 3: Find or skip the video

If primary mode includes video:
- Search YouTube for the concept in plain language
- Watch top 5–10 candidates end-to-end
- Apply the four tests in §4
- Pick the winner. Note `youtubeId`, title, creator, duration, `pickedFrom` count (real number — videos actually watched).

If no candidate passes: drop the video. Use a different primary mode.

### Step 4: Draft the content file

Create `src/lib/dive-{slug}.ts` following the shape in `src/lib/dive-git-100s.ts`. Required fields:

```ts
{
  slug, title, topicLabel,
  video?: { youtubeId, title, creator, duration, pickedFrom, difficulty, whyThisOne, skillsAfter, watchFor },
  intro: { eyebrow, headline, sub, placard, capySays },
  watch?: { placard, capyHints, cta },
  setup?: { ... },         // for artifact dives
  compare?: { ... },       // for artifact dives
  recap: { eyebrow, headline, sub, cards: [5 cards], capySays },
  quiz: { eyebrow, questions: [5-7] },
  pride: { headline, body, skills: [3 claims] },
  quit: { headline, body, stay, leave },
}
```

### Step 5: Write each block

Order matters. Build inside-out:
1. **Pride card first.** Defines the outcome. Everything else serves this.
2. **Recap cards next.** The five keepers. These are the "what good looks like."
3. **Quiz questions.** Reverse-engineer from the recap — each Q tests one card's idea.
4. **Hunt items (if video-centered).** Three phrases the learner will spot — each maps to a recap card.
5. **Cap lines and placards.** Voice pass last, after content is set.

### Step 6: Build the component

If a similar dive exists (PR, Git-100s, Claude models): copy its component file as a starting point. Edit:
- The `D` import to point to your new content file
- The stage list if structure differs
- The CapyPose values per stage

If structure is genuinely new: extract the new stage(s) into reusable building blocks in `src/components/vibe/`.

### Step 7: Wire the route

Create `src/app/vibe/dive/{slug}/page.tsx`:

```tsx
import YourDive from '@/components/vibe/YourDive'
export default function Page() { return <YourDive /> }
```

Add `/vibe` to `FULLSCREEN_PATHS` in `src/components/LayoutWrapper.tsx` if not already (already done).

### Step 8: Ship a draft

- Verify it renders on mobile (375x812) and desktop (1280+)
- Click through every stage as a first-time learner
- Take the quiz cold — do you get 100% by skim? If yes, harden the questions
- Show one friend. Watch them use it. Don't explain.

---

## 8. Pre-ship QA checklist

Before merging a dive, every item must pass.

### Content
- [ ] Concept stated in one sentence (re-state at top of content file as comment)
- [ ] 8-year-old language test on recap cards
- [ ] Cap voice is consistent (no "AI" self-reference, no sycophancy, specific over generic)
- [ ] If video included: passes the four alignment tests (§4)
- [ ] `pickedFrom` count reflects videos actually watched (not invented)
- [ ] Recap = exactly 5 cards
- [ ] Quiz = 5–7 questions
- [ ] Every quiz option has a `why` for chosen + correct (minimum)
- [ ] No "all/none of the above" options
- [ ] Pride card has 3 concrete skill claims
- [ ] Quit modal copy matches the dive's voice

### Mechanics
- [ ] Repetition rule: concept appears in at least 3 modalities (hook + main + recap + quiz)
- [ ] CTA on Watch stage is muted until at least one hunt ticked (video dives)
- [ ] Hunt items match recap cards 1:1 (each hunt → one recap card concept)
- [ ] Auto-advance on quiz works
- [ ] Score persists to localStorage
- [ ] Resume from stage works on reload
- [ ] Exit confirmation modal triggers mid-dive, skips on intro/done

### Visual
- [ ] Capy art loads (`hi`, `thinking`, `celebrating`, `oops` poses fall back to emoji if PNG missing)
- [ ] Mobile viewport (375px) reads cleanly — panels stack, no horizontal scroll
- [ ] Desktop viewport (≥1024px) uses 3-column layout where applicable
- [ ] No floating orphan emoji or character — every mascot appearance is grounded in a scene/bubble
- [ ] All sticker decals, placards, and TV chrome are tilted ±2–6° (intentional, never grid-aligned)
- [ ] Receipt card is the most visually distinct element on the Done page (this is the share moment)

### Functional
- [ ] Click "← exit" mid-dive → quit modal opens
- [ ] Click "← exit" on intro or done → direct exit, no modal
- [ ] Replay dive button → state resets to intro
- [ ] All Cap bubbles have a `pose` prop (no default `hi` masking intent)
- [ ] No console errors on a clean session
- [ ] YouTube iframe loads with `?rel=0&modestbranding=1`

---

## 9. Canonical reference implementations

Read these files before writing a new dive of the same shape.

### Video-anchored dive
- Content: [`src/lib/dive-git-100s.ts`](./src/lib/dive-git-100s.ts)
- Component: [`src/components/vibe/Git100sDive.tsx`](./src/components/vibe/Git100sDive.tsx)
- Watch sub-component: [`src/components/vibe/Git100sWatch.tsx`](./src/components/vibe/Git100sWatch.tsx)
- TV frame: [`src/components/vibe/TVPlayer.tsx`](./src/components/vibe/TVPlayer.tsx)
- Route: [`src/app/vibe/dive/git-100s/page.tsx`](./src/app/vibe/dive/git-100s/page.tsx)

### Artifact-compare dive (no video)
- Content: [`src/lib/dive-github-pr.ts`](./src/lib/dive-github-pr.ts)
- Component: [`src/components/vibe/GithubPRDive.tsx`](./src/components/vibe/GithubPRDive.tsx)
- Mock UI primitive: [`src/components/vibe/PRMockUI.tsx`](./src/components/vibe/PRMockUI.tsx)
- Route: [`src/app/vibe/dive/github-pr/page.tsx`](./src/app/vibe/dive/github-pr/page.tsx)

### Shared primitives
- Mascot: [`src/components/vibe/Capy.tsx`](./src/components/vibe/Capy.tsx) — `<Capy pose>` and `<CapyBubble pose>`
- Progress + resume: [`src/lib/vibe-progress.ts`](./src/lib/vibe-progress.ts)

---

## 10. Anti-patterns (do not do these)

| Anti-pattern | Why it fails |
|---|---|
| Pasting a YouTube link without watching the video end-to-end | Concept drift goes undetected. The video might cover ASO when you wrote a dive on SEO. |
| 10 quiz questions | Past the engagement cliff. Learners bail. |
| Quiz Qs that test recall of recap card phrasing | No transfer. Learner forgets in a week. |
| Letting Cap say "as an AI" or "let me help you" | Breaks the mascot illusion. |
| Generic placard text ("welcome!", "let's go!") | Reads like a tutorial template. Cap is specific. |
| Floating mascot emoji with no grounding (no couch, no bubble, no scene) | Looks like clip art. Always ground Cap in a scene. |
| Pride card that lists "you watched a video" as a skill | Watching is not a skill. Explaining, choosing, applying are skills. |
| Pre-ticking hunts on load | Defeats the engagement mechanic. Force interaction. |
| Skipping the Cap voice pass | Voice is the moat. Without it, this is a LinkedIn Learning clone. |
| Building a dive of a concept you cannot explain in one sentence | Scope is too big. Split it. |

---

## 11. Future spec files (planned)

Each will live at repo root next to this one:

- `DIVE-ARTIFACT-COMPARE-SPEC.md` — deep on the PR-style 2-3 way comparison pattern
- `DIVE-BUILD-ALONG-SPEC.md` — hands-on tool literacy (steps + checkpoints + screenshots)
- `DIVE-CONCEPT-EXPLAINER-SPEC.md` — animated SVG abstract concepts
- `DIVE-CAPSTONE-SPEC.md` — produce-an-artifact end-of-course pattern
- `COURSE-SPEC.md` — how a sequence of dives becomes a course
- `TRACK-SPEC.md` — how courses sequence into a track

This file (`DIVE-SPEC.md`) is the parent. Others inherit its rules unless they override explicitly.

---

## 12. When in doubt

Ask: **"Does this push the learner toward finishing the concept, or toward the exit?"**

If toward finishing → keep it.
If toward exit → cut it.

Every element on every screen earns its place by that test alone.
