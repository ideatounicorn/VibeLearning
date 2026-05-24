-- ============================================
-- ASSESSMENT: Product Vision
-- CATEGORY: Product Strategy
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
    WHERE slug = 'product-vision';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug product-vision not found. Run the seed data first.';
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
        'Spotify''s Vision-to-Roadmap Hierarchy',
        'A new Associate Product Manager at Spotify drafts a slide for the annual planning cycle: "Our vision is to build a new personalized recommendation widget called ''Daily Discovery'' by Q4 to increase session count." Why is this statement an ineffective product vision?',
        'foundational',
        'Spotify',
        'A music streaming service moving into broader audio categories.',
        'A',
        'A product vision defines the aspirational, long-term destination of the product (often a 3- to 10-year horizon). A widget or feature like ''Daily Discovery'' is a solution that belongs on a roadmap, not a vision. Correct option A identifies this solution-first trap. Option B is incorrect because session count is an engagement metric, not a financial indicator, but regardless, the primary issue is the vision vs. roadmap confusion. Option C is incorrect because duplication is an execution issue, not a vision definition issue. Option D is incorrect because technical specifications belong in PRDs, not product visions.',
        ARRAY['mission_vs_vision', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It describes a short-term execution plan and feature (roadmap/solution) rather than an aspirational, long-term future state (vision).', true),
    (v_q_id, 'B', 'It focuses on session count, which is a lagging financial indicator rather than an engagement-focused North Star metric.', false),
    (v_q_id, 'C', 'Spotify already has Discover Weekly, so ''Daily Discovery'' represents product duplication and poor portfolio management.', false),
    (v_q_id, 'D', 'It lacks clear technical specifications for how the recommendation algorithms will be implemented by engineering.', false);

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
        'Netflix''s Cloud Gaming Aspiration',
        'The PM for Netflix''s gaming initiative proposes the following vision statement: "To deploy cloud-streamed game rendering engines across AWS edge nodes so users can play interactive experiences without consoles." What is the primary strategic flaw in this statement?',
        'foundational',
        'Netflix',
        'A streaming platform expanding into interactive cloud gaming.',
        'B',
        'A great product vision should focus on the ultimate value created for the user or the customer outcome, not the technical solution. By specifying ''cloud-streamed game rendering engines across AWS edge nodes,'' the PM has written a technical solution rather than an aspirational customer-centric vision (e.g., ''To become the premier destination for shared interactive entertainment on any screen''). Option A is a secondary infrastructure debate. Option C is incorrect because long horizons are normal for visions. Option D is a target segment detail that can be addressed in product strategy rather than the high-level vision itself.',
        ARRAY['product_vision', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It focuses on AWS instead of building Netflix''s proprietary edge server infrastructure to avoid vendor lock-in.', false),
    (v_q_id, 'B', 'It is a solution masquerading as a vision, focusing on ''how'' (cloud-streamed rendering) rather than the customer value or ultimate outcome.', true),
    (v_q_id, 'C', 'It sets a 10-year technical horizon, which is too long for the volatile gaming market.', false),
    (v_q_id, 'D', 'It fails to specify whether the targeted games will be casual or hardcore, causing resource planning conflicts.', false);

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
        'Airbnb''s 10-Year Strategic Horizon',
        'Airbnb''s leadership is structuring their product plans into strategic horizons. They want to define a 10-year product vision. Which of the following statements best represents a 10-year vision rather than a 1-year or 3-year plan?',
        'foundational',
        'Airbnb',
        'A global marketplace for home-sharing and travel experiences.',
        'C',
        'A 10-year vision is highly aspirational and outlines the ultimate destiny of the company, spanning multiple industries and ecosystems (Option C). Options A, B, and D are tactical 1-year to 3-year roadmap goals or operational optimizations. They represent concrete execution steps toward a vision, rather than the vision itself. The correct answer (C) provides a broad, inspiring direction that can guide decades of strategic execution.',
        ARRAY['product_vision', 'long_term_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Redesign the host onboarding wizard to reduce host activation time from 14 days to 5 days globally.', false),
    (v_q_id, 'B', 'Expand Airbnb''s market share in the boutique hotel segment by 15% through targeted API integrations.', false),
    (v_q_id, 'C', 'Enable anyone to feel at home anywhere in the world by expanding into experiential travel, global transport, and localized living services.', true),
    (v_q_id, 'D', 'Implement an AI-powered dispute resolution system to handle 40% of tier-1 support tickets without human intervention.', false);

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
        'Slack''s Cross-Functional Alignment',
        'At Slack, a PM is leading a cross-functional alignment session. The engineering lead wants to optimize system latency, the design lead wants to introduce gesture-based navigation, and the marketing lead wants to promote enterprise compliance. How should the PM frame the product vision to align these competing priorities?',
        'foundational',
        'Slack',
        'An enterprise communication platform.',
        'D',
        'A product vision acts as a North Star that aligns different functions by showing how their specific efforts contribute to a singular, customer-centric goal. Option D achieves this by connecting technical quality (latency), user experience (gesture navigation), and business viability (compliance) under the umbrella of making work simpler and more productive. Options A, B, and C fail because they either fragment the vision, ignore cross-functional perspectives, or rely on tactical frameworks (RICE) to solve a strategic alignment problem.',
        ARRAY['north_star', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conduct a RICE prioritization session and pick the single department goal that scores the highest.', false),
    (v_q_id, 'B', 'Split the product vision into three separate parallel sub-visions, giving each team autonomous ownership.', false),
    (v_q_id, 'C', 'Prioritize the marketing lead''s goal, as enterprise compliance directly drives revenue.', false),
    (v_q_id, 'D', 'Center the vision on the core customer value—"making work life simpler, more pleasant, and more productive"—and show how latency, UX, and compliance serve this destination.', true);

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
        'Tesla''s Mission vs. Vision Translation',
        'A PM working on the Tesla Network (robotaxi fleet software) is distinguishing between the corporate mission and their specific product vision. The corporate mission is "to accelerate the world''s transition to sustainable energy." Which of the following represents a valid product vision for the Tesla Network that supports this mission?',
        'foundational',
        'Tesla',
        'An electric vehicle and clean energy company.',
        'B',
        'Option B describes a compelling product vision: it is aspirational, customer-focused, long-term, and directly supports the corporate mission by making electric vehicle transport more accessible. Option A is a short-term rollout plan (roadmap). Option C is a specific feature/algorithm (solution). Option D is an operational corporate goal, not a product vision for the Tesla Network.',
        ARRAY['mission_vs_vision', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Deploy 10,000 autonomous Model 3 robotaxis in San Francisco by Q4 2027 using FSD Beta version 15.', false),
    (v_q_id, 'B', 'Create an autonomous, on-demand ride-hailing network that makes electric vehicle travel cheaper and more accessible than private car ownership.', true),
    (v_q_id, 'C', 'Build a dynamic pricing algorithm that adjusts fares based on battery state-of-charge and grid demand.', false),
    (v_q_id, 'D', 'Transition Tesla''s manufacturing plants to use 100% renewable power sources by the end of next fiscal year.', false);

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
        'Stripe''s Vision-to-Theme Connection',
        'Stripe''s high-level vision is "to increase the GDP of the internet." The PM team needs to translate this abstract vision into three-year strategic themes to guide execution. Which of the following is a strategic theme that directly links this vision to team execution?',
        'foundational',
        'Stripe',
        'A financial infrastructure platform.',
        'A',
        'A strategic theme bridges the gap between an abstract vision ("increase internet GDP") and concrete product roadmaps. Option A directly supports the vision by breaking down "GDP expansion" into global merchant onboarding and payment localization. Option B is a technical optimization (which is a task, not a strategic product theme). Option C is an organizational restructure. Option D is a marketing spend allocation, not a product strategy theme.',
        ARRAY['strategic_theme', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Lowering barriers to global commerce by building localized payment methods and global entity creation tools.', true),
    (v_q_id, 'B', 'Migrating the backend database from sharded MySQL to Spanner to reduce query latency by 50ms.', false),
    (v_q_id, 'C', 'Restructuring the product management organization into a matrix structure to speed up feature delivery.', false),
    (v_q_id, 'D', 'Increasing the marketing budget for APAC regions by 35% to counter regional competitors.', false);

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
        'Zoom''s Vision Validation Method',
        'A PM at Zoom wants to validate a 3-year vision: "To evolve from video conferencing into an immersive, persistent virtual workspace where distributed teams co-create in real time." Before committing engineering resources, how should the PM test the validity of this vision with customers?',
        'foundational',
        'Zoom',
        'A video communications platform.',
        'A',
        'Vision validation requires testing the core value proposition and conceptual fit with users, which is best done qualitatively using prototype walk-throughs or workshops (Option A). Option B is a tactical tool validation for a specific feature, not the broad vision. Option C is a leading question that produces low-value confirmation bias. Option D measures current behavior, which doesn''t validate a future-looking immersive workspace vision.',
        ARRAY['vision_validation', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run qualitative workshops with remote-first teams using interactive concept mockups to evaluate if the vision solves their collaboration struggles.', true),
    (v_q_id, 'B', 'A/B test a new landing page with a "Buy Now" button that measures the click-through rate of existing users for a virtual whiteboard.', false),
    (v_q_id, 'C', 'Run a survey asking 5,000 corporate clients: "Would you like Zoom to have more features for team collaboration?"', false),
    (v_q_id, 'D', 'Analyze database logs to see how many users share screen links in chat channels.', false);

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
        'Duolingo''s Megatrend Adaptation',
        'Duolingo''s product leadership is assessing the impact of the generative AI and real-time translation megatrend on their 5-year vision. Which reaction represents the most strategic vision alignment?',
        'foundational',
        'Duolingo',
        'A mobile language-learning application.',
        'C',
        'Strategic thinking requires adapting product vision to megatrends (like AI) by integrating the technology to better solve the core customer need (achieving fluency, Option C). Option A is a protectionist strategy that rarely succeeds. Option B is an over-pivot that abandons the company''s core assets and mission. Option D is an ostrich strategy that risks disruption by competitors who leverage AI early.',
        ARRAY['long_term_planning', 'future_trends']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Maintain the gamified drill vision and actively petition app stores to restrict real-time translation apps.', false),
    (v_q_id, 'B', 'Pivot the company immediately away from language learning and toward building enterprise AI model training pipelines.', false),
    (v_q_id, 'C', 'Evolve the vision from "gamified grammar drill practice" to "personalized conversational fluency powered by AI tutors," turning a disruptive tech into a core value driver.', true),
    (v_q_id, 'D', 'Ignore the trend, assuming that gamified XP loops will always outperform AI conversational tools in user retention.', false);

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
        'Robinhood''s Executive Vision Pitch',
        'The PM for Robinhood''s retirement services is presenting a new 5-year product vision to the executive board. To earn funding, which approach is most effective for communicating how the vision aligns with corporate interests?',
        'foundational',
        'Robinhood',
        'A financial services platform offering commission-free trading.',
        'A',
        'To win executive and investor approval, a product vision must be connected to business value and financial sustainability. Option A directly connects the product vision (retirement accounts) to a critical business metric (stabilizing revenue and increasing LTV). Option B is too tactical for a vision pitch. Option C focuses purely on catch-up rather than strategic differentiation. Option D uses buzzwords instead of substance.',
        ARRAY['executive_evangelism', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Frame the vision around long-term customer lifetime value (LTV) expansion, showing how retirement accounts lock in capital and stabilize volatile transaction revenue.', true),
    (v_q_id, 'B', 'Present a detailed Gantt chart showing the exact weekly engineering sprints and API documentation for the next 18 months.', false),
    (v_q_id, 'C', 'Focus the presentation on a competitor feature comparison table showing that other brokerage apps already have retirement accounts.', false),
    (v_q_id, 'D', 'Explain that the vision was created using an AI copywriting tool to match industry standard buzzwords like "democratizing web3 wealth."', false);

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
        'Peloton''s Hardware-to-Software Pivot',
        'Peloton''s original vision was "to bring elite-tier studio fitness classes into the home via connected hardware." Post-pandemic, the team evaluates pivoting to allow Peloton app subscriptions without hardware. How should the PM evaluate this pivot''s alignment with the vision?',
        'foundational',
        'Peloton',
        'An interactive fitness platform known for connected bikes and treadmills.',
        'A',
        'A product pivot should be evaluated by checking if it serves the deeper corporate mission/vision ("democratizing fitness"), even if the execution vehicle (connected hardware) changes. Option A is correct because it separates the "what/how" (hardware) from the "why" (democratizing fitness). Option B is rigid and doesn''t adapt to market changes. Option C focuses on short-term stock prices rather than strategic alignment. Option D delays the decision on a purely technical factor.',
        ARRAY['pivot_evaluation', 'mission_vs_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Assess if the pivot still satisfies the core mission of "democratizing fitness," recognizing that hardware was just a strategic execution vehicle, not the ultimate vision.', true),
    (v_q_id, 'B', 'Reject the pivot because it dilutes the brand''s premium identity, which is anchored strictly on high-cost hardware ownership.', false),
    (v_q_id, 'C', 'Approve the pivot immediately because the current stock price has fallen and short-term quarterly software revenue must be maximized.', false),
    (v_q_id, 'D', 'Delay the decision until engineering completes a 6-month feasibility study on reducing the manufacturing costs of the stationary bike.', false);

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
        'Uber''s North Star Proxy Conflict',
        'Uber''s ride-sharing division has a vision of "reliable, seamless mobility for everyone, everywhere." The Driver PM team focuses on increasing "driver app open time," while the Rider PM team focuses on "rider app open time." How does this divergence in proxy metrics risk undermining the North Star vision?',
        'intermediate',
        'Uber',
        'A double-sided marketplace for rides and deliveries.',
        'A',
        'In a two-sided marketplace, optimizing localized engagement metrics like "app open time" can lead to poor user experiences (e.g., riders opening the app but finding no cars, or drivers waiting with no fares). The true North Star metric must align both sides of the marketplace, such as "Completed Trips." Option A correctly identifies that localized proxy metrics can diverge and fail to drive actual marketplace liquidity. Options B, C, and D are secondary operational concerns.',
        ARRAY['north_star', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It optimizes localized engagement metrics that do not guarantee completed, high-quality trips, which is the true driver of marketplace liquidity.', true),
    (v_q_id, 'B', 'It creates data pipeline duplication, as engineering must track two separate telemetry streams.', false),
    (v_q_id, 'C', 'It increases AWS hosting costs because tracking active app sessions is highly resource-intensive.', false),
    (v_q_id, 'D', 'It causes confusion for the customer support team, who cannot distinguish between drivers and riders in their ticketing queue.', false);

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
        'Notion''s Vision Coherence Validation',
        'Notion is exploring a new 5-year vision: "Becoming the operating system for business operations, where databases, docs, and workflows are completely integrated." To validate this vision during beta testing, which of the following customer behaviors is the strongest indicator of alignment?',
        'intermediate',
        'Notion',
        'A collaborative workspace platform.',
        'B',
        'To validate the vision of becoming a "business operating system," the PM needs to look for behaviors that demonstrate users are building custom workflows, databases, and connected tools (Option B). High DAU on basic notes (Option A) only validates the tool as a notepad, not a business operating system. Options C and D are shallow vanity or operational metrics that do not measure core vision alignment.',
        ARRAY['vision_validation', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A high daily active user (DAU) count on basic personal note-taking pages.', false),
    (v_q_id, 'B', 'High organic creation of custom databases with relational link structures by non-technical workspace administrators.', true),
    (v_q_id, 'C', 'A high click-through rate on an email newsletter announcing Notion''s new corporate color palette.', false),
    (v_q_id, 'D', 'The total number of users who sign up with a Google OAuth credential instead of a password.', false);

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
        'Shopify''s Strategic Layering',
        'A PM lead at Shopify is onboarding a junior PM. They use Shopify''s business elements to explain the strategic hierarchy. Match the following elements to their correct terms:
1. "To make commerce better for everyone"
2. "To become the single platform merchants use to start, run, and grow their retail business"
3. "Expand international merchants by building localized taxation and localized checkout APIs"
4. "Deliver the EU multi-currency checkout update in Q3"',
        'intermediate',
        'Shopify',
        'An e-commerce platform for merchants.',
        'A',
        'The strategic hierarchy flows from the abstract/eternal to the concrete/near-term: 1) Mission is the eternal purpose ("make commerce better for everyone"). 2) Vision is the aspirational destination ("become the single platform..."). 3) Strategy outlines the thematic choices to get there ("expand international..."). 4) Roadmap contains the execution steps and timelines ("Deliver EU checkout in Q3"). Option A is the correct matching sequence.',
        ARRAY['mission_vs_vision', 'strategic_theme']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '1: Mission, 2: Vision, 3: Strategy, 4: Roadmap', true),
    (v_q_id, 'B', '1: Vision, 2: Mission, 3: Roadmap, 4: Strategy', false),
    (v_q_id, 'C', '1: Strategy, 2: Roadmap, 3: Vision, 4: Mission', false),
    (v_q_id, 'D', '1: Mission, 2: Strategy, 3: Vision, 4: Roadmap', false);

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
        'Figma''s Browser-Native Bet',
        'In its early days, Figma''s vision was "to make design accessible to everyone in a collaborative, browser-native environment." At the time, desktop apps like Sketch and Adobe Photoshop dominated. What megatrend and strategic bet did Figma''s vision capitalize on?',
        'intermediate',
        'Figma',
        'A collaborative design tool.',
        'A',
        'Figma''s vision succeeded because it correctly anticipated that web browsers would become powerful enough (via WebGL/WebAssembly) to handle complex vector graphics, and that product design would shift from solo desktop work to multiplayer cloud-based collaboration (Option A). Option B is false as hardware power increased. Option C is incorrect; design work remained primarily desktop-based. Option D describes the opposite of the cloud migration trend.',
        ARRAY['long_term_planning', 'future_trends']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The advancement of browser capabilities (like WebGL/WebGL2/WebAssembly) and the shift toward real-time, multiplayer collaborative software.', true),
    (v_q_id, 'B', 'The rapid decline in hardware computing power, forcing users to rely on server-side rendering for design layouts.', false),
    (v_q_id, 'C', 'The rise of mobile-first design workflows, which made desktop design tools obsolete for modern product designers.', false),
    (v_q_id, 'D', 'The transition of enterprise companies from cloud hosting back to on-premise local server architectures.', false);

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
        'Airbnb''s COVID-19 Vision Alignment',
        'In March 2020, global travel collapsed due to COVID-19. Airbnb''s core business model faced an existential threat. The product leadership evaluated multiple pivot ideas. Which pivot aligned best with their core vision of "belonging anywhere" while adapting to the crisis?',
        'intermediate',
        'Airbnb',
        'A peer-to-peer lodging and experience marketplace.',
        'B',
        'Airbnb''s vision is centered on connection, local cultures, and belonging. Option B (Online Experiences and local road trips) adapted to travel restrictions while keeping hosts at the center and preserving the core value of cultural connection. Option A changes the business model to transactional real estate. Option C moves away from the community host model toward commercial hotels. Option D is a complete shift into logistics, which does not align with the core vision.',
        ARRAY['pivot_evaluation', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Pivoting the platform to long-term apartment leasing agreements, acting as a digital real estate broker.', false),
    (v_q_id, 'B', 'Launching "Online Experiences" to allow hosts to share localized culture virtually, and refocusing core stays on local road-trip travel.', true),
    (v_q_id, 'C', 'Partnering with hotel chains to list empty commercial rooms under a discounted Airbnb Business brand.', false),
    (v_q_id, 'D', 'Halting all travel listings and launching a logistics courier service using hosts as delivery drivers.', false);

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
        'Salesforce''s Integration Vision',
        'Over years of acquisitions (MuleSoft, Tableau, Slack), Salesforce risks building a disjointed "Frankenstein product" without a clear unified vision. A PM lead is tasked with creating a vision for the unified Customer 360 platform. Which approach avoids the vision anti-pattern of "feature-soup"?',
        'intermediate',
        'Salesforce',
        'An enterprise customer relationship management (CRM) platform.',
        'A',
        'A unified product vision for multiple products or acquisitions must focus on the customer outcome and unified value proposition (Option A). Listing individual integrations (Option B) is a technical solution and details features rather than a cohesive vision. Option C is a business goal, not a product vision. Option D fails to create any unified vision, perpetuating organizational silos.',
        ARRAY['product_vision', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Focus the vision on "providing a single, real-time shared view of customer data across all departments," rather than listing how the individual acquired apps will integrate.', true),
    (v_q_id, 'B', 'Define the vision as: "Combine Slack''s chat, Tableau''s charts, and MuleSoft''s integrations into a single sidebar dashboard."', false),
    (v_q_id, 'C', 'Focus the vision on achieving 15% year-over-year growth in cross-selling license bundles to enterprise buyers.', false),
    (v_q_id, 'D', 'Declare that each acquired application will maintain its own isolated roadmap, vision, and user interface.', false);

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
        'Canva''s Democratic Design Themes',
        'Canva''s vision is "to empower everyone in the world to design anything and publish anywhere." The PM for the Enterprise product line is writing the annual strategy. How should they tie their execution goals back to this vision?',
        'intermediate',
        'Canva',
        'An online graphic design platform.',
        'A',
        'To align with Canva''s vision of empowering everyone to design, the Enterprise PM should focus on tools that make collaboration and design easy for non-designers in corporate environments (Option A). Focus on high-end vector tools (Option B) targets professional designers, shifting away from the "empower everyone" core vision. Option C and Option D are tactical engineering and growth optimizations rather than vision-aligned strategic themes.',
        ARRAY['strategic_theme', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Formulate strategic themes around removing technical barriers for non-designers in large companies (e.g., brand kits, collaborative editing templates).', true),
    (v_q_id, 'B', 'Focus execution purely on high-end vector drawing tools to compete directly with Adobe Illustrator''s power-user demographic.', false),
    (v_q_id, 'C', 'Prioritize backend database migration to reduce latency for API integrations with external printing partners.', false),
    (v_q_id, 'D', 'Set a goal to run 200 A/B tests on button colors on the landing page to increase registration conversion rate.', false);

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
        'Spotify''s Audio Ecosystem Pivot',
        'In 2018, Spotify''s vision shifted from being a "music streaming service" to an "audio first platform." This justified major investments in podcasts and audiobooks. How should a PM evaluate if a new feature idea (e.g., interactive podcast Q&As) fits this updated vision?',
        'intermediate',
        'Spotify',
        'An audio streaming platform.',
        'A',
        'With an "audio-first" vision, features must be evaluated on how they drive consumption across the entire audio ecosystem (music, podcasts, talk) and support creators (Option A). Option B is a short-term financial evaluation. Option C is a technical constraint that shouldn''t dictate strategic alignment. Option D is a reactive competitor-focused approach rather than vision-driven innovation.',
        ARRAY['pivot_evaluation', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Evaluate if it increases total ear-share (listening time) and strengthens the creator-to-listener loop, aligned with the audio ecosystem vision.', true),
    (v_q_id, 'B', 'Calculate if the feature will yield a higher gross margin than music licensing rates in the first quarter of release.', false),
    (v_q_id, 'C', 'Test if the feature can be built using existing music playback APIs without modifying the app''s player interface.', false),
    (v_q_id, 'D', 'Assess if competitors like Apple Music have already launched an identical feature for their podcast application.', false);

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
        'Atlassian''s Jira Cloud Migration',
        'The PM team at Atlassian is pitching a major vision change for Jira: moving from on-premise servers to a cloud-first, collaboration-centric workspace. Executives are worried about short-term migration costs and churn from conservative enterprise clients. How should the PM address these concerns in their vision pitch?',
        'intermediate',
        'Atlassian',
        'A provider of collaboration and productivity software.',
        'B',
        'To evangelize a major strategic shift to executives, the PM must articulate the long-term value creation (LTV, high margins, continuous feature delivery) for both the customer and the business (Option B). Option A is highly reckless and would destroy customer trust. Option C is misleading as cloud database migrations are expensive and don''t yield immediate day-one savings. Option D is a false promise that engineering cannot guarantee.',
        ARRAY['executive_evangelism', 'long_term_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Suggest that Atlassian force-retires all server products with only a 30-day notice to accelerate migration velocity.', false),
    (v_q_id, 'B', 'Present the long-term compound value of rapid cloud-based feature updates, reduced customer IT maintenance costs, and high-margin expansion capabilities.', true),
    (v_q_id, 'C', 'Show a comparison of server costs versus cloud database hosting costs to prove immediate day-one infrastructure savings.', false),
    (v_q_id, 'D', 'Promise that all legacy server custom plugins will be fully operational in the cloud on day one without any client refactoring.', false);

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
        'Discord''s Mainstream Evolution',
        'In 2020, Discord transitioned its vision from "Chat for Gamers" to "Your Place to Talk," expanding to study groups, art communities, and friend circles. What was the primary strategic risk of this vision expansion, and how should the product team mitigate it?',
        'intermediate',
        'Discord',
        'A voice, video, and text communication service.',
        'A',
        'Expanding a product vision risks alienating the passionate core user base (gamers) that built the product''s initial momentum. Option A correctly identifies this risk and offers a balanced mitigation: keeping the underlying technology optimized for the core while widening the entry paths and positioning for broader audiences. Options B and C are based on false premises. Option D is incorrect because managing two apps increases product complexity and fragments the network effect.',
        ARRAY['pivot_evaluation', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Risk of alienating core gaming users; mitigated by preserving gamer-specific features (e.g., low-latency voice, game integration) while shifting marketing copy and onboarding templates.', true),
    (v_q_id, 'B', 'Risk of platform server collapse due to non-gamers using more bandwidth; mitigated by charging a subscription for high-quality video streaming.', false),
    (v_q_id, 'C', 'Risk of litigation from Slack and Microsoft Teams; mitigated by removing enterprise features like message threading and file management.', false),
    (v_q_id, 'D', 'Risk of brand dilution; mitigated by launching a secondary, completely separate mobile app for non-gaming users called Discord Light.', false);

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
        'Netflix''s Ad-Supported Tier Validation',
        'Netflix''s historical vision focused on an ad-free premium subscription model. To capture lower-income markets and combat subscriber slowdown, the PM team evaluates an ad-supported tier. How should they validate if this pivot aligns with their core value proposition without destroying brand equity?',
        'intermediate',
        'Netflix',
        'A subscription video-on-demand service.',
        'A',
        'To validate a pivot that changes a core vision principle (like "ad-free"), the PM must run controlled, localized pilots to gather real user behavior data (churn, ARPU, NPS) under the new model (Option A). Surveys (Option B) suffer from stated preference bias, where users say they dislike ads but might behave differently in practice. Option C relies on loud vocal minorities on social media. Option D is an analytical modeling exercise that doesn''t validate user acceptance.',
        ARRAY['vision_validation', 'pivot_evaluation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run localized, low-risk beta pilots in select international regions to measure the impact of ads on subscriber churn, overall satisfaction, and average revenue per user (ARPU).', true),
    (v_q_id, 'B', 'Survey existing premium users to ask if they would prefer to pay less to watch ads on the platform.', false),
    (v_q_id, 'C', 'Run a public PR announcement and measure social media sentiment on Twitter/X to gauge negative reactions.', false),
    (v_q_id, 'D', 'Run a simulator model using historical cable television data to estimate ad revenues.', false);

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
        'Robinhood''s Compliance Integration',
        'Robinhood''s vision is to "democratize finance for all." A PM team wants to launch a high-risk leverage-trading feature for novice investors. The compliance and risk teams argue this contradicts the vision by leading users to catastrophic financial losses. How should the PM resolve this conflict?',
        'intermediate',
        'Robinhood',
        'A financial services app.',
        'A',
        'A product vision of "democratizing finance" should not lead to product experiences that harm customers. By building education and risk guards (Option A), the PM aligns the feature with the spirit of the vision (giving access) while ensuring safety. Option B is an irresponsible interpretation of democratization that creates regulatory and user risk. Option C is overly conservative and halts product innovation. Option D ignores product responsibility and compliance.',
        ARRAY['vision_alignment', 'strategic_theme']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Redefine the roadmap to include mandatory financial literacy gates and risk-guardrails, aligning the "democratize" vision with responsible wealth building.', true),
    (v_q_id, 'B', 'Overrule the compliance team by citing the vision of "democratization," which implies giving users absolute freedom to make their own financial choices.', false),
    (v_q_id, 'C', 'Abandon the feature entirely and focus only on conservative index fund products to avoid all regulatory risks.', false),
    (v_q_id, 'D', 'Launch the feature in a beta program for all users and let the market determine if the financial risk is acceptable.', false);

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
        'Duolingo''s Metric Hierarchy',
        'Duolingo''s North Star vision is to make language learning globally accessible and effective. The executive North Star metric is Daily Active Users (DAU). The gamification team, the learning curriculum team, and the monetization team must align their work. How should they construct their metric trees?',
        'intermediate',
        'Duolingo',
        'A mobile language-learning application.',
        'A',
        'To align teams around a North Star metric (DAU), the product organization must cascade that metric into sub-metrics or proxy drivers that individual teams can directly influence (Option A). If everyone has the same high-level DAU goal (Option B), it lacks actionable focus for specialized teams. Option C is wrong because it fails to connect localized metrics back to the North Star. Option D allows one team to destroy the primary corporate North Star, showing a lack of alignment.',
        ARRAY['north_star', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Connect team-level metrics (e.g., lesson completion rate, subscription conversion, streak restoration) as mathematical drivers that feed directly into DAU retention.', true),
    (v_q_id, 'B', 'Have every single team adopt DAU as their primary OKR, ignoring sub-metrics to ensure complete alignment.', false),
    (v_q_id, 'C', 'Assign each team a different metric (Gamification gets XP, Curriculum gets accuracy, Monetization gets revenue) and ignore correlation with DAU.', false),
    (v_q_id, 'D', 'Allow the monetization team to prioritize ads and paywalls even if it leads to a 20% drop in DAU, as long as revenue targets are met.', false);

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
        'Stripe''s Horizon Resource Allocation',
        'Stripe uses a three-horizon framework for product planning. Horizon 1 is core payment processing. Horizon 2 is international expansion and Atlas (company creation). Horizon 3 is crypto/identity verification. A PM lead is allocating headcount. How should they distribute resources to ensure long-term vision alignment?',
        'intermediate',
        'Stripe',
        'A financial infrastructure provider.',
        'A',
        'To achieve a long-term vision, a company must balance core business execution with future bets. The industry-standard framework (pioneered by McKinsey) suggests a 70/20/10 split (Option A). This ensures the current cash cow (Horizon 1) is funded, growth vectors (Horizon 2) are scaling, and long-term disruptive research (Horizon 3) is explored. Option B starves the core business. Option C over-invests in unproven research. Option D halts growth into adjacent markets.',
        ARRAY['long_term_planning', 'strategic_theme']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Protect the core engine (Horizon 1) with the majority of resources (~70%), while allocating ~20% to Horizon 2 and ~10% to Horizon 3 to fund future growth bets.', true),
    (v_q_id, 'B', 'Shift 80% of resources to Horizon 3 because it represents the newest technology and fits the long-term vision.', false),
    (v_q_id, 'C', 'Allocate resources equally (33.3% each) across all horizons to ensure no product is favored.', false),
    (v_q_id, 'D', 'Focus 100% of resources on Horizon 1 until it achieves 100% global market share, then move to Horizon 2.', false);

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
        'Slack''s Generic Vision Trap',
        'A newly hired product director drafts a new vision statement: "To build a world-class, secure, enterprise-grade cloud communication platform that leverages cutting-edge technology to drive client satisfaction." Why is this statement considered a classic vision anti-pattern?',
        'intermediate',
        'Slack',
        'A channel-based messaging platform.',
        'A',
        'A product vision must be distinct and specific to the company''s unique value proposition. The drafted statement is filled with generic buzzwords ("world-class," "cloud communication," "cutting-edge," "client satisfaction") that could apply to Zoom, Teams, or Cisco (Option A). Option B is incorrect because technical details do not belong in a vision. Option C is a target audience focus, which is acceptable, but not the primary flaw. Option D is incorrect because security is a core pillar for all enterprise software and can be in a vision.',
        ARRAY['product_vision', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is generic and buzzword-heavy, making it applicable to almost any B2B SaaS company without offering unique strategic direction or inspiration.', true),
    (v_q_id, 'B', 'It does not mention the specific database technology that the platform runs on.', false),
    (v_q_id, 'C', 'It sets the standard at "enterprise-grade," which automatically excludes small-and-medium businesses (SMBs).', false),
    (v_q_id, 'D', 'It mentions "security," which should only be in the security team''s roadmap, not the product vision.', false);

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
        'Airbnb''s IPO Vision Narrative',
        'Preparing for its IPO, Airbnb needs to convince skeptical Wall Street investors of its long-term growth potential beyond home-sharing. Which narrative best communicates their vision to drive investor confidence?',
        'intermediate',
        'Airbnb',
        'A marketplace for lodging and tourism.',
        'A',
        'When evangelizing to investors, a PM/founder must frame the vision around a core defensible asset (community and connection) and show how it creates an addressable market expansion (travel and living) (Option A). Option B is too tactical and focused on cost-cutting rather than growth vision. Option C mischaracterizes Airbnb''s core value (which is community/supply, not deep tech algorithms). Option D makes unrealistic and risky regulatory acquisition promises.',
        ARRAY['executive_evangelism', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Position Airbnb as a "connection and community platform" that leverages a unique, supply-constrained global community to expand into all aspects of travel and living.', true),
    (v_q_id, 'B', 'Present a detailed financial spreadsheet showing projected quarterly cost-reductions in customer support.', false),
    (v_q_id, 'C', 'Highlight the patent portfolio of their search algorithm to show they are a pure deep-tech play.', false),
    (v_q_id, 'D', 'Promise investors that Airbnb will buy out its top five hotel competitors within two years of IPO.', false);

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
        'Notion''s Collaborative Wiki Pivot',
        'Notion started as a simple wiki tool. As it gained traction, the team saw users attempting to manage projects using tables. The leadership evaluated pivoting Notion into an all-in-one collaborative workspace. What key validation signal justified this pivot?',
        'intermediate',
        'Notion',
        'A collaborative workspace platform.',
        'A',
        'Product pivots are validated by identifying "user workarounds" or hacks where users try to force the current product to solve a broader problem (Option A). This indicates a strong latent need for a more integrated solution (workspace). Option B is a stated preference survey which does not show behavioral intent. Option C is a technical convenience, not customer validation. Option D is a market event, not direct customer validation.',
        ARRAY['pivot_evaluation', 'vision_validation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Finding that users were cobbling together multi-tool workflows (Trello + Google Docs) and hacking Notion''s basic tables to act as databases.', true),
    (v_q_id, 'B', 'A survey indicating that 90% of users wanted Notion to look more like Microsoft Word.', false),
    (v_q_id, 'C', 'The engineering team stating that database features are easier to build than rich-text editor components.', false),
    (v_q_id, 'D', 'A competitor, Coda, raising a large Series A funding round to target the same space.', false);

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
        'Figma''s Enterprise Strategy Themes',
        'Figma''s product vision is "to make design collaborative and accessible to all." To expand into the enterprise market, the PM team must define the strategic themes for the upcoming year. Which theme directly connects the collaborative vision to the enterprise growth objective?',
        'intermediate',
        'Figma',
        'A web-based design editor.',
        'A',
        'To link the vision ("collaborative and accessible to all") with the enterprise market, the product strategy should focus on bringing non-designer stakeholders (like developers and product managers) into the design process (Option A). This expands active enterprise seats and delivers collaborative value. Option B is a performance engineering task. Option C is a marketing initiative targeting students (non-enterprise). Option D is a monetization design task, not a collaborative product theme.',
        ARRAY['strategic_theme', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Enabling cross-functional design review and developer handoff workflows through view-only licenses and interactive inspection tools.', true),
    (v_q_id, 'B', 'Rebuilding the core graphics rendering engine in C++ to achieve 120 FPS on legacy MacBook hardware.', false),
    (v_q_id, 'C', 'Expanding the marketing campaign to target graphic design students in European universities.', false),
    (v_q_id, 'D', 'Redesigning the billing settings page to allow self-serve enterprise tier upgrades.', false);

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
        'Uber''s Autonomous Fleet Vision Conflict',
        'Uber''s long-term vision is "a frictionless, zero-emission, fully autonomous transit network." A major debate arises between the Autonomous Vehicle (AV) PM team and the Driver Operations PM team. The AV team wants to prioritize routing high-value trips to partner AV fleets to validate hardware performance. The Driver Ops team argues this will cause human drivers to churn due to receiving lower-paying routes. How should the Head of Product resolve this conflict using vision-led prioritization?',
        'advanced',
        'Uber',
        'A double-sided ride-hailing and logistics marketplace.',
        'A',
        'A great PM leader resolves vision conflicts by designing a transitional strategy that protects the current engine (marketplace liquidity driven by human drivers) while steadily proving out the future state (autonomous) (Option A). Completely prioritizing AVs (Option B) destroys marketplace capacity and causes immediate business failure. Prioritizing by quarterly GBV (Option C) is a short-term prioritization model that ignores long-term vision. Splitting the app (Option D) fragments network effects and harms rider experience.',
        ARRAY['vision_alignment', 'long_term_planning', 'pivot_evaluation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Define a transitional marketplace algorithm that optimizes for total network reliability, using human drivers to handle edge cases and routing AVs only where safe and highly utilized.', true),
    (v_q_id, 'B', 'Prioritize AVs 100% to accelerate the autonomous vision, accepting that human driver churn is an inevitable and acceptable cost of progress.', false),
    (v_q_id, 'C', 'Allow the team with the higher quarterly gross-booking volume (GBV) to dictate the routing algorithms for the shared network.', false),
    (v_q_id, 'D', 'Establish two completely separate, non-overlapping service categories: "Uber Human" and "Uber Autonomous," letting riders choose at checkout.', false);

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
        'Netflix''s Generative AI Threat Model',
        'Netflix''s product strategy team is analyzing a 10-year megatrend: the emergence of personalized, real-time generative video (AI-generated shows custom-tailored to a viewer''s mood). Which long-term strategic posture best aligns Netflix''s vision of "entertaining the world" with this disruptive future?',
        'advanced',
        'Netflix',
        'A subscription video streaming and production service.',
        'A',
        'To stay ahead of disruption, Netflix must expand its product vision to encompass generative video, turning a threat into a capability (Option A). Restricting AI (Option B) is a defensive strategy that will fail when competitors or open platforms offer AI content. Shifting to infrastructure (Option C) turns Netflix into an enterprise cloud provider, which is a complete departure from its core vision ("entertaining the world"). Ignoring the trend (Option D) is a classic incumbent mistake.',
        ARRAY['long_term_planning', 'future_trends', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Invest in proprietary generative video tools and interactive storytelling engines, shifting Netflix''s value prop from "curator of licensed/produced content" to "co-creator of personalized media."', true),
    (v_q_id, 'B', 'Legally restrict content creators from using AI in Netflix Original productions to preserve human-made artistic quality as a brand differentiator.', false),
    (v_q_id, 'C', 'Shift Netflix''s business model to become an infrastructure provider, renting out storage and compute servers to independent AI creators.', false),
    (v_q_id, 'D', 'Ignore the trend, based on the assumption that viewer preferences will always favor curated, high-budget Hollywood production value over custom AI media.', false);

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
        'Notion''s Retention Fallacy',
        'A PM at Notion is validating a new vision: "Evolving Notion into a fully automated, AI-powered knowledge manager that auto-organizes workspace content." They run a 30-day beta. The data shows:
- WAU on the AI features is high (75% adoption).
- Net Promoter Score (NPS) of the test group dropped by 10 points.
- Qualitative feedback shows users feel they have "lost control" of where their documents are.
What should the PM conclude about the vision validation?',
        'advanced',
        'Notion',
        'A wiki, database, and project management workspace.',
        'A',
        'High feature adoption can be a false positive driven by novelty effect or user curiosity. However, a drop in NPS and qualitative concerns about "losing control" show that the feature undermines Notion''s core value proposition (user-controlled structure) (Option A). The vision must be rejected or redesigned to restore user control. Option B ignores critical qualitative and sentiment data. Option C is a user-hostile approach. Option D is an over-pivot that abandons the problem space instead of iterating on the solution design.',
        ARRAY['vision_validation', 'pivot_evaluation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The vision is rejected in its current form because the core user value of Notion (structured, predictable organization) is violated, despite high feature usage driven by novelty.', true),
    (v_q_id, 'B', 'The vision is validated because the 75% WAU adoption rate is a hard metric that outperforms the subjective NPS decline.', false),
    (v_q_id, 'C', 'The PM should proceed to launch the feature globally, but add a series of onboarding pop-ups explaining to users why they are wrong.', false),
    (v_q_id, 'D', 'The vision should be pivoted to focus purely on a search engine, deleting the auto-organization algorithms entirely.', false);

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
        'Spotify''s Web3 Pivot Analysis',
        'During a hype cycle, Spotify''s strategy board is pressured by investors to pivot the core streaming architecture to a decentralized web3 protocol, using tokens for artist payouts and community ownership. The PM lead evaluates this against Spotify''s vision of "giving a million creative artists the opportunity to live off their art and billions of fans the opportunity to enjoy it." What is the most critical strategic reason to reject or heavily modify this pivot?',
        'advanced',
        'Spotify',
        'A streaming music platform.',
        'A',
        'A product vision must serve both sides of its ecosystem. Introducing web3 friction (wallets, seed phrases, transaction fees) directly violates the vision of "billions of fans enjoying music" (Option A). Furthermore, token volatility harms artists, violating the goal of enabling them to live off their art. Technical talent (Option B) can be hired. Competitor patents (Option C) are not the primary strategic reason. Label agreements (Option D) are negotiable, whereas UX friction and artist stability are core vision violations.',
        ARRAY['pivot_evaluation', 'product_vision', 'long_term_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The user experience friction of web3 wallets and transaction fees directly violates the "billions of fans enjoying music" vision, and token price volatility risks destabilizing artist livelihoods.', true),
    (v_q_id, 'B', 'Spotify does not have the database engineering talent to manage blockchain nodes, making the infrastructure impossible to scale.', false),
    (v_q_id, 'C', 'Competitors like Apple Music and Amazon Music have already secured patents on decentralized streaming, blocking Spotify''s market entry.', false),
    (v_q_id, 'D', 'The licensing agreements with major music labels explicitly prohibit the distribution of audio files over decentralized file systems.', false);

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
        'Figma''s Dev Mode Vision Alignment',
        'Figma''s PM for "Dev Mode" is trying to align the product around a North Star. The target user base consists of two distinct segments: Designers (who want pixel-perfect fidelity and creative freedom) and Developers (who want clean, production-ready code output and structural predictability). A conflict arises: developers want Figma to restrict design freedom to enforce code components. How should the PM resolve this in alignment with Figma''s vision of "bridging the gap between design and development"?',
        'advanced',
        'Figma',
        'A collaborative web-based design platform.',
        'A',
        'To bridge the gap between design and development, Figma must solve the friction without compromising the value proposition of either side. Option A does this by acting as a translator, which aligns with the collaborative, creative-first vision of the company. Option B solves the developer problem by ruining the designer experience. Option C fragments the workflow, violating the "collaboration" vision. Option D ignores the designer core, which is the entry point for Figma''s product adoption loop.',
        ARRAY['north_star', 'vision_alignment', 'product_vision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Position Figma not as a restrictor of design, but as a translator—creating features that map freeform design shapes to code tokens in real time, preserving designer freedom while exporting clean code.', true),
    (v_q_id, 'B', 'Restrict design tools to only allow pre-approved code components, forcing designers to adapt to engineering limitations to guarantee code fidelity.', false),
    (v_q_id, 'C', 'Split the application into two separate files: a design-only sandbox and a code-only staging environment, with manual sync required.', false),
    (v_q_id, 'D', 'Focus exclusively on the developer persona, since they represent a larger addressable market for enterprise seats than designers.', false);

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
        'Zoom''s Post-Pandemic Growth Churn',
        'Post-2021, Zoom''s stock price dropped as employees returned to offices. The board demands a new vision that convinces Wall Street of Zoom''s non-cyclical growth. The PM team presents a vision: "To power hybrid work collaboration by integrating hardware room-systems with software-defined virtual environments." A board member argues this requires too much capital expenditure. How should the PM evangelize this vision to win approval?',
        'advanced',
        'Zoom',
        'A communications technology company.',
        'A',
        'To evangelize a capital-intensive vision to a skeptical board, a PM must design a business strategy that mitigates financial risk (like high capex). Option A does this by proposing a partner-based hardware model, keeping Zoom''s business high-margin and software-driven. Option B is unrealistic as hardware has lower margins. Option C relies on an extreme assumption (physical offices disappearing completely) that is unconvincing. Option D is a highly risky bet on VR headsets, which have low adoption rates.',
        ARRAY['executive_evangelism', 'long_term_planning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Present a joint-go-to-market partnership model with existing hardware manufacturers (e.g., Logitech, Neat) to reduce capex while capturing high-margin recurring software license fees.', true),
    (v_q_id, 'B', 'Show financial projections demonstrating that hardware sales will overtake software subscriptions as the primary revenue driver by Year 3.', false),
    (v_q_id, 'C', 'Argue that hybrid work is a permanent societal shift and that physical offices will completely disappear by 2030, rendering the board''s concerns irrelevant.', false),
    (v_q_id, 'D', 'Redesign the vision to focus exclusively on virtual reality (VR) headsets, ignoring traditional office meeting rooms.', false);

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
        'Tesla''s FSD Economics Conflict',
        'Tesla''s vision is "affordable, mass-market autonomous electric vehicles." The Autopilot/FSD PM team faces a major execution conflict. To maximize FSD software revenue, finance wants to price FSD as a $15,000 upfront purchase. However, the Robotaxi Network team needs millions of vehicles on the road with FSD capability to launch a liquid, high-frequency autonomous ride-sharing network. How should the PM team reconcile these two execution tracks in alignment with the long-term vision?',
        'advanced',
        'Tesla',
        'An electric vehicle and autonomous driving software developer.',
        'A',
        'Option A aligns the near-term commercial needs (generating subscription revenue) with the long-term vision (mass-market fleet adoption for the Robotaxi network). This lowers the barrier to entry for retail customers, increasing the pool of FSD-enabled cars. Option B restricts the fleet size to wealthy buyers, slowing down the Robotaxi vision. Option C is financially unsustainable. Option D is a complete pivot away from the passenger EV consumer market, abandoning Tesla''s key asset.',
        ARRAY['strategic_theme', 'vision_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Transition FSD pricing from a high upfront fee to a low-cost, high-flexibility monthly subscription model, driving near-term software adoption while seeding the long-term Robotaxi fleet.', true),
    (v_q_id, 'B', 'Keep the price at $15,000 to maximize profit margins, and buy back used Tesla vehicles to build a corporate-owned robotaxi fleet.', false),
    (v_q_id, 'C', 'Make FSD free for all users immediately, absorbing the billions in software development costs as a marketing expense.', false),
    (v_q_id, 'D', 'Discontinue FSD development for retail customers and focus strictly on building a dedicated shuttle bus vehicle for city municipalities.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Product Vision';

END $$;
