-- ============================================
-- ASSESSMENT: Conflict Resolution
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
    WHERE slug = 'conflict-resolution';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug conflict-resolution not found. Run the seed data first.';
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
        'Spotify''s Cross-Functional Disagreement',
        E'A Spotify Engineering Lead and a Design Lead are arguing over the UI implementation for a new playlist feature. The Engineering Lead argues the design is too technically complex and will delay the launch, while the Design Lead insists it is crucial for an intuitive user experience. The argument has brought the project to a standstill.\n\nAs the PM, what is the best immediate step to resolve this?',
        'foundational',
        'Spotify',
        'Music streaming platform',
        'B',
        'The best first step in any cross-functional conflict is to bring the parties together to uncover the underlying constraints and interests, rather than positional demands. By facilitating a discussion focused on the ''why'' behind the design and the specific technical hurdles, the PM can help the team identify compromises (e.g., a simplified animation that still meets the UX goal). Forcing a decision (Option A) or siding unilaterally (Option C) damages team trust. Escalating (Option D) is premature before attempting mediation.',
        ARRAY['cross_functional_collaboration', 'mediation', 'active_listening']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Make the final decision yourself, as the PM is the ''CEO of the product'' and responsible for breaking ties.', false),
    (v_q_id, 'B', 'Facilitate a meeting to understand the specific technical constraints and the underlying UX goals to find a mutually acceptable compromise.', true),
    (v_q_id, 'C', 'Side with the Engineering Lead, as shipping on time is always more important than achieving the perfect design.', false),
    (v_q_id, 'D', 'Escalate the issue to the VP of Product to get an executive mandate on which approach to take.', false);

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
        'Airbnb''s Hostile Communication',
        E'An Airbnb Product Manager receives a hostile, public Slack message from a Marketing Manager accusing the product team of intentionally delaying a new promotional feature and ''ruining the Q3 campaign.''\n\nWhat is the most effective way for the PM to handle this situation?',
        'foundational',
        'Airbnb',
        'Travel and housing marketplace',
        'C',
        'When faced with hostile or emotional written communication, the best approach is to de-escalate by moving the conversation to a higher-bandwidth medium, like a video call or face-to-face meeting. Replying defensively in public (Option A) only fuels the conflict. Ignoring it (Option D) allows resentment to build. Escalating immediately to their manager (Option B) avoids addressing the interpersonal issue directly. A quick call helps humanize the interaction, cool tempers, and align on the actual facts of the delay.',
        ARRAY['de_escalation', 'communication', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reply in the Slack channel with a detailed timeline proving the marketing team was late in delivering requirements.', false),
    (v_q_id, 'B', 'Screenshot the message and immediately send it to the Marketing Manager''s director to complain about unprofessional behavior.', false),
    (v_q_id, 'C', 'Reply briefly acknowledging their frustration, and immediately schedule a quick video call to discuss the issue offline.', true),
    (v_q_id, 'D', 'Ignore the message completely, as engaging with hostile stakeholders is a distraction from product work.', false);

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
        'Stripe''s Sales vs. Engineering Tension',
        E'A Stripe Sales Director demands a highly customized reporting feature for a prospective enterprise client. The Engineering Manager outright refuses, stating it will create massive technical debt and distract from the core roadmap.\n\nHow should the PM navigate this conflict?',
        'foundational',
        'Stripe',
        'Payment processing platform',
        'B',
        'Sales teams often ask for specific solutions rather than explaining the underlying problem. The PM''s role is to dig into the ''why'' behind the request. By understanding what the enterprise client is actually trying to achieve (Option B), the PM and engineering team might find a scalable, low-tech-debt way to solve the problem (e.g., exposing an API endpoint). Option A creates tech debt. Option C alienates Sales and potentially loses a major deal. Option D creates a misaligned transactional culture.',
        ARRAY['sales_alignment', 'root_cause_analysis', 'roadmap_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Command engineering to build the feature, as closing enterprise deals is critical for company revenue.', false),
    (v_q_id, 'B', 'Work with Sales to uncover the client''s underlying business problem, then brainstorm scalable solutions with Engineering.', true),
    (v_q_id, 'C', 'Support Engineering''s refusal and tell Sales that custom features are strictly against company policy.', false),
    (v_q_id, 'D', 'Offer to prioritize this feature if Sales agrees to lower their demands on the next three enterprise deals.', false);

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
        'Figma''s Code Review Conflicts',
        E'Two engineers on a Figma product team are constantly bickering during PR (Pull Request) reviews. The feedback is increasingly nitpicky, sarcastic, and delaying the team''s velocity.\n\nWhat is the most appropriate action for the PM to take?',
        'foundational',
        'Figma',
        'Collaborative design tool',
        'C',
        'While this is a technical process, the conflict is impacting team velocity and morale, making it the PM''s concern. However, it is primarily an engineering management issue. The PM should raise the behavioral impact with the Engineering Manager (Option C), who is responsible for the engineers'' conduct and growth. Intervening technically (Option A) oversteps PM bounds. Ignoring it (Option B) hurts the product. Setting PR rules directly (Option D) bypasses the Engineering Manager''s authority.',
        ARRAY['team_dynamics', 'escalation', 'engineering_collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Start reviewing the PRs yourself to mediate the technical disagreements and approve code faster.', false),
    (v_q_id, 'B', 'Do nothing, as code reviews are strictly engineering territory and PMs should not interfere.', false),
    (v_q_id, 'C', 'Privately share observations with the Engineering Manager about how this behavior is impacting team velocity and morale.', true),
    (v_q_id, 'D', 'Schedule a meeting with the two engineers and dictate new rules for how they are allowed to comment on PRs.', false);

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
        'Notion''s Perfectionism vs. Speed',
        E'A Notion Product Designer wants an extra week to perfect the micro-interactions on a new database template feature. The PM wants to launch immediately to meet a promised marketing deadline.\n\nHow should the PM address this disagreement?',
        'foundational',
        'Notion',
        'Workspace and note-taking app',
        'A',
        'Conflicts over speed vs. quality are common. The best approach is to evaluate the trade-off against the core goals. If the micro-interactions are not part of the MVP criteria and delaying hurts a strategic deadline, the PM should negotiate a fast-follow (Option A). This validates the designer''s work while meeting business needs. Forcing a launch (Option C) breeds resentment. Delaying without a clear reason (Option B) misses commitments. Putting it to a vote (Option D) abdicates leadership responsibility.',
        ARRAY['trade_offs', 'speed_vs_quality', 'design_collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Acknowledge the value of the design polish, but align on launching the MVP now and scheduling the polish as a fast-follow in the next sprint.', true),
    (v_q_id, 'B', 'Delay the launch by a week; design quality is always more important than marketing deadlines.', false),
    (v_q_id, 'C', 'Tell the designer that perfection is the enemy of good and launch the feature without further discussion.', false),
    (v_q_id, 'D', 'Let the entire development team vote on whether to launch now or wait for the design polish.', false);

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
        'Uber''s Internal Tool Breakage',
        E'The Uber Driver Ops team is furious because your product team shipped a consumer app update that inadvertently broke a minor internal tool they use daily. They send an angry email copying multiple directors.\n\nWhat is the most constructive response?',
        'foundational',
        'Uber',
        'Ride-hailing network',
        'D',
        'When your team makes a mistake that impacts another team, the best conflict resolution strategy is extreme ownership. Acknowledging the pain, apologizing, and committing to a fix (Option D) immediately defuses anger and rebuilds trust. Defensiveness (Option A) or shifting blame (Option B) escalates the conflict. Minimizing their pain (Option C) is dismissive and damages the relationship long-term.',
        ARRAY['extreme_ownership', 'stakeholder_management', 'de_escalation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reply all, explaining that the internal tool is legacy software and the breakage wasn''t your team''s fault.', false),
    (v_q_id, 'B', 'Blame the QA team for missing the regression and promise the ops team that QA will be reprimanded.', false),
    (v_q_id, 'C', 'Reply stating that the consumer update drives $1M in revenue, so the minor internal tool breakage is an acceptable trade-off.', false),
    (v_q_id, 'D', 'Acknowledge the disruption, apologize for the oversight, and immediately provide a timeline for when the tool will be fixed.', true);

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
        'Slack''s Scope Creep Disagreement',
        E'During sprint planning at Slack, the PM pushes to include three new minor features. The Engineering Lead pushes back, saying the team is already at capacity and adding scope will cause burnout.\n\nHow should the PM handle this?',
        'foundational',
        'Slack',
        'Business communication platform',
        'C',
        'A core PM skill is prioritization based on capacity. When engineering flags capacity constraints, the PM must respect that limit. The correct approach is to review the priority list together and make trade-offs: if the three new features are critical, what existing work can be dropped? Option C achieves this. Pushing through (Option A) causes burnout. Secretly adding scope (Option B) destroys trust. Telling them to work harder (Option D) is toxic leadership.',
        ARRAY['prioritization', 'agile_principles', 'engineering_collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Insist the features are critical for the quarter and ask the team to just stretch this one time.', false),
    (v_q_id, 'B', 'Agree to leave them out of the sprint, but secretly ask individual engineers to build them on the side.', false),
    (v_q_id, 'C', 'Review the current sprint backlog together and ask what lower-priority items can be removed to make room for the new features.', true),
    (v_q_id, 'D', 'Tell the Engineering Lead that their team''s velocity is too low and they need to improve their estimation skills.', false);

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
        'DoorDash''s Legal Roadblock',
        E'Two days before launching a new alcohol delivery feature at DoorDash, the Legal team flags a compliance risk and demands the launch be paused. The product team is frustrated by the last-minute block.\n\nWhat should the PM do?',
        'foundational',
        'DoorDash',
        'Food delivery platform',
        'B',
        'Legal and Compliance teams exist to protect the company. Viewing them as adversaries is a mistake. The PM must partner with Legal to understand the specific risk and find a path forward (Option B). Launching anyway (Option A) risks massive fines. Canceling (Option C) wastes effort. Escalating (Option D) creates an unnecessary combative environment. Good PMs navigate compliance as a design constraint, not a blocker.',
        ARRAY['legal_compliance', 'cross_functional_collaboration', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore Legal''s warning; as the PM, you own the launch decision and assume the risk.', false),
    (v_q_id, 'B', 'Meet with Legal immediately to understand the specific compliance gap and brainstorm adjustments that satisfy their requirements.', true),
    (v_q_id, 'C', 'Cancel the launch entirely, as dealing with legal risks is too time-consuming for the product team.', false),
    (v_q_id, 'D', 'Escalate to the CEO, complaining that Legal is acting as a blocker to company innovation.', false);

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
        'GitHub''s Dominant Voice',
        E'In a GitHub product brainstorming session, a senior engineer constantly interrupts and shoots down ideas from junior designers and engineers. The room has gone quiet, and tension is high.\n\nHow should the PM address this in the moment?',
        'foundational',
        'GitHub',
        'Code hosting and collaboration platform',
        'C',
        'A PM must ensure all voices are heard to get the best ideas and maintain team health. Changing the format to a structured, silent brainstorming method (like writing on sticky notes or a digital whiteboard) instantly neutralizes the dominant voice and equalizes participation (Option C). Confronting publicly (Option A) creates defensiveness. Letting it continue (Option B) stifles innovation. Ending the meeting (Option D) avoids the problem.',
        ARRAY['meeting_facilitation', 'inclusive_culture', 'conflict_prevention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Call out the senior engineer publicly in front of the team and demand they stop interrupting.', false),
    (v_q_id, 'B', 'Let the senior engineer lead the session, as their technical expertise is the most valuable in the room.', false),
    (v_q_id, 'C', 'Pivot the meeting format to silent writing/sticky-note brainstorming to ensure everyone has an equal opportunity to contribute.', true),
    (v_q_id, 'D', 'End the meeting early and complain to the senior engineer''s manager about their toxic behavior.', false);

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
        'Zoom''s Missed Dependency',
        E'A PM from the Zoom Chat team confronts you angrily because your Video Core team missed a promised API deadline, blocking their upcoming release.\n\nWhat is the most productive way to handle this confrontation?',
        'foundational',
        'Zoom',
        'Video conferencing platform',
        'A',
        'When you miss a commitment that impacts others, defensive posturing exacerbates the conflict. The PM should take ownership, transparently explain the blocker, and immediately collaborate on a mitigation plan or new timeline (Option A). Blaming the team (Option B) shows weak leadership. Telling them to wait (Option C) is dismissive. Offering false promises (Option D) will destroy whatever trust remains when the promise is broken again.',
        ARRAY['accountability', 'cross_team_dependencies', 'transparency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Own the delay, clearly explain the technical blocker that caused it, and provide a realistic, updated timeline.', true),
    (v_q_id, 'B', 'Deflect the blame onto your engineering team so the Chat PM knows it wasn''t your personal fault.', false),
    (v_q_id, 'C', 'Tell the Chat PM they will just have to wait, as cross-team dependencies always carry schedule risks.', false),
    (v_q_id, 'D', 'Promise to deliver the API by the end of the week, even if you aren''t sure your team can do it, just to calm them down.', false);

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
        'Peloton''s Hardware vs. Software Clash',
        E'The Peloton Hardware PM wants to delay the release of a new metrics feature by 3 months to align with the launch of a new bike sensor. The Software PM wants to launch the app update now using the existing sensors. Tensions are high in the weekly sync.\n\nWhat is the best way to resolve this?',
        'intermediate',
        'Peloton',
        'Interactive fitness platform',
        'C',
        'Hardware and software release cycles often clash. The PM''s role is to unbundle the value. If the software feature provides standalone value to existing users, it shouldn''t be blocked by hardware delays. Proposing a phased rollout (Option C) allows software to deliver immediate value while leaving room for a ''v2'' that leverages the new hardware later. Option A delays value unnecessarily. Option B ignores the hardware team''s goals. Option D offloads the decision to an executive without a proposed solution.',
        ARRAY['hardware_software_integration', 'phased_rollout', 'trade_offs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree to delay the software launch, as hardware and software must always launch in perfect sync.', false),
    (v_q_id, 'B', 'Ignore the Hardware PM and launch the software immediately; hardware constraints shouldn''t dictate software timelines.', false),
    (v_q_id, 'C', 'Evaluate if the software feature provides value with existing sensors, and propose a phased rollout: v1 now, v2 synced with the hardware launch.', true),
    (v_q_id, 'D', 'Escalate to the CEO because hardware and software conflicts can only be resolved by the executive team.', false);

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
        'Discord''s Trust vs. Growth Battle',
        E'Discord''s Trust & Safety PM wants to add phone verification to new server creation to curb spam. The Growth PM vehemently opposes this, citing a projected 15% drop in new server creation. They are at an impasse.\n\nHow should this conflict be resolved?',
        'intermediate',
        'Discord',
        'Voice, video and text chat app',
        'B',
        'Conflicts between opposing metrics (e.g., Growth vs. Safety) cannot be resolved by arguing over localized metrics (total servers vs. spam count). The teams must align on a shared, higher-level metric—such as ''Active, Healthy Servers'' or Long-Term LTV. Running an A/B test (Option B) allows them to measure the holistic impact on the ecosystem rather than guessing. Option A sacrifices quality for vanity metrics. Option C introduces friction blindly. Option D is an unstructured compromise that satisfies nobody.',
        ARRAY['metric_trade_offs', 'ab_testing', 'growth_vs_safety']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Side with Growth, as user acquisition is always the most important metric for a social platform.', false),
    (v_q_id, 'B', 'Align on a shared company-level metric (e.g., ''Healthy Active Servers'') and run an A/B test to measure the holistic impact of the friction.', true),
    (v_q_id, 'C', 'Side with Trust & Safety, as ignoring spam will eventually destroy the platform''s reputation.', false),
    (v_q_id, 'D', 'Compromise by adding email verification instead of phone verification, without testing the impact.', false);

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
        'Netflix''s Algorithm vs. Performance',
        E'Netflix''s Machine Learning team has a new recommendation model that increases engagement by 2%. However, the Core Performance team is blocking the deployment because the model increases the home screen load time by 300ms, violating their strict latency SLAs.\n\nHow should the PM mediate this?',
        'intermediate',
        'Netflix',
        'Video streaming service',
        'D',
        'When teams with strict opposing mandates clash (Engagement vs. Latency), the PM must quantify the trade-off using data. By running a controlled experiment (Option D), the teams can see if the 2% engagement gain holds up against the frustration of a 300ms delay. Often, latency degrades engagement, canceling out the ML gains. Data resolves the conflict better than opinions. Option A ignores performance guardrails. Option B ignores ML innovation. Option C optimizes for engineering effort over user experience.',
        ARRAY['performance_vs_features', 'data_driven_decisions', 'guardrail_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Override the Performance team; a 2% engagement gain translates to millions in retention revenue, which outweighs latency.', false),
    (v_q_id, 'B', 'Support the Performance team and block the model; SLAs are non-negotiable under any circumstances.', false),
    (v_q_id, 'C', 'Ask the ML team to write faster code, even if it means dropping the engagement gain to 0.5%.', false),
    (v_q_id, 'D', 'Use A/B testing data to quantify the exact trade-off, analyzing whether the increased latency ultimately negates the engagement gains.', true);

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
        'Amazon''s Escalated Feature Request',
        E'A Category Manager at Amazon escalates to a VP, complaining that your product team refuses to build a highly requested merchandising tool. The VP emails you asking for an explanation.\n\nWhat is the best way to respond?',
        'intermediate',
        'Amazon',
        'E-commerce and cloud computing',
        'B',
        'When a stakeholder escalates, defending your decision requires data, not emotion. The PM should provide the VP with the prioritized roadmap and the objective ROI/impact analysis showing why other features are ranked higher (Option B). This reframes the conversation from ''PM says no'' to ''Here is how we maximize ROI for the business.'' Option A rewards the escalation. Option C is defensive and unprofessional. Option D wastes time building something you don''t intend to ship.',
        ARRAY['executive_communication', 'roadmapping', 'prioritization_frameworks']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apologize to the VP and immediately add the merchandising tool to the current sprint to smooth things over.', false),
    (v_q_id, 'B', 'Provide the VP with the prioritized roadmap and the data-driven rationale (e.g., ROI) showing why other features are ranked higher.', true),
    (v_q_id, 'C', 'Reply to the VP stating that the Category Manager is being unreasonable and doesn''t understand engineering constraints.', false),
    (v_q_id, 'D', 'Agree to build a low-quality prototype of the tool just to quiet the Category Manager down.', false);

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
        'Spotify''s Cross-Functional Retro',
        E'During a post-mortem at Spotify, the QA Lead angrily accuses the Engineering team of ''throwing untested garbage over the wall.'' The Engineering Lead fires back, saying QA is ''too slow and nitpicky.'' The meeting is derailing.\n\nHow should the PM steer the conversation?',
        'intermediate',
        'Spotify',
        'Audio streaming platform',
        'C',
        'In a blameless retro, personal attacks destroy psychological safety. The PM must immediately intervene to reframe the discussion away from personal blame (''you throw garbage'') and toward systemic process issues (Option C). By asking ''What broke in our process?'', the PM shifts the teams from adversaries to partners solving a shared problem (e.g., adding automated unit tests). Option A takes sides. Option B lets the toxicity continue. Option D ends the meeting without resolving the root cause.',
        ARRAY['post_mortem', 'blameless_culture', 'process_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Defend the Engineering team, as rapid shipping is highly valued at Spotify.', false),
    (v_q_id, 'B', 'Stay quiet and let them vent; it''s healthy for teams to blow off steam after a hard launch.', false),
    (v_q_id, 'C', 'Interrupt and reframe the conversation away from blame, asking instead what specific steps in the development process failed.', true),
    (v_q_id, 'D', 'End the meeting immediately and tell them to figure it out privately.', false);

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
        'Airbnb''s Overlapping Roadmaps',
        E'Two different product teams at Airbnb (Host Success and Core Earnings) are building overlapping ''Host Dashboard'' features. Both PMs believe their team owns the real estate and refuse to yield.\n\nWhat is the most professional way to resolve this turf war?',
        'intermediate',
        'Airbnb',
        'Travel and housing marketplace',
        'D',
        'Turf wars over product surface areas are common in large orgs. When peer PMs cannot align, the conflict must be escalated. However, a professional escalation is not a complaint; it is a joint proposal. The PMs should draft a document outlining the overlap, the user confusion it causes, and present options for a product leader to make a strategic mandate (Option D). Option A creates a fragmented UX. Option B wastes engineering resources. Option C is petty and unprofessional.',
        ARRAY['organizational_design', 'escalation', 'product_surface_ownership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Let both teams launch their versions of the dashboard and see which one hosts prefer.', false),
    (v_q_id, 'B', 'Race the other team to launch first, establishing a ''facts on the ground'' claim to the dashboard.', false),
    (v_q_id, 'C', 'Escalate to the VP of Product immediately and accuse the other PM of stepping out of their lane.', false),
    (v_q_id, 'D', 'Collaborate with the other PM on a joint memo outlining the overlap and ask product leadership for a strategic mandate on ownership.', true);

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
        'Stripe''s Bored Engineer',
        E'A highly talented, tenured engineer at Stripe threatens to switch teams because they are bored with the current roadmap (focused on legacy refactoring) and want to build a shiny new generative AI feature that isn''t a company priority.\n\nHow should the PM handle this?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'A',
        'Managing the motivation of top talent is a shared responsibility between the PM and the Engineering Manager. The PM cannot derail the roadmap for one engineer (Option B), nor should they coldly dismiss the engineer''s desires (Option C). The best approach is to partner with the EM to find a structured compromise, such as a scoped hackathon project or allocating 10% time for innovation, keeping the engineer engaged while delivering core business value (Option A).',
        ARRAY['talent_retention', 'engineering_collaboration', 'roadmap_integrity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Work with the Engineering Manager to find a compromise, such as scoping a small time-boxed innovation sprint for the AI idea.', true),
    (v_q_id, 'B', 'Immediately pivot the roadmap to prioritize the AI feature to ensure the engineer doesn''t leave.', false),
    (v_q_id, 'C', 'Tell the engineer that business needs come first and they must complete the refactoring work before doing anything fun.', false),
    (v_q_id, 'D', 'Let the engineer leave the team; no individual is bigger than the product roadmap.', false);

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
        'Figma''s Premature Marketing Promise',
        E'The Figma Product Marketing team published a blog post teasing a highly requested ''Advanced Prototyping'' feature coming next month. The PM was never consulted, and the feature is not even on the roadmap.\n\nWhat is the PM''s best course of action?',
        'intermediate',
        'Figma',
        'Collaborative design tool',
        'C',
        'When another team makes a public mistake that impacts Product, the PM must manage the external fallout first, then fix the internal process. The PM should address the immediate comms issue with Marketing to issue a correction or clarification, and then establish a strict cross-functional review process for future PR (Option C). Dropping everything to build it (Option A) ruins the strategic roadmap. Publicly fighting Marketing (Option B) damages the company brand. Ignoring it (Option D) guarantees disappointed users.',
        ARRAY['product_marketing', 'cross_functional_alignment', 'crisis_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Halt all current development and force the engineering team to build the feature to save the company''s reputation.', false),
    (v_q_id, 'B', 'Publish a tweet from your personal account clarifying that Marketing made a mistake and the feature isn''t coming.', false),
    (v_q_id, 'C', 'Work with Marketing to manage external communications immediately, then establish a strict roadmap-sync process for future public announcements.', true),
    (v_q_id, 'D', 'Ignore the blog post and continue with the current roadmap; Marketing will have to deal with the angry users next month.', false);

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
        'Notion''s Unprofessional Critique',
        E'During a cross-functional product review at Notion, a Lead Designer aggressively criticizes a junior PM''s PRD, calling the user flows ''amateurish'' and ''embarrassing'' in front of 20 people.\n\nAs a senior PM in the room, what should you do?',
        'intermediate',
        'Notion',
        'Workspace and note-taking app',
        'B',
        'Public humiliation destroys psychological safety. A senior leader in the room must immediately intervene to stop the toxic behavior. Pausing the meeting and redirecting the conversation to objective, constructive feedback (Option B) protects the junior PM and resets team norms. Staying silent (Option A) makes you complicit. Attacking the designer (Option C) creates a screaming match. Waiting until after the meeting (Option D) allows the damage to be fully inflicted.',
        ARRAY['psychological_safety', 'meeting_facilitation', 'peer_mentorship']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stay silent; the junior PM needs to learn how to handle tough feedback in a fast-paced tech environment.', false),
    (v_q_id, 'B', 'Intervene immediately, pause the critique, and calmly ask the designer to rephrase their feedback focusing on the work, not the person.', true),
    (v_q_id, 'C', 'Aggressively attack the designer''s recent work to show them how it feels to be publicly humiliated.', false),
    (v_q_id, 'D', 'Wait until after the meeting, then privately comfort the junior PM and tell them not to worry about it.', false);

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
        'Uber''s Circular Dependency Deadlock',
        E'The Uber Routing team and the Pricing team are deadlocked. Routing needs Pricing to update their API first, but Pricing claims they cannot update their API until Routing migrates to a new database. Neither will budge.\n\nHow should the PMs resolve this?',
        'intermediate',
        'Uber',
        'Ride-hailing network',
        'D',
        'Circular dependencies require synchronous collaboration, not asynchronous arguing. The PMs should bring technical leads into a joint session to map out a step-by-step, phased integration plan (e.g., using mock APIs, feature flags, or backward-compatible endpoints) (Option D). Escalating immediately (Option A) shows an inability to problem-solve. Refusing to work (Option B) halts company progress. Forcing one side to yield without a technical plan (Option C) usually results in broken systems.',
        ARRAY['technical_dependencies', 'cross_team_collaboration', 'deadlock_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Escalate the issue to the VP of Engineering to force one team to do the work first.', false),
    (v_q_id, 'B', 'Pause all work on both teams until the architecture group redesigns the system to remove the dependency.', false),
    (v_q_id, 'C', 'Tell the Pricing team they must yield because Routing is a more critical core service.', false),
    (v_q_id, 'D', 'Schedule a joint working session with both engineering leads to design a phased, synchronous implementation plan (e.g., using mock APIs).', true);

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
        'Slack''s High-Pressure Customer Request',
        E'A Customer Success Manager (CSM) at Slack messages you daily, aggressively demanding a specific custom integration for a Fortune 500 client who is threatening to churn.\n\nHow should the PM handle this pressure?',
        'intermediate',
        'Slack',
        'Business communication platform',
        'C',
        'CSMs are incentivized to save specific accounts, while PMs must build scalable products for the whole market. When pressured for a specific feature, the PM should shift the conversation from the proposed *solution* to the underlying *problem*. Inviting the CSM to a joint customer interview (Option C) uncovers the root need, which the product team might solve in a scalable way. Giving in (Option A) creates custom debt. Blocking the CSM (Option B) ignores a major churn risk. Telling them to sell better (Option D) is combative.',
        ARRAY['customer_success', 'root_cause_analysis', 'saying_no']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build the integration immediately; losing a Fortune 500 client is an unacceptable outcome for the business.', false),
    (v_q_id, 'B', 'Mute the CSM on Slack to maintain focus on the strategic roadmap.', false),
    (v_q_id, 'C', 'Invite the CSM to a joint call with the client to uncover the root business problem, shifting the focus from custom features to scalable solutions.', true),
    (v_q_id, 'D', 'Tell the CSM that if the client churns because of one missing feature, it means the sales team didn''t sell the core value properly.', false);

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
        'DoorDash''s Bug vs. Feature Battle',
        E'DoorDash''s Merchant Ops team demands engineering resources to fix a bug affecting 5% of restaurant dashboards. The Consumer Growth team demands those same resources to launch a new loyalty tier. You only have capacity for one.\n\nHow do you resolve this?',
        'intermediate',
        'DoorDash',
        'Food delivery platform',
        'B',
        'When prioritizing between wildly different requests (retention/support vs. growth), PMs must translate both into a common denominator—usually revenue or LTV impact. Quantifying the cost of the bug (merchant churn) versus the projected upside of the loyalty tier (Option B) removes emotion and allows for an objective, data-driven decision. Option A uses a rigid, arbitrary rule. Option C relies on who complains louder. Option D splits focus, likely resulting in both failing.',
        ARRAY['prioritization_frameworks', 'resource_allocation', 'data_driven_decisions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Always prioritize bugs over new features, as maintaining existing product quality is paramount.', false),
    (v_q_id, 'B', 'Quantify the financial impact of both (cost of merchant churn vs. projected loyalty revenue) and present the data-driven trade-off to stakeholders.', true),
    (v_q_id, 'C', 'Prioritize the new loyalty tier because Growth is typically a higher priority for executives than Ops.', false),
    (v_q_id, 'D', 'Split the engineering team in half so they can work on both projects simultaneously, even if it delays both.', false);

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
        'GitHub''s Community Backlash',
        E'Following a UI update on GitHub, a vocal minority of open-source developers begins complaining aggressively on Twitter. The Community Manager panics, calls an emergency meeting, and demands an immediate rollback.\n\nWhat should the PM do?',
        'intermediate',
        'GitHub',
        'Code hosting and collaboration platform',
        'C',
        'Social media backlash is loud but often unrepresentative of the silent majority. Before reacting to panic, a PM must look at actual telemetry/behavioral data. If the data shows stable engagement and successful task completion, the PM should hold steady and communicate the data (Option C). Rolling back immediately (Option A) teaches the community that outrage dictates the roadmap. Ignoring the CM (Option B) destroys internal trust. A/B testing after launch (Option D) is messy; look at the current data first.',
        ARRAY['community_management', 'data_vs_anecdotes', 'crisis_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Roll back the update immediately to appease the community and protect the brand''s reputation.', false),
    (v_q_id, 'B', 'Tell the Community Manager to ignore the complaints, as users always hate change at first.', false),
    (v_q_id, 'C', 'Analyze actual product usage data to see if the silent majority is successfully using the new UI, and use that data to guide the decision.', true),
    (v_q_id, 'D', 'Launch a Twitter poll to let the community vote on whether to keep the new UI or revert to the old one.', false);

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
        'Zoom''s Tech Debt Standoff',
        E'The Zoom Engineering Manager insists on dedicating the next 2 months entirely to refactoring a legacy microservice. The PM is terrified of missing a critical market window for a new AI transcription feature.\n\nHow can the PM negotiate this?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'D',
        'A complete freeze on feature development is rarely acceptable to the business, but ignoring tech debt leads to system collapse. The PM must negotiate a compromise, such as interleaving the work (e.g., dedicating 30% of capacity to tech debt while building the feature) or tying the refactoring to the new feature''s delivery (Option D). Option A ignores the business risk. Option B ignores the engineering risk. Option C asks engineers to work unsustainable hours.',
        ARRAY['technical_debt', 'negotiation', 'roadmap_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree to the 2-month freeze; technical stability must always trump new feature development.', false),
    (v_q_id, 'B', 'Veto the refactoring sprint completely; shipping the AI feature is required to stay competitive.', false),
    (v_q_id, 'C', 'Ask the engineering team to build the AI feature during the day and refactor the microservice on nights and weekends.', false),
    (v_q_id, 'D', 'Negotiate a plan to interleave the work, dedicating a percentage of capacity to tech debt while still advancing the feature.', true);

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
        'Peloton''s Standardization vs. Customization',
        E'Peloton''s Instructor Content team wants deep custom controls to change the UI colors and layout for their specific classes. The App Platform team wants a strictly standardized UI for maintainability.\n\nHow should the PM mediate this?',
        'intermediate',
        'Peloton',
        'Interactive fitness platform',
        'B',
        'Conflicts between customization (flexibility) and standardization (scale/maintainability) are classic product problems. The PM should guide both teams to focus on the end-user. By mapping the user journey, the teams can identify where standardization benefits the user (consistency, ease of use) and where bounded flexibility adds value (instructor branding) (Option B). Option A creates a chaotic UI. Option C ignores the instructors'' needs entirely. Option D creates technical debt and fragmentation.',
        ARRAY['platform_product_management', 'user_journey', 'standardization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Give the instructors full control; they are the talent that drives user subscriptions.', false),
    (v_q_id, 'B', 'Facilitate a user-journey workshop to determine where UI consistency benefits the end-user, and define bounded areas for instructor customization.', true),
    (v_q_id, 'C', 'Enforce strict standardization; customizing UI per class is a technical nightmare that must be avoided.', false),
    (v_q_id, 'D', 'Build a separate, custom app just for the instructors who want to change their UI.', false);

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
        'Discord''s Secret Pet Projects',
        E'A Discord engineering pod consistently misses sprint commitments. After some digging, the PM discovers the engineers are spending 30% of their time secretly building a pet project that isn''t on the roadmap.\n\nHow should the PM handle this discovery?',
        'intermediate',
        'Discord',
        'Voice, video and text chat app',
        'B',
        'When a team works on unauthorized projects, it indicates a breakdown in alignment and trust, which is a management issue. The PM must address this transparently with the Engineering Manager to realign incentives and focus (Option B). Publicly shaming them (Option A) destroys trust permanently. Doing nothing (Option C) harms the product. Canceling the roadmap (Option D) rewards bad behavior. The EM and PM need to work together to channel that engineering passion into aligned goals.',
        ARRAY['team_alignment', 'engineering_collaboration', 'transparency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Call out the engineers in the next sprint demo and publicly demand they delete the pet project.', false),
    (v_q_id, 'B', 'Have a private, transparent conversation with the Engineering Manager to address the misalignment and refocus the team on shared goals.', true),
    (v_q_id, 'C', 'Ignore it; engineers need creative outlets, and trying to stop them will just cause them to quit.', false),
    (v_q_id, 'D', 'Immediately pivot the roadmap to officially include their pet project so they stop hiding it.', false);

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
        'Netflix''s Content vs. Algorithm',
        E'The Netflix Content team spent $50M on a new original show that is performing poorly. The VP of Content pressures the PM to manually override the personalization algorithm to force the show to the top of everyone''s home screen.\n\nWhat is the PM''s best response?',
        'intermediate',
        'Netflix',
        'Video streaming service',
        'A',
        'Manually overriding core algorithms degrades trust in the product (users see irrelevant content) and corrupts the data. However, the business reality is that a $50M investment needs promotion. The PM should propose a dedicated, explicitly promotional UI surface (e.g., a ''New Releases'' or ''Featured'' banner) rather than silently breaking the core algorithmic rows (Option A). Option B degrades the core product. Option C is career-limiting and ignores business reality. Option D is deceptive.',
        ARRAY['algorithmic_integrity', 'business_vs_user', 'stakeholder_negotiation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Refuse to break the algorithm, but propose creating a dedicated, explicitly labeled ''Featured Originals'' banner to satisfy the promotion need.', true),
    (v_q_id, 'B', 'Comply with the request; a $50M investment must be protected at all costs.', false),
    (v_q_id, 'C', 'Tell the VP of Content that it''s their fault for greenlighting a bad show and the product team won''t bail them out.', false),
    (v_q_id, 'D', 'Pretend to update the algorithm but actually do nothing, hoping the VP forgets.', false);

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
        'Amazon''s Feuding Engineers',
        E'A conflict between two senior engineers at Amazon has escalated to the point where they refuse to review each other''s code, creating a massive bottleneck for your product launch.\n\nWhat is your role as the PM in resolving this?',
        'intermediate',
        'Amazon',
        'E-commerce and cloud computing',
        'D',
        'While this impacts the product, a PM is not an HR mediator or an Engineering Manager. Interpersonal feuds between engineers are strictly the purview of engineering leadership. The PM''s role is to clearly document the impact this feud is having on the product delivery and escalate to the Engineering Manager or Director to resolve the personnel issue (Option D). Acting as a therapist (Option A) oversteps boundaries. Reassigning work (Option B) treats the symptom, not the cause.',
        ARRAY['role_boundaries', 'escalation', 'team_dysfunction']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Act as an HR mediator and force them into a room until they resolve their personal differences.', false),
    (v_q_id, 'B', 'Change the project plan so the two engineers never have to work on the same components.', false),
    (v_q_id, 'C', 'Threaten to report both of them to the VP of Product if they don''t start reviewing the code.', false),
    (v_q_id, 'D', 'Document the precise impact the bottleneck is having on the launch timeline and escalate the personnel issue to the Engineering Manager.', true);

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
        'Duolingo''s Executive Standoff',
        E'The VP of Product and VP of Engineering at Duolingo are locked in a passive-aggressive standoff over migrating to a new tech stack. The VPs refuse to speak to each other, and all major feature development is frozen.\n\nHow can a Group PM unblock their specific team?',
        'advanced',
        'Duolingo',
        'Language learning app',
        'B',
        'When executives are gridlocked, sweeping top-down decisions fail. A savvy PM can break the deadlock by shrinking the scope of the risk. Proposing a small, localized pilot (e.g., migrating one low-risk microservice) allows both VPs to test the waters without conceding the larger argument (Option B). Quantifying the cost of delay also highlights the urgency. Option A is insubordination. Option C enables the dysfunction. Option D forces an unnecessary ultimatum.',
        ARRAY['executive_alignment', 'managing_up', 'pilot_programs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore the VPs entirely and instruct your team to build features on whatever stack the engineers prefer.', false),
    (v_q_id, 'B', 'Document the exact cost of the delay, and propose a low-risk, localized pilot on the new stack to bypass the all-or-nothing stalemate.', true),
    (v_q_id, 'C', 'Instruct your team to take a 3-week vacation while the executives sort out their politics.', false),
    (v_q_id, 'D', 'Send an ultimatum to the CEO demanding they fire one of the VPs to resolve the bottleneck.', false);

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
        'Canva''s Platform Power Dynamic',
        E'Canva''s Core Editor team constantly overrides the technical decisions of the Ecosystem (Plugin) team, breaking third-party plugins without warning. The Core team treats the Ecosystem team as second-class citizens.\n\nAs the Ecosystem PM, how do you resolve this systemic conflict?',
        'advanced',
        'Canva',
        'Graphic design platform',
        'C',
        'Systemic power dynamic conflicts cannot be solved with one-off meetings or complaints. They require structural, organizational changes. The Ecosystem PM must advocate for formalized boundaries, such as a documented API contract, deprecation policies, and a shared governance council (Option C). This turns subjective arguments into objective rule-following. Option A attacks the symptom. Option B damages the platform. Option D admits defeat.',
        ARRAY['platform_product_management', 'systemic_conflict', 'governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Complain to the Core PM every time a plugin breaks and demand they fix it immediately.', false),
    (v_q_id, 'B', 'Tell third-party developers that the Core team is to blame for all the breakages.', false),
    (v_q_id, 'C', 'Advocate for structural governance changes, such as strict API contracts and a required deprecation period for core changes.', true),
    (v_q_id, 'D', 'Accept that core features will always trump ecosystem features and stop advocating for third-party developers.', false);

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
        'Spotify''s Brilliant Jerk',
        E'A 10x engineer at Spotify is highly productive but incredibly toxic—belittling designers, aggressively shutting down ideas, and causing two designers to request transfers. The Engineering Manager is protecting the engineer because of their high output.\n\nWhat must the PM do?',
        'advanced',
        'Spotify',
        'Audio streaming platform',
        'C',
        'A ''brilliant jerk'' destroys more value than they create by crushing the productivity and retention of the rest of the team. When the direct EM protects them, the PM must document the broader damage to the product and team velocity and escalate beyond the EM (e.g., to the Director level) (Option C). Psychological safety is a prerequisite for good product development. Option A enables toxicity. Option B is passive-aggressive. Option D oversteps the PM role into HR territory.',
        ARRAY['team_culture', 'escalation', 'psychological_safety']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tolerate the behavior; delivering a great product requires thick skin, and the engineer''s output is too valuable to lose.', false),
    (v_q_id, 'B', 'Exclude the toxic engineer from all product and design meetings so they can only interact with code.', false),
    (v_q_id, 'C', 'Document the severe impact on team morale, retention, and overall velocity, and escalate the issue to the Director level.', true),
    (v_q_id, 'D', 'Fire the engineer yourself, asserting your authority as the ''CEO of the product.''', false);

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
        'Stripe''s Misaligned OKRs',
        E'Two Stripe product orgs are at war. Org A''s OKR is to ''Increase Total Payment Volume.'' Org B''s OKR is ''Reduce Fraud Rate.'' Org B deployed a strict verification flow that tanked Org A''s volume. Executives are screaming.\n\nHow do you resolve this structural conflict?',
        'advanced',
        'Stripe',
        'Payment processing platform',
        'D',
        'This is a classic OKR misalignment. When two orgs optimize opposing local maxima (Volume vs. Fraud), conflict is inevitable. The only solution is to redefine the incentive structure so both teams optimize for the same global maximum. The PM should propose a shared, synthesized metric, such as ''Risk-Adjusted Net Revenue'' or ''Good User Conversion'' (Option D). Option A and B just swing the pendulum. Option C ignores the structural flaw.',
        ARRAY['okrs', 'metric_alignment', 'organizational_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force Org B to roll back the verification flow; revenue is always more important than fraud prevention.', false),
    (v_q_id, 'B', 'Support Org B; a high fraud rate will eventually get Stripe dropped by credit card networks.', false),
    (v_q_id, 'C', 'Ask the engineers to make the verification flow look prettier so users don''t drop off as much.', false),
    (v_q_id, 'D', 'Draft a memo proposing a new shared, synthesized metric (e.g., ''Risk-Adjusted Net Revenue'') to realign both orgs'' incentives.', true);

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
        'Airbnb''s Executive Swoop-and-Poop',
        E'In a critical launch readiness meeting at Airbnb, the CEO suddenly tears apart the proposed design, overriding six months of rigorous user research. The team is demoralized.\n\nHow should the PM handle the CEO''s intervention?',
        'advanced',
        'Airbnb',
        'Travel and housing marketplace',
        'A',
        'When an executive ''swoops and poops,'' fighting them in the room usually backfires. The PM must maintain composure, acknowledge the feedback, and seek to understand the *root concern* driving the CEO''s reaction. Asking for time (Option A) allows the team to regroup, map the CEO''s concerns against the research, and return with a data-backed response or compromise. Option B destroys the team''s work. Option C is insubordinate and risky. Option D is confrontational.',
        ARRAY['executive_management', 'managing_up', 'resilience']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Acknowledge the feedback, ask probing questions to understand the CEO''s underlying concerns, and request 24 hours to review the data and present alternatives.', true),
    (v_q_id, 'B', 'Immediately agree with the CEO and order the team to scrap six months of work to redesign the feature.', false),
    (v_q_id, 'C', 'Tell the CEO they are wrong and that the data proves the current design is superior.', false),
    (v_q_id, 'D', 'Demand that the CEO trust the team they hired, or offer your resignation on the spot.', false);

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
        'Uber''s Crisis Finger-Pointing',
        E'During a massive outage of Uber''s critical driver safety feature, the Operations team and the Engineering team jump on a bridge call and immediately start blaming each other for the failure.\n\nAs the PM on the call, what is your immediate priority?',
        'advanced',
        'Uber',
        'Ride-hailing network',
        'C',
        'During a critical incident, resolving blame is irrelevant; resolving the outage is the only priority. The PM must assert leadership by establishing an incident command structure, explicitly pausing all root-cause debates until the system is mitigated (Option C). Option A wastes time in a crisis. Option B lets the chaos continue. Option D focuses on PR rather than fixing the life-safety issue.',
        ARRAY['incident_management', 'crisis_leadership', 'de_escalation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Facilitate a deep-dive 5 Whys analysis right then and there to definitively prove who caused the outage.', false),
    (v_q_id, 'B', 'Stay quiet; technical outages are engineering''s responsibility to manage.', false),
    (v_q_id, 'C', 'Assert control of the call, explicitly ban all root-cause discussions, and demand singular focus on mitigation and rollback steps.', true),
    (v_q_id, 'D', 'Immediately start drafting a public apology blog post while the teams argue.', false);

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
        'Slack''s Sabotaging Peer',
        E'You discover that a peer PM at Slack has been actively undermining your project in closed-door executive reviews, claiming your architecture is flawed, in an attempt to secure more headcount for their own team.\n\nHow do you handle this political sabotage?',
        'advanced',
        'Slack',
        'Business communication platform',
        'C',
        'Political sabotage requires a firm, professional, and direct response. The PM should use a structured feedback framework (like Situation-Behavior-Impact) to confront the peer directly, establishing a boundary before escalating (Option C). Retaliation (Option A) creates a toxic war. Quitting (Option B) lets the saboteur win. Immediately running to the boss (Option D) makes you look incapable of handling peer conflicts, though it is the required *next* step if the behavior continues.',
        ARRAY['office_politics', 'peer_conflict', 'direct_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Retaliate by finding flaws in their product and presenting them at the next executive review.', false),
    (v_q_id, 'B', 'Request an immediate transfer to a different org, as working in a politically toxic environment is impossible.', false),
    (v_q_id, 'C', 'Confront the peer directly and professionally using the SBI (Situation-Behavior-Impact) framework, warning them that further undermining will be escalated.', true),
    (v_q_id, 'D', 'Immediately go to the VP of Product and demand that your peer be fired for unprofessional conduct.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Conflict Resolution';

END $$;
