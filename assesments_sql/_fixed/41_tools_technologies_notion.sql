-- ============================================
-- ASSESSMENT: Notion
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
    WHERE slug = 'notion-tool';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug notion not found. Run the seed data first.';
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
        'Spotify''s Spec Duplication',
        E'A Spotify PM is writing a PRD for a new playlist feature. A specific section outlining the ''Content Moderation Guidelines'' needs to be visible in this PRD, but it is also maintained in a central Trust & Safety wiki page. How should the PM ensure the guidelines are identical in both places without manually updating both when changes occur?',
        'foundational',
        'Spotify',
        'PRD Writing',
        'B',
        'Option B is correct. A Synced Block allows content to be edited in one place and automatically updated everywhere it is pasted. Option A (Linked Database) is for structured table data, not freeform text guidelines. Option C (Global Template) applies at page creation but doesn''t keep content synced afterward. Option D (Page Mention) just creates a link, forcing the reader to click away from the PRD, which disrupts the reading experience.',
        ARRAY['synced_blocks', 'documentation', 'page_layout']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a Linked Database view of the Trust & Safety wiki and embed it in the PRD.', false),
    (v_q_id, 'B', 'Turn the guidelines into a Synced Block on the wiki and paste the synced block into the PRD.', true),
    (v_q_id, 'C', 'Create a Global Template for the guidelines and insert it into both pages.', false),
    (v_q_id, 'D', 'Use an @mention of the Trust & Safety page so the text automatically pulls into the PRD.', false);

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
        'Netflix''s Confidential Launch',
        E'Netflix is secretly developing a gaming service. The PM creates a ''Gaming Roadmap'' page inside the main Product Teamspace. However, this page must remain strictly confidential and visible only to the five PMs on the gaming pod. What is the most robust way to configure this in Notion?',
        'foundational',
        'Netflix',
        'Access Management',
        'C',
        'Option C is correct. To make a page private within a shared workspace or teamspace, you must explicitly remove access for the broader group (Workspace or Teamspace members) in the Share menu, and then selectively invite the individuals who need access. Option A hides it from the UI but it remains accessible via search. Option B is incorrect because password protection isn''t a native Notion page feature. Option D is incorrect because restricting editing doesn''t prevent viewing.',
        ARRAY['permissions', 'workspace_management', 'security']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Remove the page from the Teamspace sidebar and share the direct URL with the five PMs.', false),
    (v_q_id, 'B', 'Add a password protection block to the top of the page before adding content.', false),
    (v_q_id, 'C', 'Open the Share menu, remove ''Product Teamspace'' access, and manually invite the five PMs.', true),
    (v_q_id, 'D', 'Set the workspace default permissions to ''Can Comment'' and give the five PMs ''Full Access''.', false);

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
        'Uber''s Personal Backlog',
        E'Uber''s Core Dispatch team uses a master Notion database for all engineering tasks. A PM wants a dedicated view that only shows tasks assigned to them, grouped by status. They want to check this daily without disrupting the default view used during team standups. What should the PM do?',
        'foundational',
        'Uber',
        'Task Management',
        'A',
        'Option A is correct. A Linked View of a database allows the PM to create a custom view (filtered, sorted, grouped) anywhere in their private workspace without affecting the original database''s views. Option B duplicates the data, breaking the sync (if the PM updates a task, it won''t update for the team). Option C alters the main database for everyone. Option D is a view on the main DB, which clutters the team''s shared view dropdown.',
        ARRAY['linked_databases', 'database_views', 'filtering']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a Linked View of the database on their private dashboard and apply a ''Me'' filter.', true),
    (v_q_id, 'B', 'Duplicate the master database to their private workspace and filter it by their name.', false),
    (v_q_id, 'C', 'Add a filter to the default team view so it automatically shows tasks for the current logged-in user.', false),
    (v_q_id, 'D', 'Create a new private workspace and use the ''Move To'' function to transfer their tasks.', false);

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
        'Airbnb''s Interview Notes',
        E'An Airbnb PM conducts weekly user interviews. Every interview notes page needs the same structure: ''Participant Info'', ''Key Pain Points'', and ''Feature Requests''. What is the most efficient way to enforce this structure for every new interview added to the ''User Research'' database?',
        'foundational',
        'Airbnb',
        'User Research',
        'D',
        'Option D is correct. Creating a Database Template allows the PM to define a standard page structure that can be instantiated with one click whenever a new entry is added to that specific database. Option A creates unnecessary manual work and clutter. Option B works for standalone pages but not efficiently for database items. Option C describes Synced Blocks, which mirror identical content, meaning typing notes in one interview would overwrite notes in all others.',
        ARRAY['database_templates', 'documentation', 'process_standardization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a ''Master Note'' page and duplicate it manually each time a new interview happens.', false),
    (v_q_id, 'B', 'Use the native ''Template Button'' block at the top of the workspace.', false),
    (v_q_id, 'C', 'Create a Synced Block containing the headers and paste it into every new database row.', false),
    (v_q_id, 'D', 'Create a Database Template within the ''User Research'' database containing the headers.', true);

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
        'Stripe''s Document Feedback',
        E'A PM at Stripe is finalizing a complex API spec in Notion. They need engineering to clarify one specific sentence in paragraph three. What is the most precise way to request this feedback within Notion?',
        'foundational',
        'Stripe',
        'Collaboration',
        'B',
        'Option B is correct. Highlighting specific text and adding a comment anchors the discussion directly to the sentence in question, providing precise context. Option A leaves a page-level comment, which forces the engineer to guess which sentence the PM means. Option C is destructive to the document''s flow. Option D is a generic notification that lacks specific document context.',
        ARRAY['collaboration', 'comments', 'documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a page-level comment at the top of the spec mentioning the engineer.', false),
    (v_q_id, 'B', 'Highlight the specific sentence, click ''Comment'', and @mention the engineer.', true),
    (v_q_id, 'C', 'Insert a red text block immediately below the sentence with the question.', false),
    (v_q_id, 'D', 'Share the page via Slack and tell the engineer to look at paragraph three.', false);

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
        'DoorDash''s Dynamic Default Templates',
        E'DoorDash has a ''Projects'' database. The PM creates two templates: ''Engineering Project'' and ''Marketing Project''. They want it so that whenever someone clicks the main ''New'' button on the database, it automatically uses the ''Engineering Project'' template, rather than creating a blank page. How is this configured?',
        'foundational',
        'DoorDash',
        'Templates',
        'D',
        'Option D is correct. In a Notion database, you can set a specific template as the ''Default''. This ensures that clicking the main ''New'' button automatically applies that template, standardizing data entry. Option A only works inside pages, not the DB button. Option B is a workaround. Option C is false.',
        ARRAY['database_templates', 'workflow', 'efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use the /template slash command on the main ''New'' button.', false),
    (v_q_id, 'B', 'Delete all other templates so Notion is forced to use the remaining one.', false),
    (v_q_id, 'C', 'It is impossible; users must manually select the template from the dropdown every time.', false),
    (v_q_id, 'D', 'Click the three dots next to the ''Engineering Project'' template and select ''Set as default''.', true);

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
        'Shopify''s Strategic Alignment',
        E'Shopify uses two separate Notion databases: ''Company OKRs'' and ''Product Initiatives''. A PM wants to explicitly link their new ''Checkout Redesign'' initiative to the ''Increase Conversion by 5%'' OKR, so stakeholders can click from the OKR directly to the initiative. What should the PM do?',
        'foundational',
        'Shopify',
        'Strategic Planning',
        'A',
        'Option A is correct. A Relation property establishes a two-way link between distinct databases, allowing items in one database to be explicitly tied to items in another. Option B only creates a hyperlink inside the page, not a structured database connection. Option C is for aggregating data, which requires a Relation to exist first. Option D is for mirroring content, not establishing structural relationships.',
        ARRAY['relations', 'database_properties', 'roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a Relation property to the ''Product Initiatives'' database and link it to ''Company OKRs''.', true),
    (v_q_id, 'B', 'Copy the URL of the OKR page and paste it into a URL property on the initiative.', false),
    (v_q_id, 'C', 'Use a Rollup property to pull the OKR title into the initiative database.', false),
    (v_q_id, 'D', 'Create a Synced Block connecting the two database pages.', false);

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
        'Figma''s Lengthy Specs',
        E'A PM at Figma writes highly detailed PRDs. Stakeholders often complain the documents are too long to scan quickly, though engineers need all the technical edge cases. How can the PM improve readability without deleting the technical details?',
        'foundational',
        'Figma',
        'PRD Design',
        'C',
        'Option C is correct. Toggle Lists (or Toggle Headings) allow content to be hidden by default and expanded on demand, making long documents scannable for executives while preserving deep detail for engineers. Option A fragments the document and breaks search/context. Option B uses code blocks inappropriately, which hurts readability. Option D is tedious and easily broken during editing.',
        ARRAY['page_layout', 'toggles', 'documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Move all technical details to a separate sub-page and link to it.', false),
    (v_q_id, 'B', 'Put all technical details inside Code Blocks so they visually separate.', false),
    (v_q_id, 'C', 'Use Toggle Headings or Toggle Lists to hide technical details until clicked.', true),
    (v_q_id, 'D', 'Change the text color of technical details to light gray so they are less noticeable.', false);

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
        'Discord''s Persona Gallery',
        E'A Discord PM is building a database of User Personas. Each persona has a high-quality illustration, a name, and a short bio. The PM wants the database to look highly visual, displaying the illustrations prominently like a directory. Which database view is most appropriate?',
        'foundational',
        'Discord',
        'User Personas',
        'D',
        'Option D is correct. The Gallery view is designed specifically to showcase visual content (like images or page covers) as prominent cards, making it ideal for a visual directory of personas. Option A is text-heavy and hides images. Option B organizes by workflow state, which isn''t relevant here. Option C focuses on chronological events.',
        ARRAY['database_views', 'gallery_view', 'user_research']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Table view.', false),
    (v_q_id, 'B', 'Board view.', false),
    (v_q_id, 'C', 'Timeline view.', false),
    (v_q_id, 'D', 'Gallery view.', true);

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
        'Zoom''s Roadmap Planning',
        E'A Zoom PM is planning the Q3 roadmap. They need to visualize when projects start and end, and ensure that ''Backend Architecture'' finishes before ''UI Implementation'' begins. Which Notion database view is built for this?',
        'foundational',
        'Zoom',
        'Roadmapping',
        'B',
        'Option B is correct. The Timeline view is Notion''s Gantt chart equivalent, built for visualizing start/end dates and supporting visual dependency lines between tasks. Option A only shows dates on a standard monthly grid without duration bars or dependency links. Option C organizes by status but ignores time. Option D is a simple list.',
        ARRAY['database_views', 'timeline_view', 'roadmapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Calendar view.', false),
    (v_q_id, 'B', 'Timeline view.', true),
    (v_q_id, 'C', 'Board view.', false),
    (v_q_id, 'D', 'List view.', false);

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
        'Robinhood''s Epic Progress',
        E'Robinhood uses two related Notion databases: ''Epics'' and ''Tasks''. An Epic contains multiple Tasks. A PM wants the Epic database to automatically display a progress bar showing the percentage of its related Tasks that are marked ''Done''. How should this be configured?',
        'intermediate',
        'Robinhood',
        'Progress Tracking',
        'A',
        'Option A is correct. A Rollup property pulls data across a Relation. By rolling up the ''Status'' property of the Tasks and configuring the calculate option to ''Percent per group'' (specifically targeting ''Done''), Notion will automatically generate a progress bar. Option B is incorrect because formulas cannot natively query related database rows without a rollup intermediary. Option C and D describe manual or non-existent features.',
        ARRAY['rollups', 'progress_tracking', 'relations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use a Rollup property targeting the Tasks'' ''Status'' column, set to calculate ''Percent per group'' (Done), and display as a bar.', true),
    (v_q_id, 'B', 'Use a Formula property with the function `calculateProgress(prop("Tasks"))`.', false),
    (v_q_id, 'C', 'Create a Synced Block in the Epic that manually updates based on Task completion.', false),
    (v_q_id, 'D', 'It is not possible; progress bars in Notion require third-party widgets.', false);

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
        'LinkedIn''s Dynamic Dashboard',
        E'A LinkedIn PM creates a ''Company Dashboard'' template. The dashboard includes a linked database view of ''All Action Items''. The PM wants the view to dynamically filter so that whenever *any* employee opens the dashboard, they only see tasks assigned to themselves. How should the filter be set?',
        'intermediate',
        'LinkedIn',
        'Dashboard Design',
        'D',
        'Option D is correct. Notion provides a dynamic ''Me'' token in filters for Person properties. When a filter is set to ''Assignee contains Me'', it evaluates against the currently logged-in user viewing the page. Option A filters for a static individual. Option B requires viewers to alter the dashboard layout, which is bad UX. Option C is not a valid native Notion filter function.',
        ARRAY['filtering', 'dynamic_views', 'dashboards']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Filter where Assignee is the PM''s specific name, and ask others to duplicate the page.', false),
    (v_q_id, 'B', 'Leave it unfiltered and instruct users to use the ''Sort'' button when they open it.', false),
    (v_q_id, 'C', 'Filter where Assignee is `currentUser()`.', false),
    (v_q_id, 'D', 'Filter where Assignee contains ''Me''.', true);

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
        'Pinterest''s Teamspace Security',
        E'Pinterest''s Growth team has a dedicated Teamspace in Notion. They want all employees at the company to be able to *see* what they are working on, but only Growth team members should be able to *edit* the pages within it. What Teamspace configuration achieves this?',
        'intermediate',
        'Pinterest',
        'Workspace Architecture',
        'B',
        'Option B is correct. An ''Open'' Teamspace allows anyone in the workspace to view it. By setting the default permissions so that ''Workspace members'' have ''Can view'' access and ''Teamspace members'' have ''Can edit'' access, you achieve transparent read-only access for the company while protecting editing rights. Option A locks out the rest of the company entirely. Option C is a contradiction. Option D is a manual nightmare.',
        ARRAY['teamspaces', 'permissions', 'governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the Teamspace to ''Private'' and invite the Growth team as editors.', false),
    (v_q_id, 'B', 'Set the Teamspace to ''Open'', give Workspace members ''Can view'', and Teamspace members ''Can edit''.', true),
    (v_q_id, 'C', 'Set the Teamspace to ''Closed'' and give everyone ''Full access''.', false),
    (v_q_id, 'D', 'Keep it Open, but manually lock every single page in the Teamspace.', false);

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
        'Duolingo''s Complex A/B Test Query',
        E'A PM at Duolingo is viewing the ''A/B Tests'' database. They want a view that shows tests that are EITHER (Owned by them AND Currently Active) OR (Have a ''Critical'' tag). How should the PM build this filter in Notion?',
        'intermediate',
        'Duolingo',
        'Data Filtering',
        'C',
        'Option C is correct. Notion supports Advanced Filters that allow nested logic using rule groups. To achieve this specific logic, the PM must create an OR group at the top level, with one condition being the ''Critical'' tag, and the other condition being a nested AND group for Ownership and Active status. Option A cannot handle nested boolean logic. Option B is a formula workaround that is inefficient. Option D describes database grouping, not filtering.',
        ARRAY['advanced_filters', 'boolean_logic', 'database_views']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apply three standard filters and set them all to ''Any''.', false),
    (v_q_id, 'B', 'Create a new formula column that evaluates the logic, then filter by that column.', false),
    (v_q_id, 'C', 'Use Advanced Filters to create an ''OR'' rule group containing an ''AND'' subgroup.', true),
    (v_q_id, 'D', 'Group the database by Tag and sub-group by Owner.', false);

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
        'Canva''s Release Calendar',
        E'Canva has a master ''Release Calendar'' database and a separate ''Feature Specs'' database. When a PM creates a new Feature Spec, they want to easily associate it with a specific Release week so that the Feature shows up inside the Release Calendar entry. What is the most robust setup?',
        'intermediate',
        'Canva',
        'Release Management',
        'A',
        'Option A is correct. A two-way relation property connects the Feature database to the Release Calendar. Adding the Relation as a property allows the PM to select the release from a dropdown. Option B is a Linked View, which embeds a database but doesn''t structurally tie the specific row to a release. Option C mentions a rollup without a relation, which is impossible. Option D only pastes a hyperlink.',
        ARRAY['relations', 'database_architecture', 'release_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a Relation property in ''Feature Specs'' linked to ''Release Calendar'' and select the release week.', true),
    (v_q_id, 'B', 'Insert a Linked View of the Release Calendar inside every Feature Spec template.', false),
    (v_q_id, 'C', 'Create a Rollup in ''Feature Specs'' that pulls dates from the Release Calendar.', false),
    (v_q_id, 'D', 'Mention the Release Calendar page directly in the title of the Feature Spec.', false);

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
        'Peloton''s Meeting Notes Sync',
        E'A Peloton PM leads three different cross-functional squads. They have a single ''Leadership Updates'' bulleted list that they want to appear at the top of all three squad''s respective meeting notes pages. If the PM updates the list from any of the three pages, it should update everywhere. What should they use?',
        'intermediate',
        'Peloton',
        'Meeting Management',
        'D',
        'Option D is correct. Synced Blocks are designed exactly for this use case: taking freeform block content (like a bulleted list) and mirroring it across multiple pages so edits in one location instantly reflect everywhere. Option A is for databases, not a simple bulleted list. Option B applies content once at creation time but doesn''t keep it synced. Option C requires manual user interaction.',
        ARRAY['synced_blocks', 'collaboration', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Linked Database view of the meeting notes.', false),
    (v_q_id, 'B', 'A Global Template applied to all three pages.', false),
    (v_q_id, 'C', 'A Toggle List that links out to a master document.', false),
    (v_q_id, 'D', 'A Synced Block placed on all three pages.', true);

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
        'Reddit''s Template Trap',
        E'A Reddit PM edits the ''Bug Report'' database template to add a new ''Browser Type'' select property, setting the default value in the template to ''Chrome''. However, they notice that all 500 existing bugs in the database did NOT get updated to ''Chrome''. Why?',
        'intermediate',
        'Reddit',
        'Bug Tracking',
        'B',
        'Option B is correct. In Notion, updating a Database Template only applies to *new* pages created using that template from that moment onward. It is not retroactive and does not bulk-update existing rows in the database. Option A is false; property values can be set in templates. Option C is false. Option D is a misunderstanding of how Notion properties work.',
        ARRAY['database_templates', 'data_management', 'troubleshooting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Database templates can only define page content (blocks), not property values.', false),
    (v_q_id, 'B', 'Database templates only apply to newly created pages, they do not retroactively update existing pages.', true),
    (v_q_id, 'C', 'The PM forgot to click the ''Sync to all pages'' button after editing the template.', false),
    (v_q_id, 'D', 'Select properties cannot have default values; only Text properties can.', false);

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
        'Dropbox''s Countdown Formula',
        E'A Dropbox PM has a ''Launch Date'' property (Date type) for marketing campaigns. They want a property that calculates the number of days between today and the Launch Date. Which Notion formula structure is correct?',
        'intermediate',
        'Dropbox',
        'Campaign Management',
        'C',
        'Option C is correct. In Notion''s formula language, `dateBetween()` is the standard function used to calculate the difference between two dates. `now()` returns the current date/time, and you specify the unit (''days'') as the third argument. Option A uses incorrect syntax. Option B uses subtraction which works for numbers but not date objects cleanly without formatting. Option D uses a non-existent function.',
        ARRAY['formulas', 'date_calculations', 'launch_readiness']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'days(prop(''Launch Date'') - today())', false),
    (v_q_id, 'B', 'prop(''Launch Date'') - now()', false),
    (v_q_id, 'C', 'dateBetween(prop(''Launch Date''), now(), ''days'')', true),
    (v_q_id, 'D', 'countdown(prop(''Launch Date''), ''days'')', false);

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
        'GitHub''s Notion Integration',
        E'A PM wants to track GitHub Pull Requests within a Notion database so the marketing team can see feature completion without logging into GitHub. The PM sets up a Synced GitHub Database in Notion. What limitation must the PM keep in mind?',
        'intermediate',
        'GitHub',
        'Cross-tool Integration',
        'A',
        'Option A is correct. Synced databases in Notion (like the GitHub integration) are currently one-way syncs or read-only on the Notion side for the synced properties. You cannot change the status of a GitHub PR from within the Notion database; it must be changed in GitHub. Option B is false; it syncs continuously. Option C is false; you can add custom Notion properties to synced databases. Option D is false.',
        ARRAY['integrations', 'synced_databases', 'tooling_limitations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The synced properties are read-only in Notion; you cannot change a PR''s status from Notion.', true),
    (v_q_id, 'B', 'The database only syncs once every 24 hours and cannot be refreshed manually.', false),
    (v_q_id, 'C', 'You cannot add any native Notion properties (like a Marketing Owner) to a Synced Database.', false),
    (v_q_id, 'D', 'The integration requires every Notion user to have a paid GitHub Enterprise seat.', false);

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
        'Slack''s Public Roadmap',
        E'Slack wants to share a specific ''Q4 Public Roadmap'' Notion page with their external user base. The PM clicks ''Share to web'' and toggles it on. What security risk should the PM immediately verify before distributing the link?',
        'intermediate',
        'Slack',
        'External Sharing',
        'C',
        'Option C is correct. When sharing a page to the web, any linked databases or sub-pages within that page will also become public. If the PM linked to an internal ''Engineering Tasks'' database, external users might be able to click through and view confidential tasks. Option A is a feature you can toggle off. Option B is false; editing requires specific permissions. Option D is a misunderstanding of Notion''s index settings.',
        ARRAY['permissions', 'external_sharing', 'security']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'That external users will be charged a guest fee for viewing the page.', false),
    (v_q_id, 'B', 'That anyone with the link can automatically edit the page content.', false),
    (v_q_id, 'C', 'That the page does not contain Linked Views to internal databases, which might expose restricted data.', true),
    (v_q_id, 'D', 'That the page will immediately be indexed by Google and appear in search results within minutes.', false);

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
        'Atlassian''s Automated Status',
        E'An Atlassian PM wants a ''Health'' formula property on their projects. If the ''Due Date'' is past today AND the ''Status'' is not ''Done'', the formula should output ''🔴 At Risk''. Otherwise, it should output ''🟢 On Track''. Which formula concept is required?',
        'intermediate',
        'Atlassian',
        'Project Health',
        'A',
        'Option A is correct. An `if()` statement (or ternary operator) combined with logical operators (`and`) is required to evaluate conditions and output different text strings based on the result. Option B is a mapping function for arrays. Option C is for regular expressions. Option D is for aggregating related data, not conditional logic.',
        ARRAY['formulas', 'conditional_logic', 'project_health']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'An if() statement combined with logical operators (and).', true),
    (v_q_id, 'B', 'A map() function iterating over the properties.', false),
    (v_q_id, 'C', 'A replaceAll() function targeting the Status string.', false),
    (v_q_id, 'D', 'A rollup property with a custom conditional calculate.', false);

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
        'Salesforce''s Sub-task Counting',
        E'Salesforce uses a Notion database for Epics and a separate one for Stories. They are connected via a Relation. A PM wants to see a simple integer count of *only* the Stories marked ''Done'' attached to each Epic. How can they achieve this?',
        'intermediate',
        'Salesforce',
        'Database Architecture',
        'B',
        'Option B is correct. In Notion, you cannot apply a filter directly inside a Rollup configuration to only count a subset. You must create a formula in the child database (Stories) that outputs ''1'' if Done (or true/false), and then Rollup *that* specific formula property to SUM the values. Option A is a hallucinated feature. Option C requires manual work. Option D counts all related items, not just the ''Done'' ones.',
        ARRAY['rollups', 'formulas', 'workarounds']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use a Rollup property, select the ''Status'' column, and apply a filter for ''Done'' within the Rollup settings.', false),
    (v_q_id, 'B', 'Create a Formula in the Stories database checking if Status is Done, then Rollup that formula in the Epic database.', true),
    (v_q_id, 'C', 'Use a Relation property and manually count the bubbles that appear in the cell.', false),
    (v_q_id, 'D', 'Use a Rollup property and set calculate to ''Count values''.', false);

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
        'Etsy''s Board Sub-grouping',
        E'An Etsy PM is looking at a Board view of user research tasks grouped by ''Status'' (To-do, Doing, Done). The board is overwhelmingly large. They want to visually separate the tasks in each column by ''Research Methodology'' (Survey, Interview, Usability Test) while keeping the Status columns intact. What feature should they use?',
        'intermediate',
        'Etsy',
        'View Organization',
        'C',
        'Option C is correct. Notion''s ''Sub-group'' feature allows you to add a secondary horizontal grouping to a Board view. Grouping by Status creates vertical columns, and Sub-grouping by Methodology creates horizontal swimlanes, organizing the large board perfectly. Option A just limits what is seen. Option B sorts within columns but doesn''t create visual dividers. Option D changes the primary columns, losing the Status view.',
        ARRAY['database_views', 'board_view', 'sub_grouping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apply an advanced filter for Methodology.', false),
    (v_q_id, 'B', 'Add a Sort rule based on Methodology.', false),
    (v_q_id, 'C', 'Enable ''Sub-group'' in the view options and select Methodology.', true),
    (v_q_id, 'D', 'Change the primary Group By property from Status to Methodology.', false);

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
        'Booking.com''s Grouped Backlog',
        E'A PM at Booking.com manages a massive Table view backlog. To make sprint planning easier, they want the table to be visually broken down into collapsible sections based on the ''Epic'' relation property. How should they configure the view?',
        'intermediate',
        'Booking.com',
        'Backlog Management',
        'B',
        'Option B is correct. In a Table view, the ''Group'' feature takes a property (like a Relation to an Epic) and creates horizontal, collapsible sections for each value. This makes massive tables scannable. Option A only changes the order of rows. Option C describes Board view sub-grouping, not Table view grouping. Option D hides rows instead of organizing them.',
        ARRAY['database_views', 'table_view', 'grouping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apply a Multi-sort, sorting first by Epic, then by Priority.', false),
    (v_q_id, 'B', 'Use the ''Group'' feature in the view options and select the Epic property.', true),
    (v_q_id, 'C', 'Enable Sub-groups and select the Epic property.', false),
    (v_q_id, 'D', 'Apply an Advanced Filter where Epic ''is not empty''.', false);

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
        'Tinder''s Action Buttons',
        E'A Tinder PM wants to streamline the process of logging new competitor analyses. Instead of navigating to the database and clicking ''New'', they want a single button on their homepage that instantly generates a new page in the Competitor database with the template already applied. What feature enables this?',
        'intermediate',
        'Tinder',
        'Workflow Automation',
        'D',
        'Option D is correct. Notion''s Native Button blocks can be configured to perform specific actions, including ''Add page to [Database]''. You can specify which template to apply and even pre-fill properties, creating a true 1-click workflow. Option A requires the Notion API. Option B is outdated (Template Buttons were replaced/upgraded by the new Button block for database actions). Option C creates empty linked databases.',
        ARRAY['buttons', 'automations', 'efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Notion API Webhooks.', false),
    (v_q_id, 'B', 'The legacy Template Button block.', false),
    (v_q_id, 'C', 'A Linked Database view filtered to ''Empty''.', false),
    (v_q_id, 'D', 'A native Button block configured to ''Add page to'' the specific database.', true);

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
        'TikTok''s Feedback Resolution',
        E'A TikTok PM receives heavy feedback from Legal via comments on a Notion PRD. After addressing the feedback, the PM wants to clear the comments from the margin but ensure they are saved for the compliance audit trail later. What is the correct action?',
        'intermediate',
        'TikTok',
        'Review Process',
        'A',
        'Option A is correct. ''Resolving'' a comment thread removes it from the active margin UI but archives it in the page''s comment history, making it retrievable for audits. Option B permanently destroys the record. Option C hides it but doesn''t log it as addressed. Option D is an unnecessary manual workaround.',
        ARRAY['comments', 'collaboration', 'compliance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Click the checkmark to ''Resolve'' the comment thread.', true),
    (v_q_id, 'B', 'Delete the comment thread.', false),
    (v_q_id, 'C', 'Change the comment text color to white.', false),
    (v_q_id, 'D', 'Copy the comments into a separate ''Archive'' database and delete the originals.', false);

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
        'Cash App''s Assignee Mention',
        E'A PM at Cash App writes a task list in a standard text block (not a database). They type ''@Jane Doe, please review the compliance section.'' What is the functional limitation of doing this compared to assigning Jane in a database ''Person'' property?',
        'intermediate',
        'Cash App',
        'Task Assignment',
        'C',
        'Option C is correct. @mentioning someone in plain text sends them a notification, but it does not structure the data. You cannot build a dashboard that filters or queries for ''@mentions'' across text blocks. A Person property in a database allows for robust querying, filtering, and rolling up of assignments. Option A is false; notifications are sent. Option B is false. Option D is false.',
        ARRAY['mentions', 'person_property', 'data_structure']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Jane will not receive an inbox notification for an @mention in plain text.', false),
    (v_q_id, 'B', 'Plain text @mentions expire after 30 days.', false),
    (v_q_id, 'C', 'The assignment cannot be queried, filtered, or aggregated in dynamic database views.', true),
    (v_q_id, 'D', 'Only workspace owners can use @mentions in plain text.', false);

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
        'DoorDash''s Metric Calculation',
        E'A DoorDash PM tracks A/B test results in a Notion database. The database has columns for ''Control Conversions'' (Number) and ''Variant Conversions'' (Number). The PM wants a column that automatically calculates the percentage difference between the two. Which Notion feature is required?',
        'intermediate',
        'DoorDash',
        'Experimentation',
        'C',
        'Option C is correct. A Formula property is required to perform mathematical operations (like calculating percentage difference) between other properties within the same database row. Option A is for summarizing data from related databases. Option B is incorrect as Number properties hold static values, not logic. Option D is used to connect different databases, not to calculate math.',
        ARRAY['formulas', 'database_properties', 'analytics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Rollup property configured to ''Calculate difference''.', false),
    (v_q_id, 'B', 'A Number property with the format set to ''Percent''.', false),
    (v_q_id, 'C', 'A Formula property.', true),
    (v_q_id, 'D', 'A Relation property connecting the two columns.', false);


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
        'Amazon''s Multi-Layer Rollup Trap',
        E'An Amazon PM has three databases: OKRs -> Epics -> Tasks (connected via Relations). They roll up the Task ''Status'' to the Epic level to show Epic progress. Now, they want to roll up the Epic progress to the OKR level. They cannot find the Epic progress rollup in the OKR rollup menu. Why?',
        'advanced',
        'Amazon',
        'Database Architecture',
        'A',
        'Option A is correct. A fundamental limitation in Notion''s architecture is that you cannot directly roll up a Rollup property. To pass aggregated data up a multi-tier hierarchy (Tasks -> Epics -> OKRs), you must create a Formula property at the Epic level that simply references the Epic Rollup, and then roll up *that* formula to the OKR level. Option B is false. Option C is false. Option D is false.',
        ARRAY['rollups', 'database_architecture', 'limitations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Notion does not allow you to roll up a Rollup property directly; an intermediary formula is required.', true),
    (v_q_id, 'B', 'Multi-layer rollups require an Enterprise plan subscription.', false),
    (v_q_id, 'C', 'The PM must enable ''Recursive Relations'' in the workspace settings.', false),
    (v_q_id, 'D', 'The Epic database has exceeded the maximum allowed relation connections.', false);

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
        'Vercel''s Advanced API Sync',
        E'Vercel wants to build a custom integration that reads support tickets from Zendesk and creates matching rows in a Notion database. Which authentication mechanism must the PM ensure the engineering team uses to securely interact with the Notion API?',
        'advanced',
        'Vercel',
        'API Integration',
        'D',
        'Option D is correct. To use the Notion API, you must create an Integration in the Notion workspace settings, generate an Internal Integration Token (or use OAuth for public apps), and explicitly share the specific Notion database with that Integration bot. Option A is insecure and unsupported. Option B is not how Notion''s API auth works. Option C is a generic web concept, not Notion''s specific requirement.',
        ARRAY['api', 'integrations', 'security']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A shared username and password embedded in the Zendesk script.', false),
    (v_q_id, 'B', 'A Workspace Owner''s personal session cookie.', false),
    (v_q_id, 'C', 'A generic Webhook URL with no auth headers.', false),
    (v_q_id, 'D', 'An Integration Token and explicitly sharing the target database with the Integration bot.', true);

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
        'Stripe''s Formula 2.0 Mapping',
        E'A Stripe PM uses Notion''s new Formula 2.0. They have an Epic linked to multiple Tasks via a relation property called ''Tasks''. They want a formula that extracts just the names of the Tasks and outputs them as a comma-separated list. Which formula achieves this?',
        'advanced',
        'Stripe',
        'Formula 2.0',
        'B',
        'Option B is correct. Formula 2.0 introduces array manipulation. To get properties from a relation, you use `prop("Relation").map(current.prop("Target Property"))`. The `map()` function iterates over the relation array, `current` refers to the current item in the loop, and `.join(", ")` turns the resulting array of strings into a comma-separated list. Option A is invalid syntax. Option C is Formula 1.0 logic. Option D is invalid.',
        ARRAY['formulas', 'arrays', 'data_manipulation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'extractText(prop(''Tasks''), ''Name'')', false),
    (v_q_id, 'B', 'prop(''Tasks'').map(current.prop(''Name'')).join('', '')', true),
    (v_q_id, 'C', 'rollup(prop(''Tasks''), ''Name'', ''Show original'')', false),
    (v_q_id, 'D', 'prop(''Tasks'').format(''Name'')', false);

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
        'Shopify''s Self-Referential Relation',
        E'A Shopify PM wants to break large User Stories into smaller Sub-tasks without creating a separate database. They want both Stories and Sub-tasks to live in the same ''Master Backlog'' database. How should they structure this?',
        'advanced',
        'Shopify',
        'Database Architecture',
        'C',
        'Option C is correct. Notion allows a database to relate to itself. By creating a self-referential relation and selecting ''Sync both ways'' (often named Parent Item / Sub-item), you can create hierarchical parent/child relationships within a single database. This is how Notion''s native ''Sub-items'' feature functions under the hood. Option A requires multiple databases. Option B is for text styling. Option D creates duplicate unlinked data.',
        ARRAY['relations', 'sub_items', 'database_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a new database for Sub-tasks and use a Rollup to connect them.', false),
    (v_q_id, 'B', 'Use indented toggle lists within the ''Name'' property column.', false),
    (v_q_id, 'C', 'Create a Relation property that links the database to itself, syncing both ways.', true),
    (v_q_id, 'D', 'Duplicate the row and rename it with a ''Sub-task:'' prefix.', false);

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
        'Netflix''s Permission Limitations',
        E'A PM at Netflix is building a ''Salary & Comp'' database for their team. Everyone needs to see the rows to know who the team members are, but the ''Salary'' property column must only be visible to managers. The PM tries to restrict access to just that column but fails. Why?',
        'advanced',
        'Netflix',
        'Security Limitations',
        'B',
        'Option B is correct. This is a critical PM trap in Notion: Notion does NOT support property-level (column-level) permissions. If a user can see a database row, they can see all properties on that row. To hide salary data, the PM must split the architecture into two separate databases (one public directory, one private comp DB) linked by a relation, and restrict the comp DB. Option A, C, and D describe fake features.',
        ARRAY['permissions', 'limitations', 'database_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They need to upgrade to the Enterprise plan for column-level security.', false),
    (v_q_id, 'B', 'Notion does not support property-level permissions; if you can see a row, you can see all its properties.', true),
    (v_q_id, 'C', 'They must use a Formula property to mask the data based on the viewer''s role.', false),
    (v_q_id, 'D', 'They need to lock the database view to prevent users from scrolling horizontally.', false);

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
        'Spotify''s Automated Assignment',
        E'A Spotify PM manages a ''Content Intake'' database. When a writer changes a draft''s status to ''Ready for Review'', the PM wants Notion to automatically assign the ''Reviewer'' property to the Lead Editor. How can this be done natively in Notion?',
        'advanced',
        'Spotify',
        'Workflow Automation',
        'C',
        'Option C is correct. Notion''s native Database Automations allow you to set triggers (e.g., ''When Status changes to Ready for Review'') and actions (e.g., ''Update property Reviewer to Lead Editor''). Option A is for static defaults at creation, not dynamic updates. Option B requires third-party tools (Zapier/Make). Option D is for calculation, not mutating other properties.',
        ARRAY['automations', 'workflow', 'database_features']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the default value of the Reviewer property to the Lead Editor in the template.', false),
    (v_q_id, 'B', 'This is impossible natively; it requires a Zapier or Make integration.', false),
    (v_q_id, 'C', 'Use native Database Automations with a trigger on Status change and an action to set the Person property.', true),
    (v_q_id, 'D', 'Write a Formula in the Reviewer property to output the Lead Editor''s name.', false);

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
        'Uber''s Robust Tagging Architecture',
        E'Uber''s research team has 500+ research insights. They currently use a ''Multi-select'' property for tags (e.g., #rider-app, #pricing). The PM wants to start tracking a ''Definition'' and an ''Owner'' for each tag to maintain taxonomy governance. Why must they migrate away from the Multi-select property?',
        'advanced',
        'Uber',
        'Taxonomy & Architecture',
        'A',
        'Option A is correct. Multi-select properties are simple text strings with colors; they cannot hold metadata (like definitions or owners). To add metadata to tags, the PM must create a separate ''Global Tags'' database, convert the tags into database pages, and use a Relation property to connect the insights to the tags. Option B, C, and D represent misunderstandings of Notion''s data structures.',
        ARRAY['relations', 'database_architecture', 'taxonomy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Multi-select options are flat data; they cannot contain secondary properties like owners or definitions. A relational database is required.', true),
    (v_q_id, 'B', 'Multi-select properties are limited to a maximum of 50 tags per workspace.', false),
    (v_q_id, 'C', 'Multi-select properties cannot be used in Advanced Filters for reporting.', false),
    (v_q_id, 'D', 'Multi-select properties cannot be searched globally in the workspace.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Notion';

END $$;
