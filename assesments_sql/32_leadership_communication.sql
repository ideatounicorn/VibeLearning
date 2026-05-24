-- ============================================
-- ASSESSMENT: Communication
-- CATEGORY: Leadership
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
    WHERE slug = 'communication';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug communication not found. Run the seed data first.';
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
        'Netflix''s Delay Communication',
        E'A PM at Netflix discovers that a highly anticipated social viewing feature will miss the Q3 launch window due to unresolved edge cases in video synchronization. The VP of Product is expecting an update today.\n\nWhat is the most effective way to communicate this delay to the executive?',
        'foundational',
        'Netflix',
        'Netflix is a global streaming platform with high standards for playback reliability.',
        'C',
        'Option C is correct because executives need to know the impact and the plan immediately (BLUF - Bottom Line Up Front). They do not need deep technical excuses, nor should a PM throw engineering under the bus. Waiting for perfect information violates the principle of surfacing bad news early; PMs must communicate risks as soon as they are known, even if the exact resolution is still being finalized.',
        ARRAY['executive_update', 'delivering_bad_news', 'bluf']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Wait to communicate the delay until the engineering team provides a guaranteed new launch date to avoid multiple updates.', false),
    (v_q_id, 'B', 'Send a detailed technical root cause analysis explaining the synchronization architecture to justify the delay.', false),
    (v_q_id, 'C', 'Use the BLUF (Bottom Line Up Front) method: state the delay immediately, explain the user impact, and provide a mitigation plan.', true),
    (v_q_id, 'D', 'Inform the VP that engineering missed their estimates and ask for leadership to intervene with the engineering manager.', false);

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
        'Slack''s Technical Trade-off',
        E'During a Slack leadership review, a non-technical executive asks why a highly requested message scheduling feature is taking so long. The engineering team has encountered deep tech debt in the legacy message queue architecture.\n\nHow should the PM explain the situation?',
        'foundational',
        'Slack',
        'Slack is a workplace communication tool relying heavily on real-time messaging architecture.',
        'B',
        'Option B correctly translates technical complexity into business impact (stability vs. speed) that non-technical executives care about. Option A is too deep into technical jargon. Option C blames engineering, damaging cross-functional trust. Option D deflects the question and fails to provide transparency about the trade-off being made.',
        ARRAY['audience_tailoring', 'cross_functional', 'technical_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Explain the specific limitations of the current Kafka event streams and how they impact the database schema.', false),
    (v_q_id, 'B', 'Use an analogy explaining that they must reinforce the foundation before building a new floor, framing it as a trade-off between launch speed and system stability.', true),
    (v_q_id, 'C', 'State that the engineering team originally underestimated the work and you are holding them accountable for the tech debt.', false),
    (v_q_id, 'D', 'Pivot the conversation to focus entirely on user research for the feature to avoid getting bogged down in engineering details.', false);

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
        'Stripe''s Status Update',
        E'A PM at Stripe is sending a weekly status email to stakeholders for a critical new API integration. The project is currently blocked by a third-party partner, threatening the launch date.\n\nWhich format is best for this update?',
        'foundational',
        'Stripe',
        'Stripe is a financial infrastructure platform where reliability and partner integrations are core to the product.',
        'A',
        'Option A is the most effective approach for executive status updates. The RYG (Red, Yellow, Green) framework immediately signals project health. Identifying blockers and making explicit asks allows leadership to unblock the team. Option B hides the risk. Option C is too verbose. Option D prematurely shifts timelines without trying to resolve the blocker.',
        ARRAY['status_reporting', 'stakeholder_management', 'blocker_escalation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Red/Yellow/Green health status at the top, a clear description of the partner blocker, and a specific ask for leadership to leverage their relationship.', true),
    (v_q_id, 'B', 'A comprehensive list of all the engineering tickets completed this week to show momentum, with the blocker mentioned at the bottom.', false),
    (v_q_id, 'C', 'A chronological narrative of the week''s events, detailing every conversation had with the third-party partner to show due diligence.', false),
    (v_q_id, 'D', 'An updated timeline showing the new delayed launch date, to proactively manage expectations before they ask.', false);

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
        'Notion''s Async Comms',
        E'A PM at Notion needs to finalize a decision on whether to deprecate an underused template gallery feature. The engineering and design leads have mildly differing opinions, but no one feels strongly. The team spans three time zones.\n\nHow should the PM drive this decision?',
        'foundational',
        'Notion',
        'Notion is a productivity tool whose culture heavily favors asynchronous, document-driven communication.',
        'C',
        'Option C leverages asynchronous communication correctly for a low-contention, distributed team decision. Option A wastes synchronous time on a low-stakes decision. Option B creates a scattered, unrecorded decision process. Option D is dictatorial and bypasses necessary cross-functional alignment.',
        ARRAY['asynchronous_communication', 'meeting_management', 'decision_making']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Schedule a 60-minute mandatory synchronous meeting to ensure everyone is heard before deciding.', false),
    (v_q_id, 'B', 'Direct message the engineering and design leads separately until a consensus is reached.', false),
    (v_q_id, 'C', 'Write a short one-pager outlining the recommendation and trade-offs, and ask for async sign-off in the comments by Friday.', true),
    (v_q_id, 'D', 'Make the decision unilaterally and announce it in the next all-hands meeting.', false);

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
        'Airbnb''s Release Notes',
        E'Airbnb is rolling out a mandatory change to how Hosts upload property photos, which will break older listings if not updated. The PM needs to draft the email to Hosts.\n\nWhat should be the primary focus of the communication?',
        'foundational',
        'Airbnb',
        'Airbnb relies on millions of independent Hosts who are often not tech-savvy.',
        'D',
        'Option D focuses on the "why" (user benefit) and the "how" (actionable next steps), which is essential for user-facing change management. Option A focuses on internal reasons rather than user value. Option B is aggressive and causes unnecessary panic. Option C assumes Hosts understand API architecture, which is a classic PM curse-of-knowledge mistake.',
        ARRAY['external_communication', 'user_empathy', 'change_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Explain that Airbnb is migrating to a new cloud storage provider and needs photos updated to match the new schema.', false),
    (v_q_id, 'B', 'Emphasize the penalty of non-compliance immediately so Hosts take the warning seriously.', false),
    (v_q_id, 'C', 'Provide the technical specs of the new image API so power-Hosts can build their own automated solutions.', false),
    (v_q_id, 'D', 'Explain how the new photo format will increase their booking rates and provide a simple, step-by-step guide to updating.', true);

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
        'Spotify''s Failed Test Communication',
        E'A Spotify PM runs an A/B test on a new "Discovery Feed" layout. The results show a 5% drop in daily active listening time. The PM must present the results at the monthly product review.\n\nHow should the PM frame this outcome?',
        'foundational',
        'Spotify',
        'Spotify has a strong culture of data-driven experimentation and learning.',
        'B',
        'Option B embodies a healthy experimentation culture—framing a "failed" test as validated learning. It prevents future mistakes and adds to organizational knowledge. Option A hides negative data, which is unethical and dangerous. Option C defensively blames other factors without evidence. Option D arbitrarily extends tests just to fish for a positive result.',
        ARRAY['data_storytelling', 'experimentation_culture', 'transparency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Highlight secondary metrics that went up, like click-through rate, and briefly mention the listening time drop at the end.', false),
    (v_q_id, 'B', 'Clearly state the test failed its primary metric, share the insights learned about user behavior, and explain what will be tested next.', true),
    (v_q_id, 'C', 'Attribute the drop in listening time to seasonality or a broader market trend to protect the team''s reputation.', false),
    (v_q_id, 'D', 'Suggest running the test for another 3 months to see if the negative metric eventually turns positive.', false);

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
        'Figma''s PRD Clarity',
        E'A PM at Figma is writing a Product Requirements Document (PRD) for a new real-time cursor feature. Engineering complains that the PM''s specs are confusing and lead to rework.\n\nWhat is the most common communication flaw in early-career PRDs that causes this?',
        'foundational',
        'Figma',
        'Figma is a collaborative design tool requiring high precision in technical execution and UX.',
        'C',
        'Option C is correct. Junior PMs often jump straight into defining UI buttons or database schemas rather than clearly articulating the core user problem and the "why." Option A is false; shorter is often better if concise. Option B is false; engineers should contribute to edge cases. Option D is an anti-pattern; PRDs shouldn''t read like marketing material.',
        ARRAY['documentation', 'product_requirements', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keeping the document too brief and relying too heavily on asynchronous comments.', false),
    (v_q_id, 'B', 'Refusing to map out every single technical edge case before engineering begins coding.', false),
    (v_q_id, 'C', 'Jumping straight into prescribing the solution and UI rather than clearly defining the user problem and use cases.', true),
    (v_q_id, 'D', 'Failing to include enough marketing and go-to-market strategy in the technical spec.', false);

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
        'Uber''s Outage Update',
        E'During peak Friday hours, Uber''s rider app begins crashing on launch. It is a P0 outage. The PM is the designated incident commander communicating with leadership.\n\nWhat is the best practice for outage communication?',
        'foundational',
        'Uber',
        'Uber requires real-time reliability; outages directly impact driver earnings and rider safety.',
        'A',
        'Option A is correct. In a crisis, establishing a predictable cadence of communication (e.g., every 30 minutes) reduces panic, even if the update is "we are still investigating." Option B causes executives to panic and interrupt the triage team. Option C spreads panic unnecessarily. Option D wastes time on blame during an active incident.',
        ARRAY['crisis_communication', 'incident_management', 'managing_up']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Establish a regular cadence for updates (e.g., every 30 mins) and send them on time, even if the update is "still investigating."', true),
    (v_q_id, 'B', 'Wait to send any updates until the root cause is confirmed so you don''t provide false information.', false),
    (v_q_id, 'C', 'Immediately blast an email to the entire company detailing the revenue being lost per minute to create urgency.', false),
    (v_q_id, 'D', 'Focus the first update on identifying which engineering team pushed the broken code so accountability is clear.', false);

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
        'Shopify''s Sales Alignment',
        E'A Shopify PM receives an urgent email from a Sales Director demanding a custom checkout feature to close a $500k merchant deal. The feature is not on the roadmap.\n\nHow should the PM respond to maintain alignment?',
        'foundational',
        'Shopify',
        'Shopify serves both small merchants and enterprise clients, requiring PMs to balance scalable platform features against custom enterprise requests.',
        'B',
        'Option B builds a constructive relationship. It acknowledges the request, explains the current strategic boundaries, and offers a clear process for evaluating it later without saying a flat, dismissive "no." Option A destroys product strategy. Option C is defensive and alienating. Option D makes false promises that ruin trust.',
        ARRAY['managing_expectations', 'sales_enablement', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree to build it immediately to secure the revenue, then ask engineering to squeeze it into the current sprint.', false),
    (v_q_id, 'B', 'Acknowledge the deal value, explain how the current roadmap prioritizes platform-wide scalability, and offer to review the request in the next quarterly planning.', true),
    (v_q_id, 'C', 'Reply bluntly that product builds for the market, not for individual sales deals, and tell them to sell what is currently available.', false),
    (v_q_id, 'D', 'Tell the Sales Director the feature is "on the short-term roadmap" to help close the deal, then figure out how to build it later.', false);

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
        'GitHub''s Post-mortem Tone',
        E'Following a brief database outage that affected GitHub Actions, the PM is drafting the incident post-mortem document. An engineer made a manual error that caused the outage.\n\nWhat is the appropriate tone and focus for this document?',
        'foundational',
        'GitHub',
        'GitHub supports developers and adheres to strict site reliability engineering (SRE) principles.',
        'D',
        'Option D represents the industry standard of a "blameless post-mortem." The focus must be on why the system allowed a human error to cause an outage, not on punishing the human. Option A creates a culture of fear. Option B minimizes the impact. Option C focuses on the wrong metric.',
        ARRAY['post_mortem', 'blameless_culture', 'documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accountability-driven: Clearly identify the engineer who made the mistake so stakeholders know the team is taking it seriously.', false),
    (v_q_id, 'B', 'Defensive: Emphasize how quickly the team fixed the issue to ensure leadership knows the team is competent.', false),
    (v_q_id, 'C', 'Financial: Focus entirely on the SLA credits that will need to be paid out rather than the technical details.', false),
    (v_q_id, 'D', 'Blameless and systemic: Focus on the system vulnerabilities that allowed a single manual error to cause a catastrophic failure.', true);

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
        'DoorDash''s Thread Escalation',
        E'A DoorDash PM is watching a Slack thread spiral out of control. The Engineering Lead says a new delivery batching feature is "ready to ship." The Operations Lead replies it will "destroy Dasher trust." The thread is now 40 messages deep.\n\nWhat is the most effective intervention?',
        'intermediate',
        'DoorDash',
        'DoorDash requires tight alignment between engineering (building algorithms) and local operations (managing drivers).',
        'C',
        'Option C is the correct escalation path for toxic or spiraling async communication. When threads exceed a certain length without resolution, a PM must shift to synchronous communication to reset tone and drive alignment, then document the result. Option A ignores the conflict. Option B adds to the noise. Option D escalates prematurely.',
        ARRAY['conflict_resolution', 'synchronous_communication', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stay out of it until they resolve it themselves; PMs shouldn''t micromanage cross-functional relationships.', false),
    (v_q_id, 'B', 'Write a long, detailed Slack message breaking down both arguments and declaring who is right based on the PRD.', false),
    (v_q_id, 'C', 'Call a quick 15-minute sync with just the two leads to resolve the core disagreement, then summarize the outcome in the thread.', true),
    (v_q_id, 'D', 'Tag the VP of Product and VP of Operations into the thread to enforce a top-down decision immediately.', false);

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
        'Zoom''s Dependency Escalation',
        E'A PM at Zoom is leading a project to add AI summaries to meetings. The project is completely blocked because the Core Audio team hasn''t delivered the transcript API. The PM has tried negotiating with the Audio PM for 3 weeks with no success.\n\nHow should the PM structure the escalation to their VP?',
        'intermediate',
        'Zoom',
        'Zoom operates with highly specialized micro-teams, making cross-team dependencies a common risk.',
        'D',
        'Option D is the perfect executive escalation. It provides context, proves due diligence, states the business impact objectively, and makes a specific ask. Option A is just complaining. Option B is passive-aggressive and bypasses standard escalation. Option C offers no solutions or clear requests.',
        ARRAY['managing_up', 'escalation_paths', 'cross_team_collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"The Audio team is being uncooperative and blocking our launch. Can you talk to their VP?"', false),
    (v_q_id, 'B', 'Secretly build a workaround using a third-party API and surprise the leadership team at the launch.', false),
    (v_q_id, 'C', '"We are blocked on the transcript API. Just wanted to keep you in the loop. We will keep waiting."', false),
    (v_q_id, 'D', '"We are blocked by the Audio team''s API delay, pushing our launch by 4 weeks. I''ve tried negotiating scope with their PM but they are fully resourced on another priority. I need you to align with their VP on Q2 prioritization."', true);

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
        'Discord''s Controversial Change',
        E'Discord is removing a popular free feature (custom server banners) and moving it to the paid Nitro tier. The PM must draft the community announcement.\n\nWhich communication strategy will minimize community backlash?',
        'intermediate',
        'Discord',
        'Discord has a highly engaged, vocal user base that is highly sensitive to corporate "PR speak."',
        'C',
        'Option C builds trust through authenticity. Highly engaged communities like Discord respond best to transparent business realities rather than corporate gaslighting (Option A). Option B is too weak and apologetic, signaling a lack of conviction. Option D shifts blame to users, which guarantees outrage.',
        ARRAY['community_management', 'transparency', 'external_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Frame it purely as an "upgrade to the Nitro experience" and avoid mentioning that free users are losing something.', false),
    (v_q_id, 'B', 'Apologize profusely in the first paragraph to show empathy, then explain the change.', false),
    (v_q_id, 'C', 'Acknowledge the removal directly, briefly explain the business necessity of funding development, and highlight the new features being added for free users.', true),
    (v_q_id, 'D', 'Explain that the feature was costing the company too much money because free users were abusing the server infrastructure.', false);

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
        'Tinder''s Metric Drop Presentation',
        E'A Tinder PM notices a 12% drop in Day-7 retention among Android users. After deep analysis, the PM finds it is due to a buggy push notification SDK.\n\nWhen presenting this to the executive team, what is the best slide structure?',
        'intermediate',
        'Tinder',
        'Tinder''s leadership is highly metric-driven but strapped for time, requiring dense but synthesized updates.',
        'A',
        'Option A follows the "Minto Pyramid Principle"—start with the core insight (the drop and cause), follow with the action plan, and leave complex data for those who want to dig deeper. Option B buries the lead. Option C provides no solution. Option D creates panic without clarity.',
        ARRAY['data_storytelling', 'executive_update', 'presentation_skills']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Slide 1: The Root Cause & Impact (SDK Bug = 12% drop). Slide 2: The Action Plan to fix it. Appendix: Deep-dive data graphs.', true),
    (v_q_id, 'B', 'Slide 1: Overview of Day-7 retention. Slide 2: Breakdown by platform. Slide 3: Android anomalies. Slide 4: The root cause.', false),
    (v_q_id, 'C', 'Provide a dashboard link with no slides so executives can explore the data themselves to truly understand it.', false),
    (v_q_id, 'D', 'Slide 1: A massive red chart showing the 12% drop to create urgency, followed by 5 slides of technical SDK documentation.', false);

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
        'Robinhood''s Regulatory Constraints',
        E'The SEC has mandated a new risk-disclosure screen before Robinhood users can trade options. The Design Lead is frustrated, arguing the new screen ruins the frictionless onboarding experience.\n\nHow should the PM communicate with the Design Lead?',
        'intermediate',
        'Robinhood',
        'Robinhood balances a consumer-friendly UX with stringent financial regulations.',
        'B',
        'Option B frames the constraint as a design challenge rather than a top-down mandate, preserving the designer''s autonomy while strictly adhering to the requirement. Option A is dismissive. Option C gives false hope and wastes time. Option D assumes designers don''t care about the business, which is adversarial.',
        ARRAY['cross_functional', 'design_collaboration', 'managing_constraints']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Legal said we have to do this, so we don''t have a choice. Just put the text on the screen."', false),
    (v_q_id, 'B', '"This disclosure is a hard legal constraint. How can we design this step so it feels educational and trustworthy rather than like a roadblock?"', true),
    (v_q_id, 'C', '"Let''s build it both ways and A/B test it. If the conversion drops too much, I''ll take the data back to Legal to argue against it."', false),
    (v_q_id, 'D', '"I know you only care about aesthetics, but as the PM, I have to protect the company from getting sued."', false);

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
        'Duolingo''s Nuanced Test Results',
        E'A Duolingo PM runs an experiment changing the daily push notification copy. The results:\n- DAU (Primary Metric): Flat (0% change)\n- App Opens per User: +5%\n- Push Unsubscribe Rate: +2%\n\nHow should the PM communicate this to the Growth team?',
        'intermediate',
        'Duolingo',
        'Duolingo relies heavily on gamification and push notifications to drive daily habit formation.',
        'D',
        'Option D presents a nuanced, objective view of the trade-offs. The test didn''t achieve its primary goal (DAU), but it drove deeper engagement at the cost of long-term channel health (unsubscribes). Option A lies by omission. Option B jumps to rollout without discussing the trade-off. Option C declares failure without recognizing the learnings.',
        ARRAY['data_storytelling', 'ab_testing', 'trade_off_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Focus entirely on the +5% App Opens as a massive win and recommend immediate rollout.', false),
    (v_q_id, 'B', 'State that the test was a success because engagement went up, and ignore the unsubscribe rate since it''s only 2%.', false),
    (v_q_id, 'C', 'Declare the test an absolute failure because DAU didn''t move, and advise the team to discard the new copy.', false),
    (v_q_id, 'D', 'State that DAU was flat, highlight the trade-off between higher engagement and higher churn risk, and recommend an iteration to reduce the aggressive tone.', true);

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
        'LinkedIn''s Roadmap Pivot',
        E'Midway through Q2, LinkedIn''s executive team decides to halt all work on a new Groups feature and pivot the team to focus entirely on Creator tools.\n\nWhat is the most critical element the PM must include when communicating this to the engineering team?',
        'intermediate',
        'LinkedIn',
        'LinkedIn is evolving from a resume platform to a creator-led professional network.',
        'C',
        'Option C provides the "Why." Engineers need to understand the strategic rationale to stay motivated after having their work thrown away. Option A sounds like a lack of PM autonomy. Option B focuses on process rather than purpose. Option D is an outright lie that damages trust when the code is eventually deleted.',
        ARRAY['change_management', 'strategic_alignment', 'team_morale']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A clear statement that leadership made the call and the PM fought against it but lost.', false),
    (v_q_id, 'B', 'A detailed Jira mapping of how the old tickets will be archived and new tickets will be assigned.', false),
    (v_q_id, 'C', 'The strategic "why" driving the pivot (e.g., changing market dynamics) and how it connects to the company''s North Star.', true),
    (v_q_id, 'D', 'A promise that the code they wrote for the Groups feature will definitely be used later in the year.', false);

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
        'Amazon''s PR/FAQ Narrative',
        E'An Amazon PM is writing a PR/FAQ (Press Release / Frequently Asked Questions) document for a new drone delivery subscription. \n\nWhat is the core purpose of the "Press Release" section of this document?',
        'intermediate',
        'Amazon',
        'Amazon uses the "Working Backwards" process, requiring PMs to write a PR/FAQ before writing a single line of code.',
        'A',
        'Option A is the essence of Amazon''s PR/FAQ framework. It forces the PM to distill the value proposition into simple, customer-centric language. Option B is wrong; tech specs belong in technical docs. Option C is wrong; it shouldn''t be a financial model. Option D is wrong; the PR/FAQ is for internal alignment before development, not literal external PR.',
        ARRAY['working_backwards', 'customer_centricity', 'documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To force the team to describe the customer problem and the product''s core value proposition in simple, jargon-free language.', true),
    (v_q_id, 'B', 'To provide a high-level technical architecture of how the drone navigation system will integrate with fulfillment centers.', false),
    (v_q_id, 'C', 'To justify the financial ROI of the initiative to the executive team using projected market share data.', false),
    (v_q_id, 'D', 'To provide the actual marketing copy that the PR team will send to journalists upon launch.', false);

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
        'Pinterest''s Visual Alignment',
        E'A Pinterest PM is trying to explain a complex new multi-step user flow for saving "Idea Pins." The written PRD is causing confusion among the mobile engineers and designers.\n\nWhat is the most effective way to communicate this flow?',
        'intermediate',
        'Pinterest',
        'Pinterest is a highly visual product, requiring seamless interaction across discovery and saving flows.',
        'C',
        'Option C recognizes that complex user flows are best communicated visually. A user journey map or flow diagram instantly clarifies states and transitions that take pages to explain in text. Option A just adds more text. Option B wastes synchronous time. Option D is prescriptive and steps on the designer''s toes.',
        ARRAY['documentation', 'visual_communication', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Rewrite the PRD using stricter bullet points and bolded text for emphasis.', false),
    (v_q_id, 'B', 'Schedule a 2-hour meeting to read through the PRD line-by-line together.', false),
    (v_q_id, 'C', 'Create a visual user journey map or flowchart showing screens, states, and decision logic.', true),
    (v_q_id, 'D', 'Design the high-fidelity UI mockups yourself in Figma so they know exactly what to build.', false);

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
        'Canva''s Executive Review',
        E'During a product review at Canva, the Chief Product Officer aggressively criticizes the PM''s proposed pricing tier, stating: "This makes absolutely no sense for enterprise users."\n\nHow should the PM respond in the moment?',
        'intermediate',
        'Canva',
        'Canva has expanded from consumer design to B2B enterprise, creating tension in product strategy.',
        'B',
        'Option B de-escalates the tension, seeks to understand the root of the objection, and maintains the PM''s composure. Option A is defensive and argumentative. Option C shows a lack of conviction and caves immediately. Option D is passive-aggressive and dismissive.',
        ARRAY['managing_up', 'handling_feedback', 'executive_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Defend the proposal immediately by talking louder and presenting the 15 data points that prove the CPO wrong.', false),
    (v_q_id, 'B', 'Validate the concern, ask a clarifying question to uncover the specific enterprise use case they are worried about, and offer to follow up offline with data.', true),
    (v_q_id, 'C', 'Agree immediately with the CPO, apologize for the oversight, and promise to change the pricing tier by tomorrow.', false),
    (v_q_id, 'D', 'Ignore the comment and quickly move to the next slide to avoid further confrontation.', false);

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
        'HubSpot''s Sales Enablement',
        E'HubSpot is launching a new AI-powered lead scoring model. The PM needs to train the sales team on how to sell this new feature.\n\nWhat should be the primary focus of the PM''s presentation to Sales?',
        'intermediate',
        'HubSpot',
        'HubSpot is a B2B SaaS platform heavily reliant on an enterprise sales motion.',
        'A',
        'Option A is correct because Sales cares about how a feature helps them close deals. They need to know the customer pain points it solves, the competitive advantage, and the exact talk tracks. Option B focuses on technical implementation, which Sales doesn''t care about. Option C focuses on internal metrics. Option D is for the product team, not Sales.',
        ARRAY['go_to_market', 'sales_enablement', 'product_marketing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Customer pain points solved, competitive differentiators, and specific talk tracks/objection handling.', true),
    (v_q_id, 'B', 'The architecture of the machine learning model and the data pipelines used to train it.', false),
    (v_q_id, 'C', 'The engineering sprint velocity and the story points completed to build the feature.', false),
    (v_q_id, 'D', 'The product roadmap for the next 3 years to show long-term vision.', false);

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
        'Atlassian''s At-Risk Project',
        E'A PM at Atlassian is sending a monthly update for Jira''s new dark mode. The project is currently marked "Yellow" (At Risk) due to UI bugs, but the team believes they can still hit the launch date if they work weekends.\n\nHow should this be communicated in the status update?',
        'intermediate',
        'Atlassian',
        'Atlassian values transparency and sustainable engineering practices.',
        'D',
        'Option D represents healthy status reporting. A "Yellow" status means there is risk, and leadership needs to know what the mitigation plan is and the threshold for failure (turning Red). Option A lies to leadership. Option B creates unnecessary panic. Option C promotes a toxic work culture and hides systemic project issues.',
        ARRAY['status_reporting', 'risk_management', 'transparency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mark the project as "Green" so leadership doesn''t panic, since the team plans to catch up anyway.', false),
    (v_q_id, 'B', 'Mark the project as "Red" to dramatically lower expectations, making the team look like heroes if they hit the date.', false),
    (v_q_id, 'C', 'Keep it "Yellow" but assure leadership the team is working weekends to fix it, demonstrating dedication.', false),
    (v_q_id, 'D', 'Keep it "Yellow," explicitly define the bug backlog, outline the mitigation plan (e.g., cutting edge-case scope), and state the date a "Red" decision will be made.', true);

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
        'Dropbox''s Dependency Slip',
        E'A Dropbox PM is informed by the Infrastructure team that a required database migration will be delayed by a month, directly delaying the PM''s file-sharing feature.\n\nWhen updating the General Manager, how should the PM frame this delay?',
        'intermediate',
        'Dropbox',
        'Dropbox relies on massive, shared infrastructure where cross-team dependencies are unavoidable.',
        'B',
        'Option B is the hallmark of a mature PM. It objectively states the dependency impact without throwing colleagues under the bus, and immediately pivots to how the team is utilizing the newly available time. Option A focuses on blame. Option C creates siloed, fragile systems. Option D wastes executive time with low-level mediation.',
        ARRAY['cross_team_collaboration', 'delivering_bad_news', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ensure the GM knows it is entirely the Infrastructure team''s fault so your team isn''t penalized.', false),
    (v_q_id, 'B', 'State the new timeline objectively, explain the dependency, and outline how your team will use the waiting period to tackle tech debt.', true),
    (v_q_id, 'C', 'Announce that your team will build their own parallel database to bypass the Infrastructure team entirely.', false),
    (v_q_id, 'D', 'Ask the GM to mediate a conflict resolution meeting between you and the Infrastructure PM.', false);

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
        'Salesforce''s Impossible Deadline',
        E'The VP of Sales at Salesforce demands that a new dashboard widget be ready by the annual Dreamforce conference in 4 weeks. Engineering estimates it will take 8 weeks.\n\nHow should the PM communicate with the VP?',
        'intermediate',
        'Salesforce',
        'Salesforce is heavily driven by its major annual conference, creating intense deadline pressure.',
        'C',
        'Option C is the classic "iron triangle" PM response. You cannot change time, so you must negotiate scope. By offering a functional "V1" for the conference, the PM meets the business need without crushing the engineering team. Option A leads to burnout and failure. Option B is overly rigid. Option D is deceptive.',
        ARRAY['managing_up', 'negotiation', 'scope_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the 4-week deadline and tell engineering they must work whatever hours necessary to hit it.', false),
    (v_q_id, 'B', 'Flatly refuse the request, citing the engineering estimate, and state it will be ready in 8 weeks.', false),
    (v_q_id, 'C', 'Present the trade-offs: propose a stripped-down "V1" with hardcoded data that meets the 4-week deadline, with the full dynamic version arriving later.', true),
    (v_q_id, 'D', 'Agree to the 4 weeks, but quietly plan to launch a fake UI mockup at the conference to buy time.', false);

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
        'Reddit''s Risky Rollout',
        E'A Reddit PM is rolling out a new threaded comment architecture. It is highly requested but carries massive technical risk of breaking the site under load.\n\nWhat is the most important element to include in the internal rollout communication?',
        'intermediate',
        'Reddit',
        'Reddit experiences massive traffic spikes and has a user base highly sensitive to site performance.',
        'A',
        'Option A is crucial for risky rollouts. Internal teams must know the exact thresholds for failure and the plan to revert, which builds confidence. Option B is marketing fluff. Option C focuses on the wrong kind of risk (community vs. technical). Option D bypasses standard release processes.',
        ARRAY['change_management', 'risk_management', 'internal_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The explicit guardrail metrics (e.g., latency > 200ms) that will trigger an automatic rollback to the old architecture.', true),
    (v_q_id, 'B', 'A celebratory tone focusing on how many years the users have been asking for this feature.', false),
    (v_q_id, 'C', 'A list of moderator tools to help them ban users who complain too loudly about bugs.', false),
    (v_q_id, 'D', 'Instructions for the support team on how to manually fix database errors if they occur.', false);

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
        'WhatsApp''s Internal Crisis Comms',
        E'A tech blog publishes a misleading article claiming WhatsApp''s new privacy update allows Facebook to read users'' messages. Panic is spreading internally among customer support and sales teams.\n\nWhat is the PM''s immediate communication responsibility?',
        'intermediate',
        'WhatsApp',
        'WhatsApp''s core value proposition is end-to-end encryption and user privacy.',
        'B',
        'Option B is correct. During a PR crisis involving the product, the PM must arm internal customer-facing teams with an approved, factual FAQ so they can respond consistently to users. Option A is the PR team''s job. Option C ignores the immediate need of internal teams. Option D validates the false claim.',
        ARRAY['crisis_communication', 'internal_alignment', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Drafting a combative public tweet to argue with the tech blogger.', false),
    (v_q_id, 'B', 'Creating an internal "source of truth" FAQ explaining exactly what the update does and does not do, aligned with Legal/PR.', true),
    (v_q_id, 'C', 'Pausing all engineering work to rewrite the privacy policy so it is easier to understand.', false),
    (v_q_id, 'D', 'Rolling back the privacy update immediately to stop the bad press.', false);

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
        'Booking.com''s Failed Experiments',
        E'A PM at Booking.com has run 4 consecutive A/B tests aimed at increasing checkout conversion. All 4 tests resulted in flat or negative movement. Team morale is tanking.\n\nHow should the PM communicate this in the monthly team retrospective?',
        'intermediate',
        'Booking.com',
        'Booking.com runs one of the most rigorous, high-volume A/B testing programs in the industry.',
        'A',
        'Option A reframes failure into progress. In strong testing cultures, invalidating a hypothesis saves the company from shipping useless features. Compiling learnings builds a sharper thesis for the next test. Option B blames others. Option C lowers the bar for success. Option D is deceptive.',
        ARRAY['experimentation_culture', 'team_morale', 'data_storytelling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Synthesize the 4 tests to show what the team has definitively learned about user behavior, and use it to propose a newly informed hypothesis.', true),
    (v_q_id, 'B', 'Blame the UX researchers for providing poor qualitative insights that led to bad hypotheses.', false),
    (v_q_id, 'C', 'Suggest abandoning the checkout conversion goal entirely since it is clearly too hard to optimize further.', false),
    (v_q_id, 'D', 'Highlight micro-metric wins (like time-on-page) to pretend the tests were actually successful.', false);

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
        'Peloton''s Hardware/Software Sync',
        E'A PM at Peloton is building the software interface for a new treadmill. The software uses Agile sprints, while the hardware uses a strict Waterfall manufacturing timeline. The hardware team is confused by the software team''s changing roadmaps.\n\nHow should the PM bridge this communication gap?',
        'intermediate',
        'Peloton',
        'Peloton integrates complex physical hardware manufacturing with iterative software development.',
        'C',
        'Option C translates Agile concepts into physical milestones. Hardware teams need to know *when* APIs will be frozen so they can lock in physical components. Option A forces a bad process fit. Option B isolates teams. Option D slows down software unnecessarily.',
        ARRAY['cross_functional', 'process_translation', 'milestone_tracking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force the hardware team to adopt two-week Agile sprints so everyone is on the same cadence.', false),
    (v_q_id, 'B', 'Stop communicating with the hardware team until the software is 100% finished to avoid confusing them with iterations.', false),
    (v_q_id, 'C', 'Create a milestone-based integration document that maps software API freezes to hardware prototype lock dates.', true),
    (v_q_id, 'D', 'Switch the software team to a Waterfall process to match the hardware team''s comfort level.', false);

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
        'Stripe''s Board Deck Deprecation',
        E'A Stripe PM is preparing a slide for the Board of Directors regarding the deprecation of a legacy payment API. This API represents 2% of total volume but serves legacy enterprise clients.\n\nWhat is the most critical narrative for the Board level?',
        'advanced',
        'Stripe',
        'Stripe''s Board of Directors cares about long-term strategic leverage, enterprise risk, and margin expansion.',
        'B',
        'Option B hits exactly what a Board cares about: the strategic necessity (unlocking engineering velocity) paired with the risk mitigation plan for revenue. Option A is too technical for a board. Option C focuses on the wrong metric. Option D hides the truth from the board, which is a fireable offense.',
        ARRAY['executive_communication', 'strategic_alignment', 'board_presentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The specific technical architecture of the new API and how it uses GraphQL instead of REST.', false),
    (v_q_id, 'B', 'The engineering capacity unlocked for future growth, weighed against the churn risk, with a clear enterprise migration plan.', true),
    (v_q_id, 'C', 'A list of all the minor bugs in the legacy API to prove how bad the code had become.', false),
    (v_q_id, 'D', 'Downplaying the 2% volume entirely so the Board doesn''t ask difficult questions about churn.', false);

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
        'Airbnb''s Two-Sided Marketplace Change',
        E'Airbnb is shifting its fee structure. Instead of splitting the fee between Guest and Host, the entire fee will now be front-loaded to the Guest. \n\nHow must the PM orchestrate the external communication?',
        'advanced',
        'Airbnb',
        'Airbnb is a two-sided marketplace where changes to one side directly impact the behavior and trust of the other.',
        'D',
        'Option D handles the complexity of two-sided marketplaces. The core facts must be identical, but the value framing is tailored (Hosts hear about higher conversion, Guests hear about price transparency). Option A causes a PR disaster when they compare notes. Option B is lazy. Option C delays the inevitable.',
        ARRAY['external_communication', 'marketplace_dynamics', 'tailored_messaging']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell Hosts that Guests are paying more, and tell Guests that Hosts requested the change, to deflect blame.', false),
    (v_q_id, 'B', 'Write one generic press release and send the exact same link to both Hosts and Guests.', false),
    (v_q_id, 'C', 'Only communicate the change to Guests, since Hosts aren''t paying the fee anymore and won''t care.', false),
    (v_q_id, 'D', 'Ensure the factual mechanics are consistent, but tailor the value proposition: pitch price transparency to Guests, and pitch easier conversion to Hosts.', true);

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
        'Netflix''s Radical Candor',
        E'A Netflix PM notices their Engineering Manager (EM) consistently fails to update Jira, causing the PM to look foolish in cross-functional meetings. \n\nAligning with Netflix''s culture of radical candor, how should the PM deliver this feedback?',
        'advanced',
        'Netflix',
        'Netflix famously promotes "Radical Candor"—direct, actionable feedback given with positive intent.',
        'C',
        'Option C uses the SBI (Situation-Behavior-Impact) model. It focuses on observable behavior and its direct impact, avoiding personal attacks while being highly direct. Option A is aggressive and violates positive intent. Option B is passive-aggressive. Option D avoids the conflict entirely.',
        ARRAY['feedback', 'coaching', 'radical_candor', 'conflict_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Publicly call out the EM in the next team sync to ensure they feel the pressure to change.', false),
    (v_q_id, 'B', 'Complain to the EM''s director so management can deal with the performance issue.', false),
    (v_q_id, 'C', 'Privately state: "When tickets aren''t updated (behavior), I can''t answer questions in leadership meetings (impact), which makes our team look unaligned."', true),
    (v_q_id, 'D', 'Start updating Jira for the EM silently to ensure the team looks good without causing conflict.', false);

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
        'Figma''s M&A Integration Comms',
        E'Figma has just acquired a smaller whiteboarding startup. The PM is tasked with integrating the acquired team. The new engineers are anxious about their code being scrapped and their jobs.\n\nWhat is the most effective initial communication strategy?',
        'advanced',
        'Figma',
        'M&A (Mergers and Acquisitions) situations are characterized by high ambiguity and employee anxiety.',
        'A',
        'Option A builds trust through transparency. In M&A, you rarely have all the answers immediately. Acknowledging the ambiguity while providing a strict timeline for when answers will arrive reduces anxiety. Option B makes false promises. Option C asserts toxic dominance. Option D treats them like outsiders.',
        ARRAY['change_management', 'ambiguity', 'team_leadership']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Acknowledge the uncertainty, clearly state what decisions have not been made yet, and commit to a specific timeline for when roadmap decisions will occur.', true),
    (v_q_id, 'B', 'Promise them immediately that all of their code will be integrated into Figma to alleviate their anxiety.', false),
    (v_q_id, 'C', 'Establish dominance early by explaining that Figma''s architecture is superior and they will need to adapt quickly.', false),
    (v_q_id, 'D', 'Avoid addressing the acquisition directly and just start assigning them Jira tickets from the Figma backlog.', false);

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
        'Shopify''s Ecosystem Deprecation',
        E'A Shopify PM must announce the deprecation of an older inventory API. Over 4,000 third-party app developers use it, and the deprecation will break their apps if they don''t migrate within 6 months.\n\nWhat is the most comprehensive communication plan?',
        'advanced',
        'Shopify',
        'Shopify''s moat is its massive third-party developer ecosystem; breaking developer trust destroys the platform.',
        'B',
        'Option B is a masterclass in platform deprecation. It provides a long lead time, robust self-serve tools (migration guide), and high-touch support for power users (the top 50 apps) who represent the most ecosystem value. Option A lacks urgency until it''s too late. Option C is too abrupt. Option D creates manual chaos.',
        ARRAY['ecosystem_management', 'external_communication', 'deprecation_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send one email now, and another email 1 week before the cutoff to remind them.', false),
    (v_q_id, 'B', 'Publish a detailed migration guide, send a segmented email campaign, and proactively schedule 1:1s with the top 50 highest-volume apps.', true),
    (v_q_id, 'C', 'Shut off the API for 1 hour next week as a "scream test" to force developers to realize they need to migrate.', false),
    (v_q_id, 'D', 'Force developers to email support to get the new API keys so you can track exactly who is migrating.', false);

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
        'Uber''s Algorithmic Transparency',
        E'Uber is changing its driver dispatch algorithm to favor drivers with electric vehicles (EVs) in certain city zones. The PM must explain this to driver advocates and city regulators.\n\nHow should the PM explain the algorithmic change?',
        'advanced',
        'Uber',
        'Uber faces immense scrutiny regarding algorithmic fairness, labor relations, and municipal regulations.',
        'C',
        'Option C achieves "algorithmic transparency." You don''t expose proprietary code, but you clearly translate the inputs, weights, and behavioral incentives into human terms. Option A exposes IP and confuses the audience. Option B is opaque and builds mistrust. Option D is marketing fluff that avoids the core issue.',
        ARRAY['transparency', 'public_relations', 'algorithmic_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Publish the actual Python code and weighting formulas so regulators can see there is no manual bias.', false),
    (v_q_id, 'B', 'Refuse to explain how the algorithm works, citing trade secrets, and only share the final payout metrics.', false),
    (v_q_id, 'C', 'Abstract the math into clear behavioral principles: "If you drive an EV in Zone A, you are matched 20% faster," explaining the exact inputs.', true),
    (v_q_id, 'D', 'Use generic marketing language about "building a greener future together" and avoid mentioning the dispatch priority entirely.', false);

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
        'Slack''s Ghost Executive',
        E'A PM at Slack needs final sign-off from the VP of Product on a major UI overhaul. The VP is notorious for ignoring emails and skipping meetings, but will fiercely block launches if they haven''t approved them.\n\nWhat is the most effective communication tactic?',
        'advanced',
        'Slack',
        'Executives are extremely time-poor; PMs must sometimes force decisions while maintaining respect for authority.',
        'A',
        'Option A is the "Disagree and Commit" / "Default to Yes" strategy. By sending a decision memo with a deadline, the PM forces the executive''s hand without requiring them to do work. If they ignore it, the PM has documented permission to proceed. Option B causes indefinite delays. Option C is passive-aggressive. Option D assumes the worst and destroys trust.',
        ARRAY['managing_up', 'decision_making', 'executive_communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send a concise "Decision Memo" outlining the plan, stating: "If I don''t hear objections by Friday, we will begin development on Monday."', true),
    (v_q_id, 'B', 'Halt all engineering work until the VP eventually finds time to attend a review meeting.', false),
    (v_q_id, 'C', 'Escalate to the CEO that the VP is bottlenecking product development.', false),
    (v_q_id, 'D', 'Proceed with the launch secretly and ask for forgiveness later.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for communication';

END $$;
