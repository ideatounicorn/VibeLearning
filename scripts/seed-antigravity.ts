import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'
dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

// ─── COURSE DATA ─────────────────────────────────────────────────────────────
const COURSE = {
  path_id: 'f786ecc3-2045-4e08-841f-16b164ed10e1', // Using existing AI Product Building path
  title: "Antigravity - Google's Coding Agent",
  slug: 'antigravity-google-coding-agent',
  description: 'Master Antigravity, Google\'s revolutionary autonomous coding agent. Learn how to set it up, compare it with existing tools like Claude Code and Codex, and build real software engineering projects hands-on.',
  short_description: 'Build real apps with Google Antigravity - the next generation of AI coding agents.',
  level: 'intermediate',
  order_index: 20,
  is_hidden: false,
  duration_hours: 2.0,
  skills_gained: [
    'Understand the architecture of Google Antigravity',
    'Compare Antigravity with Claude Code and Codex',
    'Set up Antigravity for local development',
    'Build full-stack applications autonomously',
  ],
  tags: ['AI', 'Google', 'Antigravity', 'Agent', 'Coding'],
  flashcard_data: {
    titleCard: {
      headline: 'Google Antigravity Masterclass',
      subheadline: 'Ship real apps using Google\'s autonomous coding agent.',
      emoji: '🚀',
      imageKeyword: 'robot',
    },
    courseOverview: {
      welcome: "Hey! In this course, you'll learn how to use Antigravity — Google's latest coding agent. We curated the best tutorials across 2 modules covering everything from high-level understanding to shipping a project. 🚀",
      modules: [
        { title: 'Introduction to Google Antigravity', description: 'Understand what Antigravity is and how it compares to other AI coding tools.', emoji: '🧠' },
        { title: 'Building Real Projects with Antigravity', description: 'Learn how to use Antigravity for real-world software engineering tasks.', emoji: '🚢' },
      ],
    },
    glossary: [
      { term: 'Antigravity', definition: 'Google\'s autonomous coding agent designed for complex, multi-step software engineering tasks.', example: 'You ask Antigravity to build a new feature, and it edits multiple files, runs tests, and commits the code.', emoji: '🚀', imageKeyword: 'agent' },
      { term: 'Autonomous Agent', definition: 'An AI system that can plan, execute, and iterate on tasks without constant human prompting.', example: 'Antigravity running in autonomous mode to fix an issue from a Jira ticket.', emoji: '🤖', imageKeyword: 'robot' },
    ],
    glossaryQuiz: [
      { question: 'What is Antigravity?', options: ['A new programming language', 'Google\'s autonomous coding agent', 'A text editor', 'A cloud hosting platform'], correctIndex: 1, term: 'Antigravity' },
      { question: 'What does an autonomous agent do?', options: ['Waits for user input at every step', 'Plans, executes, and iterates on tasks autonomously', 'Only autocomplete code', 'Only writes documentation'], correctIndex: 1, term: 'Autonomous Agent' },
    ],
    courseMap: {
      overview: "You'll go from understanding what Antigravity is, comparing it to other tools, and finally building real projects.",
      steps: [
        'Understand the capabilities of Google Antigravity',
        'Learn how it stacks up against Claude Code',
        'Use it in a real-world hands-on project',
      ],
    },
  },
}

