-- ============================================
-- ASSESSMENT: Design Systems
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
    WHERE slug = 'design-systems';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug design-systems not found. Run the seed data first.';
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
        'Airbnb''s Color Management',
        E'Airbnb''s design team notices that engineers have hardcoded 14 different variations of the brand''s "Rausch" red color across the iOS, Android, and Web apps. A foundational PM is tasked with standardizing this.\n\nWhich of the following is the most scalable way to resolve this issue?',
        'foundational',
        'Airbnb',
        'Cross-platform color consistency',
        'C',
        'Design tokens map abstract visual properties (like a brand color) to semantic names, ensuring that updates propagate universally without hardcoded values. Option C correctly defines a single source of truth that compiles to native formats. Option A is unscalable and manual. Option B ignores iOS and Android. Option D focuses on SVG assets, not color values.',
        ARRAY['design_tokens', 'consistency', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mandate that all developers manually search and replace hex codes to match the official Figma file', false),
    (v_q_id, 'B', 'Create a centralized CSS file and force all native mobile engineers to import it into their views', false),
    (v_q_id, 'C', 'Implement design tokens for the core brand colors and export them to platform-specific code formats automatically', true),
    (v_q_id, 'D', 'Replace all text and background colors with SVG image assets so they render identically across devices', false);

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
        'Slack''s Button States',
        E'Slack is updating its primary action button. A PM observes that the engineering team is creating separate React components for the "Hover", "Active", "Disabled", and "Loading" states of the button.\n\nWhat is the primary design system principle the team is violating?',
        'foundational',
        'Slack',
        'Component reuse and state management',
        'B',
        'A core principle of component libraries is that a single component should encapsulate all its variations and states, simplifying implementation. Having separate components for states violates reusability and encapsulation. Option A is incorrect as tokens handle styling, not component logic. Option C is about spacing. Option D is a made-up principle.',
        ARRAY['component_library', 'reusability', 'maintenance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Token atomization — they should be using design tokens for each state instead of components', false),
    (v_q_id, 'B', 'Encapsulation and reusability — a single button component should handle all its internal states via props', true),
    (v_q_id, 'C', 'The 8pt grid system — state changes should only affect padding and margin, not the component itself', false),
    (v_q_id, 'D', 'Progressive disclosure — users shouldn''t see the disabled state until they hover over the button', false);

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
        'Spotify''s Platform Guidelines',
        E'Spotify''s PM for the Encore design system is reviewing a new tab bar navigation proposal. The designer wants the tab bar to look identical on iOS and Android to "maintain brand consistency."\n\nWhat is the main risk of strictly enforcing identical UI across iOS and Android?',
        'foundational',
        'Spotify',
        'Cross-platform UI design',
        'D',
        'Design systems must balance brand identity with native platform conventions. Forcing an identical UI often leads to experiences that feel broken or alien to users accustomed to OS-specific interaction patterns. Option D correctly identifies this tension. Option A is false; code sharing is about business logic, not UI identicality. Option B is wrong as Apple and Google have guidelines, but don''t strictly ban identical designs. Option C is unrelated.',
        ARRAY['consistency', 'platform_conventions', 'integration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It makes code-sharing between platforms impossible since React Native cannot render identical UIs', false),
    (v_q_id, 'B', 'Apple and Google will reject the app from their stores for not using their default system components', false),
    (v_q_id, 'C', 'The tab bar will consume too much memory on older Android devices compared to iOS devices', false),
    (v_q_id, 'D', 'It ignores native interaction patterns, making the app feel unnatural to users on their respective platforms', true);

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
        'Shopify''s Polaris Adoption',
        E'A product team at Shopify is building a new merchant analytics dashboard. The team''s tech lead argues against using the Polaris design system, stating they can build custom charts faster using a 3rd-party charting library.\n\nWhat is the strongest PM argument for insisting the team uses Polaris components instead?',
        'foundational',
        'Shopify',
        'Internal design system adoption',
        'C',
        'The strongest value proposition of a design system is the reduction of long-term technical debt and maintenance burden. While building custom might be faster initially, it creates a fragmented experience and a long-term maintenance nightmare. Option C directly addresses the lifecycle cost. Option A is a weak argument as third-party tools can be fast. Option B is overly rigid. Option D is incorrect as third-party libraries can be accessible.',
        ARRAY['adoption', 'maintenance', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Custom components are inherently slower to render in the browser than design system components', false),
    (v_q_id, 'B', 'Engineers are not allowed to make architecture decisions without PM approval', false),
    (v_q_id, 'C', 'It ensures long-term visual consistency, accessibility compliance, and unified maintenance when global updates occur', true),
    (v_q_id, 'D', 'Third-party charting libraries cannot be made accessible for screen readers', false);

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
        'Uber''s Base Icon Update',
        E'Uber decides to update its standard "Profile" icon globally from an outlined style to a filled style. The icon is used in 45 different places across the Rider, Driver, and Eats apps.\n\nWith a mature design system in place, how should this update be executed?',
        'foundational',
        'Uber',
        'Centralized system updates',
        'B',
        'A mature design system centralizes assets. Updating the icon in the central library automatically propagates the change to all consuming applications via dependency updates. Option B is the textbook definition of design system efficiency. Option A defeats the purpose of the system. Option C is risky and brittle. Option D describes a massive, unnecessary manual effort.',
        ARRAY['component_library', 'maintenance', 'consistency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Each product team must schedule a sprint to manually replace the icon asset in their respective codebases', false),
    (v_q_id, 'B', 'Update the icon in the central system library and bump the package version for product teams to consume', true),
    (v_q_id, 'C', 'Deploy a global CSS override that hides the old icon and displays the new one as a background image', false),
    (v_q_id, 'D', 'Run an automated script that searches all code repositories for the word "profile" and replaces the image files', false);

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
        'Netflix''s TV Focus States',
        E'A PM on the Netflix TV UI team notices that many users are getting lost while navigating the app with their remote controls. The PM suspects the design system''s focus states are inadequate.\n\nWhat is the most critical design system requirement for focus states on a TV interface?',
        'foundational',
        'Netflix',
        'Accessibility and focus indicators',
        'A',
        'On a 10-foot UI (TV), focus states are the only way users know where they are. High contrast, scale, and clear visual indicators are paramount for accessibility and navigation. Option A is correct. Option B is an anti-pattern; removing outlines ruins accessibility. Option C is irrelevant to the core issue. Option D is a motion preference, not a foundational accessibility requirement.',
        ARRAY['accessibility', 'component_library', 'integration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'They must have high contrast and clear visual prominence to ensure users know exactly which element is active', true),
    (v_q_id, 'B', 'They should completely remove default browser outlines to maintain the cinematic brand aesthetic', false),
    (v_q_id, 'C', 'They must dynamically change color based on the dominant color of the movie poster being hovered', false),
    (v_q_id, 'D', 'They should only appear if the user presses the arrow keys more than three times rapidly', false);

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
        'Discord''s Dark Mode',
        E'Discord is overhauling its light and dark modes. Currently, developers use specific hex codes (e.g., `#FFFFFF` and `#36393F`) directly in their code.\n\nHow should a PM structure the design tokens to cleanly support multiple themes?',
        'foundational',
        'Discord',
        'Theming and semantic tokens',
        'A',
        'Semantic tokens (e.g., `color-background-primary`) act as an abstraction layer between the code and the raw values. When switching themes, the token name stays the same, but the underlying hex value changes. Option A is the standard approach to theming. Option B hardcodes values to specific themes. Option C is a manual, unscalable approach. Option D is an anti-pattern.',
        ARRAY['design_tokens', 'scalability', 'consistency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create semantic tokens (e.g., `background-primary`) that map to different hex values depending on the active theme', true),
    (v_q_id, 'B', 'Create specific tokens for each theme (e.g., `dark-bg-color` and `light-bg-color`) and use conditional logic in every component', false),
    (v_q_id, 'C', 'Eliminate tokens entirely and use a global find-and-replace script whenever a user toggles the theme', false),
    (v_q_id, 'D', 'Hardcode dark mode colors as the default, and use CSS `filter: invert(100%)` to generate the light mode automatically', false);

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
        'Atlassian''s System Governance',
        E'Atlassian''s design system has grown significantly, but product teams are starting to create their own custom components because "the central team is too slow to approve updates."\n\nWhich governance model is most likely causing this bottleneck?',
        'foundational',
        'Atlassian',
        'Design system governance',
        'B',
        'A strict centralized governance model, where a single gatekeeper team must approve every change, inevitably creates a bottleneck as the organization scales. This leads to product teams bypassing the system. Option B correctly identifies the root cause. Option A is the opposite. Option C and D are not governance models that cause approval bottlenecks.',
        ARRAY['governance', 'adoption', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Federated governance, where all product teams contribute equally to the system', false),
    (v_q_id, 'B', 'Strict centralized governance, where one core team must build and approve all components', true),
    (v_q_id, 'C', 'Open-source governance, where anyone on the internet can submit pull requests', false),
    (v_q_id, 'D', 'Automated governance, where scripts determine if a component is allowed', false);

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
        'Figma''s Component Properties',
        E'A PM reviewing a design system file in Figma notices there are 48 separate components for a single text input field (e.g., Input-Default, Input-Hover, Input-Error, Input-Disabled, etc.).\n\nWhat modern design system feature should be used to consolidate this?',
        'foundational',
        'Figma',
        'Component variants and architecture',
        'A',
        'Component variants (and properties) allow designers to group related states and variations of a single component into one unified element, drastically reducing clutter and mirroring how components are built in code with props. Option A is correct. Option B, C, and D are unrelated concepts.',
        ARRAY['component_library', 'reusability', 'consistency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Component Variants, to group them into a single component with configurable properties', true),
    (v_q_id, 'B', 'Auto Layout, to automatically stack all the inputs in a responsive grid', false),
    (v_q_id, 'C', 'Color Styles, to ensure all the inputs use the same hex codes', false),
    (v_q_id, 'D', 'Design Tokens, to abstract the spacing between the inputs', false);

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
        'GitHub''s Primer Deprecation',
        E'The GitHub Primer team decides to replace an old `DropdownMenu` component with a newly accessible `ActionMenu`. The old component is currently used in 500+ files.\n\nWhat is the safest initial step the PM should take to phase out the old component?',
        'foundational',
        'GitHub',
        'Component deprecation lifecycle',
        'C',
        'Deprecating widely used components requires a phased approach. The first step is to mark the old component as deprecated in the documentation and code (e.g., triggering console warnings), preventing new usage while keeping existing code functioning. Option C is the standard graceful deprecation path. Option A breaks production. Option B is inefficient. Option D causes immediate widespread build failures.',
        ARRAY['deprecation', 'maintenance', 'integration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delete the old component from the library immediately to force teams to upgrade', false),
    (v_q_id, 'B', 'Run an automated script that replaces all instances of `DropdownMenu` with `ActionMenu` in one commit', false),
    (v_q_id, 'C', 'Mark `DropdownMenu` as deprecated in code and docs, triggering warnings for developers, but leave it functioning', true),
    (v_q_id, 'D', 'Change the old component to throw a fatal error on compilation to ensure no one ships it', false);

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
        'Stripe''s Composition Pattern',
        E'Stripe is building a complex "Checkout Modal" component. The design system PM must decide whether to build it as one massive component with 40 configuration props, or as a composition of smaller sub-components (Header, Body, Footer).\n\nWhy is the composition approach generally superior for a design system?',
        'intermediate',
        'Stripe',
        'Component architecture and API design',
        'D',
        'Massive components with dozens of props ("god components") become incredibly difficult to maintain and are inflexible for product teams. Composition allows developers to assemble smaller, self-contained components in flexible ways without bloating a single component''s API. Option D is the key architectural principle. Option A is false (composition is often harder to enforce). Option B is incorrect. Option C is a minor code detail, not the primary architectural reason.',
        ARRAY['component_library', 'scalability', 'reusability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Composition strictly limits what developers can build, ensuring 100% adherence to the core brand guidelines', false),
    (v_q_id, 'B', 'A single component with many props requires less code for the design system team to write initially', false),
    (v_q_id, 'C', 'Browsers parse composed components faster because they use native HTML tags exclusively', false),
    (v_q_id, 'D', 'It prevents "prop bloat" and offers product teams greater flexibility without breaking the underlying architecture', true);

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
        'Tinder''s App Size Constraint',
        E'Tinder''s engineering team complains that importing the global design system library is bloating the app''s initial bundle size, impacting load times in emerging markets.\n\nWhich technique should the design system PM advocate for to solve this performance issue?',
        'intermediate',
        'Tinder',
        'Performance and tree-shaking',
        'C',
        'Tree-shaking is a build step optimization that removes unused code from the final bundle. If a team only uses the Button component, tree-shaking ensures they don''t pay the bundle size cost for the DatePicker and Modal components. Option C is the correct technical solution. Option A creates massive duplication. Option B is an accessibility violation. Option D destroys the system''s core value proposition.',
        ARRAY['integration', 'scalability', 'maintenance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Publish each component as a completely independent npm package so teams only install what they need', false),
    (v_q_id, 'B', 'Remove all accessibility ARIA tags from the components since they add unnecessary text to the bundle', false),
    (v_q_id, 'C', 'Ensure the component library is properly configured for tree-shaking so unused components are stripped from the build', true),
    (v_q_id, 'D', 'Mandate that the design system can only use system-default fonts and pure CSS, forbidding all JavaScript', false);

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
        'DoorDash''s Component A/B Testing',
        E'The DoorDash design system team redesigns the "Add to Cart" button to be more prominent. They want to A/B test this change across the entire app before committing it to the central library.\n\nWhat is the primary risk of rolling this out globally as an A/B test inside the design system layer?',
        'intermediate',
        'DoorDash',
        'A/B testing systemic changes',
        'B',
        'A design system change affects every instance of a component globally. An A/B test at the system level introduces uncontrolled variables; the new button might improve conversion on the restaurant page but break the layout or hurt metrics on the checkout page. The interference makes it impossible to isolate the effect. Option B correctly identifies this compounding variable issue. Option A is technically false. Option C is a minor issue. Option D is irrelevant.',
        ARRAY['integration', 'consistency', 'adoption']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Design system libraries cannot accept feature flags or contextual parameters by default', false),
    (v_q_id, 'B', 'The global change introduces confounding variables across different product contexts, making the test results untrustworthy', true),
    (v_q_id, 'C', 'The A/B test will cause layout shifts (CLS) that temporarily penalize the site''s SEO ranking', false),
    (v_q_id, 'D', 'Designers will have to maintain two parallel Figma files until the experiment concludes', false);

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
        'Salesforce''s Lightning Versioning',
        E'The Salesforce Lightning Design System team is planning an update to the DatePicker component. They are removing an old `autoFormat` prop and replacing it with a new `locale` prop.\n\nAccording to semantic versioning (SemVer) principles, how should this update be published?',
        'intermediate',
        'Salesforce',
        'Semantic versioning and breaking changes',
        'A',
        'In Semantic Versioning (MAJOR.MINOR.PATCH), removing a prop constitutes a breaking API change because any consuming application using that prop will fail. Therefore, it requires a Major version bump. Option A is correct. Option B is for backwards-compatible features. Option C is for bug fixes. Option D is not a standard SemVer practice.',
        ARRAY['versioning', 'deprecation', 'maintenance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As a Major version bump (e.g., v3.0.0 to v4.0.0), because removing a prop is a breaking change', true),
    (v_q_id, 'B', 'As a Minor version bump (e.g., v3.1.0 to v3.2.0), because the core component still exists', false),
    (v_q_id, 'C', 'As a Patch version bump (e.g., v3.1.1 to v3.1.2), because it only changes the component''s configuration', false),
    (v_q_id, 'D', 'Without a version bump, but accompanied by a global email alert to all engineering teams', false);

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
        'Notion''s Design-Dev Handoff',
        E'A Notion PM observes that engineers are constantly asking designers for exact pixel measurements (padding, margins, hex codes) during handoff, despite having a comprehensive design system.\n\nWhat is the most effective systemic solution to bridge this gap?',
        'intermediate',
        'Notion',
        'Handoff and tooling integration',
        'C',
        'The breakdown in handoff usually occurs when design tools and code don''t speak the same language. Aligning Figma components and design tokens exactly 1:1 with the React components—and enforcing this nomenclature—eliminates the need for pixel measurements. Developers just copy the token/component names. Option C solves the root cause. Option A treats the symptom. Option B slows down the process. Option D is impractical.',
        ARRAY['integration', 'design_tokens', 'consistency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Require designers to create detailed "redline" specification documents for every single screen they hand off', false),
    (v_q_id, 'B', 'Mandate that PMs mediate every handoff meeting to ensure engineers understand the design intent', false),
    (v_q_id, 'C', 'Align the naming conventions of Figma tokens and components directly with the code library, creating a shared language', true),
    (v_q_id, 'D', 'Force all engineers to learn how to edit Figma files so they can inspect the properties themselves', false);

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
        'Airbnb''s One-Off Exceptions',
        E'The Airbnb Luxe team requests a unique, deeply customized carousel component that deviates heavily from the core design system to create a "premium" feel. The design system PM must decide how to handle this request.\n\nWhat is the best approach to handling this exception?',
        'intermediate',
        'Airbnb',
        'Governance and exceptions',
        'D',
        'Design systems cannot serve every edge case without becoming bloated. A "snowplow" or localized component approach allows product teams to build their specific needs locally using foundational tokens, without polluting the core library. If the component proves useful globally later, it can be promoted. Option D is the standard practice for exceptions. Option A causes bloat. Option B is overly restrictive. Option C fractures the system.',
        ARRAY['governance', 'scalability', 'component_library']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build the customized carousel into the core design system immediately so other teams can use it too', false),
    (v_q_id, 'B', 'Reject the request outright; a design system''s primary goal is strict visual uniformity without exception', false),
    (v_q_id, 'C', 'Allow the Luxe team to fork the entire design system repository and maintain their own separate version', false),
    (v_q_id, 'D', 'Permit the team to build a localized component using the system''s base tokens, but do not add it to the core library', true);

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
        'Spotify''s Multi-Brand Theming',
        E'Spotify recently acquired an audiobook platform and wants to integrate it into the main app. They want the audiobook section to feel distinct (different primary colors and typography) but still use the underlying Encore design system architecture.\n\nWhich technical architecture best supports this requirement?',
        'intermediate',
        'Spotify',
        'Theming and token architecture',
        'B',
        'A multi-tier token architecture typically involves global/primitive tokens (e.g., all possible colors), semantic/alias tokens (e.g., primary-brand-color), and component tokens. By swapping the semantic theme tokens at the root level of the audiobook section, the core components will automatically adopt the new brand styling. Option B is the industry standard for theming. Option A requires duplicating everything. Option C and D are manual, unscalable hacks.',
        ARRAY['design_tokens', 'scalability', 'consistency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Duplicate the entire Encore codebase into a new package called Encore-Audiobooks and change the hardcoded values', false),
    (v_q_id, 'B', 'Utilize a multi-tier token architecture, swapping the semantic "theme" tokens at the root level of the audiobook section', true),
    (v_q_id, 'C', 'Use inline styles on every component within the audiobook section to override the default Encore styling', false),
    (v_q_id, 'D', 'Create an "isAudiobook" boolean prop and add it to every single component in the design system', false);

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
        'Slack''s Built-In Accessibility',
        E'Slack''s design system PM is writing the requirements for a new Modal component. The PM wants to ensure that teams using the Modal cannot accidentally violate WCAG accessibility guidelines.\n\nWhich requirement ensures the highest level of built-in accessibility compliance?',
        'intermediate',
        'Slack',
        'Accessibility constraints via API',
        'C',
        'The best way to enforce accessibility in a design system is to make it structurally impossible to use a component without providing required accessibility context. Forcing developers to pass an `aria-label` or `title` prop (and throwing an error if missing) guarantees compliance at the API level. Option C enforces this. Option A relies on human behavior. Option B is visually restrictive but ignores screen readers. Option D is a post-deployment check, not a built-in constraint.',
        ARRAY['accessibility', 'component_library', 'governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Include a detailed section in the documentation explaining how to manually add ARIA attributes to the Modal', false),
    (v_q_id, 'B', 'Hardcode the Modal to only accept black text on a white background to guarantee a 21:1 contrast ratio', false),
    (v_q_id, 'C', 'Make the `aria-labelledby` or accessible title prop strictly required in the code API, throwing an error if omitted', true),
    (v_q_id, 'D', 'Run an automated Lighthouse audit on every pull request that uses the Modal component', false);

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
        'Shopify''s Adoption Metrics',
        E'The PM for Polaris at Shopify wants to prove that the design system is successfully increasing engineering velocity across the company.\n\nWhich set of metrics provides the strongest evidence of this success?',
        'intermediate',
        'Shopify',
        'Measuring design system ROI',
        'A',
        'Measuring design system success involves tracking adoption (system coverage) and the resulting impact on speed (time-to-market). High system coverage correlated with a reduction in UI-related bugs and faster PR merges indicates that the system is doing its job. Option A captures these critical ROI metrics. Option B measures useless vanity metrics. Option C measures the central team''s output, not the company''s velocity. Option D measures performance, not developer velocity.',
        ARRAY['adoption', 'maintenance', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Component adoption rate across repositories, decrease in UI-related bug tickets, and faster PR merge times', true),
    (v_q_id, 'B', 'Total number of components in the library, lines of code written by the design system team, and Figma views', false),
    (v_q_id, 'C', 'Number of new components requested by product teams and the response time of the design system support channel', false),
    (v_q_id, 'D', 'The reduction in total CSS file size and improvements in the application''s Core Web Vitals', false);

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
        'Uber''s Contribution Model',
        E'Uber utilizes a federated contribution model for its design system. A PM on the Uber Eats team wants to contribute a new "Restaurant Rating" component back to the central system.\n\nUnder a healthy federated model, what is the most critical requirement before this component is accepted?',
        'intermediate',
        'Uber',
        'Federated governance and contribution',
        'C',
        'In a federated model, product teams build and contribute components. However, for a component to be added to the central library, it must prove its generalizability—meaning it is useful across multiple contexts, not just a single product feature. Option C correctly identifies this standard. Option A is a centralized bottleneck. Option B violates accessibility. Option D is an arbitrary requirement.',
        ARRAY['contribution_model', 'governance', 'reusability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The central design system team must rewrite the component from scratch to ensure code quality', false),
    (v_q_id, 'B', 'The component must bypass standard accessibility checks to speed up the contribution pipeline', false),
    (v_q_id, 'C', 'The component must be generalized and proven to solve use cases across multiple different product areas', true),
    (v_q_id, 'D', 'The Uber Eats PM must permanently transfer two engineers to the core design system team', false);

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
        'Netflix''s Localization Expansion',
        E'Netflix is expanding its UI to support German, a language known for long compound words. The design system PM discovers that many fixed-width Buttons and Cards in the library are breaking or truncating text abruptly.\n\nHow should the component architecture be updated to fix this systemically?',
        'intermediate',
        'Netflix',
        'Internationalization and responsive components',
        'A',
        'Design systems must be resilient to content variations, especially localization. Relying on intrinsic sizing (letting the content dictate the size) and flexible constraints (min/max widths) ensures components adapt gracefully to longer languages like German. Option A is the correct systemic solution. Option B is a massive manual effort. Option C creates an unreadable UI. Option D breaks layout conventions.',
        ARRAY['consistency', 'integration', 'component_library']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Implement intrinsic sizing principles, using `min-width` and content-driven auto-layout instead of fixed dimensions', true),
    (v_q_id, 'B', 'Create a separate "German-Only" design system library with larger fixed dimensions for every component', false),
    (v_q_id, 'C', 'Force all typography tokens to dynamically shrink in size until the translated text fits within the fixed boundaries', false),
    (v_q_id, 'D', 'Mandate that all German translations must be abbreviated to match the character count of the English strings', false);

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
        'Discord''s Motion Tokens',
        E'Discord wants to standardize its animations (e.g., hover effects, modal pops) to create a cohesive brand feel. The PM suggests introducing "Motion Tokens."\n\nWhat two primary CSS properties are most effectively abstracted into design tokens for animation?',
        'intermediate',
        'Discord',
        'Motion and animation tokens',
        'D',
        'Motion tokens typically abstract two fundamental properties: Duration (how long the animation takes) and Easing (the acceleration curve, like ease-in-out). Standardizing these ensures that all animations feel like they belong to the same physical universe. Option D is correct. Options A, B, and C are layout and structural properties, not motion properties.',
        ARRAY['design_tokens', 'consistency', 'component_library']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Transform and Opacity', false),
    (v_q_id, 'B', 'Keyframes and Z-Index', false),
    (v_q_id, 'C', 'Display and Position', false),
    (v_q_id, 'D', 'Duration and Easing curves', true);

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
        'Atlassian''s Documentation Sync',
        E'Atlassian''s design system site features interactive code snippets for developers. A PM notices that when the engineering team updates a component''s API, the documentation site often remains outdated for weeks, causing confusion.\n\nWhich technical solution best prevents this drift?',
        'intermediate',
        'Atlassian',
        'Living documentation and Storybook',
        'B',
        'Living documentation is a core tenet of modern design systems. By auto-generating docs directly from the source code (using tools like Storybook or Docz based on PropTypes/TypeScript interfaces), the documentation is guaranteed to always match the code. Option B solves the root cause. Option A relies on manual process. Option C is technically flawed. Option D restricts development speed.',
        ARRAY['maintenance', 'integration', 'adoption']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Assign a dedicated technical writer to manually review every pull request and update the documentation site', false),
    (v_q_id, 'B', 'Implement a tool like Storybook to auto-generate documentation and props tables directly from the codebase', true),
    (v_q_id, 'C', 'Embed the documentation site inside Figma so designers can update the code snippets visually', false),
    (v_q_id, 'D', 'Freeze all component development until the documentation has been manually synced', false);

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
        'Figma''s Component Detachment',
        E'A PM analyzing Figma usage data notices a massive spike in designers "detaching" instances of the global Navigation Bar component. \n\nWhat does a high detachment rate most likely indicate about the design system?',
        'intermediate',
        'Figma',
        'Analytics and component flexibility',
        'A',
        'In Figma, "detaching" a component breaks its link to the master component, usually done because the designer needs to modify it in a way the master component doesn''t allow. A high detachment rate is a strong signal that the component is too rigid and lacks the variants/props needed for real-world use cases. Option A correctly diagnoses the problem. Option B implies designers are unskilled. Option C is the opposite of reality. Option D is a technical error, not a systemic issue.',
        ARRAY['adoption', 'component_library', 'reusability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Navigation Bar component is too rigid and lacks the necessary variants or properties to support actual product needs', true),
    (v_q_id, 'B', 'Designers are not properly trained on how to use Figma''s auto-layout feature', false),
    (v_q_id, 'C', 'The component is too flexible and has too many configuration options, confusing the designers', false),
    (v_q_id, 'D', 'The design system library failed to publish its latest updates to the cloud', false);

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
        'GitHub''s Redesign Rollout',
        E'GitHub is undergoing a massive visual refresh (new typography, borders, and shadows). The leadership wants this rolled out seamlessly without breaking the UI of any existing features.\n\nAssuming high design system adoption, what is the safest deployment strategy?',
        'intermediate',
        'GitHub',
        'Systemic updates and deployment',
        'C',
        'A mature design system allows for systemic updates by modifying the lowest level abstractions: the design tokens. Updating the semantic token values (e.g., border-radius, font-family) automatically cascades the new styling to all consuming components globally without requiring changes to product feature code. Option C is the power of a tokenized system. Option A is dangerous. Option B is incredibly slow. Option D requires rewriting the entire app.',
        ARRAY['design_tokens', 'scalability', 'maintenance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Deploy all changes directly to production on a Friday evening to minimize user disruption', false),
    (v_q_id, 'B', 'Require every product team to create a dedicated pull request updating the styles on their specific pages', false),
    (v_q_id, 'C', 'Update the semantic design tokens at the theme level, allowing the new styles to cascade automatically to all system components', true),
    (v_q_id, 'D', 'Build an entirely new application framework and slowly migrate users over the course of three years', false);

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
        'Stripe''s Legacy Migration',
        E'Stripe is rolling out "Sail," its new design system. However, the core Dashboard repository contains 5 years of legacy code using deprecated, custom-built CSS.\n\nWhat is the most pragmatic PM strategy to drive adoption of the new system in this legacy codebase?',
        'intermediate',
        'Stripe',
        'Adoption and technical debt',
        'B',
        'Migrating a massive legacy codebase all at once is risky and halts product development. The "Boy Scout Rule" (leave it better than you found it) combined with strict linting against adding *new* legacy code ensures gradual, pragmatic migration. Option B balances product momentum with technical debt reduction. Option A halts the business. Option C creates fragmentation. Option D is too passive.',
        ARRAY['adoption', 'maintenance', 'integration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Halt all new feature development across the company until the Dashboard is 100% migrated to the new system', false),
    (v_q_id, 'B', 'Enforce strict linting so no *new* legacy CSS can be written, and mandate that any file touched for a feature update must be migrated', true),
    (v_q_id, 'C', 'Leave the legacy code alone permanently and only use the new design system for completely new products', false),
    (v_q_id, 'D', 'Ask engineers to voluntarily update the codebase in their free time on weekends', false);

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
        'Tinder''s Micro-interactions',
        E'Tinder''s signature "Swipe Right" micro-interaction is currently hardcoded into the feed component. The PM wants to make this "swipeable card" interaction available to other teams building new features (e.g., Tinder Discover).\n\nHow should this interaction be abstracted into the design system?',
        'intermediate',
        'Tinder',
        'Abstracting behaviors and patterns',
        'C',
        'Design systems aren''t just for visual styling; they also encapsulate complex interaction patterns. By creating a reusable "Swipeable" wrapper component or behavioral hook, the interaction logic is separated from the specific content (the dating profile), allowing other teams to use the gesture. Option C correctly separates behavior from content. Option A duplicates code. Option B relies on external tools. Option D abstracts too far.',
        ARRAY['component_library', 'reusability', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Tell the Discover team to copy and paste the animation code from the feed repository into their new feature', false),
    (v_q_id, 'B', 'Publish a high-fidelity video of the interaction and tell engineers to replicate it as closely as possible', false),
    (v_q_id, 'C', 'Extract the physics and gesture logic into a reusable `SwipeableCard` wrapper component or React hook', true),
    (v_q_id, 'D', 'Create a new design token called `motion-swipe` and apply it to standard `div` elements', false);

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
        'DoorDash''s Strict Overrides',
        E'A DoorDash product engineer is frustrated because the design system''s `Button` component doesn''t allow them to override the `margin-top` property using custom CSS.\n\nWhy do mature design systems intentionally block external CSS overrides like margin on core components?',
        'intermediate',
        'DoorDash',
        'API strictness and encapsulation',
        'A',
        'Allowing arbitrary CSS overrides destroys the predictability and encapsulation of a component. If an engineer overrides margins, any future update to the core component could break the layout in unpredictable ways. Layout concerns (like spacing between components) should be handled by layout containers (e.g., Stack or Grid), not by mutating the component itself. Option A correctly explains this architectural boundary. Option B is a security concept. Option C is false. Option D is irrelevant.',
        ARRAY['governance', 'maintenance', 'component_library']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To preserve component encapsulation; spacing should be handled by parent layout components (e.g., a Stack), not by mutating the Button', true),
    (v_q_id, 'B', 'To prevent cross-site scripting (XSS) attacks that can be injected via custom CSS variables', false),
    (v_q_id, 'C', 'Because React cannot compile inline styles or CSS overrides efficiently, causing severe performance degradation', false),
    (v_q_id, 'D', 'It ensures that the DoorDash logo is always the most prominent element on the screen', false);

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
        'Salesforce''s Multi-tenant Theming Architecture',
        E'Salesforce allows enterprise customers to apply their own corporate branding (colors, fonts, corner radii) to the Salesforce UI. \n\nWhat is the most robust architectural approach for the Lightning Design System to support scalable, runtime multi-tenant theming?',
        'advanced',
        'Salesforce',
        'Runtime theming and CSS variables',
        'D',
        'For runtime theming where users can change UI colors dynamically without rebuilding the application, CSS Custom Properties (Variables) are required. They allow the browser to repaint the UI immediately when a root variable changes. Pre-processors like Sass compile to static CSS and cannot be changed at runtime. Option D represents modern multi-tenant theming architecture. Option A is static. Option B is an architectural nightmare. Option C requires a full app reload.',
        ARRAY['design_tokens', 'scalability', 'integration']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use Sass mixins to compile a separate, static CSS stylesheet for every single enterprise customer upon signup', false),
    (v_q_id, 'B', 'Inject inline styles into every single React component via an API call on every page load', false),
    (v_q_id, 'C', 'Store the themes in a central database and force a hard page refresh whenever a user navigates', false),
    (v_q_id, 'D', 'Utilize CSS Custom Properties (Variables) mapped to design tokens, updating their values dynamically at the root layer', true);

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
        'Notion''s Conflicting Team Needs',
        E'The Notion Core Experience team needs the global `Dropdown` component to support asynchronous data fetching for search. The Marketing Web team argues this adds unnecessary JavaScript bloat to their static landing pages.\n\nAs the Design System PM, how do you resolve this architectural conflict?',
        'advanced',
        'Notion',
        'Component architecture and dependency management',
        'B',
        'When a component has heavily divergent use cases (complex data fetching vs lightweight static display), forcing them into a single component bloats the API and hurts performance. The advanced solution is separating the stateless presentation logic (the UI) from the stateful behavioral logic (the fetching), allowing teams to compose what they need. Option B solves the conflict via separation of concerns. Option A ignores performance. Option C fractures the visual consistency. Option D is a non-solution.',
        ARRAY['component_library', 'scalability', 'reusability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force the Marketing team to accept the bloated component because consistency is more important than performance', false),
    (v_q_id, 'B', 'Abstract the UI into a stateless `DropdownBase` component, and create a separate `AsyncDropdown` wrapper for the data-fetching logic', true),
    (v_q_id, 'C', 'Tell the Marketing team to stop using the design system and build their own custom dropdown from scratch', false),
    (v_q_id, 'D', 'Use a feature flag to disable the Dropdown entirely for users on slow internet connections', false);

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
        'Airbnb''s System ROI',
        E'Airbnb''s CFO questions the budget for the dedicated 15-person Design System team, asking for hard financial ROI. \n\nWhich analysis provides the most accurate and quantifiable financial justification for the design system?',
        'advanced',
        'Airbnb',
        'Quantifying design system value',
        'C',
        'Quantifying design system ROI at the executive level requires translating engineering time saved into monetary value. By measuring component usage and calculating the hours saved by not rebuilding those components (factoring in engineering salaries), you provide hard financial data. Option C is the standard model for calculating DS ROI. Option A is a generic correlation. Option B measures server costs, not developer productivity. Option D is impossible to calculate reliably.',
        ARRAY['adoption', 'governance', 'maintenance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Compare the company''s stock price before and after the design system was launched', false),
    (v_q_id, 'B', 'Calculate the reduction in Amazon Web Services (AWS) hosting costs due to smaller CSS file sizes', false),
    (v_q_id, 'C', 'Calculate the total instances of components used, multiply by the estimated hours to build each from scratch, multiplied by the average engineering hourly rate', true),
    (v_q_id, 'D', 'Survey users and assign a dollar value to the increase in perceived aesthetic beauty of the application', false);

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
        'Spotify''s Headless Architecture',
        E'Spotify''s web platform uses React, but they are acquiring a company that uses Vue.js. The PM wants the acquired company to use the Encore design system without forcing them to rewrite their entire app in React.\n\nWhich advanced design system architecture best supports this?',
        'advanced',
        'Spotify',
        'Framework-agnostic design systems',
        'C',
        'When dealing with multiple JavaScript frameworks (React, Vue, Angular), a React-only component library fails. Web Components natively run in the browser regardless of framework. Alternatively, a "headless" UI architecture provides the logic and accessibility attributes independently, allowing teams to wire them up to their framework''s specific rendering layer. Option C represents a framework-agnostic approach. Option A forces a rewrite. Option B is an unmaintainable nightmare. Option D doesn''t solve the JavaScript framework incompatibility.',
        ARRAY['integration', 'scalability', 'component_library']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mandate that the acquired company immediately halts feature development and rewrites their frontend in React', false),
    (v_q_id, 'B', 'Maintain two completely separate design system codebases: one written in React and one written in Vue.js', false),
    (v_q_id, 'C', 'Adopt a headless UI architecture or standard Web Components, decoupling the logic and styling from specific framework implementations', true),
    (v_q_id, 'D', 'Export all components from Figma as static HTML and CSS files and distribute them via a zip file', false);

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
        'Slack''s Component API strictness',
        E'Slack is designing a complex `Card` component. \nApproach A uses strict props: `<Card title="Hello" icon="user" />`.\nApproach B uses slots/children: `<Card><Card.Title>Hello</Card.Title><Card.Icon type="user" /></Card>`.\n\nAs a system PM, why might you choose Approach B (Slots/Children) over Approach A?',
        'advanced',
        'Slack',
        'API design and inversion of control',
        'B',
        'In component API design, strict props (Approach A) are rigid; if a product team wants a tooltip inside the title, the DS team must add a `titleTooltip` prop, leading to prop bloat. Approach B (Slots/Children/Compound Components) uses "Inversion of Control," allowing product teams to pass arbitrary content (like a tooltip) into designated slots without modifying the core component. Option B correctly describes this advanced architectural pattern. Option A is false. Option C is backwards. Option D is irrelevant.',
        ARRAY['component_library', 'reusability', 'scalability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Because it enforces strict visual constraints and prevents product teams from adding custom elements', false),
    (v_q_id, 'B', 'It utilizes inversion of control, allowing product teams to compose custom layouts within the card without requiring new props to be added to the core API', true),
    (v_q_id, 'C', 'It allows the browser to parse the component strictly using shadow DOM protocols', false),
    (v_q_id, 'D', 'Because designers in Figma can only create components using the slot methodology', false);

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
        'Shopify''s Scale Deprecation',
        E'Shopify''s Polaris team needs to rename a core design token `color-primary` to `color-brand-primary`. This token is used in over 10,000 files across 50 repositories.\n\nWhat is the safest, least disruptive technical strategy for this deprecation at massive scale?',
        'advanced',
        'Shopify',
        'Deprecation at massive scale',
        'A',
        'At scale, you cannot simply change a token and expect 50 repositories to update simultaneously without breaking. The "alias" pattern is the safest route: you introduce the new name, alias the old name to point to the new value (preventing breakage), track the usage of the old name via linting/telemetry, and eventually remove the old name once usage drops to zero via automated refactoring (codemods). Option A is the enterprise standard. Option B breaks production. Option C is too slow. Option D creates bloat without solving the migration.',
        ARRAY['deprecation', 'scalability', 'maintenance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Introduce the new token, alias the old token to the new one, provide a codemod to auto-update repositories, and monitor usage via telemetry before deleting the old token', true),
    (v_q_id, 'B', 'Delete `color-primary` immediately, release a major version bump, and force all teams to resolve the resulting build errors in their next sprint', false),
    (v_q_id, 'C', 'Create a manual spreadsheet tracking all 10,000 instances and have the central team manually submit PRs to update them one by one', false),
    (v_q_id, 'D', 'Keep both tokens completely independent and tell new developers to just use the new one going forward', false);

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
        'Uber''s Multi-platform Tokens',
        E'Uber''s design system relies on a complex pipeline using a tool like Style Dictionary. A PM notices a bug: when a designer updates the "Spacing-Medium" token in Figma, the Web app updates correctly to 16px, but the iOS app updates to 16 points instead of the native iOS multiplier format.\n\nWhat phase of the token pipeline is failing?',
        'advanced',
        'Uber',
        'Design token build pipelines',
        'D',
        'In an advanced token pipeline, raw tokens (JSON/Figma) must pass through a translation layer (like Style Dictionary) that applies platform-specific transforms. Web needs `px` or `rem`, iOS needs `pt` or `CGFloat`, Android needs `dp`. If iOS is getting raw `px` or incorrect multipliers, the platform-specific transform logic in the build pipeline is failing. Option D accurately identifies the technical failure point. Option A blames the designer. Option B blames the native code rather than the pipeline. Option C is a layout concept.',
        ARRAY['design_tokens', 'integration', 'consistency']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The designer is exporting the token from Figma using the wrong file format (JSON instead of XML)', false),
    (v_q_id, 'B', 'The iOS engineers forgot to install the React Native bridge component', false),
    (v_q_id, 'C', 'The auto-layout engine in Figma is conflicting with Xcode''s constraint system', false),
    (v_q_id, 'D', 'The token translation/build layer is failing to apply the platform-specific format transforms before exporting to iOS', true);

    RAISE NOTICE 'Successfully inserted 35 questions for Design Systems';

END $$;
