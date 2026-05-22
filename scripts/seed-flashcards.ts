import { createClient } from '@supabase/supabase-js'
import { GoogleGenerativeAI } from '@google/generative-ai'
import * as dotenv from 'dotenv'

// Ensure local env vars are loaded
dotenv.config({ path: '.env.local' })

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
)
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY!)

function generateMockIntroData(course: {
  title: string
  description: string | null
  modules: Array<{ title: string; order_index: number; lessons: Array<{ title: string }> }>
}) {
  const title = course.title;
  const description = course.description ?? `Learn the fundamentals of ${title} and build professional projects.`;
  const modules = course.modules.map(m => ({
    title: m.title,
    description: `Master key concepts and build skills in ${m.title}.`,
    emoji: '💡'
  }));

  // Create customized glossary based on course name keywords
  let glossary = [
    { term: 'Module', definition: 'A structured chapter containing related lessons and a concept quiz.', example: 'Each module is followed by an assessment.', emoji: '📖', imageKeyword: 'code' },
    { term: 'Syllabus', definition: 'The structured outline of topics covered in the course.', example: 'Review the syllabus to understand the roadmap.', emoji: '🗺️', imageKeyword: 'design' },
    { term: 'XP (Experience Points)', definition: 'Rewards earned for completing lessons and passing quizzes.', example: 'Earn 10 XP for each lesson completed.', emoji: '⭐', imageKeyword: 'analytics' },
    { term: 'Certificate', definition: 'A credential awarded upon completing the entire course.', example: 'Share your certificate on LinkedIn.', emoji: '🏆', imageKeyword: 'design' },
    { term: 'Quiz', definition: 'A brief assessment at the end of each module to test your knowledge.', example: 'Unlock the next module by passing the quiz.', emoji: '🧠', imageKeyword: 'server' }
  ];

  const titleLower = title.toLowerCase();
  if (titleLower.includes('figma') || titleLower.includes('design') || titleLower.includes('art') || titleLower.includes('photo') || titleLower.includes('brand')) {
    glossary = [
      { term: 'Figma', definition: 'A collaborative web-based design tool for vector graphics and UI/UX design.', example: 'Creating responsive wireframes in Figma.', emoji: '🎨', imageKeyword: 'design' },
      { term: 'UI (User Interface)', definition: 'The visual elements of a product that users interact with.', example: 'Designing clean buttons, input fields, and layouts.', emoji: '📱', imageKeyword: 'design' },
      { term: 'UX (User Experience)', definition: 'The overall feel and usability of a digital product.', example: 'Conducting user research to improve usability.', emoji: '👥', imageKeyword: 'product' },
      { term: 'Prototype', definition: 'An interactive model of a design used for user testing.', example: 'Linking screens in Figma to show clickthrough flows.', emoji: '⚡', imageKeyword: 'code' },
      { term: 'Branding', definition: 'The marketing practice of creating a name, symbol or design that identifies and differentiates a product.', example: 'Establishing a cohesive color palette and logo for the app.', emoji: '🏷️', imageKeyword: 'design' }
    ];
  } else if (titleLower.includes('python') || titleLower.includes('coding') || titleLower.includes('sql') || titleLower.includes('mcp') || titleLower.includes('database')) {
    glossary = [
      { term: 'Variable', definition: 'A named container used to store data values in code.', example: 'Setting x = 10 to store an integer in Python.', emoji: '📦', imageKeyword: 'code' },
      { term: 'Function', definition: 'A reusable block of code that performs a specific task.', example: 'Defining print_welcome() to output a welcome message.', emoji: '⚙️', imageKeyword: 'code' },
      { term: 'Database', definition: 'An organized collection of data stored and accessed electronically.', example: 'Storing user profiles in a PostgreSQL database.', emoji: '🗄️', imageKeyword: 'database' },
      { term: 'API', definition: 'A set of rules allowing different software applications to communicate.', example: 'Fetching weather data from an external API.', emoji: '🔌', imageKeyword: 'api' },
      { term: 'Terminal', definition: 'A text-based interface used to run commands and execute scripts.', example: 'Running python script.py inside the terminal.', emoji: '💻', imageKeyword: 'terminal' }
    ];
  } else if (titleLower.includes('marketing') || titleLower.includes('ads') || titleLower.includes('seo') || titleLower.includes('growth')) {
    glossary = [
      { term: 'SEO', definition: 'Search Engine Optimization: the process of improving site visibility in search engines.', example: 'Using keywords to rank on the first page of Google.', emoji: '🔍', imageKeyword: 'analytics' },
      { term: 'CPC', definition: 'Cost Per Click: the amount you pay for each click on your advertisement.', example: 'Optimizing meta ads to lower the average CPC to $0.40.', emoji: '💵', imageKeyword: 'marketing' },
      { term: 'Funnel', definition: 'The visual representation of a customer journey from awareness to purchase.', example: 'Tracking signup drop-offs in the acquisition funnel.', emoji: '⏳', imageKeyword: 'product' },
      { term: 'Conversion', definition: 'When a visitor completes a desired goal, such as signing up or buying.', example: 'A landing page converting 15% of visitors into leads.', emoji: '📈', imageKeyword: 'analytics' },
      { term: 'Keywords', definition: 'Words or phrases searchers enter into search engines.', example: 'Targeting "best coding course" to attract organic traffic.', emoji: '🔑', imageKeyword: 'marketing' }
    ];
  }

  const glossaryQuiz = glossary.slice(0, 4).map((g) => {
    const wrongAnswers = [
      `A generic tool unrelated to ${title}.`,
      `A type of social media account.`,
      `An outdated term that is no longer used.`
    ];
    const options = [g.definition, ...wrongAnswers];
    // Simple shuffle
    const shuffled = [...options].sort(() => Math.random() - 0.5);
    const correctIndex = shuffled.indexOf(g.definition);
    return {
      question: `What is the primary definition of "${g.term}"?`,
      options: shuffled,
      correctIndex: correctIndex,
      term: g.term
    };
  });

  return {
    titleCard: {
      headline: `Master ${title}`,
      subheadline: description.split('.')[0] + '.',
      emoji: titleLower.includes('figma') ? '🎨' : titleLower.includes('python') ? '🐍' : '🚀',
      imageKeyword: titleLower.includes('figma') || titleLower.includes('design') ? 'design' : 'code'
    },
    courseOverview: {
      welcome: `Hey! In this course, you will learn how to master ${title}. We have divided this into ${modules.length} key modules to build your path to job-ready skillsets. 🚀`,
      modules: modules
    },
    glossary: glossary,
    glossaryQuiz: glossaryQuiz,
    courseMap: {
      overview: `You'll go through curated video lessons, test your knowledge with vocabulary checks, and prove your skills with quizzes.`,
      steps: [
        'Watch expert-curated video lessons',
        'Learn key terms & concepts',
        'Pass quizzes with 67% or more',
        'Earn and share your certificate'
      ]
    }
  };
}

