-- ============================================
-- QUESTION BANK: Product Sense → Problem Framing
-- 35 MCQ Questions (10 Foundational, 18 Intermediate, 7 Advanced)
-- Run AFTER 01_schema.sql and 02_seed_categories.sql
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_q_id UUID;
BEGIN
    SELECT id INTO v_sub_skill_id FROM sub_skills WHERE slug = 'problem-framing';
    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill "problem-framing" not found. Run 02_seed_categories.sql first.';
    END IF;

    -- ============================================
    -- FOUNDATIONAL QUESTIONS (Q1–Q10)
    -- ============================================

    -- QUESTION 1 (Foundational) — Symptom vs Root Cause
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 1,
        'Netflix''s Declining Engagement',
        'You are a PM at Netflix. Your VP tells you, "Users are canceling their subscriptions at a higher rate this quarter." You look at the data and see that cancellations spiked among users who signed up during a promotional period. What is the most important first step?',
        'foundational', 'Netflix', 'Streaming platform subscription retention',
        'B',
        'The VP has identified a symptom—rising cancellation rates—but the underlying cause is unclear. Before jumping to solutions like improving content or adjusting pricing, a strong PM distinguishes between the symptom (cancellations) and the root cause (why those specific users are leaving). Option B is correct because investigating the behavior and expectations of promo-signup users will reveal whether the problem is price sensitivity, content mismatch, or something else entirely. Option A skips diagnosis and jumps to a solution. Option C treats a secondary metric as the core problem. Option D addresses retention generically without understanding the specific cohort''s issues.',
        ARRAY['symptom_vs_cause', 'root_cause_analysis', 'problem_definition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 1;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Immediately propose a content refresh to make the library more appealing to returning users', false),
        (v_q_id, 'B', 'Investigate why promo-signup users are canceling by analyzing their viewing patterns and sign-up expectations', true),
        (v_q_id, 'C', 'Focus on improving the onboarding flow since first impressions drive long-term retention', false),
        (v_q_id, 'D', 'Launch a win-back campaign offering discounts to users who recently canceled', false);

    -- QUESTION 2 (Foundational) — Problem Space vs Solution Space
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 2,
        'Spotify''s Feature Request Trap',
        'You are a PM at Spotify. A product designer proposes: "We should add a social feed where users can see what their friends are listening to in real time." Several engineers are excited about the idea. As the PM, what is your most important response?',
        'foundational', 'Spotify', 'Music streaming social features',
        'C',
        'The designer has jumped directly into solution space (a social feed) without articulating the user problem it solves. A strong PM pulls the conversation back to problem space by asking what user need this feature addresses. Option C is correct because it regrounds the discussion in the problem before evaluating the solution. Option A accepts the solution without validating the problem. Option B evaluates feasibility prematurely—feasibility matters, but only after the problem is validated. Option D introduces competitive analysis which, while useful, doesn''t address whether the underlying problem exists for Spotify''s users.',
        ARRAY['problem_space', 'solution_space', 'problem_definition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 2;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Approve the project since team enthusiasm signals strong product-market fit', false),
        (v_q_id, 'B', 'Ask the engineering team to estimate the development effort before committing', false),
        (v_q_id, 'C', 'Ask what specific user problem this feature solves and what evidence supports that the problem exists', true),
        (v_q_id, 'D', 'Research whether competitors like Apple Music or YouTube Music have similar features', false);

    -- QUESTION 3 (Foundational) — User Problem vs Business Problem
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 3,
        'Uber''s Driver Earnings Complaint',
        'You are a PM at Uber. Driver satisfaction scores have dropped 15% over the past quarter. The operations team says, "Drivers are complaining about low earnings." The finance team says, "We need to maintain our take rate to hit revenue targets." How should you frame this problem?',
        'foundational', 'Uber', 'Ride-sharing marketplace for riders and drivers',
        'A',
        'This scenario presents a tension between a user problem (driver earnings) and a business problem (revenue targets). A strong PM recognizes that these aren''t competing problems—they''re interconnected parts of a marketplace. Option A is correct because framing the problem as a marketplace balance issue opens up solutions that could help both sides (e.g., increasing ride volume, reducing idle time). Option B only addresses the business side. Option C oversimplifies by treating it as purely a driver problem. Option D jumps to a specific solution without properly framing the problem.',
        ARRAY['user_vs_business_problem', 'problem_definition', 'problem_space']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 3;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Frame it as a marketplace health problem: how can we increase driver earnings per hour without reducing Uber''s revenue per ride?', true),
        (v_q_id, 'B', 'Frame it as a revenue optimization problem: how do we maintain take rates while keeping drivers from churning?', false),
        (v_q_id, 'C', 'Frame it as a driver satisfaction problem: how do we make drivers feel their compensation is fair?', false),
        (v_q_id, 'D', 'Propose reducing Uber''s take rate by 3% and measuring whether driver satisfaction improves', false);

    -- QUESTION 4 (Foundational) — Identifying Assumptions
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 4,
        'Slack''s Enterprise Expansion',
        'You are a PM at Slack. Your Head of Product says: "We need to build an AI meeting summarizer because enterprise customers keep asking for it." Before committing resources, what hidden assumption should you validate first?',
        'foundational', 'Slack', 'Enterprise communication and collaboration platform',
        'D',
        'The Head of Product''s request contains several hidden assumptions: that enterprise customers actually need meeting summarization (not just requesting it), that they''d use it inside Slack rather than a dedicated tool, and that this is the highest-priority problem for enterprise adoption. Option D is correct because it surfaces the most critical assumption—whether the feature request reflects a genuine unmet need or is simply a checkbox item. Option A assumes the problem is validated and jumps to competitive analysis. Option B skips problem validation entirely and goes to solution design. Option C is useful but addresses a secondary question—how many people want it—rather than whether it solves a real problem.',
        ARRAY['assumption_testing', 'problem_definition', 'problem_space']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 4;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Research competitive AI summarization tools to see if Slack can differentiate', false),
        (v_q_id, 'B', 'Start prototyping to test the concept with a small group of enterprise users', false),
        (v_q_id, 'C', 'Survey enterprise customers to quantify demand for the feature', false),
        (v_q_id, 'D', 'Investigate whether enterprise customers would actually use an AI summarizer in Slack or if the request masks a different underlying workflow problem', true);

    -- QUESTION 5 (Foundational) — Five Whys Technique
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 5,
        'Instagram''s Posting Decline',
        'You are a PM at Instagram. Data shows that the number of new posts per user has declined 20% year-over-year. Your team applies the 5 Whys technique. Which of the following represents the best application of this approach?',
        'foundational', 'Instagram', 'Photo and video sharing social media platform',
        'B',
        'The 5 Whys technique involves iteratively asking "why" to move from a surface-level symptom to the root cause. Option B is correct because it demonstrates a proper causal chain: fewer posts → users prefer Stories → Stories feel lower commitment → posting a photo feels too "permanent" → users fear judgment on grid posts. This chain reveals an actionable root cause. Option A stops at the first "why" and immediately jumps to a solution. Option C confuses correlation (more users equals fewer posts per user) with causation. Option D applies the technique too broadly and ends up in strategic territory rather than an actionable root cause.',
        ARRAY['five_whys', 'root_cause_analysis', 'symptom_vs_cause']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 5;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Ask "why are posts declining?" once, conclude it''s because of TikTok competition, and propose short-form video improvements', false),
        (v_q_id, 'B', 'Trace the chain: fewer posts → users shifting to Stories → Stories feel lower commitment → posting to the grid feels permanent → users fear judgment on permanent posts', true),
        (v_q_id, 'C', 'Attribute the decline to user base growth diluting per-user posting averages and adjust the metric to control for cohort size', false),
        (v_q_id, 'D', 'Ask "why" five times and conclude that Instagram''s overall value proposition is weakening relative to competitors', false);

    -- QUESTION 6 (Foundational) — Jumping to Solutions
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 6,
        'Airbnb''s Booking Abandonment',
        'You are a PM at Airbnb. The CEO says in a meeting: "Our checkout abandonment rate is too high. We need to simplify the checkout flow to three steps." What is the biggest problem framing mistake the CEO is making?',
        'foundational', 'Airbnb', 'Online marketplace for lodging and experiences',
        'C',
        'The CEO has committed a classic problem framing error: jumping from a symptom (high abandonment) directly to a solution (three-step checkout) without understanding the root cause. The real reason users abandon checkout could be price shock, trust issues, complex cancellation policies, or many other factors—not necessarily checkout complexity. Option C is correct because it identifies the core mistake: conflating a symptom with a diagnosis and prescribing a solution prematurely. Option A is incorrect because CEO involvement isn''t the problem. Option B is wrong because the metric itself is valid—it''s the leap to a solution that''s problematic. Option D is a secondary concern about scope.',
        ARRAY['problem_definition', 'symptom_vs_cause', 'solution_space']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 6;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'The CEO is making product decisions that should be left to the PM team', false),
        (v_q_id, 'B', 'Checkout abandonment rate is the wrong metric to track for Airbnb''s business model', false),
        (v_q_id, 'C', 'The CEO is prescribing a solution (simplify checkout) without first diagnosing why users are abandoning', true),
        (v_q_id, 'D', 'A three-step checkout is too narrow a scope; a complete redesign would be more impactful', false);

    -- QUESTION 7 (Foundational) — Problem Decomposition
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 7,
        'LinkedIn''s Engagement Challenge',
        'You are a PM at LinkedIn. Your VP says: "We need to increase engagement on the platform." This is a broad, ambiguous problem. What is the best way to decompose it into actionable sub-problems?',
        'foundational', 'LinkedIn', 'Professional networking and career development platform',
        'A',
        'When faced with an ambiguous, large problem like "increase engagement," a strong PM decomposes it into specific, measurable sub-problems along user journey stages or behavior types. Option A is correct because it breaks the vague goal into distinct user behaviors (content creation, consumption, interaction, messaging) that can each be independently analyzed and addressed. Option B over-simplifies by using a single metric without understanding what drives it. Option C segments by user type but doesn''t decompose the engagement problem itself. Option D jumps to a competitive benchmarking approach that doesn''t help structure the internal problem.',
        ARRAY['problem_decomposition', 'ambiguity_resolution', 'problem_definition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 7;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Break it down by engagement type: content creation, content consumption, social interaction (likes/comments), and direct messaging—then analyze which is underperforming', true),
        (v_q_id, 'B', 'Define engagement as DAU/MAU ratio and focus on increasing this single metric', false),
        (v_q_id, 'C', 'Segment users into job seekers, recruiters, and content creators, then build features for each', false),
        (v_q_id, 'D', 'Benchmark LinkedIn''s engagement metrics against Facebook and Twitter to identify gaps', false);

    -- QUESTION 8 (Foundational) — Reframing Problems
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 8,
        'Duolingo''s Retention Wall',
        'You are a PM at Duolingo. After analyzing retention curves, you find that 60% of users drop off between days 7 and 14. The team frames the problem as: "Users lose motivation after the initial novelty wears off." A colleague suggests reframing the problem. Which reframe would be most productive?',
        'foundational', 'Duolingo', 'Language learning mobile application',
        'B',
        'The original framing ("users lose motivation") is vague and hard to act on because motivation is an internal state. Option B reframes the problem around an observable behavior—the transition from structured lessons to self-directed learning—which is specific, testable, and solution-rich. This reframe shifts attention from an emotional state to a product design gap. Option A simply changes the metric without changing the framing. Option C narrows to a specific solution (social features) rather than reframing the problem. Option D reframes to external competition, which isn''t supported by the data provided.',
        ARRAY['problem_definition', 'problem_space', 'ambiguity_resolution']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 8;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"Our Day 7-14 retention rate is below industry benchmarks for education apps"', false),
        (v_q_id, 'B', '"Users completing the introductory curriculum lack a clear next step, causing them to disengage before building a habit"', true),
        (v_q_id, 'C', '"Users need more social accountability features to stay engaged past the first week"', false),
        (v_q_id, 'D', '"Competing apps like Babbel are stealing users after their initial Duolingo trial period"', false);

    -- QUESTION 9 (Foundational) — Problem Prioritization
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 9,
        'Notion''s Multiple Problem Paths',
        'You are a PM at Notion. Your team has identified three problems: (1) New users struggle with the blank-page problem during onboarding, (2) Team workspace admins can''t easily manage permissions, and (3) Large documents load slowly on mobile. All three are validated. How should you decide which problem to solve first?',
        'foundational', 'Notion', 'All-in-one workspace for notes, docs, and project management',
        'D',
        'When multiple validated problems compete for resources, a PM must use a structured framework that considers both user impact and business impact. Option D is correct because it evaluates each problem across the most important dimensions: how many users are affected (reach), how severely it impacts them (severity), and how it aligns with strategic goals. Option A picks the most visible problem without rigorous comparison. Option B defaults to the easiest problem, which isn''t always the most impactful. Option C arbitrarily prioritizes one dimension (new users) without evaluating tradeoffs.',
        ARRAY['problem_prioritization', 'problem_decomposition', 'constraint_identification']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 9;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Solve the onboarding problem first because it has the most visible impact on growth metrics', false),
        (v_q_id, 'B', 'Solve the mobile performance problem first because it''s likely the quickest to fix', false),
        (v_q_id, 'C', 'Always prioritize new user problems over existing user problems because acquisition drives growth', false),
        (v_q_id, 'D', 'Evaluate each problem''s reach, severity, and strategic alignment to make a data-informed tradeoff', true);

    -- QUESTION 10 (Foundational) — Confirmation Bias
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 10,
        'Pinterest''s Search Problem Hypothesis',
        'You are a PM at Pinterest. You believe that users abandon search because the results aren''t visually appealing enough. You design a user study to test this hypothesis. Which approach demonstrates confirmation bias in problem definition?',
        'foundational', 'Pinterest', 'Visual discovery and bookmarking platform',
        'A',
        'Confirmation bias in problem definition occurs when a PM designs research that can only confirm their existing hypothesis rather than testing it objectively. Option A is a textbook example: asking users if results are "visually appealing enough" leads them toward the PM''s hypothesis and cannot reveal alternative explanations for search abandonment (e.g., irrelevant results, slow load times, lack of intent match). Option B is a neutral observation method. Option C tests the hypothesis fairly by comparing visual treatment while controlling other variables. Option D explores the problem space openly without presupposing a cause.',
        ARRAY['assumption_testing', 'problem_definition', 'hypothesis_framing']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 10;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Asking users "Do you think search results on Pinterest are visually appealing enough?" in a survey', true),
        (v_q_id, 'B', 'Observing user search sessions to see where they hesitate, abandon, or change queries', false),
        (v_q_id, 'C', 'Running an A/B test comparing current results with a version that enhances visual presentation', false),
        (v_q_id, 'D', 'Conducting open-ended interviews asking users to walk through their last search experience', false);

    -- ============================================
    -- INTERMEDIATE QUESTIONS (Q11–Q28)
    -- ============================================

    -- QUESTION 11 (Intermediate) — Data-Driven Problem Validation
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 11,
        'YouTube''s Watch Time Drop in India',
        'You are a PM at YouTube. Watch time in India dropped 12% month-over-month. Your team offers these hypotheses: (1) A major cricket tournament shifted users to live TV, (2) A recent app update introduced buffering issues on low-end Android devices, (3) Short-form competitors like Instagram Reels gained market share. Which approach best validates the right problem hypothesis?',
        'intermediate', 'YouTube', 'Video streaming platform with 500M+ users in India',
        'B',
        'When multiple plausible hypotheses explain a metric decline, a strong PM uses data segmentation to systematically narrow down the root cause. Option B is correct because segmenting watch time by device type, content category, and user cohort allows you to test all three hypotheses simultaneously. If the drop is concentrated on low-end Android devices, hypothesis 2 is likely. If it''s concentrated in cricket-related content viewers, hypothesis 1 is likely. If it''s uniform across segments, hypothesis 3 gains credibility. Option A picks a single hypothesis without testing. Option C gathers qualitative data that''s slow and may not be representative. Option D addresses a solution before understanding the problem.',
        ARRAY['hypothesis_framing', 'root_cause_analysis', 'problem_definition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 11;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Focus on hypothesis 3 first because competitor pressure is the biggest strategic risk', false),
        (v_q_id, 'B', 'Segment the watch time data by device type, content category, and user cohort to see where the decline is concentrated', true),
        (v_q_id, 'C', 'Run user interviews with Indian users to understand their changing viewing habits', false),
        (v_q_id, 'D', 'Immediately roll back the recent app update to see if watch time recovers', false);

    -- QUESTION 12 (Intermediate) — XY Problem
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 12,
        'Figma''s Export Feature Request',
        'You are a PM at Figma. Enterprise design teams keep requesting the ability to export design files to PowerPoint format. When you investigate further, you discover that designers are being asked by their managers to present design iterations to non-design stakeholders. What type of problem framing issue does this represent?',
        'intermediate', 'Figma', 'Collaborative design tool for UI/UX teams',
        'C',
        'This is a classic XY Problem: users are asking for solution X (PowerPoint export) when their real problem is Y (sharing design work with non-design stakeholders who don''t use Figma). The request for PowerPoint export is a workaround users have already conceived, but it''s not the only or best solution. Option C correctly identifies this as an XY Problem where the stated request masks the real need. Option A takes the request at face value. Option B recognizes the stakeholder need but frames the solution too narrowly. Option D dismisses the request without understanding the underlying problem.',
        ARRAY['problem_definition', 'problem_space', 'solution_space', 'assumption_testing']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 12;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'A feature gap—Figma needs to add PowerPoint export to match competitor capabilities', false),
        (v_q_id, 'B', 'A stakeholder communication problem—Figma should build a presentation mode for non-designers', false),
        (v_q_id, 'C', 'An XY Problem—users are asking for a specific solution (export) when the real problem is enabling non-designer stakeholders to review designs', true),
        (v_q_id, 'D', 'A scope creep issue—Figma shouldn''t try to replace presentation tools', false);

    -- QUESTION 13 (Intermediate) — Jobs-to-be-Done Framework
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 13,
        'Zoom''s Meeting Fatigue Problem',
        'You are a PM at Zoom. Users report "meeting fatigue." Using Jobs-to-be-Done (JTBD) as a problem framing tool, which framing would be most useful for identifying solutions?',
        'intermediate', 'Zoom', 'Video conferencing and virtual meeting platform',
        'B',
        'JTBD frames problems around the job the user is hiring the product to do, not around the product itself. Option B is correct because it frames the job at the right level of abstraction: users don''t want "meetings"—they want to make collaborative decisions and maintain alignment with minimal time investment. This framing opens up solutions beyond just better video calls (e.g., async decision-making tools, structured agendas, auto-summaries). Option A is too product-centric and focuses on the tool rather than the job. Option C frames the problem as a feature request. Option D is a general wellness concern, not an actionable JTBD.',
        ARRAY['problem_definition', 'problem_space', 'problem_decomposition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 13;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"When I use Zoom, I want shorter meetings so I can get back to my real work"', false),
        (v_q_id, 'B', '"When I need to make a collaborative decision with my team, I want to reach alignment with minimal synchronous time so I can focus on deep work"', true),
        (v_q_id, 'C', '"When I schedule a meeting, I want AI-generated agendas so I don''t waste time on unstructured conversations"', false),
        (v_q_id, 'D', '"When my calendar is full of meetings, I want to feel less exhausted at the end of the day"', false);

    -- QUESTION 14 (Intermediate) — Stakeholder Alignment
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 14,
        'Shopify''s Merchant Problem Disagreement',
        'You are a PM at Shopify. The engineering team says the problem is "our checkout is too slow," the design team says "our checkout is confusing," and the data science team says "merchants lose 30% of customers at checkout." All three teams are advocating for different solutions. How should you align these stakeholders around the right problem?',
        'intermediate', 'Shopify', 'E-commerce platform for merchants',
        'D',
        'When stakeholders disagree on the problem, they''re often each seeing a different facet of the same issue. Option D is correct because it uses objective data to create a shared understanding. By analyzing where in the checkout flow users drop off and why, all three teams can converge on the actual problem—which might be speed in some steps, confusion in others, or a combination. Option A picks one team''s framing without evidence. Option B is diplomatic but doesn''t resolve the disagreement. Option C avoids the conflict by running separate workstreams, which wastes resources and doesn''t build alignment.',
        ARRAY['stakeholder_alignment', 'problem_definition', 'root_cause_analysis']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 14;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Defer to the engineering team since performance issues are objectively measurable', false),
        (v_q_id, 'B', 'Ask each team to present their case and vote on the most compelling problem statement', false),
        (v_q_id, 'C', 'Let each team pursue their own solution in parallel and see which has the most impact', false),
        (v_q_id, 'D', 'Map the checkout funnel data to identify exactly where and why drop-offs occur, then align all teams around the evidence', true);

    -- QUESTION 15 (Intermediate) — Constraint Identification
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 15,
        'Twitter''s Misinformation Challenge',
        'You are a PM at Twitter (now X). You''re tasked with "reducing misinformation on the platform." Before defining the problem further, what is the most critical constraint you need to identify?',
        'intermediate', 'Twitter/X', 'Social media platform for public discourse',
        'B',
        'Every problem exists within constraints, and identifying the right constraints is essential to framing a solvable problem. For misinformation, the most critical constraint is the tension between free expression and content accuracy—this fundamentally shapes what solutions are even viable. Option B is correct because without clarifying this constraint, you can''t define what "reducing misinformation" actually means in practice. Option A focuses on a technical constraint that''s important but secondary to the philosophical one. Option C introduces a valid metric concern but isn''t a constraint on the problem itself. Option D addresses resource constraints, which are always relevant but don''t shape the problem definition as fundamentally.',
        ARRAY['constraint_identification', 'problem_definition', 'ambiguity_resolution']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 15;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Whether the AI models can accurately detect misinformation at scale', false),
        (v_q_id, 'B', 'The acceptable tradeoff between limiting misinformation and preserving freedom of expression on the platform', true),
        (v_q_id, 'C', 'How to measure misinformation accurately enough to set a meaningful KPI', false),
        (v_q_id, 'D', 'The budget and team size available for content moderation', false);

    -- QUESTION 16 (Intermediate) — Problem Framing with Data
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 16,
        'DoorDash''s Delivery Time Complaints',
        'You are a PM at DoorDash. Customer support tickets about "late deliveries" increased 40% last month. You pull the data and discover: average delivery time actually decreased by 2 minutes, but the estimated delivery time shown to users became 5 minutes more aggressive. What is the real problem?',
        'intermediate', 'DoorDash', 'Food delivery marketplace platform',
        'C',
        'This scenario uses data to reveal that the symptom (complaints about late deliveries) doesn''t match the surface-level assumption (deliveries are getting slower). The real problem is an expectation gap—deliveries are actually faster, but the estimated times shown to users set unrealistic expectations. Option C correctly identifies the root cause: the problem isn''t delivery speed but expectation management. Option A misidentifies the problem because actual delivery times improved. Option B is a valid concern but not what the data shows. Option D treats the symptom (support tickets) rather than the cause.',
        ARRAY['symptom_vs_cause', 'root_cause_analysis', 'hypothesis_framing']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 16;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Delivery logistics are getting worse and the operations team needs to optimize routing', false),
        (v_q_id, 'B', 'Customers have become more demanding about delivery speed over time', false),
        (v_q_id, 'C', 'The estimated delivery time algorithm is setting unrealistic expectations, creating a perception gap even though actual speed improved', true),
        (v_q_id, 'D', 'Customer support needs better tools to handle the increased volume of delivery complaints', false);

    -- QUESTION 17 (Intermediate) — Problem Decomposition with Data
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 17,
        'Dropbox''s Conversion Problem',
        'You are a PM at Dropbox. Free-to-paid conversion dropped from 4.2% to 3.1% over six months. You decompose the conversion funnel and find: sign-up → activation (unchanged at 65%), activation → storage limit hit (dropped from 40% to 28%), storage limit hit → payment (unchanged at 25%). Where should you focus your problem framing?',
        'intermediate', 'Dropbox', 'Cloud storage and file sharing platform',
        'B',
        'The data clearly shows that the conversion drop is concentrated in one stage: users going from activated to hitting their storage limit. The other stages (activation and payment conversion) are stable. Option B is correct because it focuses the problem on the specific stage that changed—fewer activated users are reaching their storage limit, which means they''re either storing less or finding alternative ways to manage storage. Option A addresses a stage that hasn''t changed. Option C assumes the solution (lower the limit) rather than understanding the problem. Option D broadens the problem unnecessarily when the data points to a specific stage.',
        ARRAY['problem_decomposition', 'root_cause_analysis', 'hypothesis_framing']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 17;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Why users who hit the storage limit aren''t converting to paid—the payment flow may have friction', false),
        (v_q_id, 'B', 'Why fewer activated users are reaching their storage limit—user behavior or use case may have shifted', true),
        (v_q_id, 'C', 'Whether the free storage limit should be lowered to push more users toward hitting it', false),
        (v_q_id, 'D', 'Whether the overall pricing strategy needs adjustment given market competition from Google Drive', false);

    -- QUESTION 18 (Intermediate) — Hypothesis-Driven Problem Definition
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 18,
        'Stripe''s Integration Abandonment',
        'You are a PM at Stripe. 35% of developers who start integrating Stripe''s payment API abandon the process before completing it. You need to frame a hypothesis about why. Which is the strongest hypothesis?',
        'intermediate', 'Stripe', 'Payment infrastructure for internet businesses',
        'C',
        'A strong hypothesis is specific, testable, and based on observable behavior. Option C is the best hypothesis because it specifies a testable mechanism (documentation doesn''t cover common edge cases), a measurable behavior (seeking help externally), and suggests a falsifiable prediction (we should see spikes in abandonment correlated with complex API endpoints). Option A is too vague—"too difficult" isn''t specific enough to test or act on. Option B proposes a hypothesis about competition that doesn''t explain mid-integration abandonment. Option D assumes the problem is pricing, but developers who abandon mid-integration have likely already accepted the pricing.',
        ARRAY['hypothesis_framing', 'problem_definition', 'root_cause_analysis']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 18;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"The API is too difficult for most developers to integrate, so we need to make it simpler"', false),
        (v_q_id, 'B', '"Developers are choosing competitor payment providers mid-integration due to better features"', false),
        (v_q_id, 'C', '"Developers get stuck at specific integration steps where documentation doesn''t cover common edge cases, causing them to seek help externally and eventually abandon"', true),
        (v_q_id, 'D', '"Stripe''s pricing becomes apparent during integration, causing developers to reconsider the cost"', false);

    -- QUESTION 19 (Intermediate) — Problem Reframing
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 19,
        'Google Maps'' Navigation Accuracy',
        'You are a PM at Google Maps. Users in suburban areas report that "navigation is inaccurate." User research reveals that the GPS-based routing is actually correct, but users feel lost because suburban roads lack distinctive landmarks and visual cues. How should you reframe this problem?',
        'intermediate', 'Google Maps', 'Navigation and mapping platform',
        'D',
        'The original problem framing ("navigation is inaccurate") is wrong based on the data—GPS routing is actually correct. The real issue is that users feel lost despite correct directions because they lack visual confirmation of their route. Option D correctly reframes from a technical accuracy problem to a user confidence problem, which opens up entirely different solutions (e.g., augmented reality overlays, more detailed visual instructions, street-level photo guidance). Option A stays in the original (incorrect) framing. Option B addresses the symptom with a workaround. Option C treats it as a data gap rather than a UX gap.',
        ARRAY['problem_definition', 'problem_space', 'symptom_vs_cause']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 19;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"Suburban GPS accuracy needs improvement through better satellite calibration"', false),
        (v_q_id, 'B', '"We need to add more frequent turn-by-turn voice prompts in suburban areas"', false),
        (v_q_id, 'C', '"Our map data for suburban areas lacks sufficient detail compared to urban areas"', false),
        (v_q_id, 'D', '"Users in low-landmark environments need stronger visual confirmation cues to feel confident they''re on the right path"', true);

    -- QUESTION 20 (Intermediate) — User Problem vs Business Problem
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 20,
        'Amazon''s Return Rate Problem',
        'You are a PM at Amazon. Return rates for clothing have increased to 35%. The finance team frames this as a cost problem: "Returns cost us $X per item in shipping and processing." The customer experience team frames it as: "Customers can''t find the right size online." How should you reconcile these two framings?',
        'intermediate', 'Amazon', 'E-commerce marketplace with large clothing category',
        'A',
        'A mature PM recognizes that user problems and business problems are often two sides of the same coin. Option A is correct because it creates a unified problem framing that connects the user need (finding the right size) to the business impact (return costs), making it clear that solving the user problem directly reduces the business cost. Option B picks the business framing only, which might lead to solutions that make returns harder rather than preventing them. Option C picks the user framing only, which might not get executive buy-in. Option D treats them as separate workstreams when they should be solved together.',
        ARRAY['user_vs_business_problem', 'problem_definition', 'stakeholder_alignment']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 20;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Unify both: "Customers lack confidence in clothing fit, leading to over-ordering and returns that cost $X per item—solving the fit problem reduces both user frustration and business cost"', true),
        (v_q_id, 'B', 'Prioritize the business framing because reducing return costs directly impacts profitability', false),
        (v_q_id, 'C', 'Prioritize the user framing because solving the user problem will naturally reduce returns', false),
        (v_q_id, 'D', 'Run two parallel workstreams: one to reduce return processing costs and one to improve size guidance', false);

    -- QUESTION 21 (Intermediate) — Ambiguity Resolution
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 21,
        'Canva''s "Make It Easier" Request',
        'You are a PM at Canva. Your CEO says: "Make Canva easier to use for non-designers." This statement is highly ambiguous. What is the most productive way to resolve this ambiguity before starting any work?',
        'intermediate', 'Canva', 'Online graphic design platform for non-designers',
        'B',
        'Ambiguous directives like "make it easier" must be decomposed into specific, observable user behaviors before they become actionable. Option B is correct because it maps the ambiguity to concrete, measurable behaviors across the user journey—each of which could be the "ease" problem the CEO is referring to. Option A narrows too quickly to one interpretation (templates) without checking alignment. Option C is useful but generates new data before clarifying the question. Option D asks the CEO to clarify, which is reasonable but puts the burden on them when a PM should be able to decompose the problem and propose specific sub-problems to validate.',
        ARRAY['ambiguity_resolution', 'problem_decomposition', 'problem_definition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 21;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Interpret "easier" as better templates and start working on improving the template gallery', false),
        (v_q_id, 'B', 'Decompose "easier" into specific behaviors: finding the right template, customizing elements, understanding design principles, and exporting—then identify which stage has the highest friction', true),
        (v_q_id, 'C', 'Run a usability study with non-designers to observe where they struggle', false),
        (v_q_id, 'D', 'Ask the CEO to clarify exactly what they mean by "easier" and for which user segments', false);

    -- QUESTION 22 (Intermediate) — Root Cause vs Symptom with Data
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 22,
        'Robinhood''s Support Ticket Surge',
        'You are a PM at Robinhood. Customer support tickets increased 80% in a single week. The support team categorizes the top issue as "unable to execute trades." You dig deeper and find: (a) the trading engine has 99.9% uptime, (b) the spike correlates with a volatile market week, (c) users are hitting daily trade limits they didn''t know existed. What is the root cause?',
        'intermediate', 'Robinhood', 'Commission-free stock trading mobile app',
        'C',
        'The data reveals a clear causal chain: market volatility → more trading activity → users hitting daily trade limits → users perceiving "unable to trade" → support tickets. The trading engine isn''t down (99.9% uptime), and the volatility is external. The root cause within Robinhood''s control is that users don''t understand their trade limits until they hit them. Option C is correct because it identifies the specific, actionable root cause: a discoverability gap in limit information. Option A addresses the symptom (support volume). Option B blames an external factor Robinhood can''t control. Option D treats a constraint (trade limits) as the problem when the real issue is user awareness of that constraint.',
        ARRAY['root_cause_analysis', 'symptom_vs_cause', 'five_whys']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 22;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'The support team is understaffed and can''t handle the normal volume increase during volatile markets', false),
        (v_q_id, 'B', 'Market volatility creates unpredictable user behavior that overwhelms any trading platform', false),
        (v_q_id, 'C', 'Users are not informed about their daily trade limits upfront, so they only discover the constraint when they hit it during high-activity periods', true),
        (v_q_id, 'D', 'The daily trade limit policy is too restrictive and needs to be raised for active traders', false);

    -- QUESTION 23 (Intermediate) — Problem Space Thinking
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 23,
        'Calendly''s Enterprise Scheduling',
        'You are a PM at Calendly. Enterprise customers request "recurring group meeting scheduling with automatic conflict resolution." This is a detailed solution specification. What should you do to move back into problem space before building it?',
        'intermediate', 'Calendly', 'Scheduling automation platform for professionals',
        'B',
        'When customers provide detailed solution specs, they''ve already left the problem space and entered solution space. A PM''s job is to reverse-engineer the underlying problem. Option B is correct because it uses structured questioning to understand the real pain point before committing to a specific solution. The underlying problem might be "coordinating recurring meetings across time zones is painful" or "managers waste time manually resolving calendar conflicts," and each framing leads to different solutions. Option A treats the request as validated. Option C adds polish to a solution without understanding the problem. Option D explores alternatives in solution space without first understanding the problem.',
        ARRAY['problem_space', 'solution_space', 'problem_definition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 23;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Build it as specified since enterprise customers know their workflows best', false),
        (v_q_id, 'B', 'Ask enterprise customers: "Walk me through the last time scheduling a recurring group meeting was painful. What happened and what did you end up doing?"', true),
        (v_q_id, 'C', 'Create a prototype of the feature and test it with enterprise customers before full development', false),
        (v_q_id, 'D', 'Research how competitors like Google Calendar and Microsoft Outlook handle recurring group scheduling', false);

    -- QUESTION 24 (Intermediate) — Framing Trade-offs
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 24,
        'TikTok''s Creator-Viewer Balance',
        'You are a PM at TikTok. Creators want longer video limits (up to 10 minutes) to monetize better. Viewers prefer short-form content (under 60 seconds). Extending video length could increase creator retention but decrease viewer engagement. How should you frame this problem?',
        'intermediate', 'TikTok', 'Short-form video entertainment platform',
        'D',
        'This is a classic two-sided marketplace problem where the needs of creators and viewers are in tension. Option D is correct because it frames the problem as a trade-off optimization challenge, acknowledging that both sides matter and the solution needs to balance them. This framing leads to nuanced solutions like allowing longer content while keeping the default feed short, or creating a separate section for long-form content. Option A picks one side without justification. Option B picks the other side. Option C avoids framing the trade-off by trying to serve both equally, which isn''t realistic without understanding the relationship between creator content length and viewer engagement.',
        ARRAY['constraint_identification', 'problem_definition', 'user_vs_business_problem']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 24;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Prioritize creators since they produce the content that attracts viewers—supply drives demand', false),
        (v_q_id, 'B', 'Prioritize viewers since they outnumber creators 100:1 and viewer engagement drives ad revenue', false),
        (v_q_id, 'C', 'Frame it as a feature request to add 10-minute videos alongside the existing short-form format', false),
        (v_q_id, 'D', 'Frame it as a marketplace balance problem: how can we increase creator monetization without degrading the short-form viewing experience that drives user growth?', true);

    -- QUESTION 25 (Intermediate) — Hidden Assumptions
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 25,
        'Peloton''s Churn Reduction',
        'You are a PM at Peloton. The team''s problem statement is: "We need to add more live classes to reduce subscriber churn." What hidden assumptions should be challenged?',
        'intermediate', 'Peloton', 'Connected fitness platform with hardware and subscription content',
        'B',
        'The problem statement "add more live classes to reduce churn" contains multiple hidden assumptions that should be surfaced and tested. Option B is correct because it identifies the most critical hidden assumption: the presumption that churn is caused by insufficient live classes. In reality, churn could be driven by hardware issues, price sensitivity, workout boredom unrelated to class format, or seasonal patterns. The statement also assumes that live classes are preferable to on-demand, which may not be true for all segments. Option A challenges a secondary assumption. Option C is an assumption, but a more reasonable one given Peloton''s model. Option D challenges an assumption about competition that isn''t embedded in the original statement.',
        ARRAY['assumption_testing', 'problem_definition', 'hypothesis_framing']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 25;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'The assumption that subscribers prefer live classes over on-demand content', false),
        (v_q_id, 'B', 'The assumption that insufficient class variety is the primary driver of churn, rather than other factors like price, hardware, or lifestyle changes', true),
        (v_q_id, 'C', 'The assumption that Peloton subscribers exercise regularly enough to need more content', false),
        (v_q_id, 'D', 'The assumption that Peloton''s competitors don''t already offer more classes', false);

    -- QUESTION 26 (Intermediate) — Problem Prioritization with Data
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 26,
        'Grammarly''s Multi-Problem Roadmap',
        'You are a PM at Grammarly. User research has identified three problems: (1) Free users want more advanced suggestions (affects 50M users, low severity), (2) Premium users find the browser extension buggy (affects 5M users, high severity), (3) Enterprise buyers need SOC 2 compliance documentation (affects 500 prospects, critical for deal closure). You can only tackle one this quarter. How should you frame the prioritization decision?',
        'intermediate', 'Grammarly', 'AI-powered writing assistant across platforms',
        'D',
        'This is a prioritization problem where three valid issues compete across different dimensions: reach vs. severity vs. strategic value. Option D is correct because it maps each problem to its business impact using the right metric: (1) impacts free-to-premium conversion, (2) impacts premium retention and word-of-mouth, (3) impacts enterprise revenue pipeline. This allows an apples-to-apples comparison on business impact rather than defaulting to the largest user count. Option A defaults to reach without considering severity. Option B defaults to severity without considering reach. Option C picks the enterprise problem without evaluating the tradeoff.',
        ARRAY['problem_prioritization', 'constraint_identification', 'user_vs_business_problem']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 26;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Solve problem 1 first because it affects the most users and will have the largest impact on engagement', false),
        (v_q_id, 'B', 'Solve problem 2 first because paying users should always take priority over free users', false),
        (v_q_id, 'C', 'Solve problem 3 first because enterprise deals have the highest revenue impact per user', false),
        (v_q_id, 'D', 'Quantify each problem''s impact on the most relevant business metric—conversion rate, retention, and pipeline value—then compare the expected revenue impact', true);

    -- QUESTION 27 (Intermediate) — Problem Definition Scope
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 27,
        'Notion''s AI Feature Scope',
        'You are a PM at Notion. Your team is excited about AI and wants to "add AI to everything in Notion." This broad directive needs to be narrowed to a specific, well-framed problem. Which approach best narrows the scope?',
        'intermediate', 'Notion', 'All-in-one workspace for notes, docs, and project management',
        'C',
        'Broad technology-driven directives ("add AI to everything") need to be grounded in specific user problems to become actionable. Option C is correct because it starts from user pain points and evaluates where AI could specifically address them, leading to focused problem statements like "users spend 20 minutes writing meeting notes that AI could draft in seconds." Option A narrows scope by product area but doesn''t tie AI to user problems. Option B narrows by copying competitors, which doesn''t ensure you''re solving the right problem for Notion''s users. Option D narrows by feasibility, which is important but should come after problem definition—building the easiest AI feature isn''t valuable if it doesn''t solve a real problem.',
        ARRAY['problem_definition', 'ambiguity_resolution', 'problem_decomposition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 27;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Pick the three most-used Notion features (docs, databases, wikis) and add AI capabilities to each', false),
        (v_q_id, 'B', 'Research what AI features competitors like Google Docs and Microsoft 365 have shipped', false),
        (v_q_id, 'C', 'Identify the top 5 user pain points in Notion workflows and evaluate which ones AI could meaningfully alleviate', true),
        (v_q_id, 'D', 'Start with the simplest AI use case (text summarization) and expand from there based on user adoption', false);

    -- QUESTION 28 (Intermediate) — Problem Framing Mistakes
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 28,
        'Spotify''s Podcast Growth Stall',
        'You are a PM at Spotify. Podcast listenership growth has stalled at 25% of monthly active users despite heavy investment. Your team has proposed four problem statements. Which is the strongest problem framing?',
        'intermediate', 'Spotify', 'Audio streaming platform with music and podcasts',
        'D',
        'A strong problem statement is specific, grounded in user behavior, and doesn''t embed a solution. Option D is the strongest because it''s specific (music-only users), behavioral (never try podcasts), and root-cause-oriented (no trigger in their workflow). It also implies a measurable goal and clear user segment. Option A is too vague and solution-oriented ("better podcast recommendations"). Option B makes an assumption about quality without evidence. Option C focuses on a business metric (market share) rather than a user problem—it''s a goal, not a problem statement.',
        ARRAY['problem_definition', 'hypothesis_framing', 'problem_space']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 28;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"We need better podcast recommendations to increase podcast adoption among our user base"', false),
        (v_q_id, 'B', '"Our podcast content quality isn''t competitive with Apple Podcasts, causing users to listen elsewhere"', false),
        (v_q_id, 'C', '"Spotify''s podcast market share needs to increase from 25% to 40% to justify our content investment"', false),
        (v_q_id, 'D', '"75% of Spotify users who listen exclusively to music never try a podcast because there''s no natural trigger in their music-listening workflow to discover podcast content"', true);

    -- ============================================
    -- ADVANCED QUESTIONS (Q29–Q35)
    -- ============================================

    -- QUESTION 29 (Advanced) — Multi-Stakeholder Problem Framing
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 29,
        'Uber Eats'' Three-Sided Marketplace Problem',
        'You are a PM at Uber Eats. Order volume is declining in mid-tier cities. Restaurants say "commission fees are too high." Drivers say "delivery distances are too long for the pay." Customers say "delivery times are too slow." Each stakeholder group sees a different problem. You analyze the data: (a) Restaurant density in mid-tier cities is 40% lower than in major cities, (b) Average delivery distance is 7.2 miles vs 3.1 miles in major cities, (c) Average delivery time is 48 min vs 31 min in major cities. What is the root problem that connects all three stakeholder complaints?',
        'advanced', 'Uber Eats', 'Food delivery three-sided marketplace',
        'B',
        'This is a complex, multi-stakeholder problem that requires systems thinking to see the common root cause. All three symptoms—high commissions, long distances, slow times—stem from one underlying issue: low restaurant density in mid-tier cities. Low density means drivers must travel farther (causing the distance and time complaints), and restaurants have less competitive pressure to absorb commissions. Option B is correct because it identifies the structural root cause that connects all three stakeholder complaints and unlocks solutions that address the system (increasing restaurant supply) rather than individual symptoms. Option A treats one stakeholder''s view as the root cause. Option C confuses a market characteristic with the solvable problem. Option D jumps to a solution (logistics optimization) without addressing the structural issue.',
        ARRAY['root_cause_analysis', 'problem_decomposition', 'stakeholder_alignment', 'five_whys']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 29;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Commission fees are too high, which reduces restaurant participation and creates a supply shortage that increases delivery times', false),
        (v_q_id, 'B', 'Insufficient restaurant density in mid-tier cities creates a negative cycle: longer delivery distances increase costs for all parties, reduce order frequency, and discourage new restaurant sign-ups', true),
        (v_q_id, 'C', 'Mid-tier cities have fundamentally different unit economics that make the Uber Eats model unviable without pricing changes', false),
        (v_q_id, 'D', 'The delivery routing algorithm isn''t optimized for the geographic spread of mid-tier cities, causing unnecessarily long routes', false);

    -- QUESTION 30 (Advanced) — Systems Thinking in Problem Framing
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 30,
        'Meta''s News Feed Engagement Paradox',
        'You are a PM at Meta (Facebook). The News Feed team discovers a paradox: increasing engagement through rage-bait content increases short-term DAU but accelerates long-term user attrition, especially among 18-25 year olds. The ads team sees engagement as positive (more ad impressions). The trust & safety team sees rage-bait as harmful. The growth team is alarmed by cohort-level attrition. Three data points: (1) Rage-bait posts get 4x the engagement of neutral posts, (2) Users exposed to 3+ rage-bait posts per session are 2.3x more likely to take a 7-day break, (3) Users who take 3+ breaks in a quarter have a 60% higher churn rate. How should you frame this problem for the executive team?',
        'advanced', 'Meta/Facebook', 'Social media platform with 2B+ users',
        'C',
        'This is a sophisticated problem framing challenge where short-term and long-term metrics are in direct conflict, and multiple teams have legitimately different perspectives. Option C is correct because it reframes the problem at a systems level: the current optimization metric (engagement) is actually a leading indicator of churn when driven by rage-bait. This framing makes the tradeoff explicit and quantifiable, enabling executives to make an informed decision. Option A understates the problem by framing it as a content quality issue. Option B frames it as a team alignment problem rather than a product problem. Option D frames it too narrowly as a demographic retention issue rather than a systemic engagement quality problem.',
        ARRAY['problem_definition', 'symptom_vs_cause', 'constraint_identification', 'user_vs_business_problem']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 30;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"We have a content quality problem: rage-bait content is degrading the user experience and needs to be reduced through better ranking"', false),
        (v_q_id, 'B', '"We have a cross-team alignment problem: Ads, Trust & Safety, and Growth need to agree on shared engagement quality metrics"', false),
        (v_q_id, 'C', '"Our engagement metric is a misleading indicator of platform health: high-engagement rage-bait content drives a 2.3x increase in session breaks and 60% higher churn, meaning our optimization is systematically destroying long-term value"', true),
        (v_q_id, 'D', '"We''re losing 18-25 year olds to competitors because our content doesn''t match their values around mental health and authenticity"', false);

    -- QUESTION 31 (Advanced) — Problem Framing Under Uncertainty
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 31,
        'Tesla''s Autonomous Driving Edge Cases',
        'You are a PM at Tesla working on Full Self-Driving (FSD). Engineers report that FSD handles 99.4% of driving scenarios correctly, but the remaining 0.6% includes high-severity edge cases like construction zone navigation, emergency vehicle encounters, and unusual road configurations. The 0.6% failure rate translates to roughly one serious error per 20,000 miles. Your team debates: is the problem "reduce failure rate" or "ensure safe handling of failures"? How should you frame this problem?',
        'advanced', 'Tesla', 'Autonomous driving technology for electric vehicles',
        'D',
        'This is a problem framing challenge where the obvious framing ("reduce the 0.6% failure rate") is insufficient because the consequences of failure are not uniform—some edge cases are annoying while others are life-threatening. Option D is correct because it reframes the problem around graceful degradation: the issue isn''t just how often the system fails but what happens when it does. This framing opens up solutions like better handoff to human drivers, reduced-capability safe modes, and predictive detection of challenging scenarios—not just improving the ML model. Option A oversimplifies to a metrics problem. Option B is correct in direction but too specific (only emergency vehicles). Option C is a communication strategy, not a product problem framing.',
        ARRAY['problem_definition', 'constraint_identification', 'problem_decomposition', 'ambiguity_resolution']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 31;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"We need to reduce the failure rate from 0.6% to below 0.1% to match human driver safety benchmarks"', false),
        (v_q_id, 'B', '"We need to build specific handling for each known edge case category, starting with emergency vehicles"', false),
        (v_q_id, 'C', '"We need to communicate the failure rate transparently so users maintain appropriate vigilance"', false),
        (v_q_id, 'D', '"We need to ensure the system fails safely: when FSD encounters a scenario beyond its confidence threshold, it must transition to a safe state faster than a human could react to an unexpected situation"', true);

    -- QUESTION 32 (Advanced) — Layered Problem Decomposition
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 32,
        'Stripe''s International Expansion Problem',
        'You are a Senior PM at Stripe. The company wants to "accelerate international expansion in Southeast Asia." You know this involves: (1) regulatory compliance (different per country), (2) local payment method support (GCash, GrabPay, PromptPay, etc.), (3) developer adoption in markets where Stripe has low brand recognition, (4) local currency settlement, and (5) merchant support in local languages. A junior PM proposes starting with the most requested payment methods. What is the better approach to decompose this problem?',
        'advanced', 'Stripe', 'Global payment infrastructure platform expanding to SE Asia',
        'C',
        'The junior PM''s approach (start with most-requested features) is bottom-up and reactive. For a complex international expansion, a PM needs to decompose the problem into layers where each layer either enables or blocks the next. Option C is correct because it structures the problem as a dependency chain: regulatory compliance must come first (you can''t process payments without it), then payment methods and settlement (core product), then developer adoption and support (go-to-market). This layered decomposition prevents wasted effort on features that are blocked by unresolved prerequisites. Option A treats all dimensions equally. Option B optimizes for speed but may hit blockers. Option D narrows to a single country without the decomposition framework.',
        ARRAY['problem_decomposition', 'constraint_identification', 'problem_prioritization', 'ambiguity_resolution']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 32;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Score each of the five dimensions on urgency and effort, then tackle them in priority order based on the highest ratio', false),
        (v_q_id, 'B', 'Start with the country that has the fewest regulatory barriers and use it as a beachhead for the rest of Southeast Asia', false),
        (v_q_id, 'C', 'Map the five dimensions into a dependency chain: regulatory compliance enables payment methods, which enables local settlement, which enables developer adoption, which enables merchant support—and solve them in order', true),
        (v_q_id, 'D', 'Focus exclusively on Indonesia first as the largest market and solve all five dimensions before expanding to other countries', false);

    -- QUESTION 33 (Advanced) — Competing Problem Framings
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 33,
        'Netflix''s Content Strategy Paradox',
        'You are a VP of Product at Netflix. The data team presents two seemingly contradictory findings: (1) Users who watch niche/indie content have 30% higher 12-month retention than users who only watch popular titles, (2) Popular titles drive 5x more sign-ups than niche content. The content team wants to invest more in niche content. The growth team wants to invest in blockbusters. Both cite data to support their position. How should you frame this problem to move beyond the deadlock?',
        'advanced', 'Netflix', 'Global streaming platform with 230M+ subscribers',
        'B',
        'This is an advanced problem framing challenge because both teams are right within their own metric—and the deadlock comes from framing the problem as an either/or choice. Option B is correct because it reframes the problem around the user lifecycle: popular content serves as an acquisition tool (bringing users in), while niche content serves as a retention tool (keeping them subscribed). This framing eliminates the false dichotomy and creates a unified content strategy problem: how do we convert blockbuster-attracted signups into niche content consumers? Option A picks one side. Option C picks the other. Option D avoids the strategic question by delegating to an algorithm.',
        ARRAY['problem_definition', 'stakeholder_alignment', 'problem_space', 'constraint_identification']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 33;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', 'Invest in niche content because retention is the more sustainable growth driver at Netflix''s scale', false),
        (v_q_id, 'B', 'Reframe as a lifecycle problem: popular content is the acquisition engine and niche content is the retention engine—the real problem is how to bridge users from blockbuster-driven sign-up to niche content engagement', true),
        (v_q_id, 'C', 'Invest in blockbusters because sign-ups grow the subscriber base, which can later be engaged with niche content', false),
        (v_q_id, 'D', 'Let the recommendation algorithm optimize the balance between popular and niche content based on individual user preferences', false);

    -- QUESTION 34 (Advanced) — Second-Order Problem Effects
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 34,
        'Airbnb''s Instant Book Unintended Consequences',
        'You are a Senior PM at Airbnb. Instant Book was launched to reduce booking friction. Data after 6 months: (1) Booking conversion increased 25%, (2) Host cancellation rate increased 40%, (3) Guest review scores dropped 0.3 points on average, (4) First-time host sign-ups decreased 15%. The original problem was "too much friction in the booking process." What second-order problem framing should you now adopt?',
        'advanced', 'Airbnb', 'Two-sided marketplace for short-term accommodation',
        'C',
        'This is a classic second-order effects problem. Solving the original problem (booking friction) created new problems that are arguably worse. The 25% booking increase came at the cost of host experience degradation: more cancellations (hosts overwhelmed by bookings they can''t fulfill), lower reviews (mismatched expectations), and fewer new hosts (the hosting proposition feels less controllable). Option C is correct because it reframes around the systemic impact: Instant Book shifted control away from hosts, and the resulting host dissatisfaction threatens the supply side of the marketplace. Option A stays in the original problem frame. Option B identifies one symptom but misses the systemic issue. Option D frames it as a communications problem when it''s structural.',
        ARRAY['problem_definition', 'root_cause_analysis', 'symptom_vs_cause', 'problem_decomposition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 34;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"We need to further optimize Instant Book by reducing the types of cancellations that hosts can make"', false),
        (v_q_id, 'B', '"Host cancellation rates are too high and need to be reduced through stricter cancellation penalties"', false),
        (v_q_id, 'C', '"Instant Book solved guest friction but created a host control problem: hosts feel they''ve lost agency over who stays in their home, leading to cancellations, lower quality interactions, and a less attractive hosting proposition"', true),
        (v_q_id, 'D', '"We need to better communicate Instant Book expectations to hosts during the onboarding process"', false);

    -- QUESTION 35 (Advanced) — Organizational Problem Framing
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 35,
        'Google''s Messaging App Fragmentation',
        'You are a Group PM at Google. Google has launched and sunsetted multiple messaging apps (Hangouts, Allo, Duo, Chat, Meet, Messages). The current state: Google Chat for enterprise, Google Meet for video, Google Messages for SMS/RCS. User research shows: (1) 68% of Android users don''t know which Google messaging app to use for what purpose, (2) Enterprises report "collaboration tool fatigue" managing Chat and Meet separately, (3) Consumer NPS for Google messaging is -15 vs iMessage''s +47. Leadership asks you to "fix Google''s messaging strategy." Before proposing any solution, how should you frame the core problem?',
        'advanced', 'Google', 'Technology company with fragmented messaging product portfolio',
        'D',
        'This is the most complex type of problem framing—an organizational-level problem where product fragmentation reflects deeper issues. Option D is correct because it identifies the root cause at the right level: Google''s messaging fragmentation isn''t a product problem that can be solved by launching yet another app or merging existing ones. It''s a problem framing failure at the organizational level—Google has never clearly articulated what job its messaging products serve and for whom. Without this clarity, any solution (merge apps, build a new app, sunset products) will repeat the same pattern. Option A treats the symptom (too many apps). Option B frames it as a competitive problem against iMessage. Option C proposes a solution (unification) disguised as a problem statement.',
        ARRAY['problem_definition', 'problem_space', 'stakeholder_alignment', 'ambiguity_resolution', 'problem_decomposition']);
    SELECT id INTO v_q_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 35;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_q_id, 'A', '"Google has too many messaging apps, and we need to consolidate them into a single unified platform"', false),
        (v_q_id, 'B', '"Google Messages can''t compete with iMessage on user experience, and we need to close the NPS gap"', false),
        (v_q_id, 'C', '"Enterprise and consumer messaging have different needs, and Google should formally separate the two product lines with distinct branding"', false),
        (v_q_id, 'D', '"Google has repeatedly failed to articulate a clear problem statement for who its messaging products serve and what job they do—until we define the user, the job, and the competitive frame, any product solution will replicate the fragmentation pattern"', true);

    RAISE NOTICE 'Successfully inserted 35 questions for Problem Framing';
END $$;
