-- ============================================
-- ASSESSMENT: Information Architecture
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
    WHERE slug = 'information-architecture';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug information-architecture not found. Run the seed data first.';
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
        'Spotify''s Library Architecture',
        E'Spotify''s UX team wants to reorganize the ''Your Library'' tab because users are struggling to find saved podcasts among their music playlists. The PM wants to understand how users naturally group audio content in their minds.\n\nWhich research method is best suited for this?',
        'foundational',
        'Spotify',
        'Audio streaming platform library organization',
        'C',
        'Open card sorting (C) is the correct choice when you want to discover users'' natural mental models and categories from scratch. Closed card sorting (D) forces users into your predefined categories, which validates an existing structure but doesn''t help discover organic mental models. Tree testing (A) evaluates an existing navigational hierarchy rather than generating a new one. A/B testing (B) tests specific implemented solutions rather than uncovering the underlying organizational models.',
        ARRAY['card_sorting', 'user_research', 'mental_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tree testing to see if users can navigate the current menu structure.', false),
    (v_q_id, 'B', 'A/B testing two different tab layouts to see which drives more clicks.', false),
    (v_q_id, 'C', 'Open card sorting to see how users categorize items without predefined buckets.', true),
    (v_q_id, 'D', 'Closed card sorting with pre-defined ''Music'' and ''Podcast'' buckets.', false);

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
        'Amazon''s Categorization Models',
        E'Amazon uses a highly structured department list (e.g., Electronics > Computers > Laptops) created by domain experts. However, users can also search by terms like ''work from home essentials'', which group disparate items together based on popular user terminology.\n\nWhich two IA concepts do these approaches represent?',
        'foundational',
        'Amazon',
        'E-commerce catalog organization',
        'B',
        'The correct answer is Taxonomy and Folksonomy (B). A taxonomy is a top-down, structured, hierarchical classification system created by experts (the department list). A folksonomy is a bottom-up classification system that emerges from user-generated tags or common language (like ''work from home essentials''). Understanding the difference helps PMs balance structured browsing with organic, user-driven discovery. The other options refer to search filters (facets), relational mapping (ontology), or navigation design patterns.',
        ARRAY['taxonomy', 'folksonomy', 'categorization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Faceted search and Ontology', false),
    (v_q_id, 'B', 'Taxonomy and Folksonomy', true),
    (v_q_id, 'C', 'Polyhierarchy and Global Navigation', false),
    (v_q_id, 'D', 'Progressive disclosure and LATCH principle', false);

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
        'Airbnb''s Search Refinement',
        E'When users search for a stay on Airbnb, they first enter a destination and dates. On the results page, they can narrow down properties by ''Price range'', ''Type of place'' (entire home vs. room), and ''Amenities'' (Wi-Fi, pool). \n\nWhat is the UX term for this method of filtering?',
        'foundational',
        'Airbnb',
        'Marketplace search filtering',
        'C',
        'Faceted navigation (C) allows users to narrow down a large set of results by applying multiple filters (facets) simultaneously across different dimensions (price, type, amenities). This is standard for marketplaces and e-commerce. Progressive disclosure (A) is about revealing complex features only when needed. Hub and spoke (B) is a navigation pattern where users return to a central index to access different paths. Breadcrumbs (D) show the user''s location in a hierarchy.',
        ARRAY['faceted_navigation', 'search_ux', 'filtering']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Progressive disclosure', false),
    (v_q_id, 'B', 'Hub and spoke navigation', false),
    (v_q_id, 'C', 'Faceted navigation', true),
    (v_q_id, 'D', 'Breadcrumb trailing', false);

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
        'Netflix''s Organization Principle',
        E'Netflix organizes its homepage using horizontal rows. Some rows are genre-based (''Action Movies''), some are temporal (''Recently Added''), and some are localized (''Top 10 in the US Today''). \n\nThis structure relies on varying dimensions of which foundational IA principle?',
        'foundational',
        'Netflix',
        'Streaming content discovery',
        'A',
        'The LATCH principle (A) states that there are only five ways to organize information: Location, Alphabet, Time, Category, and Hierarchy. Netflix uses Category (Action Movies), Time (Recently Added), and Location (Top 10 in the US). Miller''s Law (B) relates to short-term memory capacity (7±2 items). The Pareto Principle (C) is the 80/20 rule. Object-Oriented UX (D) is a methodology for mapping digital objects, not an organizational framework for rows.',
        ARRAY['latch_principle', 'content_organization', 'discovery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The LATCH Principle', true),
    (v_q_id, 'B', 'Miller''s Law', false),
    (v_q_id, 'C', 'The Pareto Principle', false),
    (v_q_id, 'D', 'Object-Oriented UX', false);

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
        'Figma''s Complex Menus',
        E'When a user selects a shape in Figma, the right-hand panel displays basic properties like dimensions, fill color, and stroke. Advanced features, like exporting options or complex auto-layout constraints, are initially hidden and require clicking a ''+'' or ''Advanced'' icon to view.\n\nWhat design principle does this demonstrate?',
        'foundational',
        'Figma',
        'Professional design tool UI',
        'D',
        'Progressive disclosure (D) is an interaction design technique that helps maintain the focus of a user''s attention by reducing clutter, confusion, and cognitive workload. It presents only the minimum data required for the task at hand and offers advanced options on demand. F-pattern (A) is how users read text pages. Information foraging (B) is how users decide where to click based on ''scent''. Polyhierarchy (C) means an item lives in multiple categories.',
        ARRAY['progressive_disclosure', 'cognitive_load', 'ui_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'F-pattern scanning', false),
    (v_q_id, 'B', 'Information foraging', false),
    (v_q_id, 'C', 'Polyhierarchy', false),
    (v_q_id, 'D', 'Progressive disclosure', true);

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
        'Shopify''s Store Navigation',
        E'A Shopify merchant configures their store so that when a user views a specific t-shirt, the top of the page displays:\n`Home > Men''s Clothing > Activewear > Graphic Tees > Product`\n\nWhat type of navigational aid is this, and what is its primary purpose?',
        'foundational',
        'Shopify',
        'E-commerce store navigation',
        'A',
        'These are hierarchical breadcrumbs (A). They show the structure of the site (the taxonomy) leading to the current page, regardless of how the user arrived there. They orient the user and allow easy upward navigation. Attribute breadcrumbs (B) look like ''Size: M | Color: Red''. History breadcrumbs (C) would show the literal pages the user visited (''Home > Search > Product A > Product B''). Global navigation (D) is typically the main header menu, not a trail.',
        ARRAY['breadcrumbs', 'navigation', 'orientation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Hierarchical breadcrumbs; to orient the user and provide one-click access to parent categories.', true),
    (v_q_id, 'B', 'Attribute breadcrumbs; to show the filters applied to the current search.', false),
    (v_q_id, 'C', 'History breadcrumbs; to show the exact path the user took to arrive at the page.', false),
    (v_q_id, 'D', 'Global navigation; to allow jumping to any top-level category instantly.', false);

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
        'Notion''s Document Structure',
        E'Notion allows users to nest pages inside of pages infinitely. While this offers immense flexibility, user research shows that once a workspace goes beyond 5 or 6 levels deep, team members struggle to find important documents without relying entirely on search.\n\nThis is an example of the trade-off between which two IA structures?',
        'foundational',
        'Notion',
        'Knowledge management workspace',
        'C',
        'This scenario highlights the trade-off between deep vs. flat hierarchies (C). Deep hierarchies (many levels of nesting) require more clicks to reach content and can bury information, making discovery hard. Flat hierarchies (few levels, many items per level) require less clicking but can overwhelm users with too many choices at once. A good PM must balance these to optimize discoverability. Browse vs Search (D) is a behavior paradigm, but the structural issue here is depth.',
        ARRAY['hierarchy', 'navigation_depth', 'findability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Faceted vs. Hierarchical', false),
    (v_q_id, 'B', 'Ontological vs. Taxonomical', false),
    (v_q_id, 'C', 'Deep vs. Flat hierarchies', true),
    (v_q_id, 'D', 'Browse-first vs. Search-first', false);

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
        'Uber''s Contextual Navigation',
        E'When you open the Uber app, the immediate primary action is entering a destination (''Where to?''). Once you request a ride, the interface completely changes—the map focuses on the driver''s location, and the menus shift to trip-specific actions (Contact Driver, Split Fare, Cancel).\n\nWhat IA pattern is Uber utilizing here?',
        'foundational',
        'Uber',
        'Ride-hailing mobile application',
        'B',
        'Uber is using task-based Contextual navigation (B). The interface architecture dynamically adapts to the specific phase of the user''s journey (booking vs. waiting vs. riding). The options presented are contextually relevant to the immediate task. Global navigation (A) remains static across the entire app (like a persistent bottom tab bar). Polyhierarchy (C) and faceted navigation (D) relate to organizing and filtering content, not task state changes.',
        ARRAY['contextual_navigation', 'task_based_ui', 'state_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Global navigation', false),
    (v_q_id, 'B', 'Contextual navigation (Task-based)', true),
    (v_q_id, 'C', 'Polyhierarchical navigation', false),
    (v_q_id, 'D', 'Faceted navigation', false);

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
        'Reddit''s Community Restructuring',
        E'Reddit wants to redesign how users navigate topics (e.g., grouping r/nba and r/soccer under ''Sports''). Before writing any code, the PM creates a text-only representation of the proposed menu structure. They ask users to find where they would post a question about fixing a bicycle.\n\nWhat specific UX research technique is the PM conducting?',
        'foundational',
        'Reddit',
        'Community platform navigation',
        'C',
        'Tree testing (C) is a technique for evaluating the findability of topics in a website. It is specifically done using a text-only, stripped-down version of the site structure (the ''tree'') to isolate the IA from visual design or layout influences. Card sorting (A) generates the structure, while tree testing validates it. Usability testing (D) usually involves a visual prototype or live product. Heuristic evaluation (B) is an expert review, not a user test.',
        ARRAY['tree_testing', 'user_research', 'validation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Card sorting', false),
    (v_q_id, 'B', 'Heuristic evaluation', false),
    (v_q_id, 'C', 'Tree testing', true),
    (v_q_id, 'D', 'Usability testing', false);

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
        'Pinterest''s Information Foraging',
        E'On Pinterest, clicking a pin about ''Mid-century modern chairs'' takes the user to a page showing that pin, and immediately below it, a feed of visually similar chairs. Users rarely use the back button, instead diving deeper into the recommendations.\n\nThis behavior is best explained by which IA concept?',
        'foundational',
        'Pinterest',
        'Visual discovery engine',
        'A',
        'Information Scent (A), derived from Information Foraging Theory, describes how users evaluate cues (like images, links) to decide if a path will lead to the information they want. Pinterest maximizes ''scent'' by showing visually similar items immediately, pulling users deeper. Hub and spoke (B) is the opposite—requiring users to return to a central index. Fitts''s Law (C) relates to target size and distance. Ontological mapping (D) is a backend data structure.',
        ARRAY['information_scent', 'foraging_theory', 'discovery']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Information Scent', true),
    (v_q_id, 'B', 'Hub and Spoke navigation', false),
    (v_q_id, 'C', 'Fitts''s Law', false),
    (v_q_id, 'D', 'Ontological mapping', false);

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
        'Slack''s Channel Taxonomy',
        E'A large enterprise uses Slack. A channel named `#marketing-q3-campaign` needs to be easily found by the Marketing team, but also needs to be visible to the Finance team tracking Q3 budgets. \n\nIf the PM wants to design a system where this single channel natively exists under both the ''Marketing'' header and the ''Finance'' header for different users without duplicating the channel, they are implementing:',
        'intermediate',
        'Slack',
        'Enterprise communication platform',
        'B',
        'A polyhierarchy (B) allows a single item to belong to multiple parent categories simultaneously. This solves the problem of cross-functional resources that don''t fit neatly into a single silo. A flat taxonomy (A) would put everything on one level. An exact taxonomy (D) enforces mutually exclusive, rigidly defined categories (like alphabetical or chronological), which fails when items cross boundaries. A chronological ontology (C) is a made-up term.',
        ARRAY['polyhierarchy', 'taxonomy', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A flat taxonomy', false),
    (v_q_id, 'B', 'A polyhierarchy', true),
    (v_q_id, 'C', 'A chronological ontology', false),
    (v_q_id, 'D', 'An exact taxonomy', false);

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
        'DoorDash''s Browsing Paradigm',
        E'DoorDash data shows that 70% of sessions start with users clicking on category carousels (''Fast Food'', ''Healthy'', ''Offers'') rather than typing into the search bar. However, search users convert at a 3x higher rate.\n\nThe PM wants to redesign the app to force users toward the search bar to increase overall conversion. Why is this a flawed application of IA strategy?',
        'intermediate',
        'DoorDash',
        'Food delivery marketplace app',
        'C',
        'The PM is misinterpreting correlation for causation (C). Search users convert higher because they already know what they want (high intent). Browse users are exploring (low intent). Forcing undecided users to use a search bar won''t magically give them high intent; it will likely cause them to bounce because the IA no longer supports their exploratory mental model. IA must support both search-first (known-item) and browse-first (exploratory) behaviors appropriately.',
        ARRAY['search_vs_browse', 'user_intent', 'conversion_fallacy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Search bars take up too much vertical screen real estate on mobile devices.', false),
    (v_q_id, 'B', 'Categorization requires less backend processing power than search indexing.', false),
    (v_q_id, 'C', 'It ignores user intent; browse-first users are undecided, while search-first users already have high purchase intent.', true),
    (v_q_id, 'D', 'Faceted navigation is mathematically proven to generate higher GMV than keyword search.', false);

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
        'Stripe''s API Documentation',
        E'Stripe''s developer docs are famous for their usability. When viewing the ''Payments'' API page, the left sidebar shows all API endpoints for Payments, while the top header allows switching to ''Billing'', ''Connect'', or ''Terminal''.\n\nIn this architecture, the top header and left sidebar represent which navigational concepts respectively?',
        'intermediate',
        'Stripe',
        'Developer documentation site',
        'A',
        'The top header allows switching between major product areas from anywhere on the site, making it Global navigation (A). The left sidebar shows the specific sub-pages within the current section (''Payments''), making it Local navigation. Utility navigation (B) refers to tools like login/settings. Faceted (C) is for filtering. This distinct separation of global and local navigation is critical for orienting users in deeply nested technical documentation.',
        ARRAY['global_navigation', 'local_navigation', 'developer_ux']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Global navigation and Local navigation', true),
    (v_q_id, 'B', 'Utility navigation and Contextual navigation', false),
    (v_q_id, 'C', 'Faceted navigation and Hierarchical navigation', false),
    (v_q_id, 'D', 'Primary ontology and Secondary taxonomy', false);

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
        'GitHub''s Object-Oriented UX',
        E'On GitHub, a ''Repository'' is the central entity. Everything related to it—Issues, Pull Requests, Actions, and Security—lives underneath that Repository''s specific navigation tab, rather than having a global ''All Issues'' tab for the whole site as the primary entry point.\n\nThis structural decision is an example of prioritizing:',
        'intermediate',
        'GitHub',
        'Software development platform',
        'D',
        'GitHub uses an Object-based architecture (D), which is the core of Object-Oriented UX (OOUX). The primary ''object'' is the Repository. Users navigate first to the object they care about, and then take actions (view issues, PRs) on that specific object. A task-based architecture (A) would force the user to choose ''Resolve Issue'' first, then ask ''Which repo?''. Object-based IA mirrors how developers mentally model their work environments.',
        ARRAY['ooux', 'object_oriented_ux', 'mental_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Task-based architecture', false),
    (v_q_id, 'B', 'Chronological architecture', false),
    (v_q_id, 'C', 'Audience-based architecture', false),
    (v_q_id, 'D', 'Object-based architecture', true);

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
        'Discord''s Mobile Navigation',
        E'Discord''s mobile app historically used a deep navigation structure: to switch from a server text channel to a DM, users had to swipe right to open the server menu, tap the home icon, and then tap a DM. Recently, Discord introduced a bottom tab bar with a persistent ''Messages'' tab.\n\nWhat is the primary IA benefit of this change?',
        'intermediate',
        'Discord',
        'Real-time communication app',
        'C',
        'Adding a persistent bottom tab bar flattens the hierarchy (C) and reduces interaction cost. Previously, the hub-and-spoke model required users to backtrack to the root (Home) to switch contexts from Servers to DMs. The persistent tab bar makes core contexts directly accessible from anywhere, saving taps and mental friction during context switching. It does not create a strict flat taxonomy (A) because servers still have deep channel hierarchies.',
        ARRAY['interaction_cost', 'mobile_navigation', 'flat_hierarchy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It converts a polyhierarchy into a strict flat taxonomy.', false),
    (v_q_id, 'B', 'It implements progressive disclosure for power users.', false),
    (v_q_id, 'C', 'It flattens the hierarchy, reducing the interaction cost of context switching.', true),
    (v_q_id, 'D', 'It provides stronger information scent for server discovery.', false);

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
        'Zoom''s Settings Menu',
        E'Zoom''s desktop app settings menu has 15 different side-tabs (General, Video, Audio, Share Screen, Background & Effects, etc.). A PM notices that users consistently struggle to find the ''Hardware Acceleration'' toggle, which is buried under ''Video > Advanced''.\n\nThe team proposes running a card sorting exercise to fix this. Why might this approach be insufficient?',
        'intermediate',
        'Zoom',
        'Video conferencing desktop application',
        'B',
        'While card sorting is great for content categorization, technical settings (like ''Hardware Acceleration'') rely heavily on system models—how the software actually works under the hood. Most users don''t have a mental model for ''Hardware Acceleration'' (B), so asking them to categorize it via card sorting will yield messy, inconsistent results. In these cases, task-based contextual help or robust search is often more effective than trying to map complex system architecture to layperson mental models.',
        ARRAY['card_sorting_limitations', 'system_models', 'mental_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Card sorting is only effective for web applications, not desktop software.', false),
    (v_q_id, 'B', 'Card sorting captures the user''s mental model, but technical settings often require a system model that users don''t inherently understand.', true),
    (v_q_id, 'C', 'Card sorting does not allow for polyhierarchical organization.', false),
    (v_q_id, 'D', 'Tree testing must always be performed before card sorting in settings menus.', false);

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
        'Peloton''s Filter Optimization',
        E'Peloton users complain they can''t find ''quick, difficult, upper-body workouts''. The current IA allows filtering by:\n1. Instructor\n2. Duration (10m, 20m, 30m)\n3. Class Type (Strength, Cycling, Yoga)\n\nWhat is the most effective IA adjustment to solve the user''s specific complaint?',
        'intermediate',
        'Peloton',
        'Connected fitness platform',
        'C',
        'The user is expressing a multi-dimensional query based on duration, difficulty, and body focus. The current faceted navigation lacks the facets required to fulfill this query. Introducing ''Difficulty'' and ''Body Focus'' as new facets (C) directly addresses the missing metadata required for their mental model. Breadcrumbs (A) don''t help filtering. Sorting (B) doesn''t change the available pool. Hiding filters (D) doesn''t add the missing search capability.',
        ARRAY['faceted_search', 'metadata', 'user_queries']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Implement a hierarchical breadcrumb trail so users know where they are.', false),
    (v_q_id, 'B', 'Change the default sort order to chronological (newest first).', false),
    (v_q_id, 'C', 'Introduce ''Difficulty'' and ''Body Focus'' as new facets in the filtering architecture.', true),
    (v_q_id, 'D', 'Use progressive disclosure to hide the Instructor filter.', false);

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
        'Canva''s Contextual Properties',
        E'When a Canva user clicks on a text box, the top toolbar dynamically changes to show Font, Size, and Alignment. When they click on an image, it changes to Edit Image, Crop, and Flip.\n\nIf Canva instead placed every single tool (text, image, video editing) in a massive, persistent left-hand sidebar, what core UX principle would they be violating?',
        'intermediate',
        'Canva',
        'Graphic design platform',
        'A',
        'Showing all tools at all times severely degrades the signal-to-noise ratio and increases cognitive load (A). By using a contextual, dynamically updating toolbar, Canva ensures that the ''signal'' (tools relevant to the current object) is high, and the ''noise'' (irrelevant tools) is zero. A massive persistent sidebar forces the user to manually visually filter out irrelevant tools, slowing down task completion.',
        ARRAY['cognitive_load', 'contextual_ui', 'signal_to_noise']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Signal-to-noise ratio and cognitive load', true),
    (v_q_id, 'B', 'The LATCH principle of organization', false),
    (v_q_id, 'C', 'Information foraging theory', false),
    (v_q_id, 'D', 'The distinction between taxonomy and ontology', false);

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
        'Etsy''s Breadcrumb Challenge',
        E'An Etsy user searches for ''vintage silver ring'', clicks ''Jewelry'', then filters by ''Price < $50'', and clicks a product. The breadcrumb on the product page shows: `Home > Jewelry > Rings > Silver > Vintage`.\n\nWhy did Etsy choose to show this taxonomy path instead of the user''s exact search history path (`Home > Search Results > Price < $50 > Product`)?',
        'intermediate',
        'Etsy',
        'Handmade and vintage e-commerce marketplace',
        'D',
        'Hierarchical taxonomy breadcrumbs provide spatial orientation (D), showing the user where the item lives in the broader catalog regardless of how they got there. This allows the user to easily browse related items (e.g., clicking ''Silver'' to see other silver rings). History breadcrumbs merely duplicate the browser''s ''Back'' button and don''t aid in discovery or structural orientation. SEO (C) is impacted by URLs, not just breadcrumb text, but UX is the primary driver here.',
        ARRAY['breadcrumbs', 'spatial_orientation', 'ecommerce_ux']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Search history paths violate WCAG accessibility guidelines.', false),
    (v_q_id, 'B', 'Taxonomy paths load faster because they don''t require database queries.', false),
    (v_q_id, 'C', 'Search history paths cause duplicate content penalties for SEO.', false),
    (v_q_id, 'D', 'Taxonomy paths provide consistent spatial orientation, whereas history paths trap users in dead-end filter states.', true);

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
        'Amazon''s Facet Logic',
        E'On Amazon, a user applies filters in a specific category.\nFilter Set 1: Brand = ''Sony'' OR Brand = ''Samsung''\nFilter Set 2: Rating = ''4 Stars & Up''\n\nWhich logical operator framework correctly describes standard e-commerce faceted search architecture?',
        'intermediate',
        'Amazon',
        'E-commerce filtering architecture',
        'C',
        'Standard faceted search architecture dictates OR logic within a facet group (Brand = Sony OR Samsung) and AND logic across different facet groups (Brand is [Sony OR Samsung] AND Rating is [4 Stars & Up]). This matches user intent: users want to expand their options within a dimension (I''m okay with either brand), but restrict results across dimensions (but it MUST be highly rated). Option C correctly identifies this standard.',
        ARRAY['faceted_search', 'boolean_logic', 'filtering']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'AND logic within a single facet group, OR logic across different facet groups.', false),
    (v_q_id, 'B', 'OR logic everywhere to maximize the number of results shown.', false),
    (v_q_id, 'C', 'OR logic within a single facet group, AND logic across different facet groups.', true),
    (v_q_id, 'D', 'AND logic everywhere to ensure maximum precision of results.', false);

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
        'Shopify''s Admin Validation',
        E'Shopify has drafted a new, reorganized left-hand navigation menu for its merchant admin dashboard. Before launching, the PM wants to ensure merchants can successfully find where to ''Setup tax rates for Canada'' using only the new category names.\n\nWhich quantitative method is best to evaluate this specific task?',
        'intermediate',
        'Shopify',
        'E-commerce platform admin dashboard',
        'B',
        'Tree testing (B) is exactly designed for this. It evaluates the findability of items within a proposed hierarchy without visual distractions. Participants are given a task (''Setup tax rates'') and asked to click through a text-based tree to show where they would expect to find it. This provides quantitative data (success rate, directness) on the drafted IA. Open card sorting (C) generates categories rather than testing drafted ones. A/B testing (A) is too expensive if the IA is fundamentally flawed.',
        ARRAY['tree_testing', 'validation', 'quantitative_research']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A/B testing the live navigation panel', false),
    (v_q_id, 'B', 'Tree testing', true),
    (v_q_id, 'C', 'Open card sorting', false),
    (v_q_id, 'D', 'Clickstream analysis of current behavior', false);

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
        'Airbnb''s Overlapping Categories',
        E'During an open card sort for Airbnb''s ''Experiences'', the PM notices that 40% of users placed ''Pasta Making Class'' in ''Food & Drink'', while 60% placed it in ''Cultural Activities''.\n\nWhat is the most architecturally robust way to handle this split mental model?',
        'intermediate',
        'Airbnb',
        'Travel marketplace experiences',
        'C',
        'When mental models are heavily split, forcing a single taxonomy (A) alienates a large portion of users. Creating overly specific hybrid categories (B) inflates the taxonomy and causes clutter. The most robust solution is polyhierarchy (C), where the database architecture allows a single item (''Pasta Making'') to be tagged and discovered natively within both parent categories. This satisfies different navigational intents without structural bloat.',
        ARRAY['polyhierarchy', 'card_sorting', 'mental_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force the item into ''Cultural Activities'' since it won the majority vote.', false),
    (v_q_id, 'B', 'Create a new top-level category called ''Food & Culture'' to satisfy both groups.', false),
    (v_q_id, 'C', 'Utilize polyhierarchy and assign the item to both categories.', true),
    (v_q_id, 'D', 'Eliminate categories and force users to rely strictly on search.', false);

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
        'Spotify''s Navigation Overload',
        E'Spotify decides to add a new ''Live Audio'' feature. The bottom tab bar already has Home, Search, and Your Library. The design team argues against adding a fourth tab, stating it violates the ''Rule of 3'' in mobile design.\n\nAs a PM, how should you evaluate this claim regarding mobile IA?',
        'intermediate',
        'Spotify',
        'Mobile app navigation constraints',
        'D',
        'The ''Rule of 3'' is not a hard rule for mobile tab bars; both iOS and Android guidelines commonly support up to 5 tabs (D). The decision shouldn''t be based on a made-up rule, but on whether ''Live Audio'' has high enough task frequency, importance, and usage to justify top-level global placement alongside Home and Search. Miller''s Law (A) is 7±2, not 3. More tabs do not always increase engagement (C); they can dilute focus.',
        ARRAY['mobile_navigation', 'heuristics', 'global_navigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree, because Miller''s Law states users can only hold 3 items in short-term memory.', false),
    (v_q_id, 'B', 'Agree, because iOS Human Interface Guidelines strictly forbid more than 3 tabs.', false),
    (v_q_id, 'C', 'Disagree, because more tabs always increase user engagement metrics.', false),
    (v_q_id, 'D', 'Disagree, as standard mobile conventions commonly support up to 5 bottom tabs; the decision should be based on task frequency and feature parity.', true);

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
        'Figma''s Plugin Architecture',
        E'Figma currently places ''Plugins'' under a global dropdown menu. As the plugin ecosystem grows to thousands of tools, the dropdown becomes unnavigable. The PM proposes moving Plugins to an searchable ''App Store'' modal.\n\nThis shift moves the IA from a ________ model to a ________ model.',
        'intermediate',
        'Figma',
        'Design software plugin ecosystem',
        'A',
        'A dropdown menu relies on a Browse-first model (A), where users visually scan a list to find what they need. When lists scale to thousands of items, browsing fails. Moving to a searchable modal shifts the architecture to a Search-first model, which is much more scalable for massive inventories. It relies on user recall and query formulation rather than visual recognition.',
        ARRAY['scaling_ia', 'search_vs_browse', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Browse-first; Search-first', true),
    (v_q_id, 'B', 'Hierarchical; Polyhierarchical', false),
    (v_q_id, 'C', 'Contextual; Global', false),
    (v_q_id, 'D', 'Ontological; Taxonomical', false);

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
        'Notion''s Block Ontology',
        E'In Notion, everything is a ''Block'' (text, image, table row). A table row block can be dragged out and turned into an entire Page block. A Page block can be referenced dynamically inside another block.\n\nWhat IA concept allows Notion to treat content so fluidly?',
        'intermediate',
        'Notion',
        'Knowledge management software architecture',
        'D',
        'Notion relies on Object-Oriented Architecture (D). Because the underlying data entity (the Block) is decoupled from its presentation layer, a single block can manifest as a row in a table, a standalone page, or an item in a kanban board. This architectural decision creates immense flexibility. A strict hierarchy (A) would tie content rigidly to its container. LATCH (C) and progressive disclosure (B) are UI patterns, not underlying data architectures.',
        ARRAY['ooux', 'ontology', 'decoupled_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Strict hierarchical taxonomy', false),
    (v_q_id, 'B', 'Faceted progressive disclosure', false),
    (v_q_id, 'C', 'The LATCH principle', false),
    (v_q_id, 'D', 'Object-Oriented Architecture with decoupled presentation', true);

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
        'Slack''s Search Recall vs Precision',
        E'When searching for ''Q3 Deck'' in Slack, the system returns 500 messages containing those words. Users complain the search is useless. The PM tweaks the algorithm to only return messages where ''Q3 Deck'' is in the file title, reducing results to 5 highly relevant files.\n\nThe PM has prioritized ________ over ________.',
        'intermediate',
        'Slack',
        'Enterprise search optimization',
        'B',
        'Precision measures how many of the returned results are actually relevant. Recall measures how many of the total relevant results in the database were returned. By restricting the search to file titles, the PM improved Precision (fewer, but highly accurate results) at the expense of Recall (ignoring messages that discuss the Q3 deck but don''t contain the file). Balancing precision and recall is a core search IA challenge.',
        ARRAY['search_ux', 'precision_vs_recall', 'findability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Recall; Precision', false),
    (v_q_id, 'B', 'Precision; Recall', true),
    (v_q_id, 'C', 'Taxonomy; Folksonomy', false),
    (v_q_id, 'D', 'Information Scent; Discoverability', false);

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
        'Netflix''s Information Matrix',
        E'When you finish an episode of ''Stranger Things'' on Netflix, the UI doesn''t just ask you to go back to the menu. It immediately surfaces a ''Next Episode'' button, and below that, a row of ''More Like Stranger Things''.\n\nThis network of interconnected pathways that bypass the standard taxonomy is known as:',
        'intermediate',
        'Netflix',
        'Streaming media content architecture',
        'B',
        'Cross-linking (or contextual navigation) (B) connects related items across different parts of the taxonomy, allowing users to move laterally without going up and down the hierarchy. This creates a matrix structure rather than a strict tree. Netflix uses this to keep users engaged. Global navigation (A) is the main menu. Faceted discovery (C) is filtering. Breadcrumbs (D) go up the hierarchy.',
        ARRAY['cross_linking', 'matrix_architecture', 'contextual_navigation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Global navigation', false),
    (v_q_id, 'B', 'Cross-linking / Contextual navigation', true),
    (v_q_id, 'C', 'Faceted discovery', false),
    (v_q_id, 'D', 'Sequential breadcrumbs', false);

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
        'Robinhood''s Linear Flow',
        E'When buying a stock on Robinhood, the user goes through a strict sequence: 1) Enter amount, 2) Review order, 3) Swipe up to submit. During this flow, the global bottom navigation bar is completely hidden.\n\nWhy did the PM choose to hide the global navigation?',
        'intermediate',
        'Robinhood',
        'Fintech trade execution flow',
        'C',
        'Hiding global navigation during a critical task creates a ''tunnel'' or sequential IA (C). This removes visual noise and navigational off-ramps, forcing the user to focus solely on completing the high-intent task (executing the trade) or explicitly canceling it. This is a common pattern in checkouts and financial transactions to reduce abandonment and errors.',
        ARRAY['sequential_navigation', 'task_completion', 'tunneling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To save screen space for legal disclaimers.', false),
    (v_q_id, 'B', 'To force a polyhierarchical structure.', false),
    (v_q_id, 'C', 'To create a tunnel / sequential IA that removes off-ramps and focuses on task completion.', true),
    (v_q_id, 'D', 'Because global navigation is incompatible with the LATCH principle.', false);

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
        'GitHub''s Architecture Scaling',
        E'GitHub historically organized around code repositories. As they introduced ''GitHub Actions'' (CI/CD pipelines), they had to integrate an entirely different mental model—workflows, runs, and deployments—into the existing repo-centric IA.\n\nWhich approach is the most scalable way to handle this macro-IA challenge?',
        'advanced',
        'GitHub',
        'Developer platform expansion',
        'B',
        'Because Actions are fundamentally tied to the code they act upon, extending the existing Object-Oriented structure (B) is the most scalable and logical approach. Embedding Actions within the specific Repository maintains the Repo as the central organizing object. Divorcing them (A) breaks the contextual relationship. Faceted search (C) or a chronological feed (D) would destroy the mental model of a project workspace and create chaos.',
        ARRAY['scaling_ia', 'ooux', 'platform_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a separate global tab for ''Actions'' completely divorced from repositories.', false),
    (v_q_id, 'B', 'Extend the existing Object-Oriented structure by embedding Actions as a nested tab within each specific Repository object.', true),
    (v_q_id, 'C', 'Use faceted search to allow users to filter between Code and Actions on the homepage.', false),
    (v_q_id, 'D', 'Implement a flat hierarchy where Code and Actions are combined in a single chronological feed.', false);

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
        'Stripe''s Versioned Ontology',
        E'Stripe frequently updates its API. Different merchants are on different API versions. The documentation IA must display the correct fields, endpoints, and examples corresponding to the user''s specific API version, without creating 50 separate, duplicate documentation websites.\n\nHow is this dynamically managed on the backend?',
        'advanced',
        'Stripe',
        'Developer API documentation',
        'A',
        'Advanced dynamic IA relies on a robust ontology and metadata (A). Content blocks (like a parameter description) are objects tagged with metadata (e.g., `added_in: v2`, `deprecated_in: v4`). The front-end queries this ontology based on the user''s logged-in state to dynamically assemble the correct documentation. Creating separate folders for every version (B) causes unmanageable duplication and breaks cross-linking.',
        ARRAY['ontology', 'metadata', 'dynamic_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'By building an ontology where content blocks are tagged with metadata defining their version lifespan, dynamically rendered based on user state.', true),
    (v_q_id, 'B', 'By using a strict hierarchical taxonomy with a new top-level folder for every version.', false),
    (v_q_id, 'C', 'By relying entirely on user-generated folksonomies to tag outdated information.', false),
    (v_q_id, 'D', 'By utilizing progressive disclosure to hide older versions behind an ''Advanced'' tab.', false);

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
        'Uber''s Dynamic Taxonomy',
        E'Uber''s ride selection menu (UberX, Comfort, Black) changes dynamically. If it''s raining heavily and driver supply is low, ''Wait & Save'' might disappear, and ''UberXL'' might move to the top of the list if those drivers are idle.\n\nThis represents a shift from static IA to:',
        'advanced',
        'Uber',
        'Marketplace dynamic pricing and matching',
        'C',
        'Uber uses an Algorithmic/Contextual IA (C). Instead of a static taxonomy where categories are always in the same place, the system dynamically reorders, hides, or promotes categories based on real-time business constraints (supply/demand) and contextual relevance. This maximizes conversion and marketplace liquidity, overriding traditional rules of static spatial consistency in UX.',
        ARRAY['dynamic_ia', 'contextual_ux', 'marketplace_mechanics']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A toponymic hierarchy', false),
    (v_q_id, 'B', 'A user-controlled folksonomy', false),
    (v_q_id, 'C', 'An algorithmic/contextual IA driven by supply constraints and business logic.', true),
    (v_q_id, 'D', 'A chronological LATCH system', false);

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
        'Reddit''s Tree Testing Analysis',
        E'Reddit conducts a tree test for a new navigation structure. The results show a 85% success rate for finding ''r/personalfinance'', but the ''directness'' score is only 40%. \n\n| Metric | Score |\n|--------|-------|\n| Success Rate | 85% |\n| Directness | 40% |\n\nWhat does this data indicate about the proposed IA?',
        'advanced',
        'Reddit',
        'Community platform navigation restructuring',
        'C',
        'In tree testing, ''Success Rate'' is whether they eventually found it. ''Directness'' measures if they found it on the first try without backtracking. High success but low directness (C) means the item is there, but the information scent or category labeling is misleading. Users are clicking down the wrong path, realizing their mistake, backing up, and trying another path until they succeed. The IA causes friction.',
        ARRAY['tree_testing', 'quantitative_analysis', 'information_scent']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The IA is perfect; users are successfully finding the content.', false),
    (v_q_id, 'B', 'The terminology is confusing, so users are abandoning the task entirely.', false),
    (v_q_id, 'C', 'Users ultimately find the content, but the paths are confusing, leading to excessive backtracking and guessing.', true),
    (v_q_id, 'D', 'The polyhierarchy is too flat, forcing users to click through too many top-level items.', false);

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
        'Amazon''s Global Ontology',
        E'Amazon needs to ensure that a ''Waterproof Case'' appears when users filter by ''Features: Waterproof'' in Electronics, but also appears if someone searches for ''Scuba Gear'' in Sports & Outdoors. \n\nTo achieve this without duplicating the product entry, the data architects must define relationship rules between disparate domains. This structure is called:',
        'advanced',
        'Amazon',
        'Global e-commerce database architecture',
        'B',
        'An ontology (B) maps complex relationships and properties between different entities across domains. While a taxonomy categorizes items hierarchically (Electronics > Cases), an ontology defines rules and relationships (A ''Case'' `has_attribute` ''Waterproof''; ''Waterproof'' `is_relevant_to` ''Scuba Gear''). This allows the system to surface the item dynamically across completely different branches of the taxonomy based on relational logic.',
        ARRAY['ontology', 'metadata', 'relational_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A flat folksonomy', false),
    (v_q_id, 'B', 'An ontology', true),
    (v_q_id, 'C', 'A sequential breadcrumb matrix', false),
    (v_q_id, 'D', 'A faceted taxonomy', false);

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
        'DoorDash''s Polyhierarchical Conflicts',
        E'DoorDash categorizes restaurants by Cuisine (''Italian'', ''Mexican'') and by Fulfillment (''DashPass'', ''Pickup''). A PM notices that users browsing the ''Italian'' carousel are missing out on highly-rated DashPass Italian restaurants because those were exclusively categorized under a promotional ''DashPass'' carousel.\n\nWhat structural failure caused this?',
        'advanced',
        'DoorDash',
        'Food delivery platform categorization',
        'A',
        'The failure was treating two different dimensions (Cuisine type vs. Fulfillment method) as mutually exclusive buckets (A). A restaurant can be both Italian AND DashPass. By structurally forcing restaurants into one or the other, the IA breaks. The solution is applying a polyhierarchical tagging system where restaurants inherit attributes from multiple dimensions, allowing them to populate dynamically in all relevant carousels.',
        ARRAY['taxonomy_conflicts', 'polyhierarchy', 'dimensional_modeling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Treating mutually inclusive dimensions (Cuisine and Fulfillment) as mutually exclusive taxonomy nodes.', true),
    (v_q_id, 'B', 'Applying the LATCH principle too rigidly to chronological data.', false),
    (v_q_id, 'C', 'Over-relying on user-generated folksonomies for promotional categories.', false),
    (v_q_id, 'D', 'Using faceted search instead of a hub-and-spoke model.', false);

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
        'Airbnb''s Search Intent Weighting',
        E'When a user searches ''Beach house'' on Airbnb, the system returns exact matches for the facet `Property_Type = Beach House`. However, if the user searches ''Paris'', the system ignores the property type and prioritizes `Location = Paris` and `Distance_to_Center`.\n\nThe IA dynamically shifts its primary sorting and filtering architecture based on:',
        'advanced',
        'Airbnb',
        'Travel search algorithms',
        'D',
        'Airbnb''s search IA uses semantic parsing to deduce implicit search intent (D). It recognizes that ''Paris'' is a location entity, while ''Beach house'' is a property type entity. The architecture dynamically re-weights which facets and ontologies dictate the result structure based on the inferred intent of the unstructured search query. This bridges the gap between open-ended user queries and strictly structured backend data.',
        ARRAY['search_intent', 'semantic_search', 'dynamic_architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Heuristic evaluation scores', false),
    (v_q_id, 'B', 'Strict alphabetical LATCH sorting', false),
    (v_q_id, 'C', 'Progressive disclosure requirements', false),
    (v_q_id, 'D', 'Implicit search intent and semantic parsing', true);

    RAISE NOTICE 'Successfully inserted 35 questions for Information Architecture';

END $$;