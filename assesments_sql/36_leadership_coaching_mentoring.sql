-- ============================================
-- ASSESSMENT: Coaching & Mentoring
-- CATEGORY: Leadership
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
    WHERE slug = 'coaching-mentoring';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug coaching-mentoring not found. Run the seed data first.';
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
        'Spotify''s SBI Feedback',
        E'A junior PM on Spotify''s Playlist team consistently interrupts engineers during standups. The Group Product Manager (GPM) needs to deliver constructive feedback to correct this behavior without demoralizing the PM.\n\nWhich approach applies the Situation-Behavior-Impact (SBI) framework correctly?',
        'foundational',
        'Spotify',
        'Music streaming platform',
        'B',
        'Option B perfectly follows the SBI model: Situation (yesterday''s standup), Behavior (you interrupted the frontend lead twice), and Impact (it caused the meeting to run long and made the engineers feel unheard). Option A focuses on personality rather than objective behavior. Option C assumes intent (''you rush'') rather than stating facts. Option D is a compliment sandwich that dilutes the core feedback.',
        ARRAY['performance_feedback', 'communication', 'sbi_model']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the PM: ''You are coming across as aggressive in standups. You need to be more collaborative.''', false),
    (v_q_id, 'B', 'Tell the PM: ''In yesterday''s standup, you interrupted the frontend lead twice. This caused the meeting to run over and made the team feel unheard.''', true),
    (v_q_id, 'C', 'Tell the PM: ''When you rush through standups, the engineers feel like you don''t care about their constraints.''', false),
    (v_q_id, 'D', 'Tell the PM: ''You are doing great on specs, but maybe try to let others speak more. Keep up the good work.''', false);

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
        'Slack''s Delegation Strategy',
        E'A new Lead PM at Slack is overwhelmed because they are still writing detailed API specs for the messaging team while managing two junior PMs. The Lead PM complains they don''t have time for strategy.\n\nWhat is the most appropriate coaching advice for this Lead PM?',
        'foundational',
        'Slack',
        'Workplace communication tool',
        'C',
        'Option C correctly applies delegation for development. Moving from an Individual Contributor (IC) to a Manager requires letting go of execution tasks like API specs to focus on strategy and coaching. Option A leads directly to burnout. Option B is backwards; managers own strategy and delegate execution. Option D solves the wrong problem by reducing management load instead of fixing time allocation.',
        ARRAY['delegation', 'ic_to_manager', 'time_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the Lead PM to work longer hours temporarily until the junior PMs are fully ramped up.', false),
    (v_q_id, 'B', 'Advise the Lead PM to delegate the strategic planning to the junior PMs so they can focus on specs.', false),
    (v_q_id, 'C', 'Coach the Lead PM to delegate the API spec writing to the junior PMs, using it as a developmental opportunity.', true),
    (v_q_id, 'D', 'Suggest transferring one of the junior PMs to another team to reduce management overhead.', false);

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
        'Airbnb''s Prioritization Coaching',
        E'An Associate PM at Airbnb has a backlog of 50 host-facing features and is struggling to prioritize. They ask their mentor to just tell them which three features to build next.\n\nHow should the mentor respond?',
        'foundational',
        'Airbnb',
        'Vacation rental marketplace',
        'B',
        'Option B represents effective coaching by asking open-ended questions that guide the mentee to the answer, building their autonomous problem-solving skills. Option A solves the problem for them, which creates dependency and prevents learning. Option C delegates core PM responsibilities to engineering. Option D is unnecessarily punitive for a junior APM seeking help.',
        ARRAY['mentorship', 'prioritization', 'skill_building']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Review the backlog and select the top three features for the APM to save time.', false),
    (v_q_id, 'B', 'Ask the APM: ''What framework have you considered using to evaluate these, and what is our current goal?''', true),
    (v_q_id, 'C', 'Tell the APM to ask the engineering team which features are easiest to build.', false),
    (v_q_id, 'D', 'Escalate to the APM''s manager that they lack basic prioritization skills.', false);

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
        'Uber''s Developmental Goals',
        E'A PM on Uber''s driver app is excellent at execution but struggles with cross-functional influence. During performance review goal-setting, the manager needs to set a developmental goal.\n\nWhich goal is most effective?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'C',
        'Option C is a specific, actionable developmental goal that directly tackles the PM''s weakness (cross-functional influence) in a measurable, applied way. Option A is a standard performance/delivery goal, not a developmental one. Option B is passive and lacks application. Option D is negatively framed and doesn''t actively build the skill of influence.',
        ARRAY['career_development', 'goal_setting', 'performance_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '''Deliver the new driver earnings dashboard on time and under budget.''', false),
    (v_q_id, 'B', '''Read three books on leadership and influence by the end of Q3.''', false),
    (v_q_id, 'C', '''Lead the next quarterly planning session and secure buy-in from marketing and ops without escalations.''', true),
    (v_q_id, 'D', '''Avoid getting into any arguments with the ops team for the next six months.''', false);

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
        'Notion''s Active Listening',
        E'During a 1:1, a PM at Notion expresses frustration that their engineering pod is pushing back on a new block type feature. The manager immediately interrupts to say, ''Here is how I handled pushback when I was a PM.''\n\nWhy is this a poor coaching practice?',
        'foundational',
        'Notion',
        'Productivity and note-taking workspace',
        'A',
        'Option A is correct. Effective coaching starts with active listening to understand the root cause before offering solutions. Jumping in with advice shuts down the PM''s ability to process and problem-solve. Options B and C are bad management practices that undermine the PM''s autonomy. Option D is incorrect; past experience can be relevant, but the timing of sharing it is wrong.',
        ARRAY['active_listening', 'mentorship', 'communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The manager is failing to practice active listening and jumping straight to ''solutioning''.', true),
    (v_q_id, 'B', 'The manager should have escalated the issue to the engineering manager first.', false),
    (v_q_id, 'C', 'The manager should have told the PM to drop the feature if engineering is pushing back.', false),
    (v_q_id, 'D', 'The manager''s past experience as a PM is entirely irrelevant to Notion''s current architecture.', false);

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
        'Netflix''s IC to Manager Transition',
        E'A top-performing Senior PM at Netflix has just been promoted to Group PM. In their first month, they rewrite a PRD created by one of their direct reports because ''it wasn''t up to my standard.''\n\nWhat feedback should the Director of Product give the GPM?',
        'foundational',
        'Netflix',
        'Video streaming platform',
        'B',
        'Option B correctly identifies the mindset shift required from IC to Manager. The manager''s output is now the output of their team. Rewriting the PRD creates a bottleneck and prevents learning. Option A encourages micromanagement. Option C is extreme and violates coaching principles. Option D misses the core developmental problem.',
        ARRAY['ic_to_manager', 'delegation', 'skill_building']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '''Great job ensuring high quality. Keep rewriting them until the team learns.''', false),
    (v_q_id, 'B', '''Your job is no longer to write perfect PRDs, but to coach your team. Next time, leave comments.''', true),
    (v_q_id, 'C', '''You should fire PMs who cannot write PRDs to your standard.''', false),
    (v_q_id, 'D', '''Only rewrite the PRD if the feature is launching within the next two weeks.''', false);

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
        'Stripe''s Burnout Recognition',
        E'A highly productive PM at Stripe has started missing deadlines, skipping optional meetings, and responding cynically to user feedback. The PM previously had a flawless track record.\n\nWhat is the most appropriate first step for their manager?',
        'foundational',
        'Stripe',
        'Payment processing platform',
        'B',
        'Option B addresses the clear signs of burnout with empathy and fact-finding. A sudden drop in performance from a high achiever usually indicates burnout or personal issues, not a sudden loss of competence. Option A is punitive. Option C undermines their autonomy without discussion. Option D assumes the solution without understanding the root cause.',
        ARRAY['burnout_management', 'empathy', 'team_leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Put the PM on a formal Performance Improvement Plan (PIP).', false),
    (v_q_id, 'B', 'Schedule a 1:1 to ask open-ended questions about their workload, energy levels, and well-being.', true),
    (v_q_id, 'C', 'Reassign half of their projects to another PM immediately without discussion.', false),
    (v_q_id, 'D', 'Tell the PM they need to take a mandatory two-week vacation.', false);

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
        'Shopify''s Speaking Up Coaching',
        E'A Junior PM at Shopify has great insights in 1:1s but stays completely silent during large cross-functional reviews. \n\nHow can the manager best coach them to speak up?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'C',
        'Option C builds confidence incrementally by creating a safe, prepared space for the Junior PM to contribute. Option A uses threats, which increases anxiety and stifles performance. Option B puts them on the spot, potentially causing embarrassment and further retreat. Option D isolates them and removes the opportunity for growth.',
        ARRAY['confidence_building', 'career_development', 'mentorship']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell them: ''If you don''t speak up in the next meeting, you won''t get promoted.''', false),
    (v_q_id, 'B', 'Call on them unexpectedly during the next large meeting to force them to talk.', false),
    (v_q_id, 'C', 'Pre-align with them before the meeting to present one specific, small slide they are comfortable with.', true),
    (v_q_id, 'D', 'Stop inviting them to large meetings until they are more confident.', false);

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
        'Discord''s Effective Praise',
        E'A PM on Discord''s Trust & Safety team successfully launched a complex moderation tool on time. The manager wants to provide positive reinforcement.\n\nWhich approach is the most effective form of praise?',
        'foundational',
        'Discord',
        'Voice and text chat platform',
        'B',
        'Option B uses specific, behavior-based praise that reinforces exactly why the PM was successful. This ensures the PM knows what behaviors to repeat. Option A praises fixed traits, which can induce imposter syndrome. Option C relies solely on extrinsic motivation. Option D immediately pivots, minimizing the achievement.',
        ARRAY['performance_feedback', 'positive_reinforcement', 'communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '''You are the smartest PM on the team, great job.''', false),
    (v_q_id, 'B', '''Great job launching the tool. Your ability to align legal and engineering was the key to this success.''', true),
    (v_q_id, 'C', '''Thanks for getting the tool out. Here is a $50 gift card.''', false),
    (v_q_id, 'D', '''Good work on the launch. Now let''s focus on the next feature.''', false);

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
        'Tinder''s Coaching vs Mentoring',
        E'A seasoned PM at Tinder is asked to help a new PM. Sometimes the new PM needs to learn how to write a SQL query. Other times, they need help figuring out their 5-year career path.\n\nHow should the seasoned PM approach this?',
        'foundational',
        'Tinder',
        'Dating app',
        'C',
        'Option C correctly differentiates the modalities. SQL is a hard skill that requires teaching/training. Career pathing requires coaching (asking questions to uncover goals) and mentoring (sharing experience). Options A and B confuse coaching (non-directive inquiry) with teaching. Option D abdicates leadership responsibility.',
        ARRAY['mentorship', 'situational_leadership', 'skill_building']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use a mentoring approach for SQL, and a coaching approach for the 5-year career path.', false),
    (v_q_id, 'B', 'Use a coaching approach for SQL, and a mentoring approach for the 5-year career path.', false),
    (v_q_id, 'C', 'Use a teaching approach for SQL, and a coaching/mentoring approach for the career path.', true),
    (v_q_id, 'D', 'Direct them to engineering for SQL, and HR for their career path.', false);

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
        'Figma''s Underperformance Management',
        E'A Mid-level PM at Figma has missed their OKRs for two consecutive quarters. They blame engineering delays and shifting company priorities. The manager has provided SBI feedback, but nothing has changed.\n\nWhat is the most appropriate next step?',
        'intermediate',
        'Figma',
        'Collaborative design tool',
        'B',
        'Option B represents the correct escalation for sustained underperformance after feedback has failed. A PIP provides clarity on expectations and a fair chance to improve. Option A skips the formal HR process. Option C just moves the problem to another team. Option D penalizes engineering for the PM''s inability to manage scope.',
        ARRAY['handling_underperformance', 'performance_management', 'accountability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fire the PM immediately to maintain team standards.', false),
    (v_q_id, 'B', 'Place the PM on a structured PIP with clear, achievable 30-day milestones and weekly check-ins.', true),
    (v_q_id, 'C', 'Shift the PM to an internal tools team where OKRs are less strict.', false),
    (v_q_id, 'D', 'Tell engineering leadership to prioritize this PM''s tickets to help them succeed.', false);

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
        'LinkedIn''s Early Promotion Desire',
        E'A PM at LinkedIn with 1 year of experience demands a promotion to Senior PM, citing that they shipped three major features this year. Their manager knows they lack the strategic thinking required for the Senior level.\n\nHow should the manager handle this?',
        'intermediate',
        'LinkedIn',
        'Professional networking platform',
        'C',
        'Option C uses a transparent, objective framework (competency matrix) to show the PM exactly where they stand and what behaviors they need to demonstrate. It validates their wins while addressing the gap. Option A relies on tenure, not merit. Option B lowers the bar for the Senior title. Option D is unnecessarily combative.',
        ARRAY['career_pathing', 'performance_feedback', 'expectation_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell them ''no'' and explain that they need at least 3 years of tenure for a promotion.', false),
    (v_q_id, 'B', 'Agree to promote them to keep them motivated, but give them a smaller bonus.', false),
    (v_q_id, 'C', 'Review the Senior matrix together, acknowledge execution wins, and identify specific strategic gaps.', true),
    (v_q_id, 'D', 'Tell them their shipped features weren''t actually that impactful.', false);

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
        'Pinterest''s Situational Leadership',
        E'An expert PM at Pinterest (high competence) has recently seemed disengaged and bored (low motivation). \n\nUsing the Situational Leadership model, which management style should their leader adopt?',
        'intermediate',
        'Pinterest',
        'Visual discovery engine',
        'C',
        'Option C correctly applies the Supporting style (high relationship, low task behavior) for an individual who is highly capable but lacking motivation. Directing (Option A) and Coaching (Option B) are for low-competence individuals. Delegating (Option D) works for high-competence, high-motivation individuals, but will exacerbate disengagement here.',
        ARRAY['situational_leadership', 'motivation', 'team_leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Directing: Give them highly specific tasks with tight deadlines.', false),
    (v_q_id, 'B', 'Coaching: Teach them how to do their job better.', false),
    (v_q_id, 'C', 'Supporting: Engage in two-way dialogue to uncover what is causing disengagement and find a new challenge.', true),
    (v_q_id, 'D', 'Delegating: Leave them completely alone until they figure it out.', false);

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
        'Zoom''s Peer Feedback',
        E'During a 360-review cycle at Zoom, a PM receives feedback from an engineering manager that they are ''too dictatorial.'' The PM is defensive and says, ''I just have high standards.''\n\nHow should the PM''s manager coach them through this?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'C',
        'Option C separates intent from impact, guiding the PM to self-reflect on their behaviors without immediately validating their defensiveness. Option A damages cross-functional relationships. Option B is a cliché that shuts down conversation. Option D reflects a fundamental misunderstanding of the PM role.',
        ARRAY['peer_feedback', 'conflict_resolution', 'self_reflection']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Defend the PM and tell the engineering manager they need to be more resilient.', false),
    (v_q_id, 'B', 'Tell the PM: ''Perception is reality. If they think you are dictatorial, you are.''', false),
    (v_q_id, 'C', 'Ask the PM: ''What specific behaviors might have led the EM to this conclusion?''', true),
    (v_q_id, 'D', 'Ignore the feedback since product managers are supposed to dictate what to build.', false);

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
        'GitHub''s Failed Launch Coaching',
        E'A Mid-level PM at GitHub launched a new repository management feature that caused severe user backlash. The PM is demoralized and feels like a failure.\n\nWhat is the most effective coaching approach for the manager?',
        'intermediate',
        'GitHub',
        'Developer collaboration platform',
        'B',
        'Option B leverages a blameless post-mortem to turn a failure into a learning opportunity, removing personal guilt and focusing on process improvement. Option A is overly punitive and destroys psychological safety. Option C avoids accountability entirely. Option D creates learned helplessness.',
        ARRAY['failure_management', 'psychological_safety', 'mentorship']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Give them a formal warning and reassign their next launch to a Senior PM.', false),
    (v_q_id, 'B', 'Conduct a blameless post-mortem to analyze systemic failures and identify lessons learned together.', true),
    (v_q_id, 'C', 'Tell them to ignore the user backlash because users complain about every change.', false),
    (v_q_id, 'D', 'Take over their upcoming projects until they regain their confidence.', false);

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
        'Peloton''s Feature Attachment',
        E'A PM at Peloton has spent six months building a new social workout feature. Early beta data shows horrible retention, but the PM refuses to kill it, arguing they just need more time to polish the UI.\n\nHow should the manager coach them?',
        'intermediate',
        'Peloton',
        'Interactive fitness platform',
        'C',
        'Option C directly challenges the sunk cost fallacy using a data-driven framework (opportunity cost). It forces the PM to objectively weigh the failing feature against other high-impact work. Option A acts too unilaterally. Option B enables the fallacy. Option D attacks the person rather than the decision.',
        ARRAY['sunk_cost_fallacy', 'data_driven_decisions', 'coaching_frameworks']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Log into the admin console and kill the feature yourself to save engineering time.', false),
    (v_q_id, 'B', 'Give them one more month to polish the UI to see if retention improves.', false),
    (v_q_id, 'C', 'Ask them: ''If we took the engineering resources from this feature and applied them to our top backlog item, which yields higher ROI?''', true),
    (v_q_id, 'D', 'Tell them they are being too emotional and need to detach from their work.', false);

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
        'Canva''s Technical PM Empathy',
        E'A PM at Canva who transitioned from engineering is obsessed with system architecture and backend performance. However, they frequently ignore user research and UX friction.\n\nHow can the Group PM develop this PM''s user empathy?',
        'intermediate',
        'Canva',
        'Graphic design platform',
        'B',
        'Option B uses experiential learning. By forcing the PM to directly observe users struggling, it builds genuine empathy and highlights the importance of UX. Option A relies on reading, which rarely changes deep-seated mindsets. Option C reinforces their existing technical bias. Option D creates a silo.',
        ARRAY['user_empathy', 'skill_building', 'cross_functional_mgmt']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Assign them three books on UX design to read over the weekend.', false),
    (v_q_id, 'B', 'Require them to sit in on five user testing sessions and synthesize the UX friction points.', true),
    (v_q_id, 'C', 'Praise their technical skills and encourage them to focus exclusively on backend infrastructure.', false),
    (v_q_id, 'D', 'Tell the UX designer to handle all user-facing decisions without the PM.', false);

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
        'DoorDash''s XFN Conflict',
        E'A PM at DoorDash and the Operations Lead are in a heated conflict. The PM wants to batch orders to improve profitability, while Ops wants single deliveries to decrease wait times. The PM asks their manager to intervene and force Ops to comply.\n\nWhat is the best coaching response?',
        'intermediate',
        'DoorDash',
        'Food delivery platform',
        'A',
        'Option A coaches the PM on stakeholder management and understanding cross-functional incentives. It empowers the PM to solve the conflict themselves. Option B acts as a savior, which prevents the PM from developing conflict resolution skills. Option C tells the PM to surrender. Option D escalates prematurely.',
        ARRAY['conflict_resolution', 'stakeholder_management', 'cross_functional_mgmt']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask the PM: ''What are the Ops Lead''s primary KPIs, and how can we frame our proposal as a win-win?''', true),
    (v_q_id, 'B', 'Set up a meeting with the Ops Lead yourself and negotiate the compromise on the PM''s behalf.', false),
    (v_q_id, 'C', 'Tell the PM to drop the initiative since Ops is the primary stakeholder for delivery times.', false),
    (v_q_id, 'D', 'Escalate the issue to the VP of Product immediately.', false);

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
        'Airbnb''s Strategic Thinking',
        E'An execution-focused PM at Airbnb consistently delivers features on time but struggles to define a long-term vision. The manager wants to build the PM''s strategic thinking skills.\n\nWhich assignment is most appropriate?',
        'intermediate',
        'Airbnb',
        'Vacation rental marketplace',
        'B',
        'Option B provides an open-ended, ambiguous problem (''reduce host churn by 10%'') rather than a predefined solution, forcing the PM to analyze data, identify root causes, and build a strategic roadmap. Option A is pure execution. Option C is a task, not a strategy exercise. Option D is too broad and sets them up for failure.',
        ARRAY['strategic_thinking', 'career_development', 'skill_building']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask them to write detailed API documentation for the new payment gateway.', false),
    (v_q_id, 'B', 'Give them an ambiguous goal like ''reduce host churn by 10%'' and ask them to present a 6-month roadmap.', true),
    (v_q_id, 'C', 'Have them shadow the VP of Product for a week to see what strategy looks like.', false),
    (v_q_id, 'D', 'Tell them to invent a completely new business model for Airbnb by next month.', false);

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
        'Spotify''s PM as Bottleneck',
        E'A PM at Spotify insists on personally QAing every ticket and reviewing every PR description before engineering can merge. Velocity has plummeted.\n\nHow should the manager coach this PM?',
        'intermediate',
        'Spotify',
        'Music streaming platform',
        'C',
        'Option C directly addresses the trust and delegation issue by helping the PM implement guardrails (agreed-upon standards) instead of manual gates. Option A just tells them to work harder. Option B moves the problem to the EM. Option D ignores the root behavioral issue.',
        ARRAY['delegation', 'trust_building', 'process_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the PM they need to work weekends to clear the QA backlog.', false),
    (v_q_id, 'B', 'Tell the Engineering Manager to stop listening to the PM and just merge code.', false),
    (v_q_id, 'C', 'Coach the PM to establish clear ''Definition of Done'' criteria with the team so they don''t have to manually review everything.', true),
    (v_q_id, 'D', 'Praise the PM for their high attention to detail.', false);

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
        'Slack''s Overpromising PM',
        E'A PM on Slack''s enterprise team frequently promises unapproved features to the Sales team to help them close large deals. Engineering is frustrated by the constant context switching.\n\nWhat is the manager''s best coaching approach?',
        'intermediate',
        'Slack',
        'Workplace communication tool',
        'A',
        'Option A provides a practical framework (saying ''not right now'' instead of ''no'') to manage stakeholder expectations without blowing up deals, while protecting engineering bandwidth. Option B ruins the relationship with Sales. Option C validates bad behavior. Option D is a band-aid solution.',
        ARRAY['stakeholder_management', 'expectation_management', 'sales_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Roleplay scenarios with the PM on how to say ''not right now'' and share the existing roadmap instead of making new promises.', true),
    (v_q_id, 'B', 'Tell Sales leadership that they are no longer allowed to speak to product managers.', false),
    (v_q_id, 'C', 'Tell engineering they just need to be more agile to support enterprise deals.', false),
    (v_q_id, 'D', 'Revoke the PM''s access to Salesforce so they can''t see the deals.', false);

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
        'Shopify''s Eng to PM Transition',
        E'A recently transitioned PM (former engineer) at Shopify is struggling. During sprint planning, they spend 45 minutes debating database schema with the tech lead instead of explaining the user problem.\n\nHow should the manager correct this?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'B',
        'Option B clearly defines the boundary between Product (the ''what'' and ''why'') and Engineering (the ''how''), which is the most common hurdle for former engineers. Option A restricts communication too heavily. Option C encourages bad PM habits. Option D is an extreme overreaction.',
        ARRAY['role_clarity', 'ic_to_manager', 'cross_functional_mgmt']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Forbid the PM from talking about technology during any meetings.', false),
    (v_q_id, 'B', 'Explain the boundary: ''Product owns the problem (the what and why), Engineering owns the solution (the how). Focus on the user impact.''', true),
    (v_q_id, 'C', 'Tell the tech lead to let the PM design the database schema since they have an engineering background.', false),
    (v_q_id, 'D', 'Transition the PM back to an engineering role immediately.', false);

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
        'Stripe''s Autonomy vs Intervention',
        E'A Group PM at Stripe notices a direct report is about to launch an A/B test with a slightly flawed hypothesis. The flaw won''t break the product, but the test will likely fail to reach statistical significance.\n\nWhat is the best coaching decision?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'C',
        'Option C leverages the concept of ''allowing safe failures.'' By letting the PM run the test and review the results together, the manager provides a powerful experiential learning moment. Swooping in (Option A) prevents learning. Option B is passive-aggressive. Option D removes autonomy entirely.',
        ARRAY['situational_leadership', 'delegation', 'failure_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately intervene and rewrite the hypothesis for them before the test launches.', false),
    (v_q_id, 'B', 'Let the test run, but document the failure in their performance review.', false),
    (v_q_id, 'C', 'Let the test run, and use the post-test analysis as a coaching moment to discuss statistical significance and hypothesis design.', true),
    (v_q_id, 'D', 'Require the PM to get VP approval for all future A/B tests.', false);

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
        'Notion''s 90-day Onboarding',
        E'A manager is designing a 30-60-90 day onboarding plan for a new Senior PM at Notion. \n\nWhich structure best sets the PM up for long-term success?',
        'intermediate',
        'Notion',
        'Productivity and note-taking workspace',
        'A',
        'Option A follows best practices for senior hires: absorb context and build relationships first (30), take on small wins (60), and then drive strategy (90). Option B rushes execution before context is built. Option C delays impact too long. Option D is an unstructured approach that leads to failure.',
        ARRAY['onboarding', 'career_pathing', 'team_leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '30 days: Listen, learn, and build relationships. 60 days: Ship a small, well-defined feature. 90 days: Propose a new strategic initiative.', true),
    (v_q_id, 'B', '30 days: Ship a major feature. 60 days: Reorganize the engineering pod. 90 days: Rewrite the annual roadmap.', false),
    (v_q_id, 'C', '30 days: Shadow engineers. 60 days: Shadow marketing. 90 days: Shadow customer support.', false),
    (v_q_id, 'D', 'Provide no structure and let the Senior PM figure it out themselves.', false);

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
        'Uber''s Difficult EM',
        E'A PM at Uber is struggling with an Engineering Manager (EM) who constantly dismisses product requirements as ''unnecessary.'' The PM is frustrated and wants to escalate.\n\nHow should the manager coach the PM?',
        'intermediate',
        'Uber',
        'Ride-hailing platform',
        'C',
        'Option C coaches the PM on lateral leadership and empathy. By understanding the EM''s pressures (e.g., tech debt, deadlines), the PM can reframe their requests. Option A damages the relationship. Option B abdicates PM responsibility. Option D is an escalation that makes the PM look incapable of handling conflict.',
        ARRAY['conflict_resolution', 'empathy', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the PM to document every time the EM says no and send it to HR.', false),
    (v_q_id, 'B', 'Advise the PM to just build whatever the EM agrees to, to keep the peace.', false),
    (v_q_id, 'C', 'Coach the PM to schedule a 1:1 to understand the EM''s underlying pressures and constraints before pushing back.', true),
    (v_q_id, 'D', 'Escalate immediately to the VP of Engineering.', false);

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
        'Netflix''s Psychological Safety',
        E'Following a highly publicized bug in the recommendation algorithm, the Netflix PM team has become risk-averse, only proposing trivial, safe features.\n\nHow can the Product Director coach the team to restore psychological safety?',
        'intermediate',
        'Netflix',
        'Video streaming platform',
        'B',
        'Option B actively models vulnerability, which is the fastest way a leader can rebuild psychological safety. By sharing their own failures, the leader proves that risk-taking is safe. Option A is just rhetoric. Option C increases fear. Option D changes the process without addressing the underlying fear.',
        ARRAY['psychological_safety', 'team_culture', 'leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send an email telling the team that risk-taking is a core company value.', false),
    (v_q_id, 'B', 'Share a story in an all-hands meeting about a massive failure the Director personally caused, and what was learned.', true),
    (v_q_id, 'C', 'Threaten to lower performance ratings if PMs don''t propose bigger ideas.', false),
    (v_q_id, 'D', 'Implement a mandatory ''innovative idea'' quota for every sprint.', false);

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
        'Figma''s Imposter Syndrome',
        E'A high-performing PM at Figma confides in their manager that they feel like a fraud and are terrified the team will realize they ''don''t know what they are doing.''\n\nWhat is the most effective coaching response?',
        'intermediate',
        'Figma',
        'Collaborative design tool',
        'C',
        'Option C counters the emotional distortion of imposter syndrome with objective, documented evidence of success. Option A is dismissive of their feelings. Option B feeds the anxiety by agreeing with the premise that they are deficient. Option D is an extreme, unhelpful reaction.',
        ARRAY['imposter_syndrome', 'mentorship', 'empathy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '''Don''t worry, everyone feels that way sometimes. Just ignore it.''', false),
    (v_q_id, 'B', '''If you feel that way, you should probably take a course on product management.''', false),
    (v_q_id, 'C', 'Review their recent wins together and anchor their self-perception to objective, data-driven impact they delivered.', true),
    (v_q_id, 'D', 'Suggest they take a leave of absence for mental health reasons.', false);

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
        'LinkedIn''s Executive Presence',
        E'A Senior PM at LinkedIn has brilliant strategic ideas but rambles nervously during executive reviews, causing the VP to cut them off. \n\nHow should their manager coach them?',
        'intermediate',
        'LinkedIn',
        'Professional networking platform',
        'B',
        'Option B provides a concrete, actionable framework (Minto Pyramid / BLUF) to structure communication for executives. Option A tells them *what* to do but not *how*. Option C protects them but prevents growth. Option D shifts the blame to the VP.',
        ARRAY['communication', 'executive_presence', 'career_development']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell them to ''just be more confident'' in the next meeting.', false),
    (v_q_id, 'B', 'Coach them on the ''Bottom Line Up Front'' (BLUF) framework and do mock presentations before the next review.', true),
    (v_q_id, 'C', 'Take over presenting their slides for them from now on.', false),
    (v_q_id, 'D', 'Tell them the VP is just impatient and not to worry about it.', false);

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
        'Discord''s Toxic High Performer',
        E'A Principal PM at Discord consistently delivers 3x the revenue impact of their peers but routinely belittles designers and engineers in public channels. Several engineers have threatened to quit.\n\nHow should the VP of Product handle this?',
        'advanced',
        'Discord',
        'Voice and text chat platform',
        'B',
        'Option B addresses the ''brilliant jerk'' problem. In healthy tech orgs, behavioral standards are just as important as revenue impact. Tolerating toxicity destroys overall team velocity and retention. Option A prioritizes short-term revenue over long-term health. Option C gives them an excuse. Option D avoids the conflict.',
        ARRAY['handling_toxicity', 'performance_management', 'team_culture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore the behavior because their revenue impact is too valuable to lose.', false),
    (v_q_id, 'B', 'Deliver strict SBI feedback on the behavioral issues, making it clear that continued toxicity will result in termination regardless of impact.', true),
    (v_q_id, 'C', 'Tell the engineers that the PM is just passionate and they need thicker skin.', false),
    (v_q_id, 'D', 'Move the PM to a standalone strategy role with no team interaction.', false);

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
        'Pinterest''s Calibrating Scope',
        E'During performance calibration at Pinterest, Manager A argues for promoting a PM who launched a flashy AI feature. Manager B argues for promoting a PM who quietly refactored the data pipeline, saving $2M/year. \n\nHow should the Director coach the managers to calibrate fairly?',
        'advanced',
        'Pinterest',
        'Visual discovery engine',
        'C',
        'Option C ensures fairness by abstracting away the ''flashiness'' of the work and evaluating both PMs against a standardized matrix of complexity, autonomy, and business impact. Option A biases toward visibility over value. Option B creates arbitrary quotas. Option D punishes both candidates due to management indecision.',
        ARRAY['performance_calibration', 'leadership', 'fairness']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Promote the AI PM because AI is the company''s current strategic priority.', false),
    (v_q_id, 'B', 'Tell them neither gets promoted unless they both agree on one candidate.', false),
    (v_q_id, 'C', 'Force both managers to map their PMs'' work against the standard competency matrix to evaluate impact and complexity objectively.', true),
    (v_q_id, 'D', 'Promote neither to avoid showing favoritism.', false);

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
        'Zoom''s Role Ambiguity',
        E'After a reorg at Zoom, two Senior PMs find their product areas overlapping. They are stepping on each other''s toes and escalating minor disputes to the Director.\n\nHow should the Director resolve this?',
        'advanced',
        'Zoom',
        'Video conferencing platform',
        'C',
        'Option C forces the two Senior PMs to act like leaders by collaboratively defining their own boundaries (RACI matrix). This builds their conflict resolution skills. Option A dictates the solution, missing a coaching opportunity. Option B creates an unhealthy gladiator dynamic. Option D ignores the problem.',
        ARRAY['role_clarity', 'conflict_resolution', 'organizational_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write a detailed document clearly defining who owns what and email it to them.', false),
    (v_q_id, 'B', 'Tell them whoever ships the next feature faster gets to own the overlapping area.', false),
    (v_q_id, 'C', 'Require them to collaboratively draft a RACI matrix defining their boundaries and present it to you for approval.', true),
    (v_q_id, 'D', 'Tell them to figure it out themselves and stop bothering you.', false);

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
        'GitHub''s Succession Planning',
        E'A Director of Product at GitHub is planning to transition to a VP role in 12 months. They need to prepare one of their Group PMs to take over their role.\n\nWhat is the best approach to succession planning?',
        'advanced',
        'GitHub',
        'Developer collaboration platform',
        'B',
        'Option B is the correct approach to succession planning. It involves identifying candidates early and giving them ''stretch assignments'' (acting at the next level) to safely test and build their readiness. Option A is a recipe for failure due to lack of prep. Option C creates a toxic, highly competitive environment. Option D delegates leadership to HR.',
        ARRAY['succession_planning', 'career_development', 'leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Wait until month 11, then pick the favorite Group PM and promote them.', false),
    (v_q_id, 'B', 'Identify top candidates now, assign them stretch projects representing Director-level scope, and coach them through the execution.', true),
    (v_q_id, 'C', 'Tell all Group PMs they are competing for the role to see who works the hardest.', false),
    (v_q_id, 'D', 'Ask HR to handle the succession planning process.', false);

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
        'Peloton''s Resistant Seasoned PM',
        E'A highly experienced PM hired from Amazon refuses to use Peloton''s standard PRD templates, claiming ''at Amazon we did 6-pagers, which are vastly superior.'' Their refusal is creating friction with engineering.\n\nHow should the manager handle this?',
        'advanced',
        'Peloton',
        'Interactive fitness platform',
        'C',
        'Option C acknowledges their experience while focusing on the underlying goal (effective communication with engineering). It opens a dialogue rather than forcing compliance or fully capitulating. Option A forces rigid compliance, which alienates senior talent. Option B breaks team consistency entirely. Option D is an overreaction.',
        ARRAY['change_management', 'conflict_resolution', 'process_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell them: ''You are at Peloton now, use our templates or face disciplinary action.''', false),
    (v_q_id, 'B', 'Allow them to use 6-pagers, and tell engineering they just need to adapt.', false),
    (v_q_id, 'C', 'Discuss the ''why'' behind Peloton''s templates, identify what they believe is missing, and align on a format that serves engineering effectively.', true),
    (v_q_id, 'D', 'Fire them for lack of culture fit.', false);

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
        'DoorDash''s Misaligned Career Goals',
        E'A top-performing PM at DoorDash wants to transition into an AI/ML product role. However, the company currently has zero AI initiatives, and the PM''s skills are desperately needed on core growth.\n\nHow should the manager coach them?',
        'advanced',
        'DoorDash',
        'Food delivery platform',
        'B',
        'Option B is honest and balances the employee''s career goals with business reality. Finding adjacent opportunities keeps them engaged without making false promises. Option A makes a promise the company cannot keep, destroying trust. Option C is dismissive. Option D encourages top talent to leave immediately.',
        ARRAY['career_pathing', 'retention', 'expectation_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Promise them that DoorDash will start an AI team next quarter to keep them happy.', false),
    (v_q_id, 'B', 'Be transparent about business needs, but try to find small ways to incorporate ML models into their current growth experiments.', true),
    (v_q_id, 'C', 'Tell them AI is just a fad and they should stick to growth.', false),
    (v_q_id, 'D', 'Tell them they should probably start interviewing at OpenAI.', false);

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
        'Canva''s Coaching the Coaches',
        E'A Director of Product at Canva notices that one of their Group PMs is essentially acting as a ''super-IC,'' micromanaging their direct reports and giving them exact solutions instead of coaching them.\n\nHow should the Director coach the Group PM?',
        'advanced',
        'Canva',
        'Graphic design platform',
        'C',
        'Option C teaches the manager ''how to fish.'' By providing a framework (Socratic questioning) and requiring them to practice it, the Director is coaching the coach. Option A tells them what to do without teaching them how. Option B is passive. Option D publicly undermines the Group PM''s authority.',
        ARRAY['coaching_the_coach', 'leadership_development', 'delegation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the Group PM to stop micromanaging immediately.', false),
    (v_q_id, 'B', 'Send the Group PM a book on effective delegation.', false),
    (v_q_id, 'C', 'Roleplay 1:1 scenarios, teaching the Group PM how to use open-ended Socratic questions to guide their reports to the answer.', true),
    (v_q_id, 'D', 'Skip-level to the direct reports and tell them to ignore the Group PM''s micro-tasks.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Coaching & Mentoring';
END $$;
