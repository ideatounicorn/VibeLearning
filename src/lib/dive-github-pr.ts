// Deep dive: "Anatomy of a pull request that gets merged"
// Image-rich. Teaches via mock GitHub UI, not bullet points.

export type Avatar = { initials: string; color: string }

export type PRMock = {
  id: 'bad' | 'good'
  title: string
  number: number
  branch: string
  author: Avatar
  state: 'open' | 'merged' | 'draft'
  filesChanged: number
  additions: number
  deletions: number
  description: string | null
  hasScreenshot: boolean
  hasChecklist: boolean
  linkedIssue: number | null
  reviewers: Avatar[]
  comments: number
  ciStatus: 'pass' | 'fail' | 'pending' | 'none'
}

export const GITHUB_PR_DIVE = {
  slug: 'github-pr',
  title: 'Anatomy of a pull request',
  topicLabel: 'GitHub · Dive 1 of 5',
  estMinutes: 5,

  // ─── Stage 1: Hook ────────────────────────────────────────────────
  hook: {
    eyebrow: 'The PR problem',
    headline: 'Your code is good. Your PR makes it shippable.',
    sub: 'Most engineers spend 90% of effort on code, 10% on the PR. Reviewers see the opposite ratio.',
    capy: 'I’ll show you two real PRs solving the same task. Same code quality. Wildly different outcomes. You’ll see why.',
  },

  // ─── Stage 2: Setup ───────────────────────────────────────────────
  setup: {
    eyebrow: 'The task',
    headline: 'Two engineers. One ticket. Two pull requests.',
    body: 'Both implemented “Allow users to import contacts from a CSV file.” Both work. Both shipped. But one got merged in 2 hours. The other took 9 days.',
    ticket: {
      title: 'Allow CSV import on contacts page',
      number: 284,
      labels: ['feature', 'priority: medium'],
    },
  },

  // ─── Stage 3: The two PRs ─────────────────────────────────────────
  prs: {
    bad: {
      id: 'bad',
      title: 'updates',
      number: 1247,
      branch: 'feature-stuff',
      author: { initials: 'JD', color: '#FF6B51' },
      state: 'open',
      filesChanged: 87,
      additions: 1842,
      deletions: 631,
      description: null,
      hasScreenshot: false,
      hasChecklist: false,
      linkedIssue: null,
      reviewers: [],
      comments: 0,
      ciStatus: 'fail',
    } satisfies PRMock,

    good: {
      id: 'good',
      title: 'feat(contacts): add CSV import with 10MB limit',
      number: 1248,
      branch: 'feat/contacts-csv-import',
      author: { initials: 'PS', color: '#c8ff00' },
      state: 'open',
      filesChanged: 6,
      additions: 142,
      deletions: 18,
      description: `**What this does**
Adds a "Import from CSV" button to /contacts. Parses up to 10MB. Validates email format. Surfaces row-level errors inline.

**Why**
Closes #284 — biggest request in last user research round (mentioned by 7/12 customers).

**Screenshot**
[contacts-import-flow.gif]

**Test plan**
- [x] Upload valid 500-row CSV → all imported, success toast
- [x] Upload CSV with 3 bad emails → 497 imported, 3 errors shown inline
- [x] Upload 11MB file → blocked with "file too large" message
- [x] Cancel mid-upload → no partial state
- [x] CI: added 6 unit tests + 1 e2e

**Out of scope (follow-up)**
- XLSX support (#291)
- Bulk delete from same UI (#292)`,
      hasScreenshot: true,
      hasChecklist: true,
      linkedIssue: 284,
      reviewers: [
        { initials: 'AM', color: '#C084FC' },
        { initials: 'RK', color: '#F5C842' },
      ],
      comments: 4,
      ciStatus: 'pass',
    } satisfies PRMock,
  },

  // ─── Stage 4: Verdicts — annotated differences ────────────────────
  verdict: {
    eyebrow: 'What the reviewer sees',
    headline: 'Six things the great PR does that the bad one doesn’t.',
    callouts: [
      {
        signal: 'Title',
        bad: '“updates”',
        good: '“feat(contacts): add CSV import with 10MB limit”',
        why: 'A reviewer scans 20 titles a day. Yours is one line of metadata. Conventional Commits prefix (`feat:`, `fix:`) tells me the type before I click.',
      },
      {
        signal: 'Scope',
        bad: '87 files, +1842 / −631',
        good: '6 files, +142 / −18',
        why: 'Every extra file is reviewer cognitive tax. The 87-file PR will get a “lgtm 👍” without anyone actually reading it. The 6-file PR gets real review.',
      },
      {
        signal: 'Description',
        bad: 'Empty',
        good: 'What / Why / Screenshot / Test plan',
        why: 'Empty description means I have to read the diff to guess intent. With What/Why I can review against the goal, not just the code.',
      },
      {
        signal: 'Linked issue',
        bad: 'None',
        good: 'Closes #284',
        why: 'Auto-closes the issue on merge. Lets future you find *why* this code exists in 18 months.',
      },
      {
        signal: 'CI status',
        bad: '✕ failing',
        good: '✓ passing',
        why: 'Failing CI tells the reviewer “not ready.” Don’t request review on red. Treat the green check as table stakes.',
      },
      {
        signal: 'Branch name',
        bad: '`feature-stuff`',
        good: '`feat/contacts-csv-import`',
        why: 'Branch shows up in git logs forever. `feat/topic-thing` ages well. `feature-stuff` makes you look like a tourist.',
      },
    ],
  },

  // ─── Stage 5: Insight ─────────────────────────────────────────────
  insight: {
    eyebrow: 'The one idea',
    headline: 'Write the PR for the reviewer, not for you.',
    bullets: [
      { k: 'You', v: 'know what you built. The PR feels redundant.' },
      { k: 'The reviewer', v: 'is context-switching from another task and has 11 minutes. The PR is their *only* context.' },
      { k: 'The fix', v: 'Spend 5 min on the PR. Save 2 hours of review back-and-forth. Net win, every time.' },
    ],
    capy: 'I once spent 40 minutes writing a PR description for a 30-minute code change. Merged in an hour with zero comments. Math checks out.',
  },

  // ─── Stage 6: Match — title quality ───────────────────────────────
  matching: {
    eyebrow: 'Your turn',
    headline: 'Tag each PR title: green or red.',
    sub: 'Real titles from real codebases. Tap your call.',
    items: [
      { id: 't1', title: 'Update stuff', verdict: 'red', why: 'Says nothing. Reviewer has to open the diff just to learn the *area* you touched.' },
      { id: 't2', title: 'fix: prevent CSV import from crashing on files over 10MB (closes #284)', verdict: 'green', why: 'Type prefix, what changed, why it matters, linked issue. All in one line.' },
      { id: 't3', title: 'WIP', verdict: 'red', why: 'If it’s WIP, make it a Draft PR. WIP in the title means people will still try to review it.' },
      { id: 't4', title: 'feat(auth): add Google OAuth provider with state validation', verdict: 'green', why: 'Scoped (`auth`), conventional, names the *thing* that changed. A future bug-hunter can grep this.' },
      { id: 't5', title: 'fixed the thing john asked about', verdict: 'red', why: 'Tribal knowledge in commit history rots. Two years from now nobody remembers what John asked about.' },
      { id: 't6', title: 'refactor: extract email validation into shared util', verdict: 'green', why: 'Says it’s a refactor (so reviewer expects no behavior change), names the move, names the result.' },
    ],
  },

  // ─── Stage 7: Check ───────────────────────────────────────────────
  check: {
    eyebrow: 'Vibe check',
    prompt: 'You shipped a feature behind a flag. The flag is OFF in production. Your PR description should:',
    options: [
      {
        label: 'Mention the flag, the default state, and how to enable it',
        correct: true,
        why: 'Yes. Future-you trying to debug a production issue will search the codebase for the flag name. If your PR description has it, you save 30 min of archaeology.',
      },
      {
        label: 'Skip it — the code itself shows the flag',
        correct: false,
        why: 'No. Code shows *what*. The PR description should preserve *why* + *operational context* (default state, how to enable). The diff alone won’t.',
      },
      {
        label: 'Mention it only if asked in review',
        correct: false,
        why: 'Reactive. The reviewer will ask, you’ll answer, the answer lives in a comment thread that gets buried. Put it in the description — that’s the durable artifact.',
      },
    ],
    capy: 'Rule of thumb: anything you’d need to explain in a Slack DM about this PR belongs in the description. The PR description IS the durable Slack DM.',
  },
}
