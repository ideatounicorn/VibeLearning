-- ============================================
-- ASSESSMENT: QA & UAT
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
    WHERE slug = 'qa-uat';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug qa-uat not found. Run the seed data first.';
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
        'Airbnb''s Beta Program',
        E'Airbnb is preparing to launch a new "Split Payment" feature. The PM decides to roll this out internally to employees booking personal trips before letting actual guests use it. Employees are encouraged to report any usability issues or payment failures.\n\nWhat phase of testing does this best represent?',
        'foundational',
        'Airbnb',
        'Testing a new Split Payment feature',
        'B',
        'This scenario describes dogfooding (internal testing by employees). Employees using the product for real personal trips allows the team to catch usability and functional issues before external users see it. Alpha testing is usually earlier and more controlled; external beta involves real users outside the company, and load testing specifically tests system performance under stress, not general usability.',
        ARRAY['dogfooding', 'internal_testing', 'beta_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Load testing', false),
    (v_q_id, 'B', 'Dogfooding', true),
    (v_q_id, 'C', 'External Beta testing', false),
    (v_q_id, 'D', 'Regression testing', false);

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
        'Spotify''s Bug Triage',
        E'Spotify''s QA team reports a bug where the "Shuffle" icon turns green but fails to actually shuffle the playlist for users on iOS 12 (which represents 0.5% of the user base). The bug causes no crashes, and playback continues linearly.\n\nHow should the PM classify this bug in the backlog?',
        'foundational',
        'Spotify',
        'Bug triage for iOS 12 shuffle bug',
        'C',
        'Bug severity indicates the technical impact (low, as it doesn''t crash the app and core playback works), and priority indicates urgency for fixing based on business impact (low, as it affects only 0.5% of users). A junior PM might overreact to a broken feature, but experienced PMs factor in user base percentage and core functionality impact to assign low priority/low severity.',
        ARRAY['bug_triage', 'severity_vs_priority', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High Severity, High Priority', false),
    (v_q_id, 'B', 'High Severity, Low Priority', false),
    (v_q_id, 'C', 'Low Severity, Low Priority', true),
    (v_q_id, 'D', 'Low Severity, High Priority', false);

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
        'Uber''s UAT Strategy',
        E'Uber is launching a "Quiet Mode" feature for Uber Black. The engineering team has confirmed that the feature works perfectly in the test environment. The PM is organizing User Acceptance Testing (UAT).\n\nWhat is the primary goal of this UAT phase?',
        'foundational',
        'Uber',
        'UAT for Quiet Mode',
        'C',
        'The primary goal of UAT is to validate that the solution meets business requirements and works for the end user in real-world scenarios. Engineering tests (unit, integration) cover technical correctness and edge cases. UAT ensures the actual user (or proxies representing them) finds the feature valuable, usable, and aligned with expectations.',
        ARRAY['uat_goals', 'acceptance_criteria', 'user_validation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To find technical edge cases in the code that automated tests missed.', false),
    (v_q_id, 'B', 'To measure the impact of the feature on app load times.', false),
    (v_q_id, 'C', 'To validate that the feature meets the business requirements and solves the user need.', true),
    (v_q_id, 'D', 'To ensure the feature does not break existing payment flows.', false);

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
        'Netflix''s Regression Bug',
        E'During the QA phase for a new Netflix interactive special ("Bandersnatch 2"), a tester discovers that the standard "Skip Intro" button is no longer appearing on regular TV shows.\n\nWhich type of testing is specifically designed to catch this type of issue?',
        'foundational',
        'Netflix',
        'Testing interactive special and standard features',
        'A',
        'Regression testing is designed to ensure that recent code changes have not adversely affected existing, previously working features (like the "Skip Intro" button). Smoke testing is a quick check of critical paths, integration testing checks how modules interact, and performance testing checks speed/load. Breaking an old feature while building a new one is a classic regression.',
        ARRAY['regression_testing', 'qa_fundamentals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Regression testing', true),
    (v_q_id, 'B', 'Smoke testing', false),
    (v_q_id, 'C', 'Integration testing', false),
    (v_q_id, 'D', 'Performance testing', false);

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
        'Slack''s Acceptance Criteria',
        E'A Slack PM is writing the acceptance criteria for a new feature: "Scheduled Messages". \n\nWhich of the following is the most appropriately written acceptance criterion for UAT?',
        'foundational',
        'Slack',
        'Acceptance criteria for scheduled messages',
        'D',
        'Good acceptance criteria focus on user outcomes, state conditions clearly (often using Gherkin format: Given/When/Then), and are testable. Option D is clear, binary, and testable from a user perspective. A dictates technical implementation (cron job). B is vague ("easy"). C is a performance metric, not a functional acceptance criterion for UAT.',
        ARRAY['acceptance_criteria', 'testability', 'requirements']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The system must use a cron job to check for scheduled messages every minute.', false),
    (v_q_id, 'B', 'The user should find it easy to schedule a message for the future.', false),
    (v_q_id, 'C', 'Scheduled messages must be delivered within 500ms of the scheduled time.', false),
    (v_q_id, 'D', 'Given a user schedules a message for 9:00 AM, when the clock strikes 9:00 AM, the message appears in the channel.', true);

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
        'Figma''s Reproducibility',
        E'A user reports a bug in Figma: "Sometimes when I try to group objects, the application freezes." The PM sees this bug ticket submitted by the support team.\n\nWhat is the most important missing piece of information needed before engineering can fix this bug?',
        'foundational',
        'Figma',
        'Bug reporting and reproducibility',
        'B',
        'To fix a bug, engineers must be able to reproduce it. Steps to reproduce (and environmental details like OS, browser) are the most critical missing pieces in vague bug reports. While logs (A) and severity (C) are helpful, without knowing *how* to trigger the issue, debugging is a guessing game. The user''s pricing tier (D) is irrelevant to fixing the technical freeze.',
        ARRAY['bug_reporting', 'reproducibility', 'triage']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The server logs from the exact moment the freeze occurred.', false),
    (v_q_id, 'B', 'Clear steps to reproduce the issue, including OS and browser versions.', true),
    (v_q_id, 'C', 'The priority and severity labels assigned by the QA team.', false),
    (v_q_id, 'D', 'The pricing tier (Free vs. Pro) of the user who reported it.', false);

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
        'DoorDash''s Test Plan',
        E'DoorDash is building a feature that allows users to order from two different restaurants in the same delivery. The PM is reviewing the QA test plan.\n\nWhich of the following test cases represents a "negative test"?',
        'foundational',
        'DoorDash',
        'Testing dual-restaurant delivery',
        'C',
        'Negative testing involves verifying that the system handles invalid input or unexpected user behavior gracefully. Attempting to add items from a third restaurant when the limit is two is a classic negative test to ensure the system rejects it properly. A and D are positive tests (happy path). B is a boundary/concurrent test but still a valid use case.',
        ARRAY['test_plans', 'negative_testing', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'User adds an item from Restaurant A and an item from Restaurant B successfully.', false),
    (v_q_id, 'B', 'Two users log into the same account and add items from different restaurants simultaneously.', false),
    (v_q_id, 'C', 'User tries to add an item from a third restaurant, expecting an error message.', true),
    (v_q_id, 'D', 'User completes checkout for two restaurants and verifies the delivery fee is combined.', false);

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
        'Stripe''s Staging Environment',
        E'A PM at Stripe is asked to perform UAT on a new invoicing feature before it goes live. They are provided access to a "Staging" environment.\n\nWhat is the primary characteristic of a Staging environment that makes it suitable for this?',
        'foundational',
        'Stripe',
        'UAT in staging environments',
        'B',
        'A staging environment is meant to be a near-exact replica of the production environment, including configurations and architecture, allowing teams to test features exactly as they will behave when live. It does not use real customer production data due to privacy/security rules (A). It is more stable than development environments (C) and is not meant to bypass QA (D).',
        ARRAY['test_environments', 'staging_vs_prod', 'uat_setup']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It contains live production data, allowing testing on real customer accounts.', false),
    (v_q_id, 'B', 'It closely mirrors the production environment''s configuration and architecture.', true),
    (v_q_id, 'C', 'It is a rapidly changing environment where engineers constantly push unreviewed code.', false),
    (v_q_id, 'D', 'It bypasses all automated QA checks to allow for faster manual testing.', false);

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
        'Amazon''s Smoke Test',
        E'Right after Amazon deploys a major update to its checkout flow to production, the QA team runs a "Smoke Test." \n\nWhat are they primarily trying to achieve?',
        'foundational',
        'Amazon',
        'Production deployment smoke testing',
        'D',
        'Smoke testing (also called build verification testing) is a quick check of the most critical, basic functionalities to ensure the deployment didn''t completely break the system (e.g., "Can a user buy an item?"). It does not test edge cases (A), validate analytics (B), or exhaustively check all scenarios (C).',
        ARRAY['smoke_testing', 'post_release_testing', 'deployment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To verify that all obscure edge cases in the new code are functioning perfectly.', false),
    (v_q_id, 'B', 'To ensure that A/B testing analytics are correctly firing for the new checkout flow.', false),
    (v_q_id, 'C', 'To run an exhaustive suite of thousands of automated tests covering every possible user journey.', false),
    (v_q_id, 'D', 'To quickly verify that the most critical functions, like adding to cart and paying, are still working.', true);

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
        'Discord''s Alpha vs Beta',
        E'Discord is developing a new "Server Video Calls" feature. They just finished an internal Alpha test with employees. The PM is now preparing for a Beta test.\n\nWhat is the primary difference between how the PM should manage the Beta test compared to the Alpha test?',
        'foundational',
        'Discord',
        'Alpha vs Beta testing management',
        'A',
        'Beta tests involve external, real-world users in real environments, meaning the PM must expect more varied, unpredictable use cases and device configurations than in a controlled internal Alpha test. Beta tests are usually less heavily instrumented with debuggers (C) because users use normal apps. Beta isn''t exclusively for load testing (D), nor is it restricted to non-technical users (B).',
        ARRAY['alpha_vs_beta', 'external_testing', 'test_phases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM must account for a wider variety of unpredicted real-world environments and user behaviors.', true),
    (v_q_id, 'B', 'The PM must only invite users who have no prior technical knowledge to ensure true usability testing.', false),
    (v_q_id, 'C', 'The PM must ensure the Beta version contains more debugging code to capture logs from users.', false),
    (v_q_id, 'D', 'The PM should shift focus entirely from feature validation to pure server load testing.', false);

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
        'Peloton''s Flaky Test',
        E'Peloton''s CI/CD pipeline has an automated test for "Leaderboard Sync" that fails 15% of the time, even when no related code has changed. The engineering lead suggests ignoring the test since it is "flaky."\n\nHow should the PM respond to ensure long-term product quality?',
        'intermediate',
        'Peloton',
        'Managing flaky automated tests',
        'B',
        'Flaky tests degrade trust in the testing suite. If engineers start ignoring red builds, they might miss real bugs. The PM should prioritize fixing or quarantining the test. Deleting it (A) removes coverage. Ignoring it (C) destroys CI/CD culture. Pausing all development (D) is an overreaction for a single flaky test.',
        ARRAY['automated_testing', 'flaky_tests', 'ci_cd', 'qa_culture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree to delete the test permanently to speed up the deployment pipeline.', false),
    (v_q_id, 'B', 'Advocate for quarantining the test and allocating sprint time to fix its root cause so developers trust the test suite.', true),
    (v_q_id, 'C', 'Agree to ignore it, as long as manual QA verifies the leaderboard before major releases.', false),
    (v_q_id, 'D', 'Halt all new feature development until the test passes 100% of the time for 5 consecutive days.', false);

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
        'Shopify''s Critical Showstopper',
        E'Two days before Shopify launches a massive update to its inventory management system, QA finds a bug: Merchants with exactly zero products in their store encounter a white screen when accessing the dashboard. All other merchants are unaffected. The launch is tied to a major marketing event.\n\nWhat is the most appropriate action for the PM?',
        'intermediate',
        'Shopify',
        'Launch decision with edge case bug',
        'A',
        'PMs must balance launch commitments with user impact. Merchants with zero products are usually new, un-onboarded users, meaning existing revenue-generating merchants are unaffected. It''s a known issue that can be mitigated with support/comms or a fast-follow patch, rather than delaying a major marketing-tied launch (D) or rolling back entirely (B). Dropping severity to low (C) is inaccurate—a white screen is a high severity issue, even if priority/impact is mitigated.',
        ARRAY['launch_decision', 'bug_triage', 'showstopper', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch as planned, document the bug as a "known issue," and prioritize a hotfix immediately after launch.', true),
    (v_q_id, 'B', 'Revert the entire update and push the marketing event back by two weeks to ensure a flawless launch.', false),
    (v_q_id, 'C', 'Downgrade the bug''s severity to "Low" so it passes the launch criteria without raising flags.', false),
    (v_q_id, 'D', 'Delay the launch by 48 hours to fix the bug, accepting the misalignment with the marketing event.', false);

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
        'Netflix''s Device Matrix',
        E'Netflix is updating its video player UI. The QA team asks the PM which devices they should prioritize for manual testing, given they cannot test all 15,000+ combinations of smart TVs, phones, and browsers within the sprint.\n\nWhat is the best approach for the PM to define the test matrix?',
        'intermediate',
        'Netflix',
        'Defining QA device test matrix',
        'C',
        'A risk-based, data-driven approach is best. The PM should prioritize the platforms that account for the highest percentage of viewing hours (usage) combined with devices historically known to have compatibility issues (risk). Testing purely the newest (A) misses the long tail of old hardware users. Letting QA decide (B) abdicates business responsibility. Focusing only on high-end devices (D) ignores the reality of global distribution.',
        ARRAY['test_planning', 'device_matrix', 'risk_based_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Prioritize the newest devices from Apple and Samsung, as they represent the most premium users.', false),
    (v_q_id, 'B', 'Allow the QA team to randomly sample devices to ensure an unbiased distribution of testing.', false),
    (v_q_id, 'C', 'Prioritize based on historical product usage data mixed with known problematic hardware profiles.', true),
    (v_q_id, 'D', 'Focus entirely on devices with 4K capabilities, as that is where UI bugs are most visible.', false);

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
        'Spotify''s UAT Sign-Off',
        E'During UAT for Spotify''s new "Podcast Chapters" feature, the marketing team (acting as UAT stakeholders) refuses to sign off. They state the chapter transitions feel "clunky," even though the feature meets all documented acceptance criteria.\n\nHow should the PM handle this UAT dispute?',
        'intermediate',
        'Spotify',
        'Handling UAT stakeholder disputes',
        'D',
        'UAT is about validating the solution against requirements. If it meets criteria but feels "clunky," the PM should acknowledge the feedback as a valid enhancement request for a fast-follow iteration, but proceed with the launch if core requirements are met. Halting launch for subjective feelings (A) delays delivery. Reverting to dev without new criteria (B) is inefficient. Ignoring stakeholders (C) damages trust.',
        ARRAY['uat_sign_off', 'stakeholder_management', 'acceptance_criteria']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Halt the release indefinitely until marketing is completely satisfied with the transitions.', false),
    (v_q_id, 'B', 'Send the feature back to engineering to "make it smoother" without updating the acceptance criteria.', false),
    (v_q_id, 'C', 'Ignore the marketing team, as UAT is only meant for the engineering team to validate their own work.', false),
    (v_q_id, 'D', 'Launch as planned since criteria were met, but log the "clunky" feedback as an enhancement for the next iteration.', true);

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
        'Uber''s Localization Bug',
        E'An Uber PM in the US reviews a bug report from the Japan team: "When entering a destination, the predictive text suggestions overlap with the driver ETA." The QA team in the US cannot reproduce this bug on their devices.\n\nWhat is the most likely cause that the PM should ask QA to investigate?',
        'intermediate',
        'Uber',
        'Reproducing localization bugs',
        'B',
        'Localization and internationalization issues often stem from text expansion, font rendering, or layout differences in specific languages (like Japanese). The US QA team needs to change their device locale/language to reproduce it. It''s unlikely to be network-related (A) or timezone-related (C) for UI overlap. Assuming Japanese users have different phones (D) ignores the software locale issue.',
        ARRAY['localization_testing', 'bug_reproduction', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The bug is caused by higher latency in Japanese cellular networks.', false),
    (v_q_id, 'B', 'The bug is a localization layout issue triggered specifically by Japanese character rendering.', true),
    (v_q_id, 'C', 'The bug is related to timezone differences corrupting the ETA calculation.', false),
    (v_q_id, 'D', 'Japanese users typically use outdated Android devices that struggle with Uber''s UI.', false);

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
        'Airbnb''s Data Anonymization',
        E'Airbnb is preparing to test a new host payout dashboard in a staging environment. The engineering team plans to dump a copy of the production database into staging so QA has realistic data to test with.\n\nWhat is the most critical risk the PM must ensure is mitigated before testing begins?',
        'intermediate',
        'Airbnb',
        'Test data and privacy',
        'A',
        'Using production data in staging environments poses massive PII (Personally Identifiable Information) and security risks. The data must be sanitized/anonymized before use. Otherwise, QA teams, external contractors, or a staging environment breach could expose real user data (GDPR/CCPA violation). Performance (B) and DB sync (C) are technical concerns, but privacy is a critical compliance risk.',
        ARRAY['test_data', 'privacy_compliance', 'staging_environment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ensuring all Personally Identifiable Information (PII) is anonymized or scrubbed from the data.', true),
    (v_q_id, 'B', 'Ensuring the staging database has enough storage capacity to hold the entire production dump.', false),
    (v_q_id, 'C', 'Ensuring the staging database syncs in real-time with production during the test.', false),
    (v_q_id, 'D', 'Ensuring that QA testers use real host login credentials to access the data.', false);

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
        'Slack''s Accessibility Testing',
        E'Slack is releasing a major redesign of its sidebar. During the final QA sweep, the accessibility (a11y) report shows that the new unread badge contrast ratio is 3.5:1, failing the WCAG AA standard of 4.5:1.\n\nHow should the PM treat this issue?',
        'intermediate',
        'Slack',
        'Accessibility and QA compliance',
        'A',
        'Accessibility issues (like failing WCAG contrast ratios) are functional defects that block users with disabilities (e.g., visual impairments) from using the product. They should be treated as high priority bugs, not merely aesthetic enhancements (B) or edge cases (D). Ignoring them exposes the company to legal risk and alienates users.',
        ARRAY['accessibility_testing', 'a11y', 'bug_triage']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Treat it as a high-priority bug that must be fixed before release, as it prevents visually impaired users from using the feature.', true),
    (v_q_id, 'B', 'Log it as a low-priority UI enhancement, since contrast ratios only affect aesthetic preferences.', false),
    (v_q_id, 'C', 'Delay the release until a full a11y audit of the entire Slack application is completed.', false),
    (v_q_id, 'D', 'Ignore it, as WCAG standards only apply to government websites, not enterprise SaaS products.', false);

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
        'Figma''s Performance Regression',
        E'During performance testing for a new Figma plugin architecture, QA notes that large files now take 4.2 seconds to load, up from 3.8 seconds in the previous version. The acceptable threshold defined in the PRD is 4.0 seconds.\n\nWhat is the best immediate step for the PM?',
        'intermediate',
        'Figma',
        'Performance testing and PRD thresholds',
        'C',
        'Performance regressions require profiling to understand the root cause before making launch decisions. The PM should ask engineering to profile the code to see *why* it got slower. Blindly launching (A) violates the PRD. Blindly rolling back (B) might discard valuable work that could be easily optimized. Raising the threshold (D) defeats the purpose of having performance SLAs.',
        ARRAY['performance_testing', 'regression', 'slas']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch the feature anyway, as users cannot perceive a 400ms difference.', false),
    (v_q_id, 'B', 'Cancel the release and revert to the old architecture immediately.', false),
    (v_q_id, 'C', 'Have engineering profile the load time to identify the bottleneck before deciding on the launch.', true),
    (v_q_id, 'D', 'Update the PRD threshold to 4.5 seconds so the test passes.', false);

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
        'DoorDash''s "Works on My Machine"',
        E'A DoorDash engineer marks a bug as "Cannot Reproduce" and closes the Jira ticket. The bug states: "App crashes when attempting to tip $0 on a canceled order." The QA tester insists they saw it happen twice.\n\nWhat is the most constructive way for the PM to resolve this?',
        'intermediate',
        'DoorDash',
        'Resolving QA vs Dev conflicts over reproducibility',
        'B',
        'The "works on my machine" anti-pattern is common. The PM should facilitate collaboration, such as having the QA tester and developer pair up or screen share to ensure they are using the exact same environment, state, and steps. Re-opening without new info (A) creates a ping-pong war. Closing it (C) leaves a potential crash in prod. Blaming QA (D) destroys team morale.',
        ARRAY['bug_triage', 'reproducibility', 'team_dynamics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Re-open the ticket and assign it back to the engineer with a comment to "try harder."', false),
    (v_q_id, 'B', 'Facilitate a pairing session where QA and Engineering attempt to reproduce the bug together on the same device state.', true),
    (v_q_id, 'C', 'Keep the ticket closed; if an engineer cannot reproduce it, it cannot be fixed.', false),
    (v_q_id, 'D', 'Escalate the QA tester to their manager for submitting poorly documented bugs.', false);

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
        'Stripe''s Penetration Testing',
        E'Stripe is launching a new identity verification API. Because of the sensitive nature of the data, the PM schedules a "Penetration Test" (Pen Test) two weeks before launch.\n\nWhat is the primary objective of this specific testing phase?',
        'intermediate',
        'Stripe',
        'Penetration testing objectives',
        'A',
        'Penetration testing is a security exercise where experts simulate cyber attacks to find vulnerabilities before malicious hackers do. It is highly specific to security. It is not about server load (B—that''s load testing), API latency (C—performance testing), or data accuracy (D—functional testing).',
        ARRAY['security_testing', 'penetration_testing', 'compliance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To identify exploitable security vulnerabilities in the system architecture.', true),
    (v_q_id, 'B', 'To determine how many concurrent API calls the system can handle before failing.', false),
    (v_q_id, 'C', 'To ensure the API response time remains under 100 milliseconds globally.', false),
    (v_q_id, 'D', 'To verify that the AI models are accurately extracting text from driver''s licenses.', false);

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
        'Amazon''s Mock Dependencies',
        E'During early QA for a new Amazon search filter, the backend recommendations service is down for maintenance. QA uses a "mock" service that returns hardcoded JSON responses so they can continue testing the front-end UI.\n\nWhat is the main limitation the PM must be aware of regarding this testing phase?',
        'intermediate',
        'Amazon',
        'Testing with mocked dependencies',
        'B',
        'Mocking allows frontend testing to proceed independently of the backend, but it completely bypasses integration testing. The PM must know that the system has not been proven to work end-to-end with real dynamic data, latency, or backend error states. Assuming full validation (A) is dangerous. Mocks do not cause memory leaks (C) inherently. Mocks are standard practice, not security risks (D).',
        ARRAY['mocking', 'integration_testing', 'frontend_vs_backend']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The mock service will permanently overwrite real data once the backend returns.', false),
    (v_q_id, 'B', 'The testing does not validate integration, meaning contract mismatches or real network latency issues are hidden.', true),
    (v_q_id, 'C', 'Using hardcoded JSON responses will cause memory leaks in the browser during extended testing.', false),
    (v_q_id, 'D', 'Mocks are prohibited in enterprise QA as they violate data privacy laws.', false);

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
        'Discord''s Feature Flag Rollout',
        E'Discord uses feature flags to release a new "Thread" UI. They turn it on for 5% of Canadian users. The QA team immediately notices a spike in automated error logs related to message rendering, though no users have explicitly complained yet.\n\nHow should the PM utilize the feature flag in this scenario?',
        'intermediate',
        'Discord',
        'Feature flags and production QA',
        'C',
        'Feature flags allow PMs to safely test in production. If a spike in errors occurs (even without user reports), the PM should toggle the flag off to limit the blast radius, investigate the errors safely, and then re-enable it. Rolling out to 100% (A) is reckless. Reverting the whole codebase (B) is unnecessary since the flag can just be turned off. Waiting for complaints (D) is poor product stewardship.',
        ARRAY['feature_flags', 'canary_release', 'production_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accelerate the rollout to 100% to gather a statistically significant sample size of errors.', false),
    (v_q_id, 'B', 'Initiate a full Git rollback of the codebase to the previous day''s version.', false),
    (v_q_id, 'C', 'Turn the feature flag off immediately to stop the errors, and have engineering investigate the logs.', true),
    (v_q_id, 'D', 'Leave it on for 5% and wait until at least 10 users submit formal support tickets.', false);

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
        'Shopify''s Exploratory Testing',
        E'Shopify''s core automated test suite passes 100% for a new discount code feature. However, the PM organizes an "exploratory testing" session with five team members before launch.\n\nWhat is the distinct value of exploratory testing compared to automated testing?',
        'intermediate',
        'Shopify',
        'Exploratory testing vs automated testing',
        'A',
        'Automated tests only check exactly what they are programmed to check (the "known knowns"). Exploratory testing relies on human intuition, creativity, and domain knowledge to find edge cases, weird combinations, and usability issues that no one thought to script (the "unknown unknowns"). It is not faster (B), it doesn''t test backend server load better (C), and it''s not primarily for security (D).',
        ARRAY['exploratory_testing', 'manual_qa', 'automated_vs_manual']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It leverages human creativity to uncover unpredictable edge cases that automated scripts were never programmed to find.', true),
    (v_q_id, 'B', 'It executes repetitive regression scenarios much faster than automated CI/CD pipelines.', false),
    (v_q_id, 'C', 'It is the only way to accurately measure database query performance under heavy load.', false),
    (v_q_id, 'D', 'It ensures cryptographic compliance for payment gateways that automated tools cannot access.', false);

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
        'Peloton''s Hardware/Software Integration',
        E'Peloton is releasing a software update that changes how resistance levels are calibrated on the bike. The software QA team tests it on an emulator and it works perfectly.\n\nWhy is emulator testing insufficient for UAT in this context?',
        'intermediate',
        'Peloton',
        'Hardware integration QA',
        'C',
        'When software interacts directly with physical hardware (like a resistance knob on a bike), emulators cannot perfectly replicate mechanical variability, sensor latency, or hardware wear-and-tear. UAT must happen on actual physical bikes. Emulators are fine for pure UI logic, but fall short on hardware integration. Emulators aren''t illegal (A), nor do they inherently use old OS versions (B).',
        ARRAY['hardware_integration', 'emulator_testing', 'uat_environment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Using emulators for final QA violates app store submission policies.', false),
    (v_q_id, 'B', 'Emulators only run outdated versions of the Android operating system.', false),
    (v_q_id, 'C', 'Emulators cannot replicate the physical variability, sensor latency, and mechanical nuances of real bike hardware.', true),
    (v_q_id, 'D', 'Emulators require the software to be rewritten in a different programming language.', false);
    -- ----------------------------------------
    -- QUESTION 25 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        25,
        'Uber''s Microservices QA',
        E'Uber relies on thousands of microservices. The Pricing team deploys an update to their surge calculation logic. All of Pricing''s unit and integration tests pass. However, in production, the Receipts team reports that trip PDFs are rendering without the surge multiplier text.\n\nWhich QA concept did the testing strategy fail to account for?',
        'advanced',
        'Uber',
        'Microservices integration and end-to-end testing',
        'B',
        'In a microservices architecture, individual services (Pricing) can pass all local tests, but changes to their API payload can break downstream consumers (Receipts). This requires rigorous End-to-End (E2E) testing or Consumer-Driven Contract testing. It is not an issue of unit testing (A), load testing (C), or static analysis (D).',
        ARRAY['microservices', 'end_to_end_testing', 'contract_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Test-Driven Development (TDD) coverage', false),
    (v_q_id, 'B', 'Consumer-driven contract testing / End-to-End testing', true),
    (v_q_id, 'C', 'Stress testing for high concurrency', false),
    (v_q_id, 'D', 'Static code analysis', false);

    -- ----------------------------------------
    -- QUESTION 26 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        26,
        'Spotify''s Test Data State Mutation',
        E'Spotify''s QA team is automating tests for a "Create Playlist" flow. The test logs in as User A, creates a playlist, asserts it exists, and passes. The next day, the test fails because User A has hit the maximum limit of 10,000 playlists. \n\nWhat advanced QA principle was violated in the design of this automated test?',
        'advanced',
        'Spotify',
        'Automated testing state management',
        'A',
        'Automated tests should be idempotent and handle their own state. A test should set up the exact data it needs and tear it down afterward (or mock it). Relying on persistent state (creating playlists endlessly without deleting them) causes state mutation, leading to test brittleness. The UI framework (B), network speed (C), and test naming (D) have nothing to do with this failure.',
        ARRAY['test_automation', 'state_mutation', 'idempotency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tests must manage their own state setup and teardown to remain idempotent.', true),
    (v_q_id, 'B', 'Tests should only interact with the API, never the Graphical User Interface.', false),
    (v_q_id, 'C', 'Tests must include built-in sleep functions to account for network latency.', false),
    (v_q_id, 'D', 'Tests must be written in a Behavior-Driven Development (BDD) format to prevent data limits.', false);

    -- ----------------------------------------
    -- QUESTION 27 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        27,
        'Airbnb''s Timezone Edge Case',
        E'Airbnb is testing a new "Instant Book" timeout feature. If a host doesn''t reply in 24 hours, the request expires. The QA team in California creates a booking request at 10 PM PST on a Tuesday. The host account is set to Tokyo time (JST). QA manually fast-forwards the staging server time to Wednesday 11 PM PST to see if it expires.\n\nWhat is the biggest risk with this testing approach?',
        'advanced',
        'Airbnb',
        'Testing time-bound features across timezones',
        'C',
        'Timezone testing is notoriously tricky. By fast-forwarding the server time, QA is testing absolute elapsed time, but they aren''t testing how the application handles the translation between the user''s local timezone (PST), the host''s local timezone (JST), and the server''s UTC time. True testing needs to validate that the expiration strictly relies on UTC timestamps, not local system clocks or timezone boundary crossing.',
        ARRAY['timezone_testing', 'edge_cases', 'date_logic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fast-forwarding server time corrupts the staging database index permanently.', false),
    (v_q_id, 'B', 'The test fails to verify if the automated email was sent exactly at the 12-hour mark.', false),
    (v_q_id, 'C', 'It does not validate if the application properly normalizes the two different local timezones to UTC for the calculation.', true),
    (v_q_id, 'D', 'Hosts in Tokyo do not use the 24-hour timeout feature.', false);

    -- ----------------------------------------
    -- QUESTION 28 (Advanced)
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        28,
        'Netflix''s Chaos Engineering',
        E'To prepare for a massive global release of "Squid Game Season 2", Netflix''s PM and engineering team use a tool called "Chaos Monkey" to randomly shut down production servers during peak viewing hours.\n\nWhy would a PM sign off on intentionally breaking the production environment?',
        'advanced',
        'Netflix',
        'Chaos engineering and resilience QA',
        'B',
        'Chaos Engineering (pioneered by Netflix) intentionally injects failure into production to verify system resilience, fallback mechanisms, and auto-scaling logic under real-world conditions. It is a proactive QA strategy for highly distributed systems to ensure failures gracefully degrade (e.g., lower video bitrate) rather than crashing entirely. It is not about A/B testing (A), load testing raw capacity (C), or firing engineers (D).',
        ARRAY['chaos_engineering', 'resilience_testing', 'production_testing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To act as an A/B test to see if users will cancel their subscription if the stream buffers.', false),
    (v_q_id, 'B', 'To validate the system''s resilience, auto-recovery, and fallback mechanisms in a real-world scenario.', true),
    (v_q_id, 'C', 'To measure the absolute maximum number of concurrent users the remaining servers can hold.', false),
    (v_q_id, 'D', 'To identify which engineering teams take the longest to respond to pager alerts.', false);

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
        'Slack''s Beta Analytics Bias',
        E'Slack rolls out a new "AI Channel Summary" feature to 100 beta testers who opted in via a community forum. After 2 weeks, UAT feedback is 98% positive. The PM uses this to justify a global rollout, but it immediately receives massive backlash from enterprise compliance admins.\n\nWhat QA/Beta testing trap did the PM fall into?',
        'advanced',
        'Slack',
        'Beta testing selection bias',
        'D',
        'Opt-in beta testers from community forums are usually power users, early adopters, and enthusiasts. They are not representative of the broader user base, especially enterprise compliance admins who have entirely different priorities (security vs. novelty). This is a classic selection bias failure in UAT and Beta program design.',
        ARRAY['beta_testing', 'selection_bias', 'uat_design', 'enterprise']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Hawthorne effect (users act differently when they know they are being tested).', false),
    (v_q_id, 'B', 'Survivorship bias (only surveying users who didn''t churn).', false),
    (v_q_id, 'C', 'False positive rate (the analytics tracking code was implemented incorrectly).', false),
    (v_q_id, 'D', 'Selection bias (opt-in forum users do not represent the enterprise customer segment).', true);

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
        'Figma''s Memory Leak',
        E'Figma''s desktop app works perfectly during standard 10-minute QA sessions. However, users report that after leaving Figma open for 8 hours, the entire computer slows down to a crawl. \n\nWhat type of QA testing was likely missing from the pre-launch plan?',
        'advanced',
        'Figma',
        'Long-running performance testing',
        'A',
        'A memory leak occurs when an application fails to release memory it no longer needs, gradually consuming all system RAM over time. Short QA sessions won''t catch this. "Soak testing" (or endurance testing) is required, where the application is left running under a normal load for an extended period to monitor memory and resource utilization.',
        ARRAY['soak_testing', 'memory_leaks', 'performance_qa']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Soak testing (Endurance testing)', true),
    (v_q_id, 'B', 'Spike testing', false),
    (v_q_id, 'C', 'Volume testing', false),
    (v_q_id, 'D', 'Fuzz testing', false);

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
        'Stripe''s Regulatory Sandbox',
        E'Stripe is integrating with a new European banking partner. To perform UAT, Stripe must use the bank''s "Regulatory Sandbox" API. During testing, the PM notices the sandbox API responds in 50ms, while the production API SLA states up to 2 seconds.\n\nWhat is the strategic PM risk of relying purely on this sandbox for UAT?',
        'advanced',
        'Stripe',
        'Third-party integration QA risks',
        'C',
        'Sandboxes provided by third parties often mock heavy backend processes (like actual fraud checks or core banking ledgers) and therefore perform artificially fast. If the PM designs Stripe''s UI assuming a 50ms response, a 2-second delay in production will result in poor UX (e.g., missing loading spinners, timeout errors). Testing must account for the real production SLAs, not just sandbox performance.',
        ARRAY['integration_testing', 'api_testing', 'third_party_dependencies']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The sandbox API will charge real money if the test transactions exceed a certain threshold.', false),
    (v_q_id, 'B', 'The European bank might revoke access to the sandbox if they detect automated load testing.', false),
    (v_q_id, 'C', 'The UI/UX might be designed without proper loading states, leading to poor user experience in production.', true),
    (v_q_id, 'D', 'The PM is violating GDPR by routing test data through a European sandbox environment.', false);

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
        'Discord''s Accessibility Regression',
        E'Discord uses automated Visual Regression Testing (VRT) tools that compare screenshots of UI components against a baseline. After a minor CSS update to button padding, the VRT fails for 400 different screens.\n\nHow should the PM guide the team to handle this failure efficiently?',
        'advanced',
        'Discord',
        'Managing visual regression tools',
        'B',
        'Visual Regression Testing is highly sensitive. A legitimate, intentional change to a global component (like a button) will cause cascading failures across the app. The PM should guide the team to bulk-approve the new baseline for that specific intentional change, rather than rolling back (A), ignoring the tool (D), or doing manual checks for all 400 screens (C) which defeats the purpose of automation.',
        ARRAY['visual_regression', 'automated_testing', 'qa_efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Revert the CSS change, as 400 failures indicates a critical breakdown in the application architecture.', false),
    (v_q_id, 'B', 'Acknowledge the intentional change and update the VRT baseline images globally to accept the new padding.', true),
    (v_q_id, 'C', 'Assign the QA team to manually verify all 400 screens before approving the deployment.', false),
    (v_q_id, 'D', 'Delete the VRT tool from the pipeline, as it generates too many false positives to be useful.', false);

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
        'DoorDash''s A/B Test QA',
        E'DoorDash is running an A/B test for a new checkout button color. Variant A is red, Variant B is green. During QA, a tester clears their cookies, visits the site, gets Variant A, clears cookies again, and gets Variant B. They log a bug: "User can switch variants."\n\nHow should the PM respond to this bug report?',
        'advanced',
        'DoorDash',
        'QAing A/B testing infrastructure',
        'C',
        'A/B testing assignment is typically handled via cookies or local storage for anonymous users (or User ID for logged-in users). By clearing cookies, the tester is effectively creating a "new" anonymous user, prompting the A/B testing engine to re-assign a variant randomly. This is the intended behavior of the infrastructure, not a bug. Closing as "Works as Designed" is the correct action.',
        ARRAY['ab_testing', 'qa_infrastructure', 'bug_triage']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Escalate to high severity; users must always remain in their assigned variant regardless of cookie state.', false),
    (v_q_id, 'B', 'Assign to engineering to switch the assignment logic from cookies to IP addresses.', false),
    (v_q_id, 'C', 'Close as "Works as Designed"; clearing cookies simulates a new anonymous user, triggering a new assignment.', true),
    (v_q_id, 'D', 'Pause the A/B test immediately because the data is now corrupted by users switching variants.', false);

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
        'Amazon''s Fuzz Testing',
        E'An Amazon AWS PM is responsible for a new JSON parsing API. The security QA team runs a "Fuzz Test" against the endpoint, sending millions of malformed, random strings, null bytes, and excessively large payloads.\n\nWhat is the primary vulnerability this type of testing is designed to uncover?',
        'advanced',
        'Amazon',
        'Security testing and fuzzing',
        'B',
        'Fuzz testing (fuzzing) involves inputting massive amounts of random, invalid, or unexpected data to a system to discover coding errors, memory leaks, or unhandled exceptions that lead to crashes or security vulnerabilities (like buffer overflows). It does not test UI workflows (A), valid database query speed (C), or network routing latency (D).',
        ARRAY['fuzz_testing', 'security_qa', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Logical errors in the user onboarding workflow.', false),
    (v_q_id, 'B', 'Unhandled exceptions, crashes, and memory leaks caused by unexpected inputs.', true),
    (v_q_id, 'C', 'Slow database query execution times under normal traffic loads.', false),
    (v_q_id, 'D', 'DNS routing delays across different AWS availability zones.', false);

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
        'Shopify''s Multi-Tenant Data Bleed',
        E'Shopify QA is performing security UAT on a new inventory reporting tool. Tester A logs in as Merchant X, and Tester B logs in as Merchant Y. Tester A inputs a malicious SQL string into the search bar, and Tester B suddenly sees Merchant X''s inventory data in their results.\n\nWhat specific architectural QA failure has occurred?',
        'advanced',
        'Shopify',
        'Multi-tenant architecture QA',
        'A',
        'In a SaaS multi-tenant architecture (like Shopify), multiple customers share the same database. A "data bleed" or "tenant isolation failure" occurs when a flaw (like SQL injection or broken access control) allows one tenant to view another tenant''s data. This is a catastrophic security failure. It is not an API rate limit (B), a CDN cache issue (C), or an async queue failure (D).',
        ARRAY['multi_tenant', 'security_qa', 'data_isolation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tenant isolation failure (Data bleed)', true),
    (v_q_id, 'B', 'API rate limiting bypass', false),
    (v_q_id, 'C', 'Content Delivery Network (CDN) cache invalidation', false),
    (v_q_id, 'D', 'Asynchronous message queue deadlock', false);

    RAISE NOTICE 'Successfully inserted 35 questions for QA & UAT';

END $$;
