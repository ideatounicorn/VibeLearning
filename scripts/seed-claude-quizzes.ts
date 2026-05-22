import * as path from 'path'
import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'

// Load environment variables
dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('❌ Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env.local')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
})

const QUIZ_DATA: Record<string, Array<{
  question: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_option: 'a' | 'b' | 'c' | 'd'
  explanation: string
}>> = {
  "What Is Claude & Why It Matters": [
    {
      question: "What is a key differentiator of Anthropic's Claude models compared to many other LLMs?",
      option_a: "It has a very large context window and strong reasoning, coding, and formatting capabilities.",
      option_b: "It can only run on local machines and cannot use internet APIs.",
      option_c: "It uses image generation as its primary model architecture.",
      option_d: "It does not support prompt engineering.",
      correct_option: "a",
      explanation: "Claude is renowned for its industry-leading context window, formatting capabilities (like XML tag structure), and strong performance in complex coding/reasoning."
    },
    {
      question: "In the context of modern AI, what does 'Agentic AI' refer to?",
      option_a: "AI that generates simple voice responses.",
      option_b: "AI that acts autonomously to execute multi-step tasks, run tools, and make decisions.",
      option_c: "A chat system that only answers pre-scripted customer support questions.",
      option_d: "Any artificial intelligence algorithm created before 2020.",
      correct_option: "b",
      explanation: "Agentic AI involves AI systems designed to act as agents: using tools, planning, and executing complex workflows autonomously."
    },
    {
      question: "Why is Claude considered highly secure for enterprise use?",
      option_a: "It doesn't allow copy-pasting of chat text.",
      option_b: "Anthropic designs Claude with strong data privacy standards, and enterprise tier data isn't trained on by default.",
      option_c: "It only works when disconnected from the internet.",
      option_d: "It encrypts files using physical USB keys.",
      correct_option: "b",
      explanation: "Anthropic prioritizes alignment and safety, ensuring enterprise customer data is not used for model training."
    }
  ],
  "The Claude Interface & Core Features": [
    {
      question: "What is the main purpose of the web interface in Claude.ai?",
      option_a: "To edit video files directly in the browser.",
      option_b: "To prompt Claude, manage chat history, and utilize features like Artifacts and Projects.",
      option_c: "To purchase physical computer hardware from Anthropic.",
      option_d: "To host standard static websites for free.",
      correct_option: "b",
      explanation: "The Claude.ai web UI provides a clean user portal to run chats, upload documents, view Artifacts, and manage Projects."
    },
    {
      question: "How can you share or refer back to a previous conversation in Claude.ai?",
      option_a: "All conversations are saved in the sidebar menu and can be retrieved, renamed, or deleted.",
      option_b: "Conversations are automatically deleted as soon as you close the tab.",
      option_c: "You must download each chat as an MP3 audio file.",
      option_d: "Chats can only be recovered by contacting customer support.",
      correct_option: "a",
      explanation: "Claude.ai automatically saves your chat history in the sidebar, allowing you to access and continue them at any time."
    },
    {
      question: "What is the maximum size or limit for text input in a single chat box often referred to as?",
      option_a: "Core processor speed.",
      option_b: "Pixel density.",
      option_c: "Context window.",
      option_d: "Database schema.",
      correct_option: "c",
      explanation: "The context window represents the total capacity of text (tokens) Claude can process and remember in a single session."
    }
  ],
  "Prompt Engineering for Claude": [
    {
      question: "Why does Anthropic recommend using XML tags (e.g. <instructions>, <data>) in Claude prompts?",
      option_a: "They are required to compile the prompt into raw C++ code.",
      option_b: "They help Claude distinguish instructions, examples, and inputs clearly, improving instruction compliance.",
      option_c: "XML tags are the only way to make Claude generate images.",
      option_d: "They automatically translate the prompt into multiple languages.",
      correct_option: "b",
      explanation: "XML tags provide a clear semantic structure, helping Claude parse different segments of a prompt (such as data vs instructions) effectively."
    },
    {
      question: "What is the best practice for providing examples to Claude in a prompt (few-shot prompting)?",
      option_a: "Placing examples at the very end of the chat history.",
      option_b: "Wrapping examples inside custom XML tags like <examples> in your prompt.",
      option_c: "Copying and pasting examples in a separate browser tab.",
      option_d: "Few-shot prompting is not supported by Claude.",
      correct_option: "b",
      explanation: "Providing concrete examples inside XML tags helps Claude understand the desired output format and style."
    },
    {
      question: "How should you structure a prompt if you want Claude to think carefully before answering?",
      option_a: "Tell Claude to write out its step-by-step thinking or scratchpad before writing the final answer.",
      option_b: "Use all uppercase letters to make the prompt look urgent.",
      option_c: "Ask the same question five times in a row.",
      option_d: "Anthropic models do not support step-by-step reasoning.",
      correct_option: "a",
      explanation: "Prompting Claude to think first or use a <scratchpad> gives the model computational space to analyze the problem before generating the final solution."
    }
  ],
  "Claude Artifacts": [
    {
      question: "What triggers Claude to generate an Artifact?",
      option_a: "When you upload an image of a person.",
      option_b: "When Claude generates standalone content (like code, SVGs, or complete markdown docs) that you would edit or reuse outside the chat.",
      option_c: "When you ask a simple yes/no question.",
      option_d: "When you log out of the Claude.ai website.",
      correct_option: "b",
      explanation: "Artifacts are triggered for separate, standalone content that is meant to be viewed, modified, or run alongside the conversation."
    },
    {
      question: "Where does the Artifact panel appear in the Claude.ai user interface?",
      option_a: "In a pop-up modal that covers the entire screen.",
      option_b: "On the right side of the chat window, next to your conversation.",
      option_c: "Underneath the user settings profile picture.",
      option_d: "Inside the browser developer tools console.",
      correct_option: "b",
      explanation: "The Artifacts panel opens side-by-side on the right, keeping your conversation clean on the left."
    },
    {
      question: "Can you view or run code directly in the Artifacts window?",
      option_a: "No, it only shows the raw text representation of code.",
      option_b: "Yes, Claude can render interactive previews of HTML, CSS, React, and SVG content directly in the Artifacts tab.",
      option_c: "Yes, but only if you install a third-party browser extension first.",
      option_d: "Artifacts only support image files.",
      correct_option: "b",
      explanation: "Claude can render live, interactive previews of front-end code (HTML/JS/React) and vector SVGs right inside the Artifacts view."
    }
  ],
  "Claude Projects": [
    {
      question: "How do Claude Projects help teams collaborate?",
      option_a: "They allow real-world voice calls between team members.",
      option_b: "Users can share a project workspace with a unified context, uploaded files, and custom system instructions.",
      option_c: "They automatically publish code to public GitHub repositories.",
      option_d: "They manage project billing and payroll.",
      correct_option: "b",
      explanation: "Claude Projects allow team members to collaborate in workspaces preloaded with reference documents and custom system prompts."
    },
    {
      question: "What are 'Custom Instructions' in the context of a Claude Project?",
      option_a: "A manual of how to use a keyboard.",
      option_b: "A project-specific system prompt that dictates Claude's tone, style, and rules for all chats in that project.",
      option_c: "Code snippets used to run bash scripts.",
      option_d: "Support tickets submitted to Anthropic's developers.",
      correct_option: "b",
      explanation: "Custom instructions act as the system prompt for that project, instructing Claude on how to respond across all conversations inside it."
    },
    {
      question: "What kind of files can you upload to a Claude Project to build its knowledge base?",
      option_a: "PDF docs, text files, and source code files.",
      option_b: "High-definition raw video files and database backup files.",
      option_c: "Exe installers and zip files.",
      option_d: "You cannot upload files to Claude Projects.",
      correct_option: "a",
      explanation: "Projects support files like code files, text, PDFs, and documentation to serve as reference context for chats."
    }
  ],
  "Claude Skills & Connectors": [
    {
      question: "What is a \"Skill\" or custom capability in the Claude ecosystem?",
      option_a: "A keyboard shortcut configuration.",
      option_b: "A customized tool or instruction set that enables Claude to perform specific integrations or interactive tasks.",
      option_c: "A typing speed test built into Claude.ai.",
      option_d: "A gamified score ranking for users.",
      correct_option: "b",
      explanation: "Skills are modular extensions of Claude's capabilities, allowing it to perform customized operations or integrate with external interfaces."
    },
    {
      question: "In the context of Claude Connectors, what does \"connecting to tools\" mean?",
      option_a: "Plugs Claude directly into physical electrical outlets.",
      option_b: "Allows Claude to execute APIs, fetch external data, or call software tools to solve a user's prompt.",
      option_c: "Merging multiple Claude.ai accounts into one.",
      option_d: "Copy-pasting text between different browser windows.",
      correct_option: "b",
      explanation: "Connectors link Claude to external tools, databases, or APIs, allowing it to run actions dynamically as part of its reasoning loop."
    },
    {
      question: "Why are connectors critical for modern developer workflows with AI?",
      option_a: "They remove the need for writing code.",
      option_b: "They bridge the gap between static LLM knowledge and real-time/local software environments and databases.",
      option_c: "They speed up the computer's CPU.",
      option_d: "They translate spoken commands into code automatically.",
      correct_option: "b",
      explanation: "Connectors allow Claude to access live, external data and execute operations, rather than relying solely on static training data."
    }
  ],
  "Claude CoWork": [
    {
      question: "What is the core philosophy of 'Claude CoWork'?",
      option_a: "Using Claude as a replacement for human managers.",
      option_b: "Using Claude as an interactive, real-time collaborator and co-developer on daily tasks.",
      option_c: "Working in the same physical office as Anthropic employees.",
      option_d: "Sharing login details with other users.",
      correct_option: "b",
      explanation: "CoWork focuses on leveraging Claude as a direct partner in brainstorming, coding, and problem-solving."
    },
    {
      question: "How does the Claude Desktop App enhance the CoWork workflow?",
      option_a: "It runs without using any memory or CPU.",
      option_b: "It integrates with your local operating system and can use tools like screenshotting and filesystem access.",
      option_c: "It bypasses the need for an internet connection.",
      option_d: "It replaces your operating system kernel.",
      correct_option: "b",
      explanation: "The Claude Desktop App provides a native OS integration, allowing features like system tool access and easy multitasking."
    },
    {
      question: "What is a primary benefit of using Claude for pair programming in CoWork?",
      option_a: "Claude writes all tests, so you never have to compile.",
      option_b: "It acts as an instant code reviewer, brainstorming partner, and bug debugger alongside you.",
      option_c: "It guarantees that code will never have logic errors.",
      option_d: "It uploads your code to cloud servers without your consent.",
      correct_option: "b",
      explanation: "Pairing with Claude allows you to bounce ideas off the model, get code suggestions, and resolve errors interactively."
    }
  ],
  "Extended Thinking & Research Mode": [
    {
      question: "What is Claude's 'Extended Thinking' feature?",
      option_a: "A mode that increases the font size of Claude's response.",
      option_b: "A capability where Claude outputs its internal reasoning trace before delivering the final response to handle complex math, coding, or logic.",
      option_c: "A timer that pauses the screen for 5 minutes.",
      option_d: "A feature that requires user input at every step.",
      correct_option: "b",
      explanation: "Extended Thinking exposes the step-by-step thinking process of the model, allowing it to perform deeper analysis on challenging reasoning tasks."
    },
    {
      question: "When should you activate Research Mode in Claude.ai?",
      option_a: "For simple definitions or basic calculations.",
      option_b: "For complex queries requiring deep web-search compilation, cross-referencing sources, and comprehensive reports.",
      option_c: "When you want to translate a single word into French.",
      option_d: "Research Mode is only for writing poetry.",
      correct_option: "b",
      explanation: "Research Mode is built for in-depth information gathering, utilizing search capabilities and multi-step reasoning to compile detailed synthesis."
    },
    {
      question: "How does Extended Thinking improve code generation?",
      option_a: "It converts all code to binary automatically.",
      option_b: "It allows Claude to verify logic, anticipate edge cases, and debug its own solution before showing it to you.",
      option_c: "It runs code on an external supercomputer.",
      option_d: "It shortens code by removing descriptive comments.",
      correct_option: "b",
      explanation: "Extended thinking lets caution identify the coding problem, plan the structure, and self-correct logic errors beforehand."
    }
  ],
  "Claude Code": [
    {
      question: "What is Claude Code?",
      option_a: "An extension for Google Chrome.",
      option_b: "Anthropic's official terminal-based command-line interface (CLI) agent that operates directly on your local project files.",
      option_c: "A syntax theme for Python files.",
      option_d: "A online editor hosted on Claude.ai.",
      correct_option: "b",
      explanation: "Claude Code is a CLI tool that runs in your local development environment to edit files, run tests, and manage git."
    },
    {
      question: "Which command initializes Claude Code in a local project directory?",
      option_a: "git init",
      option_b: "claude (or npx @anthropic-ai/claude-code)",
      option_c: "npm run dev",
      option_d: "docker compose up",
      correct_option: "b",
      explanation: "Running `claude` in your terminal starts the Claude Code agent, initializing the interface for that project directory."
    },
    {
      question: "How does Claude Code handle executing command-line operations (e.g. running tests)?",
      option_a: "It asks for user permission to run commands and then executes them locally.",
      option_b: "It sends the terminal commands to the cloud to run on simulated servers.",
      option_c: "It only displays the commands and cannot run them.",
      option_d: "It runs commands completely silently without ever alerting the user.",
      correct_option: "a",
      explanation: "Claude Code runs commands locally in your environment, but prompts you for approval before running potentially destructive commands or script executions."
    }
  ],
  "MCP — Model Context Protocol": [
    {
      question: "What problem does Model Context Protocol (MCP) solve in AI development?",
      option_a: "It increases internet download speeds.",
      option_b: "It provides a standard open protocol for models to connect to secure data sources, tools, and servers without bespoke integrations.",
      option_c: "It translates files from Mac to Windows formats.",
      option_d: "It registers domain names on the internet.",
      correct_option: "b",
      explanation: "MCP provides a unified standard protocol, allowing AI models to easily interact with any dataset or API that implements the protocol."
    },
    {
      question: "In an MCP architecture, what is the role of an \"MCP Server\"?",
      option_a: "It hosts the main LLM model itself.",
      option_b: "It exposes tools, resources, and prompts to the AI client (like Claude) from a specific data source or application.",
      option_c: "It is a browser tab that shows database logs.",
      option_d: "It is the computer hardware that runs the CLI.",
      correct_option: "b",
      explanation: "An MCP Server connects to a data source (e.g., PostgreSQL, GitHub, local files) and exposes it to the MCP client (the AI)."
    },
    {
      question: "How do you configure Claude Desktop to use a new MCP Server?",
      option_a: "By editing the `claude_desktop_config.json` file to include the server executable and its arguments.",
      option_b: "By calling Anthropic customer support.",
      option_c: "By buying a hardware connector cable.",
      option_d: "MCP servers are configured automatically via voice commands.",
      correct_option: "a",
      explanation: "The `claude_desktop_config.json` file is the standard configuration file used to register and launch MCP servers on Claude Desktop."
    }
  ]
}

