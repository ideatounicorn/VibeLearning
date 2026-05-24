-- ============================================
-- ASSESSMENT: Advanced Statistics
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
    WHERE slug = 'advanced-statistics';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug advanced-statistics not found. Run the seed data first.';
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
        'Spotify''s Playlist P-Value',
        E'Spotify''s PM runs an A/B test on a new Discover Weekly algorithm. The test results show a 2% increase in listening time with a p-value of 0.03. Assuming the standard significance level of alpha = 0.05, what does the p-value strictly mean?',
        'foundational',
        'Spotify',
        'Testing a new playlist recommendation algorithm',
        'B',
        'A p-value of 0.03 means that if the null hypothesis is true (the algorithm has no effect), there is a 3% probability of seeing a 2% increase or larger purely by random chance. It does not mean there is a 97% chance the algorithm works (Option C), nor does it guarantee the algorithm is ineffective (Option A). Option D misinterprets the p-value as an effect size, a common PM pitfall. Understanding this prevents PMs from overstating statistical certainty.',
        ARRAY['p_value', 'statistical_significance', 'hypothesis_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'There is a 3% probability that the new algorithm is not effective.', false),
    (v_q_id, 'B', 'If the algorithm has no actual effect, there is a 3% chance of observing this result randomly.', true),
    (v_q_id, 'C', 'There is a 97% probability that the new algorithm caused the 2% increase.', false),
    (v_q_id, 'D', 'The new algorithm is 3% better than the old algorithm.', false);

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
        'Netflix''s Skip Intro Correlation',
        E'A Netflix Data Scientist shows the PM that users who click the "Skip Intro" button are 40% less likely to cancel their subscription within the next month. The PM suggests hiding the "Watch Intro" option to force users to skip intros, hoping to reduce churn. What is the fundamental statistical flaw in this reasoning?',
        'foundational',
        'Netflix',
        'Analyzing viewing behavior and churn',
        'A',
        'This is a classic case of confusing correlation with causation. Users who skip intros are likely binge-watching or highly engaged with the content, which causes both the skipping behavior and the lower churn. Forcing a user to skip an intro will not magically increase their underlying engagement. Option B misapplies survivorship bias. Option D invents a meaningless metric relationship.',
        ARRAY['correlation_vs_causation', 'spurious_correlation', 'churn_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It confuses correlation with causation; engaged users skip intros, skipping intros doesn''t create engagement.', true),
    (v_q_id, 'B', 'It suffers from survivorship bias since users who canceled can no longer click "Skip Intro."', false),
    (v_q_id, 'C', 'The sample size of users who click "Skip Intro" is too small to draw conclusions.', false),
    (v_q_id, 'D', 'The PM did not account for the standard deviation of churn rates across different genres.', false);

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
        'Airbnb''s Central Limit Theorem',
        E'Airbnb''s guest ratings for a market are heavily skewed, with most ratings exactly 5 stars and a long tail of 1-star reviews. The PM randomly samples 500 batches of 50 stays each and calculates the average rating for each batch. According to the Central Limit Theorem (CLT), what shape will the distribution of these batch averages take?',
        'foundational',
        'Airbnb',
        'Analyzing heavily skewed review rating data',
        'C',
        'The Central Limit Theorem states that the distribution of sample means will approximate a normal distribution (bell curve) as the sample size gets larger, regardless of the underlying population''s distribution. Even though Airbnb ratings are heavily skewed (Option A), the averages of those samples will form a normal distribution. Option D describes a bimodal distribution, which would only happen if we plotted the raw data, not the sample means.',
        ARRAY['central_limit_theorem', 'normal_distribution', 'sampling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A strongly left-skewed distribution, matching the heavy skew of the individual 5-star ratings.', false),
    (v_q_id, 'B', 'A bimodal distribution with distinct peaks at 1 star and 5 stars.', false),
    (v_q_id, 'C', 'A normal distribution (bell curve), regardless of the underlying skew in the ratings.', true),
    (v_q_id, 'D', 'A uniform distribution, since the samples were taken completely at random.', false);

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
        'Uber''s ETA Variance',
        E'Uber''s routing PM is comparing two ETA prediction models over millions of trips.\n\n| Metric | Model X | Model Y |\n|---|---|---|\n| Avg Error | +2 mins | +2 mins |\n| Standard Deviation | 1 min | 4 mins |\n\nWhy should the PM strongly prefer Model X?',
        'foundational',
        'Uber',
        'Evaluating machine learning model accuracy for ETAs',
        'B',
        'Standard deviation measures how spread out the data is around the mean. While both models have an average error of 2 minutes, Model X''s low standard deviation means its predictions are tightly clustered. Model Y will frequently be wildly inaccurate (e.g., 6+ minutes off), causing severe user trust issues. Option A is false; standard deviation does not guarantee an absolute cap. Option D incorrectly equates variance with overfitting.',
        ARRAY['variance', 'standard_deviation', 'data_distribution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Model X guarantees statistically that no ETA will ever be more than 3 minutes off.', false),
    (v_q_id, 'B', 'Model X''s errors are tightly clustered, meaning users experience fewer extreme ETA surprises.', true),
    (v_q_id, 'C', 'Model X has a higher statistical power than Model Y for A/B testing.', false),
    (v_q_id, 'D', 'Model Y''s higher variance means it is fundamentally overfitting the routing data.', false);

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
        'DoorDash''s Power Analysis',
        E'DoorDash wants to test a minor tweak to the checkout button color. The PM expects the effect to be very small, around a 0.2% lift in conversion. To ensure the test has sufficient statistical power (e.g., 80% chance to detect the effect if it exists), what must the PM do?',
        'foundational',
        'DoorDash',
        'Planning sample size for a subtle UI change',
        'D',
        'Statistical power depends heavily on sample size and the Minimum Detectable Effect (MDE). The smaller the expected effect size, the larger the sample size required to confidently distinguish the signal from random noise. Increasing alpha (Option A) increases false positives, not just true power. Option B reduces power. Option C is technically irrelevant to statistical power.',
        ARRAY['power_analysis', 'sample_size', 'minimum_detectable_effect']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Increase the significance level (alpha) from 0.05 to 0.10 to capture the small effect.', false),
    (v_q_id, 'B', 'Run the test for a shorter duration to minimize the variance from weekend/weekday seasonality.', false),
    (v_q_id, 'C', 'Use a non-parametric statistical test instead of a standard t-test.', false),
    (v_q_id, 'D', 'Run the test on a much larger sample size to detect the small effect with confidence.', true);

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
        'Shopify''s Checkout CI',
        E'Shopify runs an A/B test on a one-click checkout flow. The results report:\n\nConversion Rate Lift: +4.2%\n95% Confidence Interval: [-0.5%, +8.9%]\n\nWhat should the PM conclude based on this data?',
        'foundational',
        'Shopify',
        'Interpreting A/B test conversion rate results',
        'C',
        'Because the 95% confidence interval spans across zero (from negative to positive), the result is not statistically significant at the 5% alpha level. We cannot confidently rule out that the true effect is zero or negative. Option A fundamentally misinterprets point estimates. Option B is wrong because the test isn''t necessarily broken, just inconclusive. Option D misinterprets the 5% alpha risk.',
        ARRAY['confidence_intervals', 'statistical_significance', 'ab_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'There is a 95% chance that the true conversion lift is exactly 4.2%.', false),
    (v_q_id, 'B', 'The test was severely underpowered and must be restarted from scratch immediately.', false),
    (v_q_id, 'C', 'The results are not statistically significant because the interval includes zero.', true),
    (v_q_id, 'D', 'The new checkout flow is mathematically guaranteed to harm conversion 5% of the time.', false);

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
        'YouTube''s Power Law',
        E'A new YouTube PM is modeling the distribution of views across all videos on the platform. They assume the data will form a normal distribution (bell curve), where most videos get an "average" number of views. What distribution actually models YouTube views in reality?',
        'foundational',
        'YouTube',
        'Analyzing platform-wide engagement distribution',
        'B',
        'Internet engagement, especially content popularity, follows a power law (Pareto) distribution, not a normal distribution. A tiny fraction of viral videos get the vast majority of views, while the massive "long tail" of videos get almost zero. Option A is wrong; algorithms exacerbate skew. Options C and D are statistical distributions used for binary outcomes and rare independent events, respectively.',
        ARRAY['data_distributions', 'power_law', 'long_tail']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A uniform distribution, where views are distributed evenly due to the recommendation algorithm.', false),
    (v_q_id, 'B', 'A power law distribution, where a tiny fraction of videos get the vast majority of views.', true),
    (v_q_id, 'C', 'A binomial distribution, since videos either go viral or get zero views.', false),
    (v_q_id, 'D', 'A Poisson distribution, because video views happen over continuous time intervals.', false);

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
        'Slack''s Type I Error',
        E'Slack''s PM tests a new notification sound. The test shows a 1% increase in message response rates (p=0.04), so the PM ships it to all users. A month later, overall response rates haven''t changed. Assuming no bugs or seasonal effects, what statistical outcome likely occurred?',
        'foundational',
        'Slack',
        'Post-launch analysis of a shipped feature',
        'A',
        'A Type I Error (False Positive) occurs when you reject the null hypothesis despite it being true. At a p-value of 0.04, there was a 4% chance the test would show a "significant" result purely due to random noise, which is exactly what happened here. Option B describes a False Negative. Option C impacts early metrics but p-values dictate the statistical error type here. Option D is an unfounded assumption.',
        ARRAY['type_i_error', 'false_positive', 'hypothesis_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM encountered a Type I Error (False Positive), shipping a feature that actually had no effect.', true),
    (v_q_id, 'B', 'The PM encountered a Type II Error (False Negative), failing to detect a real long-term effect.', false),
    (v_q_id, 'C', 'The test suffered from the novelty effect, which inherently inflates the calculated p-value.', false),
    (v_q_id, 'D', 'The PM did not calculate the standard error correctly before launching.', false);

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
        'LinkedIn''s Underpowered Test',
        E'LinkedIn''s PM wants to test a major redesign of the Jobs page. Because leadership is nervous, the PM only runs the test for 2 days on 1% of traffic. The results show no significant difference (p=0.45), so the PM abandons the redesign. What statistical risk did the PM fall victim to?',
        'foundational',
        'LinkedIn',
        'Running a high-stakes UI redesign test',
        'C',
        'By running the test on very low traffic for a very short time, the test had extremely low statistical power. This leads to a high risk of a Type II Error (False Negative)—failing to detect a real improvement because there wasn''t enough data to separate the signal from the noise. Option A is incorrect; low power prevents false positives. Options B and D are logical fallacies in this specific context.',
        ARRAY['type_ii_error', 'false_negative', 'statistical_power']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A high risk of a Type I Error (False Positive), mistakenly thinking the redesign worked.', false),
    (v_q_id, 'B', 'A high risk of Simpson''s Paradox, where the results would mathematically flip over time.', false),
    (v_q_id, 'C', 'A high risk of a Type II Error (False Negative), failing to detect a real effect due to low power.', true),
    (v_q_id, 'D', 'A high risk of confirmation bias, as the PM expected the test to fail from the start.', false);

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
        'Stripe''s Dashboard Survey Bias',
        E'Stripe''s PM wants to gauge user satisfaction with the developer dashboard. They place a pop-up survey exclusively on the "Advanced API Settings" page. The survey results show an incredibly high 95% satisfaction rate. What is the primary statistical flaw in using this to report overall platform satisfaction?',
        'foundational',
        'Stripe',
        'Gathering user satisfaction data via survey',
        'D',
        'Selection bias occurs when the sample data is not representative of the broader population. By placing the survey only on an "Advanced" page, the PM only sampled highly technical, engaged power users, ignoring the vast majority of standard users who might find the dashboard confusing. Option A implies users already left. Option B relates to the PM''s interpretation, not the sampling mechanism itself.',
        ARRAY['selection_bias', 'sampling_bias', 'survey_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Survivorship bias; users who hated the dashboard have already churned and closed their accounts.', false),
    (v_q_id, 'B', 'Confirmation bias; the PM deliberately asked questions that would yield a 95% score.', false),
    (v_q_id, 'C', 'Non-response bias; 95% is too high, indicating users just clicked "Yes" to close the pop-up.', false),
    (v_q_id, 'D', 'Selection bias; the sample only includes advanced users, not the broader user base.', true);

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
        'Instagram''s Segmented Paradox',
        E'Instagram tests a new feed algorithm. Overall, the new algorithm shows a lower engagement rate than the control. However, when segmenting by OS:\n\n| Group | iOS Engagement | Android Engagement | Total Engagement |\n|---|---|---|---|\n| Control | 10% (1k users) | 4% (9k users) | 4.6% |\n| Variant | 12% (9k users) | 5% (1k users) | 4.3% |\n\nThe Variant is higher on both iOS and Android individually. How is this possible?',
        'intermediate',
        'Instagram',
        'Analyzing A/B test results broken down by OS',
        'B',
        'This is a textbook example of Simpson''s Paradox. It occurs when a trend appears in different groups of data but disappears or reverses when these groups are combined. This happens because the sample sizes and baseline conversion rates across the hidden variable (OS, here) are heavily imbalanced between the control and variant groups. Option A, C, and D describe entirely unrelated statistical phenomena.',
        ARRAY['simpsons_paradox', 'confounding_variables', 'data_segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Central Limit Theorem failed because the underlying user data was not normally distributed.', false),
    (v_q_id, 'B', 'Simpson''s Paradox; the overall rate is heavily skewed by the vastly imbalanced sample sizes.', true),
    (v_q_id, 'C', 'Regression to the mean; the engagement metrics naturally normalized over the duration of the test.', false),
    (v_q_id, 'D', 'The tracking is mathematically broken; an overall rate cannot be lower if both segments are higher.', false);

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
        'Discord''s Metric Fishing',
        E'Discord''s PM runs an A/B test on onboarding. Day 1 Retention (the primary metric) shows no significant change. The PM then checks 20 secondary metrics: messages sent, friends added, avatars changed, etc. They find "friends added" increased significantly (p=0.04) and declare the test a success. What error did the PM make?',
        'intermediate',
        'Discord',
        'Evaluating secondary metrics after a failed primary metric',
        'C',
        'This is the multiple comparisons problem (or p-hacking). If you test 20 different metrics with a 5% false-positive rate (alpha = 0.05), you have a high probability (1 - 0.95^20 ≈ 64%) of finding at least one "statistically significant" result purely by random chance. You must apply corrections (like Bonferroni) to adjust for this. Options A, B, and D do not describe this mathematical reality.',
        ARRAY['multiple_comparisons', 'p_hacking', 'family_wise_error_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The novelty effect; users added friends just because the UI looked slightly different.', false),
    (v_q_id, 'B', 'Peeking; the PM looked at the results before the required sample size was fully accumulated.', false),
    (v_q_id, 'C', 'The multiple testing problem; checking 20 metrics vastly inflates the chance of a false positive.', true),
    (v_q_id, 'D', 'Network effects; adding friends inherently biases the treatment group against the control.', false);

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
        'Amazon''s Linear Regression',
        E'An Amazon PM runs a linear regression to predict daily units sold (Y) based on item price in dollars (X). The equation is: Y = 500 - 10X. The p-value for the X coefficient is < 0.01. How should the PM correctly interpret this coefficient?',
        'intermediate',
        'Amazon',
        'Interpreting pricing elasticity using linear regression',
        'B',
        'In linear regression, the coefficient (-10) represents the expected change in the dependent variable (Y) for a 1-unit change in the independent variable (X). A p-value < 0.01 indicates this relationship is statistically significant. Option A misinterprets the intercept (500). Option C confuses the coefficient with R-squared (variance explained). Option D mathematically misreads the equation.',
        ARRAY['linear_regression', 'coefficients', 'predictive_modeling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The average item price is $10, which predictably results in 500 daily units sold.', false),
    (v_q_id, 'B', 'For every $1 increase in price, the model predicts daily sales will decrease by 10 units.', true),
    (v_q_id, 'C', 'The price of the item explains exactly 10% of the variance in total daily units sold.', false),
    (v_q_id, 'D', 'A $10 increase in item price will completely reduce sales by an average of 500 units.', false);

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
        'Peloton''s Confounding Factor',
        E'A Peloton PM sees a strong positive correlation: users who buy expensive Peloton Apparel ride more than 15 times a month. The PM proposes offering steep discounts on Apparel to randomly selected users, expecting it to drive up their ride counts. What statistical concept is the PM ignoring?',
        'intermediate',
        'Peloton',
        'Designing growth tactics based on correlational data',
        'D',
        'The PM is ignoring confounding variables. A third factor—such as high disposable income or a deep personal commitment to fitness—is likely causing *both* the apparel purchase and the high ride counts. Simply giving someone apparel won''t magically give them the motivation to ride more. Option A is a different statistical law. Option B is irrelevant here. Option C is a modeling issue.',
        ARRAY['confounding_variables', 'correlation_vs_causation', 'omitted_variable_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The law of large numbers; the correlation will naturally diminish as the user base scales.', false),
    (v_q_id, 'B', 'Survivorship bias; users who don''t ride frequently probably returned their bikes already.', false),
    (v_q_id, 'C', 'Multicollinearity; apparel purchases and ride counts are essentially the exact same metric.', false),
    (v_q_id, 'D', 'A confounding variable; underlying fitness dedication likely causes both behaviors independently.', true);

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
        'Pinterest''s Onboarding Bias',
        E'Pinterest''s PM wants to redesign the new user onboarding flow. To understand what makes a successful onboarding experience, they conduct deep-dive interviews with 50 "Power Creators" who joined 5 years ago and use the app daily. What statistical bias invalidates this research?',
        'intermediate',
        'Pinterest',
        'Conducting user research for new user acquisition',
        'C',
        'This is survivorship bias. By only interviewing the most successful users who survived the onboarding flow, the PM completely misses data from users who found the flow confusing and churned. To fix onboarding, you must study the drop-offs. Option A is a different behavioral bias. Option B is broad and less precise. Option D is true but secondary to the survivorship flaw.',
        ARRAY['survivorship_bias', 'user_research', 'sampling_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Observation bias; creators might lie about their early experiences to sound more impressive.', false),
    (v_q_id, 'B', 'Selection bias; power creators are inherently more visual than standard text-based users.', false),
    (v_q_id, 'C', 'Survivorship bias; they are entirely missing data from the users who churned during onboarding.', true),
    (v_q_id, 'D', 'Recency bias; the creators are recalling recent features rather than their initial onboarding.', false);

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
        'Spotify''s Effect Size Fallacy',
        E'Spotify tests changing the "Play" button color. The test results show an increase in clicks with a p-value of 0.0001. The PM presents this to leadership: "The p-value is extremely low, which proves this color change has a massive impact on user engagement." Why is the PM wrong?',
        'intermediate',
        'Spotify',
        'Presenting A/B test significance to leadership',
        'D',
        'A p-value only measures the probability of observing the data if the null hypothesis is true (i.e., statistical significance). It does NOT measure the magnitude or practical importance of the effect (the effect size). You can have a tiny p-value for a mathematically true but practically useless 0.001% increase if the sample size is huge. Options A, B, and C are incorrect statistical assertions.',
        ARRAY['p_value', 'effect_size', 'statistical_significance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A p-value of 0.0001 actually means there is a 99.99% chance the effect size is massive.', false),
    (v_q_id, 'B', 'The PM should be using a strict alpha of 0.01 instead of a p-value to determine effect size.', false),
    (v_q_id, 'C', 'The low p-value actually proves the result is entirely due to the novelty effect.', false),
    (v_q_id, 'D', 'A p-value measures evidence against the null hypothesis, not the size or importance of the effect.', true);

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
        'Netflix''s Guardrail Tradeoffs',
        E'To ensure absolute quality, Netflix''s experimentation platform strictly requires an alpha of 0.01 (1% significance level) instead of the industry-standard 0.05. While this prevents launching bad features, what is the direct statistical consequence of this strict threshold?',
        'intermediate',
        'Netflix',
        'Setting platform-wide A/B testing thresholds',
        'A',
        'There is a direct tradeoff between Type I errors (False Positives) and statistical power. By lowering alpha to 0.01, you require much stronger evidence to declare a winner. This significantly decreases your statistical power, leading to more Type II errors (False Negatives)—meaning you will fail to detect and launch features that actually do have a positive effect. Options B, C, and D are false.',
        ARRAY['statistical_power', 'alpha_level', 'type_ii_error']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It decreases statistical power, increasing the False Negative rate (missing true positive effects).', true),
    (v_q_id, 'B', 'It completely eliminates the multiple comparisons problem when looking at secondary metrics.', false),
    (v_q_id, 'C', 'It inherently drastically increases the Minimum Detectable Effect (MDE) required to run any test.', false),
    (v_q_id, 'D', 'It narrows the confidence intervals, making all point estimates mathematically more precise.', false);

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
        'Airbnb''s Overlapping Intervals',
        E'Airbnb tests two new pricing display formats against the control.\n\nFormat A vs Control: +3.0% lift (95% CI: [+1.1%, +4.9%])\nFormat B vs Control: +4.0% lift (95% CI: [+2.5%, +5.5%])\n\nThe PM declares Format B the winner over Format A. Is this statistically sound based *only* on this data?',
        'intermediate',
        'Airbnb',
        'Comparing two treatment groups in an A/B/n test',
        'C',
        'When comparing two treatment variants against each other, overlapping confidence intervals (A goes up to 4.9%, B goes down to 2.5%) mean you cannot definitively conclude B is better than A without running a direct statistical test between the two variants. Option A relies on point estimates. Option B relies on lower bounds. Option D misinterprets the 1% threshold.',
        ARRAY['confidence_intervals', 'ab_testing', 'statistical_comparison']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, because Format B''s point estimate (+4.0%) is mathematically larger than Format A''s (+3.0%).', false),
    (v_q_id, 'B', 'Yes, because Format B''s lower bound (+2.5%) is strictly higher than Format A''s (+1.1%).', false),
    (v_q_id, 'C', 'No, because the intervals heavily overlap, meaning we cannot confidently say B is better than A.', true),
    (v_q_id, 'D', 'No, because both formats still include a margin of error above 1%, rendering them inconclusive.', false);

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
        'Uber''s Earnings Anomaly',
        E'An Uber market manager sees that drivers in Chicago had a terrible week of earnings (3 standard deviations below average). The manager quickly implements a "Driver Motivation Email" campaign. The next week, earnings jump back to normal. The manager takes credit. What is the most likely statistical explanation?',
        'intermediate',
        'Uber',
        'Analyzing operational interventions after extreme events',
        'D',
        'Regression to the mean dictates that extreme outlier events are statistically highly likely to be followed by more normal events, regardless of any intervention. The terrible week was likely a random anomaly (e.g., bad weather), and the return to normal would have happened with or without the email. Options A, B, and C attempt to force a causal relationship that is fundamentally unlikely.',
        ARRAY['regression_to_the_mean', 'causal_inference', 'outlier_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Hawthorne effect; drivers earned more simply because they knew they were being observed.', false),
    (v_q_id, 'B', 'A confounding variable; the email caused drivers to drive more hours, which increased earnings.', false),
    (v_q_id, 'C', 'A Type II Error; the manager failed to realize the previous week was actually a data pipeline glitch.', false),
    (v_q_id, 'D', 'Regression to the mean; extreme outliers naturally tend to return closer to the average over time.', true);

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
        'LinkedIn''s Network Violation',
        E'LinkedIn tests a new messaging interface. They randomly assign 50% of users to treatment (new UI) and 50% to control (old UI). However, control users start receiving weird error messages when treatment users message them using new features. What core assumption of A/B testing has been violated?',
        'intermediate',
        'LinkedIn',
        'Testing features on a highly connected social graph',
        'C',
        'SUTVA (Stable Unit Treatment Value Assumption) requires that the treatment assigned to one user does not affect the outcome of another user. In social networks or two-sided marketplaces, this is frequently violated (network effects/interference). The treatment group messaging the control group broke SUTVA. Options A, B, and D are standard statistical concepts that do not apply to this specific interference.',
        ARRAY['sutva', 'network_effects', 'ab_testing_assumptions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Central Limit Theorem; the sample sizes between the network clusters are no longer balanced.', false),
    (v_q_id, 'B', 'Simpson''s Paradox; the messaging feature works fundamentally differently for senders vs receivers.', false),
    (v_q_id, 'C', 'SUTVA (Stable Unit Treatment Value Assumption); the treatment group interfered with the control group.', true),
    (v_q_id, 'D', 'Selection Bias; only highly connected power users are triggering the error messages.', false);

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
        'Shopify''s Flash Sale Strategy',
        E'Shopify wants to test 5 different promotional banners for a 48-hour Black Friday flash sale. A standard A/B/n test won''t reach significance fast enough. The PM decides to use a Multi-Armed Bandit (MAB) algorithm. How does the MAB solve their specific problem?',
        'intermediate',
        'Shopify',
        'Optimizing conversions during short, high-traffic events',
        'B',
        'Unlike standard A/B tests which wait until the end to declare a winner, Multi-Armed Bandits dynamically shift traffic toward winning variants in real-time. This balances "exploration" (finding the best banner) with "exploitation" (maximizing immediate conversions), which is crucial for short-lived events like Black Friday. Options A, C, and D misrepresent how MABs function.',
        ARRAY['multi_armed_bandit', 'ab_testing', 'exploitation_vs_exploration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It permanently reduces the alpha threshold to 0.10, allowing the test to reach significance 5x faster.', false),
    (v_q_id, 'B', 'It dynamically shifts traffic to winning banners in real-time, maximizing total event conversions.', true),
    (v_q_id, 'C', 'It uses Bayesian priors from last year to completely skip the initial exploration phase.', false),
    (v_q_id, 'D', 'It guarantees that all 5 banners receive exactly 20% of traffic, ensuring perfectly balanced samples.', false);

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
        'DoorDash''s Skewed AOV',
        E'DoorDash''s PM is analyzing Average Order Value (AOV). A few extreme corporate catering orders (e.g., $5,000) are heavily pulling the arithmetic mean upward, making it look like the average user spends $65, when most orders are actually around $25. Which metric should the PM use to reflect the "typical" order?',
        'intermediate',
        'DoorDash',
        'Handling extreme outliers in financial data',
        'A',
        'When data is heavily skewed by extreme outliers (like a few $5k orders among thousands of $25 orders), the median (the 50th percentile) is a much more robust measure of central tendency than the mean. It accurately reflects the "typical" user experience. The mode (Option C) can be noisy. Standard deviation (Option B) measures variance, not central tendency. Option D is an arbitrary, extreme trim.',
        ARRAY['median', 'mean', 'outlier_handling', 'skewed_distributions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Median (50th percentile), because it is highly robust to extreme outliers in a skewed distribution.', true),
    (v_q_id, 'B', 'The Standard Deviation, because it will automatically mathematically normalize the corporate orders.', false),
    (v_q_id, 'C', 'The Mode, because the absolute most common exact order value is the only true reflection of users.', false),
    (v_q_id, 'D', 'A trimmed mean explicitly dropping the bottom 50% and top 1% of all historical orders.', false);

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
        'Slack''s Subtle MDE',
        E'Slack''s PM wants to test a subtle font color change. The Data Scientist calculates that for a 2-week test with current traffic, the Minimum Detectable Effect (MDE) is 5%. The PM only realistically expects the font change to have a 0.5% impact. What is the most statistically sound decision?',
        'intermediate',
        'Slack',
        'Evaluating MDE constraints before running an experiment',
        'C',
        'If your expected impact (0.5%) is vastly smaller than the MDE (5%), the test is severely underpowered. If you run it for 2 weeks, you will almost certainly get a neutral result, wasting time. You must either run it much longer to lower the MDE, or just ship it if the engineering cost is near zero. Options A, B, and D lead to statistically invalid or operationally foolish outcomes.',
        ARRAY['minimum_detectable_effect', 'sample_size', 'statistical_power']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run the test anyway for 2 weeks; if the p-value is < 0.05, the 0.5% impact will still be valid.', false),
    (v_q_id, 'B', 'Increase the MDE in the calculator to 10% to force the sample size to fit the 2-week window.', false),
    (v_q_id, 'C', 'Do not run a 2-week test; either run it much longer, or just ship it without an experiment.', true),
    (v_q_id, 'D', 'Run a Multi-Armed Bandit instead, as bandits fundamentally do not require an MDE calculation.', false);

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
        'Stripe''s Conversion Clash',
        E'Stripe runs two A/B tests simultaneously on the same checkout page.\nTest 1 (Green Button) vs Control: +2% lift\nTest 2 (Trust Badge) vs Control: +1% lift\nHowever, users who are exposed to BOTH the green button and the trust badge experience a -3% drop in conversion. What phenomenon is this?',
        'intermediate',
        'Stripe',
        'Analyzing concurrent A/B test collisions',
        'D',
        'This is a negative interaction effect. When two independent features are tested simultaneously on the same users, they can conflict visually, technically, or cognitively. While they work well in isolation, combining them creates a worse experience. Option A is regarding data segmentation. Option B is about false positives. Option C is about stealing traffic, not a combined user state.',
        ARRAY['interaction_effects', 'multivariate_testing', 'ab_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Simpson''s Paradox; the aggregate data fundamentally contradicts the segmented isolated data.', false),
    (v_q_id, 'B', 'The multiple comparisons problem; running two tests simultaneously guarantees a false negative.', false),
    (v_q_id, 'C', 'Cannibalization; the trust badge is effectively stealing direct clicks from the main Pay button.', false),
    (v_q_id, 'D', 'A negative interaction effect; the two features interact poorly when combined, harming conversion.', true);

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
        'Instagram''s Churn Model',
        E'Instagram''s data team is building a model to predict whether a specific user will churn (Yes/No) within the next 30 days based on three variables: daily session length, follower count, and number of app opens. Which statistical model is fundamentally designed for this type of binary outcome?',
        'intermediate',
        'Instagram',
        'Choosing the right predictive model for binary states',
        'A',
        'Logistic Regression is specifically designed for classification tasks where the outcome is binary (e.g., Churn: Yes/No, Click: Yes/No). It maps continuous inputs to a probability between 0 and 1. Linear regression (Option B) is for continuous outputs (e.g., predicting revenue). K-Means (Option C) is for unsupervised clustering. PCA (Option D) is for dimensionality reduction.',
        ARRAY['logistic_regression', 'predictive_modeling', 'binary_classification']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Logistic Regression, because it specifically models the probability of a discrete, binary outcome.', true),
    (v_q_id, 'B', 'Linear Regression, because churn probability decreases strictly linearly with more followers.', false),
    (v_q_id, 'C', 'K-Means Clustering, because it will automatically group users into "Churn" and "Retain" clusters.', false),
    (v_q_id, 'D', 'Principal Component Analysis (PCA), because it reduces the three variables into a single score.', false);

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
        'YouTube''s Synthetic Control',
        E'YouTube''s PM wants to know if buying YouTube Premium *causes* users to watch more video. Since they cannot randomly force users to buy Premium, they pair each Premium user with a Free user who has nearly identical historical viewing habits, demographics, and tenure. What causal inference technique is this?',
        'intermediate',
        'YouTube',
        'Estimating causal impact using observational data',
        'B',
        'This is Propensity Score Matching (or exact matching). When you can''t run an RCT (A/B test), you create a synthetic control group from historical data that mirrors the treatment group as closely as possible to isolate the causal effect of the treatment (Premium). Option A looks at pre/post trends. Option C is a sampling technique. Option D is an active experimentation algorithm.',
        ARRAY['propensity_score_matching', 'causal_inference', 'observational_data']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Difference-in-Differences; comparing the pre-period and post-period trends of the two groups.', false),
    (v_q_id, 'B', 'Propensity Score Matching; creating a synthetic control group to mimic a randomized experiment.', true),
    (v_q_id, 'C', 'Stratified Sampling; ensuring that exactly 50% of the sample is Premium and 50% is Free.', false),
    (v_q_id, 'D', 'Multi-Armed Bandit; dynamically pairing users based on their mathematical likelihood to subscribe.', false);

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
        'Amazon''s Holiday Spike',
        E'An Amazon PM launches a new recommendation algorithm on November 15th. They compare daily revenue to the first week of November and proudly report a massive 30% increase caused by the algorithm. The VP of Analytics immediately rejects this conclusion. What obvious statistical factor did the PM ignore?',
        'intermediate',
        'Amazon',
        'Interpreting time-series data around major events',
        'C',
        'The PM completely ignored seasonality. Mid-to-late November coincides with the massive organic traffic surge of Black Friday and holiday shopping. Revenue would have spiked 30% regardless of the algorithm. You cannot compare sequential time periods directly when strong seasonality exists. Options A, B, and D are technical statistical critiques that miss the massive real-world business confounder.',
        ARRAY['seasonality', 'time_series_analysis', 'confounding_variables']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM failed to use a rigorous two-tailed t-test to measure the revenue increase.', false),
    (v_q_id, 'B', 'The PM should have used a log transformation on the raw revenue data before calculating lifts.', false),
    (v_q_id, 'C', 'The PM failed to account for seasonality; revenue naturally spikes in late November anyway.', true),
    (v_q_id, 'D', 'The PM did not segment the users by Prime status, triggering a hidden Simpson''s Paradox.', false);

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
        'Pinterest''s Bayesian Switch',
        E'Pinterest''s data science team decides to transition their entire A/B testing platform from a traditional Frequentist model (using p-values) to a Bayesian statistical model. From a PM''s perspective, what is the primary practical advantage of interpreting Bayesian results?',
        'intermediate',
        'Pinterest',
        'Understanding different statistical philosophies in testing',
        'D',
        'Bayesian statistics output intuitive probabilities (e.g., "There is a 92% chance Variant B is better than Control"). Frequentist p-values are highly unintuitive ("Assuming the null is true, there is an 8% chance of seeing this data"). PMs greatly prefer Bayesian outputs for communicating risk and making business decisions. Options A, B, and C are completely false claims about Bayesian models.',
        ARRAY['bayesian_statistics', 'frequentist_statistics', 'ab_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Bayesian models completely eliminate the need for sample size planning or stopping rules.', false),
    (v_q_id, 'B', 'Bayesian models mathematically eliminate the risk of Type I (False Positive) errors entirely.', false),
    (v_q_id, 'C', 'Bayesian models only work on binary metrics like conversion, simplifying the analytics dashboard.', false),
    (v_q_id, 'D', 'Bayesian results output a direct probability of success, which is much easier for PMs to interpret.', true);

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
        'Uber''s Continuous Paradox',
        E'An Uber researcher plots average driver earnings (Y) against hours driven (X) and finds a negative correlation: driving more hours correlates with *lower* hourly earnings. However, when the researcher adds "City" as a control variable in a multivariate regression, the coefficient for hours driven suddenly becomes *positive*. What does this indicate?',
        'advanced',
        'Uber',
        'Diagnosing complex correlational flips in regression models',
        'A',
        'This is a continuous variation of Simpson''s Paradox. The overall negative correlation is an illusion caused by the confounding variable "City." Drivers in high-paying cities (like NYC) happen to drive fewer hours on average, while drivers in low-paying cities drive more hours. Once you control for the city, the true positive relationship between hours and earnings reveals itself. Options B, C, and D are unrelated concepts.',
        ARRAY['simpsons_paradox', 'multivariate_regression', 'confounding_variables']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A continuous Simpson''s Paradox; the overall negative correlation is driven by City-level baselines.', true),
    (v_q_id, 'B', 'Multicollinearity; "City" and "Hours Driven" are perfectly correlated, breaking the regression.', false),
    (v_q_id, 'C', 'Heteroskedasticity; the variance in earnings expands exponentially as drivers work more hours.', false),
    (v_q_id, 'D', 'Survivorship bias; only drivers who earn high hourly rates can afford to work fewer hours.', false);

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
        'Airbnb''s DiD Impact',
        E'Airbnb launches a massive billboard campaign in Chicago, but not in Boston. \n- Chicago bookings grew 15% post-launch.\n- Boston bookings grew 5% in the exact same period.\nHistorically, Chicago and Boston have completely identical seasonal booking trends. Using Difference-in-Differences (DiD), what is the estimated causal impact of the billboards?',
        'advanced',
        'Airbnb',
        'Calculating causal impact using quasi-experimental design',
        'C',
        'Difference-in-Differences isolates the causal effect by subtracting the control group''s trend from the treatment group''s trend. Since Boston grew 5% without billboards, we assume Chicago would have also grown 5% naturally. The 15% actual growth minus the 5% baseline growth leaves a 10% causal impact attributable to the billboards. Options A, B, and D apply incorrect math.',
        ARRAY['difference_in_differences', 'causal_inference', 'quasi_experiment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '15%; Boston''s data is irrelevant since the billboards were exclusively in Chicago.', false),
    (v_q_id, 'B', '20%; DiD adds the two growth rates together to strictly account for the baseline variance.', false),
    (v_q_id, 'C', '10%; DiD subtracts the control group''s baseline trend from the treatment group''s total trend.', true),
    (v_q_id, 'D', '7.5%; DiD mathematically averages the growth rates of the treatment and control groups.', false);

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
        'DoorDash''s Bootstrapped Median',
        E'DoorDash is testing a new tipping UI. The PM wants a confidence interval for the *median* tip amount. Because tip distribution is highly non-normal and formulas for the variance of a median are complex, the Data Scientist uses a technique called Bootstrapping. How does Bootstrapping mathematically work?',
        'advanced',
        'DoorDash',
        'Calculating confidence intervals for complex, non-normal metrics',
        'B',
        'Bootstrapping is a powerful non-parametric technique. It involves repeatedly drawing random samples (with replacement) from your existing experimental data to create thousands of simulated datasets. You calculate the median for each simulation, which generates a distribution of medians, allowing you to easily find the 95% confidence interval. Options A, C, and D are incorrect data transformations.',
        ARRAY['bootstrapping', 'non_parametric', 'median', 'confidence_intervals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It uses historical data from the past year to build a baseline prior before calculating the median.', false),
    (v_q_id, 'B', 'It repeatedly draws random samples with replacement from the test data to simulate a distribution.', true),
    (v_q_id, 'C', 'It drops the top 5% and bottom 5% of outliers before applying a standard normal formula.', false),
    (v_q_id, 'D', 'It forces the sample data into a normal distribution using a strict logarithmic transformation.', false);

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
        'Stripe''s Instrumental Variable',
        E'Stripe wants to measure if using their "Radar" fraud tool *causes* merchant revenue to increase. Because merchants self-select into Radar, there''s massive selection bias. The Data Scientist uses an "Instrumental Variable" (IV): whether a merchant was randomly sent a promotional email about Radar. For this IV to be statistically valid, what MUST be true?',
        'advanced',
        'Stripe',
        'Applying advanced econometric models to circumvent bias',
        'D',
        'For an Instrumental Variable to be valid, it must meet two criteria: 1) It must strongly influence the treatment (the email must actually cause merchants to adopt Radar), and 2) The Exclusion Restriction: it must only affect the final outcome (revenue) *through* its effect on the treatment. The email itself cannot directly cause merchants to make more money. Options A, B, and C are incorrect requirements.',
        ARRAY['instrumental_variables', 'causal_inference', 'selection_bias']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The email must have a perfectly linear correlation with the merchant''s final revenue numbers.', false),
    (v_q_id, 'B', 'The email must be sent to exactly 50% of the merchant base to satisfy the Central Limit Theorem.', false),
    (v_q_id, 'C', 'The email must randomly assign actual Radar pricing to control for omitted variable bias.', false),
    (v_q_id, 'D', 'The email must only affect merchant revenue through its effect on increasing Radar adoption.', true);

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
        'Spotify''s Sequential Peeking',
        E'Spotify''s PM is desperate for a win and checks the A/B test dashboard daily. On Day 4, the p-value dips to 0.04. The PM stops the test and ships. To prevent this "peeking" from artificially inflating the False Positive rate, what advanced statistical framework should the data platform team implement?',
        'advanced',
        'Spotify',
        'Preventing p-hacking and peeking in testing platforms',
        'B',
        'Sequential Testing (using methods like SPRT or alpha-spending functions) mathematically adjusts the significance threshold based on how frequently you check the results. If you peek early, the threshold is severely strict (e.g., p < 0.001) and gradually loosens over time. This allows PMs to peek without ruining the test''s integrity. Options A, C, and D do not solve continuous peeking.',
        ARRAY['sequential_testing', 'peeking', 'false_positive_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stratified Sampling, which ensures traffic is evenly distributed regardless of when the PM checks.', false),
    (v_q_id, 'B', 'Sequential Testing, which dynamically adjusts the required alpha threshold based on check frequency.', true),
    (v_q_id, 'C', 'A two-tailed t-test, which automatically accounts for peeking on either side of the distribution.', false),
    (v_q_id, 'D', 'The Bonferroni correction, which adjusts the p-value based strictly on the current sample size.', false);

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
        'Shopify''s Regression Discontinuity',
        E'Shopify offers a free dedicated account manager to merchants who cross exactly $1M in annual GMV. A PM wants to measure the causal impact of account managers on subsequent store growth. Because assignment is based strictly on a hard cutoff, what quasi-experimental technique is perfectly suited for this?',
        'advanced',
        'Shopify',
        'Measuring causal impact around strict business rules',
        'A',
        'Regression Discontinuity Design (RDD) is perfect when treatment is assigned via a strict threshold. It compares subjects just barely below the threshold (e.g., $990k GMV) to those just barely above it ($1.01M GMV). Since these two groups are essentially identical in nature, any sudden jump in their subsequent growth can be causally attributed to the account manager. Options B, C, and D are inferior or impossible here.',
        ARRAY['regression_discontinuity_design', 'causal_inference', 'quasi_experiment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Regression Discontinuity Design (RDD); comparing growth of merchants just below vs just above $1M.', true),
    (v_q_id, 'B', 'Propensity Score Matching; pairing $100k merchants with $1M merchants based on store category.', false),
    (v_q_id, 'C', 'Difference-in-Differences; comparing the growth of the $1M merchants this year to last year.', false),
    (v_q_id, 'D', 'An A/B test; randomly revoking account managers from half of the $1M merchants to form a control.', false);

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
        'Netflix''s Hidden Stratification',
        E'Netflix tests a new auto-play trailer format. The overall A/B test shows zero statistically significant impact on watch time. However, an advanced analysis of "Heterogeneous Treatment Effects" (HTE) reveals a crucial insight. In the context of A/B testing, what does finding strong HTE mean?',
        'advanced',
        'Netflix',
        'Diagnosing flat top-line metrics using deep segmentation',
        'C',
        'Heterogeneous Treatment Effects occur when a treatment impacts different sub-populations in vastly different ways. For example, mobile users might have hated the auto-play (watch time down), while smart TV users loved it (watch time up). In the overall aggregate, these effects cancel each other out to zero. Uncovering HTE is critical for product strategy. Options A, B, and D misdefine the concept entirely.',
        ARRAY['heterogeneous_treatment_effects', 'data_segmentation', 'ab_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The treatment caused a severe degradation in app performance, acting as a heterogeneous confounder.', false),
    (v_q_id, 'B', 'The variance of the treatment group was much larger than control, violating the t-test assumptions.', false),
    (v_q_id, 'C', 'The treatment had vastly different, opposing effects on different sub-populations that averaged to zero.', true),
    (v_q_id, 'D', 'The metrics tracking was systematically biased depending on the user''s underlying internet speed.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Advanced Statistics';

END $$;
