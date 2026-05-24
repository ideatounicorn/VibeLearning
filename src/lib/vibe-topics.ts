// Vibe Learn — standalone proof-of-concept content
// Each topic = 90s primer slides + 5-card vibe check
// Designed for the "just vibe learn it" verb experience

export type PrimerSlide = {
  kicker?: string
  headline: string
  body?: string
  visual?: string // emoji placeholder — swap for nano-banana sticker art
  capySays?: string
  accent?: 'green' | 'violet' | 'amber' | 'coral'
}

export type VibeCard =
  | {
      kind: 'truefalse'
      prompt: string
      answer: boolean
      explain: string
    }
  | {
      kind: 'pick'
      prompt: string
      options: string[]
      correctIndex: number
      explain: string
    }

export type VibeTopic = {
  slug: string
  title: string
  tagline: string
  visual: string
  estMinutes: number
  primer: PrimerSlide[]
  vibeCheck: VibeCard[]
  goDeeper: { label: string; href: string }[]
}

export const TOPICS: Record<string, VibeTopic> = {
  'learn-claude': {
    slug: 'learn-claude',
    title: 'Claude',
    tagline: 'Anthropic’s AI — the one that thinks before it speaks.',
    visual: '🧠',
    estMinutes: 2,
    primer: [
      {
        kicker: 'What it is',
        headline: 'Claude is an AI made by Anthropic.',
        body: 'Think ChatGPT’s thoughtful cousin. Built with safety baked in.',
        visual: '🧠',
        capySays: 'I use Claude every day. Let me show you why.',
        accent: 'green',
      },
      {
        kicker: 'The family',
        headline: 'Three models. One brain, three speeds.',
        body: 'Opus = the genius (hard problems). Sonnet = the workhorse (daily driver). Haiku = the sprinter (fast & cheap).',
        visual: '🎭',
        capySays: 'Pick Sonnet by default. Upgrade to Opus when you’re stuck.',
        accent: 'violet',
      },
      {
        kicker: 'Superpower #1',
        headline: 'It remembers a LOT.',
        body: '200,000 tokens of context — roughly a 500-page book in one prompt.',
        visual: '📚',
        capySays: 'Paste the whole codebase. Seriously.',
        accent: 'amber',
      },
      {
        kicker: 'Superpower #2',
        headline: 'It can see.',
        body: 'Drop in screenshots, diagrams, photos. Claude reads them like text.',
        visual: '👁️',
        capySays: 'Stuck on a design? Screenshot it, ask Claude.',
        accent: 'coral',
      },
      {
        kicker: 'How you talk to it',
        headline: 'Be specific. Be honest.',
        body: 'Tell it the goal, the constraints, and what “done” looks like. Skip the magic words.',
        visual: '💬',
        capySays: 'Prompts aren’t spells. Just… ask clearly.',
        accent: 'green',
      },
      {
        kicker: 'Where it lives',
        headline: 'claude.ai, Claude Code, or the API.',
        body: 'Chat in the browser. Code in your terminal. Build apps via API. Same brain, different doors.',
        visual: '🚪',
        capySays: 'Claude Code is the magic one. We’ll get to that.',
        accent: 'violet',
      },
      {
        kicker: 'You’re ready',
        headline: 'That’s the vibe.',
        body: 'Now prove it — 5 quick cards.',
        visual: '✅',
        capySays: 'Let’s vibe check you.',
        accent: 'green',
      },
    ],
    vibeCheck: [
      {
        kind: 'pick',
        prompt: 'Who makes Claude?',
        options: ['OpenAI', 'Anthropic', 'Google', 'Meta'],
        correctIndex: 1,
        explain: 'Anthropic. Founded by ex-OpenAI folks in 2021.',
      },
      {
        kind: 'pick',
        prompt: 'You’ve got a gnarly bug nobody can crack. Which model?',
        options: ['Haiku', 'Sonnet', 'Opus'],
        correctIndex: 2,
        explain: 'Opus. Slowest, priciest, smartest. Save it for the hard stuff.',
      },
      {
        kind: 'truefalse',
        prompt: 'Claude can read images you paste into the chat.',
        answer: true,
        explain: 'Yep. Screenshots, charts, photos — all fair game.',
      },
      {
        kind: 'pick',
        prompt: 'Roughly how much context fits in one Claude prompt?',
        options: ['~4,000 tokens', '~32,000 tokens', '~200,000 tokens', '~2,000,000 tokens'],
        correctIndex: 2,
        explain: '200k tokens ≈ a 500-page book. Paste freely.',
      },
      {
        kind: 'truefalse',
        prompt: 'Adding “you are an expert” to every prompt makes Claude smarter.',
        answer: false,
        explain: 'Nope. Be specific about the task, not flattery. Claude doesn’t need pep talks.',
      },
    ],
    goDeeper: [
      { label: 'Watch: Claude Code in 10 min', href: 'https://www.youtube.com/results?search_query=claude+code+tutorial' },
      { label: 'Read: Anthropic prompting guide', href: 'https://docs.anthropic.com/claude/docs/intro-to-prompting' },
      { label: 'Try claude.ai →', href: 'https://claude.ai' },
    ],
  },
}
