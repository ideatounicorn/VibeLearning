// Deep dive content: "Three models, same question"
// Pre-recorded realistic Haiku/Sonnet/Opus responses to the same React perf prompt.
// Each response teaches something even if reader picks wrong.

export const CLAUDE_MODELS_DIVE = {
  slug: 'claude-models',
  title: 'Three brains, one question',
  topicLabel: 'Claude · Dive 2 of 5',
  estMinutes: 4,

  // ─── Stage 1: Hook ────────────────────────────────────────────────
  hook: {
    eyebrow: 'The model question',
    headline: 'Same prompt. Three brains. Three answers.',
    sub: 'Most people pick the wrong one. Let’s fix that in 4 minutes.',
    capy: 'I’ll show you a real React bug, then three Claude models solving it. Read each. You’ll feel the difference.',
  },

  // ─── Stage 2: Show — the prompt ───────────────────────────────────
  prompt: {
    title: 'The prompt you sent to all three models:',
    body: `My React app is slow. The TodoList re-renders on every keystroke even when todos haven't changed. Why?`,
    code: `function App() {
  const [text, setText] = useState('')
  const [todos, setTodos] = useState([])
  return (
    <>
      <input value={text} onChange={e => setText(e.target.value)} />
      <TodoList items={todos} config={{ theme: 'dark', sort: 'asc' }} />
    </>
  )
}`,
  },

  // ─── Stage 2b: Three responses ────────────────────────────────────
  responses: [
    {
      modelKey: 'haiku',
      label: 'Response A',
      tokensOut: 48,
      seconds: 0.8,
      cost: '$0.0002',
      body: `When you type, \`setText\` updates state, which re-renders \`App\`. Since \`TodoList\` is a child of \`App\`, it re-renders too.

To prevent this, wrap \`TodoList\` with \`React.memo\`.`,
      verdict: {
        depth: 'Surface',
        accuracy: 'Half-right',
        critique: 'Names the symptom (parent re-renders → child re-renders). Misses the *actual* bug: the inline `config` object. `React.memo` alone will silently fail here.',
      },
    },
    {
      modelKey: 'sonnet',
      label: 'Response B',
      tokensOut: 142,
      seconds: 2.1,
      cost: '$0.0021',
      body: `Two things going on:

**1. Parent re-renders on every keystroke.** \`setText\` triggers a re-render of \`App\`, which re-renders all children including \`TodoList\`.

**2. The \`config\` prop is a new object every render.** Even if you wrap \`TodoList\` in \`React.memo\`, the memoization fails because \`{ theme: 'dark', sort: 'asc' }\` creates a fresh object reference each time.

**Fix:**
\`\`\`jsx
const config = useMemo(() => ({ theme: 'dark', sort: 'asc' }), [])
const TodoList = React.memo(function TodoList({ items, config }) { ... })
\`\`\``,
      verdict: {
        depth: 'Solid',
        accuracy: 'Correct',
        critique: 'Identifies both layers. Names the referential equality problem. Gives a copy-paste fix. This is the daily-driver sweet spot — 90% of dev work doesn’t need more than this.',
      },
    },
    {
      modelKey: 'opus',
      label: 'Response C',
      tokensOut: 287,
      seconds: 5.4,
      cost: '$0.022',
      body: `The bug is referential inequality on the \`config\` prop. Here's the chain:

1. \`setText\` triggers re-render of \`App\`.
2. On each render, \`{ theme: 'dark', sort: 'asc' }\` is a *new* object — same shape, new reference.
3. React's default: if any prop reference changes, the child re-renders.

**Why \`React.memo\` alone won't save you:** it does a shallow comparison. \`config\` is a new reference every render → memo bails → child re-renders.

**Fix:**
\`\`\`jsx
const config = useMemo(() => ({ theme: 'dark', sort: 'asc' }), [])
const TodoList = React.memo(({ items, config }) => { ... })
\`\`\`

**Subtle gotcha:** if \`items\` is the result of a \`.map()\` or \`.filter()\` higher up, same issue applies. Memoize that too.

**Cleaner if static** — hoist it out:
\`\`\`jsx
const CONFIG = { theme: 'dark', sort: 'asc' }
function App() { ... }
\`\`\`
Zero allocation, zero hook overhead.`,
      verdict: {
        depth: 'Deep',
        accuracy: 'Correct + nuanced',
        critique: 'Explains the *mechanism* (referential equality), shows the failure mode of the naive fix, warns about adjacent gotchas (`.map()` chains), offers a cleaner pattern. Worth the 25× cost when you’re stuck or designing — overkill for a quick answer.',
      },
    },
  ],

  // ─── Stage 3: The insight ─────────────────────────────────────────
  insight: {
    eyebrow: 'The takeaway',
    headline: 'Bigger ≠ better. Match the brain to the job.',
    bullets: [
      { k: 'Haiku', v: 'Cheap, fast, surface answers. Great for classification, formatting, one-line decisions.' },
      { k: 'Sonnet', v: 'Daily driver. 90% of real work — coding, writing, analysis. Default to this.' },
      { k: 'Opus', v: 'Slow, expensive, deep. Save for: stuck debugging, architecture, ambiguous tradeoffs.' },
    ],
    capy: 'I default to Sonnet. I upgrade to Opus when I’m actually stuck. I rarely use Haiku because the savings aren’t worth the regret.',
  },

  // ─── Stage 4: Try it — match models to scenarios ──────────────────
  matching: {
    eyebrow: 'Your turn',
    headline: 'Match each task to the model you’d pick.',
    sub: 'Tap a model. There’s a defensible answer for each.',
    scenarios: [
      {
        id: 's1',
        text: 'Classify 50,000 support tickets as billing / bug / feature-request.',
        correct: 'haiku',
        why: 'Volume + simple categorization = Haiku. Sonnet would cost 10× for no real lift.',
      },
      {
        id: 's2',
        text: 'Refactor a 400-line legacy function into composable pieces.',
        correct: 'sonnet',
        why: 'Real coding work with judgment, not heroic reasoning. Sonnet nails this all day.',
      },
      {
        id: 's3',
        text: 'You’re stuck on a race condition. Have tried 3 fixes. Nothing works.',
        correct: 'opus',
        why: 'Hard, ambiguous, you-need-deeper-reasoning. This is exactly what the 25× price tag buys.',
      },
      {
        id: 's4',
        text: 'Generate alt-text for 200 blog post images.',
        correct: 'haiku',
        why: 'Repetitive vision task. Haiku reads images and is dirt cheap at scale.',
      },
    ],
    models: [
      { key: 'haiku', label: 'Haiku', sub: 'fast · cheap' },
      { key: 'sonnet', label: 'Sonnet', sub: 'daily driver' },
      { key: 'opus', label: 'Opus', sub: 'deep · pricey' },
    ],
  },

  // ─── Stage 5: Mini-check ──────────────────────────────────────────
  check: {
    eyebrow: 'Vibe check',
    prompt: 'You’re building a customer chatbot. 10,000 questions/day. Latency matters. Most questions are simple FAQ. Which model do you ship with?',
    options: [
      { label: 'Haiku', sub: 'fast · cheap', correct: true, why: 'Volume + simple = Haiku. You’d burn 10–25× the budget on Sonnet/Opus for no quality lift on FAQ questions.' },
      { label: 'Sonnet', sub: 'daily driver', correct: false, why: 'Tempting default, but at 10k/day the cost adds up fast for what’s essentially classification + retrieval.' },
      { label: 'Opus', sub: 'deep · pricey', correct: false, why: 'Wildly overkill. Slow + expensive + your users feel the latency. This is the “bigger is always better” trap.' },
    ],
    capy: 'The trap is defaulting to Sonnet for everything. Volume + simple tasks → Haiku. Stuck on a hard problem → Opus. Otherwise → Sonnet.',
  },
}
