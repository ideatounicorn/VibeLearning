-- ============================================
-- SEED DATA: Categories & Sub-skills
-- Run this AFTER supabase_schema.sql
-- Run this BEFORE any question insert scripts
-- ============================================

-- ============================================
-- INSERT CATEGORIES
-- ============================================

INSERT INTO categories (name, slug, description, display_order) VALUES
('Product Sense',           'product-sense',        'Understanding users, market, and problems deeply', 1),
('Product Strategy',        'product-strategy',     'Defining product vision and driving strategy', 2),
('Product Analytics',       'product-analytics',    'Using data to drive product decisions', 3),
('User Experience',         'user-experience',      'Designing great user experiences', 4),
('Execution',               'execution',            'Building, launching, and iterating products', 5),
('Leadership',              'leadership',           'Leading teams and influencing stakeholders', 6),
('Tools & Technologies',    'tools-technologies',   'Tools and frameworks used in PM', 7);

-- ============================================
-- INSERT SUB-SKILLS: Product Sense
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('User Research',       'user-research',        'Conducting user interviews, surveys, field studies, synthesizing qualitative and quantitative user insights', 1),
    ('Problem Framing',     'problem-framing',      'Defining the right problem to solve, structuring ambiguous problems, root cause analysis', 2),
    ('Market Sizing',       'market-sizing',        'TAM/SAM/SOM estimation, bottom-up and top-down sizing, market opportunity analysis', 3),
    ('Product Intuition',   'product-intuition',    'Developing taste for good products, evaluating product decisions, predicting user behavior', 4),
    ('Competitive Analysis','competitive-analysis',  'Analyzing competitors, moats, positioning, market dynamics, disruption patterns', 5),
    ('Opportunity Sizing',  'opportunity-sizing',    'Estimating impact of features/initiatives, cost-benefit analysis, business case development', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'product-sense';

-- ============================================
-- INSERT SUB-SKILLS: Product Strategy
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('Product Vision',          'product-vision',           'Crafting compelling product vision, aligning teams around a north star, long-term thinking', 1),
    ('Roadmapping',             'roadmapping',              'Building and maintaining product roadmaps, balancing short/long term, communicating timelines', 2),
    ('Go-to-Market Strategy',   'go-to-market-strategy',    'Launch planning, market entry, positioning, channel strategy, pricing models', 3),
    ('OKRs',                    'okrs',                     'Setting objectives and key results, cascading goals, measuring progress, OKR anti-patterns', 4),
    ('Prioritization (RICE)',   'prioritization-rice',      'RICE, ICE, MoSCoW, Kano, value-vs-effort frameworks, stakeholder alignment on priorities', 5),
    ('Portfolio Prioritization','portfolio-prioritization',  'Managing a portfolio of products/bets, resource allocation across products, kill decisions', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'product-strategy';

-- ============================================
-- INSERT SUB-SKILLS: Product Analytics
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('SQL',                 'sql',                  'Writing and interpreting SQL queries for product analysis, joins, aggregations, window functions', 1),
    ('Analytics & KPIs',    'analytics-kpis',       'Defining metrics, KPI trees, North Star metrics, leading/lagging indicators, counter-metrics', 2),
    ('A/B Testing',         'ab-testing',           'Experiment design, statistical significance, sample sizing, SUTVA, novelty effects, guardrails', 3),
    ('Cohort Analysis',     'cohort-analysis',      'Retention cohorts, behavioral cohorts, composition effects, lifecycle analysis', 4),
    ('Funnel Analysis',     'funnel-analysis',      'Conversion funnels, drop-off diagnosis, funnel quality vs. quantity, session definition', 5),
    ('Advanced Statistics', 'advanced-statistics',   'Bayesian methods, causal inference, regression, significance testing, statistical pitfalls', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'product-analytics';

-- ============================================
-- INSERT SUB-SKILLS: User Experience
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('User Personas',           'user-personas',            'Creating data-driven personas, jobs-to-be-done, segmentation, persona-driven design decisions', 1),
    ('Journey Mapping',         'journey-mapping',          'End-to-end user journey mapping, touchpoints, pain points, moments of truth', 2),
    ('Wireframing',             'wireframing',              'Low/high fidelity wireframing, information hierarchy, layout decisions, iterative design', 3),
    ('Usability Testing',       'usability-testing',        'Test planning, moderated/unmoderated testing, task analysis, interpreting usability findings', 4),
    ('Information Architecture','information-architecture',  'Navigation design, card sorting, tree testing, content structure, wayfinding', 5),
    ('Design Systems',          'design-systems',            'Component libraries, design tokens, consistency at scale, working with design systems', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'user-experience';

-- ============================================
-- INSERT SUB-SKILLS: Execution
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('Agile / Scrum',               'agile-scrum',              'Sprint planning, ceremonies, backlog management, velocity, estimation, agile anti-patterns', 1),
    ('Product Launch',              'product-launch',            'Launch checklists, phased rollouts, beta programs, launch metrics, post-launch review', 2),
    ('Feature Delivery',            'feature-delivery',          'PRDs, acceptance criteria, edge cases, technical tradeoffs, shipping iteratively', 3),
    ('Cross-functional Management', 'cross-functional-mgmt',     'Working with engineering, design, data science, marketing, legal without direct authority', 4),
    ('QA & UAT',                    'qa-uat',                    'Quality assurance processes, user acceptance testing, bug triage, regression testing', 5),
    ('Technical Documentation',     'technical-documentation',   'Writing specs, API documentation, internal wikis, decision logs, RFC processes', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'execution';

-- ============================================
-- INSERT SUB-SKILLS: Leadership
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('Stakeholder Management',       'stakeholder-management',       'Managing up, executive communication, expectation setting, alignment across orgs', 1),
    ('Communication',                'communication',                'Written and verbal communication, storytelling with data, presenting to executives', 2),
    ('Team Leadership',              'team-leadership',              'Building high-performing teams, delegation, motivation, team culture', 3),
    ('Influencing Without Authority','influencing-without-authority', 'Persuasion, building coalitions, navigating organizational dynamics, getting buy-in', 4),
    ('Conflict Resolution',          'conflict-resolution',          'Handling disagreements, mediating between teams, navigating priority conflicts', 5),
    ('Coaching & Mentoring',         'coaching-mentoring',           'Developing junior PMs, giving feedback, career development, creating growth plans', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'leadership';

-- ============================================
-- INSERT SUB-SKILLS: Tools & Technologies
-- ============================================

INSERT INTO sub_skills (category_id, name, slug, description, display_order)
SELECT c.id, s.name, s.slug, s.description, s.display_order
FROM categories c
CROSS JOIN (VALUES
    ('Jira',        'jira',         'Project tracking, epic/story management, workflows, JQL, board configuration', 1),
    ('Confluence',  'confluence',   'Documentation, knowledge management, templates, spaces, collaborative editing', 2),
    ('Mixpanel',    'mixpanel',     'Event tracking, funnels, retention reports, user segmentation, behavioral analytics', 3),
    ('Amplitude',   'amplitude',    'Product analytics, behavioral cohorting, experiment analysis, data taxonomy', 4),
    ('Notion',      'notion-tool',  'Workspace organization, databases, templates, team wikis, project management', 5),
    ('Figma',       'figma-tool',   'Design collaboration, prototyping, design reviews, dev handoff, component inspection', 6)
) AS s(name, slug, description, display_order)
WHERE c.slug = 'tools-technologies';

-- ============================================
-- VERIFY SEED DATA
-- ============================================

SELECT 
    c.name AS category,
    COUNT(ss.id) AS sub_skill_count
FROM categories c
LEFT JOIN sub_skills ss ON ss.category_id = c.id
GROUP BY c.name, c.display_order
ORDER BY c.display_order;

-- Expected output:
-- Product Sense        | 6
-- Product Strategy     | 6
-- Product Analytics    | 6
-- User Experience      | 6
-- Execution            | 6
-- Leadership           | 6
-- Tools & Technologies | 6
