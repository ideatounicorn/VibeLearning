-- ============================================
-- ASSESSMENT: Feature Delivery
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
    WHERE slug = 'feature-delivery';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug feature-delivery not found. Run the seed data first.';
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
        'Spotify''s Acceptance Criteria',
        'Spotify''s PM is writing a PRD for a new "Collaborative Playlist Privacy" toggle. Which of the following is the best example of a well-written Acceptance Criterion for this feature?',
        'foundational',
        'Spotify',
        'Building a privacy toggle for collaborative playlists',
        'C',
        'Acceptance criteria should be specific, testable, and outcome-oriented. Option C follows the BDD (Behavior-Driven Development) Given/When/Then format, making it clear exactly what should happen under specific conditions. Option A is too vague. Option B dictates technical implementation (database updates) rather than user outcomes. Option D focuses on design specs rather than functional logic.',
        ARRAY['acceptance_criteria', 'prd', 'agile']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The privacy toggle should work smoothly and not confuse users.', false),
    (v_q_id, 'B', 'When clicked, the frontend sends a POST request to update the ''is_private'' boolean in the database.', false),
    (v_q_id, 'C', 'Given a user is the owner of a collaborative playlist, when they toggle ''Private'', then the playlist should immediately be hidden from search results.', true),
    (v_q_id, 'D', 'The toggle should be 24x24 pixels, colored Spotify Green, and placed in the top right corner.', false);

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
        'Slack''s Scope Creep',
        'Mid-sprint, Slack''s Sales VP demands a new "priority DM" feature be added to the current sprint to close a major enterprise deal. The team''s sprint capacity is already full. How should the PM respond?',
        'foundational',
        'Slack',
        'Handling mid-sprint stakeholder requests',
        'D',
        'Mid-sprint scope additions jeopardize the team''s commitment and focus. The PM must manage stakeholder expectations by evaluating the trade-offs. Option D appropriately acknowledges the request while forcing a prioritization conversation: if the new feature comes in, something of equal size must come out. Option A disrupts the sprint. Option B ignores business reality. Option C promises something without consulting the engineering team''s capacity.',
        ARRAY['scope_creep', 'sprint_management', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add the feature to the current sprint and ask the engineering team to work overtime.', false),
    (v_q_id, 'B', 'Reject the request outright because sprints are immutable under all circumstances.', false),
    (v_q_id, 'C', 'Accept the feature into the current sprint, but quietly push a currently planned feature to the next sprint.', false),
    (v_q_id, 'D', 'Explain the sprint is locked, estimate the new feature, and ask the VP which currently prioritized feature they are willing to remove to make room for it.', true);

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
        'Netflix''s Feature Flags',
        'Netflix is deploying a major rewrite of its video player UI. Which of the following is the primary benefit of deploying this change behind a feature flag?',
        'foundational',
        'Netflix',
        'Deploying a major UI update',
        'B',
        'Feature flags decouple deployment (pushing code to production) from release (making the feature visible to users). This allows teams to safely deploy code without immediately exposing it, enabling gradual rollouts and instant rollbacks if issues occur. Option A is incorrect; feature flags add technical complexity. Option C is false; feature flags don''t prevent bugs, they mitigate their impact. Option D is a misunderstanding of version control.',
        ARRAY['feature_flags', 'rollout_strategy', 'deployment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It completely eliminates the technical debt associated with maintaining two versions of the UI.', false),
    (v_q_id, 'B', 'It decouples the code deployment from the feature release, allowing for an instant rollback if critical bugs appear.', true),
    (v_q_id, 'C', 'It automatically prevents code bugs from being pushed into the production environment.', false),
    (v_q_id, 'D', 'It replaces the need for branching in Git, allowing all developers to work on the main branch without conflicts.', false);

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
        'Airbnb''s MVP Scoping',
        'Airbnb wants to build a "Pet Friendly Stays" feature. The engineering team estimates that building a dynamic filtering system, real-time pet fee calculation, and host approval workflows will take 4 months. What is the best MVP to validate user demand?',
        'foundational',
        'Airbnb',
        'Scoping an MVP for pet-friendly stays',
        'A',
        'An MVP (Minimum Viable Product) should validate the core hypothesis with the least amount of effort. Option A (a simple checkbox filter) validates if guests actually care to filter for pets, requiring minimal engineering effort compared to the full vision. Option B takes too long. Option C is a "fake door" test, which can validate demand but often creates poor user experiences. Option D focuses on hosts, but guest demand is the primary risk.',
        ARRAY['mvp', 'scoping', 'hypothesis_validation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A simple ''Allows Pets'' checkbox filter that relies on the host''s existing text description, built in 2 weeks.', true),
    (v_q_id, 'B', 'A phased rollout of the full 4-month feature, starting only in California.', false),
    (v_q_id, 'C', 'A ''Bring a Pet'' button that simply shows a ''Coming Soon'' modal to measure click-through rates.', false),
    (v_q_id, 'D', 'A host-facing dashboard to let hosts upload pictures of their own pets.', false);

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
        'Uber''s Feature Breakdown',
        'An Uber PM is breaking down an epic for "Split Fare." Which of the following represents the best approach to vertical slicing (delivering value incrementally)?',
        'foundational',
        'Uber',
        'Breaking down an epic for splitting ride fares',
        'C',
        'Vertical slicing means breaking work down so that each piece delivers end-to-end user value, rather than delivering architectural layers (frontend, backend) in isolation. Option C delivers a complete, albeit limited, user flow (splitting exactly 50/50 with one person). Options A and B are horizontal slices (backend first, UI first). Option D is a phased rollout, not a feature breakdown.',
        ARRAY['vertical_slicing', 'agile', 'epic_breakdown']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Sprint 1: Build the backend database schema. Sprint 2: Build the API. Sprint 3: Build the iOS UI.', false),
    (v_q_id, 'B', 'Sprint 1: Build all UI screens with mock data. Sprint 2: Connect the UI to the live backend.', false),
    (v_q_id, 'C', 'Sprint 1: Split fare exactly 50/50 with one other user. Sprint 2: Custom split percentages. Sprint 3: Split with multiple users.', true),
    (v_q_id, 'D', 'Sprint 1: Launch the full feature to 10% of users. Sprint 2: Launch to 50% of users. Sprint 3: Launch globally.', false);

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
        'Stripe''s Rollout Strategy',
        'Stripe is launching a new checkout page that improves conversion but alters the CSS classes merchants rely on. Which rollout strategy is most appropriate?',
        'foundational',
        'Stripe',
        'Launching a breaking change to Checkout',
        'C',
        'For B2B products where changes can break a customer''s implementation (like CSS overrides), an opt-in beta followed by a communicated deprecation timeline is standard. A big bang rollout (A) will break merchant sites. An A/B test (B) is problematic for breaking API/CSS changes as merchants can''t predict which version renders. A shadow launch (D) tests backend load, not frontend CSS breakages.',
        ARRAY['rollout_strategy', 'b2b', 'change_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Big bang release to all merchants overnight to rip the band-aid off.', false),
    (v_q_id, 'B', 'A 50/50 A/B test randomly assigning end-users to the new checkout to measure conversion.', false),
    (v_q_id, 'C', 'An opt-in beta for merchants to test the new checkout, followed by a 90-day deprecation notice for the old version.', true),
    (v_q_id, 'D', 'A shadow launch where traffic is routed to both checkouts but only the old one is displayed.', false);

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
        'Figma''s Dependency Management',
        'Figma''s PM is building a new "Widgets" feature. The frontend is on track, but the backend API depends on the Core Infrastructure team, which is delayed by 3 weeks. What is the best immediate course of action?',
        'foundational',
        'Figma',
        'Managing delayed cross-team dependencies',
        'D',
        'When facing an API dependency delay, the frontend team should not sit idle. By establishing a mock API contract, the frontend team can continue building and testing the UI independently. Option A halts progress. Option B risks creating throwaway, buggy code. Option C is a severe overreaction for a 3-week delay.',
        ARRAY['dependency_management', 'cross_team', 'execution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pause all frontend development and reassign the engineers to bug fixes until the backend is ready.', false),
    (v_q_id, 'B', 'Have the frontend engineers build a temporary, hacky backend themselves to unblock the work.', false),
    (v_q_id, 'C', 'Cancel the ''Widgets'' feature entirely as the timeline has been compromised.', false),
    (v_q_id, 'D', 'Agree on a strict API contract with the Infrastructure team and have the frontend team use mock data to finish the UI.', true);

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
        'DoorDash''s Definition of Done',
        'DoorDash engineers declare the new ''Group Orders'' feature is ''done'' because the code is merged to main. However, Customer Support hasn''t been trained, and the marketing email isn''t ready. What PM concept did the team fail to align on?',
        'foundational',
        'DoorDash',
        'Assessing feature readiness',
        'B',
        'The Definition of Done (DoD) is a shared understanding of what it means for a piece of work to be considered complete. In mature product teams, DoD extends beyond ''code merged'' to include QA, documentation, and stakeholder readiness. Acceptance criteria (A) apply to a specific user story, not the release process. Velocity (C) is a measure of speed. Continuous Integration (D) is an engineering practice.',
        ARRAY['definition_of_done', 'release_readiness', 'agile']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Acceptance Criteria', false),
    (v_q_id, 'B', 'Definition of Done', true),
    (v_q_id, 'C', 'Sprint Velocity', false),
    (v_q_id, 'D', 'Continuous Integration', false);

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
        'Robinhood''s Technical Debt',
        'Robinhood''s portfolio screen is loading slowly. Engineering asks to dedicate the next sprint entirely to refactoring code (paying down technical debt) rather than building the planned ''Crypto Staking'' feature. How should the PM evaluate this request?',
        'foundational',
        'Robinhood',
        'Prioritizing tech debt vs new features',
        'B',
        'Technical debt must be quantified in terms of user impact and business cost. If the slow load times are causing churn or support tickets that outweigh the projected revenue of Crypto Staking, refactoring is the right business decision. Option A ignores the business impact. Option C incorrectly assumes tech debt is purely an engineering concern. Option D is an unrealistic mandate.',
        ARRAY['technical_debt', 'prioritization', 'trade_offs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Approve it immediately; engineering should always have final say over technical debt.', false),
    (v_q_id, 'B', 'Assess the business impact of the slow load times (e.g., increased churn, support tickets) against the projected revenue of Crypto Staking.', true),
    (v_q_id, 'C', 'Reject it; product managers only prioritize user-facing features, while engineering managers handle technical debt on their own time.', false),
    (v_q_id, 'D', 'Approve it, but mandate that the team must never accumulate technical debt again.', false);

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
        'Notion''s User Stories',
        'A Notion PM is writing a user story for a new offline mode. Which format best captures the value of this feature from the user''s perspective?',
        'foundational',
        'Notion',
        'Writing user stories for offline capabilities',
        'A',
        'The standard user story format is ''As a [user type], I want to [action], so that [benefit/value].'' Option A perfectly follows this structure, clearly defining the persona, the desired capability, and the underlying user value. Option B is an engineering task. Option C is a product requirement, not a user story. Option D focuses on the business goal rather than the user''s need.',
        ARRAY['user_stories', 'requirements', 'agile']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As a frequent traveler, I want to edit my documents without an internet connection, so that I can remain productive on flights.', true),
    (v_q_id, 'B', 'The application must cache the last 50 viewed documents in local storage.', false),
    (v_q_id, 'C', 'Implement an offline syncing mechanism that resolves merge conflicts upon reconnection.', false),
    (v_q_id, 'D', 'As Notion, we want to build offline mode to increase our market share against Evernote.', false);

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
        'GitHub''s Dogfooding Strategy',
        'GitHub is developing a major overhaul of its Pull Request review interface. Before opening a public beta, the PM decides to mandate ''dogfooding'' for two weeks. What is the primary purpose of this phase?',
        'intermediate',
        'GitHub',
        'Using dogfooding for internal validation',
        'C',
        'Dogfooding (using your own product) helps internal teams catch glaring usability issues, workflow friction, and critical bugs before exposing real customers to a broken experience. Option A is incorrect; internal usage cannot validate external market fit. Option B is incorrect; dogfooding rarely uncovers extreme scale edge cases. Option D is a marketing tactic, not the purpose of dogfooding.',
        ARRAY['dogfooding', 'beta_testing', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To mathematically prove product-market fit before investing in marketing.', false),
    (v_q_id, 'B', 'To stress-test the backend architecture under extreme load conditions.', false),
    (v_q_id, 'C', 'To identify friction points and usability bugs by having employees use the feature in real-world scenarios.', true),
    (v_q_id, 'D', 'To generate artificial hype and FOMO by leaking screenshots from internal employee accounts.', false);

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
        'Discord''s Feature Splitting',
        'Discord is building ''Threaded Voice Channels.'' The team determines that delivering the full feature will take 3 months. The PM wants to release a vertical slice in 1 month. Which of the following is the BEST example of a vertical slice?',
        'intermediate',
        'Discord',
        'Vertical slicing a complex voice feature',
        'B',
        'A vertical slice must deliver end-to-end functionality (UI + Backend) that users can actually interact with, even if limited in scope. Option B (audio only, no video/screenshare) allows users to actually use the core thread functionality. Option A is horizontal slicing (UI only). Option C is horizontal slicing (Backend only). Option D is an administrative feature, not the core user value.',
        ARRAY['vertical_slicing', 'agile', 'mvp']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Deploying the complete UI for threaded voice channels, but the buttons don''t connect to the backend audio servers yet.', false),
    (v_q_id, 'B', 'Releasing threaded channels that only support audio, delaying video and screenshare capabilities for a future release.', true),
    (v_q_id, 'C', 'Building the backend audio routing infrastructure and verifying it works via command-line tools, without any UI.', false),
    (v_q_id, 'D', 'Building the server-admin settings panel to configure thread permissions before building the threads themselves.', false);

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
        'Zoom''s Deadline Pressure',
        'Zoom''s PM is leading the delivery of ''End-to-End Encryption'' promised publicly for May 1st. On April 15th, Engineering discovers a security edge case that requires rewriting the key-exchange logic, pushing the launch to May 20th. How should the PM handle this?',
        'intermediate',
        'Zoom',
        'Handling critical delays on a public commitment',
        'C',
        'When a public deadline for a security/trust feature is missed, transparency and safety are paramount. Option C addresses the issue head-on: acknowledge the delay, communicate the reason (prioritizing security), and adjust the timeline. Option A sacrifices the core value proposition (security) for a date. Option B is unethical and dangerous. Option D introduces massive operational risk and doesn''t solve the core issue.',
        ARRAY['delivery_risk', 'communication', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Quietly remove the edge-case from the scope to hit the May 1st deadline, planning to fix it in a patch.', false),
    (v_q_id, 'B', 'Launch a fake ''Encrypted'' icon on May 1st to satisfy the PR commitment while engineers finish the real backend.', false),
    (v_q_id, 'C', 'Immediately brief leadership, draft public messaging explaining the delay prioritizes user security, and update the timeline.', true),
    (v_q_id, 'D', 'Fire the engineering manager for missing the deadline and mandate the team works 24/7.', false);

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
        'Amazon''s Third-Party Dependency',
        'Amazon is integrating a new third-party logistics API for ''Same-Day Delivery'' tracking. The third-party API goes down constantly in staging. The planned launch is in 2 weeks. What is the most robust delivery decision?',
        'intermediate',
        'Amazon',
        'Mitigating third-party API instability',
        'B',
        'When dealing with an unstable external dependency, a PM must protect the user experience. Implementing a graceful degradation or fallback mechanism (Option B) ensures the core product remains functional even when the 3rd party fails. Option A risks breaking the production app. Option C gives up too easily. Option D is legally and technically implausible in 2 weeks.',
        ARRAY['dependency_management', 'graceful_degradation', 'risk_mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch as planned; the third-party vendor signed an SLA, so it''s their legal problem if it breaks in production.', false),
    (v_q_id, 'B', 'Implement a fallback UI that gracefully degrades to ''Standard Tracking'' if the third-party API times out.', true),
    (v_q_id, 'C', 'Cancel the project immediately; Amazon should never rely on third-party APIs.', false),
    (v_q_id, 'D', 'Demand Amazon''s engineers rebuild the third-party logistics network from scratch in 2 weeks.', false);

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
        'Duolingo''s Rollout Crisis',
        'Duolingo is rolling out a new ''Leaderboard'' architecture via a feature flag. At 10% rollout, the PM notices that while crash rates are normal, users in the test group are completing 40% fewer lessons. What is the correct immediate action?',
        'intermediate',
        'Duolingo',
        'Handling a negative metric impact during staged rollout',
        'A',
        'A staged rollout is designed to catch catastrophic regressions before they affect the whole user base. A 40% drop in core engagement is a critical regression. The PM must immediately halt and rollback the feature flag to protect the business (Option A), then investigate. Option B relies on hoping the data is a fluke. Option C makes the problem worse. Option D wastes time when immediate mitigation is needed.',
        ARRAY['rollout_strategy', 'feature_flags', 'incident_response']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately turn off the feature flag, rolling back the 10% to the old experience, and investigate the drop.', true),
    (v_q_id, 'B', 'Wait 7 more days to ensure statistical significance before taking any action.', false),
    (v_q_id, 'C', 'Increase the rollout to 50% to see if the metric stabilizes with a larger sample size.', false),
    (v_q_id, 'D', 'Call an emergency sprint planning meeting to redesign the Leaderboard UI.', false);

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
        'Spotify''s Velocity Drop',
        'Spotify''s podcast discovery team has seen their sprint velocity drop from 40 story points to 20 over the last three sprints. The engineers complain about ''spaghetti code'' in the recommendation engine. What is the most appropriate PM action?',
        'intermediate',
        'Spotify',
        'Addressing velocity drop due to tech debt',
        'D',
        'A consistent drop in velocity accompanied by complaints of ''spaghetti code'' is a classic symptom of unchecked technical debt. The PM must collaborate with engineering to allocate capacity for refactoring. Option D is the standard agile approach: allocate a percentage of sprint capacity to debt repayment. Option A addresses the symptom, not the cause. Option B is micromanagement. Option C assumes a ''big bang'' rewrite is needed, which is rarely the best first step.',
        ARRAY['velocity', 'technical_debt', 'agile_capacity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reduce the scope of all future features by 50% to match the new velocity.', false),
    (v_q_id, 'B', 'Stop using story points and switch to tracking hours to ensure engineers are working 40 hours a week.', false),
    (v_q_id, 'C', 'Pause all feature development for 6 months to rewrite the entire recommendation engine from scratch.', false),
    (v_q_id, 'D', 'Work with the Engineering Manager to allocate 20-30% of upcoming sprint capacity explicitly to refactoring the legacy code.', true);

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
        'Netflix''s PRD Edge Cases',
        'A Netflix PM is writing a PRD for ''Offline Downloads on iOS''. Which of the following is the most critical edge case that MUST be defined in the PRD''s requirements?',
        'intermediate',
        'Netflix',
        'Identifying critical edge cases in a PRD',
        'B',
        'In a PRD, edge cases should address functional state changes, network interruptions, or complex user states. Option B addresses a critical DRM and licensing issue: what happens when a downloaded file expires or leaves the Netflix catalog? If unhandled, this leads to legal/licensing violations. Option A is a UI detail. Option C is standard error handling, not a complex edge case. Option D is an analytics detail.',
        ARRAY['prd', 'edge_cases', 'requirements']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'What color the progress bar should be when the download reaches 99%.', false),
    (v_q_id, 'B', 'How the app behaves if a user tries to play a downloaded movie after its regional licensing rights have expired.', true),
    (v_q_id, 'C', 'What error message displays if the user enters the wrong password during login.', false),
    (v_q_id, 'D', 'How many tracking events are sent to Amplitude during a successful download.', false);

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
        'Airbnb''s Regional Rollout',
        'Airbnb is launching a new ''Host Identity Verification'' flow. Due to varying data privacy laws (like GDPR in Europe), the PM plans a regional rollout. Which sequencing strategy minimizes risk?',
        'intermediate',
        'Airbnb',
        'Planning a regional rollout for compliance-heavy features',
        'B',
        'When dealing with compliance and risk, it is best to test the feature in a low-risk, lower-volume market first to catch bugs before rolling out to high-scrutiny, high-volume regions. Option B correctly targets a smaller market (New Zealand) before tackling the highly regulated European market. Option A starts with the highest risk. Option C ignores the regulatory constraint. Option D is an A/B test, not a rollout sequence.',
        ARRAY['rollout_strategy', 'compliance', 'risk_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch in the EU first, since the strict GDPR laws will provide the most rigorous stress test of the system.', false),
    (v_q_id, 'B', 'Launch in a smaller, English-speaking market like New Zealand first to validate the UX and catch bugs, then adapt for EU compliance.', true),
    (v_q_id, 'C', 'Launch globally simultaneously to ensure all hosts have a consistent experience regardless of local laws.', false),
    (v_q_id, 'D', 'Launch only to Superhosts globally, ignoring regional boundaries.', false);

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
        'Uber''s Delivery Metrics',
        'Uber''s VP of Product wants to know why the ''Reserve a Ride'' feature took 6 months from the initial idea to launch, even though engineering only took 4 weeks to code it. Which two metrics effectively explain this discrepancy?',
        'intermediate',
        'Uber',
        'Understanding Lead Time vs Cycle Time',
        'C',
        'Lead Time is the total time from a request being made (idea) to delivery. Cycle Time is the time the team actively spends working on it (coding to delivery). The discrepancy (6 months vs 4 weeks) is explained by a long Lead Time but short Cycle Time, indicating a bottleneck in the backlog, planning, or design phases. Option A metrics measure bugs. Option B metrics measure business impact. Option D metrics measure team happiness.',
        ARRAY['delivery_metrics', 'lead_time', 'cycle_time']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Crash Free Rate and Mean Time to Recovery (MTTR).', false),
    (v_q_id, 'B', 'Customer Acquisition Cost (CAC) and Lifetime Value (LTV).', false),
    (v_q_id, 'C', 'Lead Time (idea to launch) and Cycle Time (development start to launch).', true),
    (v_q_id, 'D', 'Employee Net Promoter Score (eNPS) and Sprint Velocity.', false);

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
        'Slack''s Tech Debt Strategy',
        'Slack is migrating its desktop app from an old Electron framework to a newer, more performant architecture. The PM must ensure feature delivery doesn''t grind to a halt. What is the most effective migration strategy?',
        'intermediate',
        'Slack',
        'Executing a large technical migration',
        'C',
        'Large architectural migrations are extremely risky if done as a ''big bang''. The Strangler Fig pattern (Option C) involves incrementally migrating parts of the application while keeping both running, allowing continuous delivery of value and mitigating risk. Option A stops all product momentum. Option B is a big bang rewrite, which notoriously fails or delays indefinitely. Option D is technical negligence.',
        ARRAY['technical_debt', 'migration', 'strangler_pattern']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A complete feature freeze for 9 months until the entire migration is complete.', false),
    (v_q_id, 'B', 'A ''Big Bang'' rewrite: build the new app entirely in secret, then switch all users over on a single day.', false),
    (v_q_id, 'C', 'The Strangler Pattern: incrementally migrate one module at a time (e.g., the sidebar, then the chat window) while both run simultaneously.', true),
    (v_q_id, 'D', 'Abandon the desktop app entirely and force all users to use the web browser version.', false);

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
        'Stripe''s Breaking API Change',
        'Stripe needs to deprecate an old API endpoint (`/v1/charges`) in favor of a new one (`/v1/payment_intents`). Millions of businesses use the old endpoint. How should the PM manage this delivery?',
        'intermediate',
        'Stripe',
        'Managing external API deprecation',
        'D',
        'Deprecating a public API requires careful change management. You cannot simply turn it off. You must version the API, provide clear migration documentation, monitor usage, and execute targeted outreach to stragglers before a heavily communicated sunset date. Option A breaks businesses. Option B assumes developers read logs. Option C means Stripe maintains legacy code forever, increasing tech debt indefinitely.',
        ARRAY['api_management', 'deprecation', 'b2b_delivery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Redirect all traffic from the old endpoint to the new one automatically via a 301 redirect.', false),
    (v_q_id, 'B', 'Turn off the old endpoint but return an error code explaining how to use the new one.', false),
    (v_q_id, 'C', 'Keep both endpoints running indefinitely; Stripe should never deprecate anything.', false),
    (v_q_id, 'D', 'Publish a migration guide, set a sunset date 18 months out, and send targeted emails to developers still calling the old endpoint.', true);

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
        'Figma''s Cross-Functional Delivery',
        'Figma is launching a ''Dev Mode'' pricing tier. Engineering is ready to deploy, but the PM discovers that Sales hasn''t been trained on the new pricing and the Legal team hasn''t updated the Terms of Service. What went wrong in the delivery process?',
        'intermediate',
        'Figma',
        'Identifying failures in cross-functional coordination',
        'B',
        'Feature delivery is not just shipping code; it requires Go-to-Market (GTM) readiness across the entire company. The PM failed to establish a cross-functional launch checklist (or a robust Definition of Done for the release), leaving Sales and Legal behind. Option A blames engineering for a PM/GTM failure. Option C blames Agile. Option D incorrectly assumes PMs shouldn''t talk to Sales.',
        ARRAY['cross_functional', 'go_to_market', 'launch_readiness']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Engineering deployed to production without getting the PM''s approval.', false),
    (v_q_id, 'B', 'The PM failed to execute a cross-functional GTM (Go-To-Market) readiness checklist.', true),
    (v_q_id, 'C', 'The Agile methodology is fundamentally incompatible with Legal and Sales workflows.', false),
    (v_q_id, 'D', 'The PM overstepped their boundaries; Sales and Legal are responsible for tracking engineering velocity on their own.', false);

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
        'DoorDash''s Bug Triaging',
        'Three days before launching a new ''Grocery Delivery'' tab, QA finds a bug: the tab icon is slightly off-center on iPhone SEs. Fixing it requires a minor UI rewrite that delays the launch by a week. How should the PM triage this?',
        'intermediate',
        'DoorDash',
        'Triaging cosmetic bugs before launch',
        'C',
        'Bug triaging before launch requires evaluating severity vs. launch impact. An off-center icon is a cosmetic (P3/P4) bug. Delaying a major strategic launch by a week for a cosmetic issue on an older device is a poor trade-off. It should be added to the backlog as a fast-follow. Option A delays value delivery unnecessarily. Option B overreacts. Option D shows a lack of quality standards.',
        ARRAY['bug_triage', 'launch_decision', 'prioritization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delay the launch by a week; no product should ever ship with known UI bugs.', false),
    (v_q_id, 'B', 'Revert the entire Grocery Delivery feature and launch it next quarter.', false),
    (v_q_id, 'C', 'Log it as a low-priority known issue, proceed with the launch, and fix it in the next sprint as a fast-follow.', true),
    (v_q_id, 'D', 'Ignore the bug entirely and permanently delete the QA ticket; iPhone SEs don''t matter.', false);

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
        'Robinhood''s Incident Response',
        'During the rollout of a new ''Options Trading'' dashboard, Robinhood''s latency spikes to 5 seconds, causing user outrage on Twitter. The PM is running the war room. What is the PM''s immediate priority?',
        'intermediate',
        'Robinhood',
        'PM responsibilities during a live incident',
        'A',
        'During a critical incident, the first priority is mitigation—stopping the bleeding. By turning off the feature flag, the PM instantly restores the app to its previous stable state. Only *after* mitigation do you investigate root causes or write post-mortems. Option B wastes time looking for blame while the app is broken. Option C focuses on PR instead of fixing the system. Option D is an administrative task for later.',
        ARRAY['incident_response', 'feature_flags', 'mitigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mitigation: Disable the feature flag to roll back the dashboard and restore normal latency.', true),
    (v_q_id, 'B', 'Root Cause Analysis: Demand engineers read through the code line-by-line to find the bug.', false),
    (v_q_id, 'C', 'Public Relations: Spend the next hour drafting an apology tweet.', false),
    (v_q_id, 'D', 'Post-Mortem: Start writing the incident report document to prevent future occurrences.', false);

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
        'Notion''s Shifting Requirements',
        'Notion is halfway through building ''Database Automations''. The CEO returns from a conference and demands the team pivot to ''AI Auto-generation'' immediately, abandoning the current sprint. What is the most structured way the PM should handle this?',
        'intermediate',
        'Notion',
        'Handling executive ''swoop and poop''',
        'D',
        'Executive ''swoop and poop'' requests are common. A strong PM doesn''t blindly say yes (causing chaos) or no (ignoring leadership). The PM must quantify the cost of the context switch: wasted work, delayed automations, and engineering morale impact, then present that tradeoff to the CEO for a strategic decision. Option A ruins team morale and execution. Option B is career suicide. Option C is passive-aggressive.',
        ARRAY['stakeholder_management', 'context_switching', 'agile']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately halt work, scrap the current sprint, and start writing AI requirements.', false),
    (v_q_id, 'B', 'Tell the CEO they are banned from interfering with the engineering team''s sprints.', false),
    (v_q_id, 'C', 'Agree with the CEO verbally, but secretly tell the engineers to keep building automations.', false),
    (v_q_id, 'D', 'Present the sunk cost and delay impact of aborting the current sprint, forcing a data-driven trade-off decision.', true);

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
        'Duolingo''s Feature Flag Debt',
        'Duolingo''s codebase currently has 400 active feature flags. Engineers complain that testing is impossible because they don''t know which combination of flags a user might have. What process failure does this represent?',
        'intermediate',
        'Duolingo',
        'Managing feature flag lifecycle',
        'C',
        'Feature flags are temporary technical debt. Once a feature is 100% rolled out and stable, the flag and the old code path must be removed. Accumulating 400 flags means the team is failing to clean up after themselves, leading to a combinatorial explosion of states that makes testing impossible. Option A blames the tool. Option B is factually incorrect. Option D misunderstands flag management.',
        ARRAY['feature_flags', 'technical_debt', 'delivery_process']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Using feature flags is an anti-pattern and should be banned entirely.', false),
    (v_q_id, 'B', 'Feature flags automatically expire after 30 days, so this is an infrastructure bug.', false),
    (v_q_id, 'C', 'The team lacks a disciplined lifecycle process to clean up and remove flags after a feature reaches 100% rollout.', true),
    (v_q_id, 'D', 'The QA team isn''t working hard enough to test all 2^400 possible states.', false);

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
        'GitHub''s Rollback vs Hotfix',
        'GitHub deploys a minor update to issue templates. 10 minutes later, users report they cannot save any new issues. The engineer identifies a typo in the code and says, ''I can write a hotfix in 20 minutes.'' What should the PM mandate?',
        'intermediate',
        'GitHub',
        'Choosing between rollback and hotfix during an outage',
        'A',
        'In a Sev-1 incident (users can''t use core functionality), the absolute fastest path to mitigation wins. Rolling back takes seconds and guarantees a return to a known stable state. Waiting 20 minutes for a hotfix (which might introduce new bugs since it''s rushed) leaves users broken for too long. Option A is the industry standard. Option B is risky. Option C is reckless. Option D is irrelevant during an outage.',
        ARRAY['incident_management', 'rollback', 'hotfix']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Rollback the deployment immediately to restore service, then have the engineer fix the typo in a non-rushed environment.', true),
    (v_q_id, 'B', 'Wait the 20 minutes for the hotfix to avoid the embarrassment of a rollback.', false),
    (v_q_id, 'C', 'Deploy the hotfix straight to production without code review to save time.', false),
    (v_q_id, 'D', 'Update the public status page and wait until tomorrow to fix it.', false);

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
        'Discord''s Deployment Decoupling',
        'Discord wants to launch ''Custom App Icons'' exactly at 9:00 AM PST on a Tuesday for a major marketing push. The engineering team usually deploys code on Thursdays. How can the PM satisfy both engineering safety and marketing''s timeline?',
        'intermediate',
        'Discord',
        'Decoupling deployment from release',
        'C',
        'This scenario highlights the difference between Deployment (pushing code to servers) and Release (exposing the feature to users). By deploying the code on Thursday hidden behind a feature flag, engineering maintains their safe, standard schedule. The PM can then simply toggle the flag on Tuesday at 9:00 AM. Option A forces engineering out of their rhythm. Option B guarantees a delayed launch. Option D is a hack.',
        ARRAY['deployment_vs_release', 'feature_flags', 'go_to_market']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force the engineering team to change their deployment schedule to Tuesday at 8:55 AM.', false),
    (v_q_id, 'B', 'Tell Marketing they must wait until Thursday afternoon to announce the feature.', false),
    (v_q_id, 'C', 'Deploy the code on Thursday behind a feature flag, and toggle the flag to 100% on Tuesday at 9:00 AM.', true),
    (v_q_id, 'D', 'Deploy a fake UI on Tuesday that says ''Loading...'' until Thursday.', false);

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
        'Amazon''s Critical Path Dependencies',
        'Amazon is building a new ''Drone Delivery'' dashboard. The frontend team (Team A) needs a routing API from Team B, who needs drone telemetry data from Team C. Team C is delayed by a month. What is the best strategy to keep Team A and B moving?',
        'advanced',
        'Amazon',
        'Managing multi-tier dependency chains on the critical path',
        'C',
        'In complex dependency chains, a delay at the bottom (Team C) bubbles all the way up. To decouple the teams, you must create static contracts (mocks). Team B mocks Team C''s data to build their API, and Team A uses Team B''s API (or mocks it) to build the frontend. This isolates the delay strictly to the integration phase. Option A halts the whole company. Option B creates chaos. Option D breaks architectural boundaries.',
        ARRAY['critical_path', 'dependency_chain', 'system_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Halt Teams A and B until Team C catches up, placing them on bug fixes.', false),
    (v_q_id, 'B', 'Have Team A skip Team B and connect directly to Team C''s incomplete database.', false),
    (v_q_id, 'C', 'Establish strict data schemas; have Team B mock Team C''s telemetry, and Team A mock Team B''s API, allowing independent development.', true),
    (v_q_id, 'D', 'Merge Teams A, B, and C into one massive 50-person squad to increase velocity.', false);

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
        'Zoom''s Strategic Pivot',
        'Zoom is 80% finished building a ''Virtual Reality Meeting'' feature. Apple suddenly announces a native VR integration that makes Zoom''s approach obsolete. What is the most strategic action for the Zoom PM?',
        'advanced',
        'Zoom',
        'Handling sunk cost and strategic pivots during delivery',
        'B',
        'This tests the PM''s ability to ignore the Sunk Cost Fallacy. If market conditions change drastically, completing an obsolete feature just because it''s 80% done is a waste of the remaining 20% effort and future maintenance costs. The PM must ruthlessly kill the project and reallocate resources. Option A falls for the sunk cost fallacy. Option C is legally dangerous. Option D ignores the external market reality.',
        ARRAY['sunk_cost_fallacy', 'strategic_pivot', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Finish the remaining 20% and launch it anyway to boost team morale.', false),
    (v_q_id, 'B', 'Halt development immediately, accept the sunk cost, and pivot the team to integrate with Apple''s new native framework.', true),
    (v_q_id, 'C', 'Sue Apple for anti-competitive behavior and freeze all engineering work.', false),
    (v_q_id, 'D', 'Double the team size to finish the feature faster and beat Apple to market.', false);

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
        'Spotify''s Feature Collision',
        'Spotify launches a ''Lyrics'' feature (Team A) and a ''Behind the Lyrics'' feature (Team B) independently. When both are enabled, the UI breaks, overlapping text and crashing the app. What delivery process failed?',
        'advanced',
        'Spotify',
        'Preventing feature collision in scaled agile',
        'C',
        'In scaled agile environments, autonomous teams can easily build features that collide in the UI or backend. The failure here is a lack of integration testing and a coordinated release train (or feature flags managed holistically) to ensure compatibility. Option A assumes a monolithic codebase. Option B restricts scaling. Option D is an engineering pattern, not a cross-team coordination process.',
        ARRAY['feature_collision', 'scaled_agile', 'integration_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The codebase was not monolithic enough.', false),
    (v_q_id, 'B', 'Spotify failed to have a single PM approve every single line of code.', false),
    (v_q_id, 'C', 'A lack of cross-squad integration testing and synchronized release management.', true),
    (v_q_id, 'D', 'The engineering teams failed to use Object-Oriented Programming principles.', false);

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
        'Netflix''s Compliance Delivery',
        'Netflix must build a ''Content Takedown'' portal to comply with a new EU directive. The legal deadline is 3 months away, and failure means a €50M fine. Engineering estimates 4 months. How should the PM scope this?',
        'advanced',
        'Netflix',
        'Scoping compliance features under strict deadlines',
        'D',
        'When facing a hard regulatory deadline with severe penalties, compliance is the only thing that matters. User experience and automation must be sacrificed for speed. A ''Wizard of Oz'' MVP—where users see a frontend form, but the backend is just an email to humans who do it manually—meets the legal requirement on time. Options A and B risk massive fines. Option C is wishful thinking.',
        ARRAY['compliance', 'wizard_of_oz_mvp', 'scoping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell Legal that agile teams don''t work with fixed deadlines, so it will be done when it''s done.', false),
    (v_q_id, 'B', 'Build the full automated backend first to ensure scalability, even if it misses the deadline.', false),
    (v_q_id, 'C', 'Require engineers to work weekends to squeeze 4 months of work into 3 months.', false),
    (v_q_id, 'D', 'Build a simple frontend form that emails Legal to process the takedowns manually (Wizard of Oz MVP) to hit the deadline, automating it later.', true);

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
        'Airbnb''s Multi-platform Sync',
        'Airbnb is launching ''Split Stays''. The iOS app is approved by Apple, the Web version is deployed, but the Android build is rejected by Google Play for a policy violation. Marketing is ready to press send on a global email. What should the PM do?',
        'advanced',
        'Airbnb',
        'Managing multi-platform launch synchronization',
        'B',
        'Launch synchronization across iOS, Android, and Web is notoriously difficult due to app store review unpredictability. The standard practice is to deploy code across all platforms behind a feature flag, get all approvals, and then toggle the flag server-side. Since Android is rejected, the PM must delay marketing and keep the flag off to ensure a consistent cross-platform user experience. Option A creates a fragmented, confusing user experience. Options C and D are outside the PM''s control.',
        ARRAY['multi_platform', 'app_store_review', 'launch_synchronization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch on iOS and Web immediately, and tell Android users in the email that their version is ''coming soon''.', false),
    (v_q_id, 'B', 'Keep the feature flag turned off across all platforms, delay the marketing email, and focus on fixing the Android policy violation.', true),
    (v_q_id, 'C', 'Call Google Play support and demand an immediate override.', false),
    (v_q_id, 'D', 'Send the marketing email, but only to iOS and Web users based on their device history.', false);

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
        'Uber''s Network Effects Rollout',
        'Uber is launching a new ''Driver Bidding'' system. If they A/B test it randomly across users in New York, the system will break because drivers in the test group will compete with drivers in the control group for the same riders. How should this be tested?',
        'advanced',
        'Uber',
        'Testing features in two-sided marketplaces with network effects',
        'A',
        'Standard A/B testing assumes independence between users (SUTVA). In a marketplace like Uber, treating users in the same city differently causes interference (network effects). To test this, you must isolate the groups geographically. A geofenced or city-level test (e.g., test in Boston, control in Chicago) isolates the network effects. Options B, C, and D fail to address the marketplace interference.',
        ARRAY['network_effects', 'marketplace_testing', 'geofencing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conduct a geofenced market-level test (e.g., launch to 100% of users in Boston, keep Chicago as a control).', true),
    (v_q_id, 'B', 'Run a standard 50/50 A/B test but only run it for 24 hours to minimize damage.', false),
    (v_q_id, 'C', 'Only test it on top-tier ''Uber Black'' drivers to limit the pool.', false),
    (v_q_id, 'D', 'Launch it globally immediately, as A/B testing is impossible for marketplaces.', false);

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
        'Stripe''s Shadow Testing',
        'Stripe has rewritten its core transaction routing engine in a new programming language to improve latency. The new code is deployed to production but is not processing real money. Instead, production traffic is duplicated and sent to the new engine just to compare outputs. What is this technique called?',
        'advanced',
        'Stripe',
        'Understanding shadow testing for core infrastructure',
        'B',
        'Shadow Testing (or Dark Launching) involves duplicating live production traffic and routing it to a new backend system without letting the new system affect the actual user response or database state. This allows teams to verify performance and correctness under real load without any risk to the user. Option A is testing with real users. Option C tests capacity but not correctness with real data. Option D is a phased rollout.',
        ARRAY['shadow_testing', 'dark_launch', 'infrastructure_delivery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Canary Release', false),
    (v_q_id, 'B', 'Shadow Testing (Dark Launch)', true),
    (v_q_id, 'C', 'Load Testing', false),
    (v_q_id, 'D', 'Blue-Green Deployment', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Feature Delivery';

END $$;
