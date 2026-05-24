import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'
dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

// ─── COURSE DATA ─────────────────────────────────────────────────────────────

const PATH_ID = 'f786ecc3-2045-4e08-841f-16b164ed10e1' // AI Product Building

const COURSE = {
  path_id: PATH_ID,
  title: 'Vibe Coding — Build Anything with AI',
  slug: 'vibe-coding-build-anything-with-ai',
  description: 'Master the art of AI-assisted coding. Learn to build full-stack apps using Cursor, Claude Code, Bolt, and Lovable — without getting stuck on syntax. Go from idea to shipped product faster than ever.',
  short_description: 'Build real apps with AI tools — ship faster, think bigger, skip the syntax grind.',
  level: 'beginner',
  order_index: 10,
  is_hidden: false,
  duration_hours: 5.5,
  skills_gained: [
    'Use Cursor AI to build features across multiple files',
    'Write effective prompts that get usable code on the first try',
    'Set up and command Claude Code from your terminal',
    'Ship full-stack apps with Lovable and Bolt.new',
    'Deploy AI-built apps to production with Vercel',
    'Debug AI-generated code by providing precise error context',
    'Structure CLAUDE.md for consistent AI-assisted projects',
    'Iterate on shipped products using real user feedback',
  ],
  tags: ['AI', 'Vibe Coding', 'Cursor', 'Claude Code', 'Lovable', 'Bolt', 'No-Code', 'Prompt Engineering'],
  flashcard_data: {
    titleCard: {
      headline: 'Build Anything with AI — No Syntax Required',
      subheadline: 'Ship real apps using Cursor, Claude Code, Lovable and Bolt.',
      emoji: '⚡',
      imageKeyword: 'code',
    },
    courseOverview: {
      welcome: "Hey! In this course, you'll learn vibe coding — the skill of building real software using AI as your coding partner. We curated the best YouTube tutorials across 7 modules covering everything from mindset to shipping in production. 🚀",
      modules: [
        { title: 'What is Vibe Coding?', description: 'Understand the philosophy, mindset, and why it changes everything.', emoji: '🧠' },
        { title: 'AI Coding Tools Landscape', description: 'Survey every major tool and choose the right one for your project.', emoji: '🗺️' },
        { title: 'Prompt Engineering for Code', description: 'Write prompts that get working code on the first try.', emoji: '✍️' },
        { title: 'Build with Cursor AI', description: 'Master the most powerful AI code editor in your local environment.', emoji: '🖥️' },
        { title: 'Build with Claude Code', description: 'Use Anthropic\'s terminal agent for deep, agentic coding tasks.', emoji: '🤖' },
        { title: 'Ship Apps with Lovable & Bolt', description: 'Build full-stack apps in minutes using browser-based AI builders.', emoji: '🚢' },
        { title: 'Deploy, Launch & Iterate', description: 'Put your AI-built app in front of real users and keep improving.', emoji: '🏁' },
      ],
    },
    glossary: [
      { term: 'Vibe Coding', definition: 'A development workflow where you direct AI to write code using natural language, focusing on intent over syntax.', example: 'Instead of writing a login function, you tell Cursor: "Add email/password auth with Supabase" and it writes it.', emoji: '⚡', imageKeyword: 'code' },
      { term: 'Prompt Engineering', definition: 'The skill of crafting clear, structured inputs to get the best possible outputs from AI.', example: 'Instead of "make a button", you write "Add a primary CTA button with loading state that calls /api/submit on click".', emoji: '✍️', imageKeyword: 'code' },
      { term: 'Context Window', definition: 'The maximum amount of text an AI can process in one conversation.', example: 'A 200K token context window can hold roughly 150,000 words — your entire codebase.', emoji: '📐', imageKeyword: 'server' },
      { term: 'Agentic Mode', definition: 'When AI autonomously plans, executes, and iterates through multi-step tasks without you prompting each step.', example: 'Claude Code in agentic mode reads your codebase, writes code, runs tests, and fixes errors automatically.', emoji: '🤖', imageKeyword: 'code' },
      { term: 'Hallucination', definition: 'When AI confidently generates incorrect or made-up code, APIs, or facts.', example: 'AI references a library function that doesn\'t exist — always verify generated code before shipping.', emoji: '👻', imageKeyword: 'server' },
    ],
    glossaryQuiz: [
      { question: 'What is the core idea behind vibe coding?', options: ['Writing code very quickly by hand', 'Using AI to implement your ideas through natural language', 'Pair programming with a colleague', 'Using visual drag-and-drop builders'], correctIndex: 1, term: 'Vibe Coding' },
      { question: 'What does "context window" refer to in AI coding?', options: ['A browser tab', 'The amount of text AI can read and process at once', 'Your monitor size', 'The number of files in a project'], correctIndex: 1, term: 'Context Window' },
      { question: 'What is "hallucination" in the context of AI code generation?', options: ['A visual rendering bug', 'A performance issue', 'When AI generates plausible-sounding but incorrect code or APIs', 'When AI refuses to answer'], correctIndex: 2, term: 'Hallucination' },
      { question: 'Agentic mode in AI coding tools means the AI can:', options: ['Only answer questions', 'Autonomously plan and execute multi-step coding tasks', 'Run only one command at a time', 'Edit only one file'], correctIndex: 1, term: 'Agentic Mode' },
    ],
    courseMap: {
      overview: "You'll go from understanding vibe coding philosophy, to mastering the top AI coding tools, to shipping a real full-stack app in production — all powered by the best-curated YouTube tutorials.",
      steps: [
        'Understand vibe coding mindset and choose your tools',
        'Master prompt engineering and AI-specific coding workflows',
        'Build and debug full-stack features with Cursor and Claude Code',
        'Deploy your AI-built app and earn your certificate',
      ],
    },
  },
}

// ─── MODULES + LESSONS ───────────────────────────────────────────────────────

