-- ============================================
-- ASSESSMENT: Jira
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
    WHERE slug = 'jira';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug jira not found. Run the seed data first.';
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
        'Spotify''s Issue Hierarchy',
        E'Spotify''s Discovery PM wants to group 15 user stories and 5 bugs under a single broader initiative called "AI Playlist Recommendations." They need to track the overall progress of this initiative over the next 3 months.\n\nWhat is the most appropriate Jira issue hierarchy to use?',
        'foundational',
        'Spotify',
        'Discovery Team',
        'B',
        'An Epic is specifically designed to group related stories, bugs, and tasks that form a larger initiative delivered over multiple sprints. Creating a separate project creates unnecessary silos and administrative overhead. Sub-tasks should be used for breaking down a single story into technical steps, not for grouping distinct user stories. While labels can group issues, they lack structured progress tracking and dedicated reporting like Epic Burndowns.',
        ARRAY['epics', 'issue_types', 'agile_planning']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a separate Project and put the stories inside it.', false),
    (v_q_id, 'B', 'Create an Epic and link the stories and bugs to it using the "Epic Link".', true),
    (v_q_id, 'C', 'Create a Master Story and convert the 20 items into Sub-tasks.', false),
    (v_q_id, 'D', 'Add a common Label to all 20 items and track them via a Kanban board.', false);

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
        'Airbnb''s Burndown Chart',
        E'During a 2-week sprint, Airbnb''s Guest Experience PM checks the Sprint Burndown Chart on day 6. The "Remaining Values" line has been completely flat for the last 5 days, remaining significantly above the grey "Guideline" line.\n\nWhat should the PM conclude from this chart?',
        'foundational',
        'Airbnb',
        'Guest Experience Team',
        'C',
        'The Sprint Burndown Chart shows the total remaining work (usually in story points) across the sprint. A flat horizontal line means no issues are being completed and moved to "Done" (or their remaining estimate isn''t being reduced). This often indicates a bottleneck, such as stories waiting in QA, or developers forgetting to update Jira. If scope was added, the line would spike upwards, not stay flat.',
        ARRAY['agile_reporting', 'burndown_chart', 'sprint_tracking']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The team is completing work exactly as planned and is on track.', false),
    (v_q_id, 'B', 'Scope was added to the sprint midway, causing the line to flatten.', false),
    (v_q_id, 'C', 'The team has not transitioned any estimated issues to the "Done" status.', true),
    (v_q_id, 'D', 'The team''s velocity has increased, meaning they will finish early.', false);

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
        'Uber''s Board Configuration',
        E'Uber''s Platform Reliability team handles incoming production alerts, urgent bug fixes, and infrastructure maintenance. Their priorities change daily, and they do not plan work in 2-week iterations. They need a Jira board to visualize their workflow.\n\nWhich board type should the PM configure?',
        'foundational',
        'Uber',
        'Platform Reliability Team',
        'B',
        'Kanban boards are designed for continuous flow of work, making them ideal for support, reliability, or operations teams where priorities shift daily and work is not time-boxed into sprints. Scrum boards require batching work into time-boxed sprints, which fails when daily urgent interrupts occur. Work-In-Progress (WIP) limits in Kanban help the team focus on finishing open tasks before pulling in new ones.',
        ARRAY['kanban', 'scrum', 'boards']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Scrum board with 1-week sprints to accommodate the changing priorities.', false),
    (v_q_id, 'B', 'A Kanban board with Work-In-Progress (WIP) limits.', true),
    (v_q_id, 'C', 'A Basic board with a strict Epic hierarchy.', false),
    (v_q_id, 'D', 'An Agility board with the backlog disabled.', false);

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
        'DoorDash''s Issue Links',
        E'DoorDash''s Checkout PM is planning a sprint. Story A ("Add Apple Pay button") cannot be started until Story B ("Integrate Apple Pay backend API") is fully complete.\n\nHow should the PM represent this dependency in Jira?',
        'foundational',
        'DoorDash',
        'Checkout Team',
        'D',
        'Issue linking in Jira defines the relationship between tickets. If Story A cannot start until Story B is done, Story B is the blocker. Therefore, "Story B blocks Story A" (or "Story A is blocked by Story B") is the correct directional link. Making it a sub-task is incorrect because they are distinct user stories, potentially worked on by different developers. Just adding a comment doesn''t allow Jira''s dependency tracking features to recognize the blocker.',
        ARRAY['issue_links', 'dependencies', 'sprint_planning']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a comment on Story A mentioning Story B.', false),
    (v_q_id, 'B', 'Make Story A a sub-task of Story B.', false),
    (v_q_id, 'C', 'Link the issues so that "Story A blocks Story B".', false),
    (v_q_id, 'D', 'Link the issues so that "Story B blocks Story A".', true);

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
        'Netflix''s Basic JQL',
        E'Netflix''s PM wants to find all bugs in the "PLAYER" project that are marked as "High" priority and are currently in the "Open" status.\n\nWhich JQL (Jira Query Language) string correctly returns this list?',
        'foundational',
        'Netflix',
        'Video Player Team',
        'A',
        'JQL uses standard SQL-like syntax with "AND" to combine conditions. Option A correctly uses the "=" operator and the "AND" keyword to filter for issues that meet all four criteria simultaneously. Using colons is not valid JQL syntax for exact matching. Using "OR" would return any issue in the PLAYER project, OR any bug anywhere, OR any high priority issue anywhere, resulting in massive amounts of irrelevant data.',
        ARRAY['jql', 'search_filters', 'issue_tracking']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'project = PLAYER AND type = Bug AND priority = High AND status = Open', true),
    (v_q_id, 'B', 'project : PLAYER AND type : Bug AND priority : High AND status : Open', false),
    (v_q_id, 'C', 'SEARCH project=PLAYER, type=Bug, priority=High, status=Open', false),
    (v_q_id, 'D', 'project = PLAYER OR type = Bug OR priority = High OR status = Open', false);

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
        'Shopify''s Issue Routing',
        E'Shopify''s PM wants to categorize Jira issues based on the part of the architecture they touch (e.g., "Database", "UI", "API"). They want these categories to have a designated "Default Assignee" so new UI bugs automatically route to the frontend lead.\n\nWhat Jira feature should they use?',
        'foundational',
        'Shopify',
        'Merchant App Team',
        'C',
        'Components in Jira are project-specific subdivisions that can have a designated Component Lead and a Default Assignee. This makes them perfect for architectural or functional routing (e.g., automatically assigning "Database" issues to the DBA). Labels are informal, free-text tags that cannot have default assignees and are prone to typos. Epics represent specific initiatives, not permanent architectural categories.',
        ARRAY['components', 'routing', 'project_setup']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Labels', false),
    (v_q_id, 'B', 'Custom Fields', false),
    (v_q_id, 'C', 'Components', true),
    (v_q_id, 'D', 'Epics', false);

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
        'Slack''s Velocity Chart',
        E'Slack''s PM is looking at the Velocity Chart. Over the last 4 sprints, the team''s "Completed" bars show 42, 45, 41, and 44 story points. For the upcoming sprint planning, the team wants to commit to 65 story points because "they feel confident."\n\nWhat is the PM''s best response based on the chart?',
        'foundational',
        'Slack',
        'Messaging Core Team',
        'B',
        'The Velocity Chart shows the historical amount of work (story points) a team completes per sprint. It is the most reliable predictor of future capacity. Since the team consistently completes ~43 points, committing to 65 points (a ~50% increase) is highly unrealistic and will likely lead to spillover, missed goals, and demoralization. Altering sprint length violates Scrum timeboxing principles.',
        ARRAY['velocity_chart', 'agile_reporting', 'capacity_planning']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Approve the 65 points, as Agile encourages teams to stretch their commitments.', false),
    (v_q_id, 'B', 'Push back, as the historical velocity strongly suggests their capacity is consistently around 43 points.', true),
    (v_q_id, 'C', 'Approve the 65 points but increase the length of the sprint in Jira by a few days to ensure completion.', false),
    (v_q_id, 'D', 'Reject it and mandate they commit to exactly 44 points, their most recent velocity.', false);

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
        'Zoom''s Release Tracking',
        E'Zoom is preparing for their "v5.12 Release" which includes multiple features and bug fixes across different Jira projects. The PM needs a way to track all issues going into this specific app update and generate release notes.\n\nWhat is the native Jira feature for this?',
        'foundational',
        'Zoom',
        'Mobile Client Team',
        'B',
        'The "Fix Version" field is explicitly designed in Jira to track software releases. Creating a Version allows PMs to use the native "Release Hub," track version progress, warn about uncompleted issues before release, and automatically generate release notes. Using labels is too informal and lacks release-specific reporting. Epics are for feature initiatives, not version-based release tracking.',
        ARRAY['versions', 'releases', 'issue_fields']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a "v5.12" Label and add it to all relevant issues.', false),
    (v_q_id, 'B', 'Use the "Fix Version" field and create a "v5.12" version in the project.', true),
    (v_q_id, 'C', 'Create a new Epic named "v5.12 Release" and link everything to it.', false),
    (v_q_id, 'D', 'Use the "Environment" custom field to denote the release version.', false);

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
        'Stripe''s Workflow Enforcement',
        E'A Stripe PM notices that engineers are moving issues directly from "To Do" to "Done," bypassing the "In Review" status. To enforce that all code goes through review, the PM wants to restrict the Jira workflow.\n\nWhat workflow configuration is needed?',
        'foundational',
        'Stripe',
        'Payment API Team',
        'B',
        'By default, many Jira workflows have "Allow all statuses to transition to this one" enabled for the "Done" status, allowing a ticket to jump from anywhere to Done. To enforce a strict sequence (To Do -> In Progress -> In Review -> Done), the PM must remove the "All" transition and draw specific, explicit transition paths. While a Validator could check for a PR, it doesn''t fundamentally fix the broken workflow paths.',
        ARRAY['workflows', 'transitions', 'process_enforcement']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a Validator on the "Done" status requiring a linked PR.', false),
    (v_q_id, 'B', 'Remove the "Allow all statuses to transition to this one" setting on the "Done" status and explicitly map the transition from "In Review" to "Done".', true),
    (v_q_id, 'C', 'Change the "Done" status category from Green to Grey.', false),
    (v_q_id, 'D', 'Add a Post Function to the "To Do" status that emails the PM.', false);

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
        'Canva''s Sub-task Estimation',
        E'Canva''s PM creates a User Story estimated at 8 Story Points. The lead engineer breaks this story down into 4 Sub-tasks. The engineer asks the PM, "Should I add 2 Story Points to each of the 4 sub-tasks?"\n\nWhat is the correct Jira best practice?',
        'foundational',
        'Canva',
        'Editor Team',
        'C',
        'In Jira (and standard Agile practice), Story Points represent the overall effort, complexity, and risk of delivering a user-facing increment of value (the User Story). Sub-tasks represent technical execution steps. Placing story points on sub-tasks causes double-counting in Jira''s native velocity metrics unless specifically configured to roll up (which is discouraged). The parent story retains the points, and sub-tasks are tracked by completion or estimated in hours.',
        ARRAY['story_points', 'sub_tasks', 'estimation']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes, sub-tasks must always have story points that sum up precisely to the parent story''s estimate.', false),
    (v_q_id, 'B', 'Yes, but only if the sub-tasks are assigned to different developers.', false),
    (v_q_id, 'C', 'No, story points should remain only on the parent Story. Sub-tasks are typically estimated in hours or left unestimated.', true),
    (v_q_id, 'D', 'No, story points should be moved entirely to the sub-tasks, and the parent story should have 0 points.', false);

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
        'Figma''s Dynamic JQL',
        E'Figma''s PM wants to create a personalized Jira dashboard widget that always shows the logged-in user the unresolved high-priority bugs assigned to them.\n\nWhich JQL query dynamically adapts to whoever is looking at the dashboard?',
        'intermediate',
        'Figma',
        'Design Systems Team',
        'B',
        'In JQL, currentUser() is the correct function to dynamically filter for the user who is currently executing the query or viewing the dashboard. "resolution IS EMPTY" (or "resolution = Unresolved") is the standard way to find issues that haven''t been completed. loggedInUser() and dynamicUser do not exist in JQL.',
        ARRAY['jql', 'dashboards', 'advanced_search']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'assignee = loggedInUser() AND priority = High AND resolution = Unresolved', false),
    (v_q_id, 'B', 'assignee = currentUser() AND priority = High AND resolution IS EMPTY', true),
    (v_q_id, 'C', 'assignee IN (me) AND priority = High AND status != Closed', false),
    (v_q_id, 'D', 'assignee = dynamicUser AND priority = High AND resolution = Unresolved', false);

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
        'GitHub''s Workflow Validators',
        E'GitHub''s PM wants to modify the Jira workflow so that an issue can only be transitioned to the "In QA" status if the "Test Environment URL" custom field is filled out. If it is empty, the transition should fail and show an error message.\n\nWhat workflow element should be used?',
        'intermediate',
        'GitHub',
        'Issues & PRs Team',
        'C',
        'A Validator checks if certain criteria are met during the transition and throws an error message if they are not (e.g., requiring a specific field to be filled). A Condition hides the transition button entirely if criteria aren''t met, meaning the user wouldn''t even know why they can''t move it. A Post Function executes after the transition happens. A Trigger listens for external events.',
        ARRAY['workflows', 'validators', 'custom_fields']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Condition', false),
    (v_q_id, 'B', 'A Post Function', false),
    (v_q_id, 'C', 'A Validator', true),
    (v_q_id, 'D', 'A Trigger', false);

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
        'Robinhood''s CFD Bottlenecks',
        E'Robinhood''s PM is reviewing the Cumulative Flow Diagram (CFD) for the team''s Kanban board. Over the last month, the colored band representing the "In QA" status has been getting progressively wider vertically, while the "Done" band''s slope has flattened.\n\nWhat does this indicate?',
        'intermediate',
        'Robinhood',
        'Crypto Trading Team',
        'B',
        'In a CFD, the vertical width of a band represents the Work In Progress (WIP) for that specific status. If the "In QA" band is widening vertically, it means tickets are piling up in that state—they are entering QA faster than they are leaving it. The flattening "Done" slope confirms that the delivery rate (throughput) has slowed down. This is a classic visual indicator of a bottleneck at the QA stage.',
        ARRAY['cumulative_flow_diagram', 'bottlenecks', 'agile_reporting']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The team''s throughput is increasing, resulting in more issues entering QA.', false),
    (v_q_id, 'B', 'QA is a bottleneck; work is arriving in QA faster than it is being tested and moved to Done.', true),
    (v_q_id, 'C', 'The developers are writing fewer bugs, so QA has more time to test thoroughly.', false),
    (v_q_id, 'D', 'The team''s cycle time is decreasing, which is a positive agile indicator.', false);

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
        'Notion''s Control Chart',
        E'Notion''s PM uses the Jira Control Chart to analyze the team''s efficiency. The chart shows that "Lead Time" is averaging 45 days, but "Cycle Time" is averaging 5 days.\n\nHow should the PM interpret this massive gap?',
        'intermediate',
        'Notion',
        'Enterprise Security Team',
        'B',
        'Lead Time is the total time from when an issue is created until it is completed. Cycle Time is the time from when work actually begins (moves to In Progress) until it is completed. A long lead time but a short cycle time means issues are spending a massive amount of time waiting in the backlog before they are prioritized and picked up. Once picked up, the team completes them quickly.',
        ARRAY['control_chart', 'cycle_time', 'lead_time']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Developers are taking 45 days to write the code, but QA is testing it in 5 days.', false),
    (v_q_id, 'B', 'Issues sit in the backlog for about 40 days before developers actually start working on them.', true),
    (v_q_id, 'C', 'The team is failing their sprint goals consistently by 40 days.', false),
    (v_q_id, 'D', 'The Jira instance has a configuration error calculating time elapsed.', false);

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
        'Atlassian''s Sprint Report',
        E'At the end of a sprint, the team realizes they only completed 20 out of 40 committed story points because a critical developer was sick. During the retrospective, the Scrum Master asks the PM to look at the Jira reports to understand what happened to specific tickets.\n\nWhich report gives a detailed breakdown of issues completed, issues not completed, and issues added mid-sprint?',
        'intermediate',
        'Atlassian',
        'Jira Software Team',
        'B',
        'The Sprint Report specifically provides a granular, ticket-by-ticket breakdown of what happened during a specific sprint. It lists completed issues, uncompleted issues, and flags any issues that were added after the sprint started (scope creep). The Velocity Chart only shows the high-level aggregate numbers (committed vs completed points) across multiple sprints, but lacks ticket-level detail.',
        ARRAY['sprint_report', 'agile_reporting', 'sprint_tracking']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Velocity Chart', false),
    (v_q_id, 'B', 'Sprint Report', true),
    (v_q_id, 'C', 'Version Report', false),
    (v_q_id, 'D', 'Epic Report', false);

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
        'Uber''s Historical JQL',
        E'Uber''s PM suspects that many bugs are being reopened after QA tests them in staging. They want to find all bugs in the "DRIVER" project that were moved to "Done" at some point, but are currently back in "To Do" or "In Progress".\n\nWhich JQL query does this?',
        'intermediate',
        'Uber',
        'Driver App Team',
        'A',
        'The "WAS" operator in JQL allows you to search historical data. "status WAS Done" finds any issue that had the "Done" status at any point in its lifecycle. Combining it with "status != Done" ensures you only get issues that have since moved out of "Done" (i.e., reopened). Option B only catches issues specifically moved to "To Do," missing those moved directly to "In Progress". Option C is logically impossible.',
        ARRAY['jql', 'historical_search', 'issue_tracking']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'project = DRIVER AND type = Bug AND status WAS Done AND status != Done', true),
    (v_q_id, 'B', 'project = DRIVER AND type = Bug AND status CHANGED FROM Done TO "To Do"', false),
    (v_q_id, 'C', 'project = DRIVER AND type = Bug AND status = Done AND status = "In Progress"', false),
    (v_q_id, 'D', 'project = DRIVER AND type = Bug AND history = "Done"', false);

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
        'Figma''s Epic Burndown',
        E'Figma''s PM is tracking an Epic for "Advanced Animations." Looking at the Jira Epic Burndown chart, they see the "Work Completed" bar growing steadily sprint over sprint, but the "Remaining Work" bar is *also* growing.\n\nWhat is the most accurate diagnosis?',
        'intermediate',
        'Figma',
        'Prototyping Team',
        'B',
        'An Epic Burndown chart visualizes progress toward completing an Epic. If the team is completing work (Work Completed bar goes up) but the Remaining Work is also increasing (instead of decreasing), it means PMs or stakeholders are continuously adding new stories or increasing point estimates within the Epic. This visualizes scope creep outpacing the team''s delivery capacity.',
        ARRAY['epic_burndown', 'scope_creep', 'agile_reporting']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The developers are overestimating their work during sprint planning.', false),
    (v_q_id, 'B', 'Scope creep is occurring; new stories are being added to the Epic faster than the team can complete them.', true),
    (v_q_id, 'C', 'The team''s velocity is dropping, causing a buildup of technical debt.', false),
    (v_q_id, 'D', 'The Epic is complete and the Jira board needs to be archived.', false);

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
        'Discord''s Jira Automation',
        E'Discord''s PM wants to automate a workflow in Jira: "Whenever a critical production bug is created, automatically send a message to a specific Slack channel and assign it to the On-Call Engineer."\n\nIn Jira Automation, what sequence of components is required?',
        'intermediate',
        'Discord',
        'Trust & Safety Team',
        'B',
        'Jira Automation operates on a Trigger -> Condition -> Action logic. To catch a newly reported bug, the Trigger must be "Issue Created". The Condition restricts this to only apply when Priority is Critical and Type is Bug. Finally, the Actions execute the desired business logic: assigning the issue and sending the Slack notification. Using "Issue Transitioned" implies it already existed.',
        ARRAY['automation', 'workflows', 'integrations']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Trigger: Issue Transitioned -> Condition: Type is Bug -> Action: Send Slack message', false),
    (v_q_id, 'B', 'Trigger: Issue Created -> Condition: Priority is Critical AND Type is Bug -> Action: Assign issue & Send Slack message', true),
    (v_q_id, 'C', 'Trigger: Scheduled -> Condition: Status is Open -> Action: Webhook', false),
    (v_q_id, 'D', 'Trigger: Field Value Changed -> Condition: Assignee is Empty -> Action: Send email', false);

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
        'DoorDash''s Resolution Field',
        E'A DoorDash engineer marks a Jira bug as "Done" and adds a comment saying "Could not reproduce." However, on the Jira board, the issue is crossed out, but on dashboard filters, it still appears as "Unresolved."\n\nWhat did the engineer likely forget to do?',
        'intermediate',
        'DoorDash',
        'Merchant Portal Team',
        'C',
        'In Jira, an issue is only considered "Resolved" by the system (and filtered out of "Unresolved" lists) when the ''Resolution'' system field is populated (e.g., Done, Won''t Do, Cannot Reproduce). Moving an issue to a "Done" status category does NOT automatically set the Resolution field unless a Post Function is explicitly configured on that transition, or a transition screen forces the user to select it.',
        ARRAY['resolution', 'workflows', 'issue_fields']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They forgot to clear the Assignee field.', false),
    (v_q_id, 'B', 'They forgot to transition the status from "To Do" to "Done".', false),
    (v_q_id, 'C', 'They moved the status to "Done" but the workflow transition didn''t set the ''Resolution'' field.', true),
    (v_q_id, 'D', 'They did not log time against the issue.', false);

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
        'Airbnb''s Sprint Scope Change',
        E'It''s Day 3 of a 2-week sprint. Airbnb''s PM realizes they urgently need to add a new 5-point story to the active sprint to fix a ranking algorithm error. The team agrees they have capacity.\n\nHow does Jira represent this addition on the Sprint Burndown Chart?',
        'intermediate',
        'Airbnb',
        'Search Ranking Team',
        'B',
        'When scope is added to an active sprint, the Sprint Burndown chart accurately reflects reality by showing a vertical spike upwards in the "Remaining Values" (story points) on the exact day the issue was added. It does not rewrite history to hide the scope change. Jira tracks initial commitment vs final commitment, but the chart visualizes the day-to-day reality of remaining work, making the spike highly visible.',
        ARRAY['burndown_chart', 'scope_change', 'sprints']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It retroactively alters the initial commitment on Day 1 to include the 5 points.', false),
    (v_q_id, 'B', 'It shows a vertical spike upwards on the Remaining Values line on Day 3.', true),
    (v_q_id, 'C', 'It ignores the new points because sprint commitments are permanently locked in Jira.', false),
    (v_q_id, 'D', 'It creates a secondary burndown line specifically for unplanned work.', false);

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
        'Shopify''s WIP Limits',
        E'Shopify''s PM sets a Work-In-Progress (WIP) limit of 4 on the "In Progress" column of their Kanban board. There are currently 4 issues in that column. A developer tries to drag a 5th urgent issue from "To Do" into "In Progress".\n\nWhat happens natively in Jira?',
        'intermediate',
        'Shopify',
        'Checkout Performance Team',
        'B',
        'Native Jira Software WIP limits are visual indicators, not strict system constraints. When a limit is breached, Jira allows the action but highlights the column header in red (or yellow) to alert the team that they are violating their agreed-upon process. It relies on team discipline rather than hard technical blockers to manage flow.',
        ARRAY['kanban', 'wip_limits', 'boards']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Jira strictly blocks the transition and shows an error preventing the move.', false),
    (v_q_id, 'B', 'Jira allows the transition but highlights the column header to indicate the WIP limit is breached.', true),
    (v_q_id, 'C', 'Jira automatically moves the oldest issue in "In Progress" back to "To Do" to make room.', false),
    (v_q_id, 'D', 'Jira creates a new sub-column to handle the overflow.', false);

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
        'GitHub''s Version Management',
        E'A user reports a bug in GitHub CodeSpaces that has been present since Version 2.1. The team investigates, writes a patch, and plans to release the solution in the upcoming Version 2.4.\n\nHow should the PM populate the version fields on the Jira bug ticket?',
        'intermediate',
        'GitHub',
        'CodeSpaces Team',
        'A',
        '''Affects Version'' indicates which versions of the software the bug was observed in (where the problem exists). ''Fix Version'' indicates which upcoming release will contain the code change that resolves the bug. Therefore, the bug affects 2.1 (and potentially 2.2, 2.3) but will be fixed in 2.4. Using the Environment field or generic labels bypasses Jira''s native release hub capabilities.',
        ARRAY['versions', 'releases', 'issue_fields']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Affects Version: 2.1 | Fix Version: 2.4', true),
    (v_q_id, 'B', 'Affects Version: 2.4 | Fix Version: 2.1', false),
    (v_q_id, 'C', 'Environment: 2.1 | Fix Version: 2.4', false),
    (v_q_id, 'D', 'Component: Version 2.1 | Label: Version 2.4', false);

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
        'Netflix''s JQL Sorting',
        E'Netflix''s PM is writing a JQL query for a dashboard. They want to see all unassigned bugs in the Growth project, but it is crucial that the most recently created bugs appear at the very top of the list.\n\nWhat is the correct JQL syntax?',
        'intermediate',
        'Netflix',
        'Growth Team',
        'C',
        'The correct syntax for sorting in JQL is ORDER BY. The field name is "created" (not createdDate). To get the most recently created items at the top, the order must be descending (DESC), meaning newest to oldest. Using ASC would put the oldest bugs from years ago at the top.',
        ARRAY['jql', 'sorting', 'dashboards']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'project = Growth AND type = Bug AND assignee IS EMPTY SORT BY created DESC', false),
    (v_q_id, 'B', 'project = Growth AND type = Bug AND assignee IS EMPTY ORDER BY createdDate ASC', false),
    (v_q_id, 'C', 'project = Growth AND type = Bug AND assignee IS EMPTY ORDER BY created DESC', true),
    (v_q_id, 'D', 'project = Growth AND type = Bug AND assignee IS EMPTY GROUP BY created DESC', false);

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
        'Stripe''s JQL Relative Dates',
        E'Stripe''s PM wants to set up a subscription filter that emails them every Monday morning with a list of all bugs created in the last 7 days that are still unresolved.\n\nWhich JQL query dynamically handles the rolling 7-day window?',
        'intermediate',
        'Stripe',
        'Billing Team',
        'A',
        'In JQL, relative date and time logic is executed using string abbreviations inside quotes, such as "-7d" (minus 7 days), "-1w" (minus 1 week), or "-24h". Option A correctly asks for bugs created after exactly 7 days ago. Using startOfWeek() would only look at bugs created since Sunday/Monday of the current week, missing bugs from the previous week depending on when the query is run.',
        ARRAY['jql', 'relative_dates', 'filters']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'type = Bug AND resolution IS EMPTY AND created > "-7d"', true),
    (v_q_id, 'B', 'type = Bug AND resolution IS EMPTY AND created BETWEEN Monday AND Sunday', false),
    (v_q_id, 'C', 'type = Bug AND resolution IS EMPTY AND created > startOfWeek()', false),
    (v_q_id, 'D', 'type = Bug AND resolution IS EMPTY AND createdDate > NOW() - 7', false);

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
        'Slack''s Issue Security',
        E'Slack is acquiring a smaller startup. A dedicated Jira project is created to manage the technical integration. The PM needs to ensure that only a specific group of 5 executives can view issues tagged as "Legal", while the rest of the integration team can see all other issues in the same project.\n\nWhat Jira feature is required?',
        'intermediate',
        'Slack',
        'Enterprise Compliance Team',
        'B',
        'Project Permissions control who can see the project as a whole. If you need granular, ticket-by-ticket visibility restrictions within the same project, you must use an Issue Security Scheme. It allows you to define security levels (e.g., "Executive Only") and apply them to specific tickets, making them invisible to regular project members. Field Level Security is not native to Jira.',
        ARRAY['permissions', 'issue_security', 'project_setup']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Project Permissions Scheme', false),
    (v_q_id, 'B', 'Issue Security Scheme', true),
    (v_q_id, 'C', 'Field Level Security', false),
    (v_q_id, 'D', 'Private Labels', false);

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
        'Zoom''s Sub-tasks',
        E'A Zoom PM has an Epic for "Webinar scaling." Story A is "Upgrade database schema." The PM realizes that Story A requires updating a wiki page, writing release notes, and running a performance test script.\n\nShould they use sub-tasks or "relates to" issue links to track these three activities?',
        'intermediate',
        'Zoom',
        'Meeting Infrastructure Team',
        'B',
        'Sub-tasks are designed specifically to break down a single user story or task into smaller, actionable chunks of work required to complete that parent item. Updating docs or running tests to consider a story "Done" are perfect use cases for sub-tasks. Issue links are for loosely relating independent stories. Contrary to misconception, sub-tasks can be assigned to different users than the parent story.',
        ARRAY['sub_tasks', 'issue_links', 'work_breakdown']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Issue Links, because documentation and testing are fundamentally different issue types than coding.', false),
    (v_q_id, 'B', 'Sub-tasks, because they are concrete steps required to complete the parent Story A.', true),
    (v_q_id, 'C', 'Issue Links, because sub-tasks cannot be assigned to different people than the parent story.', false),
    (v_q_id, 'D', 'Neither; they should be converted into separate Epics.', false);

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
        'Atlassian''s Post Functions',
        E'An Atlassian PM is optimizing an internal IT helpdesk Jira workflow. When an IT agent transitions a ticket to "Resolved", the PM wants Jira to automatically clear the "Escalation Level" custom field and add a generic "Thank you" comment.\n\nWhere must these actions be configured?',
        'intermediate',
        'Atlassian',
        'Internal Support',
        'C',
        'Post Functions carry out additional automated processing after a transition is successfully executed. Updating field values, clearing fields, assigning users, or generating comments upon a status change are the classic use cases for workflow Post Functions. Validators only check if a transition is allowed before it happens.',
        ARRAY['workflows', 'post_functions', 'automation']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'In the Validator of the "Resolved" transition.', false),
    (v_q_id, 'B', 'In the Automation Rules trigger section.', false),
    (v_q_id, 'C', 'In the Post Functions of the transition to "Resolved".', true),
    (v_q_id, 'D', 'In the Field Configuration Scheme for the project.', false);

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
        'Notion''s Chart Outliers',
        E'Notion''s PM is looking at the Control Chart to determine the team''s average cycle time. The rolling average line sits around 4 days. However, there is a cluster of dots sitting at 45 days. The PM investigates and realizes these were stale tickets left open by an engineer who went on sabbatical.\n\nWhat should the PM do to make the chart actionable?',
        'intermediate',
        'Notion',
        'Core Editor Team',
        'B',
        'Control charts are highly sensitive to extreme outliers, which skew the rolling average and make it hard to see the team''s actual normal performance. Jira allows you to apply Quick Filters directly to reports. Filtering out the known anomaly (the sabbatical engineer''s tickets) cleans the data without resorting to destructive actions like deleting tickets or falsifying historical data.',
        ARRAY['control_chart', 'cycle_time', 'agile_reporting']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delete the Jira tickets completely to remove them from the database.', false),
    (v_q_id, 'B', 'Create a Quick Filter to exclude tickets assigned to that specific engineer.', true),
    (v_q_id, 'C', 'Change the status of those tickets retroactively so they appear to have taken 4 days.', false),
    (v_q_id, 'D', 'Ignore the chart and calculate cycle time manually in Excel.', false);

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
        'Shopify''s Estimation Trap',
        E'During Sprint Planning, a junior PM at Shopify argues with the lead engineer. The PM says, "Last sprint we completed 40 points in 10 days. So a 4-point story is exactly 1 day of work. You should finish these two 4-point stories by Tuesday."\n\nWhat fundamental PM/Agile mistake is the PM making?',
        'advanced',
        'Shopify',
        'App Store Team',
        'A',
        'Story points are an abstract measure of effort, complexity, and uncertainty, not a direct conversion to hours or days. Equating points to exact time (e.g., 1 point = 2 hours) is a classic anti-pattern. A 4-point story might take 3 days of research and 1 hour of coding, while another takes 3 days of brute-force typing. Attempting to manage an engineer''s daily schedule using story point math defeats the purpose of relative estimation.',
        ARRAY['story_points', 'estimation', 'agile_anti_patterns']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Assuming that story points equate directly to linear time, ignoring complexity, risk, and non-coding overhead.', true),
    (v_q_id, 'B', 'Using points instead of t-shirt sizing for sprint planning.', false),
    (v_q_id, 'C', 'Forgetting to account for weekend days in the velocity calculation.', false),
    (v_q_id, 'D', 'Assigning stories to the engineer instead of letting the engineer pull them.', false);

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
        'Salesforce''s Advanced Roadmaps',
        E'Salesforce uses Jira Advanced Roadmaps. A PM needs to organize work in a hierarchy that goes higher than an Epic. They create an "Initiative" issue type.\n\nHow do they link an existing Epic to this Initiative?',
        'advanced',
        'Salesforce',
        'Multi-Cloud Integration Team',
        'B',
        'In standard Jira Software, "Epic Link" connects stories/tasks to an Epic. However, when using Advanced Roadmaps (Portfolio) to create hierarchy levels above Epic (like Initiative or Theme), you must use the "Parent Link" custom field to connect the Epic up to the Initiative. Epics cannot be sub-tasks, and standard issue links do not create true roadmap hierarchy.',
        ARRAY['advanced_roadmaps', 'hierarchy', 'portfolio_planning']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use the standard "Epic Link" field on the Initiative.', false),
    (v_q_id, 'B', 'Use the "Parent Link" field on the Epic, pointing to the Initiative.', true),
    (v_q_id, 'C', 'Add the Epic to the Initiative''s "Sub-tasks" list.', false),
    (v_q_id, 'D', 'Use a standard "blocks" issue link.', false);

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
        'Robinhood''s Advanced Historical JQL',
        E'Robinhood''s PM needs to audit an incident. They need to find all critical bugs that were downgraded to "Low" priority by a specific engineer (`jsmith`) during the month of October.\n\nWhich JQL query achieves this?',
        'advanced',
        'Robinhood',
        'Options Trading Team',
        'B',
        'The "CHANGED" operator in JQL allows you to search the change history of specific fields (like Status, Priority, Assignee). By combining it with "FROM", "TO", "BY" (for the user), and "DURING" (for the date range), you can pinpoint exact historical actions. Option A only shows bugs that are currently low priority and were updated in October by jsmith in any way (e.g., adding a comment), missing the specific priority downgrade criteria.',
        ARRAY['jql', 'historical_search', 'audit']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'type = Bug AND priority = Low AND updatedBy = jsmith AND updatedDate >= "2023-10-01"', false),
    (v_q_id, 'B', 'type = Bug AND priority CHANGED FROM Critical TO Low BY jsmith DURING ("2023-10-01", "2023-10-31")', true),
    (v_q_id, 'C', 'type = Bug AND priority WAS Low BY jsmith AND created >= "2023-10-01"', false),
    (v_q_id, 'D', 'type = Bug AND priority = Low AND history = "jsmith changed priority"', false);

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
        'Spotify''s Technical Debt Tracking',
        E'Spotify''s engineers want to dedicate 20% of the next sprint to refactoring legacy encoding logic. The code works, so there are no bugs, but it''s hard to maintain.\n\nHow should the PM represent this work in Jira to ensure it is prioritized and tracked against velocity?',
        'advanced',
        'Spotify',
        'Audio Encoding Team',
        'C',
        'Technical debt refactoring requires time, effort, and capacity. It should be made visible on the backlog as a Task or Story (often with a specific issue type or label like ''Tech Debt'') and estimated with story points. This allows the PM to explicitly negotiate prioritization and ensures the team''s velocity reflects their total output. Calling it a Bug pollutes quality metrics, as it''s not a broken feature. "Hidden" work destroys predictability.',
        ARRAY['technical_debt', 'backlog_management', 'story_points']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create "Bug" tickets, because bad code is technically a defect.', false),
    (v_q_id, 'B', 'Tell the engineers to do it secretly without Jira tickets so it doesn''t affect the burndown chart.', false),
    (v_q_id, 'C', 'Create standard "Task" or "Story" tickets labeled ''Tech-Debt'' and point estimate them like normal feature work.', true),
    (v_q_id, 'D', 'Create an Epic called "Tech Debt" and close it at the end of the sprint.', false);

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
        'Discord''s Parallel Workflows',
        E'A Discord PM creates a complex Jira workflow with parallel branches: After "In Progress", tickets go to *both* "Code Review" and "Security Audit" simultaneously. The ticket can only transition to "Done" when both are complete.\n\nWhat is the major agile anti-pattern this Jira configuration creates?',
        'advanced',
        'Discord',
        'Voice Infrastructure Team',
        'B',
        'Jira workflows are fundamentally linear state machines. A single ticket can only be in one status at a time. Trying to build parallel flows (where a single ticket is in "Code Review" and "Security Audit" simultaneously) requires complex third-party apps, custom scripting, or creating parallel sub-tasks. Building it into the main workflow often results in convoluted transitions, tickets getting permanently stuck, or users finding loopholes.',
        ARRAY['workflows', 'anti_patterns', 'process_design']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It makes the workflow too simple for enterprise scale.', false),
    (v_q_id, 'B', 'Jira cannot natively enforce parallel "AND" workflow gates without heavy scripting, leading to tickets getting stuck.', true),
    (v_q_id, 'C', 'It prevents the PM from viewing the Sprint Report.', false),
    (v_q_id, 'D', 'It forces the team to use Kanban instead of Scrum.', false);

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
        'Zoom''s Sprint Spillover',
        E'It''s the last day of the sprint. Zoom''s team has an 8-point story. The coding and testing are 100% complete, but the Product Manager hasn''t had time to do the final UAT (User Acceptance Testing) sign-off. The sprint ends in 1 hour.\n\nWhat is the correct Jira action?',
        'advanced',
        'Zoom',
        'Chat Platform Team',
        'C',
        'Agile principles dictate that an issue is only "Done" when it meets the complete Definition of Done (which here includes UAT). Partial credit is an anti-pattern. If it''s not done, it spills over. When the sprint is closed in Jira, any incomplete issues (and their full point values) are moved to the backlog or the next sprint. Fudging the numbers destroys the integrity of the team''s velocity metrics and hides the bottleneck.',
        ARRAY['sprints', 'spillover', 'agile_principles']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mark the issue as "Done" to get the 8 points, and just do the UAT next week.', false),
    (v_q_id, 'B', 'Split the issue into a 7-point "Dev" story and a 1-point "UAT" story, closing the Dev one.', false),
    (v_q_id, 'C', 'Leave the issue open. When closing the sprint, Jira will move the full 8 points back to the backlog or the next sprint.', true),
    (v_q_id, 'D', 'Change the estimate to 0 points so it doesn''t negatively impact the Velocity Chart.', false);

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
        'Stripe''s Workflow Conditions',
        E'Stripe has a critical Jira project for ledger updates. The PM wants to ensure that a ticket can be transitioned to "Ready for Deploy" *only* by users who belong to the "Lead Engineers" Jira user group.\n\nHow is this natively configured?',
        'advanced',
        'Stripe',
        'Financial Core Team',
        'A',
        'A Condition prevents a transition from even appearing on the screen or being executable if criteria aren''t met. Jira provides a native "User Is In Group" condition that can be added to a transition. This ensures only members of the "Lead Engineers" group will see the button to move the issue to "Ready for Deploy". Assigning issues or requiring custom fields does not securely restrict the actual execution of the transition.',
        ARRAY['workflows', 'conditions', 'permissions']
    ) RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use a "User Is In Group" Condition on the transition.', true),
    (v_q_id, 'B', 'Set the Assignee field to the "Lead Engineers" group.', false),
    (v_q_id, 'C', 'Use a Post Function to check the user''s group and revert the transition if they aren''t in it.', false),
    (v_q_id, 'D', 'Create a custom field called "Approved By" and make it mandatory.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Jira';

END $$;
