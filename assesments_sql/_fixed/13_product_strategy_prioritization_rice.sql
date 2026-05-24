-- ============================================
-- ASSESSMENT: Prioritization (RICE)
-- CATEGORY: Product Strategy
-- TOTAL QUESTIONS: 35
-- DIFFICULTY: 10 foundational, 18 intermediate, 7 advanced
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_q_id UUID;
BEGIN
    -- Look up the sub-skill ID
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'prioritization-rice';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug prioritization-rice not found. Run the seed data first.';
    END IF;

    -- ----------------------------------------
    -- QUESTION 1 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        1,
        'Spotify''s Smart Shuffle RICE Score',
        E'A Spotify Product Manager is prioritizing a new "Smart Shuffle" feature for free tier users. The team estimates that the feature will reach 10 million users next quarter. The PM estimates the impact on engagement to be 2 (High impact) and has 80% (0.8) confidence in the estimates based on initial user interviews. The engineering team estimates that it will take 4 person-months of effort to build.\n\nWhat is the calculated RICE score for this feature?',
        'foundational',
        'Spotify',
        'Smart Shuffle feature expansion',
        'B',
        'The RICE score is calculated using the formula: (Reach * Impact * Confidence) / Effort. In this case, Reach = 10,000,000 users, Impact = 2, Confidence = 80% (0.8), and Effort = 4 person-months. Plunging these numbers into the formula: (10,000,000 * 2 * 0.8) / 4 = 16,000,000 / 4 = 4,000,000. Option A is incorrect because it fails to divide by the Effort. Option C is incorrect because it uses a Confidence of 40% instead of 80%. Option D is incorrect because it multiplies by the effort instead of dividing, or uses incorrect formula parameters.',
        ARRAY['prioritization', 'rice_calculation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '16,000,000', false),
    (v_q_id, 'B', '4,000,000', true),
    (v_q_id, 'C', '2,000,000', false),
    (v_q_id, 'D', '8,000,000', false);

    -- ----------------------------------------
    -- QUESTION 2 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        2,
        'Duolingo''s ICE Score Application',
        E'A Growth Product Manager at Duolingo is prioritizing a list of 15 rapid, low-effort growth experiments designed to increase daily active users (DAU). The PM decides to use the ICE framework (Impact, Confidence, Ease) instead of the RICE framework.\n\nWhat is the primary reason for choosing ICE over RICE in this specific context?',
        'foundational',
        'Duolingo',
        'Growth and Marketing Experiments',
        'A',
        'The ICE framework is frequently favored by growth and marketing teams because it simplifies the prioritization process by combining Reach and Impact into a single "Impact" score, or by assuming Reach is constant across experiments. In rapid growth experimentation (like changing copy, colors, or minor onboarding steps), estimating exact Reach for each micro-experiment can add unnecessary overhead, making the simpler ICE framework more agile. Option B is incorrect because Ease is typically scored on a simple linear scale (1-10), not a logarithmic scale. Option C is incorrect because Confidence is still a core component of ICE. Option D is incorrect because ICE is a quantitative framework that uses numerical scoring (typically 1-10 for each factor).',
        ARRAY['prioritization', 'ice_score']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'ICE does not require estimating Reach, which is highly beneficial when Reach is roughly equal across experiments or extremely difficult to estimate for micro-experiments.', true),
    (v_q_id, 'B', 'ICE replaces Effort with Ease, which uses a logarithmic scale that is more mathematically rigorous than linear effort.', false),
    (v_q_id, 'C', 'ICE completely eliminates the Confidence parameter to allow for faster decision-making.', false),
    (v_q_id, 'D', 'ICE is a purely qualitative framework that does not use numerical scoring, reducing stakeholder bias.', false);

    -- ----------------------------------------
    -- QUESTION 3 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        3,
        'Netflix''s Kano Classification',
        E'A Netflix Product Manager is organizing a backlog of features for the smart TV app and wants to classify them using the Kano Model. The two features under evaluation are:\n1. "Offline Downloads" (allowing users to download content to watch without internet)\n2. "Interactive Movie Recommendations" (an AI chatbot that helps users choose what to watch via conversational prompts)\n\nHow should the PM classify these features?',
        'foundational',
        'Netflix',
        'Feature Categorization',
        'B',
        'In the Kano Model, Must-have (Basic) needs are characteristics that customers expect as a baseline; their absence causes high dissatisfaction, but their presence does not significantly increase satisfaction because they are taken for granted. In modern streaming, offline downloads have become a standard baseline expectation (Must-have). Attractive (Delighter) needs are unexpected features that, when presented, cause high satisfaction, but their absence does not cause dissatisfaction. Interactive conversational recommendation fits this as an innovative delighter. Option A is incorrect because recommendations are attractive, not indifferent. Options C and D are incorrect because they misclassify the baseline expectation of offline viewing.',
        ARRAY['prioritization', 'kano_model']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Offline Downloads is a Performance need; Interactive Movie Recommendations is an Indifferent need.', false),
    (v_q_id, 'B', 'Offline Downloads is a Must-have (Basic) need; Interactive Movie Recommendations is an Attractive (Delighter) need.', true),
    (v_q_id, 'C', 'Offline Downloads is an Attractive need; Interactive Movie Recommendations is a Performance need.', false),
    (v_q_id, 'D', 'Offline Downloads is a Performance need; Interactive Movie Recommendations is a Must-have need.', false);

    -- ----------------------------------------
    -- QUESTION 4 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        4,
        'Slack''s MoSCoW Release Planning',
        E'A Slack Product Manager is preparing for a major update to "Slack Huddles" and conducts a MoSCoW prioritization session with representatives from Sales, Engineering, and Design. After the session, the PM notices that 80% of the proposed features are classified as "Must Have" (M).\n\nWhat is the primary risk of this distribution, and how should the PM address it?',
        'foundational',
        'Slack',
        'Enterprise Huddles Release',
        'A',
        'A common pitfall of the MoSCoW method is "Must-Have inflation," where stakeholders classify almost everything as critical to ensure their preferred features are built. This destroys the utility of prioritization, leading to bloated scopes and missed deadlines. Standard practice is to limit "Must Haves" to no more than 50-60% of the total development capacity (effort), leaving the remaining capacity for "Should Have" and "Could Have" items that can be safely descoped if the project runs over schedule. Option B is incorrect because converting everything to "Could Have" removes all prioritization. Option C is incorrect because increasing "Won''t Have" arbitrarily does not solve the stakeholder alignment problem. Option D is incorrect because Kano surveys are for customer preferences, not capacity planning.',
        ARRAY['prioritization', 'moscow_method']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The release will suffer from scope creep and likely delay the launch; the PM should enforce a rule that "Must Have" features cannot exceed 60% of the total estimated effort.', true),
    (v_q_id, 'B', 'The engineering team will lose motivation; the PM should convert all "Must Have" features to "Could Have" features to reduce pressure.', false),
    (v_q_id, 'C', 'The sales team will be dissatisfied; the PM should increase the "Won''t Have" category to 90% of the backlog.', false),
    (v_q_id, 'D', 'The feature quality will drop; the PM should replace the MoSCoW framework with a Kano survey of external users.', false);

    -- ----------------------------------------
    -- QUESTION 5 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        5,
        'Figma''s Value vs. Effort Low-Hanging Fruit',
        E'A Figma Product Manager maps out potential features on a standard 2x2 Value vs. Effort matrix. The team has identified a feature: "Keyboard shortcut to auto-align layers" as having very high value for professional designers and requiring very low engineering effort.\n\nIn which quadrant does this feature fall, and what is its standard prioritization recommendation?',
        'foundational',
        'Figma',
        'Editor Usability Improvements',
        'C',
        'In a Value vs. Effort matrix, features that offer high customer/business value but require low development effort are classified as "Quick Wins" or "Low-hanging fruit." These features offer the highest return on investment (ROI) and should be prioritized first to build momentum and deliver immediate value. Option A represents major strategic initiatives that require significant planning. Option B represents minor tasks that are done during downtime. Option D represents resource drains that should generally be avoided.',
        ARRAY['prioritization', 'value_vs_effort']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High Value, High Effort (Major Projects) — plan carefully and resource heavily.', false),
    (v_q_id, 'B', 'Low Value, Low Effort (Fill-ins) — do only when resources are idle.', false),
    (v_q_id, 'C', 'High Value, Low Effort (Quick Wins / Low-hanging fruit) — build and release first.', true),
    (v_q_id, 'D', 'Low Value, High Effort (Thankless Tasks) — deprioritize or avoid.', false);

    -- ----------------------------------------
    -- QUESTION 6 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        6,
        'Canva''s RICE Confidence Scoring',
        E'A Canva Product Manager is evaluating a proposed "AI Video Background Remover" feature. The PM has conducted qualitative interviews with 10 design professionals who strongly expressed a need for this feature, but the team lacks quantitative survey data or behavior logs.\n\nUnder standard RICE scoring guidelines (e.g., Intercom''s rubric), what is the maximum Confidence level the PM should assign?',
        'foundational',
        'Canva',
        'Video Editing Suite Expansion',
        'C',
        'Standard RICE confidence scoring rubrics (pioneered by Intercom) map specific data evidence to confidence percentages: 100% represents high confidence backed by quantitative data, user testing, and engineering proof; 80% represents medium confidence backed by some qualitative and quantitative indicators; 50% represents low confidence, which is typical when you have qualitative feedback from a very small sample size (like 10 interviews) or when there is still significant market/technical risk. Assigning 80% or 100% based only on a few interviews is a common scoring bias error. Option D is too low, as a 10% confidence score is reserved for complete "moonshots" with zero user validation.',
        ARRAY['prioritization', 'rice_calculation', 'scoring_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '100% (High Confidence) — because the qualitative feedback from professionals was extremely enthusiastic.', false),
    (v_q_id, 'B', '80% (Medium Confidence) — because qualitative user feedback is strong, but quantitative data is missing.', false),
    (v_q_id, 'C', '50% (Low Confidence) — because qualitative data from a small sample size still carries significant hypothesis risk.', true),
    (v_q_id, 'D', '10% (Moonshot/No Confidence) — because there is no production code or live user testing.', false);

    -- ----------------------------------------
    -- QUESTION 7 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        7,
        'Notion''s Opportunity Cost Evaluation',
        E'A Notion Product Manager has a dedicated engineering team for one quarter. The PM must choose between building "Offline Mode" (high customer value, 3 months of effort) or "Table Databases improvements" (medium customer value, 1 month of effort). The PM chooses to build "Offline Mode."\n\nWhat is the opportunity cost of this decision?',
        'foundational',
        'Notion',
        'Desktop App Optimization',
        'B',
        'Opportunity cost is the value of the next best alternative foregone when a decision is made. By choosing to build "Offline Mode," the team cannot work on the "Table Databases improvements" (and potentially other features that could fit into that 3-month block). The lost value and benefits of those unbuilt features represent the opportunity cost. Option A represents direct sunk costs, not opportunity costs. Option C represents technical risk. Option D represents the cost of inaction on the chosen path, not the opportunity cost of the foregone alternative.',
        ARRAY['prioritization', 'opportunity_cost']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The financial cost of paying the developers'' salaries for the 3 months.', false),
    (v_q_id, 'B', 'The value and customer satisfaction that would have been generated by the Table Databases improvements during that quarter.', true),
    (v_q_id, 'C', 'The risk of introducing database synchronization bugs in the offline codebase.', false),
    (v_q_id, 'D', 'The lost subscription revenue from users who churned due to the lack of offline support.', false);

    -- ----------------------------------------
    -- QUESTION 8 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        8,
        'Zoom''s Strategic Alignment Filter',
        E'Zoom''s corporate goal for the upcoming year is "Enterprise Market Expansion." A Zoom Product Manager has a backlog containing high-RICE features targeting "K-12 Education" and lower-RICE features targeting "Enterprise Single Sign-On (SSO) and Compliance."\n\nHow should the strategic alignment filter be applied to these features?',
        'foundational',
        'Zoom',
        'Enterprise SSO & Compliance',
        'A',
        'Prioritization frameworks like RICE or Kano should not be run in a vacuum. A "Strategic Alignment Filter" acts as a gatekeeper: if a feature does not align with the current corporate strategic objectives (e.g., Enterprise Expansion), it should not be prioritized, even if it has a high RICE score due to high reach in another segment (like K-12). Scoring features that are out of strategic scope wastes team cycles. Option B is incorrect because averaging dilutes strategic focus. Option C is incorrect because RICE does not inherently capture strategic alignment unless heavily modified. Option D is an unrealistic and counterproductive action for a PM.',
        ARRAY['prioritization', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM should filter out or deprioritize the K-12 features first because they do not align with the company''s core strategic goal, regardless of their individual RICE scores.', true),
    (v_q_id, 'B', 'The PM should calculate the average of the RICE score and the Strategic Alignment score to ensure educational users are not neglected.', false),
    (v_q_id, 'C', 'The PM should build the highest-scoring RICE features first, as RICE scores automatically account for company strategy.', false),
    (v_q_id, 'D', 'The PM should request a new corporate goal that covers both K-12 and Enterprise segments to avoid conflict.', false);

    -- ----------------------------------------
    -- QUESTION 9 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        9,
        'Stripe''s Stakeholder Alignment Session',
        E'A Stripe Product Manager is running a quarterly planning session. The VP of Sales demands custom billing features to win a new enterprise account, while the Engineering Lead insists on a database refactor to prevent system lag.\n\nWhat is the most effective initial step the PM should take to align these stakeholders?',
        'foundational',
        'Stripe',
        'Billing API Enhancements',
        'B',
        'When stakeholders have conflicting priorities, discussions can quickly devolve into political battles or bias toward the loudest voice (HIPPO). Introducing a shared, objective prioritization framework (like RICE or Value-vs-Effort) with agreed-upon metrics to evaluate both proposals transparently forces stakeholders to defend their requests with data and logical arguments rather than emotion. Option A is incorrect because voting does not address the underlying strategic value. Option C is incorrect because it ignores technical debt. Option D is a sub-optimal compromise that often results in neither project receiving the resources required to succeed.',
        ARRAY['prioritization', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conduct a blind vote where each stakeholder votes on their preferred features, with the majority winning.', false),
    (v_q_id, 'B', 'Introduce a shared, objective prioritization framework (like RICE or Value-vs-Effort) with agreed-upon metrics to evaluate both proposals transparently.', true),
    (v_q_id, 'C', 'Agree with the VP of Sales because short-term revenue is the most important metric for Stripe.', false),
    (v_q_id, 'D', 'Split the engineering resources 50/50 between the two requests to avoid conflict.', false);

    -- ----------------------------------------
    -- QUESTION 10 (Foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        10,
        'Tinder''s Reach Bias Mitigation',
        E'A Tinder Product Manager is defining the "Reach" parameter in a RICE calculation for a new premium feature called "Super Like Booster."\n\nTo ensure the prioritization is realistic and free from scoring bias, how should "Reach" be strictly defined for this calculation?',
        'foundational',
        'Tinder',
        'Premium Matching Features',
        'B',
        'A common mistake in RICE prioritization is "Reach inflation," where PMs use the total user base (e.g., total registered users or overall MAU) as the Reach value. To be accurate, Reach must be defined as the number of users who are actually exposed to and can interact with the specific feature in a given period (e.g., a quarter). For a premium booster, this would be the subset of active users who visit the shop or see the booster prompt, not the total registered user base. Option A and C inflate reach. Option D is too restrictive, as it only counts users who already perform a similar action, rather than those exposed to the new feature.',
        ARRAY['prioritization', 'scoring_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The total number of registered Tinder accounts globally.', false),
    (v_q_id, 'B', 'The estimated number of users who will actually see and interact with the "Super Like Booster" option within a specific timeframe.', true),
    (v_q_id, 'C', 'The total number of monthly active users (MAU) of Tinder.', false),
    (v_q_id, 'D', 'The total number of daily active users (DAU) who send at least one Super Like.', false);

    -- ----------------------------------------
    -- QUESTION 11 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        11,
        'Airbnb''s RICE Multi-Market Trade-off',
        E'An Airbnb Product Manager compares two search initiatives:\n\n| Feature | Reach (qtr) | Impact | Confidence | Effort (PM) |\n|---------|-------------|--------|------------|-------------|\n| A: "Luxury Tier Filter" | 500,000 | 3 (Massive) | 80% | 2 |\n| B: "Search Autocomplete" | 20,000,000 | 0.5 (Low) | 50% | 1 |\n\nUsing RICE:\n- Feature A: (500k * 3 * 0.8) / 2 = 600,000\n- Feature B: (20M * 0.5 * 0.5) / 1 = 5,000,000\n\nFeature B scores much higher due to its massive Reach. How should the PM address this "Reach bias" to make a sound strategic decision?',
        'intermediate',
        'Airbnb',
        'Search Experience Optimization',
        'B',
        'RICE scores are highly sensitive to Reach, which naturally biases the framework toward broad, horizontal platform changes (like autocomplete) over highly valuable, deep vertical features (like luxury travel). To prevent this, advanced PMs segment their product backlog and engineering resources by strategic pillars (e.g., 70% core growth, 30% premium monetization). RICE is then used to rank features within each pillar, rather than forcing a low-reach/high-value feature to compete directly against a high-reach/low-value feature. Option A is an ethical and logical violation (metric manipulation). Option C ignores the strategic value of the luxury segment. Option D is incorrect because RICE can still be highly effective within segmented backlogs.',
        ARRAY['prioritization', 'rice_calculation', 'scoring_bias', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Artificially increase the Impact score of Feature A to 25 so it outscores Feature B.', false),
    (v_q_id, 'B', 'Segment the backlog by strategic goals (e.g., "Luxury Revenue" vs "Core Engagement") and run separate RICE evaluations within each segment with dedicated resource allocations.', true),
    (v_q_id, 'C', 'Always build the highest RICE score first (Feature B) because mathematical outcomes are objective.', false),
    (v_q_id, 'D', 'Reject the RICE framework entirely and use MoSCoW, as numerical formulas cannot handle different user segment sizes.', false);

    -- ----------------------------------------
    -- QUESTION 12 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        12,
        'Shopify''s Kano Questionnaire Analysis',
        E'A Shopify Product Manager conducts a Kano survey for a proposed feature: "One-click Checkout for guest buyers." The survey results for the two standard Kano questions are:\n- Functional question ("How do you feel if guest checkouts can buy in one click?"): 70% of merchants answer "I like it," 20% answer "It must be that way."\n- Dysfunctional question ("How do you feel if guest checkouts cannot buy in one click?"): 75% of merchants answer "I dislike it," 15% answer "I can tolerate it."\n\nAccording to Kano Model evaluation rules, how should this feature be classified?',
        'intermediate',
        'Shopify',
        'Checkout Flow Enhancements',
        'B',
        'In the Kano evaluation matrix, when the presence of a feature is liked (Functional = Like) and its absence is disliked (Dysfunctional = Dislike), it is classified as a Performance (or One-dimensional) feature. These features have a linear relationship with satisfaction: the better they perform, the happier the customer is. Must-have features, by contrast, are expected as a baseline (Functional = Expect/Neutral, Dysfunctional = Dislike). Attractive features are liked if present but tolerated/accepted if absent (Functional = Like, Dysfunctional = Tolerate/Neutral). Since merchants strongly like its presence and strongly dislike its absence, it is a Performance feature.',
        ARRAY['prioritization', 'kano_model']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Must-have (Basic)', false),
    (v_q_id, 'B', 'Performance (One-dimensional)', true),
    (v_q_id, 'C', 'Attractive (Delighter)', false),
    (v_q_id, 'D', 'Indifferent', false);

    -- ----------------------------------------
    -- QUESTION 13 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        13,
        'DoorDash''s MoSCoW Dependency Trap',
        E'A DoorDash PM is using MoSCoW to prioritize features for a new "Corporate Group Ordering" tool.\n- Feature A: "Create group cart and invite links" is a Must Have (M).\n- Feature B: "Individual split-billing at checkout" is a Could Have (C).\n\nDuring technical scoping, the Engineering Lead notes that building Feature A requires a complete rewrite of the checkout database schema. If they build Feature B at the same time, it will take 1 additional week. If they delay Feature B to a future release, rewriting the schema again will take 5 weeks. How should the PM resolve this dependency?',
        'intermediate',
        'DoorDash',
        'Group Ordering Workflow',
        'B',
        'While MoSCoW represents business priority, it does not account for technical dependencies or non-linear engineering effort. If a low-priority feature ("Could Have") has a heavy technical dependency on a high-priority feature ("Must Have") such that separating them introduces massive technical debt or redundant work, the PM must adjust the sequencing. Doing the database foundation work for both features now saves 4 weeks of future engineering effort, representing a smart trade-off in resource management. Option A is inefficient. Option C is incorrect because group carts are core to the product. Option D is an anti-pattern that leads to low-quality code or team burnout.',
        ARRAY['prioritization', 'moscow_method']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep Feature B as "Could Have" and accept the 5-week rewrite cost later to protect the current sprint scope.', false),
    (v_q_id, 'B', 'Re-classify Feature B''s database foundations as a "Must Have" or adjust the release roadmap to bundle the database modifications together, optimizing engineering efficiency.', true),
    (v_q_id, 'C', 'Demote Feature A to a "Could Have" so that it matches Feature B''s priority level.', false),
    (v_q_id, 'D', 'Force the engineers to build both features within the original timeline without adjusting the prioritization.', false);

    -- ----------------------------------------
    -- QUESTION 14 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        14,
        'Uber''s Value-Effort Bias Correction',
        E'An Uber PM is prioritizing features for the driver app. The PM maps "Predictive Surge Alerts for Drivers" as High Value / Low Effort on the assumption that they can simply repurpose the existing rider demand API. The Engineering Lead, however, rates it as High Effort because the rider API cannot handle the concurrent websocket connections required for live driver push notifications.\n\nHow should the PM handle this discrepancy?',
        'intermediate',
        'Uber',
        'Driver Matching Algorithm',
        'B',
        'A common mistake in value-vs-effort prioritization is the PM estimating engineering effort based on business assumptions (e.g., "we already have a similar API"). PMs own the definition of Value, but Engineering must own the definition of Effort. When a discrepancy occurs, the PM should not override the team or guess a middle ground. Instead, they should facilitate a technical spike to investigate the constraints, which might reveal simpler implementation paths or confirm that the effort is indeed high, leading to a more accurate roadmap. Option A leads to missed deadlines. Option C is arbitrary. Option D is premature without validating the actual value and technical feasibility.',
        ARRAY['prioritization', 'value_vs_effort', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Override the Engineering Lead''s estimate because the PM owns the product roadmap and must push for aggressive timelines.', false),
    (v_q_id, 'B', 'Conduct a collaborative scoping session to understand the technical bottleneck, run a 3-day technical spike to test alternative architectures, and let the engineering team own the final Effort estimate.', true),
    (v_q_id, 'C', 'Split the difference and mark the effort as "Medium Effort" in the backlog.', false),
    (v_q_id, 'D', 'Immediately move the feature to the "Thankless Tasks" (Low Value / High Effort) quadrant and cancel it.', false);

    -- ----------------------------------------
    -- QUESTION 15 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        15,
        'Slack''s RICE Confidence Validation',
        E'A Slack PM is evaluating "Federated Search across External Drives (Google Drive, OneDrive)." The initial metrics are: Reach = 20M users, Impact = 3 (Massive), Effort = 6 person-months. However, the engineering team is highly uncertain about the stability of the OneDrive search API, leading the PM to assign a RICE Confidence score of 20% (0.2). This results in a low RICE score.\n\nWhat is the PM''s best next step?',
        'intermediate',
        'Slack',
        'Enterprise Search Integration',
        'B',
        'When a high-impact, high-reach feature has a low RICE score solely due to low Confidence (often caused by technical or user adoption uncertainty), the PM''s role is to "de-risk" the feature. Running a time-boxed spike or prototype allows the team to gather data and resolve the specific uncertainty. If the spike is successful, confidence rises (e.g., from 20% to 80%), which will dramatically increase the RICE score and justify placing it on the main roadmap. Option A is passive and misses high-potential features. Option C is dishonest and introduces severe delivery risk. Option D is incorrect because the uncertainty is technical, not customer demand, so a customer survey will not solve it.',
        ARRAY['prioritization', 'rice_calculation', 'scoring_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Place the feature in the backlog and build a lower-impact feature that has 100% confidence.', false),
    (v_q_id, 'B', 'Allocate a 1-week spike for a Senior Engineer to build a prototype integrating with the OneDrive API to resolve technical uncertainty, potentially raising the confidence score to 80%.', true),
    (v_q_id, 'C', 'Change the Confidence score to 80% anyway to secure budget, then deal with technical issues during development.', false),
    (v_q_id, 'D', 'Ask the Sales team to survey customers to increase the Confidence score.', false);

    -- ----------------------------------------
    -- QUESTION 16 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        16,
        'Netflix''s ICE Growth Backlog',
        E'A Netflix Growth PM is prioritizing onboarding experiments using the ICE framework (scale 1-10 for each parameter, scored by multiplying Impact * Confidence * Ease).\n- Experiment A: "One-click Paypal Signup" (Impact: 8, Confidence: 5, Ease: 7)\n- Experiment B: "Localized landing page hero images" (Impact: 5, Confidence: 9, Ease: 9)\n\nWhat are the ICE scores, and how should the PM prioritize these experiments?',
        'intermediate',
        'Netflix',
        'Sign-up Funnel Optimization',
        'A',
        'The multiplicative ICE score is calculated as Impact * Confidence * Ease. For Experiment A: 8 * 5 * 7 = 280. For Experiment B: 5 * 9 * 9 = 405. Since Experiment B has a higher ICE score, it should be prioritized first. Growth teams favor experiments with high confidence and ease (like localizing images) because they can be deployed quickly to generate fast learnings, even if their individual impact is moderate compared to complex integrations (like Paypal signup). Option B uses an incorrect formula. Option C ignores the core principle of the ICE score, which is to balance impact with ease and confidence. Option D has incorrect calculations.',
        ARRAY['prioritization', 'ice_score']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Experiment A = 280, Experiment B = 405; prioritize Experiment B because it has a higher confidence score and is easier to implement, yielding a higher overall ICE score.', true),
    (v_q_id, 'B', 'Experiment A = 20, Experiment B = 23; prioritize Experiment B using the additive method.', false),
    (v_q_id, 'C', 'Experiment A = 280, Experiment B = 405; prioritize Experiment A because high impact is more important than ease in a growth funnel.', false),
    (v_q_id, 'D', 'Experiment A = 56, Experiment B = 81; prioritize Experiment B because it has a higher reach.', false);

    -- ----------------------------------------
    -- QUESTION 17 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        17,
        'Canva''s HIPPO Alignment Challenge',
        E'A Canva Product Manager is finalizing the quarterly roadmap. The CEO (the HIPPO - Highest Paid Person''s Opinion) strongly requests building a "Generative AI 3D Model Creator." However, user data and support tickets show that the most requested feature is "Improved PDF Export Formatting" (which scores 4x higher in RICE due to massive Reach and low Effort).\n\nHow should the PM handle this situation?',
        'intermediate',
        'Canva',
        'Presentation Product Backlog',
        'C',
        'Managing senior stakeholders (HIPPOs) requires balancing data-driven product decisions with relationship management. Outright refusal (Option A) can damage trust and ignore the CEO''s strategic intuition. Blind compliance (Option B) ignores user data and team efficiency. The best PM approach is to expose the trade-offs using objective data, and then suggest a portfolio allocation approach—shipping the high-value utility feature while running a small, time-boxed experiment/POC to test the CEO''s high-risk, high-reward hypothesis. Option D is adversarial and unproductive.',
        ARRAY['prioritization', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Refuse the CEO''s request, citing the RICE scores, and build only the PDF Export tool.', false),
    (v_q_id, 'B', 'Build the Generative AI tool first to maintain political alignment, and put PDF Export on the back burner.', false),
    (v_q_id, 'C', 'Present the RICE analysis showing the trade-off, and propose a compromise: allocate 85% of engineering capacity to ship the PDF Export tool, and 15% to build a lightweight proof-of-concept (POC) for the AI 3D tool.', true),
    (v_q_id, 'D', 'Run a user survey specifically designed to prove the CEO''s idea is bad, then present it to the executive board.', false);

    -- ----------------------------------------
    -- QUESTION 18 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        18,
        'Uber''s Kano Decay Over Time',
        E'When Uber first introduced "Real-Time Driver Tracking on Map" in 2010, users perceived it as an Attractive (Delighter) feature that drove massive customer delight. Today, how does this feature classify in the Kano Model, and what product strategy principle does this transition demonstrate?',
        'intermediate',
        'Uber',
        'Core Rideshare Experience',
        'B',
        'The Kano Model is dynamic; customer expectations evolve. What was once a "delighter" (Attractive) becomes a standard market expectation over time as competitors copy the feature and technology matures. Today, real-time driver tracking is a baseline expectation (Must-Have); if a ride-hailing app lacks it, users will be highly dissatisfied and likely abandon the product, but having it does not create extra delight. Option A is incorrect because customer expectations are not static. Option C is incorrect; while it is copied, it is now a baseline expectation rather than a linear performance metric. Option D is incorrect because users care deeply if the tracking fails.',
        ARRAY['prioritization', 'kano_model']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It remains an Attractive feature, demonstrating that core product value does not change over time.', false),
    (v_q_id, 'B', 'It has become a Must-Have (Basic) feature, demonstrating that customer expectations rise and former delighters decay into baseline requirements over time.', true),
    (v_q_id, 'C', 'It has become a Performance feature, demonstrating that competitors eventually copy all features.', false),
    (v_q_id, 'D', 'It has become an Indifferent feature, demonstrating that users no longer care about tracking.', false);

    -- ----------------------------------------
    -- QUESTION 19 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        19,
        'Stripe''s Technical Debt Prioritization',
        E'A Stripe Product Manager is under pressure from the Sales team to support "Cryptocurrency Subscriptions." The engineering team, however, reports that the core billing engine has high technical debt, warning that adding new payment methods before refactoring will increase future feature delivery times by 50%.\n\nHow should the PM evaluate the opportunity cost of delaying the refactor?',
        'intermediate',
        'Stripe',
        'Subscription Billing Engine',
        'B',
        'Delaying technical debt refactoring has a compounding opportunity cost. While building the Crypto feature provides immediate, visible value, it degrades the codebase, making all future changes slower. The opportunity cost of delaying the refactor is the speed-to-market and revenue of every subsequent feature that is slowed down by the technical debt. PMs must balance this long-term speed degradation against the short-term benefit of the new feature. Option A is incorrect because technical debt has a major impact on product velocity. Option C represents engineering cost, not opportunity cost. Option D represents operational risk, not opportunity cost.',
        ARRAY['prioritization', 'opportunity_cost']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Technical refactors have no opportunity cost because they are internal and do not directly generate revenue.', false),
    (v_q_id, 'B', 'The opportunity cost of delaying the refactor is the cumulative delay and lost revenue from all future billing features, which must be weighed against the immediate revenue gain of the Crypto subscription feature.', true),
    (v_q_id, 'C', 'The opportunity cost is the direct salary cost of the developers while they work on the refactor.', false),
    (v_q_id, 'D', 'The opportunity cost is the risk of a system crash, which should be quantified by the QA team.', false);

    -- ----------------------------------------
    -- QUESTION 20 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        20,
        'Notion''s High-Effort Strategic Bet',
        E'A Notion PM is reviewing a Value vs. Effort matrix. The feature "Notion AI Collaborative Document Reviewer" is classified as High Value / High Effort (Major Project). The backlog is currently full of High Value / Low Effort (Quick Wins).\n\nWhat is the strategic risk of prioritizing only the Quick Wins quarter after quarter?',
        'intermediate',
        'Notion',
        'Workspace Collaboration Tools',
        'B',
        'While "Quick Wins" (High Value, Low Effort) are tempting because they offer rapid gratification and high short-term ROI, relying on them exclusively leads to incrementalism. A product cannot survive solely on minor optimizations; it requires "Major Projects" (High Value, High Effort) to build deep, defensible moats, catch up on major shifts (like AI), and open up new markets. Option A is a risk of bad design, not incrementalism. Option C is a secondary human resource concern, not the primary product strategy risk. Option D is incorrect because Quick Wins often do drive short-term revenue, but they fail to secure long-term defensibility.',
        ARRAY['prioritization', 'value_vs_effort', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The product will become too complex for new users due to feature bloat.', false),
    (v_q_id, 'B', 'The product will accumulate incremental enhancements but fail to build defensible competitive advantages or execute necessary strategic pivots.', true),
    (v_q_id, 'C', 'The engineering team will experience burnout due to the lack of technically challenging work.', false),
    (v_q_id, 'D', 'The company will lose short-term revenue because Quick Wins do not convert users.', false);

    -- ----------------------------------------
    -- QUESTION 21 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        21,
        'Duolingo''s RICE Bias Correction',
        E'The Lead Product Manager at Duolingo notices that during quarterly planning, PMs from different product pods consistently rate all of their own features as having "Massive Impact (3)" and "100% Confidence." This scoring inflation makes the centralized RICE spreadsheet useless.\n\nWhat is the most effective way to eliminate this subjective scoring bias?',
        'intermediate',
        'Duolingo',
        'Gamification & Churn Prevention',
        'B',
        'Scoring bias and inflation occur when prioritization criteria are subjective. To make frameworks like RICE work across multiple teams, the organization must define a strict, shared rubric. For Impact, mapping numbers (3, 2, 1, 0.5) to specific quantitative ranges of business growth forces PMs to justify their scores with models. For Confidence, mapping percentages (100%, 80%, 50%) to specific data sources (A/B tests, user research, gut feeling) prevents groundless optimism. Option A replaces one bias with another. Option C is too simplistic. Option D is arbitrary and unscientific.',
        ARRAY['prioritization', 'scoring_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Let the Lead PM manually adjust and re-score all features based on their personal opinion.', false),
    (v_q_id, 'B', 'Establish a strict, objective scoring rubric for Impact and Confidence (e.g., 3 = projected to increase company North Star DAU by >3%; 100% Confidence = backed by recent randomized A/B test data).', true),
    (v_q_id, 'C', 'Transition to a binary prioritization system (Yes/No) to remove all numerical values.', false),
    (v_q_id, 'D', 'Divide every PM''s self-reported RICE score by their years of experience at the company.', false);

    -- ----------------------------------------
    -- QUESTION 22 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        22,
        'Spotify''s Kano Survey Discordance',
        E'A Spotify Product Manager analyzes a Kano survey for a proposed feature: "Live Listening Party with voice chat." The aggregate data shows a high percentage of "Indifferent" responses for the Functional question, but the Dysfunctional question has a bimodal distribution: 40% "Dislike it" and 45% "Neutral."\n\nHow should the PM interpret and act on these results?',
        'intermediate',
        'Spotify',
        'Collaborative Social Listening',
        'B',
        'Bimodal distributions or highly fragmented responses in a Kano survey indicate that the customer base is not homogeneous. A feature that is useless or "Indifferent" to a solo listener (e.g., older users listening to podcasts) might be an essential "Must-Have" or "Performance" feature for a highly active social segment (e.g., teenagers hosting virtual listening rooms). By segmenting the data, the PM can identify if there is a target market segment that justifies building the feature for a specific cohort. Option A ignores the valuable sub-segment. Option C is premature because the overall audience is indifferent. Option D is expensive and doesn''t address the segmentation problem.',
        ARRAY['prioritization', 'kano_model']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Discard the feature immediately because the aggregate majority of users are indifferent.', false),
    (v_q_id, 'B', 'Segment the survey respondents by user behavior (e.g., heavy social shares vs. solo listeners) to see if a distinct, valuable sub-segment highly values the feature.', true),
    (v_q_id, 'C', 'Build the feature immediately because 40% dislike its absence, which makes it a Must-Have.', false),
    (v_q_id, 'D', 'Change the UI design of the feature and run the survey again to the same group.', false);

    -- ----------------------------------------
    -- QUESTION 23 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        23,
        'Figma''s MoSCoW Boundary Enforcement',
        E'A Figma PM is managing the launch of "Figma Slides." The project uses MoSCoW prioritization. Two weeks before the launch, the Engineering Lead reports that the team is behind schedule. A "Should Have" feature ("Presenter view drawing tool") is only 30% complete, and its completion threatens the launch date of the "Must Have" features (like "Basic slide transitions").\n\nWhat action should the PM take?',
        'intermediate',
        'Figma',
        'Collaboration & Sharing Tools',
        'B',
        'The primary benefit of the MoSCoW framework is that it provides a clear, pre-negotiated plan for scope cuts when schedules slip. "Must Have" features are non-negotiable for a viable launch, whereas "Should Haves" are highly important but can be deferred. When a project is delayed, the PM should immediately descopo "Should Have" and "Could Have" items to protect the launch date and quality of the "Must Haves." Option A ignores the release schedule constraint. Option C leads to low morale and technical debt. Option D defeats the purpose of the initial prioritization.',
        ARRAY['prioritization', 'moscow_method']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delay the launch by two weeks to ensure all "Must Have" and "Should Have" features ship together.', false),
    (v_q_id, 'B', 'Cut or descoping the "Should Have" drawing tool immediately to protect the launch date and focus all resources on stabilizing the "Must Have" transition features.', true),
    (v_q_id, 'C', 'Direct the team to work overtime to complete both features by the original deadline.', false),
    (v_q_id, 'D', 'Demote the transition features to "Should Have" and prioritize the drawing tool instead.', false);

    -- ----------------------------------------
    -- QUESTION 24 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        24,
        'Shopify''s App Store Build vs Buy',
        E'A Shopify Product Manager is deciding whether to build a native "SMS Marketing Automation Tool" in-house (estimated effort: 10 months) or partner with an existing app in the Shopify App Store to integrate it natively (estimated effort: 2 months). Building in-house offers higher long-term gross margins, but partnering gets merchants a solution 8 months faster.\n\nHow should the PM frame the opportunity cost of building in-house?',
        'intermediate',
        'Shopify',
        'Merchant Marketing Tools',
        'A',
        'The opportunity cost of a 10-month in-house build includes both: 1. the lost business value/revenue of the SMS tool itself during the 8-month delay compared to partnering, and 2. the value of the other features the engineering team could have built during the extra 8 months they spent coding the SMS tool. This comprehensive view of opportunity cost prevents companies from making low-ROI build decisions. Option B represents direct financial expenses. Option C represents technical risk. Option D represents the cost of the alternative option, not the opportunity cost of the chosen path.',
        ARRAY['prioritization', 'opportunity_cost']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The opportunity cost of building in-house is the subscription revenue lost from merchants who install competitor apps during the 8-month development delay, plus the value of other roadmap features the team could have built in those 8 months.', true),
    (v_q_id, 'B', 'The opportunity cost is the cost of engineering salaries paid during the extra 8 months of development.', false),
    (v_q_id, 'C', 'The opportunity cost is the technical debt that will accumulate in the codebase during the 10-month build.', false),
    (v_q_id, 'D', 'The opportunity cost is the licensing fee that Shopify would have paid to the partner app.', false);

    -- ----------------------------------------
    -- QUESTION 25 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        25,
        'Airbnb''s Effort Sizing Discrepancy',
        E'An Airbnb PM maps a feature, "Local Currency Payouts for Small Hosts in LATAM," as High Value / Low Effort (Quick Win) based on initial API documentation. However, during detailed technical design, the compliance team states that local regulations require custom identity check integrations, increasing the engineering effort from 2 weeks to 4 months.\n\nHow should the PM re-evaluate this feature?',
        'intermediate',
        'Airbnb',
        'Host Payment Onboarding',
        'B',
        'When the effort estimate of a feature changes significantly, its position on the prioritization matrix shifts. A feature that was a "Quick Win" (High Value, Low Effort) becomes a "Major Project" (High Value, High Effort). The PM must re-evaluate it against other major projects, as it will now consume significant engineering resources that could be used elsewhere. It should not be forced into the current sprint as a quick task. Option A ignores the resource constraint. Option C is too extreme; the feature may still be highly valuable and worth building as a major project. Option D is illegal and presents high regulatory risk.',
        ARRAY['prioritization', 'value_vs_effort']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep it prioritized as a Quick Win because the potential value to LATAM hosts remains unchanged.', false),
    (v_q_id, 'B', 'Move it from "Quick Win" to "Major Project" (High Value / High Effort) and re-evaluate its priority against other long-term strategic initiatives rather than expecting an immediate release.', true),
    (v_q_id, 'C', 'Cancel the project immediately because it is no longer a low-effort feature.', false),
    (v_q_id, 'D', 'Instruct the engineering team to build the feature without the compliance checks to keep the effort low.', false);

    -- ----------------------------------------
    -- QUESTION 26 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        26,
        'Discord''s RICE Confidence Decay',
        E'A Discord PM calculated a high RICE score for "Mobile Screen Sharing with Audio Support" in Q1. Due to resource constraints, the feature was delayed. By Q4, two major competitors launched high-quality mobile screen sharing.\n\nAssuming the engineering effort remains the same, how does this competitor activity affect the RICE inputs for the Discord feature?',
        'intermediate',
        'Discord',
        'Mobile Screen Sharing',
        'C',
        'When competitors launch a feature first, it shifts from being a potential differentiation feature (high impact) to a table stakes or parity feature. Thus, the incremental Impact on acquisition and retention decreases. Furthermore, Confidence in the original business model and adoption estimates decreases because competitor actions alter market dynamics, requiring the PM to gather new data and re-evaluate. Option A is incorrect because competitors capture market share, potentially reducing Discord''s reach. Option B is incorrect; technical viability of others does not equal confidence in your own team''s execution and delivery. Option D is incorrect because competitive pressure does not reduce engineering complexity.',
        ARRAY['prioritization', 'rice_calculation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reach increases because the market is now educated about mobile screen sharing.', false),
    (v_q_id, 'B', 'Confidence increases because the competitors have proven that the technology is viable on mobile devices.', false),
    (v_q_id, 'C', 'Impact decreases because the feature is no longer a differentiator, and Confidence decreases because competitor presence shifts user expectations and behavior, requiring recalculation.', true),
    (v_q_id, 'D', 'Effort decreases because the competitive threat forces engineers to write code faster.', false);

    -- ----------------------------------------
    -- QUESTION 27 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        27,
        'Slack''s Resource Allocation Conflict',
        E'A Slack Product Manager faces a common conflict: the Sales team demands custom features to close three large enterprise contracts (high short-term revenue), while the Design team wants to redesign the navigation interface to reduce long-term user drop-off (high long-term retention).\n\nWhat is the most strategic way to resolve this conflict?',
        'intermediate',
        'Slack',
        'Core App Navigation Redesign',
        'B',
        'Attempting to use a single prioritization score (like RICE) to compare completely different classes of work (enterprise features vs. core UX refactoring) often leads to gridlock or bias toward short-term revenue. Best-in-class product organizations use portfolio allocation (or investment buckets) to partition engineering capacity. This ensures that the team continues to make strategic progress on long-term user experience and technical health while still supporting sales enablement. Option A ignores long-term product decay. Option C leads to stagnation. Option D is unethical and damages organizational trust.',
        ARRAY['prioritization', 'stakeholder_alignment', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Prioritize the Sales requests because immediate revenue is the most tangible and easily measured metric.', false),
    (v_q_id, 'B', 'Create a portfolio allocation framework (e.g., 60% Enterprise Customer Requests, 30% Core UX & Tech Debt, 10% Innovation) to allocate dedicated engineering capacity to each area.', true),
    (v_q_id, 'C', 'Postpone both initiatives and ask the teams to vote on a single priority for the quarter.', false),
    (v_q_id, 'D', 'Implement the design changes in secret while telling the Sales team that their features are in development.', false);

    -- ----------------------------------------
    -- QUESTION 28 (Intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        28,
        'Stripe''s Custom API Demands',
        E'A prospective enterprise customer promises Stripe $1.2 million in annual recurring revenue (ARR) if Stripe builds a custom billing dashboard widget. The PM estimates that building this widget will occupy the core dashboard engineering team for the entire quarter (3 months).\n\nWhat is the most rigorous way for the PM to evaluate whether to accept this request?',
        'intermediate',
        'Stripe',
        'Dashboard Enterprise Widgets',
        'B',
        'Building custom features for a single client carries a massive opportunity cost: the core engineering team is locked up, unable to build platform features that benefit thousands of other customers. To make an objective decision, the PM must model the expected value of the alternative roadmap (e.g., if shipping 3 platform features would unblock $3M ARR across 50 smaller clients, then accepting the $1.2M custom request is a net loss). Option A ignores opportunity cost. Option C is operationally non-viable. Option D is too dogmatic, as sometimes enterprise requests align with the long-term roadmap and are worth building.',
        ARRAY['prioritization', 'opportunity_cost', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the request immediately because $1.2M ARR is a clear, high-value win that directly maps to business growth.', false),
    (v_q_id, 'B', 'Compare the $1.2M ARR with the estimated aggregate value (Reach * Impact * Revenue Potential) of the other roadmap features the team would have built during those 3 months for the broader customer base.', true),
    (v_q_id, 'C', 'Request that the customer pay Stripe''s engineers directly for their overtime hours to build it.', false),
    (v_q_id, 'D', 'Decline the request because custom features should never be built for individual customers under any circumstances.', false);

    -- ----------------------------------------
    -- QUESTION 29 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        29,
        'Netflix''s Simpson''s Paradox in Reach',
        E'A Netflix PM is evaluating a proposed "Korean Drama Interactive Hub" feature.\n- Global Subscriber Reach: ~6% of total global subscribers (approx. 16M users).\n- APAC Subscriber Reach: 85% of active APAC subscribers.\n- Subscriber Retention Risk: Global average churn is 3%; however, APAC subscribers who watch K-Dramas have a 12% churn rate if they do not see new releases weekly.\n\nIf the PM evaluates this feature using standard global RICE parameters, the low global Reach (6%) yields a low priority score. What analytical trap does the PM fall into, and how should it be corrected?',
        'advanced',
        'Netflix',
        'Regional Content Personalization',
        'B',
        'Simpson''s Paradox and composition bias occur when aggregate data trends disappear or reverse when the data is segmented. Globally, the feature looks low-priority because the vast majority of subscribers (e.g., in North America or Europe) may not interact with it. However, within the APAC region and the high-value K-Drama enthusiast segment—which has a high churn rate—the reach and retention impact are massive. Evaluating this purely on a global aggregate level leads to poor strategic decisions. Correcting this requires segment-weighted scoring or evaluating the feature within a regional prioritization bucket. Options A, C, and D do not address the analytical error of aggregate metrics.',
        ARRAY['prioritization', 'scoring_bias', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM falls into the sunk cost fallacy; they should ignore the low reach and build the feature because the APAC team has already done research.', false),
    (v_q_id, 'B', 'The PM falls into Simpson''s Paradox / composition bias, where aggregate low reach masks extremely high, critical reach within a high-churn segment; corrected by weighting the Reach parameter by the segment''s churn risk or Lifetime Value (LTV).', true),
    (v_q_id, 'C', 'The PM commits a correlation-to-causation error; corrected by running a global multi-variate test before scoring.', false),
    (v_q_id, 'D', 'The PM suffers from effort bias; corrected by reducing the estimated engineering effort to make the score competitive.', false);

    -- ----------------------------------------
    -- QUESTION 30 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        30,
        'Notion''s Kano Indifferent to Performance Shift',
        E'A Notion PM conducts a Kano survey for "Git-style Version History Branching." The overall customer base (comprising students, writers, and general users) classifies the feature as Indifferent. However, when segmenting the data, the PM discovers that software engineers and technical PMs classify it as a Performance and Must-Have feature. The company''s new corporate strategy is "Enterprise Developer Tooling Market Expansion."\n\nHow should the PM proceed?',
        'advanced',
        'Notion',
        'Developer Workspace Features',
        'B',
        'Prioritization must align with forward-looking corporate strategy, not just current user demographics. While developers represent a minority of current users (80% are indifferent general users), the strategic goal is to expand into the developer market. Therefore, the preferences of that target segment must be heavily weighted. Using the segment-specific Kano insights (Must-Have/Performance for developers) justifies the investment and guides the product design to be highly technical rather than watered down. Option A ignores the new strategic direction. Option C results in a feature that satisfies neither segment. Option D is a statistical error that hides the critical segment needs.',
        ARRAY['prioritization', 'kano_model', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Deprioritize the feature because the general user base represents 80% of Notion''s current active users and they are indifferent.', false),
    (v_q_id, 'B', 'Prioritize the feature on the roadmap, but target the product design and marketing messaging specifically to the developer segment, using the segment-specific Kano classification to justify the resource allocation.', true),
    (v_q_id, 'C', 'Build a simplified version of version branching that is easy for writers to use, compromising between the two segments.', false),
    (v_q_id, 'D', 'Average the Kano scores across all users and classify the feature as a weak "Attractive" feature.', false);

    -- ----------------------------------------
    -- QUESTION 31 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        31,
        'Uber''s Late-stage Roadmap Pivot',
        E'Uber''s engineering team has spent 6 months and $2 million developing "Shared Rides 2.0," a complex matching algorithm. The project is 80% complete and requires 1 more month to ship. A sudden regulatory shift in major cities slashes the projected profitability of shared rides. The PM identifies a new initiative: "EV Driver Charging Subsidies," which requires the same engineering resources for 1 month and has a projected ROI 4 times higher than the updated projection for Shared Rides 2.0. The team resists pivoting because of the work already completed.\n\nHow should the PM frame the decision?',
        'advanced',
        'Uber',
        'Shared Rides Matching Engine',
        'B',
        'This scenario tests the ability to overcome the Sunk Cost Fallacy. The $2 million and 6 months spent are historical (sunk) costs and should not influence future decisions. The only relevant metrics are the future resources required (1 month of effort for either project) and the future value generated. The opportunity cost of spending the next 1 month finishing Shared Rides 2.0 is the 4x higher value of the EV Charging initiative. The PM must ignore the past investment and choose the EV Charging project if its marginal return over the next month is higher. Option A is a classic sunk cost trap. Option C adds unnecessary delay. Option D violates the resource constraint and delays both features.',
        ARRAY['prioritization', 'opportunity_cost', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Complete Shared Rides 2.0 because the $2 million is already spent, and stopping now would waste the team''s effort.', false),
    (v_q_id, 'B', 'Compare the marginal 1 month of effort required to finish Shared Rides 2.0 against the opportunity cost of delaying the EV Charging initiative for 1 month, ignoring the $2M historical cost.', true),
    (v_q_id, 'C', 'Delay both projects and run a 3-month comprehensive market study to resolve the team''s disagreement.', false),
    (v_q_id, 'D', 'Split the engineering team so that both features are completed over the next 3 months.', false);

    -- ----------------------------------------
    -- QUESTION 32 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        32,
        'Figma''s Weighted RICE Customization',
        E'Figma is transitioning from a self-serve growth model to an enterprise-sales-led model. The standard RICE formula (Reach * Impact * Confidence) / Effort consistently favors consumer features (high Reach, low Effort) over critical enterprise security features like "Role-Based SAML SSO" (low Reach in terms of user count, but vital for closing high-value contracts).\n\nHow should the PM customize the RICE framework to align with this strategic shift?',
        'advanced',
        'Figma',
        'Enterprise Governance & Security',
        'B',
        'The standard RICE formula is optimized for volume (user reach) and can fail in enterprise SaaS where value is concentrated in a small number of high-paying customers. Advanced PMs adapt the formula by adding a "Strategic Alignment Weight" (or "Revenue Value Weight") multiplier. This adjusts the score to reflect strategic value, allowing low-reach, high-contract-value features to compete fairly with high-reach consumer features. Option A removes all structure. Option C is a form of reach inflation that misrepresents actual feature usage. Option D is manipulation of data estimates, which ruins engineering trust.',
        ARRAY['prioritization', 'rice_calculation', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Abandon RICE completely and rely on qualitative sales feedback to dictate the entire roadmap.', false),
    (v_q_id, 'B', 'Modify the RICE formula to: (Reach * Impact * Confidence * Strategic Alignment Weight) / Effort, where "Strategic Alignment" is a multiplier (e.g., 1.0 to 3.0) assigned based on alignment with Enterprise Sales goals.', true),
    (v_q_id, 'C', 'Multiply the Reach of the SAML SSO feature by the total number of employees at all target enterprise companies, rather than active Figma users.', false),
    (v_q_id, 'D', 'Artificially reduce the Effort score of all enterprise features to 1 person-month to boost their scores.', false);

    -- ----------------------------------------
    -- QUESTION 33 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        33,
        'Stripe''s High-Effort Nonlinear Risk',
        E'A Stripe PM is evaluating a "Cross-Border Stablecoin Settlement API" using a Value vs. Effort matrix. The PM initially classifies it as High Value / High Effort. However, the engineering team notes that "High Effort" for blockchain and regulatory compliance projects exhibits non-linear complexity and high tail-risk (e.g., security audits, licensing delays) compared to typical web development.\n\nHow should the PM adjust the prioritization filter to manage this non-linear risk?',
        'advanced',
        'Stripe',
        'Cross-Border Settlement API',
        'A',
        'In complex software systems (especially in fintech or infrastructure), large project estimates are notoriously inaccurate. The risk and effort scale non-linearly due to hidden dependencies, external audits, and compliance. To mitigate this, PMs should apply a risk multiplier to high-complexity projects (increasing their Effort score or reducing their Confidence score) and require a preliminary phase (like a proof-of-concept or legal review) before scheduling them. Option B ignores the reality of software engineering delays. Option C prevents the company from executing high-value strategic bets. Option D does not address the engineering and compliance delivery risks.',
        ARRAY['prioritization', 'value_vs_effort', 'scoring_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apply an "Effort Uncertainty Premium" by multiplying the effort score of high-complexity projects by a risk multiplier (e.g., 1.5x or 2.0x), and mandate a preliminary "de-risking" phase before full commitment.', true),
    (v_q_id, 'B', 'Treat the effort as linear and manage any timeline overruns using standard Agile sprint extensions.', false),
    (v_q_id, 'C', 'Avoid all High Effort features entirely and focus the roadmap exclusively on Low Effort features.', false),
    (v_q_id, 'D', 'Ask the sales team to secure deposits from customers to offset the technical risk of development.', false);

    -- ----------------------------------------
    -- QUESTION 34 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        34,
        'GitHub''s Cross-Team Dependency Alignment',
        E'The PM for the GitHub Actions team needs the Security & Identity team to expose a new "OIDC Token Exchange API" to build "Actions Secrets Manager." The Security team prioritizes their own backlog using RICE, and the token exchange API scores lower than their internal security projects, causing a bottleneck.\n\nHow should the Actions PM resolve this cross-team priority deadlock?',
        'advanced',
        'GitHub',
        'Actions Secrets Management',
        'B',
        'In platform engineering and multi-team organizations, dependencies frequently fail prioritization because the provider team (Security) only measures the direct impact of the API, not the downstream value of the consumer feature (Actions Secrets Manager). By co-authoring the RICE score and adding the downstream reach/impact (e.g., the millions of developers who will use Actions Secrets Manager), the API''s true business value is reflected, naturally lifting its priority on the Security team''s backlog. Option A is a heavy-handed escalation that damages collaboration. Option C violates code ownership and security protocols. Option D introduces security vulnerabilities.',
        ARRAY['prioritization', 'stakeholder_alignment', 'prioritization_filters']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Escalate the deadlock to the VP of Product to force the Security team to prioritize the API.', false),
    (v_q_id, 'B', 'Collaborate with the Security team to recalculate the RICE score of the API by incorporating the downstream Reach and Impact of the Actions Secrets Manager that it unblocks.', true),
    (v_q_id, 'C', 'Have the Actions team build the token exchange API themselves in Security''s codebase, bypassing Security''s review process to save time.', false),
    (v_q_id, 'D', 'Redesign the Actions Secrets Manager to bypass token exchange, using basic username/password auth instead.', false);

    -- ----------------------------------------
    -- QUESTION 35 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        35,
        'Duolingo''s Mathematical Bias in ICE',
        E'A Duolingo Growth PM uses ICE scoring (Impact * Confidence * Ease on a scale of 1-10) to prioritize experiments.\n- Experiment A (Breakthrough): Impact = 9, Confidence = 8, Ease = 2 (Score = 144)\n- Experiment B (Minor Optimization): Impact = 5, Confidence = 5, Ease = 6 (Score = 150)\n\nThe formula ranks the minor optimization (Experiment B) higher, penalizing the breakthrough idea (Experiment A) due to its high complexity (low Ease). How should the PM strategically adjust for this mathematical bias in the prioritization process?',
        'advanced',
        'Duolingo',
        'Gamified Learning Loops',
        'B',
        'Multiplicative formulas like ICE or RICE are mathematically biased toward features that are easy to build (high Ease / low Effort). This bias can lead to an "optimization trap" where a team only builds minor tweaks and never attempts high-impact, complex breakthroughs. The standard solution is not to manipulate the formula (which ruins its consistency) but to allocate dedicated resource budgets for different product horizons (e.g., McKinsey''s Three Horizons). By separating optimization work from breakthrough initiatives, high-impact features are evaluated against each other rather than competing with easy wins. Option A dilutes the differentiation of the framework. Option C is arbitrary score manipulation. Option D ignores resource constraints entirely.',
        ARRAY['prioritization', 'ice_score', 'scoring_bias', 'opportunity_cost']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the formula to addition (Impact + Confidence + Ease) to reduce the penalty on complex features.', false),
    (v_q_id, 'B', 'Establish dedicated resource buckets for different horizons (e.g., 70% optimizations, 30% breakthroughs), allowing Experiment A to compete only against other high-impact, high-complexity ideas.', true),
    (v_q_id, 'C', 'Manually increase the Ease score of Experiment A to 5 to make the scores match the PM''s intuition.', false),
    (v_q_id, 'D', 'Eliminate the Ease parameter from all calculations and rank features solely by Impact.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Prioritization (RICE)';

END $$;