const MODULES = [
  {
    title: 'What is Vibe Coding?',
    slug: 'what-is-vibe-coding',
    description: JSON.stringify({
      overview: 'Understand what vibe coding is, why it matters, and how thinking shifts when AI handles implementation.',
      objectives: [
        'Define vibe coding and explain its core workflow',
        'Understand why communicating intent beats memorizing syntax',
        'Identify when to review and when to trust AI output',
        'Recognize common beginner mistakes in AI-assisted coding',
      ],
      prerequisites: ['Basic comfort using a computer', 'Curiosity about building software'],
    }),
    order_index: 0,
    is_free: true,
    lessons: [
      { title: 'Vibe Coding Fundamentals in 33 Minutes', youtube_url: 'https://www.youtube.com/watch?v=iLCDSY2XX7E', youtube_video_id: 'iLCDSY2XX7E', order_index: 0, duration_minutes: 33, why_this_video: 'The most concise and dense intro to vibe coding — covers the philosophy, tools, and first project in under 35 minutes.', skills_gained: ['Vibe coding mindset', 'Tool overview', 'First AI project'] },
      { title: "The Ultimate Beginner's Guide to Vibe Coding", youtube_url: 'https://www.youtube.com/watch?v=-VuZmoc-Sq8', youtube_video_id: '-VuZmoc-Sq8', order_index: 1, duration_minutes: 25, why_this_video: 'Walks through the full beginner journey — from zero to building a real app — with clear mental models.', skills_gained: ['Beginner workflow', 'Tool selection', 'First project'] },
      { title: 'Vibe Coding Full Course for Beginners', youtube_url: 'https://www.youtube.com/watch?v=RKOXmCK4Khw', youtube_video_id: 'RKOXmCK4Khw', order_index: 2, duration_minutes: 40, why_this_video: 'Covers Replit, Cursor, and Lovable in one video — perfect survey of the vibe coding landscape.', skills_gained: ['Tool survey', 'Workflow patterns', 'Project structure'] },
    ],
    quizzes: [
      { question: 'What does "vibe coding" mean?', option_a: 'Writing code in a relaxed state of mind', option_b: 'Using AI to build software through natural language direction', option_c: 'Pair programming with a colleague', option_d: 'Using visual drag-and-drop editors', correct_option: 'b', explanation: 'Vibe coding is the practice of directing AI to implement code while you focus on intent and product decisions.', order_index: 1 },
      { question: 'Who popularized the term "vibe coding"?', option_a: 'Linus Torvalds', option_b: 'Sam Altman', option_c: 'Andrej Karpathy', option_d: 'Mark Zuckerberg', correct_option: 'c', explanation: 'Andrej Karpathy coined and popularized the term "vibe coding" to describe AI-assisted software development.', order_index: 2 },
      { question: 'What is the primary skill required in vibe coding?', option_a: 'Memorizing programming syntax', option_b: 'Speed typing', option_c: 'Clearly communicating your intent to AI', option_d: 'Manual debugging', correct_option: 'c', explanation: 'The core skill is communicating what you want clearly — the AI handles implementation details.', order_index: 3 },
      { question: 'When AI generates incorrect code, what should you do?', option_a: 'Give up and write it manually', option_b: 'Accept the output anyway', option_c: 'Refine your prompt with specific feedback about what went wrong', option_d: 'Switch to a different AI tool', correct_option: 'c', explanation: 'Iterative refinement — telling AI exactly what is wrong — is the core debugging loop in vibe coding.', order_index: 4 },
      { question: 'What is an AI "hallucination" in coding?', option_a: 'A visual rendering bug', option_b: 'When AI confidently generates wrong or made-up code', option_c: 'A performance optimization', option_d: 'A UI animation glitch', correct_option: 'b', explanation: 'Hallucination is when AI produces plausible-sounding but incorrect code, APIs, or facts that need verification.', order_index: 5 },
      { question: 'Why do vibe coders still benefit from understanding code basics?', option_a: 'They have to write everything manually', option_b: 'To look impressive', option_c: 'To review, debug, and effectively guide AI output', option_d: 'Basics are not needed at all', correct_option: 'c', explanation: 'Code literacy helps you spot issues, give precise feedback, and know when AI output is actually correct.', order_index: 6 },
      { question: 'What does "iterative prompting" mean?', option_a: 'Using the same prompt repeatedly', option_b: 'Refining prompts based on AI output until you get the right result', option_c: 'Writing longer and longer prompts', option_d: 'Copying prompts from others', correct_option: 'b', explanation: 'Iterative prompting is the loop of prompt → review output → refine → repeat until satisfied.', order_index: 7 },
      { question: 'A good vibe coding session always starts with?', option_a: 'Installing every AI tool available', option_b: 'A clear goal and a structured plan', option_c: 'Writing tests first', option_d: 'Just typing and seeing what happens', correct_option: 'b', explanation: 'Clear goals prevent AI from going in wrong directions and wasting your time with irrelevant output.', order_index: 8 },
      { question: 'What is "context" in vibe coding?', option_a: 'The UI color theme', option_b: 'The programming language being used', option_c: 'Background information given to AI about your project', option_d: 'The folder structure', correct_option: 'c', explanation: 'Context includes your project goals, constraints, and existing code — better context = better AI output.', order_index: 9 },
      { question: 'Which statement about vibe coding is TRUE?', option_a: 'It only works for toy projects', option_b: 'You never need to read generated code', option_c: 'Reviewing AI output is always essential', option_d: 'It removes all traditional dev skills', correct_option: 'c', explanation: 'Never ship AI code without reviewing it — you are responsible for what goes into production.', order_index: 10 },
      { question: 'What is a CLAUDE.md file used for?', option_a: 'Storing CSS styles', option_b: 'Giving AI persistent context about your project conventions', option_c: 'Logging runtime errors', option_d: 'Managing npm packages', correct_option: 'b', explanation: 'CLAUDE.md tells Claude Code about your tech stack, conventions, and project goals on every session.', order_index: 11 },
      { question: 'The main advantage of vibe coding for beginners is?', option_a: 'AI does everything automatically with zero input', option_b: 'No planning is ever needed', option_c: 'Faster path from idea to working product', option_d: 'No bugs ever appear', correct_option: 'c', explanation: 'Vibe coding dramatically reduces the learning curve for building real projects that actually work.', order_index: 12 },
      { question: 'What is "agentic mode" in AI coding tools?', option_a: 'A paid subscription tier', option_b: 'AI that autonomously plans and executes multi-step tasks', option_c: 'A code formatting feature', option_d: 'A git integration', correct_option: 'b', explanation: 'Agentic mode lets AI act autonomously — reading files, writing code, running commands, and iterating.', order_index: 13 },
      { question: 'How should you break down a complex feature for vibe coding?', option_a: 'Write one massive prompt with all requirements', option_b: 'Let AI decide the approach without guidance', option_c: 'Break it into small, specific tasks and verify each step', option_d: 'Never break it down', correct_option: 'c', explanation: 'Smaller tasks give AI clear scope and let you catch errors before they compound.', order_index: 14 },
      { question: 'Vibe coding is best suited for?', option_a: 'Developers who want to avoid all thinking', option_b: 'People who want to build and ship software faster', option_c: 'Only non-technical founders', option_d: 'Only senior engineers', correct_option: 'b', explanation: 'Vibe coding accelerates anyone — from beginners to senior devs — who wants to build faster.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'Define vibe coding as directing AI with natural language to build software you envision',
        'Communicate intent precisely — specificity in prompts drives quality in output',
        'Review every piece of AI-generated code before shipping it to users',
        'Iterate on prompts using specific error feedback rather than starting over',
        'Use CLAUDE.md or cursor rules to give AI persistent project context',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Write a one-paragraph description of an app you want to build. Then rewrite it as a vibe coding prompt: include the tech stack, key features, and one specific constraint.', screenshot_hint: 'Your two versions side by side — notice how the second is more actionable for AI.' },
        { type: 'reflection', prompt: 'What mental shift is hardest for you — trusting AI output, or learning when NOT to trust it? Write 3 sentences on how you\'ll handle that.' },
      ],
    },
  },
  {
    title: 'AI Coding Tools Landscape',
    slug: 'ai-coding-tools-landscape',
    description: JSON.stringify({
      overview: 'Survey every major AI coding tool, understand their strengths, and choose the right one for your project type.',
      objectives: [
        'Compare Cursor, Claude Code, Lovable, Bolt, and Replit',
        'Match tool to project type and technical comfort level',
        'Understand browser-based vs local development tradeoffs',
        'Know when to switch tools mid-project',
      ],
      prerequisites: ['Completed Module 1'],
    }),
    order_index: 1,
    is_free: true,
    lessons: [
      { title: 'I Ranked Every AI App Builder for 2026', youtube_url: 'https://www.youtube.com/watch?v=OZOokCf2R_4', youtube_video_id: 'OZOokCf2R_4', order_index: 0, duration_minutes: 20, why_this_video: 'The most systematic head-to-head comparison of Lovable, Bolt, Replit, and Cursor — saves hours of research.', skills_gained: ['Tool comparison', 'Decision framework', 'Use-case matching'] },
      { title: 'Vibe Coding Tutorial for Beginners 2026: Step by Step', youtube_url: 'https://www.youtube.com/watch?v=Q_FZ800Hm4g', youtube_video_id: 'Q_FZ800Hm4g', order_index: 1, duration_minutes: 30, why_this_video: 'Hands-on walkthrough of the full vibe coding workflow using multiple tools — great for seeing real usage.', skills_gained: ['Hands-on workflow', 'Tool switching', 'Beginner project'] },
      { title: '100 Hours of Vibe Coding Lessons in 20 Minutes', youtube_url: 'https://www.youtube.com/watch?v=MyRF01zzKvE', youtube_video_id: 'MyRF01zzKvE', order_index: 2, duration_minutes: 20, why_this_video: 'Distils hundreds of hours of vibe coding experience into actionable best practices — the fastest way to skip mistakes.', skills_gained: ['Best practices', 'Common mistakes', 'Expert shortcuts'] },
    ],
    quizzes: [
      { question: 'Which tool is best for code-heavy projects needing deep IDE integration?', option_a: 'Lovable', option_b: 'Bolt.new', option_c: 'Cursor', option_d: 'Replit', correct_option: 'c', explanation: 'Cursor is a full local code editor with deep codebase awareness, ideal for complex multi-file projects.', order_index: 1 },
      { question: 'Lovable is primarily designed for?', option_a: 'Backend API development', option_b: 'Full-stack React app generation from prompts', option_c: 'Database management', option_d: 'Terminal workflows', correct_option: 'b', explanation: 'Lovable generates full-stack React + Supabase apps from natural language descriptions.', order_index: 2 },
      { question: 'What makes Bolt.new different from Cursor?', option_a: 'Bolt runs entirely in the browser with no installation', option_b: 'Bolt requires a local install', option_c: 'Bolt only works with Python', option_d: 'Bolt has no AI features', correct_option: 'a', explanation: 'Bolt.new is a browser-based IDE — zero setup, immediate results, accessible from any device.', order_index: 3 },
      { question: 'Claude Code runs in?', option_a: 'The browser only', option_b: 'Lovable\'s interface', option_c: 'Your local terminal/command line', option_d: 'GitHub Codespaces', correct_option: 'c', explanation: 'Claude Code is Anthropic\'s terminal-based agent that runs locally with full file system access.', order_index: 4 },
      { question: 'What is the main limitation of browser-based vibe coding tools?', option_a: 'They support very few languages', option_b: 'Limited access to your local file system', option_c: 'They are all paid tools', option_d: 'Their AI is weaker than local tools', correct_option: 'b', explanation: 'Browser-based tools can\'t access your local OS, files, or environment — ideal for greenfield projects.', order_index: 5 },
      { question: 'Which platform is owned by Anthropic?', option_a: 'Cursor', option_b: 'Lovable', option_c: 'Claude Code', option_d: 'Bolt.new', correct_option: 'c', explanation: 'Claude Code is built and maintained by Anthropic, the AI safety company behind Claude.', order_index: 6 },
      { question: 'Cursor is built on top of which code editor?', option_a: 'Vim', option_b: 'Emacs', option_c: 'VS Code', option_d: 'Sublime Text', correct_option: 'c', explanation: 'Cursor is a fork of VS Code — all your existing extensions and shortcuts work inside it.', order_index: 7 },
      { question: 'Which tool is best for non-technical founders?', option_a: 'Claude Code', option_b: 'Terminal vim', option_c: 'Lovable or Bolt.new', option_d: 'Raw API calls', correct_option: 'c', explanation: 'Lovable and Bolt require no technical setup — describe your app and watch it get built.', order_index: 8 },
      { question: '"Agentic mode" in coding tools means?', option_a: 'AI writes one line at a time', option_b: 'AI autonomously plans and executes multi-step tasks', option_c: 'AI only answers questions', option_d: 'Manual control mode', correct_option: 'b', explanation: 'Agentic mode allows AI to create files, run commands, and iterate without needing a prompt for each action.', order_index: 9 },
      { question: 'What should you prioritize when choosing a vibe coding tool?', option_a: 'Social media popularity', option_b: 'Project type, workflow, and technical comfort', option_c: 'Number of tutorials available', option_d: 'The most expensive option', correct_option: 'b', explanation: 'Tool choice depends on your project\'s complexity, whether you need local file access, and your coding background.', order_index: 10 },
      { question: 'When does using multiple vibe coding tools make sense?', option_a: 'Never — stick to one', option_b: 'Only when one tool is down', option_c: 'Different tools excel at different stages of development', option_d: 'Only when you have a big budget', correct_option: 'c', explanation: 'Many pros use Lovable to scaffold, Cursor to refine, and Claude Code for complex logic — best tool for each job.', order_index: 11 },
      { question: 'GitHub Copilot integrates with?', option_a: 'Only VS Code', option_b: 'Multiple popular code editors', option_c: 'Only Cursor', option_d: 'Only the terminal', correct_option: 'b', explanation: 'Copilot works in VS Code, JetBrains IDEs, Vim, and more — it\'s editor-agnostic.', order_index: 12 },
      { question: 'Replit Agent is best for?', option_a: 'Large production codebases', option_b: 'Quick prototypes in a cloud-hosted environment', option_c: 'Terminal-only workflows', option_d: 'Offline development', correct_option: 'b', explanation: 'Replit provides a full cloud environment — great for prototypes when you can\'t or won\'t set up locally.', order_index: 13 },
      { question: 'What is a key signal that a tool fits your workflow?', option_a: 'It is the newest tool available', option_b: 'It reduces time from idea to working code', option_c: 'It has the most GitHub stars', option_d: 'It is the most expensive', correct_option: 'b', explanation: 'The right tool accelerates your specific workflow — measured by how fast you ship, not by specs.', order_index: 14 },
      { question: 'Which of these is NOT a vibe coding tool?', option_a: 'Cursor', option_b: 'Claude Code', option_c: 'Microsoft Excel', option_d: 'Bolt.new', correct_option: 'c', explanation: 'Microsoft Excel is a spreadsheet tool — not part of the AI-assisted software development ecosystem.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'Match your tool to your project — Lovable/Bolt for speed, Cursor for depth, Claude Code for complex logic',
        'Browser-based tools trade local file access for zero-setup convenience',
        'Cursor is VS Code with AI superpowers — all your existing workflow transfers',
        'Claude Code\'s terminal access makes it the most powerful for serious projects',
        'Many professionals combine tools at different stages — scaffold, refine, deploy',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Open Bolt.new and build a simple landing page for an app idea in 10 minutes using only prompts. No code editing allowed.', screenshot_hint: 'Screenshot your landing page result — notice what AI got right and what needs refinement.' },
        { type: 'screenshot', prompt: 'Install Cursor and open an existing project (or create a new folder). Use CMD+K to generate a simple utility function. Screenshot the result.', screenshot_hint: 'The Cursor inline edit panel showing your prompt and the generated code.' },
      ],
    },
  },
  {
    title: 'Prompt Engineering for Code',
    slug: 'prompt-engineering-for-code',
    description: JSON.stringify({
      overview: 'Learn the frameworks and techniques that turn vague requests into precise, working code on the first try.',
      objectives: [
        'Apply few-shot, chain-of-thought, and role-based prompting',
        'Structure prompts with clear inputs, outputs, and constraints',
        'Use XML tags and system prompts effectively',
        'Debug AI output by providing targeted error context',
      ],
      prerequisites: ['Completed Module 2'],
    }),
    order_index: 2,
    is_free: false,
    lessons: [
      { title: 'Prompt Engineering Essentials: Better Results from LLMs', youtube_url: 'https://www.youtube.com/watch?v=LAF-lACf2QY', youtube_video_id: 'LAF-lACf2QY', order_index: 0, duration_minutes: 25, why_this_video: 'Google\'s official guide — covers every core technique with practical code examples in under 30 minutes.', skills_gained: ['Core prompting techniques', 'Few-shot prompting', 'Chain-of-thought'] },
      { title: "Google's 9 Hour AI Prompt Engineering Course in 20 Minutes", youtube_url: 'https://www.youtube.com/watch?v=p09yRj47kNM', youtube_video_id: 'p09yRj47kNM', order_index: 1, duration_minutes: 20, why_this_video: 'Condenses an entire Google course into actionable insights — highest information density on this topic.', skills_gained: ['Google prompt frameworks', 'Advanced techniques', 'LLM behavior'] },
      { title: 'Prompt Engineering Guide — Beginner to Advanced', youtube_url: 'https://www.youtube.com/watch?v=uDIW34h8cmM', youtube_video_id: 'uDIW34h8cmM', order_index: 2, duration_minutes: 35, why_this_video: 'Complete progression from beginner to advanced with real coding examples and live demos.', skills_gained: ['Structured prompting', 'Role-based prompting', 'System prompts'] },
      { title: 'Prompt Engineering MasterClass for Developers (30 Labs)', youtube_url: 'https://www.youtube.com/watch?v=M_c1nJgHaJ8', youtube_video_id: 'M_c1nJgHaJ8', order_index: 3, duration_minutes: 60, why_this_video: '30 hands-on labs make abstract techniques concrete — the most practice-oriented resource available.', skills_gained: ['30 practical labs', 'Code review assistant', 'Developer workflows'] },
    ],
    quizzes: [
      { question: 'What is prompt engineering?', option_a: 'Building and training AI models', option_b: 'Crafting structured inputs to maximize AI output quality', option_c: 'Programming in Python', option_d: 'Designing user interfaces', correct_option: 'b', explanation: 'Prompt engineering is the skill of structuring your requests to consistently get accurate, usable outputs from AI.', order_index: 1 },
      { question: 'Which technique gives AI examples to follow?', option_a: 'Zero-shot prompting', option_b: 'Chain-of-thought', option_c: 'Few-shot prompting', option_d: 'Role-based prompting', correct_option: 'c', explanation: 'Few-shot prompting includes 2-5 examples of input/output pairs so AI learns the expected pattern.', order_index: 2 },
      { question: 'Chain-of-thought prompting works by?', option_a: 'Writing shorter prompts', option_b: 'Asking AI to reason step-by-step before answering', option_c: 'Using markdown code blocks', option_d: 'Repeating the prompt until correct', correct_option: 'b', explanation: 'Chain-of-thought ("think step by step") makes AI show its reasoning, catching errors in logic.', order_index: 3 },
      { question: 'What does "role-based prompting" mean?', option_a: 'Assigning AI a specific expert persona', option_b: 'Using role-based access control', option_c: 'Writing prompts for RPG games', option_d: 'Team-based prompt writing', correct_option: 'a', explanation: 'Telling AI "You are a senior React developer" shifts its output style, vocabulary, and assumptions.', order_index: 4 },
      { question: 'The best code prompts include?', option_a: 'Vague, open-ended descriptions', option_b: 'Specific inputs, expected outputs, and constraints', option_c: 'Only the function name', option_d: 'A single word', correct_option: 'b', explanation: 'Precise prompts reduce ambiguity — AI produces better code when it knows exactly what success looks like.', order_index: 5 },
      { question: 'XML tags in prompts help by?', option_a: 'Making prompts look more technical', option_b: 'Clearly separating different sections for AI to parse', option_c: 'Running the code automatically', option_d: 'Debugging errors', correct_option: 'b', explanation: 'Tags like <context>, <task>, <example> help AI understand which part of the prompt does what.', order_index: 6 },
      { question: 'What is a "system prompt"?', option_a: 'An OS-level command', option_b: 'Instructions that set AI behavior before the conversation starts', option_c: 'A command to install software', option_d: 'A debugging command', correct_option: 'b', explanation: 'System prompts define the AI\'s role, constraints, and persona for the entire session.', order_index: 7 },
      { question: 'Negative prompting means?', option_a: 'Writing frustrated prompts', option_b: 'Explicitly telling AI what NOT to do', option_c: 'Using negative numbers', option_d: 'Giving negative feedback after the answer', correct_option: 'b', explanation: '"Do not use jQuery, do not add comments" — telling AI what to avoid reduces unwanted output.', order_index: 8 },
      { question: 'What is "context window"?', option_a: 'A browser popup', option_b: 'The maximum text AI can process in one request', option_c: 'A code comment block', option_d: 'A file preview pane', correct_option: 'b', explanation: 'Context window limits how much code + instructions AI can "see" at once — larger windows handle bigger codebases.', order_index: 9 },
      { question: 'When AI produces wrong code, the best response is?', option_a: 'Start the entire conversation over', option_b: 'Paste the error back with specific description of what is wrong', option_c: 'Accept the output and ship it', option_d: 'Switch to a different AI tool', correct_option: 'b', explanation: 'Specific error context ("line 42 throws TypeError: Cannot read properties of undefined") gives AI exactly what it needs to fix.', order_index: 10 },
      { question: 'Which is better for complex features?', option_a: 'One long prompt with all requirements at once', option_b: 'Breaking into smaller sequential prompts', option_c: 'Repeating the same prompt', option_d: 'Using emoji to express intent', correct_option: 'b', explanation: 'Smaller prompts reduce AI confusion, make errors easier to isolate, and produce more reliable output.', order_index: 11 },
      { question: 'Temperature in AI models controls?', option_a: 'CPU processing heat', option_b: 'Randomness and creativity of outputs', option_c: 'Response length', option_d: 'Code formatting style', correct_option: 'b', explanation: 'Low temperature (0.1) = consistent/predictable. High temperature (0.9) = creative/varied. For code, use low temperature.', order_index: 12 },
      { question: 'What does "grounding" a prompt mean?', option_a: 'Writing prompts in lowercase', option_b: 'Providing specific facts, code snippets, or context', option_c: 'Starting from scratch each time', option_d: 'Deleting conversation history', correct_option: 'b', explanation: 'Grounded prompts include real code, real errors, and specific context — less hallucination, better output.', order_index: 13 },
      { question: 'For code generation, which temperature setting works best?', option_a: 'As high as possible for creativity', option_b: 'Low temperature for consistent, predictable output', option_c: 'Temperature does not matter', option_d: 'Maximum randomness always wins', correct_option: 'b', explanation: 'Code needs to be correct, not creative — low temperature reduces hallucination and syntax errors.', order_index: 14 },
      { question: 'The most common beginner prompting mistake is?', option_a: 'Using too many examples', option_b: 'Being too vague — no context, constraints, or expected output', option_c: 'Writing too specifically', option_d: 'Using punctuation', correct_option: 'b', explanation: '"Make a login" gives AI nothing to work with. "Build an email/password login form using React + Supabase Auth" does.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'Specify inputs, outputs, and constraints in every code prompt — vague prompts produce vague code',
        'Few-shot prompting: give AI 2-3 examples of what you want before asking it to generate',
        'Chain-of-thought: ask AI to "think step by step" before writing code for complex logic',
        'Role-based prompting shifts AI\'s vocabulary and assumptions — "You are a senior Next.js engineer"',
        'Paste exact error messages with context when debugging — specificity drives fix quality',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Take a vague prompt ("make a form") and rewrite it three times — each version more specific. Test each version in Cursor or Claude and compare the outputs.', screenshot_hint: 'Three prompt versions and their respective AI outputs side by side.' },
        { type: 'screenshot', prompt: 'Write a role-based prompt: "You are a senior TypeScript engineer. Generate a type-safe API client for [your project]." Run it and screenshot the result.', screenshot_hint: 'The generated TypeScript code with proper types and error handling.' },
      ],
    },
  },
  {
    title: 'Build with Cursor AI',
    slug: 'build-with-cursor-ai',
    description: JSON.stringify({
      overview: 'Master Cursor — the most powerful local AI code editor — from setup to advanced multi-file agentic workflows.',
      objectives: [
        'Navigate Cursor Chat, Composer, and inline edit (Cmd+K)',
        'Configure .cursorrules for project-specific AI behavior',
        'Use @codebase and @docs to give AI full project context',
        'Run Cursor in Agent mode for autonomous multi-step tasks',
      ],
      prerequisites: ['Completed Module 3'],
    }),
    order_index: 3,
    is_free: false,
    lessons: [
      { title: 'Cursor Tutorial for Beginners (AI Code Editor)', youtube_url: 'https://www.youtube.com/watch?v=ocMOZpuAMw4', youtube_video_id: 'ocMOZpuAMw4', order_index: 0, duration_minutes: 20, why_this_video: 'The clearest and most structured beginner intro to Cursor — covers every core feature with real examples.', skills_gained: ['Cursor setup', 'Chat panel', 'Inline edit'] },
      { title: 'Cursor AI Beginner Tutorial 2026 (Best AI for Coding)', youtube_url: 'https://www.youtube.com/watch?v=yMfXn-WLYWI', youtube_video_id: 'yMfXn-WLYWI', order_index: 1, duration_minutes: 25, why_this_video: 'Most up-to-date 2026 tutorial covering all new features and the latest Cursor workflows.', skills_gained: ['Latest features', 'Composer mode', 'Context usage'] },
      { title: 'Cursor Crash Course & AI Coding for Beginners', youtube_url: 'https://www.youtube.com/watch?v=5zR1ZE5aqho', youtube_video_id: '5zR1ZE5aqho', order_index: 2, duration_minutes: 30, why_this_video: 'Real project walkthrough — builds a complete feature using Cursor from scratch, showing the full agentic workflow.', skills_gained: ['Real project', 'Agentic workflow', 'Agent mode'] },
      { title: 'Cursor AI Tutorial for Beginners — Build FAST!', youtube_url: 'https://www.youtube.com/watch?v=LHASMSoT2Og', youtube_video_id: 'LHASMSoT2Og', order_index: 3, duration_minutes: 20, why_this_video: 'Focused on speed — shows how to build features in minutes using Cursor\'s most powerful shortcuts.', skills_gained: ['Speed workflows', 'Keyboard shortcuts', 'Fast iteration'] },
    ],
    quizzes: [
      { question: 'Cursor\'s Composer feature is used for?', option_a: 'Writing email drafts', option_b: 'Multi-file code generation and coordinated edits across a project', option_c: 'Running unit tests', option_d: 'Deploying apps', correct_option: 'b', explanation: 'Composer can read and edit multiple files at once — perfect for features that span components, routes, and APIs.', order_index: 1 },
      { question: 'What does Cmd+K (Ctrl+K) do in Cursor?', option_a: 'Saves the file', option_b: 'Opens an inline AI edit panel in your current file', option_c: 'Opens the terminal', option_d: 'Closes the tab', correct_option: 'b', explanation: 'Cmd+K opens an inline prompt right where your cursor is — perfect for small, targeted changes.', order_index: 2 },
      { question: 'What is .cursorrules used for?', option_a: 'Enforcing manual code style', option_b: 'Giving AI persistent instructions about your project conventions', option_c: 'Running the linter', option_d: 'Setting keyboard shortcuts', correct_option: 'b', explanation: '.cursorrules tells Cursor your tech stack, coding style, and project rules — applied to every AI interaction.', order_index: 3 },
      { question: 'What does the @codebase command do in Cursor?', option_a: 'Deletes all files', option_b: 'Gives AI access to and context about your entire project', option_c: 'Runs the app', option_d: 'Formats all code', correct_option: 'b', explanation: '@codebase lets Cursor search and reason about your whole repository, not just open files.', order_index: 4 },
      { question: 'What is "Agent mode" in Cursor?', option_a: 'A Pro subscription perk', option_b: 'AI autonomously plans and executes multi-step coding tasks', option_c: 'A debugging interface', option_d: 'A git commit helper', correct_option: 'b', explanation: 'Agent mode lets Cursor create files, run terminal commands, and iterate through complex tasks on its own.', order_index: 5 },
      { question: 'The best way to start a new feature in Cursor is?', option_a: 'Write all requirements in one giant prompt', option_b: 'Give context about your project and describe the specific feature goal', option_c: 'Let AI decide without any guidance', option_d: 'Import every file first', correct_option: 'b', explanation: 'Start with context (what the app does) + goal (what this feature should achieve) + constraints (what not to do).', order_index: 6 },
      { question: 'Cursor Tab autocomplete works by?', option_a: 'Standard dictionary suggestions', option_b: 'AI predicting your next code change based on recent edits', option_c: 'Searching Stack Overflow', option_d: 'Matching your previous keystrokes', correct_option: 'b', explanation: 'Cursor Tab uses AI to predict whole code changes — press Tab to accept multi-line suggestions.', order_index: 7 },
      { question: 'What types of context can Cursor reference?', option_a: 'Only the currently open file', option_b: 'Files, folders, docs, web URLs, terminal output, and more', option_c: 'Only text files', option_d: 'Only package.json', correct_option: 'b', explanation: 'Use @file, @folder, @web, @docs, @terminal — Cursor can pull context from almost anywhere.', order_index: 8 },
      { question: 'When Cursor generates a bug, best practice is?', option_a: 'Restart Cursor', option_b: 'Paste the exact error message into Chat for AI to diagnose and fix', option_c: 'Manually debug without AI', option_d: 'Delete the file and start over', correct_option: 'b', explanation: 'AI fixes its own bugs fastest when you give it the exact error — include file path and line number.', order_index: 9 },
      { question: 'Cursor\'s Notepads feature is used for?', option_a: 'Writing meeting notes', option_b: 'Storing reusable prompt templates and project context', option_c: 'Writing README files', option_d: 'Saving API keys', correct_option: 'b', explanation: 'Notepads store prompt templates you can pull into any Cursor session — great for repeatable workflows.', order_index: 10 },
      { question: 'Inline edit (Cmd+K) vs Composer — when should you use each?', option_a: 'They are identical', option_b: 'Inline for small localized changes, Composer for multi-file features', option_c: 'Use Composer always', option_d: 'Use inline edit always', correct_option: 'b', explanation: 'Cmd+K is surgical — one function, one block. Composer is for features that span multiple files.', order_index: 11 },
      { question: 'What makes Cursor better than standard GitHub Copilot?', option_a: 'Cursor is always free', option_b: 'Cursor understands your full codebase and can edit multiple files', option_c: 'Cursor only does autocomplete', option_d: 'Cursor runs in the browser', correct_option: 'b', explanation: 'Copilot is autocomplete-focused. Cursor understands project architecture and can orchestrate complex changes.', order_index: 12 },
      { question: 'Best practice for large Cursor tasks is?', option_a: 'One massive prompt with all requirements', option_b: 'Break into small tasks, verify each step before continuing', option_c: 'Never verify AI output', option_d: 'Use only the Chat panel', correct_option: 'b', explanation: 'Errors compound — verify each small step to prevent AI from building on a broken foundation.', order_index: 13 },
      { question: 'Cursor\'s @web command lets AI?', option_a: 'Deploy your app', option_b: 'Browse the web to reference up-to-date documentation', option_c: 'Search your GitHub repos', option_d: 'Monitor production', correct_option: 'b', explanation: '@web fetches live documentation, so AI uses the current API — not outdated training data.', order_index: 14 },
      { question: 'After accepting a Composer edit, you should?', option_a: 'Immediately push to production', option_b: 'Review the diff, test the change, then commit if correct', option_c: 'Never review AI edits', option_d: 'Delete the original files', correct_option: 'b', explanation: 'Always review diffs before accepting — Composer makes it easy to see exactly what changed.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'Cmd+K for inline edits, Composer for multi-file features — know which to reach for',
        '.cursorrules gives AI persistent project conventions so you don\'t repeat yourself every session',
        '@codebase, @web, and @docs give Cursor the context it needs to generate accurate code',
        'Agent mode handles complex multi-step tasks — verify at each milestone, not just at the end',
        'Cursor Tab autocomplete predicts whole code changes — press Tab early and often',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Create a .cursorrules file for a project you\'re working on. Include: tech stack, coding conventions, what to avoid, and one project-specific rule. Then use it in a real Composer task.', screenshot_hint: 'Your .cursorrules file and the Composer chat showing AI following the rules.' },
        { type: 'screenshot', prompt: 'Use Cursor Agent mode to add a complete new feature to any project (e.g., a dark mode toggle, or a search bar). Let it run autonomously and screenshot the final result.', screenshot_hint: 'The working feature in your browser + the Cursor Agent activity log showing all steps taken.' },
      ],
    },
  },
  {
    title: 'Build with Claude Code',
    slug: 'build-with-claude-code',
    description: JSON.stringify({
      overview: 'Use Anthropic\'s terminal-based AI agent for deep, agentic coding — with full local file access, MCP tools, and autonomous task execution.',
      objectives: [
        'Install and configure Claude Code in your terminal',
        'Write effective CLAUDE.md files for project context',
        'Use plan mode, /clear, and /compact effectively',
        'Extend Claude Code with MCP servers',
      ],
      prerequisites: ['Completed Module 4'],
    }),
    order_index: 4,
    is_free: false,
    lessons: [
      { title: 'Claude Code Tutorial: Beginner to Advanced in 20 Minutes', youtube_url: 'https://www.youtube.com/watch?v=ujHXnlSVheI', youtube_video_id: 'ujHXnlSVheI', order_index: 0, duration_minutes: 20, why_this_video: 'Best single-video crash course — covers everything from install to advanced workflows in 20 focused minutes.', skills_gained: ['Claude Code install', 'Core commands', 'CLAUDE.md'] },
      { title: 'Claude Code Tutorial for Beginners', youtube_url: 'https://www.youtube.com/watch?v=3nnw06bY4mM', youtube_video_id: '3nnw06bY4mM', order_index: 1, duration_minutes: 25, why_this_video: 'Step-by-step beginner walkthrough with real project — focuses on the most important commands and workflows.', skills_gained: ['Setup workflow', 'File access', 'Task execution'] },
      { title: 'Claude Code for Beginners Tutorial (Full Course)', youtube_url: 'https://www.youtube.com/watch?v=gh2_PhgZGsM', youtube_video_id: 'gh2_PhgZGsM', order_index: 2, duration_minutes: 45, why_this_video: 'Most comprehensive free Claude Code course — covers MCP, sub-agents, and production workflows.', skills_gained: ['MCP servers', 'Sub-agents', 'Production workflows'] },
      { title: 'I Should Be Charging $999 for This Claude Code Tutorial', youtube_url: 'https://www.youtube.com/watch?v=4nthc76rSl8', youtube_video_id: '4nthc76rSl8', order_index: 3, duration_minutes: 30, why_this_video: 'Expert-level tips and tricks not covered in basic tutorials — the fastest path to advanced Claude Code mastery.', skills_gained: ['Expert tips', 'Advanced workflows', 'Productivity shortcuts'] },
    ],
    quizzes: [
      { question: 'Claude Code runs primarily in?', option_a: 'A web browser', option_b: 'Your local terminal or command line', option_c: 'Cursor\'s interface', option_d: 'GitHub Actions', correct_option: 'b', explanation: 'Claude Code is a CLI tool — it lives in your terminal and has full access to your local file system.', order_index: 1 },
      { question: 'What is CLAUDE.md?', option_a: 'A Markdown formatter', option_b: 'A project context file that guides Claude\'s behavior and conventions', option_c: 'An error log file', option_d: 'A CSS configuration file', correct_option: 'b', explanation: 'CLAUDE.md tells Claude your tech stack, coding conventions, key files, and project goals — read every session.', order_index: 2 },
      { question: 'Claude Code\'s plan mode is used for?', option_a: 'Project management scheduling', option_b: 'Reviewing Claude\'s proposed plan before it makes any changes', option_c: 'Scheduling automated tasks', option_d: 'Writing test cases', correct_option: 'b', explanation: 'Plan mode shows you what Claude intends to do before it touches any files — great for risky operations.', order_index: 3 },
      { question: 'What does /clear do in Claude Code?', option_a: 'Deletes all project files', option_b: 'Clears the context window to start a fresh conversation', option_c: 'Uninstalls Claude Code', option_d: 'Formats all code', correct_option: 'b', explanation: '/clear resets context — useful when a conversation gets confused or too long.', order_index: 4 },
      { question: 'How does Claude Code differ from browser-based AI tools?', option_a: 'Claude Code is less capable', option_b: 'Claude Code has full access to your local file system and terminal', option_c: 'Claude Code is always free', option_d: 'Claude Code runs faster', correct_option: 'b', explanation: 'Claude Code can read, write, and execute files locally — browser tools can\'t access your OS or environment.', order_index: 5 },
      { question: 'MCP servers extend Claude Code by?', option_a: 'Making responses slower', option_b: 'Adding new tools and capabilities beyond the defaults', option_c: 'Limiting what Claude can access', option_d: 'Changing the UI', correct_option: 'b', explanation: 'MCP (Model Context Protocol) servers give Claude Code access to databases, APIs, browsers, and more.', order_index: 6 },
      { question: 'What is the recommended way to give Claude Code project context?', option_a: 'Paste everything into each chat message', option_b: 'Use CLAUDE.md with project description and coding conventions', option_c: 'Hope it infers from file names', option_d: 'Use only code comments', correct_option: 'b', explanation: 'CLAUDE.md is read automatically — it\'s the most efficient way to give persistent context without repeating yourself.', order_index: 7 },
      { question: 'Claude Code\'s agentic loops mean?', option_a: 'It repeats your prompt forever', option_b: 'It loops code logic automatically', option_c: 'It autonomously runs commands, reads files, and iterates', option_d: 'It pings a server repeatedly', correct_option: 'c', explanation: 'Agentic Claude Code can write code, run tests, read error output, and fix itself without you intervening.', order_index: 8 },
      { question: 'What should you review before approving Claude Code actions?', option_a: 'Nothing — trust AI completely', option_b: 'Which files will be modified and what commands will run', option_c: 'Only the final output at the end', option_d: 'The token count', correct_option: 'b', explanation: 'Always review proposed file changes and shell commands — especially destructive operations like deletes.', order_index: 9 },
      { question: 'What does /compact do?', option_a: 'Zips your project files', option_b: 'Summarizes conversation history to fit more in the context window', option_c: 'Compresses images', option_d: 'Minifies JavaScript', correct_option: 'b', explanation: '/compact intelligently summarizes the conversation, freeing up context for more code without losing important info.', order_index: 10 },
      { question: 'Claude Code sub-agents are used for?', option_a: 'Customer support chatbots', option_b: 'Breaking large tasks into parallel workstreams', option_c: 'Writing documentation only', option_d: 'Running a single terminal command', correct_option: 'b', explanation: 'Sub-agents spawn specialized Claude instances — e.g., one agent writes code while another writes tests.', order_index: 11 },
      { question: 'The best CLAUDE.md file includes?', option_a: 'Your full professional resume', option_b: 'Tech stack, conventions, key files, commands, and project goals', option_c: 'API keys and passwords', option_d: 'Random notes', correct_option: 'b', explanation: 'A great CLAUDE.md helps Claude make correct decisions on day one without needing repeated clarification.', order_index: 12 },
      { question: 'When Claude Code makes a mistake, best practice is?', option_a: 'Uninstall and reinstall', option_b: 'Use /undo and refine instructions with specific error details', option_c: 'Accept the mistake and continue', option_d: 'Manually fix every file', correct_option: 'b', explanation: '/undo reverts the last action — then give Claude the exact error and clearer instructions.', order_index: 13 },
      { question: 'What makes Claude Code powerful for experienced developers?', option_a: 'Its colorful UI', option_b: 'Deep reasoning + full local file access + tool use via MCP', option_c: 'It is the cheapest option', option_d: 'It only writes comments', correct_option: 'b', explanation: 'The combination of strong reasoning, local access, and extensible tools makes Claude Code production-grade.', order_index: 14 },
      { question: 'Claude Code\'s plan mode is especially useful when?', option_a: 'Editing a CSS color', option_b: 'Making complex changes that touch many files or run risky commands', option_c: 'Writing a one-line fix', option_d: 'Creating a new folder', correct_option: 'b', explanation: 'Use plan mode for database migrations, refactors, or anything that could break things if done wrong.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'CLAUDE.md is the most important file in any Claude Code project — write it before anything else',
        'Plan mode shows intent before action — always use it for destructive or complex operations',
        '/compact and /clear manage context window — use them proactively on long sessions',
        'MCP servers unlock database access, browser control, and external APIs directly in Claude Code',
        'Sub-agents parallelize work — split large features into concurrent specialized agents',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Install Claude Code (npm install -g @anthropic-ai/claude-code). Navigate to any project and run "claude" in the terminal. Write a CLAUDE.md for the project covering tech stack, conventions, and one project-specific rule.', screenshot_hint: 'Your terminal running Claude Code + the CLAUDE.md file content.' },
        { type: 'screenshot', prompt: 'Use Claude Code plan mode to refactor a function or component. Type your request, review the plan, then approve it. Screenshot the plan and the diff after approval.', screenshot_hint: 'Claude\'s plan text + the file diff showing exactly what changed.' },
      ],
    },
  },
  {
    title: 'Ship Full-Stack Apps with Lovable & Bolt',
    slug: 'ship-full-stack-apps-lovable-bolt',
    description: JSON.stringify({
      overview: 'Build complete full-stack applications in minutes using browser-based AI builders — no local setup required.',
      objectives: [
        'Build a full-stack app from a text description in Lovable',
        'Connect Supabase to Lovable for auth and database',
        'Use Bolt.new to prototype and iterate in the browser',
        'Know when to move from AI builders to local editors',
      ],
      prerequisites: ['Completed Module 5'],
    }),
    order_index: 5,
    is_free: false,
    lessons: [
      { title: 'Complete Vibe Coding Tutorial: Build Full Stack App in 30 Min with Lovable', youtube_url: 'https://www.youtube.com/watch?v=n-c-cUH97L8', youtube_video_id: 'n-c-cUH97L8', order_index: 0, duration_minutes: 30, why_this_video: 'End-to-end real app build in Lovable — the most practical demo of what\'s possible in 30 minutes with AI.', skills_gained: ['Lovable workflow', 'Full-stack generation', 'Supabase integration'] },
      { title: 'The Ultimate Guide to Bolt.new (Build Apps with AI)', youtube_url: 'https://www.youtube.com/watch?v=0_Ij8FEvY4U', youtube_video_id: '0_Ij8FEvY4U', order_index: 1, duration_minutes: 25, why_this_video: 'The definitive Bolt.new guide — step by step with real examples across different project types.', skills_gained: ['Bolt.new workflow', 'Browser IDE', 'App generation'] },
      { title: 'Bolt v2 is Actually Insane: Idea to Full-Stack App in Minutes', youtube_url: 'https://www.youtube.com/watch?v=Mq_s-rpsVgo', youtube_video_id: 'Mq_s-rpsVgo', order_index: 2, duration_minutes: 15, why_this_video: 'Shows the dramatic improvement in Bolt v2 — the fastest demo of full-stack app generation available.', skills_gained: ['Bolt v2 features', 'Speed building', 'Full-stack generation'] },
      { title: 'I Built a Full-Stack App in 10 Minutes: Vibe Coding with Zoer', youtube_url: 'https://www.youtube.com/watch?v=k04F4EE9Oow', youtube_video_id: 'k04F4EE9Oow', order_index: 3, duration_minutes: 10, why_this_video: 'The fastest real-world demo — shows what\'s achievable in 10 minutes combining Lovable, Supabase, and Netlify.', skills_gained: ['Speed workflow', 'Lovable + Supabase', 'One-click deploy'] },
    ],
    quizzes: [
      { question: 'Lovable primarily generates?', option_a: 'Only backend REST APIs', option_b: 'Full-stack React apps from natural language descriptions', option_c: 'Only CSS stylesheets', option_d: 'Database schemas only', correct_option: 'b', explanation: 'Lovable turns text descriptions into complete React + Supabase applications with auth, database, and UI.', order_index: 1 },
      { question: 'Bolt.new runs entirely in?', option_a: 'Your local file system', option_b: 'The browser — no installation required', option_c: 'GitHub Codespaces', option_d: 'A Docker container', correct_option: 'b', explanation: 'Bolt.new is a browser-based IDE — open it, describe your app, and build immediately from any device.', order_index: 2 },
      { question: 'The best first prompt for Lovable is?', option_a: '"Make me an app"', option_b: 'Detailed description: goals, target users, and key features', option_c: 'A one-word topic', option_d: 'Just a design mockup image', correct_option: 'b', explanation: 'Lovable builds better apps when it knows who the app is for, what problem it solves, and what features matter.', order_index: 3 },
      { question: 'How do you connect Supabase to Lovable?', option_a: 'Write raw SQL migrations manually', option_b: 'Through Lovable\'s built-in Supabase integration panel', option_c: 'Via the command line', option_d: 'It is not possible', correct_option: 'b', explanation: 'Lovable has native Supabase integration — connect your project and auth/database is auto-configured.', order_index: 4 },
      { question: 'What is the main advantage of Bolt.new for non-developers?', option_a: 'It has the nicest UI', option_b: 'Zero setup — build and see results in the browser immediately', option_c: 'It is always 100% accurate', option_d: 'It never produces bugs', correct_option: 'b', explanation: 'No Node.js, no terminal, no git — Bolt.new removes all setup friction so you go from idea to running code instantly.', order_index: 5 },
      { question: 'When your Lovable app breaks after a change, you should?', option_a: 'Delete everything and start over', option_b: 'Use the undo feature and refine your prompt with specific error details', option_c: 'Manually edit the generated code', option_d: 'Ignore the error', correct_option: 'b', explanation: 'Lovable\'s undo reverts to the last working state — then describe the bug precisely so AI can fix it.', order_index: 6 },
      { question: '"Sync to GitHub" in Lovable lets you?', option_a: 'Auto-deploy to production', option_b: 'Download the code and continue editing locally in Cursor', option_c: 'Share the app publicly', option_d: 'Backup your account', correct_option: 'b', explanation: 'Sync to GitHub pushes Lovable-generated code to a repo — then open in Cursor for deeper customization.', order_index: 7 },
      { question: 'Bolt v2 improved on the original Bolt.new by?', option_a: 'Removing AI features', option_b: 'Better multi-file editing and full-stack generation capabilities', option_c: 'Making it paid only', option_d: 'Removing the browser interface', correct_option: 'b', explanation: 'Bolt v2 added dramatically improved code generation, better multi-file handling, and more reliable full-stack output.', order_index: 8 },
      { question: 'What is a key limitation of Lovable/Bolt for complex apps?', option_a: 'They cannot do any database operations', option_b: 'Context window limits and complex business logic may need manual coding', option_c: 'They only work for portfolio sites', option_d: 'They require a paid plan for basic features', correct_option: 'b', explanation: 'Large complex apps can exceed AI context limits — at that point, move to Cursor or Claude Code for deeper control.', order_index: 9 },
      { question: 'Which platform lets you deploy Lovable apps in one click?', option_a: 'Lovable\'s built-in deploy button', option_b: 'AWS manual setup only', option_c: 'Heroku only', option_d: 'Firebase only', correct_option: 'a', explanation: 'Lovable has a built-in deploy button that publishes your app to a Lovable subdomain instantly.', order_index: 10 },
      { question: 'When should you move from Lovable/Bolt to Cursor?', option_a: 'Never — stay in the browser forever', option_b: 'When you need complex logic, custom integrations, or larger codebase control', option_c: 'After the first 5 minutes', option_d: 'When AI stops working', correct_option: 'b', explanation: 'Browser builders are for speed — move to Cursor when you need deeper control over the code architecture.', order_index: 11 },
      { question: 'What type of app is Lovable best suited for?', option_a: 'Real-time trading systems', option_b: 'SaaS apps, dashboards, and marketplaces', option_c: 'Embedded hardware systems', option_d: 'Low-level OS drivers', correct_option: 'b', explanation: 'Lovable excels at CRUD-heavy web apps with auth, database, and standard UI patterns.', order_index: 12 },
      { question: 'Replit Agent differs from Lovable by?', option_a: 'No difference', option_b: 'Providing a full cloud coding environment with terminal access', option_c: 'Only supporting frontend code', option_d: 'Not having any AI features', correct_option: 'b', explanation: 'Replit Agent gives you a full cloud IDE with terminal — Lovable is more of an app generator with limited code access.', order_index: 13 },
      { question: 'What should you do after building with Lovable/Bolt?', option_a: 'Never look at the generated code', option_b: 'Immediately charge users without testing', option_c: 'Test all user flows, fix bugs, and connect production services', option_d: 'Delete the project', correct_option: 'c', explanation: 'AI-built apps need real user flow testing before launch — check auth, edge cases, and error states.', order_index: 14 },
      { question: 'Lovable vs Bolt.new — main difference?', option_a: 'They are identical tools', option_b: 'Lovable focuses on React + Supabase; Bolt supports more frameworks and has more IDE features', option_c: 'Bolt is always better', option_d: 'Lovable is faster', correct_option: 'b', explanation: 'Lovable is opinionated (React + Supabase). Bolt is more flexible with framework choices and has a fuller browser IDE.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'Detailed first prompts produce better apps — describe users, goals, and key features before anything',
        'Lovable\'s Supabase integration gives you auth + database in minutes — use it',
        'Bolt.new requires zero setup — the fastest path from idea to running code',
        'Sync to GitHub when you need to move to Cursor for deeper customization',
        'Test every user flow before deploying — AI builders produce real bugs on edge cases',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Open Lovable.dev and build a task management app from scratch. Use only prompts — no manual code editing. Connect Supabase for auth and tasks storage.', screenshot_hint: 'Your working task app with real auth and data persisting in Supabase.' },
        { type: 'screenshot', prompt: 'Open Bolt.new and build a landing page for a SaaS product in under 15 minutes. Deploy it when done. Share the live URL.', screenshot_hint: 'Your live Bolt.new landing page URL in the browser.' },
      ],
    },
  },
  {
    title: 'Deploy, Launch & Iterate',
    slug: 'deploy-launch-iterate',
    description: JSON.stringify({
      overview: 'Ship your AI-built app to production, set up monitoring, and establish a continuous improvement loop with real users.',
      objectives: [
        'Deploy a Next.js app to Vercel in under 5 minutes',
        'Configure environment variables for production',
        'Set up error monitoring for production issues',
        'Build a feedback loop that turns user input into product improvements',
      ],
      prerequisites: ['Completed Module 6'],
    }),
    order_index: 6,
    is_free: false,
    lessons: [
      { title: 'Build and Deploy a Full-Stack App in Under One Hour with AI', youtube_url: 'https://www.youtube.com/watch?v=wvOOisquWFw', youtube_video_id: 'wvOOisquWFw', order_index: 0, duration_minutes: 55, why_this_video: 'Complete end-to-end build + deploy in one session — shows the full workflow from zero to production URL.', skills_gained: ['Full build workflow', 'Vercel deploy', 'Production checklist'] },
      { title: 'How to Build & Deploy a FULL SaaS App Using AI', youtube_url: 'https://www.youtube.com/watch?v=AaHykKBRchg', youtube_video_id: 'AaHykKBRchg', order_index: 1, duration_minutes: 40, why_this_video: 'Shows Cursor + Claude building a monetizable SaaS and shipping it — perfect model for serious projects.', skills_gained: ['SaaS architecture', 'Payment integration', 'Production deploy'] },
      { title: 'Build → Deploy → Launch with AI (Full Tutorial)', youtube_url: 'https://www.youtube.com/watch?v=CFQKh47v6ug', youtube_video_id: 'CFQKh47v6ug', order_index: 2, duration_minutes: 35, why_this_video: 'The most complete coverage of the full ship workflow — deploy, launch marketing, collect feedback, and iterate.', skills_gained: ['Deploy workflow', 'Launch checklist', 'Iteration loop'] },
      { title: 'Build and Deploy a Full-Stack AI App (Completely Free)', youtube_url: 'https://www.youtube.com/watch?v=JiwTGGGIhDs', youtube_video_id: 'JiwTGGGIhDs', order_index: 3, duration_minutes: 30, why_this_video: 'Shows the zero-cost deployment path — free tier Vercel + Supabase + AI tools for indie hackers and learners.', skills_gained: ['Free deployment', 'Cost optimization', 'Indie stack'] },
    ],
    quizzes: [
      { question: 'Vercel is primarily used for?', option_a: 'Database hosting', option_b: 'Deploying frontend and full-stack Next.js apps', option_c: 'Storing files and media', option_d: 'Running background batch jobs', correct_option: 'b', explanation: 'Vercel is the de facto deployment platform for Next.js — instant deploys, preview URLs, and edge functions.', order_index: 1 },
      { question: 'What is a "production deployment"?', option_a: 'A test environment', option_b: 'The live version of your app that real users access', option_c: 'A database backup', option_d: 'A staging server', correct_option: 'b', explanation: 'Production is what users see — mistakes here have real consequences, unlike staging or preview deployments.', order_index: 2 },
      { question: 'Environment variables in deployment are used for?', option_a: 'Setting UI color themes', option_b: 'Storing secrets like API keys safely outside your code', option_c: 'Naming your functions', option_d: 'Styling code', correct_option: 'b', explanation: 'Never hardcode API keys — env vars keep them secure and let you use different values per environment.', order_index: 3 },
      { question: 'What should you do BEFORE deploying to production?', option_a: 'Skip all testing to ship fast', option_b: 'Test all key user flows in a staging or preview environment', option_c: 'Delete all old code', option_d: 'Disable all error logging', correct_option: 'b', explanation: 'Preview deployments on Vercel let you test exactly what production will look like before real users see it.', order_index: 4 },
      { question: 'What is a rollback?', option_a: 'A failed deployment', option_b: 'Reverting to a previous stable deployment version', option_c: 'A type of CSS animation', option_d: 'A database migration', correct_option: 'b', explanation: 'Vercel\'s instant rollback lets you undo a bad deploy in seconds — no data loss, immediate recovery.', order_index: 5 },
      { question: 'Error monitoring tools like Sentry help by?', option_a: 'Writing code automatically', option_b: 'Catching and alerting on production errors in real time', option_c: 'Deploying faster', option_d: 'Managing DNS records', correct_option: 'b', explanation: 'Sentry captures errors with full stack traces, user context, and frequency — you know about bugs before users report them.', order_index: 6 },
      { question: 'What does "cold start" mean in serverless?', option_a: 'Server has no internet connection', option_b: 'First request is slower because the function needs to initialize', option_c: 'The app crashed unexpectedly', option_d: 'Database is offline', correct_option: 'b', explanation: 'Cold starts happen when serverless functions spin up from zero — subsequent requests are fast once "warm".', order_index: 7 },
      { question: 'Vercel preview deployments are created when?', option_a: 'Manually triggered only', option_b: 'Automatically for every pull request', option_c: 'Once a week on a schedule', option_d: 'Only when pushing to main', correct_option: 'b', explanation: 'Every PR on Vercel gets its own preview URL — share it with teammates or stakeholders before merging.', order_index: 8 },
      { question: 'What should you monitor after launching?', option_a: 'Nothing — the AI handles it', option_b: 'Error rates, load times, and user behavior metrics', option_c: 'Only revenue numbers', option_d: 'Only signup counts', correct_option: 'b', explanation: 'Error rates tell you what\'s broken. Load times tell you about performance. User behavior tells you about UX.', order_index: 9 },
      { question: 'A/B testing in production lets you?', option_a: 'Test backend vs frontend', option_b: 'Show different versions to different user segments to compare performance', option_c: 'Debug errors faster', option_d: 'Manage team permissions', correct_option: 'b', explanation: 'A/B testing measures which version drives better outcomes — data-driven iteration vs guessing.', order_index: 10 },
      { question: 'Custom domains on Vercel require?', option_a: 'Vercel Pro plan', option_b: 'Adding DNS records (CNAME/A) at your domain registrar', option_c: 'Contacting Vercel support', option_d: 'A special config file', correct_option: 'b', explanation: 'Add your domain in Vercel settings, then update DNS at Namecheap/GoDaddy/Cloudflare — free on all plans.', order_index: 11 },
      { question: 'Continuous deployment (CD) means?', option_a: 'Manual deploys every week', option_b: 'Code changes automatically deploy after passing CI checks', option_c: 'Deploying on a fixed schedule', option_d: 'Developer manually pushes each release', correct_option: 'b', explanation: 'CD pipelines auto-deploy on every merge to main — faster releases, less human error in the deploy process.', order_index: 12 },
      { question: 'What is the "indie hacker" deployment stack for free?', option_a: 'AWS + RDS + Kubernetes', option_b: 'Vercel free tier + Supabase free tier + domain', option_c: 'Azure + CosmosDB', option_d: 'Heroku + MongoDB Atlas', correct_option: 'b', explanation: 'Vercel + Supabase free tiers cover most hobby/early-stage projects at zero cost — just pay for a domain.', order_index: 13 },
      { question: 'When should you iterate on your vibe-coded app?', option_a: 'Never after shipping', option_b: 'Continuously based on real user feedback and usage data', option_c: 'Only once a year', option_d: 'Only when AI suggests it', correct_option: 'b', explanation: 'Shipping is the beginning — real users reveal problems AI can\'t predict. Iterate based on what they actually do.', order_index: 14 },
      { question: 'What makes a successful AI-built product launch?', option_a: 'Perfect zero-bug code from AI', option_b: 'Solving a real problem + shipping fast + iterating on feedback', option_c: 'Using the most expensive AI tools', option_d: 'Waiting until the product is perfect', correct_option: 'b', explanation: 'Speed to market + real problem + feedback loop beats perfection every time — ship and learn.', order_index: 15 },
    ],
    recap: {
      key_takeaways: [
        'Deploy to Vercel by connecting your GitHub repo — auto-deploys on every push to main',
        'Never hardcode secrets — use Vercel environment variables for API keys and credentials',
        'Vercel preview deployments give you a real URL per PR — test before merging to production',
        'Add error monitoring (Sentry) before launch — catch bugs before users report them',
        'Ship imperfect, gather feedback, iterate — the vibe coding advantage is speed of improvement',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Deploy any project to Vercel: connect your GitHub repo, add environment variables, and get a live production URL. Time yourself — try to do it in under 5 minutes.', screenshot_hint: 'Your Vercel dashboard showing successful deployment + your live production URL in the browser.' },
        { type: 'screenshot', prompt: 'Set up Sentry (free tier) for error monitoring on your deployed app. Trigger a test error and verify it appears in your Sentry dashboard.', screenshot_hint: 'Sentry dashboard showing your captured error with stack trace and context.' },
      ],
    },
  },
]

