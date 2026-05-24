// Dive: "What Claude can actually do"
// Course: Meet Claude · Dive 1 of 8
// Architecture: Story-style (16-panel arrow-nav comic) → 5-Q Vibe Check → Receipt
//
// Pattern reference: Growth.Design case studies (Louie's lessons).
// Cap + "you" (no second human character).
// Each Insight panel adds a sticky to a persistent corner stack.
// Spot-it interactions test learning inside the artifact (panels 6, 9, 12, 13).
// Video lives INSIDE the story (panels 14-15) with parallel spot-cards beside.

// ─── Panel schema (discriminated union) ──────────────────────────────────────

export type Sticky = { id: string; label: string; color: string }

export type Bubble = {
  from: 'cap' | 'narrator'
  text: string  // supports **bold** and `code` inline
  pose?: 'hi' | 'thinking' | 'celebrating' | 'oops'
  position?: 'left' | 'right' | 'top' | 'bottom-left' | 'bottom-right'
}

export type Hotspot = {
  // percentage-based positioning on the underlying artifact image
  x: number; y: number; w: number; h: number
  correct: boolean
  hint?: string  // Cap line shown if user taps near-but-wrong
  label?: string // sticky label that pins on correct tap (big-spot only)
}

export type Panel =
  | { id: string; type: 'cover'; topicChip: string; title: string; subtitle: string; duration: string; capyPose: 'hi' | 'celebrating' }
  | { id: string; type: 'scene'; visual?: { kind: 'emoji'; value: string } | { kind: 'image'; src: string; alt: string }; bubbles: Bubble[]; bgTint?: 'warm' | 'cool' | 'neutral' }
  | { id: string; type: 'artifact'; image: string; alt: string; caption?: string; bubbles: Bubble[]; arrows?: { x: number; y: number; label: string; direction?: 'up'|'down'|'left'|'right' }[] }
  | { id: string; type: 'insight'; emoji: string; label: string; title: string; body: string; source: string; addsSticky: Sticky }
  | { id: string; type: 'spot'; image: string; alt: string; prompt: string; hotspots: Hotspot[]; capyHint?: string }
  | { id: string; type: 'big-spot'; image: string; alt: string; prompt: string; hotspots: Hotspot[]; capyHint?: string }
  | { id: string; type: 'video'; youtubeId: string; title: string; creator: string; duration: string; parallelCards: { stickyId: string; label: string; sceneHint: string }[]; cta: string }
  | { id: string; type: 'realization'; big: string; small: string; capyPose: 'hi' | 'thinking' | 'celebrating' }

// ─── Stickies (defined once, referenced from insight + big-spot + video) ──────

const STICKIES = {
  longContext: { id: 'long-context', label: 'Long context', color: '#FFB58A' },
  toolUse:     { id: 'tool-use',     label: 'Tool use',     color: '#C084FC' },
  e2eCode:     { id: 'e2e-code',     label: 'End-to-end code', color: '#A8E6CF' },
} as const

// ─── Dive content ────────────────────────────────────────────────────────────

