-- =============================================
-- VibeLearn Phase 3 Migration
-- Career Paths revamp + Courses page + Course Details
-- Run in Supabase SQL Editor
-- =============================================

-- ============ ALTER courses TABLE ============

ALTER TABLE courses ADD COLUMN IF NOT EXISTS level TEXT DEFAULT 'beginner';
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_name TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_bio TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS instructor_avatar_url TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS language TEXT DEFAULT 'English';
ALTER TABLE courses ADD COLUMN IF NOT EXISTS enrolled_count INT DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS rating NUMERIC(3,1) DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS reviews_count INT DEFAULT 0;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS skills_gained TEXT[];
ALTER TABLE courses ADD COLUMN IF NOT EXISTS tags TEXT[];
ALTER TABLE courses ADD COLUMN IF NOT EXISTS is_pro BOOLEAN DEFAULT FALSE;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS last_updated_at DATE DEFAULT NOW();
ALTER TABLE courses ADD COLUMN IF NOT EXISTS certificate_enabled BOOLEAN DEFAULT TRUE;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS duration_hours NUMERIC;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS prerequisites TEXT;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS short_description TEXT;

-- ============ ALTER paths TABLE ============

ALTER TABLE paths ADD COLUMN IF NOT EXISTS unit_count INT DEFAULT 0;
ALTER TABLE paths ADD COLUMN IF NOT EXISTS faq JSONB DEFAULT '[]'::JSONB;
ALTER TABLE paths ADD COLUMN IF NOT EXISTS total_courses INT DEFAULT 0;

-- ============ UPDATE path unit counts ============

UPDATE paths p SET
  unit_count = (SELECT COUNT(*) FROM courses c WHERE c.path_id = p.id AND c.is_hidden = FALSE),
  total_courses = (SELECT COUNT(*) FROM courses c WHERE c.path_id = p.id AND c.is_hidden = FALSE);

-- ============ ADD FAQs to paths ============

UPDATE paths SET faq = '[
  {"q": "What is a career path?", "a": "A career path is a structured sequence of courses designed to take you from beginner to job-ready in a specific field. Each path includes curated courses, projects, and a certificate of completion."},
  {"q": "What do I need to know before starting?", "a": "No prior experience is required for most paths. Each path starts with foundational concepts and progressively builds your skills."},
  {"q": "Which career path is right for me?", "a": "Choose based on your interests and goals. If you enjoy problem-solving and technology, try AI or Data. If you love creating experiences, explore Design or Product."},
  {"q": "How much does a career path cost?", "a": "You can start any path for free and access the first two levels of each course. Upgrade to Pro for unlimited access to all paths and courses."},
  {"q": "Will this career path help me prepare for a job?", "a": "Yes. Each path is designed with industry requirements in mind, covering the exact skills employers look for in job descriptions."},
  {"q": "Will I earn a certification upon completion?", "a": "Yes. Completing a career path awards you an industry-recognized certificate you can share on LinkedIn, your resume, or your portfolio."},
  {"q": "How is a career path different from an individual course?", "a": "Individual courses focus on specific skills. A career path bundles multiple related courses into a complete learning journey designed to get you job-ready."}
]'::JSONB;

-- ============ UPDATE paths with better descriptions ============

UPDATE paths SET description = 'Build real AI products from scratch. Learn prompting, agents, automation tools, and ship production-ready AI applications without a CS degree.' WHERE slug = 'ai-product-building';
UPDATE paths SET description = 'Design beautiful, intuitive products that users love. Master Figma, UX research, interaction design, and build a portfolio that gets you hired.' WHERE slug = 'ux-design';
UPDATE paths SET description = 'Lead products from 0 to 1. Learn roadmapping, stakeholder management, agile, and data-driven decision making to become a product leader.' WHERE slug = 'product-management';
UPDATE paths SET description = 'Grow brands with content, ads, and analytics. Master digital marketing, SEO, paid ads, and analytics to drive measurable business growth.' WHERE slug = 'digital-marketing';
UPDATE paths SET description = 'Turn raw data into decisions. Learn SQL, Python, Excel, and visualization tools to analyze data and drive business outcomes.' WHERE slug = 'data-analysis';

-- ============ SEED course metadata ============