async function run() {
  console.log('🚀 Starting Claude AI Quiz Seeder...')

  // 1. Fetch course
  const { data: course, error: courseError } = await supabase
    .from('courses')
    .select('id, title')
    .eq('slug', 'master-claude-ai-zero-to-pro')
    .single()

  if (courseError || !course) {
    console.error('❌ Course not found:', courseError?.message || 'Course is null')
    process.exit(1)
  }

  console.log(`📌 Found Course: "${course.title}" (ID: ${course.id})`)

  // 2. Fetch course modules
  const { data: modules, error: modulesError } = await supabase
    .from('modules')
    .select('id, title, order_index')
    .eq('course_id', course.id)
    .order('order_index', { ascending: true })

  if (modulesError || !modules || modules.length === 0) {
    console.error('❌ Modules not found or empty:', modulesError?.message || 'Modules is null/empty')
    process.exit(1)
  }

  console.log(`📚 Found ${modules.length} modules. Seeding quizzes...`)

  for (const mod of modules) {
    const questions = QUIZ_DATA[mod.title]
    if (!questions) {
      console.warn(`⚠️ No quiz questions mapped for module title: "${mod.title}". Skipping.`)
      continue
    }

    console.log(`🧹 Clearing existing quizzes for module: "${mod.title}" (ID: ${mod.id})...`)
    const { error: deleteError } = await supabase
      .from('quizzes')
      .delete()
      .eq('module_id', mod.id)

    if (deleteError) {
      console.error(`❌ Failed to clear quizzes for module "${mod.title}":`, deleteError.message)
      continue
    }

    const quizRows = questions.map((q, idx) => ({
      module_id: mod.id,
      question: q.question,
      option_a: q.option_a,
      option_b: q.option_b,
      option_c: q.option_c,
      option_d: q.option_d,
      correct_option: q.correct_option,
      explanation: q.explanation,
      order_index: idx + 1,
    }))

    console.log(`✍️ Inserting ${quizRows.length} questions for module: "${mod.title}"...`)
    const { data, error: insertError } = await supabase
      .from('quizzes')
      .insert(quizRows)
      .select()

    if (insertError) {
      console.error(`❌ Failed to insert quizzes for module "${mod.title}":`, insertError.message)
    } else {
      console.log(`✅ Successfully seeded module: "${mod.title}"`)
    }
  }

  console.log('🎉 Seeding completed!')
}

run().catch((err) => {
  console.error('❌ Script failed with error:', err)
  process.exit(1)
})
