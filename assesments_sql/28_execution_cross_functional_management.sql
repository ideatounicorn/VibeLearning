-- ============================================
-- ASSESSMENT: Cross-functional Management
-- CATEGORY: Execution
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
    WHERE slug = 'cross-functional-mgmt';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug cross-functional-mgmt not found. Run the seed data first.';
    END IF;

    -- ----------------------------------------
    -- QUESTION 1 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        1,
        'Spotify''s Feature Kickoff',
        E'Spotify is kicking off a new collaborative playlist feature. The PM, Engineering Lead, and Product Designer are in the first planning meeting. The designer immediately starts sketching wireframes while the engineering lead discusses database schema changes. As the PM, what is the most critical cross-functional alignment action to take right now?',
        'foundational',
        'Spotify',
        'Consumer audio streaming',
        'C',
        E'The primary role of a PM in early cross-functional alignment is establishing the ''why'' (goals, user problem) and ''what'' (scope, success metrics). Option C correctly anchors the team on the user problem and goals before solutioning. Option A is premature optimization. Option B is micromanagement. Option D is a project management task that should follow goal alignment.',
        ARRAY['kickoff', 'role_clarity', 'alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Pause them and create a detailed RACI matrix to ensure no overlapping responsibilities during the project.', false),
    (v_q_id, 'B', E'Instruct the designer to stop sketching and focus on writing user stories with you instead.', false),
    (v_q_id, 'C', E'Steer the conversation back to aligning on the target user, the specific problem being solved, and the success metrics.', true),
    (v_q_id, 'D', E'Open a Jira board and immediately start creating epics to capture their technical and design ideas.', false);
    -- ----------------------------------------
    -- QUESTION 2 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        2,
        'Uber''s Legal Translation',
        E'Uber''s Legal team mandates that a new driver background check disclosure must be shown in the app within 2 weeks due to a new state law. The Legal team provides a 5-page PDF of dense legal text. How should the PM best handle this cross-functional handoff to Engineering and Design?',
        'foundational',
        'Uber',
        'Rideshare marketplace',
        'B',
        E'A key PM cross-functional skill is ''translating'' between domains. Option B shows the PM extracting the functional requirements for Design/Eng while maintaining the core compliance need. Option A abdicates the PM responsibility, leading to poor UX. Option C is risky because PMs shouldn''t rewrite legal text unilaterally. Option D is unnecessarily confrontational and ignores the compliance mandate.',
        ARRAY['legal_compliance', 'translation', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Attach the PDF to a Jira ticket and assign it to the frontend engineering lead to implement as a scrollable text box.', false),
    (v_q_id, 'B', E'Extract the specific constraints (e.g., must be a forced-scroll, explicit opt-in button) and brief Design to create a compliant but user-friendly flow.', true),
    (v_q_id, 'C', E'Rewrite the legal text to be concise and user-friendly, then send it directly to Engineering to implement.', false),
    (v_q_id, 'D', E'Push back on Legal, explaining that 5 pages of text violates Uber''s design principles, and refuse to build it until it''s shortened.', false);
    -- ----------------------------------------
    -- QUESTION 3 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        3,
        'Slack''s Launch Timeline Conflict',
        E'Slack is launching a new ''Huddles'' feature. Product Marketing (PMM) has secured a major TechCrunch exclusive for October 15th. On October 1st, Engineering informs the PM that a critical edge-case bug will take until October 18th to fix. What is the best cross-functional approach to resolve this?',
        'foundational',
        'Slack',
        'B2B SaaS communication',
        'D',
        E'Cross-functional tradeoffs require evaluating risk vs. reward with all context. Option D brings the right stakeholders together to make an informed business decision (launch with known bug, descale, or delay PR). Option A assumes Eng makes business decisions. Option B assumes PR trumps product quality without discussion. Option C is dishonest and damages trust.',
        ARRAY['gtm_alignment', 'launch_readiness', 'tradeoffs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Tell Marketing they must delay the PR piece to October 18th because Engineering owns the release criteria.', false),
    (v_q_id, 'B', E'Tell Engineering to skip the bug fix and launch anyway, as PR commitments cannot be broken.', false),
    (v_q_id, 'C', E'Hide the bug from Marketing so they don''t panic, and ask Engineering to work weekends to finish it secretly.', false),
    (v_q_id, 'D', E'Facilitate a meeting with Eng and PMM to assess the bug''s severity vs. the cost of moving the PR date, and jointly agree on a tradeoff.', true);
    -- ----------------------------------------
    -- QUESTION 4 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        4,
        'Airbnb''s Pixel Perfection',
        E'An Airbnb product squad is building a new booking flow. The Lead Designer is frustrated because the Engineering team''s implementation is missing subtle animations and the padding is off by a few pixels. Engineering says fixing it will delay the launch by a week. How should the PM intervene?',
        'foundational',
        'Airbnb',
        'Travel marketplace',
        'C',
        E'The PM''s role is to mediate conflicts by anchoring on user value and business impact. Option C evaluates whether the design details actually impact the goal, allowing for a rational prioritization decision. Option A blindly favors speed. Option B blindly favors design. Option D introduces unnecessary process overhead for a simple alignment issue.',
        ARRAY['design_eng_alignment', 'prioritization', 'conflict_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Side with Engineering; shipping fast is always more important than pixel-perfect design.', false),
    (v_q_id, 'B', E'Side with Design; Airbnb''s brand relies on premium aesthetics, so the launch must be delayed.', false),
    (v_q_id, 'C', E'Assess with both teams if the missing polish impacts usability or core metrics, and decide whether it''s a launch blocker or a fast-follow.', true),
    (v_q_id, 'D', E'Require the Designer and Engineer to write a joint memo explaining their disagreement to the VP of Product.', false);
    -- ----------------------------------------
    -- QUESTION 5 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        5,
        'Shopify''s Customer Escalation',
        E'A Shopify Customer Success Manager (CSM) constantly messages a PM directly on Slack, bypassing the standard Jira intake process to demand immediate bug fixes for their largest enterprise merchant. The PM''s engineering team is getting distracted. What is the best action for the PM?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'B',
        E'Establishing and enforcing cross-functional processes is key to protecting the team''s focus. Option B addresses the behavior directly but empathetically, explaining the ''why'' behind the process. Option A rewards the bad behavior. Option C is unnecessarily hostile. Option D is passive-aggressive and damages the relationship.',
        ARRAY['process_enforcement', 'stakeholder_management', 'customer_success']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Log the bugs in Jira on the CSM''s behalf to ensure the engineers see them without breaking process.', false),
    (v_q_id, 'B', E'Have a 1:1 with the CSM to explain how direct messaging bypasses triage and hurts the team''s ability to prioritize effectively, and enforce the Jira process.', true),
    (v_q_id, 'C', E'Escalate the CSM to the VP of Customer Success for violating the product development protocol.', false),
    (v_q_id, 'D', E'Ignore the Slack messages completely until the CSM realizes they need to use the proper channels.', false);
    -- ----------------------------------------
    -- QUESTION 6 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        6,
        'Notion''s Data Instrumentation',
        E'Notion is releasing a new block type. The PM asks the Data Analyst to build a dashboard for launch. The Analyst replies, ''The engineers didn''t add any telemetry to this feature, so I have no data to query.'' The engineers say, ''Telemetry wasn''t in the PRD.'' Where did the cross-functional process fail?',
        'foundational',
        'Notion',
        'Productivity SaaS',
        'C',
        E'Data requirements are product requirements. Option C correctly identifies that the PM failed to include data/analytics as a cross-functional requirement during the planning and spec phase. Option A blames the engineers for the PM''s omission. Option B misunderstands the Analyst''s role. Option D implies telemetry is optional.',
        ARRAY['data_alignment', 'prd', 'requirements_gathering']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Engineering failed to proactively add telemetry, which is a standard engineering best practice.', false),
    (v_q_id, 'B', E'The Data Analyst failed to review the engineering code to ensure their data needs were met.', false),
    (v_q_id, 'C', E'The PM failed to define tracking requirements and include the Data Analyst during the planning and spec phase.', true),
    (v_q_id, 'D', E'The process didn''t fail; telemetry should be a post-launch fast-follow to ensure launch speed.', false);
    -- ----------------------------------------
    -- QUESTION 7 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        7,
        'Stripe''s Engineering Pushback',
        E'A Stripe PM wants to build a new payment reconciliation dashboard. The Engineering Lead pushes back, stating the current backend architecture can''t support the real-time data the PM is asking for without a 3-month refactor. What is the best immediate response?',
        'foundational',
        'Stripe',
        'Fintech payment infrastructure',
        'B',
        E'When facing technical constraints, great PMs negotiate scope by focusing on the underlying user need rather than the specific solution. Option B seeks a compromise that delivers value without the massive cost. Option A ignores the technical reality. Option C gives up too easily. Option D forces an engineering decision without PM context.',
        ARRAY['technical_constraints', 'scope_negotiation', 'eng_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Insist that real-time data is a hard requirement and escalate to the VP of Engineering to secure the 3-month timeline.', false),
    (v_q_id, 'B', E'Ask the Engineering Lead if a slightly delayed data sync (e.g., hourly batches) would solve the user need while avoiding the 3-month refactor.', true),
    (v_q_id, 'C', E'Cancel the dashboard project since the technical cost is too high to justify the feature.', false),
    (v_q_id, 'D', E'Ask the Engineering Lead to design the dashboard UI since they know the backend constraints best.', false);
    -- ----------------------------------------
    -- QUESTION 8 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        8,
        'DoorDash''s Marketing Disconnect',
        E'DoorDash is launching a new ''DashPass for Students'' tier. One week before launch, the PM sees the Marketing team''s draft email campaign. It promises ''Free delivery on all restaurants,'' but the product only supports free delivery on ''Eligible restaurants.'' What should the PM do?',
        'foundational',
        'DoorDash',
        'Food delivery marketplace',
        'A',
        E'PMs must ensure GTM materials accurately reflect the product to avoid user trust issues and legal risks. Option A addresses the discrepancy immediately to prevent false advertising. Option B is technically impossible in a week. Option C hopes the problem goes away. Option D creates a terrible user experience.',
        ARRAY['gtm_alignment', 'marketing', 'launch_readiness']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Immediately contact Marketing to correct the copy to ''Eligible restaurants'' to avoid false advertising and user frustration.', true),
    (v_q_id, 'B', E'Tell Engineering they must urgently update the product to support ''All restaurants'' to match the Marketing copy.', false),
    (v_q_id, 'C', E'Let the email go out; the terms of service in the app will legally cover the ''Eligible restaurants'' restriction.', false),
    (v_q_id, 'D', E'Ask Design to make the ''Eligible'' badge very small in the app so users don''t notice the discrepancy.', false);
    -- ----------------------------------------
    -- QUESTION 9 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        9,
        'Figma''s Sales Enablement',
        E'Figma''s Enterprise Sales team is struggling to sell a new advanced security feature because they don''t understand how it works technically. They keep asking the PM to jump on sales calls. The PM is overwhelmed with calls. What is the most scalable cross-functional solution?',
        'foundational',
        'Figma',
        'Collaborative design software',
        'C',
        E'PMs must enable Sales scalably, not become a permanent crutch. Option C creates reusable assets and trains the trainers (Sales Enablement), fixing the root cause. Option A doesn''t solve the immediate problem. Option B scales poorly and distracts Eng. Option D is an unsustainable hero complex.',
        ARRAY['sales_enablement', 'scalability', 'cross_functional_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Tell the Sales team to read the technical API documentation on the developer portal.', false),
    (v_q_id, 'B', E'Assign an Engineer to join the sales calls instead, as they understand the technical details better.', false),
    (v_q_id, 'C', E'Partner with Product Marketing to create a comprehensive sales playbook, battle cards, and host a live training session for the Sales team.', true),
    (v_q_id, 'D', E'Continue taking the calls; being the primary technical salesperson is a core part of the Enterprise PM role.', false);
    -- ----------------------------------------
    -- QUESTION 10 (foundational)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        10,
        'Amazon''s Ops Alignment',
        E'An Amazon PM is launching a new digital feature that allows Prime members to request a specific 2-hour delivery window. The digital experience is built, but the PM hasn''t spoken to the fulfillment center operations team. Why is this a critical failure?',
        'foundational',
        'Amazon',
        'E-commerce and logistics',
        'C',
        E'In operations-heavy companies, digital features often have physical constraints. Option C identifies that a digital button is useless if the physical world cannot fulfill the promise. Option A is false (Ops is heavily involved). Option B is a secondary concern compared to capability. Option D relies on a mechanism that Ops must build/support.',
        ARRAY['ops_alignment', 'physical_digital_bridge', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Fulfillment center teams typically report to Product, so they should have been in the daily standups.', false),
    (v_q_id, 'B', E'The Operations team needs to approve the UI design of the delivery window selector.', false),
    (v_q_id, 'C', E'The digital feature creates a real-world operational requirement; if Ops isn''t staffed or equipped for precise windows, the feature will fail completely.', true),
    (v_q_id, 'D', E'Operations needs to know so they can manually email customers if the 2-hour window is missed.', false);
    -- ----------------------------------------
    -- QUESTION 11 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        11,
        'Netflix''s ML Integration',
        E'A Netflix PM is overseeing a new recommendation UI. The Data Science (DS) team has built a highly accurate model, but it takes 1.5 seconds to return results. The Frontend Engineering (FE) team says this violates the 300ms latency SLA for rendering the homepage. How should the PM navigate this?',
        'intermediate',
        'Netflix',
        'Streaming media',
        'B',
        E'Cross-functional PMs must facilitate trade-offs between accuracy (DS) and performance (FE). Option B explores caching or async loading, solving both needs (accuracy + perceived performance). Option A ignores the UX impact. Option C ignores the DS value. Option D relies on a potentially impossible mandate.',
        ARRAY['data_science', 'engineering', 'latency_vs_accuracy', 'tradeoffs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Tell FE to accept the 1.5s latency because recommendation accuracy is the primary driver of retention.', false),
    (v_q_id, 'B', E'Facilitate a discussion between DS and FE to explore caching strategies, pre-computing recommendations, or using UI skeleton states.', true),
    (v_q_id, 'C', E'Tell DS to scrap the model and use a simpler, less accurate algorithm that returns in 200ms.', false),
    (v_q_id, 'D', E'Dictate that DS must optimize their model to 300ms by next week, regardless of how they do it.', false);
    -- ----------------------------------------
    -- QUESTION 12 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        12,
        'Shopify''s Matrix Conflict',
        E'A PM on Shopify''s ''Checkout'' team wants to use a new, faster UI framework. However, the ''Platform'' team mandates that all teams use the older, standardized internal UI library to maintain global consistency. The Checkout PM knows the new framework will increase conversion by 2%. What is the best approach?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'D',
        E'Matrix orgs require navigating platform standards vs. local team goals. Option D shows structural negotiation—partnering with the platform team to prove value and potentially update the standard for everyone, rather than going rogue or giving up. Option A creates massive technical debt. Option C is passive. Option B escalates prematurely.',
        ARRAY['matrix_organization', 'platform_vs_product', 'negotiation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Secretly build the checkout feature using the new framework; it''s easier to ask forgiveness than permission.', false),
    (v_q_id, 'B', E'Escalate immediately to the CEO to force the Platform team to make an exception for Checkout.', false),
    (v_q_id, 'C', E'Abandon the new framework and accept the lower conversion rate to comply with Platform standards.', false),
    (v_q_id, 'D', E'Propose an A/B test with the new framework to the Platform team, using the data to justify either an exception or upgrading the global standard.', true);
    -- ----------------------------------------
    -- QUESTION 13 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        13,
        'GitHub''s Misaligned Incentives',
        E'GitHub''s Enterprise PM team is mandated to increase paid seat licenses (Sales-driven OKR). Meanwhile, the Open Source community PM team is mandated to remove friction for free collaborative projects (Growth-driven OKR). A proposed feature limits repository collaborators for free users. How should the cross-functional PM group resolve this?',
        'intermediate',
        'GitHub',
        'Developer tooling platform',
        'C',
        E'Conflicting OKRs between product lines require elevating the discussion to company-level strategy. Option C frames the conflict correctly as a strategic trade-off, not a localized squabble. Option A relies on false compromise. Option B makes the user experience chaotic. Option D assumes one team''s OKRs inherently trump the other''s without executive alignment.',
        ARRAY['okr_conflict', 'portfolio_management', 'strategic_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Compromise by limiting free collaborators, but making the limit high enough that it barely affects anyone.', false),
    (v_q_id, 'B', E'A/B test the limitation on 50% of users to see which team''s metric improves more.', false),
    (v_q_id, 'C', E'Escalate the structural conflict to Product Leadership to clarify the company''s macro-prioritization between Enterprise revenue and Open Source market share.', true),
    (v_q_id, 'D', E'The Enterprise PM should override the Open Source PM, as revenue-generating features always take precedence.', false);
    -- ----------------------------------------
    -- QUESTION 14 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        14,
        'Discord''s Trust & Safety Block',
        E'A Discord Growth PM is launching a one-click server creation flow. Two days before launch, Trust & Safety (T&S) blocks the release, citing a high risk of spam bot proliferation. The Growth PM''s OKR depends on this launch. What is the most constructive step?',
        'intermediate',
        'Discord',
        'Community communication platform',
        'B',
        E'T&S and Growth often conflict. Good PMs treat T&S as a partner, not a blocker. Option B collaboratively seeks a solution (rate limits/captchas) that satisfies T&S guardrails while preserving most of the Growth goal. Option A is reckless. Option C is defeatist. Option D wastes time arguing rather than problem-solving.',
        ARRAY['trust_and_safety', 'growth', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Launch anyway; Growth OKRs are paramount, and T&S can clean up the spam bots later.', false),
    (v_q_id, 'B', E'Work with T&S to define acceptable risk thresholds and implement fast-follow mitigations like rate-limiting or CAPTCHAs for suspicious IPs.', true),
    (v_q_id, 'C', E'Cancel the launch and miss the OKR, acknowledging that T&S has ultimate veto power.', false),
    (v_q_id, 'D', E'Demand T&S provide concrete proof that spam bots will increase before accepting their block.', false);
    -- ----------------------------------------
    -- QUESTION 15 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        15,
        'Airbnb''s Local Market Launch',
        E'Airbnb is launching ''Experiences'' in Tokyo. The PM needs alignment from Product, Local Ops, Legal, and Marketing. Ops says they need 3 months to onboard hosts. Marketing wants to announce in 1 month during a major festival. Engineering says the app localization takes 2 months. How should the PM sequence this?',
        'intermediate',
        'Airbnb',
        'Travel marketplace',
        'D',
        E'Complex cross-functional launches require identifying the critical path and aligning all functions around reality, not desire. Option D correctly identifies Ops as the long pole (3 months) and forces Marketing to align with the actual delivery date. Option A creates a disastrous user experience. Option B is a disjointed launch. Option C ignores engineering constraints.',
        ARRAY['launch_sequencing', 'critical_path', 'gtm_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Launch the Marketing campaign in 1 month, let users download the unlocalized app, and tell Ops to rush onboarding.', false),
    (v_q_id, 'B', E'Let Marketing launch in 1 month, Engineering in 2 months, and Ops in 3 months so each team hits their own goals.', false),
    (v_q_id, 'C', E'Force Ops to finish in 1 month to meet the Marketing deadline, regardless of host quality.', false),
    (v_q_id, 'D', E'Identify Ops (3 months) as the critical path, align all teams to a single launch date in 3 months, and ask Marketing to pivot their campaign.', true);
    -- ----------------------------------------
    -- QUESTION 16 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        16,
        'Spotify''s Hardware Integration',
        E'Spotify is building software for a new partner smartwatch. The external hardware partner operates on a strict waterfall schedule with a 6-month code freeze prior to manufacturing. The Spotify agile software squad is used to weekly sprints and CI/CD. How does the PM manage this impedance mismatch?',
        'intermediate',
        'Spotify',
        'Audio streaming',
        'C',
        E'Integrating agile software with waterfall hardware requires hybrid planning. Option C bridges the gap by mapping agile milestones to the hardware''s rigid milestones (code freeze). Option A is impossible for the hardware partner. Option B destroys the software team''s velocity. Option D creates massive integration risk at the end.',
        ARRAY['agile_vs_waterfall', 'partner_management', 'process_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Force the hardware partner to adopt two-week sprints so they align with the software squad''s cadence.', false),
    (v_q_id, 'B', E'Switch the software squad to a 6-month waterfall process to perfectly mirror the partner.', false),
    (v_q_id, 'C', E'Maintain software sprints, but establish a cross-functional milestone roadmap that aligns specific software deliverables to the partner''s rigid integration and freeze dates.', true),
    (v_q_id, 'D', E'Let the software squad work independently and hand over the code one week before the hardware partner''s manufacturing date.', false);
    -- ----------------------------------------
    -- QUESTION 17 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        17,
        'Slack''s Executive Swoop',
        E'During a sprint, the CEO of Slack directly messages an engineer, bypassing the PM, asking them to immediately change the color of the notification badge because ''it feels off.'' The engineer drops their planned sprint work to do this. How should the PM handle this cross-functional disruption?',
        'intermediate',
        'Slack',
        'B2B SaaS',
        'C',
        E'Executive swooping destroys team focus. The PM must shield the team while managing up. Option C addresses the engineer''s reaction (coaching them on process) and manages the CEO (redirecting requests through the PM). Option A is passive. Option B is overly confrontational. Option D ignores the process breakdown.',
        ARRAY['executive_management', 'sprint_protection', 'communication_channels']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Accept that the CEO has ultimate authority and adjust the sprint backlog to accommodate the lost time.', false),
    (v_q_id, 'B', E'Publicly call out the CEO in the #general channel for breaking sprint protocol and distracting the team.', false),
    (v_q_id, 'C', E'Privately ask the engineer to route future executive requests to you, and sync with the CEO to understand the context and funnel requests through the backlog.', true),
    (v_q_id, 'D', E'Tell the engineer to revert the code change immediately until the CEO writes a PRD for the color change.', false);
    -- ----------------------------------------
    -- QUESTION 18 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        18,
        'Stripe''s API Versioning Dilemma',
        E'Stripe is deprecating an old API. Core Engineering wants to shut it down in 30 days to remove tech debt. Developer Relations (DevRel) says merchants need at least 6 months to migrate or Stripe will face massive churn. As the PM, how do you resolve this?',
        'intermediate',
        'Stripe',
        'Developer API / Fintech',
        'D',
        E'Deprecating APIs is a high-stakes cross-functional negotiation between Eng efficiency and customer impact. Option D uses data to bridge the gap, targeting the timeline based on actual migration difficulty rather than arbitrary dates. Option A ignores customer pain. Option B ignores engineering costs. Option C assumes a false dichotomy.',
        ARRAY['deprecation', 'devrel', 'engineering_alignment', 'data_driven']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Side with Engineering; 30 days is standard, and merchants who don''t migrate are acceptable churn.', false),
    (v_q_id, 'B', E'Side with DevRel; the API must be supported indefinitely to ensure zero churn.', false),
    (v_q_id, 'C', E'Split the difference and agree on exactly 3.5 months to make both sides equally unhappy.', false),
    (v_q_id, 'D', E'Pull API usage data to quantify the revenue at risk, categorize merchants by migration complexity, and build a phased shutdown plan with DevRel and Eng.', true);
    -- ----------------------------------------
    -- QUESTION 19 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        19,
        'Notion''s Crowded Rituals',
        E'A Notion squad has grown to include 1 PM, 6 Engineers, 2 Designers, 1 QA, 1 Data Analyst, 1 PMM, and 1 User Researcher. Their daily standup now takes 45 minutes, and engineers are complaining it''s a waste of time. How should the PM fix this cross-functional ritual?',
        'intermediate',
        'Notion',
        'Productivity SaaS',
        'B',
        E'Not all cross-functional partners need to be in every daily operational ritual. Option B correctly identifies that standups are for the core delivery team (Eng/Design/QA) and separates broader stakeholder alignment into a different cadence. Option A doesn''t solve the bloated group size. Option C eliminates visibility entirely. Option D creates fragmented silos.',
        ARRAY['agile_rituals', 'team_topology', 'process_efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Implement a strict 1-minute timer per person during the standup.', false),
    (v_q_id, 'B', E'Limit the daily standup to the core delivery team (Eng, Design, QA), and set up a separate weekly sync for broader cross-functional alignment (Data, PMM, UXR).', true),
    (v_q_id, 'C', E'Cancel the daily standup and move all updates to a Slack thread to save time.', false),
    (v_q_id, 'D', E'Split the team into three different standups (Eng standup, Design standup, Business standup).', false);
    -- ----------------------------------------
    -- QUESTION 20 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        20,
        'DoorDash''s Promo Chaos',
        E'A DoorDash PM notices a sudden 500% spike in orders for a specific ice cream chain, causing massive delivery delays and driver shortages in 3 cities. After digging, the PM realizes Marketing launched a ''99-cent ice cream'' push notification without telling Product or Ops. What is the key systemic fix?',
        'intermediate',
        'DoorDash',
        'Logistics marketplace',
        'C',
        E'When teams operate in silos and cause system strain, the PM must build guardrails. Option C establishes a systemic cross-functional review process for high-impact actions. Option A is a band-aid. Option B limits marketing artificially. Option D removes marketing autonomy entirely.',
        ARRAY['systemic_fixes', 'marketing_ops_alignment', 'guardrails']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Write a script to automatically cancel orders when driver supply drops below a certain threshold.', false),
    (v_q_id, 'B', E'Demand that Marketing never run discounts greater than 10% in the future.', false),
    (v_q_id, 'C', E'Establish a cross-functional ''campaign review'' process where Ops and Product must sign off on promotions projected to increase local volume by >20%.', true),
    (v_q_id, 'D', E'Revoke Marketing''s access to the push notification tool and require the PM to send all emails.', false);
    -- ----------------------------------------
    -- QUESTION 21 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        21,
        'Instagram''s Algorithm Conflict',
        E'Instagram''s Feed PM is evaluating a new ranking algorithm. Data Science proves it increases time-in-app by 5%. However, User Research (UXR) shares a qualitative study showing the algorithm makes users feel ''anxious and overwhelmed.'' How should the PM weigh this cross-functional input?',
        'intermediate',
        'Instagram',
        'Social media',
        'D',
        E'Quantitative data (DS) tells you *what* is happening; qualitative data (UXR) tells you *why*. A PM must synthesize both. Option D investigates the root cause of the anxiety, suspecting that short-term engagement might lead to long-term churn. Option A blindly follows metrics. Option B blindly ignores metrics. Option C is a disjointed user experience.',
        ARRAY['data_vs_uxr', 'qual_vs_quant', 'synthesis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Ship the algorithm; quantitative metrics at scale always trump small-sample qualitative research.', false),
    (v_q_id, 'B', E'Block the algorithm entirely; user sentiment is always more important than engagement metrics.', false),
    (v_q_id, 'C', E'Ship the algorithm, but add a prominent ''Take a Break'' button to solve the anxiety issue.', false),
    (v_q_id, 'D', E'Synthesize the findings: hypothesize that the 5% increase is ''doomscrolling'' which may cause long-term churn, and ask DS to measure long-term retention of the test cohort.', true);
    -- ----------------------------------------
    -- QUESTION 22 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        22,
        'WhatsApp''s Privacy PR Crisis',
        E'WhatsApp is updating its privacy policy to allow minimal data sharing with business accounts. Legal requires the update. Product builds the consent flow. When it launches, users panic, thinking WhatsApp is reading their private messages. What cross-functional step was missed?',
        'intermediate',
        'WhatsApp',
        'Messaging application',
        'A',
        E'Legal changes often require Comms/PR alignment to manage user perception. Option A correctly identifies that Legal mandates the text, but Comms/PMM must wrap it in a narrative that prevents panic. Option B blames Engineering for a communications issue. Option C blames Legal for doing their job. Option D focuses on UX, not the core narrative.',
        ARRAY['comms_pr', 'legal', 'crisis_prevention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'The PM failed to loop in Communications/PR to craft a proactive narrative explaining what is NOT changing (e.g., end-to-end encryption remains).', true),
    (v_q_id, 'B', E'Engineering failed to make the ''Accept'' button prominent enough, leading to user frustration.', false),
    (v_q_id, 'C', E'Legal failed to write the policy in a way that users would enthusiastically accept.', false),
    (v_q_id, 'D', E'Design failed to add enough illustrations to the consent screen to make it feel friendly.', false);
    -- ----------------------------------------
    -- QUESTION 23 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        23,
        'Figma''s Acquisition Integration',
        E'Figma acquires a small whiteboard startup to help build FigJam. The startup engineers are used to shipping straight to production with no QA. Figma''s core engineers require strict peer reviews and QA sign-off. Tension is rising. As the integration PM, how do you manage this culture clash?',
        'intermediate',
        'Figma',
        'Design software acquisition',
        'B',
        E'Post-acquisition integration requires blending cultures deliberately. Option B acknowledges the value of both (speed vs. quality) and actively facilitates a new shared norm. Option A crushes the startup''s agility. Option C lowers Figma''s quality bar dangerously. Option D creates two separate, resentful subcultures.',
        ARRAY['acquisition_integration', 'engineering_culture', 'process_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Immediately enforce Figma''s strict processes on the startup engineers; they must adapt to the acquirer.', false),
    (v_q_id, 'B', E'Facilitate a joint engineering workshop to define a ''middle-ground'' process for the FigJam team, balancing the startup''s velocity with Figma''s reliability standards.', true),
    (v_q_id, 'C', E'Let the startup engineers bypass QA entirely to maintain their morale and velocity.', false),
    (v_q_id, 'D', E'Keep the two engineering teams completely separated so they don''t have to interact.', false);
    -- ----------------------------------------
    -- QUESTION 24 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        24,
        'Discord''s Platform Dependency',
        E'A Discord PM is building a new ''Voice Effects'' feature, which relies heavily on the ''Core Audio'' platform team to provide a new API. The Core Audio team keeps delaying the API due to their own OKRs. The Voice Effects PM is blocked. What is the most effective escalation path?',
        'intermediate',
        'Discord',
        'Platform dependencies',
        'C',
        E'When blocked by a dependency, PMs must elevate the conversation from a localized conflict to a company-priority level. Option C brings the respective leaders together to align on which project is more important to the company. Option A is passive. Option B violates codebase boundaries and risks instability. Option D wastes time on bureaucracy.',
        ARRAY['dependency_management', 'escalation', 'platform_teams']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Wait patiently until the Core Audio team finishes their OKRs; you cannot rush platform teams.', false),
    (v_q_id, 'B', E'Have your engineers fork the Core Audio codebase and build the API themselves to unblock the feature.', false),
    (v_q_id, 'C', E'Escalate to the Product/Engineering Directors above both teams to get a ruling on which team''s OKR is the higher company priority.', true),
    (v_q_id, 'D', E'Create a highly detailed Gantt chart showing the delay and email it to the Core Audio team daily.', false);
    -- ----------------------------------------
    -- QUESTION 25 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        25,
        'Shopify''s Sales Promise',
        E'Shopify''s VP of Enterprise Sales promises a massive prospective merchant that a custom inventory feature will be ready in 3 weeks if they sign the contract. The Sales VP then tells the PM to drop everything and build it. The feature would take 8 weeks. How should the PM respond?',
        'intermediate',
        'Shopify',
        'Enterprise SaaS sales',
        'B',
        E'PMs must manage rogue sales promises by injecting reality without killing the deal. Option B seeks to understand the root need and offers a realistic workaround (manual process + real timeline) to save the deal without destroying engineering capacity. Option A submits to bullying. Option C kills the deal aggressively. Option D relies on deceit.',
        ARRAY['sales_alignment', 'managing_up', 'scope_negotiation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Tell engineering to work nights and weekends to hit the 3-week deadline to secure the major contract.', false),
    (v_q_id, 'B', E'Meet with the Sales VP, explain the 8-week reality, and propose a manual workaround (concierge onboarding) for the first 5 weeks while the feature is built.', true),
    (v_q_id, 'C', E'Refuse to build the feature, stating that Sales cannot dictate the product roadmap under any circumstances.', false),
    (v_q_id, 'D', E'Tell the Sales VP it will be ready in 3 weeks, but launch a completely fake UI button to buy time.', false);
    -- ----------------------------------------
    -- QUESTION 26 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        26,
        'Amazon''s Two-Pizza Team Gap',
        E'An Amazon squad is operating as a ''two-pizza team'' building a new checkout widget. They have Eng, Design, and QA, but no dedicated Product Marketing Manager (PMM). Launch is in two weeks, and they need a go-to-market plan. What should the PM do?',
        'intermediate',
        'Amazon',
        'Resource constraints',
        'D',
        E'When a cross-functional role is missing, the PM must fill the gap or find fractional support. Option D shows the PM stepping up to draft the materials and utilizing a central team for review, ensuring the work gets done adequately. Option A ignores the GTM need. Option B is an unrealistic demand. Option C asks the wrong discipline to do the job.',
        ARRAY['role_gaps', 'gtm_alignment', 'adaptability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Skip the marketing plan; if there''s no PMM, it''s not the squad''s responsibility to market the feature.', false),
    (v_q_id, 'B', E'Delay the launch indefinitely until HR hires a dedicated PMM for the squad.', false),
    (v_q_id, 'C', E'Assign the UX Designer to write the marketing emails and blog posts, as they are the most creative person on the team.', false),
    (v_q_id, 'D', E'Draft the GTM plan and copy yourself, and ask the centralized Marketing team for a 30-minute review to ensure brand compliance.', true);
    -- ----------------------------------------
    -- QUESTION 27 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        27,
        'GitHub''s Open Source vs Enterprise',
        E'GitHub is rolling out a new CI/CD interface. The Open Source (OS) PM and the Enterprise PM disagree. OS wants the UI to default to public actions. Enterprise wants it to default to strict internal environments. How do you resolve this design conflict?',
        'intermediate',
        'GitHub',
        'Multi-segment product',
        'C',
        E'When user segments have conflicting needs, the solution is often contextual configuration rather than a one-size-fits-all compromise. Option C leverages the context (account type) to deliver the right default for each segment. Option A alienates Enterprise. Option B alienates OS. Option D creates unnecessary UI friction for everyone.',
        ARRAY['segment_conflict', 'design_alignment', 'product_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Default to public actions, as GitHub''s roots are in open source.', false),
    (v_q_id, 'B', E'Default to strict internal environments, as Enterprise pays the bills.', false),
    (v_q_id, 'C', E'Work with Engineering to build a context-aware default: it defaults to public for free accounts, and internal for enterprise SSO accounts.', true),
    (v_q_id, 'D', E'Force every user to manually select their default setting every time they open the page.', false);
    -- ----------------------------------------
    -- QUESTION 28 (intermediate)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        28,
        'Uber''s Ops Heavy Launch',
        E'Uber is launching a feature requiring drivers to upload a photo of their vehicle inspection. Ops must manually verify these photos. The PM expects 10,000 uploads on day 1. Ops currently has 5 reviewers who can do 100 per day each. What is the PM''s failure here?',
        'intermediate',
        'Uber',
        'Operations scaling',
        'A',
        E'Digital products with human-in-the-loop workflows must calculate operational capacity. Option A correctly identifies the math failure (10k demand vs 500 capacity). A PM must align feature rollout speed with Ops scaling (e.g., phased rollout, auto-approval heuristics). Option B blames Ops. Option C is a UX problem. Option D is irrelevant.',
        ARRAY['capacity_planning', 'ops_alignment', 'human_in_the_loop']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'The PM failed to model the operational capacity constraints and didn''t design a phased rollout to match Ops'' throughput.', true),
    (v_q_id, 'B', E'Ops failed to proactively hire 95 more reviewers in anticipation of the product launch.', false),
    (v_q_id, 'C', E'The PM failed to make the photo upload button prominent enough.', false),
    (v_q_id, 'D', E'Engineering failed to compress the photo files, which will slow down the reviewers.', false);
    -- ----------------------------------------
    -- QUESTION 29 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        29,
        'Netflix''s Competing OKRs',
        E'Netflix''s Q3 OKRs are locked. The PM''s OKR is ''Increase feature adoption by 15%.'' The Engineering Lead''s OKR, set by the VP of Eng, is ''Reduce technical debt by migrating 40% of microservices.'' The engineering team only has capacity for one. How should the PM navigate this structural misalignment?',
        'advanced',
        'Netflix',
        'Executive misalignment',
        'B',
        E'When OKRs conflict structurally at the VP level, PMs cannot resolve it at the squad level. Option B correctly identifies this as a leadership alignment issue and forces the VPs to clarify the priority. Option A guarantees failure for the PM. Option C relies on shadow work. Option D damages the relationship with the Eng Lead.',
        ARRAY['okr_alignment', 'executive_escalation', 'matrix_conflict']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Accept that technical debt is more important and pause all feature work, knowing you will fail your own OKR.', false),
    (v_q_id, 'B', E'Draft a joint memo with the Eng Lead outlining the capacity conflict, and escalate to both the VP of Product and VP of Eng to decide the macro-priority.', true),
    (v_q_id, 'C', E'Convince the engineers to work on features during the day and migrate microservices at night.', false),
    (v_q_id, 'D', E'Ignore the Eng Lead''s OKR and write Jira tickets for features, forcing the engineers to pick them up.', false);
    -- ----------------------------------------
    -- QUESTION 30 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        30,
        'Airbnb''s VP Design Disagreement',
        E'Airbnb''s VP of Design halts a major checkout redesign one week before launch, claiming it ''lacks the Airbnb soul,'' despite the PM and VP of Eng showing data that it increases conversion by 4%. The squad is demoralized. How do you handle this high-level cross-functional roadblock?',
        'advanced',
        'Airbnb',
        'Executive stakeholder management',
        'C',
        E'Advanced PMs know how to isolate subjective executive feedback into actionable constraints. Option C respectfully acknowledges the VP''s authority but forces them to pinpoint exactly what ''soul'' means in this context, translating subjective emotion into objective design criteria. Option A is insubordination. Option B accepts a vague critique. Option D wastes time starting from scratch.',
        ARRAY['executive_stakeholders', 'design_leadership', 'translation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Launch the feature anyway, citing the 4% conversion increase as justification.', false),
    (v_q_id, 'B', E'Apologize to the VP, scrap the redesign, and tell the squad to try harder next time.', false),
    (v_q_id, 'C', E'Schedule an emergency review to ask the VP of Design to specifically identify which components lack ''soul'', translating the subjective feedback into actionable fixes.', true),
    (v_q_id, 'D', E'Ask Engineering to rebuild the old checkout flow immediately.', false);
    -- ----------------------------------------
    -- QUESTION 31 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        31,
        'Uber''s Emergency Regulatory Shutdown',
        E'A European city abruptly passes a law banning Uber''s core service effective in 48 hours. The PM must orchestrate a shutdown. Legal needs to comply. Ops needs to notify drivers. Comms needs a PR statement. Eng needs to geo-fence the app. What is the PM''s immediate move?',
        'advanced',
        'Uber',
        'Crisis management',
        'D',
        E'In an existential cross-functional crisis, asynchronous communication fails. You need a war room. Option D establishes immediate, synchronous alignment, assigns a clear DRI for the incident, and sequences the dependent steps. Option A is too slow. Option B is chaotic. Option C is incomplete.',
        ARRAY['crisis_management', 'war_room', 'orchestration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Create a Slack channel, invite everyone, and ask them to post their status updates by end of day.', false),
    (v_q_id, 'B', E'Immediately tell Engineering to turn off the app in that city, then figure out Comms and Ops later.', false),
    (v_q_id, 'C', E'Focus entirely on writing the PR statement, as the public fallout is the biggest risk.', false),
    (v_q_id, 'D', E'Call an immediate cross-functional ''war room'' meeting to establish a runbook, designate an incident commander, and sequence the shutdown steps hour-by-hour.', true);
    -- ----------------------------------------
    -- QUESTION 32 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        32,
        'Stripe''s Multi-Year Initiative',
        E'A Stripe PM is leading a 2-year initiative to rebuild the billing engine. After 8 months, cross-functional momentum is dying. Engineering velocity has dropped, Marketing has stopped asking about it, and Sales thinks it''s a myth. How do you reinvigorate cross-functional alignment?',
        'advanced',
        'Stripe',
        'Long-term program management',
        'C',
        E'Massive, multi-year projects die of exhaustion if they lack intermediate milestones. Option C solves this by carving out a tangible, shipable piece of value to prove momentum and re-engage stakeholders. Option A just adds meetings. Option B shifts blame. Option D abandons a strategic initiative due to poor management.',
        ARRAY['long_term_projects', 'momentum', 'milestones']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Schedule a weekly 2-hour status meeting with all stakeholders to force them to pay attention.', false),
    (v_q_id, 'B', E'Write a memo to the CEO complaining that the cross-functional teams lack commitment.', false),
    (v_q_id, 'C', E'Work with Engineering to carve out a ''v0.1'' milestone that delivers tangible value to a small subset of users in 6 weeks, and host an internal demo day.', true),
    (v_q_id, 'D', E'Cancel the initiative, as 8 months is too long to go without launching.', false);
    -- ----------------------------------------
    -- QUESTION 33 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        33,
        'Spotify''s Re-org Transition',
        E'Spotify announces a massive re-org, moving from functional silos (all engineers report to Eng Managers) to cross-functional autonomous ''Squads'' (Eng, Design, PM report to a single Squad Leader). Your new squad is confused about who owns what. How do you establish the new operating model?',
        'advanced',
        'Spotify',
        'Organizational design',
        'B',
        E'Re-orgs create chaos. A PM must explicitly redefine the rules of engagement. Option B uses a structured framework (RACI/DACI) to explicitly map out the new realities of decision-making, removing ambiguity. Option A relies on hope. Option C is an authoritarian land grab. Option D defers to leadership for team-level norms.',
        ARRAY['re_org', 'raci', 'team_formation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Let the team figure it out organically over a few sprints; imposing structure early kills autonomy.', false),
    (v_q_id, 'B', E'Facilitate a DACI/RACI workshop with the new squad to explicitly define who is the driver, approver, and contributor for product, technical, and design decisions.', true),
    (v_q_id, 'C', E'Announce that as the PM, you are the CEO of the squad and have final say on all engineering and design decisions.', false),
    (v_q_id, 'D', E'Ask HR to provide a document explaining how squads are supposed to work.', false);
    -- ----------------------------------------
    -- QUESTION 34 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        34,
        'Slack''s Escalation Structure',
        E'Slack''s Enterprise squad is constantly disrupted by Sales escalating ''critical'' missing features for high-value prospects. The PM spends 60% of their time arguing with Sales Directors over Jira tickets. What is the advanced systemic solution?',
        'advanced',
        'Slack',
        'Systemic process design',
        'C',
        E'When escalation becomes the norm, the intake process is broken. Option C builds a quantified, objective rubric aligned with company strategy, moving the conversation from ''who yells loudest'' to ''what is the ARR impact.'' Option A ignores the business reality of enterprise sales. Option B creates a parallel, inefficient track. Option D burns out the PM.',
        ARRAY['sales_escalations', 'process_design', 'intake_rubric']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Block all Sales Directors on Slack and tell them to submit ideas through a generic Google Form.', false),
    (v_q_id, 'B', E'Dedicate 50% of engineering capacity to a ''Sales Demands'' track to keep them happy.', false),
    (v_q_id, 'C', E'Partner with Sales Leadership to build a quantified intake rubric (e.g., minimum ARR threshold, strategic fit) that all requests must pass before reaching the squad.', true),
    (v_q_id, 'D', E'Continue fighting ticket-by-ticket; defending the backlog is just the reality of enterprise PMing.', false);
    -- ----------------------------------------
    -- QUESTION 35 (advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        35,
        'Figma''s Shadow PMing',
        E'A highly respected Staff Engineer at Figma starts ''shadow PMing''—writing PRDs, defining scope, and promising features to marketing without consulting the PM. The team loves this engineer. How do you re-establish your PM role without creating an enemy?',
        'advanced',
        'Figma',
        'Role boundaries and ego',
        'B',
        E'Advanced PMs handle ''shadow PMs'' not by fighting them, but by judo-ing their energy. Option B validates the engineer''s passion while clearly delineating responsibilities, turning a competitor into a powerful partner. Option A creates a turf war. Option C abdicates the PM role. Option D destroys team morale.',
        ARRAY['shadow_pm', 'role_boundaries', 'engineering_partnership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'Publicly call out the engineer in the next team meeting for overstepping their boundaries.', false),
    (v_q_id, 'B', E'Have a private 1:1, praise their product sense, and propose dividing and conquering: they own the technical architecture and feasibility, you own the user problem and GTM alignment.', true),
    (v_q_id, 'C', E'Let the engineer act as the PM, and transition yourself to more of a project management/scrum master role.', false),
    (v_q_id, 'D', E'Report the engineer to their manager for violating the standard career ladder expectations.', false);


    RAISE NOTICE 'Successfully inserted 35 questions for Cross-functional Management';

END $$;
