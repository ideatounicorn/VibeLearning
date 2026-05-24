-- ============================================
-- ASSESSMENT: OKRs
-- CATEGORY: Product Strategy
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
    WHERE slug = 'okrs';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug okrs not found. Run the seed data first.';
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
        'Notion''s Objective Refinement',
        'A PM at Notion is drafting their team''s quarterly Objective for a new collaboration hub. They write: ''Increase monthly active editors by 15% and launch three new collaboration templates.'' A senior product director reviews the draft and suggests separating it because it violates core OKR principles. Why is this objective poorly structured?',
        'foundational',
        'Notion',
        'Notion collaboration features and editor engagement',
        'B',
        'Objectives should be qualitative, memorable, and aspirational, whereas metrics and deliverables belong in Key Results. By putting ''15% growth'' (a key result) and ''launch three templates'' (a project output) directly into the Objective, the PM makes the goal feel like a tactical to-do list rather than a strategic rally cry. Moving metrics to KRs leaves the Objective qualitative, e.g., ''Make Notion the default canvas for real-time team collaboration.'' Option A is wrong because mixing metrics and objectives is a known anti-pattern. Option C is wrong because increasing the target doesn''t solve the structural issue. Option D is wrong because it still keeps a metric in the Objective.',
        ARRAY['okrs', 'objective_writing', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is well-structured because it combines a clear target with specific deliverables to give the team direction', false),
    (v_q_id, 'B', 'It mixes a qualitative objective with quantitative metrics and deliverables; the objective should be qualitative and aspirational, with numbers moved to the Key Results', true),
    (v_q_id, 'C', 'It is not ambitious enough; a 15% increase for a new feature is too low to be considered a true Objective', false),
    (v_q_id, 'D', 'It contains too many deliverables; removing the template launch while keeping the 15% active editor target would make it a valid Objective', false);

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
        'Duolingo''s Streak Freeze Key Result',
        'A Duolingo Growth PM writes the following Key Result for the Gamified Streak Freeze initiative: ''Ship the new Gamified Streak Freeze feature by October 15th.'' What is the primary anti-pattern represented in this Key Result?',
        'foundational',
        'Duolingo',
        'User retention and streak gamification',
        'A',
        'This KR represents a classic task-list or output-based Key Result. Shipping a feature is an output, not an outcome; it doesn''t measure if the feature actually solved the underlying user problem or moved business metrics. A high-quality KR should focus on the outcome, such as ''Reduce the 7-day churn rate of users who lose their streak from 18% to 12%.'' Option B is wrong because deadlines themselves are fine, but a deadline on a pure output makes it a project plan, not a KR. Option C is wrong because difficulty is not the primary issue. Option D is wrong because it focuses on a specific feature choice rather than the output vs. outcome distinction.',
        ARRAY['okrs', 'key_results', 'task_krs', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is a task-list/output KR rather than an outcome-oriented KR, meaning it measures shipping a feature rather than the value the feature delivers', true),
    (v_q_id, 'B', 'It includes a specific calendar date, which is not permitted in Key Results under standard OKR frameworks', false),
    (v_q_id, 'C', 'It is too easy to achieve and doesn''t represent a stretch target for a high-performing Growth team', false),
    (v_q_id, 'D', 'It focuses on a retention feature rather than directly measuring top-line Daily Active Users (DAU)', false);

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
        'Spotify''s Committed vs. Aspirational Grading',
        'A Spotify PM is defining goals for the quarter. They establish a committed OKR for infrastructure reliability (achieve 99.99% playback uptime) and an aspirational OKR for a new social listening feature (reach 10 million weekly active listeners). At the end of the quarter, the reliability stands at 99.90% (75% of the gap closed), and the social listening feature reaches 7.5 million listeners (75% of target). How should these results be graded?',
        'foundational',
        'Spotify',
        'Infrastructure stability and new feature adoption',
        'B',
        'Committed OKRs are operational agreements where 100% success is expected (score of 1.0). Hitting 99.90% instead of 99.99% represents a failure in delivery. Aspirational OKRs are stretch goals where a score of 0.7 (70% achievement) is considered standard success. Therefore, the social listening feature OKR (75% achieved) is a success, while the reliability OKR is a failure. Option A is wrong because it treats both types of goals identically. Option C is wrong because it reverses the definitions. Option D is wrong because grading committed goals on a curve defeats their purpose as predictable operational targets.',
        ARRAY['okrs', 'committed_vs_aspirational', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Both are considered successes because both achieved at least 75% of their respective targets, exceeding the standard 70% OKR success threshold', false),
    (v_q_id, 'B', 'The reliability OKR is a failure because committed OKRs require 100% achievement, while the social listening OKR is a success because hitting 75% of an aspirational target is excellent', true),
    (v_q_id, 'C', 'The social listening OKR is a failure because they missed the 10M target, while the reliability OKR is a success because 99.90% uptime is still highly functional', false),
    (v_q_id, 'D', 'Both should be graded on a curve and given a passing grade of 0.75, reflecting equal execution across both areas', false);

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
        'Uber''s Focus and OKR Overload',
        'A PM for Uber''s Rider Experience team drafts 8 separate Objectives for the upcoming quarter, each with 5 to 6 Key Results. The topics range from app loading times and driver rating prompts to redesigning the ride-selection drawer. The Director of Product asks the PM to consolidate this list down to 3 to 4 Objectives. What is the main strategic rationale for this constraint?',
        'foundational',
        'Uber',
        'Rider experience optimization and product prioritization',
        'B',
        'One of the most common OKR anti-patterns is having too many goals, which dilutes focus and resource allocation. If everything is a priority, nothing is. Limiting objectives to 3-5 forces the PM to make difficult trade-offs and focus only on the most high-impact work. Option A is a tool limitation, not a strategic reason. Option C is wrong because OKRs are team-level, not individual-level. Option D is wrong because cascading is unaffected by volume, although tracking becomes chaotic.',
        ARRAY['okrs', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Standard OKR tracking software has performance limitations and cannot support more than 20 rows of database records per team', false),
    (v_q_id, 'B', 'An excessive number of OKRs dilutes team focus, makes it impossible to make clear trade-offs, and turns OKRs into an exhaustive list of business-as-usual tasks', true),
    (v_q_id, 'C', 'Objectives must be restricted to two per team member to ensure that individual performance reviews remain balanced and fair', false),
    (v_q_id, 'D', 'Having more than 4 objectives prevents engineering managers from cascading individual sprint tasks during backlog grooming', false);

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
        'Slack''s APAC Expansion Cascading',
        'Slack''s executive team publishes a corporate OKR: ''Objective: Accelerate enterprise market penetration in the APAC region.'' The PM for Slack''s Enterprise Admin team is asked to align their team''s OKRs. Which approach demonstrates the best practice for cascading and aligning goals?',
        'foundational',
        'Slack',
        'Enterprise administration capabilities for global expansion',
        'B',
        'Perfect alignment does not mean copying corporate goals top-down (which destroys team autonomy and creativity). Instead, the team should identify how their unique domain (Enterprise Admin features) can help achieve the corporate goal. Simplifying multi-org administration is highly relevant to large APAC companies. Option A is a top-down anti-pattern. Option C ignores alignment completely. Option D is a dictatorial approach that removes the product manager''s strategic input.',
        ARRAY['okrs', 'cascading_goals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Copy the corporate Objective and Key Results verbatim into the team''s OKR document to ensure 100% compliance', false),
    (v_q_id, 'B', 'Identify how the Admin team''s domain can unlock APAC market growth (e.g., localizing administrative settings or simplifying multi-org setup for APAC conglomerates) and write localized KRs', true),
    (v_q_id, 'C', 'Ignore the corporate objective since the Admin team has a separate backlog of technical debt and local bug fixes that do not relate to international expansion', false),
    (v_q_id, 'D', 'Request that the VP of Product write the team''s specific Key Results and assign them directly to the engineering lead', false);

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
        'Airbnb''s Host Registration Sandbagging',
        'An Airbnb PM for the Host Onboarding team is writing OKRs. The team''s historical data shows that host registration completion rate naturally grows by 1.8% quarter-over-quarter due to baseline improvements. The PM proposes a Key Result: ''Increase host registration completion rate by 2.0% this quarter.'' What anti-pattern is this?',
        'foundational',
        'Airbnb',
        'Host onboarding funnel optimization',
        'C',
        'This is a classic case of ''sandbagging''—setting a target so low and close to the baseline growth that success is virtually guaranteed without significant effort or innovation. OKRs should represent stretch targets (especially aspirational ones) to drive innovative thinking and breakthroughs. Option A is incorrect because this is a metric, not a task list. Option B is incorrect because no dependency friction is described. Option D is wrong because registration completion rate is a mid-funnel leading metric, not a lagging financial metric.',
        ARRAY['okrs', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Task-list Key Result, because the metric is too simple to track', false),
    (v_q_id, 'B', 'Dependency conflict, because host onboarding requires help from marketing', false),
    (v_q_id, 'C', 'Sandbagging, because the target is set so close to the natural baseline growth that it requires very little innovation to achieve', true),
    (v_q_id, 'D', 'Over-indexing on lagging indicators, because registration completion is a financial outcome', false);

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
        'Zoom''s Confidence Score Drop',
        'During the week 6 mid-quarter review of Zoom''s Developer Platform team, the PM notices that a critical Key Result (''Increase active API integrations from 5,000 to 7,500'') is lagging at 5,200 due to delayed documentation releases. The PM drops the KR''s confidence score from 0.8 to 0.3. What is the primary purpose of this adjustment?',
        'foundational',
        'Zoom',
        'Developer platform API adoption and documentation',
        'C',
        'Confidence scores in OKRs act as early warning signals. Dropping the score to 0.3 triggers a constructive discussion about why the goal is at risk, enabling the team to reallocate resources, simplify scope, or resolve the blocker before the quarter ends. Option A is wrong because hiding problems defeats the purpose of OKRs. Option B is wrong because waiting until the end of the quarter prevents course correction. Option D is wrong because targets should not be silently lowered mid-quarter just to look good.',
        ARRAY['okrs', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To flag the engineering team for poor performance during their individual mid-quarter evaluations', false),
    (v_q_id, 'B', 'To justify resetting the baseline so that the end-of-quarter grading looks more favorable to executive leadership', false),
    (v_q_id, 'C', 'To serve as an early warning signal that triggers immediate discussion regarding blockers, resource reallocation, or scope adjustment', true),
    (v_q_id, 'D', 'To formally request that the Key Result be removed from the team''s OKR list for the remainder of the quarter', false);

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
        'DoorDash''s Merchant Portal OKRs',
        'A DoorDash Merchant Portal PM is writing quarterly OKRs. Which of the following is written as a high-quality, outcome-oriented Key Result?',
        'foundational',
        'DoorDash',
        'Merchant portal adoption and menu updates',
        'C',
        'A high-quality Key Result must be outcome-oriented, measurable, and time-bound. Option C measures user behavior changes (merchants updating menus weekly) which drives fresher data and better customer experience, representing an outcome. Options A, B, and D are outputs (writing docs, running tests, deploying code) which are tactical tasks and do not measure if value was created.',
        ARRAY['okrs', 'key_results', 'task_krs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write the complete technical design document for the bulk menu upload API by week 4', false),
    (v_q_id, 'B', 'Conduct 6 usability tests with quick-service restaurant operators to evaluate the new onboarding flow', false),
    (v_q_id, 'C', 'Increase the percentage of active merchants who update their menu pricing weekly from 12% to 25% by the end of Q3', true),
    (v_q_id, 'D', 'Deploy the automated menu translator microservice to the staging and production environments', false);

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
        'Netflix''s Failed Engagement Target',
        'A Netflix PM''s team set an ambitious aspirational KR: ''Increase average weekly viewing hours for newly onboarded members from 8 to 12 hours.'' At the end of the quarter, the metric reached 9 hours. The VP of Product conducts a retrospective. How should the team approach this result?',
        'foundational',
        'Netflix',
        'New member onboarding and engagement metrics',
        'B',
        'Aspirational OKRs are designed to stretch the team. Hitting 9 hours (a 25% increase) is valuable progress. Decoupling OKR grading from performance reviews creates psychological safety, encouraging teams to take big risks. The focus should be on learning why the hypotheses failed. Option A destroys psychological safety. Option C is sandbagging. Option D is overly cautious and avoids risk.',
        ARRAY['okrs', 'retrospective_learning', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Hold the PM accountable for the failure by marking their individual performance review as ''needs improvement''', false),
    (v_q_id, 'B', 'Grade the KR as a partial success (0.25), analyze which user experience hypotheses failed to drive the expected uplift, and ensure the score is decoupled from individual performance reviews', true),
    (v_q_id, 'C', 'Change the target to 9 hours retroactively so the team can report a 1.0 success to the executive board', false),
    (v_q_id, 'D', 'Commit only to low-risk, minor UX tweaks next quarter to ensure 100% target achievement', false);

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
        'GitHub''s Daily Backlog Alignment',
        'A GitHub PM is planning the sprint backlog with their engineering team. The team has a quarterly Key Result: ''Reduce the time-to-first-CI-feedback from 8 minutes to 3 minutes for enterprise repositories.'' Which practice best ensures that daily execution is aligned with this quarterly OKR?',
        'foundational',
        'GitHub',
        'CI/CD developer workflow efficiency',
        'A',
        'OKRs should not exist in isolation from daily work. Every sprint ticket related to the CI pipeline should explicitly map back to this Key Result, explaining how the task helps reduce latency. This keeps the team focused on outcomes. Option B treats OKRs as a side project. Option C is retrofitting OKRs to match whatever engineers wanted to build anyway. Option D is an anti-pattern that makes OKRs purely performative.',
        ARRAY['okrs', 'key_results']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ensure every sprint ticket related to the CI pipeline explicitly states which bottleneck it targets to help reduce feedback times toward the 3-minute goal', true),
    (v_q_id, 'B', 'Set aside every Friday for ''OKR work'' where engineers work on metrics, while dedicating Monday through Thursday to the regular roadmap backlog', false),
    (v_q_id, 'C', 'Define the sprint backlog first, and then write new Key Results at the end of the month that match whatever tasks were shipped', false),
    (v_q_id, 'D', 'Focus the sprint entirely on shipping features from the static annual roadmap, treating the OKR as a high-level reporting exercise for leadership', false);

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
        'YouTube''s Creator Monetization Cascading',
        'YouTube''s corporate objective is to ''Help creators build sustainable businesses on YouTube.'' The Creator Monetization product team needs to define their quarterly Objective to align with this goal. Which of the following represents the most effective team-level Objective?',
        'intermediate',
        'YouTube',
        'Creator monetization models and revenue streams',
        'C',
        'A team-level Objective should be qualitative, inspirational, and focused on the value the team can deliver to support the corporate objective. Option C is qualitative and focuses on the team''s domain (diversified revenue) to help creators build sustainable businesses. Option A is an output (launching a feature). Option B is a metric (belonging in KRs). Option D is purely technical execution (reducing database latency).',
        ARRAY['okrs', 'objective_writing', 'cascading_goals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch the Super Chat stickers and channel memberships interface by November 1st', false),
    (v_q_id, 'B', 'Increase the percentage of active creators earning more than $1,000/month from 8% to 12%', false),
    (v_q_id, 'C', 'Empower mid-tier creators to diversify their income streams beyond ad revenue', true),
    (v_q_id, 'D', 'Re-engineer the payment processing pipeline to handle 10,000 transactions per second', false);

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
        'Robinhood''s Cross-Team Dependency Blocker',
        'A Robinhood PM on the Crypto team has a key Q2 metric: ''Increase weekly crypto recurring buys from 40k to 70k.'' Hitting this target requires integration with a new banking API, which must be built by the Core Payments Team. During planning, the Core Payments Team explains that their quarterly OKR is focused entirely on migrating to a new database ledger, leaving no resources for the API integration. How should the Crypto PM handle this?',
        'intermediate',
        'Robinhood',
        'Cross-team API integration and resource alignment',
        'C',
        'Cross-team dependencies must be resolved during the joint OKR planning phase. If a team relies on another, the dependency must either be reflected in the supporting team''s OKRs (as a committed KR or shared goal) or the initiating team must adjust their own targets. Option C describes this collaborative alignment. Option A is dangerous and violates code ownership. Option B escalates prematurely. Option D is an ostrich strategy that results in failure.',
        ARRAY['okrs', 'dependency_conflicts', 'cascading_goals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write the banking API code within the Crypto team''s repository and merge it into the Core Payments repository without their review', false),
    (v_q_id, 'B', 'Escalate to the VP of Product to demand that the Core Payments Team drop their database ledger migration OKR immediately', false),
    (v_q_id, 'C', 'Conduct a joint planning session to align OKRs, resulting in either a shared OKR or a committed KR on the Payments team''s list supporting the API delivery, or adjust the Crypto team''s target accordingly', true),
    (v_q_id, 'D', 'Proceed with the recurring buys OKR as written, and blame the Payments team in the end-of-quarter review when the target is missed', false);

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
        'Stripe''s Billing Leading Indicators',
        'A Stripe PM for the Billing platform wants to write a Key Result to drive customer retention. The team''s ultimate goal is to increase Annual Recurring Revenue (ARR) retention. Which of the following represents the best leading indicator Key Result for this team?',
        'intermediate',
        'Stripe',
        'B2B SaaS billing and customer retention',
        'C',
        'ARR retention is a lagging indicator—by the time it drops, it is too late to act. A high-quality KR focuses on a leading indicator that the product team can directly influence, which correlates with the lagging outcome. Option C measures the activation funnel (configuring subscription tiers within 7 days), which is a strong leading indicator of product adoption and retention. Option A is a lagging financial metric. Option B is a support health metric. Option D is a task output.',
        ARRAY['okrs', 'key_results']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Increase Billing platform ARR retention rate from 94% to 97% by Q4', false),
    (v_q_id, 'B', 'Reduce customer support tickets related to complex invoice disputes by 15%', false),
    (v_q_id, 'C', 'Increase the percentage of newly integrated merchants who configure their first subscription tier within 7 days of signup from 45% to 70%', true),
    (v_q_id, 'D', 'Build and ship the automated tax compliance module for European merchants', false);

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
        'Duolingo''s Retention Target Math',
        'A Duolingo PM sets an aspirational Key Result: ''Increase D30 user retention from 20% to 28%.'' At the end of the quarter, the team achieves 25% D30 retention. How should this KR be scored and interpreted?',
        'intermediate',
        'Duolingo',
        'User retention cohort analysis',
        'B',
        'OKR scoring is typically calculated as: (Actual - Baseline) / (Target - Baseline). Here, the baseline is 20%, target is 28%, and actual is 25%. The calculation is (25 - 20) / (28 - 20) = 5 / 8 = 0.625. In Google''s OKR framework, a score between 0.6 and 0.7 on an aspirational goal is considered a successful ''green'' grade, representing excellent progress. Option B correctly identifies this math and interpretation. Option A is wrong because it uses binary grading. Option C is wrong because 25% is not 100% of the target. Option D is sandbagging.',
        ARRAY['okrs', 'okr_grading', 'committed_vs_aspirational']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Grade it as 0.0 (failure) because the team failed to hit the absolute target of 28% retention', false),
    (v_q_id, 'B', 'Grade it as 0.63 (success) because they achieved ~63% of the target increase, which is within the standard 0.6-0.7 range for aspirational goals', true),
    (v_q_id, 'C', 'Grade it as 1.0 (perfect success) because hitting 25% retention is close enough to 28% and represents significant growth', false),
    (v_q_id, 'D', 'Grade it as 0.89 because 25 is 89% of 28, neglecting the baseline starting point of 20%', false);

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
        'Zoom''s OKRs vs. Health KPIs',
        'A Zoom PM for the Video Quality team is drafting OKRs. The team''s daily responsibility includes maintaining video latency below 150ms. The PM is debating whether to make ''Maintain video latency below 150ms'' a Key Result. What is the correct way to handle this?',
        'intermediate',
        'Zoom',
        'Video quality latency and performance monitoring',
        'B',
        'This scenario highlights the difference between OKRs (focusing on strategic changes/initiatives) and KPIs (focusing on health metrics or business-as-usual). Keeping latency below 150ms is a operational health KPI. It only becomes an OKR if latency spikes or if the team needs to perform a major engineering re-architecture to drop it further. Option B correctly makes this distinction. Option A clutter OKRs with daily operations. Option C is a role-based misconception. Option D is arbitrary.',
        ARRAY['okrs', 'key_results', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Include it as a Key Result to ensure the engineering team remains accountable for daily network operations', false),
    (v_q_id, 'B', 'Keep it as a health KPI/guardrail metric monitored via dashboards; only make it an OKR if the team needs to execute a strategic project to lower latency further', true),
    (v_q_id, 'C', 'Convert it into an Objective: ''Maintain latency,'' and have the key results be the specific server names', false),
    (v_q_id, 'D', 'Include it as an OKR but only grade it at the end of the year rather than quarterly', false);

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
        'Peloton''s 0-to-1 Learning OKRs',
        'Peloton is developing a brand-new social feature: ''Virtual Riding Co-Ops,'' allowing users to complete challenges together in real time. Because this is a 0-to-1 launch, the team has no historical baseline data for user adoption or retention. How should the PM structure the Key Results for this launch?',
        'intermediate',
        'Peloton',
        'New social fitness feature launch and validation',
        'B',
        'For 0-to-1 features, setting arbitrary engagement numbers (like ''reach 50% weekly active users'') is a guess that leads to bad planning. Instead, OKRs should focus on learning, establishing baselines, and validating core value propositions. Option B focuses on establishing a baseline and finding the retention driver, which is the correct approach for early-stage discovery. Option A is an ungrounded guess. Option C is an avoidance strategy. Option D is an output-based trap.',
        ARRAY['okrs', 'key_results', 'committed_vs_aspirational']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set an ambitious target like ''Achieve 45% weekly active usage'' based on competitor benchmarks, and hold the team to it', false),
    (v_q_id, 'B', 'Focus KRs on learning and baseline establishment, such as ''Establish baseline D7 retention curve and identify the top 2 engagement drivers via qualitative interviews''', true),
    (v_q_id, 'C', 'Skip quarterly OKRs entirely and use a simple task list until the product has been in the market for 6 months', false),
    (v_q_id, 'D', 'Write Key Results based entirely on software delivery milestones, such as ''Deploy backend microservice to production''', false);

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
        'Atlassian''s ''Sponsor'' Anti-Pattern',
        'At Atlassian, a senior VP mandates that the Jira Mobile, Jira Web, and Jira Search teams all include a specific Key Result in their quarterly OKRs: ''Integrate the new AI-powered Voice Ticket Creator feature by Q3.'' What is the primary risk associated with this style of top-down cascading?',
        'intermediate',
        'Atlassian',
        'Jira issue creation flows and cross-platform alignment',
        'B',
        'This represents the ''Sponsor'' anti-pattern, where executives bypass product discovery and force a specific output (a feature) down the hierarchy as an OKR. This ruins team autonomy, prevents them from applying localized customer insight, and forces them to focus on shipping a specific solution instead of solving a user problem (outcome). Option A, C, and D do not represent the core organizational risk of lost autonomy and poor product discovery.',
        ARRAY['okrs', 'cascading_goals', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It makes it difficult for the Finance team to track budget allocations across the three product lines', false),
    (v_q_id, 'B', 'It overrides team autonomy, bypasses user research, and forces teams to focus on output delivery (shipping a feature) rather than solving user problems (outcomes)', true),
    (v_q_id, 'C', 'It causes developer burnout by introducing duplicate code across the Web and Mobile repositories', false),
    (v_q_id, 'D', 'It violates Scrum principles by requiring teams to deploy code on a quarterly rather than bi-weekly basis', false);

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
        'Spotify''s Mid-Quarter Podcasting Pivot',
        'A Spotify Podcast PM has a quarterly Key Result: ''Increase podcast listening hours by 20%.'' In week 5, Spotify''s exclusive licensing agreements with three major podcast networks expire due to unexpected legal hurdles, causing a sudden 15% drop in total podcast catalog views. How should the PM manage the team''s OKR?',
        'intermediate',
        'Spotify',
        'Podcast licensing and catalog engagement',
        'C',
        'OKRs are not meant to be rigid contracts that force teams to run off a cliff when assumptions change. When external shocks occur, the PM should hold a mid-quarter review, document the licensing blocker, pivot the team to areas they can still control (like optimizing the recommendation model for non-exclusive podcasts), adjust the target, and communicate this change transparently to stakeholders. Option A is passive. Option B is gaming the metric. Option D lacks transparency.',
        ARRAY['okrs', 'okr_grading', 'retrospective_learning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Leave the OKR unchanged and accept a 0.0 grade at the end of the quarter to show accountability', false),
    (v_q_id, 'B', 'Redefine the term ''listening hours'' in the tracking tool to include music streaming, masking the podcast drop', false),
    (v_q_id, 'C', 'Conduct a review to document the blocker, adjust the target or pivot the team''s tactics to optimize non-exclusive catalog engagement, and align with stakeholders', true),
    (v_q_id, 'D', 'Silently delete the OKR from the team''s dashboard to prevent executive leadership from seeing the decline', false);

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
        'Shopify''s Checkout Fraud Counter-Metric',
        'A Shopify Checkout PM sets a Key Result: ''Increase checkout conversion rate from 82% to 85%.'' The team achieves 85.5% by removing multi-factor authentication steps and security badges. However, chargebacks and fraud transactions spike by 40%, costing merchants thousands of dollars. Which OKR design principle did the PM violate?',
        'intermediate',
        'Shopify',
        'E-commerce checkout conversion and fraud prevention',
        'B',
        'This scenario demonstrates Goodhart''s Law (''When a measure becomes a target, it ceases to be a good measure'') and the failure to include a counter-metric (or guardrail metric). To prevent the team from optimizing a metric at the expense of business health, they must pair it with a guardrail, such as ''Maintain fraud rate below 0.1%.'' Option A is incorrect. Option C is irrelevant to the trade-off. Option D is incorrect because conversion rate is a valid operational outcome metric, but needs guardrails.',
        ARRAY['okrs', 'key_results', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Setting a committed target that was too easy to achieve without modifying the code', false),
    (v_q_id, 'B', 'Failing to include a counter-metric or guardrail metric to prevent local optimization from causing systemic harm', true),
    (v_q_id, 'C', 'Using a quantitative key result instead of a qualitative objective to measure checkout performance', false),
    (v_q_id, 'D', 'Measuring conversion rate, which is a lagging financial outcome rather than a leading indicator', false);

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
        'Airbnb''s Marketplace OKR Conflict',
        'At Airbnb, the Host Experience team has a Q3 OKR to ''Increase average listing price to maximize host payout revenue.'' Concurrently, the Guest Experience team has an OKR to ''Increase bookable inventory under $100/night to attract budget travelers.'' The two teams launch conflicting sorting experiments, damaging search conversion. How should this conflict be resolved?',
        'intermediate',
        'Airbnb',
        'Two-sided marketplace supply and demand balancing',
        'B',
        'In a two-sided marketplace, teams optimizing local OKRs in silos can easily damage the overall ecosystem. The conflict must be resolved by aligning both teams around a shared corporate goal (like Gross Merchandise Value or overall booking matches) and establishing joint guardrails. Option A is dictatorial and misses alignment. Option C is mathematically nonsense. Option D ignores the guest-side impact.',
        ARRAY['okrs', 'dependency_conflicts', 'cascading_goals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The VP of Product should cancel the Guest Experience team''s OKR and prioritize Host revenue', false),
    (v_q_id, 'B', 'The teams should hold a joint alignment session to connect their goals to a shared corporate Objective (e.g., increase overall booking matches) and set guardrails to prevent one-sided optimization from harming the marketplace', true),
    (v_q_id, 'C', 'Combine the two OKRs into a single average listing price metric of exactly $120/night across all global listings', false),
    (v_q_id, 'D', 'Allow both teams to run their experiments simultaneously in the same cities, and award resources to the team that hits their target first', false);

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
        'Slack''s ''Set and Forget'' Anti-Pattern',
        'Slack''s PM for the Search and Discovery team writes excellent, outcome-oriented OKRs at the start of Q1. During the quarter, the team focuses weekly status updates entirely on Jira ticket completions. They only revisit the OKRs during the final week of Q1 to grade their performance. What anti-pattern is this?',
        'intermediate',
        'Slack',
        'Search and discovery feature tracking',
        'C',
        'This represents the ''Set and Forget'' anti-pattern. OKRs are useless if they are not integrated into the team''s weekly or bi-weekly cadence (e.g., discussing confidence scores or metric progress during sprint reviews). Without this, OKRs become a bureaucratic reporting exercise rather than a tool for execution. Option A, B, and D describe different OKR anti-patterns.',
        ARRAY['okrs', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Sandbagging, because the team did not update their goals to match their actual development pace', false),
    (v_q_id, 'B', 'Task-list KRs, because the team spent their time working on Jira tickets', false),
    (v_q_id, 'C', 'Set and Forget, where OKRs are treated as a quarterly planning ritual rather than an active tool to guide weekly execution and prioritization', true),
    (v_q_id, 'D', 'Top-down cascading, because the PM did not involve the engineers in the final grading process', false);

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
        'Figma''s Multi-Year Strategy Alignment',
        'Figma''s multi-year strategic pillar is: ''Empower non-designers to actively collaborate in design files.'' The PM for the Collaboration team needs to translate this into a quarterly Key Result. Which of the following represents the most aligned, outcome-oriented quarterly Key Result?',
        'intermediate',
        'Figma',
        'Multi-user collaboration and user personas',
        'B',
        'A quarterly Key Result should represent measurable progress toward the long-term strategy. Option B defines a clear behavioral outcome (non-designers collaborating actively) that is measurable and directly aligned. Option A is a simple output. Option C is a feature list. Option D is a marketing task.',
        ARRAY['okrs', 'objective_writing', 'key_results']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Publish 5 video tutorials explaining how non-designers can leave comments in Figma files', false),
    (v_q_id, 'B', 'Increase the percentage of weekly active design files that have at least one non-designer editor making edits from 15% to 25%', true),
    (v_q_id, 'C', 'Launch 3 new commenting and voice memo features specifically designed for developers and product managers', false),
    (v_q_id, 'D', 'Rebrand the marketing landing page to highlight Figma''s utility for product managers and writers', false);

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
        'Uber''s Aspirational Latency Scoring',
        'An Uber Delivery PM sets an aspirational Key Result: ''Reduce average delivery checkout load time from 1,200ms to 600ms.'' The team spends the quarter optimizing API responses and achieves an average load time of 800ms. What is the calculated score for this Key Result?',
        'intermediate',
        'Uber',
        'Checkout performance and load time latency',
        'B',
        'The score is calculated using the formula: (Baseline - Actual) / (Baseline - Target) for reduction metrics. Here, baseline is 1,200ms, target is 600ms, and actual is 800ms. Calculation: (1200 - 800) / (1200 - 600) = 400 / 600 = 0.67. Option B is correct. Option A is incorrect. Option C is incorrect. Option D is a simple ratio of 800/1200, which ignores the target threshold.',
        ARRAY['okrs', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '0.33', false),
    (v_q_id, 'B', '0.67', true),
    (v_q_id, 'C', '0.50', false),
    (v_q_id, 'D', '0.75', false);

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
        'Slack''s Shared Team OKRs',
        'A Slack PM wants to prevent silos where engineering only cares about technical performance and design only cares about UX patterns. The PM proposes writing shared team OKRs instead of function-specific OKRs. What is the best way to structure this?',
        'intermediate',
        'Slack',
        'Cross-functional team collaboration and goal setting',
        'B',
        'High-performing product teams share collective ownership of the outcome. The entire team should share the Objective and the Key Results, rather than splitting them by functional role. This encourages engineers and designers to collaborate on the best ways to move the metrics together. Option A and D keep the silos intact. Option C completely separates technical and product goals, which worsens alignment.',
        ARRAY['okrs', 'cascading_goals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM owns the Objective, the designer owns UX usability KRs, and the engineers own system performance KRs', false),
    (v_q_id, 'B', 'The entire cross-functional team collectively owns the Objective and all supporting outcome KRs, and collaborates on how different functions can move those metrics', true),
    (v_q_id, 'C', 'Engineering writes a separate set of engineering-only OKRs, while PM and Design write business OKRs, and they merge them in a shared document', false),
    (v_q_id, 'D', 'The team shares the Objective, but each individual team member has their own separate, siloed Key Results linked to their specific job description', false);

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
        'Notion''s Binary Security Compliance',
        'Notion''s Enterprise team has a committed OKR: ''Achieve SOC 2 Type II compliance certification by December 31st.'' How should the team think about the grading and execution of this committed OKR?',
        'intermediate',
        'Notion',
        'Enterprise security compliance and certification',
        'B',
        'Committed OKRs are operational requirements where partial success is not acceptable. For a regulatory or compliance goal like SOC 2, you are either certified or you are not. Therefore, this KR is binary: it is scored as 1.0 upon full achievement or 0.0 if missed. Hitting 70% of compliance criteria does not grant certification. Option B is correct. Option A and C fail to recognize the strict nature of compliance-based committed goals. Option D is incorrect because binary targets are appropriate for compliance/legal milestones.',
        ARRAY['okrs', 'committed_vs_aspirational', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It should be graded on a curve; hitting 70% of the audit requirements is considered a success', false),
    (v_q_id, 'B', 'It must be treated as a binary committed KR (scored as 1.0 or 0.0) because failing to achieve full certification renders the entire effort unsuccessful for enterprise customers', true),
    (v_q_id, 'C', 'It should be classified as an aspirational OKR because compliance audits are highly unpredictable and out of the team''s control', false),
    (v_q_id, 'D', 'The team should avoid binary targets in OKRs and instead measure the ''number of hours spent preparing for the audit''', false);

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
        'Amazon''s PR/FAQ to OKR Transition',
        'An Amazon PM writes a PR/FAQ for a new ''Group Gifting'' experience, describing how friends can pool funds to buy high-value items. The PR/FAQ is approved. When setting quarterly OKRs for the product launch, which of the following represents the most aligned outcome Key Result?',
        'intermediate',
        'Amazon',
        'Social commerce and collaborative purchasing',
        'C',
        'The PR/FAQ describes the customer value: pooling money easily to buy gifts. The OKR should measure if customers are experiencing this core value. Option C measures the behavioral outcome of successful group pooling. Option A and B are output tasks. Option D measures traffic/vanity metrics rather than the core transactional value.',
        ARRAY['okrs', 'key_results']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Achieve VP sign-off on the technical architecture design document by week 3', false),
    (v_q_id, 'B', 'Complete 100% of the front-end and back-end integration tickets in the sprint backlog', false),
    (v_q_id, 'C', 'Achieve a rate of 15% of all group-gifting invitations resulting in a successfully completed purchase within 14 days of creation', true),
    (v_q_id, 'D', 'Generate 50,000 page views on the group-gifting marketing landing page', false);

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
        'YouTube''s Quality Guardrails',
        'YouTube''s Recommendation PM writes an OKR: ''Objective: Increase user session depth via recommendation algorithm optimization.'' The main Key Result is: ''Increase average videos watched per session from 4.2 to 5.0.'' To prevent the algorithm from gaming this by recommending low-quality clickbait, what counter-metric must the PM track?',
        'intermediate',
        'YouTube',
        'Recommendation engine tuning and user satisfaction',
        'C',
        'Optimizing purely for quantity of videos watched can lead the recommendation engine to suggest highly sensationalized clickbait, which increases short-term clicks but damages long-term trust and user retention. Pairing the metric with a quality-focused counter-metric like ''Maintain user satisfaction survey rating above 4.2/5'' or ''Keep click-to-completion rate above 70%'' prevents this gaming. Option C is correct. Option A and D do not capture video clickbait quality issues directly. Option B is a lagging metric.',
        ARRAY['okrs', 'key_results', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Daily Active Users (DAU), to ensure that more people are using the app overall', false),
    (v_q_id, 'B', 'Monthly churn rate of premium subscribers, to track financial impact', false),
    (v_q_id, 'C', 'Video click-to-completion rate (percentage of videos watched for at least 50% of their length) or user satisfaction survey score', true),
    (v_q_id, 'D', 'Total number of video uploads by creators in the same period', false);

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
        'GitHub''s Planning Latency Optimization',
        'A GitHub PM leads a team that spends the first 4 weeks of every quarter debating, drafting, and revising their team-level OKRs, leaving only 8 weeks for actual feature execution. How should the PM optimize this planning process?',
        'intermediate',
        'GitHub',
        'Software development team planning efficiency',
        'B',
        'Spending a third of the quarter on OKR planning is a severe waste of execution time (planning latency). The PM should time-box planning to 1-2 weeks. OKRs do not need to be perfect; they need to provide direction. Option B describes this time-boxing best practice. Option A is an overreaction. Option C removes team alignment and buy-in. Option D removes the agility of quarterly cycles.',
        ARRAY['okrs', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Eliminate quarterly OKRs entirely and switch to continuous kanban with no high-level goals', false),
    (v_q_id, 'B', 'Time-box the planning process to a maximum of 1-2 weeks, using pre-drafted company/division goals to align quickly and iterate rather than striving for perfection', true),
    (v_q_id, 'C', 'Have the PM write all the OKRs in isolation and hand them down to the engineering leads without any discussion', false),
    (v_q_id, 'D', 'Switch to annual OKRs only and stop grading them to reduce administrative overhead', false);

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
        'Netflix''s Mobile Segment Masking',
        'A Netflix Engagement PM has a Q1 OKR: ''Maintain average user viewing hours at 12 hours/week.'' At the end of Q1, the aggregate metric reports 12.4 hours/week, indicating a successful 1.0 score. However, a segment analysis reveals that Web and TV viewing hours increased significantly due to a TV UI redesign, while Mobile viewing hours dropped from 8 hours/week to 3 hours/week due to a buggy app release. How should the PM handle this?',
        'advanced',
        'Netflix',
        'Cross-platform user engagement and segment divergence',
        'C',
        'This scenario demonstrates Simpson''s Paradox / segment masking in OKR metrics. While the aggregate target was met, underlying segments are diverging dangerously. The PM must grade the OKR as technically achieved but highlight the mobile drop as a critical finding, and prioritize a mobile-specific OKR next quarter to resolve the degradation. Option A is a dangerous omission. Option B is an invalid retroactive change. Option D avoids the mobile problem entirely.',
        ARRAY['okrs', 'okr_grading', 'retrospective_learning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Report the OKR as a complete success (1.0) and ignore the mobile decline, as the overall company target was achieved', false),
    (v_q_id, 'B', 'Retroactively change the Q1 target to 14 hours/week to reflect the TV growth, and mark the overall OKR as a failure', false),
    (v_q_id, 'C', 'Grade the OKR as achieved (1.0), but present the segment divergence as a critical finding to leadership and set a targeted Q2 OKR to fix the mobile experience', true),
    (v_q_id, 'D', 'Modify the metric definition for next quarter to exclude mobile users from the average viewing hours calculation', false);

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
        'Uber''s Marketplace Feedback Loops',
        'At Uber, the Rider Pricing team has a Q3 OKR to ''Increase gross bookings by 5% via targeted rider discounts.'' Simultaneously, the Driver Incentives team has an OKR to ''Reduce driver acquisition/incentive spend by 10%.'' When both teams run experiments in the same city, rider demand surges while driver supply drops, causing massive surge multiplier spikes, long wait times, and high rider cancellation rates. What is the root cause of this conflict?',
        'advanced',
        'Uber',
        'Two-sided marketplace economics and experimental interference',
        'B',
        'This is a classic marketplace feedback loop conflict. The two teams set local OKRs in silos without considering how their metrics interact in the shared physical marketplace. The solution is to align both teams around a unified marketplace efficiency metric (like Match Rate or completed trips) and share guardrail metrics. Option A slows down innovation unnecessarily. Option C encourages toxic competition. Option D is an operational fallback that doesn''t fix the OKR design issue.',
        ARRAY['okrs', 'dependency_conflicts', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The teams ran experiments in the same market; they should have isolated their testing by running rider experiments only in Chicago and driver experiments in New York', false),
    (v_q_id, 'B', 'The local OKRs were designed in silos without accounting for marketplace feedback loops; they should be aligned around a shared efficiency metric (e.g., Match Rate) with mutual guardrail metrics', true),
    (v_q_id, 'C', 'The Rider team did not discount aggressively enough to offset the loss of driver incentives', false),
    (v_q_id, 'D', 'The Driver Incentives team should have delayed their Q3 OKR until the Rider Pricing team completed their discount phase', false);

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
        'Spotify''s Viral Loop Grading Math',
        E'A Spotify Growth PM has an Objective: ''Unlock viral loop growth.'' The supporting KRs are:\n1. Increase external referral share rate by 15% (Achieved: 15% -> score 1.0)\n2. Increase landing page sign-up conversion from 30% to 45% (Achieved: 33% -> progress: (33-30)/(45-30) = 0.20)\n3. Achieve a virality coefficient (K-factor) of 1.1 (Achieved: 0.85 -> K-factor needs to be > 1.0 for self-sustaining growth)\nHow should the PM grade this Objective''s overall success?',
        'advanced',
        'Spotify',
        'Viral loop mechanics and product growth metrics',
        'B',
        'A viral loop is a multiplicative system. The K-factor represents the number of new users generated by each existing user. If the K-factor is less than 1.0 (here, it is 0.85), the loop decays and is not self-sustaining. Therefore, the overall Objective (''Unlock viral loop growth'') was not achieved. Hitting the intermediate referral rate and conversion targets is meaningless if the system-level outcome failed. The PM should score the overall Objective as 0.0 or near-zero, rather than a simple mathematical average of the KRs. Option B correctly identifies this system-level thinking. Option A uses a simplistic average that misrepresents reality. Option C is wrong. Option D is gaming the target.',
        ARRAY['okrs', 'okr_grading', 'key_results']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Average the three scores mathematically: (1.0 + 0.20 + 0.0) / 3 = 0.40, reflecting moderate progress', false),
    (v_q_id, 'B', 'Grade the overall Objective as 0.0 (or near-zero) because the K-factor remains below 1.0, meaning the viral loop is not self-sustaining and the core Objective was not achieved', true),
    (v_q_id, 'C', 'Grade the Objective as 1.0 because the external referral share rate target was fully achieved, which is the hardest leading indicator', false),
    (v_q_id, 'D', 'Recalculate the K-factor progress as 77% (0.85/1.10) and average it with the others to yield a score of 0.66', false);

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
        'Slack''s Developer Platform Vanity KRs',
        'A Slack PM for the App Directory has an OKR: ''Objective: Accelerate third-party app ecosystem growth.'' The main Key Result is: ''Increase total apps in the App Directory from 2,000 to 3,000.'' By Q3, they reach 3,150 apps. However, telemetry reveals that 82% of these new apps have zero active installations, and developer support tickets increase by 50% due to low-quality submissions. What structural OKR error was made?',
        'advanced',
        'Slack',
        'Developer ecosystem platform and directory metrics',
        'B',
        'The PM fell into the trap of using a vanity quantity metric (app count) as a Key Result, which was easily gamed by developers submitting low-quality apps (Goodhart''s Law). The KR should have measured value/engagement, such as the number of active apps with a minimum threshold of installations. Option B is the correct structural fix. Option A doubles down on the vanity metric. Option C changes business models rather than fixing the OKR. Option D is an output-based solution that destroys the platform model.',
        ARRAY['okrs', 'key_results', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The target was set too low; they should have set the KR target to 5,000 apps to force higher standards', false),
    (v_q_id, 'B', 'The KR measured a vanity quantity output rather than quality and usage; they should have defined the KR around active, installed apps (e.g., ''Increase apps with >50 weekly active teams from 1,200 to 1,800'')', true),
    (v_q_id, 'C', 'The team should have charged developers a $99 publishing fee to filter out low-quality apps before they reached the directory', false),
    (v_q_id, 'D', 'The PM should have focused on building the top 1,000 apps internally using Slack resources to ensure high quality', false);

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
        'DoorDash''s Diminishing Returns Cascading',
        'DoorDash''s VP of Product sets a corporate Q4 target: ''Reduce order cancellation rate by 20% globally.'' The VP mandates that every regional PM team reduce their local cancellation rate by exactly 20%. The Seattle PM starts the quarter with a 1.0% cancellation rate (highly optimized), while the Atlanta PM starts with an 8.0% cancellation rate (unoptimized). What is the strategic flaw in this cascading method?',
        'advanced',
        'DoorDash',
        'Regional delivery operations and cancellation rate optimization',
        'B',
        'This cascading method ignores the law of diminishing returns. Reducing an already optimized cancellation rate from 1.0% to 0.8% (Seattle) requires extreme engineering and operational effort for a tiny absolute gain (0.2%). Reducing Atlanta''s rate from 8.0% to 6.4% is far easier and yields a massive absolute gain (1.6%). Distributing targets equally leads to severe resource misallocation. Option B is correct. Option A is geographically biased. Option C is ridiculous. Option D is statistically incorrect.',
        ARRAY['okrs', 'cascading_goals', 'okr_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Seattle has a higher volume of premium customers, so their cancellation rate should naturally be lower than Atlanta''s', false),
    (v_q_id, 'B', 'It ignores the law of diminishing returns; reducing Seattle''s rate from 1.0% to 0.8% is exponentially harder than reducing Atlanta''s from 8.0% to 6.4%, leading to misallocated engineering resources', true),
    (v_q_id, 'C', 'The Seattle PM should have been given a target to increase cancellation rates to help balance driver supply', false),
    (v_q_id, 'D', 'All regional marketplaces have identical friction points, so the 20% relative reduction is mathematically fair and optimal', false);

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
        'Stripe''s Black Friday Resource Shift',
        'Stripe''s Core API team has a committed OKR: ''Zero downtime during Black Friday week (100% API uptime)'' and an aspirational OKR: ''Reduce API response time for complex merchant queries by 30%.'' Two weeks before Black Friday, a database replication bug is discovered that threatens write reliability under peak load. How should the PM reallocate resources?',
        'advanced',
        'Stripe',
        'High-availability transaction processing and capacity planning',
        'B',
        'Committed OKRs represent strict operational agreements that are essential for business viability (downtime during Black Friday is catastrophic). Under resource constraints, committed OKRs take absolute precedence. The PM must pause the aspirational latency OKR, shift all engineering resources to fix the database bug, and document this trade-off for stakeholders. Option A is a compromise that risks failing both. Option C is unacceptable for Stripe''s core value. Option D is risky and unrealistic in a 2-week window.',
        ARRAY['okrs', 'committed_vs_aspirational', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Maintain a 50/50 resource split between the two OKRs to ensure that the team makes partial progress on latency optimization', false),
    (v_q_id, 'B', 'Pause the aspirational latency OKR entirely, shift all engineering resources to resolve the database bug to secure the committed uptime OKR, and document the rationale', true),
    (v_q_id, 'C', 'Lower the uptime target of the committed OKR to 98% to avoid pausing the latency optimization work', false),
    (v_q_id, 'D', 'Hire external contractors to patch the replication bug within 48 hours so the core team does not lose focus on latency', false);

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
        'Shopify''s POS Discovery Post-Mortem',
        'Shopify''s Point of Sale (POS) PM set an ambitious aspirational OKR: ''Increase POS tablet activation rate in physical retail stores from 60% to 80%.'' The engineering team delivered 100% of the planned features (better onboarding flows, instant sync, simplified UI) on time. However, the activation rate ended the quarter at 62%. The PM''s post-mortem reveals that retail store owners lacked physical counter mounting stands, preventing them from deploying the tablets. How should this result be graded and classified?',
        'advanced',
        'Shopify',
        'Physical retail POS hardware deployment and activation',
        'B',
        'This is a classic ''hypothesis/discovery failure'' rather than an execution failure. The team executed perfectly (delivered features on time), but their underlying assumption that software features were the primary bottleneck was incorrect (the actual blocker was a physical accessory). In a healthy product culture, this is treated as a valuable learning opportunity, graded as a partial success (0.10), and used to guide next quarter''s OKRs toward hardware support. Option B is correct. Option A is wrong because execution was successful. Option C is sandbagging. Option D is incorrect because the software worked as designed.',
        ARRAY['okrs', 'retrospective_learning', 'okr_grading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Grade as a total execution failure (0.0) because the engineering team did not build a feature to bypass the mounting stand requirement', false),
    (v_q_id, 'B', 'Grade as a partial success (0.10) and classify it as a hypothesis/discovery failure; document the mounting stand blocker, share the learnings across the org, and pivot next quarter''s OKRs to focus on physical hardware distribution partnerships', true),
    (v_q_id, 'C', 'Retroactively change the original Q3 target to 62% and claim a 1.0 success to ensure the team receives their quarterly bonuses', false),
    (v_q_id, 'D', 'Classify it as a technical failure because the POS app should have run in headless mode without a tablet screen', false);


    RAISE NOTICE 'Successfully inserted 35 questions for OKRs';

END $$;