-- UX Design / Design courses
UPDATE courses SET
  level = 'intermediate',
  instructor_name = 'Colin Michael Face',
  instructor_bio = 'Seasoned Product Designer and Product Manager with a global perspective. Self-taught journey has given a unique approach to design thinking, applied across startups and enterprise environments.',
  language = 'English',
  enrolled_count = 54949,
  rating = 4.8,
  reviews_count = 36,
  skills_gained = ARRAY['Effective component design — Learn to create clear hierarchies and components that direct attention toward primary actions', 'Seamless user journey support — Structure interfaces that eliminate friction and communicate errors helpfully', 'Cognitive organization and focus — Discover ways to group information logically', 'Systematic design principles — Use consistent styling, proper states, and accessibility standards'],
  tags = ARRAY['UI Design', 'User Interface', 'Components', 'Best Practices', 'UX', 'Accessibility'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 7,
  prerequisites = 'No prerequisites',
  short_description = 'Master UI components and learn the reasoning behind every design decision.'
WHERE slug = 'Figma-mastery';

UPDATE courses SET
  level = 'beginner',
  instructor_name = 'Sarah Chen',
  instructor_bio = 'UX Designer with 8+ years at top tech companies. Specializes in user research and making complex systems feel simple.',
  language = 'English',
  enrolled_count = 38421,
  rating = 4.7,
  reviews_count = 28,
  skills_gained = ARRAY['User research methods — Qualitative and quantitative approaches', 'Usability testing — Plan, conduct, and analyze tests', 'Journey mapping — Visualize end-to-end user experiences', 'Data synthesis — Turn research into actionable insights'],
  tags = ARRAY['UX Research', 'User Testing', 'Design', 'Research Methods'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 6,
  prerequisites = 'No prerequisites',
  short_description = 'Master user experience research to create user-centered designs.'
WHERE slug = 'Ux-research';

UPDATE courses SET
  level = 'beginner',
  instructor_name = 'Marcus Rivera',
  instructor_bio = 'Former design lead at Airbnb. Now teaches visual design principles to thousands of students worldwide.',
  language = 'English',
  enrolled_count = 29847,
  rating = 4.9,
  reviews_count = 41,
  skills_gained = ARRAY['Color theory — Build harmonious palettes that communicate brand values', 'Typography — Choose and pair typefaces for clarity and hierarchy', 'Grid systems — Create consistent, flexible layouts', 'Composition — Direct attention with visual weight and balance'],
  tags = ARRAY['Visual Design', 'Color Theory', 'Typography', 'UI', 'Design Fundamentals'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 5,
  prerequisites = 'No prerequisites',
  short_description = 'Master fundamental visual design principles through hands-on projects.'
WHERE slug = 'Visual-design-principles';

-- AI courses
UPDATE courses SET
  level = 'beginner',
  instructor_name = 'Alex Patel',
  instructor_bio = 'AI engineer and educator who has built production AI systems at scale. Makes complex AI concepts accessible to non-technical audiences.',
  language = 'English',
  enrolled_count = 47230,
  rating = 4.9,
  reviews_count = 52,
  skills_gained = ARRAY['Prompt engineering — 20+ proven frameworks to unlock AI potential', 'APE, RACE, ROSES, TRACE frameworks — Structured approaches to AI communication', 'Advanced prompting — Chain-of-thought, few-shot, and role-based prompting', 'Real-world applications — Apply prompting to coding, writing, and analysis tasks'],
  tags = ARRAY['AI', 'Prompt Engineering', 'ChatGPT', 'Claude', 'LLMs'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 8,
  prerequisites = 'No prerequisites',
  short_description = 'Master the art of AI communication with 20+ proven prompting frameworks.'
WHERE slug = 'Prompt-Engineering-Mastery';

UPDATE courses SET
  level = 'intermediate',
  instructor_name = 'Jordan Kim',
  instructor_bio = 'Full-stack engineer turned AI builder. Has shipped 5+ AI SaaS products and teaches others to do the same in weeks, not months.',
  language = 'English',
  enrolled_count = 31540,
  rating = 4.8,
  reviews_count = 39,
  skills_gained = ARRAY['AI agent architecture — Design autonomous agents with memory and tools', 'LangChain framework — Build production-ready agentic applications', 'Tool integration — Connect agents to APIs, databases, and external services', 'Retrieval systems — Implement RAG for context-aware agents'],
  tags = ARRAY['AI', 'LangChain', 'Agents', 'Python', 'LLMs'],
  is_pro = TRUE,
  certificate_enabled = TRUE,
  duration_hours = 10,
  prerequisites = 'Basic Python knowledge',
  short_description = 'Build intelligent AI agents using LangChain with tool use and memory.'
WHERE slug = 'Building-AI-Agents-with-LangChain';

UPDATE courses SET
  level = 'beginner',
  instructor_name = 'Mia Thompson',
  instructor_bio = 'No-code builder and entrepreneur who has built and sold multiple SaaS products. Passionate about democratizing software development.',
  language = 'English',
  enrolled_count = 28900,
  rating = 4.7,
  reviews_count = 31,
  skills_gained = ARRAY['AI-powered development — Build full apps without traditional coding', 'Rapid prototyping — Go from idea to MVP in days', 'UI/UX with AI assistance — Design beautiful interfaces automatically', 'SaaS deployment — Launch and scale software products'],
  tags = ARRAY['AI', 'No-Code', 'SaaS', 'Product Building', 'Lovable'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 6,
  prerequisites = 'No prerequisites',
  short_description = 'Build complete SaaS applications using AI-powered development tools.'
WHERE slug = 'Building-SaaS-with-Lovable-AI';

-- Product Management courses
UPDATE courses SET
  level = 'beginner',
  instructor_name = 'David Park',
  instructor_bio = 'Former PM at Google and Stripe. Now helping the next generation of product managers build the skills to lead impactful products.',
  language = 'English',
  enrolled_count = 42180,
  rating = 4.8,
  reviews_count = 47,
  skills_gained = ARRAY['Market research — Validate ideas with real data before building', 'Roadmap planning — Prioritize features using frameworks like RICE and MoSCoW', 'Stakeholder management — Align engineering, design, and business teams', 'Agile methodologies — Lead sprints and manage backlogs effectively'],
  tags = ARRAY['Product Management', 'Strategy', 'Agile', 'Roadmapping', 'Leadership'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 9,
  prerequisites = 'No prerequisites',
  short_description = 'Build essential product management skills from strategy to execution.'
WHERE slug = 'Product-Management-Fundamentals';

-- Digital Marketing courses
UPDATE courses SET
  level = 'beginner',
  instructor_name = 'Emma Wilson',
  instructor_bio = 'Digital marketing director with 10+ years growing brands at scale. Has managed $10M+ in ad spend across Google, Meta, and TikTok.',
  language = 'English',
  enrolled_count = 33760,
  rating = 4.6,
  reviews_count = 29,
  skills_gained = ARRAY['SEO fundamentals — Keyword research, on-page optimization, link building', 'Technical SEO — Site structure, speed optimization, schema markup', 'Content strategy — Create content that ranks and converts', 'Analytics — Measure and improve organic search performance'],
  tags = ARRAY['SEO', 'Digital Marketing', 'Content Marketing', 'Google', 'Analytics'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 7,
  prerequisites = 'No prerequisites',
  short_description = 'Master search engine optimization to drive sustainable organic traffic.'
WHERE slug = 'seo';

-- Data courses
UPDATE courses SET
  level = 'beginner',
  instructor_name = 'Raj Nair',
  instructor_bio = 'Data scientist with PhD in Statistics. Has worked at Netflix and Spotify on recommendation systems. Simplifies complex data concepts.',
  language = 'English',
  enrolled_count = 51230,
  rating = 4.8,
  reviews_count = 58,
  skills_gained = ARRAY['Python programming — Write clean, efficient code for data analysis', 'Data structures — Lists, dicts, DataFrames, arrays', 'Web development with Django — Build data-powered web applications', 'Automation — Automate repetitive tasks with Python scripts'],
  tags = ARRAY['Python', 'Data Science', 'Programming', 'Automation', 'Machine Learning'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 12,
  prerequisites = 'No prerequisites',
  short_description = 'Master Python from fundamentals to advanced data science applications.'
WHERE slug = 'Python-programming';

UPDATE courses SET
  level = 'intermediate',
  instructor_name = 'Raj Nair',
  instructor_bio = 'Data scientist with PhD in Statistics. Makes complex data concepts accessible with real-world examples.',
  language = 'English',
  enrolled_count = 39870,
  rating = 4.7,
  reviews_count = 44,
  skills_gained = ARRAY['SQL queries — SELECT, JOIN, GROUP BY, subqueries', 'Database design — Normalize schemas for performance', 'Performance optimization — Indexes, query plans, caching', 'Data modeling — Design relational databases from scratch'],
  tags = ARRAY['SQL', 'Databases', 'Data Analysis', 'Backend', 'PostgreSQL'],
  is_pro = FALSE,
  certificate_enabled = TRUE,
  duration_hours = 8,
  prerequisites = 'Basic computer literacy',
  short_description = 'Master SQL and relational database design for data analysis.'
WHERE slug = 'Sql-and-relational-databases';

-- Update remaining courses with generic but realistic metadata
UPDATE courses SET
  enrolled_count = CASE
    WHEN enrolled_count = 0 THEN (RANDOM() * 40000 + 5000)::INT
    ELSE enrolled_count
  END,
  rating = CASE
    WHEN rating = 0 THEN ROUND((RANDOM() * 0.8 + 4.0)::NUMERIC, 1)
    ELSE rating
  END,
  reviews_count = CASE
    WHEN reviews_count = 0 THEN (RANDOM() * 50 + 10)::INT
    ELSE reviews_count
  END,
  level = CASE
    WHEN level = 'beginner' AND slug IN (
      'Building-AI-Agents-with-LangChain', 'Building-AI-Agents-with-N8N',
      'machine-learning-a-z-hands-on-python', 'Retrieval-Augmented-Generation-(RAG)-Systems',
      'ethical-hacking-and-penetration-testing', 'devops-fundamentals-ci-cd-101'
    ) THEN 'intermediate'
    WHEN level = 'beginner' AND slug IN (
      'AI-Coding-with-MCP-Tools-Integration', 'cyber-security-from-beginner-to-expert'
    ) THEN 'advanced'
    ELSE level
  END,
  is_pro = CASE
    WHEN slug IN (
      'Building-AI-Agents-with-LangChain', 'Building-AI-Agents-with-N8N',
      'machine-learning-a-z-hands-on-python', 'Retrieval-Augmented-Generation-(RAG)-Systems',
      'ethical-hacking-and-penetration-testing', 'AI-Coding-with-MCP-Tools-Integration',
      'AI-for-Finance-Professionals', 'Data-Analysis-with-AI'
    ) THEN TRUE
    ELSE FALSE
  END,
  certificate_enabled = TRUE,
  language = 'English',
  duration_hours = CASE
    WHEN duration_hours IS NULL THEN (RANDOM() * 8 + 4)::NUMERIC(4,1)
    ELSE duration_hours
  END,
  instructor_name = CASE
    WHEN instructor_name IS NULL AND path_id = '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c' THEN 'Alex Patel'
    WHEN instructor_name IS NULL AND path_id = '1d4aeeee-79cc-4887-9e02-01a6999ceaa1' THEN 'Colin Michael Face'
    WHEN instructor_name IS NULL AND path_id = '3275b00a-58d7-4a4b-8472-a851a9231497' THEN 'David Park'
    WHEN instructor_name IS NULL AND path_id = '251e65a0-3e44-4a0e-b18a-78fe5d7a1366' THEN 'Emma Wilson'
    WHEN instructor_name IS NULL AND path_id = 'f4f7844a-e0a8-47a4-bdef-83b51c933b39' THEN 'Raj Nair'
    ELSE instructor_name
  END,
  tags = CASE
    WHEN tags IS NULL AND path_id = '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c' THEN ARRAY['AI', 'Technology', 'Innovation']
    WHEN tags IS NULL AND path_id = '1d4aeeee-79cc-4887-9e02-01a6999ceaa1' THEN ARRAY['Design', 'UX', 'Creative']
    WHEN tags IS NULL AND path_id = '3275b00a-58d7-4a4b-8472-a851a9231497' THEN ARRAY['Product', 'Strategy', 'Leadership']
    WHEN tags IS NULL AND path_id = '251e65a0-3e44-4a0e-b18a-78fe5d7a1366' THEN ARRAY['Marketing', 'Digital', 'Growth']
    WHEN tags IS NULL AND path_id = 'f4f7844a-e0a8-47a4-bdef-83b51c933b39' THEN ARRAY['Data', 'Analytics', 'Python']
    ELSE tags
  END
WHERE is_hidden = FALSE;

-- Update module is_free flags (first 2 per course)
UPDATE modules SET is_free = TRUE
WHERE order_index <= 2;
