-- ============================================
-- ASSESSMENT: Journey Mapping
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
    WHERE slug = 'journey-mapping';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug journey-mapping not found. Run the seed data first.';
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
        'Spotify''s Moment of Truth',
        E'Spotify''s PM is mapping the new user journey. After signing up, users listen to a generated playlist, share a song, and create their own playlist. Which touchpoint represents the primary "Moment of Truth" (MoT) in this journey?',
        'foundational',
        'Spotify',
        'Streaming music discovery phase',
        'B',
        E'A Moment of Truth (MoT) in journey mapping is a critical touchpoint where the user forms a lasting impression of the product''s value. For Spotify, experiencing personalized value (the music) is the realization of the core value proposition. Account creation is just a necessary friction step, not the emotional peak. Sharing a song is an action taken after the value is realized.',
        ARRAY['moment_of_truth', 'touchpoints', 'onboarding']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The account creation screen, because it captures user data.', false),
    (v_q_id, 'B', 'The moment the user hears their first personalized playlist and realizes the app''s value.', true),
    (v_q_id, 'C', 'The moment the user successfully shares a song on social media.', false),
    (v_q_id, 'D', 'The push notification reminding them to open the app.', false);

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
        'Uber''s Identifying Touchpoints',
        E'An Uber PM is documenting the rider journey map for a typical trip. Which of the following should be classified as a "touchpoint" rather than an "action" or "emotion"?',
        'foundational',
        'Uber',
        'Rider booking and tracking experience',
        'B',
        E'A touchpoint is a specific point of interaction between the user and the product/service interface. The push notification is a direct, observable interaction point. Feeling anxious is an emotion (which belongs on the empathy curve). Deciding to book is a user action or decision. The API call is a back-stage process, not a front-stage user touchpoint.',
        ARRAY['touchpoints', 'omnichannel', 'journey_components']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The user feels anxious about being late.', false),
    (v_q_id, 'B', 'The push notification stating "Your driver is arriving".', true),
    (v_q_id, 'C', 'The user decides to book an Uber instead of a Lyft.', false),
    (v_q_id, 'D', 'The background API call connecting the rider app to the driver app.', false);

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
        'Airbnb''s Defining the User',
        E'Airbnb''s PM is creating a journey map for the "first-time booking" experience. The map includes phases like "Search", "Request", "Host Approval", and "Payment". What is the fundamental flaw in this journey map?',
        'foundational',
        'Airbnb',
        'Marketplace booking flow',
        'B',
        E'Journey maps should always be anchored to a specific persona. Mixing the Guest''s journey (Search, Request, Payment) with the Host''s actions (Host Approval) creates confusion. The host''s approval should either be mapped as a system response/wait-state from the Guest''s perspective, or separated into a distinct Host Journey Map. Blurring them ruins the empathy focus.',
        ARRAY['personas', 'actor_mapping', 'marketplace_journeys']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It lacks a phase for "Post-Trip Review".', false),
    (v_q_id, 'B', 'It mixes the Guest''s journey with the Host''s journey without distinction.', true),
    (v_q_id, 'C', 'It doesn''t include the exact UI elements used in each phase.', false),
    (v_q_id, 'D', '"Payment" should always come before "Host Approval".', false);

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
        'Notion''s Phase Boundaries',
        E'Notion''s Growth PM is mapping the "Onboarding" phase. Where should the boundaries of this phase typically begin and end for a SaaS productivity tool?',
        'foundational',
        'Notion',
        'User onboarding and activation',
        'B',
        E'The onboarding phase in a journey map typically spans from initial entry (signup/first open) to the first "Aha!" moment or completion of a core loop (like creating a database). Converting to paid or inviting users are important, but they belong in later phases like "Monetization" or "Advocacy". Time-boxing to 7 days ignores actual user behavior and milestones.',
        ARRAY['phase_boundaries', 'onboarding', 'activation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'From the first marketing ad clicked to the moment the user pays for a premium subscription.', false),
    (v_q_id, 'B', 'From the first time opening the app to the moment the user successfully completes a core action, like creating their first database.', true),
    (v_q_id, 'C', 'From the account creation screen to exactly 7 days post-signup.', false),
    (v_q_id, 'D', 'From the first app launch to the user inviting a team member.', false);

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
        'Duolingo''s Mapping Emotional Highs',
        E'Duolingo''s PM maps out the daily lesson journey. The user receives a push notification, opens the app, struggles with a translation, uses a hint, completes the lesson, and sees the "Streak Extended" animation. Where should the emotional peak be mapped?',
        'foundational',
        'Duolingo',
        'Daily engagement loop',
        'C',
        E'The "Streak Extended" animation is intentionally designed to be the emotional high point, providing a dopamine hit and reinforcing the habit loop (the Reward phase). Struggles during the lesson represent cognitive friction (emotional low points), and notifications are merely external triggers, not the emotional payoff.',
        ARRAY['emotional_journey', 'empathy_mapping', 'habit_loops']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'When the push notification is received.', false),
    (v_q_id, 'B', 'When the user uses a hint to overcome a struggle.', false),
    (v_q_id, 'C', 'When the "Streak Extended" animation plays.', true),
    (v_q_id, 'D', 'When the user closes the app.', false);

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
        'Peloton''s Offline Touchpoints',
        E'A PM at Peloton is journey mapping the "Purchase to First Ride" experience. Which touchpoint is most critical to include even though it happens entirely outside the digital interface?',
        'foundational',
        'Peloton',
        'Hardware delivery and setup',
        'B',
        E'Journey mapping must capture the entire holistic user experience, crossing the boundary between physical and digital. The delivery and assembly of the bike is a massive, highly emotional touchpoint for a hardware product. Backend syncs are invisible (back-stage), and emails/app downloads are standard digital touchpoints.',
        ARRAY['omnichannel', 'physical_touchpoints', 'service_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The confirmation email sent from the backend system.', false),
    (v_q_id, 'B', 'The delivery team assembling the bike in the user''s home.', true),
    (v_q_id, 'C', 'The user downloading the companion app from the App Store.', false),
    (v_q_id, 'D', 'The backend syncing the user''s profile with the bike''s tablet.', false);

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
        'DoorDash''s Front-stage vs Back-stage',
        E'A DoorDash PM is building a user journey map for ordering food. A stakeholder insists on adding the step: "Order gets routed to the nearest available Dasher." How should the PM handle this?',
        'foundational',
        'DoorDash',
        'Food delivery operations',
        'C',
        E'User journey maps strictly reflect the user''s perspective (front-stage). Internal processes like routing algorithms are invisible to the Eater. They belong in a Service Blueprint under "Back-stage Actions" or "Support Processes". Including them in the primary user touchpoint layer dilutes the focus on the user''s actual emotional experience.',
        ARRAY['front_stage', 'back_stage', 'service_blueprint']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add it as a primary user touchpoint in the journey map.', false),
    (v_q_id, 'B', 'Replace the "User tracking the order" touchpoint with this step.', false),
    (v_q_id, 'C', 'Exclude it from the main user journey map or add it to a "Back-stage" layer, as it is invisible to the user.', true),
    (v_q_id, 'D', 'Create an entirely new journey map just for the routing algorithm.', false);

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
        'Netflix''s Purpose of Journey Maps',
        E'Netflix''s PM wants to improve the process of finding a movie on Friday nights. What is the primary reason the PM should use a Journey Map instead of just analyzing a quantitative funnel dashboard?',
        'foundational',
        'Netflix',
        'Content discovery',
        'B',
        E'Quantitative funnels show *where* users drop off (the "what"), but qualitative Journey Maps capture the user''s context, thoughts, and emotions, revealing the *why* behind the friction. Journey maps are empathy-building tools, not precision calculators for drop-off percentages or automated A/B test generators.',
        ARRAY['qualitative_data', 'friction', 'user_empathy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Journey Map accurately calculates the exact drop-off percentage at each step.', false),
    (v_q_id, 'B', 'A Journey Map captures qualitative emotional states and friction, answering "why" users drop off, not just "where".', true),
    (v_q_id, 'C', 'A Journey Map automatically generates A/B test hypotheses based on data.', false),
    (v_q_id, 'D', 'A Journey Map is required by engineering to understand system architecture.', false);

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
        'Shopify''s Current vs Future State',
        E'Shopify''s PM is tasked with redesigning the merchant checkout configuration flow. They start by immediately creating a "Future State" journey map. Why is this approach risky?',
        'foundational',
        'Shopify',
        'Merchant onboarding',
        'B',
        E'When redesigning an existing flow, failing to map the "Current State" first means you miss the opportunity to baseline the existing pain points, user workarounds, and systemic constraints. A future state map without a current state foundation is often a theoretical fantasy that doesn''t address the actual problems merchants face.',
        ARRAY['current_state', 'future_state', 'process_mapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Future state maps take significantly longer to create than current state maps.', false),
    (v_q_id, 'B', 'It anchors the team on a theoretical ideal without first identifying the actual pain points and constraints of the existing experience.', true),
    (v_q_id, 'C', 'Future state maps cannot include quantitative data overlays.', false),
    (v_q_id, 'D', 'Future state maps are only useful for brand new zero-to-one products, not existing ones.', false);

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
        'Tinder''s Missing Micro-Friction',
        E'Tinder''s PM maps the user journey: Download ➔ Create Profile ➔ Swipe ➔ Match ➔ Message. Data shows a massive drop-off between "Match" and "Message". The journey map shows the emotional state at "Match" is highly positive. What is the most likely missing element in this map?',
        'foundational',
        'Tinder',
        'Matching and messaging flow',
        'A',
        E'Journey maps often gloss over micro-frictions. While getting a match is an emotional high, the transition to messaging involves high anxiety and cognitive load ("What do I say to start the conversation?"). If the map doesn''t capture this emotional plunge immediately after the match, it fails to explain the steep drop-off in the funnel.',
        ARRAY['drop_off_diagnosis', 'emotional_journey', 'micro_friction']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The map fails to break down the micro-frictions of initiating a conversation, such as anxiety about the first message.', true),
    (v_q_id, 'B', 'The map shouldn''t include the "Message" phase at all, as conversation quality is out of Tinder''s control.', false),
    (v_q_id, 'C', 'The map doesn''t show the backend server load during the matching algorithm.', false),
    (v_q_id, 'D', 'The map incorrectly assumes "Match" is a positive emotion; users actually hate getting matches.', false);

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
        'Amazon''s Omnichannel Mapping',
        E'Amazon''s PM is mapping the journey of buying a large appliance. The user researches on desktop, checks AR view on the mobile app, and receives a physical delivery. What is the primary challenge in mapping this omnichannel journey?',
        'intermediate',
        'Amazon',
        'E-commerce large item purchase',
        'B',
        E'Omnichannel journeys are complex because users expect their context (cart, preferences, browsing history) to persist seamlessly across channels. The PM must map how the system state is maintained when switching from desktop research to mobile AR, and finally to physical delivery. Attempting to force single-channel behavior creates massive friction.',
        ARRAY['omnichannel', 'context_continuity', 'cross_device']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ensuring the user uses only one device to reduce mapping complexity.', false),
    (v_q_id, 'B', 'Tracking the continuity of context and state as the user switches between channels and physical environments.', true),
    (v_q_id, 'C', 'Forcing the physical delivery team to use the Amazon mobile app.', false),
    (v_q_id, 'D', 'Keeping the emotional line flat to represent a seamless experience.', false);

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
        'Figma''s Persona Specificity',
        E'Figma''s PM maps the "Developer Handoff" feature journey. The map shows "User opens file -> User inspects CSS -> User exports assets". What critical mistake has the PM made regarding personas?',
        'intermediate',
        'Figma',
        'Design to development handoff',
        'B',
        E'In collaborative SaaS tools like Figma, different personas have completely different goals, entry points, and emotional states. A Designer creates the file, while a Developer inspects and exports. Using a generic "User" persona obscures the distinct needs and the handoff friction between these two distinct roles.',
        ARRAY['personas', 'collaboration', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They assumed the user exports assets before inspecting CSS.', false),
    (v_q_id, 'B', 'They conflated the "Designer" persona with the "Developer" persona into a generic "User".', true),
    (v_q_id, 'C', 'They didn''t include the "Manager" persona in the flow.', false),
    (v_q_id, 'D', 'They failed to map the journey of the physical keyboard strokes.', false);

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
        'Slack''s Quantifying the Map',
        E'Slack''s PM has built a beautiful, qualitative journey map of the "Workspace Creation" flow, showing emotional dips during the invite step. Leadership asks, "How do we know this is our biggest problem?" How should the PM integrate data to answer this?',
        'intermediate',
        'Slack',
        'B2B workspace onboarding',
        'A',
        E'A strong journey map pairs the qualitative "why" (emotional dips, user quotes) with the quantitative "what" (funnel drop-offs, time-on-task). Overlaying conversion metrics directly onto the map proves the business impact of the emotional friction, making a compelling, data-backed case for leadership to allocate resources.',
        ARRAY['quantitative_data', 'funnel_analysis', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Overlay funnel conversion rates and drop-off percentages directly onto the corresponding journey phases.', true),
    (v_q_id, 'B', 'Replace the emotional curve with a line graph of daily active users.', false),
    (v_q_id, 'C', 'Discard the journey map entirely and only present a SQL dashboard.', false),
    (v_q_id, 'D', 'Conduct more user interviews to get a statistically significant sample size of emotions.', false);

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
        'Airbnb''s Prioritizing Pain Points',
        E'An Airbnb PM maps the guest journey and finds three pain points: \n1) Search filter UI is slightly confusing. \n2) Guests feel severe anxiety waiting 24 hours for a host to accept a booking. \n3) The checkout page loads slowly. \nHow should the PM use the journey map to prioritize these?',
        'intermediate',
        'Airbnb',
        'Guest booking experience',
        'C',
        E'Journey maps highlight "Moments of Truth"—points where emotional stakes are highest for the user. Waiting 24 hours creates severe anxiety and directly impacts conversion (users abandon the booking). It is a deeper structural pain point than a slightly confusing UI or a slow load time, making it the highest priority to fix (e.g., via Instant Book).',
        ARRAY['moment_of_truth', 'prioritization', 'pain_points']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fix the search filters first because they occur earliest in the chronological journey.', false),
    (v_q_id, 'B', 'Fix the checkout page first because technical debt is easiest to measure.', false),
    (v_q_id, 'C', 'Prioritize the host acceptance wait, as it represents a deep emotional trough ("Moment of Truth") that risks the user abandoning the platform entirely.', true),
    (v_q_id, 'D', 'Fix all three simultaneously to ensure a perfectly smooth journey map.', false);

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
        'Stripe''s B2B Dual Journeys',
        E'Stripe''s PM maps the implementation of Stripe Billing. They realize the CTO makes the purchasing decision, but a junior developer actually writes the API integration. How should the journey map reflect this reality?',
        'intermediate',
        'Stripe',
        'B2B API integration',
        'A',
        E'In B2B SaaS, the economic buyer (CTO) and the end-user (Developer) are often different people with entirely different goals, emotions, and touchpoints. Combining them hides the friction. Mapping both separately—and explicitly showing where the handoff occurs between them—is essential for a complete picture of the enterprise lifecycle.',
        ARRAY['b2b_journeys', 'personas', 'decision_makers']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create two separate journey maps (Buyer Journey and User/Implementation Journey) that intersect at the point of handoff.', true),
    (v_q_id, 'B', 'Map only the CTO''s journey, as they hold the budget and are the true customer.', false),
    (v_q_id, 'C', 'Combine both personas into one "Company" persona to simplify the map for stakeholders.', false),
    (v_q_id, 'D', 'Map only the developer''s journey, since Stripe is fundamentally an API-first product.', false);

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
        'Spotify''s Non-Linear Discovery',
        E'A PM at Spotify is mapping the "Discovery" journey, but realizes users find new music via search, algorithmic playlists, friend activity, and external links in random orders. How should the PM approach mapping this non-linear behavior?',
        'intermediate',
        'Spotify',
        'Music discovery pathways',
        'C',
        E'Modern digital journeys are rarely linear. Attempting to map every permutation creates an unreadable mess, and forcing a linear path is inaccurate. PMs should map modular "core loops" or use a hub-and-spoke model where the "hub" is the home screen and users embark on various discovery "spokes" iteratively.',
        ARRAY['non_linear_journeys', 'core_loops', 'discovery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force all users into a single, idealized linear path to keep the document readable.', false),
    (v_q_id, 'B', 'Give up on journey mapping and use a Service Blueprint instead.', false),
    (v_q_id, 'C', 'Map the core loops (e.g., the "Discover Weekly" loop) and use a "hub and spoke" model rather than a strict chronological timeline.', true),
    (v_q_id, 'D', 'Map every single possible permutation of user actions on one massive, branching document.', false);

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
        'DoorDash''s Multi-Actor Intersections',
        E'DoorDash''s PM maps the "Delivery" phase. The map shows the Eater waiting, the Dasher driving, and the Restaurant preparing food. What is the most critical element to highlight in this multi-actor map?',
        'intermediate',
        'DoorDash',
        'Three-sided marketplace dynamics',
        'B',
        E'In a multi-sided marketplace, the "magic" happens when different actors'' journeys intersect perfectly. The journey map must highlight these intersection points and synchronization handoffs, as misalignments (e.g., Dasher waits 20 mins for food, or food gets cold waiting for a Dasher) are the primary sources of friction.',
        ARRAY['marketplace_journeys', 'multi_actor', 'handoffs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The exact geographic route the Dasher takes on the map.', false),
    (v_q_id, 'B', 'The synchronization and communication handoffs between the actors (e.g., Dasher arriving just as food is ready).', true),
    (v_q_id, 'C', 'The emotional state of the Restaurant chef during peak hours.', false),
    (v_q_id, 'D', 'The background API calls to Google Maps routing services.', false);

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
        'Notion''s Identifying Journey Gaps',
        E'Notion''s PM reviews a user journey for "Inviting a teammate". The map shows: User clicks invite ➔ User enters email ➔ Teammate joins workspace. What critical gap in the user experience is missing from this map?',
        'intermediate',
        'Notion',
        'Viral growth loops',
        'B',
        E'A common mistake in journey mapping is ignoring the asynchronous gaps between actions, especially across different users. The time between sending the invite and the teammate joining is a massive black box where drop-offs happen. The map must capture the recipient''s context, email delivery, and their decision to click the link.',
        ARRAY['journey_gaps', 'asynchronous_actions', 'b2b_journeys']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The background database update creating the new user record.', false),
    (v_q_id, 'B', 'The time delay and the teammate''s experience of receiving the email and deciding to click the link.', true),
    (v_q_id, 'C', 'The specific hex color and copy of the invite button.', false),
    (v_q_id, 'D', 'The PM''s internal business goal for increasing daily active users.', false);

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
        'Netflix''s Invisible Touchpoints',
        E'Netflix''s PM is mapping the "Continue Watching" journey. The user finishes an episode on their iPad, puts it down, and the next day opens the app on their TV to see the next episode cued up. What touchpoint is driving this seamless experience?',
        'intermediate',
        'Netflix',
        'Cross-device continuity',
        'C',
        E'In modern connected ecosystems, the best touchpoints are often invisible. The automatic syncing of watch state across devices via the cloud is a critical enabler of the journey, even if the user takes no explicit action. The journey map must account for these invisible system enablers that maintain user context.',
        ARRAY['invisible_touchpoints', 'ecosystem_mapping', 'cross_device']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The user manually saving their progress before closing the iPad app.', false),
    (v_q_id, 'B', 'The customer support team manually syncing the accounts overnight.', false),
    (v_q_id, 'C', 'The ''invisible'' back-stage state synchronization between the device and the cloud.', true),
    (v_q_id, 'D', 'The push notification telling them to keep watching the next day.', false);

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
        'Uber''s Navigating Journey Extremes',
        E'Uber''s PM maps the journey of a rider. The map looks perfectly smooth with consistently high emotional states. However, support tickets show a massive spike in users who are deeply frustrated. What did the PM likely fail to include in the map?',
        'intermediate',
        'Uber',
        'Rider satisfaction',
        'B',
        E'A journey map that only shows the "happy path" is practically useless for product improvement. PMs must explicitly map common edge cases and "unhappy paths" (failures, cancellations, driver no-shows, surge pricing) to understand where the system breaks down and how to design better recovery experiences.',
        ARRAY['unhappy_path', 'edge_cases', 'error_recovery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The driver''s background check and onboarding process.', false),
    (v_q_id, 'B', 'Edge cases and "unhappy paths" (e.g., driver cancellations, surge pricing, lost items).', true),
    (v_q_id, 'C', 'The exact machine learning algorithm used to match drivers.', false),
    (v_q_id, 'D', 'The color psychology behind the Uber app icon.', false);

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
        'Duolingo''s Mapping Habit Loops',
        E'Duolingo''s PM wants to map the user journey to increase 30-day retention. Which psychological framework should they explicitly integrate into their journey map phases?',
        'intermediate',
        'Duolingo',
        'Gamification and retention',
        'A',
        E'For a habit-forming consumer app like Duolingo, the journey is not a linear path to purchase, but a recurring loop. Integrating Nir Eyal''s Hook Model (Trigger -> Action -> Variable Reward -> Investment) into the journey map helps the PM design specific touchpoints for triggers (notifications) and rewards (leaderboards).',
        ARRAY['habit_loops', 'hook_model', 'retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Hook Model (Trigger -> Action -> Variable Reward -> Investment).', true),
    (v_q_id, 'B', 'The standard B2B sales funnel (Lead -> MQL -> SQL).', false),
    (v_q_id, 'C', 'The Agile software development lifecycle.', false),
    (v_q_id, 'D', 'The RICE prioritization framework.', false);

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
        'Peloton''s Post-Purchase Dissonance',
        E'Peloton''s PM maps the journey from "Checkout" to "Delivery". There is a 3-week waiting period for the hardware. During this phase, users frequently cancel their orders. What emotional state should the PM map during this waiting period to address the churn?',
        'intermediate',
        'Peloton',
        'Fulfillment and delivery',
        'B',
        E'A classic journey mapping insight is the "valley of despair" during long fulfillment windows. Users who spend thousands of dollars experience cognitive dissonance (buyer''s remorse). By mapping this anxiety, the PM can design interventions (e.g., immediate access to the digital app, welcome videos) to bridge the gap and prevent cancellations.',
        ARRAY['post_purchase', 'cognitive_dissonance', 'emotional_journey']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Uninterrupted euphoria, as they are excited for the bike.', false),
    (v_q_id, 'B', 'Buyer''s remorse / Cognitive dissonance, triggered by a high price point and lack of immediate value.', true),
    (v_q_id, 'C', 'Complete apathy, as they are not using the product yet.', false),
    (v_q_id, 'D', 'Anger at the delivery team for taking so long.', false);

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
        'Shopify''s Mapping the Ecosystem',
        E'Shopify''s PM is mapping the "Store Setup" journey. They realize that merchants frequently leave the core Shopify dashboard to install 3rd-party apps (like Mailchimp or Yotpo) to complete their setup. How should the journey map handle this?',
        'intermediate',
        'Shopify',
        'Platform and app ecosystem',
        'C',
        E'For platform products, the user journey inevitably crosses into 3rd-party ecosystems. A good PM maps the user''s actual reality, not just the company''s proprietary software. Friction during an external app installation reflects poorly on the overall Shopify experience, so it must be mapped and optimized.',
        ARRAY['ecosystem_mapping', 'third_party', 'platform_journeys']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore it; 3rd-party apps are not Shopify''s responsibility.', false),
    (v_q_id, 'B', 'Treat it as a hard drop-off point and consider the journey ended.', false),
    (v_q_id, 'C', 'Map the 3rd-party ecosystem interactions as critical touchpoints, identifying friction in the handoff.', true),
    (v_q_id, 'D', 'Redesign Shopify to ban 3rd-party apps so the journey is linear and controllable.', false);

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
        'Tinder''s Offline Outcomes',
        E'Tinder''s journey map shows the final phase as "User sends a message". The PM argues the map is incomplete based on Jobs-to-be-Done theory. What is the true ultimate phase of the user''s journey?',
        'intermediate',
        'Tinder',
        'Dating app lifecycle',
        'C',
        E'The user''s goal isn''t to use the app; it''s to go on a date. The journey extends into the physical world. While Tinder can''t control the date, mapping it helps PMs understand the user''s true "Job to be Done" and might inspire critical features (e.g., location sharing, safety panic buttons, restaurant recommendations).',
        ARRAY['job_to_be_done', 'offline_touchpoints', 'macro_journey']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The user paying for a premium Tinder Gold subscription.', false),
    (v_q_id, 'B', 'The user deleting the app out of frustration.', false),
    (v_q_id, 'C', 'The offline date itself, which is the actual "Job to be Done" of the app.', true),
    (v_q_id, 'D', 'The user successfully swiping left on 100 consecutive profiles.', false);

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
        'Amazon''s Cross-Functional Alignment',
        E'Amazon''s PM has created a journey map for "Returns". Customer Support, Logistics, and Engineering are all arguing over who owns the problem of slow refunds. How should the PM use the journey map to resolve this?',
        'intermediate',
        'Amazon',
        'Cross-functional operations',
        'C',
        E'Journey maps break down organizational silos. By showing the holistic user experience, the map acts as a "boundary object"—a shared artifact that helps different departments (Support, Logistics) see how their isolated KPIs and back-stage processes combine to create a poor experience for the user at a single touchpoint.',
        ARRAY['boundary_object', 'cross_functional', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Hide the map and make a unilateral executive decision.', false),
    (v_q_id, 'B', 'Use the map to assign a single owner to the entire end-to-end journey.', false),
    (v_q_id, 'C', 'Use the map as a boundary object to show how each department''s back-stage actions collectively impact the single user-facing touchpoint of "Waiting for Refund".', true),
    (v_q_id, 'D', 'Create three separate journey maps, one for each department, so they can focus on their own silos.', false);

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
        'Figma''s Measuring the Map',
        E'Figma''s PM mapped the "Comment Resolution" journey and identified a major pain point. They shipped a new UI feature to fix it. How do they know if the journey actually improved?',
        'intermediate',
        'Figma',
        'Product iteration and measurement',
        'B',
        E'Journey maps are hypotheses about user friction. When you ship a fix, you must measure the impact using quantitative metrics (KPIs) associated with that specific touchpoint. A qualitative map must be tied to trackable metrics (like time-to-resolve) to prove the intervention was successful.',
        ARRAY['kpis', 'measurement', 'quantitative_data']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The digital journey map tool will automatically update its emotional curve.', false),
    (v_q_id, 'B', 'They should look at the corresponding quantitative KPIs (e.g., time to resolve a comment, feature adoption rate) linked to that specific journey phase.', true),
    (v_q_id, 'C', 'They should ask the engineering team if the code deployed successfully without errors.', false),
    (v_q_id, 'D', 'They should immediately create a new Future State map.', false);

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
        'Stripe''s Long-Tail Journeys',
        E'Stripe''s PM maps the enterprise sales journey. It typically takes 6-9 months from initial contact to going live. How should the PM format a map that spans such a long timeframe without it becoming unreadable?',
        'intermediate',
        'Stripe',
        'Enterprise sales cycle',
        'C',
        E'Mapping a 9-month B2B journey day-by-day creates an unreadable document. The PM should structure the map hierarchically: a macro-level view of the months-long phases (Evaluation, Integration), with nested, zoomed-in micro-journeys for critical interactions (like the API sandbox testing day).',
        ARRAY['macro_journey', 'micro_journey', 'b2b_journeys']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Map it day-by-day to ensure no touchpoint is missed.', false),
    (v_q_id, 'B', 'Compress it into a standard 5-step consumer funnel to make it readable.', false),
    (v_q_id, 'C', 'Break the map into macro-phases (Evaluation, Integration, Launch) and zoom into micro-journeys for specific high-friction moments.', true),
    (v_q_id, 'D', 'Only map the first week, as the rest of the 9 months is too unpredictable.', false);

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
        'Slack''s Translating to Roadmap',
        E'Slack''s PM presents a journey map showing that new users feel overwhelmed by too many channels. Leadership says, "Great map, but what do we do?" What is the immediate next step for the PM to make the map actionable?',
        'intermediate',
        'Slack',
        'Product strategy alignment',
        'A',
        E'A journey map is useless if it doesn''t drive action. The standard bridge from a journey map to a product roadmap is taking the identified pain points and framing them as "How Might We" (HMW) opportunities. These HMWs then lead to ideation, prioritization, and concrete feature development.',
        ARRAY['how_might_we', 'roadmapping', 'actionable_insights']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Frame the pain points as "How Might We" (HMW) questions to generate specific product features for the roadmap.', true),
    (v_q_id, 'B', 'Start mapping the journey of a different persona to get more data.', false),
    (v_q_id, 'C', 'Immediately delete 50% of the features in the app to reduce overwhelm.', false),
    (v_q_id, 'D', 'Tell leadership that journey maps are strictly for building empathy, not for taking action.', false);

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
        'Airbnb''s Journey Map vs Service Blueprint',
        E'Airbnb''s PM is investigating why "Instant Book" properties sometimes double-book. The user journey map shows the guest clicking "Book" and receiving an error. Why is the user journey map insufficient for solving this specific problem?',
        'advanced',
        'Airbnb',
        'Booking infrastructure',
        'B',
        E'A user journey map strictly focuses on the front-stage user experience (what the user sees and feels). When diagnosing complex technical or operational failures (like double-booking via async calendar syncs), a Service Blueprint is required to expose the invisible "back-stage" systems, data flows, and API integrations.',
        ARRAY['service_blueprint', 'back_stage', 'system_mapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Journey maps don''t show the emotional state of the host, who is the real victim.', false),
    (v_q_id, 'B', 'This is a systemic operational failure requiring a Service Blueprint to map the backend database locks, third-party calendar syncs, and background APIs.', true),
    (v_q_id, 'C', 'The journey map was likely created for the wrong persona.', false),
    (v_q_id, 'D', 'Journey maps cannot mathematically include error states or drop-offs.', false);

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
        'Uber''s Synthesizing Conflicting Journeys',
        E'Uber''s PM is mapping the "Surge Pricing" moment. The rider''s journey map shows a severe emotional low (frustration). The driver''s journey map shows a sharp emotional high (excitement). How should the PM handle this inherent conflict in product strategy?',
        'advanced',
        'Uber',
        'Marketplace pricing dynamics',
        'C',
        E'In two-sided marketplaces, one persona''s pain is often the other''s gain. By mapping both and overlaying them, the PM identifies the zero-sum tension. This insight drives product strategy—not to average the emotions, but to design features that justify the friction to the rider (transparency) while maintaining the incentive for the driver.',
        ARRAY['marketplace_journeys', 'zero_sum', 'multi_actor']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Average the two emotions out to a "neutral" state on a combined master map.', false),
    (v_q_id, 'B', 'Ignore the driver''s emotion, as the rider is the one paying the money.', false),
    (v_q_id, 'C', 'Recognize this as a "Zero-Sum Touchpoint" and use the dual maps to design a balancing mechanism (e.g., explaining the value to the rider while rewarding the driver).', true),
    (v_q_id, 'D', 'Eliminate surge pricing entirely to keep the rider map strictly positive.', false);

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
        'Netflix''s Mapping Algorithmic Journeys',
        E'Netflix''s PM is mapping the personalized homepage experience. Because the UI changes entirely based on a machine learning model, every user''s path is unique. How do you map a purely algorithmic journey?',
        'advanced',
        'Netflix',
        'Machine learning personalization',
        'B',
        E'For highly personalized, algorithmic products, mapping specific UI paths is futile. Instead, PMs map behavioral archetypes (how different types of users react to recommendations) and parallel it with the system''s learning loop (how user actions feed data back to improve the next touchpoint).',
        ARRAY['algorithmic_journeys', 'personalization', 'behavioral_archetypes']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Map the static layout of the page, ignoring the dynamic content entirely.', false),
    (v_q_id, 'B', 'Map the "System Journey" (how the algorithm learns) alongside a generalized user journey based on behavioral archetypes.', true),
    (v_q_id, 'C', 'It is impossible to map ML-driven interfaces; rely solely on multivariate A/B testing.', false),
    (v_q_id, 'D', 'Create 100 different maps for 100 randomly sampled users.', false);

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
        'DoorDash''s Designing for ''Failure Demand''',
        E'DoorDash''s PM notices a high volume of users traversing the "Contact Support" journey path to report missing items. This path is mapped in great detail and is highly optimized. What strategic realization should the PM make from this map?',
        'advanced',
        'DoorDash',
        'Support and operations',
        'B',
        E'"Failure demand" is demand for a service caused by a failure to do something right for the customer in the first place. Advanced PMs recognize that smoothing out an error recovery journey is secondary to eliminating the root cause upstream. A highly optimized support journey is still a net-negative user experience.',
        ARRAY['failure_demand', 'error_recovery', 'root_cause']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They need to optimize the support chat UI further to make the interaction even faster.', false),
    (v_q_id, 'B', 'This entire journey path represents "Failure Demand"; the primary goal should be eliminating the need for it by fixing upstream restaurant operations.', true),
    (v_q_id, 'C', 'They should monetize this path by charging users for a premium support tier.', false),
    (v_q_id, 'D', 'The map is successful because users are completing the support flow without dropping off.', false);

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
        'Spotify''s Macro vs Micro Journeys',
        E'Spotify''s PM is building a map covering a user''s entire 5-year subscription lifetime (Macro). They also have a detailed map for creating a single playlist (Micro). What is the critical strategic linkage between these two maps?',
        'advanced',
        'Spotify',
        'Lifetime value and retention',
        'B',
        E'Macro and micro journeys operate on different time scales but are fundamentally linked. Micro-journeys represent the specific, repeated actions (core loops) that generate value. The successful, repeated execution of these micro-journeys is what propels the user forward through the long-term macro journey (e.g., preventing churn).',
        ARRAY['macro_journey', 'micro_journey', 'core_loops']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The playlist map must physically fit inside the 5-year map document for formatting purposes.', false),
    (v_q_id, 'B', 'The micro journey (playlist creation) is a core loop that, when completed successfully and repeatedly, drives the "Retention" phase of the macro journey.', true),
    (v_q_id, 'C', 'There is no strategic linkage; they are used by completely different, siloed teams.', false),
    (v_q_id, 'D', 'The macro journey determines the UI color palette of the micro journey.', false);

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
        'Shopify''s Mapping API Journeys',
        E'Shopify''s PM is mapping the journey of a Developer building a custom public app. The touchpoints aren''t UI screens, but API endpoints, webhooks, and rate limits. What is the equivalent of an "emotional low point" in this technical journey map?',
        'advanced',
        'Shopify',
        'Developer experience (DX)',
        'B',
        E'API products have journeys too. The "user" is a developer, and the "UI" is the API response and documentation. Emotional low points occur when the system acts unpredictably or unhelpfully—such as cryptic 500 errors, hidden rate limits, or poor deprecation warnings. Empathy applies to technical users just as much as consumers.',
        ARRAY['developer_journey', 'api_design', 'technical_personas']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'When the developer has to read any form of documentation.', false),
    (v_q_id, 'B', 'Encounters with opaque error codes, rate limit throttles without headers, or deprecation warnings without migration paths.', true),
    (v_q_id, 'C', 'When the API returns a standard 200 OK response too quickly.', false),
    (v_q_id, 'D', 'When the developer chooses to use Postman instead of curl.', false);

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
        'Amazon''s Mapping Circular Journeys',
        E'Amazon''s PM maps the "Subscribe & Save" feature. Unlike a standard e-commerce funnel, this journey has no distinct "end". How should the map be structurally adapted to reflect this?',
        'advanced',
        'Amazon',
        'Subscription e-commerce',
        'B',
        E'Subscription models create circular journeys, not linear funnels. The critical phase is the "Replenishment Trigger" (the automated renewal). The map must loop back on itself, highlighting the passive touchpoints (e.g., warning emails before shipping) that sustain the loop and prevent the user from actively breaking the cycle (churn).',
        ARRAY['circular_journeys', 'subscription_loops', 'retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As a straight line that artificially ends after exactly 12 months.', false),
    (v_q_id, 'B', 'As an infinite loop, explicitly mapping the "Replenishment Trigger" phase that automatically re-initiates the purchase cycle without user intervention.', true),
    (v_q_id, 'C', 'By mapping only the first purchase and ignoring all subsequent automated deliveries.', false),
    (v_q_id, 'D', 'By creating a Service Blueprint instead, as circular journeys cannot be mapped.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for journey-mapping';

END $$;
