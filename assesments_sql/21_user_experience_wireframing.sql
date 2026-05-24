-- ============================================
-- ASSESSMENT: Wireframing
-- CATEGORY: User Experience
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
    WHERE slug = 'wireframing';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug wireframing not found. Run the seed data first.';
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
        'Airbnb''s Lo-fi vs Hi-fi Choice',
        E'A PM at Airbnb is kicking off a brand-new feature: split payments for group trips. The PM wants to get early alignment from the engineering and leadership teams on the core user flow before committing significant design resources.\n\nWhich level of wireframing fidelity is most appropriate for this goal?',
        'foundational',
        'Airbnb',
        'Feature kickoff for split payments',
        'B',
        'Low-fidelity wireframes are ideal for early alignment on user flows and core functionality without getting bogged down in visual design debates. A high-fidelity or mid-fidelity mockup would waste resources if the core concept is rejected, and stakeholders might focus on colors and fonts instead of the split-payment logic.',
        ARRAY['fidelity_levels', 'prototyping', 'stakeholder_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'High-fidelity interactive prototypes to ensure exact specifications are communicated.', false),
    (v_q_id, 'B', 'Low-fidelity sketches or wireframes focusing purely on layout and flow logic.', true),
    (v_q_id, 'C', 'Mid-fidelity wireframes with actual styling and brand colors.', false),
    (v_q_id, 'D', 'Production-ready mockups to save time in the long run.', false);

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
        'Spotify''s Empty States',
        E'A Spotify PM is reviewing wireframes for a new "Collaborative Podcast Playlists" feature. The wireframes show a beautifully populated playlist with 10 episodes, a play button, and sharing options.\n\nWhat critical wireframe state is the PM most likely missing in this review?',
        'foundational',
        'Spotify',
        'Collaborative podcast playlists',
        'B',
        'Empty states are frequently forgotten in happy-path wireframes but are critical for onboarding. When a user first creates a playlist, it will be empty. If the wireframe doesn''t account for this, the user might face a blank screen instead of a clear call-to-action to "Add your first episode." While loading states and edge cases matter, the empty state is a guaranteed phase of the primary user journey.',
        ARRAY['empty_states', 'onboarding', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The loading spinner state for slow network connections.', false),
    (v_q_id, 'B', 'The "Empty State" for when the playlist is first created and has no episodes.', true),
    (v_q_id, 'C', 'The maximum capacity state when the playlist hits 10,000 episodes.', false),
    (v_q_id, 'D', 'The dark mode versus light mode visual variations.', false);

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
        'Uber''s Call-to-Action Placement',
        E'An Uber PM is working on the ride-request screen. In the latest wireframes, the "Confirm Ride" button is pushed below the fold on smaller devices because the map and car type selection take up too much vertical space.\n\nWhat is the most significant risk of this wireframe layout?',
        'foundational',
        'Uber',
        'Ride-request screen layout',
        'C',
        'The primary Call-To-Action (CTA) for conversion—"Confirm Ride"—must be immediately visible without requiring the user to scroll (above the fold). Forcing users to scroll to find the main conversion button introduces friction and increases drop-off rates. Engineering a scrollable view is trivial, but users will experience unnecessary friction.',
        ARRAY['above_the_fold', 'conversion_funnel', 'cta_placement']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Users might think the app is broken if they don''t see a confirmation button.', false),
    (v_q_id, 'B', 'The engineering team will struggle to build a scrollable view.', false),
    (v_q_id, 'C', 'Users may abandon the funnel because the primary Call-To-Action (CTA) is not immediately visible.', true),
    (v_q_id, 'D', 'It violates Apple''s Human Interface Guidelines for map views.', false);

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
        'Slack''s Visual Hierarchy',
        E'A Slack PM is reviewing a wireframe for a new "Advanced Search" modal. The modal contains a "Search" button, a "Cancel" button, a "Save Filter" button, and an "Export Results" button. All four buttons are styled as solid blue, equal-sized rectangles.\n\nWhat is the primary UX flaw in this wireframe?',
        'foundational',
        'Slack',
        'Advanced Search modal',
        'A',
        'Visual hierarchy guides the user''s eye to the most important action. By styling all four buttons identically, the wireframe fails to distinguish the primary action (Search) from secondary (Save) or tertiary (Cancel/Export) actions. This increases cognitive load. While accessibility and option overload are concerns, the immediate flaw in the layout is the lack of visual prioritization.',
        ARRAY['visual_hierarchy', 'cognitive_load', 'ui_components']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It lacks a clear visual hierarchy, giving equal weight to primary, secondary, and tertiary actions.', true),
    (v_q_id, 'B', 'The buttons should be rounded instead of rectangular to match modern UI trends.', false),
    (v_q_id, 'C', 'It provides too many options; a modal should never have more than two buttons.', false),
    (v_q_id, 'D', 'The blue color might not be accessible for color-blind users.', false);

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
        'Netflix''s Cross-Platform Adaptation',
        E'A Netflix PM is designing a new "Interactive Trivia" overlay for movies. The initial wireframes were designed using a mobile portrait layout. The PM now needs to adapt these wireframes for the TV interface (10-foot UI).\n\nWhich adaptation is most critical when moving from mobile wireframes to TV wireframes?',
        'foundational',
        'Netflix',
        'Interactive Trivia overlay on TV',
        'B',
        'The most fundamental difference between mobile and TV UI is the input method. Mobile relies on direct touch, while TVs rely on remote controls (D-pad). Wireframes for TV must clearly indicate "focus states" (which element is currently highlighted) and ensure that users can logically navigate between elements using only up/down/left/right clicks.',
        ARRAY['cross_platform', 'input_methods', 'tv_ui']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Increasing the text length since TVs have much larger screens.', false),
    (v_q_id, 'B', 'Designing for D-pad (directional pad) navigation and focus states instead of touch targets.', true),
    (v_q_id, 'C', 'Placing all interactive elements at the bottom of the screen for easier access.', false),
    (v_q_id, 'D', 'Switching from vertical scrolling to horizontal swiping gestures.', false);

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
        'Duolingo''s Feedback Collection',
        E'A Duolingo PM presents a low-fidelity wireframe (gray boxes, placeholder text) of a new "Leaderboard Challenge" feature to the engineering team. An engineer complains that "the colors look boring" and "the fonts are ugly."\n\nHow should the PM address this feedback during the wireframe review?',
        'foundational',
        'Duolingo',
        'Leaderboard Challenge review',
        'C',
        'The core purpose of low-fidelity wireframes is to align on structure, layout, and logic without the distraction of visual design. The PM must actively manage the review by reminding stakeholders of the current fidelity level and redirecting feedback toward the user flow rather than aesthetics. Adding colors early defeats the purpose of lo-fi wireframes.',
        ARRAY['stakeholder_management', 'fidelity_levels', 'feedback_collection']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apologize and promise to add brand colors and fonts before the next meeting.', false),
    (v_q_id, 'B', 'Agree with the engineer and ask them to suggest better color palettes.', false),
    (v_q_id, 'C', 'Refocus the conversation on user flows, layout, and functionality, explaining that visual styling comes later.', true),
    (v_q_id, 'D', 'Ignore the feedback completely as engineers shouldn''t be commenting on design.', false);

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
        'DoorDash''s Error States',
        E'A DoorDash PM is creating wireframes for a new "Group Order" checkout flow. The happy path works perfectly. The PM is now mapping out error states.\n\nWhich of the following is the most effective way to handle an expired credit card error in the wireframe?',
        'foundational',
        'DoorDash',
        'Group Order checkout flow',
        'B',
        'Good UX in error states requires clear, contextual, and actionable feedback. Inline validation near the specific field that caused the error tells the user exactly what went wrong and how to fix it without losing their context or progress in the checkout flow. Generic error codes or dead ends frustrate users and increase cart abandonment.',
        ARRAY['error_states', 'inline_validation', 'checkout_funnel']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'An alert box that says "Error Code 402: Payment Failed. Try again."', false),
    (v_q_id, 'B', 'Inline validation text near the credit card field stating "Card expired. Please update your expiration date or use a new card."', true),
    (v_q_id, 'C', 'A full-screen redirect to a "Payment Failed" page with a link back to the homepage.', false),
    (v_q_id, 'D', 'Disabling the "Place Order" button without any accompanying text so the user figures it out.', false);

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
        'Robinhood''s Information Density',
        E'A Robinhood PM is designing a new "Pro Trader" view. The wireframe currently crams a candlestick chart, order book, news feed, portfolio balance, and trade execution buttons onto a single mobile screen, making all elements very small.\n\nWhat is the most likely negative outcome of this high-information-density wireframe on a mobile device?',
        'foundational',
        'Robinhood',
        'Pro Trader mobile view',
        'B',
        'Cramming too much information onto a small mobile screen increases cognitive load and shrinks touch targets. In a high-stakes environment like trading, small touch targets and overwhelming visuals can easily lead to "fat-finger" errors, causing users to make incorrect trades. PMs must balance information density with usability, often using progressive disclosure.',
        ARRAY['information_density', 'cognitive_load', 'touch_targets']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The app will consume too much mobile data to render the screen.', false),
    (v_q_id, 'B', 'High cognitive load and small touch targets will lead to user errors, such as executing the wrong trade.', true),
    (v_q_id, 'C', 'The engineering team will not be able to render all those components simultaneously.', false),
    (v_q_id, 'D', 'Users will prefer the desktop version over the mobile version.', false);

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
        'Notion''s PM vs Designer Role',
        E'The Notion PM and Product Designer are kicking off a new "Database Automation" feature.\n\nWhich of the following best describes the PM''s typical role in the wireframing process compared to the Designer?',
        'foundational',
        'Notion',
        'Database Automation feature kickoff',
        'C',
        'In a healthy PM-Designer relationship, the PM defines the "what" and "why" (business requirements, user goals, edge cases, and rough logical flows). The Designer focuses on the "how" (exploring UI layouts, interaction patterns, and visual hierarchy). PMs often sketch lo-fi concepts to communicate logic, but Designers own the actual user interface solutions.',
        ARRAY['pm_role', 'collaboration', 'design_process']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM dictates the exact pixel placement of buttons; the Designer chooses the colors.', false),
    (v_q_id, 'B', 'The PM creates the final high-fidelity mockups; the Designer writes the code.', false),
    (v_q_id, 'C', 'The PM provides the business requirements, user goals, and rough flows; the Designer explores layout solutions and interaction patterns.', true),
    (v_q_id, 'D', 'The PM writes the marketing copy; the Designer handles all wireframing entirely independently.', false);

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
        'GitHub''s Navigation Patterns',
        E'A GitHub PM is wireframing a new mobile app redesign. The app has 5 core areas: Home, Notifications, Issues, Pull Requests, and Profile.\n\nWhat is the most standard and accessible navigation pattern to represent these 5 core areas in the mobile wireframe?',
        'foundational',
        'GitHub',
        'Mobile app redesign',
        'B',
        'For mobile applications with 3-5 core destination areas of equal importance, a bottom tab bar is the industry standard. It keeps the primary navigation visible, accessible with one hand, and immediately shows the user where they are. Hamburger menus hide navigation and reduce engagement, while swipe-only navigation lacks discoverability.',
        ARRAY['navigation_patterns', 'mobile_ui', 'discoverability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A hidden hamburger menu (☰) in the top left corner.', false),
    (v_q_id, 'B', 'A bottom tab navigation bar with 5 icons.', true),
    (v_q_id, 'C', 'A floating action button (FAB) that expands into a menu.', false),
    (v_q_id, 'D', 'Horizontal swiping between all 5 screens without a visible menu.', false);

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
        'Figma''s User Flows vs Static Screens',
        E'A PM at Figma is mapping out the "Invite User" feature. They have a static wireframe showing the invite modal, but the engineering lead is confused about what happens when an invited user doesn''t have an account yet.\n\nWhat wireframing artifact would best resolve this confusion?',
        'intermediate',
        'Figma',
        'Invite User feature',
        'A',
        'Static screens fail to communicate transitions and conditional logic (like what happens if a user is unregistered). A ''wireflow'' combines wireframes with a flowchart, using arrows and decision nodes to map out the exact user journey. Higher fidelity doesn''t solve missing logic, and a purely text PRD can be harder to interpret than a visual flow.',
        ARRAY['wireflows', 'user_journey', 'conditional_logic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A wireflow (wireframes connected by directional arrows) showing the decision tree for existing vs. new users.', true),
    (v_q_id, 'B', 'A higher-fidelity mockup of the exact same invite modal.', false),
    (v_q_id, 'C', 'A written Product Requirements Document (PRD) without any visuals.', false),
    (v_q_id, 'D', 'An empty state wireframe for the invite modal.', false);

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
        'Shopify''s Progressive Disclosure',
        E'A Shopify PM is wireframing a new, highly complex merchant dashboard with over 50 configuration settings for taxes, shipping, and inventory.\n\nHow should the PM use wireframes to minimize cognitive load while keeping all 50 settings accessible?',
        'intermediate',
        'Shopify',
        'Complex merchant dashboard',
        'C',
        'Progressive disclosure is a UI pattern that sequences information and actions across several screens, or hides complex options behind an "Advanced" toggle. This keeps the primary interface clean for the average user while ensuring power users can still access complex settings. A long scrolling page or 50 separate pages would cause severe cognitive overload and navigation fatigue.',
        ARRAY['progressive_disclosure', 'cognitive_load', 'information_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Place all 50 settings on a single, long scrolling page so nothing is hidden.', false),
    (v_q_id, 'B', 'Remove the less popular settings entirely from the wireframe.', false),
    (v_q_id, 'C', 'Use progressive disclosure, showing only the top 5 essential settings, and grouping the rest behind "Advanced Settings" toggles.', true),
    (v_q_id, 'D', 'Create 50 separate pages, one for each setting, to keep each screen clean.', false);

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
        'Zoom''s Wireframe Accessibility',
        E'A Zoom PM is creating mid-fidelity wireframes for a new "Live Transcription" toggle. The PM places a small gray ''T'' icon next to the mute button to represent the feature. \n\nWhich of the following accessibility concerns should be flagged during the wireframe review?',
        'intermediate',
        'Zoom',
        'Live Transcription toggle',
        'D',
        'Even in mid-fidelity wireframes, basic accessibility principles like minimum touch target sizes (usually 44x44 pt on mobile) and contrast ratios must be considered. A small, gray icon is likely to fail contrast checks and be difficult for users with motor impairments to tap accurately. PMs must ensure wireframes bake in accessibility early.',
        ARRAY['accessibility', 'touch_targets', 'contrast']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The icon cannot be easily translated into other languages.', false),
    (v_q_id, 'B', 'Live transcription is not an accessibility feature.', false),
    (v_q_id, 'C', 'Gray icons use too much battery power.', false),
    (v_q_id, 'D', 'The touch target size might be too small and gray-on-gray lacks sufficient contrast.', true);

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
        'Discord''s Responsive Design',
        E'A Discord PM is reviewing wireframes for a new "Server Event Calendar". The desktop wireframe includes a left sidebar (channels), a middle column (calendar), and a right sidebar (active members).\n\nWhen adapting this wireframe for mobile screens, what is the best approach for these three columns?',
        'intermediate',
        'Discord',
        'Server Event Calendar',
        'A',
        'In responsive design, multi-column desktop layouts cannot simply be shrunk or vertically stacked if the middle column contains the primary interactive content. The standard pattern is to dedicate the mobile viewport to the primary content (the calendar) and collapse secondary navigation (channels/members) into off-canvas menus accessible via swipe or buttons.',
        ARRAY['responsive_design', 'mobile_ui', 'layout_adaptation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Collapse the sidebars behind a hamburger menu or swipe gesture, dedicating the main mobile screen to the calendar.', true),
    (v_q_id, 'B', 'Stack the three columns vertically, requiring the user to scroll past all channels to reach the calendar.', false),
    (v_q_id, 'C', 'Shrink the text and icons so all three columns fit horizontally on the mobile screen.', false),
    (v_q_id, 'D', 'Remove the channels and members features entirely from the mobile app.', false);

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
        'Tinder''s Gesture Mapping',
        E'A Tinder PM is wireframing a new "Super Like Boost" feature. The interaction relies entirely on complex multi-finger gestures rather than visible buttons.\n\nWhy is relying solely on gestures a dangerous decision in wireframing and product design?',
        'intermediate',
        'Tinder',
        'Super Like Boost feature',
        'B',
        'Gestures are "invisible" UI. They lack visual affordances, meaning users cannot easily discover them without explicit onboarding or external knowledge. Relying entirely on gestures without visible button alternatives creates a severe discoverability problem. Wireframes should typically include visible controls (buttons) even if a gesture shortcut exists.',
        ARRAY['gestures', 'discoverability', 'affordance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Gestures require too much processing power from the mobile device.', false),
    (v_q_id, 'B', 'Gestures have zero affordance (visual cues), leading to severe discoverability issues.', true),
    (v_q_id, 'C', 'Gestures cannot be programmed into native iOS or Android apps.', false),
    (v_q_id, 'D', 'Gestures always trigger accidental actions.', false);

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
        'Amazon''s Faceted Search',
        E'An Amazon PM is wireframing a new B2B electronics purchasing portal. The catalog has 10,000 items with overlapping categories (e.g., "Laptops", "Dell", "16GB RAM").\n\nWhich wireframe layout pattern is best suited for this level of filtering?',
        'intermediate',
        'Amazon',
        'B2B electronics portal',
        'D',
        'For complex catalogs with multiple attributes, faceted search (typically on a left sidebar) is the industry standard. It allows users to apply multiple filters simultaneously (e.g., Brand + RAM + Price) and progressively narrow down the results. Dropdowns are inefficient for large datasets, and a basic search bar places too much cognitive load on the user to guess exact keywords.',
        ARRAY['faceted_search', 'filtering', 'information_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A single, massive dropdown menu containing all possible combinations.', false),
    (v_q_id, 'B', 'A chronological feed of items that users can endlessly scroll.', false),
    (v_q_id, 'C', 'A basic search bar with no filtering options.', false),
    (v_q_id, 'D', 'A faceted navigation sidebar allowing multiple simultaneous filter selections.', true);

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
        'Stripe''s Inline Validation',
        E'A Stripe PM is evaluating a wireframe for a new merchant registration form. The wireframe currently shows validation errors only after the user clicks the final "Submit" button at the bottom of the page.\n\nHow should the PM instruct the designer to improve this wireframe?',
        'intermediate',
        'Stripe',
        'Merchant registration form',
        'C',
        'Waiting until the end of a long form to display errors frustrates users and increases abandonment. Inline validation, which provides immediate feedback (like a green checkmark or red text) as the user leaves a field, allows users to correct mistakes in context. Pop-up modals for every field would be overly aggressive and annoying.',
        ARRAY['form_design', 'inline_validation', 'user_friction']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Remove validation errors entirely to reduce friction.', false),
    (v_q_id, 'B', 'Use a pop-up modal for every field as soon as it is filled out.', false),
    (v_q_id, 'C', 'Implement inline validation that provides real-time feedback as the user tabs out of each field.', true),
    (v_q_id, 'D', 'Make the "Submit" button flash red continuously if there is an error anywhere.', false);

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
        'LinkedIn''s Social Proof Layout',
        E'A LinkedIn PM is wireframing a new "Course Certificates" page. To increase conversion, they want to add social proof.\n\nWhere in the wireframe hierarchy is the most effective placement for "Connections who took this course"?',
        'intermediate',
        'LinkedIn',
        'Course Certificates page',
        'A',
        'Social proof is most effective at the point of decision. Placing endorsements or "connections who took this course" right next to the primary Call-to-Action (Enroll Now) reassures the user exactly when they are deciding whether to convert. Hiding it in a tab or footer neutralizes its psychological impact.',
        ARRAY['social_proof', 'conversion_optimization', 'layout_hierarchy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Directly adjacent to the primary "Enroll Now" Call-to-Action button.', true),
    (v_q_id, 'B', 'Hidden in the website footer.', false),
    (v_q_id, 'C', 'On a separate tab that the user must click to view.', false),
    (v_q_id, 'D', 'In small text at the very top of the page, above the course title.', false);

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
        'Airbnb''s State Management',
        E'An Airbnb PM is wireframing the search results page. Users need to see both a list of properties and their locations on a map. \n\nWhat is the most effective UI pattern to handle these dual views on a mobile device?',
        'intermediate',
        'Airbnb',
        'Search results map vs list',
        'C',
        'On mobile, screen real estate is too limited to effectively display both a functional map and a readable list simultaneously. The best pattern is a state toggle (often a floating action button) that allows users to seamlessly flip between a full-screen map and a full-screen list without losing their search context. Kicking users to an external app breaks the user journey.',
        ARRAY['state_management', 'mobile_ui', 'view_toggles']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Squeeze both the list and the full map onto the screen simultaneously.', false),
    (v_q_id, 'B', 'Force users to use only the map, eliminating the list view.', false),
    (v_q_id, 'C', 'Provide a floating toggle button to switch smoothly between full-screen List and full-screen Map states.', true),
    (v_q_id, 'D', 'Open the map in an external application like Google Maps.', false);

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
        'Spotify''s Micro-interactions',
        E'A Spotify PM is reviewing static wireframes for the "Like Song" feature (clicking the heart icon). The wireframe just shows the heart changing from empty to green.\n\nWhy might the PM request a wireflow or annotation detailing the micro-interaction here?',
        'intermediate',
        'Spotify',
        'Like Song micro-interaction',
        'B',
        'Micro-interactions (like a heart popping with a small vibration and a brief "Added to Liked Songs" toast) provide critical immediate feedback. Static wireframes miss these temporal details. The PM needs to ensure the team builds the delightful and confirming feedback loop, which requires annotating the wireframe or using a sequential wireflow to describe the animation and haptics.',
        ARRAY['micro_interactions', 'haptics', 'user_feedback']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Because the green color might not be on-brand.', false),
    (v_q_id, 'B', 'To specify the animation, haptic feedback, and success toast that confirms the action to the user.', true),
    (v_q_id, 'C', 'Because static wireframes cannot be used by developers at all.', false),
    (v_q_id, 'D', 'To ensure the heart icon is perfectly symmetrical.', false);

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
        'Uber''s Edge Case Wireframing',
        E'An Uber PM is creating wireframes for the rider experience. They have mapped out requesting a ride, waiting for the driver, and completing the trip.\n\nWhich of the following represents a critical edge case that MUST be wireframed to ensure a complete flow?',
        'intermediate',
        'Uber',
        'Rider experience flow',
        'A',
        'Edge cases that interrupt the primary user journey (like a driver cancellation) require explicit design solutions to recover the user gracefully (e.g., automatically re-booking and showing a "Finding a new driver" state). Language changes or rare cars are minor variations or secondary actions, whereas a cancellation fundamentally breaks the core transaction and needs a dedicated wireframe flow.',
        ARRAY['edge_cases', 'error_recovery', 'user_journey']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The driver cancels the trip while en route to pick up the rider.', true),
    (v_q_id, 'B', 'The rider wants to change the app language during a trip.', false),
    (v_q_id, 'C', 'The driver has a specific model of car that is rare.', false),
    (v_q_id, 'D', 'The rider wants to read the terms of service while waiting.', false);

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
        'Slack''s Onboarding Flows',
        E'A Slack PM is wireframing a new user onboarding experience for enterprise clients. The PM wants to introduce 8 different advanced features to the user upon their first login.\n\nWhich wireframing approach best balances feature discovery with minimizing user frustration?',
        'intermediate',
        'Slack',
        'Enterprise user onboarding',
        'B',
        'Front-loading complex onboarding via unskippable carousels or massive pop-ups overwhelms users and causes "onboarding fatigue." The modern best practice is contextual onboarding: wireframing small, dismissible tooltips or coach marks that trigger only when the user organically interacts with that specific part of the interface, providing relevant information exactly when it''s needed.',
        ARRAY['onboarding', 'contextual_tooltips', 'cognitive_load']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'An unskippable 8-step full-screen tutorial before they can see their workspace.', false),
    (v_q_id, 'B', 'Contextual tooltips that only appear when the user navigates to the relevant area of the app.', true),
    (v_q_id, 'C', 'A single, massive pop-up containing text explaining all 8 features at once.', false),
    (v_q_id, 'D', 'Sending the user an email with a PDF manual instead of doing in-app onboarding.', false);

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
        'Netflix''s Content Length Variability',
        E'A Netflix PM is reviewing wireframes for a new "Trending Titles" carousel. The designer used short placeholder text like "Movie 1" and "Movie 2" for the titles under the thumbnails.\n\nWhat is the biggest risk of approving this wireframe as-is?',
        'intermediate',
        'Netflix',
        'Trending Titles carousel',
        'C',
        'Wireframes must stress-test UI components with realistic data. Using perfectly uniform, short placeholder text hides structural flaws. If a real movie title is "The Lord of the Rings: The Fellowship of the Ring," it could break the grid, wrap to three lines, or overlap with other UI elements. PMs must ensure wireframes account for character limits and text truncation.',
        ARRAY['data_variability', 'stress_testing', 'ui_components']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The placeholders infringe on copyright.', false),
    (v_q_id, 'B', 'The engineering team won''t know what actual movies to populate.', false),
    (v_q_id, 'C', 'It fails to account for real-world data variability, like long titles that might wrap, break the layout, or overlap.', true),
    (v_q_id, 'D', 'Users prefer to see actual movie posters instead of text.', false);

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
        'Duolingo''s Gamification Layout',
        E'A Duolingo PM is designing a wireframe for the end-of-lesson screen. They need to display XP earned, a daily streak counter, a "Next Lesson" button, and a small ad.\n\nBased on gamification principles, what element should be placed most prominently in the visual hierarchy?',
        'intermediate',
        'Duolingo',
        'End-of-lesson screen',
        'C',
        'In gamified products, the core loop relies on momentum and loss aversion. Highlighting the streak (loss aversion) and providing a massive, clear path to continue (Next Lesson) drives retention. While XP is important, it''s a reward, not the primary action. Promoting the ad above the core loop would degrade the user experience and hurt long-term engagement.',
        ARRAY['gamification', 'visual_hierarchy', 'core_loop']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The small ad, to maximize revenue.', false),
    (v_q_id, 'B', 'The XP earned.', false),
    (v_q_id, 'C', 'The daily streak counter and the "Next Lesson" CTA, to drive immediate retention and loop completion.', true),
    (v_q_id, 'D', 'A button to edit the user''s profile.', false);

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
        'DoorDash''s Status Progression',
        E'A DoorDash PM is wireframing the order tracking screen. The delivery has 4 stages: Preparing, Picked Up, On the Way, and Delivered.\n\nHow should this progression be visually represented in the wireframe to reduce customer support tickets?',
        'intermediate',
        'DoorDash',
        'Order tracking screen',
        'A',
        'A visual stepper (e.g., a progress bar with nodes) manages user expectations by showing not only where the order is *now*, but what the *entire process* is and what steps remain. This transparency reduces anxiety and the urge to contact support. A single text line lacks context about the total journey, and live video is unscalable and privacy-invasive.',
        ARRAY['status_tracking', 'transparency', 'user_anxiety']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A visual stepper or progress bar clearly showing current, past, and future states.', true),
    (v_q_id, 'B', 'A single text field that just says the current state.', false),
    (v_q_id, 'C', 'Push notifications without an in-app visual tracker.', false),
    (v_q_id, 'D', 'A live video feed of the restaurant kitchen.', false);

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
        'Robinhood''s Data Vis Placeholders',
        E'A Robinhood PM is wireframing a new portfolio performance chart. \n\nInstead of a standard line graph, the PM sketches a highly specific interaction where dragging a finger across the chart updates multiple separate metrics elsewhere on the screen simultaneously.\n\nWhy is this a risky element to include in a low-fidelity wireframe?',
        'intermediate',
        'Robinhood',
        'Portfolio performance chart',
        'C',
        'While wireframes define layout, suggesting complex, synchronized data-visualization interactions without technical validation is risky. The PM might "sell" a vision to stakeholders that engineering cannot performantly execute (especially calculating multiple synchronous metric updates on mobile). Such interactions require prototyping and technical spiking, not just a wireframe.',
        ARRAY['technical_feasibility', 'data_visualization', 'prototyping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Line graphs are outdated in modern fintech apps.', false),
    (v_q_id, 'B', 'Low-fidelity wireframes should never include charts.', false),
    (v_q_id, 'C', 'It implies a highly complex technical interaction that may not be feasible or performant, requiring engineering validation first.', true),
    (v_q_id, 'D', 'Users do not like dragging gestures on charts.', false);

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
        'Notion''s Contextual Menus',
        E'A Notion PM is creating a wireframe for a desktop web feature where users can reorder, delete, or duplicate blocks of text.\n\nTo keep the interface clean, the PM hides these actions inside a "hover state" menu that only appears when the mouse is over the block. What is the main issue with this wireframing decision?',
        'intermediate',
        'Notion',
        'Block action menus',
        'D',
        'Designing core interactions explicitly around "hover" states is a massive trap in modern product development because touchscreens (phones and tablets) do not have a hover state. The PM and designer will have to invent a completely different interaction pattern (like an explicit tap or a visible ellipsis icon) for mobile, leading to inconsistent UX and doubled engineering effort.',
        ARRAY['hover_states', 'touch_devices', 'interaction_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Hover states are impossible to build in modern web frameworks.', false),
    (v_q_id, 'B', 'It provides too much information to the user.', false),
    (v_q_id, 'C', 'Hover menus decrease the visual aesthetic of the page.', false),
    (v_q_id, 'D', 'Hover states do not exist on touch devices (mobile/tablet), requiring a completely separate interaction design.', true);

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
        'GitHub''s Breadcrumb Navigation',
        E'A GitHub PM is wireframing the repository file browser. The user can click deep into folders: `Repo > src > components > ui > buttons`.\n\nWhat is the most critical UI component to include in this wireframe to prevent users from getting lost?',
        'intermediate',
        'GitHub',
        'Repository file browser',
        'B',
        'For deep hierarchical data (like a file system), a breadcrumb trail is essential. It provides situational awareness (showing the user exactly where they are) and allows them to navigate up multiple levels of the hierarchy in a single click. A "Back" button only goes up one level, and opening tabs creates massive clutter.',
        ARRAY['breadcrumbs', 'navigation', 'hierarchy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A "Return to Homepage" button.', false),
    (v_q_id, 'B', 'A breadcrumb trail (e.g., `src / components / ui`) allowing one-click upward navigation.', true),
    (v_q_id, 'C', 'A persistent pop-up modal showing the current folder name.', false),
    (v_q_id, 'D', 'Opening every folder in a new browser tab.', false);

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
        'Figma''s Collaborative Edge Cases',
        E'A Figma PM is wireframing a new "Multiplayer Whiteboard" feature. The wireframe shows User A selecting and moving a rectangle. \n\nWhat advanced state must the PM explicitly wireframe to ensure the engineering team accounts for real-time collaboration?',
        'advanced',
        'Figma',
        'Multiplayer Whiteboard',
        'A',
        'In real-time multiplayer products, concurrency and conflict resolution are the hardest technical and UX challenges. The PM must wireframe edge cases like object contention (e.g., locking an object when someone clicks it, or showing multiple cursors fighting) so engineering knows how to handle race conditions visually. Offline states are important, but concurrency is the core complexity here.',
        ARRAY['concurrency', 'real_time_collaboration', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The collision state: What User A sees when User B tries to select and move the exact same rectangle at the exact same time.', true),
    (v_q_id, 'B', 'The offline state for when the server is down.', false),
    (v_q_id, 'C', 'The payment screen for upgrading to a premium account.', false),
    (v_q_id, 'D', 'The color picker menu for the rectangle.', false);

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
        'Shopify''s Component Scalability',
        E'A Shopify PM is wireframing a new "Product Discount" badge to appear on merchant storefronts. \n\nHowever, Shopify merchants use thousands of wildly different, custom-built themes.\n\nHow should the PM approach this wireframing task to ensure it works across all themes?',
        'advanced',
        'Shopify',
        'Product Discount badge',
        'C',
        'In highly extensible platforms like Shopify, a PM cannot wireframe a rigid UI. They must think in terms of modular systems and "injection." The wireframe/spec must focus on the component''s abstract constraints—how it inherits fonts from the parent theme, its max width, and how it handles text overflow—rather than dictating exact pixel placements that will break custom themes.',
        ARRAY['component_design', 'scalability', 'platform_ecosystem']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Wireframe the badge into a single default theme and mandate that all merchants use that theme.', false),
    (v_q_id, 'B', 'Create 1,000 different wireframes, one for each theme.', false),
    (v_q_id, 'C', 'Define the component abstractly, specifying its constraints, DOM injection logic, and dynamic CSS properties, rather than exact pixel placement.', true),
    (v_q_id, 'D', 'Abandon the feature because theme variability is too high.', false);

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
        'Zoom''s Role-Based Interface Variations',
        E'A Zoom PM is wireframing a new "Q&A" panel. The feature has complex permissions: Attendees can ask questions and upvote; Panelists can type answers; Hosts can dismiss questions or answer live.\n\nWhat is the most efficient way to wireframe this to ensure engineering understands the logic?',
        'advanced',
        'Zoom',
        'Q&A panel permissions',
        'B',
        'When dealing with complex Role-Based Access Control (RBAC), drawing a separate wireframe for every minor variation is tedious and hard to maintain. Showing all buttons at once is confusing. The advanced PM approach is to combine a master wireframe with a logic matrix (a table mapping Roles to Actions/UI Elements). This gives engineering a precise, testable source of truth.',
        ARRAY['rbac', 'state_matrix', 'complex_logic']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Draw one massive wireframe with every single button visible and put an asterisk next to ones that are restricted.', false),
    (v_q_id, 'B', 'Create a master component wireframe, accompanied by a state matrix or logic table detailing button visibility per user role.', true),
    (v_q_id, 'C', 'Write a 50-page text document without any wireframes.', false),
    (v_q_id, 'D', 'Only wireframe the Host view, as they are the most important users.', false);

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
        'Discord''s Multi-State Async UI',
        E'A Discord PM is wireframing a feature where users can reply to specific messages in a busy chat channel.\n\nIf User A hits "reply" to a message from User B, but User B deletes their original message before User A hits send, how should the wireframe handle this async conflict?',
        'advanced',
        'Discord',
        'Async message replies',
        'A',
        'In highly asynchronous, multi-user systems, race conditions happen constantly. A good PM anticipates these. Deleting User A''s typed text is hostile UX. Locking User B from deleting is technically difficult and bad privacy. Graceful degradation (sending the message but tombstoning the deleted context) resolves the conflict while preserving user effort.',
        ARRAY['async_communication', 'graceful_degradation', 'race_conditions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Wireframe a graceful degradation state where User A''s message still sends, but the ''replied to'' context is marked as ''[Message Deleted]''.', true),
    (v_q_id, 'B', 'Wireframe a hard error popup that deletes what User A typed and forces them to start over.', false),
    (v_q_id, 'C', 'Prevent User B from deleting their message if someone is currently typing a reply.', false),
    (v_q_id, 'D', 'Ignore this scenario; it''s too rare to wireframe.', false);

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
        'Tinder''s Algorithmic Representation',
        E'A Tinder PM is wireframing what happens when a user runs out of potential matches in their immediate radius.\n\nInstead of just an empty state, the PM wants to use this moment to adjust the recommendation algorithm''s parameters. Which wireframe approach achieves this best?',
        'advanced',
        'Tinder',
        'Empty match stack',
        'D',
        'Advanced PMs use empty states as opportunities for activation or recovery. By embedding algorithm-adjusting controls (like distance/age sliders) directly into the empty state, the PM reduces friction. The user doesn''t have to navigate to a settings menu to solve their problem; they can widen their parameters and immediately generate a new stack of matches.',
        ARRAY['empty_states', 'friction_reduction', 'algorithmic_ui']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A blank screen with a sad face icon.', false),
    (v_q_id, 'B', 'A button that says "Reset Algorithm."', false),
    (v_q_id, 'C', 'A prompt to delete the app.', false),
    (v_q_id, 'D', 'A "Global Mode" toggle combined with interactive sliders to expand age or distance preferences directly on the empty state screen.', true);

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
        'Amazon''s Global vs Local Context',
        E'An Amazon PM is wireframing a new micro-site for "Amazon Pharmacy" inside the main Amazon app. The Pharmacy requires strict HIPAA compliance and a totally different cart system than regular retail.\n\nHow should the wireframe handle the top navigation bar to prevent user confusion?',
        'advanced',
        'Amazon',
        'Amazon Pharmacy micro-site',
        'B',
        'When integrating a fundamentally distinct sub-product with legal/compliance barriers (like a pharmacy inside a retail app), maintaining global context (the regular nav bar) is dangerous. Users might think their regular items and prescriptions are mixed. An advanced wireframe creates a distinct "local context" (a sub-brand nav) that visually anchors the user in the new, separate ecosystem while still allowing an escape hatch to the main app.',
        ARRAY['information_architecture', 'local_context', 'system_integration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the exact same navigation bar as the retail site to ensure brand consistency.', false),
    (v_q_id, 'B', 'Use a "sub-brand" navigation bar that distinctly visually separates the Pharmacy environment and features a dedicated Pharmacy cart.', true),
    (v_q_id, 'C', 'Remove the navigation bar entirely.', false),
    (v_q_id, 'D', 'Merge the retail cart and pharmacy cart into one unified icon, dealing with compliance in the backend.', false);

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
        'Stripe''s Abstract Logic Wireframing',
        E'A Stripe PM is working on a new API feature for complex subscription proration. Since the product is purely backend (an API endpoint), there is no graphical user interface (GUI).\n\nWhat is the equivalent of a "wireframe" that the PM should create to align with engineering and developer-users?',
        'advanced',
        'Stripe',
        'API subscription proration',
        'C',
        'For API-first products, the "UI" is the developer documentation and the API contract itself. The structural equivalent of a wireframe is a sequence diagram or conceptual data model showing how requests, payloads, and webhooks flow between systems. Mocking up fake GUIs wastes time and misses the actual user experience: a developer interacting with endpoints.',
        ARRAY['api_design', 'sequence_diagrams', 'developer_experience']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A graphical mockup of a fake dashboard that will never be built.', false),
    (v_q_id, 'B', 'API products do not need any form of wireframing or structural planning.', false),
    (v_q_id, 'C', 'A sequence diagram mapping the API calls, payloads, and state changes alongside draft developer documentation.', true),
    (v_q_id, 'D', 'A marketing landing page explaining the feature.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Wireframing';

END $$;
