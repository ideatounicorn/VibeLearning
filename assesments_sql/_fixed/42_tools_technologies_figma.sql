-- ============================================
-- ASSESSMENT: Figma
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
    WHERE slug = 'figma-tool';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug figma not found. Run the seed data first.';
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
        'Spotify''s Code Inspection',
        E'Spotify''s PM wants to grab the CSS padding and color values for a new "Play" button to share with a frontend developer. They are viewing the design file.\n\nWhat is the most efficient way to get this code?',
        'foundational',
        'Spotify',
        'Music streaming platform',
        'B',
        'Dev Mode is specifically built to bridge the gap between design and engineering. By toggling Dev Mode and inspecting the layer, a PM or developer can instantly view generated CSS, iOS, or Android code. Exporting as SVG only gives vector coordinate data, not styling logic like padding or shadows. Asking a designer to install a plugin is unnecessary since code inspection is native functionality. Right-clicking to copy code is less robust and missing the spatial context Dev Mode provides.',
        ARRAY['dev_mode', 'developer_handoff', 'inspect_panel']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Export the button as an SVG and open it in a text editor.', false),
    (v_q_id, 'B', 'Turn on Dev Mode, select the button, and copy the code snippet from the Inspect panel.', true),
    (v_q_id, 'C', 'Right-click the button and choose "Copy as Code".', false),
    (v_q_id, 'D', 'Ask the designer to install a code-export plugin.', false);

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
        'Uber''s Component Architecture',
        E'An Uber PM is changing the text on a "Request Ride" button in a specific mockup frame. Suddenly, they notice that the text has changed on every single button across the entire file.\n\nWhat mistake did the PM make?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'B',
        'Figma''s component system relies on Main Components (the master template) and Instances (copies). Editing the text of a Main Component propagates that change to all instances across the file. The PM should have edited an Instance, which would create a local text override without affecting the global design. Auto Layout controls sizing, not global text syncing. "Replace All" would require intentional search operations, which the PM didn''t do.',
        ARRAY['components', 'instances', 'design_systems']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They accidentally used the "Replace All" text tool.', false),
    (v_q_id, 'B', 'They edited the Main Component instead of an Instance.', true),
    (v_q_id, 'C', 'The button was locked inside an Auto Layout frame.', false),
    (v_q_id, 'D', 'The text layer had a shared text style applied.', false);

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
        'Airbnb''s Targeted Feedback',
        E'An Airbnb PM needs to leave feedback for a designer, specifically pointing out that the padding inside a search bar feels too tight.\n\nWhat is the best way to communicate this within Figma?',
        'foundational',
        'Airbnb',
        'Travel and housing marketplace',
        'B',
        'The comment tool (accessed via ''C'') allows users to pin feedback exactly on the UI element in question. This context is critical for designers to know exactly what the PM is referring to. Taking screenshots breaks the single source of truth and clutters communication. Highlighting and adding descriptions modifies the file structure inappropriately. Adding red text directly alters the design file, which is a bad practice for feedback.',
        ARRAY['collaboration', 'comments', 'feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Take a screenshot, draw a red arrow on it, and paste it next to the frame.', false),
    (v_q_id, 'B', 'Press ''C'' to open the Comment tool, click directly on the search bar, and type the feedback.', true),
    (v_q_id, 'C', 'Add a red text layer on top of the design with the feedback.', false),
    (v_q_id, 'D', 'Highlight the frame and add a description in the properties panel.', false);

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
        'Netflix''s Prototype Navigation',
        E'A Netflix PM is presenting a clickable prototype of a new TV interface. When they click the "Play" button, nothing happens and the screen does not advance to the video player.\n\nWhat is the most likely cause?',
        'foundational',
        'Netflix',
        'Video streaming service',
        'B',
        'In Figma''s Prototyping mode, frames must be explicitly linked using interaction "noodles" to define user flows. If clicking a button does nothing, the interaction trigger hasn''t been set up to navigate to the destination frame. Unexported screens remain in the canvas but don''t break prototype clicks. Publishing is for library components, not functional prototypes. Viewers can click through prototypes perfectly fine without edit access.',
        ARRAY['prototyping', 'interactions', 'user_flows']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The designer forgot to export the video screen.', false),
    (v_q_id, 'B', 'The Play button layer is missing a prototype interaction connecting it to the video screen.', true),
    (v_q_id, 'C', 'The prototype must be published before links work.', false),
    (v_q_id, 'D', 'The PM doesn''t have edit access to click buttons in presentation mode.', false);

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
        'Slack''s Responsive Buttons',
        E'A Slack PM edits a button''s text from "Send" to "Schedule for Tomorrow". The text becomes much longer, but the button''s background color does not expand, causing the text to spill out of the edges.\n\nHow should this button be structured to fix this?',
        'foundational',
        'Slack',
        'Workplace messaging platform',
        'C',
        'Auto Layout is Figma''s system for creating responsive designs. To make a button background grow with its text, the button frame must use Auto Layout with the horizontal resizing set to "Hug contents". This ensures the frame dynamically adjusts to the text layer''s bounding box. Fixed width forces the text to overflow or clip. Converting to a component doesn''t inherently make it responsive. Holding shift while typing does not affect bounding box scaling.',
        ARRAY['auto_layout', 'responsiveness', 'ui_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The button needs to be converted to a component.', false),
    (v_q_id, 'B', 'The text layer''s resizing property is set to "Fixed width".', false),
    (v_q_id, 'C', 'The button frame lacks Auto Layout with horizontal resizing set to "Hug contents".', true),
    (v_q_id, 'D', 'The PM needs to hold Shift while typing to scale the background.', false);

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
        'Notion''s File Navigation',
        E'A Notion PM opens a massive Figma file containing 50 different frames for an upcoming feature. They don''t know which frames are brainstorming and which are the final ones ready for engineering.\n\nWhat is the standard Figma practice to locate the final designs?',
        'foundational',
        'Notion',
        'Productivity and knowledge workspace',
        'B',
        'In complex Figma files, it''s a best practice to organize work using Pages and dedicated sections. PMs and developers should look for clear visual indicators like native "Ready for dev" sections or specific Pages named to denote finality. Version numbers in layer names are error-prone and rarely updated systematically. Sorting layers by date modified is not a native Figma feature and wouldn''t reliably indicate finality.',
        ARRAY['file_organization', 'developer_handoff', 'pages']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Look for the frame with the highest version number in the layer name.', false),
    (v_q_id, 'B', 'Check the "Ready for dev" section or look for a specifically named Page.', true),
    (v_q_id, 'C', 'Sort the layers panel by date modified to find the most recent edit.', false),
    (v_q_id, 'D', 'View the file''s source code to find the latest timestamp.', false);

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
        'Discord''s Distorted Assets',
        E'A Discord PM drags the corner of a responsive chat window frame to make it wider to see how it looks on desktop. However, the "Send" icon inside the chat bar gets stretched horizontally and distorted.\n\nWhy did the icon distort?',
        'foundational',
        'Discord',
        'Voice and text communication platform',
        'A',
        'Constraints in Figma dictate how elements behave when their parent frame is resized. If an icon distorts horizontally, its constraint is likely set to "Left and Right" or "Scale", forcing it to stretch with the parent. To fix this, it should be set to "Right" (to pin it to the right side) or "Center" with a fixed size. Flattening to a bitmap ruins the vector quality. Auto Layout frames handle resizing differently, but constraints are the root cause here.',
        ARRAY['constraints', 'responsive_design', 'resizing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The icon''s constraints are set to "Left and Right" or "Scale" instead of "Right".', true),
    (v_q_id, 'B', 'The icon needs to be flattened into a bitmap image first.', false),
    (v_q_id, 'C', 'The frame''s Auto Layout is turned off.', false),
    (v_q_id, 'D', 'The PM should hold Command/Ctrl while dragging to preserve aspect ratios.', false);

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
        'DoorDash''s Asset Export',
        E'A DoorDash PM needs a high-resolution, transparent logo from a mockup frame to use in an external slide deck.\n\nHow should they extract this asset from Figma?',
        'foundational',
        'DoorDash',
        'Food delivery platform',
        'B',
        'Figma has a dedicated Export panel. By selecting the specific layer or group, clicking the "+" next to Export, and choosing a format like PNG or SVG, the PM can download a clean, transparent asset. Taking a system screenshot usually captures the background and degrades quality. "Save Image As" is not a native Figma right-click function for layers. Dev Mode is for code, not general asset extraction for slide decks.',
        ARRAY['exporting', 'assets', 'presentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Take a system screenshot of the canvas.', false),
    (v_q_id, 'B', 'Select the logo layer, click the "+" in the Export panel, choose PNG or SVG, and export.', true),
    (v_q_id, 'C', 'Right-click the logo and select "Save Image As".', false),
    (v_q_id, 'D', 'Use Dev Mode to download the entire asset library.', false);

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
        'Shopify''s Text Overrides',
        E'A Shopify PM spots a typo in a specific confirmation modal ("Sve changes" instead of "Save changes"). The modal is an instance of a main component.\n\nHow can they fix this typo for just this one modal without affecting others?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'B',
        'Figma allows "overrides" on instances. By double-clicking into the text layer of an instance, a user can change the text just for that specific copy. This preserves the component relationship (so it still inherits layout and color changes) while allowing unique content. Detaching the instance breaks the design system link entirely. Adding a new text box over the instance is messy and breaks Auto Layout logic.',
        ARRAY['instances', 'overrides', 'components']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Detach the instance, edit the text, and recreate the component.', false),
    (v_q_id, 'B', 'Double-click into the text layer of the instance and type the new text.', true),
    (v_q_id, 'C', 'Hide the instance''s text layer and draw a new text box over it.', false),
    (v_q_id, 'D', 'Ask the designer to create a new variant in the design system specifically for this typo fix.', false);

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
        'Tinder''s View-Only Access',
        E'A Tinder PM opens a link to a design file and sees a "View only" badge at the top. They want to try rearranging some profile cards to test a new layout idea.\n\nWhat is their best path forward?',
        'foundational',
        'Tinder',
        'Dating app',
        'B',
        'When a user has "View only" access, they cannot modify the canvas, rearrange layers, or edit properties. To play with the layout, they must either request edit access from the file owner, or duplicate the file to their own drafts where they will have full edit permissions. There is no "Draft Mode" toggle to bypass permissions, and viewers cannot edit Auto Layout properties or unlock layers.',
        ARRAY['permissions', 'collaboration', 'file_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Toggle on the "Draft Mode" setting in the top toolbar.', false),
    (v_q_id, 'B', 'Duplicate the file to their drafts to edit it, or request edit access.', true),
    (v_q_id, 'C', 'Use a keyboard shortcut to temporarily unlock the layers.', false),
    (v_q_id, 'D', 'Edit the Auto Layout padding, which is always open to viewers.', false);

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
        'Zoom''s Responsive Video Grid',
        E'A Zoom PM is creating a simple wireframe of a video call interface using Auto Layout. There is a fixed-width sidebar, and they want the main video feed area to automatically stretch to occupy all remaining horizontal space in the window.\n\nWhich resizing property must be applied to the video feed frame?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'A',
        'In an Auto Layout context, setting a child element''s resizing property to "Fill container" forces it to absorb all available space left over by other fixed or hugging elements. "Hug contents" would shrink the frame to fit its internal content. Constraints like "Scale" apply to regular frames, not children of an Auto Layout frame. Manually dragging defeats the purpose of an automated responsive layout.',
        ARRAY['auto_layout', 'resizing', 'responsive_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the resizing property to "Fill container".', true),
    (v_q_id, 'B', 'Set the resizing property to "Hug contents".', false),
    (v_q_id, 'C', 'Apply a constraint of "Scale".', false),
    (v_q_id, 'D', 'Set the resizing to "Fixed" and manually drag it to the edge.', false);

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
        'Stripe''s Safe Iteration',
        E'A Stripe PM is exploring a risky redesign of the core checkout flow. The main Figma file is currently used by engineers for an active sprint. The PM wants to modify the designs without confusing the engineers or permanently altering the main file yet.\n\nWhat is the safest native Figma workflow for this?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'B',
        'Figma supports Branching, similar to Git in software development. A PM or designer can create a branch from the main file, experiment freely in an isolated environment, and eventually merge the changes back (or discard them) when ready. Creating a new page doesn''t hide it from engineers. Turning off Dev Mode isn''t granular to frames in that way. Exporting to a .fig file breaks cloud collaboration completely.',
        ARRAY['branching', 'version_control', 'collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a new page in the file and lock all the layers.', false),
    (v_q_id, 'B', 'Create a branch from the main file, work there, and merge it when approved.', true),
    (v_q_id, 'C', 'Turn off Dev Mode for the specific frames being edited.', false),
    (v_q_id, 'D', 'Export the file as a .fig file and work entirely offline.', false);

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
        'Robinhood''s Hover States',
        E'A Robinhood PM is testing a high-fidelity prototype. When they hover their mouse over a stock ticker, the background turns green. However, looking at the canvas, there are no prototype "noodles" connecting the main dashboard to a separate hover-state dashboard.\n\nHow is this interaction happening?',
        'intermediate',
        'Robinhood',
        'Financial services and investing',
        'B',
        'Figma features "Interactive Components", which allow designers to define interactions (like hover, press, or loading states) directly between the variants of a component. Once defined at the component level, any instance of that component will automatically inherit the interaction in a prototype without needing complex frame-to-frame wiring. Figma does not auto-guess hover states, and browser extensions don''t trigger Figma native prototypes.',
        ARRAY['prototyping', 'interactive_components', 'variants']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Figma automatically guesses hover states based on matching layer names.', false),
    (v_q_id, 'B', 'The designer used Interactive Components, where the hover interaction is built directly into the component variants.', true),
    (v_q_id, 'C', 'The PM has a browser extension installed that simulates CSS hover states.', false),
    (v_q_id, 'D', 'The prototype is actually an embedded iframe from the live staging website.', false);

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
        'Canva''s Developer Annotations',
        E'A Canva PM needs to explain complex business logic to engineering: a specific dropdown in the UI should only appear if the user is on a "Pro" subscription. They want this note to be highly visible to developers inspecting the file.\n\nWhat is the best way to communicate this within Figma?',
        'intermediate',
        'Canva',
        'Graphic design platform',
        'B',
        'Dev Mode includes an "Annotations" feature that allows PMs and designers to attach persistent text, logic, or variable notes directly to components. These show up prominently when developers inspect the file. Changing layer names is messy and easily overwritten. Regular comments are often resolved and disappear. Hidden layers are easily missed by developers inspecting the visual canvas.',
        ARRAY['developer_handoff', 'dev_mode', 'annotations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the dropdown''s layer name to "Dropdown (Pro Only)".', false),
    (v_q_id, 'B', 'Use Dev Mode annotations to attach a logic note directly to the component.', true),
    (v_q_id, 'C', 'Leave a regular comment and tell the developer not to resolve it.', false),
    (v_q_id, 'D', 'Create a hidden layer with the text that developers can find in the layer tree.', false);

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
        'Spotify''s Dark Mode Testing',
        E'A Spotify PM wants to see how a new playlist screen looks in Dark Mode. The designer built the file using Figma Variables for color theming.\n\nHow can the PM quickly view the dark mode version without modifying the core components?',
        'intermediate',
        'Spotify',
        'Music streaming platform',
        'B',
        'When a design utilizes Figma Variables (specifically color tokens), a frame can be assigned a specific Variable Mode. By selecting the top-level frame and switching the mode from Light to Dark in the layer panel, all colors bound to variables will instantly swap to their dark mode equivalents. Duplicating and manually changing defeats the purpose of variables. Inverting colors is a destructive visual hack.',
        ARRAY['variables', 'theming', 'design_systems']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ask the designer to duplicate the entire file and manually change all hex codes.', false),
    (v_q_id, 'B', 'Select the frame and switch the Variable Mode from Light to Dark in the right-hand panel.', true),
    (v_q_id, 'C', 'Use a plugin to apply a CSS color-invert filter to the canvas.', false),
    (v_q_id, 'D', 'Change their computer''s operating system settings to Dark Mode.', false);

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
        'Peloton''s Component Overrides',
        E'A Peloton PM changes the text of a button instance from "Start" to "Begin". The next day, the design system team updates the Main Component, changing the button color from red to black.\n\nWhat happens to the PM''s specific button instance?',
        'intermediate',
        'Peloton',
        'Fitness media and equipment',
        'C',
        'Figma is smart about handling overrides. When you change properties of an instance (like text, stroke weight, or specific colors), Figma preserves those local overrides even when the main component is updated. Therefore, the instance will inherit the new black color from the main component, but it will retain the custom "Begin" text override. It does not reset, nor does it create a fatal conflict.',
        ARRAY['components', 'instances', 'overrides']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It resets the text to "Start" and turns black.', false),
    (v_q_id, 'B', 'It stays "Begin" but remains red, rejecting the update entirely.', false),
    (v_q_id, 'C', 'It stays "Begin" and turns black, because Figma preserves text overrides while inheriting other updates.', true),
    (v_q_id, 'D', 'It creates a conflict error that must be manually resolved in the layers panel.', false);

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
        'Instagram''s Fluid Animations',
        E'An Instagram PM is prototyping a Story transition. They want a photo to smoothly expand from a small thumbnail to full screen. Currently, the prototype just instantly cuts between the thumbnail frame and the full-screen frame.\n\nWhat must be configured to achieve the smooth expansion?',
        'intermediate',
        'Instagram',
        'Social media platform',
        'A',
        'To create fluid, interpolating animations between states, Figma requires the interaction to be set to "Smart Animate". Crucially, the layers that are meant to animate (in this case, the photo) must have the exact same layer name and hierarchy in both frames. If the names match, Figma automatically calculates the size and position changes. "Push" is a directional slide, not an expansion. Grouping is irrelevant if names don''t match.',
        ARRAY['prototyping', 'smart_animate', 'animations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The transition must be set to "Smart Animate" and the photo layer must have the exact same name in both frames.', true),
    (v_q_id, 'B', 'The PM needs to use the "Push" transition and check the "Expand" box.', false),
    (v_q_id, 'C', 'The layers need to be grouped and converted into an interactive component first.', false),
    (v_q_id, 'D', 'Figma does not support smooth scaling animations; they must use a tool like Principle.', false);

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
        'Slack''s Library Updates',
        E'While working in a feature file, a Slack PM sees a black toast notification at the bottom of the screen reading: "Updates available for this file."\n\nWhat does this notification indicate?',
        'intermediate',
        'Slack',
        'Workplace messaging platform',
        'B',
        'In a mature design system, teams use published Libraries. When a designer modifies a Main Component in the core library and publishes it, any other file using instances of that component receives an "Updates available" notification. The user can review the changes and choose to accept them to sync their file with the latest design system. It has nothing to do with software updates or other users joining.',
        ARRAY['design_systems', 'libraries', 'components']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Figma desktop application needs to restart to install new software features.', false),
    (v_q_id, 'B', 'A connected design system library was updated; they can review and apply the changes.', true),
    (v_q_id, 'C', 'Another user has joined the file and is currently editing the same frame.', false),
    (v_q_id, 'D', 'The file hasn''t been saved to the cloud recently and requires a manual sync.', false);

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
        'Uber''s Component Variants',
        E'An Uber PM drags a "Toggle" component from the Assets panel onto their canvas. It defaults to the "Off" state, but they need it to be in the "On" state for their mockup.\n\nWhat is the correct way to change this component''s state?',
        'intermediate',
        'Uber',
        'Ride-hailing platform',
        'B',
        'When components are built with Variants (like On/Off, Primary/Secondary, Hover/Default), selecting an instance of that component reveals its Properties in the right-hand panel. The PM can simply toggle the state property from "Off" to "On". Manually moving vector shapes inside the instance breaks the component structure. Detaching components breaks future updates. Searching the assets panel is less efficient than using the property panel.',
        ARRAY['variants', 'components', 'properties']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Double-click the toggle and manually move the circle vector to the right.', false),
    (v_q_id, 'B', 'Select the component and use the Properties panel on the right to switch the state to "On".', true),
    (v_q_id, 'C', 'Detach the instance, recolor it green, and regroup it.', false),
    (v_q_id, 'D', 'Delete it and search the assets panel specifically for a separate "Toggle-On" component.', false);

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
        'Shopify''s Group Masking',
        E'A Shopify PM pastes a large hero image into a "Card" container. However, the image spills outside the rounded boundaries of the card instead of being cropped to fit inside.\n\nWhat is the structural reason for this issue?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'A',
        'In Figma, Groups and Frames behave differently. A Group is merely a bounding box that shrinks or grows to fit its contents exactly; it cannot clip or mask content. A Frame acts like a window and has a "Clip content" checkbox in the properties panel that hides anything extending past its boundaries. The container must be a Frame (or Auto Layout frame) with "Clip content" checked to crop the image.',
        ARRAY['frames_vs_groups', 'clipping', 'layers']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The container is a Group, not a Frame; Groups cannot use the "Clip content" property.', true),
    (v_q_id, 'B', 'The image layer needs to be converted into a vector mask.', false),
    (v_q_id, 'C', 'The PM needs to use the image crop tool manually before placing it.', false),
    (v_q_id, 'D', 'Auto Layout is forcing the container to expand, preventing clipping.', false);

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
        'Pinterest''s Tag Wrapping',
        E'A Pinterest PM is adding multiple category tags (e.g., "Home Decor", "DIY") into an Auto Layout row. As they add more tags, the row extends infinitely past the edge of the mobile screen mockup instead of dropping tags to a second line.\n\nHow can they fix this natively?',
        'intermediate',
        'Pinterest',
        'Visual discovery engine',
        'B',
        'Figma''s Auto Layout has a specific property called "Wrap". When applied to a horizontal layout, if child items exceed the fixed width of the parent frame, they will automatically wrap to a new line, much like CSS flex-wrap. Manually dragging defeats the purpose of Auto Layout. Truncating text shrinks the words, but doesn''t move the tags. Clipping content just hides the overflow without wrapping.',
        ARRAY['auto_layout', 'wrapping', 'responsive_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They must manually drag the excess tags into a second, separate Auto Layout row.', false),
    (v_q_id, 'B', 'Change the Auto Layout direction property from "Horizontal" to "Wrap".', true),
    (v_q_id, 'C', 'Set the text inside the tags to "Truncate" so they shrink to fit.', false),
    (v_q_id, 'D', 'Ensure the parent frame has "Clip content" turned off.', false);

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
        'Tinder''s Delayed Modals',
        E'A Tinder PM wants to create a prototype where a "Match!" modal automatically appears exactly 2 seconds after the user swipes right, without requiring any additional clicks.\n\nWhich prototype trigger should they use?',
        'intermediate',
        'Tinder',
        'Dating app',
        'B',
        'To trigger an action automatically without user interaction, Figma provides the "After Delay" trigger. The PM would link the post-swipe screen to the modal screen and set the trigger to "After Delay" with a value of 2000ms. "On Drag" requires active user movement. Smart animate is an animation type, not a trigger. Figma fully supports time-based triggers natively.',
        ARRAY['prototyping', 'triggers', 'user_flows']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the interaction trigger to "On Drag" with a slow easing.', false),
    (v_q_id, 'B', 'Set the interaction trigger to "After Delay" with a value of 2000ms.', true),
    (v_q_id, 'C', 'Use "Smart Animate" and set the duration to 2000ms.', false),
    (v_q_id, 'D', 'This requires a custom plugin; Figma only supports click or hover triggers.', false);

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
        'GitHub''s Code Syntax',
        E'A GitHub PM is reviewing a web dashboard in Dev Mode to pull some CSS styles. However, they notice all the generated code snippets in the right panel are showing iOS Swift code instead of CSS.\n\nHow do they fix this?',
        'intermediate',
        'GitHub',
        'Developer platform',
        'A',
        'Dev Mode allows users to customize the language and framework for code generation. In the Dev Mode sidebar, there is a dropdown to select the target platform (CSS, SwiftUI, Compose, etc.). Changing this to CSS/Web will instantly translate the Figma properties into the correct syntax. Figma does not auto-detect the viewer''s OS to determine project code, nor is it limited to mobile.',
        ARRAY['dev_mode', 'developer_handoff', 'code_generation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the platform language dropdown in the Dev Mode settings to CSS.', true),
    (v_q_id, 'B', 'The designer must have accidentally used Apple''s iOS UI kit components.', false),
    (v_q_id, 'C', 'Figma automatically detects the PM is on a Mac and defaults to Swift.', false),
    (v_q_id, 'D', 'Dev Mode currently only supports mobile development languages.', false);

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
        'Airbnb''s Icon Swapping',
        E'An Airbnb PM is adjusting a mockup and wants to replace a "Star" icon inside a button component with a "Heart" icon. They want to do this cleanly without breaking the button''s alignment or detaching the component.\n\nWhat is the native Figma way to achieve this?',
        'intermediate',
        'Airbnb',
        'Travel and housing marketplace',
        'B',
        'Figma utilizes "Instance Swapping" for nested components (like an icon inside a button). In the right-hand properties panel, an instance swap property allows the user to select the Star icon and swap it directly with the Heart icon from the design system library. This maintains Auto Layout, spacing, and component inheritance perfectly. Deleting or hiding layers inside an instance is messy and often prohibited without detaching.',
        ARRAY['components', 'instance_swap', 'design_systems']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delete the Star layer and paste a Heart layer inside the instance.', false),
    (v_q_id, 'B', 'Use the Instance Swap property in the right panel to replace the Star with the Heart.', true),
    (v_q_id, 'C', 'Ask the designer to make a whole new button variant specifically for the Heart icon.', false),
    (v_q_id, 'D', 'Hide the Star layer and place the Heart icon precisely on top of the button.', false);

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
        'Notion''s Version History',
        E'A Notion PM realizes they accidentally deleted a crucial page of PRD wireframes on Friday. It is now Monday, they have made many other unrelated changes, and the undo command (Cmd+Z) will not go back that far.\n\nHow can they recover the wireframes without losing Monday''s work?',
        'intermediate',
        'Notion',
        'Productivity and knowledge workspace',
        'B',
        'Figma continuously autosaves to Version History. A user can open "Show version history" from the file menu, view the file exactly as it was on Friday, and copy the deleted frames. They can then return to the current version and paste them in. This recovers the lost work without needing to revert the entire file, which would destructively wipe out all progress made on Monday.',
        ARRAY['version_history', 'file_recovery', 'collaboration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The work is permanently lost since the session was closed over the weekend.', false),
    (v_q_id, 'B', 'Open Version History, view Friday''s save, copy the missing frames, and paste them into the current version.', true),
    (v_q_id, 'C', 'Check the global Figma "Trash" folder for deleted frames and restore them.', false),
    (v_q_id, 'D', 'Revert the entire file to Friday''s version, accepting the loss of Monday''s work.', false);

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
        'Meta''s Boolean Operations',
        E'A Meta PM is playing around with building a custom "Notification Bell" icon. They place a small circle overlapping a larger circle and want the smaller circle to cut a transparent hole out of the larger one.\n\nWhich tool should they use?',
        'intermediate',
        'Meta',
        'Social technology company',
        'B',
        'To punch a hole through a vector shape using another shape, Figma uses Boolean Operations, specifically "Subtract selection". This non-destructively removes the overlapping area of the front shape from the back shape, creating a true transparent hole. Grouping and lowering opacity just makes a translucent circle. Applying a white fill fakes a hole, but fails if the background isn''t white. There is no traditional "eraser" for vectors.',
        ARRAY['vector_editing', 'boolean_operations', 'icons']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Group the circles and set the smaller circle''s opacity to 0%.', false),
    (v_q_id, 'B', 'Select both circles and use the "Subtract selection" boolean operation.', true),
    (v_q_id, 'C', 'Use the eraser tool from the toolbar to delete the overlap.', false),
    (v_q_id, 'D', 'Apply a white fill to the smaller circle to match the canvas background.', false);

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
        'Discord''s Quick PNG Copy',
        E'A Discord PM wants to show a quick visual snapshot of a single frame in a Slack channel, but they don''t want to clutter their computer''s downloads folder with exported image files.\n\nWhat is the fastest way to achieve this?',
        'intermediate',
        'Discord',
        'Voice and text communication platform',
        'B',
        'Figma allows users to select any frame or element, right-click (or use Cmd+Shift+C), and select "Copy as PNG". This renders the frame directly to the system clipboard, allowing the PM to immediately paste the image into Slack or a document without creating a local file. System screenshots can be messy and capture the Figma UI or grid. Sharing the link requires the team to open Figma, adding friction.',
        ARRAY['exporting', 'sharing', 'efficiency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Take a system screenshot using the computer''s built-in snipping tool.', false),
    (v_q_id, 'B', 'Select the frame, right-click to "Copy as PNG", and paste directly in Slack.', true),
    (v_q_id, 'C', 'Export the frame to the desktop, upload to Slack, then delete the file.', false),
    (v_q_id, 'D', 'Share the Figma file link and tell the team to zoom in on the frame.', false);

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
        'Atlassian''s Prototype Embedding',
        E'An Atlassian PM wants an interactive Figma prototype to be usable directly inside a Confluence Product Requirements Document (PRD), rather than forcing readers to click out to a new tab.\n\nHow is this accomplished?',
        'intermediate',
        'Atlassian',
        'Workplace collaboration software',
        'B',
        'Figma prototypes can be embedded directly into many modern tools (like Confluence, Notion, or Jira) using Smart Links or iFrames. The PM simply needs to click "Share prototype", ensure the permissions allow viewing ("Anyone with the link"), and paste the URL into the document, which will automatically render an interactive player. Exporting to GIF loses interactivity. Downloading HTML is not a native Figma feature.',
        ARRAY['integrations', 'prototyping', 'documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Export the prototype as an interactive GIF and upload it to Confluence.', false),
    (v_q_id, 'B', 'Copy the prototype link and paste it into Confluence to render an embedded player.', true),
    (v_q_id, 'C', 'Download the HTML export from Dev Mode and host it on an internal server.', false),
    (v_q_id, 'D', 'It is impossible; Figma prototypes only run natively in the Figma app or a direct browser tab.', false);

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
        'Netflix''s Advanced Auto Layout limits',
        E'A Netflix PM is reviewing a responsive web grid designed with Auto Layout. They want the left sidebar to shrink dynamically as the screen gets smaller, but it absolutely must never become narrower than 240px wide.\n\nWhich native Figma feature controls this?',
        'advanced',
        'Netflix',
        'Video streaming service',
        'A',
        'Figma''s Auto Layout supports advanced sizing controls, specifically Minimum and Maximum width/height. By setting the sidebar to "Fill container" (so it shrinks dynamically) and adding a "Min width" of 240px via the width dropdown, the PM ensures the layout is fluid until it hits the 240px floor, at which point it stops shrinking. Creating multiple variants is highly inefficient. Constraints alone cannot set dimensional limits.',
        ARRAY['auto_layout', 'responsive_design', 'advanced_sizing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Set the Auto Layout sizing to "Fill", open the width dropdown, and add a "Min width" of 240.', true),
    (v_q_id, 'B', 'Create multiple variants of the sidebar for every possible screen size.', false),
    (v_q_id, 'C', 'Use a fixed width of 240px and let the rest of the screen overlap it on smaller devices.', false),
    (v_q_id, 'D', 'Apply a dimensional constraint of "Left" to the sidebar.', false);

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
        'Duolingo''s Prototyping Logic',
        E'A Duolingo PM is building a high-fidelity prototype that needs to actually keep score. Every time a user clicks a correct answer on different screens, a score counter in the header should increase by 10 points.\n\nWhat is the most scalable way to build this logic in Figma?',
        'advanced',
        'Duolingo',
        'Language learning app',
        'B',
        'Advanced prototyping in Figma utilizes "Variables". The PM can create a Number Variable called `score`. In the prototype interaction for a correct answer, they add an action: "Set variable" -> `score` to `score + 10`. Any text layer bound to that variable will dynamically update across the entire prototype. Creating hundreds of frames for permutations is completely unscalable. Smart Animate only interpolates visuals, not math logic.',
        ARRAY['prototyping', 'variables', 'advanced_interactions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create hundreds of individual frames mapping out every possible score combination.', false),
    (v_q_id, 'B', 'Create a Number Variable for the score, and use the "Set variable" action to add 10 on click.', true),
    (v_q_id, 'C', 'Use Smart Animate to transition text fields from one number to the next.', false),
    (v_q_id, 'D', 'Use a Figma plugin during the presentation mode to manually update the text layers live.', false);

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
        'Salesforce''s Component Architecture',
        E'A Salesforce PM changes the corner radius on a fundamental "Base Icon" component. However, they notice that the larger "Primary Button" component (which visually includes an icon) does not inherit the new corner radius.\n\nWhat is the structural flaw in the design system causing this?',
        'advanced',
        'Salesforce',
        'Enterprise CRM platform',
        'A',
        'In complex design systems, larger components (like a Primary Button) are often built by nesting smaller components (like a Base Icon). If the Primary Button does not inherit changes from the Base Icon, it means the designer likely detached the instance of the Base Icon when building the button, severing the inheritance link. Corner radii are inheritable through nested instances. Auto Layout does not override border radius natively.',
        ARRAY['components', 'nested_components', 'design_systems']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Primary Button was built using a detached instance of the Base Icon, severing inheritance.', true),
    (v_q_id, 'B', 'Corner radius is a property that cannot be inherited between nested components.', false),
    (v_q_id, 'C', 'The PM needs to hit "Publish Library" before local changes apply to other local components.', false),
    (v_q_id, 'D', 'The Primary Button has Auto Layout applied, which overrides internal corner radius settings.', false);

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
        'Stripe''s Branch Merging',
        E'A Stripe PM is merging their redesign branch back to the main file. Figma blocks the merge and displays a "Conflict" warning on the "Checkout Modal" frame.\n\nWhy did this happen and how is it resolved?',
        'advanced',
        'Stripe',
        'Payment processing platform',
        'B',
        'Conflicts in Figma Branching occur exactly like Git: another user edited the exact same frame in the Main file while the Branch was active. To resolve it, Figma provides a side-by-side comparison screen where the PM must explicitly choose whether to overwrite Main with their Branch changes, or discard their Branch changes to keep Main. Figma does not auto-delete edits or auto-merge them into messy variants.',
        ARRAY['branching', 'version_control', 'conflict_resolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Figma automatically deletes the older edit based on the timestamp to resolve conflicts.', false),
    (v_q_id, 'B', 'Another editor changed the same frame; the PM must review side-by-side and pick a version to keep.', true),
    (v_q_id, 'C', 'The branch cannot be merged; the PM must revert the main file to an older version first.', false),
    (v_q_id, 'D', 'The two conflicting frames are automatically grouped into a single component with variants.', false);

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
        'Uber''s Absolute Positioning',
        E'An Uber PM is building a user avatar using Auto Layout. They want a small red notification dot to overlap the top right corner of the avatar image, ignoring the Auto Layout padding and alignment rules.\n\nWhat is the most elegant way to achieve this without breaking the Auto Layout?',
        'advanced',
        'Uber',
        'Ride-hailing platform',
        'B',
        'Figma''s Auto Layout includes an "Absolute position" feature. By selecting a child object (the red dot) and toggling Absolute Position, that object ignores the flow and padding of the parent Auto Layout frame, allowing it to be freely positioned (like top right corner) while keeping the rest of the component responsive. Removing Auto Layout completely degrades the component''s usefulness. Negative gap is a hack that often breaks scaling.',
        ARRAY['auto_layout', 'absolute_positioning', 'ui_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Remove Auto Layout from the entire avatar component and manually position everything.', false),
    (v_q_id, 'B', 'Select the red dot, toggle "Absolute position", and drag it to the corner.', true),
    (v_q_id, 'C', 'Use a negative gap value in the Auto Layout settings to pull the dot backwards.', false),
    (v_q_id, 'D', 'Group the dot and the avatar image together before applying Auto Layout to the parent.', false);

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
        'Canva''s Performance Optimization',
        E'A Canva PM is working in a massive Figma file containing thousands of frames and high-resolution images. The browser tab keeps crashing, displaying an "Out of memory" error.\n\nWhat is the technical limitation they are hitting?',
        'advanced',
        'Canva',
        'Graphic design platform',
        'B',
        'Figma runs in a web-based environment (WebAssembly/WebGL) and is subject to active memory limits imposed by browsers (historically around 2GB). When a file has too many large images, detached components, or hidden vectors, it exceeds this RAM limit and crashes. The solution is optimizing the file by splitting it into separate pages/files or compressing images. There is no arbitrary 100-frame limit or Enterprise tier memory bypass.',
        ARRAY['performance', 'file_management', 'memory_limits']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Figma has a hardcoded limit of 100 frames per file.', false),
    (v_q_id, 'B', 'They hit the browser''s active memory limit (~2GB); they must split the file or compress assets.', true),
    (v_q_id, 'C', 'They need to upgrade their Figma subscription to an Enterprise plan for unlimited memory.', false),
    (v_q_id, 'D', 'The PM needs to clear their browser cookies and cache to reset the memory stack.', false);

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
        'GitHub''s Design Tokens',
        E'A GitHub PM is transitioning the team to a strict design-to-code workflow. Engineers are complaining that Dev Mode is showing them raw hex colors (e.g., `#0D1117`) instead of the system''s semantic design tokens (e.g., `bg-canvas-default`).\n\nHow should the design system be structured to pass tokens to Dev Mode?',
        'advanced',
        'GitHub',
        'Developer platform',
        'B',
        'To achieve a true design-to-code pipeline, designers should utilize Figma Variables (or plugins like Token Studio). By creating semantic variables (like `bg-canvas-default`) and binding them to the raw hex codes, Dev Mode will natively expose the token name to engineers inspecting the elements, eliminating hardcoded values. Typing tokens into layer names is hacky and breaks. Dev Mode fully supports token names when configured properly.',
        ARRAY['design_tokens', 'dev_mode', 'design_systems']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Designers must manually type `bg-canvas-default` into every relevant layer name.', false),
    (v_q_id, 'B', 'Designers must use Figma Variables to alias colors to token names, which Dev Mode will expose.', true),
    (v_q_id, 'C', 'Engineers must write a regex script locally to find and replace hex codes after copying.', false),
    (v_q_id, 'D', 'Dev Mode exclusively supports CSS hex codes, so the engineering team must adapt their process.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Figma';

END $$;
