-- ============================================
-- ASSESSMENT: Agile / Scrum
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
    WHERE slug = 'agile-scrum';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug agile-scrum not found. Run the seed data first.';
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
        'Spotify''s Backlog Refinement',
        'During a backlog refinement session, Spotify''s core audio PM is reviewing upcoming user stories. The engineering team points out that several backend services have accumulating technical debt that is slowing down deployments. How should the PM handle this technical debt within the Agile framework?',
        'foundational',
        'Spotify',
        'Audio streaming backend infrastructure',
        'C',
        'Option C is correct because Agile embraces continuous delivery of value, and technical debt directly impedes future value delivery. Bringing it into the product backlog makes work visible and allows for holistic prioritization. Option A is incorrect because "hidden" backlogs create transparency issues and risk developer burnout. Option B is incorrect because rigid percentage allocations ignore the fluctuating reality of business needs and system health. Option D is incorrect because the Product Owner must balance short-term feature delivery with long-term product viability, which requires proactively addressing technical debt.',
        ARRAY['backlog_refinement', 'technical_debt', 'prioritization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a separate "technical debt backlog" that engineers work on during their free time.', false),
    (v_q_id, 'B', 'Dedicate exactly 20% of every sprint exclusively to technical debt regardless of business goals.', false),
    (v_q_id, 'C', 'Work with engineering to create user stories for technical debt, estimate them, and prioritize them against new features in the single product backlog.', true),
    (v_q_id, 'D', 'Ignore it until a critical failure occurs, as the Product Owner''s sole responsibility is delivering new user-facing features.', false);

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
        'Slack''s Definition of Ready',
        'During Slack''s Sprint Planning, the team reviews a story to "Add reaction animations to messages." An engineer notes that the exact animations haven''t been designed yet, and the edge cases for mobile aren''t documented. What should the PM do?',
        'foundational',
        'Slack',
        'Core messaging experience',
        'B',
        'Option B is correct. The Definition of Ready (DoR) is a working agreement that ensures user stories have enough clarity, context, and dependencies resolved before development begins. Pulling in a story without designs violates this and guarantees mid-sprint bottlenecks. Option A is a poor practice because assigning inflated points for pure uncertainty masks missing requirements. Options C and D are wrong because they circumvent the team''s quality standards and introduce unstructured design work into an execution phase, disrupting predictability.',
        ARRAY['definition_of_ready', 'sprint_planning', 'user_stories']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Assign the story 13 points to account for the uncertainty and pull it into the sprint anyway.', false),
    (v_q_id, 'B', 'Send the story back to the backlog because it does not meet the Definition of Ready.', true),
    (v_q_id, 'C', 'Pull the story into the sprint and let the engineer design the animations themselves.', false),
    (v_q_id, 'D', 'Break the story into two: one for designing the animations and one for building them, both in the same sprint.', false);

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
        'Airbnb''s Daily Standup',
        'Fifteen minutes into an Airbnb team''s Daily Scrum, two engineers are engaged in a deep debate about whether to use GraphQL or REST for a new booking API. The other six team members are quietly waiting. What is the most appropriate action for the Scrum Master or PM to take?',
        'foundational',
        'Airbnb',
        'Booking API infrastructure',
        'B',
        'Option B is correct. The Daily Scrum is a 15-minute timeboxed event meant for synchronization and identifying blockers, not for deep problem-solving. Pausing the deep-dive and taking it to a "parking lot" allows the rest of the team to sync without wasting their time. Option A is wrong because it disrespects the timebox and the rest of the team''s schedule. Option C is wrong because the Scrum Master/PM should facilitate the process, not unilaterally dictate technical architecture decisions. Option D is an overreaction that defeats the primary purpose of the daily sync.',
        ARRAY['daily_scrum', 'facilitation', 'agile_ceremonies']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Wait patiently for the engineers to resolve the issue, as technical decisions are critical to sprint success.', false),
    (v_q_id, 'B', 'Pause the discussion, suggest they take it to a "parking lot" immediately after standup, and move to the next person.', true),
    (v_q_id, 'C', 'Make an executive decision to use GraphQL so the meeting can conclude.', false),
    (v_q_id, 'D', 'Cancel the rest of the standup and schedule a 2-hour architecture review meeting.', false);

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
        'Notion''s Definition of Done',
        'At the end of a sprint, a Notion engineering team demonstrates a new "Table Sorting" feature during the Sprint Review. The code is written and works locally, but it hasn''t been merged to the main branch or tested by QA. How should the PM categorize this work?',
        'foundational',
        'Notion',
        'Table database features',
        'C',
        'Option C is correct because Scrum mandates that work must meet the team''s Definition of Done (DoD) to be considered complete. Since the DoD almost always includes QA testing and merging to main, the story is incomplete and yields zero velocity for the sprint. Option A is wrong because a local demo does not guarantee production readiness. Option B is a common anti-pattern; in Agile, points are generally binary (done or not done) to prevent the accumulation of "almost done" technical debt. Option D is wrong because QA testing should be integrated within the original story''s vertical slice.',
        ARRAY['definition_of_done', 'sprint_review', 'velocity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the story as complete, since the functionality was successfully demonstrated.', false),
    (v_q_id, 'B', 'Mark it as 80% complete and carry over the remaining 20% of the points to the next sprint.', false),
    (v_q_id, 'C', 'Consider the story not done, carry it over to the next sprint backlog, and do not count its points toward the current sprint''s velocity.', true),
    (v_q_id, 'D', 'Accept the story but secretly create a new "QA Testing" story for the next sprint.', false);

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
        'Uber''s Sprint Retrospective',
        'An Uber driver app team has missed their sprint commitment for the third sprint in a row. During the Sprint Retrospective, the team is quiet and hesitant to speak up. How should the PM or Scrum Master approach this?',
        'foundational',
        'Uber',
        'Driver app team',
        'C',
        'Option C is correct. The Sprint Retrospective must be a safe space to identify systemic and process issues, focusing on "how" the team works rather than assigning individual blame. Running a blameless root cause analysis aligns with Agile principles of continuous improvement and psychological safety. Option A destroys psychological safety and will cause developers to hide future issues. Option B ignores a critical Agile feedback loop; skipping ceremonies when morale is low only compounds underlying problems. Option D violates self-organization, as PMs cannot mandate arbitrary velocity increases without addressing capacity or process constraints.',
        ARRAY['sprint_retrospective', 'continuous_improvement', 'team_dynamics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Demand that the engineering manager hold the underperforming developers accountable.', false),
    (v_q_id, 'B', 'Skip the retrospective since morale is low and let the team rest.', false),
    (v_q_id, 'C', 'Run a "blameless" root cause analysis exercise, focusing on processes and bottlenecks rather than individual failures.', true),
    (v_q_id, 'D', 'Tell the team they are underperforming and mandate a mandatory 10% velocity increase for the next sprint.', false);

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
        'Netflix''s Story Estimation',
        'A new Netflix PM joins a team and notices they are estimating user stories in hours (e.g., "This story will take 14 hours"). The PM wants to transition the team to using story points. What is the primary benefit of using story points over hours?',
        'foundational',
        'Netflix',
        'Platform engineering team',
        'A',
        'Option A is correct. Story points represent a relative measure of complexity, effort, and risk, rather than absolute time. This abstracts away the differing skill levels of developers—a senior and junior developer might take different amounts of time to complete a task, but they can agree on its relative complexity. Option B is incorrect and unethical; PMs should not use secret metrics. Option C is a fallacy; story points do not guarantee faster delivery, they just improve predictability. Option D is incorrect because the Scrum Guide actually does not strictly mandate story points; it only requires that work is "sized", leaving the specific method up to the team.',
        ARRAY['story_points', 'estimation', 'relative_sizing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Story points account for complexity, risk, and effort, accommodating different skill levels across developers better than absolute time estimates.', true),
    (v_q_id, 'B', 'Story points allow the PM to secretly calculate exact launch dates without telling stakeholders.', false),
    (v_q_id, 'C', 'Story points guarantee that the team will deliver faster.', false),
    (v_q_id, 'D', 'Story points are a mandatory requirement of the Scrum Guide, whereas estimating in hours violates Scrum rules.', false);

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
        'Shopify''s Sprint Goal',
        'Mid-way through a 2-week sprint at Shopify, the VP of Sales asks the PM to urgently add a minor customization to the checkout page for a specific VIP merchant. It would take a developer about two days. What is the most Agile approach?',
        'foundational',
        'Shopify',
        'Checkout experience',
        'C',
        'Option C is correct. While Agile is flexible, the Sprint Goal is meant to be protected to allow the team focus. The PM must evaluate if the new request endangers the current sprint commitment. If it does, negotiating it into the next sprint is the proper boundary-setting technique. Option A disrupts the team and violates sprint boundaries without assessment. Option B is too rigid; Scrum allows the sprint backlog to change if the Product Owner and Developers agree it doesn''t endanger the Sprint Goal. Option D is incorrect because sprint timeboxes (e.g., 2 weeks) are strictly fixed to maintain cadence.',
        ARRAY['sprint_backlog', 'sprint_goal', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately pull a developer off their current work to build the customization.', false),
    (v_q_id, 'B', 'Say no, as the sprint backlog is entirely immutable under all circumstances.', false),
    (v_q_id, 'C', 'Evaluate if the request endangers the current Sprint Goal; if yes, negotiate adding it to the next sprint backlog instead of disrupting the current sprint.', true),
    (v_q_id, 'D', 'Extend the current sprint by two days to accommodate the new request.', false);

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
        'Figma''s Scrum Roles',
        'At Figma, the Engineering Manager often steps in to write user stories, prioritize the backlog, and define acceptance criteria when the PM is busy. According to Scrum principles, what risk does this create?',
        'foundational',
        'Figma',
        'Core editor team',
        'A',
        'Option A is correct. In Scrum, the Product Owner (usually the PM in tech companies) is solely responsible for maximizing the value of the product and managing the Product Backlog. When an EM takes this over, the focus often shifts from customer value to technical convenience, risking misalignment with business goals. Option B is incorrect; Engineering Managers can attend ceremonies as stakeholders, though they shouldn''t interfere with self-organization. Option C is wrong because role clarity is vital in Scrum. Option D is an HR concern, not a Scrum principle.',
        ARRAY['scrum_roles', 'product_owner', 'backlog_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It creates an anti-pattern where the Product Owner role is diluted, potentially leading to misalignment between business value and what the team builds.', true),
    (v_q_id, 'B', 'It violates the rule that Engineering Managers are not allowed to attend Scrum ceremonies.', false),
    (v_q_id, 'C', 'None; this is an ideal implementation of a cross-functional Agile team.', false),
    (v_q_id, 'D', 'It risks the Engineering Manager getting promoted over the PM.', false);

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
        'Discord''s Epic Breakdown',
        'A PM at Discord creates a single Jira ticket titled "Implement Voice Channels in Web App" and assigns it 100 story points, expecting the team to complete it over three sprints. What Agile principle is being violated?',
        'foundational',
        'Discord',
        'Web application team',
        'B',
        'Option B is correct. A core rule of sprint execution is that any work brought into a sprint must be sized appropriately to be completed within that single timebox. A 100-point Epic spanning multiple sprints cannot be effectively tracked, tested, or delivered incrementally. It must be broken down into smaller, vertically-sliced user stories. Option A is a fabricated rule; Epics don''t have minimum point values. Option C makes assumptions about organizational structure that Agile doesn''t mandate. Option D is backwards; story points are primarily used for new features, while bugs are often left unpointed.',
        ARRAY['epics', 'user_stories', 'work_breakdown']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Epics should always be assigned a minimum of 200 points.', false),
    (v_q_id, 'B', 'Work brought into a sprint must be broken down into user stories small enough to be completed within a single sprint.', true),
    (v_q_id, 'C', 'Voice channels should be built by a separate specialized team, not the web app team.', false),
    (v_q_id, 'D', 'Story points should only be applied to bugs, not new features.', false);

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
        'GitHub''s Velocity Constraints',
        E'GitHub''s Enterprise team completed the following story points over the last three sprints:\n\n| Sprint | Points |\n|--------|--------|\n| 41     | 35     |\n| 42     | 42     |\n| 43     | 38     |\n\nDuring planning for Sprint 44, the team only commits to 25 points because two developers will be attending a conference. The PM is upset because this lowers the team''s average velocity. How should the PM handle this?',
        'foundational',
        'GitHub',
        'Enterprise features',
        'B',
        'Option B is correct. Velocity is a lagging indicator and a capacity planning tool, not a performance target. When team capacity decreases (due to PTO, conferences, etc.), the expected velocity must decrease proportionately. Option A is setting the team up for guaranteed failure by ignoring reality. Option C treats developers as feature factories and ignores continuous learning, which hurts the team long-term. Option D is metric manipulation and destroys the integrity of Agile reporting.',
        ARRAY['velocity', 'capacity_planning', 'sprint_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force the team to commit to 38 points to maintain the average velocity.', false),
    (v_q_id, 'B', 'Accept the 25-point commitment, understanding that velocity is a capacity planning tool, not a performance target.', true),
    (v_q_id, 'C', 'Cancel the developers'' conference attendance to ensure maximum feature output.', false),
    (v_q_id, 'D', 'Log 13 fake points in Jira to keep the velocity chart looking consistent for leadership.', false);

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
        'Zoom''s Production Incident',
        'On day 3 of a 14-day sprint, Zoom experiences a critical P0 bug where users on Mac cannot share their screens. The fix requires the immediate attention of two developers on the Scrum team. How should the PM manage the sprint?',
        'intermediate',
        'Zoom',
        'Desktop client team',
        'C',
        'Option C is correct. Agile relies on adapting to reality. When an emergency injects new work into the sprint, the team''s capacity is consumed. To maintain a sustainable pace and protect the Sprint Goal as much as possible, lower-priority sprint items must be removed or swapped out. Option A leads to burnout and missed commitments because it ignores the reality of fixed capacity. Option B is an overreaction; sprints should only be cancelled if the Sprint Goal becomes completely obsolete. Option D is unacceptable product management, as critical user issues supersede artificial sprint boundaries.',
        ARRAY['sprint_backlog', 'incident_management', 'capacity_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add the P0 bug to the sprint backlog without removing any existing stories, as the team must work overtime to meet their original commitment.', false),
    (v_q_id, 'B', 'Stop the entire sprint, fix the bug, and restart Sprint Planning from scratch.', false),
    (v_q_id, 'C', 'Add the bug to the sprint, and work with the team to identify which lower-priority sprint backlog items must be removed to accommodate the emergency work.', true),
    (v_q_id, 'D', 'Tell customer support that the team is doing Scrum and cannot fix the bug until the next sprint starts.', false);

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
        'Stripe''s Scope Creep',
        'A Stripe PM is managing a feature to "Support Apple Pay in the Web SDK." During development, the team realizes they forgot to account for 3D Secure authentication, which will double the effort required. The story is currently in the active sprint. What is the best course of action?',
        'intermediate',
        'Stripe',
        'Web SDK team',
        'C',
        'Option C is correct. When new, substantial scope is discovered mid-sprint, it should be treated as new work. Splitting it out makes the work visible, allows the team to re-estimate, and forces a prioritization conversation (swap it with something else or move to next sprint). Option A results in technical debt and a poor user experience. Option B is "dark work" that hides scope creep, ruining velocity tracking and exhausting the team. Option D delivers negative business value, as a broken payment integration violates Stripe''s core promise of reliability.',
        ARRAY['scope_creep', 'user_stories', 'agile_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask developers to rush and build a quick, hardcoded version of 3D Secure to meet the sprint deadline.', false),
    (v_q_id, 'B', 'Quietly add the 3D Secure requirements to the acceptance criteria of the existing story without changing the points.', false),
    (v_q_id, 'C', 'Flag the scope change immediately, split out the 3D Secure requirement into a new story, and either swap it for other sprint items or move it to the next sprint.', true),
    (v_q_id, 'D', 'Let the engineers finish the Apple Pay integration without 3D Secure, pushing the broken feature to production to maintain velocity.', false);

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
        'Duolingo''s Estimation Disagreement',
        'During Sprint Planning at Duolingo, the team is using Planning Poker to estimate a story to "Add a streak freeze widget to the home screen." A junior developer estimates it at 8 points, while a senior developer estimates it at 2 points. What should the PM or Scrum Master facilitate next?',
        'intermediate',
        'Duolingo',
        'Growth and gamification',
        'C',
        'Option C is correct. The primary value of Planning Poker is not the number generated, but the conversation it provokes. Large discrepancies usually indicate that one person sees a risk the other missed, or one person misunderstands the requirements. Option A prematurely truncates this valuable discovery process. Option B defeats the purpose of team estimation and assumes the senior developer is infallible. Option D is punitive and creates a toxic culture, violating Agile''s core tenet of psychological safety.',
        ARRAY['estimation', 'planning_poker', 'team_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Take the average (5 points) and move on to save time.', false),
    (v_q_id, 'B', 'Defer entirely to the senior developer since they will likely do the work anyway.', false),
    (v_q_id, 'C', 'Ask the senior developer and junior developer to explain their reasoning to uncover hidden assumptions or risks, then re-estimate.', true),
    (v_q_id, 'D', 'Assign the story to the junior developer to punish them for overestimating.', false);

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
        'DoorDash''s Kanban Shift',
        'The DoorDash Merchant Platform team spends 80% of their time handling urgent production support tickets and minor configuration changes. They frequently fail their 2-week Scrum sprints because planned work is constantly interrupted. What Agile pivot should the PM recommend?',
        'intermediate',
        'DoorDash',
        'Merchant operations support',
        'B',
        'Option B is correct. Scrum is designed for teams that can isolate themselves from interruptions for a timeboxed period to focus on feature development. When a team''s primary function is reactive support (where SLA response times matter more than batching work), Kanban is the superior framework. Kanban focuses on continuous flow and Work In Progress (WIP) limits rather than artificial timeboxes. Option A punishes developers for a systemic structural issue. Option C worsens the problem; longer sprints mean even more unpredictability. Option D ignores the business reality that production issues must be resolved.',
        ARRAY['kanban', 'scrum', 'process_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Implement a penalty system for developers who don''t finish their sprint work.', false),
    (v_q_id, 'B', 'Transition from Scrum to Kanban, using WIP (Work in Progress) limits and continuous flow instead of timeboxed sprints.', true),
    (v_q_id, 'C', 'Lengthen the sprints to 4 weeks to give the team more time to absorb interruptions.', false),
    (v_q_id, 'D', 'Stop fixing production bugs altogether to protect the sprint integrity.', false);

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
        'Robinhood''s Horizontal Slicing',
        'A Robinhood PM writes a set of user stories for a new portfolio graph: 1) "Design DB schema", 2) "Build backend API", 3) "Build iOS UI." At the end of the sprint, the database and API are done, but the UI isn''t. The user gets no value. What Agile anti-pattern did the PM fall into?',
        'intermediate',
        'Robinhood',
        'Mobile app portfolio view',
        'A',
        'Option A is correct. The PM engaged in "horizontal slicing"—structuring work by technical layers rather than user value. Agile advocates for "vertical slicing," where a user story encompasses a thin slice of all layers (DB, API, UI) so that completing the story delivers testable, usable value to the end user. Option B is a symptom, but the structural flaw is the slicing method. Option C refers to a prioritization framework, which doesn''t fix the structural breakdown of the work. Option D is irrelevant because the schema was successfully completed.',
        ARRAY['user_stories', 'vertical_slicing', 'value_delivery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Horizontal slicing—breaking down work by architectural layer instead of delivering vertical slices of end-to-end user value.', true),
    (v_q_id, 'B', 'Under-estimating the UI engineering capacity.', false),
    (v_q_id, 'C', 'Failing to use the MoSCoW prioritization framework.', false),
    (v_q_id, 'D', 'Missing the Definition of Ready for the database schema.', false);

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
        'Peloton''s Burndown Analysis',
        E'A PM looks at Peloton''s sprint burndown chart for a 10-day sprint. The remaining effort logs look like this:\n\n| Day | Remaining Points |\n|-----|------------------|\n| 1   | 40               |\n| 4   | 40               |\n| 8   | 40               |\n| 9   | 20               |\n| 10  | 0                |\n\nWhat does this pattern most likely indicate?',
        'intermediate',
        'Peloton',
        'Leaderboard features',
        'B',
        'Option B is correct. A burndown chart that stays flat and drops massively at the end is a classic "waterfall-within-a-sprint" anti-pattern. It indicates that developers are keeping work in progress for the entire sprint and only integrating/testing on the last day, creating massive risk and a QA bottleneck. A healthy burndown should slope downwards continuously as small stories are completed incrementally. Option A is false; while they finished, the process was highly risky. Option C is unrelated to burndown shapes. Option D misinterprets the chart; velocity isn''t increasing, work is just batching up.',
        ARRAY['burndown_chart', 'agile_metrics', 'bottlenecks']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The team is highly efficient and finishes work exactly on time.', false),
    (v_q_id, 'B', 'Stories are too large, or developers are keeping work "in progress" without merging incrementally, creating a QA bottleneck.', true),
    (v_q_id, 'C', 'The Scrum Master is doing a great job protecting the team from scope creep.', false),
    (v_q_id, 'D', 'The team''s velocity is increasing exponentially.', false);

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
        'Tinder''s Partial Completion',
        'A 13-point story to "Add Super Like animations" on Tinder is about 90% complete at the end of the sprint. The code is written but failed one edge-case QA test. How should the points be handled?',
        'intermediate',
        'Tinder',
        'Core swiping mechanics',
        'C',
        'Option C is correct. In Agile methodologies, story points are generally binary—a story is either Done or Not Done. Giving partial credit creates a false sense of velocity and obscures the fact that no actual value was delivered to the user. The uncompleted story should roll over to the next sprint, where it will be finished and the full points claimed. Option A and B inflate velocity with phantom progress. Option D creates administrative overhead and decouples the bug from its original context.',
        ARRAY['velocity', 'definition_of_done', 'spillover']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Award the team 11 points (90%) for the current sprint and roll over 2 points.', false),
    (v_q_id, 'B', 'Count all 13 points in the current sprint to keep morale high, since it''s almost done.', false),
    (v_q_id, 'C', 'Count 0 points for the current sprint, move the story to the next sprint, and complete it there.', true),
    (v_q_id, 'D', 'Close the story, open a new "Bug fix" story for 13 points in the next sprint.', false);

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
        'Pinterest''s Vague Acceptance Criteria',
        'A Pinterest PM writes a story: "As a user, I want search to be fast, so I can find pins quickly." The engineers build a caching layer that improves speed by 5%, but the PM expected sub-200ms latency. What should the PM have done differently?',
        'intermediate',
        'Pinterest',
        'Search infrastructure',
        'B',
        'Option B is correct. Acceptance Criteria (AC) represent the boundaries of a user story and determine when it is complete. "Fast" is subjective and untestable. A PM must provide quantitative, verifiable conditions so engineers know exactly what target they are hitting. Option A is unnecessary; PMs do not need to dictate the technical implementation, only the outcome. Option C is an anti-pattern; story points measure effort, not priority or importance. Option D is toxic and shifts blame for the PM''s own poorly written requirements.',
        ARRAY['acceptance_criteria', 'user_stories', 'quality']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Written the story entirely in technical jargon so the engineers took it seriously.', false),
    (v_q_id, 'B', 'Included quantitative, testable Acceptance Criteria (e.g., "Search results render in < 200ms at the 95th percentile").', true),
    (v_q_id, 'C', 'Assigned 21 story points instead of 5 to signal importance.', false),
    (v_q_id, 'D', 'Escalated the engineers to their manager for poor performance.', false);

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
        'Salesforce''s Missing QA Capacity',
        E'A Salesforce Scrum team consists of 5 developers and 1 QA engineer. During planning, the PM reviews capacity:\n\n| Role      | Count | Points/Person | Total Capacity |\n|-----------|-------|---------------|----------------|\n| Developer | 5     | 10            | 50             |\n| QA        | 1     | 10            | 10             |\n\nThe PM commits to 50 points of work. By sprint end, developers finish coding all 50 points, but only 10 points pass QA. What went wrong?',
        'intermediate',
        'Salesforce',
        'CRM frontend team',
        'B',
        'Option B is correct. A team''s overall throughput is limited by its narrowest bottleneck—in this case, QA capacity. The PM committed to 50 points of development work but ignored that the system only had the capacity to test 10 points. Agile capacity planning must account for the full lifecycle of a story (development + testing). Option A unfairly blames the QA engineer for a mathematical impossibility. Option C violates the Definition of Done and sacrifices quality. Option D is incorrect; while Scrum encourages cross-functional skills, having a QA specialist is not strictly forbidden.',
        ARRAY['capacity_planning', 'bottlenecks', 'cross_functional_teams']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The QA engineer is underperforming and should be put on a PIP.', false),
    (v_q_id, 'B', 'The PM failed to balance QA capacity, committing to more development work than could be tested.', true),
    (v_q_id, 'C', 'The team should have skipped QA testing to ensure they met the sprint commitment.', false),
    (v_q_id, 'D', 'Scrum strictly forbids having specialized QA roles, so the team structure is invalid.', false);

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
        'HubSpot''s Cross-Team Dependency',
        'HubSpot Team A is building a new marketing dashboard, but they cannot finish their 8-point story until Team B updates an internal API. Team B says they will update the API "sometime next sprint." How should Team A''s PM handle this during planning?',
        'intermediate',
        'HubSpot',
        'Marketing dashboard team',
        'B',
        'Option B is correct. A core rule of Sprint Planning is that stories must be independent and actionable. Pulling a blocked story into an active sprint guarantees that it will sit in "Waiting" status, creating artificial spillover and frustrating the team. It should remain in the backlog until the dependency is fully resolved. Option A relies on hope, which is not a strategy. Option C violates team boundaries and introduces technical risk. Option D ruins velocity metrics and still leaves the story blocked.',
        ARRAY['dependencies', 'sprint_planning', 'backlog_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pull the 8-point story into the current sprint and hope Team B finishes early.', false),
    (v_q_id, 'B', 'Mark the story as blocked and leave it in the product backlog until Team B has actually deployed the API update.', true),
    (v_q_id, 'C', 'Force Team A''s engineers to hack into Team B''s codebase and make the change themselves.', false),
    (v_q_id, 'D', 'Commit to the story but give it 0 points since Team B is doing the hard work.', false);

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
        'Canva''s Release Confusion',
        'A Canva marketing manager is upset because a feature was marked "Done" at the end of the sprint, but it isn''t available to users in production yet. What Agile concept does the marketing manager misunderstand?',
        'intermediate',
        'Canva',
        'Design templates team',
        'A',
        'Option A is correct. "Done" in Scrum means the work meets the team''s Definition of Done and is a potentially releasable increment. "Released" is a business decision regarding when to actually expose that code to end-users (e.g., via feature flags or coordinated launch dates). The two are decoupled in modern software development. Option B is a capacity planning concept, not a deployment one. Option C relates to team facilitation. Option D is a backlog organization concept.',
        ARRAY['definition_of_done', 'release_management', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The difference between "Done" (meeting sprint criteria, potentially releasable) and "Released" (actually deployed to end-users).', true),
    (v_q_id, 'B', 'The difference between team Velocity and individual Capacity.', false),
    (v_q_id, 'C', 'The role of the Scrum Master in enforcing deployment pipelines.', false),
    (v_q_id, 'D', 'The difference between Epics and Themes.', false);

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
        'LinkedIn''s Agile MVP',
        'A LinkedIn PM defines an MVP for a new "Creator Mode" consisting of 15 complex user stories. The PM insists that nothing can be released until all 15 stories are completed across four sprints. What Agile principle is being compromised?',
        'intermediate',
        'LinkedIn',
        'Creator ecosystem',
        'A',
        'Option A is correct. A fundamental principle of Agile is delivering working software frequently to gather early user feedback. By holding back 15 stories across two months, the PM is employing a Waterfall approach, risking building the wrong thing without market validation. Option B is a myth; MVPs are defined by value, not an arbitrary sprint limit. Option C is similarly fabricated; there is no numerical limit on MVP stories. Option D is an XP engineering practice, unrelated to product release strategy.',
        ARRAY['mvp', 'iterative_delivery', 'agile_principles']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The principle of delivering working software frequently to gather early user feedback.', true),
    (v_q_id, 'B', 'The requirement that MVPs must be built in exactly one sprint.', false),
    (v_q_id, 'C', 'The rule that an MVP can only consist of 5 user stories.', false),
    (v_q_id, 'D', 'The practice of pair programming.', false);

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
        'Amazon''s Mandated Velocity',
        'An Amazon leadership team demands that a Scrum team increase their velocity by 10% every sprint to show "continuous improvement." What is the most likely negative consequence of this mandate?',
        'intermediate',
        'Amazon',
        'Logistics software team',
        'B',
        'Option B is correct. When velocity—a relative, team-calibrated metric—is weaponized as a performance target (Goodhart''s Law), teams will naturally engage in "point inflation." They will assign 8 points to a task that used to be 5 points just to meet the mandated numbers, rendering the metric useless for actual capacity planning. Option A is unrealistic; human productivity does not scale infinitely. Option C is wrong; teams usually relax the Definition of Done to move faster, hurting quality. Option D is a non-sequitur.',
        ARRAY['velocity', 'agile_anti_patterns', 'metrics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The team will work 10% faster with no drop in quality.', false),
    (v_q_id, 'B', 'The team will engage in "point inflation," artificially assigning higher point values to the same work.', true),
    (v_q_id, 'C', 'The Definition of Done will naturally become stricter.', false),
    (v_q_id, 'D', 'The team will transition to Kanban automatically.', false);

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
        'Atlassian''s Mid-Sprint Priority Change',
        'On day 2 of a sprint, Jira''s PM realizes a major competitor just launched a highly requested feature. The PM bursts into the team room and demands they drop their current sprint goal to copy the competitor''s feature immediately. What is the Scrum Master''s role here?',
        'intermediate',
        'Atlassian',
        'Jira core product team',
        'B',
        'Option B is correct. The Scrum Master serves to protect the team from mid-sprint disruptions. The proper protocol is for the PM to add the new requirement to the backlog for the next sprint. If the business priority is truly an existential crisis, the PM has the authority to officially cancel the sprint, but they cannot simply hijack active sprint work on a whim. Option A is an HR overreach. Option C violates sprint integrity and predictability. Option D is an SAFe artifact that doesn''t apply to standard agile sprint protocols.',
        ARRAY['scrum_master', 'sprint_cancellation', 'protecting_the_team']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fire the PM for interfering with the development team.', false),
    (v_q_id, 'B', 'Protect the team''s focus by asking the PM to add the feature to the backlog, or explicitly cancel the sprint if it''s an existential priority.', true),
    (v_q_id, 'C', 'Instantly oblige and re-assign all developers to the new feature.', false),
    (v_q_id, 'D', 'Tell the PM they must wait 6 months for the next PI planning cycle.', false);

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
        'Booking.com''s External Vendor',
        'Booking.com hires an external agency to build a standalone promo site. The agency insists on a fixed-price, fixed-scope, and fixed-timeline contract, requiring full designs upfront. How does this conflict with Agile software development?',
        'intermediate',
        'Booking.com',
        'Marketing engineering',
        'A',
        'Option A is correct. Agile frameworks are fundamentally empirical, assuming that requirements will change as more is learned during development. A contract locking in time, budget, and scope upfront represents a classic Waterfall approach (the "Iron Triangle" of project management), completely eliminating the flexibility required to be Agile. Option B is overly prescriptive; Agile doesn''t mandate daily deployments. Option C is false; Agile teams frequently use contractors. Option D is false; Agile does not dictate payment structures.',
        ARRAY['agile_manifesto', 'contracts', 'waterfall_vs_agile']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agile embraces changing requirements and iterative discovery, which fixed-scope contracts explicitly prevent.', true),
    (v_q_id, 'B', 'Agile requires daily deployments, which agencies cannot do.', false),
    (v_q_id, 'C', 'Agile forbids the use of external contractors.', false),
    (v_q_id, 'D', 'Agile requires paying developers by the hour, not a fixed price.', false);

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
        'WhatsApp''s Meaningless Retrospectives',
        'In WhatsApp''s team retrospectives, the team consistently brings up "flaky CI/CD pipelines" as a pain point. However, for five sprints in a row, nothing has changed, and the team is becoming cynical. What is the PM/Scrum Master failing to do?',
        'intermediate',
        'WhatsApp',
        'Platform infrastructure',
        'B',
        'Option B is correct. A retrospective is only valuable if it leads to tangible change. When teams complain without action, retrospectives devolve into mere venting sessions. The Scrum Master and PM must ensure that process improvements are translated into actionable, assigned tasks and injected directly into the next sprint backlog so they actually get done. Option A is purely administrative and doesn''t solve the problem. Option C is hostile and destructive. Option D addresses the format of the meeting, but not the failure of execution.',
        ARRAY['sprint_retrospective', 'continuous_improvement', 'actionable_feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They are failing to document the complaints in Confluence.', false),
    (v_q_id, 'B', 'They are failing to create concrete, assigned action items and pulling them into the next sprint''s backlog.', true),
    (v_q_id, 'C', 'They are failing to report the complaining engineers to HR.', false),
    (v_q_id, 'D', 'They are failing to change the retrospective format to a "Starfish" model.', false);

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
        'Reddit''s Over-Capacity Planning',
        'Reddit''s community moderation team has an average velocity of 40 points. During planning, the PM calculates that a critical feature totals 55 points. To meet a management deadline, the PM pressures the team to commit to all 55 points. What is the most likely outcome?',
        'intermediate',
        'Reddit',
        'Community moderation tools',
        'B',
        'Option B is correct. Forcing a team to overcommit beyond their historical capacity usually results in developers taking shortcuts, skipping tests, and accumulating technical debt. Ultimately, the team will still likely fail to hit the 55-point target, which destroys trust with management and damages team morale. Option A is a naive "hustle culture" myth. Option C reflects a misunderstanding of Scrum; the framework doesn''t automatically adjust anything, it relies on human discipline. Option D assumes a level of predictable mutiny that isn''t guaranteed, though morale will drop.',
        ARRAY['capacity_planning', 'agile_anti_patterns', 'sustainable_pace']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The team will rise to the challenge, deliver 55 points, and permanently increase their velocity.', false),
    (v_q_id, 'B', 'Quality will drop, technical debt will accrue, and the team will likely still fail to deliver the 55 points.', true),
    (v_q_id, 'C', 'The Scrum framework will automatically adjust the points to 40.', false),
    (v_q_id, 'D', 'The team will finish the 55 points but refuse to work the next sprint.', false);

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
        'Dropbox''s Hidden Work',
        'A Dropbox engineer frequently takes on direct requests from the Customer Success team to run custom database queries. These take up about 10 hours a week but are not tracked in Jira or discussed in Scrum ceremonies. How does this impact the team?',
        'intermediate',
        'Dropbox',
        'Enterprise administration',
        'B',
        'Option B is correct. Work that circumvents the backlog and sprint planning is known as "dark work" or "invisible work." Because it consumes capacity but isn''t tracked, the team''s velocity metrics become inaccurate, making future sprint commitments unreliable and obscuring the true cost of supporting the Customer Success team. Option A ignores the negative operational impact on the product team. Option C is a joke answer. Option D is incorrect; Kanban also requires work visibility.',
        ARRAY['dark_work', 'velocity', 'transparency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It''s highly beneficial as it keeps the Customer Success team happy.', false),
    (v_q_id, 'B', 'It creates "dark work" that distorts the team''s true velocity, making sprint commitments unreliable.', true),
    (v_q_id, 'C', 'It proves the engineer is ready to become a Product Manager.', false),
    (v_q_id, 'D', 'It validates that the team is successfully using Kanban.', false);

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
        'Spotify''s Forecasting Dilemma',
        E'Spotify''s PM needs to forecast a launch date for a 200-point Epic. The team''s velocity over the last 5 sprints has been highly variable:\n\n| Sprint | Velocity |\n|--------|----------|\n| 1      | 22       |\n| 2      | 45       |\n| 3      | 18       |\n| 4      | 50       |\n| 5      | 25       |\n\nThe VP of Product wants a guaranteed launch date. How should a senior PM handle this high-variance forecasting?',
        'advanced',
        'Spotify',
        'Podcast discovery team',
        'C',
        'Option C is correct. When velocity exhibits high variance, deterministic forecasting (using a simple average to provide a single date) is statistically invalid and dangerous. A senior PM should use a probabilistic forecast, such as a cone of uncertainty, providing a date range based on pessimistic and optimistic scenarios, while managing stakeholder expectations. Option A gives a false sense of precision. Option B is disastrously reckless. Option D halts business value delivery entirely to satisfy a metric constraint.',
        ARRAY['forecasting', 'velocity', 'cone_of_uncertainty']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Average the velocity (32 points) and promise launch in exactly 7 sprints.', false),
    (v_q_id, 'B', 'Use the highest velocity (50) to show an optimistic timeline of 4 sprints to keep the VP happy.', false),
    (v_q_id, 'C', 'Acknowledge the high variance, refuse a single date, and provide a probabilistic forecast (cone of uncertainty).', true),
    (v_q_id, 'D', 'Stop the team from working until their velocity stabilizes to exactly 30 points per sprint.', false);

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
        'Shopify''s Multi-Team Scaling',
        'Four different Scrum teams at Shopify are working on a massive overhaul of the global checkout system. They frequently step on each other''s code, causing merge conflicts, and integration testing is a nightmare. What Agile scaling practice should the PMs implement?',
        'advanced',
        'Shopify',
        'Global checkout rewrite',
        'B',
        'Option B is correct. When scaling Agile across multiple interdependent teams, alignment is the biggest risk. A "Scrum of Scrums" provides a scaled daily/weekly sync for representatives from each team to discuss cross-team dependencies and integration points, effectively managing the architectural overlaps. Option A violates the Scrum rule of maintaining small, nimble teams (typically 3-9 people); 35 people is unmanageable. Option C introduces hard handoffs and silos, destroying team autonomy. Option D abandons Agile principles completely.',
        ARRAY['scaled_agile', 'dependencies', 'scrum_of_scrums']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Disband the four teams and create one massive 35-person Scrum team.', false),
    (v_q_id, 'B', 'Implement regular "Scrum of Scrums" meetings, establish cross-team alignment, and prioritize integration points.', true),
    (v_q_id, 'C', 'Have Team 1 write the code, Team 2 test it, Team 3 deploy it, and Team 4 monitor it.', false),
    (v_q_id, 'D', 'Switch entirely to Waterfall, as Agile cannot handle more than one team working on a single product.', false);

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
        'Netflix''s Continuous Delivery Clash',
        'A Netflix core infrastructure team deploys microservices to production up to 50 times a day using advanced CI/CD pipelines. The PM insists they still follow strict 2-week Scrum sprints, batching "releasable increments" only at the end of the sprint. What is the architectural friction here?',
        'advanced',
        'Netflix',
        'Platform engineering',
        'C',
        'Option C is correct. Traditional Scrum relies on batched timeboxes (sprints) to deliver integrated value. However, elite engineering teams with mature CI/CD have outgrown this necessity. Imposing 2-week batching on a continuous delivery pipeline artificially constrains flow and delays value realization. Such teams generally operate better using Kanban. Option A is entirely false; CI/CD is an extreme realization of Agile principles. Option B is rigid dogma. Option D suggests slowing down a high-performing engineering capability to appease an administrative framework.',
        ARRAY['continuous_delivery', 'scrum_vs_kanban', 'devops']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'CI/CD is fundamentally incompatible with all Agile methodologies.', false),
    (v_q_id, 'B', 'The PM is correct; releasing mid-sprint violates the Scrum Guide''s core tenets.', false),
    (v_q_id, 'C', 'Traditional 2-week batching is artificially constraining a team capable of continuous flow.', true),
    (v_q_id, 'D', 'The engineers are deploying too fast and need to be slowed down to maintain velocity metrics.', false);

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
        'GitHub''s Output vs. Outcomes',
        'A GitHub PM proudly reports that the team delivered 60 story points this sprint, beating their previous record of 55. However, user retention has dropped, and feature adoption is at 2%. What advanced Agile mindset shift does this PM need?',
        'advanced',
        'GitHub',
        'Actions pipeline features',
        'A',
        'Option A is correct. A common pitfall in Agile execution is the "Feature Factory" anti-pattern, where teams celebrate high Output (story points delivered, code shipped) while ignoring Outcomes (customer value, behavior change, business impact). Delivering 60 points of software that nobody uses is a massive waste of resources. Option B doubles down on the broken output-driven mindset. Option C focuses on the mechanics of estimation, ignoring the strategic failure. Option D abdicates the PM''s core responsibility for product success.',
        ARRAY['outcomes_vs_outputs', 'agile_metrics', 'product_value']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They need to shift from measuring "Output" (points delivered) to measuring "Outcomes" (business value created).', true),
    (v_q_id, 'B', 'They need to ensure the next sprint delivers 65 points to counteract the dropping retention.', false),
    (v_q_id, 'C', 'They need to switch to T-shirt sizing instead of Fibonacci story points to improve accuracy.', false),
    (v_q_id, 'D', 'They need to realize that PMs are only responsible for delivery, while marketing is responsible for adoption.', false);

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
        'Figma''s Dark Launch Strategy',
        'Figma''s engineering team needs to rewrite the WebGL rendering engine. It will take 4 sprints. The codebase cannot be left broken for a month, but the feature is too big for one sprint. How should the PM structure the user stories?',
        'advanced',
        'Figma',
        'Canvas rendering team',
        'C',
        'Option C is correct. Deep architectural refactors often cannot be delivered in a single sprint. The Agile solution is to use architectural slicing and Feature Flags (dark launching). This allows developers to safely merge small, integrated technical increments into the main codebase every sprint without exposing incomplete UI to the user. Option A results in massive merge conflicts and integration nightmares. Option B (long-lived branches) is a severe anti-pattern that leads to "merge hell." Option D destroys the business by pausing all other innovation.',
        ARRAY['feature_flags', 'technical_debt', 'agile_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create one 4-sprint long story and merge all the code on the very last day of the 4th sprint.', false),
    (v_q_id, 'B', 'Create a separate code branch that lives for 2 months, isolating the developers from the main application.', false),
    (v_q_id, 'C', 'Merge code continuously behind a Feature Flag, writing stories that deliver testable technical increments each sprint.', true),
    (v_q_id, 'D', 'Pause all feature development for the entire company until the rendering engine is finished.', false);

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
        'Airbnb''s Simpson''s Paradox in Agile Data',
        'An Agile Coach at Airbnb points out that while Team A''s velocity is 30 points and Team B''s velocity is 80 points, Team A is actually delivering more business value. The PM for Team B is confused. Why is comparing velocity across different teams a fundamental anti-pattern?',
        'advanced',
        'Airbnb',
        'Growth and search teams',
        'B',
        'Option B is correct. Story points are an abstract, dimensionless unit calibrated locally by a specific team based on their own baseline of complexity. A "5-point" story for Team A might be a "1-point" or "13-point" story for Team B. Because the scales are entirely arbitrary, comparing them is statistically invalid and usually incentivizes teams to artificially inflate their estimates to look better. Option A is irrelevant; tools don''t change the fundamental nature of points. Option C assumes malice. Option D is a rigid developer-centric metric that ignores user value.',
        ARRAY['velocity', 'agile_metrics', 'anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Because Team A might be using Jira while Team B is using Asana.', false),
    (v_q_id, 'B', 'Because velocity is a relative measure calibrated locally; comparing teams incentivizes point inflation.', true),
    (v_q_id, 'C', 'Because Team B is likely lying about their point completions.', false),
    (v_q_id, 'D', 'Because business value can only be measured by the number of commits made to GitHub.', false);

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
        'Stripe''s Definition of Ready Trap',
        'A PM at Stripe creates a highly rigorous "Definition of Ready" (DoR) requiring pixel-perfect designs, fully finalized API contracts, and sign-off from legal before any story enters a sprint. Over time, the team''s lead time balloons to 3 months. What Agile dysfunction has occurred?',
        'advanced',
        'Stripe',
        'Compliance and onboarding',
        'B',
        'Option B is correct. While a Definition of Ready ensures a story is actionable, making it overly prescriptive turns it into an immovable stage-gate. The PM has effectively recreated siloed Waterfall phases (Design -> Legal -> Build) masked inside a Scrum process, destroying the team''s ability to iterate collaboratively and rapidly discover requirements alongside developers. Option A worsens the bottleneck. Option C misunderstands the root cause; estimation won''t fix an overly bureaucratic process. Option D unfairly blames developers for a PM-created process failure.',
        ARRAY['definition_of_ready', 'waterfall_in_disguise', 'agile_anti_patterns']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM hasn''t made the DoR strict enough; they also need sign-off from the CEO.', false),
    (v_q_id, 'B', 'The DoR has been weaponized into a stage-gate, effectively recreating Waterfall phases under the guise of Scrum.', true),
    (v_q_id, 'C', 'The team is failing to accurately estimate the legal approval process in their story points.', false),
    (v_q_id, 'D', 'The developers are simply not working fast enough to keep up with the rigorous DoR.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Agile / Scrum';

END $$;