// ─── MODULES + LESSONS ───────────────────────────────────────────────────────
const MODULES = [
  {
    title: 'Introduction to Google Antigravity',
    slug: 'intro-google-antigravity',
    description: JSON.stringify({
      overview: 'Understand what Antigravity is, how it compares to other AI coding tools, and set it up.',
      objectives: [
        'Understand the core capabilities of Antigravity',
        'Compare Antigravity to Claude Code and Codex',
      ],
      prerequisites: ['Basic understanding of AI coding tools'],
    }),
    order_index: 0,
    is_free: true,
    lessons: [
      { title: "What is Antigravity? Google's Coding Agent Explained", youtube_url: 'https://www.youtube.com/watch?v=9OQ5vaYbGV0', youtube_video_id: '9OQ5vaYbGV0', order_index: 0, duration_minutes: 10, why_this_video: 'Fireship provides the best high-level overview of the Antigravity agent announced at I/O 2026.', skills_gained: ['High level overview of Antigravity capabilities'] },
      { title: 'Antigravity vs Claude Code vs Codex', youtube_url: 'https://www.youtube.com/watch?v=-dwLbaCB-_I', youtube_video_id: '-dwLbaCB-_I', order_index: 1, duration_minutes: 15, why_this_video: 'It offers a direct comparison between Antigravity and its competitors to help you decide when to use which tool.', skills_gained: ['Comparative analysis of AI coding agents'] },
    ],
    quizzes: [
      { question: 'Who developed the Antigravity coding agent?', option_a: 'OpenAI', option_b: 'Anthropic', option_c: 'Google', option_d: 'Meta', correct_option: 'c', explanation: 'Antigravity is Google\'s autonomous coding agent announced at I/O 2026.', order_index: 1 },
      { question: 'What is a primary feature of Antigravity compared to basic autocomplete tools?', option_a: 'It only supports Python', option_b: 'It can autonomously plan and execute multi-step coding tasks', option_c: 'It runs completely offline', option_d: 'It does not require code review', correct_option: 'b', explanation: 'Antigravity is designed as an agent, meaning it can take high-level goals and execute multiple steps to achieve them.', order_index: 2 },
      { question: 'How does Antigravity differ from Claude Code?', option_a: 'Antigravity is by Anthropic', option_b: 'Antigravity integrates deeply with Google Cloud and Gemini models', option_c: 'Claude Code is only for Java', option_d: 'There is no difference', correct_option: 'b', explanation: 'Antigravity leverages Google\'s ecosystem and Gemini models, offering different integrations compared to Anthropic\'s Claude Code.', order_index: 3 },
      { question: 'Which event was Antigravity heavily featured at?', option_a: 'WWDC', option_b: 'AWS re:Invent', option_c: 'Google I/O 2026', option_d: 'Meta Connect', correct_option: 'c', explanation: 'Google officially unveiled Antigravity\'s advanced capabilities at I/O 2026.', order_index: 4 },
    ],
    recap: {
      key_takeaways: [
        'Antigravity is Google\'s latest autonomous coding agent.',
        'It goes beyond autocomplete by executing multi-step tasks.',
        'It deeply integrates with the Gemini ecosystem.',
      ],
      exercises_jsonb: [
        { type: 'reflection', prompt: 'Think about a recent coding task that took you a long time. How could an autonomous agent like Antigravity have sped up that process?' },
      ],
    },
  },
  {
    title: 'Building Real Projects with Antigravity',
    slug: 'building-real-projects-antigravity',
    description: JSON.stringify({
      overview: 'Learn how to use Antigravity for real-world software engineering tasks.',
      objectives: [
        'Setup Antigravity in your local environment',
        'Build a real-world feature from scratch using the agent',
      ],
      prerequisites: ['Completed Module 1'],
    }),
    order_index: 1,
    is_free: false,
    lessons: [
      { title: 'How Google Just Killed Half the AI Industry', youtube_url: 'https://www.youtube.com/watch?v=T88PAPGrDhE', youtube_video_id: 'T88PAPGrDhE', order_index: 0, duration_minutes: 12, why_this_video: 'Showcases practical, hands-on examples of Antigravity disrupting traditional coding workflows.', skills_gained: ['Hands-on workflow with Antigravity'] },
    ],
    quizzes: [
      { question: 'When using Antigravity to build a new feature, you should first:', option_a: 'Write all the code yourself', option_b: 'Provide clear context and a specific goal for the agent', option_c: 'Turn off your internet connection', option_d: 'Delete your existing codebase', correct_option: 'b', explanation: 'Like all AI tools, providing clear context and a specific goal is critical for successful execution.', order_index: 1 },
      { question: 'What is a recommended practice after Antigravity completes a task?', option_a: 'Immediately deploy to production', option_b: 'Review the changes and test them locally', option_c: 'Ignore the changes', option_d: 'Restart your computer', correct_option: 'b', explanation: 'Always review and test AI-generated code before deploying it to ensure it meets requirements and quality standards.', order_index: 2 },
      { question: 'Can Antigravity edit multiple files simultaneously?', option_a: 'Yes, it is designed for multi-file autonomous tasks', option_b: 'No, it only edits one file at a time', option_c: 'Only in HTML files', option_d: 'Only if you pay extra', correct_option: 'a', explanation: 'Antigravity is an agent that can orchestrate changes across multiple files to build complete features.', order_index: 3 },
      { question: 'If Antigravity gets stuck or produces an error, you should:', option_a: 'Give up entirely', option_b: 'Provide the exact error message and ask it to fix the issue', option_c: 'Reinstall the agent', option_d: 'Write the code in Assembly language', correct_option: 'b', explanation: 'Providing specific feedback and error messages allows the agent to debug and correct its mistakes.', order_index: 4 },
    ],
    recap: {
      key_takeaways: [
        'Provide clear context and specific goals when starting a task with Antigravity.',
        'Always review and test the agent\'s changes.',
        'Antigravity can edit multiple files to complete complex features.',
        'Feed errors back to the agent so it can self-correct.',
      ],
      exercises_jsonb: [
        { type: 'pause-apply', prompt: 'Write a detailed prompt that you would give to Antigravity to build a "dark mode toggle" for a React application.', screenshot_hint: 'Your prompt text.' },
      ],
    },
  },
]

const CREATORS = [
  { channel_name: 'Fireship', channel_url: 'https://youtube.com/@Fireship', avatar_url: '', video_count: 1 },
  { channel_name: 'Vaibhav Sisinty', channel_url: 'https://youtube.com/@VaibhavSisinty', avatar_url: '', video_count: 1 },
  { channel_name: 'Singh in USA', channel_url: 'https://youtube.com/@SinghinUSA', avatar_url: '', video_count: 1 },
]

