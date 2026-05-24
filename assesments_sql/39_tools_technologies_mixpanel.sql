-- ============================================
-- ASSESSMENT: Mixpanel
-- CATEGORY: Tools & Technologies
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
    WHERE slug = 'mixpanel';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug mixpanel not found. Run the seed data first.';
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
        'Notion''s User Properties',
        E'Notion''s PM wants to track whether a user is on the "Free", "Plus", or "Enterprise" plan. This plan changes rarely, but the PM wants to filter ANY product event (like "Page Created") by the user''s current plan at the time of analysis.\n\nWhat is the most efficient way to track this in Mixpanel?',
        'foundational',
        'Notion',
        'Workspace collaboration',
        'C',
        'User Profile Properties are the correct choice because they store the current state of a user. Once a property like "Plan = Plus" is set on a user''s profile, Mixpanel automatically allows you to filter or break down any event performed by that user by their current profile properties. Option A creates unnecessary event volume. Option B requires engineering overhead to append it to every event manually, which is inefficient. Option D is an analytical grouping, not a tracking implementation.',
        ARRAY['event_tracking', 'user_properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fire a ''Plan Changed'' event every time the user logs in.', false),
    (v_q_id, 'B', 'Add ''Plan'' as an Event Property to every single event in the tracking plan.', false),
    (v_q_id, 'C', 'Store ''Plan'' as a User Profile Property.', true),
    (v_q_id, 'D', 'Create a Behavioral Cohort for each plan based on historical billing events.', false);

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
        'Uber''s Super Properties',
        E'Uber''s PM wants to ensure that every single event fired from the mobile app (e.g., ''Ride Requested'', ''Driver Rated'') automatically includes the operating system (''iOS'' or ''Android''). The PM wants to implement this without requiring engineers to manually append the OS to every individual event call.\n\nWhich Mixpanel feature should the PM use?',
        'foundational',
        'Uber',
        'Ride-hailing app',
        'B',
        'Super Properties are properties that you register once in the SDK, and Mixpanel automatically attaches them to every subsequent event tracked by that user on that device. This is the industry standard for tracking persistent contextual data like OS, App Version, or device type. User Profile Properties (Option A) only update the profile, not the individual event rows. Lexicon (Option D) is for data dictionary management, not data collection.',
        ARRAY['event_tracking', 'super_properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'User Profile Properties', false),
    (v_q_id, 'B', 'Super Properties', true),
    (v_q_id, 'C', 'Lookup Tables', false),
    (v_q_id, 'D', 'Lexicon Data Dictionary', false);

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
        'Airbnb''s Funnel Calculation',
        E'Airbnb''s PM is building a funnel in Mixpanel for the booking flow:\n\n| Step | Measurement | Value |\n|------|-------------|-------|\n| 1. Search | Totals | 10,000 |\n| 2. View Listing | Totals | 15,000 |\n| 3. Book | Totals | 2,000 |\n\nThe PM notices the conversion rate from Step 1 to Step 2 is >100%. What is the most likely reason for this impossible funnel conversion rate?',
        'foundational',
        'Airbnb',
        'Travel marketplace',
        'C',
        'Mixpanel funnels should typically be calculated using "Unique Users" to track conversion accurately. If the PM selects "Totals" (total event count) instead of "Uniques", a user who performs 1 Search and then clicks on 5 different Listings will generate 1 Step 1 event and 5 Step 2 events, pushing the step-to-step count over 100%. A proper funnel measures the percentage of unique individuals who progress through the steps.',
        ARRAY['funnels', 'reports', 'analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users are firing the ''View Listing'' event without ever firing the ''Search'' event.', false),
    (v_q_id, 'B', 'Mixpanel is counting users across multiple devices without resolving their identity.', false),
    (v_q_id, 'C', 'The PM selected ''Totals'' instead of ''Uniques'' for the funnel calculation.', true),
    (v_q_id, 'D', 'The funnel is set to ''Any Order'' instead of ''Sequential''.', false);

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
        'Duolingo''s DAU Calculation',
        E'Duolingo''s PM wants to track Daily Active Users (DAU) in Mixpanel''s Insights report. The company defines an "active user" strictly as someone who completes at least one lesson, not just someone who opens the app.\n\nHow should the PM configure the Insights report to accurately reflect DAU?',
        'foundational',
        'Duolingo',
        'Language learning app',
        'B',
        'To calculate Daily Active Users based on a specific action, you must select the defining event (''Lesson Completed'') and measure the "Unique" count. This ensures that a user who completes 5 lessons in one day is only counted as 1 Active User for that day. Measuring "Total" (Option A) would give you total lessons completed, not users. Selecting ''App Open'' (Option C) violates the company''s specific definition of an active user.',
        ARRAY['insights', 'reports', 'kpis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Select the ''Lesson Completed'' event and set the measurement to ''Total''.', false),
    (v_q_id, 'B', 'Select the ''Lesson Completed'' event and set the measurement to ''Unique''.', true),
    (v_q_id, 'C', 'Select the ''App Open'' event and filter by users who have a ''Streak'' > 0.', false),
    (v_q_id, 'D', 'Select ''All Events'' and set the measurement to ''Unique''.', false);

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
        'Discord''s N-Day Retention',
        E'Discord''s PM is analyzing an N-Day Retention report where the Starting Event is ''Server Joined'' and the Return Event is ''Message Sent''. The PM sees the following:\n\n| Day | Retention % |\n|-----|-------------|\n| 0 | 100% |\n| 1 | 40% |\n| 7 | 15% |\n\nWhat does the 15% on Day 7 specifically mean in Mixpanel''s default N-Day retention?',
        'foundational',
        'Discord',
        'Community chat app',
        'B',
        'In Mixpanel, standard "N-Day Retention" means the user performed the return event strictly *on* that specific time increment (Day 7). It does not mean they did it every day leading up to Day 7 (Option C), nor does it mean they did it at any point within the first 7 days (Option D—that would be Unbounded Retention). Option A is wrong because it specifies their *first* message, whereas retention just cares if the event occurred at all on that day.',
        ARRAY['retention', 'reports', 'analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '15% of users who joined a server sent their very first message exactly 7 days later.', false),
    (v_q_id, 'B', '15% of users who joined a server sent at least one message specifically on the 7th day after joining.', true),
    (v_q_id, 'C', '15% of users who joined a server have sent a message every single day for 7 days.', false),
    (v_q_id, 'D', '15% of users who joined a server sent a message at any point within the first 7 days.', false);

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
        'Canva''s User Paths',
        E'Canva''s PM wants to know exactly what users do immediately after they click the ''Download Design'' button. The PM does not know what the common next steps are and wants Mixpanel to reveal the most frequent sequence of events.\n\nWhich Mixpanel report is specifically designed to answer this question?',
        'foundational',
        'Canva',
        'Design software',
        'C',
        'The Flows report in Mixpanel is designed specifically to visualize the sequence of events users take after (or before) a specific event. It generates a Sankey diagram showing the most common paths. Funnels (Option A) require you to pre-define the exact steps you want to measure. Insights (Option B) is for graphing metrics over time. Impact (Option D) is for measuring causal relationships between a feature launch and a metric.',
        ARRAY['flows', 'reports', 'user_journey']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Funnels', false),
    (v_q_id, 'B', 'Insights', false),
    (v_q_id, 'C', 'Flows', true),
    (v_q_id, 'D', 'Impact', false);

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
        'Robinhood''s Power Users',
        E'Robinhood''s PM wants to send a targeted push notification campaign to "Power Traders"—defined as users who have completed more than 10 trades in the last 30 days.\n\nHow can the PM dynamically create and maintain this list of users in Mixpanel to sync with their messaging tool?',
        'foundational',
        'Robinhood',
        'Stock trading app',
        'B',
        'Behavioral Cohorts in Mixpanel allow you to group users dynamically based on actions they have taken (e.g., performed ''Trade Completed'' > 10 times in the last 30 days). This cohort updates automatically as users qualify or disqualify, making it perfect for syncing to messaging tools via integrations. Creating a 10-step funnel (Option A) is tedious and meant for sequence analysis. Super Properties (Option D) are set on the device side, not calculated dynamically from historical events.',
        ARRAY['cohorts', 'segmentation', 'integrations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a Funnel with 10 identical ''Trade Completed'' steps.', false),
    (v_q_id, 'B', 'Build a Behavioral Cohort where ''Trade Completed'' > 10 in the last 30 days.', true),
    (v_q_id, 'C', 'Use the Flows report to find paths containing 10 trades.', false),
    (v_q_id, 'D', 'Set a Super Property called ''Is_Power_Trader'' to true.', false);

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
        'DoorDash''s Event Context',
        E'DoorDash''s PM is tracking an ''Order Placed'' event. They want to be able to segment these orders by ''Restaurant Category'' (e.g., Thai, Mexican, Italian) in Mixpanel to see which cuisines are most popular on weekends.\n\nWhere is the correct place to store the ''Restaurant Category'' data?',
        'foundational',
        'DoorDash',
        'Food delivery',
        'B',
        'Contextual data specific to an individual action should always be stored as an Event Property attached directly to that event. If you stored it as a User Profile Property (Option A), it would constantly overwrite every time the user ordered a different cuisine, erasing historical context. Super properties (Option C) apply to all events, which doesn''t make sense for a specific order. Custom Events (Option D) are for combining events in Lexicon, not storing data.',
        ARRAY['event_tracking', 'data_modeling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As a User Profile Property.', false),
    (v_q_id, 'B', 'As an Event Property on the ''Order Placed'' event.', true),
    (v_q_id, 'C', 'As a Super Property.', false),
    (v_q_id, 'D', 'As a Custom Event in Lexicon.', false);

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
        'Stripe''s Identity Resolution',
        E'Stripe''s PM is setting up Mixpanel. They notice that a single user visiting the marketing site on Chrome (generating an anonymous ID), then logging into the dashboard on Safari, is being counted as two completely separate users in reports.\n\nWhat Mixpanel SDK method must the engineers call upon login to connect the user''s known database ID to their current session?',
        'foundational',
        'Stripe',
        'Payment processor',
        'B',
        'The `mixpanel.identify()` method is crucial for identity management. When a user logs in, calling `identify(USER_ID)` tells Mixpanel to associate the current device''s local, anonymous Distinct ID with the user''s permanent backend ID. Without this, cross-device usage or anonymous-to-authenticated transitions result in fragmented, duplicated user profiles. `mixpanel.track()` (Option D) just sends an event, while `mixpanel.people.set()` (Option C) updates profile properties.',
        ARRAY['identity_management', 'implementation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'mixpanel.group()', false),
    (v_q_id, 'B', 'mixpanel.identify()', true),
    (v_q_id, 'C', 'mixpanel.people.set()', false),
    (v_q_id, 'D', 'mixpanel.track()', false);

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
        'Figma''s Event Consolidation',
        E'Figma''s PM notices that the engineering team accidentally implemented an event as `file_exported` on the iOS app and `File Exported` on the Android app. \n\nTo fix this in Mixpanel moving forward AND historically, without requiring a massive engineering data migration, what is the best approach?',
        'foundational',
        'Figma',
        'Design tool',
        'A',
        'Mixpanel Lexicon allows PMs to create a "Custom Event" that acts as a virtual wrapper around multiple underlying events. By creating a Custom Event called "File Exported (All)" that includes both `file_exported` and `File Exported`, the PM instantly fixes the data in the UI retroactively without touching any code or APIs. Asking engineering to rewrite historical data (Option B) is expensive, slow, and prone to error.',
        ARRAY['lexicon', 'data_governance', 'custom_events']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use Mixpanel Lexicon to merge the two events into a single Custom Event.', true),
    (v_q_id, 'B', 'Ask engineering to write a script to rewrite all historical data via the Mixpanel API.', false),
    (v_q_id, 'C', 'Create a new event, and delete the old ones to prevent UI confusion.', false),
    (v_q_id, 'D', 'Change the Super Property mapping in the project settings.', false);

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
        'Netflix''s Strict Funnels',
        E'Netflix''s PM creates a funnel: ''Start Episode'' -> ''Finish Episode''. The overall conversion rate is 85%. However, the PM realizes a user might start Episode 1, get bored, and immediately watch and finish a 2-minute recap video of a different show. This scenario is falsely inflating the funnel completion rate.\n\nHow can the PM fix this funnel to ensure the user finished the *exact same* episode they started?',
        'intermediate',
        'Netflix',
        'Streaming service',
        'B',
        'Mixpanel funnels have a feature called "Hold property constant". By applying this to the `episode_id` event property, Mixpanel guarantees that a user only converts if the `episode_id` on the ''Finish Episode'' event exactly matches the `episode_id` from the ''Start Episode'' event. Strict Sequence (Option A) only enforces event order, not property matching. Decreasing the time window (Option C) does not solve the logical flaw.',
        ARRAY['funnels', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the funnel order to ''Strict Sequence''.', false),
    (v_q_id, 'B', 'Use the ''Hold property constant'' feature on the `episode_id` property.', true),
    (v_q_id, 'C', 'Decrease the funnel conversion time window to 1 hour.', false),
    (v_q_id, 'D', 'Create a Behavioral Cohort of users who watched both.', false);

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
        'Shopify''s Custom Formulas',
        E'Shopify''s PM wants to chart the Average Order Value (AOV) over time. They track an ''Order Completed'' event which contains a numeric event property called `revenue`.\n\nHow can the PM chart the AOV directly in a Mixpanel Insights report?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'A',
        'Mixpanel Insights natively supports calculating the Average, Sum, Min, Max, or Percentiles of any numeric event property. By selecting the ''Order Completed'' event and changing the measurement from ''Total'' (event count) to ''Average'' of the `revenue` property, the PM gets AOV instantly. While Mixpanel has custom formulas (like dividing Total Revenue by Total Events), simply selecting ''Average'' on the property is the most direct native method. Option D is incorrect as Mixpanel easily handles this.',
        ARRAY['insights', 'formulas', 'metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Select the ''Order Completed'' event, and set the measurement to ''Average'' on the `revenue` property.', true),
    (v_q_id, 'B', 'Select ''Order Completed'', measure ''Total'' `revenue`, and use the ''Breakdown'' feature by ''User''.', false),
    (v_q_id, 'C', 'Use the Flows report to average the values between ''Checkout Started'' and ''Order Completed''.', false),
    (v_q_id, 'D', 'Mixpanel Insights cannot calculate averages; the data must be exported to a data warehouse.', false);

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
        'Slack''s Tracking Trade-offs',
        E'Slack''s PM wants to analyze how many messages a user sends per week over time to spot seasonal trends. \n\nAn engineer suggests: "Instead of firing an event every time a message is sent, let''s just increment a `total_messages_sent` User Profile Property. It''ll save millions of events per day."\n\nWhy must the PM reject this suggestion based on Mixpanel''s architecture?',
        'intermediate',
        'Slack',
        'Workplace messaging',
        'C',
        'User Profile Properties in Mixpanel store only the *current* state of the user. If you just increment a counter, you know the total messages sent over their lifetime, but you have no time-series data. You cannot graph "Messages sent in Week 1 vs Week 2" in an Insights report because the historical timestamps aren''t recorded. To analyze trends over time, you must track immutable Events. Mixpanel does support incrementing numeric properties natively (making Option D wrong), but it ruins temporal analysis.',
        ARRAY['data_modeling', 'event_tracking', 'user_properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'User Profile Properties cannot store numeric values.', false),
    (v_q_id, 'B', 'Incrementing profile properties costs more Mixpanel credits than firing events.', false),
    (v_q_id, 'C', 'User Profile Properties only show current state, making it impossible to analyze weekly trends over time.', true),
    (v_q_id, 'D', 'Mixpanel doesn''t support incrementing profile properties automatically.', false);

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
        'Zoom''s Anonymous Aliasing',
        E'A user visits Zoom anonymously and creates a test meeting (Mixpanel assigns Distinct ID: `anon_123`). The user then clicks "Sign Up" and creates a real account (Database ID: `User_99`).\n\nTo ensure the initial anonymous behavior is permanently stitched to the new authenticated user profile, what exact method should the engineering team call immediately upon sign-up?',
        'intermediate',
        'Zoom',
        'Video conferencing',
        'B',
        'The `mixpanel.alias()` method is specifically designed for the moment of registration. It tells Mixpanel: "Take the anonymous ID (`anon_123`) and map it permanently to this new known ID (`User_99`)." From that point forward, calling `identify(''User_99'')` on subsequent logins will pull up the complete history. If you just called `identify()` at signup without `alias()`, the anonymous pre-signup events would remain orphaned under `anon_123`.',
        ARRAY['identity_management', 'implementation', 'alias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'mixpanel.identify(''User_99'')', false),
    (v_q_id, 'B', 'mixpanel.alias(''User_99'', ''anon_123'')', true),
    (v_q_id, 'C', 'mixpanel.people.set({''id'': ''User_99''})', false),
    (v_q_id, 'D', 'mixpanel.group(''Company'', ''User_99'')', false);

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
        'TikTok''s Retention Metrics',
        E'TikTok''s PM is analyzing retention. Because TikTok is a habit-forming app, users open it multiple times a week. The PM sees the following:\n\n| Day | N-Day Retention | Unbounded Retention |\n|-----|-----------------|---------------------|\n| 7   | 12%             | 35%                 |\n| 14  | 8%              | 28%                 |\n\nWhat does the 35% Unbounded Retention on Day 7 signify?',
        'intermediate',
        'TikTok',
        'Short-form video',
        'C',
        'Unbounded Retention (also known as rolling retention) measures the percentage of users who return *on or after* a specific day. A 35% unbounded retention on Day 7 means that 35% of the original cohort came back on Day 7, Day 8, Day 14, or any day after. It effectively measures the inverse of churn. It answers: "What percentage of users haven''t completely abandoned the app by Day 7?"',
        ARRAY['retention', 'metrics', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '35% of users came back every single day for the first 7 days.', false),
    (v_q_id, 'B', '35% of users had an active session lasting longer than 7 minutes.', false),
    (v_q_id, 'C', '35% of users returned on Day 7 or any day after Day 7.', true),
    (v_q_id, 'D', '35% of users performed the return event strictly on Day 7.', false);

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
        'Pinterest''s Flow Loops',
        E'Pinterest''s PM is looking at a Flows report starting from ''Pin Expanded''. They notice the most common path is an endless loop:\n''Pin Expanded'' -> ''Related Pin Clicked'' -> ''Pin Expanded'' -> ''Related Pin Clicked''...\n\nThe PM wants to see where users actually navigate *outside* of this core loop. What is the best feature in the Flows report to reveal this?',
        'intermediate',
        'Pinterest',
        'Visual discovery engine',
        'A',
        'Mixpanel''s Flows report allows you to "Hide" specific events from the visualization. By hiding the ''Related Pin Clicked'' event, the Flow will seamlessly bridge the gap and show the *next* different action the user took (e.g., ''Board Created'' or ''Checkout Started''). This is the standard way to remove noisy loops or redundant navigation events from path analysis. Changing to ''Steps preceding'' (Option B) just looks backward, keeping the loop.',
        ARRAY['flows', 'user_journey']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Hide the ''Related Pin Clicked'' event from the flow.', true),
    (v_q_id, 'B', 'Change the flow from ''Steps following'' to ''Steps preceding''.', false),
    (v_q_id, 'C', 'Expand the flow to 20 steps to see where the loop naturally ends.', false),
    (v_q_id, 'D', 'Switch to a Funnel report instead.', false);

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
        'Etsy''s Custom Events',
        E'Etsy''s PM realizes that users can add items to their cart via two distinct tracking events: ''Add to Cart'' (from the product page) and ''Quick Add'' (from search results). \n\nThe PM wants to use "Any Add to Cart" as a single unified metric in Funnels and Insights without relying on engineers to update the tracking code. What should the PM do?',
        'intermediate',
        'Etsy',
        'Handmade e-commerce',
        'B',
        'Creating a Custom Event in Mixpanel Lexicon allows you to logically group multiple underlying events (e.g., ''Add to Cart'' OR ''Quick Add'') into a single, reusable event called "Any Add to Cart". Once created, this Custom Event behaves exactly like a raw event in Funnels, Insights, and Retention reports. A formula (Option A) only works in Insights, not Funnels. Super Properties (Option C) are for context, not event grouping.',
        ARRAY['lexicon', 'custom_events', 'data_governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use a Formula in Insights to add the two events together (A + B).', false),
    (v_q_id, 'B', 'Create a Custom Event in Lexicon that includes both ''Add to Cart'' and ''Quick Add''.', true),
    (v_q_id, 'C', 'Create a Super Property called ''Added_To_Cart''.', false),
    (v_q_id, 'D', 'Use a Behavioral Cohort of users who performed either event.', false);

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
        'Tinder''s Funnel Exclusions',
        E'Tinder''s PM is analyzing a funnel: ''Profile Liked'' (Step 1) -> ''Match Created'' (Step 2) -> ''Message Sent'' (Step 3). \n\n| User | Step 1 (Like) | Middle Event | Step 2 (Match) | Step 3 (Message) |\n|------|---------------|--------------|----------------|------------------|\n| U1 | Yes | - | Yes | Yes |\n| U2 | Yes | Unmatch | Yes | No |\n\nThe PM wants to evaluate the messaging conversion rate, but specifically wants to filter out users who fired the ''Unmatch'' event at any point between Step 2 and Step 3. How can the PM configure this?',
        'intermediate',
        'Tinder',
        'Dating app',
        'A',
        'Mixpanel funnels have an "Exclusion Steps" feature, which allows you to define an event that will disqualify a user from the funnel if it occurs between specific steps. By setting ''Unmatch'' as an exclusion step between Step 2 and Step 3, User 2 will be dropped from the funnel calculation. Filtering by a User Property (Option B) wouldn''t work dynamically based on the timestamp of the steps.',
        ARRAY['funnels', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add an ''Exclusion Step'' in the funnel for the ''Unmatch'' event between Step 2 and Step 3.', true),
    (v_q_id, 'B', 'Filter the entire funnel by the User Property `is_unmatched = false`.', false),
    (v_q_id, 'C', 'Use the ''Hold property constant'' feature on the `match_id`.', false),
    (v_q_id, 'D', 'Create a cohort of users who did not unmatch, and use that cohort as Step 1.', false);

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
        'GitHub''s Predictive AI',
        E'GitHub''s Growth PM wants to offer a targeted discount to free users who are highly likely to upgrade to a paid Copilot subscription in the next 30 days. The PM doesn''t want to manually guess which behaviors indicate intent.\n\nWhich Mixpanel feature is explicitly designed to identify these users automatically using machine learning models?',
        'intermediate',
        'GitHub',
        'Developer platform',
        'C',
        'Predictive Cohorts use Mixpanel''s built-in machine learning to predict the likelihood of users performing a specific action (like ''Upgrade'') in the future based on their past behavioral patterns. The PM can simply select the target event, and Mixpanel generates cohorts of "High", "Medium", and "Low" likelihood users. The Signal report (Option A) finds correlations, but doesn''t automatically generate predictive user groupings for targeting.',
        ARRAY['cohorts', 'predictive_analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Signal Report', false),
    (v_q_id, 'B', 'Behavioral Cohorts', false),
    (v_q_id, 'C', 'Predictive Cohorts', true),
    (v_q_id, 'D', 'Impact Report', false);

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
        'Vercel''s B2B Tracking',
        E'Vercel''s PM is analyzing product usage. Because Vercel is a B2B SaaS product, multiple developers belong to a single "Workspace" (the paying customer). The PM wants to ask: "How many *Workspaces* deployed a project last week?" rather than how many individual users did.\n\nWhich Mixpanel feature natively enables this B2B account-level analysis?',
        'intermediate',
        'Vercel',
        'Cloud hosting',
        'C',
        'Group Analytics is a premium Mixpanel feature designed specifically for B2B companies. It allows you to analyze data at the account/company level (e.g., Workspace, Organization) instead of the user level. When Group Analytics is configured, you can view Funnels, Insights, and Retention where the counting unit is the Group rather than the Distinct ID. User Profiles (Option A) only allow filtering individuals by a workspace string, not counting unique workspaces.',
        ARRAY['group_analytics', 'b2b_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'User Profiles with a ''Workspace'' property.', false),
    (v_q_id, 'B', 'Super Properties.', false),
    (v_q_id, 'C', 'Group Analytics.', true),
    (v_q_id, 'D', 'Custom Events grouping users by domain name.', false);

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
        'Reddit''s Breakdown Limits',
        E'Reddit''s PM is looking at an Insights report for the ''Upvote'' event and breaks it down by the event property `subreddit_name`. \n\nBecause there are millions of subreddits, Mixpanel only displays the top 10,000 subreddits and groups the remaining millions into a bucket labeled "Other". What is the technical term for a property like `subreddit_name` that has an massive number of unique values?',
        'intermediate',
        'Reddit',
        'Social news aggregator',
        'A',
        'A "High Cardinality Property" is a data engineering term for a field that contains a very large number of unique values (e.g., user IDs, URLs, search queries, or millions of subreddit names). Analytics tools like Mixpanel often struggle to visualize high cardinality breakdowns due to performance limits, which is why they group long-tail results into an "Other" bucket. "Sparse Matrix" (Option D) refers to missing data, not unique values.',
        ARRAY['insights', 'data_modeling', 'reports']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High Cardinality Property', true),
    (v_q_id, 'B', 'Super Property', false),
    (v_q_id, 'C', 'Unbounded Property', false),
    (v_q_id, 'D', 'Sparse Matrix Property', false);

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
        'Dropbox''s Lexicon Cleanup',
        E'Dropbox''s PM notices that an engineer accidentally left a debugging event called `test_click_xyz123` in the production tracking plan. It fired millions of times and is now clogging up the event dropdown menus for every PM using Mixpanel.\n\nThe engineer has pushed an update to stop the event from firing. What is the fastest and safest way for the PM to clean up the Mixpanel UI right now?',
        'intermediate',
        'Dropbox',
        'Cloud storage',
        'B',
        'Hiding the event in Mixpanel Lexicon is the standard way to remove deprecated, noisy, or erroneous events from the UI without permanently destroying data. Hiding an event removes it from all dropdown menus and autocomplete suggestions for all users in the project. Deleting historical data (Option A) is dangerous, irreversible, and unnecessary for simple UI cleanup.',
        ARRAY['lexicon', 'data_governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delete all historical data for `test_click_xyz123` using the Mixpanel Data Deletion API.', false),
    (v_q_id, 'B', 'Hide the event in Mixpanel Lexicon so it stops showing up in the UI dropdowns.', true),
    (v_q_id, 'C', 'Rename the event to a Custom Event.', false),
    (v_q_id, 'D', 'Ban the IP addresses of the test devices.', false);

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
        'Salesforce''s Attribution Tracking',
        E'Salesforce''s PM wants to track the *very first* UTM source (e.g., ''utm_source=Google'') a user ever clicked to arrive at the site, and append it to every subsequent event they perform forever, to accurately calculate First-Touch Attribution.\n\nWhich Mixpanel SDK method should the engineering team use to ensure this initial UTM source is never accidentally overwritten by future visits from different sources?',
        'intermediate',
        'Salesforce',
        'B2B CRM software',
        'B',
        'The `mixpanel.register_super_properties_once()` method stores a super property locally but ensures that it will NEVER overwrite an existing value if the property is already set. This is exactly how you implement First-Touch attribution. If they used `register_super_properties()` (Option A), the value would be overwritten every time the user clicked a new ad, effectively changing it to Last-Touch attribution.',
        ARRAY['event_tracking', 'super_properties', 'implementation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'mixpanel.register_super_properties()', false),
    (v_q_id, 'B', 'mixpanel.register_super_properties_once()', true),
    (v_q_id, 'C', 'mixpanel.people.set()', false),
    (v_q_id, 'D', 'mixpanel.identify()', false);

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
        'HubSpot''s Time to Convert',
        E'HubSpot''s PM is analyzing an onboarding funnel: ''Account Created'' -> ''Contact Imported'' -> ''Campaign Launched''. \n\n| Percentile | Time to Complete |\n|------------|------------------|\n| 25th | 2 days |\n| 50th (Median)| 4 days |\n| 90th | 12 days |\n\nThe PM wants to view this exact median conversion time breakdown. Where in Mixpanel can the PM natively find this data?',
        'intermediate',
        'HubSpot',
        'Marketing automation',
        'B',
        'The Funnels report in Mixpanel has a built-in visualization specifically called "Time to Convert." When you toggle to this view, Mixpanel automatically calculates the distribution of time it took users to get from Step 1 to the final step, showing you a histogram along with the median, average, and percentiles. You do not need to use custom formulas (Option D) or the Flows report (Option A) to get this data.',
        ARRAY['funnels', 'reports', 'metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'In the Flows report, looking at the path length.', false),
    (v_q_id, 'B', 'In the Funnels report, under the ''Time to Convert'' visualization.', true),
    (v_q_id, 'C', 'In the Retention report, using Unbounded retention.', false),
    (v_q_id, 'D', 'By creating a Formula in Insights subtracting timestamps.', false);

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
        'Atlassian''s Causal Lift',
        E'Atlassian''s PM launched a new ''Templates'' feature in Jira. The PM wants to know: "Did users who adopted Templates subsequently have higher weekly active days compared to similar users who didn''t use Templates?"\n\nWhich Mixpanel report is specifically built to measure this causal lift while attempting to control for baseline user differences?',
        'intermediate',
        'Atlassian',
        'Work management software',
        'C',
        'The Impact report in Mixpanel is designed for causal inference. It attempts to measure the true lift of a feature by comparing users who adopted the feature to a lookalike control group who did not, controlling for pre-feature baseline behavior. This helps answer "Did this feature cause retention to go up?" Signal (Option B) measures correlation, not causal impact. Cohorts (Option D) allow manual comparison, but don''t do the propensity matching automatically.',
        ARRAY['impact_report', 'reports', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Insights', false),
    (v_q_id, 'B', 'Signal', false),
    (v_q_id, 'C', 'Impact', true),
    (v_q_id, 'D', 'Cohorts', false);

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
        'Peloton''s Data Schema',
        E'Peloton''s PM is tired of bad data polluting Mixpanel (e.g., iOS sends `is_subscriber: "true"` as a string, while Android sends `is_subscriber: true` as a boolean). \n\nThe PM creates a formal Tracking Plan. How can the PM proactively enforce this plan within Mixpanel to catch bad data formatting before it ruins reporting?',
        'intermediate',
        'Peloton',
        'Connected fitness',
        'A',
        'Mixpanel Lexicon includes Data Types & Schema validation features. PMs can define the expected data type (e.g., Boolean, Numeric, String) for every property. Once enforced, if an SDK sends data that violates the schema, Mixpanel can flag the violation, drop the bad property, or reject the event entirely, keeping the project clean. Behavioral Cohorts (Option B) analyze data after it''s already ingested.',
        ARRAY['data_governance', 'lexicon', 'schema_validation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Enable Mixpanel Data Types & Schema validation in Lexicon, which flags or drops non-conforming data.', true),
    (v_q_id, 'B', 'Use a Behavioral Cohort to permanently filter out bad events.', false),
    (v_q_id, 'C', 'Write a SQL query in the Mixpanel Custom Query editor to cast data types nightly.', false),
    (v_q_id, 'D', 'Mixpanel automatically standardizes data types; the PM doesn''t need to do anything.', false);

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
        'Booking.com''s Data Smoothing',
        E'Booking.com''s PM is looking at an Insights report of ''Daily Bookings''. The data is highly cyclical, violently spiking on weekends and dropping every Tuesday, making it visually very hard to see if the overall underlying growth trend is positive.\n\nWhat built-in feature in Mixpanel Insights should the PM use to make the macro trend immediately clear?',
        'intermediate',
        'Booking.com',
        'Travel reservations',
        'B',
        'Applying a Rolling Average (Smoothing) in Mixpanel Insights takes the average of the trailing X days (e.g., 7-day rolling average) for each data point. This perfectly flattens out weekly cyclicality (like weekend spikes) and reveals the true underlying macro trend of the metric. Changing chart types (Option A) or breaking down by day (Option C) will not remove the visual noise of the cycle.',
        ARRAY['insights', 'reports', 'metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the chart type to a Stacked Bar chart.', false),
    (v_q_id, 'B', 'Apply a 7-day Rolling Average (Smoothing) to the metric.', true),
    (v_q_id, 'C', 'Break down the data by ''Day of Week''.', false),
    (v_q_id, 'D', 'Use a Custom Formula to divide bookings by 7.', false);

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
        'Twitter''s Aha Moment',
        E'Twitter/X''s PM is trying to find the platform''s "Aha! moment" (similar to Facebook''s famous "7 friends in 10 days" metric). The PM wants to identify which specific event, performed at what frequency, correlates most strongly with long-term 2nd-week retention.\n\nWhich Mixpanel report is explicitly designed to automatically calculate these correlations?',
        'intermediate',
        'Twitter',
        'Social media network',
        'C',
        'The Signal report is designed specifically to help PMs find their product''s "Aha! moment." It scans your event data to find which user actions (and at what frequency, like doing an event 3 times within 7 days) have the highest correlation with a goal event (like Week 2 Retention). It automatically calculates False Positive rates, False Negative rates, and Correlation scores. Impact (Option D) measures causal lift of a known feature, not exploratory correlation.',
        ARRAY['signal', 'reports', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Flows', false),
    (v_q_id, 'B', 'Retention', false),
    (v_q_id, 'C', 'Signal', true),
    (v_q_id, 'D', 'Impact', false);

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
        'LinkedIn''s Identity Merge API',
        E'A user applies for a job on LinkedIn anonymously on their phone (Distinct ID: `A`). Later, they create an account on their desktop (Distinct ID: `B`). Six months later, they log into that account on their phone.\n\nAssuming the engineers used Mixpanel''s modern ID Merge API, which statement correctly describes how Mixpanel handles their identity upon that final login?',
        'advanced',
        'LinkedIn',
        'Professional network',
        'B',
        'Mixpanel''s modern ID Merge system allows multiple distinct IDs to be clustered together retrospectively. When the user logs in on the phone (ID A) to the account created on the desktop (ID B), the `identify()` call tells Mixpanel that ID A and ID B are the same person. Mixpanel merges them into a single identity cluster, meaning all past anonymous phone events and desktop events are now correctly attributed to the same single user profile.',
        ARRAY['identity_management', 'id_merge', 'implementation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mixpanel will permanently delete the events tied to ID A to avoid duplication.', false),
    (v_q_id, 'B', 'Mixpanel will merge IDs A and B into a single cluster, retroactively connecting the anonymous mobile events to the desktop profile.', true),
    (v_q_id, 'C', 'Mixpanel cannot connect the devices unless the user explicitly enters an email address on the phone prior to logging in.', false),
    (v_q_id, 'D', 'Mixpanel will keep the events separate, but duplicate the User Profile properties across both IDs.', false);

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
        'Slack''s Group Analytics Mapping',
        E'Slack''s PM is using Mixpanel Group Analytics, tracking metrics by `workspace_id`. However, power users belong to 15 different workspaces. \n\nWhen a power user fires a ''Message Sent'' event inside Workspace #4, how must the tracking payload be configured so the event is attributed *only* to Workspace #4 in Group Analytics?',
        'advanced',
        'Slack',
        'Workplace messaging',
        'B',
        'In Mixpanel Group Analytics, if a user belongs to multiple groups (many-to-many relationship), you must pass the *specific* Group ID as an event property on the action itself. By passing `workspace_id: "4"` directly on the ''Message Sent'' event, Mixpanel knows to attribute that specific action to Workspace #4, even if the user profile lists 15 different workspaces. Passing an array of all IDs (Option A) would falsely attribute the message to all 15 workspaces.',
        ARRAY['group_analytics', 'data_modeling', 'implementation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The `workspace_id` must be passed as an array of all 15 IDs on the event; Mixpanel automatically sorts it out.', false),
    (v_q_id, 'B', 'The event must explicitly pass the single specific `workspace_id` where the message was sent as an event property.', true),
    (v_q_id, 'C', 'The PM must create 15 different user profiles for the user to separate the data.', false),
    (v_q_id, 'D', 'Mixpanel Group Analytics does not support users belonging to multiple groups.', false);

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
        'Amazon''s Object Arrays',
        E'Amazon''s PM is tracking an ''Order Completed'' event. An order contains multiple items. The engineers pass this data as a JSON array of objects within the event:\n\n```json\n"items": [\n  {"id": 1, "category": "electronics"},\n  {"id": 2, "category": "books"}\n]\n```\n\nTo properly filter and breakdown by nested properties (e.g., "Revenue from Electronics") in Mixpanel Insights, what must the PM ensure?',
        'advanced',
        'Amazon',
        'E-commerce',
        'B',
        'Mixpanel natively supports "Object Arrays" (also known as complex data types or nested JSON). When this feature is enabled, PMs can query, filter, and break down data based on properties *inside* an array of objects directly in the UI. You do not need to flatten the data into separate events (Option A), which would ruin the concept of a single "Order Completed" action.',
        ARRAY['event_tracking', 'data_modeling', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Flatten the array into separate events before sending, as Mixpanel cannot process JSON arrays.', false),
    (v_q_id, 'B', 'Ensure the project has ''Object Arrays'' enabled, allowing filtering by nested properties natively in the UI.', true),
    (v_q_id, 'C', 'Create a Custom Event for every possible product category.', false),
    (v_q_id, 'D', 'Use a Super Property to store the array globally across the session.', false);

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
        'Uber''s Step-Level Timeouts',
        E'Uber''s PM analyzes a funnel: ''Open App'' -> ''Request Ride'' -> ''Driver Arrives''.\n\n| Step | Overall Window | Step Timeout |\n|------|----------------|--------------|\n| Request->Arrive | 24 hours | 15 mins |\n\nThe overall funnel conversion window is 24 hours. However, if a driver takes more than 15 minutes to arrive after the request, the user experience is broken. How can the PM enforce this 15-minute limit without shrinking the 24-hour window for the whole funnel?',
        'advanced',
        'Uber',
        'Ride-hailing app',
        'B',
        'Mixpanel allows for "Step-level conversion windows" (or step timeouts). You can set the global funnel window to 24 hours, but apply a specific constraint that Step 2 -> Step 3 must happen within 15 minutes. This ensures that users who take 2 hours to decide to request a ride (Step 1 -> Step 2) stay in the funnel, but those whose drivers take 20 minutes to arrive (Step 2 -> Step 3) drop out.',
        ARRAY['funnels', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use the ''Time to Convert'' breakdown and manually filter out users over 15 minutes.', false),
    (v_q_id, 'B', 'Apply a step-level conversion window constraint between Step 2 and Step 3 in the funnel settings.', true),
    (v_q_id, 'C', 'Create a custom formula to subtract the timestamps of the two events.', false),
    (v_q_id, 'D', 'It is impossible; all steps in a Mixpanel funnel must share the global conversion window.', false);

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
        'Figma''s Reverse ETL Sync',
        E'Figma''s PM has built complex LTV and ML churn prediction models in Snowflake using historical data. The PM wants to bring these predictive scores back into Mixpanel as User Profile Properties so they can be used to build Behavioral Cohorts.\n\nWhat is the standard industry approach to achieve this data sync?',
        'advanced',
        'Figma',
        'Design tool',
        'B',
        'Reverse ETL tools (like Census, Hightouch, or Mixpanel''s native warehouse sync) are designed exactly for this. They query data from a data warehouse (Snowflake, BigQuery) and pipe it directly into operational tools like Mixpanel, updating User Profiles via the server-side API. Triggering events manually via Python (Option A) is inefficient. Front-end SDKs (Option C) shouldn''t handle heavy backend ML data logic.',
        ARRAY['integrations', 'reverse_etl', 'data_modeling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write a Python script to trigger Mixpanel events manually every hour.', false),
    (v_q_id, 'B', 'Use a Reverse ETL tool to sync data from Snowflake directly to Mixpanel''s user profiles.', true),
    (v_q_id, 'C', 'Ask engineers to pass the Snowflake data through the front-end Mixpanel JS SDK.', false),
    (v_q_id, 'D', 'Export all Mixpanel data to a CSV and manually merge it with the Snowflake data.', false);

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
        'Spotify''s Custom Bracket Retention',
        E'Spotify''s PM is analyzing retention for podcast listeners. Instead of knowing if a user returned exactly on Day 7, the PM wants to define custom intervals:\n\n| Bracket | Window |\n|---------|--------|\n| Week 1 | Day 1-7 |\n| Week 2 | Day 8-14 |\n\nThe PM wants to know if they returned *at least once* during these specific custom periods. Which report configuration is required?',
        'advanced',
        'Spotify',
        'Audio streaming',
        'C',
        'Bracket Retention allows PMs to define custom, non-uniform time windows (brackets) for retention analysis. Instead of strict 24-hour periods (N-Day) or infinite periods (Unbounded), Bracket Retention lets you measure if a user performed the return event at least once within your specifically defined boundary, such as Day 1-7, Day 8-14, and Day 15-30.',
        ARRAY['retention', 'advanced_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'N-Day Retention', false),
    (v_q_id, 'B', 'Unbounded Retention', false),
    (v_q_id, 'C', 'Bracket Retention', true),
    (v_q_id, 'D', 'Rolling Retention', false);

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
        'Airbnb''s Alias Anti-Pattern',
        E'Airbnb''s engineering team is implementing Mixpanel on a newly acquired platform. They decide to call `mixpanel.alias(new_id, old_id)` every single time a user logs in to "ensure IDs are always connected just in case."\n\nWhy is this a catastrophic implementation error in Mixpanel?',
        'advanced',
        'Airbnb',
        'Travel marketplace',
        'B',
        'The `alias` method is designed to be called exactly ONCE in a user''s lifecycle: at the moment of initial registration to connect their pre-signup anonymous ID to their new permanent backend ID. Calling it continuously on every login creates deep chains of aliases. Historically, Mixpanel strictly warned against this because complex alias chains break identity resolution, leading to disconnected profiles and permanently lost data. Normal logins should only use `identify()`.',
        ARRAY['identity_management', 'alias', 'implementation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '`alias` deletes all user profile properties every time it is called.', false),
    (v_q_id, 'B', '`alias` is meant to be called exactly once at signup; calling it continuously creates chains that break identity resolution.', true),
    (v_q_id, 'C', '`alias` costs 10x more Mixpanel credits than an `identify` call.', false),
    (v_q_id, 'D', '`alias` only works on mobile apps, and will crash web platforms.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Mixpanel';

END $$;
