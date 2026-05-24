-- ============================================
-- ASSESSMENT: A/B Testing
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
    WHERE slug = 'ab-testing';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug ab-testing not found. Run the seed data first.';
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
        'Netflix''s Minimum Detectable Effect',
        E'Netflix''s Growth PM wants to test a new "Skip Intro" button design. The current conversion rate to click the button is 40%. The PM wants to be able to detect a relative improvement of 1% (Minimum Detectable Effect). The data scientist says this will take 4 weeks to gather enough sample size. The PM asks, "Can we just run it for 2 weeks?"\n\nWhat is the statistically correct response?',
        'foundational',
        'Netflix',
        'Video streaming platform',
        'C',
        'To detect a smaller effect size (MDE), you need a larger sample size, which requires running the test longer. Cutting the test duration in half reduces the sample size, which drops the statistical power of the test. This means the test will be less likely to detect the 1% improvement even if it truly exists. Option A incorrectly implies significance is just about time, not sample. Option B confuses MDE with alpha (false positive rate). Option D incorrectly states MDE is fixed.',
        ARRAY['sample_size', 'minimum_detectable_effect', 'power']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, but the p-value will automatically double, increasing the chance of a false positive.', false),
    (v_q_id, 'B', 'Yes, but we will have to increase our acceptable false positive rate (alpha) to 10% to keep the same MDE.', false),
    (v_q_id, 'C', 'No, reducing duration decreases the sample size, which reduces the test''s power to detect a 1% effect.', true),
    (v_q_id, 'D', 'No, because the Minimum Detectable Effect is mathematically fixed by the baseline conversion rate of 40%.', false);

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
        'Spotify''s P-value Interpretation',
        E'Spotify runs a 2-week test on a new playlist recommendation algorithm. The primary metric (Average Listening Time) shows a +2% lift with a p-value of 0.08. The team had pre-agreed to a significance level (alpha) of 0.05.\n\nHow should the PM interpret this result?',
        'foundational',
        'Spotify',
        'Audio streaming platform',
        'B',
        'Because the p-value (0.08) is strictly greater than the pre-agreed alpha (0.05), the test failed to reach statistical significance. This means we cannot confidently rule out that the observed 2% lift is merely due to random chance. Option A is the classic inverse probability fallacy of p-values. Option C is a dangerous peeking practice that artificially inflates false positives. Option D incorrectly assumes a non-significant result means the feature is actively harmful.',
        ARRAY['p_value', 'statistical_significance', 'alpha']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The feature is successful because it grew metrics by 2%, and there is only an 8% chance we are wrong.', false),
    (v_q_id, 'B', 'The result is not statistically significant; we cannot confidently rule out that the lift is due to random chance.', true),
    (v_q_id, 'C', 'We should run the test for exactly 1 more week to see if the p-value drops below the 0.05 threshold.', false),
    (v_q_id, 'D', 'The feature is a failure and we can conclude with 92% confidence that the old algorithm was better.', false);

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
        'Amazon''s Primary Metric Selection',
        E'Amazon is testing a redesign of the "Buy Now with 1-Click" button on product detail pages to make it more prominent. The PM needs to choose a primary success metric for the A/B test.\n\nWhich metric is the most robust indicator of the feature''s success?',
        'foundational',
        'Amazon',
        'E-commerce marketplace',
        'C',
        'The primary metric should measure actual value creation. Successful checkout completions per user directly measures if the button drives real purchases. Option A (clicks) is a vanity metric; making a button bigger gets more clicks, but doesn''t mean they actually complete the purchase. Option B (revenue per user) has extremely high variance because one user buying a $5,000 TV can skew the results entirely. Option D (conversion per session) is easily diluted by users who log multiple sessions before buying.',
        ARRAY['primary_metric', 'success_metrics', 'variance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Total clicks on the "Buy Now" button per day', false),
    (v_q_id, 'B', 'Average total revenue per user', false),
    (v_q_id, 'C', 'Successful checkout completions per user', true),
    (v_q_id, 'D', 'Overall purchase conversion rate per session', false);

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
        'Uber''s Randomization Unit',
        E'Uber is testing a completely new, multi-step checkout flow for booking rides. The PM needs to decide the unit of randomization for the A/B test.\n\nWhich randomization unit is most appropriate for this test?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'A',
        'For significant UI or flow changes, users expect a consistent experience. Randomizing by User ID ensures that if a user opens the app on Monday and again on Wednesday, they see the same checkout flow. Randomizing by Session ID (Option B) or Ride ID (Option D) means a user might see the old UI in the morning and the new UI in the evening, causing extreme confusion and contaminating the test. Device ID (Option C) fails if the user switches from their phone to their tablet.',
        ARRAY['randomization_unit', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'User ID', true),
    (v_q_id, 'B', 'Session ID', false),
    (v_q_id, 'C', 'Device ID', false),
    (v_q_id, 'D', 'Ride ID', false);

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
        'Slack''s Guardrail Metric',
        E'Slack''s Growth team introduces a new feature that sends an automated push notification to users when a channel they are in has been inactive for 7 days. The primary metric is Daily Active Users (DAU).\n\nWhich of the following is the most critical guardrail metric for this test?',
        'foundational',
        'Slack',
        'Workplace communication tool',
        'D',
        'Guardrail metrics ensure that while we optimize the primary metric, we don''t damage the core business or user experience. Increasing notification frequency will likely increase DAU, but the primary risk is annoying users to the point they disable notifications or uninstall the app. Notification opt-out rate captures this exact risk. Options A, B, and C are engagement metrics but do not capture the systemic downside risk of aggressive push notifications.',
        ARRAY['guardrail_metric', 'trade_offs', 'retention']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Average session length per user', false),
    (v_q_id, 'B', 'Total number of messages sent per day', false),
    (v_q_id, 'C', 'New channel creation rate', false),
    (v_q_id, 'D', 'Notification opt-out rate', true);

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
        'Airbnb''s Type I Error',
        E'Airbnb runs a pricing UI test with the statistical significance threshold (alpha) set to 0.05. The test concludes with a p-value of 0.03, so the PM declares the new UI a winner.\n\nIn plain terms, what does the alpha of 0.05 represent in this context?',
        'foundational',
        'Airbnb',
        'Vacation rental marketplace',
        'B',
        'Alpha (typically 0.05) is the False Positive Rate or Type I Error rate. It means that if the new feature actually has ZERO impact (the null hypothesis is true), there is still a 5% probability that random noise in the data will make it look like a statistically significant winner. Option A incorrectly defines the False Negative rate (Beta). Options C and D are widespread misunderstandings of probability; p-values and alpha tell us about the data given the hypothesis, not the probability of the hypothesis itself.',
        ARRAY['type_i_error', 'alpha', 'false_positive']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'There is a 5% chance that the test fails to detect a winner when the feature is actually better.', false),
    (v_q_id, 'B', 'If the feature actually has no effect, there is a 5% chance we will incorrectly conclude it is a winner.', true),
    (v_q_id, 'C', 'There is exactly a 95% probability that the new UI is better than the old UI.', false),
    (v_q_id, 'D', 'There is a 5% chance that the treatment group contains a bug affecting the results.', false);

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
        'Shopify''s Statistical Power',
        E'Shopify designs an A/B test for a new checkout flow. The data science team configures the test to have 80% statistical power (beta = 0.20) for a 2% Minimum Detectable Effect. The test finishes and the results are not statistically significant.\n\nWhat does the 80% power imply about this outcome?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'A',
        'Statistical power (1 - beta) is the probability of detecting an effect if the true effect actually exists and is at least as large as the MDE. Having 80% power means that if the feature truly improved conversion by 2%, there was an 80% chance the test would have flagged it as significant (and a 20% chance it would fail to do so, causing a Type II error). Option B confuses power with confidence. Option C is a misunderstanding of effect sizes. Option D misinterprets power as related to bug frequency.',
        ARRAY['statistical_power', 'type_ii_error', 'beta']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'If the feature actually improved conversion by 2% or more, there was a 20% chance the test would miss it.', true),
    (v_q_id, 'B', 'There is an 80% probability that the test correctly identified that the feature does nothing.', false),
    (v_q_id, 'C', 'The feature only achieved 80% of the 2% lift that the product team originally expected.', false),
    (v_q_id, 'D', 'We can be 80% confident that there were no severe bugs in the treatment group experience.', false);

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
        'DoorDash''s Baseline Conversion',
        E'DoorDash is testing a new upsell prompt for dessert. The baseline conversion rate for dessert is currently 1.5%. The PM wants to detect a 10% relative improvement (MDE).\n\nHow does this low baseline conversion rate impact the A/B test design?',
        'foundational',
        'DoorDash',
        'Food delivery platform',
        'C',
        'A 10% relative improvement on a 1.5% baseline is an absolute improvement of just 0.15%. Detecting such a tiny absolute difference requires a massive sample size, meaning the test will likely need to run for a very long time to reach statistical significance. Low baselines require exponentially more traffic to detect relative changes. Option A is the opposite of the truth. Option B is statistically invalid. Option D misunderstands absolute vs relative metrics.',
        ARRAY['baseline_conversion', 'sample_size', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The low baseline makes the test run much faster because it is easier to improve a small number.', false),
    (v_q_id, 'B', 'We should switch to a lower significance level (alpha = 0.10) to compensate for the low baseline.', false),
    (v_q_id, 'C', 'It requires a massive sample size to detect the improvement, meaning the test will take much longer to run.', true),
    (v_q_id, 'D', 'It guarantees the test will fail because a 1.5% baseline cannot mathematically grow by 10%.', false);

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
        'Figma''s Control vs Variant',
        E'Figma builds a completely redesigned right-hand properties panel. To measure its impact, a junior PM suggests releasing the new panel to 50% of users in November, and comparing their November engagement to the engagement of all users in October.\n\nWhy is this a fundamentally flawed approach?',
        'foundational',
        'Figma',
        'Collaborative design tool',
        'C',
        'A proper A/B test requires testing the control and variant groups simultaneously. Comparing a November treatment group to an October historical baseline introduces temporal confounding variables (e.g., holidays, marketing pushes, natural growth, macroeconomic shifts). Option C correctly identifies this failure to control for external time-based factors. Options A, B, and D describe valid things to care about, but they miss the core flaw of doing a sequential/historical comparison instead of a concurrent split.',
        ARRAY['control_group', 'confounding_variables', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM didn''t specify what the primary metric for engagement will be.', false),
    (v_q_id, 'B', '50% of users is too large of an audience for a beta feature; it should be 5%.', false),
    (v_q_id, 'C', 'It fails to isolate the feature''s impact from external time-based factors that might differ between October and November.', true),
    (v_q_id, 'D', 'Users who receive the new panel will experience a novelty effect that invalidates the data.', false);

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
        'LinkedIn''s Novelty Effect',
        E'LinkedIn changes the primary "Connect" button from blue to bright green. In the first week of the A/B test, clicks on the button spike by 15% (statistically significant). By week 4, the lift has entirely vanished, and the treatment group is performing identically to the control group.\n\nWhat is the most likely explanation for this phenomenon?',
        'foundational',
        'LinkedIn',
        'Professional networking platform',
        'B',
        'This is the classic Novelty Effect. Users notice a change in the UI and click it purely out of curiosity or because their habitual visual patterns were disrupted. Once they get used to the new color, their behavior reverts to baseline because the underlying utility of the feature hasn''t changed. Option A assumes a bug without evidence. Option C misunderstands statistical significance over time. Option D describes the Primacy effect (change aversion), which is the exact opposite pattern (initially drops, then recovers).',
        ARRAY['novelty_effect', 'behavioral_analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A tracking bug in week 4 caused the analytics events to drop significantly.', false),
    (v_q_id, 'B', 'Users initially clicked the button because it was new and visually different, but habituated over time.', true),
    (v_q_id, 'C', 'The sample size in week 1 was too small, creating a false positive that was corrected in week 4.', false),
    (v_q_id, 'D', 'Users experienced change aversion and deliberately stopped using the feature after week 1.', false);

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
        'Tinder''s Multiple Testing Problem',
        E'Tinder decides to test 20 different colors for the "Super Like" button simultaneously. They set the significance level (alpha) at 0.05. After two weeks, 19 colors show no difference, but "Neon Yellow" shows a statistically significant lift with a p-value of 0.04.\n\nShould the PM launch Neon Yellow?',
        'intermediate',
        'Tinder',
        'Dating app',
        'C',
        'This is the Multiple Testing Problem. If you test 20 variants with an alpha of 0.05, the probability of getting at least one false positive is 1 - (0.95^20), which is about 64%. Because "Neon Yellow" barely squeaked by at p=0.04 among 20 tests, it is highly likely to be a false positive due to random noise. To fix this, you must apply a correction (like Bonferroni), which lowers the required p-value threshold. Option A ignores the math. Option B is a novelty effect, not the primary statistical issue. Option D is incorrect; 20 variants is possible if math is adjusted.',
        ARRAY['multiple_testing', 'false_positive', 'bonferroni_correction']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, because the p-value is below 0.05, it is a mathematically proven winner.', false),
    (v_q_id, 'B', 'No, because users are likely experiencing a novelty effect from the bright yellow color.', false),
    (v_q_id, 'C', 'No, testing 20 variants at alpha 0.05 creates a ~64% chance of finding a false positive. This result is highly suspect.', true),
    (v_q_id, 'D', 'Yes, but they must run the test for an additional 2 weeks to ensure it wasn''t a tracking bug.', false);

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
        'Stripe''s Peeking Problem',
        E'Stripe sets an A/B test duration of 14 days based on sample size calculations. On Day 3, the PM checks the dashboard and sees the new checkout flow is up 5% with a p-value of 0.01. The PM wants to stop the test immediately and launch to capture the revenue.\n\nWhat is the primary statistical danger of doing this?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'D',
        'This is the Peeking Problem. Standard A/B tests (Frequentist) assume a fixed horizon. If you check results daily and stop the test the moment you see a significant result, you drastically inflate your False Positive Rate. Random variance often swings wildly early in a test before converging on the true mean. By selectively stopping on a high swing, you guarantee finding "winners" that are actually flat. Option A misunderstands alpha. Option B focuses on a business rule, not the statistical danger. Option C is false; significance doesn''t lock in.',
        ARRAY['peeking_problem', 'false_positive', 'stopping_rules']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stopping early reduces the power of the test, increasing the chance of a false negative.', false),
    (v_q_id, 'B', 'It violates Stripe''s engineering deployment schedule, which requires 2 weeks of QA.', false),
    (v_q_id, 'C', 'There is no statistical danger; once p < 0.05 is reached, significance cannot be lost.', false),
    (v_q_id, 'D', 'It severely inflates the false positive rate because you are selectively terminating the test when variance swings in your favor.', true);

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
        'YouTube''s Day of Week Seasonality',
        E'YouTube wants to test a new layout for the homepage. They run the experiment from Friday morning to Sunday night. They hit their required sample size and the variant wins with 99% significance. The PM rolls it out to 100% of users on Monday morning.\n\nWhy is this rollout highly risky?',
        'intermediate',
        'YouTube',
        'Video sharing platform',
        'A',
        'Weekend user behavior is fundamentally different from weekday user behavior. Weekend users might watch longer entertainment videos, while weekday users might watch short tutorials. Even if sample size is reached, running a test that doesn''t span full 7-day business cycles fails to capture day-of-week seasonality. The "winner" for the weekend might be a loser for the week. Option B is factually incorrect. Option C relies on an arbitrary 2-week rule. Option D is a novelty effect description, not the primary temporal issue here.',
        ARRAY['seasonality', 'experiment_duration', 'external_validity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Weekend user behavior often differs drastically from weekday behavior; the results may not generalize.', true),
    (v_q_id, 'B', 'Because traffic is lower on weekends, reaching significance that fast implies a tracking bug.', false),
    (v_q_id, 'C', 'Tests must always run for exactly 14 days, regardless of the sample size reached.', false),
    (v_q_id, 'D', 'Users have more free time on the weekend to experience the novelty effect.', false);

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
        'Booking.com''s Interaction Effects',
        E'At Booking.com, PM Alpha is testing a new red "Book Now" button on the property page. At the exact same time, PM Beta is testing a massive red banner at the top of the property page warning users about hotel scarcity. Both tests randomize 50% of all users.\n\nWhat is the biggest risk of running these tests simultaneously without coordination?',
        'intermediate',
        'Booking.com',
        'Travel fare aggregator',
        'B',
        'When two tests overlap on the same UI or user flow, they can create Interaction Effects. A user who gets both the red button AND the red banner might feel overwhelmed by the aggressive UI and abandon the site. Even if both features are positive in isolation, their combined effect might be negative. A multivariate test or mutually exclusive experiment layers are needed. Option A is a misunderstanding of how independent randomization works. Option C is false; tests can run concurrently if orthogonal. Option D is a SUTVA violation, which doesn''t apply directly here.',
        ARRAY['interaction_effects', 'multivariate_testing', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The sample size for both tests will be cut in half, destroying statistical power.', false),
    (v_q_id, 'B', 'Users receiving both treatments might experience an overwhelming UI, causing a negative interaction effect.', true),
    (v_q_id, 'C', 'It is mathematically impossible to calculate p-values when two tests run concurrently.', false),
    (v_q_id, 'D', 'One PM''s test will artificially steal supply inventory from the other PM''s test.', false);

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
        'Notion''s Cannibalization',
        E'Notion adds a prominent "AI Generate" button to the top navigation bar. During the A/B test, clicks on the new button are incredibly high. However, the overall number of documents created per user remains exactly the same as the control group.\n\nHow should the PM interpret this result?',
        'intermediate',
        'Notion',
        'Productivity software',
        'C',
        'This is classic Cannibalization. The new feature looks wildly successful in a vacuum (high clicks), but it didn''t increase the overall pie (total documents created). Users simply shifted their behavior from an old method (like typing or using a slash command) to the new button. The feature provides zero incremental business value. Option A assumes a bug. Option B is false; engagement shifted, it didn''t decrease. Option D assumes a novelty effect without evidence.',
        ARRAY['cannibalization', 'incrementality', 'primary_metric']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The tracking for overall document creation is likely broken and undercounting.', false),
    (v_q_id, 'B', 'The feature is a failure because it actually decreased user engagement with the core product.', false),
    (v_q_id, 'C', 'The new button cannibalized usage from existing creation methods, providing no incremental value.', true),
    (v_q_id, 'D', 'Users are experiencing a novelty effect and will eventually create more documents next month.', false);

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
        'Etsy''s Simpson''s Paradox',
        E'Etsy runs an A/B test on a new checkout UI. The overall results show that the Treatment group has a LOWER conversion rate than Control. \nHowever, when the PM segments the data, they find that Treatment conversion is HIGHER for Mobile users AND HIGHER for Desktop users.\n\nWhat statistical phenomenon explains this?',
        'intermediate',
        'Etsy',
        'E-commerce platform',
        'B',
        'This is Simpson''s Paradox. It occurs when a trend appears in different groups of data but disappears or reverses when these groups are combined. In A/B testing, this almost always happens due to Sample Ratio Mismatch (SRM) or composition bias—for example, if the treatment group accidentally received a massive influx of Mobile users (who inherently have lower conversion rates than Desktop). Option A is a different concept. Option C is a real thing, but doesn''t mathematically cause this inversion. Option D is irrelevant.',
        ARRAY['simpsons_paradox', 'segmentation', 'composition_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Law of Large Numbers', false),
    (v_q_id, 'B', 'Simpson''s Paradox, likely driven by a traffic allocation imbalance between platforms.', true),
    (v_q_id, 'C', 'Heterogeneous Treatment Effects across different device sizes.', false),
    (v_q_id, 'D', 'The Hawthorne Effect, where users behave differently when observed.', false);

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
        'Duolingo''s Heterogeneous Treatment Effects',
        E'Duolingo tests a highly demanding "Hardcore Mode" popup. The overall A/B test results are perfectly flat (p=0.85). However, a data scientist segments the results and finds that D1 Retention for New Users dropped by 10%, while D30 Retention for Power Users increased by 5%.\n\nWhat is the most strategic product decision?',
        'intermediate',
        'Duolingo',
        'Language learning app',
        'C',
        'This represents Heterogeneous Treatment Effects (the treatment affects different segments in opposite ways). The feature is terrible for new users (too demanding, causing churn) but great for power users (providing needed challenge). The flat overall result masks these massive swings. The PM shouldn''t discard it or launch it globally; they should turn it into a targeted feature. Option A harms new users. Option B leaves money/engagement on the table. Option D is an unnecessary delay.',
        ARRAY['heterogeneous_treatment_effects', 'segmentation', 'product_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch the feature globally because power users are the most valuable cohort.', false),
    (v_q_id, 'B', 'Discard the feature entirely since the overall top-line metric showed no improvement.', false),
    (v_q_id, 'C', 'Roll back the global test and rebuild the feature to only trigger for advanced Power Users.', true),
    (v_q_id, 'D', 'Run the test for another month to see if New Users eventually adapt to the Hardcore Mode.', false);

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
        'Pinterest''s Variance Reduction (CUPED)',
        E'Pinterest wants to test a minor change to the feed ranking algorithm. Because the expected effect size is tiny, the MDE requires the test to run for 8 weeks. The data science team suggests using CUPED (Controlled-experiment Using Pre-Experiment Data).\n\nHow does CUPED help in this scenario?',
        'intermediate',
        'Pinterest',
        'Image sharing platform',
        'C',
        'CUPED uses pre-experiment data (e.g., how active a user was before the test) as a covariate to explain away natural, baseline variance between users. By mathematically removing the noise of inherent user differences, the variance of the test metric shrinks. Lower variance means you have higher statistical power, allowing you to detect the same small MDE with a smaller sample size (i.e., less time). Option A is false; CUPED doesn''t alter traffic. Option B is false; it changes variance, not alpha. Option D is synthetic control, not CUPED.',
        ARRAY['variance_reduction', 'cuped', 'experiment_velocity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It allows Pinterest to shift 90% of traffic to the treatment group safely.', false),
    (v_q_id, 'B', 'It artificially lowers the p-value threshold required to declare a winner.', false),
    (v_q_id, 'C', 'It uses historical user data to explain away natural variance, reducing the required sample size.', true),
    (v_q_id, 'D', 'It creates a synthetic control group from past data so 100% of users can get the treatment.', false);

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
        'Discord''s Dilution Effect',
        E'Discord tests a new toggle inside the "Advanced Audio Settings" menu. They randomize all 150 million active users into Treatment and Control. Only 1% of users actually visit this settings page during the test. After two weeks, the data shows absolutely zero difference between the groups.\n\nWhat is the main experimental design flaw?',
        'intermediate',
        'Discord',
        'Communication platform',
        'C',
        'This is the Dilution Effect. By analyzing all 150M users, the PM included 99% of users who never even had a chance to see the new feature. The noise from the 99% completely overwhelms any signal generated by the 1% who actually used it. To fix this, you must only "trigger" or log users into the experiment when they actually visit the Advanced Audio Settings menu. Option A is false; 150M is massive. Option B is unrelated. Option D is a SUTVA violation, which is not applicable here.',
        ARRAY['dilution_effect', 'triggering', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The sample size is too small because only 1.5 million users saw the feature.', false),
    (v_q_id, 'B', 'The test should have been run globally instead of relying on a 50/50 split.', false),
    (v_q_id, 'C', 'The analysis included millions of users who never saw the change, diluting the statistical signal.', true),
    (v_q_id, 'D', 'Audio settings create network effects that leak between treatment and control groups.', false);

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
        'Peloton''s Outliers',
        E'Peloton tests a new apparel store layout. The primary metric, Total Revenue per User, is up 15% in the Treatment group with p=0.02. However, a deep dive reveals that 3 users in the Treatment group bought 50 bikes each for corporate gyms, while no such purchases happened in Control.\n\nHow should the PM handle this data?',
        'intermediate',
        'Peloton',
        'Fitness equipment company',
        'B',
        'Continuous metrics like Revenue are highly susceptible to outliers. Three massive whale purchases randomly landing in Treatment have skewed the mean, creating a false signal. The PM must apply an outlier mitigation strategy, such as capping (truncating) revenue at the 99th percentile, or looking at non-continuous metrics like Conversion Rate, to see the true impact on normal users. Option A accepts a false positive. Option C throws away all heavy users entirely. Option D is factually incorrect.',
        ARRAY['outliers', 'continuous_metrics', 'data_cleaning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the results; revenue is revenue, and the test is a statistical success.', false),
    (v_q_id, 'B', 'Apply a capping strategy (e.g., truncate at the 99th percentile) to remove outlier skew and re-analyze.', true),
    (v_q_id, 'C', 'Remove all users who spent more than $100 to perfectly normalize the data.', false),
    (v_q_id, 'D', 'Revenue cannot be used in A/B testing; only binary conversion metrics are mathematically valid.', false);

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
        'Reddit''s Ratio Metrics',
        E'Reddit is running an A/B test. The randomization unit is User ID. The PM wants to use "Upvotes per Session" as the primary metric.\n\nWhat statistical complication arises when using this metric compared to "Sessions per User"?',
        'intermediate',
        'Reddit',
        'Social news aggregator',
        'D',
        'This is the Ratio Metric problem. Because you randomized on User, but the denominator of the metric is Session, the data points (sessions) are not independent (one user can have many sessions). Standard statistical formulas for variance assume independence. To calculate the variance of a ratio metric correctly, you must use the Delta Method or bootstrapping. Option A is a business concern, not a statistical one. Options B and C are fundamentally false misunderstandings of metric definitions.',
        ARRAY['ratio_metrics', 'delta_method', 'variance_calculation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users can upvote multiple times in one session, making the metric impossible to track.', false),
    (v_q_id, 'B', 'Ratio metrics inherently have zero variance, meaning p-values cannot be calculated.', false),
    (v_q_id, 'C', 'It requires the randomization unit to be immediately switched from User ID to Session ID.', false),
    (v_q_id, 'D', 'The unit of analysis differs from the randomization unit, requiring advanced variance calculation like the Delta Method.', true);

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
        'Robinhood''s Carryover Effects',
        E'Robinhood finishes a controversial A/B test that aggressively pushed options trading, which upset many users. The next day, the same PM starts a new A/B test on a retirement planning tool, using the exact same Treatment and Control user buckets from the first test.\n\nWhat is the primary risk of this approach?',
        'intermediate',
        'Robinhood',
        'Financial services platform',
        'B',
        'This is a Carryover Effect (or lingering bias). The users in the Treatment bucket from the first test are likely still annoyed or behaving differently due to the previous aggressive UI. If you reuse the exact same buckets, their altered behavior bleeds into the second test, destroying the baseline equivalence of your groups. You must re-randomize users using a new salt/hash for every experiment. Option A is a novelty effect. Option C is false; re-randomizing is cheap. Option D is irrelevant.',
        ARRAY['carryover_effects', 'randomization', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users will experience a novelty effect because they are getting two new features in a row.', false),
    (v_q_id, 'B', 'Lingering behavioral changes from the first test will bias the results of the second test.', true),
    (v_q_id, 'C', 'Re-randomizing users for every test costs too much computing power for continuous delivery.', false),
    (v_q_id, 'D', 'The retirement tool will cannibalize the revenue generated by the options trading tool.', false);

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
        'Zoom''s Sequential Testing',
        E'Zoom rolls out a massive rewrite of their video encoding engine. Because a bug could ruin millions of enterprise calls, the PM insists on checking the A/B test results every single day to look for a statistical drop in call quality, despite knowing the Peeking Problem inflates false positives.\n\nWhat is the mathematically correct way to handle this business need?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'A',
        'Sequential Testing frameworks (like SPRT, O''Brien-Fleming, or always-valid p-values) mathematically adjust the significance thresholds based on how often you peek. They require a massive difference to flag a winner/loser early on, slowly relaxing to the standard alpha by the end of the test. This allows PMs to continuously monitor for disasters without inflating the false positive rate. Option B guarantees false positives. Option C is a deployment strategy, not statistical. Option D is A/A testing, which doesn''t help here.',
        ARRAY['sequential_testing', 'peeking_problem', 'always_valid_p_values']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Implement a sequential testing framework that mathematically adjusts the alpha threshold for multiple peeks.', true),
    (v_q_id, 'B', 'Keep the alpha at 0.05 but divide the required sample size by the number of days.', false),
    (v_q_id, 'C', 'Abandon A/B testing and use a canary deployment instead.', false),
    (v_q_id, 'D', 'Run an A/A test concurrently to subtract the false positive rate from the A/B test.', false);

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
        'Twitter''s Primacy Effect',
        E'Twitter completely redesigns the profile page layout. In week 1 of the A/B test, engagement in the Treatment group drops by 10%. However, the PM decides to keep the test running. By week 4, the Treatment group''s engagement has steadily climbed and is now +5% compared to Control.\n\nWhat explains this pattern?',
        'intermediate',
        'Twitter',
        'Social media platform',
        'B',
        'This is the Primacy Effect, commonly known as Change Aversion. When users are highly accustomed to a specific UI, any change disrupts their muscle memory, causing initial frustration and a drop in metrics. However, if the new design is objectively better, their metrics will recover and exceed the baseline as they learn the new layout. Option A is the Novelty Effect (the exact opposite pattern). Option C is a SUTVA violation. Option D is Simpson''s Paradox.',
        ARRAY['primacy_effect', 'change_aversion', 'longitudinal_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Novelty Effect', false),
    (v_q_id, 'B', 'Change Aversion (Primacy Effect)', true),
    (v_q_id, 'C', 'Network Interference', false),
    (v_q_id, 'D', 'Simpson''s Paradox', false);

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
        'Canva''s Non-inferiority Testing',
        E'Canva rebuilds its image export engine to use a cheaper cloud provider, saving $5M a year. The goal is NOT to increase the export success rate, but simply to prove that the new engine doesn''t break things.\n\nWhat is the correct experimental design for this?',
        'intermediate',
        'Canva',
        'Graphic design platform',
        'C',
        'This requires a Non-inferiority Test. Standard A/B testing is designed to prove a difference. If you just look for a "not significant" result in a standard test, you might just have an underpowered test. Non-inferiority testing establishes a pre-defined margin (e.g., "we will accept up to a 0.5% drop in success rate") and mathematically proves with statistical significance that the new feature is NOT worse than that margin. Option A accepts lack of evidence as evidence of absence. Option B is for continuous metric skew. Option D is for variance reduction.',
        ARRAY['non_inferiority_testing', 'do_no_harm', 'experiment_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run a standard A/B test and launch if the p-value is greater than 0.05.', false),
    (v_q_id, 'B', 'Run a multi-armed bandit test to slowly shift traffic.', false),
    (v_q_id, 'C', 'Run a non-inferiority test, setting a pre-defined acceptable margin of degradation.', true),
    (v_q_id, 'D', 'Use CUPED to entirely eliminate the variance in the export success rate.', false);

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
        'DoorDash''s SUTVA Violation',
        E'DoorDash tests a new algorithm that gives Treatment Dashers priority access to high-paying orders. Treatment Dashers see a 20% increase in earnings. However, total market earnings remain completely flat, and Control Dashers complain their earnings dropped significantly.\n\nWhat fundamental assumption of A/B testing was violated?',
        'intermediate',
        'DoorDash',
        'Food delivery platform',
        'A',
        'This is a violation of SUTVA (Stable Unit Treatment Value Assumption), specifically a two-sided marketplace interference. SUTVA assumes that the treatment assignment of one user does not affect the outcome of another user. Here, drivers share a constrained supply of orders. Giving Treatment drivers priority actively steals orders from Control drivers, artificially inflating the difference between the groups without adding true incremental value to the platform. Options B, C, and D are real statistical terms but do not describe market interference.',
        ARRAY['sutva', 'network_effects', 'two_sided_markets']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SUTVA (Stable Unit Treatment Value Assumption)', true),
    (v_q_id, 'B', 'The Law of Large Numbers', false),
    (v_q_id, 'C', 'Heteroscedasticity', false),
    (v_q_id, 'D', 'The Independence of Irrelevant Alternatives', false);

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
        'GitHub''s Evaluating Trade-offs',
        E'GitHub Copilot tests a larger, more advanced AI model. The primary metric (Code Acceptance Rate) increases by a massive 4% (p < 0.001). However, the guardrail metric (Latency) increases from 200ms to 250ms, which is also highly statistically significant.\n\nHow should the PM proceed?',
        'intermediate',
        'GitHub',
        'Developer platform',
        'D',
        'In reality, A/B tests rarely have purely positive outcomes; they surface trade-offs. The PM must evaluate if the business value of a 4% increase in acceptance outweighs the user experience cost of a 50ms latency regression. This is a strategic product decision, not a purely mathematical one. Option A is a dogmatic rule that prevents innovation. Option B ignores the data. Option C is kicking the can down the road.',
        ARRAY['trade_offs', 'guardrail_metric', 'decision_making']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Any regression in a guardrail metric means an automatic rollback; discard the new model.', false),
    (v_q_id, 'B', 'Ignore the latency because the primary metric is the only one tied to OKRs.', false),
    (v_q_id, 'C', 'Run the test until the latency difference is no longer statistically significant.', false),
    (v_q_id, 'D', 'Weigh the strategic trade-off: evaluate if the 4% acceptance lift is worth the 50ms UX degradation.', true);

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
        'Salesforce''s B2B Randomization',
        E'Salesforce tests a new collaborative document editing feature. They randomize by User ID. A sales manager gets the Treatment (new feature) and loves it, but their direct report gets the Control (old feature). The manager tells the report to use the new feature, causing confusion and support tickets.\n\nHow should this test have been designed?',
        'intermediate',
        'Salesforce',
        'B2B CRM software',
        'C',
        'This is a classic B2B SaaS problem: Contagion/Spillover. Users within the same company communicate and collaborate. If you randomize at the user level, you break their shared workflows and cause confusion. B2B tests involving collaboration must randomize at the Organization, Tenant, or Workspace level so an entire team gets the exact same experience. Option A doesn''t solve the collaboration break. Option B causes massive bias. Option D is irrelevant.',
        ARRAY['b2b_experimentation', 'randomization_unit', 'spillover_effects']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Randomize by Session ID instead of User ID.', false),
    (v_q_id, 'B', 'Allow users in the Control group to manually opt-in to the Treatment if requested.', false),
    (v_q_id, 'C', 'Randomize at the Organization or Tenant level to ensure team consistency.', true),
    (v_q_id, 'D', 'Only test the feature on weekends when communication is lower.', false);

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
        'Uber''s Switchback Testing',
        E'Uber wants to test a new driver dispatch algorithm in New York City to reduce rider wait times. Because drivers and riders share the same geographic marketplace, randomizing by User ID or Driver ID causes severe SUTVA violations (interference).\n\nWhat is the industry-standard experimental design to solve this?',
        'advanced',
        'Uber',
        'Ride-hailing platform',
        'C',
        'Switchback Testing (or Time-Slice Randomization) is the standard for two-sided marketplaces where supply and demand are tightly coupled locally. Instead of randomizing users, you alternate the ENTIRE market (e.g., NYC) between the Control algorithm and Treatment algorithm in time blocks (e.g., every 2 hours). This eliminates driver-to-driver interference because at any given moment, the whole city is operating under the same rules. Option A ignores the market constraints. Option B creates horrific UI inconsistency. Option D is an observational method, not an experiment.',
        ARRAY['switchback_testing', 'marketplace_experimentation', 'sutva']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'CUPED Variance Reduction', false),
    (v_q_id, 'B', 'Session-level Randomization', false),
    (v_q_id, 'C', 'Switchback Testing', true),
    (v_q_id, 'D', 'Propensity Score Matching', false);

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
        'Airbnb''s Cluster Randomization',
        E'Airbnb tests a new host-side feature that encourages hosts to lower their cleaning fees. If a host lowers their fee (Treatment), they get more bookings, but this directly steals bookings from neighboring hosts who didn''t get the feature (Control).\n\nHow can Airbnb design an A/B test to accurately measure the true incremental lift to the overall platform?',
        'advanced',
        'Airbnb',
        'Vacation rental marketplace',
        'A',
        'Because Airbnb inventory competes geographically, user-level randomization causes cannibalization across groups, overstating the feature''s success. Cluster Randomization solves this by grouping interference units. You randomize entire geographic markets (e.g., all hosts in Austin get Treatment, all hosts in Denver get Control). This isolates the interference within the cluster, allowing you to measure true platform-level incrementality. Option B doesn''t solve the spatial cannibalization. Option C is a bandit, which still requires a unit of randomization. Option D guarantees selection bias.',
        ARRAY['cluster_randomization', 'marketplace_experimentation', 'cannibalization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Randomize by geographic clusters (e.g., cities) so hosts only compete with hosts in the same experiment arm.', true),
    (v_q_id, 'B', 'Use a switchback test, alternating the feature on and off every hour globally.', false),
    (v_q_id, 'C', 'Use a multi-armed bandit algorithm to automatically lower fees for the worst-performing hosts.', false),
    (v_q_id, 'D', 'Allow hosts to opt-in to the test to ensure they are comfortable with the fee change.', false);

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
        'Lyft''s Synthetic Control',
        E'Lyft executes a massive physical billboard marketing campaign exclusively in Chicago. They cannot run an A/B test because they cannot hide billboards from half the city. The PM needs to calculate the incremental lift in rides generated by the campaign.\n\nWhat advanced technique should the PM use?',
        'advanced',
        'Lyft',
        'Ride-hailing platform',
        'C',
        'When a true randomized A/B test is impossible (like city-wide physical ads), you use a Synthetic Control. You mathematically construct a "fake Chicago" using a weighted combination of similar untreated cities (e.g., 0.6 * Boston + 0.4 * Seattle) that historically tracked Chicago''s ride volume perfectly. You then compare the actual Chicago post-campaign to the Synthetic Chicago to measure incrementality. Option A ignores exogenous factors. Option B is factually wrong. Option D is an entirely different concept.',
        ARRAY['synthetic_control', 'causal_inference', 'incrementality']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Compare Chicago''s rides this month directly to Chicago''s rides last month.', false),
    (v_q_id, 'B', 'It is mathematically impossible to measure incrementality without a randomized control group.', false),
    (v_q_id, 'C', 'Construct a Synthetic Control group using a weighted combination of similar untreated cities to serve as the baseline.', true),
    (v_q_id, 'D', 'Use the Delta Method to approximate the variance of the billboard views.', false);

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
        'Spotify''s Long-term Holdouts',
        E'Spotify launches 50 new features a year. Every single feature was proven to increase retention by 0.5% in short 2-week A/B tests. However, at the end of the year, Spotify''s overall retention has only increased by 5%, not the expected 25%.\n\nWhat experimental mechanism is required to accurately measure the true cumulative impact of a year of shipping?',
        'advanced',
        'Spotify',
        'Audio streaming platform',
        'B',
        'Short-term A/B tests cannot measure long-term effects, interaction effects between dozens of features, or novelty effects that fade over months. To measure true cumulative incrementality, mature tech companies use Long-term Holdouts: a small group of users (e.g., 1%) who are intentionally excluded from ALL new features for 6-12 months. Comparing the mainline users to this holdout reveals the actual aggregate value shipped. Option A describes the problem, not the mechanism. Option C is impractical. Option D is a variance technique.',
        ARRAY['holdout_groups', 'cumulative_impact', 'long_term_effects']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Bonferroni Correction', false),
    (v_q_id, 'B', 'Long-term Holdouts', true),
    (v_q_id, 'C', 'Simultaneous Multivariate Testing (MVT) on 50 variables', false),
    (v_q_id, 'D', 'Pre-experiment Covariate Matching (CUPED)', false);

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
        'Meta''s Network Effects Interference',
        E'Instagram is testing a new "Read Receipts" feature in Direct Messages. User A is in the Control group (no feature). User B is in the Treatment group and turns the feature on. Because User B has it on, User A now knows User B read their message, altering User A''s behavior.\n\nWhat advanced experimental design minimizes this graph interference?',
        'advanced',
        'Meta',
        'Social media company',
        'D',
        'In social networks, user behavior is interconnected. Standard user-level randomization fails because information bleeds across edges (SUTVA violation). Network Cluster Randomization (or Graph Partitioning) solves this by running community detection algorithms to find tightly knit groups of friends, and randomizing at the cluster level. This ensures most communication happens entirely within the Treatment group or entirely within the Control group, isolating the effect. Options A, B, and C do not address the network graph.',
        ARRAY['network_effects', 'graph_partitioning', 'sutva']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Switchback Testing', false),
    (v_q_id, 'B', 'Device-level Randomization', false),
    (v_q_id, 'C', 'Stratified Sampling', false),
    (v_q_id, 'D', 'Network Cluster Randomization (Graph Partitioning)', true);

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
        'Amazon''s A/A Testing Diagnostics',
        E'Before Prime Day, Amazon runs an A/A test where exactly 50% of users are put into Group 1 and 50% into Group 2. Both groups receive the exact same website. After two weeks, the results show Group 1 has a statistically significant 3% higher conversion rate than Group 2 (p < 0.001).\n\nWhat is the most likely diagnosis?',
        'advanced',
        'Amazon',
        'E-commerce marketplace',
        'B',
        'An A/A test should almost never return a highly significant result. If it does, your experiment infrastructure is broken. The most common cause is Sample Ratio Mismatch (SRM) or a tracking bug where users are not being properly hashed/routed, or bots are disproportionately hitting one bucket. It means any A/B test run on this system cannot be trusted. Option A is a misunderstanding of alpha. Option C is false; baselines are the whole point. Option D relies on a mystical external factor rather than a system flaw.',
        ARRAY['a_a_testing', 'sample_ratio_mismatch', 'experiment_diagnostics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'This is expected behavior because alpha is 0.05, so 5% of A/A tests will show a 3% difference.', false),
    (v_q_id, 'B', 'The experimentation infrastructure has a severe flaw, likely a Sample Ratio Mismatch (SRM) or hashing bug.', true),
    (v_q_id, 'C', 'Conversion rate is naturally too volatile for A/A testing; they should have used Revenue.', false),
    (v_q_id, 'D', 'Group 1 organically experienced a macro-economic shift that Group 2 did not.', false);

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
        'Netflix''s Multi-armed Bandit vs A/B',
        E'Netflix creates 5 different thumbnail artworks for a new movie launching this weekend. They only care about maximizing total clicks right now during the launch window, not about generating statistical learnings for next year. \n\nWhy should the PM choose a Multi-armed Bandit over a standard A/B test?',
        'advanced',
        'Netflix',
        'Video streaming platform',
        'B',
        'Standard A/B tests (Explore, then Exploit) cost money because they force a static chunk of traffic to experience the "loser" variants for the entire duration of the test. A Multi-armed Bandit dynamically shifts traffic to the winning variants in real-time as the data comes in (Explore and Exploit simultaneously). This minimizes "regret" (lost clicks on bad thumbnails) during a short, highly-valuable launch window. Option A is false; bandits require more math. Option C describes CUPED. Option D is an inverse definition.',
        ARRAY['multi_armed_bandit', 'explore_exploit', 'regret_minimization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Bandits do not require complex statistical infrastructure, making them faster to deploy.', false),
    (v_q_id, 'B', 'Bandits dynamically shift traffic to the winning variants in real-time, minimizing lost clicks (regret) during the launch window.', true),
    (v_q_id, 'C', 'Bandits use pre-experiment covariate data to reduce variance, reaching significance faster.', false),
    (v_q_id, 'D', 'A/B tests are only valid for binary metrics, whereas Bandits are required for continuous metrics.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for A/B Testing';

END $$;
