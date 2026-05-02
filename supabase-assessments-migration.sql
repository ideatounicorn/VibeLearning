-- Assessments: standalone quiz system (separate from module quizzes)

CREATE TABLE assessments (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title            TEXT NOT NULL,
  slug             TEXT UNIQUE NOT NULL,
  description      TEXT,
  short_description TEXT,
  category         TEXT NOT NULL DEFAULT 'Skills', -- 'Skills' | 'Tools'
  icon_emoji       TEXT DEFAULT '📊',
  icon_bg          TEXT DEFAULT '#4F46E5', -- hex color for icon bg
  duration_minutes INT  DEFAULT 25,
  question_count   INT  DEFAULT 25,
  xp_reward        INT  DEFAULT 750,
  attempts_count   INT  DEFAULT 0,   -- public stat (updated via trigger)
  difficulty       TEXT DEFAULT 'All levels',
  is_published     BOOLEAN DEFAULT true,
  is_pro           BOOLEAN DEFAULT false,
  tags             TEXT[] DEFAULT '{}',
  order_index      INT  DEFAULT 0,
  created_at       TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE assessment_questions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  assessment_id   UUID REFERENCES assessments(id) ON DELETE CASCADE NOT NULL,
  question        TEXT NOT NULL,
  option_a        TEXT NOT NULL,
  option_b        TEXT NOT NULL,
  option_c        TEXT NOT NULL,
  option_d        TEXT NOT NULL,
  correct_option  TEXT NOT NULL CHECK (correct_option IN ('a','b','c','d')),
  explanation     TEXT,
  order_index     INT  DEFAULT 0
);

CREATE TABLE user_assessments (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  assessment_id UUID REFERENCES assessments(id) ON DELETE CASCADE NOT NULL,
  score         INT  NOT NULL,
  total         INT  NOT NULL,
  xp_awarded    INT  NOT NULL DEFAULT 0,
  completed_at  TIMESTAMPTZ DEFAULT now()
);

-- RLS
ALTER TABLE assessments           ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessment_questions  ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_assessments      ENABLE ROW LEVEL SECURITY;

CREATE POLICY "assessments: public read"
  ON assessments FOR SELECT USING (is_published = true);

CREATE POLICY "assessment_questions: public read"
  ON assessment_questions FOR SELECT USING (true);

CREATE POLICY "user_assessments: own data"
  ON user_assessments FOR ALL USING (auth.uid() = user_id);

-- Increment attempts_count on each completed attempt
CREATE OR REPLACE FUNCTION increment_assessment_attempts()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE assessments SET attempts_count = attempts_count + 1 WHERE id = NEW.assessment_id;
  RETURN NEW;
END;
$$;

CREATE TRIGGER after_user_assessment_insert
  AFTER INSERT ON user_assessments
  FOR EACH ROW EXECUTE FUNCTION increment_assessment_attempts();

-- ============================================================
-- Seed Data: 8 assessments
-- ============================================================

