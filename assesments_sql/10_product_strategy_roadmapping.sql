-- ============================================
-- ASSESSMENT: Roadmapping
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
    WHERE slug = 'roadmapping';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug roadmapping not found. Run the seed data first.';
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
        'Spotify''s Podcasting Engagement Outcome',
        E'A Spotify Product Manager is tasked with transitioning the podcasting team from a feature-driven roadmap (e.g., ''Build podcast playlists,'' ''Launch video podcasts'') to an outcome-driven roadmap. The main objective is to increase podcast listener retention. The PM needs to choose the best initial outcome-focused goal to put on the roadmap.',
        'foundational',
        'Spotify',
        'Transitioning from feature-driven to outcome-driven roadmaps',
        'B',
        E'B is the correct answer because it defines a clear, measurable outcome (4-week retention rate from 25% to 35%) rather than specifying a feature to build. Option A and C are feature-driven goals that specify what to build (a recommendation algorithm, sharing cards) rather than the outcome. Option D targets the wrong user segment (music-only subscribers) and focuses on cross-selling rather than the core retention of podcast listeners. Outcome-driven roadmaps focus on solving customer problems and achieving business results, leaving the specific solutions open to discovery.',
        ARRAY['roadmapping', 'outcome_driven', 'feature_driven']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch a podcast recommendation algorithm by Q3 to increase user satisfaction.', false),
    (v_q_id, 'B', 'Increase the 4-week retention rate of new podcast listeners from 25% to 35%.', true),
    (v_q_id, 'C', 'Build and ship the new podcast sharing cards for Instagram Stories to drive viral growth.', false),
    (v_q_id, 'D', 'Reduce the churn rate of premium music-only subscribers by introducing podcast content in their feeds.', false);

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
        'Slack''s Executive Roadmap Presentation',
        E'The Slack Platform PM is preparing to present the platform ecosystem strategy to the executive leadership team for the upcoming fiscal year. The leadership team wants to understand strategic direction, major focus areas, and resource allocation across ecosystems, but does not need exact sprint-level dates. The PM needs to choose the most appropriate roadmap format for this audience.',
        'foundational',
        'Slack',
        'Choosing the right roadmap format for executive communication',
        'C',
        E'C is the correct answer because a Now-Next-Later roadmap organized around customer themes is ideal for executive audiences. It communicates strategic priorities, focus areas, and the ''why'' without committing to precise delivery dates that are likely to change. Option A (Gantt chart) is too granular and creates false precision about dates, which leads to misaligned expectations. Options B and D are execution-level tools (Jira backlog and Kanban board) that are appropriate for engineering teams but do not communicate high-level product strategy or outcomes to executives.',
        ARRAY['roadmapping', 'now_next_later', 'gantt_roadmap']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A detailed Gantt chart showing bi-weekly feature release schedules and developer resources allocated to each integration.', false),
    (v_q_id, 'B', 'A Jira backlog list ordered by stack rank, showing open tickets and bug counts for the Slack API.', false),
    (v_q_id, 'C', 'A Now-Next-Later roadmap organized around customer themes (e.g., Secure Collaboration, Developer Velocity, Automation).', true),
    (v_q_id, 'D', 'A Kanban board showing active developer tasks in ''''In Progress'''' and ''''Testing'''' columns.', false);

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
        'Shopify''s Checkout Upgrade Timeline',
        E'A Shopify PM is launching a significant upgrade to the checkout flow that affects third-party developer APIs. Because of the risk of breaking live store checkouts, there is high technical uncertainty about the exact launch date. The Partner Relations team is demanding a timeline so they can prepare merchants. How should the PM communicate the timeline?',
        'foundational',
        'Shopify',
        'Managing and communicating roadmap uncertainty to stakeholders',
        'B',
        E'B is the correct answer because under high technical uncertainty, communicating timelines in broad horizons (e.g., quarters or seasons) along with the conditioning factors (sandbox stability) is the best practice. This manages expectations and prevents partners from making premature business commitments, while still providing enough context for planning. Option A and D commit to false precision, which leads to loss of trust if dates slip due to unforeseen technical challenges. Option C represents a complete lack of transparency, which damages partner relations and prevents them from doing any planning.',
        ARRAY['roadmapping', 'stakeholder_timeline', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Commit to a specific release date (e.g., ''''September 15th'''') to give partners a concrete deadline, and plan to work overtime if the team falls behind.', false),
    (v_q_id, 'B', 'Communicate the launch as a broad horizon (e.g., ''''Targeting late Q3/early Q4, contingent on sandbox stability metrics'''') and share a milestones checklist.', true),
    (v_q_id, 'C', 'Refuse to share any dates or timeframes until the code is fully merged and tested, keeping the project internal.', false),
    (v_q_id, 'D', 'Provide a detailed Gantt chart with weekly progress milestones, assuring partners that all dates are firm.', false);

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
        'Airbnb''s Guest Booking Conversion vs Trust',
        E'Airbnb''s Search and Discovery PM is under pressure to hit a short-term Q2 conversion target. A designer suggests removing the guest review rating summary from search result cards, which internal experiments show increases immediate checkout conversion by 3.5% (as guests click and explore more listings). However, long-term brand survey data shows that transparent reviews are the top driver of user trust. What is the most strategic roadmapping decision?',
        'foundational',
        'Airbnb',
        'Balancing short-term optimization/debt with long-term strategic initiatives',
        'B',
        E'B is the correct answer. Product managers must protect the long-term strategic viability and customer trust of the product, even at the expense of short-term optimization metrics. Removing reviews to inflate search-to-checkout conversion is a classic ''local maxima'' optimization that harms long-term customer retention and brand equity. Option A prioritizes short-term numbers at the expense of the core value proposition. Option C introduces cherry-picking bias, which degrades transparency. Option D is an unstable strategy that confuses users and damages consistency.',
        ARRAY['roadmapping', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the short-term win by scheduling the removal of reviews on the roadmap, since meeting Q2 targets is the immediate priority.', false),
    (v_q_id, 'B', 'Reject the change and keep the review summary on search cards, prioritizing the long-term value of trust on the roadmap.', true),
    (v_q_id, 'C', 'Place a compromise feature on the roadmap: show reviews only for listings with a rating above 4.5 stars.', false),
    (v_q_id, 'D', 'Add both ideas to the roadmap: remove the reviews for Q2, and plan a feature to re-introduce them in Q4 once targets are met.', false);

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
        'Zoom''s Security Priority Pivot',
        E'In early 2020, Zoom experienced a massive surge in usage, which exposed critical security and privacy issues (''Zoombombing''). The PM team had a roadmap filled with highly anticipated features like custom virtual backgrounds and interactive whiteboard tools. What is the most appropriate roadmap adaptation strategy?',
        'foundational',
        'Zoom',
        'Handling changing requirements and adapting the roadmap dynamically',
        'B',
        E'B is the correct answer. When a product faces an existential crisis (such as security vulnerabilities that threaten user safety and company reputation), PMs must adapt the roadmap dynamically. Declaring a feature freeze to focus resources on resolving the crisis is a classic case study of Zoom''s actual response in 2020. Option A and C try to balance or distract, which leaves the existential threat unaddressed. Option D uses a flawed application of prioritization frameworks (treating security as zero-reach), which fails to recognize that security is a foundational baseline requirement for any software product.',
        ARRAY['roadmapping', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Continue executing the existing roadmap to deliver the whiteboard tools, while assigning a small sub-team to patch security bugs as they arise.', false),
    (v_q_id, 'B', 'Pause the development of all new features, declare a 90-day feature freeze, and focus 100% of engineering resources on privacy and security upgrades.', true),
    (v_q_id, 'C', 'Release the virtual backgrounds immediately to distract users from the security issues, while slowly updating the security backend.', false),
    (v_q_id, 'D', 'Reprioritize the backlog by applying a RICE score where the reach of security features is set to zero since they do not drive engagement.', false);

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
        'Duolingo''s Gamification Alignment',
        E'A new Duolingo PM wants to align the engineering, design, and content creation teams around a new roadmap initiative focused on ''Streak Motivation.'' Each team has a different view of what is most important: engineering wants to fix infrastructure debt, design wants a UI overhaul, and content wants new languages. How should the PM establish alignment?',
        'foundational',
        'Duolingo',
        'Roadmap prioritization and alignment processes',
        'B',
        E'B is the correct answer. Establishing a shared, outcome-oriented goal (like D30 Retention) provides an objective framework for evaluating competing initiatives. Facilitating a collaborative workshop ensures all functions feel heard and understand how their work contributes to the strategic outcome. Option A leads to fragmented execution and lack of focus. Option C (''command and control'') damages team morale and misses out on cross-functional expertise. Option D is a dogmatic choice that may ignore critical user-experience or content needs.',
        ARRAY['roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allow each team to work on their own priority independently and merge the results at the end of the quarter.', false),
    (v_q_id, 'B', 'Facilitate a cross-functional workshop to map each team''''s proposals back to a shared business outcome (e.g., D30 Retention) and prioritize collectively.', true),
    (v_q_id, 'C', 'Make the decision unilaterally as the product manager and assign tasks to each team without explanation.', false),
    (v_q_id, 'D', 'Choose the engineering priority because technical infrastructure is always the foundation of any product.', false);

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
        'Stripe''s API Versioning Dependency',
        E'Stripe''s Core API team is planning to deprecate an older version of their Payment Intents API. The Developer Dashboard team and the Billing team both rely on this API. If the Core team proceeds without coordination, the dashboards of thousands of merchants will show broken data. What is the best way to handle this dependency on the roadmap?',
        'foundational',
        'Stripe',
        'Multi-team and platform dependency management on roadmaps',
        'C',
        E'C is the correct answer. Managing dependencies requires explicit mapping of blocking relationships and shared milestones on the roadmaps of all affected teams. This prevents silent failures and ensures resources are aligned. Option A and B lead to platform instability and broken customer experiences. Option D is an extreme organizational change that is impractical and does not solve the underlying technical dependency.',
        ARRAY['roadmapping', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Core API team deprecates the API as scheduled and expects the other teams to reactively fix their services.', false),
    (v_q_id, 'B', 'Core API team adds the deprecation to their roadmap, but does not communicate it, assuming other teams monitor API logs.', false),
    (v_q_id, 'C', 'Establish a shared milestone on the roadmaps of all three teams, with the Core API team''''s deprecation blocked until the Dashboard and Billing teams ship their migration updates.', true),
    (v_q_id, 'D', 'Merge the three teams into a single monolithic team to eliminate all future dependencies.', false);

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
        'Uber''s Driver Destination Filter Exclusion',
        E'Uber''s Driver Experience PM receives a request from the regional Operations team to add a ''destination filter'' feature that allows drivers to choose their direction unlimited times per day. The PM knows this would severely damage rider pickup times (ETA) in suburban areas and decides to exclude it from the roadmap. How should the PM communicate this exclusion to the Ops team?',
        'foundational',
        'Uber',
        'Communicating the ''Why'' behind roadmap exclusions',
        'B',
        E'B is the correct answer. Communicating roadmap exclusions requires sharing the data-driven ''why'' behind the decision, focusing on the trade-offs and impact on key company metrics (marketplace health and rider ETAs). This builds credibility and trust with stakeholders. Option A is dishonest and will backfire if engineers tell Ops it IS possible. Option C (false promise) is a common PM trap that damages long-term trust. Option D is unprofessional and hurts cross-functional collaboration.',
        ARRAY['roadmapping', 'roadmap_exclusions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Inform the Ops team that the feature is technically impossible to build within the current architecture.', false),
    (v_q_id, 'B', 'Share the analytical model showing the trade-off: unlimited destination filters increase driver flexibility but cause rider ETAs to spike by 40% in suburban areas, harming overall marketplace health.', true),
    (v_q_id, 'C', 'Tell the Ops team that the feature is on the roadmap for next year, to avoid conflict, while planning to drop it later.', false),
    (v_q_id, 'D', 'Ignore the request and stop responding to emails from the regional Ops team.', false);

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
        'Figma''s Editor Canvas Latency',
        E'Figma''s core editor canvas is experiencing high latency (lag) when rendering large design systems with over 10,000 layers. The PM has a strategic goal to acquire more Enterprise customers, who typically design at this scale. However, the sales team is demanding new interactive prototyping features to win a major deal. What is the best way to balance these items on the roadmap?',
        'foundational',
        'Figma',
        'Balancing tech debt/performance with strategic customer-facing features',
        'B',
        E'B is the correct answer. Balancing technical debt with strategic features is best managed by establishing dedicated capacity allocations (e.g., 70/30) on the roadmap. This ensures that the product''s foundation is maintained while still delivering business value. Option A ignores performance debt, which will eventually make the product unusable for the very Enterprise customers they wish to acquire. Option C is a high-risk strategy that halts all market competitiveness for half a year. Option D is unrealistic and leads to team burnout.',
        ARRAY['roadmapping', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Dedicate the entire quarter''''s roadmap to interactive prototyping to close the sales deal, and defer the performance issues indefinitely.', false),
    (v_q_id, 'B', 'Allocate a fixed capacity of the roadmap (e.g., 70% features, 30% performance debt) to incrementally resolve canvas latency while delivering key features.', true),
    (v_q_id, 'C', 'Stop all feature development for two quarters to completely rewrite the rendering engine from scratch.', false),
    (v_q_id, 'D', 'Tell the engineering team to work faster so they can deliver both the performance upgrades and the prototyping features in the same timeframe.', false);

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
        'Netflix''s Mobile-First Theme',
        E'Netflix''s Growth PM is planning the upcoming roadmap for the Latin American market, where mobile network bandwidth is highly variable. Instead of writing a list of features like ''Offline downloads improvement'' or ''Low-res video mode,'' the PM wants to use a theme-based roadmap. How should the PM frame this theme?',
        'foundational',
        'Netflix',
        'Using theme-based roadmap formats',
        'C',
        E'C is the correct answer. A theme-based roadmap frames priorities around customer problems or user needs (e.g., ''Seamless Streaming on Low-Bandwidth Networks'') rather than technical solutions or geographic buckets. This keeps the team focused on the customer outcome and allows them to discover the best feature ideas to address that theme. Option A is too broad and geographic. Option B is technology-centered rather than customer-centered. Option D is a feature-focused description.',
        ARRAY['roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Theme: Latin American Expansion Features.', false),
    (v_q_id, 'B', 'Theme: Mobile Video Optimization Engine.', false),
    (v_q_id, 'C', 'Theme: Seamless Streaming on Low-Bandwidth Networks.', true),
    (v_q_id, 'D', 'Theme: Offline Downloads & Quality Controls.', false);

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
        'DoorDash''s Merchant App Re-platform',
        E'A DoorDash PM is leading the re-platforming of the Merchant Portal app. The new portal requires a new API endpoint from the Core Order Processing team to show real-time order tracking. However, the Core Order team''s roadmap is fully booked with high-priority scaling tasks for the upcoming holiday season. What is the most effective way to resolve this dependency?',
        'intermediate',
        'DoorDash',
        'Cross-team dependency management and resource constraints',
        'A',
        E'A is the correct answer. When facing a cross-team dependency where the blocking team has no capacity, a common and effective PM strategy is ''inner-sourcing'' — having the requesting team''s engineers write the necessary code in the host repository under the guidance and review of the host team. This unblocks the roadmap without disrupting the host team''s strategic priorities. Option B is a brute-force escalation that ignores critical scaling risks. Option C delay is costly and unnecessary. Option D introduces severe technical debt and fragility.',
        ARRAY['roadmapping', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask the Merchant Portal team''''s engineers to write the endpoint themselves in the Core team''''s codebase, following their standards, and coordinate a code review.', true),
    (v_q_id, 'B', 'Escalate to the VP of Product to force the Core Order team to drop their scaling tasks and prioritize the API endpoint.', false),
    (v_q_id, 'C', 'Delay the Merchant Portal launch by three months until the Core Order team''''s schedule opens up.', false),
    (v_q_id, 'D', 'Build a temporary, unstable web-scraper to pull order data from the database, bypassing the Core Order team entirely.', false);

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
        'GitHub''s Copilot Enterprise Override',
        E'The PM for GitHub Actions has a Q3 roadmap focused on improving runner spin-up times, which is the #1 complaint from developer surveys. During a planning meeting, the CEO requests that the team pivot immediately to build a ''Copilot-driven pipeline generator'' to match a competitor''s recent announcement. How should the PM handle this executive request?',
        'intermediate',
        'GitHub',
        'Handling executive roadmap requests and corporate overrides',
        'C',
        E'C is the correct answer. Dealing with executive roadmap requests requires a collaborative approach: sizing the request, showing the trade-offs on the existing roadmap, and offering creative alternatives (like a phased MVP) to address the executive''s strategic concern while protecting core product health. Option A is career-limiting and ignores the strategic context the CEO might have. Option B is reactive and fails to protect the team or the customer experience. Option D is a recipe for burnout and low-quality code.',
        ARRAY['roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Refuse the CEO''''s request, citing the developer survey data as the absolute source of truth for the product.', false),
    (v_q_id, 'B', 'Immediately pivot the entire team to the Copilot feature, cancelling the runner spin-up time project without further discussion.', false),
    (v_q_id, 'C', 'Work with engineering to size the Copilot feature, present a trade-off analysis showing how much runner speed optimization will be delayed, and propose a phased approach (e.g., a lightweight Copilot MVP alongside core speed fixes).', true),
    (v_q_id, 'D', 'Agree to do both projects in Q3, knowing the team will have to work 80-hour weeks to deliver them.', false);

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
        'Notion''s Offline Mode Request',
        E'Notion''s Enterprise PM is in sales discussions with a major financial services prospect that is willing to sign a $1M ARR contract if Notion guarantees the delivery of ''Full Offline Mode'' on the roadmap within six months. The engineering team estimates that true offline mode requires a 12-month complete rewrite of the sync architecture. What should the PM do?',
        'intermediate',
        'Notion',
        'Handling sales-led enterprise roadmap requests',
        'C',
        E'C is the correct answer. PMs must resist the temptation to commit to unrealistic timelines for single-customer deals, as this creates massive technical debt and roadmapping chaos. Offering an alternative MVP that addresses the immediate customer pain point (saving drafts offline) within the realistic capacity of the team, while planning the long-term solution, is the most sustainable approach. Option A creates a high risk of project failure and breach of contract. Option B is too dismissive of a major revenue opportunity. Option D is dishonest and leads to internal misalignment.',
        ARRAY['roadmapping', 'roadmap_exclusions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the deal and put the 6-month offline mode on the roadmap, planning to figure out the technical constraints later.', false),
    (v_q_id, 'B', 'Reject the sales deal entirely and refuse to discuss offline capabilities with the client.', false),
    (v_q_id, 'C', 'Decline the 6-month commitment, explain the architectural complexity, and offer a roadmap commitment for a ''''Local Draft Mode'''' MVP in 6 months, while scheduling the full offline architecture for the following year.', true),
    (v_q_id, 'D', 'Put the feature on a private roadmap shown only to this customer, while keeping it off the main engineering roadmap.', false);

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
        'Robinhood''s Tax Reporting Mandate',
        E'Robinhood''s PM for Crypto is executing a roadmap to launch advanced yield-earning features in Q4. In August, the IRS issues a new regulatory mandate requiring crypto platforms to implement strict cost-basis tax reporting by November 1st, or face severe fines. The tax feature will require 80% of the team''s capacity. How should the PM adapt the roadmap?',
        'intermediate',
        'Robinhood',
        'Adapting the roadmap dynamically to regulatory requirements',
        'B',
        E'B is the correct answer. Regulatory and compliance mandates are non-negotiable constraints that must override commercial features on a roadmap. The PM must dynamically reprioritize the roadmap and proactively manage stakeholder expectations regarding commercial impacts. Option A risks existential regulatory penalties. Option C introduces severe security and privacy risks with customer financial data. Option D is unsustainable and leads to high defect rates.',
        ARRAY['roadmapping', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore the IRS mandate until Q1 and launch the yield features as planned to hit the Q4 revenue target.', false),
    (v_q_id, 'B', 'Deprioritize the yield-earning features, move the IRS cost-basis tax reporting to the top of the roadmap, and adjust the Q4 revenue expectations with stakeholders.', true),
    (v_q_id, 'C', 'Outsource the tax reporting tool to a third-party agency without any security review to keep the internal team on the yield features.', false),
    (v_q_id, 'D', 'Ask the engineering team to work double shifts for three months to deliver both the tax compliance and yield features.', false);

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
        'Atlassian''s Cloud Security Roadmap',
        E'Atlassian''s PM for Jira Cloud is developing a new ''bring your own key'' (BYOK) encryption feature that enterprise customers require before migrating from on-premise servers. The feature is highly complex, with multiple external dependencies. The sales team is demanding a specific launch date so they can close migrations. How should the PM present the roadmap to the sales team?',
        'intermediate',
        'Atlassian',
        'Presenting timelines and managing uncertainty to stakeholders',
        'A',
        E'A is the correct answer. Using a Now-Next-Later format allows the PM to communicate sequence and priority without committing to hard dates. Accompanying this with a transparent explanation of the milestones and dependencies helps the sales team explain the progress to customers, maintaining credibility. Option B (secret buffers) leads to internal distrust and misaligned marketing campaigns. Option C uses deceptive design (fine print) which fails to prevent sales representatives from promising the date to clients. Option D isolates the product team and hurts sales enablement.',
        ARRAY['roadmapping', 'stakeholder_timeline', 'now_next_later']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Share a Now-Next-Later roadmap where BYOK is placed in the ''''Next'''' column, and explain the key technical milestones required to move it to ''''Now.''''', true),
    (v_q_id, 'B', 'Give sales a Gantt chart showing the exact week of release, but secretly add a 2-month buffer to the internal engineering timeline.', false),
    (v_q_id, 'C', 'Share a timeline roadmap with exact monthly dates but add a disclaimer at the bottom in tiny font stating that ''''dates are subject to change.''''', false),
    (v_q_id, 'D', 'Refuse to show the roadmap to the sales team to prevent them from sharing it with customers.', false);

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
        'Spotify''s Car Mode Roadmap Metrics',
        E'Spotify''s Mobile PM is planning a roadmap for ''Spotify in the Car.'' The team has identified a key problem: users find it difficult and unsafe to search for music while driving. The junior PM proposes a roadmap focused on shipping ''Voice Search for Car Mode'' as the primary feature. How should the PM reframe this roadmap to be outcome-driven?',
        'intermediate',
        'Spotify',
        'Outcome-driven vs Feature-driven roadmaps',
        'B',
        E'B is the correct answer because it directly measures the safety outcome (eyes-off-the-screen time) which aligns with the core customer problem, without prescribing the solution. The solution could be voice search, bigger buttons, auto-playlists, or steering wheel integration. Option A is still a feature-delivery goal, just with a quality metric. Option C measures a vanity metric (number of voice queries) that doesn''t guarantee a safer or better driving experience. Option D commits the team to a massive hardware project without validating if software changes can solve the problem.',
        ARRAY['roadmapping', 'outcome_driven', 'feature_driven']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the goal as ''''Ship Voice Search for Car Mode by Q3 with 95% voice recognition accuracy.''''', false),
    (v_q_id, 'B', 'Set the goal as ''''Reduce the average eyes-off-the-screen time during music selection in Car Mode from 8 seconds to less than 2 seconds.''''', true),
    (v_q_id, 'C', 'Set the goal as ''''Increase the total number of voice queries made in the app by 50% year-over-year.''''', false),
    (v_q_id, 'D', 'Build a dedicated hardware accessory for cars that simplifies playlist navigation.', false);

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
        'Netflix''s Ad-Supported Tier Rollout',
        E'Netflix''s Growth PM is planning the roadmap for the new Ad-Supported subscription tier. A data analyst points out that adding more intrusive pre-roll ads will increase short-term ad revenue by $15M in the first quarter. However, long-term user retention modeling indicates that intrusive ads will double the churn rate of new subscribers within six months. What is the most strategic roadmapping action?',
        'intermediate',
        'Netflix',
        'Balancing tactical optimization with long-term strategic initiatives',
        'B',
        E'B is the correct answer. Strategic roadmapping requires balancing short-term monetization with long-term customer lifetime value (LTV). Setting guardrail metrics (like keeping retention drop under 1%) on the roadmap ensures that feature optimizations do not compromise the long-term health of the business. Option A is a short-sighted approach that creates ''churn debt'' which is harder and more expensive to fix later. Option C is an over-cautious response that misses the market window. Option D is an expensive, non-scalable operational fix that doesn''t address the core product issue.',
        ARRAY['roadmapping', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Include the intrusive pre-roll ads on the Q1 roadmap to maximize immediate revenue, and plan to fix the churn issue in Q3.', false),
    (v_q_id, 'B', 'Design a roadmap that prioritizes non-intrusive ad formats (e.g., pause-screen ads) and sets a guardrail metric that long-term subscriber retention must not drop by more than 1%.', true),
    (v_q_id, 'C', 'Defer the launch of the Ad-Supported tier entirely until the team can guarantee zero churn.', false),
    (v_q_id, 'D', 'Implement the intrusive ads but offer free subscription months to users who complain to customer support.', false);

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
        'Uber''s Autonomous Delivery Roadmap',
        E'Uber''s Delivery PM is creating a 3-year strategic roadmap for autonomous robot delivery in urban areas. The technology is in its infancy, local regulations are changing rapidly, and hardware costs are high. How should the PM structure this roadmap to communicate the strategic vision without committing to unfeasible timelines?',
        'intermediate',
        'Uber',
        'Managing long-term strategic initiatives under high uncertainty',
        'B',
        E'B is the correct answer. For highly speculative, long-term initiatives with high uncertainty (like autonomous systems), a horizon-based roadmap (Horizon 1/2/3) is the best framework. It organizes the roadmap around phases of validation and risk reduction (feasibility, economics, scale) rather than calendar dates. Option A assumes a predictable timeline that is impossible to guarantee. Option C fails to communicate strategic direction to stakeholders. Option D is deceptive and creates severe misalignment.',
        ARRAY['roadmapping', 'stakeholder_timeline']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use a Gantt-style timeline showing the exact cities where robots will launch each quarter for the next 3 years.', false),
    (v_q_id, 'B', 'Create a roadmap structured around phased learning horizons: Horizon 1 (Technical feasibility in controlled zone), Horizon 2 (Unit economic optimization in select markets), Horizon 3 (Scalable autonomous network).', true),
    (v_q_id, 'C', 'Avoid creating a roadmap altogether, and instead use a simple spreadsheet containing a list of engineering tasks.', false),
    (v_q_id, 'D', 'Publish a roadmap that commits to a nationwide launch in Year 2 to impress investors, while keeping the actual delays confidential.', false);

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
        'Airbnb''s Co-Host Network Alignment',
        E'Airbnb is launching a ''Co-Host Network'' that allows property owners to find local property managers. The product team''s roadmap includes features like ''Co-Host Matchmaking Algorithm'' and ''In-App Contract Signing.'' However, the operational support teams are not prepared to handle disputes or verify local business licenses. How should the PM align the roadmap?',
        'intermediate',
        'Airbnb',
        'Cross-functional roadmap alignment and operational readiness',
        'B',
        E'B is the correct answer. A successful product roadmap is not just an engineering schedule; it must be a holistic, cross-functional plan that includes operational readiness milestones, marketing campaigns, and legal reviews. This is especially true for marketplaces like Airbnb where physical-world operations are critical to the user experience. Option A leads to a broken customer experience and support backlog. Option C is an over-compromise that weakens the product value. Option D ignores the product team''s core competency in managing software development.',
        ARRAY['roadmapping', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Focus solely on launching the software features and let the operations team handle the issues reactively as they arise.', false),
    (v_q_id, 'B', 'Add a cross-functional track to the roadmap that aligns product release milestones with operational readiness (e.g., support training, verification workflows, legal frameworks).', true),
    (v_q_id, 'C', 'Remove the matchmaking algorithm from the roadmap and build a simple directory to minimize operational complexity.', false),
    (v_q_id, 'D', 'Hand over the entire project roadmap to the Operations team and have them manage the engineering backlog.', false);

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
        'Figma''s Prototyping Performance vs Features',
        E'Figma''s PM receives a flood of feature requests from users demanding complex conditional logic in interactive prototyping. At the same time, telemetry data shows that the loading time of basic prototype previews has increased by 40% over the last two quarters. The team only has capacity for one major initiative. How should the PM decide?',
        'intermediate',
        'Figma',
        'Balancing feature requests against core product performance and stability',
        'B',
        E'B is the correct answer. Core performance (like load times) is a hygiene factor; if a product''s baseline performance degrades, new features will not save the user experience. PMs must prioritize maintaining core quality and performance over new feature requests. Option A ignores the degradation of the core experience, leading to user frustration. Option C leads to two low-quality results that fail to solve either problem. Option D shifts the blame to users and is not a sustainable product strategy.',
        ARRAY['roadmapping', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build the conditional logic features, as they represent explicit user demands and will win marketing headlines.', false),
    (v_q_id, 'B', 'Prioritize the performance optimization of prototype load times, and place the conditional logic features on the ''''Later'''' roadmap.', true),
    (v_q_id, 'C', 'Split the engineering team in half, forcing them to build a low-quality version of the conditional logic while doing basic performance patches.', false),
    (v_q_id, 'D', 'Tell the marketing team to run a campaign educating users on how to build lighter files so Figma doesn''''t have to optimize performance.', false);

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
        'Slack''s Custom On-Premise Request',
        E'A major global bank offers to buy 50,000 Slack Enterprise licenses if Slack agrees to build a custom, on-premise hosting option that complies with their internal security policy. This request is completely contrary to Slack''s multi-tenant cloud architecture strategy. How should the PM handle this roadmap request?',
        'intermediate',
        'Slack',
        'Handling sales-led roadmap requests from single large customers',
        'B',
        E'B is the correct answer. PMs must defend the product architecture and strategy against sales-led requests that create permanent fragmentation or deviate from the core business model. Offering a compliant cloud solution (like EKM) that leverages existing capabilities is the correct way to address the customer''s security needs without compromising the platform. Option A and C create unsustainable maintenance overhead and fracture the codebase. Option D is an irrational pivot based on a single customer''s request.',
        ARRAY['roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Put the custom on-premise solution on the roadmap to secure the massive revenue, and worry about the architectural fragmentation later.', false),
    (v_q_id, 'B', 'Decline the on-premise request, explain that it conflicts with the core product architecture, and offer to work with their security team to validate Slack''''s ''''Enterprise Key Management'''' (EKM) cloud solution.', true),
    (v_q_id, 'C', 'Secretly build a separate fork of the codebase for the bank and have a dedicated team maintain it manually.', false),
    (v_q_id, 'D', 'Immediately change Slack''''s overall product strategy to move all enterprise customers to on-premise deployments.', false);

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
        'Shopify''s POS Terminal Rollout',
        E'Shopify is launching a new physical Point-of-Sale (POS) terminal. The hardware manufacturing team is in Shenzhen, the firmware team is in Toronto, and the POS software app team is in San Francisco. A delay in the hardware certification process in China threatens to push back the launch by 8 weeks. How should the software PM adapt the POS app roadmap?',
        'intermediate',
        'Shopify',
        'Hardware-software dependency coordination on a product roadmap',
        'C',
        E'C is the correct answer. When faced with an unavoidable external dependency delay (like hardware manufacturing), the PM must adapt the software roadmap productively. Building an emulator allows merchants to try the software and helps developers debug, while the extra time is spent on software polish. Option A creates user confusion and negative reviews from merchants who download an app they cannot use. Option B is an inefficient use of resources. Option D is unprofessional and dangerous.',
        ARRAY['roadmapping', 'dependency_management', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the software roadmap unchanged, launch the POS app on the App Store as scheduled, and let users download it even if they don''''t have the hardware.', false),
    (v_q_id, 'B', 'Pause all software development for 8 weeks and send the engineers on vacation to save budget.', false),
    (v_q_id, 'C', 'Pivot the software team to build a ''''Virtual Terminal Emulator'''' on the roadmap so merchants can test the software on iPads while waiting for hardware, and use the extra time to refine retail-specific software features.', true),
    (v_q_id, 'D', 'Blame the hardware team publicly and demand that they bypass the certification process to stay on schedule.', false);

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
        'Duolingo''s Math App Consolidation',
        E'Duolingo developed a standalone Math app, but user engagement is low compared to the main Duolingo app. The PM decides to exclude future standalone Math features from the roadmap and instead merge the math curriculum into the main app as a ''Math course.'' The team working on the standalone app is resistant. How should the PM align the team?',
        'intermediate',
        'Duolingo',
        'Priority alignment and communicating the ''Why'' behind exclusions',
        'B',
        E'B is the correct answer. Aligning a team around a hard deprioritization or pivot requires transparently sharing the strategic data and metrics (reach, retention, impact) that drove the decision. This shows respect for the team''s work and frames the change as an opportunity for greater impact. Option A creates resentment and reduces motivation. Option C is a false promise that creates planning instability. Option D is deceptive and leads to organizational failure.',
        ARRAY['roadmapping', 'roadmap_exclusions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the team they must comply with the decision because it came from executive leadership, without explaining the rationale.', false),
    (v_q_id, 'B', 'Present the data: the main app has a 100x larger user base and a 3x higher D30 retention rate, meaning the math course will reach far more students and have a greater impact inside the main app.', true),
    (v_q_id, 'C', 'Promise the team that if the merged math course fails in the first 30 days, they will immediately resume work on the standalone app.', false),
    (v_q_id, 'D', 'Allow the team to continue working on the standalone app in secret while reporting to leadership that they have merged.', false);

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
        'Zoom''s Classroom Engagement Outcome',
        E'A Zoom PM for Education has a backlog filled with feature requests from teachers, such as ''Add emojis for raising hands,'' ''Add sound effects,'' and ''Add a timer widget.'' Instead of shipping these as a feature checklist, the PM wants to define a clear outcome. What is the most effective way to frame this roadmap objective?',
        'intermediate',
        'Zoom',
        'Transitioning from feature-driven requests to outcome-driven objectives',
        'B',
        E'B is the correct answer. Reframing the roadmap from feature requests to customer outcomes (active student participation) focuses the team on the actual problem (student disengagement) and allows them to design the best solutions, which may or may not include the requested emojis or sound effects. Option A is a feature-delivery goal. Option C is a vague, qualitative competitive claim that is not measurable. Option D is an operational support metric that does not address the core classroom experience.',
        ARRAY['roadmapping', 'outcome_driven', 'feature_driven']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build and release the Hand Raise Emojis, Sound Effects, and Timer features by the end of Q3.', false),
    (v_q_id, 'B', 'Increase the average percentage of active student participation per 45-minute virtual class session from 20% to 50%.', true),
    (v_q_id, 'C', 'Make the Zoom Education client the most feature-rich virtual classroom tool in the market.', false),
    (v_q_id, 'D', 'Reduce the customer support ticket volume related to classroom management by 15%.', false);

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
        'Stripe''s Tax API Platform Transition',
        E'Stripe''s internal engineering team has built a highly reliable internal database service for tax rate lookup. The PM wants to commercialize this service as a public ''Stripe Tax API.'' The current internal service has no public documentation, lacks multi-tenant rate limiting, and does not have a developer sandbox. How should the PM structure the transition roadmap?',
        'intermediate',
        'Stripe',
        'Transitioning internal platform utilities to public products',
        'B',
        E'B is the correct answer. Transitioning an internal utility to a public platform product requires prioritizing developer experience (DX) and system guardrails (rate limits, sandbox) on the roadmap. Without these, the API will fail to gain adoption and could degrade Stripe''s reputation. Option A risks system outages and developer frustration due to lack of sandboxing and rate limits. Option C ignores the basic requirements of a public API. Option D is overly defeatist and misses a major business opportunity.',
        ARRAY['roadmapping', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch the internal service as the public API next week, and add rate-limiting and sandboxing to the roadmap for next year.', false),
    (v_q_id, 'B', 'Design a roadmap that prioritizes developer-facing infrastructure (sandbox, rate-limits, docs) in Phase 1 before launching a public beta.', true),
    (v_q_id, 'C', 'Keep the team focused on adding new tax calculations (e.g., global VAT) while ignoring developer infrastructure.', false),
    (v_q_id, 'D', 'Cancel the public API launch because adapting internal services for external use is too difficult.', false);

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
        'Robinhood''s Crypto Wallet Delay',
        E'Robinhood announced a ''Crypto Wallet'' feature with a waitlist of over 1 million users, targeting a Q3 launch. In August, a security audit reveals a vulnerability in the multi-signature custody system that requires a 3-month redesign of the security architecture, pushing the launch to Q4. How should the PM handle the public communication and roadmap?',
        'intermediate',
        'Robinhood',
        'Communicating delays of highly anticipated features',
        'B',
        E'B is the correct answer. When a highly anticipated public feature is delayed, the PM must prioritize security and trust, and communicate the delay transparently. Framing the delay around protecting the users'' assets (''highest standard of security'') is the correct approach. Option A is extremely dangerous and irresponsible, putting user funds at risk. Option C damages company credibility and brand trust. Option D is unprofessional and does not solve the product delivery issue.',
        ARRAY['roadmapping', 'stakeholder_timeline', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Release the wallet in Q3 with the known vulnerability to meet the public promise, and patch it quietly later.', false),
    (v_q_id, 'B', 'Send an email to the waitlist explaining that Robinhood is extending the testing phase to ensure the highest security standards, and update the target to Q4.', true),
    (v_q_id, 'C', 'Say nothing publicly, delete the waitlist landing page, and hope users forget about the feature.', false),
    (v_q_id, 'D', 'Blame the external security auditing firm for the delay and file a lawsuit to show users it wasn''''t Robinhood''''s fault.', false);

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
        'Notion''s AI Content Block Expansion',
        E'Notion''s PM is planning the annual product roadmap. The sales and marketing teams are demanding ''AI Content Generation'' tools because they are highly marketable and drive immediate sign-ups. Meanwhile, engineering telemetry shows that offline synchronization errors are the top driver of user churn for power users. How should the PM allocate resources?',
        'intermediate',
        'Notion',
        'Balancing marketing-led hype features with core infrastructure stability',
        'C',
        E'C is the correct answer. A balanced product roadmap must address both growth/acquisition (marketing-friendly features like AI) and core product health (sync reliability) to prevent a ''leaky bucket'' scenario where new users sign up but churn quickly due to poor quality. Splitting the roadmap into distinct strategic tracks is the best practice. Option A ignores a critical retention threat. Option B ignores market competition and acquisition opportunities. Option D abdicates the PM''s responsibility to make strategic product decisions based on business outcomes.',
        ARRAY['roadmapping', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allocate 100% of the roadmap to AI Content Generation to ride the industry hype cycle and maximize new sign-ups.', false),
    (v_q_id, 'B', 'Allocate 100% of the roadmap to fixing offline sync, ignoring the AI demands, since retention is the only metric that matters.', false),
    (v_q_id, 'C', 'Balance the roadmap by creating two parallel tracks: a ''''Growth & Acquisition'''' track focused on AI, and a ''''Core Retention & Quality'''' track focused on sync reliability.', true),
    (v_q_id, 'D', 'Let the engineering team vote on which project they prefer to work on, and assign the roadmap based on their preference.', false);

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
        'Atlassian''s Jira Product Discovery Tool',
        E'Atlassian''s PM for Jira Product Discovery is designing the product roadmap. The team needs to communicate progress to three different groups: internal engineers who need sprint-level detail, the sales team who need quarterly estimates, and external enterprise customers who want to see the strategic direction. What is the best roadmap strategy?',
        'intermediate',
        'Atlassian',
        'Designing roadmaps for different stakeholder needs',
        'B',
        E'B is the correct answer. Different stakeholders require different levels of detail and communication formats. Engineering needs task-level execution details; Sales needs high-level business milestones; Customers need strategic themes and directions. Generating these views from a single source of truth ensures consistency while preventing date commits to customers. Option A commits to false precision with customers. Option C overwhelms non-technical stakeholders and creates confusion. Option D damages customer trust and alignment.',
        ARRAY['roadmapping', 'stakeholder_timeline', 'now_next_later']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Maintain a single, highly detailed Gantt chart with exact release dates and share it publicly with all three groups.', false),
    (v_q_id, 'B', 'Create three distinct views of the roadmap from a single source of truth: a detailed backlog for engineering, a quarterly milestone view for sales, and a theme-based (Now-Next-Later) view for customers.', true),
    (v_q_id, 'C', 'Tell the sales team and customers to look at the engineering team''''s Jira board to see what is being built.', false),
    (v_q_id, 'D', 'Only create a roadmap for the engineering team, and tell the sales team and customers that Atlassian does not share timelines.', false);

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
        'GitHub''s Advanced Vulnerability Prioritization',
        E'GitHub''s Security PM is managing a Q4 roadmap. In October, a zero-day vulnerability is discovered in the Git core protocol that affects all self-hosted enterprise servers. At the same time, the team is mid-way through a strategic migration of the database infrastructure to prevent weekend database outages (which occurred twice last month), and is also committed to shipping the highly marketed ''GitHub Copilot Security Autofix'' feature by December 15th. What is the most strategic way to reprioritize the roadmap?',
        'advanced',
        'GitHub',
        'Advanced multi-variable prioritization and urgent risk management',
        'A',
        E'A is the correct answer. A zero-day vulnerability that threatens the security of self-hosted enterprise servers represents an immediate, high-severity security risk that must take precedence over all other roadmap items, including critical infrastructure migrations and commercial launches. Security and trust are foundational baseline requirements. Once the zero-day is patched, the team must return to the database migration because recurring database outages represent a major system stability risk (retention threat) that is more critical than a new feature launch like Copilot Autofix. Option B is an unacceptable security risk. Option C is impractical for core security patches. Option D ignores the immediate threat of database outages, which should be prioritized over the new feature.',
        ARRAY['roadmapping', 'roadmap_adaptation', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pause the database migration and the Copilot feature; allocate 100% of engineering resources to patch the zero-day vulnerability immediately, then resume the database migration.', true),
    (v_q_id, 'B', 'Ignore the zero-day vulnerability since it only affects self-hosted customers, and proceed with the database migration and the Copilot launch.', false),
    (v_q_id, 'C', 'Hire a third-party security firm to patch the zero-day vulnerability while the internal team continues working on the database migration and the Copilot feature.', false),
    (v_q_id, 'D', 'Postpone the Copilot feature launch and use those resources to patch the vulnerability, while keeping the database migration running at full speed.', false);

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
        'Netflix''s Gaming Portfolio Allocation',
        E'Netflix''s VP of Product is allocating the product roadmap budget for the next fiscal year. The core video streaming business is growing at 3% YoY, while the experimental Gaming division is in its infancy with high user acquisition costs but high potential for long-term subscriber engagement. The executive team is debating how to distribute resources. What is the most strategic roadmapping approach?',
        'advanced',
        'Netflix',
        'Advanced portfolio roadmapping and strategic resource allocation',
        'C',
        E'C is the correct answer. Advanced portfolio roadmapping requires a structured resource allocation model (such as the 70-20-10 or 75-20-5 Core-Adjacent-Transformational model) to balance near-term core optimizations with long-term strategic bets under uncertainty. This ensures the core business remains stable while incubating future growth engines. Options A and B are extreme positions that either choke off future innovation or starve the core cash cow. Option D suffers from projection bias, where teams exaggerate ROI to win funding, leading to poor strategic alignment.',
        ARRAY['roadmapping', 'tactical_vs_strategic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allocate 95% of resources to the core streaming business to maximize near-term revenue, and shut down the gaming division.', false),
    (v_q_id, 'B', 'Allocate 50% of resources to Gaming to aggressively catch up with competitors, even if it causes video streaming quality to degrade.', false),
    (v_q_id, 'C', 'Use a core-innovation investment matrix: allocate 75% of resources to optimize core streaming (core), 20% to scaling gaming mechanics (adjacent), and 5% to speculative web3/VR experiments (transformational).', true),
    (v_q_id, 'D', 'Let each product team bid for budget in an internal auction, allocating resources to the team that projects the highest immediate ROI.', false);

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
        'Uber''s Autonomous Vehicle Delivery Network',
        E'Uber''s Autonomous Mobility PM is managing a multi-year roadmap for deploying self-driving robotaxis in urban markets. The roadmap has three critical dependencies: (1) regulatory approval for driverless operations in City X, (2) the delivery of new electric vehicles from a partner OEM, and (3) the training of the routing AI on City X''s unique weather patterns. The regulatory approval is delayed indefinitely due to local political changes. What is the most strategic roadmap adaptation?',
        'advanced',
        'Uber',
        'Managing systemic dependencies and external delays',
        'B',
        E'B is the correct answer. In advanced dependency management, when a critical external blocker (like regulations in City X) is delayed indefinitely, the PM must adapt the roadmap by shifting resources and assets to an alternative path (City Y) where progress can be made. This maintains strategic momentum and avoids wasting capital on idle assets (OEM vehicles). Option A is a passive strategy that creates execution delays and false reporting. Option C halts all company progress due to a single localized blocker. Option D is illegal and violates safety standards.',
        ARRAY['roadmapping', 'dependency_management', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the city X launch timeline on the roadmap to maintain investor pressure, and hope the regulations change.', false),
    (v_q_id, 'B', 'Pivot the roadmap immediately: redirect the OEM vehicles to City Y (where regulations are already favorable) and shift the AI training focus to City Y''''s climate, minimizing idle assets.', true),
    (v_q_id, 'C', 'Stop all AI training and vehicle deliveries globally until City X''''s regulatory status is resolved.', false),
    (v_q_id, 'D', 'Launch the robotaxis in City X anyway, using human backup drivers, and keep the autonomous roadmap unchanged.', false);

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
        'Spotify''s Creator Marketplace Roadmap',
        E'Spotify''s Marketplace PM is designing a roadmap for the Creator Portal. The PM faces conflicting demands from three powerful stakeholders: (1) Ad Sales wants sponsored song recommendation slots to drive ad revenue, (2) Creator Relations wants tools for artists to pitch songs directly to editors for free, and (3) Music Labels want premium analytics to track artist growth. The engineering team has capacity for only one major track. How should the PM resolve this conflict?',
        'advanced',
        'Spotify',
        'Resolving conflicting cross-functional priorities using strategic alignment',
        'C',
        E'C is the correct answer. Resolving high-stakes stakeholder conflicts requires aligning the roadmap to a single, agreed-upon strategic metric (Artist Retention and Satisfaction) that represents the long-term platform health. Evaluating requests against this framework enables objective prioritization, and a creative packaging approach (free tool for artists, paid analytics for labels) satisfies multiple stakeholder needs without fragmenting engineering resources. Options A and B capitulate to single-stakeholder pressure and ignore the platform ecosystem balance. Option D is an anti-pattern that creates architectural fragmentation and low-quality execution.',
        ARRAY['roadmapping', 'roadmap_exclusions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allocate the roadmap to Ad Sales because direct revenue is the easiest metric to measure and justify to the CFO.', false),
    (v_q_id, 'B', 'Allocate the roadmap to Music Labels because they control the licensing agreements that keep music on Spotify.', false),
    (v_q_id, 'C', 'Define a ''''North Star'''' strategic framework where the core roadmap objective is ''''Artist Retention and Satisfaction,'''' evaluate all three requests against this metric, and build a combined MVP that features a basic free editor pitch tool alongside paid label analytics.', true),
    (v_q_id, 'D', 'Split the engineering team into three micro-teams, allowing each team to build a separate, independent version of the features.', false);

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
        'Figma''s Enterprise Permission Model Restructure',
        E'Figma''s Enterprise PM needs to migrate the platform''s permission and access control system to support custom enterprise roles. The engineering team estimates that this database migration will require 100% of the team''s capacity for two quarters. However, the sales and marketing teams are warning that a 6-month feature freeze will cause Figma to fall behind competitors in interactive prototyping. How should the PM structure the roadmap?',
        'advanced',
        'Figma',
        'Managing systemic database and security migrations on the roadmap',
        'C',
        E'C is the correct answer. Advanced roadmapping requires balancing systemic structural rewrites (permissions) with commercial market needs (prototyping). Phasing the migration over a longer period with a dedicated capacity allocation (50/50) allows the team to maintain market momentum with lightweight feature updates while making steady progress on the critical architectural foundation. Option A builds massive technical debt that will eventually block all enterprise sales. Option B risks market share loss and competitor pull-ahead during the freeze. Option D is dangerous because core security and authorization systems are too critical to be outsourced.',
        ARRAY['roadmapping', 'tactical_vs_strategic', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Postpone the permission rewrite indefinitely and continue building prototyping features, using manual workarounds for enterprise clients.', false),
    (v_q_id, 'B', 'Declare a complete feature freeze for two quarters to let engineering perform the migration without any distractions.', false),
    (v_q_id, 'C', 'Phase the migration over four quarters by dedicating 50% of engineering capacity to infrastructure and 50% to features, and build ''''wrapper'''' feature improvements that do not depend on the new model in the interim.', true),
    (v_q_id, 'D', 'Outsource the permission system migration to a third-party developer agency to keep the internal engineering team focused on prototyping features.', false);

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
        'Shopify''s Global Tax Compliance Engine',
        E'Shopify is expanding in Europe. The sales team demands that the PM build a custom tax compliance and invoicing feature specifically for Germany''s complex local regulations to close a major partnership. However, the core platform team is building a ''Global Tax Calculation API'' designed to support all international markets starting next year. What is the most strategic roadmapping decision?',
        'advanced',
        'Shopify',
        'Sales-led local compliance requests vs scalable global platform roadmap',
        'C',
        E'C is the correct answer. Advanced PMs protect the scalable core platform by leveraging the developer ecosystem (App Store/integrations) to address hyper-local or single-market compliance demands. This unblocks the immediate sales opportunity without distracting the internal team from building the long-term, scalable global architecture. Option A creates duplicate code and architectural fragmentation. Option B loses the commercial opportunity. Option D is highly inefficient and fails to leverage platform scalability.',
        ARRAY['roadmapping', 'roadmap_exclusions', 'dependency_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build the custom German feature immediately as a separate service to win the partnership, and let the global team merge it later.', false),
    (v_q_id, 'B', 'Decline the custom German feature request and ask the sales team to wait until the Global Tax API is launched next year.', false),
    (v_q_id, 'C', 'Leverage Shopify''''s App Store ecosystem: partner with an existing German tax software provider to build an integration app for the immediate deal, while keeping the internal core team focused on the scalable Global Tax API.', true),
    (v_q_id, 'D', 'Stop the development of the Global Tax API and pivot the entire global team to build local tax engines for each European country one by one.', false);

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
        'Slack''s Desktop Client Migration',
        E'Slack is planning a complete rewrite of its desktop client (transitioning from legacy Electron/JavaScript to a modern rendering pipeline) to solve severe memory usage and startup latency issues. This migration requires a 12-month development cycle where no new consumer-facing features can be shipped. The marketing team is terrified of losing momentum. How should the PM manage stakeholder trust and expectations on the roadmap?',
        'advanced',
        'Slack',
        'Managing stakeholder trust during long-term architectural migrations',
        'B',
        E'B is the correct answer. Managing a long-term architectural migration requires reframing the roadmap from ''what features we are freezing'' to ''what outcomes (speed, reliability) we are delivering to the customer.'' Supplementing the migration with low-effort, high-impact ''quality-of-life'' improvements keeps the product feeling fresh and maintains market momentum without disrupting the core engineering rewrite. Option A is dishonest and destroys organizational trust. Option C is a short-sighted strategy that leads to a technical dead-end. Option D is an inefficient resource allocation that fails to solve the architectural crisis in a reasonable timeframe.',
        ARRAY['roadmapping', 'stakeholder_timeline', 'roadmap_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the migration secret from the marketing and sales teams, and continue reporting fake feature release dates on the roadmap.', false),
    (v_q_id, 'B', 'Present a ''''Performance and Reliability'''' roadmap that frames the client rewrite not as a feature freeze, but as a strategic upgrade that will reduce app load times by 50%, and plan a series of high-impact ''''quality-of-life'''' micro-features (which require low dev effort) to ship throughout the year.', true),
    (v_q_id, 'C', 'Cancel the rewrite and continue patching the legacy client with temporary memory fixes, despite knowing it will eventually become unusable.', false),
    (v_q_id, 'D', 'Split the engineering team: 10% on the rewrite and 90% on new features, accepting that the rewrite will now take 10 years to complete.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Roadmapping';

END $$;
