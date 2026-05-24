-- ============================================
-- ASSESSMENT: User Personas
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
    WHERE slug = 'user-personas';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug user-personas not found. Run the seed data first.';
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
        'Spotify''s Behavioral Segmentation',
        'Spotify''s PM is defining a new user persona for a "Discovery" feature. Marketing suggests targeting "Millennials earning $50k-$100k." The PM argues they should target "Commuters who listen to 3+ hours of varied genres weekly." Why is the PM''s approach better for product development?',
        'foundational',
        'Spotify',
        'Music streaming service',
        'B',
        'The correct answer is B. Behavioral personas focus on what users do and their goals, which directly informs feature design like a discovery algorithm. Demographic data (Option A) is useful for marketing but rarely explains why a user needs a product feature. Option C is wrong because demographics are often easier to measure. Option D is incorrect because both types of data can be statistically significant.',
        ARRAY['behavioral_personas', 'demographics', 'user_goals']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Demographic personas are only used by the finance team for forecasting.', false),
    (v_q_id, 'B', 'Behavioral traits map directly to user needs and feature usage, driving better product decisions.', true),
    (v_q_id, 'C', 'Demographic data is much harder to collect accurately than behavioral data.', false),
    (v_q_id, 'D', 'Behavioral data is statistically significant, whereas demographic data is usually anecdotal.', false);

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
        'Uber''s Anti-Persona',
        'Uber''s PM is defining personas for a new high-end service, Uber Black. The team identifies "Budget-conscious college students taking late-night trips" as a specific user group. How should the PM categorize this group?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'C',
        'The correct answer is C. An anti-persona defines who the product is explicitly NOT built for, helping the team avoid scope creep and maintain strategic focus on their actual target. Option A and B are wrong because building for budget-conscious users would undermine a premium product. Option D incorrectly applies B2B concepts to a B2C scenario.',
        ARRAY['anti_personas', 'product_focus', 'segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As a secondary persona to capture edge-case revenue.', false),
    (v_q_id, 'B', 'As a primary persona, since they represent the largest volume of riders.', false),
    (v_q_id, 'C', 'As an anti-persona, clearly defining who the product is NOT for, to maintain focus.', true),
    (v_q_id, 'D', 'As a buyer persona, while business executives are the user persona.', false);

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
        'Slack''s Buyer vs User Persona',
        'Slack''s PM is building a new Enterprise Key Management (EKM) feature. When designing the feature, the PM focuses entirely on the "Everyday IC Worker" persona. Why is this a critical mistake for this specific feature?',
        'foundational',
        'Slack',
        'Enterprise communication platform',
        'B',
        'The correct answer is B. Enterprise features like EKM are primarily evaluated by the "IT/Security Buyer" persona, whose needs (compliance, security, audits) differ drastically from the end-user (fast communication). Designing enterprise governance features for an IC worker completely misses the actual customer evaluating the feature. Buyer personas are critical in B2B SaaS, contradicting Option C.',
        ARRAY['buyer_vs_user', 'b2b_personas', 'enterprise']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The IC worker is an anti-persona for all Slack enterprise features.', false),
    (v_q_id, 'B', 'EKM is primarily evaluated by the IT/Security Buyer persona, whose needs differ drastically from the end-user.', true),
    (v_q_id, 'C', 'Buyer personas are only relevant for marketing, while PMs should only focus on users.', false),
    (v_q_id, 'D', 'EKM requires a Manager persona rather than an IC.', false);

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
        'Airbnb''s Dual-Sided Market Personas',
        'Airbnb''s PM is reviewing personas for a new "Instant Book" feature. The "Last-Minute Traveler" persona loves it for speed, but the "Cautious Host" persona hates it due to lack of vetting. How should the PM resolve this persona conflict?',
        'foundational',
        'Airbnb',
        'Accommodation marketplace',
        'A',
        'The correct answer is A. In dual-sided marketplaces, PMs must balance the needs of both supply and demand personas. Acknowledging structural tension and building guardrails (like ID verification for Instant Book) satisfies the Host without blocking the Guest. Option B is a common trap; ignoring supply can destroy marketplace liquidity. Option D leads to a diluted, useless persona.',
        ARRAY['dual_sided_marketplace', 'persona_conflict', 'product_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Acknowledge the structural tension and build guardrails that satisfy the Host without blocking the Guest.', true),
    (v_q_id, 'B', 'Always prioritize the demand side (Guest) because they bring money into the platform.', false),
    (v_q_id, 'C', 'Discard the "Cautious Host" persona since they act as a blocker to product growth.', false),
    (v_q_id, 'D', 'Create a single "Platform User" persona that averages out the needs of both sides.', false);

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
        'Duolingo''s Jobs-to-be-Done vs Personas',
        'Duolingo''s PM wants to improve the "Streak Repair" feature. The team has a "Busy Professional" persona and a "Student" persona. However, both use Streak Repair identically. What framework should the PM use instead to better understand this behavior?',
        'foundational',
        'Duolingo',
        'Language learning app',
        'D',
        'The correct answer is D. When different demographic or behavioral personas exhibit the exact same motivation for a specific feature, the Jobs-to-be-Done (JTBD) framework is more useful. It focuses on the functional/emotional "job" (protecting progress) rather than the user''s identity. Option A and B are irrelevant segmentation methods here. Option C just creates unnecessary persona bloat.',
        ARRAY['jobs_to_be_done', 'persona_limitations', 'motivations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Anti-personas, by excluding people who do not care about streaks.', false),
    (v_q_id, 'B', 'Psychographic segmentation to separate the extroverted users from introverted users.', false),
    (v_q_id, 'C', 'A brand new "Streak Saver" persona to replace the existing ones.', false),
    (v_q_id, 'D', 'Jobs-to-be-Done (JTBD), focusing on the shared goal of protecting progress regardless of identity.', true);

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
        'Notion''s Proto-Persona Validation',
        'A new PM at Notion drafts a "Freelance Writer" proto-persona based entirely on their own assumptions and a brainstorming workshop with internal stakeholders. What is the immediate next step the PM must take?',
        'foundational',
        'Notion',
        'Productivity workspace',
        'C',
        'The correct answer is C. Proto-personas are assumptions based on internal knowledge. They are useful starting points but MUST be validated against actual qualitative and quantitative data before driving product decisions. Option A skips validation and risks building the wrong thing. Option B is overly rigid; proto-personas are valid tools if verified. Option D prematurely scales an unverified concept.',
        ARRAY['proto_personas', 'persona_validation', 'user_research']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Start building features tailored to this persona immediately to test market fit.', false),
    (v_q_id, 'B', 'Discard it, as personas must never be created without at least 6 months of prior research.', false),
    (v_q_id, 'C', 'Validate the proto-persona against real qualitative user research and quantitative behavioral data.', true),
    (v_q_id, 'D', 'Send the proto-persona to the marketing team to launch targeted ad campaigns.', false);

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
        'Peloton''s Qualitative vs Quantitative Inputs',
        E'Peloton''s PM is analyzing drop-off data to update the "Time-Strapped Parent" persona.\n\n| Minute | Drop-off % |\n|--------|------------|\n| 5      | 2%         |\n| 10     | 5%         |\n| 15     | 40%        |\n| 20     | 3%         |\n\nThe PM sees 40% of users drop off at 15 minutes. What is missing if they only use this quantitative data to update the persona?',
        'foundational',
        'Peloton',
        'Connected fitness platform',
        'B',
        'The correct answer is B. Quantitative data tells you *what* is happening (a 40% drop-off at 15 mins), but qualitative data is required to understand *why* it''s happening (e.g., a baby woke up vs. the workout became too intense). Good personas require both. Option A doesn''t explain the behavior. Option C is a monetization metric, not a behavioral insight.',
        ARRAY['qualitative_data', 'quantitative_data', 'persona_building']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Demographic data to ensure the 40% are actually parents.', false),
    (v_q_id, 'B', 'Qualitative data to explain why they drop off (e.g., kids waking up vs. workout being too hard).', true),
    (v_q_id, 'C', 'Financial data to see if these users are paying full price.', false),
    (v_q_id, 'D', 'Competitive analysis to see if Apple Fitness users also drop off.', false);

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
        'Figma''s Primary vs Secondary Personas',
        'Figma''s PM is prioritizing features for a release. Feature X is highly requested by the "UX Designer" (Primary Persona) but ignored by the "Product Manager" (Secondary Persona). Feature Y is loved by the PM persona but disliked by the Designer persona. What should the PM do?',
        'foundational',
        'Figma',
        'Collaborative design tool',
        'B',
        'The correct answer is B. The golden rule of primary personas is that satisfying them is the core objective. Secondary personas can be accommodated, but NEVER at the expense of the primary persona''s experience. Option A alienates the core user. Option C results in a mediocre product for everyone. Option D arbitrary shifts product strategy without evidence.',
        ARRAY['primary_persona', 'secondary_persona', 'prioritization']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Prioritize Feature Y to expand the total addressable market to PMs.', false),
    (v_q_id, 'B', 'Prioritize Feature X, as secondary personas should not compromise the primary persona''s experience.', true),
    (v_q_id, 'C', 'Build a compromised version of both features to partially satisfy both personas.', false),
    (v_q_id, 'D', 'Demote the UX Designer to a secondary persona to balance the product roadmap.', false);

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
        'Tinder''s Aspirational vs Actual Behavior',
        'During interviews, Tinder users claim they want a "Long-Term Relationship Seeker" persona. However, app data shows these same users heavily index on superficial swiping and short conversations. How should the PM incorporate this into the persona?',
        'foundational',
        'Tinder',
        'Dating app',
        'C',
        'The correct answer is C. Users often report aspirational behaviors in interviews (what they wish they did) while data reveals actual behavior. A great PM documents this tension within the persona to design features that either bridge the gap or acknowledge the reality without judgment. Ignoring data (Option A) or user sentiment (Option B) creates an incomplete picture.',
        ARRAY['aspirational_behavior', 'behavioral_personas', 'user_interviews']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Ignore the behavioral data; personas should reflect what users say they want.', false),
    (v_q_id, 'B', 'Discard the interview data entirely, as users frequently lie during research.', false),
    (v_q_id, 'C', 'Document both the aspirational goal and the actual behavior to design features that bridge the gap.', true),
    (v_q_id, 'D', 'Create an anti-persona for users who display contradictory behaviors.', false);

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
        'Shopify''s B2B Merchant Personas',
        'Shopify''s PM is creating a persona for their new "Shopify Plus" enterprise tier. The PM uses the existing "Mom & Pop Shop Owner" persona and just adds "has more revenue" to it. Why is this a flawed approach?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'C',
        'The correct answer is C. In B2B and enterprise software, scaling up isn''t just about more volume; it fundamentally changes the nature of the user. Enterprise personas involve buying committees, legal compliance, and complex operational workflows, making a scaled-up SMB persona wildly inaccurate. Option B is wrong because SMBs still exist. Option D is a false stereotype.',
        ARRAY['b2b_personas', 'enterprise', 'persona_evolution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mom & Pop shops cannot physically generate enough revenue to qualify for enterprise tiers.', false),
    (v_q_id, 'B', 'The existing persona should be deleted and replaced entirely by the enterprise persona.', false),
    (v_q_id, 'C', 'Enterprise customers involve complex buying committees and different operational needs, not just higher revenue.', true),
    (v_q_id, 'D', 'Enterprise users do not care about product features, only about pricing discounts.', false);

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
        'Discord''s Shadow Persona Discovery',
        'Discord was originally built for the "Hardcore PC Gamer" persona. Data shows a massive, sustained spike in users creating servers for study groups and crypto trading. How should the PM handle this unintended audience (shadow persona)?',
        'intermediate',
        'Discord',
        'Voice and text communication platform',
        'D',
        'The correct answer is D. Shadow personas are unintended user groups that adopt a product. A PM shouldn''t blindly pivot to them or forcefully block them. Instead, they should research the shadow persona to understand their needs and make a strategic decision on whether to formally support them. Option B is a reckless pivot. Option A and C artificially stifle organic growth.',
        ARRAY['shadow_personas', 'product_strategy', 'organic_growth']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately ban these users, as they violate the core "Gamer" persona focus.', false),
    (v_q_id, 'B', 'Redesign the entire app to pivot towards study groups and crypto traders.', false),
    (v_q_id, 'C', 'Force these users to adopt the "Gamer" persona by hiding non-gaming server categories.', false),
    (v_q_id, 'D', 'Research this shadow persona to understand their needs and decide strategically whether to support them.', true);

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
        'Stripe''s Technical Developer Personas',
        'Stripe''s PM is building a persona for the "Backend Developer" who integrates their payment API. Which of the following details is MOST critical to include in this specific persona, unlike a typical B2C consumer persona?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'B',
        'The correct answer is B. For deeply technical products, a developer persona must capture their tech stack, preferred SDKs, documentation reading habits, and debugging workflows. These are the "behaviors" that matter for API design. Demographic details (Option A), visual preferences (Option C), and personal habits (Option D) are largely irrelevant for an API integration experience.',
        ARRAY['technical_personas', 'developer_experience', 'b2b_personas']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Their age, marital status, and household income.', false),
    (v_q_id, 'B', 'Their preferred tech stack, API documentation standards, and debugging workflow.', true),
    (v_q_id, 'C', 'Their visual design preferences and color accessibility needs.', false),
    (v_q_id, 'D', 'Their daily commute time and podcast listening habits.', false);

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
        'Canva''s Average User Fallacy',
        E'Canva''s PM looks at user segmentation data based on feature usage:\n\n| Segment | % of Base | Needs |\n|---------|-----------|-------|\n| Novice  | 50%       | Auto-templates, 1-click export |\n| Pro     | 50%       | CMYK prepress, SVG vectors, layers |\n\nThe PM creates an "Average Marketer" persona that wants "medium-complexity tools." Why will this fail?',
        'intermediate',
        'Canva',
        'Graphic design platform',
        'C',
        'The correct answer is C. This is the classic "average user fallacy" or the "flaw of averages." When you have a bimodal distribution of user needs, building for the middle creates a product that is too complex for novices and too basic for pros, ultimately pleasing no one. The PM must maintain distinct personas and design interfaces (like progressive disclosure) that cater to both properly.',
        ARRAY['average_user_fallacy', 'persona_segmentation', 'bimodal_distribution']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The PM should have created an anti-persona for the professional designers instead.', false),
    (v_q_id, 'B', 'It will succeed because capturing the middle 50% is the safest product strategy.', false),
    (v_q_id, 'C', 'The average user does not exist; building for the middle alienates both the pros and the novices.', true),
    (v_q_id, 'D', 'The PM failed to consider the demographic split between the two groups.', false);

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
        'Instagram''s Persona Divergence',
        'Instagram originally had a "Photo Sharer" persona. With Reels, Stories, and Shopping, the platform has evolved. A junior PM wants to maintain just the "Photo Sharer" as the sole primary persona to keep the product simple. What is the risk?',
        'intermediate',
        'Instagram',
        'Social media platform',
        'B',
        'The correct answer is B. As a product matures and its feature set expands to serve new use cases (e.g., video consumption, e-commerce), the original persona often diverges. Failing to update personas means the product team will make decisions based on an outdated mental model, leading to features that don''t support actual engagement drivers.',
        ARRAY['persona_evolution', 'product_maturity', 'user_behavior']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The photo sharer persona will automatically become an anti-persona.', false),
    (v_q_id, 'B', 'The product will fail to serve actual drivers of current engagement, leading to a disconnected strategy.', true),
    (v_q_id, 'C', 'There is no risk; maintaining a single, simple persona is the golden rule of UX.', false),
    (v_q_id, 'D', 'The database will run out of storage if too many personas are created.', false);

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
        'Reddit''s Edge Case Personas',
        'Reddit''s PM is designing a new commenting interface. They create an "Accessibility Edge Case" persona representing users with severe visual impairments using screen readers. How should this persona be utilized?',
        'intermediate',
        'Reddit',
        'Community discussion platform',
        'C',
        'The correct answer is C. Edge case or accessibility personas act as lenses or constraints. Designing for them (e.g., clear semantic HTML, keyboard navigation, high contrast) almost universally improves the core product experience for all users (the "curb-cut effect"). Option A is an overcorrection. Option D treats accessibility as a purely legal burden rather than a product quality driver.',
        ARRAY['accessibility', 'edge_cases', 'inclusive_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As the primary persona, meaning all complex visual UI elements should be removed.', false),
    (v_q_id, 'B', 'As an anti-persona, since Reddit is primarily a text and image-based visual platform.', false),
    (v_q_id, 'C', 'As a lens to ensure core features meet standards, benefiting all users via the curb-cut effect.', true),
    (v_q_id, 'D', 'It should be ignored unless mandated by the legal compliance teams.', false);

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
        'Spotify''s Data Synthesis',
        E'Spotify''s PM synthesizes data for the "Podcast Enthusiast" persona.\n\n| Data Source | Finding |\n|-------------|---------|\n| Quantitative| Peak listening: 8 AM - 9 AM |\n| Qualitative | "I feel overwhelmed picking a show." |\n\nWhich feature idea best synthesizes BOTH insights for this persona?',
        'intermediate',
        'Spotify',
        'Music streaming service',
        'B',
        'The correct answer is B. A PM must synthesize multiple data points. The quantitative data indicates a morning commute use-case. The qualitative data indicates choice paralysis. A curated "Daily Drive" mix solves both by removing the friction of choice right when they need it most. Option C exacerbates the choice overload. Option D abandons the persona entirely.',
        ARRAY['data_synthesis', 'qual_and_quant', 'feature_ideation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A feature that allows them to download 10,000 podcasts at once for offline commuting.', false),
    (v_q_id, 'B', 'A curated "Daily Drive" playlist that automatically mixes short news podcasts with music.', true),
    (v_q_id, 'C', 'A complex search filter to let them manually sort through 5 million podcasts during their commute.', false),
    (v_q_id, 'D', 'Removing podcasts entirely and focusing back on music to reduce choice overload.', false);

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
        'Uber''s Evolving Personas in Crisis',
        'During the pandemic, Uber''s core "Daily Commuter" persona stopped using the app entirely. The PM quickly pivots focus to the "Essential Worker" and "Eats Delivery Customer" personas. What core product principle does this demonstrate?',
        'intermediate',
        'Uber',
        'Ride-hailing and delivery platform',
        'A',
        'The correct answer is A. Personas are not static monuments; they are living documents that reflect reality. When macro-environmental factors drastically shift user behavior, PMs must rapidly evolve or deprioritize historical personas to adapt the product strategy. Option B is overly rigid. Option C is wrong because commuters could (and did) return post-pandemic.',
        ARRAY['persona_evolution', 'market_shifts', 'adaptability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Personas are living documents that must evolve rapidly when macro-environmental factors shift.', true),
    (v_q_id, 'B', 'Personas should only be updated once every 5 years to ensure statistical validity.', false),
    (v_q_id, 'C', 'The "Daily Commuter" should have been permanently deleted as an anti-persona.', false),
    (v_q_id, 'D', 'Personas are irrelevant during a crisis, and PMs should only look at raw data.', false);

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
        'Airbnb''s Cultural Persona Differences',
        'Airbnb''s "Vacationing Family" persona was developed in the US. When expanding to Japan, the PM notices the core product loop is failing. What is the most likely persona-related issue?',
        'intermediate',
        'Airbnb',
        'Accommodation marketplace',
        'D',
        'The correct answer is D. Behaviors, trust models, and spatial requirements vary wildly across cultures. A US family persona assumes large spaces and certain privacy norms that do not map to the reality of Japanese housing or cultural trust systems. Assuming a persona is globally universal without local research is a classic PM failure.',
        ARRAY['globalization', 'cultural_context', 'user_research']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Japanese users only travel for business, so the vacation persona is an anti-persona there.', false),
    (v_q_id, 'B', 'The PM failed to translate the persona document into Japanese for the engineering team.', false),
    (v_q_id, 'C', 'Personas only work in Western markets due to differing software engineering standards.', false),
    (v_q_id, 'D', 'The PM assumed the US persona''s behaviors and trust models translated globally without localization.', true);

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
        'Notion''s Persona Dilution',
        'A Notion PM lists 15 different primary personas ranging from "College Student" to "Enterprise IT Admin" to "Recipe Collector." Every new feature must attempt to satisfy all 15. What is the inevitable product outcome?',
        'intermediate',
        'Notion',
        'Productivity workspace',
        'B',
        'The correct answer is B. If everyone is a primary persona, no one is. Attempting to design for 15 vastly different use cases simultaneously leads to "persona dilution" and a bloated, confusing product that lacks a cohesive value proposition. PMs must ruthlessly prioritize 1-2 primary personas for a given feature or product area.',
        ARRAY['persona_dilution', 'prioritization', 'product_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A perfectly balanced product that dominates every market segment simultaneously.', false),
    (v_q_id, 'B', 'A bloated, confusing product that lacks a clear value proposition for anyone.', true),
    (v_q_id, 'C', 'A highly optimized enterprise tool, because the IT Admin persona will naturally dominate.', false),
    (v_q_id, 'D', 'Immediate acquisition by a competitor due to high market penetration.', false);

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
        'Slack''s Decision Maker vs Influencer',
        'In Slack''s B2B model, the "IT Admin" holds the budget, but the "Engineering Manager" champions the tool. How should the PM design the onboarding flow using these personas?',
        'intermediate',
        'Slack',
        'Enterprise communication platform',
        'B',
        'The correct answer is B. Product-Led Growth (PLG) in B2B requires catering to the Champion/User for adoption while building administrative rails for the Buyer. You optimize the core "Aha!" moment for the user driving bottom-up adoption, while ensuring the IT Admin has the security tools needed to approve the purchase. Option A ignores the end-user, killing adoption.',
        ARRAY['b2b_personas', 'product_led_growth', 'buying_committee']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Focus entirely on the IT Admin, since they are the ones paying the bill.', false),
    (v_q_id, 'B', 'Design the core "Aha!" moment for the Engineering Manager, while building compliance features for IT.', true),
    (v_q_id, 'C', 'Ignore both and focus only on the CEO persona, as they have ultimate authority.', false),
    (v_q_id, 'D', 'Build two entirely separate apps: one for IT and one for Engineering.', false);

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
        'Figma''s Enterprise Transition',
        'Figma is moving upmarket. They have a deep understanding of the "Solo Designer." Now they need a persona for the "Design Systems Manager." What new dimension MUST this persona heavily focus on that the solo persona lacked?',
        'intermediate',
        'Figma',
        'Collaborative design tool',
        'C',
        'The correct answer is C. Moving from a solo user to an enterprise manager persona requires a shift in focus from individual creation tools (vectors, brushes) to systemic tools (workflows, governance, permissions, library management). The Design Systems Manager cares about team-wide consistency and control, not just personal output.',
        ARRAY['enterprise_personas', 'b2b_transition', 'user_needs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Individual creativity and unique brush/vector tool preferences.', false),
    (v_q_id, 'B', 'How to bypass IT security to install the app locally.', false),
    (v_q_id, 'C', 'Workflows, governance, team collaboration, and access permissions.', true),
    (v_q_id, 'D', 'Minimizing the cost of the software to save personal budget.', false);

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
        'Duolingo''s A/B Testing a Persona',
        E'Duolingo''s PM A/B tests a new Leaderboard feature targeting a hypothesized "Competitive Learner" persona.\n\n| Group | WAU | Avg Session Length |\n|-------|-----|--------------------|\n| Control | 1.2M | 12 mins |\n| Variant | 1.2M | 18 mins (top 20%), 4 mins (bottom 10%) |\n\nEngagement spikes for the top 20% but drops for the bottom 10%. What should the PM conclude?',
        'intermediate',
        'Duolingo',
        'Language learning app',
        'C',
        'The correct answer is C. The data validates the existence of the "Competitive Learner" persona (the top 20%), but also reveals that the feature acts as a strong deterrent (anti-persona effect) for another group (the bottom 10%, likely anxious or casual learners). A PM should use this to introduce toggle settings or distinct user journeys, rather than forcing it on everyone.',
        ARRAY['persona_validation', 'ab_testing', 'behavioral_segmentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The test is a failure because engagement dropped for 10% of users.', false),
    (v_q_id, 'B', 'All users should be forced into the "Competitive Learner" persona to maximize the 20% spike.', false),
    (v_q_id, 'C', 'The persona exists and drives engagement, but acts as a deterrent for a subset of other users.', true),
    (v_q_id, 'D', 'The 10% who dropped off are bots and should be excluded from persona data.', false);

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
        'Peloton''s Mapping Persona Pain Points',
        'Peloton''s "Data-Driven Athlete" persona''s main pain point is "I do not know if my cardiovascular baseline is improving over time." Which feature directly addresses this specific persona''s pain point?',
        'intermediate',
        'Peloton',
        'Connected fitness platform',
        'A',
        'The correct answer is A. Personas are only useful when their specific pain points map directly to feature solutions. A Strive Score and historical power output directly answer the Data-Driven Athlete''s need to track baseline improvement. Options B, C, and D appeal to different personas (Social Learner, Casual Rider, Gamifier).',
        ARRAY['pain_points', 'feature_mapping', 'user_needs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A personalized Strive Score and historical power output trending graphs.', true),
    (v_q_id, 'B', 'High-fiving other users during a live class.', false),
    (v_q_id, 'C', 'Scenic rides through virtual landscapes.', false),
    (v_q_id, 'D', 'Earning badges for taking 5 classes in a row.', false);

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
        'Shopify''s Marketing vs Product Personas',
        'Shopify''s Marketing team uses: "Sarah, 34, loves fashion, reads Vogue." The Product team uses: "High-Volume Apparel Merchant, handles 500+ SKUs, needs bulk inventory editing." Why do these persona definitions differ?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'D',
        'The correct answer is D. Marketing and Product teams often need different types of personas. Marketing personas focus heavily on demographics and psychographics to optimize ad targeting and acquisition channels. Product personas focus on behavioral contexts, system interactions, and functional goals to design user interfaces and technical capabilities.',
        ARRAY['marketing_personas', 'product_personas', 'cross_functional']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'One team is strictly B2B and the other is strictly B2C.', false),
    (v_q_id, 'B', 'The Product team is using outdated data.', false),
    (v_q_id, 'C', 'Marketing personas are always qualitative, while Product personas are quantitative.', false),
    (v_q_id, 'D', 'Marketing focuses on targeting and acquisition, while Product focuses on system interactions and goals.', true);

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
        'Stripe''s Strategic Anti-Persona',
        'Stripe defines "High-Risk, Cash-Heavy Local Businesses" (like dispensaries or casinos) as an anti-persona. A sales rep brings in a massive contract for a chain of casinos requiring custom offline features. What should the PM do based on the persona definition?',
        'intermediate',
        'Stripe',
        'Payment processing platform',
        'B',
        'The correct answer is B. An anti-persona is a strategic guardrail. Accepting features for an anti-persona, even for high revenue, introduces massive technical debt, regulatory risk, and derails the product from its core strategy. The PM must hold the line, as bending the product for an anti-persona destroys long-term focus.',
        ARRAY['anti_personas', 'product_strategy', 'stakeholder_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the contract immediately; revenue always overrides persona definitions.', false),
    (v_q_id, 'B', 'Reject the feature requests needed for this contract, as serving an anti-persona derails product strategy.', true),
    (v_q_id, 'C', 'Convert the anti-persona into a primary persona temporarily until the contract is signed.', false),
    (v_q_id, 'D', 'Build a separate, unbranded app just for casinos to hide it from the main user base.', false);

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
        'Discord''s Creator vs Consumer Balancing',
        'Discord''s PM notices the "Server Admin" persona needs complex bot integration tools, making the UI cluttered and intimidating for the "Casual Chatter" persona. How can the PM use these personas to fix the UI?',
        'intermediate',
        'Discord',
        'Voice and text communication platform',
        'C',
        'The correct answer is C. When balancing a "power user/admin" persona and a "casual consumer" persona, PMs often use progressive disclosure. You keep the default UI clean and simple for the vast majority of consumers, while hiding complex configurations in nested menus or specific admin views for the power users.',
        ARRAY['progressive_disclosure', 'power_users', 'ui_ux']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force Casual Chatters to learn the admin tools so everyone is on the same level.', false),
    (v_q_id, 'B', 'Remove the admin tools entirely to prioritize the Casual Chatter.', false),
    (v_q_id, 'C', 'Implement progressive disclosure: hide complex admin tools while keeping the core interface clean.', true),
    (v_q_id, 'D', 'Ban Server Admins from using Discord on mobile devices.', false);

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
        'Tinder''s Psychographic Segmentation',
        'Tinder''s PM segments users not by age or location, but by "Desire for External Validation" vs "Desire for Genuine Connection." This is an example of what type of persona building?',
        'intermediate',
        'Tinder',
        'Dating app',
        'A',
        'The correct answer is A. Psychographic segmentation divides users based on psychological traits, motivations, beliefs, and attitudes. This is highly effective for social and dating apps where users of the exact same demographic can have fundamentally opposing goals (validation vs. connection).',
        ARRAY['psychographics', 'segmentation', 'user_motivations']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Psychographic segmentation based on motivations and attitudes.', true),
    (v_q_id, 'B', 'Demographic segmentation based on quantifiable traits.', false),
    (v_q_id, 'C', 'Firmographic segmentation based on business characteristics.', false),
    (v_q_id, 'D', 'Behavioral segmentation based strictly on click paths.', false);

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
        'Canva''s Persona Fragmentation',
        'Canva launches a "Video Editor." The PM tries to use the exact same "Print Flyer Designer" persona to dictate the user experience for the video tool. Why will this lead to a poor user experience?',
        'intermediate',
        'Canva',
        'Graphic design platform',
        'C',
        'The correct answer is C. Extending a product line into a new medium (like video vs. print) introduces fundamentally different mental models. A print persona expects static layouts and CMYK, while a video persona needs timelines, keyframes, and audio syncing. Reusing the exact same persona for a radically different job-to-be-done causes UX failures.',
        ARRAY['persona_fragmentation', 'mental_models', 'product_expansion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Print designers do not own computers capable of rendering video.', false),
    (v_q_id, 'B', 'The Print Flyer Designer persona is an anti-persona for all digital products.', false),
    (v_q_id, 'C', 'Video editing involves fundamentally different mental models than static print design.', true),
    (v_q_id, 'D', 'Video editors require a B2B persona, while print designers are B2C.', false);

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
        'Notion''s Complex Buying Committee',
        'Notion is targeting Fortune 500s. The PM must map out the B2B buying committee personas. Which matrix correctly aligns the persona to their primary evaluation concern?',
        'advanced',
        'Notion',
        'Productivity workspace',
        'B',
        'The correct answer is B. In enterprise B2B software, the "Champion" (usually a manager or lead) cares about Team Productivity and UX. The "Economic Buyer" (VP or CFO) cares about ROI and tool consolidation (saving money). The "IT/Security Admin" cares about SAML, compliance, and security guardrails. PMs must build features addressing all three layers.',
        ARRAY['b2b_personas', 'buying_committee', 'enterprise']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Champion = Security/SAML; Economic Buyer = Team Productivity; IT Admin = ROI/Consolidation.', false),
    (v_q_id, 'B', 'Champion = Team Productivity; Economic Buyer = ROI/Consolidation; IT Admin = Security/SAML.', true),
    (v_q_id, 'C', 'Champion = ROI/Consolidation; Economic Buyer = Security/SAML; IT Admin = Team Productivity.', false),
    (v_q_id, 'D', 'Champion = Team Productivity; Economic Buyer = Team Productivity; IT Admin = Team Productivity.', false);

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
        'Airbnb''s Simpson''s Paradox in Personas',
        E'Airbnb''s PM is evaluating the "Budget Traveler" persona''s conversion rate.\n\n| Region | 2022 Conv % | 2023 Conv % | Volume Shift |\n|--------|-------------|-------------|--------------|\n| US     | 4.0%        | 4.2%        | Flat         |\n| EU     | 3.5%        | 3.7%        | Flat         |\n| Asia   | 1.0%        | 1.5%        | +500%        |\n| Global | 3.2%        | 2.8%        | -            |\n\nThe global conversion rate for Budget Travelers dropped, but local rates increased. What is the PM observing?',
        'advanced',
        'Airbnb',
        'Accommodation marketplace',
        'A',
        'The correct answer is A. This is Simpson''s Paradox. A massive influx of users from a lower-converting cohort (Asia) drags down the blended global average, even though every individual cohort is actually performing better. Advanced PMs must segment persona data carefully to avoid false conclusions about a persona''s overall health.',
        ARRAY['simpsons_paradox', 'data_segmentation', 'cohort_analysis']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Simpson''s Paradox; a large influx of traffic from a lower-converting region is dragging down the global average.', true),
    (v_q_id, 'B', 'The Novelty Effect; the persona is getting bored of the platform over time.', false),
    (v_q_id, 'C', 'A Sutva Violation; budget travelers are cannibalizing luxury travelers.', false),
    (v_q_id, 'D', 'The Peak-End Rule; the checkout process is too expensive for budget travelers.', false);

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
        'Slack''s Cannibalization of Personas',
        'Slack introduces a "Huddle" feature aimed at the "Quick Collaborator" persona. It is wildly successful. However, the "Deep Focus Developer" persona''s retention drops significantly because they are constantly interrupted. What is the advanced PM''s diagnosis?',
        'advanced',
        'Slack',
        'Enterprise communication platform',
        'C',
        'The correct answer is C. Features that perfectly serve one persona can create severe negative externalities for another. Advanced PMs anticipate this structural tension. Rather than rolling the feature back, the PM needs to build guardrails (like advanced Do Not Disturb or status muting) to protect the secondary persona from the primary persona''s tools.',
        ARRAY['negative_externalities', 'persona_tension', 'product_ecosystem']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Deep Focus Developer is no longer a valid persona and should be ignored.', false),
    (v_q_id, 'B', 'Huddles should be rolled back completely because it harmed a user group.', false),
    (v_q_id, 'C', 'The feature served one persona but created negative externalities for another, requiring new guardrails.', true),
    (v_q_id, 'D', 'The PM should charge developers extra for the ability to turn off Huddles.', false);

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
        'Spotify''s Algorithmic Personas',
        'Spotify''s ML models create thousands of dynamic micro-clusters (e.g., "Norwegian Death Metal Workout"). Yet, the PM still maintains 4 core human-readable personas. Why retain static personas when ML is mathematically more precise?',
        'advanced',
        'Spotify',
        'Music streaming service',
        'B',
        'The correct answer is B. Machine learning is incredible at optimizing content delivery dynamically, but it cannot design a user interface, articulate a product vision, or build empathy among engineers. Human-readable personas are required to align a product team around structural decisions (like UI layouts or broad feature bets) that algorithms can''t make.',
        ARRAY['algorithmic_personas', 'machine_learning', 'team_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'ML clusters are mathematically precise but cannot be stored in a PostgreSQL database.', false),
    (v_q_id, 'B', 'ML optimizes content, but human personas are needed to build empathy and design structural UI features.', true),
    (v_q_id, 'C', 'Static personas are required by law for GDPR compliance, whereas ML clusters are not.', false),
    (v_q_id, 'D', 'Human-readable personas are strictly for the marketing team''s ad copywriting.', false);

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
        'Uber''s Marketplace Dynamics and Personas',
        'Uber''s "Price-Sensitive Rider" persona usually waits for UberPool. During a rainstorm, surge pricing makes Pool as expensive as UberX. The rider takes an UberX instead. What does this reveal about persona behavior?',
        'advanced',
        'Uber',
        'Ride-hailing platform',
        'A',
        'The correct answer is A. In complex marketplaces, persona behaviors are not static traits; they are highly elastic and state-dependent. A user''s willingness to pay or wait changes drastically based on real-time environmental factors (weather, surge, urgency). Advanced PMs design features assuming personas fluidly transition based on context.',
        ARRAY['marketplace_dynamics', 'state_dependent_behavior', 'elasticity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Persona behaviors are highly elastic and state-dependent based on real-time marketplace dynamics.', true),
    (v_q_id, 'B', 'The rider has permanently shifted into the "Luxury Rider" persona.', false),
    (v_q_id, 'C', 'The persona was defined incorrectly and should not have included price sensitivity.', false),
    (v_q_id, 'D', 'Uber should ban users who deviate from their assigned persona behavior.', false);

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
        'Shopify''s Ecosystem Personas',
        'Shopify''s PM identifies that 30% of their "High-Volume Merchant" persona''s growth is actually driven by a secondary persona: the "3rd-Party App Developer" who builds custom tools for them. How should this impact the PM''s strategy?',
        'advanced',
        'Shopify',
        'E-commerce platform',
        'B',
        'The correct answer is B. In platform ecosystems, secondary personas (like developers) often act as force-multipliers for primary personas. Recognizing this means the PM must treat the platform ecosystem as a core product, investing heavily in APIs and developer experiences to indirectly drive massive value for the primary merchant persona.',
        ARRAY['platform_ecosystem', 'developer_personas', 'network_effects']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Block 3rd-party developers, as they are stealing revenue from Shopify''s native tools.', false),
    (v_q_id, 'B', 'Treat the ecosystem as a product, building robust APIs for Devs to indirectly serve Merchants.', true),
    (v_q_id, 'C', 'Force the Merchants to learn how to code so they do not need developers.', false),
    (v_q_id, 'D', 'Combine both groups into a single "Technical Merchant" persona.', false);

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
        'Figma''s Structural Tension',
        'Figma Enterprise PM faces a dilemma: The "Procurement Buyer" persona wants strict seat-license control to limit costs. The "IC Designer" persona wants frictionless collaboration (invite anyone instantly). If the PM optimizes strictly for frictionless collaboration, what is the most likely business outcome?',
        'advanced',
        'Figma',
        'Collaborative design tool',
        'D',
        'The correct answer is D. This is the classic B2B "land and expand" trap. Optimizing solely for user virality causes unchecked seat expansion. When the surprise bill hits procurement, it destroys trust with the Buyer persona, leading to churn. Advanced enterprise PMs must balance bottom-up virality with top-down cost governance to sustain renewals.',
        ARRAY['b2b_tension', 'buyer_vs_user', 'enterprise_governance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Perfect product-market fit, as the IC Designer is the only persona that matters.', false),
    (v_q_id, 'B', 'The Procurement Buyer will be delighted by the viral adoption of the tool.', false),
    (v_q_id, 'C', 'The engineering team will not be able to scale the database to handle the invites.', false),
    (v_q_id, 'D', 'Viral internal growth causes a surprise bill, infuriating the Buyer and risking contract cancellation.', true);

    RAISE NOTICE 'Successfully inserted 35 questions for user-personas';

END $$;
