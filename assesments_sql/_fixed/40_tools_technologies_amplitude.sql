-- ============================================
-- ASSESSMENT: Amplitude
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
    WHERE slug = 'amplitude';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug amplitude not found. Run the seed data first.';
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
        'Netflix''s Event Taxonomy',
        'Netflix''s PM wants to track when a user finishes watching a movie. Which of the following is the most scalable way to define this in Amplitude?',
        'foundational',
        'Netflix',
        'Streaming media platform',
        'B',
        'Option B is correct because passing the movie title as an Event Property keeps the taxonomy clean and highly scalable. Option A is a common anti-pattern that bloats the event dictionary, making it impossible to aggregate overall viewing behavior. Option C fails because User Properties are constantly overwritten, meaning you would lose the historical log. Option D relies on brittle, implicit logic rather than tracking a definitive action. A core PM principle of data governance is keeping event names broad and using properties to provide specific context.',
        ARRAY['event_taxonomy', 'event_properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create separate events for every movie, e.g., ''Watched_The_Matrix''.', false),
    (v_q_id, 'B', 'Create a single ''Movie_Finished'' event and pass the movie title as an Event Property.', true),
    (v_q_id, 'C', 'Set a User Property called ''Last_Watched_Movie'' and update it every time a movie ends.', false),
    (v_q_id, 'D', 'Create a ''Play_Button_Clicked'' event and assume the user finishes it if they do not click ''Pause''.', false);

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
        'Spotify''s User vs Event Properties',
        'Spotify''s PM is analyzing playlist creation. The PM wants to know if users on the ''Premium'' tier create more playlists than ''Free'' tier users. Should ''Subscription_Tier'' be an Event Property or User Property?',
        'foundational',
        'Spotify',
        'Audio streaming service',
        'B',
        'Option B is correct because a subscription tier reflects a state of the user that applies across many different events and sessions. User Properties persist across events, making it easy to segment any behavior by the user''s current state. Option A is incorrect because attaching it to every single event is redundant and doesn''t allow segmenting users who haven''t fired the event. Option C is wrong because state changes are tracked, but you still need a property to segment other behaviors. Option D is incorrect because Amplitude updates User Properties automatically via identify calls.',
        ARRAY['user_properties', 'event_properties', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Event Property, because subscription tier only matters when the event happens.', false),
    (v_q_id, 'B', 'User Property, because it reflects a persistent user state that applies across many events.', true),
    (v_q_id, 'C', 'Neither, it should be tracked as a separate event called ''Subscription_Tier_Changed''.', false),
    (v_q_id, 'D', 'Both, but Amplitude requires User Properties to be updated manually via CSV uploads.', false);

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
        'Uber''s Active User Definition',
        'An Uber PM notices that Daily Active Users (DAU) in Amplitude spiked dramatically yesterday, but completed rides remained flat. Which of the following is the most likely cause?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'B',
        'Option B is correct. In Amplitude, an ''Active User'' is typically defined as any user who fires an active event, such as ''App Open''. A push notification can drive massive app opens without driving core conversions like booking a ride. Option A is incorrect because ride duration doesn''t inflate unique active user counts. Option C would decrease ride counts, but wouldn''t inherently spike overall DAU. Option D is completely fabricated; Amplitude does not group users arbitrarily on weekends. PMs must always separate top-of-funnel activity metrics from core value metrics.',
        ARRAY['active_users', 'event_segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users are taking longer rides than usual, spanning multiple sessions.', false),
    (v_q_id, 'B', 'A new push notification caused many users to open the app, triggering an active event.', true),
    (v_q_id, 'C', 'The ''Ride_Completed'' event was accidentally deleted from Amplitude''s tracking plan.', false),
    (v_q_id, 'D', 'Amplitude automatically groups duplicate users together on weekends.', false);

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
        'Airbnb''s Funnel Steps',
        'An Airbnb PM builds a funnel in Amplitude: "App Open" -> "Book Stay". They notice a 99% drop-off between these two steps. What is the most foundational analytical mistake they are making?',
        'foundational',
        'Airbnb',
        'Accommodation marketplace',
        'A',
        'Option A is correct because skipping critical intermediate steps (like searching and viewing listings) makes it impossible to pinpoint where friction actually occurs. A funnel must map the logical user journey to be diagnostic. Option B is incorrect; Amplitude funnels track across sessions up to the conversion window limit. Option C is wrong because ''Book Stay'' is a standard conversion event. Option D is wrong because "Exact Order" restricts intermediate events, which would lower conversion further, but the primary error here is missing journey steps entirely.',
        ARRAY['funnel_analysis', 'conversion_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The funnel is missing critical intermediate steps (like ''View Listing''), making drop-off diagnosis impossible.', true),
    (v_q_id, 'B', 'Amplitude funnels cannot track events across different user sessions.', false),
    (v_q_id, 'C', '''Book Stay'' is a backend event and cannot be used in frontend funnel analysis.', false),
    (v_q_id, 'D', 'The funnel defaults to "Exact Order", preventing users from being counted if they search first.', false);

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
        'Slack''s Behavioral Cohorts',
        'Slack''s PM wants to analyze the long-term retention of "Power Users," defined as users who sent at least 50 messages in their first week. How should they isolate this group in Amplitude?',
        'foundational',
        'Slack',
        'B2B messaging platform',
        'B',
        'Option B is correct. Behavioral Cohorts allow you to group users based on specific actions they took (or didn''t take) within a defined timeframe, which can then be applied as a filter to any chart. Option A is incorrect because Event Segmentation charts only show the event metrics, not create reusable user groups. Option C is a manual, unscalable anti-pattern that ignores Amplitude''s native capabilities. Option D describes a funnel, which measures step-by-step conversion, not ongoing behavioral grouping.',
        ARRAY['behavioral_cohorts', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create an Event Segmentation chart and set the y-axis to ''Messages Sent > 50''.', false),
    (v_q_id, 'B', 'Create a Behavioral Cohort of users who performed ''Message_Sent'' >= 50 times in their first 7 days.', true),
    (v_q_id, 'C', 'Export all users to a CSV, filter in Excel, and upload them as a static User Property.', false),
    (v_q_id, 'D', 'Use a Funnel chart and set the conversion window to 7 days.', false);

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
        'Shopify''s N-Day Retention',
        E'Shopify''s PM is looking at an N-Day Retention table for the ''Viewed Dashboard'' event:\n\n| Cohort | Day 0 | Day 1 | Day 7 |\n|--------|-------|-------|-------|\n| Nov 1  | 100%  | 40%   | 10%   |\n\nWhat does "Day 7 is 10%" explicitly mean in Amplitude?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'A',
        'Option A is correct. In N-Day Retention, a user is counted as retained on Day N only if they fire the return event strictly on that specific day (e.g., exactly 7 days after the start event). Option B describes Unbounded (Rolling) retention, where a user is counted if they return on Day 7 OR any day afterward. Option C is incorrect as it describes event volume distribution, not user retention. Option D refers to session duration metrics, which are entirely separate from retention cohorts.',
        ARRAY['retention_analysis', 'n_day_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '10% of users viewed the dashboard exactly on the 7th day after their initial event.', true),
    (v_q_id, 'B', '10% of users viewed the dashboard at least once during their first 7 days.', false),
    (v_q_id, 'C', '10% of the total dashboard views for the month occurred on Day 7.', false),
    (v_q_id, 'D', 'Users spent 10% of their total session time on the dashboard on Day 7.', false);

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
        'DoorDash''s Unbounded Retention',
        'A DoorDash PM is measuring retention. Users often order food unpredictably—sometimes twice a week, sometimes once a month. Which retention metric is best suited to measure if users haven''t completely churned?',
        'foundational',
        'DoorDash',
        'Food delivery app',
        'B',
        'Option B is correct. Unbounded Retention measures the percentage of users who return on a specific day OR any day thereafter. This is ideal for products with unpredictable or low-frequency usage patterns, like food delivery or travel. Option A (N-Day) is too strict, penalizing users who don''t order on exact 24-hour intervals. Option C (Bracket) allows ranges but is better for periodic habits (like weekly workflows). Option D is an entirely different chart type meant for counting event volume.',
        ARRAY['retention_analysis', 'unbounded_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'N-Day Retention', false),
    (v_q_id, 'B', 'Unbounded (Rolling) Retention', true),
    (v_q_id, 'C', 'Bracket Retention', false),
    (v_q_id, 'D', 'Event Segmentation Analysis', false);

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
        'Figma''s Stickiness',
        'Figma''s PM is looking at a Stickiness chart for the ''Edit_File'' event over a 7-day period. The chart shows that 30% of users have a stickiness of 5 days. What does this mean?',
        'foundational',
        'Figma',
        'Collaborative design tool',
        'B',
        'Option B is correct. Stickiness measures the frequency of user engagement by showing the percentage of users who performed an event on a specific number of distinct days within a timeframe. Option A incorrectly conflates days with hours of duration. Option C describes Day 5 N-Day Retention, not stickiness. Option D confuses distinct active days with the raw count of events performed in a single session. Stickiness is a key indicator of habit formation.',
        ARRAY['stickiness', 'engagement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '30% of users edited a file continuously for 5 hours.', false),
    (v_q_id, 'B', '30% of active users performed the ''Edit_File'' event on exactly 5 distinct days within the week.', true),
    (v_q_id, 'C', '30% of users returned to the app exactly 5 days after signing up.', false),
    (v_q_id, 'D', '30% of users performed the ''Edit_File'' event 5 times in a single session.', false);

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
        'Notion''s Event Property Filtering',
        'Notion''s PM wants to count how many times the ''Page_Created'' event occurred, but only for pages created using a template. The ''Page_Created'' event has a boolean property `is_template`. How should the PM configure the chart?',
        'foundational',
        'Notion',
        'Productivity workspace',
        'B',
        'Option B is correct. Filtering by an event property restricts the data to only include events where that property meets the condition. Option A is incorrect because "Group By" would show two separate lines (True and False), rather than just counting the specific condition. Option C is a syntactically invalid custom formula. Option D overcomplicates the analysis by turning a simple metric into a funnel sequence, assuming ''Template_Used'' is a separate event.',
        ARRAY['event_segmentation', 'filtering']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Event Segmentation > Select ''Page_Created'' > Group By ''is_template''.', false),
    (v_q_id, 'B', 'Event Segmentation > Select ''Page_Created'' > Filter where `is_template` = True.', true),
    (v_q_id, 'C', 'Create a custom formula: `UNIQUES(Page_Created) * is_template`.', false),
    (v_q_id, 'D', 'Build a Funnel with ''Page_Created'' as step 1 and ''Template_Used'' as step 2.', false);

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
        'Duolingo''s Session Length',
        'Duolingo''s PM wants to measure average session length. By default, how does Amplitude define a user session for a mobile application?',
        'foundational',
        'Duolingo',
        'Language learning app',
        'B',
        'Option B is correct. Amplitude defaults to defining a mobile session as a period of activity where events are separated by no more than 5 minutes of inactivity. If a user backgrounds the app for 6 minutes and returns, a new session begins. Option A is incorrect; sessions don''t span entire calendar days. Option C is measuring app lifecycle, not sessions. Option D is incorrect; sessions are defined by dynamic activity timeouts, not strict chronological caps.',
        ARRAY['session_metrics', 'data_governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The time between the first event of the calendar day and the last event of the day.', false),
    (v_q_id, 'B', 'A period of continuous activity where events are separated by no more than a default 5-minute timeout.', true),
    (v_q_id, 'C', 'The total duration the application has been installed on the user''s device.', false),
    (v_q_id, 'D', 'A strict 30-minute window, regardless of whether the user is active or inactive.', false);

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
        'Robinhood''s Holding Property Constant',
        E'A Robinhood PM is analyzing a funnel. They see the following user journey log:\n\n1. Search Ticker (Ticker=''TSLA'')\n2. View Stock Page (Ticker=''AAPL'')\n3. Buy Stock (Ticker=''AAPL'')\n\nAmplitude currently counts this user as successfully converted in the "Search -> View -> Buy" funnel. How can the PM fix this so it only counts if the exact same stock is searched and bought?',
        'intermediate',
        'Robinhood',
        'Retail investing app',
        'B',
        'Option B is correct. The "Hold Property Constant" feature ensures that a funnel only counts a conversion if the specified event property (Ticker) remains identical across all steps. Option A is incorrect because "Exact Order" only prevents intervening events; it does not match property values. Option C is unscalable, as there are thousands of stocks. Option D restricts the analysis to just one stock instead of providing a universal conversion rate across all tickers.',
        ARRAY['funnel_analysis', 'holding_properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the funnel order from "Any Order" to "Exact Order".', false),
    (v_q_id, 'B', 'Use the "Hold Property Constant" setting and select the `Ticker` property across all steps.', true),
    (v_q_id, 'C', 'Create separate, individual funnels for every single stock ticker available.', false),
    (v_q_id, 'D', 'Filter the entire chart to only include users who bought ''TSLA''.', false);

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
        'Canva''s Conversion Window',
        'A Canva PM sets up a funnel: "Sign Up" -> "Create Design" -> "Export Design". The conversion window is set to the default of 30 days. If a user signs up on Day 1, creates a design on Day 15, and exports on Day 35, will they be counted as converted?',
        'intermediate',
        'Canva',
        'Design software platform',
        'C',
        'Option C is correct. In Amplitude, the conversion window is measured from the time the user completes the first step of the funnel. If the total time from step 1 to the final step exceeds the window, the user is not counted as a full conversion. Option A is incorrect because timing constraints matter. Option B is a common misconception; the timer does not reset after each intermediate step. Option D is false because funnels natively track across sessions up to the window limit.',
        ARRAY['funnel_analysis', 'conversion_window']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, because they completed all steps in the correct order.', false),
    (v_q_id, 'B', 'Yes, because the 30-day window resets every time a user completes an intermediate step.', false),
    (v_q_id, 'C', 'No, because the time between the first step and the last step exceeds 30 days.', true),
    (v_q_id, 'D', 'No, because Amplitude requires all steps to be completed within a single session.', false);

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
        'Peloton''s Exact vs Loose Order Funnels',
        'A Peloton PM creates a funnel: ''Start Workout'' -> ''Finish Workout''. They configure it to "Exact Order". A user performs: ''Start Workout'' -> ''Pause Workout'' -> ''Finish Workout''. What happens to this user in the funnel?',
        'intermediate',
        'Peloton',
        'Fitness technology company',
        'B',
        'Option B is correct. "Exact Order" in Amplitude requires that the user completes the funnel steps with NO other intervening events logged between them. Because the ''Pause Workout'' event fired, the exact sequence was broken, and the user drops out. Option A describes "This Order" (loose order) functionality. Option C is entirely fabricated. Option D is incorrect because Amplitude processes all ingested events chronologically, regardless of session mapping, when evaluating exact order.',
        ARRAY['funnel_analysis', 'exact_order']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The user is counted as converted because they ultimately finished the workout.', false),
    (v_q_id, 'B', 'The user is not counted as converted because an intervening event occurred between the steps.', true),
    (v_q_id, 'C', 'The user is counted as converted but automatically flagged as an outlier.', false),
    (v_q_id, 'D', 'Amplitude ignores ''Pause Workout'' because it is considered a background system event.', false);

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
        'Netflix''s Bracket Retention',
        'Netflix''s PM knows users tend to watch shows intensely over the weekend, drop off mid-week, and return the next weekend. Which retention metric is specifically designed to group periods together to capture this cyclical behavior?',
        'intermediate',
        'Netflix',
        'Streaming platform',
        'C',
        'Option C is correct. Bracket Retention allows PMs to define custom retention intervals (e.g., Days 1-3, Days 4-7, Days 8-14) rather than forcing strict daily check-ins. This is perfect for cyclical habits like weekend binging. Option A (Unbounded) just tracks if they ever return, losing the weekend periodicity. Option B (N-Day) is too granular and would show artificial churn on Tuesdays and Wednesdays. Option D (Lifecycle) looks at user states (new, resurrected), not specific return intervals.',
        ARRAY['retention_analysis', 'bracket_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Unbounded Retention', false),
    (v_q_id, 'B', 'N-Day Retention', false),
    (v_q_id, 'C', 'Bracket Retention', true),
    (v_q_id, 'D', 'Lifecycle Analysis', false);

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
        'Spotify''s Group-Level Analytics',
        'Spotify introduced a "Family Plan". The PM wants to measure the retention of the Family Plan Account as a whole, rather than the 5 individual users within it. How should they approach this in Amplitude?',
        'intermediate',
        'Spotify',
        'Audio streaming platform',
        'A',
        'Option A is correct. Group-Level Analytics (formerly known as Account-Level Reporting) allows PMs to change the primary counting entity from the individual ''User ID'' to a predefined group property, like a company ID or Family Plan ID. Option B is an unnecessary extraction of data when the tool supports this natively. Option C groups individual users but still counts retention on a per-user basis. Option D segments individual users by plan type but does not roll them up into a single account entity.',
        ARRAY['group_analytics', 'b2b_analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the reporting entity via Group-Level Analytics to the `Family_Plan_ID` group.', true),
    (v_q_id, 'B', 'Export all raw event data to SQL and run a distinct count on `Family_Plan_ID`.', false),
    (v_q_id, 'C', 'Create a behavioral cohort of users who have the property "Family Plan" = True.', false),
    (v_q_id, 'D', 'Filter the standard user retention chart by the `Plan_Type` user property.', false);

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
        'Uber''s Pathfinder/Journeys',
        'Uber''s PM wants to know what users do immediately after they experience a ''Ride Cancelled'' event. Which Amplitude chart is natively designed to visualize the aggregate sequence of events diverging from a specific starting point?',
        'intermediate',
        'Uber',
        'Ride-hailing platform',
        'B',
        'Option B is correct. Pathfinder (now part of Journeys) visualizes all the different paths users take starting from a specific event, or ending at a specific event. It is designed for open-ended exploration of user flows. Option A is incorrect because Funnels require you to define the exact steps in advance; they don''t reveal unknown paths. Option C simply counts event frequencies. Option D breaks down the makeup of a user segment, not sequential event flows.',
        ARRAY['pathfinder', 'user_journeys']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Funnel Analysis', false),
    (v_q_id, 'B', 'Pathfinder / User Journeys', true),
    (v_q_id, 'C', 'Event Segmentation', false),
    (v_q_id, 'D', 'Composition Analysis', false);

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
        'Airbnb''s Impact Analysis',
        'Airbnb recently launched a ''Price Breakdown'' feature. The PM uses Amplitude''s Impact Analysis chart to measure if using this feature causes an increase in bookings. Which of the following best describes the statistical methodology this chart uses natively?',
        'intermediate',
        'Airbnb',
        'Accommodation marketplace',
        'B',
        'Option B is correct. Amplitude''s Impact Analysis leverages Propensity Score Matching (PSM). It looks at users who used the feature (treatment) and mathematically finds users who didn''t use it but had nearly identical prior behaviors (synthetic control). Option A is wrong because simple correlation ignores selection bias (power users naturally use more features). Option C describes a randomized A/B test, which must be run at the code level, not retroactively in analytics. Option D is correlation, not causal impact.',
        ARRAY['impact_analysis', 'causal_inference']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It directly compares the conversion rate of users who used the feature vs those who did not.', false),
    (v_q_id, 'B', 'It uses Propensity Score Matching to create a synthetic control group of similar users.', true),
    (v_q_id, 'C', 'It runs a retroactive randomized A/B test on historical data.', false),
    (v_q_id, 'D', 'It calculates the Pearson correlation coefficient between the feature and bookings.', false);

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
        'Slack''s Custom Events',
        'Slack''s PM wants to track total messages sent. However, engineers tracked three separate events: ''Text_Sent'', ''Image_Sent'', and ''Video_Sent''. What is the most efficient way to track these as a single metric going forward without waiting for an engineering fix?',
        'intermediate',
        'Slack',
        'B2B messaging platform',
        'A',
        'Option A is correct. Amplitude allows PMs to create Custom Events (or Derived Events) in the Data Governance UI, grouping multiple existing events into one cohesive virtual event. This is immediately available for querying. Option B is incorrect because Amplitude empowers PMs to fix taxonomy issues via the UI. Option C creates a cohort of users, which doesn''t sum up the total volume of the events. Option D is a manual workaround that defeats the purpose of an analytics tool.',
        ARRAY['data_governance', 'custom_events']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a Custom Event in Amplitude Data that combines the three events into one.', true),
    (v_q_id, 'B', 'Submit an engineering ticket and wait for them to update the tracking plan.', false),
    (v_q_id, 'C', 'Create a behavioral cohort of users who fired any of the three events.', false),
    (v_q_id, 'D', 'Export the counts for all three events and sum them manually in a spreadsheet.', false);

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
        'Shopify''s Data Governance & Aliasing',
        'A user browses Shopify anonymously on the web (generating a Device ID), then downloads the app, creates an account, and logs in (generating a distinct User ID). How does Amplitude connect these two tracking profiles?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'B',
        'Option B is correct. Amplitude handles identity resolution via Aliasing. When a user transitions from anonymous to known, the engineering implementation must pass both IDs (or trigger an identify call) so Amplitude''s backend can merge the event streams. Option A is incorrect; IP addresses are volatile and insufficient for deterministic identity resolution. Option C is false because identity merging is a core feature. Option D is wrong because merging happens automatically via API logic, not manual UI clicks.',
        ARRAY['data_governance', 'aliasing', 'identity_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Amplitude automatically connects them based on matching IP addresses.', false),
    (v_q_id, 'B', 'The system aliases the profiles when the Identify API call maps the Device ID to the User ID.', true),
    (v_q_id, 'C', 'It is impossible; cross-platform sessions will always remain distinct users.', false),
    (v_q_id, 'D', 'The PM must manually merge the user profiles within the Amplitude UI dashboard.', false);

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
        'DoorDash''s Compass Analysis',
        'A DoorDash PM uses the Compass chart to find leading indicators for retention. Compass shows that ''Adding a Profile Picture'' has an extremely high correlation with 30-day retention. What should the PM conclude?',
        'intermediate',
        'DoorDash',
        'Food delivery app',
        'B',
        'Option B is correct. The Compass chart identifies correlations, but correlation does not equal causation. Highly engaged users might just naturally add profile pictures. The PM must test causality (e.g., via an A/B test incentivizing photo uploads) before assuming it drives retention. Option A falls into the causality trap. Option C is an extreme overstatement of a single metric. Option D dismisses valid behavioral data; profile personalization often correlates with platform commitment.',
        ARRAY['compass', 'correlation_vs_causation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Forcing all users to add a profile picture during onboarding will guarantee higher retention.', false),
    (v_q_id, 'B', 'It is highly correlated, but the PM must run an A/B test to prove if the relationship is causal.', true),
    (v_q_id, 'C', 'Adding a profile picture is the primary reason users decide to continue ordering food.', false),
    (v_q_id, 'D', 'The data must be ignored because profile pictures are irrelevant to food delivery.', false);

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
        'Figma''s Lifecycle Chart',
        'Figma''s PM is viewing a Lifecycle chart and sees a segment labeled "Resurrected Users." How does Amplitude natively define a Resurrected User?',
        'intermediate',
        'Figma',
        'Collaborative design platform',
        'A',
        'Option A is correct. In Amplitude''s Lifecycle analysis, a Resurrected User is defined as someone who was active in the current interval, was inactive in the immediately preceding interval (churned), but had been active in some interval prior to that. Option B defines a new user on a new account. Option C is a specific customer support action, not an analytics state. Option D defines a "New" user, which is a different bucket in the lifecycle chart.',
        ARRAY['lifecycle_analysis', 'user_states']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A user active in the current interval, inactive in the previous interval, but active before that.', true),
    (v_q_id, 'B', 'A user who creates a new account after deleting their previous one.', false),
    (v_q_id, 'C', 'A user who clicks a specific "Reactivate Account" link via email.', false),
    (v_q_id, 'D', 'A user who completes an event for the very first time.', false);

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
        'Notion''s Active Events',
        'Notion''s PM is calculating Daily Active Users (DAU). In Amplitude, which events count towards a user being considered "Active"?',
        'intermediate',
        'Notion',
        'Productivity workspace',
        'B',
        'Option B is correct. Amplitude allows admins to define which events are "Active" and which are "Inactive" (passive) in the Data/Govern settings. Passive events (like background syncs or push notification receipts) do not count toward DAU. Option A is incorrect because any user-driven event (like ''Page Edited'') can count. Option C limits DAU to monetization, which is fundamentally wrong. Option D includes passive events, which artificially inflates active user counts.',
        ARRAY['active_users', 'data_governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Only the default ''App Open'' or ''Session Start'' events.', false),
    (v_q_id, 'B', 'Any event that has been explicitly marked as an "Active Event" in the taxonomy settings.', true),
    (v_q_id, 'C', 'Only events that are tied to a revenue-generating transaction.', false),
    (v_q_id, 'D', 'Every event fired, including passive background syncs not initiated by the user.', false);

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
        'Duolingo''s Custom Formulas',
        'A Duolingo PM wants to track the ratio of ''Lessons Completed'' to ''Lessons Started'' over time. Which custom formula syntax is correct in Amplitude''s Event Segmentation chart?',
        'intermediate',
        'Duolingo',
        'Language learning platform',
        'B',
        'Option B is correct. In Amplitude''s custom formulas, you reference the events added to the chart by their letter designation (A, B, C) and wrap them in metric functions like TOTALS() or UNIQUES(). Therefore, `TOTALS(A) / TOTALS(B)` calculates the correct ratio of raw events. Option A uses invalid syntax by trying to type the event name directly. Option C and D use fabricated formula functions that don''t exist in Amplitude''s syntax engine.',
        ARRAY['custom_formulas', 'event_segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '`UNIQUES(Lessons_Completed) / UNIQUES(Lessons_Started)`', false),
    (v_q_id, 'B', '`TOTALS(A) / TOTALS(B)` where A is ''Lessons Completed'' and B is ''Lessons Started''', true),
    (v_q_id, 'C', '`COUNT(Lessons_Completed, Lessons_Started)`', false),
    (v_q_id, 'D', '`RATIO(Lessons_Completed, Lessons_Started)`', false);

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
        'Robinhood''s Historical Count',
        'A Robinhood PM wants to segment users based on how many times they have historically triggered the ''Trade_Executed'' event prior to today. Which native Amplitude feature enables this?',
        'intermediate',
        'Robinhood',
        'Retail investing app',
        'A',
        'Option A is correct. Amplitude natively supports a "Historical Count" filter within Event Segmentation and Cohorts, allowing PMs to target users based on the exact Nth time they perform an action (e.g., showing users making their 5th trade). Option B is incorrect; funnels track sequences, not historical lifetime counts. Option C measures day-over-day habit, not lifetime accumulation. Option D is a retention metric, completely unrelated to cumulative event counting.',
        ARRAY['historical_count', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The ''Historical Count'' filter on the event selection.', true),
    (v_q_id, 'B', 'A basic Funnel chart with the conversion window extended.', false),
    (v_q_id, 'C', 'The Stickiness analysis chart.', false),
    (v_q_id, 'D', 'Unbounded retention with a 365-day bracket.', false);

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
        'Canva''s Funnel Drop-off Diagnosis',
        'In a Canva funnel, 60% of users drop off between ''Select Template'' and ''Export''. The PM wants to know what else these dropped-off users did instead of exporting. Which feature directly answers this?',
        'intermediate',
        'Canva',
        'Design software platform',
        'B',
        'Option B is correct. Amplitude allows PMs to click on the drop-off segment of a funnel step and select "Show User Paths" (or Journeys). This immediately generates a Pathfinder chart showing the exact actions the churned users took instead. Option A shows conversion rates over chronological time, not alternate behaviors. Option C tracks engagement frequency. Option D finds correlations for retention, not immediate behavioral alternatives in a funnel flow.',
        ARRAY['funnel_analysis', 'user_journeys', 'drop_off']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conversion Over Time', false),
    (v_q_id, 'B', '"Show User Paths" / "Journeys" originating from the drop-off step', true),
    (v_q_id, 'C', 'Stickiness Chart', false),
    (v_q_id, 'D', 'Compass Analysis', false);

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
        'Netflix''s Roll-up Properties',
        'Netflix users can upgrade their subscription. The ''Plan_Type'' is a user property. What happens to a user''s historical ''Play_Video'' events if their ''Plan_Type'' changes from Basic to Premium mid-month?',
        'intermediate',
        'Netflix',
        'Streaming platform',
        'B',
        'Option B is correct. In Amplitude, when an event is fired, it captures a snapshot of the user properties at that exact moment. Therefore, past events retain the ''Basic'' property value, while future events log with ''Premium''. Option A is false; Amplitude never deletes historical data for property changes. Option C is incorrect; retroactive updating would destroy the integrity of historical cohort analysis. Option D is false; the user remains fully analyzable.',
        ARRAY['user_properties', 'event_state']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Amplitude automatically deletes the historical events prior to the change.', false),
    (v_q_id, 'B', 'Past events keep the old property value, and new events get the new property value.', true),
    (v_q_id, 'C', 'Amplitude retroactively updates all historical events to reflect the new Plan_Type.', false),
    (v_q_id, 'D', 'The user is excluded from all future analysis due to property conflict.', false);

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
        'Spotify''s Metric Interpretation',
        'In an Event Segmentation chart for ''Song_Played'', the PM switches the metric from "Uniques" to "Event Totals". The line on the chart moves significantly higher. What does this indicate?',
        'intermediate',
        'Spotify',
        'Audio streaming platform',
        'B',
        'Option B is correct. "Uniques" counts the number of distinct users performing the event, while "Event Totals" counts the absolute number of times the event fired. A massive gap between the two indicates that a subset of users is performing the action repeatedly (high events per user). Option A is wrong because an influx of new users would raise the "Uniques" line as well. Option C and D are completely unrelated inferences to this specific metric switch.',
        ARRAY['event_segmentation', 'uniques_vs_totals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A massive influx of new users just joined the platform.', false),
    (v_q_id, 'B', 'Users are playing a very large number of songs individually (high events per user).', true),
    (v_q_id, 'C', 'The overall retention rate of the platform has decreased.', false),
    (v_q_id, 'D', 'The data is corrupted and counting internal test accounts.', false);

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
        'Uber''s A/B Test Integration',
        'Uber is running an A/B test via LaunchDarkly, but wants to analyze the downstream behavior in Amplitude. What is the standard technical pattern to pipe A/B test data into Amplitude?',
        'intermediate',
        'Uber',
        'Ride-hailing platform',
        'A',
        'Option A is correct. The industry standard for integrating external feature flagging/experimentation tools with Amplitude is to fire an ''Experiment_Viewed'' (or exposure) event containing the experiment name and variant as properties. This enables filtering and segmenting in all charts. Option B is highly manual and unscalable. Option C fragments data and destroys the ability to analyze global metrics. Option D breaks identity resolution entirely.',
        ARRAY['ab_testing', 'integrations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send an ''Experiment_Viewed'' event containing the variant name as an event property.', true),
    (v_q_id, 'B', 'Manually upload a CSV of control/treatment users every 24 hours.', false),
    (v_q_id, 'C', 'Create a new, separate Amplitude project for each A/B test variant.', false),
    (v_q_id, 'D', 'Change the global ''User ID'' to append the variant name.', false);

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
        'Airbnb''s Simpson''s Paradox',
        E'An Airbnb PM looks at conversion data week-over-week:\n\n| Segment | W1 Conv. | W2 Conv. |\n|---------|----------|----------|\n| iOS     | 10%      | 12%      |\n| Android | 4%       | 5%       |\n| TOTAL   | 8%       | 6%       |\n\nThe overall conversion dropped from 8% to 6%, but both iOS and Android increased individually. What is the most likely cause of this metric movement?',
        'advanced',
        'Airbnb',
        'Accommodation marketplace',
        'A',
        'Option A is correct. This is a classic example of Simpson''s Paradox, where a trend appears in segmented groups but reverses when combined. This happens due to a mix shift; if W2 had a massive influx of Android users (who inherently convert lower), the weighted total average drops, even if Android''s baseline improved. Option B is incorrect as this is standard math, not a bug. Option C and D do not mathematically explain inverse ratio movements across segments.',
        ARRAY['simpsons_paradox', 'composition_bias', 'analytics_kpis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Simpson''s Paradox, caused by a massive mix shift toward the lower-converting Android segment.', true),
    (v_q_id, 'B', 'An error in Amplitude''s calculation logic for cross-platform custom formulas.', false),
    (v_q_id, 'C', 'The iOS and Android engineering teams are using different timezones in their SDKs.', false),
    (v_q_id, 'D', 'Users are switching back and forth between iOS and Android within the exact same session.', false);

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
        'Slack''s Multiple Property Holding',
        'Slack''s PM builds a funnel: ''Start Thread'' -> ''Reply to Thread'' -> ''Resolve Thread''. They want to ensure this funnel only counts when all three steps happen within the exact same thread AND the exact same channel. How can they achieve this?',
        'advanced',
        'Slack',
        'B2B messaging platform',
        'B',
        'Option B is correct. Amplitude''s "Hold Property Constant" feature allows you to select multiple properties simultaneously. By selecting both `Thread_ID` and `Channel_ID`, the funnel will strictly enforce that both variables remain identical across all steps for a conversion to count. Option A is false; Amplitude supports multi-property holding. Option C is wrong because "Exact Order" enforces sequence, not property matching. Option D visualizes flows but doesn''t calculate conversion rates.',
        ARRAY['funnel_analysis', 'holding_properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'This is impossible in Amplitude; funnels can only hold one property constant at a time.', false),
    (v_q_id, 'B', 'Use "Hold Property Constant" and select both `Thread_ID` and `Channel_ID`.', true),
    (v_q_id, 'C', 'Set the funnel to "Exact Order" and the conversion window to 1 second.', false),
    (v_q_id, 'D', 'Use the ''Pathfinder'' chart instead of a Funnel.', false);

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
        'Shopify''s Cross-Project Analysis',
        'Shopify has two separate Amplitude projects: Consumer App and Merchant Dashboard. The PM wants to build a single funnel measuring how many users open the Shop app and subsequently log into the Merchant Dashboard. What is the primary obstacle?',
        'advanced',
        'Shopify',
        'E-commerce platform',
        'B',
        'Option B is correct. Standard Amplitude charts cannot query data across two disparate projects natively. To achieve this, the data must either be tracked into a unified master project, or accessed using advanced add-ons like Amplitude Portfolio or Snowflake data shares. Option A is false; users can exist in multiple projects. Option C is fabricated; there is no 2-step limit. Option D might be true regarding timezones, but it isn''t the primary architectural blocker.',
        ARRAY['data_governance', 'cross_project_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Amplitude strictly prohibits users from having the same User ID in two different projects.', false),
    (v_q_id, 'B', 'Standard charts cannot query across projects; data must be unified or queried via Portfolio.', true),
    (v_q_id, 'C', 'Funnels are limited to a maximum of 2 steps when cross-project tracking is enabled.', false),
    (v_q_id, 'D', 'The Merchant Dashboard uses a different tracking timezone than the Consumer App.', false);

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
        'DoorDash''s Behavioral Cohort Syncing',
        'DoorDash''s PM creates a Behavioral Cohort of "Users who ordered 3+ times last week." They sync this cohort to Braze to send an email. Why might the number of users receiving the email in Braze be lower than the cohort size shown in Amplitude?',
        'advanced',
        'DoorDash',
        'Food delivery platform',
        'B',
        'Option B is correct. Amplitude cohorts contain all user profiles meeting the criteria, including anonymous users (Device IDs) who haven''t provided an email address or merged with a known User ID. When syncing to marketing tools like Braze, anonymous profiles without contact information are inherently dropped. Option A is false; enterprise tools support millions of users. Option C is false; integrations are usually real-time or hourly. Option D is false; syncing cohorts is a core use case.',
        ARRAY['behavioral_cohorts', 'integrations', 'identity_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Braze automatically caps external API campaigns at 10,000 users.', false),
    (v_q_id, 'B', 'The Amplitude cohort includes anonymous users who lack email addresses.', true),
    (v_q_id, 'C', 'Amplitude''s cohort sync API is inherently delayed by 7 days.', false),
    (v_q_id, 'D', 'Behavioral cohorts cannot be synced to external tools; they are view-only.', false);

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
        'Figma''s B2B Account-Level Complexities',
        'Figma uses Group-Level Analytics to measure Account Retention. If User A from "Acme Corp" triggers the start event on Day 0, and User B from "Acme Corp" triggers the return event on Day 7, how is retention calculated?',
        'advanced',
        'Figma',
        'Collaborative design platform',
        'A',
        'Option A is correct. In Group-Level (Account) Analytics, the group identifier (e.g., Company Name) becomes the primary actor. As long as *any* user within that group fires the start event, and *any* user within the group fires the return event, the group itself is counted as retained. Option B applies only to user-level analytics. Option C is wrong because this behavior is fully supported. Option D is incorrect; group sharing is the exact purpose of the feature.',
        ARRAY['group_analytics', 'b2b_analytics', 'retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Acme Corp" is counted as retained because the unit of analysis is the group, not the individual.', true),
    (v_q_id, 'B', '"Acme Corp" is NOT counted as retained, because User A must trigger both events.', false),
    (v_q_id, 'C', 'Amplitude will flag this as anomalous and remove "Acme Corp" from the dataset.', false),
    (v_q_id, 'D', 'The chart will crash because multiple users are sharing the same group ID.', false);

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
        'Notion''s Funnel Time to Convert',
        E'Notion''s PM builds a funnel: ''Create Page'' -> ''Share Page''. The Time to Convert histogram shows:\n\n| Metric | Value |\n|--------|-------|\n| Median | 2 hrs |\n| Average| 48 hrs|\n\nWhat is the most analytically sound interpretation of this discrepancy?',
        'advanced',
        'Notion',
        'Productivity workspace',
        'B',
        'Option B is correct. Time-to-convert metrics in behavior funnels are highly susceptible to right-skewness. Most users complete the funnel quickly (producing a low median), but a small tail of users might return days later to finish the funnel, pulling the mean (average) drastically upward. Option A is incorrect because double-firing deflates time. Option C is wrong because Amplitude does not bifurcate math by device unprompted. PMs should always use medians for time-based metrics.',
        ARRAY['funnel_analysis', 'time_to_convert', 'advanced_statistics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The tracking code is double-firing, causing the median to be artificially low.', false),
    (v_q_id, 'B', 'A small tail of extreme outliers is skewing the average upward; the PM should rely on the median.', true),
    (v_q_id, 'C', 'The median time is only calculated for mobile devices, while the average includes web.', false),
    (v_q_id, 'D', 'The PM set the conversion window too short, artificially inflating the average.', false);

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
        'Duolingo''s Rolling Window Averages',
        'A PM uses a custom formula `ROLLINGAVERAGE(TOTALS(A), 7)`. They notice this metric is substantially smoother than simply charting `TOTALS(A)` on a daily interval. Why is this technique crucial for interpreting this specific product''s data?',
        'advanced',
        'Duolingo',
        'Language learning platform',
        'B',
        'Option B is correct. Consumer products like Duolingo often exhibit strong day-of-week seasonality (e.g., massive spikes on Mondays, drops on weekends). A 7-day rolling average perfectly neutralizes this weekly cycle, smoothing the noise to reveal the true underlying growth or decline trend. Option A is a dangerous assumption about missing data. Option C is a cynical misinterpretation of data smoothing. Option D is factually incorrect; Amplitude processes billions of daily events easily.',
        ARRAY['custom_formulas', 'time_series_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It mathematically hides tracking errors caused by server outages on weekends.', false),
    (v_q_id, 'B', 'It neutralizes day-of-week seasonality, revealing the true underlying trend.', true),
    (v_q_id, 'C', 'It manipulates the data to artificially inflate numbers for executive reporting.', false),
    (v_q_id, 'D', 'Amplitude''s backend cannot process raw daily totals for high-volume events without crashing.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for amplitude';

END $$;
