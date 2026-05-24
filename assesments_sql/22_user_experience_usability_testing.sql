-- ============================================
-- ASSESSMENT: Usability Testing
-- CATEGORY: User Experience
-- TOTAL QUESTIONS: 35
-- DIFFICULTY: ~10 foundational, ~18 intermediate, ~7 advanced
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_q_id UUID;
BEGIN
    -- Look up the sub-skill ID
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'usability-testing';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug usability-testing not found. Run the seed data first.';
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
        'Airbnb''s Think-Aloud Protocol',
        E'Airbnb''s PM is conducting a moderated usability test for a new checkout flow. During the test, a user struggles to find the "Apply Promo Code" button but remains completely silent for over a minute.\n\nWhat is the best immediate action for the moderator to take?',
        'foundational',
        'Airbnb',
        'Moderated usability testing of a checkout flow',
        'B',
        'Option B is correct because the think-aloud protocol relies on understanding the user''s internal thought process. Prompting them neutrally to speak their thoughts helps uncover why they are stuck without leading them or giving away the answer. Option A is wrong because intervening prematurely ruins the opportunity to observe if and how users recover from errors naturally. Option C is wrong because extended silence means missed qualitative insights, which is the primary goal of the test. Option D is wrong because abandoning the task immediately prevents you from understanding the root cause of the friction.',
        ARRAY['think_aloud_protocol', 'moderated_testing', 'facilitation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stop the test immediately and explain where the button is.', false),
    (v_q_id, 'B', 'Ask the user: "What are you thinking right now as you look at this screen?"', true),
    (v_q_id, 'C', 'Ignore the silence and wait until they eventually find it or give up.', false),
    (v_q_id, 'D', 'Record it as a failure and move on to the next task.', false);

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
        'Spotify''s Unmoderated Testing',
        E'A PM at Spotify wants to quickly test whether users understand the new iconography for a "Collaborative Playlist" feature before launching it. They have a high-fidelity prototype and need task-based feedback within 24 hours from 50 users globally.\n\nWhat is the most appropriate research method?',
        'foundational',
        'Spotify',
        'Validating UI iconography rapidly',
        'B',
        'Option B is correct because unmoderated remote testing allows for rapid, asynchronous data collection from a large, geographically dispersed sample size using specific task prompts. Option A is wrong because recruiting and running 50 in-person sessions within 24 hours is logistically impossible. Option C is wrong because an emailed survey relies on self-reported attitudinal data rather than observing behavioral task success. Option D is wrong because a heuristic evaluation uses internal experts, not actual users, and won''t validate if real users understand the icons.',
        ARRAY['unmoderated_testing', 'remote_testing', 'methodology_selection']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conduct in-person lab usability testing.', false),
    (v_q_id, 'B', 'Run an unmoderated remote usability test with a specific task prompt.', true),
    (v_q_id, 'C', 'Email a survey to all active Spotify users asking them to rate the icons.', false),
    (v_q_id, 'D', 'Do a heuristic evaluation with the internal design team.', false);

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
        'Netflix''s Prototype Fidelity',
        E'Netflix is exploring a radically new layout for the home screen. The team has just started the ideation phase and wants to see if the general categorization and information architecture make sense to users, long before investing engineering time.\n\nWhat prototype fidelity is most appropriate?',
        'foundational',
        'Netflix',
        'Early-stage concept testing for layout',
        'B',
        'Option B is correct because low-fidelity prototypes (like paper or simple clickable wireframes) are ideal for testing foundational concepts, layout, and information architecture without the distraction of visual design or the high cost of coding. Option A is wrong because building a coded prototype at the ideation stage is a massive waste of engineering resources if the core concept fails. Option C is wrong because you do not need real backend data to test mental models and categorization. Option D is wrong because launching an untested radical redesign as an A/B test risks heavily degrading the user experience at scale.',
        ARRAY['prototype_fidelity', 'early_testing', 'information_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build a fully functional, coded React prototype to test interactively.', false),
    (v_q_id, 'B', 'Use a low-fidelity paper or simple clickable wireframe prototype.', true),
    (v_q_id, 'C', 'Wait until the backend APIs are ready to populate real data before testing.', false),
    (v_q_id, 'D', 'Skip usability testing and launch an A/B test directly.', false);

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
        'Slack''s Usability Metric',
        E'Slack''s PM wants to measure the efficiency of a new channel creation flow. During a usability test with 5 users, the PM records the following data:\n\n| User | Metric Captured |\n|---|---|\n| 1 | 45 seconds |\n| 2 | 52 seconds |\n| 3 | 38 seconds |\n| 4 | 61 seconds |\n| 5 | 40 seconds |\n\nWhich usability metric is the PM capturing here?',
        'foundational',
        'Slack',
        'Measuring efficiency of user flows',
        'A',
        'Option A is correct because the data directly measures "Time on Task," which is the standard behavioral metric for evaluating the efficiency of a user flow. Option B (NPS) is wrong because it measures overall brand loyalty and likelihood to recommend, not task efficiency. Option C (SUS) is wrong because it is a 10-item attitudinal questionnaire measuring perceived usability, not raw time. Option D (CES) is wrong because it asks users to rate how much effort they expended, making it a subjective attitudinal score rather than an objective time measurement.',
        ARRAY['metrics', 'time_on_task', 'efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Time on Task', true),
    (v_q_id, 'B', 'Net Promoter Score (NPS)', false),
    (v_q_id, 'C', 'System Usability Scale (SUS)', false),
    (v_q_id, 'D', 'Customer Effort Score (CES)', false);

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
        'Uber''s Recruitment Screener',
        E'Uber is testing a new feature specifically for users who frequently schedule rides to the airport. The PM is drafting a screener questionnaire to recruit participants.\n\nWhich screener question will yield the most unbiased, accurate cohort?',
        'foundational',
        'Uber',
        'Recruiting target users for a test',
        'B',
        'Option B is correct because it asks an open, behavioral question without revealing what specific answer the recruiter is looking for. This prevents participants from lying just to get selected. Option A is wrong because it is a leading "yes/no" question that tells the user exactly what behavior is desired, prompting "professional testers" to say yes to qualify for the incentive. Option C asks about preferences rather than actual behavior. Option D is too narrow and assumes they must be traveling immediately, which over-constrains the pool.',
        ARRAY['recruitment', 'screener_design', 'bias_prevention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Do you frequently schedule Uber rides to the airport?"', false),
    (v_q_id, 'B', '"How often do you travel to the airport, and what transportation methods do you typically use?"', true),
    (v_q_id, 'C', '"Do you like using Uber when you travel to the airport?"', false),
    (v_q_id, 'D', '"Are you planning an airport trip in the next 24 hours?"', false);

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
        'Duolingo''s Leading Question',
        E'Duolingo''s PM is moderating a usability session on a new streak recovery feature. After the task, the PM asks: "How easy was it to use our new streak recovery button?"\n\nWhy is this a flawed moderation technique?',
        'foundational',
        'Duolingo',
        'Moderating user feedback sessions',
        'B',
        'Option B is correct because the phrasing "How easy was it..." presumes that the feature was, in fact, easy. This is a leading question that biases the participant to agree to avoid social awkwardness. A better, neutral question would be "How would you describe your experience using that feature?" Option A is wrong because leading questions yield invalid satisfaction data. Option C is wrong because leading questions are bad regardless of task success. Option D is wrong because satisfaction can be asked verbally, just not in a leading way.',
        ARRAY['bias', 'moderation_skills', 'interviewing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is a good question because it directly measures user satisfaction.', false),
    (v_q_id, 'B', 'It is a leading question that biases the user to agree that the feature is easy.', true),
    (v_q_id, 'C', 'It should only be asked if the user successfully completed the task.', false),
    (v_q_id, 'D', 'It is a quantitative metric question that cannot be asked verbally.', false);

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
        'DoorDash''s Task Success Rate',
        E'DoorDash is evaluating a new group ordering flow. The PM reviews the results from 20 usability test participants:\n\n| Outcome | Number of Users |\n|---|---|\n| Success with no errors | 12 |\n| Success with minor recoverable errors | 3 |\n| Success but critical error (wrong order) | 2 |\n| Gave up / Failed | 3 |\n\nWhat is the clean task success rate (users who succeeded without critical errors)?',
        'foundational',
        'DoorDash',
        'Calculating task success metrics',
        'C',
        'Option C is correct. Task success is defined as users achieving the goal without critical failures. Here, 12 succeeded perfectly, and 3 succeeded after minor, recoverable errors (15 total). 15/20 = 75%. Option A is wrong because it counts failures. Option B (85%) wrongly includes the 2 users who made critical errors (like ordering the wrong food), which is a failure in the real world. Option D (60%) is too strict, as minor recoverable errors still count as a success in standard usability metrics.',
        ARRAY['task_success_rate', 'metrics', 'quantitative_usability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '100% (20/20 completed the task or tried)', false),
    (v_q_id, 'B', '85% (17/20 finished the checkout flow in some capacity)', false),
    (v_q_id, 'C', '75% (15/20 succeeded without critical errors)', true),
    (v_q_id, 'D', '60% (12/20 succeeded with absolutely zero errors)', false);

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
        'Stripe''s Methodology Selection',
        E'Stripe is redesigning its complex developer dashboard. The PM needs deep qualitative insights, the ability to read facial expressions, and the option to dynamically probe on complex technical terms when developers get stuck during the test.\n\nWhich testing method should they choose?',
        'foundational',
        'Stripe',
        'Choosing the right research method',
        'B',
        'Option B is correct because moderated testing (whether in-person or live remote) allows the researcher to dynamically probe, ask follow-up questions, and read body language in real time, which is crucial for complex B2B/developer workflows. Option A is wrong because unmoderated tests rely on static scripts and cannot adapt if a developer gets stuck on a nuance. Option C is wrong because A/B testing provides quantitative behavioral data but no qualitative "why." Option D is wrong because tree testing only evaluates information architecture, not the full dashboard experience.',
        ARRAY['moderated_testing', 'methodology_selection', 'qualitative_research']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Unmoderated remote testing', false),
    (v_q_id, 'B', 'Moderated in-person or live remote testing', true),
    (v_q_id, 'C', 'A/B testing', false),
    (v_q_id, 'D', 'Tree testing', false);

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
        'Robinhood''s Post-Test Questionnaire',
        E'After completing a usability test of Robinhood''s new options trading interface, the PM wants a standardized, quick measure of perceived usability to compare against previous baseline versions.\n\nWhich industry-standard tool is best suited for this?',
        'foundational',
        'Robinhood',
        'Measuring perceived usability post-test',
        'B',
        'Option B is correct because the System Usability Scale (SUS) is the industry standard, 10-item questionnaire specifically designed to measure perceived usability reliably. It yields a single score (0-100) perfect for benchmarking. Option A is wrong because CSAT measures general satisfaction with a service, not specific interface usability. Option C is wrong because first-click testing is a behavioral navigation method, not a post-test questionnaire. Option D is wrong because card sorting is an generative exercise for information architecture.',
        ARRAY['system_usability_scale', 'standardized_questionnaires', 'benchmarking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Customer Satisfaction (CSAT) Survey', false),
    (v_q_id, 'B', 'System Usability Scale (SUS)', true),
    (v_q_id, 'C', 'First Click Testing', false),
    (v_q_id, 'D', 'Card Sorting', false);

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
        'Figma''s Task Scenario Design',
        E'Figma''s PM is writing a task for a usability test of a new "Auto Layout" feature.\n\nWhich task prompt is the most effective for observing natural user behavior?',
        'foundational',
        'Figma',
        'Writing usability test scenarios',
        'B',
        'Option B is correct because it provides a realistic goal and context without explicitly naming the UI elements the user needs to find. This forces the user to navigate naturally. Option A is wrong because it uses the exact UI terminology ("Auto Layout") and tells them where to look ("right sidebar"), removing the challenge of discovery. Option C is wrong because it gives step-by-step instructions, making it a test of following directions rather than usability. Option D is a direct question, not a behavioral task.',
        ARRAY['task_design', 'scenario_writing', 'bias_prevention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Use the Auto Layout feature on the right sidebar to align these buttons."', false),
    (v_q_id, 'B', '"Imagine you are designing a navigation bar. Make these three buttons align evenly so that if you add a fourth, they adjust automatically."', true),
    (v_q_id, 'C', '"Please click on the right sidebar, find Auto Layout, and click the plus icon."', false),
    (v_q_id, 'D', '"Do you think the Auto Layout feature is easy to find?"', false);

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
        'Amazon''s First Click Testing',
        E'Amazon''s PM is running a first-click test on a new product detail page to see if users understand where to click to select a size. They launch a beta and run this query:\n\n```sql\nSELECT first_click_target, COUNT(*) as clicks\nFROM beta_sessions\nWHERE task_started = true\nGROUP BY 1 ORDER BY 2 DESC;\n```\n\nWhy is evaluating the *first click* so critical for predicting overall task success?',
        'intermediate',
        'Amazon',
        'Analyzing navigation patterns',
        'B',
        'Option B is correct. Extensive usability research (like that from measuringu) shows that if a user''s first click is down the correct path, they have an 87% chance of completing the task, compared to only a 46% chance if their first click is wrong. Option A is wrong because first-click tests explicitly measure navigation accuracy and mental models, not just time. Option C is wrong because first-click tests are often run on static images before any code is written. Option D is wrong because a SUS survey is attitudinal and happens post-test, whereas first-click is behavioral.',
        ARRAY['first_click_testing', 'navigation', 'metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'First-click tests are only useful for measuring time on task, not navigation accuracy.', false),
    (v_q_id, 'B', 'Research shows that if a user''s first click is correct, they are over twice as likely to complete the task successfully.', true),
    (v_q_id, 'C', 'First-click tests require a fully functioning coded prototype to be valid.', false),
    (v_q_id, 'D', 'It replaces the need for a SUS survey to determine why users drop off.', false);

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
        'Shopify''s Heuristic Evaluation',
        E'A PM at Shopify wants to evaluate a new merchant onboarding flow quickly before recruiting external users for a formal usability test. They ask three internal designers to systematically review the flow against Nielsen''s 10 usability principles to identify obvious flaws.\n\nWhat is this research method called?',
        'intermediate',
        'Shopify',
        'Expert review methodologies',
        'B',
        'Option B is correct. A Heuristic Evaluation involves UX experts or evaluators reviewing an interface against a set of accepted usability principles (heuristics) to identify common issues quickly. Option A (Cognitive Walkthrough) is wrong because it involves stepping through specific tasks from the user''s perspective, rather than evaluating against a broad set of principles. Option C is wrong because no external users are involved. Option D is wrong because contextual inquiry involves observing real users in their actual environment.',
        ARRAY['heuristic_evaluation', 'expert_review', 'nielsen_heuristics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Cognitive Walkthrough', false),
    (v_q_id, 'B', 'Heuristic Evaluation', true),
    (v_q_id, 'C', 'Unmoderated Usability Test', false),
    (v_q_id, 'D', 'Contextual Inquiry', false);

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
        'Notion''s Observer Effect',
        E'Notion is conducting in-person usability testing for a new block type. The PM notices that participants are excessively praising the feature and persisting through obvious bugs, which contradicts the high drop-off rates and frustration seen in natural product usage analytics.\n\nWhat is the most likely cause of this discrepancy?',
        'intermediate',
        'Notion',
        'Discrepancy between lab and analytics data',
        'A',
        'Option A is correct. The Hawthorne effect (or observer effect) occurs when participants alter their behavior simply because they know they are being watched. In usability testing, this often manifests as users trying harder to succeed and being overly polite to the researcher. Option B is unlikely to account for the stark contrast with actual analytics. Option C is wrong because even if tasks were vague, the persistence through bugs is an artifact of the lab setting. Option D is wrong because behavioral analytics generally reflect truer intent than lab-based observations.',
        ARRAY['observer_effect', 'hawthorne_effect', 'bias', 'behavioral_analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The participants are experiencing the Hawthorne effect, altering their behavior because they are being observed.', true),
    (v_q_id, 'B', 'The participants represent a highly engaged power-user cohort that naturally tolerates bugs.', false),
    (v_q_id, 'C', 'The usability test tasks were written too vaguely, leading to false positives in completion rates.', false),
    (v_q_id, 'D', 'Natural usage analytics are consistently flawed compared to qualitative in-person testing.', false);

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
        'Discord''s Formative Sample Size',
        E'Discord''s PM is planning a formative qualitative usability test to uncover major friction points in a new voice channel setup process.\n\nAccording to standard UX research principles (e.g., Nielsen Norman Group), how many users should they recruit to uncover approximately 85% of the most common usability problems?',
        'intermediate',
        'Discord',
        'Determining sample size for qualitative testing',
        'B',
        'Option B is correct. Jakob Nielsen''s well-established research shows that testing with just 5 users will uncover roughly 85% of core usability problems in a qualitative, formative test. Testing more users in a single round yields diminishing returns. Option A (1-2 users) is too few and risks indexing on outliers. Option C (30-50) and Option D (100+) are appropriate for quantitative, summative testing where statistical significance is needed, but they are a massive waste of resources for early formative testing.',
        ARRAY['sample_size', 'formative_testing', 'nielsen_norman']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '1-2 users', false),
    (v_q_id, 'B', '5-8 users', true),
    (v_q_id, 'C', '30-50 users', false),
    (v_q_id, 'D', '100+ users', false);

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
        'Zoom''s Accessibility Testing',
        E'Zoom is testing a new screen-sharing layout. To ensure it is truly usable for individuals with visual impairments who rely on screen readers (like VoiceOver or JAWS), what is the most robust approach the PM should take?',
        'intermediate',
        'Zoom',
        'Testing for accessibility and inclusive design',
        'C',
        'Option C is correct because the only way to genuinely test accessibility usability is to observe participants who natively use assistive technologies in their daily lives. They navigate interfaces fundamentally differently than sighted users. Option A is wrong because unmoderated tests may completely fail if the prototype isn''t coded perfectly for screen readers. Option B is wrong because automated tools only catch about 30% of accessibility issues and cannot evaluate actual human usability. Option D is a terrible practice ("disability simulation") that yields inaccurate data and is widely frowned upon by accessibility experts.',
        ARRAY['accessibility', 'inclusive_design', 'assistive_technology']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run a standard unmoderated test and add a survey question asking if they are visually impaired.', false),
    (v_q_id, 'B', 'Run the prototype through an automated WCAG accessibility checker tool and consider it validated.', false),
    (v_q_id, 'C', 'Conduct moderated testing specifically recruiting participants who natively use assistive technologies daily.', true),
    (v_q_id, 'D', 'Test the layout by blindfolding standard participants and asking them to navigate via keyboard.', false);

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
        'LinkedIn''s Contextual Inquiry',
        E'LinkedIn''s PM wants to understand how sales professionals actually use the Sales Navigator tool during their chaotic daily workflow, rather than in a quiet, controlled lab setting. The PM decides to visit their offices and shadow them while they work, asking questions about their environment and interruptions.\n\nWhat is this research method?',
        'intermediate',
        'LinkedIn',
        'Observational research methods',
        'B',
        'Option B is correct. Contextual Inquiry is an ethnographic research method where researchers observe and interview users in their actual environment (their context) to understand real-world workflows, interruptions, and workarounds. Option A is wrong because A/B testing is a quantitative split test. Option C is wrong because summative usability testing is usually a highly controlled, lab-style evaluation of metrics. Option D is wrong because card sorting is used for information architecture taxonomy.',
        ARRAY['contextual_inquiry', 'observational_research', 'ethnography']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A/B Testing', false),
    (v_q_id, 'B', 'Contextual Inquiry', true),
    (v_q_id, 'C', 'Summative Usability Testing', false),
    (v_q_id, 'D', 'Closed Card Sorting', false);

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
        'Booking.com''s Formative vs Summative',
        E'Booking.com is launching a major redesign of its search results. During the early wireframe stage, the PM conducts testing purely to find and fix usability flaws. Just before launch, the PM conducts a highly structured test to measure time-on-task and compare it against the old design''s benchmark.\n\nWhat types of tests are these?',
        'intermediate',
        'Booking.com',
        'Differentiating test objectives',
        'C',
        'Option C is correct. Formative testing is conducted early in the design process to "form" or improve the design by finding flaws (qualitative). Summative testing is conducted at the end to "sum up" or evaluate the final product against benchmarks using metrics (quantitative). Option A and B are wrong because the goals of the two phases are distinct. Option D incorrectly reverses the definitions.',
        ARRAY['formative_testing', 'summative_testing', 'benchmarking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Both are formative tests.', false),
    (v_q_id, 'B', 'Both are summative tests.', false),
    (v_q_id, 'C', 'The first is formative, the second is summative.', true),
    (v_q_id, 'D', 'The first is summative, the second is formative.', false);

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
        'TikTok''s Moderation Probe',
        E'During a moderated test of TikTok''s new video editing tool, a user taps the "Effects" icon, frowns, taps back, and says out loud, "That''s weird." The PM wants to understand the friction without leading the user.\n\nWhat is the best response?',
        'intermediate',
        'TikTok',
        'Probing techniques during moderation',
        'C',
        'Option C is correct. Asking "What were you expecting to see?" is a classic, neutral probing technique. It uncovers the user''s mental model without planting ideas in their head. Option A is wrong because it is a leading question that puts a specific answer ("color filters") into the user''s mouth. Option B is wrong because defending the prototype stops the user from explaining their confusion. Option D is wrong because it dismisses a clear moment of friction, which is exactly what the test is designed to uncover.',
        ARRAY['probing_techniques', 'moderation_skills', 'mental_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Did you expect the color filters to be in that menu instead?"', false),
    (v_q_id, 'B', '"Yes, that button is currently broken in this prototype build."', false),
    (v_q_id, 'C', '"What were you expecting to see when you tapped that?"', true),
    (v_q_id, 'D', '"Let''s just move on to the next task if you are stuck."', false);

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
        'Peloton''s Biometric Testing Pitfall',
        E'Peloton''s PM wants to know exactly which metrics (cadence, resistance, output) users focus on during an intense cycling workout interface. They use eye-tracking software to generate a heat map.\n\nWhat is a major limitation of relying solely on eye-tracking data?',
        'intermediate',
        'Peloton',
        'Understanding the limits of eye tracking',
        'B',
        'Option B is correct. Eye tracking provides highly accurate quantitative data on fixations (where someone looked) and saccades (movement between points), but it provides zero qualitative context. A user might stare at a metric because it''s useful, or because they are deeply confused by it. Option A is wrong; modern eye tracking accurately captures saccades. Option C is wrong; you can get valuable directional data with 15-30 users. Option D is factually incorrect regarding the technology.',
        ARRAY['eye_tracking', 'biometric_testing', 'qualitative_vs_quantitative']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It cannot measure saccades accurately during physical movement.', false),
    (v_q_id, 'B', 'It tells you where a user looked, but not why they looked there or if they comprehended the information.', true),
    (v_q_id, 'C', 'It requires a sample size of at least 500 to be statistically significant.', false),
    (v_q_id, 'D', 'It can only track horizontal eye movements, not vertical ones.', false);

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
        'Cash App''s Remote Testing Logistics',
        E'A Cash App PM is setting up an unmoderated remote usability test using UserTesting. They want users to test a mobile prototype built in Figma.\n\nWhat is the most critical logistical step before launching the test to the 20 recruited participants?',
        'intermediate',
        'Cash App',
        'Setting up unmoderated remote prototypes',
        'A',
        'Option A is correct. In unmoderated testing, if the Figma link requires a login, has wrong permissions, or displays a desktop frame on a mobile device, the entire test will fail because there is no moderator present to troubleshoot. Option B is wrong because unmoderated tests are taken asynchronously, not scheduled via calendar. Option C is wrong because they are testing a Figma prototype, not a live coded TestFlight build. Option D is wrong because a 50-question survey will cause severe survey fatigue and poor data quality.',
        ARRAY['remote_testing', 'prototype_logistics', 'unmoderated_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ensure the Figma prototype link permissions are set to "Anyone with the link can view" and scaled correctly for mobile device screens.', true),
    (v_q_id, 'B', 'Schedule Zoom calendar invites with all 20 participants.', false),
    (v_q_id, 'C', 'Ensure the participants have downloaded the live Cash App beta build from TestFlight.', false),
    (v_q_id, 'D', 'Prepare a complex 50-question quantitative survey to administer after the test.', false);

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
        'Etsy''s SUS Score Interpretation',
        E'Etsy runs a usability test on a new seller dashboard. The PM collects System Usability Scale (SUS) scores from 5 users.\n\n| User | SUS Score |\n|---|---|\n| 1 | 45 |\n| 2 | 55 |\n| 3 | 50 |\n| 4 | 60 |\n| 5 | 50 |\n\nThe average score is 52. How should the PM interpret this quantitative result?',
        'intermediate',
        'Etsy',
        'Interpreting standard usability metrics',
        'C',
        'Option C is correct. The System Usability Scale (SUS) is not a percentage. Based on decades of research across thousands of systems, the average SUS score is 68. A score of 52 is well below average (putting it in the bottom quartile), indicating significant usability issues that need addressing. Option A and B are wrong because they misinterpret the 0-100 scale. Option D is wrong because SUS measures perceived usability, not behavioral task completion rates.',
        ARRAY['system_usability_scale', 'score_interpretation', 'benchmarking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is an excellent score, well above the industry average.', false),
    (v_q_id, 'B', 'It is perfectly average, meaning the usability is acceptable but has room for minor improvements.', false),
    (v_q_id, 'C', 'It is a poor score, well below the industry average of 68, indicating severe usability issues.', true),
    (v_q_id, 'D', 'It means 52% of users successfully completed their tasks without moderator assistance.', false);

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
        'GitHub''s Cognitive Walkthrough',
        E'A GitHub PM is evaluating a new pull request review flow without recruiting external users. The PM and a lead designer step through the flow themselves as if they were a user, asking at each step: "Will the user know what to do here?" and "Will the user see that the correct action is available?"\n\nWhat method is this?',
        'intermediate',
        'GitHub',
        'Expert evaluation methods',
        'B',
        'Option B is correct. A Cognitive Walkthrough is an expert review method where evaluators step through a specific task from a user''s perspective, specifically asking questions about whether the user''s goals align with the system''s visible actions. Option A is wrong because there are no external participants. Option C is wrong because tree testing evaluates taxonomy, not UI flows. Option D is wrong because first-click tests measure where real users click.',
        ARRAY['cognitive_walkthrough', 'expert_review', 'inspection_methods']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Moderated Usability Testing', false),
    (v_q_id, 'B', 'Cognitive Walkthrough', true),
    (v_q_id, 'C', 'Tree Testing', false),
    (v_q_id, 'D', 'First-Click Testing', false);

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
        'Vercel''s System Status',
        E'During a usability test, a Vercel user clicks "Deploy" but the screen remains completely static for 15 seconds before finally showing a success message. The user repeatedly clicks the button in frustration, thinking it is broken.\n\nWhich of Nielsen''s usability heuristics is primarily being violated?',
        'intermediate',
        'Vercel',
        'Identifying heuristic violations',
        'B',
        'Option B is correct. "Visibility of system status" is Nielsen''s first heuristic, which states that systems should always keep users informed about what is going on, through appropriate feedback within a reasonable amount of time (e.g., a loading spinner). Option A refers to using language and concepts familiar to the user. Option C is about preventing mistakes before they occur. Option D refers to not cluttering the UI with irrelevant information.',
        ARRAY['heuristic_evaluation', 'visibility_of_system_status', 'nielsen_heuristics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Match between system and the real world', false),
    (v_q_id, 'B', 'Visibility of system status', true),
    (v_q_id, 'C', 'Error prevention', false),
    (v_q_id, 'D', 'Aesthetic and minimalist design', false);

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
        'Reddit''s Card Sorting',
        E'Reddit''s PM is redesigning the settings menu because users constantly complain they can''t find notification preferences. The PM gives users a list of 40 settings options and asks them to group them into categories that make sense to them, and then name those categories themselves.\n\nWhat is this technique?',
        'intermediate',
        'Reddit',
        'Information architecture research',
        'B',
        'Option B is correct. Open Card Sorting is an exploratory generative exercise where users categorize items and create their own labels for those groups. This reveals user mental models. Option C (Closed Card Sorting) is wrong because in closed sorting, the categories are pre-defined by the researcher, and users just sort items into those existing buckets. Option A (Tree Testing) validates an existing hierarchy. Option D is an expert review method.',
        ARRAY['card_sorting', 'information_architecture', 'mental_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tree Testing', false),
    (v_q_id, 'B', 'Open Card Sorting', true),
    (v_q_id, 'C', 'Closed Card Sorting', false),
    (v_q_id, 'D', 'Heuristic Evaluation', false);

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
        'Salesforce''s Retrospective Think-Aloud',
        E'Salesforce is testing a complex enterprise data reporting tool. The PM worries that asking users to talk out loud concurrently will add too much cognitive load and artificially alter their performance on the difficult analytical tasks.\n\nWhat is the best alternative to gather qualitative thoughts?',
        'intermediate',
        'Salesforce',
        'Managing cognitive load during testing',
        'A',
        'Option A is correct. Retrospective Think-Aloud (RTA) involves having the user complete the complex task in silence to capture accurate time and behavioral metrics, and then replaying a recording of the task immediately afterward and asking them to narrate their thought process. Option B is a quantitative survey, not qualitative thoughts. Option C is a behavioral split test. Option D doesn''t solve the cognitive load issue; it just removes the moderator.',
        ARRAY['retrospective_think_aloud', 'cognitive_load', 'moderation_techniques']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Retrospective Think-Aloud (RTA)', true),
    (v_q_id, 'B', 'System Usability Scale (SUS)', false),
    (v_q_id, 'C', 'A/B Testing', false),
    (v_q_id, 'D', 'Unmoderated Remote Testing', false);

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
        'Tinder''s Usability vs A/B Testing',
        E'Tinder introduces a new "Super Like" animation. The design team ran a usability test with 5 users who all loved the animation and found it easy to use. However, a subsequent A/B test to 100,000 users shows a 10% drop in overall matches.\n\nWhat should the PM conclude?',
        'intermediate',
        'Tinder',
        'Reconciling qualitative and quantitative data',
        'B',
        'Option B is correct. Usability testing evaluates whether people *can* understand and operate a feature (usability). A/B testing evaluates whether the feature drives a macro business behavior at scale (utility/impact). The animation may be usable and pretty, but it might take too long, reducing overall swiping volume. Option A is wrong because qualitative data is still valuable for finding friction. Option C is wrong because 5 users is perfectly valid for qualitative usability. Option D is fundamentally incorrect.',
        ARRAY['usability_vs_ab_testing', 'methodology_selection', 'mixed_methods']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The usability test was poorly conducted and qualitative feedback should be ignored entirely in the future.', false),
    (v_q_id, 'B', 'Usability testing measures if users can use a feature, while A/B testing measures if it drives business outcomes at scale. Both are valid.', true),
    (v_q_id, 'C', 'The sample size for the usability test was too small to be valid for usability purposes either.', false),
    (v_q_id, 'D', 'A/B tests are highly susceptible to qualitative bias and should be paused.', false);

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
        'Twitter''s Pilot Test',
        E'Twitter/X''s PM is preparing a complex 60-minute moderated usability test for a new Creator Analytics suite.\n\nWhat is the most important step to take *before* testing the first real, recruited participant?',
        'intermediate',
        'Twitter',
        'Test preparation best practices',
        'A',
        'Option A is correct. A pilot test (or dry run) is essential for complex tests to ensure the tasks make sense, the prototype doesn''t break, the timing fits within the allotted slot, and recording software works. Without it, you risk wasting expensive recruited participants on a broken setup. Option B is premature. Option C is unrelated to qualitative testing. Option D is wrong because standard questionnaires like SUS must be given immediately *after* the experience, not before.',
        ARRAY['pilot_testing', 'preparation', 'test_logistics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run a pilot test (dry run) with a colleague to check timing, technical setup, and task clarity.', true),
    (v_q_id, 'B', 'Finalize the executive summary presentation template for stakeholders.', false),
    (v_q_id, 'C', 'Ensure the A/B testing framework is configured in production.', false),
    (v_q_id, 'D', 'Send out the SUS survey to the participants in advance so they know what to expect.', false);

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
        'Pinterest''s Attitudinal vs Behavioral Data',
        E'During a usability test of a new Pinterest board organization tool, a PM observes a participant and logs the following:\n\n| Source | Data Point |\n|---|---|\n| Observation | Struggled for 5 mins, clicked wrong buttons 4 times |\n| Post-Task Survey | Rated task 5/5 "Super easy and intuitive!" |\n\nHow should the PM handle this contradiction?',
        'intermediate',
        'Pinterest',
        'Handling conflicting qualitative data',
        'B',
        'Option B is correct. This is a classic conflict between behavioral data (what they did) and attitudinal data (what they said). Users often self-report high scores due to politeness, self-blame, or poor memory. UX professionals always prioritize observed behavior over self-reported surveys when diagnosing usability. Option A ignores the massive friction observed. Option C is antagonistic and ruins rapport. Option D throws away valuable behavioral data simply because the user was polite.',
        ARRAY['behavioral_vs_attitudinal', 'self_reporting_bias', 'data_triangulation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Record the task as highly successful because user satisfaction is the ultimate metric.', false),
    (v_q_id, 'B', 'Rely on the behavioral observation to identify usability issues, as self-reported attitudinal data is often biased by politeness.', true),
    (v_q_id, 'C', 'Confront the user about their mistakes to correct their survey response.', false),
    (v_q_id, 'D', 'Discard the user''s data entirely as they are clearly an outlier.', false);

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
        'Instagram''s Task-Level vs Test-Level Metrics',
        E'Instagram''s PM is summarizing a usability test report and needs to categorize the metrics collected:\n\n| Metric | Measured When |\n|---|---|\n| Single Ease Question (SEQ) | After every task |\n| Time on Task | During every task |\n| System Usability Scale (SUS) | End of the entire session |\n| NPS | End of the entire session |\n\nWhich of the following correctly categorizes these as task-level vs test-level metrics?',
        'advanced',
        'Instagram',
        'Structuring quantitative usability reports',
        'C',
        'Option C is correct. Task-level metrics evaluate specific, individual interactions within the test (Time on Task measures efficiency of one task; SEQ is a 1-question survey asked immediately after one task). Test-level metrics evaluate the entire system or product holistically at the very end of the session (SUS measures overall perceived usability; NPS measures overall brand sentiment). Options A, B, and D mix up these established industry definitions.',
        ARRAY['metrics', 'seq', 'sus', 'quantitative_usability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Task-level: System Usability Scale (SUS); Test-level: Time on Task.', false),
    (v_q_id, 'B', 'Task-level: Task Success Rate; Test-level: Single Ease Question (SEQ).', false),
    (v_q_id, 'C', 'Task-level: Time on Task, Single Ease Question (SEQ); Test-level: System Usability Scale (SUS), NPS.', true),
    (v_q_id, 'D', 'Task-level: Net Promoter Score (NPS); Test-level: Task Success Rate, SUS.', false);

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
        'Uber''s Confidence Intervals',
        E'Uber conducts a summative benchmark usability test on a new driver onboarding flow with 20 users. The task success rate is exactly 80% (16/20).\n\nTo report this quantitative finding accurately and scientifically to executive stakeholders, the PM should:',
        'advanced',
        'Uber',
        'Reporting quantitative statistics',
        'B',
        'Option B is correct. When dealing with small sample sizes in quantitative usability testing, a point estimate (80%) is insufficient. A confidence interval (like Adjusted-Wald for binomial data) must be calculated to show the margin of error (e.g., "We are 95% confident the true success rate is between 62% and 94%"). Option A is statistically false; small samples cannot guarantee exact population parameters. Option C is wrong because summative testing with 20-30 users is an industry standard for benchmarking, provided confidence intervals are used. Option D is unnecessary and expensive.',
        ARRAY['confidence_intervals', 'quantitative_usability', 'statistics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'State definitively that 80% of all future drivers will succeed in this flow.', false),
    (v_q_id, 'B', 'Calculate and report a confidence interval to show the margin of error around the 80% success rate based on the sample size.', true),
    (v_q_id, 'C', 'Discard the quantitative data entirely because 20 users is only suitable for formative qualitative testing.', false),
    (v_q_id, 'D', 'Run an A/B test immediately to mathematically confirm the 80% rate before reporting.', false);

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
        'Shopify''s Within-Subjects Design',
        E'Shopify is comparing its checkout flow against a major competitor''s checkout flow using a within-subjects usability test design (meaning the same participants test both flows).\n\nWhat is the critical methodological control the PM must implement to ensure valid results?',
        'advanced',
        'Shopify',
        'Experimental design and bias control',
        'B',
        'Option B is correct. In a within-subjects design, testing the same interface second always confers a learning advantage (or fatigue disadvantage). To control for this "order effect," researchers must counterbalance: half the participants see Shopify first, and half see the Competitor first. Option A introduces massive order bias, guaranteeing the second system tested will look easier because users learned on the first. Option C ruins the ability to compare apples-to-apples. Option D is an unnecessary recruitment constraint.',
        ARRAY['benchmark_testing', 'within_subjects_design', 'counterbalancing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ensure all participants test Shopify first, then the competitor, so they have a baseline.', false),
    (v_q_id, 'B', 'Counterbalance the order of presentation (half test Shopify first, half test the competitor first) to mitigate order bias and learning effects.', true),
    (v_q_id, 'C', 'Use completely different, unrelated tasks for the Shopify test and the competitor test to prevent overlap.', false),
    (v_q_id, 'D', 'Ensure the participants have never shopped online before to avoid prior brand bias.', false);

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
        'Slack''s Usability Severity Rating',
        E'After a usability test, a Slack PM logs usability issues and prioritizes them based on severity.\n\n| Issue | Frequency | Impact |\n|---|---|---|\n| A - Cannot find "Create Channel" | 1/10 users | Total Task Failure |\n| B - Confused by color of "Send" | 8/10 users | 2-second delay |\n| C - Typo in tooltip | 10/10 users | No delay |\n\nUsing standard severity frameworks (like Nielsen''s), how should the PM prioritize Issue A versus Issue B?',
        'advanced',
        'Slack',
        'Prioritizing usability issues',
        'B',
        'Option B is correct. Severity is a function of Frequency, Impact, and Persistence. While Issue A is low frequency, its impact is catastrophic (task failure). High-impact blockers must be prioritized over minor annoyances (Issue B), even if the annoyance is highly frequent. Option A is wrong because frequency does not inherently overrule impact. Option C is wrong because A/B testing is not required to fix obvious usability flaws. Option D is wrong because a typo has zero impact on task completion, despite 100% frequency.',
        ARRAY['severity_rating', 'issue_prioritization', 'nielsen_heuristics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Issue B is inherently more severe because frequency is always heavily weighted over impact.', false),
    (v_q_id, 'B', 'Issue A is a critical blocker (high impact) despite low frequency and should be prioritized over a minor annoyance like Issue B.', true),
    (v_q_id, 'C', 'Both issues should be ignored until a statistically significant A/B test confirms them.', false),
    (v_q_id, 'D', 'The PM should prioritize Issue C because it affects 100% of the tested users.', false);

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
        'Atlassian''s Tree Testing vs Card Sorting',
        E'Atlassian''s Jira navigation has become too complex. The PM previously ran an open card sort to generate a proposed new taxonomy. Now, the PM wants to empirically validate if users can actually *find* specific settings using this *new* proposed hierarchy, stripped of any visual design influence.\n\nWhich method is best?',
        'advanced',
        'Atlassian',
        'Validating information architecture',
        'B',
        'Option B is correct. Tree Testing (often called "reverse card sorting") is specifically designed to evaluate the findability of topics in a proposed hierarchy. Users navigate a text-only tree structure to find a target. Option A (Closed Card Sort) only verifies categorization, not top-down navigation logic. Option C (First-Click Test) requires a visual UI, violating the prompt''s constraint to strip visual design. Option D is an expensive way to test a taxonomy that isn''t built yet.',
        ARRAY['tree_testing', 'information_architecture', 'findability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Closed Card Sort', false),
    (v_q_id, 'B', 'A Tree Test', true),
    (v_q_id, 'C', 'A First-Click Test', false),
    (v_q_id, 'D', 'An A/B Test', false);

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
        'Canva''s Demand Characteristics Bias',
        E'Canva''s PM is moderating a session and says: "We redesigned this export menu specifically to make it faster. Can you try exporting as a PDF and let me know if it feels faster than the old way?"\n\nWhat is the primary methodological flaw in this prompt?',
        'advanced',
        'Canva',
        'Identifying researcher bias',
        'A',
        'Option A is correct. By stating the goal ("make it faster"), the PM introduces a "demand characteristic." The participant will subconsciously alter their behavior to confirm the researcher''s hypothesis, resulting in invalid, overly positive feedback. A neutral prompt would just ask them to export the file. Option B is irrelevant to the methodological flaw. Option C is wrong because moderated sessions can absolutely gather qualitative feedback on perceived speed. Option D is terrible practice for user research.',
        ARRAY['moderation_bias', 'demand_characteristics', 'leading_questions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM revealed the design intent, creating a demand characteristic bias where the user tries to validate the researcher''s hypothesis.', true),
    (v_q_id, 'B', 'The PM should have asked them to export as a PNG instead of a PDF to truly test rendering speed.', false),
    (v_q_id, 'C', 'Moderated sessions shouldn''t be used to discuss speed; only unmoderated screen recordings can track perceived speed.', false),
    (v_q_id, 'D', 'There is no flaw; giving users the exact context helps them focus on the right aspects of the prototype.', false);

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
        'Stripe''s Statistical Significance in Usability',
        E'Stripe''s PM compares Time on Task for an API key generation flow using an unmoderated between-subjects test.\n\n| Metric | Legacy Flow | New Flow |\n|---|---|---|\n| Sample Size | 30 | 30 |\n| Mean Time | 45s | 38s |\n| p-value | - | 0.08 |\n\n(Alpha set to 0.05). How should the PM interpret this quantitative usability result?',
        'advanced',
        'Stripe',
        'Interpreting statistical significance in UX',
        'B',
        'Option B is correct. A p-value of 0.08 is greater than the standard alpha of 0.05. This means the result is not statistically significant; there is an 8% chance that the observed 7-second difference is purely due to random variation in the sample, not an actual improvement in the underlying design. Option A ignores the lack of statistical significance. Option C is a severe misunderstanding of what a p-value represents (it measures the probability of the observed data given the null hypothesis, not a failure rate). Option D is wrong because a t-test is standard for continuous data like time.',
        ARRAY['statistical_significance', 'quantitative_usability', 't_test', 'p_value']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The new flow is definitively faster by 7 seconds; launch it immediately.', false),
    (v_q_id, 'B', 'The difference is not statistically significant at the 5% level; the observed difference in time could easily be due to random chance.', true),
    (v_q_id, 'C', 'The p-value of 0.08 proves that 8% of users will fail the task in the new flow.', false),
    (v_q_id, 'D', 'A t-test is inappropriate for time-on-task data; a chi-square test must always be used for continuous metrics.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for usability-testing';

END $$;
