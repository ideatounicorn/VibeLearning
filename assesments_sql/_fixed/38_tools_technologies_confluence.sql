-- ============================================
-- ASSESSMENT: Confluence
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
    WHERE slug = 'confluence';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug confluence not found. Run the seed data first.';
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
        'Shopify''s PRD Template',
        E'A Shopify PM is starting to write a PRD for a new "One-Click Checkout" feature. They want to ensure consistency with other Shopify PRDs and make sure all standard sections (Goals, Non-Goals, User Stories) are included without manually copying and pasting formatting. What is the most efficient way to start this document in Confluence?',
        'foundational',
        'Shopify',
        'PM starting a new checkout feature',
        'B',
        'Using Confluence templates (Option B) is the standard PM practice to ensure consistency, automatically populate required sections (Goals, Non-Goals), and include pre-configured macros like Page Properties. Option A is tedious and prone to formatting errors. Option C is incorrect because ''Include Page'' embeds the live content of the old PRD; editing it would change the original document or be impossible if read-only. Option D defeats the purpose of collaborative, cloud-based wiki software.',
        ARRAY['prd_creation', 'templates', 'standardization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Copy the raw HTML of an existing PRD and paste it into a blank page.', false),
    (v_q_id, 'B', 'Use the global "Product Requirements Document" template when creating the new page.', true),
    (v_q_id, 'C', 'Create a blank page and use the Include Page macro to embed an old PRD.', false),
    (v_q_id, 'D', 'Export an existing PRD to Word, edit it, and upload it as an attachment.', false);

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
        'Netflix''s Jira Integration',
        E'A Netflix PM has completed the PRD for a new "Skip Intro" animation. Engineering is tracking the implementation in Jira. The PM wants the Confluence PRD to automatically display the real-time status (To Do, In Progress, Done) of the overarching Jira Epic. How should they achieve this?',
        'foundational',
        'Netflix',
        'Linking PRD to engineering execution',
        'C',
        'The Jira Issues macro (Option C) creates a dynamic link between Confluence and Jira, pulling in real-time data like status, assignee, and resolution. This ensures the PRD acts as a living document reflecting actual engineering progress. Option A is unscalable and guarantees the document will become stale. Option B is overly complex and displays too much noise (the entire board) rather than the specific Epic. Option D is a static snapshot that instantly becomes outdated.',
        ARRAY['jira_integration', 'macros', 'traceability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Manually type the status at the top of the PRD and update it daily.', false),
    (v_q_id, 'B', 'Embed an iframe of the entire Jira board at the bottom of the page.', false),
    (v_q_id, 'C', 'Insert the Jira Issues macro and link it to the specific Epic key.', true),
    (v_q_id, 'D', 'Export the Jira ticket as a PDF and attach it to the page.', false);

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
        'Spotify''s Page History',
        E'A Spotify PM is co-editing a PRD for "AI DJ" with three other stakeholders. They realize that a crucial section detailing the monetization strategy was accidentally deleted two days ago, but many other valid changes have been made since then. How should the PM retrieve the lost section?',
        'foundational',
        'Spotify',
        'Recovering from accidental edits',
        'B',
        'Viewing the Page History (Option B) allows a PM to compare versions, see exactly what was removed, and copy the necessary text without losing the legitimate work done over the last two days. Option A is destructive and would erase two days of valid collaboration from other stakeholders. Option C is incorrect because the recycle bin stores deleted pages, not deleted snippets of text. Option D is irrelevant, as Page Properties Reports aggregate metadata across pages, not historical page states.',
        ARRAY['version_control', 'page_history', 'collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Revert the page to the version from two days ago, discarding all recent changes.', false),
    (v_q_id, 'B', 'Go to Page History, view the version from two days ago, copy the deleted text, and paste it into the current version.', true),
    (v_q_id, 'C', 'Check the Confluence recycle bin for the deleted text snippet.', false),
    (v_q_id, 'D', 'Use the Page Properties Report macro to pull the previous version''s metadata.', false);

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
        'Airbnb''s Async Review',
        E'An Airbnb PM has drafted a proposal for "Host Protection Insurance." They share the Confluence page with Legal and Finance for async review. The Legal team has a specific concern about one sentence in the "Liability" section and wants to start a threaded discussion about that specific text. What Confluence feature should Legal use?',
        'foundational',
        'Airbnb',
        'Gathering feedback on a draft',
        'B',
        'Inline comments (Option B) allow reviewers to highlight specific text and start contextual, threaded discussions without altering the actual document content. This is the gold standard for async PM reviews. Option A forces the PM to hunt for the context of the comment. Option C is a poor practice because it litters the source document with meta-commentary, making it hard to read. Option D is meant for author-driven callouts, not for stakeholder feedback and discussion.',
        ARRAY['async_collaboration', 'inline_comments', 'stakeholder_review']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a comment at the very bottom of the page referencing the paragraph.', false),
    (v_q_id, 'B', 'Highlight the specific sentence and add an inline comment.', true),
    (v_q_id, 'C', 'Edit the page and write their feedback in bold red text next to the sentence.', false),
    (v_q_id, 'D', 'Use the Info macro to insert a warning box above the paragraph.', false);

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
        'Uber''s Page Hierarchy',
        E'An Uber PM is taking over the "Driver Earnings" product area. Currently, all 50+ PRDs, meeting notes, and technical specs are sitting at the root level of the team''s space, making it impossible to find anything. What is the most effective immediate step to improve discoverability?',
        'foundational',
        'Uber',
        'Structuring documentation',
        'B',
        'Confluence relies on a parent-child page tree structure (Option B) to organize content logically and provide natural navigation paths. Grouping pages under relevant parent pages instantly improves the architecture. Option A abandons the tool entirely and breaks all existing links. Option C is a band-aid that doesn''t solve the structural chaos and misuses labels. Option D is destructive and could delete vital historical context without review.',
        ARRAY['page_tree', 'information_architecture', 'discoverability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Export all pages to Google Drive and organize them into folders.', false),
    (v_q_id, 'B', 'Create a hierarchical page tree (e.g., parent pages for ''PRDs'', ''Meeting Notes'') and nest the existing pages underneath them.', true),
    (v_q_id, 'C', 'Add the "Urgent" label to the most important pages and leave the rest alone.', false),
    (v_q_id, 'D', 'Delete any page older than 6 months to reduce clutter.', false);

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
        'Stripe''s Status Communication',
        E'A Stripe PM is maintaining a launch dashboard in Confluence for a new API endpoint. They need to clearly indicate that the "Security Audit" phase is currently "At Risk" so executives scanning the page notice it immediately. What is the best Confluence feature to use?',
        'foundational',
        'Stripe',
        'Documenting project health',
        'B',
        'The Status macro (Option B) provides standardized, visually distinct lozenges that are universally understood in Confluence and can be easily updated. It ensures consistent visual communication of project health. Option A is subtle and relies on formatting that might be overlooked or stripped out. Option C is unscalable, visually messy, and non-standard. Option D will spam the executives with notifications rather than just providing a scannable dashboard.',
        ARRAY['status_macro', 'visual_communication', 'dashboards']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the font color of the text "At Risk" to red.', false),
    (v_q_id, 'B', 'Use the Status macro to create a colored, highly visible pill (e.g., red ''AT RISK'').', true),
    (v_q_id, 'C', 'Insert an image of a red stop sign next to the text.', false),
    (v_q_id, 'D', 'Mention (@) the executive team next to the word "At Risk".', false);

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
        'Discord''s Page Restrictions',
        E'A Discord PM is drafting a sensitive PRD for a new "Voice Modulation" feature. The PM wants to work on it collaboratively with the engineering lead, but wants to hide the page from the broader company until the concept is validated. How should they configure the page?',
        'foundational',
        'Discord',
        'Protecting draft content',
        'C',
        'Page restrictions (Option C) allow granular access control at the individual page level, perfect for keeping early drafts private to a small working group before wider release. Option A is incorrect because Personal Spaces can be shared, and moving pages later breaks links. Option B does not prevent people from reading or sharing the sensitive document. Option D is a false assumption; pages without labels are still fully indexed by Confluence search and will appear in the activity feed.',
        ARRAY['page_restrictions', 'security', 'draft_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Put the page in their Personal Space, which no one else can ever access.', false),
    (v_q_id, 'B', 'Add a "Draft" watermark to the page so others know not to read it.', false),
    (v_q_id, 'C', 'Apply page restrictions to allow "View and Edit" only for themselves and the engineering lead.', true),
    (v_q_id, 'D', 'Publish the page but don''t add any labels, making it unsearchable.', false);

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
        'Zoom''s Meeting Notes',
        E'After a weekly product sync, a Zoom PM is writing the meeting notes in Confluence. They need to assign an action item to a designer to "Update the mockups by Friday." What is the best way to do this so the designer is notified and the task is tracked?',
        'foundational',
        'Zoom',
        'Action item tracking',
        'B',
        'Confluence''s native Action Items (Option B) integrate with notifications and the user''s personal task list. Using @mentions ensures they are alerted, and the `//` command sets a standard due date. Option A provides no notification or tracking. Option C requires context switching and loses the single source of truth in the notes. Option D is massive overkill; a mockup update is a task or sub-task, not a Jira Epic.',
        ARRAY['action_items', 'task_management', 'meeting_notes']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Bold the designer''s name and write the task next to it.', false),
    (v_q_id, 'B', 'Create an Action Item (task checkbox), @mention the designer, and add the due date (//).', true),
    (v_q_id, 'C', 'Send a Slack message to the designer with a link to the Confluence page.', false),
    (v_q_id, 'D', 'Use the Jira macro to create a new Epic for the task.', false);

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
        'Figma''s Single Source of Truth',
        E'A Figma PM has written a comprehensive "Q3 Product Vision" paragraph. This paragraph needs to appear at the top of 5 different feature PRDs. The PM wants to ensure that if the vision changes, they only have to update it in one place. Which Confluence feature should they use?',
        'foundational',
        'Figma',
        'Reusing content safely',
        'B',
        'The Excerpt and Excerpt Include macros (Option B) are specifically designed for single-sourcing content. You define the source once, embed it elsewhere, and any updates to the source automatically cascade to all included instances. Option A violates the DRY (Don''t Repeat Yourself) principle and guarantees outdated docs. Option C is used for aggregating metadata into a table, not reusing blocks of text. Option D misuses Jira for static document text, adding unnecessary overhead.',
        ARRAY['excerpt_macro', 'content_reuse', 'single_source_of_truth']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Copy and paste the text into all 5 pages.', false),
    (v_q_id, 'B', 'Put the text in an Excerpt macro on the main page, and use the Excerpt Include macro on the 5 PRDs.', true),
    (v_q_id, 'C', 'Use the Page Properties macro to link the pages.', false),
    (v_q_id, 'D', 'Create a Jira issue with the vision text and embed it in the PRDs.', false);

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
        'Duolingo''s Knowledge Organization',
        E'A Duolingo PM conducts 10 user interviews about a new "Math Course." They create a separate Confluence page for each interview''s notes. They want to easily pull all 10 pages into a summary report. What should they do to the 10 individual pages to enable this?',
        'foundational',
        'Duolingo',
        'Categorizing research',
        'A',
        'Labels (Option A) are metadata tags that allow PMs to categorize and dynamically group pages. The PM can then use the Content by Label macro on the summary page to automatically list all 10 interviews. Option B is structural overkill; you don''t create a new Space for a single batch of interviews. Option C affects security, not organization or aggregation. Option D is tedious and destroys the actual authorship history of who took the notes.',
        ARRAY['labels', 'metadata', 'content_aggregation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add the label "math-interviews-q3" to all 10 pages.', true),
    (v_q_id, 'B', 'Put all 10 pages in a brand new Confluence Space.', false),
    (v_q_id, 'C', 'Restrict the pages to only the research team.', false),
    (v_q_id, 'D', 'Change the author of all pages to the lead researcher.', false);

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
        'DoorDash Page Properties',
        E'A DoorDash Group PM oversees 12 different growth initiatives, each with its own PRD. The GPM wants to create a single "Portfolio Dashboard" page that displays a table showing the Status, Target Launch Date, and Lead PM for all 12 initiatives. How can they automate this table?',
        'intermediate',
        'DoorDash',
        'Portfolio reporting across multiple PRDs',
        'A',
        'The Page Properties and Page Properties Report macros (Option A) are built exactly for this. By embedding a hidden table (Page Properties) with standard rows (Status, Date) in each PRD, the Report macro dynamically aggregates them into a master portfolio view. Option B relies on Jira, but the question asks about data (like PRD status) that might only exist in Confluence drafts. Option C is manual, error-prone, and scales poorly. Option D would embed the entire content of all 12 PRDs, creating a massive, unreadable page.',
        ARRAY['page_properties', 'portfolio_management', 'reporting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use the Page Properties macro inside each PRD to store the data, and the Page Properties Report macro on the dashboard to pull it.', true),
    (v_q_id, 'B', 'Use the Jira Issues macro to pull the entire Epic backlog into Confluence.', false),
    (v_q_id, 'C', 'Manually create a table on the dashboard and @mention the PMs to update their row.', false),
    (v_q_id, 'D', 'Use the Include Page macro 12 times on the dashboard.', false);

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
        'HubSpot Content Lifecycle',
        E'A HubSpot PM inherits a Confluence space for the "Marketing Hub." A search for "Email API" returns 15 pages, but 12 of them are outdated specs from 2018. This is confusing engineers. What is the most responsible way to handle the old pages?',
        'intermediate',
        'HubSpot',
        'Managing stale documentation',
        'C',
        'Moving pages to a designated Archive structure and labeling them (Option C) preserves historical context (which might be needed for legacy bugs) while removing them from the active navigation and allowing search filters to exclude them. Option A destroys potentially valuable historical decisions. Option B leaves the pages in the active tree and search results, continuing to cause clutter. Option D breaks links for engineers who might actually need to reference the legacy behavior.',
        ARRAY['content_lifecycle', 'archiving', 'search_optimization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delete the 12 old pages permanently.', false),
    (v_q_id, 'B', 'Edit the old pages and write "DO NOT USE" at the top in large red letters.', false),
    (v_q_id, 'C', 'Move the 12 pages to an "Archive" parent page and add the "archived" label to exclude them from main search results.', true),
    (v_q_id, 'D', 'Change the page restrictions so only the PM can see the old pages.', false);

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
        'LinkedIn Epic Tracking',
        E'A LinkedIn PM is managing a complex "Creator Mode" launch. The Confluence PRD needs to show the breakdown of the 5 engineering Epics and their progress. The PM inserts the Jira Issues macro. What configuration is best to show this breakdown dynamically?',
        'intermediate',
        'LinkedIn',
        'Tracking complex engineering deliverables',
        'B',
        'Using JQL within the Jira Issues macro (Option B) dynamically pulls in exactly the relevant Epics and displays their live status and progress bars directly in the PRD. Option A is static; if a 6th Epic is added, the PRD won''t update. Option C shows sprint execution, which is too granular and short-term for a high-level PRD tracking Epics. Option D is too broad, showing departmental data rather than the specific feature''s breakdown.',
        ARRAY['jira_macro', 'jql', 'epic_tracking']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Paste the static URLs of the 5 Epics into the macro.', false),
    (v_q_id, 'B', 'Configure the macro with a JQL query (e.g., `project = CREATOR AND issuetype = Epic`) and display the ''Status'' and ''Progress'' columns.', true),
    (v_q_id, 'C', 'Embed a Jira gadget showing the entire sprint burn-down chart.', false),
    (v_q_id, 'D', 'Use the Jira Roadmap macro to show a Gantt chart of the entire department.', false);

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
        'Salesforce Space Architecture',
        E'Salesforce is restructuring its product organization. The PM Operations team needs to decide how to structure Confluence. They have core product documentation (PRDs), public-facing release notes, and casual team building/internal notes. What is the best Space architecture?',
        'intermediate',
        'Salesforce',
        'Designing high-level wiki structure',
        'B',
        'Confluence Spaces are intended to separate content with different audiences, permissions, and purposes (Option B). Release notes need external/broad access, while team operations are internal. Option A creates massive clutter and makes permission management a nightmare. Option C silos information by person rather than by product or function, ensuring knowledge is lost when a PM leaves. Option D is incredibly risky; a single mistake in page restrictions could expose confidential internal notes to the public.',
        ARRAY['space_architecture', 'governance', 'permissions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Put absolutely everything in one giant "Salesforce Product" Space for maximum discoverability.', false),
    (v_q_id, 'B', 'Create three separate Spaces: ''Product Specs'' (internal), ''Release Notes'' (public/external), and ''Team Operations'' (internal).', true),
    (v_q_id, 'C', 'Create a separate Space for every single PM.', false),
    (v_q_id, 'D', 'Use a single Space, but rely entirely on Page Restrictions to hide internal notes from the public.', false);

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
        'Canva Cross-Functional Hub',
        E'A Canva PM is launching "Video Backgrounds." Marketing, Legal, Support, and Engineering all need to reference the product details, but they also have their own specific launch checklists. How should the PM structure the Confluence documentation?',
        'intermediate',
        'Canva',
        'Coordinating multiple departments',
        'C',
        'A Hub-and-Spoke model (Option C) keeps the core product truth (the parent PRD) centralized while giving cross-functional teams dedicated child pages to manage their specific operational checklists. This keeps the PRD clean while maintaining a single, linked directory for the launch. Option A makes the document unreadable and overwhelming. Option B scatters the knowledge, causing alignment issues. Option D duplicates the entire document context unnecessarily and makes navigation harder.',
        ARRAY['cross_functional', 'page_hierarchy', 'hub_and_spoke']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Put all checklists and PRD details onto one incredibly long page.', false),
    (v_q_id, 'B', 'Have each team create documents in their own Spaces and email the links to the PM.', false),
    (v_q_id, 'C', 'Create a parent "Launch Hub" page with the core PRD, and create child pages for Marketing, Legal, and Support checklists.', true),
    (v_q_id, 'D', 'Use the Excerpt macro to embed the entire PRD into the Marketing Space.', false);

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
        'Pinterest Notifications',
        E'A Pinterest PM is finalizing the PRD for "Idea Pins." They have 20 stakeholders. Every time the PM fixes a minor typo, 20 people get an email notification, causing complaints. How should the PM update the PRD without spamming stakeholders?',
        'intermediate',
        'Pinterest',
        'Managing stakeholder communication noise',
        'B',
        'Confluence provides a "Notify watchers" toggle exactly for this scenario (Option B), allowing PMs to make minor formatting or typo fixes silently. Option A places the burden on the stakeholders and risks them forgetting to re-watch the page for major updates. Option C breaks the collaborative nature of Confluence and creates versioning chaos. Option D triggers even more notifications (permission change alerts) and temporarily breaks links for anyone trying to view the page.',
        ARRAY['notifications', 'stakeholder_management', 'editing_best_practices']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask all stakeholders to "unwatch" the page until launch.', false),
    (v_q_id, 'B', 'Uncheck the "Notify watchers" box at the bottom of the editor before publishing the minor change.', true),
    (v_q_id, 'C', 'Copy the text to Google Docs, edit it there, and paste it back once a week.', false),
    (v_q_id, 'D', 'Change the page restrictions to private, make the edits, and then make it public again.', false);

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
        'Robinhood Security Inheritance',
        E'A Robinhood PM is working on a highly confidential Crypto feature. They create a parent page called "Project Alpha" and restrict it to just the crypto leadership team. They then create a child page called "Technical Specs." What happens to the permissions of the child page?',
        'intermediate',
        'Robinhood',
        'Understanding permission cascading',
        'B',
        'In Confluence, view restrictions cascade down the page hierarchy (Option B). If a parent page is restricted to a group, all child pages are implicitly restricted to that same group, ensuring secure areas remain secure by default. Option A is factually incorrect and would be a massive security flaw. Option C is backwards; view restrictions are inherited, edit restrictions generally are not. Option D is incorrect; Confluence applies inheritance silently.',
        ARRAY['permissions', 'inheritance', 'security']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is publicly visible to everyone at Robinhood until explicitly restricted.', false),
    (v_q_id, 'B', 'It inherits the view restrictions of the parent page automatically.', true),
    (v_q_id, 'C', 'It inherits edit restrictions, but view restrictions must be set manually.', false),
    (v_q_id, 'D', 'Confluence prompts the PM to set permissions before saving the child page.', false);

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
        'Booking.com Blueprint Templates',
        E'Booking.com wants all PMs globally to use the exact same template for "Experiment Briefs" to ensure statistical rigor. They also want the template to automatically apply the label ''experiment-brief'' when created. What is the best administrative approach?',
        'intermediate',
        'Booking.com',
        'Enforcing global standards',
        'B',
        'Global Templates (Option B) allow administrators to standardize structure across the entire instance and can be pre-configured with labels, ensuring every new document starts with the correct metadata and formatting. Option A relies on human memory and will inevitably fail, leading to inconsistent data. Option C is an aggressive, hostile administrative practice. Option D is a misunderstanding of Page Properties, which stores data inside the page, not page-level metadata labels.',
        ARRAY['global_templates', 'labels', 'standardization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a standard page, ask PMs to copy/paste it, and manually type the label.', false),
    (v_q_id, 'B', 'Create a Global Template in Confluence Administration, format it, and pre-configure the label in the template settings.', true),
    (v_q_id, 'C', 'Write a script that checks all new pages and deletes them if they don''t have the label.', false),
    (v_q_id, 'D', 'Use the Page Properties macro to force PMs to enter a label.', false);

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
        'Peloton Onboarding',
        E'A Peloton PM is building an onboarding space for new Product Managers. They want a dynamic list that automatically shows the 5 most recently updated PRDs across the entire company so new hires can see what active work looks like. Which macro should they use?',
        'intermediate',
        'Peloton',
        'Creating dynamic dashboards',
        'A',
        'The Recently Updated macro (Option A) dynamically pulls in pages based on recency and can be filtered by labels (like ''PRD'') or spaces. This creates an automatic, self-refreshing feed of active work. Option B simply lists all pages alphabetically, which isn''t useful for seeing active work. Option C pulls Jira tickets, not Confluence pages. Option D is used for structural reporting, not a chronological feed of updates.',
        ARRAY['recently_updated_macro', 'dynamic_content', 'onboarding']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Recently Updated macro, filtered by the "PRD" label.', true),
    (v_q_id, 'B', 'The Page Index macro.', false),
    (v_q_id, 'C', 'The Jira Issues macro.', false),
    (v_q_id, 'D', 'The Content Report Table macro.', false);

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
        'GitHub Release Notes',
        E'A GitHub PM is preparing for the launch of "Copilot X". They need to generate customer-facing release notes in Confluence. They want to pull in the list of completed features directly from the Jira Sprint, but they only want to show the Summary and hide the internal engineering comments. How should they do this?',
        'intermediate',
        'GitHub',
        'Generating safe external documentation',
        'B',
        'The Jira Issues macro allows precise control over which fields (columns) are displayed (Option B). By selecting only the Summary field, the PM can expose the feature names without exposing internal engineering data or comments. Option A is manual and doesn''t update if a last-minute ticket is added to the release. Option C is static and creates an ugly UX. Option D is a massive security and professional risk, exposing internal agile workings to the public.',
        ARRAY['jira_macro', 'release_notes', 'field_configuration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Manually copy and paste the summaries from Jira to Confluence.', false),
    (v_q_id, 'B', 'Use the Jira Issues macro, write JQL for the completed sprint, and configure the Display Options to only show the ''Summary'' column.', true),
    (v_q_id, 'C', 'Export the Jira Sprint to Excel, delete the comment columns, and embed the spreadsheet.', false),
    (v_q_id, 'D', 'Grant all customers access to the Jira board so they can look it up themselves.', false);

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
        'Tinder Collaborative Editing',
        E'Two Tinder PMs are simultaneously editing the "Swipe Logic" PRD in Confluence. PM A is rewriting the goals, while PM B is adding a data table at the bottom. PM A''s internet connection drops. When they reconnect and try to publish, Confluence warns them of a conflict. What is the safest way to resolve this?',
        'intermediate',
        'Tinder',
        'Handling sync conflicts',
        'C',
        'When offline/sync conflicts occur, the safest method is to copy your unsaved localized changes (Option C), accept the server''s current state (which includes your colleague''s work), and then cleanly re-apply your specific changes. Option A wastes the PM''s time. Option B destroys the colleague''s work, leading to friction. Option D is a complete overreaction and destroys the page''s history and URL.',
        ARRAY['collaborative_editing', 'conflict_resolution', 'data_integrity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Click "Discard my changes" and rewrite the goals from scratch.', false),
    (v_q_id, 'B', 'Click "Overwrite" to force PM A''s version, deleting PM B''s table.', false),
    (v_q_id, 'C', 'View the changes, copy PM A''s draft text to the clipboard, refresh to get PM B''s version, and paste PM A''s text back in.', true),
    (v_q_id, 'D', 'Delete the page and start a new one to avoid database corruption.', false);

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
        'Reddit Decision Register',
        E'The Reddit product team makes dozens of rapid decisions about API pricing. Six months later, no one remembers *why* a specific pricing tier was chosen. The PM wants to track these choices systematically. Which Confluence pattern is best?',
        'intermediate',
        'Reddit',
        'Documenting historical decisions',
        'B',
        'The Decision template combined with the Page Properties Report (Option B) creates a standardized, searchable "Decision Register." It captures the context, alternatives considered, and the final call, while the master log makes it easy for future PMs to review the history. Option A is chaotic and unsearchable. Option C overloads a single ticket, making it unreadable. Option D guarantees the knowledge is lost to the wider team until the yearly export, defeating the purpose of a wiki.',
        ARRAY['decision_register', 'page_properties', 'templates']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a comment on the homepage every time a decision is made.', false),
    (v_q_id, 'B', 'Use the Decision template to create a page for each choice, and use a Page Properties Report to create a master Decision Log.', true),
    (v_q_id, 'C', 'Create a single Jira ticket called "API Pricing" and put all decisions in the description.', false),
    (v_q_id, 'D', 'Write the decisions in a private Slack channel and export it to Confluence yearly.', false);

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
        'Twilio Architecture Diagrams',
        E'A Twilio PM needs to include a complex API sequence diagram in their PRD. The engineering team uses Draw.io (or Gliffy) within Confluence. The PM wants to ensure that if engineering updates the diagram, the PRD always shows the latest version. What should they do?',
        'intermediate',
        'Twilio',
        'Embedding visual documentation',
        'B',
        'Using integrated diagramming macros like Draw.io or Gliffy (Option B) embeds the live diagram file into the page. If an engineer updates the source diagram, the PRD updates automatically. Option A requires manual uploads every time a change is made, guaranteeing the PRD will become outdated. Option C forces the reader to leave the PRD context. Option D is a terrible use of tables and cannot accurately represent a sequence diagram.',
        ARRAY['integrations', 'diagrams', 'live_embedding']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask engineering to export the diagram as a PNG and upload it to the PRD.', false),
    (v_q_id, 'B', 'Insert the Draw.io/Gliffy macro directly into the PRD and link it to the live diagram file.', true),
    (v_q_id, 'C', 'Paste a hyperlinked text URL pointing to the diagram.', false),
    (v_q_id, 'D', 'Re-draw the diagram using native Confluence tables.', false);

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
        'Vercel Anonymous Access',
        E'Vercel wants to use Confluence to host their public developer documentation. They want anyone on the internet to read it without needing an account, but only Vercel employees should be able to edit it. How is this configured?',
        'intermediate',
        'Vercel',
        'Exposing docs publicly',
        'A',
        'Confluence supports public documentation via Anonymous Access (Option A). An admin enables it globally, and then the space admin grants read-only rights to the ''Anonymous'' user group for that specific space. Option B is a security violation and violates licensing terms. Option C misuses tools and doesn''t host the actual Confluence site publicly. Option D is factually incorrect; Confluence is widely used for public knowledge bases.',
        ARRAY['anonymous_access', 'public_documentation', 'permissions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Enable Anonymous Access at the global level, and grant "View" permissions to anonymous users for the specific "Public Docs" Space.', true),
    (v_q_id, 'B', 'Create a generic username/password and post it on the Vercel homepage.', false),
    (v_q_id, 'C', 'Share the Confluence Space via a Google Drive public link.', false),
    (v_q_id, 'D', 'It is impossible; Confluence requires all viewers to have a paid license.', false);

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
        'Dropbox Retrospectives',
        E'After a failed launch at Dropbox, the PM runs a post-mortem and documents 15 action items across 5 different pages in the "Retrospectives" space. The Group PM wants a single dashboard showing all incomplete action items from all retrospectives. Which macro solves this?',
        'intermediate',
        'Dropbox',
        'Aggregating tasks across pages',
        'B',
        'The Task Report macro (Option B) aggregates native Confluence action items (checkboxes) across pages and spaces. Filtering it by status and space perfectly creates the requested operational dashboard. Option A is for metadata tables, not native checkboxes. Option C embeds chunks of text, not a dynamic list of tasks. Option D is for Jira tickets, but the prompt specified these were documented as action items within the Confluence pages.',
        ARRAY['task_report_macro', 'action_items', 'dashboards']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Page Properties Report macro.', false),
    (v_q_id, 'B', 'The Task Report macro, filtered by the "Retrospectives" space and "Incomplete" status.', true),
    (v_q_id, 'C', 'The Excerpt Include macro.', false),
    (v_q_id, 'D', 'The Jira Issues macro.', false);

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
        'Shopify Competitive Analysis',
        E'A Shopify PM is tracking 5 competitors. They create a Confluence page with a massive table comparing features. As the table grows to 50 rows, it becomes unreadable. The PM wants to allow stakeholders to click a column header (e.g., "Competitor A") to sort the data alphabetically. What should they do?',
        'intermediate',
        'Shopify',
        'Managing large data tables',
        'B',
        'Confluence natively supports sorting on tables (Option B) as long as the PM has designated the top row as a "Header Row" in the table formatting options. This makes large matrices usable. Option A is manual and destroys the dynamic nature of the document. Option C is unhelpful for a feature matrix containing text, not numerical data. Option D is overly complex, requires admin permissions, and is completely unnecessary for a native feature.',
        ARRAY['tables', 'sorting', 'formatting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Export the table to Excel, sort it, and paste it back.', false),
    (v_q_id, 'B', 'Nothing. Standard Confluence tables automatically support column sorting if a header row is defined.', true),
    (v_q_id, 'C', 'Use the Chart macro to convert the table into a bar chart.', false),
    (v_q_id, 'D', 'Write custom JavaScript in the HTML macro to enable sorting.', false);

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
        'Atlassian Jira Roadmap',
        E'An Atlassian PM wants to present the Q3 roadmap to the executive team directly from Confluence. They want a visual Gantt-style timeline showing Epics, their start/end dates, and dependencies, pulling live from Jira Software. Which macro is specifically built for this?',
        'intermediate',
        'Atlassian',
        'Visualizing Jira data in Confluence',
        'C',
        'The Jira Roadmap macro (Option C) embeds the live, interactive visual timeline (Gantt chart) from a Jira Software project directly into a Confluence page, perfect for executive presentations. Option A only shows a list or table of issues, not a visual timeline. Option B is a manual Confluence tool that doesn''t sync with Jira execution data. Option D is for aggregating Confluence pages, not Jira timelines.',
        ARRAY['jira_roadmap', 'gantt_charts', 'executive_reporting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Jira Issues macro.', false),
    (v_q_id, 'B', 'The Roadmap Planner macro.', false),
    (v_q_id, 'C', 'The Jira Roadmap macro (Advanced Roadmaps/Portfolio integration).', true),
    (v_q_id, 'D', 'The Content by Label macro.', false);

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
        'Slack Include Page',
        E'A Slack PM has a standard "Communication Guidelines" page. They want this exact content to appear in the PRDs for "Huddles", "Canvas", and "Clips". They use the Include Page macro. Later, the PM realizes they only wanted to include the *first paragraph* of the guidelines, not the whole page. What must they change?',
        'intermediate',
        'Slack',
        'Refining embedded content',
        'A',
        'The Include Page macro pulls in the *entire* document. To pull in only a specific portion, the source content must be wrapped in an Excerpt macro, and the target page must use the Excerpt Include macro (Option A). Option B is a misuse of security features to manipulate UI layout. Option C still imports the whole page, it just hides it behind a click, which doesn''t solve the core issue. Option D destructively alters the source document just to fix an embedding issue.',
        ARRAY['include_page', 'excerpt_macro', 'content_reuse']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Switch from the Include Page macro to the Excerpt Include macro, and wrap the first paragraph of the source page in an Excerpt macro.', true),
    (v_q_id, 'B', 'Add a Page Restriction to the bottom half of the guidelines page.', false),
    (v_q_id, 'C', 'Use the Expand macro on the target PRDs to hide the extra text.', false),
    (v_q_id, 'D', 'Delete the bottom half of the Communication Guidelines page.', false);

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
        'Amazon M&A Permissions',
        E'Amazon is acquiring a small startup. The M&A PM creates a highly confidential Space in Confluence called "Project Apollo." The PM sets the Space Permissions so only the ''MA-Leadership'' group can view it. Later, a PM accidentally removes all Page Restrictions from the main "Valuation" page inside that space. Who can view the Valuation page?',
        'advanced',
        'Amazon',
        'Advanced permission interactions',
        'B',
        'In Confluence, Space Permissions form the absolute outer security perimeter. Page Restrictions can only *further restrict* access within that group, they cannot grant access to someone who doesn''t have Space access. Therefore, removing page restrictions just reverts the page to the default Space Permissions (Option B). Option A represents a fundamental misunderstanding of Confluence security, which would lead to massive data leaks. Option C and D are factually incorrect regarding how permissions cascade.',
        ARRAY['space_permissions', 'page_restrictions', 'security']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Everyone at Amazon, because the Page Restrictions were removed.', false),
    (v_q_id, 'B', 'Only the ''MA-Leadership'' group, because Space Permissions act as the absolute outer boundary.', true),
    (v_q_id, 'C', 'No one, because removing restrictions deletes the page visibility.', false),
    (v_q_id, 'D', 'Only the Space Administrator.', false);

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
        'Uber Traceability',
        E'Uber''s compliance team mandates strict traceability: every Product Requirement in Confluence must map to a Jira Epic, which must map to Test Cases. The PM wants to quickly audit if any PRDs in the "Driver Safety" space are missing Jira links. What is the most robust automated way to audit this?',
        'advanced',
        'Uber',
        'Compliance auditing via Confluence features',
        'B',
        'By enforcing a standard where the Jira link is stored inside a Page Properties macro on the PRD, the PM can use the Page Properties Report (Option B) to generate a dynamic audit table. Any row with a blank "Jira Epic" column immediately flags a compliance gap. Option A is unscalable and error-prone. Option C is technically impossible for a standard SaaS PM without backend sysadmin access. Option D is invalid JQL and misunderstands how the macro works.',
        ARRAY['traceability', 'page_properties_report', 'compliance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Manually open all 50 pages and check for Jira links.', false),
    (v_q_id, 'B', 'Use the Page Properties Report to pull all PRDs, ensuring the "Jira Epic" column is included in the underlying properties table to spot blanks.', true),
    (v_q_id, 'C', 'Write a SQL query against the Confluence database to join the pages and issues tables.', false),
    (v_q_id, 'D', 'Use the Jira Issues macro and filter for `issue = NULL`.', false);

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
        'Spotify Knowledge Architecture',
        E'Spotify has grown rapidly, resulting in 500+ Confluence spaces. PMs complain they can''t find anything because search results are polluted with outdated spaces from 2015. As Head of Product Ops, what is the most scalable architectural change to fix search without permanently destroying data?',
        'advanced',
        'Spotify',
        'Enterprise search optimization',
        'B',
        'Archiving a Space (Option B) is a core Confluence administrative feature that hides the space from the directory and, crucially, removes it from the default quick search results. The data is preserved and can be found via advanced search if needed. Option A is a manual naming convention that doesn''t actually remove the clutter from search. Option C is destructive and risks losing valuable historical decisions. Option D is an architectural nightmare that will break thousands of links and cause permission chaos.',
        ARRAY['space_archiving', 'search_optimization', 'enterprise_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mandate that every PM prefix their page titles with the year (e.g., "[2024] PRD").', false),
    (v_q_id, 'B', 'Implement a strict Space archiving policy: archive unused spaces, which removes them from the default search index while preserving the data.', true),
    (v_q_id, 'C', 'Delete all spaces that haven''t been updated in 12 months.', false),
    (v_q_id, 'D', 'Move all pages into a single global space and rely entirely on labels.', false);

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
        'Netflix Release Dashboard',
        E'A Netflix Platform PM is managing a massive migration to a new video codec. The work spans 15 different Jira projects across 5 engineering orgs. The PM needs a single Confluence dashboard showing all "Blocker" bugs across this specific migration. How should they configure the Jira Issues macro?',
        'advanced',
        'Netflix',
        'Cross-project Jira querying',
        'B',
        'The true power of the Jira Issues macro for cross-org PMs is executing cross-project JQL (Option B). Assuming the work is tagged with a custom field or epic link (e.g., "Migration Initiative"), a single JQL query can aggregate blockers globally into one clean list. Option A creates a fragmented, hard-to-read dashboard. Option C is useless noise. Option D misunderstands the tool; Page Properties aggregates Confluence pages, not Jira bugs.',
        ARRAY['jira_macro', 'advanced_jql', 'cross_project_reporting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add 15 separate Jira Issues macros, one for each project, and filter each for blockers.', false),
    (v_q_id, 'B', 'Use an advanced JQL query in a single Jira Issues macro: `priority = Blocker AND "Migration" = "Codec2024"`.', true),
    (v_q_id, 'C', 'Embed the entire Netflix Jira directory.', false),
    (v_q_id, 'D', 'Use the Page Properties Report macro to aggregate bugs.', false);

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
        'Stripe Metric Single-Sourcing',
        E'At Stripe, the definition of "Active Merchant" is complex and changes yearly. It is referenced in 40 different PRDs. The Data Science team maintains the canonical definition on their Space. How can a PM ensure their new PRD always displays the exact, real-time definition maintained by Data Science without copying it?',
        'advanced',
        'Stripe',
        'Cross-space content reuse',
        'B',
        'The Excerpt Include macro can cross Space boundaries (Option B). By specifying the source Space Key and Page Title, a PM can pull a centralized definition into their local PRD. If DS updates the definition, all 40 PRDs update instantly. Option A guarantees drift and outdated metrics. Option C is messy, includes page headers/footers, and creates a poor reading experience. Option D requires the reader to leave the PRD, breaking context.',
        ARRAY['excerpt_include', 'cross_space', 'data_governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Copy the definition text and add a comment saying "Check DS page for updates."', false),
    (v_q_id, 'B', 'Ask Data Science to wrap the definition in an Excerpt macro, then use the Excerpt Include macro on the PRD, specifying the DS page name and Space key.', true),
    (v_q_id, 'C', 'Use the HTML macro to iframe the Data Science page.', false),
    (v_q_id, 'D', 'Link to the Data Science page using a standard hyperlink.', false);

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
        'Coinbase Compliance Approvals',
        E'A Coinbase PM is writing a PRD for "Instant Withdrawals." Because it involves financial compliance, the PRD must be formally approved and locked by the Legal team before engineering can begin. Using standard Confluence (or common marketplace apps like Comala), what is the proper workflow?',
        'advanced',
        'Coinbase',
        'Enforcing document sign-offs',
        'B',
        'In highly regulated environments like Coinbase, PMs rely on automated Document Management workflows (Option B). These tools enforce state transitions, capture auditable digital sign-offs, and automatically lock down permissions once approved to prevent post-approval tampering. Option A lacks any audit trail or security. Option C is a clunky workaround that takes the document out of the native wiki ecosystem. Option D is a massive security violation.',
        ARRAY['workflows', 'compliance', 'document_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM emails Legal, and when Legal says "approved," the PM types "APPROVED" at the top.', false),
    (v_q_id, 'B', 'Implement a page workflow where the state transitions to "In Review," Legal digitally signs off, and edit restrictions are automatically applied.', true),
    (v_q_id, 'C', 'Export the page as a PDF, send it via DocuSign, and attach the signed PDF back to the page.', false),
    (v_q_id, 'D', 'Have Legal write their password in a comment on the page to prove they read it.', false);

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
        'GitHub API Automation',
        E'A GitHub PM wants to automate a weekly status report. They want a script to automatically create a new Confluence page every Monday, populated with a specific template and data pulled from internal analytics tools. How is this achieved architecturally?',
        'advanced',
        'GitHub',
        'Programmatic page creation',
        'A',
        'Advanced PM ops often involve using the Confluence REST API (Option A) to programmatically generate pages, update content, or extract data. Sending POST requests with HTML or ADF allows for fully automated, deeply integrated workflows. Option B (UI scripting) is brittle, unscalable, and prone to breaking. Option C is factually incorrect; the REST API is robust. Option D creates a static attachment, not a native, editable Confluence page.',
        ARRAY['rest_api', 'automation', 'reporting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use the Confluence REST API to POST a new page, sending the content as Atlassian Document Format (ADF) or HTML.', true),
    (v_q_id, 'B', 'Write a Python script that simulates mouse clicks in the browser to create the page.', false),
    (v_q_id, 'C', 'It cannot be done; Confluence does not allow programmatic page creation.', false),
    (v_q_id, 'D', 'Send an email to a special Confluence address with the data attached as a Word document.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Confluence';
END $$;