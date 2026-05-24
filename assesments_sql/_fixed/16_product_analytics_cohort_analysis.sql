-- ============================================
-- ASSESSMENT: Cohort Analysis
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
    WHERE slug = 'cohort-analysis';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug cohort-analysis not found. Run the seed data first.';
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
        'Netflix''s Retention Curve',
        'A Junior PM at Netflix is looking at a standard time-based cohort retention chart for new subscribers. They notice that Month 1 retention is 85%, but by Month 6, it flattens out completely at 60%, staying exactly at 60% through Month 12. What does this flat tail indicate?',
        'foundational',
        'Netflix',
        'Subscription streaming service',
        'B',
        'A flat tail on a retention curve indicates that users who stick around until that point have formed a habit and stop churning. This is the strongest indicator of product-market fit (B is correct). A continuing downward curve would indicate a "leaky bucket". Losing 40% over 6 months is actually excellent for consumer subscriptions. A tracking error would not present as a perfectly flat stabilized line.',
        ARRAY['retention_curve', 'product_market_fit']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The product has poor product-market fit because it lost 40% of its acquired users.', false),
    (v_q_id, 'B', 'The product has reached strong product-market fit with a stable core user base.', true),
    (v_q_id, 'C', 'There is a data tracking error, as retention curves should always decay continuously.', false),
    (v_q_id, 'D', 'The cohort has experienced a negative network effect causing early drop-off.', false);

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
        'Spotify''s Cohort Definition',
        'The Spotify Premium PM wants to understand if users who create their own playlists retain better than users who only listen to pre-made playlists. Which type of cohort analysis should the PM perform?',
        'foundational',
        'Spotify',
        'Audio streaming platform',
        'A',
        'This scenario requires analyzing groups based on specific actions they took (creating a playlist vs. not), which is the definition of a behavioral cohort. Time-based or acquisition cohorts group users by when they joined. Demographic cohorts group by static user traits like age. B2B cohorts are irrelevant for this consumer feature analysis.',
        ARRAY['behavioral_cohorts', 'user_segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Behavioral cohort analysis', true),
    (v_q_id, 'B', 'Acquisition time-based cohort analysis', false),
    (v_q_id, 'C', 'Demographic cohort analysis', false),
    (v_q_id, 'D', 'B2B account-level cohort analysis', false);

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
        'Slack''s Retention Metrics',
        'Slack defines an active user as someone who sends at least one message. The PM sees a metric labeled "Day 7 Retention: 45%". The tooltip explains this counts users who returned on Day 7 OR any day after. What type of retention metric is this?',
        'foundational',
        'Slack',
        'B2B team communication',
        'D',
        'Unbounded retention (or rolling retention) measures users who return on a specific day OR any day thereafter. It tells you the proportion of users who haven''t churned completely by that date. N-day retention measures exactly the specific day (Day 7 only). Bracket retention measures within a time window.',
        ARRAY['retention_metrics', 'unbounded_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'N-day (strict) retention', false),
    (v_q_id, 'B', 'Bracket retention', false),
    (v_q_id, 'C', 'Revenue retention', false),
    (v_q_id, 'D', 'Unbounded (rolling) retention', true);

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
        'Uber''s Cohort Heatmap',
        E'An Uber PM is reviewing a monthly rider cohort heatmap. They notice that the Month 1 retention across the columns reads: Jan (40%), Feb (38%), Mar (35%), Apr (32%).\n\nWhat trend does this indicate?',
        'foundational',
        'Uber',
        'Ride-hailing marketplace',
        'B',
        'Reading down the "Month 1" column across different acquisition months (Jan, Feb, Mar, Apr) tracks how the initial retention of new cohorts changes over time. Because the percentage is dropping (40% to 32%), it means newer cohorts are degrading and retaining worse than older ones. It doesn''t speak to the long-term tail or frequency, just the early drop-off of newer signups.',
        ARRAY['cohort_heatmap', 'cohort_degradation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users are churning heavily in Month 1 but stabilizing in Month 2.', false),
    (v_q_id, 'B', 'Newer acquisition cohorts are degrading and retaining worse over time.', true),
    (v_q_id, 'C', 'The product has achieved a strong network effect.', false),
    (v_q_id, 'D', 'Users from January are riding less frequently by April.', false);

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
        'Airbnb''s User Lifecycle',
        'Airbnb categorizes users into a lifecycle framework to run cohort analysis. A PM sees a segment labeled "Reactivated". What does this category represent in standard lifecycle analysis?',
        'foundational',
        'Airbnb',
        'Travel booking marketplace',
        'C',
        'In lifecycle analysis, a "Reactivated" (or resurrected) user is someone who was previously active, became inactive (churned/dormant) for a defined period, and then returned to active status. Option A is a New user. Option B is an Active/Retained user. Option D is a Churned/Dormant user.',
        ARRAY['lifecycle_analysis', 'resurrection']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users who created an account but never made a booking.', false),
    (v_q_id, 'B', 'Users who booked in the previous period and booked again in the current period.', false),
    (v_q_id, 'C', 'Users who were inactive in the previous period but returned to book in the current period.', true),
    (v_q_id, 'D', 'Users who have not opened the app for more than 12 months.', false);

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
        'Notion''s Definition of Active',
        'A Notion PM is building a cohort retention dashboard. They initially define "Active" as opening the Notion app. Retention looks incredibly high at 85% for Day 30, but revenue and engagement are dropping. What is the PM''s primary mistake?',
        'foundational',
        'Notion',
        'Productivity workspace',
        'C',
        'Defining "Active" simply as opening the app is a vanity metric that overstates true retention. A meaningful retention event should reflect core value exchange—for Notion, that means creating or editing a block. Using a shallow event inflates numbers while missing the actual engagement drop that correlates with revenue.',
        ARRAY['retention_event', 'active_users', 'vanity_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They chose Day 30 instead of Day 1, masking early churn.', false),
    (v_q_id, 'B', 'They failed to segment the users by their acquisition channel.', false),
    (v_q_id, 'C', 'They used a shallow vanity metric (app open) instead of a core value action (editing a page).', true),
    (v_q_id, 'D', 'They ignored the difference between desktop and mobile users.', false);

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
        'Tinder''s Natural Churn',
        'A PM at Tinder notices that even their most successful acquisition cohorts eventually see a complete drop-off in retention after 6-12 months. What is the most likely analytical explanation for this?',
        'foundational',
        'Tinder',
        'Dating app',
        'A',
        'Dating apps have a natural lifecycle where success (finding a partner) leads to churn. This is known as "success churn" or "structural churn." The core value proposition of the product naturally limits the lifetime of the user. It does not necessarily indicate a flawed onboarding, tracking error, or lack of critical mass.',
        ARRAY['natural_frequency', 'success_churn', 'lifecycle_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The product has success churn, where achieving the core goal results in users leaving the app.', true),
    (v_q_id, 'B', 'Tinder has a flawed onboarding process that only becomes apparent months later.', false),
    (v_q_id, 'C', 'There is a systemic data pipeline failure purging old user records.', false),
    (v_q_id, 'D', 'The app failed to reach critical mass in the users'' local geographies.', false);

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
        'Discord''s Metric Hierarchy',
        'Discord''s leadership is reviewing a slide showing MAU (Monthly Active Users) has grown by 15% month-over-month. The PM argues that MAU alone is misleading and insists on viewing the cohort retention table. Why is the PM correct?',
        'foundational',
        'Discord',
        'Community communication platform',
        'C',
        'MAU is an aggregate metric that blends new user acquisition, retention, and resurrection. A product can mask a terrible "leaky bucket" (awful retention) by simply dumping huge amounts of money into marketing to acquire new users. Cohort analysis isolates retention by tracking specific groups over time, revealing the true health of the product.',
        ARRAY['mau', 'cohort_vs_aggregate', 'vanity_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'MAU only counts unique users, which double-counts desktop and mobile users.', false),
    (v_q_id, 'B', 'Cohort tables are the only way to calculate Customer Acquisition Cost (CAC).', false),
    (v_q_id, 'C', 'MAU can grow through aggressive acquisition even if the product is bleeding existing users heavily.', true),
    (v_q_id, 'D', 'Discord''s MAU definition includes bots, whereas cohorts automatically exclude them.', false);

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
        'Peloton''s Interval Selection',
        'A PM at Peloton is setting up the default retention charts. They must choose the time interval to group cohorts (Daily, Weekly, or Monthly). Given Peloton''s core use case of personal fitness, which interval is most appropriate?',
        'foundational',
        'Peloton',
        'Connected fitness',
        'B',
        'The cohort interval should match the natural frequency of the product''s core use case. Fitness is generally a weekly habit (working out a few times a week). Daily is too noisy (most users take rest days), and Monthly is too broad (misses the nuance of habit formation).',
        ARRAY['natural_frequency', 'cohort_interval']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Daily, because PMs should track the most granular data possible.', false),
    (v_q_id, 'B', 'Weekly, because fitness routines generally operate on a weekly habit cycle.', true),
    (v_q_id, 'C', 'Monthly, because hardware subscription billing happens monthly.', false),
    (v_q_id, 'D', 'Yearly, because users buy expensive bikes as a long-term investment.', false);

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
        'DoorDash''s Acquisition Cohorts',
        'When looking at an acquisition cohort table for DoorDash, the PM sees the "January" row. What exactly does this row represent?',
        'foundational',
        'DoorDash',
        'Food delivery',
        'C',
        'An acquisition cohort groups users based on the time they first took a significant action, usually sign-up or first purchase. The row represents the specific group of all users who joined or ordered for the first time in January, tracking their behavior in subsequent months.',
        ARRAY['acquisition_cohorts', 'reading_cohorts']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'All users who ordered food in January, regardless of when they signed up.', false),
    (v_q_id, 'B', 'The revenue generated in January by all active cohorts.', false),
    (v_q_id, 'C', 'The group of users whose first sign-up or first order occurred in January.', true),
    (v_q_id, 'D', 'The users who churned in January.', false);

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
        'Stripe''s Composition Bias',
        'Stripe''s overall Day 30 retention has dropped from 75% to 65% over three months. However, when the PM splits cohorts by segment (Enterprise vs. SMB), Day 30 retention for Enterprise is stable at 85%, and SMB is stable at 50%. How is it possible that overall retention dropped?',
        'intermediate',
        'Stripe',
        'Payment processing infrastructure',
        'B',
        'This is a classic example of Simpson''s Paradox driven by composition bias. If the underlying segment retention is stable, but the overall aggregate drops, it means the mix of acquired users has shifted toward the lower-retaining segment. Stripe is likely acquiring a much higher proportion of SMBs than they used to.',
        ARRAY['simpsons_paradox', 'composition_bias', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Enterprise users are churning at a slower rate than SMB users.', false),
    (v_q_id, 'B', 'The proportion of SMB users in the new acquisition cohorts has significantly increased.', true),
    (v_q_id, 'C', 'There is a systemic tracking error in the overall aggregate calculation.', false),
    (v_q_id, 'D', 'SMB users are upgrading to Enterprise tiers, shifting the numbers.', false);

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
        'Shopify''s B2B Benchmarks',
        'A PM moving from Tinder to Shopify is alarmed to see that Shopify''s Month 12 retention for merchants is 45%. They propose an emergency task force to fix the "leaky bucket," noting Tinder aimed for far different curves. What is the PM failing to understand?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'A',
        'Retention benchmarks vary wildly by industry. B2B SaaS (like Shopify) often sees Month 12 retention of 40-60%, whereas consumer social apps might see 10-20% at Month 12. More importantly, 45% is a healthy benchmark for SMB SaaS, especially since SMBs naturally fail (business closures). Panic is unwarranted without comparing to B2B benchmarks.',
        ARRAY['b2b_vs_b2c', 'benchmarks', 'retention_curve']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Industry benchmarks: 45% annual retention is incredibly healthy for an SMB B2B platform.', true),
    (v_q_id, 'B', 'Tinder relies on daily use, while Shopify merchants only log in weekly.', false),
    (v_q_id, 'C', 'Shopify is a marketplace, so they must look at buyer retention, not merchant retention.', false),
    (v_q_id, 'D', 'The PM is confusing Month 12 retention with Net Dollar Retention.', false);

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
        'Zoom''s COVID Shift',
        'In mid-2021, Zoom''s PMs analyzed cohort retention. The Q2 2020 cohort (start of COVID) had massive volume but stabilized at a 20% long-term retention rate. The Q2 2021 cohort was much smaller in volume but stabilized at 45%. What is the best interpretation of this data?',
        'intermediate',
        'Zoom',
        'Video conferencing',
        'D',
        'Massive macro-events (like COVID lockdowns) bring in a surge of low-intent or temporary users who otherwise wouldn''t use the product, dragging down percentage retention for that cohort. Once the anomaly passes, the smaller volume of acquired users represents the higher-intent core demographic, returning percentage retention to normal/higher levels.',
        ARRAY['macro_trends', 'cohort_quality', 'anomalies']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Zoom''s product quality degraded significantly during 2020.', false),
    (v_q_id, 'B', 'The pricing changes in 2021 successfully weeded out free users.', false),
    (v_q_id, 'C', 'Zoom achieved network effects in 2021 that didn''t exist in 2020.', false),
    (v_q_id, 'D', 'The 2020 cohort was flooded with low-intent users driven by temporary macro-conditions.', true);

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
        'Duolingo''s Smile Retention',
        E'A Duolingo PM notices a rare phenomenon on older cohorts: the retention curve drops from Month 1 to Month 6, flattens, and then actually starts curving *upward* in Month 12 and beyond.\n\nWhat mechanism causes this "smile" curve?',
        'intermediate',
        'Duolingo',
        'Language learning app',
        'A',
        'A "smile" retention curve occurs when resurrected users (those returning after a long absence) outnumber the users churning in the long tail. For a product like Duolingo, users often take breaks and then return later for a New Year''s resolution or upcoming trip, causing older cohorts to see an uptick in active users.',
        ARRAY['smile_retention', 'resurrection', 'lifecycle_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High rates of resurrection, where long-dormant users become active again.', true),
    (v_q_id, 'B', 'An error in tracking where new users are being assigned to old cohorts.', false),
    (v_q_id, 'C', 'The product is experiencing negative churn from users upgrading to paid tiers.', false),
    (v_q_id, 'D', 'Users are spending longer session times in the app as they advance levels.', false);

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
        'Canva''s Activation Milestone',
        'Canva''s PM isolates two behavioral cohorts: \n1. Users who exported a design within 24 hours of signup.\n2. Users who only browsed templates within 24 hours.\nCohort 1 has 60% M3 retention; Cohort 2 has 15% M3 retention. What is the most rigorous next step for the PM?',
        'intermediate',
        'Canva',
        'Graphic design tool',
        'C',
        'Behavioral cohorts show correlation, not causation. Users who export early might inherently be higher-intent users. To prove that forcing users to export *causes* higher retention, the PM must run an A/B test guiding users to the "Aha!" moment (exporting) to see if it moves the baseline. Changing the UI or relying blindly on the correlation is a common PM trap.',
        ARRAY['behavioral_cohorts', 'aha_moment', 'correlation_vs_causation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately redesign the onboarding flow to force all users to export a design.', false),
    (v_q_id, 'B', 'Stop acquiring users who only browse templates to improve overall metrics.', false),
    (v_q_id, 'C', 'Run an A/B test nudging users to export to see if it causes higher retention or just correlates with high intent.', true),
    (v_q_id, 'D', 'Change the definition of an active user to strictly require an export.', false);

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
        'Spotify''s Channel Impact',
        'Spotify ran a massive paid influencer campaign in August. The August acquisition cohort is 3x larger than July. However, August Month 1 retention is 15% lower than July. Does this mean the August marketing campaign was a failure?',
        'intermediate',
        'Spotify',
        'Audio streaming platform',
        'D',
        'Paid campaigns usually bring in lower-intent, marginal users, driving down the percentage retention. However, if the sheer volume of users acquired is massive, the absolute number of retained, paying users might still result in high positive ROI. A PM must look at total absolute retained volume and LTV/CAC, not just the percentage drop.',
        ARRAY['acquisition_channels', 'cohort_quality', 'ltv_cac']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, a 15% drop in retention indicates the influencers attracted bots.', false),
    (v_q_id, 'B', 'Yes, because product-market fit has clearly degraded in August.', false),
    (v_q_id, 'C', 'No, because July is generally a slow month for streaming music.', false),
    (v_q_id, 'D', 'Not necessarily, because the absolute number of retained users might be much higher, yielding positive ROI.', true);

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
        'Robinhood''s Survivorship Bias',
        'A Robinhood PM analyzes the Q1 2021 cohort. They notice that the "average portfolio size" of users in this cohort increases month over month steadily for two years. The PM concludes that Robinhood effectively encourages users to deposit more money over time. What analytical flaw might be present?',
        'intermediate',
        'Robinhood',
        'Stock trading app',
        'A',
        'This is classic survivorship bias. Users with small portfolios (low intent) churn early. Users with large portfolios stay. Even if no one deposits a single new dollar, the average portfolio size of the remaining cohort will mathematically rise because the bottom tier dropped out. The PM must look at the behavior of a fixed set of surviving users.',
        ARRAY['survivorship_bias', 'cohort_metrics', 'analytical_flaws']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Survivorship bias: Users with smaller portfolios churn out, artificially raising the average of those left.', true),
    (v_q_id, 'B', 'Confirmation bias: The PM is looking at portfolio size instead of trading volume.', false),
    (v_q_id, 'C', 'Cohort degradation: The Q1 2021 cohort is likely worse than Q1 2020.', false),
    (v_q_id, 'D', 'Market bias: The stock market naturally goes up over time.', false);

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
        'Discord''s Network Effects',
        E'A PM at Discord compares the Month 6 retention of cohorts from 2018 vs. cohorts from 2022. The 2018 cohort had 30% Month 6 retention. The 2022 cohort has 55% Month 6 retention.\n\nAssuming the core product functionality is identical, what primarily explains this cohort improvement?',
        'intermediate',
        'Discord',
        'Gaming communication platform',
        'B',
        'When newer cohorts systematically retain better over time without massive product changes, it is usually the hallmark of a strong network effect. As the platform gains more users, the value to a new user joining in 2022 is much higher (because all their friends are already there) than to a user joining in 2018.',
        ARRAY['network_effects', 'cohort_improvement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The novelty effect has finally worn off.', false),
    (v_q_id, 'B', 'Strong network effects increase the value of the platform for newer users.', true),
    (v_q_id, 'C', 'Survivorship bias in the data tracking system.', false),
    (v_q_id, 'D', 'Users in 2022 are intrinsically more likely to play video games.', false);

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
        'Shopify''s Net Dollar Retention',
        'A Shopify PM reports that the Q3 cohort has a Month 12 User Retention of 65%, but a Month 12 Net Dollar Retention (NDR) of 115%. How should leadership interpret this?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'C',
        'Net Dollar Retention (NDR) measures the revenue retained from a cohort, including upgrades and cross-sells, minus churn and downgrades. If NDR is >100%, it means the revenue generated by the surviving users upgrading (expansion revenue) outpaces the revenue lost from the 35% of users who churned. This is highly positive.',
        ARRAY['net_dollar_retention', 'revenue_cohorts', 'b2b_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The data is wrong; NDR cannot mathematically exceed 100%.', false),
    (v_q_id, 'B', '35% of users are paying 115% more for their subscriptions.', false),
    (v_q_id, 'C', 'The expansion revenue from retained users outpaces the revenue lost from churned users.', true),
    (v_q_id, 'D', 'Shopify is losing money on 35% of the cohort.', false);

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
        'Slack''s Account vs User',
        'A Slack PM looks at two cohort tables for the same enterprise clients. The "Account-Level Retention" shows 98% at Month 12. The "User-Level Retention" shows 60% at Month 12. Why is there such a vast difference?',
        'intermediate',
        'Slack',
        'Enterprise communication',
        'A',
        'In B2B SaaS, Account retention tracks if the company renews the contract. User retention tracks individual employees. Employees leave the company, get fired, or switch roles, leading to natural user-level churn. However, the company (Account) still uses Slack, keeping Account-level retention incredibly high.',
        ARRAY['b2b_vs_b2c', 'account_retention', 'user_retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Individual employees naturally turn over at companies, but the companies themselves keep their Slack contracts.', true),
    (v_q_id, 'B', 'Accounts are billed annually, while users log in daily.', false),
    (v_q_id, 'C', 'Users are deleting their accounts to circumvent pricing limits.', false),
    (v_q_id, 'D', 'Slack has poor product-market fit for end-users but high lock-in for IT buyers.', false);

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
        'Tinder''s Negative Churn Trap',
        'A junior PM at Tinder reports they have achieved "Negative Churn" because the number of right swipes per retained user is increasing month-over-month in a cohort. What concept is the PM misunderstanding?',
        'intermediate',
        'Tinder',
        'Dating app',
        'D',
        'Negative churn is strictly a revenue metric (when expansion revenue exceeds lost revenue from churners). Engagement metrics (like swipes) cannot have "negative churn." An increase in swipes per user is simply increased engagement or a symptom of survivorship bias (power users stay).',
        ARRAY['negative_churn', 'engagement_metrics', 'vanity_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tinder users cannot swipe more over time due to algorithmic limiting.', false),
    (v_q_id, 'B', 'Right swipes are a lagging indicator, not a leading indicator.', false),
    (v_q_id, 'C', 'Negative churn requires the user base to grow, not just the swipes.', false),
    (v_q_id, 'D', 'Negative churn strictly applies to revenue (NDR > 100%), not engagement metrics.', true);

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
        'Uber''s Two-Sided Cohorts',
        'An Uber Marketplace PM notices that Driver Cohort retention in Chicago is dropping heavily in Month 2. Rider Cohort retention is completely stable. What is the most likely marketplace dynamic causing this?',
        'intermediate',
        'Uber',
        'Ride-hailing marketplace',
        'A',
        'In a two-sided marketplace, if demand (Riders) remains stable but supply (Drivers) drops, drivers are likely finding it unprofitable to drive or are switching to a competitor (like Lyft) that offers better incentives. If there was a tech bug, it would likely hit both sides or limit riders. Fares dropping would increase riders.',
        ARRAY['marketplace_metrics', 'two_sided_markets', 'supply_demand']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Competitors are offering aggressive driver incentives, stealing supply.', true),
    (v_q_id, 'B', 'Riders are taking fewer trips, starving the drivers of revenue.', false),
    (v_q_id, 'C', 'A bug in the rider app is preventing ride requests.', false),
    (v_q_id, 'D', 'Uber''s algorithm is over-subsidizing rider fares.', false);

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
        'Peloton''s Hardware vs Software',
        'Peloton tracks two cohorts: "App-only users" and "Bike-owners". The App-only M12 retention is 20%. The Bike-owner M12 retention is 85%. What is the primary product principle driving this massive difference?',
        'intermediate',
        'Peloton',
        'Connected fitness',
        'B',
        'Sunk cost fallacy and physical presence (a $2000 bike in your living room) create immense friction to churn. App-only users have zero sunk costs and face no friction to cancel a $13/month subscription. Hardware intrinsically drives lock-in.',
        ARRAY['lock_in', 'sunk_cost', 'hardware_vs_software']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Bike owners are inherently more fit than app users.', false),
    (v_q_id, 'B', 'High upfront sunk cost and hardware presence create massive friction to churn.', true),
    (v_q_id, 'C', 'The app has a severely degraded UX compared to the bike tablet.', false),
    (v_q_id, 'D', 'App users do not experience network effects.', false);

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
        'DoorDash''s Bracket Retention',
        'DoorDash defines bracket retention to account for casual users. The PM sets the brackets as Day 0 (First order), Days 1-7, Days 8-14, and Days 15-30. Why use brackets instead of strict N-Day retention?',
        'intermediate',
        'DoorDash',
        'Food delivery',
        'C',
        'Unlike an email app used strictly daily, food delivery has a flexible frequency. A user might order on Day 6, or Day 8. Strict N-day (e.g., checking Day 7 exactly) will falsely mark users as churned just because they ordered on a Tuesday instead of a Monday. Brackets capture flexible usage windows.',
        ARRAY['bracket_retention', 'natural_frequency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Brackets automatically exclude dormant users from the denominator.', false),
    (v_q_id, 'B', 'Brackets artificially inflate retention numbers to present to investors.', false),
    (v_q_id, 'C', 'Users don''t order food on an exact daily schedule; brackets capture natural usage fluctuations.', true),
    (v_q_id, 'D', 'Strict N-day retention is computationally too expensive for DoorDash''s data team.', false);

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
        'Spotify''s Metric Definition',
        'A Spotify PM tracks the metric "Percentage of W1 retained users who listened to at least 3 podcasts". If the metric jumps from 10% to 40% in the newest cohort, but overall W1 retention stays flat, what happened?',
        'intermediate',
        'Spotify',
        'Audio streaming',
        'B',
        'The overall cohort size and retention didn''t change, but the *behavior* within the retained segment did. This means the core user base shifted their usage patterns to include podcasts (feature adoption), even though it didn''t bring in new retained users at a macro level.',
        ARRAY['feature_adoption', 'behavioral_cohorts', 'engagement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Podcasts are driving significantly higher overall retention for Spotify.', false),
    (v_q_id, 'B', 'Existing retained users are adopting a new feature at a higher rate.', true),
    (v_q_id, 'C', 'The newest cohort is much smaller than previous cohorts.', false),
    (v_q_id, 'D', 'Users who don''t listen to podcasts are churning faster.', false);

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
        'Notion''s B2B Expansion',
        E'Notion tracks a cohort of 100 enterprise companies acquired in January. By December, only 60 companies remain (40% logo churn). However, the number of active daily users from this cohort has doubled since January.\n\nWhat is the mechanism at play?',
        'intermediate',
        'Notion',
        'Productivity workspace',
        'C',
        'In B2B product-led growth (PLG), "Seat Expansion" occurs when a product spreads virally within an enterprise. Even if 40% of the companies (logos) churned, the remaining 60 companies expanded their usage so massively (e.g., from 10 seats to 100 seats per company) that total users doubled. This is typical for land-and-expand SaaS.',
        ARRAY['seat_expansion', 'logo_churn', 'b2b_metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Resurrection: Churned companies came back with more employees.', false),
    (v_q_id, 'B', 'Network density: The 40% of churned users transferred to the remaining 60 companies.', false),
    (v_q_id, 'C', 'Seat expansion: The retained companies deployed Notion to much larger internal teams.', true),
    (v_q_id, 'D', 'Tracking error: You cannot have user growth if logo retention drops.', false);

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
        'Airbnb''s Re-booking Cohorts',
        'Airbnb tracks cohorts by the month of their *first booking*. A PM wants to see if users who book "Experiences" alongside their first "Stay" retain better. They find these users have 2x the 12-month re-booking rate. Is it safe to enforce Experiences in onboarding?',
        'intermediate',
        'Airbnb',
        'Travel booking marketplace',
        'B',
        'Again, correlation does not equal causation. Users who spend more money and time to book both a Stay and an Experience are intrinsically "power users" or luxury travelers. Forcing a casual budget traveler to look at Experiences during onboarding won''t magically turn them into a high-retaining power user; it might actually cause onboarding friction and churn.',
        ARRAY['correlation_vs_causation', 'onboarding', 'behavioral_cohorts']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, because the data clearly shows a 2x lift in LTV.', false),
    (v_q_id, 'B', 'No, because users booking Experiences likely have higher disposable income and intent to travel, skewing the baseline.', true),
    (v_q_id, 'C', 'Yes, but only if they A/B test the UI of the Experiences tab.', false),
    (v_q_id, 'D', 'No, because Airbnb is primarily a Stay marketplace, and Experiences cannibalize revenue.', false);

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
        'Zoom''s Freemium Degradation',
        'Zoom launches a new free tier limit. The new cohort is 5x larger than the previous month, but Month 3 retention plummets from 40% to 15%. However, the total number of paying subscribers in Month 3 from this new cohort is 20% higher than the old cohort. What is the PM''s takeaway?',
        'intermediate',
        'Zoom',
        'Video conferencing',
        'C',
        'When you widen the top of the funnel (e.g., generous freemium), you acquire many low-intent users, crashing the *percentage* retention. However, if the sheer volume of the cohort is large enough, the absolute yield of retained, paying users can still increase. 15% of 500k is greater than 40% of 100k. The PM should focus on absolute yield and revenue, not just the percentage drop.',
        ARRAY['freemium', 'absolute_vs_relative', 'funnel_expansion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The free tier was a failure because core retention plummeted to 15%.', false),
    (v_q_id, 'B', 'Zoom should revert the change because free users are straining server capacity.', false),
    (v_q_id, 'C', 'The strategy is successful; widening the top of funnel sacrificed percentage retention but increased absolute yield.', true),
    (v_q_id, 'D', 'The PM should redefine "active user" to exclude free tier users.', false);

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
        'Airbnb''s Seasonal Masking',
        E'An Airbnb PM analyzes retention cohorts over a 12-month period. They notice that across *every single acquisition cohort*, there is a sudden, sharp spike in active users exactly in July, followed by a severe drop in August.\n\nWhat analytical technique must the PM use to understand true cohort decay?',
        'advanced',
        'Airbnb',
        'Travel booking marketplace',
        'B',
        'Travel is highly seasonal. The July spike is a macro-seasonal effect acting across all cohorts simultaneously, masking the true underlying decay of the cohorts. To see true retention, the PM must control for seasonality (e.g., using Year-over-Year cohort comparisons or seasonal decomposition) to separate the natural churn from the summer travel boom.',
        ARRAY['seasonality', 'cohort_decay', 'data_smoothing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Eliminate all users who booked in July from the denominator to clean the data.', false),
    (v_q_id, 'B', 'Apply seasonal decomposition or Year-over-Year index comparisons to isolate the underlying decay trend.', true),
    (v_q_id, 'C', 'Switch from unbounded retention to strict N-day retention to ignore the July variance.', false),
    (v_q_id, 'D', 'Redefine the cohort start date to July for all users.', false);

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
        'Canva''s Feature Cannibalization',
        'Canva launches an AI image generator. The PM creates a behavioral cohort: "Used AI Generator." This cohort shows incredible 30-day retention of the AI feature. However, the overall Canvas product retention remains totally flat, and retention of the "Stock Photo Search" feature drops by 40%. What is happening?',
        'advanced',
        'Canva',
        'Graphic design tool',
        'D',
        'This is feature cannibalization. The new feature is highly engaging, but it is not driving incremental retention for the product overall; it is simply shifting existing retained users away from an older feature (Stock Photo Search). The AI feature is a substitute, not an additive growth lever for the overall product.',
        ARRAY['feature_cannibalization', 'incremental_retention', 'behavioral_cohorts']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The AI feature is driving net-new growth, but the Stock Photo team is failing.', false),
    (v_q_id, 'B', 'Users are overwhelmed by choice, causing them to churn from the overall product.', false),
    (v_q_id, 'C', 'The AI cohort is suffering from composition bias skewing the overall metrics.', false),
    (v_q_id, 'D', 'The new feature is cannibalizing engagement from an old feature without driving incremental retention for the platform.', true);

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
        'Shopify''s Multi-Dimensional Cohorts',
        'A Senior PM at Shopify wants to forecast LTV accurately. They know that retention varies wildly. To build the most predictive model, they segment the acquisition cohorts by "Geography", "Acquisition Channel", and "Merchant Category" simultaneously. What statistical risk does this multi-dimensional cohorting introduce?',
        'advanced',
        'Shopify',
        'E-commerce platform',
        'B',
        'When you slice cohorts across too many dimensions (e.g., SMBs from Brazil acquired via Facebook Ads selling pet food), the sample size of each specific cell becomes too small. This leads to high variance and statistical noise, making the retention curves erratic and useless for predicting long-term LTV.',
        ARRAY['multi_dimensional_cohorts', 'sample_size', 'variance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Simpson''s Paradox: The sub-segments will always look worse than the aggregate.', false),
    (v_q_id, 'B', 'Sample size sparsity: Slicing too thin creates high variance and statistical noise in the retention curves.', true),
    (v_q_id, 'C', 'Survivorship Bias: Only the best merchants will have data across all three dimensions.', false),
    (v_q_id, 'D', 'Left Truncation: Older cohorts will not map to the new categorical dimensions.', false);

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
        'Netflix''s Left Truncation Bias',
        E'Netflix migrated to a new analytics tool in 2020. The PM builds a cohort analysis starting from 2020. They notice that the "2016 signup cohort" (tracked from 2020 onwards) has a seemingly impossible Month-to-Month retention rate of 99.8%, far higher than the 2020 cohort.\n\nWhat data bias explains this?',
        'advanced',
        'Netflix',
        'Subscription streaming',
        'C',
        'This is Left Truncation (or survival bias). Because the tracking started in 2020, the PM is only seeing the users from 2016 who survived for 4 years to make it into the new system. All the casual 2016 users churned years ago. Comparing the hyper-loyal survivors of an old cohort to a fresh new cohort is mathematically flawed.',
        ARRAY['left_truncation', 'survival_bias', 'analytics_migration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The 2016 cohort had better content options, leading to inherently higher LTV.', false),
    (v_q_id, 'B', 'The new analytics tool fails to properly calculate unbounded retention.', false),
    (v_q_id, 'C', 'Left truncation: The 2016 users tracked in 2020 are exclusively the hyper-loyal 4-year survivors.', true),
    (v_q_id, 'D', 'The 2020 cohort is exhibiting right-censoring bias.', false);

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
        'Uber''s Liquidity Effect on Cohorts',
        E'Uber launches in two cities simultaneously. City A acquires 10,000 riders and 100 drivers. City B acquires 1,000 riders and 100 drivers.\n\nA PM looks at the Rider Month 1 retention: City A is at 12%, City B is at 45%.\n\nWhat marketplace principle drives this discrepancy?',
        'advanced',
        'Uber',
        'Ride-hailing marketplace',
        'A',
        'In a marketplace, liquidity is the product. City A has terrible liquidity (100 riders fighting for 1 driver). Riders experience massive wait times and surge pricing, leading to churn. City B has great liquidity (10 riders per driver), leading to fast pickups and high retention. Acquisition volume without matching supply destroys marketplace cohorts.',
        ARRAY['marketplace_liquidity', 'supply_demand', 'cohort_quality']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Marketplace liquidity: City A had far too much demand for the supply, causing a terrible UX and high churn.', true),
    (v_q_id, 'B', 'City A hit the saturation point of the local geographic market faster.', false),
    (v_q_id, 'C', 'City B exhibits the novelty effect, which will wear off by Month 2.', false),
    (v_q_id, 'D', 'City A has a lower natural frequency of ride-hailing needs.', false);

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
        'Slack''s Predictive LTV',
        'A Data PM at Slack needs to predict the 5-year LTV of a cohort that is only 3 months old. They fit a power-law curve to the first 3 months of retention data and project it forward. What is the most critical risk of this methodology?',
        'advanced',
        'Slack',
        'B2B Communication',
        'C',
        'Projecting early retention via a curve fit assumes the churn behavior remains constant. In SaaS, retention often hits a "floor" where it stabilizes (PMF), or it could drop suddenly at Month 12 when annual contracts expire. Extrapolating a power curve without accounting for contract cliffs or structural baseline stabilization leads to wildly inaccurate LTV models.',
        ARRAY['predictive_ltv', 'curve_fitting', 'contract_churn']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Power-law curves always underestimate the initial Month 1 churn.', false),
    (v_q_id, 'B', 'LTV can only be calculated using Net Dollar Retention, not user retention curves.', false),
    (v_q_id, 'C', 'It ignores structural churn events like Month 12 annual contract renewals that drastically alter the curve later.', true),
    (v_q_id, 'D', 'Cohorts younger than 6 months cannot mathematically be fitted to a curve.', false);

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
        'Duolingo''s Causal Inference',
        E'Duolingo wants to know if completing a "Streak Freeze" tutorial *causes* higher 30-day cohort retention. \n\nA PM uses Propensity Score Matching (PSM) to match users who took the tutorial with identical users who didn''t, based on Day 1 activity levels. The matched tutorial cohort retains 15% better.\n\nHas the PM proven causality?',
        'advanced',
        'Duolingo',
        'Language learning app',
        'B',
        'Propensity Score Matching controls for observable variables (like Day 1 activity), but it cannot control for unobservable variables (like a user''s intrinsic underlying motivation). Users who choose to take an optional tutorial are inherently more motivated. The only way to prove causality is a randomized controlled trial (A/B test).',
        ARRAY['causal_inference', 'propensity_score_matching', 'ab_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, Propensity Score Matching completely isolates the causal impact of the tutorial.', false),
    (v_q_id, 'B', 'No, PSM cannot account for unobservable variables like intrinsic user motivation.', true),
    (v_q_id, 'C', 'Yes, as long as the sample size is statistically significant at a 95% confidence interval.', false),
    (v_q_id, 'D', 'No, because 30-day retention is too short a window to measure the impact of a tutorial.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Cohort Analysis';

END $$;
