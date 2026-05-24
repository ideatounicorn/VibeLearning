-- ============================================
-- ASSESSMENT: Analytics & KPIs
-- CATEGORY: Product Analytics
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
    WHERE slug = 'analytics-kpis';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug analytics-kpis not found. Run the seed data first.';
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
        'Spotify''s North Star Metric',
        'A new PM at Spotify is asked to evaluate the success of the ''Discover Weekly'' feature. Which of the following metrics serves as the BEST North Star Metric for this specific feature?',
        'foundational',
        'Spotify',
        'Audio streaming platform',
        'C',
        'A North Star Metric should capture the core value delivered to the user. For Discover Weekly, the value is discovering new music they love. Time spent listening to Discover Weekly specifically captures this value. Total DAU is too broad, number of tracks skipped is a negative indicator, and playlist opens doesn''t measure actual consumption or value realized.',
        ARRAY['north_star_metric', 'engagement', 'feature_evaluation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Total Spotify Daily Active Users (DAU).', false),
    (v_q_id, 'B', 'Number of Discover Weekly playlists opened per week.', false),
    (v_q_id, 'C', 'Total hours spent listening to Discover Weekly tracks.', true),
    (v_q_id, 'D', 'Number of tracks skipped in Discover Weekly.', false);

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
        'Uber''s Marketplace Balance',
        'Uber''s marketplace team notices that wait times in downtown Chicago have increased from 3 minutes to 8 minutes over the last week. Which metric should they look at FIRST to diagnose the issue?',
        'foundational',
        'Uber',
        'Ride-hailing marketplace',
        'A',
        'Wait times are a direct result of marketplace balance (supply vs. demand). The ratio of active riders looking for rides to available drivers in that specific geofence will immediately tell you if the issue is a demand spike or a supply shortage. Driver cancellation rate, average fare, and app crashes are secondary metrics that might explain the ''why'' but don''t establish the core imbalance.',
        ARRAY['marketplace_metrics', 'supply_demand', 'liquidity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The ratio of ride requests to available drivers in the downtown Chicago geofence.', true),
    (v_q_id, 'B', 'The average driver cancellation rate across all of Chicago.', false),
    (v_q_id, 'C', 'The average surge pricing multiplier in the region.', false),
    (v_q_id, 'D', 'The percentage of users experiencing app crashes on iOS.', false);

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
        'Slack''s DAU/MAU Ratio',
        'Slack''s product team sees a DAU/MAU ratio of 85% for Enterprise users but only 30% for Free users. A junior PM suggests focusing all marketing efforts on Free users to ''fix'' their ratio. Why is this reasoning flawed?',
        'foundational',
        'Slack',
        'B2B team communication',
        'B',
        'DAU/MAU measures habituation. Enterprise users use Slack because it''s mandated for work (high natural frequency), resulting in an artificially high DAU/MAU. Free users often use it for casual groups or side projects with naturally lower frequency. Comparing these cohorts directly ignores the fundamental difference in their use cases and natural frequency.',
        ARRAY['dau_mau', 'engagement', 'cohort_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Free users actually generate more revenue through word-of-mouth.', false),
    (v_q_id, 'B', 'Enterprise use cases have a different natural frequency (daily work) than Free use cases (casual groups).', true),
    (v_q_id, 'C', 'MAU is a vanity metric and should not be used to calculate engagement.', false),
    (v_q_id, 'D', 'The team should focus on Weekly Active Users (WAU) instead of DAU.', false);

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
        'Netflix''s Lagging Indicator',
        'Netflix wants to predict which users are likely to cancel their subscription next month. Which of the following is a lagging indicator in this context?',
        'foundational',
        'Netflix',
        'Subscription streaming service',
        'D',
        'A lagging indicator tells you what has already happened. The cancellation rate is the ultimate lagging indicator—by the time it goes up, the users have already left. Days since last login, decrease in watch time, and removing payment methods are all leading indicators that predict future churn.',
        ARRAY['lagging_indicator', 'churn', 'predictive_analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A 50% decrease in weekly watch hours.', false),
    (v_q_id, 'B', 'The number of days since the user''s last login.', false),
    (v_q_id, 'C', 'A user removing their backup payment method.', false),
    (v_q_id, 'D', 'The total churn rate for the current month.', true);

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
        'Airbnb''s Guardrail Metric',
        'Airbnb is testing a new ''Instant Book'' default that skips host approval. The primary goal is to increase booking conversion rate. What is the most important guardrail metric to monitor?',
        'foundational',
        'Airbnb',
        'Accommodation marketplace',
        'B',
        'A guardrail metric ensures that optimizing for the primary goal (conversion) doesn''t harm the overall business. If bypassing host approval leads to bad guest experiences or hosts feeling lack of control, the host cancellation rate will spike. Page load time is irrelevant here, average booking value is a secondary revenue metric, and number of searches is at the top of the funnel.',
        ARRAY['guardrail_metric', 'marketplace_metrics', 'experimentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Average page load time for the booking screen.', false),
    (v_q_id, 'B', 'Host-initiated cancellation rate.', true),
    (v_q_id, 'C', 'Average Booking Value (ABV).', false),
    (v_q_id, 'D', 'Number of searches performed per user.', false);

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
        'Shopify''s Actionable vs Vanity Metrics',
        'A PM at Shopify is reporting on the success of a new ''abandoned cart recovery'' email feature. Which metric is the most actionable measure of the feature''s success?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'C',
        'Actionable metrics tie directly to business value and decision-making. The incremental revenue generated directly from clicks in the recovery emails proves the feature''s ROI. Total emails sent is a vanity metric. Open rate is a top-of-funnel diagnostic metric. Total platform GMV is too broad and cannot be attributed solely to this feature.',
        ARRAY['actionable_metrics', 'vanity_metrics', 'attribution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Total number of recovery emails sent.', false),
    (v_q_id, 'B', 'Total Gross Merchandise Volume (GMV) across the platform.', false),
    (v_q_id, 'C', 'Incremental revenue attributed to recovery email clicks.', true),
    (v_q_id, 'D', 'The open rate of the recovery emails.', false);

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
        'DoorDash''s LTV:CAC',
        'DoorDash is spending $50 to acquire a new user (CAC). The average user generates $10 in contribution margin per order. Which additional piece of data is needed to calculate the user''s LTV (Lifetime Value)?',
        'foundational',
        'DoorDash',
        'Food delivery marketplace',
        'B',
        'LTV is calculated as (Margin per transaction) * (Number of transactions per user over their lifetime). To know the number of transactions, you need the average order frequency and the user retention (or churn) rate over time. App store ratings, marketing spend, and restaurant acquisition cost don''t factor into a single consumer''s LTV calculation.',
        ARRAY['ltv_cac', 'unit_economics', 'monetization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The cost to acquire a restaurant partner.', false),
    (v_q_id, 'B', 'The average order frequency and user retention rate over time.', true),
    (v_q_id, 'C', 'The total marketing budget for the quarter.', false),
    (v_q_id, 'D', 'The average app store rating of the new users.', false);

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
        'Figma''s Net Dollar Retention',
        'Figma''s Net Dollar Retention (NDR) is 130%. What does this indicate about their revenue?',
        'foundational',
        'Figma',
        'Collaborative design tool',
        'A',
        'Net Dollar Retention measures revenue from existing customers, accounting for expansions, downgrades, and churn. An NDR over 100% means that the revenue growth from existing customers (upgrades, adding more seats) outpaces the revenue lost from churn and downgrades. It does not measure new logo acquisition.',
        ARRAY['ndr', 'saas_metrics', 'revenue_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Revenue from existing customers is growing faster than revenue lost to churn.', true),
    (v_q_id, 'B', 'Figma is acquiring 30% more new customers this year than last year.', false),
    (v_q_id, 'C', '30% of Figma''s revenue is spent on customer acquisition.', false),
    (v_q_id, 'D', 'Figma''s gross margin on software is 30%.', false);

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
        'Duolingo''s Leading Indicator of Retention',
        'Duolingo wants to improve its D30 (Day 30) retention. The team decides to focus on a leading indicator that they can influence in the short term. Which of the following is the best choice?',
        'foundational',
        'Duolingo',
        'Language learning app',
        'C',
        'A leading indicator must predict the trailing metric (D30 retention) and be actionable early. The percentage of users completing a 3-day streak in their first week is highly predictive of long-term habit formation and can be influenced immediately. D1 retention is good but less correlated with D30 than early streak behavior. Time spent on D30 is a lagging metric.',
        ARRAY['leading_indicator', 'retention', 'activation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The number of push notifications sent on Day 29.', false),
    (v_q_id, 'B', 'The total time spent in the app on Day 30.', false),
    (v_q_id, 'C', 'The percentage of users who achieve a 3-day streak in their first week.', true),
    (v_q_id, 'D', 'The cost to acquire a user (CAC).', false);

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
        'Tinder''s Counter-Metric',
        'Tinder introduces a new algorithmic feed to help users find better matches. They see average session length increase by 40%. Why might this NOT be a positive signal?',
        'foundational',
        'Tinder',
        'Dating app',
        'D',
        'In transactional or matching products, excessive time spent can indicate friction. If session length increases but matches don''t, it means users are swiping longer without success, leading to frustration. This is a classic counter-metric scenario where an ''engagement'' metric going up actually signals a worse user experience.',
        ARRAY['counter_metric', 'engagement', 'friction']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Longer sessions always mean higher server costs, reducing margins.', false),
    (v_q_id, 'B', 'It means users are reading profiles carefully instead of swiping quickly.', false),
    (v_q_id, 'C', 'Apple and Google penalize apps that have overly long session lengths.', false),
    (v_q_id, 'D', 'Increased session length might indicate users are struggling to find a match, adding friction to the core loop.', true);

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
        'LinkedIn''s Feed Engagement Trap',
        'A LinkedIn PM changes the feed algorithm to prioritize highly controversial text posts. Likes and Comments spike by 50%, but 30 days later, WAU (Weekly Active Users) drops by 10%. What analytical mistake did the PM make?',
        'intermediate',
        'LinkedIn',
        'Professional networking platform',
        'C',
        'The PM optimized for short-term, low-quality engagement (likes/comments on controversy) at the expense of the long-term core value proposition (professional networking). This is a classic trap where vanity engagement metrics diverge from sustainable retention metrics. Users engage with the drama but eventually churn because the platform no longer feels valuable for their career.',
        ARRAY['kpi_trap', 'engagement_quality', 'retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They failed to measure the cost of storing the additional comments.', false),
    (v_q_id, 'B', 'They looked at WAU instead of MAU, which is more stable.', false),
    (v_q_id, 'C', 'They optimized for short-term engagement over long-term user value and retention.', true),
    (v_q_id, 'D', 'They should have tracked shares instead of likes and comments.', false);

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
        'Stripe''s API Uptime vs Payment Success',
        'Stripe''s dashboard shows API uptime is 99.999%, but the ''Payment Success Rate'' metric dropped from 95% to 82% over the weekend. What is the most likely actionable conclusion for a PM?',
        'intermediate',
        'Stripe',
        'Payment processing infrastructure',
        'C',
        'API uptime only measures if the servers are responding, not if the business logic is successful. A sharp drop in Payment Success Rate while uptime is perfect usually points to downstream issues like bank network outages, an influx of fraudulent transactions, or expired cards from a large merchant. The PM needs to segment the failure codes to diagnose the issue.',
        ARRAY['system_metrics', 'business_metrics', 'diagnostic_analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The API monitoring tool is broken and needs to be recalibrated.', false),
    (v_q_id, 'B', 'Customers are abandoning their carts faster due to UI latency.', false),
    (v_q_id, 'C', 'The API is functioning, but there is an issue with underlying bank networks or an influx of fraudulent transactions.', true),
    (v_q_id, 'D', 'Stripe''s pricing model is too expensive, causing merchants to leave.', false);

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
        'Robinhood''s ARPU Mix Shift',
        E'E'Robinhood reports that overall ARPU (Average Revenue Per User) has declined from $50 to $40 over the last quarter. However, the data table shows:\n\n| Cohort | Q1 ARPU | Q2 ARPU |\n|--------|---------|---------|\n| Crypto | $80     | $85     |\n| Options| $120    | $125    |\n| Stocks | $20     | $22     |\n\nWhat is the most likely mathematical explanation?'',
        'intermediate',
        'Robinhood',
        'Retail investing platform',
        'B',
        'This is an example of Simpson''s Paradox or a mix shift effect. Even though the ARPU for every individual segment increased, the overall average can decrease if a much larger proportion of the user base is now made up of the lowest-revenue segment (Stocks). The influx of low-ARPU users drags down the blended average.',
        ARRAY['simpsons_paradox', 'arpu', 'mix_shift']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Robinhood lowered their fees across all transaction types.', false),
    (v_q_id, 'B', 'There was a massive influx of new ''Stocks'' users, shifting the overall user mix toward the lowest-ARPU segment.', true),
    (v_q_id, 'C', 'Options traders traded less frequently in Q2 than in Q1.', false),
    (v_q_id, 'D', 'The calculation for ARPU is inherently flawed and should use median instead of mean.', false);

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
        'Notion''s Activation Metric',
        'Notion''s growth team is defining a new activation metric. They currently use ''Account Created''. Why is this a poor activation metric, and what would be a better alternative?',
        'intermediate',
        'Notion',
        'Workspace and documentation tool',
        'A',
        'Activation metrics should measure the moment a user experiences the core value of the product (the ''Aha!'' moment). Simply creating an account captures intent but not value delivery. A better metric is an action that demonstrates setting up a workspace, such as creating a page and adding content or inviting a team member.',
        ARRAY['activation', 'time_to_value', 'onboarding']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Account Creation is a top-of-funnel step; a better metric is ''Created 3 pages and invited 1 team member''.', true),
    (v_q_id, 'B', 'Account Creation is too hard to track; a better metric is ''Time spent on the landing page''.', false),
    (v_q_id, 'C', 'Account Creation is a lagging indicator; a better metric is ''NPS score''.', false),
    (v_q_id, 'D', 'Account Creation measures the wrong persona; a better metric is ''Credit card added''.', false);

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
        'Discord''s Voice Engagement',
        'Discord launches a new spatial audio feature for Voice Channels. They want to measure its impact. Which KPI tree accurately connects the feature to the company''s North Star?',
        'intermediate',
        'Discord',
        'Voice and text communication platform',
        'C',
        'A KPI tree maps specific feature metrics to broader company goals. The feature directly impacts usage of spatial audio. If good, this increases total voice minutes per user (engagement depth), which in turn drives overall daily active users and retention (North Star). Option C accurately models this causal chain.',
        ARRAY['kpi_tree', 'engagement', 'feature_adoption']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Spatial Audio Toggles -> Text Messages Sent -> Nitro Subscriptions', false),
    (v_q_id, 'B', 'Server Creation Rate -> Friend Requests Sent -> Spatial Audio Toggles', false),
    (v_q_id, 'C', 'Spatial Audio Adoption Rate -> Average Voice Minutes per Session -> Overall WAU/Retention', true),
    (v_q_id, 'D', 'App Store Ratings -> Marketing CTR -> Spatial Audio Toggles', false);

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
        'Zoom''s Freemium Conversion',
        'Zoom limits free meetings to 40 minutes. They notice that 80% of free users regularly end meetings at 39 minutes. A PM suggests reducing the limit to 20 minutes to force upgrades. What is the biggest analytical risk of this strategy?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'B',
        'In a freemium model, free users are a marketing channel and a source of network effects. Drastically degrading the free experience to force monetization often backfires by causing the top-of-funnel to collapse. Users will switch to a competitor (like Google Meet) rather than upgrade, destroying the acquisition loop.',
        ARRAY['freemium', 'conversion_rate', 'network_effects']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The 20-minute limit will increase server costs due to users re-joining constantly.', false),
    (v_q_id, 'B', 'It degrades the core value of the free tier so much that users may churn to competitors, destroying the top-of-funnel acquisition loop.', true),
    (v_q_id, 'C', 'Enterprise customers will demand price cuts if the free tier is reduced.', false),
    (v_q_id, 'D', 'It will artificially inflate the Daily Active Users (DAU) metric.', false);

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
        'Peloton''s Hardware vs Software Churn',
        'Peloton sells a $2,000 bike and a $39/month subscription. The hardware gross margin is 20%, and the software gross margin is 70%. Which metric is MOST critical to Peloton''s long-term enterprise value?',
        'intermediate',
        'Peloton',
        'Connected fitness hardware and software',
        'C',
        'In a razor-and-blades or connected hardware model, the initial hardware sale often just acquires the customer. The true enterprise value comes from the recurring, high-margin software revenue. Therefore, Monthly Subscription Churn is the most critical metric, as it dictates the LTV of the high-margin revenue stream.',
        ARRAY['ltv', 'churn', 'business_model_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Number of bikes sold per quarter.', false),
    (v_q_id, 'B', 'Hardware manufacturing defect rate.', false),
    (v_q_id, 'C', 'Monthly Subscription Churn Rate.', true),
    (v_q_id, 'D', 'Average apparel order value.', false);

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
        'Etsy''s Take Rate Optimization',
        'Etsy increases its seller transaction fee from 5% to 6.5%. The ''Take Rate'' metric improves immediately. Which set of counter-metrics must the PM monitor to ensure this doesn''t destroy the marketplace?',
        'intermediate',
        'Etsy',
        'Handmade goods marketplace',
        'D',
        'Take rate is the percentage of GMV the platform keeps. Increasing it angers supply. The risk is that sellers leave the platform (Seller Churn) or pass the costs to buyers by raising prices, which lowers buyer conversion. Monitoring seller churn and off-platform leakage (sellers taking transactions directly) is critical.',
        ARRAY['marketplace_metrics', 'take_rate', 'counter_metric']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'App load time and crash rates.', false),
    (v_q_id, 'B', 'Customer acquisition cost (CAC) for buyers.', false),
    (v_q_id, 'C', 'Average number of photos uploaded per listing.', false),
    (v_q_id, 'D', 'Seller churn rate, average listing price increases, and off-platform transaction leakage.', true);

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
        'Twitch''s Concurrent Viewers',
        'Twitch relies heavily on the ''Peak Concurrent Viewers'' (PCV) metric. During a massive esports tournament, PCV hits an all-time high, but ad revenue for the month drops 5%. How can this happen?',
        'intermediate',
        'Twitch',
        'Live streaming platform',
        'B',
        'Peak Concurrent Viewers is a ''spiky'' metric that measures a single moment in time. Ad revenue is driven by total minutes watched across the month (inventory). If users tune in for a 2-hour tournament peak but abandon their daily viewing of mid-tier streamers, the peak is high but the aggregate inventory (and revenue) drops.',
        ARRAY['engagement_metrics', 'monetization', 'spiky_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The ad server cannot handle peak loads and crashes during the tournament.', false),
    (v_q_id, 'B', 'PCV measures a single moment; if everyday viewing of mid-tier streamers dropped significantly, total watch minutes (ad inventory) would decline.', true),
    (v_q_id, 'C', 'Esports viewers use ad-blockers at a 100% rate.', false),
    (v_q_id, 'D', 'Twitch pays out more to the esports tournament organizers than they make in ads.', false);

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
        'WhatsApp''s Metric Saturation',
        'WhatsApp has over 2 billion MAUs. A PM notices that overall user growth in Europe has plateaued at 0.5% YoY. Should the PM conclude that the product is failing in Europe?',
        'intermediate',
        'WhatsApp',
        'Messaging application',
        'A',
        'This is metric saturation. In mature markets where a product has achieved near-total market penetration, you mathematically cannot sustain high user growth rates. The PM should shift focus from acquisition metrics to engagement, retention, or monetization metrics (like messages sent per user or business API usage).',
        ARRAY['metric_saturation', 'growth', 'market_penetration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'No, WhatsApp has likely reached market saturation in Europe; focus should shift from acquisition to engagement and utility.', true),
    (v_q_id, 'B', 'Yes, a healthy social app must grow at least 15% YoY indefinitely.', false),
    (v_q_id, 'C', 'No, the PM should only look at DAU, which is probably still doubling.', false),
    (v_q_id, 'D', 'Yes, it indicates that competitors like iMessage are stealing all their users.', false);

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
        'Canva''s True Completion Metric',
        'Canva''s team wants to measure the success of a new template search feature. Which metric represents the ''True Completion'' of the user''s intent?',
        'intermediate',
        'Canva',
        'Design software',
        'C',
        'True Completion metrics measure the actual end goal of the user. A user searches for a template not just to click on it, but to create a design and ultimately export/download it. High click-through on search but low export rate would mean the search results looked good but weren''t actually useful for the final task.',
        ARRAY['task_completion', 'user_intent', 'funnel_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The number of search queries executed per session.', false),
    (v_q_id, 'B', 'The click-through rate (CTR) on the top 3 search results.', false),
    (v_q_id, 'C', 'The percentage of search sessions that result in a downloaded or shared design.', true),
    (v_q_id, 'D', 'The average time spent scrolling through the template library.', false);

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
        'Pinterest''s Engagement Depth',
        'Pinterest considers ''Pins Saved'' a higher value action than ''Pins Viewed''. A new UI change increases ''Pins Viewed'' by 15% but decreases ''Pins Saved'' by 5%. How should the PM evaluate this?',
        'intermediate',
        'Pinterest',
        'Visual discovery engine',
        'D',
        'Not all engagement is equal. ''Views'' are passive, top-of-funnel engagement. ''Saves'' are high-intent, active engagement that builds the user''s board and signals strong preference (driving the algorithm). Trading high-value, deep engagement for low-value, shallow engagement is generally a net negative for long-term retention.',
        ARRAY['engagement_depth', 'metric_tradeoffs', 'core_action']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is a massive success because 15% > 5%, resulting in net positive engagement.', false),
    (v_q_id, 'B', 'It is a success because views drive ad impressions, which is the only thing that matters.', false),
    (v_q_id, 'C', 'The PM should stop tracking Pins Saved as it is too difficult for users to do.', false),
    (v_q_id, 'D', 'It is a negative outcome; the UI change likely created shallow, passive browsing at the expense of high-intent core actions.', true);

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
        'Amazon''s AOV vs Frequency',
        'Amazon Prime wants to maximize Customer LTV. A PM proposes a change that will increase Average Order Value (AOV) by $10, but models show it will decrease order frequency from 4 times a month to 2 times a month. Should they ship it?',
        'intermediate',
        'Amazon',
        'E-commerce platform',
        'B',
        'LTV is driven by AOV * Frequency. If AOV goes up slightly but frequency drops by half, total revenue drops. More importantly, high frequency drives habituation. Amazon Prime''s core moat is being the default habit for shopping. Sacrificing frequency for AOV breaks the habit loop.',
        ARRAY['aov', 'purchase_frequency', 'ltv', 'habituation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, higher AOV always leads to better gross margins.', false),
    (v_q_id, 'B', 'No, halving the frequency destroys total revenue and weakens the user''s shopping habit.', true),
    (v_q_id, 'C', 'Yes, shipping costs will be lower with fewer packages.', false),
    (v_q_id, 'D', 'No, Amazon only cares about Prime subscription revenue, not e-commerce margins.', false);

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
        'Salesforce''s Logo Churn vs Gross Retention',
        'Salesforce reports a ''Logo Churn'' of 10% but a ''Gross Revenue Retention'' of 98%. How is this conceptually possible?',
        'intermediate',
        'Salesforce',
        'CRM enterprise software',
        'C',
        'Logo churn is the percentage of distinct companies that cancel. Gross Revenue Retention measures the percentage of revenue retained from the starting cohort, NOT including expansions. If 10% of small companies churn (representing 2% of total revenue), and the large enterprise accounts stay, logo churn is high but revenue retention remains strong.',
        ARRAY['logo_churn', 'gross_retention', 'b2b_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They are acquiring enough new logos to make up for the 10% loss.', false),
    (v_q_id, 'B', 'The retained customers upgraded their plans, pushing revenue retention to 98%.', false),
    (v_q_id, 'C', 'The 10% of companies that churned were very small accounts, representing only 2% of the starting cohort''s revenue.', true),
    (v_q_id, 'D', 'The calculation is mathematically impossible; Logo Churn and Revenue Churn must be equal.', false);

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
        'GitHub''s Proxy Metrics',
        'GitHub Copilot wants to measure if it makes developers more productive. Since ''productivity'' is subjective, which of the following is the BEST objective proxy metric?',
        'intermediate',
        'GitHub',
        'Developer collaboration platform',
        'C',
        'A proxy metric stands in for something unmeasurable. For developer productivity, lines of code is a terrible metric (encourages bloat). Number of logins is vanity. PR merge time (Time-to-Merge) or the volume of successfully merged PRs per developer is a strong proxy for actual value shipped.',
        ARRAY['proxy_metric', 'productivity', 'b2b_saas']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Total lines of code written per day.', false),
    (v_q_id, 'B', 'Number of times a developer logs into GitHub per week.', false),
    (v_q_id, 'C', 'Decrease in the average time it takes to merge a Pull Request (PR).', true),
    (v_q_id, 'D', 'The number of repositories a developer stars.', false);

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
        'Shopify''s CAC Payback Period',
        'Shopify spends $500 to acquire a merchant. The merchant pays $50/month in subscription fees and generates $10/month in transaction margins. What is the CAC Payback Period?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'B',
        'CAC Payback Period = CAC / (Monthly Gross Margin per User). Here, the monthly margin is $50 (subscription) + $10 (transaction) = $60/month. $500 CAC / $60 per month = 8.33 months. This metric is critical for understanding cash flow and how fast the business can sustainably grow.',
        ARRAY['cac_payback', 'unit_economics', 'cash_flow']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '10 months', false),
    (v_q_id, 'B', '8.33 months', true),
    (v_q_id, 'C', '5 months', false),
    (v_q_id, 'D', '12 months', false);

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
        'Uber''s Surge Pricing Elasticity',
        'Uber''s data science team notices that at a 1.5x surge multiplier, conversion rate drops by 10%. At a 2.0x multiplier, conversion rate drops by 40%. What analytical concept does this demonstrate?',
        'intermediate',
        'Uber',
        'Ride-hailing marketplace',
        'A',
        'This demonstrates Price Elasticity of Demand. As price increases, demand decreases, but the relationship is rarely linear. At a certain threshold (like 2.0x), users perceive the price as completely unreasonable and abandon the app in droves, creating a non-linear drop in conversion.',
        ARRAY['price_elasticity', 'conversion_rate', 'marketplace_economics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Non-linear price elasticity of demand.', true),
    (v_q_id, 'B', 'Simpson''s Paradox.', false),
    (v_q_id, 'C', 'The Network Effect.', false),
    (v_q_id, 'D', 'Cohort degradation.', false);

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
        'Airbnb''s Search-to-Book Funnel',
        E'E'Airbnb''s Search-to-Book funnel looks like this:\n1. Search: 100%\n2. View Listing: 80%\n3. Click Book: 20%\n4. Complete Payment: 18%\n\nWhere is the biggest point of friction, and what does it suggest?'',
        'intermediate',
        'Airbnb',
        'Accommodation marketplace',
        'B',
        'Funnel analysis looks at relative drop-off. Step 1 to 2 retains 80%. Step 2 to 3 drops from 80% to 20% (a 75% relative drop-off). Step 3 to 4 drops from 20% to 18% (a 10% relative drop-off). The massive drop between viewing a listing and clicking book indicates that while listings look appealing in search, the actual listing details (price, photos, reviews, fees) do not persuade users to book.',
        ARRAY['funnel_analysis', 'drop_off', 'conversion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Between Click Book and Complete Payment; users are failing at the credit card screen.', false),
    (v_q_id, 'B', 'Between View Listing and Click Book; the listing details are not convincing users to commit.', true),
    (v_q_id, 'C', 'Between Search and View Listing; the search algorithm is broken.', false),
    (v_q_id, 'D', 'The funnel is perfectly healthy and requires no optimization.', false);

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
        'Netflix''s Incremental Content Valuation',
        'Netflix is deciding whether to renew a niche sci-fi show. It gets 5 million views, but analytics show an ''Incremental Subscriber Value'' near zero. Why would Netflix cancel a show with 5 million views?',
        'advanced',
        'Netflix',
        'Streaming platform',
        'C',
        'In subscription models, viewing hours don''t directly equal revenue. Content is valuable if it acquires new users or prevents existing users from churning. If the 5 million viewers would happily watch other Netflix shows if the sci-fi show didn''t exist, the show generates no ''incremental'' retention value. It simply cannibalizes viewing time from other content without reducing churn.',
        ARRAY['incremental_value', 'cannibalization', 'subscription_economics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The show''s production cost was higher than the ad revenue it generated.', false),
    (v_q_id, 'B', '5 million views is below the absolute threshold for any Netflix show.', false),
    (v_q_id, 'C', 'The viewers would have retained their subscription and watched other content anyway; the show provided no unique retention value.', true),
    (v_q_id, 'D', 'The show had too many negative reviews on external sites like Rotten Tomatoes.', false);

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
        'DoorDash''s Marketplace Cannibalization',
        'DoorDash heavily promotes ''Pickup'' (0% delivery fee). Total orders increase by 5%, but total net revenue drops. The PM runs a cohort analysis. What is the most likely advanced analytical explanation?',
        'advanced',
        'DoorDash',
        'Food delivery marketplace',
        'A',
        'This is a classic cannibalization scenario. The PM hoped Pickup would drive incremental orders from price-sensitive users. Instead, existing high-LTV delivery users (who generate margin via delivery fees and service fees) switched to Pickup to save money. The 5% growth in total volume didn''t offset the massive margin compression from cannibalizing core delivery behavior.',
        ARRAY['cannibalization', 'margin_compression', 'cohort_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High-frequency delivery users cannibalized their own behavior by switching to Pickup, reducing average margin per order faster than volume grew.', true),
    (v_q_id, 'B', 'Restaurants raised their prices on the platform, causing users to churn.', false),
    (v_q_id, 'C', 'The marketing spend to promote Pickup was incorrectly attributed.', false),
    (v_q_id, 'D', 'Drivers quit the platform because there were fewer deliveries to make.', false);

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
        'Spotify''s Royalty Economics',
        'A PM at Spotify notes that if a user listens to 10 hours of music a month, Spotify is highly profitable. If a user listens to 100 hours a month, Spotify loses money on that user. What fundamental metric dynamic causes this?',
        'advanced',
        'Spotify',
        'Audio streaming platform',
        'D',
        'Unlike Netflix, which pays fixed licensing fees for content (zero marginal cost per stream), Spotify pays variable, usage-based royalties to record labels. Their revenue per user is fixed ($10/month), but their COGS (Cost of Goods Sold) scales linearly with consumption. Therefore, ultra-high engagement turns a profitable user into an unprofitable one.',
        ARRAY['marginal_costs', 'cogs', 'unit_economics', 'business_model']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High bandwidth streaming costs increase server expenses exponentially.', false),
    (v_q_id, 'B', 'Users who listen more are more likely to cancel their subscription.', false),
    (v_q_id, 'C', 'The LTV of a high-engagement user is inherently flawed.', false),
    (v_q_id, 'D', 'Revenue is fixed (subscription), but COGS is variable (per-stream royalties), creating negative unit economics at high usage.', true);

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
        'Slack''s Org-Level Network Effects',
        'Slack wants to predict account churn. They find that DAU/MAU isn''t predictive. Instead, they look at ''Cross-Channel Messages Sent per User''. Why is this a better predictor of B2B retention?',
        'advanced',
        'Slack',
        'B2B team communication',
        'B',
        'In B2B SaaS with network effects, deep integration into company workflows is the ultimate moat against churn. DAU just means people log in. ''Cross-channel messaging'' indicates cross-functional collaboration and silobusting (Metcalfe''s law within the org). If an org uses Slack just for isolated teams (low cross-channel), they can easily migrate. If it connects the whole org, switching costs are insurmountable.',
        ARRAY['network_effects', 'switching_costs', 'b2b_churn']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It requires users to type more, which burns more calories.', false),
    (v_q_id, 'B', 'It measures the density of the internal network graph; higher cross-functional communication means higher organizational switching costs.', true),
    (v_q_id, 'C', 'It indicates that the company is large and has a bigger budget.', false),
    (v_q_id, 'D', 'Cross-channel messages use more storage, forcing the company to upgrade to higher tiers.', false);

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
        'Tinder''s Local Liquidity',
        'Tinder has 50,000 active users in New York and 50,000 active users spread evenly across rural Texas. Why does the New York cohort have a 3x higher retention rate despite identical absolute user numbers?',
        'advanced',
        'Tinder',
        'Dating app',
        'A',
        'Dating apps rely on hyper-local network effects. Global or regional user counts are vanity metrics. The critical metric is ''Marketplace Liquidity''—the density of relevant matches within a specific geographic radius. 50k users in a dense city means high liquidity and infinite swiping. 50k users spread across an entire state means a user will run out of nearby matches in minutes, leading to churn.',
        ARRAY['marketplace_liquidity', 'local_network_effects', 'density']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Marketplace liquidity relies on geographic density; New York users have a much deeper pool of relevant matches within a 5-mile radius.', true),
    (v_q_id, 'B', 'Users in New York are inherently more likely to pay for premium features.', false),
    (v_q_id, 'C', 'Rural users prefer desktop applications over mobile apps.', false),
    (v_q_id, 'D', 'The algorithm favors users in urban centers due to a hardcoded bias.', false);

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
        'Airbnb''s Asymmetric Network Effects',
        'Airbnb notices that acquiring a new host in Paris increases bookings from users in London, Berlin, and New York. However, Uber acquiring a new driver in Paris only impacts riders in Paris. What analytical concept defines this difference?',
        'advanced',
        'Airbnb',
        'Accommodation marketplace',
        'C',
        'Uber is a hyper-local marketplace; supply and demand must match geographically in real-time. Airbnb is a cross-border (global) marketplace. The demand side (travelers) relies on global supply. Acquiring supply in a destination market creates value for demand in origin markets. This is an asymmetric, cross-border network effect, requiring entirely different acquisition metrics and strategies than a local marketplace.',
        ARRAY['network_effects', 'marketplace_dynamics', 'cross_border']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Uber is a commoditized marketplace, while Airbnb is highly differentiated.', false),
    (v_q_id, 'B', 'Airbnb has better brand marketing in Europe than Uber.', false),
    (v_q_id, 'C', 'Airbnb operates a cross-border/global network effect, whereas Uber is constrained by hyper-local network effects.', true),
    (v_q_id, 'D', 'Hosts have higher LTV than Uber drivers.', false);

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
        'Figma''s Collaboration Multiplier',
        'Figma tracks ''Multiplayer Sessions'' (2+ people editing the same file concurrently). They find that companies with >20% of sessions being multiplayer have 1/5th the churn of companies with 0% multiplayer sessions. How should a PM act on this data?',
        'advanced',
        'Figma',
        'Collaborative design tool',
        'B',
        'Advanced analytics requires identifying causal drivers of retention. The data proves that real-time collaboration is Figma''s core retention hook. A strategic PM doesn''t just watch the metric; they change the product to drive users toward that behavior. By optimizing the onboarding flow to force or highly incentivize inviting a colleague, you artificially manufacture the high-retention behavior.',
        ARRAY['causal_drivers', 'onboarding_optimization', 'multiplayer_engagement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore it, correlation does not equal causation.', false),
    (v_q_id, 'B', 'Redesign the onboarding funnel to heavily incentivize inviting a colleague to a file within the first 10 minutes of use.', true),
    (v_q_id, 'C', 'Charge a premium fee for multiplayer access since it is highly valued.', false),
    (v_q_id, 'D', 'Focus marketing exclusively on solo designers to balance the user base.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for analytics-kpis';

END $$;