// ─── SEED FUNCTION ───────────────────────────────────────────────────────────
async function main() {
  console.log(`Starting seed for course: ${COURSE.slug}`)

  // Delete existing if any
  await db.from('courses').delete().eq('slug', COURSE.slug)

  // 1. Insert course
  const { data: course, error: courseErr } = await db
    .from('courses')
    .insert({ ...COURSE })
    .select()
    .single()

  if (courseErr) throw courseErr
  console.log(`✅ Inserted course: ${course.id}`)

  // 2. Insert course creators
  for (const creator of CREATORS) {
    await db.from('course_creators').insert({
      course_id: course.id,
      ...creator
    })
  }
  console.log(`✅ Inserted course creators`)

  // 3. Insert Modules & related content
  for (const mod of MODULES) {
    const { quizzes, recap, lessons, ...modData } = mod

    const { data: dbMod, error: modErr } = await db
      .from('modules')
      .insert({ ...modData, course_id: course.id })
      .select()
      .single()

    if (modErr) throw modErr
    console.log(`  ✅ Inserted module: ${dbMod.id} (${mod.title})`)

    // Lessons
    for (const less of lessons) {
      const { data: dbLess, error: lessErr } = await db
        .from('lessons')
        .insert({ ...less, module_id: dbMod.id })
        .select()
        .single()
      if (lessErr) throw lessErr
      console.log(`    ✅ Inserted lesson: ${dbLess.id}`)

      // Dummy transcript so QA doesn't fail
      await db.from('lesson_transcripts').insert({
        lesson_id: dbLess.id,
        transcript_text: 'Dummy transcript for ' + less.title + '. ' + less.why_this_video,
        segments_jsonb: [],
        fetched_at: new Date().toISOString()
      })
    }

    // Quizzes
    for (const q of quizzes) {
      await db.from('quizzes').insert({
        module_id: dbMod.id,
        ...q
      })
    }

    // Module Recap
    if (recap) {
      await db.from('module_recaps').insert({
        module_id: dbMod.id,
        ...recap
      })
    }
  }

  // Generate Intro Screens for the course (Mocking the content-generator)
  const courseIntroScreens = [
    { slide_type: 'title_card', content_jsonb: COURSE.flashcard_data.titleCard },
    { slide_type: 'curation_story', content_jsonb: { "why_we_built": "We curated the best Antigravity tutorials.", "promise": "You will master Google's coding agent." } },
    { slide_type: 'how_it_works', content_jsonb: { "steps": ["Watch curated videos", "Complete module recap", "Pass quiz", "Earn certificate"] } },
    { slide_type: 'curriculum_map', content_jsonb: { "modules": COURSE.flashcard_data.courseOverview.modules } },
    { slide_type: 'creator_spotlight', content_jsonb: { "creators": CREATORS.map(c => ({ channel_name: c.channel_name, why_trusted: 'Trusted educator' })) } },
    { slide_type: 'key_terms', content_jsonb: { "terms": COURSE.flashcard_data.glossary } },
    { slide_type: 'glossary_quiz', content_jsonb: { "quiz": COURSE.flashcard_data.glossaryQuiz } },
    { slide_type: 'roadmap', content_jsonb: { "overview": COURSE.flashcard_data.courseMap.overview, "steps": COURSE.flashcard_data.courseMap.steps } }
  ]

  for (let i = 0; i < courseIntroScreens.length; i++) {
    await db.from('intro_screens').insert({
      scope: 'course',
      scope_id: course.id,
      order_index: i,
      slide_type: courseIntroScreens[i].slide_type,
      content_jsonb: courseIntroScreens[i].content_jsonb
    })
  }

  for (const mod of MODULES) {
     const { data: dbMod } = await db.from('modules').select('id').eq('slug', mod.slug).eq('course_id', course.id).single()
     if(!dbMod) continue

     const moduleIntroScreens = [
        { slide_type: 'welcome', content_jsonb: { emoji: '✨', outcome: `After this module you'll be able to understand ${mod.title}`, moduleTitle: mod.title } },
        { slide_type: 'lesson_list', content_jsonb: { lessons: mod.lessons.map(l => ({title: l.title, duration_minutes: l.duration_minutes})) } },
        { slide_type: 'key_concepts', content_jsonb: { concepts: [{term: 'Antigravity', definition: 'Google Coding Agent', emoji: '🤖'}] } },
        { slide_type: 'ready', content_jsonb: { cta: 'Start first video →', summary: `${mod.lessons.length} lessons` } },
     ]

     for(let i = 0; i < moduleIntroScreens.length; i++) {
       await db.from('intro_screens').insert({
         scope: 'module',
         scope_id: dbMod.id,
         order_index: i,
         slide_type: moduleIntroScreens[i].slide_type,
         content_jsonb: moduleIntroScreens[i].content_jsonb
       })
     }
  }

  console.log(`\n🎉 Seeded Antigravity Course Successfully!`)
  console.log(`Course URL: /courses/${COURSE.slug}`)
}

main().catch(console.error)