export const MEET_CLAUDE_DIVE = {
  slug: 'meet-claude',
  title: 'What Claude can actually do',
  topicLabel: 'Meet Claude · Dive 1 of 8',

  // Panels — 16 of them, arrow-nav comic
  panels: [
    // PANEL 1 — Cover
    {
      id: 'cover',
      type: 'cover',
      topicChip: 'AI AT WORK',
      title: 'What Claude can actually do',
      subtitle: '…and why your work week is about to shrink.',
      duration: '5 MIN',
      capyPose: 'hi',
    },

    // PANEL 2 — Setup
    {
      id: 'setup',
      type: 'scene',
      visual: { kind: 'emoji', value: '🗓️' },
      bgTint: 'warm',
      bubbles: [
        { from: 'cap', pose: 'thinking', position: 'left',
          text: 'Imagine your Monday morning. **30 customer interviews** to read. A **12-page PRD** to turn into Asana tasks. By Friday.' },
      ],
    },

    // PANEL 3 — Old way
    {
      id: 'old-way',
      type: 'scene',
      visual: { kind: 'emoji', value: '😩' },
      bubbles: [
        { from: 'cap', pose: 'thinking', position: 'left',
          text: 'Old way? Paste transcript one into ChatGPT. Themes? Paste two. Themes? **Three days, minimum.**' },
      ],
    },

    // PANEL 4 — Turn
    {
      id: 'turn',
      type: 'scene',
      visual: { kind: 'emoji', value: '👀' },
      bubbles: [
        { from: 'cap', pose: 'celebrating', position: 'left',
          text: 'Now watch this.' },
      ],
    },

    // PANEL 5 — Wow #1 (real Claude artifact)
    {
      id: 'wow-context',
      type: 'artifact',
      image: '/dive-meet-claude/claude-multi-pdf-upload.svg',
      alt: 'Claude.ai chat with 30 PDFs uploaded in one prompt',
      caption: 'claude.ai · all 30 transcripts in ONE prompt',
      bubbles: [
        { from: 'cap', pose: 'celebrating', position: 'bottom-left',
          text: 'All 30 in **one prompt**. 200k tokens = ~500 pages of context. Claude reads them all together.' },
      ],
      arrows: [
        { x: 50, y: 80, label: 'thirty PDFs · one drop', direction: 'up' },
      ],
    },

    // PANEL 6 — Insight #1 + Spot-it (combined into 2 panels for cleanliness)
    {
      id: 'insight-context',
      type: 'insight',
      emoji: '⚡',
      label: 'CLAUDE CAPABILITY',
      title: 'Long context',
      body: 'Claude reads up to ~500 pages in one prompt. Patterns that no single document reveals. With citations.',
      source: 'Anthropic · claude.ai context window 200k tokens',
      addsSticky: STICKIES.longContext,
    },

    {
      id: 'spot-context',
      type: 'spot',
      image: '/dive-meet-claude/claude-citations-output.svg',
      alt: 'Claude response with themed bullets + citations to original PDFs',
      prompt: 'Find where Claude **cites which transcript** said what.',
      hotspots: [
        { x: 70, y: 35, w: 25, h: 8, correct: true },
        { x: 70, y: 50, w: 25, h: 8, correct: true },
        // wrong-tap targets handled implicitly (anything outside hotspots)
      ],
      capyHint: 'Look at the **right side** of each bullet — Claude cites the source inline.',
    },

    // PANEL 8 — Next problem
    {
      id: 'next-prd',
      type: 'scene',
      visual: { kind: 'emoji', value: '📄' },
      bubbles: [
        { from: 'cap', pose: 'thinking', position: 'left',
          text: 'Now the 12-page PRD. Most people manually create the Asana tasks. **Don\'t.**' },
      ],
    },

    // PANEL 9 — Twist (Asana materializes)
    {
      id: 'twist-asana',
      type: 'artifact',
      image: '/dive-meet-claude/claude-asana-twist.svg',
      alt: 'Claude prompt + Asana board materializing with tasks',
      caption: 'claude.ai → asana board (live, via MCP)',
      bubbles: [
        { from: 'cap', pose: 'celebrating', position: 'bottom-right',
          text: 'Claude didn\'t **write a list**. It **made the tasks**. In your Asana. Live.' },
      ],
      arrows: [
        { x: 75, y: 50, label: 'tasks Claude just created', direction: 'right' },
      ],
    },

    // PANEL 10 — Insight #2
    {
      id: 'insight-tools',
      type: 'insight',
      emoji: '⚡',
      label: 'CLAUDE CAPABILITY',
      title: 'Tool use',
      body: 'Claude can act in Asana, Drive, GitHub, Notion, Slack, custom APIs. The line between "chat AI" and "AI teammate."',
      source: 'Anthropic · Interactive Connectors + MCP Apps (Jan 2026)',
      addsSticky: STICKIES.toolUse,
    },

    {
      id: 'spot-tools',
      type: 'spot',
      image: '/dive-meet-claude/claude-asana-twist.svg',
      alt: 'Same Claude+Asana screenshot — find the tool-use moment',
      prompt: 'Find where Claude is actually **doing something** in Asana (not just describing).',
      hotspots: [
        { x: 60, y: 40, w: 35, h: 30, correct: true },
      ],
      capyHint: 'Look at the **Asana board on the right** — those tasks didn\'t exist before.',
    },

    // PANEL 12 — Code scene
    {
      id: 'code-bug',
      type: 'artifact',
      image: '/dive-meet-claude/claude-debug.svg',
      alt: 'Claude analyzing a stack trace + writing a fix',
      caption: 'claude.ai · production bug, 11pm',
      bubbles: [
        { from: 'cap', pose: 'thinking', position: 'bottom-left',
          text: 'Bug. 11pm. **Hour left.** Claude reads the trace, writes the fix, writes the tests. End to end.' },
      ],
      arrows: [
        { x: 30, y: 30, label: 'bug identified', direction: 'up' },
        { x: 60, y: 60, label: 'fix written', direction: 'down' },
        { x: 80, y: 80, label: 'tests added', direction: 'right' },
      ],
    },

    // PANEL 13 — Insight #3
    {
      id: 'insight-code',
      type: 'insight',
      emoji: '⚡',
      label: 'CLAUDE CAPABILITY',
      title: 'End-to-end coding',
      body: 'Claude doesn\'t suggest. It writes, runs, debugs, and keeps going until the code runs.',
      source: 'Anthropic · Claude Code & Claude.ai 2025',
      addsSticky: STICKIES.e2eCode,
    },

    // PANEL 14 — Big spot-it (find all 3 in one shot)
    {
      id: 'big-spot',
      type: 'big-spot',
      image: '/dive-meet-claude/claude-everything.svg',
      alt: 'Composite Claude.ai screenshot with all 3 capabilities visible',
      prompt: 'All **three** capabilities. One screen. Find them.',
      hotspots: [
        { x: 15, y: 25, w: 30, h: 20, correct: true, label: 'Long context' },
        { x: 55, y: 40, w: 35, h: 25, correct: true, label: 'Tool use' },
        { x: 25, y: 70, w: 50, h: 20, correct: true, label: 'End-to-end code' },
      ],
      capyHint: 'Use the stickies in the corner — each pins to its area on the screen.',
    },

    // PANEL 15 — Video pitch (in-story)
    {
      id: 'video-pitch',
      type: 'scene',
      visual: { kind: 'emoji', value: '📺' },
      bubbles: [
        { from: 'cap', pose: 'celebrating', position: 'bottom-left',
          text: 'To see all this happen for real — Anthropic filmed three of their teammates doing it in their actual workday. **3:52.** Worth watching now that you know what you\'re seeing.' },
      ],
    },

    // PANEL 16 — Watch with parallel spot-cards
    {
      id: 'watch',
      type: 'video',
      youtubeId: 'oqUclC3gqKs',
      title: 'A day with Claude',
      creator: 'Anthropic',
      duration: '3:52',
      parallelCards: [
        { stickyId: 'long-context', label: 'Spot Long context',     sceneHint: 'Maggie · research synthesis' },
        { stickyId: 'tool-use',     label: 'Spot Tool use',          sceneHint: 'Mahesh · PRD → Asana' },
        { stickyId: 'e2e-code',     label: 'Spot End-to-end code',   sceneHint: 'Cat · debug' },
      ],
      cta: 'I saw all three →',
    },

    // PANEL 17 — Realization
    {
      id: 'realization',
      type: 'realization',
      big: 'You stopped thinking of AI as a smarter Google.',
      small: 'You started thinking of it as a teammate that does the work.',
      capyPose: 'celebrating',
    },
  ] satisfies Panel[],

  // ─── Stage B: Vibe check ───────────────────────────────────────────────
  quiz: {
    eyebrow: 'Prove it',
    questions: [
      {
        q: 'It\'s Friday. Your boss drops 50 MORE interview transcripts. What\'s your move?',
        options: [
          { label: 'Read them yourself this weekend — Claude can\'t handle that volume', correct: false,
            why: '50 transcripts ≈ a small fraction of Claude\'s 200k-token context. Easily fits in one prompt.' },
          { label: 'One Claude prompt — paste all 50, ask for cross-cutting themes with citations', correct: true,
            why: 'Right. This is exactly the long-context move you just learned. Save your weekend.' },
          { label: 'Forward to a research firm — outside scope of AI', correct: false,
            why: 'Research synthesis is precisely what Claude excels at. Outsourcing here means paying for what Claude does in 90 seconds.' },
        ],
      },
      {
        q: 'A teammate says "Claude is just ChatGPT with a different name." Best 1-line correction?',
        options: [
          { label: 'They\'re right, basically the same', correct: false,
            why: 'The Asana scene alone disproves this. Claude can act in your tools; ChatGPT (mostly) can\'t.' },
          { label: 'Different companies — and more importantly, Claude can act in your tools, not just chat', correct: true,
            why: 'This is the practical, memorable correction. Naming "act in your tools" is the new mental model.' },
          { label: 'Claude is just smarter', correct: false,
            why: 'Vague claim. The honest answer names a specific differentiator.' },
        ],
      },
      {
        q: 'Production breaks at 11pm. Best workflow?',
        options: [
          { label: 'Paste stack trace into ChatGPT, copy the suggestion, manually edit + test', correct: false,
            why: 'This is the OLD way. End-to-end means Claude does the whole loop, not just step 1.' },
          { label: 'Hand Claude the trace + repo context. Let it explain, fix, and write tests in one flow', correct: true,
            why: 'Right — this is the end-to-end coding capability you saw. The whole loop, not step 1.' },
          { label: 'Wake your senior engineer up', correct: false,
            why: 'Sometimes valid, but Claude can usually get you through the first attempt before you escalate.' },
        ],
      },
      {
        q: 'Your PM wrote a 20-page spec. Operations needs it in 40 Linear tickets. The lazy-but-correct move?',
        options: [
          { label: 'Manually create the 40 tickets', correct: false,
            why: 'You just learned not to. Tool use is the whole point.' },
          { label: 'Paste the spec into Claude with Linear connected — Claude creates the tickets', correct: true,
            why: 'Right. Tool use generalizes — Asana in the demo, Linear in your case. Same capability, different surface.' },
          { label: 'Send the spec to Linear AI — Claude can\'t do this', correct: false,
            why: 'Claude can do this via MCP/Linear integration. The capability is broader than the demo.' },
        ],
      },
      {
        q: 'You\'re evaluating Claude vs ChatGPT for your team. What\'s the strongest single argument?',
        options: [
          { label: 'Claude has more parameters', correct: false,
            why: 'Parameter counts are a benchmark obsession. Daily work doesn\'t care.' },
          { label: 'Claude reads across your tools and takes actions in them — long context + tool use + end-to-end code', correct: true,
            why: 'This is the right answer because it names three concrete capabilities, not vibes. Memorable, defensible, demoable.' },
          { label: 'Claude is more popular', correct: false,
            why: 'Both are huge. Popularity isn\'t the differentiator that helps your team work better.' },
        ],
      },
    ],
  },

  // ─── Stage C: Receipt ──────────────────────────────────────────────────
  pride: {
    headline: 'You can now use Claude like a teammate.',
    body: 'Most people still use Claude as a smarter Google. You don\'t anymore. That mental shift IS the lesson.',
    skills: [
      'Hand Claude 30 docs → synthesis with citations comes back',
      'Hand Claude a PRD → an Asana board comes back',
      'Hand Claude a bug → an end-to-end fix comes back',
    ],
    nextLesson: {
      label: 'Next in Meet Claude',
      title: 'Why Claude says no (and what to do about it)',
    },
  },

  quit: {
    headline: 'Wait — already?',
    body: 'You\'re part way through. Cap will lose his place.',
    stay: 'Keep learning',
    leave: 'Quit anyway',
  },
}
