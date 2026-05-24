-- ============================================
-- ASSESSMENT: Funnel Analysis
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
    WHERE slug = 'funnel-analysis';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug funnel-analysis not found. Run the seed data first.';
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
        'Spotify''s Funnel Drop-off Identification',
        E'Spotify''s PM is analyzing the premium upgrade funnel and sees the following data:\n\n* Step 1: View Pricing Page (10,000 users)\n* Step 2: Select Plan (8,000 users)\n* Step 3: Enter Payment Details (4,000 users)\n* Step 4: Complete Upgrade (3,800 users)\n\nWhere is the biggest opportunity for improvement based on relative drop-off?',
        'foundational',
        'Spotify',
        'Premium upgrade funnel',
        'B',
        'B is correct. The conversion from Step 2 to Step 3 is 50% (4,000/8,000), which represents the largest relative drop-off in the funnel. Step 1 to 2 is 80%, and Step 3 to 4 is 95%. A PM should focus on the step with the highest leakage. Options A and C are incorrect because their conversion rates are much higher. Option D is incorrect because while top-of-funnel volume is important, the question asks for the biggest opportunity within the existing funnel steps.',
        ARRAY['drop_off_diagnosis', 'conversion_rate', 'step_conversion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Step 1 to Step 2', false),
    (v_q_id, 'B', 'Step 2 to Step 3', true),
    (v_q_id, 'C', 'Step 3 to Step 4', false),
    (v_q_id, 'D', 'Top of funnel volume', false);

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
        'DoorDash''s Funnel Ordering',
        E'DoorDash''s PM sets up a funnel: "Open App -> View Restaurant -> Add to Cart -> Checkout". They notice some users have a 100% conversion rate from "Open App" directly to "Checkout", seemingly bypassing "View Restaurant". What is the most likely cause of this data anomaly?',
        'foundational',
        'DoorDash',
        'Food delivery checkout funnel',
        'B',
        'B is correct. A loose funnel (or "any order" funnel) tracks if a user completed the steps regardless of strict sequence, or allows skipping intermediate steps. Users might re-order a past meal directly from the home screen, bypassing the "View Restaurant" step. A is incorrect because this is a common valid user path, not necessarily broken tracking. C is unlikely to be the primary cause of this specific bypass. D is irrelevant to the sequence of steps.',
        ARRAY['strict_funnel', 'loose_funnel', 'event_ordering']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The tracking is broken.', false),
    (v_q_id, 'B', 'They are using a loose funnel where intermediate steps are not required.', true),
    (v_q_id, 'C', 'The users are bots.', false),
    (v_q_id, 'D', 'The funnel time window is too short.', false);

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
        'Shopify''s Conversion Window',
        E'Shopify''s Checkout PM changes the funnel conversion window from 7 days to 10 minutes. The overall conversion rate instantly drops from 45% to 20%. What user behavior did the PM most likely exclude by making this change?',
        'foundational',
        'Shopify',
        'E-commerce checkout flow',
        'A',
        'A is correct. E-commerce users frequently comparison shop, look for promo codes, or wait to retrieve their physical credit card, which often takes longer than 10 minutes. By truncating the window, the PM excluded legitimate delayed conversions. B is incorrect because immediate bounces fail both windows. C is incorrect as mobile users are not exclusively slow. D is incorrect because permanent abandoners wouldn''t convert in the 7-day window either.',
        ARRAY['session_definition', 'conversion_window', 'time_to_convert']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users who comparison shop across tabs or wait to find their credit card.', true),
    (v_q_id, 'B', 'Users who bounce immediately on the homepage.', false),
    (v_q_id, 'C', 'Users who use mobile devices.', false),
    (v_q_id, 'D', 'Users who abandoned their cart permanently.', false);

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
        'Robinhood''s Funnel Granularity',
        E'Robinhood requires users to link a bank account before funding. The PM notices a massive 60% drop-off at the "Link Bank Account" step. What is the most effective initial analytical action to diagnose this?',
        'foundational',
        'Robinhood',
        'Account funding flow',
        'A',
        'A is correct. "Link Bank Account" is likely a macro-step comprising several micro-actions (e.g., Select Bank, Enter Credentials, MFA). Breaking it down into granular events helps pinpoint whether the friction is UI-related, a technical API failure with specific banks, or an authentication issue. B is incorrect as linking a bank is a core requirement for a brokerage. C won''t solve the drop-off reason. D is prematurely testing a solution before diagnosing the specific problem.',
        ARRAY['step_granularity', 'drop_off_diagnosis', 'event_tracking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Break the "Link Bank Account" step into more granular micro-events.', true),
    (v_q_id, 'B', 'Remove the bank linking step completely.', false),
    (v_q_id, 'C', 'Increase the time window of the funnel to 30 days.', false),
    (v_q_id, 'D', 'Run an A/B test changing the button color.', false);

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
        'Uber''s Funnel Entry Point',
        E'Uber''s Growth PM defines a funnel starting with "Open App", yielding a 15% conversion to "Request Ride". Another PM defines the funnel starting with "Enter Destination", yielding a 60% conversion. Which funnel is analytically better?',
        'foundational',
        'Uber',
        'Ride request flow',
        'C',
        'C is correct. Funnels serve different purposes based on their entry point. "Open App" measures the overall effectiveness of the app at converting all sessions, including casual browsing. "Enter Destination" measures the conversion of high-intent users. Neither is objectively better; they answer different questions. A and B are wrong because they assume one metric rules all. D is wrong because broader isn''t always better if you are trying to optimize a specific high-intent flow.',
        ARRAY['top_of_funnel', 'conversion_rate', 'metric_definition']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The first one, because 15% is more realistic.', false),
    (v_q_id, 'B', 'The second one, because 60% shows higher intent.', false),
    (v_q_id, 'C', 'Neither is objectively better; they serve different analytical purposes.', true),
    (v_q_id, 'D', 'The first one, because it includes all possible users.', false);

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
        'Netflix''s Step Drop-off Diagnosis',
        E'Netflix''s Growth PM observes the sign-up funnel:\n\n* Email entry: 100k\n* Password creation: 98k\n* Plan selection: 95k\n* Payment details: 40k\n* Submit: 39k\n\nWhich step transition should the PM investigate first?',
        'foundational',
        'Netflix',
        'Subscription sign-up flow',
        'C',
        'C is correct. The transition from "Plan selection" (95k) to "Payment details" (40k) has a massive drop-off (~58% loss). This indicates massive friction or a UI failure when asking for money. The other transitions (A, B, D) have excellent conversion rates (>95%). A PM must always triage the leakiest bucket first.',
        ARRAY['drop_off_diagnosis', 'conversion_rate', 'funnel_setup']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Email to Password', false),
    (v_q_id, 'B', 'Password to Plan', false),
    (v_q_id, 'C', 'Plan to Payment', true),
    (v_q_id, 'D', 'Payment to Submit', false);

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
        'Airbnb''s Relative vs Absolute Drop-off',
        E'Airbnb''s PM is looking at the host onboarding funnel:\n\n* Step 1 (Start): 1,000 users\n* Step 2 (Photos): 500 users\n* Step 3 (Description): 400 users\n\nWhat is the relative conversion rate from Step 2 to Step 3?',
        'foundational',
        'Airbnb',
        'Host onboarding flow',
        'C',
        'C is correct. Relative conversion rate measures the percentage of users who complete a step out of those who completed the *previous* step. Here, 400 / 500 = 80%. Absolute conversion (A) would be 400 / 1000 = 40%, which measures from the top of the funnel. B and D are mathematically incorrect.',
        ARRAY['relative_conversion', 'absolute_conversion', 'funnel_math']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '40%', false),
    (v_q_id, 'B', '50%', false),
    (v_q_id, 'C', '80%', true),
    (v_q_id, 'D', '10%', false);

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
        'Amazon''s Purchase Friction',
        E'Amazon''s PM notices a high drop-off at the "Select Shipping Speed" step. They propose removing the step entirely and defaulting everyone to standard shipping to improve funnel conversion. What is the biggest risk of this change?',
        'foundational',
        'Amazon',
        'Checkout and shipping flow',
        'B',
        'B is correct. While removing steps (friction) generally increases step-to-step conversion, this specific step provides critical value to users who need fast shipping. Removing it might cause high-intent buyers to abandon their cart entirely when they see standard shipping at the final checkout. A is incorrect because it happens late in the funnel. C and D are nonsensical in this context.',
        ARRAY['friction', 'user_intent', 'conversion_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It might artificially inflate the top-of-funnel volume.', false),
    (v_q_id, 'B', 'It might decrease overall purchase conversion because users who want fast shipping will abandon their cart.', true),
    (v_q_id, 'C', 'It will violate standard funnel analytics practices.', false),
    (v_q_id, 'D', 'It will increase the time-to-convert metric.', false);

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
        'Stripe''s Funnel Segmentation',
        E'Stripe''s PM sees a 60% overall completion rate for merchant onboarding. When segmenting by device, Desktop conversion is 75% and Mobile is 20%. What should the PM do next?',
        'foundational',
        'Stripe',
        'Merchant onboarding',
        'C',
        'C is correct. A massive discrepancy between devices suggests either a technical bug on mobile, an un-optimized responsive UI, or a mismatch in user intent (e.g., users exploring on mobile but preferring to type complex business details on a keyboard). The PM must investigate the specific friction points. A is drastic. B assumes desktop is flawed. D ignores a massive potential growth lever.',
        ARRAY['segmentation', 'device_mix', 'drop_off_diagnosis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stop supporting mobile onboarding.', false),
    (v_q_id, 'B', 'Redesign the entire desktop flow to match mobile.', false),
    (v_q_id, 'C', 'Investigate the mobile UI and technical performance for specific friction points.', true),
    (v_q_id, 'D', 'Ignore it, as Desktop brings in most of the revenue anyway.', false);

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
        'Figma''s Technical vs UX Drop-off',
        E'Figma''s PM notices a sudden 30% drop in conversion from "Sign Up" to "Editor Loaded" that started yesterday. The UI has not changed in months. What is the most likely cause?',
        'foundational',
        'Figma',
        'Sign-up to editor flow',
        'B',
        'B is correct. A sudden, massive drop in a funnel step without UI changes is almost always a technical regression, API failure, or infrastructure outage. UX issues or pricing concerns (A, C) cause gradual shifts or establish long-term baselines, not overnight cliffs. D would affect top-of-funnel acquisition, not mid-funnel conversion.',
        ARRAY['drop_off_diagnosis', 'technical_friction', 'conversion_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users suddenly decided the product is too expensive.', false),
    (v_q_id, 'B', 'A technical regression or bug is preventing the editor from loading.', true),
    (v_q_id, 'C', 'The paradox of choice is overwhelming users.', false),
    (v_q_id, 'D', 'A competitor launched a new marketing campaign.', false);

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
        'Notion''s Funnel Re-ordering',
        E'Notion requires users to invite teammates during onboarding. Currently, this step is before users create their first page. A PM moves the "Invite Teammates" step to *after* the user creates their first page. What is the expected impact on the funnel?',
        'intermediate',
        'Notion',
        'User onboarding flow',
        'B',
        'B is correct. By moving the friction of inviting teammates until after the user has experienced core value (creating a page), the conversion to "First Page" will increase. Furthermore, users who reach the invite step will have higher intent and context, likely improving the quality of invites. A is wrong because intent typically increases. C is incorrect as the number of steps is the same. D is unrelated to step ordering.',
        ARRAY['step_ordering', 'friction', 'user_intent']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conversion to "First Page Created" will decrease, but "Teammates Invited" will increase.', false),
    (v_q_id, 'B', 'Conversion to "First Page Created" will increase, and users who reach "Invite Teammates" will have higher intent.', true),
    (v_q_id, 'C', 'Overall time-to-convert will decrease significantly.', false),
    (v_q_id, 'D', 'The funnel will become a loose funnel.', false);

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
        'Peloton''s Time-to-Convert Distribution',
        E'Peloton''s PM is measuring the funnel from "View Bike" to "Purchase". They use a 24-hour conversion window, resulting in a 2% conversion rate. User interviews reveal people take weeks to discuss a $2,000 purchase with their spouse. How should the PM adjust the funnel?',
        'intermediate',
        'Peloton',
        'Purchase consideration funnel',
        'B',
        'B is correct. High-ticket items have long consideration cycles. A 24-hour window artificially truncates the data, failing to capture the true purchasing lifecycle. Extending the window to 30 or 60 days will give an accurate picture of funnel performance. A is a reactive product change to a measurement error. C and D do not address the timing issue.',
        ARRAY['time_to_convert', 'conversion_window', 'delayed_conversion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the 24-hour window but run aggressive discounts.', false),
    (v_q_id, 'B', 'Extend the conversion window to 30 or 60 days to capture the true purchasing lifecycle.', true),
    (v_q_id, 'C', 'Change the funnel to a strict ordering funnel.', false),
    (v_q_id, 'D', 'Segment the funnel by mobile vs desktop.', false);

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
        'Duolingo''s Intent vs Friction Tradeoff',
        E'Duolingo adds a mandatory "Goal Setting" screen to the signup funnel. The conversion rate to "Account Created" drops by 5%. However, Day-7 retention for users who complete signup increases by 15%. How should the PM interpret this?',
        'intermediate',
        'Duolingo',
        'Onboarding and retention',
        'B',
        'B is correct. Not all friction is bad. "Positive friction" can filter out low-intent users or help personalize the onboarding experience, leading to better long-term retention. The PM traded top-of-funnel volume for higher downstream quality. A is false; retention matters more than raw acquisition. C is false; denominator changes affect cohort metrics. D removes the commitment mechanism that drives the retention.',
        ARRAY['friction', 'retention', 'funnel_tradeoff']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The feature is a failure because top-of-funnel conversion is the only metric that matters in onboarding.', false),
    (v_q_id, 'B', 'The feature is a success; adding friction filtered out low-intent users and improved the core product experience.', true),
    (v_q_id, 'C', 'The funnel tracking is broken because retention cannot increase if conversion decreases.', false),
    (v_q_id, 'D', 'The PM should make the step optional to maximize both conversion and retention.', false);

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
        'Booking.com''s Paradox of Choice',
        E'Booking.com''s checkout page offers 15 different payment methods. A PM hypothesizes that showing only the top 3 (Credit Card, PayPal, Apple Pay) behind a "More Options" toggle will improve conversion. What psychological principle justifies this?',
        'intermediate',
        'Booking.com',
        'Payment selection checkout',
        'B',
        'B is correct. The Paradox of Choice states that giving users too many options increases cognitive load, leading to decision paralysis and cart abandonment. Simplifying the default choices reduces friction. A (Endowment Effect) relates to ownership. C (Confirmation Bias) and D (Halo Effect) are unrelated to menu complexity.',
        ARRAY['paradox_of_choice', 'cognitive_load', 'conversion_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Endowment Effect', false),
    (v_q_id, 'B', 'The Paradox of Choice', true),
    (v_q_id, 'C', 'Confirmation Bias', false),
    (v_q_id, 'D', 'The Halo Effect', false);

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
        'Uber''s Biased Funnel Data',
        E'Uber''s PM tracks the funnel: "Enter Destination" -> "View Prices" -> "Request Ride". They notice the volume of "View Prices" is 3x higher than "Enter Destination" within the same session. What explains this data anomaly?',
        'intermediate',
        'Uber',
        'Ride pricing funnel',
        'B',
        'B is correct. Funnel events must be carefully deduplicated. If the app auto-refreshes prices or if users toggle between ride types (UberX, Comfort), multiple "View Prices" events fire per user session. Without unique user or session deduplication, the step volume inflates. A is impossible in Uber''s UI. C is mathematically impossible for unique users. D does not explain intra-session inflation.',
        ARRAY['event_tracking', 'data_anomaly', 'funnel_setup']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users are skipping the "Enter Destination" step entirely.', false),
    (v_q_id, 'B', 'Users are sitting on the screen and the app is auto-refreshing prices, firing multiple events without deduplication.', true),
    (v_q_id, 'C', 'The conversion rate from step 1 to step 2 is 300%.', false),
    (v_q_id, 'D', 'The funnel is using a 30-day conversion window.', false);

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
        'Netflix''s Funnel Cannibalization',
        E'Netflix tests a redesign of the payment page. It yields a 10% higher conversion from "View Payment" to "Submit Payment". However, the overall "Start Signup" to "Watch First Video" funnel conversion drops by 2%. What most likely happened?',
        'intermediate',
        'Netflix',
        'Payment and onboarding flow',
        'B',
        'B is correct. A localized win in a funnel can cause downstream cannibalization. The new design might have encouraged users to submit payments without verifying details properly, leading to asynchronous payment failures that block them from actually watching video. A is unlikely for just a payment page. C and D don''t explain a drop in the true North Star metric.',
        ARRAY['cannibalization', 'guardrail_metric', 'funnel_tradeoff']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The new payment page attracted bot traffic.', false),
    (v_q_id, 'B', 'The test achieved a localized win but introduced friction later, such as asynchronous payment failures.', true),
    (v_q_id, 'C', 'Simpson''s Paradox occurred due to device segmentation.', false),
    (v_q_id, 'D', 'The funnel window was too long.', false);

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
        'Airbnb''s User Mix Shift',
        E'Airbnb''s overall booking conversion rate dropped from 5% to 4% this month. However, conversion for New Users went from 2% to 2.5%, and for Returning Users it went from 8% to 9%. What is the most likely mathematical reason for the overall drop?',
        'intermediate',
        'Airbnb',
        'Booking funnel',
        'B',
        'B is correct. This is a classic example of Simpson''s Paradox, specifically caused by a mix shift. If marketing acquired a massive influx of New Users (who have a lower baseline conversion rate), the overall average gets pulled down, even though both individual segments improved. A, C, and D do not explain this specific statistical phenomenon.',
        ARRAY['mix_shift', 'simpsons_paradox', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The tracking pixels are double-counting returning users.', false),
    (v_q_id, 'B', 'Simpson''s Paradox caused by a massive influx of New Users at the top of the funnel.', true),
    (v_q_id, 'C', 'The paradox of choice is affecting returning users more than new users.', false),
    (v_q_id, 'D', 'A loose funnel definition is inflating the segment rates.', false);

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
        'Amazon''s Cross-Device Tracking',
        E'A PM at Amazon is analyzing the "Add to Cart (Mobile)" -> "Checkout (Desktop)" funnel. They notice a near 0% conversion rate in their analytics tool, even though user research shows this is a very common buying pattern. What is the analytical issue?',
        'intermediate',
        'Amazon',
        'Cross-device purchasing behavior',
        'B',
        'B is correct. If the analytics tool relies on anonymous device IDs or cookie-based session IDs, it cannot connect the mobile action to the desktop action. The PM must use persistent, cross-device User IDs (like an account ID) to accurately track funnels that span multiple devices. A, C, and D are incorrect diagnoses of a pure tracking limitation.',
        ARRAY['cross_device', 'user_funnel', 'event_tracking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The funnel steps are out of order.', false),
    (v_q_id, 'B', 'The analytics tool is using device-specific session IDs instead of cross-device persistent user IDs.', true),
    (v_q_id, 'C', 'The time-to-convert is too short.', false),
    (v_q_id, 'D', 'The users are abandoning their carts.', false);

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
        'Stripe''s Asynchronous Drop-offs',
        E'Stripe''s onboarding requires users to submit business details, which are then reviewed asynchronously by an internal team. The PM sets up a funnel: "Submit Details" -> "Account Activated". The conversion is 15% within a 1-hour window. What is the flaw in this funnel setup?',
        'intermediate',
        'Stripe',
        'Merchant KYC onboarding',
        'B',
        'B is correct. Asynchronous reviews (KYC, manual underwriting) often take hours or days. A 1-hour funnel window artificially truncates successful conversions, making the funnel look broken when it is merely delayed. The PM must extend the conversion window to match the operational SLA. A, C, and D miss the core timing issue.',
        ARRAY['asynchronous_events', 'conversion_window', 'delayed_conversion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The steps are in the wrong order.', false),
    (v_q_id, 'B', 'Asynchronous review takes days; a 1-hour window artificially truncates successful conversions.', true),
    (v_q_id, 'C', 'The PM is using a strict funnel instead of a loose funnel.', false),
    (v_q_id, 'D', 'The funnel should only include automated steps.', false);

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
        'Figma''s Time-in-Step Analysis',
        E'Figma''s PM analyzes the "Invite User" modal. The drop-off rate is extremely low (5%), but the median "time in step" is 4 minutes. What should the PM conclude?',
        'intermediate',
        'Figma',
        'Collaboration invite flow',
        'C',
        'C is correct. A low drop-off rate can mask severe UX issues. If a simple task (inviting a user) takes 4 minutes, it indicates high cognitive load or friction. Users are likely struggling to understand permissions or find email addresses, even if their high intent forces them to eventually complete it. A and B blindly trust the proxy metric. D assumes technical failure without evidence.',
        ARRAY['time_to_convert', 'cognitive_load', 'drop_off_diagnosis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The step is highly successful because users aren''t dropping off.', false),
    (v_q_id, 'B', 'Users are highly engaged with the invite feature.', false),
    (v_q_id, 'C', 'The low drop-off hides high cognitive friction; users are struggling to complete the task.', true),
    (v_q_id, 'D', 'The funnel tracking for time-to-convert is broken.', false);

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
        'Spotify''s Loose Funnel Inflation',
        E'Spotify''s PM sets up a "loose" funnel for "Search -> Play Song". They notice conversion is 95%. However, direct user observation shows many users struggle with the search UI and give up. Why might the loose funnel be misleading here?',
        'intermediate',
        'Spotify',
        'Search and discovery flow',
        'B',
        'B is correct. Loose funnels track if a user completes Step B *any time* after Step A, regardless of causality. A user might fail at search, go back to the homepage, and click a recommended song. The loose funnel counts this as a "Search -> Play" conversion, falsely inflating the success of the search feature. A, C, and D are incorrect definitions of loose funnels.',
        ARRAY['loose_funnel', 'conversion_rate', 'event_tracking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A loose funnel requires steps to be completed in a strict order.', false),
    (v_q_id, 'B', 'It counts any user who searched and eventually played a song, even if the play was unrelated to the search.', true),
    (v_q_id, 'C', 'Loose funnels only track session-based behavior.', false),
    (v_q_id, 'D', 'Loose funnels exclude mobile users.', false);

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
        'DoorDash''s Upsell Funnel Tradeoffs',
        E'DoorDash adds a "Would you like to add a drink?" step between "View Cart" and "Checkout". The PM notes that conversion from "View Cart" to "Checkout" drops by 2%, but Average Order Value (AOV) increases by $3. How should the PM evaluate this?',
        'intermediate',
        'DoorDash',
        'Cart and checkout flow',
        'B',
        'B is correct. Funnel conversion is not the ultimate goal; revenue or profit is. Introducing strategic friction (an upsell) will naturally cause some drop-off. The PM must calculate the net impact on total revenue (Volume × AOV) to determine if the monetary gain offsets the lost order volume. A is overly dogmatic. C adds unnecessary friction. D breaks the product.',
        ARRAY['upsell', 'funnel_tradeoff', 'friction']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Roll back the change immediately; funnel drop-off must never increase.', false),
    (v_q_id, 'B', 'Evaluate the net impact on total revenue (Volume × AOV) to see if the gain offsets the lost volume.', true),
    (v_q_id, 'C', 'Make the drink step a strict requirement.', false),
    (v_q_id, 'D', 'Remove the cart step entirely.', false);

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
        'Shopify''s Funnel Loops',
        E'A Shopify PM observes the checkout funnel. Users frequently loop between "Review Order" and "Shipping Details" multiple times to check prices before finally clicking "Purchase". If the PM uses a standard unique-user funnel model, how is this loop handled?',
        'intermediate',
        'Shopify',
        'Checkout iterations',
        'B',
        'B is correct. In standard unique-user funnel analytics, intermediate loops are flattened. As long as the user eventually progresses from Step A to Step B to Step C within the conversion window, they are counted as a single successful conversion, ignoring the back-and-forth ping-ponging. A is wrong because they eventually succeed. C double-counts users. D is dramatic.',
        ARRAY['funnel_loops', 'event_tracking', 'conversion_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The user is counted as dropped off at "Review Order".', false),
    (v_q_id, 'B', 'The user is counted as completing the funnel once, ignoring the repeated intermediate steps.', true),
    (v_q_id, 'C', 'The user is counted as completing the funnel multiple times.', false),
    (v_q_id, 'D', 'The analytics tool will crash due to the infinite loop.', false);

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
        'Robinhood''s Mandatory KYC Step',
        E'Robinhood requires users to upload a photo ID. The PM notices a 20% drop-off at this step. Legal mandates the step cannot be removed or moved. How should the PM approach optimizing this funnel?',
        'intermediate',
        'Robinhood',
        'Identity verification (KYC)',
        'C',
        'C is correct. When a step is mandatory and strictly ordered due to compliance, the only lever a PM has is reducing execution friction. Improving error messaging, adding auto-capture for the camera, and providing clear lighting instructions can rescue users who *want* to convert but fail due to technical/UI friction. A and B violate legal constraints. D violates KYC regulations.',
        ARRAY['mandatory_step', 'friction', 'drop_off_diagnosis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Remove the step and ask for forgiveness later.', false),
    (v_q_id, 'B', 'Move the step to after the user has made their first trade.', false),
    (v_q_id, 'C', 'Optimize the UI/UX of the upload step (e.g., better error messaging, clear lighting instructions).', true),
    (v_q_id, 'D', 'Replace the photo ID upload with a simple text input.', false);

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
        'Uber''s Top of Funnel Pollution',
        E'Uber''s PM notices the conversion rate from "App Open" to "Ride Requested" suddenly drops from 20% to 5% over the weekend. The absolute number of "Ride Requested" events remained perfectly stable compared to previous weekends. What happened?',
        'intermediate',
        'Uber',
        'App engagement tracking',
        'A',
        'A is correct. If the numerator (Ride Requested) is stable but the rate drops massively, the denominator (App Open) must have spiked. This is often caused by bot traffic, a broken marketing campaign driving accidental clicks, or a push notification that caused users to open the app without ride intent. B, C, and D would reduce the absolute number of requested rides.',
        ARRAY['top_of_funnel', 'conversion_rate', 'bot_traffic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A massive surge of bot traffic or accidental app opens inflated the top of the funnel (denominator).', true),
    (v_q_id, 'B', 'Users suddenly found the app too expensive.', false),
    (v_q_id, 'C', 'The app crashed for most users.', false),
    (v_q_id, 'D', 'Drivers went on strike.', false);

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
        'Spotify''s Intent-Based Segmentation',
        E'Spotify''s PM wants to measure the success of a new "Discover Weekly" feature. They create a funnel: "View Home Page -> Click Discover Weekly -> Save a Song". Why is this funnel deeply flawed for measuring feature success?',
        'intermediate',
        'Spotify',
        'Feature adoption tracking',
        'B',
        'B is correct. The "View Home Page" step includes millions of users who opened the app with a specific intent (e.g., listening to a specific podcast). Measuring feature conversion against the entire user base punishes the metric. The PM should start the funnel at "Click Discover Weekly" or segment by user intent. A, C, and D do not address the fundamental denominator issue.',
        ARRAY['user_intent', 'segmentation', 'metric_definition']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It doesn''t include "Share a Song".', false),
    (v_q_id, 'B', 'It includes all users on the Home Page, punishing the feature''s conversion rate for users who came with a different intent.', true),
    (v_q_id, 'C', 'The conversion window is too short.', false),
    (v_q_id, 'D', 'It uses a loose funnel ordering.', false);

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
        'DoorDash''s Default Selections',
        E'DoorDash''s PM changes the tip selection in the checkout funnel. Instead of a blank text box, they provide pre-selected buttons: 15%, 20%, 25%. Time-in-step decreases by 30% and checkout conversion increases slightly. Why did this work?',
        'intermediate',
        'DoorDash',
        'Checkout tipping flow',
        'B',
        'B is correct. Providing smart defaults or predefined options reduces cognitive load. Users no longer have to perform mental math or agonize over what is socially acceptable. This removes friction, speeding up the funnel and slightly boosting conversion. A is the opposite of what happened. C and D are irrelevant to cognitive friction.',
        ARRAY['cognitive_load', 'friction', 'conversion_rate']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It increased the paradox of choice.', false),
    (v_q_id, 'B', 'It reduced cognitive load by providing default heuristics, lowering friction in the funnel.', true),
    (v_q_id, 'C', 'It forced users into a strict funnel path.', false),
    (v_q_id, 'D', 'It increased the time window for conversion.', false);

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
        'Shopify''s Step vs Overall Impact',
        E'A Shopify merchant''s funnel has 4 steps with the following conversion rates:\n* Step 1 to 2: 50%\n* Step 2 to 3: 50%\n* Step 3 to 4: 50%\n\nA PM improves Step 3 to 4 conversion to 60%. What is the new overall conversion rate from Step 1 to Step 4?',
        'intermediate',
        'Shopify',
        'Multi-step checkout',
        'A',
        'A is correct. The overall conversion rate is the product of all step-to-step conversions. Initially, it was 0.5 * 0.5 * 0.5 = 12.5%. After the improvement, it becomes 0.5 * 0.5 * 0.6 = 15%. Understanding how local step improvements mathematically impact the global funnel is a core PM skill. B, C, and D represent incorrect calculations.',
        ARRAY['step_conversion', 'overall_conversion', 'funnel_math']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '15%', true),
    (v_q_id, 'B', '12.5%', false),
    (v_q_id, 'C', '60%', false),
    (v_q_id, 'D', '20%', false);

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
        E'Airbnb''s PM analyzes the "Search -> Book" funnel.\n* City A conversion: 10%\n* City B conversion: 5%\n* Overall conversion: 5.4%\n\nMarketing shifts budget to City A, generating 100x more searches there. City A still converts at 10%, but the Overall conversion increases to 9.1%. What analytical phenomenon is this?',
        'advanced',
        'Airbnb',
        'Booking search funnel',
        'C',
        'C is correct. Simpson''s Paradox (or a mix shift) occurs when the weighting of underlying segments changes, drastically altering the aggregate metric even if the segment-level metrics remain stable. By flooding the top of the funnel with higher-converting City A users, the overall average shifted towards City A''s rate. A, B, and D are incorrect terms for this statistical effect.',
        ARRAY['simpsons_paradox', 'mix_shift', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Hawthorne Effect', false),
    (v_q_id, 'B', 'Cannibalization', false),
    (v_q_id, 'C', 'Simpson''s Paradox / Mix Shift Effect', true),
    (v_q_id, 'D', 'The Novelty Effect', false);

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
        'Stripe''s Strict Time-Bound Funnels',
        E'Stripe''s PM uses a strict, 24-hour time-bound funnel for: "View Docs -> Generate API Key -> Make First API Call". Data shows a 2% conversion. However, database logs show 40% of users eventually make an API call within a week, often bypassing the UI to generate keys via CLI. What is the primary failure in the PM''s funnel design?',
        'advanced',
        'Stripe',
        'Developer onboarding',
        'A',
        'A is correct. Developer workflows are highly asynchronous and multi-channel. Forcing a strict UI event sequence (assuming they use the web dashboard to generate keys) and a tight 24-hour window completely misses reality. The PM needs a loose funnel that accepts cross-channel events (CLI, Web) and a longer conversion window. B, C, and D are minor optimizations, not the root cause.',
        ARRAY['strict_funnel', 'conversion_window', 'multi_channel']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Using a 24-hour window and strict UI event sequence for an asynchronous, multi-channel workflow.', true),
    (v_q_id, 'B', 'Not segmenting by programming language.', false),
    (v_q_id, 'C', 'Including bot traffic in the "View Docs" step.', false),
    (v_q_id, 'D', 'The funnel needs more granular UI steps for the API key generation.', false);

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
        'Netflix''s Funnel Survival Curves',
        E'A Netflix PM wants to understand not just *if* users convert from Trial to Paid, but exactly *when* the drop-off happens over a 30-day period to optimize the timing of email interventions. Simple step funnels only show the final state. What advanced analytical method should the PM apply?',
        'advanced',
        'Netflix',
        'Trial conversion retention',
        'B',
        'B is correct. Kaplan-Meier Survival Analysis is used to estimate the time-to-event (conversion or churn) over a period. It allows PMs to see the exact curve of when users drop off during a 30-day window, pinpointing the optimal day to send a push notification. A is for marketing attribution. C is for grouping users. D is for controlling confounding variables in observational studies.',
        ARRAY['survival_analysis', 'time_to_convert', 'advanced_statistics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Multi-touch attribution', false),
    (v_q_id, 'B', 'Kaplan-Meier Survival Analysis', true),
    (v_q_id, 'C', 'K-Means Clustering', false),
    (v_q_id, 'D', 'Propensity Score Matching', false);

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
        'Amazon''s Funnel Entry Attribution',
        E'Amazon''s PM analyzes the Prime signup funnel. Users can enter via the Homepage banner, Checkout prompt, or Video app. Checkout users have an 80% conversion rate; Homepage users have 5%. The PM concludes Homepage banners are ineffective and should be removed. What is the critical error in this logic?',
        'advanced',
        'Amazon',
        'Prime subscription entry points',
        'B',
        'B is correct. The PM is ignoring user intent and funnel stages. Users at checkout are already in a transactional mindset with high intent. Users on the homepage are browsing. Removing the top-of-funnel awareness builder (Homepage banner) might eventually starve the bottom-of-funnel (Checkout), as users need multiple touchpoints before converting. A, C, and D do not address the strategic error.',
        ARRAY['attribution', 'user_intent', 'top_of_funnel']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Simpson''s Paradox.', false),
    (v_q_id, 'B', 'Ignoring user intent; Homepage users are browsing while Checkout users have high intent. The banner builds awareness.', true),
    (v_q_id, 'C', 'The PM used a loose funnel instead of a strict funnel.', false),
    (v_q_id, 'D', 'The PM did not account for bot traffic on the homepage.', false);

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
        'Robinhood''s Friction vs LTV',
        E'Robinhood introduces an optional "Profile Avatar Setup" step immediately after account creation. The data team confirms the step has zero technical errors and takes 2 seconds. Yet, funnel conversion to "First Trade" drops by 4%. What psychological friction explains the downstream drop-off?',
        'advanced',
        'Robinhood',
        'Post-onboarding engagement',
        'B',
        'B is correct. Interruption of momentum is a powerful force. Even if a step is technically frictionless, it breaks the user''s cognitive flow and intent. The user signed up to trade stocks; asking them to upload a selfie distracts them, causing a subset of users to close the app and never return. A, C, and D are psychological principles unrelated to momentum interruption.',
        ARRAY['friction', 'funnel_tradeoff', 'user_intent']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Sunk Cost Fallacy', false),
    (v_q_id, 'B', 'Interruption of momentum/intent; even frictionless steps can distract users from their primary goal.', true),
    (v_q_id, 'C', 'The Endowment Effect', false),
    (v_q_id, 'D', 'Anchoring Bias', false);

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
        'Figma''s Non-Linear Paths',
        E'A Figma PM realizes users don''t follow a linear path. From the Canvas, users might use the Pen tool, add Text, or insert a Frame in any order before sharing. A linear funnel "Pen -> Text -> Share" shows a 1% conversion. To understand true user behavior, the PM should transition to what type of analysis?',
        'advanced',
        'Figma',
        'Canvas interaction flow',
        'A',
        'A is correct. Funnels are inherently linear and ordered. When a product supports highly non-linear, exploratory workflows (like a canvas or IDE), Markov Chains or Path Analysis (Journey Mapping) are required. These visualize the most common transitions between states rather than forcing users into a preconceived linear model. B, C, and D are analytical methods that do not map user journeys.',
        ARRAY['non_linear_funnel', 'path_analysis', 'event_tracking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Markov Chain / Path Analysis (User Journey Mapping)', true),
    (v_q_id, 'B', 'A/B/n Testing', false),
    (v_q_id, 'C', 'Regression Analysis', false),
    (v_q_id, 'D', 'Sentiment Analysis', false);

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
        'Booking.com''s Branch Cannibalization',
        E'Booking.com tests an "Express Checkout" button that bypasses the "Select Room Upgrades" step. Funnel completion rate soars by 15%. However, overall Revenue Per Session drops. In funnel optimization, this is an example of what phenomenon?',
        'advanced',
        'Booking.com',
        'Checkout optimization',
        'B',
        'B is correct. The PM optimized a proxy metric (funnel conversion rate) at the direct expense of the true North Star / Guardrail metric (Revenue). The Express Checkout cannibalized the high-margin upsell branch of the funnel. Funnel optimization must always be balanced against revenue or LTV guardrails. A, C, and D do not describe this strategic tradeoff.',
        ARRAY['funnel_branching', 'cannibalization', 'guardrail_metric']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Novelty Effect', false),
    (v_q_id, 'B', 'Optimizing a proxy metric at the expense of the true North Star / Guardrail metric.', true),
    (v_q_id, 'C', 'Simpson''s Paradox', false),
    (v_q_id, 'D', 'The Hawthorne Effect', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Funnel Analysis';
END $$;
