export type RoadmapItemType = 'course' | 'assessment' | 'project' | 'graduation'

export interface RoadmapItem {
  type: RoadmapItemType
  emoji: string
  tag: string
  title: string
  description: string
  why: string
  isFree?: boolean
}

export type CarouselSlideType = 'prose' | 'checklist' | 'hierarchy' | 'tools'

export interface HierarchyLevel {
  title: string
  salary: string
  years: string
}

export interface CarouselSlide {
  title: string
  type: CarouselSlideType
  content: string | string[]
  hierarchy?: HierarchyLevel[]
  tools?: string[]
}

export interface RoleData {
  id: string
  pathSlug: string
  label: string
  emoji: string
  tagline: string
  color: string
  goalTitle: string
  carousel: CarouselSlide[]
  roadmap: RoadmapItem[]
}

export const ROLES: RoleData[] = [
  // ─── AI Generalist ───────────────────────────────────────────────────────
  {
    id: 'ai-generalist',
    pathSlug: 'ai-product-building',
    label: 'AI Generalist',
    emoji: '🤖',
    tagline: 'Master the AI-augmented workforce.\nBe the person every team needs.',
    color: '#818CF8',
    goalTitle: 'AI-Augmented Professional',
    carousel: [
      {
        title: 'A Monday as an AI Generalist',
        type: 'prose',
        content:
          'You start the week by running an AI pipeline that drafts the weekly status report in seconds. Then you ship a no-code automation that saves the ops team 6 hours. By lunch you\'re prototyping a custom GPT for the sales team. You\'re not a developer — you\'re the person who makes everyone 10× faster.',
      },
      {
        title: 'Career Ladder & Earning Potential',
        type: 'hierarchy',
        content: '',
        hierarchy: [
          { title: 'AI Tools Coordinator', salary: '$55K–$75K', years: '0–1 yr' },
          { title: 'AI Ops Specialist', salary: '$75K–$100K', years: '1–3 yrs' },
          { title: 'AI Product Strategist', salary: '$100K–$140K', years: '3–6 yrs' },
          { title: 'Head of AI / CDO', salary: '$140K–$220K+', years: '6+ yrs' },
        ],
      },
      {
        title: 'Skills You Will Master',
        type: 'checklist',
        content: [
          'Prompt engineering & LLM workflows',
          'No-code / low-code AI automation (Zapier, Make)',
          'AI-assisted content & image generation',
          'Data literacy — reading dashboards & metrics',
          'Building custom GPTs and AI agents',
          'Evaluating & selecting AI tools for business use',
          'Ethics, bias, and responsible AI deployment',
        ],
      },
      {
        title: 'Your AI Toolstack',
        type: 'tools',
        content: '',
        tools: ['ChatGPT', 'Claude', 'Midjourney', 'Make', 'Zapier', 'Notion AI', 'Perplexity', 'v0.dev', 'Cursor', 'LangChain'],
      },
      {
        title: 'Why Learning AI Now Is a Superpower',
        type: 'prose',
        content:
          'AI won\'t replace you — someone who knows AI will. Companies are desperately hiring people who bridge the gap between AI tools and real business problems. This role doesn\'t exist in textbooks yet; it\'s being written right now, and you\'re learning it first.',
      },
    ],
    roadmap: [
      {
        type: 'course',
        emoji: '🧠',
        tag: 'Course',
        title: 'AI Foundations for Non-Engineers',
        description: 'How LLMs work, what they can and can\'t do, and how to think in prompts.',
        why: 'Mental model first — every future skill depends on understanding this.',
        isFree: true,
      },
      {
        type: 'course',
        emoji: '✍️',
        tag: 'Course',
        title: 'Prompt Engineering Masterclass',
        description: 'Chain-of-thought, few-shot, system prompts, and retrieval patterns.',
        why: 'Prompting is the core skill — the difference between mediocre and magical output.',
      },
      {
        type: 'assessment',
        emoji: '📊',
        tag: 'Assessment',
        title: 'AI & Machine Learning Literacy Check',
        description: 'A timed quiz on AI concepts, capabilities, and responsible use.',
        why: 'Validates your foundation before moving into hands-on automation.',
      },
      {
        type: 'course',
        emoji: '⚡',
        tag: 'Course',
        title: 'No-Code AI Automation (Make + Zapier)',
        description: 'Build multi-step AI workflows that automate real business tasks.',
        why: 'Automation is the fastest way to demonstrate ROI with AI.',
      },
      {
        type: 'project',
        emoji: '🛠️',
        tag: 'Project',
        title: 'Build an AI Workflow for a Real Business Problem',
        description: 'Design and deploy an AI automation that saves measurable time or cost.',
        why: 'Portfolio proof that you can ship, not just talk about AI.',
      },
      {
        type: 'course',
        emoji: '🤝',
        tag: 'Course',
        title: 'Building & Deploying Custom AI Agents',
        description: 'GPTs, LangChain agents, and multi-model orchestration.',
        why: 'The next frontier — agents that act, not just respond.',
      },
      {
        type: 'graduation',
        emoji: '🎓',
        tag: 'Graduation',
        title: 'Portfolio Finalization & Career Launch',
        description: 'Curate your projects, build your AI portfolio, prep for interviews.',
        why: 'Ship your story — your portfolio is your new CV.',
      },
    ],
  },

  // ─── UX/UI Designer ──────────────────────────────────────────────────────
  {
    id: 'ux-design',
    pathSlug: 'ux-design',
    label: 'UX/UI Designer',
    emoji: '🎨',
    tagline: 'Create digital products that millions\nof people love to use every day.',
    color: '#F472B6',
    goalTitle: 'Job-Ready Junior UX Designer',
    carousel: [
      {
        title: 'A Monday Morning as a UX Designer',
        type: 'prose',
        content:
          'You open Figma and review 3 user interview recordings from Friday. You sketch wireframes for a new checkout flow, then present them to the PM. In the afternoon it\'s a design critique — you defend every decision with research data, not personal taste. By 5pm you\'ve iterated on 2 components based on feedback and pushed them to the design system.',
      },
      {
        title: 'Career Ladder & Earning Potential',
        type: 'hierarchy',
        content: '',
        hierarchy: [
          { title: 'Junior UX Designer', salary: '$55K–$80K', years: '0–2 yrs' },
          { title: 'Mid UX/UI Designer', salary: '$80K–$110K', years: '2–4 yrs' },
          { title: 'Senior Designer', salary: '$110K–$145K', years: '4–7 yrs' },
          { title: 'Design Lead / VP Design', salary: '$145K–$200K+', years: '7+ yrs' },
        ],
      },
      {
        title: 'Skills You Will Master',
        type: 'checklist',
        content: [
          'User research: interviews, surveys, usability tests',
          'Information architecture & user flows',
          'Wireframing and low/high fidelity prototyping',
          'Figma: auto-layout, components, variables',
          'Design systems and style guides',
          'Accessibility (WCAG) and inclusive design',
          'Presenting designs and handling stakeholder feedback',
          'AI-assisted design with Figma AI & Galileo',
        ],
      },
      {
        title: 'Your Design Toolstack',
        type: 'tools',
        content: '',
        tools: ['Figma', 'FigJam', 'Maze', 'Hotjar', 'Notion', 'Framer', 'Galileo AI', 'Miro', 'Lottie', 'Zeplin'],
      },
      {
        title: 'How AI Is Changing UX Design',
        type: 'prose',
        content:
          'AI generates UI layouts in seconds, but it can\'t do user research or strategic thinking. Designers who learn AI tools prototype 5× faster and use the saved time for deeper user empathy work. The future isn\'t AI replacing designers — it\'s AI-fluent designers replacing designers who aren\'t.',
      },
    ],
    roadmap: [
      {
        type: 'course',
        emoji: '🔍',
        tag: 'Course',
        title: 'UX Design Fundamentals',
        description: 'Heuristics, user psychology, and how to think like a designer.',
        why: 'The mental framework before touching any tool.',
        isFree: true,
      },
      {
        type: 'course',
        emoji: '🗣️',
        tag: 'Course',
        title: 'User Research & Empathy Mapping',
        description: 'How to run interviews, synthesise insights, and build user personas.',
        why: 'Research is your superpower — design without it is just decoration.',
      },
      {
        type: 'assessment',
        emoji: '📐',
        tag: 'Assessment',
        title: 'Design Thinking Knowledge Check',
        description: 'A timed challenge on UX concepts, heuristics, and research methods.',
        why: 'Confirm you\'re ready to move from theory into Figma.',
      },
      {
        type: 'course',
        emoji: '✏️',
        tag: 'Course',
        title: 'Figma Masterclass',
        description: 'Auto-layout, components, variables, and design-to-dev handoff.',
        why: 'Figma is the industry standard — you need to be fast in it.',
      },
      {
        type: 'project',
        emoji: '📱',
        tag: 'Project',
        title: 'Redesign a Local Business App',
        description: 'Research, wireframe, and prototype a full mobile app redesign.',
        why: 'A real portfolio piece interviewers can scroll through on day one.',
      },
      {
        type: 'course',
        emoji: '🚀',
        tag: 'Course',
        title: 'Advanced UI & AI-Assisted Prototyping',
        description: 'Motion design, Framer, Galileo AI, and advanced design systems.',
        why: 'Senior-level output — the thing that separates good from great.',
      },
      {
        type: 'graduation',
        emoji: '🎓',
        tag: 'Graduation',
        title: 'Portfolio Finalization & Interview Prep',
        description: 'Case studies, portfolio site, and mock design critiques.',
        why: 'Your portfolio is your audition — make it unforgettable.',
      },
    ],
  },

  // ─── Product Manager ─────────────────────────────────────────────────────
  {
    id: 'product-management',
    pathSlug: 'product-management',
    label: 'Product Manager',
    emoji: '📦',
    tagline: 'Own the product lifecycle and strategy.\nBe the person who decides what gets built.',
    color: '#34D399',
    goalTitle: 'Associate Product Manager',
    carousel: [
      {
        title: 'A Monday as a Product Manager',
        type: 'prose',
        content:
          'You start with a 15-min standup, then review the weekend\'s retention metrics — something dropped on Sunday. You write a Slack message framing the problem, then pull the team into a quick diagnosis session. By noon you\'ve updated the sprint backlog. The afternoon is a PRD review for next quarter\'s AI feature — you\'re the decision-maker in the room.',
      },
      {
        title: 'Career Ladder & Earning Potential',
        type: 'hierarchy',
        content: '',
        hierarchy: [
          { title: 'Associate Product Manager', salary: '$75K–$100K', years: '0–2 yrs' },
          { title: 'Product Manager', salary: '$100K–$145K', years: '2–5 yrs' },
          { title: 'Senior PM / Group PM', salary: '$145K–$200K', years: '5–8 yrs' },
          { title: 'VP Product / CPO', salary: '$200K–$400K+', years: '8+ yrs' },
        ],
      },
      {
        title: 'Skills You Will Master',
        type: 'checklist',
        content: [
          'Product discovery and opportunity framing',
          'Writing PRDs, user stories, and acceptance criteria',
          'Prioritisation: RICE, MoSCoW, opportunity scoring',
          'Data for PMs: SQL basics, funnel analysis, A/B testing',
          'Roadmapping and stakeholder communication',
          'Agile / Scrum ceremonies and sprint planning',
          'AI feature strategy and prompt-driven prototyping',
          'Negotiating trade-offs between design, eng, and business',
        ],
      },
      {
        title: 'Your PM Toolstack',
        type: 'tools',
        content: '',
        tools: ['Jira', 'Notion', 'Figma', 'Amplitude', 'Mixpanel', 'Linear', 'Miro', 'ChatGPT', 'Loom', 'SQL'],
      },
      {
        title: 'How AI Is Reshaping Product Management',
        type: 'prose',
        content:
          'PMs who use AI can run 10 user interviews in 20 minutes via AI synthesis, generate PRD first drafts in seconds, and prototype ideas with zero engineering time. The best PMs of 2026 don\'t wait for eng bandwidth — they prototype, test, and validate with AI before a single line of code is written.',
      },
    ],
    roadmap: [
      {
        type: 'course',
        emoji: '🧩',
        tag: 'Course',
        title: 'Product Thinking & Strategy',
        description: 'How to frame problems, define success, and build a product vision.',
        why: 'Strategy before execution — the most senior PMs never skip this.',
        isFree: true,
      },
      {
        type: 'course',
        emoji: '📝',
        tag: 'Course',
        title: 'Writing PRDs & Managing Backlogs',
        description: 'PRD structure, user stories, acceptance criteria, and sprint ceremonies.',
        why: 'Your written communication is your primary tool as a PM.',
      },
      {
        type: 'assessment',
        emoji: '🎯',
        tag: 'Assessment',
        title: 'Strategy & Prioritisation Benchmark',
        description: 'Scenario-based test on prioritisation frameworks and product tradeoffs.',
        why: 'Interviewers will test this — verify your skills before they do.',
      },
      {
        type: 'course',
        emoji: '📈',
        tag: 'Course',
        title: 'Data for PMs: Metrics, SQL & A/B Testing',
        description: 'Reading dashboards, writing basic SQL queries, and designing experiments.',
        why: 'Data fluency separates good PMs from great ones.',
      },
      {
        type: 'project',
        emoji: '🤖',
        tag: 'Project',
        title: 'Launch a Mock AI Feature for a Popular App',
        description: 'Write a full PRD, design the UX flow, and define launch metrics.',
        why: 'Hiring managers ask "show me something you\'ve shipped" — now you have an answer.',
      },
      {
        type: 'course',
        emoji: '🤝',
        tag: 'Course',
        title: 'Stakeholder Management & Soft Skills',
        description: 'Influence without authority, running effective reviews, saying no gracefully.',
        why: 'Technical skills get you the job; soft skills determine how far you go.',
      },
      {
        type: 'graduation',
        emoji: '🎓',
        tag: 'Graduation',
        title: 'Portfolio Finalization & Interview Prep',
        description: 'PM portfolio, mock interviews, and PM case study frameworks.',
        why: 'The final polish — turn your learning into a compelling PM narrative.',
      },
    ],
  },

  // ─── Growth Marketer ─────────────────────────────────────────────────────
  {
    id: 'growth-marketing',
    pathSlug: 'digital-marketing',
    label: 'Growth Marketer',
    emoji: '📈',
    tagline: 'Drive acquisition, retention, and scale.\nTurn data into exponential growth.',
    color: '#FBBF24',
    goalTitle: 'Growth Marketing Specialist',
    carousel: [
      {
        title: 'A Monday as a Growth Marketer',
        type: 'prose',
        content:
          'You pull last week\'s CAC and LTV numbers over coffee. Something\'s off with the paid search ROAS — you dig in, find a keyword bleeding budget, pause it, and brief the copy team on a new angle. By noon you\'ve launched an A/B test on the landing page headline. The afternoon is a growth review where you present next quarter\'s acquisition plan to the founders.',
      },
      {
        title: 'Career Ladder & Earning Potential',
        type: 'hierarchy',
        content: '',
        hierarchy: [
          { title: 'Digital Marketing Coordinator', salary: '$45K–$65K', years: '0–2 yrs' },
          { title: 'Growth Marketing Specialist', salary: '$65K–$95K', years: '2–4 yrs' },
          { title: 'Growth Marketing Manager', salary: '$95K–$135K', years: '4–7 yrs' },
          { title: 'VP Growth / CMO', salary: '$135K–$250K+', years: '7+ yrs' },
        ],
      },
      {
        title: 'Skills You Will Master',
        type: 'checklist',
        content: [
          'Paid acquisition: Google Ads, Meta Ads, TikTok Ads',
          'SEO: on-page, technical, and link building',
          'Email marketing and lifecycle automation',
          'Conversion rate optimisation (CRO) and A/B testing',
          'Analytics: GA4, Mixpanel, attribution modelling',
          'Content strategy and distribution',
          'Growth loops and viral mechanics',
          'AI-powered copywriting and campaign generation',
        ],
      },
      {
        title: 'Your Growth Toolstack',
        type: 'tools',
        content: '',
        tools: ['Google Ads', 'Meta Ads Manager', 'GA4', 'Klaviyo', 'HubSpot', 'Semrush', 'Hotjar', 'Notion', 'ChatGPT', 'Canva'],
      },
      {
        title: 'How AI Is Transforming Growth Marketing',
        type: 'prose',
        content:
          'AI can now generate 50 ad copy variants in 60 seconds, predict churn before it happens, and personalise email sequences at scale. Growth marketers who use AI don\'t just save time — they run more experiments, find winning angles faster, and compound learnings at a rate that manual marketers can\'t match.',
      },
    ],
    roadmap: [
      {
        type: 'course',
        emoji: '🔭',
        tag: 'Course',
        title: 'Growth Marketing Fundamentals',
        description: 'The AARRR framework, growth loops, and channel strategy.',
        why: 'The strategy layer — understand how growth actually compounds.',
        isFree: true,
      },
      {
        type: 'course',
        emoji: '💸',
        tag: 'Course',
        title: 'Paid Acquisition: Google & Meta Ads',
        description: 'Campaign structure, bidding, creative testing, and ROAS optimisation.',
        why: 'Paid is the fastest lever for measurable growth at any stage.',
      },
      {
        type: 'assessment',
        emoji: '📡',
        tag: 'Assessment',
        title: 'Digital Marketing Knowledge Check',
        description: 'Channel knowledge, funnel metrics, and growth frameworks.',
        why: 'Confirm your channel fluency before running live campaigns.',
      },
      {
        type: 'course',
        emoji: '📊',
        tag: 'Course',
        title: 'Analytics & CRO: GA4, A/B Testing & Attribution',
        description: 'Measure what matters and turn data into conversion improvements.',
        why: 'Without measurement, you\'re guessing. This course makes you dangerous.',
      },
      {
        type: 'project',
        emoji: '🚀',
        tag: 'Project',
        title: 'Launch a Full-Funnel Campaign for a Real Brand',
        description: 'Build, launch, and report on a multi-channel growth campaign.',
        why: 'Nothing proves growth skills like a real campaign with real numbers.',
      },
      {
        type: 'course',
        emoji: '🤖',
        tag: 'Course',
        title: 'AI-Powered Growth: Automation & Personalisation',
        description: 'AI copywriting, predictive segmentation, and automated workflows.',
        why: 'The edge that makes you 10× more productive than peers.',
      },
      {
        type: 'graduation',
        emoji: '🎓',
        tag: 'Graduation',
        title: 'Portfolio Finalization & Interview Prep',
        description: 'Growth case studies, portfolio, and growth interview prep.',
        why: 'Frame your wins in impact — numbers close offers.',
      },
    ],
  },

  // ─── Data Analyst ────────────────────────────────────────────────────────
  {
    id: 'data-analysis',
    pathSlug: 'data-analysis',
    label: 'Data Analyst',
    emoji: '📊',
    tagline: 'Turn raw data into business strategy.\nBe the person every team trusts with numbers.',
    color: '#60A5FA',
    goalTitle: 'Junior Data Analyst',
    carousel: [
      {
        title: 'A Monday as a Data Analyst',
        type: 'prose',
        content:
          'You start by pulling the weekend retention cohort into a SQL query. Something weird — a drop-off on day 3 for users who signed up via mobile. You build a quick chart in Tableau, then write a Slack thread framing the hypothesis. By noon the product team is re-prioritising based on your find. Afternoons: building the automated weekly KPI dashboard the exec team reads on Fridays.',
      },
      {
        title: 'Career Ladder & Earning Potential',
        type: 'hierarchy',
        content: '',
        hierarchy: [
          { title: 'Junior Data Analyst', salary: '$55K–$80K', years: '0–2 yrs' },
          { title: 'Data Analyst', salary: '$80K–$110K', years: '2–4 yrs' },
          { title: 'Senior / Lead Analyst', salary: '$110K–$150K', years: '4–7 yrs' },
          { title: 'Analytics Manager / Director', salary: '$150K–$220K+', years: '7+ yrs' },
        ],
      },
      {
        title: 'Skills You Will Master',
        type: 'checklist',
        content: [
          'SQL: queries, joins, aggregations, window functions',
          'Python for data: pandas, numpy, matplotlib',
          'Data visualisation: Tableau, Looker, Power BI',
          'Statistical thinking: hypothesis testing, A/B analysis',
          'Business metrics: CAC, LTV, retention, churn',
          'Data cleaning and transformation (ETL basics)',
          'Storytelling with data — presenting to non-technical audiences',
          'AI-assisted analysis with ChatGPT + Python',
        ],
      },
      {
        title: 'Your Analytics Toolstack',
        type: 'tools',
        content: '',
        tools: ['SQL', 'Python', 'Tableau', 'Power BI', 'Google Sheets', 'BigQuery', 'dbt', 'Looker', 'Jupyter', 'ChatGPT'],
      },
      {
        title: 'How AI Is Reshaping Data Analysis',
        type: 'prose',
        content:
          'You can now ask ChatGPT to write your SQL query in plain English, generate a Python cleaning script, or explain a statistical output. The bar for entry has lowered — but the bar for insight has gone up. Analysts who combine AI fluency with strong business intuition and communication are becoming the most valued people in any data team.',
      },
    ],
    roadmap: [
      {
        type: 'course',
        emoji: '🗄️',
        tag: 'Course',
        title: 'SQL Fundamentals for Data Analysis',
        description: 'SELECT to window functions — everything you need to query any database.',
        why: 'SQL is the language of data — every analyst role requires it.',
        isFree: true,
      },
      {
        type: 'course',
        emoji: '🐍',
        tag: 'Course',
        title: 'Python for Data Analysis',
        description: 'pandas, numpy, data cleaning, and exploratory analysis.',
        why: 'Python unlocks everything SQL can\'t — reshaping, modelling, automation.',
      },
      {
        type: 'assessment',
        emoji: '🔬',
        tag: 'Assessment',
        title: 'SQL & Data Analysis Benchmark',
        description: 'Timed SQL challenges and data interpretation questions.',
        why: 'Validate your SQL and reasoning skills before moving to visualisation.',
      },
      {
        type: 'course',
        emoji: '📉',
        tag: 'Course',
        title: 'Data Visualisation & Storytelling',
        description: 'Tableau, chart selection, and presenting insights to stakeholders.',
        why: 'The analyst who can\'t communicate findings might as well not have them.',
      },
      {
        type: 'project',
        emoji: '🏪',
        tag: 'Project',
        title: 'End-to-End Business Analysis Project',
        description: 'Take a raw dataset from exploration to executive dashboard.',
        why: 'One completed project proves more than 10 courses — hire me energy.',
      },
      {
        type: 'course',
        emoji: '🤖',
        tag: 'Course',
        title: 'AI-Assisted Analysis & Advanced Statistics',
        description: 'A/B testing, cohort analysis, and LLM-powered data workflows.',
        why: 'Move from reporting to genuine insight — the analyst every team wants.',
      },
      {
        type: 'graduation',
        emoji: '🎓',
        tag: 'Graduation',
        title: 'Portfolio Finalization & Interview Prep',
        description: 'GitHub portfolio, case studies, and data interview prep.',
        why: 'Interviewers look at your GitHub — make it tell your story.',
      },
    ],
  },
]
