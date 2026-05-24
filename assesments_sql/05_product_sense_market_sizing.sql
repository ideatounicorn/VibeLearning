-- ============================================
-- QUESTION BANK: Product Sense > Market Sizing
-- Sub-skill slug: market-sizing
-- Total questions: 35
-- Difficulty mix: 10 foundational, 18 intermediate, 7 advanced
-- Run AFTER 02_seed_categories.sql
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_question_id UUID;
BEGIN
    -- Look up the sub_skill ID for market-sizing
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'market-sizing'
      AND category_id = (SELECT id FROM categories WHERE slug = 'product-sense');

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill "market-sizing" not found under "product-sense". Run seed data first.';
    END IF;

    -- ========================================
    -- Q1: Uber Eats'' TAM vs SAM (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 1,
        'Uber Eats'' TAM vs SAM Distinction',
        'Uber Eats is evaluating expansion into a mid-sized European city with 800,000 residents. The total food services industry in the city is worth €2.1 billion annually, the online food delivery segment is €320 million, and Uber Eats estimates it can realistically capture 18% of online delivery within 2 years. A PM is asked to identify the SAM for Uber Eats in this city. Which figure best represents the SAM?',
        'foundational',
        'Uber Eats',
        'European city expansion for food delivery platform',
        'B',
        'The SAM (Serviceable Addressable Market) is the portion of the TAM that your product can actually serve given its business model and constraints. Here, the TAM is the entire food services industry (€2.1B), but Uber Eats only operates in online food delivery, so the SAM is €320M. The €57.6M figure (18% of €320M) represents the SOM — the realistic share the company expects to capture. Many candidates confuse SAM with SOM; SAM is defined by what you *could* serve with your product model, while SOM factors in competitive dynamics and execution ability. The full €2.1B would overstate the opportunity since Uber Eats cannot serve dine-in restaurants.',
        ARRAY['tam_sam_som', 'addressable_market', 'market_segmentation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', '€2.1 billion — the total food services market in the city', false),
    (v_question_id, 'B', '€320 million — the online food delivery segment', true),
    (v_question_id, 'C', '€57.6 million — 18% of the online delivery segment', false),
    (v_question_id, 'D', '€144 million — the dine-in portion minus online delivery', false);

    -- ========================================
    -- Q2: Spotify Bottom-Up Sizing (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 2,
        'Spotify''s Bottom-Up Podcast Market Sizing',
        'Spotify is considering launching a premium podcast-only subscription at $4.99/month. A PM wants to estimate annual revenue potential using a bottom-up approach. They have: 220M free-tier users globally, 35% listen to at least one podcast monthly, research suggests 8% of podcast listeners would pay for premium content. What is the correct bottom-up annual revenue estimate?',
        'foundational',
        'Spotify',
        'Premium podcast subscription tier sizing',
        'C',
        'Bottom-up sizing builds from unit-level data to a total estimate. The calculation is: 220M free users × 35% podcast listeners = 77M podcast listeners. Then 77M × 8% conversion = 6.16M paying subscribers. Annual revenue = 6.16M × $4.99 × 12 = ~$368.8M. Option A incorrectly applies the 8% to all free users rather than just podcast listeners. Option B uses the right user count but forgets to annualize (multiplying by 12). Option D doubles the price assumption. Bottom-up is the preferred approach here because Spotify has concrete user data to build from, making it more credible than a top-down estimate from global podcast market reports.',
        ARRAY['bottom_up_sizing', 'fermi_estimation', 'unit_economics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', '$105.4M — calculated as 220M × 8% × $4.99 × 12', false),
    (v_question_id, 'B', '$30.7M — calculated as 220M × 35% × 8% × $4.99', false),
    (v_question_id, 'C', '$368.8M — calculated as 220M × 35% × 8% × $4.99 × 12', true),
    (v_question_id, 'D', '$737.6M — calculated as 220M × 35% × 8% × $9.99 × 12', false);

    -- ========================================
    -- Q3: Netflix Top-Down Sizing (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 3,
        'Netflix''s Top-Down Market Approach',
        'Netflix is entering the mobile-only gaming market. A PM uses a top-down approach, starting with the global mobile gaming market ($95B), filtering for casual games ($38B), then for markets where Netflix operates (72% of global casual gaming revenue). Which statement best describes the primary risk of this top-down approach?',
        'foundational',
        'Netflix',
        'Mobile gaming market entry via top-down analysis',
        'D',
        'The core risk of top-down sizing is that it starts with macro numbers and applies filters, but each filter involves assumptions that can compound errors. For Netflix specifically, the biggest risk is that the top-down approach assumes Netflix can capture a portion of the existing casual gaming market, but Netflix''s gaming model (bundled with subscription, no in-app purchases) is fundamentally different from how the $38B casual gaming market generates revenue. The top-down number gives a misleading sense of the opportunity because Netflix isn''t competing for the same revenue pool. Options A and B describe valid concerns but are operational, not fundamental flaws in the sizing methodology. Option C is incorrect because top-down by definition uses macro data.',
        ARRAY['top_down_sizing', 'market_opportunity', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Netflix lacks game development expertise, so the market size is irrelevant', false),
    (v_question_id, 'B', 'The 72% geographic filter may not account for regional gaming preferences', false),
    (v_question_id, 'C', 'Top-down approaches lack sufficient granularity because they don''t use user-level data', false),
    (v_question_id, 'D', 'The revenue model (subscription-bundled, no IAP) differs from how the $38B market generates revenue, making the filtered number misleading', true);

    -- ========================================
    -- Q4: Airbnb Market Segmentation (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 4,
        'Airbnb''s Market Segmentation for Sizing',
        'Airbnb is sizing the market for a new "Airbnb for Work" corporate travel product. The PM starts with the global business travel market ($1.4T). A junior analyst segments only by geography (US = 40% = $560B) and calls this the SAM. What is the most critical segmentation dimension the analyst missed?',
        'foundational',
        'Airbnb',
        'Corporate travel product market segmentation',
        'B',
        'Geographic segmentation alone is insufficient for accurate market sizing. The most critical missing dimension is behavioral — specifically, what percentage of business travelers would consider alternatives to traditional hotels. Business travel includes flights, ground transport, conferences, and other non-accommodation spending, so the accommodation-only segment is much smaller than $560B. Furthermore, corporate travel policies at many large companies mandate hotel chains, making those travelers unserviceable. Option A (company size) is relevant but secondary to the fundamental issue of filtering for the right category. Option C (traveler age) is a demographic variable with less direct impact on serviceable market. Option D matters for execution but doesn''t affect market sizing methodology.',
        ARRAY['market_segmentation', 'addressable_market', 'serviceable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Company size — small businesses have different travel budgets than enterprises', false),
    (v_question_id, 'B', 'Behavioral — what share of business travel spend is on accommodation and what share of those travelers would consider non-hotel options', true),
    (v_question_id, 'C', 'Demographic — younger business travelers may prefer Airbnb over hotels', false),
    (v_question_id, 'D', 'Competitive — how much market share Marriott and Hilton currently hold', false);

    -- ========================================
    -- Q5: Slack SOM Estimation (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 5,
        'Slack''s SOM Estimation Logic',
        'Slack is estimating its SOM (Serviceable Obtainable Market) in Japan. Data: 5.2M knowledge workers in Japan use team collaboration tools (SAM). Slack currently has 12% market share. Microsoft Teams holds 48%, and local tools hold 25%. Slack''s growth rate is 3% YoY. A PM projects Slack''s SOM in 3 years. Which approach is most appropriate?',
        'foundational',
        'Slack',
        'Japanese enterprise collaboration market share projection',
        'C',
        'SOM estimation should be grounded in realistic competitive dynamics, not just arithmetic growth projections. The best approach starts with current market share (12%), considers competitive trends (Teams is dominant and growing via Office 365 bundling), and models where Slack can realistically win — likely segments underserved by Teams such as tech startups, creative agencies, and companies avoiding Microsoft ecosystems. Option A is too simplistic — applying a flat growth rate ignores competitive pressure from Teams. Option B assumes Slack can capture all remaining share, which is unrealistic given Teams'' dominance. Option D conflates TAM growth with Slack-specific share growth. A good SOM estimate requires understanding segment-level competitive dynamics, not just top-line math.',
        ARRAY['tam_sam_som', 'penetration_rate', 'competitive_share']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Apply the 3% YoY growth rate to current share: 12% × 1.03^3 = ~13.1% of SAM in 3 years', false),
    (v_question_id, 'B', 'Subtract Teams'' share and local tools from the SAM to find the remaining 15% as Slack''s ceiling', false),
    (v_question_id, 'C', 'Model segment-by-segment where Slack has competitive advantage (e.g., startups, non-Microsoft shops) and estimate capture rate in those segments', true),
    (v_question_id, 'D', 'Grow the SAM by industry growth rate and assume Slack maintains 12% share of the larger market', false);

    -- ========================================
    -- Q6: TikTok Bottom-Up vs Top-Down (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 6,
        'TikTok''s Sizing Methodology Choice',
        'TikTok is evaluating the market for an e-commerce feature (TikTok Shop) in Southeast Asia. The PM has two data points: (1) Southeast Asian social commerce market is $25B (top-down industry report), and (2) TikTok has 325M monthly active users in SEA, with early tests showing 2.1% make a purchase with an average order value of $18. Which sizing approach should the PM prioritize and why?',
        'foundational',
        'TikTok',
        'Social commerce feature in Southeast Asia',
        'B',
        'When a company has proprietary user data and early behavioral signals, bottom-up sizing is almost always more credible and actionable. TikTok has actual user counts (325M MAU), observed purchase behavior (2.1% conversion), and average transaction values ($18) — this is far more reliable than a third-party industry report. The bottom-up estimate yields 325M × 2.1% × $18 × 12 = ~$1.47B annually, grounded in real behavior. The $25B top-down figure includes platforms TikTok doesn''t compete with (like Shopee, Lazada), making it less useful for TikTok''s specific opportunity. Option C wrongly dismisses bottom-up data. Option D suggests averaging, which is a common but methodologically unsound practice — two differently sourced estimates shouldn''t be averaged.',
        ARRAY['bottom_up_sizing', 'top_down_sizing', 'market_opportunity']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Top-down, because the $25B figure provides the total market context needed for investor presentations', false),
    (v_question_id, 'B', 'Bottom-up, because TikTok''s own user data and behavioral signals produce a more credible and actionable estimate', true),
    (v_question_id, 'C', 'Top-down, because bottom-up estimates based on early tests are unreliable and tend to undercount the opportunity', false),
    (v_question_id, 'D', 'Average both approaches to get a balanced estimate that accounts for uncertainty', false);

    -- ========================================
    -- Q7: Zoom Proxy Metrics (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 7,
        'Zoom''s Proxy Metric for Market Sizing',
        'Zoom wants to size the market for a new AI meeting notes feature. There is no industry report on "AI meeting summary tools." The PM needs a proxy metric to estimate addressable demand. Which proxy metric is most appropriate?',
        'foundational',
        'Zoom',
        'AI meeting notes feature market sizing without direct data',
        'C',
        'When direct market data doesn''t exist, proxy metrics help estimate demand by measuring closely related behaviors. The number of meetings where participants take manual notes or generate transcripts is the best proxy because it directly measures the behavior Zoom AI would replace. These users are already investing effort in the exact problem the feature solves, making them the most likely adopters. Option A (total Zoom meetings) massively overcounts — not every meeting needs notes. Option B (revenue of note-taking apps like Notion) measures a related but different market since most Notion usage isn''t meeting-specific. Option D (knowledge workers globally) is too broad and doesn''t indicate demand for this specific feature. The best proxy metrics are ones that measure the incumbent behavior your product aims to replace.',
        ARRAY['proxy_metrics', 'addressable_market', 'fermi_estimation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Total number of Zoom meetings per day globally', false),
    (v_question_id, 'B', 'Revenue of standalone note-taking apps (Notion, Evernote)', false),
    (v_question_id, 'C', 'Number of meetings where participants currently take manual notes or generate transcripts', true),
    (v_question_id, 'D', 'Total number of knowledge workers globally', false);

    -- ========================================
    -- Q8: DoorDash Fermi Estimation (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 8,
        'DoorDash''s Fermi Estimation Framework',
        'A DoorDash PM is asked in a strategy meeting: "How many grocery delivery orders happen in the US per week?" They have no data. Using Fermi estimation, which decomposition approach is most methodologically sound?',
        'foundational',
        'DoorDash',
        'Estimating US grocery delivery volume using Fermi principles',
        'A',
        'The best Fermi decomposition breaks the problem into independently estimable components that multiply to the answer. Starting with US households (~130M), estimating the % that use grocery delivery (~15-20%), and their weekly order frequency (~0.8-1.2 orders) gives you: 130M × 18% × 1.0 = ~23.4M orders/week. This approach is sound because each component can be estimated from general knowledge and cross-checked. Option B works backward from revenue, which requires knowing revenue first. Option C uses total grocery spending, which mixes in-store and online in ways that are hard to disaggregate. Option D relies on a single company''s data and market share estimate, which introduces compounding assumptions. In Fermi estimation, the goal is to have as few dependent assumptions as possible.',
        ARRAY['fermi_estimation', 'bottom_up_sizing', 'market_opportunity']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'US households × % using grocery delivery × average weekly order frequency', true),
    (v_question_id, 'B', 'Total US grocery delivery revenue ÷ average order value', false),
    (v_question_id, 'C', 'US weekly grocery spending ÷ average online grocery basket size', false),
    (v_question_id, 'D', 'DoorDash grocery orders × (1 / DoorDash''s estimated market share)', false);

    -- ========================================
    -- Q9: Pinterest Common Sizing Mistake (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 9,
        'Pinterest''s Market Sizing Pitfall',
        'Pinterest is sizing the market for shoppable pins in home décor. A PM estimates: "200M Pinterest users are interested in home décor. The average US household spends $2,000/year on home décor. Therefore, the market is 200M × $2,000 = $400B." What is the most critical error in this analysis?',
        'foundational',
        'Pinterest',
        'Shoppable pins market sizing for home décor',
        'B',
        'This is a classic market sizing mistake: conflating potential demand with capturable revenue. Just because 200M users browse home décor on Pinterest does not mean each will spend $2,000 through Pinterest. The PM is treating the total household spend as if Pinterest would capture 100% of it, when in reality Pinterest would only capture a fraction as a referral or commerce intermediary. Additionally, the $2,000 household figure is being applied per-user rather than per-household, likely double-counting within households. Option A is a secondary issue. Option C is incorrect because the user count isn''t necessarily wrong for a TAM-level view. Option D raises a valid point about currency, but it''s not the primary error. The fundamental flaw is equating "interested in" with "will purchase through."',
        ARRAY['tam_sam_som', 'market_opportunity', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The $2,000 figure should be inflation-adjusted for current year', false),
    (v_question_id, 'B', 'It conflates total household spending with what users would actually purchase through Pinterest, massively overstating the addressable market', true),
    (v_question_id, 'C', 'The 200M user base is too large — only US users should be counted', false),
    (v_question_id, 'D', 'The estimate uses US household spending but applies it to global Pinterest users', false);

    -- ========================================
    -- Q10: LinkedIn Growth Rate Estimation (Foundational)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 10,
        'LinkedIn''s Growth Rate Extrapolation',
        'LinkedIn Learning grew revenue from $400M to $680M over 3 years (70% total growth). A PM extrapolates this forward, projecting $1.16B in 3 more years using the same growth rate. What is the biggest risk with this linear extrapolation?',
        'foundational',
        'LinkedIn',
        'LinkedIn Learning revenue growth projection',
        'D',
        'Growth rate extrapolation is one of the most common and dangerous market sizing mistakes. The key issue is that most products follow an S-curve — initial rapid growth slows as the market matures and penetration increases. LinkedIn Learning''s early 70% growth likely benefited from the COVID-driven shift to remote work and online learning, a tailwind that won''t repeat. As the base grows larger, maintaining the same percentage growth requires acquiring proportionally more customers, which becomes harder as you exhaust early adopters. Option A is a valid concern but doesn''t address the core methodological flaw. Option B is overly dismissive. Option C raises a fair point about competitors but isn''t the primary risk of the extrapolation method itself.',
        ARRAY['growth_rate_estimation', 'market_opportunity', 'top_down_sizing']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The PM should use CAGR instead of total growth rate for projections', false),
    (v_question_id, 'B', 'Three years of data is insufficient to project any growth rate forward', false),
    (v_question_id, 'C', 'Competitors like Coursera and Udemy could erode LinkedIn''s growth', false),
    (v_question_id, 'D', 'Growth typically follows an S-curve — early rapid growth slows as market penetration increases and one-time tailwinds (e.g., COVID) don''t repeat', true);

    -- ========================================
    -- Q11: Stripe Adjacent Market Sizing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 11,
        'Stripe''s Adjacent Market Identification',
        'Stripe (online payment processing) is considering expanding into business banking (Stripe Treasury). The PM needs to size this adjacent market. Stripe processes payments for 3.1M businesses. The US small business banking market generates $150B in annual revenue. Which approach best sizes Stripe''s specific opportunity in business banking?',
        'intermediate',
        'Stripe',
        'Adjacent market expansion into business banking',
        'C',
        'When sizing adjacent markets, the most effective approach leverages your existing customer base as a beachhead. Stripe should start with its 3.1M existing businesses, estimate what share would consolidate banking with their payments provider (likely high given the convenience), and calculate revenue per customer from banking services. This is superior to top-down filtering because Stripe''s competitive advantage is its existing relationship and integration — not competing in the open market for banking customers. Option A applies a simple market-share assumption without accounting for Stripe''s unique distribution advantage. Option B ignores Stripe''s existing customer base entirely. Option D undervalues the opportunity by looking only at payment-linked revenue, missing the broader banking relationship potential.',
        ARRAY['adjacent_market', 'bottom_up_sizing', 'market_expansion']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Take 2% of the $150B small business banking market as a reasonable Year 1 capture = $3B', false),
    (v_question_id, 'B', 'Size the market as total US small business banking ($150B) minus the share held by top 4 banks', false),
    (v_question_id, 'C', 'Start with Stripe''s 3.1M existing businesses, estimate adoption rate for bundled banking, and calculate average banking revenue per business', true),
    (v_question_id, 'D', 'Estimate the transaction fee revenue Stripe would earn on business banking transactions flowing through its payments infrastructure', false);

    -- ========================================
    -- Q12: Duolingo Market Validation (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 12,
        'Duolingo''s Market Sizing Validation',
        'Duolingo estimated the market for a math learning app (Duolingo Math) at $2.8B using a top-down approach from the global EdTech market. Before committing engineering resources, the PM wants to validate this estimate. Which validation method provides the strongest evidence that the sizing is reasonable?',
        'intermediate',
        'Duolingo',
        'Validating market estimate for math learning expansion',
        'B',
        'The strongest validation for a market size estimate comes from triangulating with a completely different methodology. If the bottom-up estimate (using Duolingo''s user data on math interest) yields a similar order of magnitude to the top-down $2.8B, confidence increases significantly. Option A (survey data) is useful but suffers from stated-preference bias — people say they''d pay for things they won''t. Option C validates demand interest but doesn''t validate the dollar value of the market. Option D provides a useful benchmark but only tells you about competitors'' current revenue, not the total addressable market. The gold standard in market sizing is convergence between independently derived estimates using different methodologies.',
        ARRAY['market_validation', 'bottom_up_sizing', 'top_down_sizing']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Survey 5,000 Duolingo users on willingness to pay for a math app', false),
    (v_question_id, 'B', 'Build a bottom-up estimate using Duolingo''s existing user base, % interested in math, and expected conversion to paid, then compare with the top-down figure', true),
    (v_question_id, 'C', 'Launch a waitlist landing page and measure sign-up rate as a demand signal', false),
    (v_question_id, 'D', 'Benchmark against revenue of existing math apps (Photomath, Khan Academy) and sum their revenues', false);

    -- ========================================
    -- Q13: Tesla Market Timing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 13,
        'Tesla''s Market Maturity Assessment',
        'In 2018, a Tesla PM is sizing the market for a home solar + battery storage product (Powerwall). The total US residential electricity market is $170B. The PM estimates the home solar market at $12B and the home battery market at $1.2B. However, both markets are growing at 25%+ annually. How should the PM handle market maturity in their sizing?',
        'intermediate',
        'Tesla',
        'Home energy product in a rapidly growing market',
        'D',
        'For rapidly growing markets, static TAM figures are misleading because they represent today''s market, not the market at the time of scale. The PM should present a range with time horizons — e.g., current TAM of $1.2B for batteries, growing to $4.5B+ in 5 years based on cost curves, regulatory trends, and adoption rates. This gives stakeholders an honest view of both current reality and future potential. Option A uses today''s small number, which dramatically understates the opportunity for a company making multi-year bets. Option B uses the $170B electricity market, which is misleading since most electricity consumers won''t adopt solar+battery soon. Option C is arbitrary and not grounded in analysis of growth drivers.',
        ARRAY['market_opportunity', 'growth_rate_estimation', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Use the current $1.2B battery market as TAM since it reflects actual current spending', false),
    (v_question_id, 'B', 'Use the $170B residential electricity market as TAM since solar+battery will eventually replace grid power', false),
    (v_question_id, 'C', 'Average the current market ($1.2B) and the total electricity market ($170B) to get a mid-range estimate', false),
    (v_question_id, 'D', 'Present a time-horizon-based TAM that models growth from the $1.2B current market using adoption curves, cost trends, and policy drivers', true);

    -- ========================================
    -- Q14: Canva Multi-Segment Sizing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 14,
        'Canva''s Multi-Segment Market Sizing',
        'Canva is sizing its total market across three segments: (1) Individual creators — 50M potential users at $12.99/month, (2) Small business teams — 8M teams of ~5 people at $14.99/user/month, (3) Enterprise — 200K companies at $30/user/month with 50 avg seats. A PM sums these to get the total market. What is the key risk in this multi-segment sizing?',
        'intermediate',
        'Canva',
        'Multi-segment market sizing across individual, team, and enterprise',
        'A',
        'Double-counting is the most dangerous pitfall in multi-segment market sizing. A freelance designer might be counted as an "individual creator" AND as a member of a "small business team," and a startup employee might appear in both the "small business" and "enterprise" segments depending on how the company grows. When segments overlap, summing them inflates the total. The PM should define mutually exclusive segment boundaries or apply an overlap discount. Option B is operationally valid but doesn''t relate to sizing methodology. Option C might be true for some markets but isn''t the primary risk of the multi-segment addition. Option D is a concern but doesn''t address the structural issue with the sizing approach itself.',
        ARRAY['market_segmentation', 'tam_sam_som', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Users may be double-counted across segments — a freelancer could appear in both "individual creator" and "small business team" segments', true),
    (v_question_id, 'B', 'Canva likely cannot serve all three segments equally well with one product', false),
    (v_question_id, 'C', 'The enterprise segment is priced too low compared to competitors like Adobe', false),
    (v_question_id, 'D', 'The 50M individual creators figure likely includes users who would never pay for design tools', false);

    -- ========================================
    -- Q15: Instacart Unit Economics in Sizing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 15,
        'Instacart''s Unit Economics in Market Sizing',
        'Instacart sizes the US online grocery delivery market at $120B (total GMV). A PM argues this represents Instacart''s revenue opportunity. Average take rate is 8% of GMV, fulfillment cost is 6% of GMV, and customer acquisition cost averages $45 per customer. Why is using GMV as the market size misleading for assessing Instacart''s opportunity?',
        'intermediate',
        'Instacart',
        'GMV vs revenue in grocery delivery market sizing',
        'B',
        'This illustrates a critical distinction in market sizing: GMV (Gross Merchandise Volume) is not revenue. Instacart doesn''t keep $120B — it keeps its take rate (8% of GMV = $9.6B in revenue). Even more importantly, after fulfillment costs (6% of GMV = $7.2B), the gross margin is only ~2% of GMV = $2.4B, which must still cover CAC, overhead, and other costs. Presenting $120B as "the market" gives investors and leadership a dramatically inflated view of the economic opportunity. Option A is true but secondary to the core issue. Option C confuses the issue — the $120B is not the wrong metric because of market share, but because it measures GMV rather than revenue. Option D raises a valid but separate concern about market concentration.',
        ARRAY['unit_economics', 'market_opportunity', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The $120B includes non-grocery items like alcohol and household goods that have different margins', false),
    (v_question_id, 'B', 'GMV overstates the opportunity — Instacart''s actual revenue is 8% take rate ($9.6B), and gross profit after fulfillment is only ~2% of GMV (~$2.4B)', true),
    (v_question_id, 'C', 'Instacart can''t capture 100% of the online grocery market due to competition from Amazon Fresh and Walmart', false),
    (v_question_id, 'D', 'The $120B figure is concentrated in a few metro areas, making it appear larger than the addressable geographic market', false);

    -- ========================================
    -- Q16: Figma Competitive Share (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 16,
        'Figma''s Competitive Market Share Estimation',
        'Figma wants to estimate its market share in the design tools market. The challenge: there is no single industry report that covers all competitors. Available data: Figma ARR = $400M, Adobe Creative Cloud (design subset) = ~$4B, Sketch revenue = ~$50M, InVision = ~$30M. A PM sums known competitor revenues ($4.48B) and calculates Figma''s share as 8.9%. What flaw does this approach have?',
        'intermediate',
        'Figma',
        'Estimating market share from competitor revenue data',
        'C',
        'Summing known competitor revenues creates a denominator that only includes companies you know about, systematically overestimating your market share. The actual market includes dozens of smaller tools (Canva for design, Framer, Penpot, Miro for whiteboarding-design overlap), open-source alternatives, and in-house tools at large companies. This is called "survivorship bias in market sizing" — you only count what''s visible. The real market could be $6-8B+, making Figma''s share closer to 5-6%. Option A raises a valid structural question but doesn''t address the methodological flaw. Option B is incorrect — public and private company revenue can be compared if sourced properly. Option D identifies a real challenge but doesn''t pinpoint the specific error in the PM''s calculation.',
        ARRAY['competitive_share', 'market_opportunity', 'top_down_sizing']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Adobe Creative Cloud includes non-design products (video, PDF), so the comparison is apples-to-oranges', false),
    (v_question_id, 'B', 'Figma and Adobe have different pricing models, making revenue comparison unreliable', false),
    (v_question_id, 'C', 'The denominator only includes known competitors — the actual market includes many uncounted tools, open-source alternatives, and in-house solutions, overstating Figma''s share', true),
    (v_question_id, 'D', 'Revenue is a lagging indicator and doesn''t reflect current user preference trends favoring Figma', false);

    -- ========================================
    -- Q17: Notion Bottom-Up with Conversion Funnel (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 17,
        'Notion''s Conversion Funnel Market Sizing',
        'Notion is sizing the market for a new Notion AI writing assistant. Data: 30M monthly active users, 45% use docs (text editing) features, 60% of doc users write more than 500 words/week, early tests show 12% would upgrade to AI tier at $10/month. A PM builds the bottom-up funnel. What is the estimated annual revenue, and which assumption should the PM stress-test first?',
        'intermediate',
        'Notion',
        'AI writing assistant feature market sizing with conversion funnel',
        'B',
        'The funnel calculation: 30M MAU × 45% doc users = 13.5M → × 60% active writers = 8.1M → × 12% conversion = 972K subscribers → × $10/month × 12 = ~$116.6M annually. The 12% conversion assumption deserves the most scrutiny because it comes from "early tests" which typically suffer from selection bias — early testers are often power users who are not representative of the broader population. Real conversion rates in freemium products typically range from 2-5%, making 12% aggressively optimistic. Option A uses the correct math but identifies the wrong assumption to stress-test; user count is known data. Option C has the wrong revenue figure. Option D inverts the logic — the 45% and 60% filters are based on actual usage data, not projections.',
        ARRAY['bottom_up_sizing', 'penetration_rate', 'market_validation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', '$116.6M annually; stress-test the 30M MAU figure as it may include inactive accounts', false),
    (v_question_id, 'B', '$116.6M annually; stress-test the 12% conversion rate as early test participants likely skew toward power users', true),
    (v_question_id, 'C', '$58.3M annually; stress-test the $10/month price as users may prefer a cheaper tier', false),
    (v_question_id, 'D', '$116.6M annually; stress-test the 45% and 60% filters as they may decline if AI changes user behavior', false);

    -- ========================================
    -- Q18: WhatsApp Sizing in Emerging Market (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 18,
        'WhatsApp''s Emerging Market Payment Sizing',
        'WhatsApp is sizing the peer-to-peer (P2P) payment market in India. Data: India has 500M WhatsApp users, the total Indian digital P2P payment market is $800B annually (driven by UPI), and WhatsApp Pay currently processes 2% of UPI transactions. A PM projects WhatsApp can reach 15% UPI market share based on user base dominance. Why might this projection overestimate WhatsApp Pay''s achievable market?',
        'intermediate',
        'WhatsApp',
        'P2P payments market sizing in India',
        'D',
        'This is a classic case where market sizing ignores structural constraints. In India, the P2P payment market is heavily influenced by regulatory decisions — the NPCI (National Payments Corporation of India) imposed a 30% market share cap on any single UPI app, and WhatsApp Pay has faced repeated regulatory delays due to data localization requirements. Additionally, Google Pay and PhonePe have established strong habits with cashback incentives that create switching costs beyond what user base alone can overcome. Option A is partially true but understates the issue. Option B is incorrect — WhatsApp''s user base advantage is real but insufficient. Option C raises a relevant point about revenue model but doesn''t explain why market share itself is overestimated.',
        ARRAY['market_opportunity', 'penetration_rate', 'market_expansion']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The $800B figure includes merchant payments, not just P2P, inflating the relevant market', false),
    (v_question_id, 'B', 'WhatsApp''s messaging user base doesn''t translate to payment adoption because users prefer separate financial apps', false),
    (v_question_id, 'C', 'P2P payments have zero take rate for WhatsApp, so transaction volume doesn''t equal revenue', false),
    (v_question_id, 'D', 'Regulatory caps on UPI market share, data localization requirements, and entrenched competitor habits create structural constraints not captured in user-base-based projections', true);

    -- ========================================
    -- Q19: Peloton Market Ceiling (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 19,
        'Peloton''s Market Ceiling Analysis',
        'In 2020, Peloton sized its TAM as all US households with income >$50K that have at least one fitness-oriented member (58M households). At $39/month subscription + $1,895 bike, this implied a massive TAM. By 2022, Peloton had 3M subscribers and growth stalled. What market sizing error contributed most to the overestimate?',
        'intermediate',
        'Peloton',
        'Connected fitness market ceiling reality check',
        'B',
        'Peloton''s sizing error was defining TAM based on demographic eligibility (income + fitness interest) rather than behavioral willingness. Having >$50K income and caring about fitness doesn''t mean a household will buy a $1,895 bike and commit to $39/month when alternatives (gym, outdoor running, free YouTube workouts, cheaper bikes) exist. The behavioral filter — "would actually choose a connected premium indoor bike over all alternatives" — is far more restrictive than the demographic filter. This is a common mistake: defining your market as "everyone who could theoretically use the product" rather than "everyone who would choose your product given alternatives." Option A is true but is a normal business challenge, not a sizing methodology error. Option C happened but is about execution, not sizing. Option D is a valid consideration but less fundamental than the core segmentation error.',
        ARRAY['addressable_market', 'market_segmentation', 'tam_sam_som']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Peloton didn''t account for recession risk and discretionary spending reduction', false),
    (v_question_id, 'B', 'The TAM used demographic filters (income, fitness interest) instead of behavioral filters (willingness to choose a premium connected bike over all alternatives)', true),
    (v_question_id, 'C', 'Peloton''s supply chain issues prevented them from fulfilling demand during COVID', false),
    (v_question_id, 'D', 'The TAM didn''t account for geographic constraints — Peloton bikes can''t be delivered to all US households', false);

    -- ========================================
    -- Q20: Shopify Marketplace Sizing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 20,
        'Shopify''s Platform Market Sizing',
        'Shopify is sizing the market for its platform. A PM calculates: Total e-commerce market = $5.5T globally. Shopify''s addressable segment (SMB e-commerce) = $1.2T in GMV. Shopify''s average take rate = 2.8%. Therefore, Shopify''s revenue TAM = $1.2T × 2.8% = $33.6B. A finance analyst argues this understates the opportunity. Why might the analyst be correct?',
        'intermediate',
        'Shopify',
        'Platform revenue TAM with expanding services',
        'C',
        'The PM''s calculation correctly adjusts GMV to revenue using the take rate, which is good practice. However, it assumes the 2.8% take rate is static. Shopify has been steadily expanding its services — payments (Shopify Payments), shipping (Shopify Fulfillment), capital (Shopify Capital), email marketing, and POS. Each new service increases the take rate per merchant. If Shopify''s take rate expands to 4-5% over time through additional services, the revenue TAM grows from $33.6B to $48-60B without any GMV growth. Option A is wrong because the PM already filtered to SMB e-commerce. Option B misidentifies the direction — enterprises are not Shopify''s core market. Option D raises a valid point about geographic expansion but the question asks why the current estimate *understates* opportunity, and the expanding take rate is a more structural factor.',
        ARRAY['unit_economics', 'market_expansion', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The $5.5T global e-commerce market is the true TAM, not the $1.2T SMB subset', false),
    (v_question_id, 'B', 'Shopify is moving upmarket to enterprises, which would increase the $1.2T base', false),
    (v_question_id, 'C', 'Shopify''s take rate is expanding through additional services (payments, fulfillment, capital), so the 2.8% understates future revenue capture per dollar of GMV', true),
    (v_question_id, 'D', 'Shopify is expanding internationally, which would increase the $1.2T SMB e-commerce base beyond current estimates', false);

    -- ========================================
    -- Q21: Rivian Market Timing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 21,
        'Rivian''s Market Timing Dilemma',
        'Rivian is sizing the market for electric adventure vehicles (SUVs and trucks). The total US SUV/truck market is $450B annually. Current EV penetration in SUVs/trucks is only 3%. A PM must decide: should the market size be based on 3% current EV penetration ($13.5B) or a projected 25% EV penetration in 2030 ($112.5B)? What is the best approach?',
        'intermediate',
        'Rivian',
        'EV adventure vehicle market timing and penetration',
        'D',
        'Market timing is one of the most nuanced aspects of market sizing, especially in rapidly evolving sectors like EVs. The best approach is to present a trajectory from current state to projected state, clearly labeling the assumptions driving growth (charging infrastructure, battery cost declines, regulatory mandates, consumer sentiment). This gives decision-makers both a current reality check and a future vision. Option A is too conservative for strategic planning — if Rivian only plans for today''s 3%, it will underinvest. Option B is too aggressive as a single point estimate — 25% penetration depends on many uncertain factors. Option C creates a false precision that appears rigorous but masks the actual uncertainty. The trajectory approach acknowledges that market sizing is not a static number but a function of time and assumptions.',
        ARRAY['market_opportunity', 'growth_rate_estimation', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Use 3% ($13.5B) as it reflects actual current demand and avoids speculative projections', false),
    (v_question_id, 'B', 'Use 25% ($112.5B) as it reflects the market Rivian is building toward', false),
    (v_question_id, 'C', 'Average the two figures ($63B) to create a balanced mid-point estimate', false),
    (v_question_id, 'D', 'Present a market trajectory from $13.5B (today) to $112.5B (2030), with explicit assumptions about adoption drivers and risk factors at each stage', true);

    -- ========================================
    -- Q22: Discord Market Expansion (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 22,
        'Discord''s Market Redefinition',
        'Discord originally sized its market as "PC gaming communication" (~$2B market). After noticing 30% of communities were non-gaming (study groups, crypto, music fans), Discord redefined its market to "community platforms" (~$15B). What does this shift illustrate about market sizing best practices?',
        'intermediate',
        'Discord',
        'Market redefinition from gaming to general community platform',
        'A',
        'Discord''s evolution illustrates a crucial concept: TAM is not static — it should be revisited as you learn how users actually use your product. When 30% of users were non-gaming, this signaled a much larger addressable market than the original gaming-only sizing. This is a best practice because market sizing should be data-informed and evolve with product-market fit signals. However, the PM should size each segment separately to avoid over-indexing on aspirational markets where adoption is unproven. Option B overcomplicates the situation — Discord isn''t pivoting, it''s expanding. Option C is backwards — the data supports a larger market, not sticking with the smaller one. Option D conflates two separate issues: market sizing methodology and investor communications.',
        ARRAY['adjacent_market', 'market_expansion', 'market_segmentation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'TAM should be re-evaluated as user behavior data reveals that the product serves a broader market than originally scoped', true),
    (v_question_id, 'B', 'Discord should have conducted both a gaming-specific and community-platform sizing from the start to avoid needing to pivot', false),
    (v_question_id, 'C', 'The original $2B gaming communication market is more reliable since it was the product''s core use case', false),
    (v_question_id, 'D', 'Market redefinition from $2B to $15B is primarily a fundraising narrative strategy rather than a genuine sizing exercise', false);

    -- ========================================
    -- Q23: Robinhood Behavioral Segmentation (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 23,
        'Robinhood''s Behavioral Market Segmentation',
        'Robinhood is sizing the market for a new crypto wallet feature. The PM segments by demographics: US adults (258M) → own cryptocurrency (22% = 56.8M) → age 18-40 (68% = 38.6M). A senior PM argues this approach is insufficient. What behavioral segmentation should be added?',
        'intermediate',
        'Robinhood',
        'Crypto wallet behavioral segmentation for market sizing',
        'C',
        'Behavioral segmentation based on transaction patterns is far more informative than demographics for a crypto wallet feature. Users who actively trade or transfer crypto (vs. buy-and-hold investors) are the ones who need a wallet. A 25-year-old who bought $50 of Bitcoin once and hasn''t touched it is demographically "a crypto owner" but behaviorally irrelevant for a wallet product. The key filter is: how many crypto owners actively transact, transfer between wallets, or interact with DeFi protocols? This is likely a small fraction of the 38.6M. Option A adds a useful data point but doesn''t address the behavioral gap. Option B focuses on a competitor rather than the user base. Option D adds psychographic data that doesn''t directly predict wallet usage.',
        ARRAY['market_segmentation', 'addressable_market', 'proxy_metrics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Income segmentation — filter for users with >$10K in investable assets', false),
    (v_question_id, 'B', 'Platform preference — filter for users who already use Robinhood vs. Coinbase', false),
    (v_question_id, 'C', 'Transaction frequency — filter for crypto owners who actively trade or transfer crypto rather than passive buy-and-hold investors', true),
    (v_question_id, 'D', 'Risk tolerance — survey crypto owners on their comfort with self-custody and DeFi products', false);

    -- ========================================
    -- Q24: Calendly Freemium Sizing (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 24,
        'Calendly''s Freemium-to-Paid Market Sizing',
        'Calendly has 20M registered users and wants to size the revenue opportunity for its premium tiers ($10/month individual, $15/user/month team). The PM notes that 92% of users are on the free tier. Industry benchmarks for freemium SaaS show 3-5% paid conversion. The PM estimates: 20M × 4% × $10/month × 12 = $96M. What is the most important missing factor in this analysis?',
        'intermediate',
        'Calendly',
        'Freemium SaaS revenue sizing with team expansion',
        'B',
        'The analysis only accounts for individual paid conversions but misses the most powerful growth lever in freemium SaaS: seat expansion within teams and organizations. When one person on a team upgrades, they often bring 5-20 teammates with them (the "land and expand" motion). This means the revenue per converted user is not $10/month for one seat but potentially $15 × 8 seats = $120/month per converting account. This multiplier can 3-5x the individual conversion estimate. Option A is a valid adjustment but relatively minor compared to the team expansion multiplier. Option C addresses growth but not the current sizing methodology. Option D is about new user acquisition, not about monetizing the existing base.',
        ARRAY['bottom_up_sizing', 'unit_economics', 'penetration_rate']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The 4% conversion rate should be weighted by user activity level — active users convert at higher rates than dormant ones', false),
    (v_question_id, 'B', 'The analysis ignores team seat expansion — each converting user likely brings multiple teammates at the higher $15/user/month team price', true),
    (v_question_id, 'C', 'The 20M registered user base is growing, so the sizing should include projected new user growth', false),
    (v_question_id, 'D', 'The analysis doesn''t account for users who sign up through referral links and have higher conversion rates', false);

    -- ========================================
    -- Q25: Google Maps Monetization (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 25,
        'Google Maps'' Local Advertising Market Sizing',
        'A Google Maps PM is sizing the market for a new local business advertising product. They need to estimate how many small businesses in the US would pay for promoted placement on Google Maps. There are 33M small businesses in the US. The PM proposes using "businesses that currently spend on Google Ads" (5M) as the SAM. Is this the right SAM, and why?',
        'intermediate',
        'Google Maps',
        'Local business advertising product market sizing',
        'C',
        'The PM''s proposed SAM of 5M (existing Google Ads customers) significantly understates the opportunity. The right SAM should include all location-dependent businesses — restaurants, retailers, dentists, salons, etc. — not just those already on Google Ads. Many local businesses don''t advertise on Google Search because the ROI model doesn''t work for them, but a Maps placement (showing up when someone nearby is looking for their category) has a very different value proposition. The PM should segment the 33M businesses by those with physical locations that serve local customers (~20M), which is the more accurate SAM. Option A is wrong because it''s too restrictive. Option B overcounts by including online-only and B2B businesses. Option D mistakes the SAM for the SOM.',
        ARRAY['serviceable_market', 'market_segmentation', 'tam_sam_som']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Yes — businesses already spending on Google Ads have proven willingness to pay for digital advertising', false),
    (v_question_id, 'B', 'No — the SAM should be all 33M small businesses since any business could benefit from Maps visibility', false),
    (v_question_id, 'C', 'No — the SAM should be all location-dependent businesses with physical storefronts serving local customers (~20M), as Maps ads appeal beyond existing Google Ads customers', true),
    (v_question_id, 'D', 'No — the 5M figure is the SOM, not SAM; the SAM should be all businesses that have a Google Business Profile', false);

    -- ========================================
    -- Q26: Loom Market Sizing via Proxy (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 26,
        'Loom''s Async Video Communication Market',
        'Loom (async video messaging for work) is sizing a market that barely existed 5 years ago — "async video communication." No industry analysts cover this category. The PM needs to estimate TAM using proxy markets. Which combination of proxies best estimates Loom''s addressable market?',
        'intermediate',
        'Loom',
        'Sizing a new category using proxy market data',
        'D',
        'For truly new categories, the best sizing approach combines multiple proxy markets that represent the behaviors your product replaces. Loom replaces three specific workflows: (1) meetings that could have been async messages, (2) long email explanations that a quick video would improve, and (3) written documentation with walkthroughs. By estimating the time/cost of these incumbent workflows and the % convertible to async video, you get a bottom-up TAM grounded in real pain points. Option A uses a single proxy that''s too narrow. Option B is too broad — most enterprise video spending is on live conferencing, not async. Option C uses a demographic proxy without connecting to the behavior Loom replaces.',
        ARRAY['proxy_metrics', 'fermi_estimation', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The screen recording software market ($1.8B) as the closest existing category', false),
    (v_question_id, 'B', 'The total enterprise video communications market ($25B) filtered by the async percentage', false),
    (v_question_id, 'C', 'Number of knowledge workers globally × average willingness to pay for productivity tools', false),
    (v_question_id, 'D', 'A blend of proxies: unnecessary meetings replaced by video messages + email threads better served by video + training documentation workflows, weighted by conversion likelihood', true);

    -- ========================================
    -- Q27: Coinbase Double Counting (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 27,
        'Coinbase''s Double-Counting Pitfall',
        'Coinbase is sizing its market and calculates: US crypto trading volume = $1.5T/year. Coinbase charges ~1.5% per transaction. Revenue TAM = $1.5T × 1.5% = $22.5B. However, this figure has a significant double-counting problem. What is it?',
        'intermediate',
        'Coinbase',
        'Transaction volume double counting in crypto exchange sizing',
        'A',
        'Trading volume inherently double-counts because every trade has a buyer and a seller. When someone buys $1,000 of Bitcoin on Coinbase, that transaction generates $1,000 in buy volume and (on the other side) $1,000 in sell volume, but it''s one economic event. Additionally, crypto markets have significant wash trading and arbitrage volume that inflates reported figures. High-frequency traders may trade the same dollar many times per day, inflating volume without representing genuine economic activity. The PM should adjust by dividing volume by 2 (for buy/sell double counting) and applying a discount for non-organic trading activity. Option B raises a valid concern about competition but doesn''t address the double-counting issue. Option C is incorrect — the take rate is an input, not the flaw. Option D misidentifies where double counting occurs.',
        ARRAY['addressable_market', 'unit_economics', 'market_opportunity']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Trading volume counts both buy and sell sides of each transaction, and includes wash trading and arbitrage — the actual economic activity is significantly less than $1.5T', true),
    (v_question_id, 'B', 'Coinbase can''t capture the entire $1.5T because decentralized exchanges (DEXs) are taking market share', false),
    (v_question_id, 'C', 'The 1.5% fee assumption is too high — competitive pressure from Binance will compress fees to 0.5%', false),
    (v_question_id, 'D', 'The $1.5T includes both spot trading and derivatives, which serve different customer segments and shouldn''t be summed', false);

    -- ========================================
    -- Q28: Waymo Autonomous Ride Market (Intermediate)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 28,
        'Waymo''s Autonomous Ride-Hailing Market Sizing',
        'Waymo is sizing the autonomous ride-hailing market. One approach: take the existing ride-hailing market ($100B globally) and assume autonomous vehicles replace all human drivers. A strategy lead argues this understates the TAM. What is the strongest argument for a larger market than $100B?',
        'intermediate',
        'Waymo',
        'Autonomous ride-hailing market expansion beyond existing ride-hailing',
        'B',
        'This illustrates a critical market sizing concept: technology disruptions often expand markets rather than just redistributing existing share. Autonomous vehicles would dramatically reduce the cost per mile (no driver = ~60% cost reduction), which would unlock trips that are currently too expensive via ride-hailing — daily commutes, children''s activities, elderly transportation, and rural routes. These use cases represent latent demand that doesn''t exist in today''s $100B market. Historically, technology-driven price drops have expanded markets by 2-5x (consider how smartphones expanded the camera market beyond dedicated cameras). Option A adds relevant spending but doesn''t capture market expansion from new use cases. Option C overestimates by including freight, which is a fundamentally different service. Option D adds value but doesn''t explain why the base ride-hailing TAM itself would grow.',
        ARRAY['market_expansion', 'market_opportunity', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'It should include car ownership costs ($2T+) since autonomous taxis would replace personal vehicles', false),
    (v_question_id, 'B', 'Lower cost per mile from removing the driver would unlock new use cases (daily commutes, children''s transport, elderly mobility) that are currently uneconomical via ride-hailing, expanding the TAM beyond existing ride-hailing', true),
    (v_question_id, 'C', 'Autonomous vehicles could also serve goods delivery and freight, making the TAM the entire transportation and logistics market ($7T)', false),
    (v_question_id, 'D', 'Autonomous ride-hailing would integrate with public transit to provide first/last-mile connections, adding public transit budgets to the TAM', false);

    -- ========================================
    -- Q29: Bumble Two-Sided Market (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 29,
        'Bumble''s Two-Sided Market Sizing Challenge',
        'Bumble (dating app) is sizing the market for a new "Bumble BFF" feature (friend-matching for new-in-town professionals). The PM estimates: 45M single professionals relocate annually in the US. 30% express loneliness post-move. 40% would use an app for friend-finding. Willingness to pay: $9.99/month. The PM calculates: 45M × 30% × 40% × $9.99 × 12 = $647M. What critical aspect of two-sided market sizing does this analysis miss?',
        'advanced',
        'Bumble',
        'Two-sided friend-matching market with network density constraints',
        'B',
        'Two-sided markets have a unique sizing constraint: both sides must exist in sufficient density for the product to deliver value. Unlike a marketplace with buyers and sellers, Bumble BFF requires a critical mass of people seeking friends in the same geographic area AND similar demographics (age, interests) for matches to be meaningful. In smaller cities, there may be too few active users to produce good matches, making the product worthless despite demand existing. This means the SAM is limited to metro areas where user density exceeds the minimum viable threshold — potentially reducing the addressable market by 40-60%. Option A is a valid concern but secondary. Option C describes a churn problem, not a sizing methodology gap. Option D is a go-to-market question, not a market sizing constraint.',
        ARRAY['market_segmentation', 'addressable_market', 'penetration_rate']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The analysis assumes a monthly subscription model, but users finding friends successfully would churn — retention may be very low', false),
    (v_question_id, 'B', 'Two-sided markets require geographic density — in smaller cities, there won''t be enough concurrent users seeking friends to create quality matches, reducing the serviceable market significantly', true),
    (v_question_id, 'C', 'The product has a "success problem" — users who find friends stop paying, meaning the 12-month revenue assumption is wrong', false),
    (v_question_id, 'D', 'The analysis doesn''t account for Bumble''s ability to cross-promote BFF to its existing dating user base, which could increase adoption', false);

    -- ========================================
    -- Q30: Amazon Pharmacy Multi-Constraint (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 30,
        'Amazon Pharmacy''s Constrained Market Sizing',
        'Amazon Pharmacy is sizing the US prescription drug delivery market. Data: US prescription drug market = $550B. Online pharmacy penetration = 8% ($44B). Amazon''s competitive advantages: Prime membership (200M members), existing logistics network. A PM sizes the opportunity as $44B × Amazon''s projected 25% share = $11B. However, multiple structural constraints limit this. Which combination of constraints is most critical to model?',
        'advanced',
        'Amazon',
        'Prescription drug delivery with regulatory and behavioral constraints',
        'D',
        'Pharmacy market sizing requires modeling multiple overlapping constraints that dramatically reduce the addressable market. PBM (Pharmacy Benefit Manager) contracts are the biggest structural barrier — most insured Americans must use pharmacies within their PBM network, and PBMs like CVS Caremark and Express Scripts have exclusive arrangements. Insurance formulary restrictions determine which drugs are covered where. State-by-state licensing means Amazon can''t immediately serve all states. Controlled substance restrictions eliminate high-value prescriptions (opioids, stimulants) from delivery. Finally, many patients (especially elderly) prefer in-person pharmacist relationships. Each constraint operates independently, and their cumulative effect can reduce the addressable market by 60-80%. Option A addresses only the behavioral segment. Option B focuses on one product category. Option C captures only the competitive dimension.',
        ARRAY['market_opportunity', 'serviceable_market', 'market_segmentation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Customer preference — only 15% of Americans are willing to receive prescriptions by mail vs. picking up in-person', false),
    (v_question_id, 'B', 'Product limitation — specialty drugs and biologics require cold chain logistics that Amazon can''t easily replicate', false),
    (v_question_id, 'C', 'Competitive lock-in — CVS/Walgreens have billions invested in locations and will match on delivery', false),
    (v_question_id, 'D', 'PBM network exclusions, insurance formulary restrictions, state licensing requirements, controlled substance regulations, and patient preference for in-person pharmacist relationships — each independently reduces the serviceable market', true);

    -- ========================================
    -- Q31: OpenAI API Market with Platform (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 31,
        'OpenAI''s API Platform Market Sizing',
        'An OpenAI PM is sizing the market for GPT API in enterprise applications. Approach 1 (top-down): Global enterprise software market ($600B) × % that will integrate AI ($25% by 2028) = $150B AI integration market × OpenAI''s share (20%) = $30B. Approach 2 (bottom-up): 500K developer teams × average annual API spend ($15K) × growth multiplier (3x in 5 years) = $22.5B. The estimates differ by 33%. What does this divergence likely indicate?',
        'advanced',
        'OpenAI',
        'Enterprise AI API market sizing with divergent estimates',
        'C',
        'When two independently derived estimates differ by less than an order of magnitude (here, 33% apart), that''s actually strong convergence in market sizing — it suggests the order of magnitude ($20-30B) is likely correct. The specific divergence likely indicates different time horizons and growth assumptions: the top-down includes projected market expansion through 2028, while the bottom-up is grounded in today''s developer base with a growth multiplier. The PM should investigate which assumptions drive the gap and present a range ($22-30B) with scenarios. Option A is incorrect — a 33% gap is acceptable in market sizing. Option B reverses the typical pattern; bottom-up estimates tend to be more conservative. Option D is incorrect because both estimates use different but valid methodologies; neither has a structural flaw large enough to explain the gap.',
        ARRAY['top_down_sizing', 'bottom_up_sizing', 'market_validation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The 33% gap means at least one estimate is fundamentally flawed and should be discarded', false),
    (v_question_id, 'B', 'The bottom-up estimate is likely more accurate because it uses real developer data, so the top-down should be adjusted down', false),
    (v_question_id, 'C', 'The convergence within the same order of magnitude is a positive signal; the gap likely reflects different time horizons and growth assumptions that should be investigated and presented as a range', true),
    (v_question_id, 'D', 'The top-down 25% AI integration rate is speculative, making the entire top-down estimate unreliable', false);

    -- ========================================
    -- Q32: Doordash Multi-Sided Marketplace (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 32,
        'DoorDash''s Three-Sided Marketplace Sizing',
        'DoorDash operates a three-sided marketplace: consumers, restaurants, and dashers (drivers). A PM sizes the market from the consumer side only: US food delivery demand = $65B GMV. However, the CFO asks: "What constrains our actual serviceable market?" In a three-sided marketplace, which side creates the binding constraint on market size, and why?',
        'advanced',
        'DoorDash',
        'Three-sided marketplace binding constraint analysis',
        'C',
        'In multi-sided marketplaces, the binding constraint is the side that is hardest to scale and has the least elastic supply. For DoorDash, dasher supply is the binding constraint in most markets. During peak hours (dinner time, bad weather), dasher availability determines how many orders can be fulfilled. Even if 100 consumers want to order and 50 restaurants are available, only as many orders as there are dashers can be completed. This creates a supply-side ceiling that''s invisible in consumer-demand-based market sizing. The PM must model: peak-hour dasher availability × orders per dasher per hour × average order value = actual serviceable capacity. If this is lower than consumer demand, the market size is effectively capped by dasher supply. Option A ignores that restaurant onboarding is relatively straightforward. Option B describes a partial constraint but restaurants can increase capacity. Option D is a financial constraint, not a marketplace dynamics constraint.',
        ARRAY['market_opportunity', 'serviceable_market', 'market_segmentation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The restaurant side — only restaurants on the platform can serve orders, and restaurant onboarding is slow', false),
    (v_question_id, 'B', 'The restaurant side — kitchen capacity during peak hours limits the number of delivery orders a restaurant can handle', false),
    (v_question_id, 'C', 'The dasher (driver) side — peak-hour driver availability caps the number of orders that can be fulfilled, creating a supply-side ceiling on serviceable market', true),
    (v_question_id, 'D', 'The consumer side — customer acquisition cost makes some geographic areas unprofitable to serve', false);

    -- ========================================
    -- Q33: Apple Vision Pro (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 33,
        'Apple Vision Pro''s Category-Creation Sizing',
        'Apple launches Vision Pro (spatial computing headset) at $3,499. There is no existing "spatial computing" market to size. The PM has: VR headset market ($12B), AR enterprise market ($8B), premium laptop market ($45B for >$1500 devices), and home theater market ($20B). How should the PM approach sizing a market for a product that creates a new category?',
        'advanced',
        'Apple',
        'New category market sizing for spatial computing',
        'D',
        'Category-creating products cannot be sized by simply picking the closest existing market — they often cannibalize portions of multiple adjacent markets while also creating entirely new use cases. The right approach identifies which specific use cases Vision Pro serves (replacing a monitor for knowledge workers, immersive entertainment, 3D design, virtual collaboration), sizes each use case from its relevant incumbent market, and adds an estimate for net-new use cases that didn''t exist before. For example: 5% of premium laptop users replacing a monitor ($2.25B) + 3% of home theater enthusiasts ($600M) + enterprise 3D design ($400M) + net-new spatial computing use cases (highly uncertain, but $1-3B). This yields a $4-6B TAM that''s grounded in behavioral substitution. Option A cherry-picks the largest adjacent market. Option B sums markets without considering overlap. Option C is too conservative for strategic planning.',
        ARRAY['adjacent_market', 'market_expansion', 'fermi_estimation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Use the premium laptop market ($45B) since Vision Pro primarily replaces laptop screens for knowledge workers', false),
    (v_question_id, 'B', 'Sum VR + AR + premium laptop + home theater markets ($85B) since Vision Pro spans all these categories', false),
    (v_question_id, 'C', 'Use the VR headset market ($12B) as the starting point since Vision Pro is fundamentally a headset', false),
    (v_question_id, 'D', 'Decompose by use case: size each use case from its relevant incumbent market (% of laptop users replacing monitors, % of entertainment spending, etc.) and add estimated net-new use cases', true);

    -- ========================================
    -- Q34: Stripe Atlas International (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 34,
        'Stripe Atlas'' Cross-Border Market Sizing',
        'Stripe Atlas helps international entrepreneurs incorporate US businesses remotely ($500 one-time + Stripe payment processing). A PM sizes the market: 300M people in emerging markets consider themselves entrepreneurs, 15% want to sell to US customers, 10% of those would incorporate a US entity. TAM = 300M × 15% × 10% = 4.5M potential customers × $500 = $2.25B. An experienced market analyst flags three compounding errors. What is the most fundamental error?',
        'advanced',
        'Stripe Atlas',
        'Cross-border SaaS market sizing with compounding assumption errors',
        'B',
        'The fundamental error is using "consider themselves entrepreneurs" as the base population. This self-identification metric includes people with side hustles, aspiring entrepreneurs who haven''t started, and micro-businesses that will never need a US entity. The PM should start with a much more qualified base: entrepreneurs in emerging markets who already have revenue from US/international customers, or who have products/services suitable for US markets. This might be 5-10M, not 300M. Then the 15% and 10% filters would yield vastly different (and more honest) numbers. Additionally, the $500 one-time fee undervalues the LTV — the real revenue comes from payment processing, but even that requires the business to generate meaningful US revenue. Option A addresses a secondary concern. Option C misidentifies the issue. Option D raises a valid but less fundamental point.',
        ARRAY['fermi_estimation', 'market_segmentation', 'addressable_market']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The $500 one-time fee understates the LTV — the real opportunity is in ongoing payment processing revenue', false),
    (v_question_id, 'B', 'The 300M base is inflated — "self-identified entrepreneurs" includes aspiring and micro-entrepreneurs who would never need or qualify for US incorporation, overstating the addressable population by 10-50x', true),
    (v_question_id, 'C', 'The 15% "want to sell to US" filter is too low — with global e-commerce, most entrepreneurs would want US market access', false),
    (v_question_id, 'D', 'The analysis ignores that many emerging-market entrepreneurs can''t pass US banking compliance requirements (KYC/AML), reducing the serviceable population', false);

    -- ========================================
    -- Q35: Meta Metaverse Scenario-Based (Advanced)
    -- ========================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 35,
        'Meta''s Scenario-Based Metaverse Sizing',
        'Meta (formerly Facebook) committed $10B+/year to metaverse development. The PM team produced three market estimates: Bear case: $50B (VR gaming + fitness only), Base case: $300B (adds virtual workspaces, social, education), Bull case: $1.5T (adds virtual commerce, real estate, advertising replacing physical equivalents). Leadership asks: "Which number should we use for resource allocation?" The market is 7-10 years from maturity. What is the correct approach to using these scenarios for strategic decision-making?',
        'advanced',
        'Meta',
        'Scenario-based market sizing for long-horizon strategic bets',
        'C',
        'For long-horizon, high-uncertainty strategic bets, the correct approach is to ensure the investment is justifiable even in the bear case. If $10B/year cannot generate acceptable returns in a $50B market (where Meta might capture 15-20% = $7.5-10B revenue), the bet is too risky. Using the base or bull case for resource allocation creates a dangerous dependency on optimistic assumptions. The probability-weighted average (Option A) creates false precision — assigning 20%/50%/30% probabilities to scenarios 7+ years out is guesswork dressed as analysis. Using the bull case (Option B) is how companies destroy shareholder value. Using the base case but planning for the bear (Option D) is better but still risks over-committing if the base case doesn''t materialize. The bear-case-first approach forces intellectual honesty: if the investment doesn''t work in the downside scenario, it shouldn''t be made regardless of how attractive the upside appears.',
        ARRAY['market_opportunity', 'growth_rate_estimation', 'market_validation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Use a probability-weighted average: (20% × $50B) + (50% × $300B) + (30% × $1.5T) = $610B as the expected TAM', false),
    (v_question_id, 'B', 'Use the bull case ($1.5T) since the investment is only justified if the metaverse achieves its full potential', false),
    (v_question_id, 'C', 'Ensure the investment is defensible even in the bear case ($50B) — if $10B+/year can''t generate returns in the downside scenario, the bet is too risky regardless of upside', true),
    (v_question_id, 'D', 'Use the base case ($300B) for planning but build contingency plans that scale down if the market tracks toward the bear case', false);

END $$;