async function generateFlashcards(course: {
  id: string
  title: string
  description: string | null
  skills_gained: string[] | null
  modules: Array<{ title: string; order_index: number; lessons: Array<{ title: string }> }>
}) {
  const moduleList = course.modules.map(m => ({
    title: m.title,
    lessons: m.lessons.map(l => l.title),
  }))

  const prompt = `You are a learning designer for VibeLearn, an online education platform.

Generate a course intro and orientation experience for: "${course.title}"

Course description: ${course.description ?? 'N/A'}
Skills to gain: ${(course.skills_gained ?? []).join(', ')}
Modules in this course: ${moduleList.map(m => `${m.title} (${m.lessons.slice(0, 3).join(', ')}${m.lessons.length > 3 ? '...' : ''})`).join(' | ')}

Return a JSON object with EXACTLY this structure:
{
  "titleCard": {
    "headline": "string (punchy, high-impact 1-line course headline, max 8 words)",
    "subheadline": "string (what learner will be able to DO after this course, max 15 words)",
    "emoji": "string (single relevant course emoji)",
    "imageKeyword": "string (an Unsplash search keyword like 'terminal', 'github', 'cloud', 'database', 'design', 'code' or general tech term for the hero image)"
  },
  "courseOverview": {
    "welcome": "string (warm, emoji-rich welcoming text, e.g. 'Hey! In this course, you will be learning how to master [Skills]. We have divided this into [Count] key modules to build your path to job-ready skillsets.')",
    "modules": [
      {
        "title": "string (exact title of the module)",
        "description": "string (clear, simple summary of what they learn in this module, max 12 words)",
        "emoji": "string (single relevant emoji for this module)"
      }
    ]
  },
  "glossary": [
    {
      "term": "string (the concept name, e.g. 'Terminal', 'Repository', 'API')",
      "definition": "string (friendly, simple definition, 1-2 sentences)",
      "example": "string (practical real-world example, 1 sentence)",
      "emoji": "string (single relevant emoji for this term)",
      "imageKeyword": "string (an Unsplash search keyword like 'terminal', 'github', 'code', 'data', 'design', 'server', 'analytics' to represent the concept)"
    }
  ],
  "glossaryQuiz": [
    {
      "question": "string (a quiz question testing one of the glossary terms)",
      "options": ["string", "string", "string", "string"],
      "correctIndex": number (0-3),
      "term": "string (which glossary term this tests)"
    }
  ],
  "courseMap": {
    "overview": "string (2-3 sentence description of the path forward through lessons and quizzes)",
    "steps": ["string (exactly 4 steps)"]
  }
}

Rules:
- courseOverview.modules: MUST match the modules list provided above in order.
- glossary: exactly 5 terms, core concepts/vocabulary the learner MUST know before starting.
- glossaryQuiz: exactly 4 questions testing the glossary terms.
- courseMap.steps: exactly 4 steps.
- Make the welcome text, definitions, and examples highly readable, engaging, and rich with emojis.
- Return ONLY the JSON, no markdown code block, no explanation.`

  const model = genAI.getGenerativeModel({ model: 'gemini-1.5-flash' })
  const result = await model.generateContent(prompt)
  const text = result.response.text().trim()
  const cleaned = text.replace(/^```json?\n?/, '').replace(/\n?```$/, '').trim()
  return JSON.parse(cleaned)
}