// ─── COURSE CREATORS ─────────────────────────────────────────────────────────

const CREATORS = [
  { channel_name: 'Various Vibe Coding Creators', channel_url: 'https://www.youtube.com', video_count: 4 },
  { channel_name: 'Cursor AI Tutorials', channel_url: 'https://www.youtube.com/@cursor-tutorials', video_count: 4 },
  { channel_name: 'Claude Code Community', channel_url: 'https://www.youtube.com/@claude-code', video_count: 4 },
  { channel_name: 'Lovable & Bolt Builders', channel_url: 'https://www.youtube.com/@lovable-builders', video_count: 4 },
  { channel_name: 'Full Stack AI Deployers', channel_url: 'https://www.youtube.com/@fullstackai', video_count: 4 },
]

// ─── SEED FUNCTION ────────────────────────────────────────────────────────────

async function main() {
  console.log('🚀 Seeding Vibe Coding course...\n')

  // 1. Upsert course (courses.slug has no unique constraint — select then update-or-insert)
  const { data: existing } = await db.from('courses').select('id').eq('slug', COURSE.slug).maybeSingle()

  let course: { id: string }
  if (existing) {
    const { error: upErr } = await db.from('courses').update({
      path_id: COURSE.path_id, title: COURSE.title, description: COURSE.description,
      short_description: COURSE.short_description, level: COURSE.level,
      order_index: COURSE.order_index, is_hidden: COURSE.is_hidden,
      duration_hours: COURSE.duration_hours, skills_gained: COURSE.skills_gained,
      tags: COURSE.tags, flashcard_data: COURSE.flashcard_data,
    }).eq('id', existing.id)
    if (upErr) { console.error('❌ Course update failed:', upErr.message); process.exit(1) }
    course = existing
    console.log(`⚡ Course already exists — updated: ${COURSE.slug} (${course.id})`)
  } else {
    const { data: inserted, error: insErr } = await db.from('courses').insert({
      path_id: COURSE.path_id, title: COURSE.title, slug: COURSE.slug,
      description: COURSE.description, short_description: COURSE.short_description,
      level: COURSE.level, order_index: COURSE.order_index, is_hidden: COURSE.is_hidden,
      duration_hours: COURSE.duration_hours, skills_gained: COURSE.skills_gained,
      tags: COURSE.tags, flashcard_data: COURSE.flashcard_data,
    }).select('id').single()
    if (insErr) { console.error('❌ Course insert failed:', insErr.message); process.exit(1) }
    course = inserted!
  }
  console.log(`✅ Course: ${COURSE.title} (${course.id})`)

  // 2. Seed modules, lessons, quizzes, recaps
  for (const modData of MODULES) {
    // Upsert module
    const { data: mod, error: modErr } = await db
      .from('modules')
      .upsert({
        course_id: course.id,
        title: modData.title,
        slug: modData.slug,
        description: modData.description,
        order_index: modData.order_index,
        is_free: modData.is_free,
      }, { onConflict: 'course_id,slug' })
      .select('id')
      .single()

    if (modErr) { console.error(`❌ Module failed: ${modData.title}:`, modErr.message); continue }
    console.log(`  📦 Module ${modData.order_index + 1}: ${modData.title} (${mod.id})`)

    // Delete + re-insert lessons (no unique constraint on lessons)
    await db.from('lessons').delete().eq('module_id', mod.id)
    for (const lesson of modData.lessons) {
      const { error: lessonErr } = await db.from('lessons').insert({
        module_id: mod.id,
        title: lesson.title,
        youtube_url: lesson.youtube_url,
        youtube_video_id: lesson.youtube_video_id,
        order_index: lesson.order_index,
        duration_minutes: lesson.duration_minutes,
        why_this_video: lesson.why_this_video,
        skills_gained: lesson.skills_gained,
      })
      if (lessonErr) console.error(`    ❌ Lesson failed: ${lesson.title}:`, lessonErr.message)
      else console.log(`    🎬 Lesson: ${lesson.title}`)
    }

    // Delete + insert quizzes (fresh each run)
    await db.from('quizzes').delete().eq('module_id', mod.id)
    for (const q of modData.quizzes) {
      const { error: qErr } = await db.from('quizzes').insert({ module_id: mod.id, ...q })
      if (qErr) console.error(`    ❌ Quiz failed: ${q.question.slice(0, 40)}...`, qErr.message)
    }
    console.log(`    🧠 ${modData.quizzes.length} quiz questions seeded`)

    // Delete + re-insert module recap
    await db.from('module_recaps').delete().eq('module_id', mod.id)
    const { error: recapErr } = await db.from('module_recaps').insert({
      module_id: mod.id,
      key_takeaways: modData.recap.key_takeaways,
      exercises_jsonb: modData.recap.exercises_jsonb,
    })
    if (recapErr) console.error(`    ❌ Recap failed:`, recapErr.message)
    else console.log(`    📝 Module recap seeded`)

    // Insert module intro slides into intro_screens
    await db.from('intro_screens').delete().eq('scope', 'module').eq('scope_id', mod.id)
    const moduleSlides = [
      { slide_type: 'welcome', content_jsonb: { emoji: '🎯', moduleTitle: modData.title, outcome: modData.description ? JSON.parse(modData.description).objectives?.[0] ?? '' : '' } },
      { slide_type: 'lesson_list', content_jsonb: { lessons: modData.lessons.map(l => ({ title: l.title, duration_minutes: l.duration_minutes })) } },
      { slide_type: 'key_concepts', content_jsonb: { concepts: COURSE.flashcard_data.glossary.slice(0, 3).map(g => ({ term: g.term, definition: g.definition, emoji: g.emoji })) } },
      { slide_type: 'ready', content_jsonb: { cta: 'Start first video →', summary: `${modData.lessons.length} lessons · ~${modData.lessons.reduce((s, l) => s + (l.duration_minutes ?? 0), 0)} min` } },
    ]
    for (let i = 0; i < moduleSlides.length; i++) {
      await db.from('intro_screens').insert({ scope: 'module', scope_id: mod.id, order_index: i, ...moduleSlides[i] })
    }
    console.log(`    🖼  4 module intro slides seeded`)
  }

  // 3. Seed course creators
  await db.from('course_creators').delete().eq('course_id', course.id)
  for (const creator of CREATORS) {
    await db.from('course_creators').insert({ course_id: course.id, ...creator })
  }
  console.log(`\n  👥 ${CREATORS.length} creators seeded`)

  // 4. Seed course intro slides
  await db.from('intro_screens').delete().eq('scope', 'course').eq('scope_id', course.id)
  const courseSlides = [
    { slide_type: 'title_card', content_jsonb: COURSE.flashcard_data.titleCard },
    { slide_type: 'curation_story', content_jsonb: { why_we_built: 'We reviewed 200+ YouTube videos on AI coding tools, vibe coding, and deployment to curate only the highest-quality tutorials.', promise: 'Every video was chosen for clarity, depth, and practical applicability — no fluff, no filler.' } },
    { slide_type: 'how_it_works', content_jsonb: { steps: ['Watch curated expert videos', 'Complete module recap & exercises', 'Pass quiz with 67%+ to unlock next module', 'Earn your certificate on completion'] } },
    { slide_type: 'curriculum_map', content_jsonb: { modules: MODULES.map(m => ({ title: m.title, lesson_count: m.lessons.length, description: JSON.parse(m.description).overview })) } },
    { slide_type: 'creator_spotlight', content_jsonb: { creators: CREATORS } },
    { slide_type: 'key_terms', content_jsonb: { terms: COURSE.flashcard_data.glossary } },
    { slide_type: 'glossary_quiz', content_jsonb: { quiz: COURSE.flashcard_data.glossaryQuiz } },
    { slide_type: 'roadmap', content_jsonb: COURSE.flashcard_data.courseMap },
  ]
  for (let i = 0; i < courseSlides.length; i++) {
    await db.from('intro_screens').insert({ scope: 'course', scope_id: course.id, order_index: i, ...courseSlides[i] })
  }
  console.log(`  🖼  8 course intro slides seeded`)

  // 5. Summary
  const totalLessons = MODULES.reduce((s, m) => s + m.lessons.length, 0)
  const totalQuizzes = MODULES.reduce((s, m) => s + m.quizzes.length, 0)
  console.log(`
╔══════════════════════════════════════════════════╗
║       VIBE CODING COURSE — SEED COMPLETE         ║
╠══════════════════════════════════════════════════╣
║ Course ID:    ${course.id}  ║
║ Modules:      ${MODULES.length}                                      ║
║ Lessons:      ${totalLessons}                                     ║
║ Quiz Qs:      ${totalQuizzes} (${MODULES.length} × 15)                       ║
║ Recaps:       ${MODULES.length}                                      ║
║ Intro slides: ${courseSlides.length} course + ${MODULES.length * 4} module              ║
╠══════════════════════════════════════════════════╣
║ Next: Run migration then visit                   ║
║ /courses/vibe-coding-build-anything-with-ai      ║
╚══════════════════════════════════════════════════╝
  `)
}

main().catch(e => { console.error('Fatal:', e); process.exit(1) })