INSERT INTO assessments (title, slug, description, short_description, category, icon_emoji, icon_bg, duration_minutes, question_count, xp_reward, attempts_count, difficulty, tags, order_index) VALUES
(
  'YouSkill Pulse',
  'youskill-pulse',
  'Get a comprehensive snapshot of your digital skills across design, product, engineering, and data. This adaptive assessment measures your abilities across all domains and delivers a personalized learning roadmap. Perfect for anyone starting their learning journey or benchmarking current skills against industry standards.',
  'Benchmark your skills across all domains and get a personalized learning roadmap.',
  'Skills', '🧠', '#7C3AED', 25, 25, 750, 12450, 'All levels',
  ARRAY['General', 'Benchmark'], 0
),
(
  'UX Design Fundamentals',
  'ux-design-fundamentals',
  'Test your understanding of core UX design principles including user research, information architecture, interaction design, and usability testing. This assessment measures how well you apply design thinking to real-world problems and whether you follow established design heuristics and best practices.',
  'Assess your knowledge of UX design principles, research, and usability.',
  'Skills', '🎨', '#DB2777', 25, 25, 750, 8930, 'All levels',
  ARRAY['UX', 'Design'], 1
),
(
  'Product Thinking',
  'product-thinking',
  'Demonstrate your ability to think like a product manager. This assessment covers product strategy, roadmapping, prioritization frameworks, metrics and KPIs, stakeholder management, and the product development lifecycle. Test whether you can identify user problems and build the right solutions.',
  'Test your product strategy, prioritization, and lifecycle management skills.',
  'Skills', '📦', '#0891B2', 25, 25, 750, 6240, 'All levels',
  ARRAY['Product', 'Strategy'], 2
),
(
  'AI & Machine Learning Literacy',
  'ai-ml-literacy',
  'Measure your conceptual understanding of artificial intelligence and machine learning. Topics include supervised vs unsupervised learning, neural networks, LLMs, prompt engineering, AI ethics, and practical AI tool usage. Suitable for non-engineers who want to collaborate effectively with AI systems and teams.',
  'Benchmark your AI/ML conceptual knowledge and practical tool awareness.',
  'Skills', '🤖', '#059669', 25, 25, 750, 9870, 'All levels',
  ARRAY['AI', 'Machine Learning'], 3
),
(
  'Data Analysis',
  'data-analysis',
  'Assess your ability to work with data effectively. This covers data types, statistical concepts, visualization best practices, SQL fundamentals, spreadsheet analysis, and interpreting data insights for decision-making. Test whether you can transform raw data into actionable business intelligence.',
  'Test your data analysis, statistics, and visualization knowledge.',
  'Skills', '📊', '#D97706', 20, 20, 600, 5430, 'All levels',
  ARRAY['Data', 'Analytics'], 4
),
(
  'Digital Marketing',
  'digital-marketing',
  'Evaluate your marketing knowledge across SEO, paid advertising, content marketing, social media strategy, email marketing, and analytics. This assessment tests your understanding of the modern marketing funnel, campaign optimization, and how to drive measurable growth for products and brands.',
  'Benchmark your digital marketing knowledge across SEO, ads, and analytics.',
  'Skills', '📈', '#EA580C', 20, 20, 600, 4120, 'All levels',
  ARRAY['Marketing', 'Growth'], 5
),
(
  'Figma Essentials',
  'figma-essentials',
  'Test your proficiency with Figma — the industry-standard design tool. This assessment covers components, auto layout, prototyping, design systems, collaboration features, variables, and plugins. See how your Figma skills stack up against designers worldwide.',
  'Measure your Figma proficiency from basics to advanced features.',
  'Tools', '🖌️', '#F43F5E', 20, 25, 600, 11340, 'All levels',
  ARRAY['Figma', 'Design Tools'], 6
),
(
  'SQL Fundamentals',
  'sql-fundamentals',
  'Assess your SQL knowledge from basic SELECT queries to complex JOINs, subqueries, aggregations, and window functions. This assessment tests whether you can write queries to extract insights from relational databases — an essential skill for analysts, engineers, and product managers.',
  'Test your SQL skills from basic queries to joins and aggregations.',
  'Tools', '🗄️', '#1D4ED8', 20, 20, 600, 3890, 'All levels',
  ARRAY['SQL', 'Databases'], 7
);

-- ============================================================
-- Seed Questions (5 per assessment for development)
-- Production: add full 25-question sets via admin panel
-- ============================================================

