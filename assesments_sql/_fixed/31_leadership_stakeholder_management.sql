-- ============================================
-- ASSESSMENT: Stakeholder Management
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
    WHERE slug = 'stakeholder-management';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug stakeholder-management not found. Run the seed data first.';
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
        'Uber''s Stakeholder Power/Interest',
        E'An Uber Product Manager is launching a minor update to the driver earnings dashboard UI. The VP of Global Operations has immense power over the driver platform but has very low interest in this specific, minor UI tweak.\n\nAccording to the Power/Interest grid, how should the PM engage this VP?',
        'foundational',
        'Uber',
        'Minor UI update to driver earnings',
        'C',
        'In stakeholder mapping, a stakeholder with High Power but Low Interest should be ''Kept Satisfied''. This means providing brief, high-level updates to ensure they are aware, but avoiding overwhelming them with deep details. Option A (Manage Closely) is for High Power/High Interest. Option B (Keep Informed) is for Low Power/High Interest. Option D is a common junior mistake; ignoring high-power stakeholders risks them blocking the project later if they feel blindsided.',
        ARRAY['stakeholder_mapping', 'power_interest_grid']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Manage them closely by inviting them to weekly tactical design reviews.', false),
    (v_q_id, 'B', 'Keep them informed by sending detailed daily progress reports.', false),
    (v_q_id, 'C', 'Keep them satisfied with brief, high-level updates and avoid overwhelming them.', true),
    (v_q_id, 'D', 'Monitor them passively and do not communicate unless they ask.', false);

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
        'Spotify''s Roadmap vs. Sales',
        E'Spotify''s VP of Ad Sales urgently requests a new interactive podcast ad format by Q3 to close a major sponsor. However, the engineering team estimates the underlying infrastructure won''t be ready until Q4.\n\nHow should the PM handle this mismatch?',
        'foundational',
        'Spotify',
        'Ad format delivery timeline mismatch',
        'B',
        'Great PMs look beyond the specific feature request to understand the underlying business need. By understanding that Sales needs to close a specific sponsor, the PM can work to find an interim solution that satisfies the sponsor without destroying the engineering timeline. Option A damages trust with Sales. Option C guarantees failure and burnout for Engineering. Option D creates a dysfunctional ''pass the buck'' culture.',
        ARRAY['managing_expectations', 'roadmap_alignment', 'sales_product_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Say ''no'' immediately because the engineering roadmap is already locked.', false),
    (v_q_id, 'B', 'Understand the sponsor''s underlying goal and explore a lighter, interim solution for Q3.', true),
    (v_q_id, 'C', 'Commit to the Q3 date for Sales and push the engineering team to work weekends.', false),
    (v_q_id, 'D', 'Tell Sales that Engineering is at fault so they should negotiate with the CTO directly.', false);

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
        'Notion''s HiPPO Swoop',
        E'Midway through a critical two-week sprint, Notion''s CEO (the Highest Paid Person''s Opinion) drops into the team Slack channel and says, ''I was playing around with the app this weekend. We should really move the template gallery to the left sidebar right now.''\n\nWhat is the best immediate response from the PM?',
        'foundational',
        'Notion',
        'CEO suggesting abrupt UX changes',
        'B',
        'When dealing with a HiPPO, outright rejection (Option C) causes friction, while immediate capitulation (Option A) ruins sprint predictability and team morale. The best approach is to acknowledge the feedback, extract the underlying problem they are trying to solve, and evaluate it against current priorities. Option D is passive-aggressive and assumes the CEO is wrong before understanding their perspective.',
        ARRAY['hippo', 'managing_up', 'sprint_protection']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stop the current sprint work and immediately add the sidebar change to Jira.', false),
    (v_q_id, 'B', 'Acknowledge the feedback, ask what user problem prompted it, and evaluate it for the next sprint.', true),
    (v_q_id, 'C', 'Politely tell the CEO that the sprint is locked and they must submit a formal request.', false),
    (v_q_id, 'D', 'Ignore the Slack message until the sprint is over to protect the engineering team.', false);

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
        'Stripe''s Legal Roadblock',
        E'Two days before the launch of a new Stripe invoicing feature, the Legal team flags a compliance risk regarding EU tax regulations and says, ''You cannot launch this.''\n\nHow should the PM respond?',
        'foundational',
        'Stripe',
        'Late-stage legal block on launch',
        'D',
        'Legal is a crucial stakeholder, not an enemy. When Legal blocks a launch, the PM must sit down with them to understand the specific risk and co-create a mitigation strategy (like a copy change or scoping out the EU temporarily). Option A is reckless and risks massive fines. Option B is passive and delays the launch unnecessarily. Option C is confrontational and ruins cross-functional relationships.',
        ARRAY['cross_functional', 'legal_compliance', 'launch_blockers']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch anyway and assume the risk, as time-to-market is the primary PM responsibility.', false),
    (v_q_id, 'B', 'Cancel the launch immediately and wait for Legal to draft new requirements.', false),
    (v_q_id, 'C', 'Escalate to the CEO and complain that Legal is acting as a bottleneck to revenue.', false),
    (v_q_id, 'D', 'Meet with Legal immediately to understand the exact risk and collaborate on a mitigation plan.', true);

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
        'Slack''s Conflicting VPs',
        E'Slack''s VP of Enterprise wants strict, heavy admin approval flows for inviting external guests. The VP of Growth wants a frictionless, one-click viral invite flow. Both claim their request is the company''s top priority.\n\nWhat is the most effective way for the PM to resolve this?',
        'foundational',
        'Slack',
        'Conflicting feature requests from equal-power stakeholders',
        'C',
        'When stakeholders of equal power have directly conflicting goals, the PM must act as a facilitator. Bringing them together with data outlining the trade-offs (security vs. viral growth) allows the decision to be made based on company-wide OKRs. Option A splits the difference poorly, likely pleasing no one. Option B relies on personal preference rather than strategy. Option D abdicates product leadership.',
        ARRAY['conflict_resolution', 'trade_offs', 'okr_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build exactly half of what Enterprise wants and half of what Growth wants to compromise.', false),
    (v_q_id, 'B', 'Side with the VP you have a better relationship with to ensure political backing.', false),
    (v_q_id, 'C', 'Bring both VPs together with data on the trade-offs and align the decision to company-level OKRs.', true),
    (v_q_id, 'D', 'Tell Engineering to build whatever is technically easier and inform the VPs afterward.', false);

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
        'Shopify''s Launch Date Dilemma',
        E'Shopify''s Marketing team needs a firm launch date for a massive merchant campaign. Engineering is dealing with unexpected technical debt and refuses to commit to a specific date.\n\nHow should the PM bridge this gap?',
        'foundational',
        'Shopify',
        'Marketing needs a date, Engineering won''t commit',
        'C',
        'Marketing needs predictability, while Engineering needs flexibility for unknowns. Providing a confidence-based range and a firm ''go/no-go'' checkpoint gives Marketing enough info to prepare while protecting Engineering from a death march. Option A forces Engineering into a rigid date they didn''t agree to. Option B alienates Marketing. Option D is dishonest and sets everyone up for failure.',
        ARRAY['managing_expectations', 'engineering_alignment', 'marketing_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pick a date halfway between the best-case and worst-case scenarios and commit to it.', false),
    (v_q_id, 'B', 'Tell Marketing they cannot run the campaign until the code is completely finished.', false),
    (v_q_id, 'C', 'Provide a confidence-based date range and establish a ''go/no-go'' deadline for the campaign.', true),
    (v_q_id, 'D', 'Commit to Marketing''s preferred date, then silently cut core features to hit it.', false);

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
        'Netflix''s Support Escalation',
        E'The Director of Customer Support at Netflix insists that Product must build an auto-reply feature for billing issues. The PM knows this is not on the roadmap and does not align with the strategy of fixing root-cause billing errors.\n\nHow should the PM say ''no''?',
        'foundational',
        'Netflix',
        'Rejecting a feature request from Support',
        'D',
        'Saying ''no'' requires validating the stakeholder''s underlying pain (high ticket volume) while showing how the roadmap already addresses it (fixing the root cause). Agreeing to monitor metrics shows ongoing partnership. Option A is a blunt rejection that ruins relationships. Option B is a classic PM lie (''the backlog'') that creates false hope. Option C abandons the product strategy.',
        ARRAY['saying_no', 'backlog_management', 'customer_support']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Say ''No, this does not align with our strategic priorities'' and end the conversation.', false),
    (v_q_id, 'B', 'Add it to the backlog to make the Director happy, knowing you will never build it.', false),
    (v_q_id, 'C', 'Pause the current roadmap to quickly build the auto-reply feature to keep Support happy.', false),
    (v_q_id, 'D', 'Validate their pain point, explain how current roadmap items address the root cause, and agree to monitor ticket volume.', true);

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
        'Figma''s New Engineering Manager',
        E'A PM at Figma gets a new Engineering Manager (EM) who is highly skeptical of Product. The EM constantly demands to see raw user interview transcripts before agreeing to any technical architecture.\n\nWhat is the best way to build trust with this EM?',
        'foundational',
        'Figma',
        'Building trust with a skeptical EM',
        'B',
        'A skeptical EM usually wants to understand the ''why'' behind product decisions. Transparently sharing frameworks and inviting them into the discovery process builds shared context and deep trust. Option A creates an adversarial ''stay in your lane'' dynamic. Option C leads to analysis paralysis. Option D avoids the root issue of trust.',
        ARRAY['engineering_alignment', 'building_trust', 'discovery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Remind the EM that Product defines the ''what'' and Engineering defines the ''how''.', false),
    (v_q_id, 'B', 'Share decision-making frameworks and invite the EM to sit in on upcoming user interviews.', true),
    (v_q_id, 'C', 'Refuse to move forward until the EM has read every single user interview transcript.', false),
    (v_q_id, 'D', 'Escalate to the Director of Engineering and request a more compliant EM.', false);

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
        'Airbnb''s Stakeholder Mapping',
        E'An Airbnb PM is starting a massive, highly controversial project to overhaul Host cancellation policies globally.\n\nWhat is the most critical first step in stakeholder management for this project?',
        'foundational',
        'Airbnb',
        'Starting a complex, high-stakes project',
        'A',
        'For complex projects, the PM must proactively map out all cross-functional groups (Legal, Support, Comms, Policy) to understand their influence and interest early. Option B assumes the PM has all the answers without consulting experts. Option C limits input to engineering, ignoring vital business stakeholders. Option D is an anti-pattern; you don''t build first and seek alignment later on controversial policies.',
        ARRAY['stakeholder_mapping', 'project_kickoff', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Identify all impacted cross-functional teams and map their influence to tailor an engagement plan.', true),
    (v_q_id, 'B', 'Write a final PRD and send it to all executives for a one-time sign-off.', false),
    (v_q_id, 'C', 'Focus solely on aligning the engineering team, as execution is the only thing that matters.', false),
    (v_q_id, 'D', 'Build an MVP quietly and launch it as an A/B test before telling any stakeholders.', false);

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
        'Discord''s Escalation Path',
        E'A critical Discord Trust & Safety feature is delayed because the Data Science (DS) team hasn''t delivered the required ML model. The DS manager keeps saying ''we are busy.''\n\nHow should the PM escalate this issue?',
        'foundational',
        'Discord',
        'Escalating a blocked cross-functional dependency',
        'B',
        'Escalation should always be framed around the impact to the business goals, not personal complaints about a colleague. By presenting the impact on safety goals to a mutual leader, you force a prioritization decision. Option A is unprofessional. Option C makes the PM the bottleneck. Option D is weak and accepts failure without trying to resolve the resource constraint.',
        ARRAY['escalation', 'cross_functional_dependencies', 'trust_and_safety']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send a company-wide email blaming the DS team for the delay.', false),
    (v_q_id, 'B', 'Escalate to the mutual leader, framing the conversation around the impact to company safety goals.', true),
    (v_q_id, 'C', 'Attempt to write the ML model yourself to prove it can be done quickly.', false),
    (v_q_id, 'D', 'Accept the delay and tell the Trust & Safety team that the feature is cancelled.', false);

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
        'DoorDash''s Custom Sales Promise',
        E'A DoorDash Sales Rep promised a major restaurant chain a highly customized, white-label reporting dashboard by next month to close a $5M deal. This feature is nowhere on the Product roadmap.\n\nHow should the PM handle this?',
        'intermediate',
        'DoorDash',
        'Sales promised an un-roadmapped custom feature',
        'C',
        'The PM must solve the immediate business problem ($5M at risk) without destroying the product architecture with custom code. Finding a manual workaround solves the short-term, while establishing a strict policy with Sales Leadership prevents this from recurring. Option A reinforces bad behavior. Option B loses a major deal unnecessarily. Option D is a hollow threat.',
        ARRAY['sales_product_alignment', 'custom_requests', 'roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Drop the current roadmap and build the custom dashboard because revenue is king.', false),
    (v_q_id, 'B', 'Refuse to build it and tell the Sales Rep they will have to lose the $5M deal.', false),
    (v_q_id, 'C', 'Find a manual workaround for this client, then partner with Sales Leadership to enforce a ''no custom promises'' policy.', true),
    (v_q_id, 'D', 'Build the feature but threaten the Sales Rep that you will never do it again.', false);

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
        'Amazon''s PR/FAQ Buy-In',
        E'An Amazon PM is proposing a highly controversial new Prime benefit that will initially reduce margins but drive long-term lock-in. They need to get buy-in from skeptical SVPs.\n\nWhat is the most effective way to structure the PR/FAQ document?',
        'intermediate',
        'Amazon',
        'Getting buy-in for a controversial idea using a PR/FAQ',
        'A',
        'At Amazon (and for PMs generally), the best way to disarm skeptics is to anticipate their exact arguments. The FAQ section should explicitly address the hardest questions (e.g., ''Won''t this ruin our margins?'') with data-backed answers. Option B avoids the hard questions, making it look like the PM hasn''t done their homework. Option C is marketing fluff. Option D focuses purely on implementation, not strategic value.',
        ARRAY['pr_faq', 'executive_buy_in', 'objection_handling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Clearly articulate customer value and use the FAQ to explicitly address the most likely executive objections regarding margins.', true),
    (v_q_id, 'B', 'Focus the FAQ strictly on the technical architecture so executives know the engineering is sound.', false),
    (v_q_id, 'C', 'Omit the margin reduction data to ensure the narrative focuses purely on the positive customer experience.', false),
    (v_q_id, 'D', 'List all the features in bullet points and avoid mentioning potential risks to keep the tone positive.', false);

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
        'Zoom''s Passive-Aggressive Dependency',
        E'A PM at Zoom relies on another product team to build an API. The other PM initially agreed, but keeps missing deadlines, citing ''other shifting priorities'' in status updates while avoiding direct communication.\n\nWhat is the best approach to resolve this?',
        'intermediate',
        'Zoom',
        'Handling passive resistance from another PM',
        'D',
        'Passive-aggressive delays usually stem from unspoken resource constraints or misaligned incentives. A 1:1 conversation seeks to understand their reality and find a mutually beneficial path forward. Option A is an escalation that damages trust before attempting a peer resolution. Option B is passive. Option C is aggressive and counterproductive.',
        ARRAY['peer_management', 'cross_functional_dependencies', 'conflict_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately escalate to their VP to force them to adhere to the original timeline.', false),
    (v_q_id, 'B', 'Continue pushing your own team''s work and hope the other team eventually delivers the API.', false),
    (v_q_id, 'C', 'Call them out publicly in the next all-hands meeting for blocking your team.', false),
    (v_q_id, 'D', 'Schedule a 1:1 to uncover their underlying resource constraints and redefine a mutually viable timeline.', true);

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
        'GitHub''s Mid-Project Pivot',
        E'A GitHub PM spent 2 months getting executive buy-in for a massive 6-month initiative. In month 2, a beta test definitively proves the core user hypothesis is completely wrong.\n\nHow should the PM handle the stakeholders?',
        'intermediate',
        'GitHub',
        'Communicating a pivot after securing buy-in',
        'A',
        'Great PMs prioritize truth over ego. If data invalidates the hypothesis, the PM must proactively admit it, present the new data, and propose a pivot. This builds immense credibility. Option B is the sunk cost fallacy. Option C is deceptive and manipulative. Option D is weak and lacks leadership.',
        ARRAY['pivoting', 'executive_communication', 'sunk_cost_fallacy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Proactively assemble stakeholders, present the invalidating data, and propose a pivoted strategy.', true),
    (v_q_id, 'B', 'Push forward with the original plan because cancelling it now would cost too much political capital.', false),
    (v_q_id, 'C', 'Slowly alter the project scope over the next 4 months so executives don''t notice the pivot.', false),
    (v_q_id, 'D', 'Wait for the executive sponsor to review the beta data and tell you what to do next.', false);

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
        'HubSpot''s Legal vs. Growth Conflict',
        E'HubSpot''s Growth team wants to implement an auto-opt-in checkbox for marketing emails to boost conversions. The Legal team states this strictly violates GDPR and cannot be done.\n\nHow should the PM proceed?',
        'intermediate',
        'HubSpot',
        'Legal blocking a growth initiative',
        'B',
        'Legal is not a blocker; they are a partner in risk management. The PM should accept the constraint (no auto-opt-in) and brainstorm alternative UX patterns (like compelling copy or explicit value props) that drive conversions while remaining legally compliant. Option A is illegal. Option C is combative. Option D abandons the Growth goal entirely.',
        ARRAY['legal_compliance', 'growth_design', 'stakeholder_collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Implement the auto-opt-in only for non-EU users without telling Legal.', false),
    (v_q_id, 'B', 'Treat Legal as a partner and brainstorm alternative UX patterns that drive high opt-ins while strictly following GDPR.', true),
    (v_q_id, 'C', 'Tell the Growth team that Legal is ruining the product and escalate to the CEO.', false),
    (v_q_id, 'D', 'Abandon the opt-in initiative entirely and move on to a different project.', false);

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
        'Tinder''s Design vs. Eng Trade-off',
        E'Tinder''s Lead Designer wants a fluid, complex 3D animation for a new matching feature. The Tech Lead says building it will delay the launch by 3 weeks and severely impact app load times on older Android devices.\n\nHow should the PM resolve this stakeholder conflict?',
        'intermediate',
        'Tinder',
        'Resolving a direct Design vs. Engineering conflict',
        'C',
        'PMs resolve stalemates by bringing the focus back to the user and the North Star metrics. If the animation hurts load times (which hurts retention on Android), the PM must guide the team to a compromise that balances aesthetics with performance and timeline. Option A blindly follows Design. Option B blindly follows Engineering. Option D relies on executive fiat rather than team collaboration.',
        ARRAY['trade_offs', 'design_eng_alignment', 'performance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Side with Design because a dating app relies entirely on premium aesthetics and user delight.', false),
    (v_q_id, 'B', 'Side with Engineering because hitting the deadline is the only metric that matters to leadership.', false),
    (v_q_id, 'C', 'Frame the decision around user impact, highlighting the Android performance hit, and facilitate a compromise on a simpler animation.', true),
    (v_q_id, 'D', 'Let the two of them argue it out, and if they can''t decide, escalate to the CPO.', false);

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
        'LinkedIn''s Bypassed PM',
        E'A LinkedIn Marketing Manager bypassed you (the PM) and directly direct-messaged an engineer to change the copy on a signup button. The engineer made the change, which inadvertently broke an ongoing A/B test.\n\nWhat is the appropriate action?',
        'intermediate',
        'LinkedIn',
        'A stakeholder bypassing the PM process',
        'B',
        'The PM must address both sides of the bypass. First, educate the engineer on why the PM intake process exists (to protect things like A/B tests). Second, firmly align with the Marketing Manager on the correct process for future requests, ensuring they understand the negative impact of their bypass. Option A ignores the root cause. Option C is an overreaction. Option D addresses the stakeholder but ignores the engineer''s complicity.',
        ARRAY['process_enforcement', 'team_protection', 'stakeholder_boundaries']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fix the A/B test silently and don''t mention it, to avoid causing drama with Marketing.', false),
    (v_q_id, 'B', 'Educate the engineer on protecting tests, then firmly align with Marketing on the proper intake process.', true),
    (v_q_id, 'C', 'Formally reprimand the engineer for taking unauthorized work and report the marketer to HR.', false),
    (v_q_id, 'D', 'Tell Marketing they are banned from requesting copy changes for the rest of the quarter.', false);

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
        'Pinterest''s Vanity Executive Request',
        E'Pinterest''s Chief Product Officer (CPO) saw a competitor launch ''Stories'' and demands the team build it immediately. However, your data clearly shows users are begging for better search filtering, not Stories.\n\nHow do you handle the CPO''s request?',
        'intermediate',
        'Pinterest',
        'Executive pushing a vanity feature against data',
        'D',
        'When an executive pushes a vanity feature, flatly saying no is politically dangerous, but blindly executing is product negligence. Using the ''disagree and commit'' framework—showing the opportunity cost with data, offering a low-cost test, and letting the exec make the final call—protects the product while respecting hierarchy. Option A is blind obedience. Option B is insubordination. Option C creates a bloated roadmap.',
        ARRAY['managing_up', 'hippo', 'disagree_and_commit']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Drop the search improvements and immediately begin building Stories.', false),
    (v_q_id, 'B', 'Refuse the request entirely, citing the data as the ultimate authority.', false),
    (v_q_id, 'C', 'Try to build both Stories and Search Filtering simultaneously to keep everyone happy.', false),
    (v_q_id, 'D', 'Show the opportunity cost using data, propose a small timeboxed test of Stories, and let the CPO make the final call.', true);

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
        'Duolingo''s Bad News Delivery',
        E'A highly anticipated, heavily resourced gamification feature at Duolingo has just concluded its A/B test. The results are bad: it decreased Day 1 retention by 4%. You have a meeting with the exec team tomorrow.\n\nHow do you present this?',
        'intermediate',
        'Duolingo',
        'Presenting failed experiment results to executives',
        'A',
        'Great PMs do not hide bad news. They report it objectively, accompanied by a deep analysis of *why* it failed and what the organization learned. This turns a failure into a strategic asset. Option B is deceptive data manipulation. Option C is defensive and unprofessional. Option D wastes time by not arriving with an analysis.',
        ARRAY['managing_up', 'experimentation', 'delivering_bad_news']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Report the negative result clearly, alongside a deep dive into why it failed and actionable learnings for the next iteration.', true),
    (v_q_id, 'B', 'Focus the presentation on secondary metrics that went up, downplaying the drop in Day 1 retention.', false),
    (v_q_id, 'C', 'Blame the engineering team for poor execution, suggesting the feature would have worked if built better.', false),
    (v_q_id, 'D', 'Cancel the meeting until you can run a completely different test to show positive numbers.', false);

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
        'Peloton''s Hardware Dependency',
        E'Your software feature at Peloton requires integration with a new bike sensor. The Hardware team just announced they are 2 months behind schedule, meaning you cannot test your software on the actual device.\n\nHow do you manage this dependency?',
        'intermediate',
        'Peloton',
        'Managing a heavily delayed cross-functional dependency',
        'C',
        'When a physical dependency is delayed, the PM must decouple the workflows. Using simulators allows the software team to continue making progress and de-risking the logic, while resetting expectations with leadership. Option A wastes software engineering capacity. Option B guarantees integration failures later. Option D is petty and unhelpful.',
        ARRAY['cross_functional_dependencies', 'hardware_software', 'unblocking_teams']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pause all software development and put the engineers on a different project for 2 months.', false),
    (v_q_id, 'B', 'Assume the hardware will work exactly as specced and launch the software without testing.', false),
    (v_q_id, 'C', 'Decouple the workflows by using software simulators to test logic, and communicate the revised timeline to leadership.', true),
    (v_q_id, 'D', 'Write an angry email to the Head of Hardware demanding they speed up their manufacturing.', false);

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
        'Robinhood''s Micromanager VP',
        E'A VP of Product at Robinhood wants to review every single Jira ticket, PRD comment, and UI copy string before the team is allowed to write code. This is causing a massive bottleneck.\n\nHow should the PM address this?',
        'intermediate',
        'Robinhood',
        'Handling a highly micromanaging executive',
        'B',
        'Micromanagement usually stems from anxiety or lack of visibility. The PM should propose a new operating rhythm that provides the VP with the high-level assurance they need (e.g., weekly syncs, design sign-offs) while gently explaining how ticket-level reviews are blocking execution. Option A enables the bottleneck. Option C is passive-aggressive. Option D damages the relationship.',
        ARRAY['managing_up', 'micromanagement', 'process_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the process and schedule 3 hours every day to review tickets with the VP.', false),
    (v_q_id, 'B', 'Propose a new rhythm: offer high-level weekly syncs and design sign-offs, explaining how ticket review slows execution.', true),
    (v_q_id, 'C', 'Stop writing Jira tickets entirely so there is nothing for the VP to review.', false),
    (v_q_id, 'D', 'Tell the VP they are a micromanager and you refuse to participate in their process.', false);

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
        'Booking.com''s Late Requirement',
        E'Two weeks before a major Booking.com launch, the VP of Europe demands you add a complex multi-currency checkout flow. It would take 4 weeks to build.\n\nHow do you respond?',
        'intermediate',
        'Booking.com',
        'Stakeholder introducing massive scope creep right before launch',
        'B',
        'Late-stage scope creep must be managed with absolute clarity on trade-offs. The PM must outline the cost (a 4-week delay) vs. the benefit, and strongly recommend launching V1 on time, slotting the new request into a fast-follow V2. Option A rewards scope creep. Option C is antagonistic. Option D ruins the codebase.',
        ARRAY['scope_creep', 'launch_management', 'trade_offs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delay the launch by 4 weeks to accommodate the VP''s request.', false),
    (v_q_id, 'B', 'Outline the 4-week delay cost, recommend launching V1 on time, and prioritize the currency flow for V2.', true),
    (v_q_id, 'C', 'Ignore the request entirely because the PRD was signed off months ago.', false),
    (v_q_id, 'D', 'Ask Engineering to hack together a buggy version in 2 weeks to appease the VP.', false);

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
        'Canva''s Competing North Stars',
        E'At Canva, Marketing insists the North Star Metric is ''New Signups''. Engineering insists it''s ''System Uptime''. Product insists it''s ''Successful Designs Exported''.\n\nHow do you align these disparate stakeholders?',
        'intermediate',
        'Canva',
        'Aligning different departments on a single North Star',
        'D',
        'A true North Star metric represents core value delivery. The PM must facilitate an understanding that ''Designs Exported'' is the leading indicator of long-term value, while acknowledging that Signups and Uptime are critical ''health metrics'' or guardrails. Option A results in a lack of focus. Option B is dictatorial. Option C passes the buck.',
        ARRAY['north_star_metric', 'alignment', 'kpi_setting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a blended formula that averages Signups, Uptime, and Exports together.', false),
    (v_q_id, 'B', 'Declare that Product owns the metric and force everyone to adopt ''Designs Exported''.', false),
    (v_q_id, 'C', 'Let the CEO decide the metric since the departments cannot agree.', false),
    (v_q_id, 'D', 'Facilitate a workshop showing ''Designs Exported'' as the core value, while tracking Signups and Uptime as crucial health metrics.', true);

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
        'Twitter/X''s Post-Mortem Trust',
        E'You pushed a feature at Twitter/X that caused a 2-hour site-wide outage. Stakeholders are furious and now demand to personally approve all of your future code releases.\n\nHow do you rebuild trust and regain autonomy?',
        'intermediate',
        'Twitter',
        'Rebuilding stakeholder trust after a massive failure',
        'C',
        'Trust is rebuilt through extreme ownership and systemic improvement. Publishing a detailed post-mortem with actionable preventative measures, and asking for a short probationary period, proves you have learned from the mistake. Option A avoids responsibility. Option B accepts a permanent, inefficient bottleneck. Option D is arrogant.',
        ARRAY['trust_building', 'post_mortem', 'incident_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Blame the QA team for missing the bug and assure stakeholders it won''t happen again.', false),
    (v_q_id, 'B', 'Agree to their demands and let stakeholders approve all releases indefinitely.', false),
    (v_q_id, 'C', 'Take extreme ownership, publish a detailed post-mortem with preventative steps, and ask for a probationary period.', true),
    (v_q_id, 'D', 'Remind them that ''moving fast and breaking things'' is standard industry practice.', false);

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
        'Salesforce''s Silent Blocker',
        E'The Enterprise Security Lead at Salesforce ignored all your project update emails and skipped all review meetings. The day before launch, they review the code, find a flaw, and block the release.\n\nHow do you handle the immediate situation and the long-term process?',
        'intermediate',
        'Salesforce',
        'Dealing with a stakeholder who ignores process but blocks at the end',
        'A',
        'In enterprise SaaS, security is non-negotiable. You must delay the launch to fix the flaw. Long-term, you must fix the systemic issue by instituting a mandatory sign-off gate *early* in the process, forcing the ''silent'' stakeholder to engage. Option B risks massive enterprise churn. Option C focuses on blame, not solutions. Option D is unrealistic.',
        ARRAY['enterprise_software', 'security', 'process_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delay the launch to fix the flaw, then update project kickoffs to mandate explicit Security sign-off during the design phase.', true),
    (v_q_id, 'B', 'Launch anyway, document the security flaw in the backlog, and fix it in sprint 2.', false),
    (v_q_id, 'C', 'Escalate to the CEO, demanding the Security Lead be fired for missing meetings.', false),
    (v_q_id, 'D', 'Force the engineering team to stay up all night to rewrite the entire security architecture.', false);

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
        'Reddit''s Community as Stakeholder',
        E'You are a PM at Reddit launching a new API pricing model. It will hit aggressive revenue goals but you know the power-user community and moderators will hate it.\n\nHow should you manage this unique stakeholder group?',
        'intermediate',
        'Reddit',
        'Managing highly vocal external user communities as stakeholders',
        'B',
        'For community-driven products, power users are essentially external stakeholders. Briefing them early (even under NDA), validating their concerns, and giving them time to prepare is crucial for mitigating massive backlash. Option A guarantees a user revolt. Option C compromises company strategy. Option D is cowardly.',
        ARRAY['community_management', 'external_stakeholders', 'rollout_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch it silently on a Friday night to minimize initial media coverage.', false),
    (v_q_id, 'B', 'Treat moderators as key stakeholders: brief them early, gather feedback, and let them prepare the community.', true),
    (v_q_id, 'C', 'Cancel the feature completely; user happiness must always supersede revenue.', false),
    (v_q_id, 'D', 'Create fake Reddit accounts to post positive comments about the pricing change.', false);

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
        'Dropbox''s Influence Without Authority',
        E'You are a PM at Dropbox. You desperately need the Infrastructure team to migrate a database for your new feature. You do not manage them, they are busy, and your feature is not in their OKRs.\n\nHow do you get them to do the work?',
        'intermediate',
        'Dropbox',
        'Gaining buy-in from a busy team you don''t manage',
        'C',
        'Influencing without authority requires understanding what the other person cares about. By understanding the Infra team''s goals (like reducing tech debt or server costs) and framing your request in a way that helps *them* achieve *their* goals, you create a win-win. Option A relies on positional authority you don''t have. Option B is bribery. Option D is whining.',
        ARRAY['influencing_without_authority', 'cross_functional', 'negotiation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell them you are the PM and therefore the ''CEO of the product'', so they must comply.', false),
    (v_q_id, 'B', 'Offer to buy their team pizza if they stay late to do your migration.', false),
    (v_q_id, 'C', 'Understand their team''s OKRs and frame your database request in terms of how it helps reduce their technical debt.', true),
    (v_q_id, 'D', 'Complain to your manager that the company culture is uncollaborative.', false);

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
        'Instagram''s Visionary Founder',
        E'You are presenting a new feed ranking algorithm to an Instagram founder who relies heavily on intuition and visibly tunes out during data-heavy, spreadsheet-driven presentations.\n\nHow should you adjust your stakeholder management style?',
        'intermediate',
        'Instagram',
        'Managing up to a highly intuitive, non-analytical executive',
        'D',
        'Stakeholder management requires adapting to the audience. For a visionary, intuition-driven leader, you must lead with narrative, user experience, and prototypes. Data should be kept in the appendix or used only to back up the narrative, not as the primary communication vehicle. Option A is stubborn. Option B abandons the rigor of data entirely. Option C is condescending.',
        ARRAY['managing_up', 'communication_styles', 'visionary_leaders']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force them to look at the spreadsheets; data is the only objective truth.', false),
    (v_q_id, 'B', 'Stop analyzing data completely and just build whatever the founder intuitively feels is right.', false),
    (v_q_id, 'C', 'Speak very slowly and explain basic statistical concepts so they can understand the data.', false),
    (v_q_id, 'D', 'Lead with a compelling user narrative and visual prototypes, using data subtly to back up the story.', true);

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
        'Stripe''s Executive Risk Disagreement',
        E'Stripe is expanding into a complex new market. The Head of Legal demands a 0% compliance risk approach (takes 2 years to build). The Head of Growth demands a launch in 3 months, arguing the revenue will outpace any regulatory fines.\n\nAs the PM, how do you resolve this advanced standoff?',
        'advanced',
        'Stripe',
        'Resolving fundamental disagreements on company risk appetite',
        'C',
        'When C-level executives fundamentally disagree on the company''s risk appetite, a PM cannot resolve it via compromise. The PM must construct a tiered risk framework (quantifying the exact cost of fines vs. revenue) and escalate to the CEO/Board, as defining corporate risk tolerance is a CEO-level duty. Option A sides with Growth recklessly. Option B sides with Legal conservatively. Option D relies on a meaningless average.',
        ARRAY['risk_management', 'executive_escalation', 'strategic_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Side with Growth; moving fast and breaking things is essential in fintech.', false),
    (v_q_id, 'B', 'Side with Legal; compliance is paramount and cannot be risked.', false),
    (v_q_id, 'C', 'Model the financial scenarios (fines vs revenue) for 3 tiers of risk, and escalate to the CEO for a definitive ruling on company risk appetite.', true),
    (v_q_id, 'D', 'Compromise by launching in 1 year, cutting the difference down the middle.', false);

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
        'WhatsApp''s Global vs. Local Priorities',
        E'The WhatsApp India GM desperately needs a low-bandwidth text feature to capture rural users. The WhatsApp US GM needs high-fidelity video reactions to combat iMessage. You only have engineering capacity for one.\n\nHow do you align these stakeholders?',
        'advanced',
        'WhatsApp',
        'Prioritizing across vastly different global market needs',
        'B',
        'In global organizations, comparing raw numbers (India MAU vs US Revenue) often leads to stalemates. The PM must tie the decision back to the company''s macro-narrative for the year (e.g., is this the year of ''Next Billion Users'' or ''Mature Market Monetization''?). Option A reduces strategy to a simple math problem, ignoring strategic intent. Option C is a political cop-out. Option D results in two half-baked features.',
        ARRAY['global_strategy', 'prioritization', 'strategic_narrative']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Calculate the projected ARR of both features and simply pick the highest number.', false),
    (v_q_id, 'B', 'Base the decision on the company''s stated macro-narrative for the year (e.g., ''Next Billion Users'' vs ''Defending US Market Share'').', true),
    (v_q_id, 'C', 'Tell the two GMs to debate it and get back to you when one of them concedes.', false),
    (v_q_id, 'D', 'Split the engineering team in half and attempt to build V1s of both features simultaneously.', false);

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
        'Uber''s Unilateral Decision',
        E'A cross-functional group of 5 Uber stakeholders (Ops, Pricing, Eng, Data, Product) have been locked in analysis paralysis for 4 weeks over a minor change to the surge pricing algorithm. No consensus is in sight.\n\nWhat is the strongest leadership move for the PM?',
        'advanced',
        'Uber',
        'Breaking analysis paralysis when consensus fails',
        'A',
        'Consensus is a tool, not a religion. When consensus fails and causes paralysis, a senior PM must step up, declare the debate over, make a unilateral decision based on the best available data, and take full accountability for the outcome. Option B prolongs the paralysis. Option C introduces a new, uninvested decision-maker. Option D is weak and avoids making a choice.',
        ARRAY['decision_making', 'breaking_consensus', 'accountability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Declare that consensus has failed, make a unilateral decision based on data, and take full accountability for the results.', true),
    (v_q_id, 'B', 'Schedule another 4 weeks of meetings to ensure everyone feels heard before deciding.', false),
    (v_q_id, 'C', 'Bring in a 6th stakeholder from outside the project to act as a tie-breaker.', false),
    (v_q_id, 'D', 'Cancel the project since the team cannot reach an agreement.', false);

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
        'Airbnb''s Lost Executive Sponsor',
        E'You are 6 months into a 12-month platform rewrite at Airbnb. The VP who sponsored the project suddenly leaves the company. The new VP thinks the rewrite is a ''waste of time'' and wants to kill it.\n\nHow do you save the project?',
        'advanced',
        'Airbnb',
        'Managing the loss of an executive sponsor mid-project',
        'D',
        'A new executive has new priorities. You cannot rely on the old VP''s mandate. You must pause, understand what the new VP cares about (e.g., conversion rates, speed to market), and re-pitch the technical rewrite entirely in terms of the new VP''s business goals to secure renewed sponsorship. Option A relies on obsolete authority. Option B is deceptive. Option C gives up too easily.',
        ARRAY['executive_sponsorship', 'managing_up', 'change_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Remind the new VP that the old VP already approved the budget, so they cannot cancel it.', false),
    (v_q_id, 'B', 'Hide the project budget under a different initiative so the new VP doesn''t notice it.', false),
    (v_q_id, 'C', 'Agree with the new VP immediately and throw away 6 months of engineering work.', false),
    (v_q_id, 'D', 'Repackage the platform''s technical progress into the specific business value metrics the new VP cares about and re-pitch it.', true);

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
        'Shopify''s Systemic Misalignment',
        E'Shopify''s Product strategy is moving aggressively toward standardized, self-serve SaaS. However, the Sales team is compensated heavily on selling customized, bespoke enterprise implementations, leading them to constantly demand custom features.\n\nHow do you resolve this?',
        'advanced',
        'Shopify',
        'Identifying and escalating systemic incentive misalignments',
        'B',
        'This is a systemic organizational issue, not a standard product requirement conflict. People do what they are paid to do. The PM must recognize the misaligned incentive structure and escalate to the highest levels (CRO/CPO) to align the sales compensation model with the new product strategy. Option A treats a systemic issue as a series of tactical arguments. Option C subverts the company strategy. Option D ignores the root cause.',
        ARRAY['incentive_structures', 'sales_alignment', 'organizational_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Argue with the Sales team on a feature-by-feature basis every week.', false),
    (v_q_id, 'B', 'Recognize this as a systemic incentive problem and escalate to the CRO and CPO to realign the sales compensation model.', true),
    (v_q_id, 'C', 'Change the product strategy back to customized enterprise software to support the Sales team.', false),
    (v_q_id, 'D', 'Refuse all meetings with Sales until they stop asking for custom features.', false);

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
        'Figma''s Strategic Concession',
        E'A powerful, tenured executive at Figma is adamant about adding a confusing dropdown to your core UI. You know it''s bad UX. However, next month you need this exact executive''s support to approve a massive, risky architectural change.\n\nWhat is the most strategic move?',
        'advanced',
        'Figma',
        'Making calculated trade-offs for long-term political capital',
        'C',
        'Senior PMs play the long game. Sometimes, you must lose a small battle (a bad dropdown) to win the war (a massive architectural change). Making a calculated concession builds political capital with the executive, ensuring their support when you need it most. Option A wins the battle but loses the war. Option B is passive-aggressive. Option D is unethical.',
        ARRAY['political_capital', 'strategic_concessions', 'managing_up']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fight the executive to the death over the dropdown to protect the UX at all costs.', false),
    (v_q_id, 'B', 'Build the dropdown but make it completely hidden so users can''t find it.', false),
    (v_q_id, 'C', 'Concede on the dropdown as a calculated trade-off to build political capital for the upcoming architectural vote.', true),
    (v_q_id, 'D', 'Tell the executive you will build it, but secretly tell engineering to ignore the ticket.', false);

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
        'Netflix''s Board-Level Metric Conflict',
        E'The Netflix Board of Directors demands a 10% increase in ''Minutes Watched'' next quarter. Your data science team models out the required changes (more clickbait, autoplaying trailers) and proves this will cannibalize 12-month subscriber retention.\n\nHow do you handle this executive directive?',
        'advanced',
        'Netflix',
        'Pushing back on harmful Board-level directives with data',
        'B',
        'Blindly following a flawed metric directive from a Board destroys long-term company value. A senior PM must partner with Data Science to create a compelling visualization showing how optimizing the short-term proxy metric (''Minutes'') destroys the ultimate North Star (LTV/Retention), and propose a healthier alternative. Option A blindly destroys value. Option C is insubordinate. Option D is deceptive.',
        ARRAY['executive_alignment', 'metric_cannibalization', 'data_storytelling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Execute the clickbait features immediately; Board directives cannot be questioned.', false),
    (v_q_id, 'B', 'Present a unified case with Data Science showing the LTV destruction, and propose a healthier proxy metric to the C-suite.', true),
    (v_q_id, 'C', 'Send an email directly to the Board of Directors explaining why they are wrong.', false),
    (v_q_id, 'D', 'Fake the ''Minutes Watched'' data on the next quarterly report to protect retention.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Stakeholder Management';

END $$;
