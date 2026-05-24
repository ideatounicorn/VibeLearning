-- ============================================
-- ASSESSMENT: Product Launch
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
    WHERE slug = 'product-launch';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug product-launch not found. Run the seed data first.';
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
        'Slack''s Launch Readiness',
        E'Slack is preparing to launch a new threaded replies interface. The development is complete, and the feature passes all QA testing. However, the Customer Success (CS) and Support teams state they haven''t been trained on the new interface or received the updated help documentation.\n\nAs the PM, what is the best course of action?',
        'foundational',
        'Slack',
        'Workplace communication platform',
        'B',
        'In product management, a feature is only ready to launch when the entire organization is ready to support it. Launching without trained Support and CS teams (Option B) will lead to poor user experience, longer resolution times, and frustrated internal teams. Option A ignores the cross-functional dependencies of a launch. Option C relies on an assumption that users won''t need help, which is reckless for a core UI change. Option D is a temporary patch that creates a confusing experience for users who might search the help center and find nothing.',
        ARRAY['launch_checklist', 'cross_functional_alignment', 'go_to_market']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Proceed with the launch immediately, since engineering and QA are the only hard blockers for technical deployment.', false),
    (v_q_id, 'B', 'Delay the launch until Support and CS are fully trained and the help center documentation is published.', true),
    (v_q_id, 'C', 'Launch the feature but disable it for enterprise customers, assuming standard users won''t need support.', false),
    (v_q_id, 'D', 'Launch the feature, but hide the ''Help'' button in the UI until documentation is ready.', false);

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
        'Uber''s Phased Rollout',
        E'Uber is launching a new ''Uber Pet'' ride type. Instead of launching globally, the PM decides to roll out the feature exclusively in Austin, Texas for the first four weeks.\n\nWhat is the primary reason for choosing a city-specific phased rollout?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'C',
        'A phased geographic rollout allows a marketplace like Uber to monitor real-world operational dynamics (like supply/demand balance and driver opt-in rates) in a contained environment before risking a global failure (Option C). Option A is incorrect because bugs can be found via internal QA or beta testing; a city rollout tests market dynamics. Option B is wrong because localized marketing is a byproduct, not the primary strategic reason for phasing. Option D incorrectly focuses only on server load, which is usually managed via percentage rollouts (e.g., 1% of all traffic) rather than geographic ones.',
        ARRAY['phased_rollout', 'marketplace_dynamics', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To ensure that software bugs only affect a small number of users before they are fixed.', false),
    (v_q_id, 'B', 'To allow the marketing team to spend their entire budget on a single localized campaign.', false),
    (v_q_id, 'C', 'To observe local network effects, driver adoption, and operational impact in a contained market.', true),
    (v_q_id, 'D', 'To reduce the server load and avoid backend crashes during the initial launch.', false);

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
        'Spotify''s Beta Testing',
        E'Spotify is developing a new ''AI DJ'' feature. The PM decides to release it to an external group of 5,000 highly active power users who opted into early access. \n\nWhich phase of the release cycle does this represent?',
        'foundational',
        'Spotify',
        'Music streaming app',
        'A',
        'This scenario describes a Beta release (Option A), where a nearly complete product is given to external users in real-world environments to gather feedback and catch edge-case issues. An Alpha release (Option B) is typically internal, tested by employees. A General Availability (GA) release (Option C) means the feature is available to the entire target market. A Dark Launch (Option D) involves releasing the backend capability to production without exposing the UI to users, which contradicts giving it to 5,000 users.',
        ARRAY['beta_testing', 'release_management', 'user_feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Beta release', true),
    (v_q_id, 'B', 'Alpha release', false),
    (v_q_id, 'C', 'General Availability (GA)', false),
    (v_q_id, 'D', 'Dark Launch', false);

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
        'Airbnb''s Go/No-Go Decision',
        E'Airbnb is planning to launch a highly anticipated ''Flexible Dates'' search feature tomorrow. The marketing team has already scheduled a massive press release. During the final Go/No-Go meeting, QA reports a P1 (Priority 1) bug: 2% of users trying to book a flexible stay are double-charged.\n\nHow should the PM handle the Go/No-Go decision?',
        'foundational',
        'Airbnb',
        'Travel and accommodation marketplace',
        'D',
        'A P1 bug involving financial transactions and double-charging breaks core user trust and legal compliance. You must halt the launch, regardless of marketing commitments (Option D). Option A is a classic amateur mistake: treating marketing dates as immovable at the expense of user trust. Option B is impractical; finding and manually refunding users damages the brand and overwhelms support. Option C implies rolling back immediately after launch, which guarantees the bad experience will happen to some users and generates terrible PR.',
        ARRAY['go_no_go', 'risk_mitigation', 'launch_blocker']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Approve the launch because the press release is already scheduled and cannot be reversed without PR damage.', false),
    (v_q_id, 'B', 'Approve the launch, but instruct the Support team to manually monitor and refund the 2% of affected users.', false),
    (v_q_id, 'C', 'Approve the launch for PR reasons, but immediately trigger a rollback 5 minutes after it goes live.', false),
    (v_q_id, 'D', 'Block the launch, coordinate with PR to delay the announcement, and focus engineering on fixing the P1 bug.', true);

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
        'Notion''s Post-Launch Monitoring',
        E'Notion just launched a major overhaul of its rich text editor globally at 9:00 AM. It is now 9:30 AM.\n\nWhich of the following metrics is the most critical for the PM to monitor right now?',
        'foundational',
        'Notion',
        'Productivity and workspace tool',
        'B',
        'Immediately after a launch (T+30 minutes), a PM must monitor operational and system health metrics to ensure the product isn''t broken (Option B). Error rates, crash rates, and latency are leading indicators of launch failure. Option A (Day 1 retention) cannot be measured 30 minutes post-launch. Option C (NPS) is a lagging indicator gathered via surveys much later. Option D (Conversion to paid) is important but secondary to basic system functionality during the immediate post-launch window.',
        ARRAY['post_launch_monitoring', 'system_health', 'leading_indicator']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Day 1 User Retention rate', false),
    (v_q_id, 'B', 'System error rates, crash reports, and latency', true),
    (v_q_id, 'C', 'Net Promoter Score (NPS) from users using the new editor', false),
    (v_q_id, 'D', 'Conversion rate from free to paid tiers', false);

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
        'Figma''s Rollback Plan',
        E'Figma''s PM is preparing to launch a new rendering engine that should improve canvas performance. The PM requires engineering to wrap the release in a ''feature flag''.\n\nWhat is the primary benefit of using a feature flag for this launch?',
        'foundational',
        'Figma',
        'Collaborative design tool',
        'C',
        'A feature flag (or toggle) allows teams to turn a feature on or off remotely without deploying new code. If the rendering engine fails, turning off the flag instantly rolls the system back to the old engine (Option C). Option A describes A/B testing, which might use feature flags, but isn''t their primary rollback benefit. Option B is related to dark launching, not the rollback capability of a flag. Option D is incorrect because feature flags do not inherently backup user data.',
        ARRAY['feature_flag', 'rollback_plan', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It automatically assigns users into A/B test cohorts based on their IP address.', false),
    (v_q_id, 'B', 'It allows the design team to push UI updates directly to the app stores without Apple''s review.', false),
    (v_q_id, 'C', 'It allows the team to instantly disable the new engine in production without executing a new code deployment.', true),
    (v_q_id, 'D', 'It creates a backup of all user files so they can be restored if the new engine corrupts data.', false);

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
        'Stripe''s API Release Management',
        E'Stripe is releasing an update to its Payment Intents API. Millions of businesses rely on the current version of the API to process checkout transactions.\n\nWhat is the most critical requirement for this launch?',
        'foundational',
        'Stripe',
        'Payment processing platform',
        'A',
        'For infrastructure and developer platforms like Stripe, maintaining backward compatibility (Option A) is paramount. If an API update breaks existing integrations, millions of merchants lose money instantly. Option B (simultaneous global launch) is risky and often avoided in favor of phased rollouts. Option C (forcing migration) is terrible developer experience and leads to massive churn. Option D is irrelevant to API integrity.',
        ARRAY['release_management', 'api_design', 'backward_compatibility']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The new version must be fully backward compatible so existing merchant integrations do not break.', true),
    (v_q_id, 'B', 'The release must happen globally at exactly midnight UTC to avoid timezone confusion.', false),
    (v_q_id, 'C', 'All existing users must be forcefully migrated to the new API within 24 hours.', false),
    (v_q_id, 'D', 'The API must be released exclusively on mobile platforms first before the web.', false);

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
        'Netflix''s Cross-functional Alignment',
        E'Netflix is launching a new ''Interactive Trivia'' game feature. The PM is finalizing the launch checklist. \n\nWhy is it crucial for the PM to align with the Legal and Content Licensing teams prior to launch?',
        'foundational',
        'Netflix',
        'Streaming platform',
        'B',
        'New formats (like interactive games) often fall outside standard video licensing agreements or raise new data compliance issues. A PM must ensure the company has the legal right to use the IP in this new format and that it complies with regulations (Option B). Option A is incorrect; Legal doesn''t write technical copy. Option C is marketing''s job, not legal''s. Option D is engineering/QA''s responsibility.',
        ARRAY['cross_functional_alignment', 'legal_compliance', 'launch_checklist']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To ensure the Legal team can write the technical documentation for the engineering codebase.', false),
    (v_q_id, 'B', 'To verify that interactive content doesn''t violate existing IP licensing agreements or data privacy laws.', true),
    (v_q_id, 'C', 'To get approval on the marketing budget allocated for promoting the new trivia games.', false),
    (v_q_id, 'D', 'To ensure the Legal team can perform final QA testing on the feature''s user interface.', false);

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
        'DoorDash''s Post-Launch Triage',
        E'DoorDash just launched a new ''Group Ordering'' feature. Two hours post-launch, the team receives two bug reports:\nBug 1: A visual glitch where the ''Add'' button is slightly misaligned on older Android phones.\nBug 2: 5% of group orders fail to process the final payment.\n\nHow should the PM prioritize these?',
        'foundational',
        'DoorDash',
        'Food delivery platform',
        'A',
        'Post-launch triage requires prioritizing bugs based on severity and impact. Bug 2 blocks core functionality (revenue and order completion), making it a P0/P1 issue that needs immediate attention (Option A). Bug 1 is a minor cosmetic issue that doesn''t prevent user success. Option B and C fail to understand the severity of payment failures. Option D is an overreaction; a rollback is only needed if Bug 2 cannot be quickly hotfixed and is causing massive damage, but addressing the payment issue is still the priority.',
        ARRAY['post_launch_monitoring', 'bug_triage', 'prioritization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Prioritize Bug 2 immediately as it blocks core revenue functionality, and log Bug 1 in the backlog for a later sprint.', true),
    (v_q_id, 'B', 'Prioritize Bug 1 because UI issues generate the most negative reviews on the App Store.', false),
    (v_q_id, 'C', 'Treat both bugs with equal priority and require engineering to fix both before deploying a patch.', false),
    (v_q_id, 'D', 'Immediately roll back the entire launch because any bug found post-launch indicates a failed QA process.', false);

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
        'Shopify''s Dark Launch',
        E'Shopify''s engineering team ''dark launches'' a new inventory syncing service. \n\nWhat does it mean to ''dark launch'' this feature?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'C',
        'A ''dark launch'' means deploying the backend code to production and passing real user traffic through it to test performance and scale, but hiding the new UI/results from the end user (Option C). This tests backend stability under real loads without risking user disruption. Option A describes dark mode UI. Option B is a stealth PR strategy. Option D describes a staged percentage rollout, not a dark launch.',
        ARRAY['dark_launch', 'release_management', 'infrastructure']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The feature is released exclusively for users who have enabled ''Dark Mode'' in their OS settings.', false),
    (v_q_id, 'B', 'The feature is launched to the public without any marketing announcements or press releases.', false),
    (v_q_id, 'C', 'The backend service is running in production with real traffic, but the feature is completely hidden from the user interface.', true),
    (v_q_id, 'D', 'The feature is gradually released to 1% of users, then 10%, before a full global rollout.', false);

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
        'GitHub''s Phased Rollout Strategy',
        E'GitHub is deploying a major refactor to its pull request merge logic. The PM wants to ensure that if the new logic fails, it only impacts a minimal number of requests and can be instantly reverted without downtime.\n\nWhich deployment strategy should the PM advocate for?',
        'intermediate',
        'GitHub',
        'Developer platform',
        'B',
        'A Canary Release (Option B) slowly rolls out the change to a small subset of servers or users (the ''canary in the coal mine''). If metrics degrade, traffic is instantly routed back to the stable version. A Big Bang release (Option A) updates everything at once, maximizing risk. Blue/Green (Option C) switches all traffic at once between two identical environments; while safe for rollbacks, it doesn''t minimize initial impact like a canary. A Shadow Deployment (Option D) tests logic without affecting the outcome, which is good for testing but isn''t a rollout strategy for actually applying the new logic.',
        ARRAY['canary_release', 'phased_rollout', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Big Bang Deployment', false),
    (v_q_id, 'B', 'Canary Release', true),
    (v_q_id, 'C', 'Blue/Green Deployment', false),
    (v_q_id, 'D', 'Shadow Deployment', false);

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
        'Discord''s Post-Launch Monitoring',
        E'Discord launches a new ''Voice Filter'' feature globally. On Day 1, Voice Channel usage spikes by 40%. The marketing team celebrates a massive success. The PM looks at the data:\n- DAU increased by 2%\n- Average voice session length dropped by 15%\n- Support tickets related to audio quality increased by 300%\n\nWhat is the most accurate interpretation of this launch?',
        'intermediate',
        'Discord',
        'Voice and text chat platform',
        'C',
        'The data shows a classic ''Novelty Effect'' combined with a poor user experience. Users are trying the new feature (causing the spike in usage), but the feature is likely buggy or low quality, evidenced by shorter sessions and a massive spike in support tickets (Option C). Celebrating the 40% spike (Option A) ignores the negative downstream metrics. Option B incorrectly assumes the feature is fundamentally sound based only on DAU. Option D jumps to a conclusion about server load without evidence; the issue is audio quality and session length.',
        ARRAY['post_launch_monitoring', 'novelty_effect', 'counter_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The launch is a success because a 40% increase in core engagement is the ultimate validation of product-market fit.', false),
    (v_q_id, 'B', 'The launch is a success because DAU grew, meaning the feature successfully acquired new users for the platform.', false),
    (v_q_id, 'C', 'The spike is likely a novelty effect; the drop in session length and rise in tickets indicate the feature is actually degrading the core voice experience.', true),
    (v_q_id, 'D', 'The spike in support tickets is normal for any launch, but the drop in session length proves the servers are crashing.', false);

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
        'Zoom''s Go/No-Go Call',
        E'Zoom is scheduled to launch ''Live Translation'' in 2 hours. In the final Go/No-Go meeting, QA reveals a P2 bug: The translation overlay text clips slightly off-screen on the iPad Mini in landscape mode. The iPad Mini represents 0.5% of Zoom''s daily active users.\n\nWhat is the best Go/No-Go decision?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'B',
        'A PM must weigh the severity and impact of a bug against the momentum of a launch. A cosmetic bug (text clipping) affecting a tiny fraction of users (0.5%) does not justify halting a major launch (Option B). You document it as a known issue and fast-follow with a patch. Option A (halting) is too risk-averse for a minor issue. Option C is technically complex and risky to deploy a device-specific block hours before launch. Option D (delaying) wastes momentum and PR for a trivial edge case.',
        ARRAY['go_no_go', 'bug_triage', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Halt the launch. No feature should ever go to production with known P2 UI bugs.', false),
    (v_q_id, 'B', 'Proceed with the launch. Document the bug as a known issue and schedule a fast-follow patch for the next sprint.', true),
    (v_q_id, 'C', 'Proceed with the launch, but hastily write code to completely disable the feature for all iPad users.', false),
    (v_q_id, 'D', 'Delay the launch by exactly 24 hours to give engineering time to fix the clipping issue.', false);

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
        'Robinhood''s Risk Mitigation',
        E'Robinhood is launching a new ''Crypto Staking'' product. Because financial regulations vary heavily by state, the legal team warns that offering the feature in New York could result in massive fines.\n\nWhat is the most robust way to handle this during launch?',
        'intermediate',
        'Robinhood',
        'Financial trading app',
        'B',
        'For regulatory compliance, client-side filtering (Option A or C) is highly insecure, as users can bypass it (e.g., using a VPN or modifying the app). The most robust mitigation is server-side enforcement based on verified user identity/KYC data (Option B). Option D ignores the legal warning entirely, which is catastrophic for a PM in fintech.',
        ARRAY['risk_mitigation', 'regulatory_compliance', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use the device''s GPS to hide the feature in the UI if the user is currently located in New York.', false),
    (v_q_id, 'B', 'Implement strict server-side gating based on the user''s KYC (Know Your Customer) verified address to block NY residents.', true),
    (v_q_id, 'C', 'Add a checkbox during onboarding asking users to confirm they are not NY residents.', false),
    (v_q_id, 'D', 'Launch it nationally to maximize adoption, and let the legal team handle any fines as a cost of doing business.', false);

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
        'Tinder''s A/B Testing vs Phased Rollout',
        E'Tinder has built a new ''Profile Video'' feature. The PM wants to know if this feature actually increases the number of mutual matches (a causal relationship), while engineering is worried about the video hosting servers crashing under load.\n\nWhich launch strategy should the PM use?',
        'intermediate',
        'Tinder',
        'Dating app',
        'C',
        'An A/B test (experimentation) establishes causal impact on metrics (matches). A phased percentage rollout (e.g., 1% -> 10% -> 100%) mitigates operational risk (server load). To achieve both, the PM should run an A/B test but ramp up the test traffic gradually (Option C). Option A only tests causality but ignores the server risk. Option B manages server load but doesn''t prove causality (you can''t isolate the feature''s impact from seasonality). Option D is a market test, which suffers from regional bias and network effects, failing to cleanly prove causality.',
        ARRAY['phased_rollout', 'ab_testing', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch a 50/50 A/B test immediately to get statistical significance on the match rate as fast as possible.', false),
    (v_q_id, 'B', 'Do a phased rollout (10% to 50% to 100%) without a control group to safely monitor server load.', false),
    (v_q_id, 'C', 'Run an A/B test with a gradual ramp-up (e.g., 5% treatment / 5% control, then scale up) to measure impact while monitoring servers.', true),
    (v_q_id, 'D', 'Launch it exclusively in Australia as a test market, and compare Australia''s match rates to the rest of the world.', false);

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
        'Slack''s Rollback Triggers',
        E'Slack is rolling out a major update to its WebSocket connection architecture. The PM and Engineering Lead are defining the automatic rollback triggers (circuit breakers) for the launch.\n\nWhich of the following is the best metric to use as an automatic rollback trigger?',
        'intermediate',
        'Slack',
        'Workplace communication platform',
        'B',
        'Automatic rollback triggers must be based on objective, real-time, critical system metrics. A 5% increase in connection drop rate (Option B) directly measures the health of a WebSocket architecture and is a leading indicator of critical failure. Option A (NPS) is a lagging metric that takes days to collect. Option C (tweets) is subjective and unquantifiable for an automated system. Option D (CPU usage) might be expected to increase slightly with new architecture; it''s a resource metric, not a direct user-experience failure metric like dropped connections.',
        ARRAY['rollback_plan', 'system_health', 'circuit_breaker']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A drop in the Net Promoter Score (NPS) survey results over the first 24 hours.', false),
    (v_q_id, 'B', 'A 5% increase in the real-time WebSocket connection drop rate.', true),
    (v_q_id, 'C', 'More than 50 negative tweets mentioning Slack in a one-hour window.', false),
    (v_q_id, 'D', 'Any increase in backend CPU utilization, even if connection stability remains at 99.99%.', false);

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
        'Uber''s Beta Selection',
        E'Uber is launching a new ''Earnings Predictor'' tool for drivers. The PM wants to run a beta test to gather qualitative feedback on the tool''s UX and accuracy.\n\nWho is the ideal cohort to select for this beta?',
        'intermediate',
        'Uber',
        'Ride-hailing platform',
        'C',
        'When beta testing a complex operational tool, you want a representative mix of users to uncover diverse edge cases. Choosing drivers with varying experience levels and driving habits (Option C) ensures the predictor handles part-time, full-time, new, and veteran driver patterns. Option A (only top earners) suffers from extreme selection bias. Option B (churned drivers) won''t use the tool enough to give UX feedback. Option D (internal employees) won''t reflect real-world driver financial anxieties or actual market behaviors.',
        ARRAY['beta_testing', 'user_selection', 'qualitative_feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Only the top 1% of highest-earning drivers, as they understand the platform best.', false),
    (v_q_id, 'B', 'Drivers who haven''t driven in the last 6 months, to see if the tool reactivates them.', false),
    (v_q_id, 'C', 'A randomized mix of full-time, part-time, new, and veteran drivers who opt-in to test new features.', true),
    (v_q_id, 'D', 'Uber internal employees who occasionally drive on weekends.', false);

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
        'Spotify''s Multi-Platform Launch',
        E'Spotify is launching ''Collaborative Playlists v2''. The iOS app is approved and ready. The Android app has a bug that will take 3 days to fix. The web version is ready.\n\nWhy might the PM choose to delay the iOS and Web launches to synchronize with Android?',
        'intermediate',
        'Spotify',
        'Music streaming app',
        'A',
        'Collaborative features require network effects across platforms. If an iOS user shares a collaborative link with an Android friend, the Android user must be able to use it. A fragmented experience breaks the core value proposition of collaboration (Option A). Option B is a myth; Apple does not penalize synchronized launches. Option C is false; servers can easily handle asynchronous traffic. Option D is incorrect; marketing prefers unified launches, but user experience in a collaborative feature is the primary driver.',
        ARRAY['multi_platform_launch', 'network_effects', 'cross_platform']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Because the feature requires users to interact with each other; a fragmented launch breaks the experience if users are on different platforms.', true),
    (v_q_id, 'B', 'Because Apple App Store policies prohibit launching a feature on iOS before it is available on Android.', false),
    (v_q_id, 'C', 'To prevent server overload, as launching platforms sequentially causes massive backend database locks.', false),
    (v_q_id, 'D', 'Because the marketing team physically cannot run two different advertising campaigns in the same week.', false);

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
        'Airbnb''s Two-Sided Marketplace Launch',
        E'Airbnb is launching a new ''Experiences'' tier: ''Pro Tours'' (guided multi-day trips). \n\nAs part of the go-to-market execution, what is the most critical sequencing strategy for a two-sided marketplace?',
        'intermediate',
        'Airbnb',
        'Travel marketplace',
        'B',
        'In a two-sided marketplace, you must solve the ''cold start'' problem by seeding the supply side before driving demand. If users search for ''Pro Tours'' and find none, they bounce and never return. Therefore, Airbnb must onboard hosts (supply) before launching to guests (demand) (Option B). Option A guarantees a terrible guest experience. Option C wastes money on ads before supply exists. Option D makes no sense for multi-day real-world trips.',
        ARRAY['go_to_market', 'two_sided_marketplace', 'supply_and_demand']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch to guests first to generate waitlist demand, then recruit hosts to fulfill that demand.', false),
    (v_q_id, 'B', 'Seed the supply side by onboarding and training ''Pro Tour'' hosts weeks before revealing the feature to guests.', true),
    (v_q_id, 'C', 'Run massive digital ads globally on day one to simultaneously acquire both hosts and guests.', false),
    (v_q_id, 'D', 'Launch the feature virtually first, allowing guests to experience the tour via Zoom before booking in person.', false);

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
        'Notion''s Post-launch Communication',
        E'Notion launches a redesign of their sidebar navigation. Within hours, Twitter and Reddit are flooded with power users complaining that the new layout slows down their workflow. Metrics show daily active usage hasn''t dropped, but the vocal backlash is intense.\n\nHow should the PM handle this post-launch crisis?',
        'intermediate',
        'Notion',
        'Productivity and workspace tool',
        'C',
        'UI redesigns almost always trigger ''change aversion'' from vocal power users. The PM should monitor the situation, clearly communicate the rationale behind the change, and watch actual behavioral metrics before reacting (Option C). Option A is a knee-jerk reaction that prevents progress. Option B is passive-aggressive and damages brand trust. Option D is misleading, as you cannot promise to revert something just to quiet a crowd if you have no intention of doing so.',
        ARRAY['post_launch_monitoring', 'change_aversion', 'user_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately roll back the redesign to appease the power users, as they represent the most valuable customer segment.', false),
    (v_q_id, 'B', 'Ignore the feedback entirely, as social media complaints rarely correlate with actual business metrics.', false),
    (v_q_id, 'C', 'Acknowledge the feedback publicly, explain the long-term rationale for the design, and wait to see if the complaints subside as users adapt.', true),
    (v_q_id, 'D', 'Reply to the Reddit threads promising that the old sidebar will be brought back as a toggle next week.', false);

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
        'Figma''s Degradation Strategy',
        E'Figma launches a new ''AI Auto-Layout'' feature. It is incredibly popular, but the computational load is 5x higher than expected, threatening to crash the main canvas rendering servers for all users.\n\nWhat is the best immediate mitigation strategy?',
        'intermediate',
        'Figma',
        'Collaborative design tool',
        'D',
        'When a non-critical new feature threatens the core product (canvas rendering), the PM must execute a graceful degradation strategy. Disabling the heavy AI feature via a kill switch protects the core experience (Option D). Option A risks crashing the whole platform. Option B is an engineering task that takes too long during an active incident. Option C is technically complex and still risks performance issues for paid users.',
        ARRAY['risk_mitigation', 'graceful_degradation', 'incident_response']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the feature on and let the servers slow down; user engagement with the AI is more important than pure speed.', false),
    (v_q_id, 'B', 'Immediately rewrite the AI algorithm to use less CPU, and deploy the hotfix within the hour.', false),
    (v_q_id, 'C', 'Throttle the feature so it only works for enterprise customers, ensuring the server load is monetized.', false),
    (v_q_id, 'D', 'Use a feature flag to instantly disable the AI Auto-Layout globally, protecting core canvas performance.', true);

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
        'Stripe''s Partner Launch',
        E'Stripe is partnering with Shopify to launch an integrated ''Shop Pay on Stripe'' button. The launch is scheduled for Tuesday. On Monday, Shopify informs Stripe that their API endpoint will have a 5-second latency due to an unresolvable database issue on their end.\n\nWhat is the PM''s best course of action?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'B',
        'A 5-second latency in checkout is a fatal flaw that will cause massive cart abandonment and merchant fury. When a partner dependency fails critical performance SLAs, the launch must be delayed (Option B). Option A blames the partner but still results in a terrible Stripe user experience. Option C is deceptive and harms the partner relationship. Option D relies on an impossible engineering feat (Stripe caching Shopify''s real-time checkout logic).',
        ARRAY['partner_launch', 'cross_functional_alignment', 'go_no_go']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch as planned, but add a disclaimer to the UI explaining that Shopify''s servers are slow.', false),
    (v_q_id, 'B', 'Delay the launch until Shopify can meet the required latency SLAs, as slow checkouts damage merchant trust.', true),
    (v_q_id, 'C', 'Proceed with the launch, but silently route the payments through a different processor without telling Shopify.', false),
    (v_q_id, 'D', 'Cache all the Shopify data on Stripe''s servers to artificially speed up the transaction.', false);

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
        'Netflix''s Soft Launch',
        E'Netflix is considering a drastic change to its pricing model, introducing a lower-tier ad-supported plan. Before rolling it out in the US, the PM decides to launch it entirely in Canada.\n\nWhat is the primary rationale for using Canada as a ''Soft Launch'' proxy market?',
        'intermediate',
        'Netflix',
        'Streaming platform',
        'B',
        'A proxy market soft launch involves releasing a feature in a smaller market with similar demographics and behaviors to the primary market (the US). Canada is culturally and economically similar enough to provide highly predictive data on adoption, churn, and revenue impact without risking the primary revenue base (Option B). Option A is a geographic misconception. Option C is incorrect; US PR still reports on Canadian launches. Option D is unrelated to the strategic purpose of a proxy market.',
        ARRAY['soft_launch', 'proxy_market', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Because Canada has lower privacy regulations than the US, allowing for more aggressive data tracking.', false),
    (v_q_id, 'B', 'Canada''s demographic and behavioral profile is similar to the US, providing predictive data while risking a smaller revenue base.', true),
    (v_q_id, 'C', 'To prevent US tech blogs and competitors from noticing the new pricing model.', false),
    (v_q_id, 'D', 'Because server hosting costs are significantly cheaper in Canada during the initial testing phase.', false);

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
        'DoorDash''s Launch Retrospective',
        E'DoorDash''s recent launch of ''Grocery Delivery'' was delayed by three weeks due to severe miscommunication between the Engineering and Courier Operations teams. The PM is hosting a post-launch retrospective.\n\nWhat is the most productive approach for the PM to take in this meeting?',
        'intermediate',
        'DoorDash',
        'Food delivery platform',
        'C',
        'A successful retrospective must be ''blameless''. The goal is to uncover systemic process failures, not to punish individuals. Focusing on how the process allowed the miscommunication (Option C) leads to actionable improvements. Option A creates a toxic culture. Option B ignores the root cause, guaranteeing the mistake will happen again. Option D is an authoritative overreach that alienates the team.',
        ARRAY['launch_retrospective', 'post_mortem', 'cross_functional_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Identify specific individuals who failed to communicate and formally reprimand them in front of the team.', false),
    (v_q_id, 'B', 'Focus entirely on the positive metrics of the launch and avoid discussing the delay to keep morale high.', false),
    (v_q_id, 'C', 'Conduct a blameless ''5 Whys'' analysis to understand what process breakdowns led to the miscommunication.', true),
    (v_q_id, 'D', 'Unilaterally declare a new process where the PM must approve all emails sent between Engineering and Operations.', false);

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
        'Shopify''s Enterprise vs SMB Launch',
        E'Shopify is launching a new ''Advanced Tax Calculation'' module. The platform serves both small mom-and-pop shops (SMB) and massive Enterprise clients (Shopify Plus).\n\nHow should the launch strategy differ between these two segments?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'A',
        'Enterprise clients have rigid workflows, custom integrations, and zero tolerance for surprise changes. They require advanced notice, white-glove onboarding, and sandbox testing. SMBs usually prefer seamless, automatic updates (Option A). Option B is backwards; SMBs don''t read long documentation, and Enterprises hate automatic unannounced changes. Option C is unfair and damages the brand. Option D ignores the distinct needs of the two segments.',
        ARRAY['go_to_market', 'segmentation', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Provide Enterprise clients with early sandbox access, account manager training, and a manual opt-in; automatically roll it out to SMBs with in-app tooltips.', true),
    (v_q_id, 'B', 'Automatically roll it out to Enterprise clients to maximize immediate revenue, but require SMBs to read documentation before opting in.', false),
    (v_q_id, 'C', 'Launch it only for Enterprise clients, as SMBs do not care about tax compliance.', false),
    (v_q_id, 'D', 'Use the exact same launch playbook for both segments to ensure brand consistency and reduce marketing overhead.', false);

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
        'GitHub''s Pricing Tier Launch',
        E'GitHub is launching a new, more expensive ''Pro'' tier that includes advanced security scanning. The previous tier, ''Standard'', will no longer include these security features for new users.\n\nHow should the PM handle the thousands of existing ''Standard'' users who currently rely on the security features?',
        'intermediate',
        'GitHub',
        'Developer platform',
        'C',
        'When changing pricing and packaging, forcefully downgrading existing users or raising their prices without warning causes massive churn and reputational damage. ''Grandfathering'' existing users—letting them keep their current features at their current price (Option C)—is the standard best practice to maintain loyalty while applying the new pricing to net-new users. Option A causes instant churn. Option B is technically messy and confusing. Option D is a bait-and-switch that destroys trust.',
        ARRAY['pricing_launch', 'go_to_market', 'customer_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately lock the features and force them to upgrade to ''Pro'' to access their security scans.', false),
    (v_q_id, 'B', 'Delete their historical security data to free up server space for the new ''Pro'' tier customers.', false),
    (v_q_id, 'C', '''Grandfather'' existing users, allowing them to keep the security features on their current plan, while applying the new rules to new signups.', true),
    (v_q_id, 'D', 'Give them a 7-day warning, then automatically charge their credit cards for the higher ''Pro'' tier.', false);

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
        'Discord''s Feature Gating',
        E'Discord is launching ''Custom Server Profiles,'' a feature exclusively for users who pay for ''Nitro'' (the premium subscription). \n\nFrom a release management perspective, what is the best way to handle non-paying users interacting with this feature?',
        'intermediate',
        'Discord',
        'Voice and text chat platform',
        'B',
        'Feature gating shouldn''t just hide features; it should use them as monetization surfaces. Allowing non-paying users to see the feature UI, but gating the save/publish action behind a paywall (Option B), drives conversion. Hiding it completely (Option A) misses an upsell opportunity. Option C is a terrible UX that frustrates users. Option D is a technical nightmare that bloats the app size unnecessarily.',
        ARRAY['feature_gating', 'monetization', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Completely hide the UI elements from non-paying users so they don''t get confused.', false),
    (v_q_id, 'B', 'Show the UI to everyone, allow non-paying users to preview the feature, but trigger a paywall when they try to save the profile.', true),
    (v_q_id, 'C', 'Allow non-paying users to use the feature fully, but randomly delete their profiles after 24 hours to encourage them to upgrade.', false),
    (v_q_id, 'D', 'Maintain two completely separate codebases and app binaries—one for free users and one for Nitro users.', false);

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
        'Zoom''s Launch Timing',
        E'It is November 15th. Zoom''s team has finalized a massive rewrite of the video encoding backend. QA has signed off. The PM notes that Thanksgiving (US) and the December holiday period are approaching, which historically means massive spikes in family video calls and a skeleton crew of Zoom engineers on duty.\n\nWhat is the most responsible launch decision?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'C',
        'Major backend rewrites carry high inherent risk. Launching them right before peak traffic events when the engineering team is understaffed (holidays) is a recipe for catastrophe. Implementing a holiday code freeze and delaying the launch to January (Option C) is standard industry practice. Option A guarantees a disaster if something goes wrong. Option B implies working engineers through holidays, which burns out the team. Option D is irrelevant; beta testers don''t mitigate the risk of a full-scale backend deployment during peak times.',
        ARRAY['launch_timing', 'code_freeze', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch immediately. The holiday traffic spike will be a great stress test for the new backend.', false),
    (v_q_id, 'B', 'Launch on Thanksgiving Day, and require all engineers to cancel their holidays to monitor the rollout.', false),
    (v_q_id, 'C', 'Institute a code freeze. Delay the global rollout until January when traffic normalizes and the full engineering team is available.', true),
    (v_q_id, 'D', 'Launch it only to users who explicitly opt-in to ''Beta Features'' in their settings.', false);

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
        'Robinhood''s Zero Downtime Launch',
        E'Robinhood is executing a database schema migration to support a new ''Fractional Shares'' feature. The market is open, and millions of trades are happening per minute. \n\nTo ensure a ''zero downtime'' launch without disrupting active trades, which rollout pattern MUST the engineering and product team follow?',
        'advanced',
        'Robinhood',
        'Financial trading app',
        'A',
        'In high-availability systems, schema migrations must be decoupled from application code deployments. The pattern is: Add the new database columns first (without breaking old code), deploy code that writes to both old and new schemas, backfill data, then switch reads to the new schema, and finally deprecate the old columns (Option A). Option B requires massive downtime. Option C causes data loss. Option D is impossible because databases cannot be ''A/B tested'' in this manner without data corruption.',
        ARRAY['zero_downtime', 'database_migration', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A multi-step deployment: expand schema, dual-write to old/new, migrate data, switch reads, then deprecate old schema.', true),
    (v_q_id, 'B', 'A Big Bang deployment where the app servers are taken offline for 5 minutes while the database schema updates.', false),
    (v_q_id, 'C', 'Spin up a completely new database, route new users to it, and abandon the data of legacy users.', false),
    (v_q_id, 'D', 'Run an A/B test on the database layer, routing 50% of trades to the new schema and 50% to the old.', false);

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
        'Tinder''s Algorithmic Launch',
        E'Tinder has developed a new Machine Learning matching algorithm. In offline tests, it increases match relevance by 20%. However, when launched to a 5% test cohort in production, the match rate actually drops by 10%.\n\nWhat is the most likely ''cold start'' issue causing this launch failure?',
        'advanced',
        'Tinder',
        'Dating app',
        'B',
        'Machine learning algorithms often suffer from a ''cold start'' problem in production. Even if offline testing looks good, the production model lacks the real-time historical engagement data for new users/swipes that it relies on to make accurate predictions. It needs time to gather live feedback loops to calibrate (Option B). Option A is a basic UX bug, not an algorithmic cold start. Option C violates the premise of an algorithm launch. Option D describes a network effect failure, not an algorithmic cold start.',
        ARRAY['algorithmic_launch', 'cold_start', 'machine_learning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The 5% cohort was unable to download the latest app update containing the new UI.', false),
    (v_q_id, 'B', 'The new model lacked sufficient real-time interaction history in the live environment to calibrate its weights, requiring a warmup period.', true),
    (v_q_id, 'C', 'The algorithm was inherently biased against users who pay for Tinder Gold.', false),
    (v_q_id, 'D', 'The 5% cohort was too geographically dispersed to find matches near them.', false);

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
        'Slack''s Cannibalization Post-Launch',
        E'Slack launches ''Huddles'' (quick audio calls). One month post-launch, the PM reviews the metrics:\n- Huddles adoption is high (30% DAU).\n- Traditional Slack text messages sent have decreased by 15%.\n- Overall time spent in the app has increased by 10%.\n\nShould the PM view this launch as a success or a failure, and why?',
        'advanced',
        'Slack',
        'Workplace communication platform',
        'C',
        'This is an example of ''strategic cannibalization.'' Huddles is eating into text messaging, but it is increasing overall engagement (time spent in app). If a new feature cannibalizes an old one but improves the overarching North Star metric (engagement/retention), it is a successful product evolution (Option C). Option A blindly fears any cannibalization. Option B misses the point that the overall ecosystem value grew. Option D is an irrational conclusion to a successful feature adoption.',
        ARRAY['post_launch_monitoring', 'cannibalization', 'product_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Failure. Cannibalizing a core feature (text messaging) destroys the original product value proposition.', false),
    (v_q_id, 'B', 'Failure. The increase in app time is likely just users struggling to figure out how the audio UI works.', false),
    (v_q_id, 'C', 'Success. While Huddles cannibalized text, it increased overall ecosystem engagement, proving users found a more efficient way to communicate.', true),
    (v_q_id, 'D', 'Success, but only if the PM immediately initiates a plan to deprecate text messaging entirely.', false);

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
        'Uber''s Regulatory Launch',
        E'Uber is rolling out ''Surge Pricing V2'' globally. The launch is managed via feature flags. During the rollout, a massive hurricane hits Miami, and local price-gouging laws instantly go into effect.\n\nWhat is the most robust launch architecture Uber should have in place to handle this?',
        'advanced',
        'Uber',
        'Ride-hailing platform',
        'B',
        'Global products operating in regulated physical environments (like Uber) must build granular, geofenced control planes. In emergencies, they need to instantly disable features (like surge pricing) via dynamic geofencing without taking down the global system or pushing new code (Option B). Option A is manual and error-prone. Option C punishes the whole world for a local event. Option D relies on app store reviews, which take days, guaranteeing legal violations.',
        ARRAY['regulatory_compliance', 'geofencing', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Require engineers to manually delete the surge pricing code from the Miami servers.', false),
    (v_q_id, 'B', 'A dynamic geofencing system linked to feature flags, allowing operations teams to instantly disable surge pricing in specific polygons.', true),
    (v_q_id, 'C', 'A global kill switch that turns off surge pricing worldwide whenever an emergency is declared anywhere.', false),
    (v_q_id, 'D', 'Push an immediate app update to the iOS store that removes the feature, hoping Apple approves it in time.', false);

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
        'Spotify''s Global Launch Timing',
        E'Spotify is launching ''Spotify Wrapped'', a viral annual campaign. The marketing team wants a ''global simultaneous reveal'' at exactly 9:00 AM EST.\n\nAs a PM, why might you strongly push back against a strict, single-minute global launch?',
        'advanced',
        'Spotify',
        'Music streaming app',
        'A',
        'A simultaneous global launch for a heavily data-intensive, highly anticipated feature (like Wrapped) will create a massive ''thundering herd'' problem. Millions of users requesting personalized data arrays at the exact same second will overwhelm the CDN and backend databases, causing an outage (Option A). Option B is false; CDNs can cache data globally. Option C is false; App Store delays can be mitigated by releasing the binary early and hiding the feature behind a server flag. Option D is a marketing concern, not a technical launch constraint.',
        ARRAY['launch_timing', 'infrastructure', 'thundering_herd']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It creates a ''thundering herd'' of traffic that guarantees database bottlenecks and CDN overloads, risking a total platform outage.', true),
    (v_q_id, 'B', 'Because Content Delivery Networks (CDNs) cannot legally distribute encrypted user data across international borders simultaneously.', false),
    (v_q_id, 'C', 'Because Apple App Store review times vary, making it impossible to coordinate app availability.', false),
    (v_q_id, 'D', 'Because 9:00 AM EST is midnight in Japan, leading to terrible social media engagement in Asian markets.', false);

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
        'Airbnb''s Segment Analysis',
        E'Airbnb rolls out a new ''Instant Book'' ranking algorithm to 10% of users globally. Overall, bookings increase by 2%. The PM digs into the data:\n- North America bookings: down 3%\n- Europe bookings: down 2%\n- Asia bookings: down 4%\n\nHow can the overall bookings increase if every region decreased?',
        'advanced',
        'Airbnb',
        'Travel marketplace',
        'B',
        'This scenario describes Simpson''s Paradox. The overall metric can show a positive trend if there''s a heavy shift in the composition of the traffic toward a segment with a naturally higher baseline conversion rate, even if the treatment degraded conversion within every segment individually (Option B). Option A is biologically impossible. Option C implies basic math errors, which isn''t the root of the paradox. Option D is a currency issue, not a bookings volume issue.',
        ARRAY['post_launch_monitoring', 'simpsons_paradox', 'data_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The data pipeline is clearly broken and dropping tracking events randomly.', false),
    (v_q_id, 'B', 'Simpson''s Paradox: The traffic mix shifted heavily toward a region with a higher baseline conversion rate, skewing the aggregate average.', true),
    (v_q_id, 'C', 'The A/B testing tool incorrectly calculated the statistical significance bounds.', false),
    (v_q_id, 'D', 'Currency exchange rates fluctuated during the rollout, inflating the perceived revenue.', false);

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
        'Notion''s Post-Mortem Root Cause',
        E'Notion launched an ''Offline Mode'' that corrupted data for 500 users. During the post-mortem, the team finds the bug occurred because a junior engineer bypassed the staging environment to push a hotfix. \n\nApplying the ''5 Whys'' framework, what is the best ''root cause'' conclusion for the PM to document?',
        'advanced',
        'Notion',
        'Productivity and workspace tool',
        'D',
        'In a blameless post-mortem, human error is rarely the root cause; process failure is. The ''5 Whys'' approach pushes past ''who did it'' to ''why did the system allow them to do it''. The root cause is the lack of technical safeguards (CI/CD permissions) that permitted a single developer to bypass CI checks (Option D). Option A stops at human error. Option B is a punitive management response, not a process fix. Option C is a band-aid that doesn''t solve the underlying deployment vulnerability.',
        ARRAY['launch_retrospective', '5_whys', 'process_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The root cause is human error; the junior engineer was careless and ignored protocol.', false),
    (v_q_id, 'B', 'The root cause is poor management; the engineering manager failed to supervise their direct report.', false),
    (v_q_id, 'C', 'The root cause is a lack of documentation; the staging environment instructions were not clear.', false),
    (v_q_id, 'D', 'The root cause is a CI/CD process failure; the deployment pipeline lacked branch protection rules enforcing staging checks.', true);

    RAISE NOTICE 'Successfully inserted 35 questions for Product Launch';

END $$;