-- YouSkill Pulse
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('Which methodology emphasizes iterative development and continuous user feedback?', 'Waterfall', 'Agile', 'Six Sigma', 'Prince2', 'b', 'Agile methodology emphasizes iterative cycles (sprints) and continuous feedback loops with users and stakeholders.', 0),
  ('A/B testing is primarily used to:', 'Debug software', 'Compare two versions of a feature to determine which performs better', 'Train machine learning models', 'Manage project timelines', 'b', 'A/B testing splits users between two variants and measures which achieves better outcomes on defined metrics.', 1),
  ('What does "North Star Metric" mean?', 'The most important metric that best captures the core value your product delivers to customers', 'A metric used only by startups', 'The total revenue of a company', 'A navigation tool for product teams', 'a', 'The North Star Metric is the single metric that best captures the core value your product delivers to customers.', 2),
  ('Which type of data is collected through surveys and interviews?', 'Quantitative data', 'Qualitative data', 'Structured data', 'Time-series data', 'b', 'Qualitative data is descriptive and collected through methods like interviews, surveys, and observations.', 3),
  ('What is "technical debt"?', 'Money owed to software vendors', 'The cost of shortcuts taken during development that must be addressed later', 'Server infrastructure costs', 'A type of software license', 'b', 'Technical debt refers to the implied cost of future rework caused by choosing a quick solution now instead of a better approach.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'youskill-pulse';

-- UX Design Fundamentals
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('Which of Nielsen''s 10 usability heuristics states that the system should always keep users informed?', 'User control and freedom', 'Visibility of system status', 'Error prevention', 'Consistency and standards', 'b', 'Visibility of system status means the system should always keep users informed about what is going on through appropriate feedback.', 0),
  ('What is the primary purpose of a user persona?', 'To decorate the design brief', 'To represent a fictional but research-based character that embodies key user traits', 'To track developer progress', 'To document technical requirements', 'b', 'Personas are fictional characters created based on research to represent different user types that might use your product.', 1),
  ('Card sorting is used to:', 'Test visual design', 'Understand how users mentally categorize information', 'Measure loading speed', 'Prototype interactions', 'b', 'Card sorting is a UX research method where users organize topics into categories, helping designers create intuitive information architectures.', 2),
  ('What does "affordance" mean in UX design?', 'The cost of design tools', 'A design element''s ability to suggest how it should be used', 'The time required to complete a task', 'A type of user research', 'b', 'An affordance is a property of an object or environment that suggests how it should be used — like a button that looks clickable.', 3),
  ('The "F-pattern" in web reading behavior means users:', 'Read every word on a page', 'Scan content horizontally then vertically, forming an F shape', 'Only read the footer', 'Read from bottom to top', 'b', 'Eye-tracking studies show users scan web pages in an F-shaped pattern: two horizontal movements and one vertical movement.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'ux-design-fundamentals';

-- Product Thinking
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('The RICE scoring framework stands for:', 'Revenue, Impact, Cost, Efficiency', 'Reach, Impact, Confidence, Effort', 'Risk, Innovation, Complexity, Experience', 'Research, Iteration, Clarity, Execution', 'b', 'RICE = Reach (users affected) × Impact × Confidence ÷ Effort. It helps prioritize features objectively.', 0),
  ('What is a "jobs-to-be-done" framework?', 'A hiring process framework', 'A framework focusing on the functional and emotional jobs users hire a product to do', 'A project management tool', 'A performance review system', 'b', 'JTBD focuses on understanding the underlying motivations (jobs) that drive users to adopt or switch products.', 1),
  ('Product-market fit means:', 'Your product is built with the latest technology', 'Your product satisfies a strong market demand', 'You have more features than competitors', 'Your team is happy with the product', 'b', 'Product-market fit is when your product satisfies a strong market need, evidenced by organic growth and user retention.', 2),
  ('A "minimum viable product" (MVP) is:', 'The cheapest product you can build', 'A version with just enough features to validate core assumptions with real users', 'A fully featured beta release', 'An internal prototype', 'b', 'An MVP has only the core features needed to test your riskiest assumptions with actual users, minimizing wasted effort.', 3),
  ('OKRs stand for:', 'Operations, Knowledge, Resources', 'Objectives and Key Results', 'Output, KPIs, Reviews', 'Opportunities, Knowledge, Risks', 'b', 'OKRs (Objectives and Key Results) is a goal-setting framework that defines what you want to achieve and how you''ll measure success.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'product-thinking';

-- AI & ML Literacy
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('What is a "large language model" (LLM)?', 'A very large spreadsheet', 'A neural network trained on vast amounts of text to understand and generate human language', 'A database of language rules', 'A translation service', 'b', 'LLMs are deep learning models trained on large text corpora that can generate, summarize, translate, and reason about text.', 0),
  ('Supervised learning requires:', 'Unlabeled data only', 'Labeled training data with known inputs and correct outputs', 'No training data', 'Only images', 'b', 'Supervised learning trains models on labeled examples (input-output pairs) so the model learns to predict outputs for new inputs.', 1),
  ('What is "hallucination" in the context of AI?', 'A visual effect in image generation', 'When an AI model generates confident but factually incorrect information', 'Dreaming in neural networks', 'A training technique', 'b', 'AI hallucination refers to when a model generates plausible-sounding but incorrect or fabricated information with false confidence.', 2),
  ('"Prompt engineering" refers to:', 'Writing code for AI systems', 'Crafting effective inputs to guide AI models toward desired outputs', 'Building AI hardware', 'Managing AI teams', 'b', 'Prompt engineering is the practice of designing and optimizing prompts (inputs) to get better, more reliable outputs from AI models.', 3),
  ('What is "fine-tuning" an AI model?', 'Adjusting a model''s visual output', 'Further training a pre-trained model on domain-specific data to improve performance', 'Reducing model size', 'Translating model weights', 'b', 'Fine-tuning takes a pre-trained model and continues training it on a smaller, task-specific dataset to specialize its capabilities.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'ai-ml-literacy';

-- Data Analysis
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('What does "variance" measure in statistics?', 'The middle value in a dataset', 'The spread of data points around the mean', 'The most frequent value', 'The difference between max and min', 'b', 'Variance measures how far data points are spread from the mean. High variance = data is spread out; low variance = data is clustered.', 0),
  ('A scatter plot is best used to:', 'Show distribution of a single variable', 'Reveal the relationship between two continuous variables', 'Display part-to-whole relationships', 'Show trends over time', 'b', 'Scatter plots display two variables as points on X/Y axes, making correlations, clusters, and outliers visible.', 1),
  ('What is a "cohort analysis"?', 'Analyzing all users at once', 'Grouping users by a shared characteristic or time of acquisition to track their behavior over time', 'A method for cleaning data', 'A type of A/B test', 'b', 'Cohort analysis groups users (e.g., by signup month) to compare their behavior and retention patterns over time.', 2),
  ('The p-value in hypothesis testing represents:', 'The probability the hypothesis is true', 'The probability of observing results as extreme as the data, assuming the null hypothesis is true', 'The sample size needed', 'Statistical power', 'b', 'The p-value tells you how likely your observed results would occur if the null hypothesis were true. Low p-value (< 0.05) suggests statistical significance.', 3),
  ('What does ETL stand for?', 'Edit, Transform, Load', 'Extract, Transform, Load', 'Evaluate, Test, Launch', 'Export, Translate, Link', 'b', 'ETL (Extract, Transform, Load) is the process of extracting data from sources, transforming it to fit requirements, and loading it into a target system.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'data-analysis';

-- Digital Marketing
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('What does CTR stand for in digital marketing?', 'Content Transfer Rate', 'Click-Through Rate', 'Customer Transaction Revenue', 'Channel Traffic Ranking', 'b', 'CTR (Click-Through Rate) = (Clicks / Impressions) × 100. It measures how often people click an ad or link after seeing it.', 0),
  ('In SEO, "backlinks" refer to:', 'Internal links within your website', 'Links from other websites pointing to your site', 'Broken links on your site', 'Navigation links', 'b', 'Backlinks are links from external websites to yours. High-quality backlinks signal authority and improve search engine rankings.', 1),
  ('The marketing funnel stages in order are:', 'Purchase, Awareness, Interest, Decision', 'Awareness, Interest, Decision, Action', 'Action, Decision, Interest, Awareness', 'Interest, Awareness, Action, Decision', 'b', 'The AIDA funnel: Awareness → Interest → Decision → Action represents the customer journey from discovery to purchase.', 2),
  ('What is "retargeting" in digital advertising?', 'Re-publishing old content', 'Showing ads to users who have previously visited your website or engaged with your brand', 'Targeting a new demographic', 'Running ads on multiple channels simultaneously', 'b', 'Retargeting (remarketing) uses cookies to show targeted ads to people who have previously interacted with your website or content.', 3),
  ('CAC stands for:', 'Content Acquisition Cost', 'Customer Acquisition Cost', 'Channel Analytics Count', 'Campaign Attribution Code', 'b', 'Customer Acquisition Cost (CAC) = Total marketing & sales spend ÷ New customers acquired. It tells you how much it costs to acquire one customer.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'digital-marketing';

-- Figma Essentials
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('In Figma, "Auto Layout" is primarily used for:', 'Automatic color selection', 'Creating responsive frames that resize dynamically based on their content', 'Auto-generating content', 'Organizing layers alphabetically', 'b', 'Auto Layout makes frames resize and reflow automatically when content changes — essential for building responsive components.', 0),
  ('What is a "component" in Figma?', 'A plugin', 'A reusable design element that can be instantiated multiple times — changes to the main component propagate to all instances', 'A prototype interaction', 'A color style', 'b', 'Components are reusable building blocks. Edit the main component and all instances update automatically, enabling consistent design systems.', 1),
  ('Figma "variables" can store:', 'Only color values', 'Colors, numbers, strings, and booleans — used to power design tokens and theming', 'Only text strings', 'Only spacing values', 'b', 'Figma variables store design tokens (colors, numbers, strings, booleans) and can be scoped to different modes like light/dark theme.', 2),
  ('To detach an instance from its main component, you use:', 'Delete and recreate', 'Right-click → Detach instance', 'Cmd/Ctrl + D', 'Edit → Unlink', 'b', 'Right-click on a component instance and select "Detach instance" to break the link from the main component, making it independently editable.', 3),
  ('What is the difference between a Frame and a Group in Figma?', 'They are identical', 'Frames have layout properties (auto layout, constraints, clip content) while Groups are simple containers with no layout properties', 'Groups are larger than Frames', 'Frames can only contain text', 'b', 'Frames are powerful layout containers with constraints, auto layout, and clip content. Groups are simple containers that just hold elements together.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'figma-essentials';

-- SQL Fundamentals
INSERT INTO assessment_questions (assessment_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, order_index)
SELECT id, q, a, b, c, d, ans, exp, idx FROM assessments, (VALUES
  ('Which SQL clause filters rows AFTER grouping?', 'WHERE', 'HAVING', 'FILTER', 'GROUP BY', 'b', 'HAVING filters groups after GROUP BY aggregation. WHERE filters individual rows before grouping.', 0),
  ('What does SELECT DISTINCT do?', 'Selects only NULL values', 'Returns only unique rows, eliminating duplicates', 'Selects the first row', 'Counts distinct values', 'b', 'SELECT DISTINCT eliminates duplicate rows from the result set, returning only unique combinations of selected columns.', 1),
  ('A LEFT JOIN returns:', 'Only matching rows from both tables', 'All rows from the left table plus matching rows from the right table (NULLs for non-matches)', 'All rows from the right table', 'Only non-matching rows', 'b', 'LEFT JOIN returns all rows from the left table. Rows with no match in the right table get NULL values for right table columns.', 2),
  ('Which aggregate function counts non-NULL values?', 'SUM()', 'COUNT(column_name)', 'AVG()', 'MAX()', 'b', 'COUNT(column_name) counts non-NULL values. COUNT(*) counts all rows including NULLs. SUM/AVG/MAX ignore NULLs.', 3),
  ('What does the ORDER BY clause do without specifying ASC or DESC?', 'Sorts in random order', 'Sorts in ascending order (ASC is the default)', 'Sorts in descending order', 'Does not sort', 'b', 'Without specifying ASC or DESC, ORDER BY defaults to ascending (ASC) order.', 4)
) AS t(q, a, b, c, d, ans, exp, idx)
WHERE assessments.slug = 'sql-fundamentals';