async function main() {
  const { data: courses, error } = await db
    .from('courses')
    .select('id, title, description, skills_gained, flashcard_data, modules(title, order_index, lessons(title))')
    .eq('is_hidden', false)
    .order('title')

  if (error) { console.error('Failed to fetch courses:', error.message); process.exit(1) }

  console.log(`Found ${courses.length} courses`)

  const isKeyPlaceholder = !process.env.GEMINI_API_KEY || process.env.GEMINI_API_KEY === 'your_gemini_api_key'

  for (const course of courses) {
    const hasNewFormat = course.flashcard_data && typeof course.flashcard_data === 'object' && 'courseOverview' in course.flashcard_data

    if (hasNewFormat) {
      console.log(`  SKIP ${course.title} (already has new orientation format)`)
      continue
    }

    try {
      const sortedModules = ((course.modules as any[]) ?? []).sort((a, b) => a.order_index - b.order_index)

      let data: any
      if (isKeyPlaceholder) {
        console.log(`  MOCK  ${course.title} (using high-quality local generator)...`)
        data = generateMockIntroData({
          title: course.title,
          description: course.description,
          modules: sortedModules
        })
      } else {
        console.log(`  GEN  ${course.title}...`)
        data = await generateFlashcards({
          ...course,
          modules: sortedModules,
        })
      }

      const { error: updateError } = await db
        .from('courses')
        .update({ flashcard_data: data })
        .eq('id', course.id)

      if (updateError) throw new Error(updateError.message)
      console.log(`  OK   ${course.title}`)

      if (!isKeyPlaceholder) {
        // Rate limit to stay well under Gemini free tier limits
        await new Promise(r => setTimeout(r, 1500))
      }
    } catch (err) {
      console.error(`  FAIL ${course.title}:`, err)
    }
  }

  console.log('Done.')
}

main()
