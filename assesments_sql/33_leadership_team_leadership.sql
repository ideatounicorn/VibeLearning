-- ============================================
-- ASSESSMENT: Team Leadership
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
    WHERE slug = 'team-leadership';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug team-leadership not found. Run the seed data first.';
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
        'Spotify''s Squad Autonomy',
        'A PM at Spotify takes over a newly formed squad. The engineers are used to their previous PM telling them exactly what features to build and how they should look. The new PM wants to align with Spotify''s culture of highly autonomous squads.',
        'foundational',
        'Spotify',
        'Music streaming platform known for its agile ''squad'' model',
        'A',
        'Option A is correct because true autonomy requires strong alignment; the PM defines the ''what'' and ''why'' (metrics, problems), while the team defines the ''how'' (solutions). Option B describes anarchy, not autonomy, as the team needs business direction. Option C reinforces a ''feature factory'' mindset. Option D abdicates the PM''s core responsibility of product direction.',
        ARRAY['autonomy', 'squad_model', 'alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Provide the team with the target business metrics and user problems, but let them figure out the solutions.', true),
    (v_q_id, 'B', 'Let the team decide what business metrics to focus on and how to improve them to maximize total autonomy.', false),
    (v_q_id, 'C', 'Continue telling them what to build until they prove they can deliver consistently.', false),
    (v_q_id, 'D', 'Wait for the Engineering Manager to set the product direction so the PM can focus on external stakeholders.', false);

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
        'Netflix''s Context Not Control',
        'A PM at Netflix notices that backend engineers are making technical architecture decisions that do not align with the broader strategic goals of the streaming platform.',
        'foundational',
        'Netflix',
        'Global streaming service known for its ''Context, Not Control'' leadership philosophy',
        'B',
        'Option B is correct. Netflix''s culture emphasizes ''Context, Not Control''. If highly capable people are making bad decisions, it usually means they lack the right business context. Option A introduces unnecessary bureaucracy. Option C and D resort to micro-management, which stifles innovation and violates the principle of empowering talent.',
        ARRAY['culture', 'alignment', 'communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Implement a mandatory PRD approval process for all technical decisions.', false),
    (v_q_id, 'B', 'Share more business context, metrics, and long-term strategy during team meetings.', true),
    (v_q_id, 'C', 'Tell the Engineering Manager to restrict engineering autonomy and tightly manage tasks.', false),
    (v_q_id, 'D', 'Take over the sprint planning meetings to assign specific technical tasks to ensure compliance.', false);

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
        'Airbnb''s Triad Alignment',
        'A PM at Airbnb forms a new triad with an Engineering Manager (EM) and a Design Lead. The triad is moving slowly because they constantly disagree on priorities and scope.',
        'foundational',
        'Airbnb',
        'Design-led hospitality marketplace',
        'B',
        'Option B is correct. A strong triad requires explicit alignment on how they work together, make decisions, and share goals. Option A breaks trust and relies on authority rather than influence. Option C is a popularity contest that undermines leadership. Option D might speed things up temporarily but will destroy cross-functional trust and collaboration over time.',
        ARRAY['triad', 'cross_functional', 'alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Escalate to the VP of Product to establish the PM''s absolute authority.', false),
    (v_q_id, 'B', 'Establish a regular triad sync to align on shared goals, decision rights, and working agreements.', true),
    (v_q_id, 'C', 'Ask the engineers to vote on which leader they prefer to follow.', false),
    (v_q_id, 'D', 'The PM should make the final call on all decisions immediately to unblock the team.', false);

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
        'Stripe''s High Standards',
        'A PM at Stripe is reviewing a new API feature before launch. It functions correctly but lacks the meticulous documentation and polish Stripe is known for. The team is exhausted from a long sprint.',
        'foundational',
        'Stripe',
        'Fintech platform renowned for developer experience and high quality',
        'B',
        'Option B is correct. PMs must uphold the product quality bar while maintaining empathy. Acknowledging hard work while holding the line on standards builds long-term respect. Option A damages the brand''s reputation for quality. Option C creates a toxic, blame-shifting culture. Option D prevents the team from learning and scales poorly.',
        ARRAY['quality', 'standards', 'motivation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch it anyway to boost team morale, then fix the polish issues quietly later.', false),
    (v_q_id, 'B', 'Acknowledge their hard work, explain the gap in quality using specific examples, and delay the launch to meet the bar.', true),
    (v_q_id, 'C', 'Blame the QA team for not catching the polish issues earlier in the cycle.', false),
    (v_q_id, 'D', 'Write the documentation and fix the code themselves over the weekend so the team can rest.', false);

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
        'Slack''s Async Norms',
        'A PM at Slack leads a fully remote team distributed across four different time zones. Communication is fragmented, people are missing context, and velocity is dropping.',
        'foundational',
        'Slack',
        'Workplace communication platform',
        'C',
        'Option C is correct. Distributed teams require explicit communication norms to function effectively without burning out. Option A is exhausting and impractical for distributed teams. Option B creates an unhealthy ''always-on'' culture that destroys focus. Option D leads to silos and total loss of alignment.',
        ARRAY['remote_work', 'communication', 'norms']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Schedule a daily 2-hour synchronous sync-up that overlaps all time zones.', false),
    (v_q_id, 'B', 'Start reprimanding team members who do not reply to messages within 5 minutes.', false),
    (v_q_id, 'C', 'Collaborate with the team to establish documented norms for when to use async channels versus synchronous meetings.', true),
    (v_q_id, 'D', 'Let everyone work completely independently without requiring any shared updates.', false);

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
        'Figma''s Psychological Safety',
        'A PM at Figma notices during sprint retrospectives that no one brings up mistakes, process failures, or missed estimates. Everything is always described as ''fine.''',
        'foundational',
        'Figma',
        'Collaborative design platform',
        'B',
        'Option B is correct. Psychological safety starts at the top. When leaders model vulnerability by admitting mistakes, it creates a safe environment for others to do the same. Option A forces participation, which causes resentment, not safety. Option C creates a culture of backstabbing. Option D treats the symptom, not the underlying lack of trust.',
        ARRAY['psychological_safety', 'culture', 'agile_leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mandate that everyone must share at least one mistake per retro.', false),
    (v_q_id, 'B', 'Openly share a recent mistake the PM made and what they learned from it to model vulnerability.', true),
    (v_q_id, 'C', 'Privately message individuals asking them to report on other people''s mistakes.', false),
    (v_q_id, 'D', 'Cancel retrospectives since they aren''t generating actionable value.', false);

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
        'GitHub''s Distributed Culture',
        'A new engineer joins a globally distributed GitHub team but struggles to gain context because all technical and product discussions happen in private direct messages (DMs).',
        'foundational',
        'GitHub',
        'Developer platform with a strong async, remote-first culture',
        'B',
        'Option B is correct. Transparency is critical for distributed teams. Moving conversations to public channels and documenting decisions ensures everyone, especially new hires, has equal access to context. Option A puts the burden on the new hire. Option C does not scale and makes the PM a bottleneck. Option D is an extreme, unenforceable overcorrection.',
        ARRAY['transparency', 'remote_work', 'onboarding']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the new engineer to be more aggressive in asking questions in DMs.', false),
    (v_q_id, 'B', 'Shift team discussions to public channels and document decisions in a centralized wiki.', true),
    (v_q_id, 'C', 'Schedule a 1:1 with the new engineer every day to manually feed them information.', false),
    (v_q_id, 'D', 'Ban the use of direct messages entirely across the team.', false);

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
        'Uber''s Bias for Action',
        'An Uber team is stuck in analysis paralysis regarding a new surge pricing experiment. They are debating edge cases, delaying the launch by weeks.',
        'foundational',
        'Uber',
        'Ride-hailing network known for execution speed',
        'B',
        'Option B is correct. PMs must drive velocity by distinguishing between one-way (irreversible) and two-way (reversible) doors. A small experiment is a two-way door that breaks analysis paralysis. Option A seeks impossible certainty. Option C avoids the PM''s responsibility to unblock the team. Option D Abandons a potentially high-impact project just because it''s hard.',
        ARRAY['execution', 'velocity', 'decision_making']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Wait until the data scientists are 100% confident in the projection.', false),
    (v_q_id, 'B', 'Remind the team that decisions are reversible and propose a small-scale rollout to gather real data.', true),
    (v_q_id, 'C', 'Escalate to the VP of Product to make the final decision for the team.', false),
    (v_q_id, 'D', 'Change the project to something easier to measure.', false);

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
        'Notion''s New Team Member',
        'A PM at Notion welcomes a new Product Designer to their squad. The PM wants to ensure the designer integrates well and becomes productive quickly.',
        'foundational',
        'Notion',
        'Productivity and workspace tool',
        'C',
        'Option C is correct. Effective onboarding involves providing context (vision, stakeholders) and building confidence through early, achievable success (a quick win). Option A and B are trial-by-fire methods that often lead to burnout and failure. Option D ignores the PM''s role in building triad cohesion and shared team context.',
        ARRAY['onboarding', 'triad', 'culture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Provide product requirements and let them figure out the rest to test their initiative.', false),
    (v_q_id, 'B', 'Assign them the most difficult strategic task immediately to gauge their skill level.', false),
    (v_q_id, 'C', 'Share the product vision, introduce them to key stakeholders, and give them a well-scoped ''quick win'' project.', true),
    (v_q_id, 'D', 'Tell the Design Manager to handle everything; PMs shouldn''t be involved in onboarding designers.', false);

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
        'DoorDash''s Accountability',
        'A DoorDash squad misses their sprint commitment for the third time in a row due to consistent underestimation of task complexity.',
        'foundational',
        'DoorDash',
        'Food delivery logistics platform',
        'B',
        'Option B is correct. True accountability is about fixing the system, not punishing the people. A blameless retro identifies root causes without destroying psychological safety. Option A breeds fear and hiding of information. Option C avoids solving the estimation problem. Option D is an arbitrary hack that destroys the validity of the team''s velocity metrics.',
        ARRAY['accountability', 'agile_leadership', 'process']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Publicly reprimand the team in the sprint review to enforce accountability.', false),
    (v_q_id, 'B', 'Partner with the EM to facilitate a blameless retro focused on identifying estimation bottlenecks.', true),
    (v_q_id, 'C', 'Stop doing sprint planning entirely and shift the team to Kanban.', false),
    (v_q_id, 'D', 'Double all story point estimates for the next sprint to ensure they meet their commitment.', false);

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
        'Spotify''s Alignment Matrix',
        'A PM at Spotify wants their squad to experiment with a new onboarding flow. The squad feels unmotivated, complains about being a ''feature factory,'' and just asks the PM for tickets.',
        'intermediate',
        'Spotify',
        'Music streaming platform',
        'B',
        'Option B is correct. To move from a ''feature factory'' to an empowered product team, the PM must provide high alignment (the problem/metric) and high autonomy (the solution). Option A still dictates the solution, keeping them in feature factory mode. Option C lacks alignment with company goals. Option D is micromanagement that decreases autonomy.',
        ARRAY['empowerment', 'autonomy', 'motivation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Give them a detailed spec (high alignment) and tell them to build it however they want (high autonomy).', false),
    (v_q_id, 'B', 'Provide a clear business problem and metric to move, then ask the team to ideate solutions together.', true),
    (v_q_id, 'C', 'Let the team decide what business metric to focus on and how to improve it.', false),
    (v_q_id, 'D', 'Implement strict daily standups to align on daily tasks and monitor their output.', false);

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
        'Netflix''s Managing Underperformance',
        'A PM at Netflix relies on a backend engineer who consistently delivers late, buggy code, blocking the product roadmap. The engineer reports to an Engineering Manager (EM).',
        'intermediate',
        'Netflix',
        'High-performance culture streaming service',
        'B',
        'Option B is correct. PMs do not have direct HR authority over engineers but must manage performance via influence. Providing direct feedback and partnering with the EM addresses the issue professionally. Option A is impossible; PMs aren''t HR managers. Option C creates hidden resentment and masks the problem. Option D sacrifices the product''s success to avoid difficult conversations.',
        ARRAY['performance_management', 'cross_functional', 'feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fire the engineer directly, as PMs are the ''CEOs of the product.''', false),
    (v_q_id, 'B', 'Provide specific, objective feedback to the engineer and discuss the roadmap impact privately with the EM.', true),
    (v_q_id, 'C', 'Work around the engineer by secretly assigning their critical tasks to other team members.', false),
    (v_q_id, 'D', 'Adjust the roadmap indefinitely to accommodate the engineer''s slow pace to avoid conflict.', false);

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
        'Shopify''s Shielding the Team',
        'At Shopify, executive leadership is rapidly changing strategic priorities week-to-week, causing whiplash. The engineering team is frustrated by the constant context switching.',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'B',
        'Option B is correct. A key leadership function for PMs is acting as an ''umbrella''—shielding the team from executive churn while synthesizing true strategic pivots. Option A causes chaos and burnout. Option C destroys trust in the company''s leadership and breeds toxicity. Option D is insubordinate and guarantees the team builds the wrong thing.',
        ARRAY['leadership', 'focus', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pass down every leadership idea immediately so the team is fully transparently in the loop.', false),
    (v_q_id, 'B', 'Buffer the noise by synthesizing leadership''s goals and only translating validated, finalized priorities to the team.', true),
    (v_q_id, 'C', 'Complain about leadership to the team to build camaraderie and show empathy.', false),
    (v_q_id, 'D', 'Ignore leadership entirely and stick to the original roadmap regardless of business changes.', false);

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
        'Atlassian''s Team Health',
        'An Atlassian team''s health monitor shows ''red'' on ''Shared Understanding.'' Engineers report they don''t understand why they are building the features on the roadmap.',
        'intermediate',
        'Atlassian',
        'Enterprise software company that creates Jira and Confluence',
        'B',
        'Option B is correct. Shared understanding is built through shared context. Involving engineers in discovery gives them firsthand exposure to user pain points, bridging the gap between strategy and execution. Option A just creates more documentation without solving the context gap. Option C is passive and often ignored. Option D abdicates the PM''s core responsibility of communicating vision.',
        ARRAY['shared_understanding', 'empowerment', 'discovery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write longer, more detailed Jira tickets that explicitly spell out the business requirements.', false),
    (v_q_id, 'B', 'Involve engineers earlier in the discovery process, including customer interviews and strategy reviews.', true),
    (v_q_id, 'C', 'Send a weekly newsletter with business metrics and mandate that the team read it.', false),
    (v_q_id, 'D', 'Make the Engineering Manager responsible for explaining the ''why'' to the team.', false);

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
        'Discord''s Post-Launch Burnout',
        'A Discord team successfully launched a massive voice feature after a grueling 3-month push, but team morale is low and they are severely burned out.',
        'intermediate',
        'Discord',
        'Voice, video, and text communication service',
        'B',
        'Option B is correct. Managing team energy is a core leadership skill. A cool-down period allows the team to recover, fix corner-cutting done during the crunch, and celebrate, preventing long-term churn. Option A guarantees severe burnout and attrition. Option C is unrealistic for a business. Option D forces context switching, which is mentally taxing, not restful.',
        ARRAY['burnout', 'motivation', 'velocity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately start the next major feature to maintain momentum and capitalize on the success.', false),
    (v_q_id, 'B', 'Plan a ''cool down'' sprint focused on tech debt, bug fixes, and team celebrations.', true),
    (v_q_id, 'C', 'Give everyone a month off and halt all product development entirely.', false),
    (v_q_id, 'D', 'Shift the team to a completely different product area for variety.', false);

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
        'Airbnb''s Design/Eng Trade-offs',
        'At Airbnb, the Lead Designer wants a complex custom animation that will take 4 weeks. The Lead Engineer argues a standard native component takes 2 days and is more accessible.',
        'intermediate',
        'Airbnb',
        'Design-led hospitality marketplace',
        'C',
        'Option C is correct. The PM''s role in the triad is to act as the objective facilitator, grounding trade-off discussions in user value, business goals, and ROI. Option A and B show bias and undermine one side of the triad. Option D is an immense waste of engineering resources just to avoid making a decision.',
        ARRAY['triad', 'trade_offs', 'conflict_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Side with the engineer because development speed is always the most important metric.', false),
    (v_q_id, 'B', 'Side with the designer because Airbnb is fundamentally a design-led culture.', false),
    (v_q_id, 'C', 'Facilitate a discussion on the user impact versus development cost, referring back to the project''s core goals.', true),
    (v_q_id, 'D', 'Tell them to build both versions and run an A/B test to see which is better.', false);

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
        'Stripe''s Servant Leadership',
        'A PM at Stripe sees that their billing engineers are bogged down responding to customer support tickets about complex API integrations, severely slowing down feature work.',
        'intermediate',
        'Stripe',
        'Developer-centric payment infrastructure',
        'B',
        'Option B is correct. Servant leadership means removing blockers. The PM dives in to understand the user friction, takes the immediate hit to protect the team, and solves the systemic issue (self-serve tooling). Option A leads to a terrible customer experience. Option C patches the symptom without fixing the underlying product usability issue. Option D blames the victim.',
        ARRAY['servant_leadership', 'blockers', 'velocity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the engineers to ignore the support tickets so they can focus on coding.', false),
    (v_q_id, 'B', 'Analyze the tickets, identify root causes, advocate for self-serve tooling, and take on triaging the tickets temporarily.', true),
    (v_q_id, 'C', 'Hire more customer support agents to handle the technical queries.', false),
    (v_q_id, 'D', 'Escalate the engineers'' low velocity to the VP of Engineering.', false);

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
        'Figma''s Fostering Ownership',
        'A PM at Figma wants engineers to feel more ownership over the product''s success, rather than just feeling responsible for shipping code on time.',
        'intermediate',
        'Figma',
        'Collaborative design platform',
        'B',
        'Option B is correct. Tying engineers to the ultimate business outcome (metrics) and giving them public recognition fosters deep ownership and pride in the product. Option A forces engineers to do PM work, which isn''t their core competency. Option C is punitive. Option D is an abdication of the PM role.',
        ARRAY['ownership', 'motivation', 'culture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Require engineers to write the Product Requirements Documents (PRDs).', false),
    (v_q_id, 'B', 'Have engineers co-present new features and their post-launch metrics at company all-hands.', true),
    (v_q_id, 'C', 'Make engineers responsible for meeting customer support SLAs.', false),
    (v_q_id, 'D', 'Let engineers choose the product strategy independently without PM input.', false);

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
        'Zoom''s Incident Leadership',
        'Zoom experiences a major outage affecting millions of users. The team is panicking, and some engineers are defensively pointing fingers at each other in Slack.',
        'intermediate',
        'Zoom',
        'Video communications platform requiring extreme reliability',
        'A',
        'Option A is correct. During an incident, the PM''s leadership role is to de-escalate panic, stop blame, and ruthlessly prioritize mitigation. Blameless post-mortems happen after the fire is out. Option B increases panic and destroys psychological safety. Option C abandons the team during a crisis. Option D is important but secondary to helping the team focus on recovery.',
        ARRAY['crisis_management', 'psychological_safety', 'prioritization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Focus the team strictly on mitigating user impact first, saving the root cause analysis for a blameless retro later.', true),
    (v_q_id, 'B', 'Immediately identify exactly who pushed the bad code so they can be removed from the critical path.', false),
    (v_q_id, 'C', 'Step back entirely; technical incidents are strictly an Engineering Manager''s domain.', false),
    (v_q_id, 'D', 'Start drafting customer apology emails and ignore the engineering chatter.', false);

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
        'Slack''s Transition to Async',
        'A PM at Slack wants to reduce meeting fatigue to increase deep work time for the engineering team.',
        'intermediate',
        'Slack',
        'Workplace communication platform',
        'C',
        'Option C is correct. Daily status updates are low-complexity, informational tasks that are perfectly suited for asynchronous communication (e.g., via a Slack bot). Options A, B, and D require high bandwidth, nuance, and emotional intelligence, making them terrible candidates for async communication and highly necessary to keep synchronous.',
        ARRAY['async_work', 'communication', 'efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A sprint retrospective dealing with high team conflict.', false),
    (v_q_id, 'B', 'A complex architectural whiteboard session.', false),
    (v_q_id, 'C', 'The daily status standup.', true),
    (v_q_id, 'D', 'A 1:1 focused on career development.', false);

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
        'DoorDash''s Over-reliance on PM',
        'A DoorDash squad refuses to make any minor UX or technical decision without the PM''s explicit approval. This is creating a bottleneck and slowing down development.',
        'intermediate',
        'DoorDash',
        'Fast-paced logistics and delivery platform',
        'B',
        'Option B is correct. When teams are afraid to decide, they lack explicit permission and boundaries. A decision matrix (like DACI or RAPID) clarifies autonomy, empowering the team while keeping the PM out of the weeds. Option A burns the PM out. Option C is passive-aggressive and damages trust. Option D shifts the bottleneck without solving the team''s lack of empowerment.',
        ARRAY['empowerment', 'decision_making', 'delegation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Work longer hours to approve things faster so the team isn''t blocked.', false),
    (v_q_id, 'B', 'Create a ''decision matrix'' that explicitly outlines which types of decisions the team is empowered to make independently.', true),
    (v_q_id, 'C', 'Refuse to answer any questions to force them to decide on their own.', false),
    (v_q_id, 'D', 'Delegate all product decisions to the Engineering Manager.', false);

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
        'Robinhood''s Re-org',
        'Robinhood undergoes a major re-org. A PM inherits a new team that is visibly angry and cynical about their previous PM leaving and the shifting roadmap.',
        'intermediate',
        'Robinhood',
        'Financial services platform',
        'B',
        'Option B is correct. When taking over a traumatized or cynical team, a leader must first build trust through active listening and empathy before attempting to drive change. Option A will immediately cause the team to reject the new PM. Option C makes promises the PM likely cannot keep. Option D is dismissive and destroys psychological safety.',
        ARRAY['change_management', 'empathy', 'team_building']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately implement new processes to establish authority and signal a fresh start.', false),
    (v_q_id, 'B', 'Hold 1:1s to actively listen to their concerns, acknowledge the disruption, and learn their existing working styles.', true),
    (v_q_id, 'C', 'Promise them that the roadmap will go back to exactly how it was under the old PM.', false),
    (v_q_id, 'D', 'Tell them to get over it because re-orgs are a standard part of working in tech.', false);

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
        'Uber''s Celebrating Failures',
        'An Uber team launches a highly anticipated routing feature that completely fails to move the primary metric during an A/B test.',
        'intermediate',
        'Uber',
        'Data-driven ride-hailing company',
        'C',
        'Option C is correct. A strong product culture treats failed experiments as valuable learnings, not disciplinary issues. Celebrating the learning neutralizes fear of failure and ensures the organization gets smarter. Option A ensures the same mistake will be repeated. Option B destroys cross-functional trust. Option D kills innovation by punishing risk-taking.',
        ARRAY['experimentation', 'culture', 'psychological_safety']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Sweep it under the rug and quickly move the team to the next feature to maintain morale.', false),
    (v_q_id, 'B', 'Blame the data science team for providing inaccurate initial projections.', false),
    (v_q_id, 'C', 'Host a retro to celebrate the learning, document the invalidated assumptions, and share the insights with other teams.', true),
    (v_q_id, 'D', 'Punish the team by assigning them low-priority bug-fixing duties for a month.', false);

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
        'GitHub''s Combating Silos',
        'A GitHub squad has frontend engineers who don''t talk to backend engineers until the end of the sprint, leading to massive integration issues and missed deadlines.',
        'intermediate',
        'GitHub',
        'Developer platform',
        'C',
        'Option C is correct. Structural silos require structural solutions. Forcing joint kickoffs and API contracts before coding starts ensures alignment without micromanagement. Option A is an extreme overcorrection that slows velocity. Option B exacerbates the silo problem. Option D turns the PM into a massive bottleneck and prevents engineers from collaborating directly.',
        ARRAY['collaboration', 'cross_functional', 'process']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force frontend and backend engineers to pair program on all tickets.', false),
    (v_q_id, 'B', 'Organize the sprint so frontend and backend work on completely separate features to avoid blocking each other.', false),
    (v_q_id, 'C', 'Work with the EM to structure cross-functional ''mini-squads'' for features, requiring joint kickoffs and API contracts upfront.', true),
    (v_q_id, 'D', 'The PM should act as the messenger, translating requirements between frontend and backend.', false);

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
        'Notion''s Quiet Team Members',
        'During Notion brainstorming sessions, only the most senior engineer and the design lead speak. Junior engineers remain completely silent.',
        'intermediate',
        'Notion',
        'Productivity software company',
        'C',
        'Option C is correct. ''Brainwriting'' or silent document reading levels the playing field for introverts and junior members, preventing the loudest voices from anchoring the room. Option A creates anxiety and reduces safety. Option B is overly confrontational and stifles senior contributors. Option D excludes vital context from senior members.',
        ARRAY['inclusion', 'brainstorming', 'facilitation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Call on quiet members randomly to put them on the spot and force participation.', false),
    (v_q_id, 'B', 'Tell the senior engineer and design lead to stop talking until others have spoken.', false),
    (v_q_id, 'C', 'Implement silent reading and async writing of ideas (brainwriting) before opening the floor for verbal discussion.', true),
    (v_q_id, 'D', 'Only invite the quiet members to the next meeting so they feel comfortable.', false);

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
        'Netflix''s Radical Candor',
        'A Netflix PM receives feedback that their Engineering Manager (EM) is acting as a gatekeeper, forbidding engineers from talking directly to the PM about product ideas.',
        'intermediate',
        'Netflix',
        'Culture of radical candor and direct feedback',
        'B',
        'Option B is correct. PMs must address triad conflicts directly and professionally. Using a framework like SBI focuses the conversation on objective business impact (agility, innovation) rather than personal attacks. Option A is an escalation that destroys trust. Option C is deceptive and creates toxic politics. Option D allows a dysfunctional team dynamic to persist.',
        ARRAY['feedback', 'conflict_resolution', 'triad']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Complain to the VP of Engineering to get the EM reprimanded.', false),
    (v_q_id, 'B', 'Deliver direct, private feedback to the EM using the SBI (Situation, Behavior, Impact) model, focusing on how gatekeeping hurts team agility.', true),
    (v_q_id, 'C', 'Secretly set up 1:1s with engineers behind the EM''s back to bypass them.', false),
    (v_q_id, 'D', 'Ignore the issue to preserve the working relationship with the EM.', false);

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
        'Spotify''s Tech Debt Tension',
        'A Spotify squad''s velocity is tanking due to severe tech debt. The PM wants to ship user features, while the EM wants to halt all feature work for 2 months to refactor.',
        'intermediate',
        'Spotify',
        'Music streaming platform',
        'C',
        'Option C is correct. Managing tech debt is a shared triad responsibility. A healthy compromise involves continuous, incremental investment (the ''tax'' approach) rather than stopping all product momentum. Option A burns out the team and leads to a system rewrite eventually anyway. Option B kills business momentum. Option D lacks transparency and trust.',
        ARRAY['trade_offs', 'tech_debt', 'negotiation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Override the EM, arguing that PMs own the roadmap and user value comes first.', false),
    (v_q_id, 'B', 'Surrender the roadmap to the EM for 2 months to keep the engineering team happy.', false),
    (v_q_id, 'C', 'Partner with the EM to quantify the tech debt cost and allocate a fixed percentage of each sprint (e.g., 20%) to continuous refactoring.', true),
    (v_q_id, 'D', 'Hide the refactoring work inside feature tickets so leadership doesn''t know it''s happening.', false);

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
        'Shopify''s Team Goals',
        'A PM at Shopify needs to set quarterly OKRs (Objectives and Key Results) for their squad.',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'B',
        'Option B is correct. Effective goal setting is a balance of top-down alignment and bottom-up empowerment. The PM brings the strategic context (Objective), and the team figures out how to measure success (Key Results). Option A removes team agency and buy-in. Option C risks misalignment with company strategy. Option D abdicates the PM''s role.',
        ARRAY['goal_setting', 'alignment', 'okrs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM drafts the OKRs in a silo and presents them to the team as final.', false),
    (v_q_id, 'B', 'The PM sets the business objective (the ''O'') and collaborates with the team to define the measurable Key Results (''KRs'').', true),
    (v_q_id, 'C', 'The team sets both the Objectives and Key Results without PM input to ensure maximum engineering buy-in.', false),
    (v_q_id, 'D', 'The PM asks the VP of Product to set the squad''s goals.', false);

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
        'Stripe''s Scaling a Team',
        'Stripe''s payments team grows rapidly from 6 to 18 engineers. The PM is drowning in Slack pings, sprint planning takes 4 hours, and daily standups take 45 minutes.',
        'advanced',
        'Stripe',
        'Rapidly scaling fintech platform',
        'C',
        'Option C is correct. Teams break down structurally at around 8-10 people. The advanced PM recognizes when a team has outgrown its operational model and advocates for organizational design changes (podding) rather than just working harder. Option A leads to PM burnout. Option B is draconian and stalls development. Option D abandons the execution phase entirely.',
        ARRAY['scaling', 'org_design', 'process']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Work longer hours to maintain the exact same level of involvement with every engineer.', false),
    (v_q_id, 'B', 'Implement a strict rule that engineers can only message the PM once per day.', false),
    (v_q_id, 'C', 'Work with engineering leadership to split the team into smaller pods with specific sub-domains and delegated tech leads.', true),
    (v_q_id, 'D', 'Stop attending all engineering ceremonies to focus purely on product strategy.', false);

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
        'Airbnb''s Cultural Decay',
        'A newly hired senior engineer at Airbnb is incredibly productive, shipping code 3x faster than anyone else. However, they constantly belittle junior designers and ignore the PM''s context.',
        'advanced',
        'Airbnb',
        'Culture-focused tech company',
        'C',
        'Option C is correct. Advanced PMs understand that culture is the ultimate driver of long-term velocity. A ''brilliant jerk'' will eventually cause high-performing peers to quit, resulting in a net negative for the company. PMs must protect triad culture. Option A is a cop-out. Option B sacrifices long-term health for short-term gains. Option D rewards toxic behavior.',
        ARRAY['culture', 'toxic_behavior', 'triad']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Do nothing, as managing engineering behavior is strictly an Engineering Manager problem.', false),
    (v_q_id, 'B', 'Tolerate the behavior because the engineer is highly productive and accelerating the roadmap.', false),
    (v_q_id, 'C', 'Partner immediately with the EM and Design Lead to address the behavior, as ''brilliant jerks'' destroy triad trust and long-term team velocity.', true),
    (v_q_id, 'D', 'Promote the engineer to Tech Lead so they feel more respected by the designers.', false);

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
        'Figma''s Manager of PMs',
        'A Group PM at Figma is managing a junior PM who is overly dictatorial with their engineering team, handing down rigid specs and causing friction with the engineers.',
        'advanced',
        'Figma',
        'Design platform requiring high cross-functional collaboration',
        'B',
        'Option B is correct. Managing PMs requires coaching them out of the ''project manager'' mindset into a ''product leader'' mindset. Teaching them to provide context rather than control solves the root cause. Option A undermines the junior PM completely. Option C destroys the junior PM''s credibility forever. Option D just moves the toxic behavior to another team.',
        ARRAY['coaching', 'influence', 'leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Take over the junior PM''s team temporarily to show them how to lead properly.', false),
    (v_q_id, 'B', 'Coach the junior PM on ''influence without authority'' and shift their focus from dictating tasks to providing business context.', true),
    (v_q_id, 'C', 'Tell the engineering team to just ignore the junior PM''s rigid specs.', false),
    (v_q_id, 'D', 'Move the junior PM to a team with less experienced engineers who need more direction.', false);

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
        'Netflix''s ''Keeper Test''',
        'A PM at Netflix realizes a long-tenured Product Analyst is no longer capable of handling the advanced data modeling the team now requires due to scaling.',
        'advanced',
        'Netflix',
        'Streaming company with a ''high talent density'' philosophy',
        'C',
        'Option C is correct. High-performing teams require honest conversations about performance and fit. Addressing skill gaps transparently respects the individual while protecting the team''s capabilities. Option A and B are dishonest, waste company resources, and hide the problem. Option D is abusive and unprofessional.',
        ARRAY['performance_management', 'talent_density', 'feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Quietly route the complex work to another team to protect the analyst from failing.', false),
    (v_q_id, 'B', 'Keep the analyst but hire a shadow contractor to do their actual work.', false),
    (v_q_id, 'C', 'Have a transparent conversation with the analyst and their manager about the skill gap, providing an opportunity to level up or transition out.', true),
    (v_q_id, 'D', 'Humiliate the analyst in a team meeting so they realize they need to quit.', false);

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
        'GitHub''s Influencing Hiring',
        'The EM at GitHub is about to hire a senior engineer who aced the technical screens but showed strong dismissiveness toward user research and product strategy during the PM interview loop.',
        'advanced',
        'GitHub',
        'Developer platform where cross-functional alignment is critical',
        'C',
        'Option C is correct. PMs are critical in assessing the cross-functional collaboration skills of engineering hires. Providing evidence-based feedback helps the EM make a holistic hiring decision. Option A is factually incorrect; PMs rarely have absolute veto over engineering. Option B ignores the PM''s responsibility to protect team culture. Option D creates a dysfunctional team dynamic immediately.',
        ARRAY['hiring', 'culture_fit', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Veto the hire directly, as PMs have absolute veto power over engineering hires.', false),
    (v_q_id, 'B', 'Say nothing; PMs should not evaluate engineering candidates.', false),
    (v_q_id, 'C', 'Share specific behavioral examples from the interview with the EM, strongly advising against the hire due to cross-functional culture fit risks.', true),
    (v_q_id, 'D', 'Approve the hire but refuse to assign them any product-facing work.', false);

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
        'Atlassian''s Low-Trust Turnaround',
        'A PM inherits an Atlassian team where engineers refuse to give estimates, citing that previous PMs used estimates as hard deadlines to punish them for being late.',
        'advanced',
        'Atlassian',
        'Enterprise software company',
        'C',
        'Option C is correct. Turning around a low-trust team requires acknowledging past trauma and safely rebuilding processes. Moving to abstract estimation (t-shirt sizes) removes the fear of timeline commitments while still allowing for prioritization. Option A reinforces the abuse. Option B means the PM cannot do basic roadmapping. Option D is deceptive and will destroy trust completely when discovered.',
        ARRAY['trust', 'agile', 'turnaround']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Demand estimates and threaten PIPs for non-compliance to re-establish control.', false),
    (v_q_id, 'B', 'Stop doing estimation completely and indefinitely to make them comfortable.', false),
    (v_q_id, 'C', 'Acknowledge the past abuse, separate estimates from commitments, and start by only estimating relative complexity (e.g., t-shirt sizes) to rebuild safety.', true),
    (v_q_id, 'D', 'Ask the EM to provide all the estimates secretly without telling the team.', false);

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
        'Slack''s Demoralized Team',
        'A PM takes over a Slack team whose previous major project was abruptly cancelled by leadership after 8 months of work. They are cynical, apathetic, and expect their next project to be cancelled too.',
        'advanced',
        'Slack',
        'Workplace communication platform',
        'B',
        'Option B is correct. Leading a demoralized team requires empathy and rebuilding confidence through consecutive, low-risk successes. Securing executive buy-in prevents history from repeating itself. Option A shows a complete lack of emotional intelligence. Option C makes a promise the PM cannot guarantee. Option D treats a deep psychological and strategic issue with a superficial perk.',
        ARRAY['morale', 'leadership', 'turnaround']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell them to ''get over it'' and immediately assign a massive new 12-month project.', false),
    (v_q_id, 'B', 'Validate their frustration, secure a series of small ''quick wins'' to rebuild momentum, and ensure strong executive buy-in for the next initiative.', true),
    (v_q_id, 'C', 'Promise them unconditionally that their next project will definitely not be cancelled.', false),
    (v_q_id, 'D', 'Host a team offsite to buy everyone drinks and assume the problem is solved.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Team Leadership';

END $$;