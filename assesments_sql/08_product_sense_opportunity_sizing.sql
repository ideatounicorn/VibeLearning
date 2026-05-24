-- ============================================
-- QUESTION BANK: Product Sense → Opportunity Sizing
-- Sub-skill slug: opportunity-sizing
-- Total questions: 35
-- Difficulty mix: 10 foundational, 18 intermediate, 7 advanced
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_question_id UUID;
BEGIN
    -- Look up sub_skill_id
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'opportunity-sizing'
      AND category_id = (SELECT id FROM categories WHERE slug = 'product-sense');

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill "opportunity-sizing" not found under "product-sense"';
    END IF;

    -- ============================================
    -- QUESTION 1 (foundational) — DoorDash
    -- Topic: Feature-level impact estimation (conversion lift × funnel volume × revenue)
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 1,
        'Estimating Revenue Impact of a Tipping Prompt Redesign',
        'DoorDash is redesigning its post-checkout tipping prompt to increase average tip size. The current flow generates $2.50 average tip per order. The PM estimates the redesigned prompt will increase average tips by 15%. DoorDash processes 4 million orders per day and takes a 10% platform fee on tips. How should the PM estimate the incremental annual revenue from this change?',
        'foundational',
        'DoorDash',
        'Post-checkout tipping UX redesign for driver tips',
        'B',
        'The correct approach is to calculate the incremental tip per order ($2.50 × 15% = $0.375), multiply by daily order volume (4M), apply the platform fee (10%), and annualize. That gives $0.375 × 4,000,000 × 0.10 × 365 = ~$54.75M annually. Option A incorrectly applies the 15% lift to total revenue rather than the tip increment. Option C forgets to apply the platform fee percentage, sizing the opportunity at 10× its actual value. Option D uses monthly instead of daily volume, drastically undersizing the opportunity. The key insight is that in marketplace businesses, the platform''s revenue share determines how much of the gross transaction value flows to the company.',
        ARRAY['impact_estimation', 'revenue_modeling', 'incremental_revenue']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 1;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', '15% × total daily GMV × 365 = the annual revenue uplift', false),
        (v_question_id, 'B', '($2.50 × 15%) × 4M orders/day × 10% platform fee × 365 days ≈ $54.75M/year', true),
        (v_question_id, 'C', '($2.50 × 15%) × 4M orders/day × 365 days ≈ $547.5M/year, without applying the take rate', false),
        (v_question_id, 'D', '($2.50 × 15%) × 4M orders/month × 10% platform fee × 12 months ≈ $1.8M/year', false);

    -- ============================================
    -- QUESTION 2 (foundational) — Spotify
    -- Topic: Sizing non-revenue opportunities (engagement/retention impact)
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 2,
        'Sizing the Retention Impact of Spotify''s Podcast Integration',
        'Spotify''s PM is sizing the opportunity for deeper podcast integration into music playlists. Internal data shows that users who listen to both music and podcasts have a 30-day retention rate of 85%, compared to 72% for music-only users. There are 200M music-only MAUs. The PM assumes the feature will convert 5% of music-only users to dual-format listeners. What is the MOST important consideration when sizing this opportunity?',
        'foundational',
        'Spotify',
        'Cross-format content integration to improve retention',
        'C',
        'The most important consideration is whether the higher retention among podcast+music users is causal or merely correlational. Users who organically listen to both formats may simply be more engaged overall — they were going to retain regardless. If the correlation is not causal, converting music-only users to dual listeners may not produce the expected 13-percentage-point retention lift. Options A and B are valid secondary calculations but meaningless if the underlying causal assumption is wrong. Option D addresses scale but not the fundamental validity of the sizing. This is one of the most common mistakes in opportunity sizing: treating observational correlations as causal effects.',
        ARRAY['sizing_assumptions', 'impact_estimation', 'cannibalization_risk']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 2;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Calculate (200M × 5%) × ($4.99 ARPU) to estimate the revenue impact of retained users', false),
        (v_question_id, 'B', 'Multiply the 13-percentage-point retention lift by the 10M converted users to get incremental retained MAUs', false),
        (v_question_id, 'C', 'Determine whether the retention difference is causal or driven by selection bias in users who already prefer both formats', true),
        (v_question_id, 'D', 'Focus on whether 5% conversion is achievable given current podcast discovery UX', false);

    -- ============================================
    -- QUESTION 3 (foundational) — Netflix
    -- Topic: Cost-benefit analysis framework
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 3,
        'Cost-Benefit Analysis for Netflix''s Download-for-Offline Feature',
        'Netflix is evaluating expanding its download-for-offline feature to include entire seasons with one tap. Engineering estimates 3 months of work (team of 8 engineers, $200K/engineer/year fully loaded). The PM projects a 2% reduction in monthly churn among the 15M subscribers who travel frequently, at an average revenue of $15/month. Which cost-benefit framework component is the PM MOST likely underestimating?',
        'foundational',
        'Netflix',
        'Expanding offline download capability for season bundles',
        'D',
        'The PM is most likely underestimating the ongoing infrastructure and CDN costs. Enabling one-tap season downloads means users will download significantly more content, increasing storage on devices and — more critically — increasing Netflix''s CDN bandwidth costs. These are recurring costs that grow with adoption, not one-time engineering costs. Option A (engineering cost) is already quantified. Option B (revenue from churn reduction) is a valid projection. Option C (opportunity cost) is important but secondary to the ongoing cost that could erode the entire business case. In opportunity sizing, PMs frequently account for build costs but miss the variable ongoing costs that scale with usage.',
        ARRAY['cost_benefit_analysis', 'business_case', 'sizing_assumptions']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 3;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'The engineering build cost — 8 engineers × 3 months at $200K/year is roughly $400K, which may be underscoped', false),
        (v_question_id, 'B', 'The revenue uplift — 2% churn reduction on 15M travelers at $15/mo is $54M annually, which seems too optimistic', false),
        (v_question_id, 'C', 'The opportunity cost of not building other features during the 3-month engineering allocation', false),
        (v_question_id, 'D', 'The ongoing CDN and infrastructure costs that scale as millions of users download entire seasons, not just individual episodes', true);

    -- ============================================
    -- QUESTION 4 (intermediate) — Uber
    -- Topic: Revenue modeling (direct, indirect, cannibalization)
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 4,
        'Revenue Cannibalization in Uber''s Shuttle Launch',
        'Uber is launching a fixed-route "Uber Shuttle" in major metros at $3-5 per ride. The PM projects 500K daily rides within 6 months. Current data shows 30% of shuttle riders would have taken UberX (average fare $18, Uber take rate 25%) and 70% are new riders or switchers from public transit. What is the net daily revenue impact, accounting for cannibalization?',
        'intermediate',
        'Uber',
        'Fixed-route shuttle service launch in metropolitan areas',
        'C',
        'To calculate net revenue impact, we must account for both the new revenue from shuttle rides and the lost revenue from cannibalized UberX rides. New shuttle revenue: 500K rides × $4 average fare × 25% take rate = $500K/day. However, 30% of riders (150K) would have taken UberX at $18 × 25% = $4.50 per ride, generating $675K in revenue. The cannibalized revenue loss is $675K - (150K × $4 × 0.25) = $675K - $150K = $525K. Net impact = $500K new shuttle revenue - $525K cannibalization loss = -$25K/day. The shuttle actually destroys net revenue at these assumptions. Option A ignores cannibalization entirely. Option B only counts new riders. Option D miscalculates by applying cannibalization to gross fares rather than Uber''s take rate. This is why cannibalization analysis is critical — a product that looks great on gross metrics can destroy company revenue.',
        ARRAY['revenue_modeling', 'cannibalization_risk', 'impact_estimation']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 4;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Positive: 500K × $4 × 25% = $500K/day in new revenue, since shuttle is an incremental product line', false),
        (v_question_id, 'B', 'Positive: 350K new rides × $4 × 25% = $350K/day, counting only non-cannibalized riders', false),
        (v_question_id, 'C', 'Slightly negative: ~-$25K/day, because cannibalized UberX revenue ($675K) exceeds total shuttle revenue ($500K) when accounting for the take-rate differential', true),
        (v_question_id, 'D', 'Negative: -$1.2M/day, because 150K cannibalized rides lose $18 each in gross fare', false);

    -- ============================================
    -- QUESTION 5 (intermediate) — Airbnb
    -- Topic: ROI calculation for product initiatives
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 5,
        'ROI Calculation for Airbnb''s Verified Photos Program',
        'Airbnb is expanding its professional photography program to cover 500K more listings. Cost: $150 per listing for photography. Historical data shows professionally photographed listings earn 24% more bookings, with an average booking value of $180 and Airbnb''s service fee at 14%. Average listing gets 15 bookings/year. What is the 1-year ROI of this program?',
        'intermediate',
        'Airbnb',
        'Professional photography expansion for host listings',
        'B',
        'First, calculate the investment: 500K listings × $150 = $75M. Then calculate incremental revenue: each listing gets 15 bookings/year, and professional photos increase this by 24%, so incremental bookings = 15 × 0.24 = 3.6 per listing. Incremental revenue per listing = 3.6 × $180 × 14% = $90.72. Total incremental revenue = 500K × $90.72 = $45.36M. ROI = ($45.36M - $75M) / $75M = -39.5%. The program actually has negative year-1 ROI. However, the photos persist for multiple years, so the multi-year ROI would be positive (year 2 adds another $45.36M with no additional cost). Option A incorrectly applies the 24% lift to total revenue rather than incremental bookings. Option C forgets to apply the service fee rate. Option D calculates ROI correctly but uses wrong booking math. The lesson: some investments require multi-year payback analysis, not single-year ROI.',
        ARRAY['roi_calculation', 'business_case', 'payback_period']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 5;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Positive ROI of ~120%: 500K × 15 bookings × $180 × 24% × 14% ÷ $75M', false),
        (v_question_id, 'B', 'Negative year-1 ROI of ~-40%: incremental Airbnb revenue is ~$45M vs. $75M investment, but becomes positive in year 2 since photos are durable assets', true),
        (v_question_id, 'C', 'Positive ROI of ~224%: 500K × 3.6 incremental bookings × $180 ÷ $75M, without applying the take rate', false),
        (v_question_id, 'D', 'Negative ROI of ~-80%: the 24% lift applies only to click-through, not to completed bookings', false);

    -- ============================================
    -- QUESTION 6 (foundational) — LinkedIn
    -- Topic: Building business cases for stakeholder buy-in
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 6,
        'Building a Business Case for LinkedIn Premium Company Pages',
        'LinkedIn''s PM wants to propose "Premium Company Pages" — enhanced analytics and branding tools for company profiles at $500/month. There are 58M company pages on LinkedIn, but initial research suggests only Fortune 5000 companies and well-funded startups would pay. The PM needs to present a business case to the VP. What is the BEST way to structure the opportunity sizing for stakeholder buy-in?',
        'foundational',
        'LinkedIn',
        'Monetizing company pages with premium features',
        'A',
        'The best approach is a bottom-up analysis starting with the realistic addressable segment. Starting with 58M total company pages is misleading because 99%+ are SMBs or inactive. A credible business case starts with the realistic buyer segment (Fortune 5000 + funded startups ≈ ~50K-100K companies), applies a realistic adoption curve (maybe 5-15% in year 1), and layers in pricing assumptions. This bottom-up approach is more credible with executives than a top-down TAM that requires tiny penetration rates. Option B uses the top-down approach, which would claim "$348B TAM" that no executive would find credible. Option C focuses only on competitive positioning without sizing. Option D anchors on comparable product pricing but skips the volume estimation entirely.',
        ARRAY['business_case', 'sizing_assumptions', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 6;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Bottom-up: identify the realistic buyer segment (~50-100K companies), estimate adoption rate by year, project revenue as segment × adoption × price × retention', true),
        (v_question_id, 'B', 'Top-down: 58M company pages × $500/month × 12 months = $348B TAM, then apply a 0.1% penetration rate', false),
        (v_question_id, 'C', 'Competitive benchmark: show that competitors charge similar amounts and argue LinkedIn should match', false),
        (v_question_id, 'D', 'Feature comparison: list all premium features and assign dollar values to each, summing to justify the $500 price point', false);

    -- ============================================
    -- QUESTION 7 (intermediate) — Slack
    -- Topic: Opportunity cost — building Feature A vs Feature B
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 7,
        'Opportunity Cost Analysis for Slack''s Engineering Resources',
        'Slack''s PM has two proposals competing for the same 6-person engineering team for Q3. Feature A: AI-powered channel summarization (projected to reduce churn by 0.5% among enterprise customers, 80K enterprise accounts at $15K ARR). Feature B: Workflow Builder v2 (projected to increase upsell from Pro to Enterprise for 3% of 200K Pro accounts at $8K ARR uplift). Both take one quarter to build. What is the opportunity cost framework the PM should apply?',
        'intermediate',
        'Slack',
        'Resource allocation between AI summarization and Workflow Builder features',
        'D',
        'The correct framework compares the expected value of each option and recognizes that the opportunity cost of choosing one is the forgone value of the other. Feature A: 0.5% churn reduction × 80K accounts × $15K = $6M in saved ARR. Feature B: 3% conversion × 200K accounts × $8K = $48M in new ARR. At face value, Feature B appears 8× more valuable. However, a rigorous analysis must also consider confidence levels in each estimate, time-to-impact, strategic alignment, and reversibility. Option A only looks at revenue without comparing. Option B ignores Feature A entirely. Option C focuses on cost rather than value. The key insight is that opportunity cost is not just about what you build — it''s about the best alternative you forgo.',
        ARRAY['opportunity_cost', 'resource_allocation', 'impact_estimation', 'business_case']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 7;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Calculate Feature A''s ROI independently and approve if positive, regardless of Feature B', false),
        (v_question_id, 'B', 'Default to Feature B since new revenue is always more valuable than preventing churn', false),
        (v_question_id, 'C', 'Choose whichever feature costs less to build, since both have positive expected value', false),
        (v_question_id, 'D', 'Compare expected incremental ARR of both ($6M saved vs. $48M new), then adjust for confidence intervals, time-to-impact, and strategic fit to determine the true opportunity cost', true);

    -- ============================================
    -- QUESTION 8 (intermediate) — Stripe
    -- Topic: Sensitivity analysis — which assumptions matter most
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 8,
        'Sensitivity Analysis for Stripe''s Invoice Financing Feature',
        'Stripe is considering an invoice financing product where merchants can get 90% of invoice value immediately (Stripe earns a 3% fee). The PM''s model projects $500M annual revenue based on: (1) 2M eligible merchants, (2) 15% adoption rate, (3) $50K average annual invoice volume per merchant, and (4) 3% fee rate. The PM wants to run a sensitivity analysis. Which assumption, if off by 50%, would have the LARGEST impact on projected revenue?',
        'intermediate',
        'Stripe',
        'Invoice financing product for merchants on Stripe platform',
        'B',
        'Let''s check the math: Revenue = 2M × 15% × $50K × 3% = 2M × 0.15 × 50K × 0.03 = $450M (close to the $500M projection). Each variable has a linear, multiplicative relationship. If any single variable moves by 50%, revenue moves by 50% — from a purely mathematical standpoint, they''re equivalent. However, the question is about which assumption is most likely to be wrong by 50% and in practice, adoption rate assumptions for new financial products are notoriously unreliable. The 15% adoption rate is the least validated and most volatile assumption. Eligible merchant count is observable from data. Invoice volume is measurable from existing merchant behavior. Fee rate is a business decision. Adoption rate is a pure forecast with the widest confidence interval, making it the most critical sensitivity variable. True sensitivity analysis considers both the mathematical impact AND the uncertainty range of each input.',
        ARRAY['sensitivity_analysis', 'sizing_assumptions', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 8;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Eligible merchants (2M): because it''s the largest number in the model and small changes compound', false),
        (v_question_id, 'B', 'Adoption rate (15%): because it''s the least validated assumption with the widest confidence interval, and it''s equally multiplicative as other inputs', true),
        (v_question_id, 'C', 'Average invoice volume ($50K): because revenue is directly proportional to volume and merchants vary widely', false),
        (v_question_id, 'D', 'Fee rate (3%): because competitor pressure could force rates down, making it the most externally vulnerable assumption', false);

    -- ============================================
    -- QUESTION 9 (advanced) — Amazon
    -- Topic: NPV and payback period for longer-term investments
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 9,
        'NPV Analysis for Amazon''s Drone Delivery Investment',
        'Amazon is evaluating a $2B investment in drone delivery infrastructure. The projected cash flows are: Year 1: -$500M (additional build-out), Year 2: +$200M, Year 3: +$600M, Year 4: +$900M, Year 5: +$1.2B. The discount rate is 12%. The simple payback period is between Year 3 and Year 4. What does an NPV analysis reveal that simple payback does NOT?',
        'advanced',
        'Amazon',
        'Drone delivery infrastructure investment decision',
        'C',
        'NPV (Net Present Value) accounts for the time value of money — a dollar earned in Year 5 is worth less than a dollar today. Using a 12% discount rate, the Year 5 cash flow of $1.2B is only worth about $681M in today''s dollars. The NPV calculation would be: -$2B - $500M/1.12 + $200M/1.12² + $600M/1.12³ + $900M/1.12⁴ + $1.2B/1.12⁵ ≈ -$2B - $446M + $159M + $427M + $572M + $681M = -$607M. The project has a negative NPV at 12% discount rate despite appearing to "pay back" by Year 4 in nominal terms. Option A describes IRR, not NPV. Option B describes risk analysis, not NPV. Option D is partially correct but misses the core insight that NPV can completely flip the investment decision from "go" to "no-go." The lesson: payback period ignores the cost of capital, which can make a seemingly profitable investment value-destroying.',
        ARRAY['npv_analysis', 'payback_period', 'business_case', 'cost_benefit_analysis']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 9;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'NPV calculates the internal rate of return, showing the minimum revenue needed for profitability', false),
        (v_question_id, 'B', 'NPV assesses the probability-weighted risk of each cash flow estimate being wrong', false),
        (v_question_id, 'C', 'NPV reveals that when future cash flows are discounted to present value, the project may actually be value-destroying despite positive nominal returns and a reasonable payback period', true),
        (v_question_id, 'D', 'NPV simply adjusts for inflation, showing that $1.2B in Year 5 buys less than $1.2B today', false);

    -- ============================================
    -- QUESTION 10 (foundational) — Instagram
    -- Topic: Incremental vs. absolute impact estimation
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 10,
        'Incremental vs. Absolute Impact for Instagram Shopping',
        'Instagram is launching in-app checkout for Shopping posts. The PM reports: "Shopping posts already generate $8B in GMV through outbound links. Our in-app checkout will capture 14% service fee on all transactions, generating $1.12B in new revenue." What is the fundamental flaw in this opportunity sizing?',
        'foundational',
        'Instagram',
        'In-app checkout feature for Instagram Shopping',
        'B',
        'The PM is treating the entire $8B GMV as if it wouldn''t exist without in-app checkout — but those transactions are already happening via outbound links. The in-app checkout doesn''t create $8B in new commerce; it merely changes the transaction venue. The incremental value is: (1) the lift in conversion rate from smoother checkout (maybe 20-30% of users who currently abandon after clicking out), and (2) the net-new data and fee revenue minus any costs. If in-app checkout converts 25% more users, the incremental GMV is $2B, not $8B, and the fee revenue is $280M, not $1.12B. Option A addresses pricing, not the sizing flaw. Option C is a real concern but not the fundamental flaw. Option D addresses merchant adoption, which is secondary. The classic mistake is confusing "total addressable activity" with "incremental impact of the feature."',
        ARRAY['incremental_revenue', 'impact_estimation', 'sizing_assumptions']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 10;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'The 14% service fee is too high and merchants will resist, reducing adoption', false),
        (v_question_id, 'B', 'The $8B GMV already occurs through outbound links — in-app checkout only captures incremental conversion, not the full existing volume', true),
        (v_question_id, 'C', 'The projection ignores returns and refund costs, which typically eat 15-20% of GMV in fashion', false),
        (v_question_id, 'D', 'Not all merchants will enable in-app checkout, so the addressable GMV is smaller', false);

    -- ============================================
    -- QUESTION 11 (intermediate) — Zoom
    -- Topic: Build vs. buy decisions with cost comparison
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 11,
        'Build vs. Buy Decision for Zoom''s AI Notetaker',
        'Zoom wants to add an AI meeting notetaker feature. Option 1 (Build): 18 months, team of 12 ML engineers ($250K/yr each), plus $2M/year in compute costs. Option 2 (Buy): Acquire a startup for $40M that has the technology ready, integrate in 3 months with 4 engineers. The feature is projected to reduce churn by 1% on Zoom''s 200K enterprise accounts ($20K ARR each). What should the PM''s build-vs-buy analysis prioritize?',
        'intermediate',
        'Zoom',
        'AI-powered meeting notetaker feature development',
        'D',
        'The critical factor is time-to-value. Both options have similar total costs (Build: $3M/yr × 1.5 years + $2M compute = $6.5M; Buy: $40M acquisition + integration costs). But the revenue impact differs dramatically due to timing. The feature''s churn reduction value = 1% × 200K × $20K = $40M ARR saved. With buying, Zoom captures this 15 months sooner than building. Those 15 months of earlier churn reduction are worth approximately $50M ($40M × 15/12). Option A focuses only on build cost without comparing time value. Option B focuses on technical risk without financial comparison. Option C considers only the acquisition price without the time-to-revenue advantage. In build-vs-buy, the dominant factor is usually the cost of delayed revenue, not the sticker price of either option.',
        ARRAY['build_vs_buy', 'cost_benefit_analysis', 'opportunity_cost']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 11;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Focus on minimizing total engineering cost, since the build option is 6× cheaper than the acquisition', false),
        (v_question_id, 'B', 'Focus on technical risk — building in-house gives more control over quality and IP', false),
        (v_question_id, 'C', 'Focus on the $40M acquisition price and whether the startup''s technology is worth that valuation', false),
        (v_question_id, 'D', 'Focus on time-to-value: the 15-month head start from buying captures ~$50M in earlier churn savings, which likely exceeds the cost premium of acquisition over building', true);

    -- ============================================
    -- QUESTION 12 (foundational) — Pinterest
    -- Topic: Identifying and validating sizing assumptions
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 12,
        'Validating Sizing Assumptions for Pinterest''s Creator Fund',
        'Pinterest is sizing the opportunity for a Creator Fund that pays top creators to produce exclusive content. The PM''s model assumes: (1) 50K creators will participate, (2) each creator will produce 10 exclusive pins/month, (3) exclusive pins will generate 3× more engagement than regular pins, (4) higher engagement will increase ad impressions by 8%, and (5) the additional impressions will be monetized at existing CPM rates. Which assumption is HARDEST to validate before launch?',
        'foundational',
        'Pinterest',
        'Creator monetization and exclusive content program',
        'C',
        'Assumption 4 — that higher engagement translates to 8% more ad impressions — is the hardest to validate pre-launch. Assumptions 1 and 2 can be validated through creator surveys and beta programs. Assumption 3 can be tested with A/B experiments using sample exclusive content. Assumption 5 (CPM rates holding steady) can be verified with the ads team. But the link between engagement and ad impressions depends on complex feed algorithm behavior, user session length changes, and ad load factors that only manifest at scale. A 3× engagement lift per pin doesn''t linearly translate to more ad impressions — users might spend the same total time but concentrate it on fewer pins, or the algorithm might not increase ad slots proportionally. This assumption requires a full-scale experiment to validate, making it the riskiest input in the model.',
        ARRAY['sizing_assumptions', 'impact_estimation', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 12;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Creator participation (50K): because creator incentive programs have highly variable uptake', false),
        (v_question_id, 'B', 'Content production (10 pins/month): because creator output depends on payment structure and creative burnout', false),
        (v_question_id, 'C', 'Engagement-to-impressions translation (8% lift): because the relationship between per-pin engagement and total ad inventory is non-linear and system-dependent', true),
        (v_question_id, 'D', 'CPM rate stability: because flooding more inventory could depress auction prices', false);

    -- ============================================
    -- QUESTION 13 (intermediate) — Shopify
    -- Topic: Feature-level impact (conversion lift × funnel volume × revenue)
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 13,
        'Funnel-Based Impact Estimation for Shopify''s One-Click Checkout',
        'Shopify is rolling out Shop Pay one-click checkout to all merchants. Current merchant checkout funnel: 10M daily cart initiations → 6M reach payment page (60%) → 4.2M complete purchase (70% of payment page). Shop Pay is expected to increase payment-page-to-purchase conversion from 70% to 82%. Average order value is $65, and Shopify earns 2.9% + $0.30 per transaction. What is the daily incremental revenue for Shopify?',
        'intermediate',
        'Shopify',
        'One-click checkout rollout across merchant ecosystem',
        'B',
        'The calculation requires identifying where in the funnel the improvement occurs. Shop Pay improves the payment-to-purchase step from 70% to 82%. Daily purchases increase from 4.2M to 6M × 82% = 4.92M. Incremental purchases = 720K/day. Shopify''s per-transaction revenue = $65 × 2.9% + $0.30 = $1.885 + $0.30 = $2.185. Daily incremental revenue = 720K × $2.185 ≈ $1.57M/day. Option A incorrectly applies the conversion lift to the top of funnel. Option C uses only the percentage fee without the per-transaction fee. Option D applies the 12-percentage-point lift to total daily GMV rather than to incremental transactions. The key insight: in funnel-based estimation, the lift must be applied at the specific funnel stage where the feature acts, then propagated downstream.',
        ARRAY['impact_estimation', 'revenue_modeling', 'feature_impact']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 13;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', '~$3.2M/day: apply the 12% conversion lift to all 10M cart initiations and multiply by Shopify''s per-transaction fee', false),
        (v_question_id, 'B', '~$1.57M/day: 720K incremental purchases (6M × 12% lift at payment step) × $2.185 per-transaction Shopify revenue', true),
        (v_question_id, 'C', '~$1.36M/day: 720K incremental purchases × $65 AOV × 2.9%, omitting the $0.30 per-transaction fee', false),
        (v_question_id, 'D', '~$22.6M/day: apply the 12% lift to total daily GMV ($65 × 4.2M) × 2.9%', false);

    -- ============================================
    -- QUESTION 14 (intermediate) — Twitter/X
    -- Topic: Common mistake — overestimating TAM
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 14,
        'Avoiding TAM Overestimation for X''s Job Listings Feature',
        'X (formerly Twitter) is considering launching a job listings feature to compete with LinkedIn. The PM''s sizing deck claims: "The global online recruitment market is $30B. X has 550M MAUs vs. LinkedIn''s 900M. Therefore, X can capture (550/900) × $30B = $18.3B of this market." What is the MOST critical flaw in this sizing approach?',
        'intermediate',
        'Twitter/X',
        'Job listings feature to compete with LinkedIn',
        'C',
        'The fundamental flaw is that raw MAU ratios are meaningless for recruitment market sizing because user intent differs radically between platforms. LinkedIn users visit the platform with professional and career intent — they maintain resumes, list skills, and signal job-seeking status. X users visit for news, entertainment, and social commentary. A recruiter posting on LinkedIn targets users who are in a professional context; the same post on X reaches users scrolling past political tweets and memes. The relevant metric isn''t total MAUs but "users with professional/career intent," which might be 5-10% of X''s base vs. 60-70% of LinkedIn''s. This would shrink X''s addressable market by 10×+. Option A addresses pricing, not sizing. Option B addresses competition but accepts the flawed TAM. Option D identifies a real issue but is secondary to the intent gap. This exemplifies the most common TAM mistake: assuming all users are equally addressable.',
        ARRAY['sizing_assumptions', 'business_case', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 14;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'The $30B market figure includes offline recruitment, which X cannot capture', false),
        (v_question_id, 'B', 'LinkedIn has 20 years of network effects in recruitment that X cannot overcome, so the share estimate is too high', false),
        (v_question_id, 'C', 'MAU ratio is irrelevant — user intent is fundamentally different; X''s users are there for news/social content, not career activities, making the addressable segment a fraction of total MAUs', true),
        (v_question_id, 'D', 'X doesn''t have structured profile data (resumes, skills, work history) needed for job matching', false);

    -- ============================================
    -- QUESTION 15 (advanced) — Google
    -- Topic: Cannibalization risk in opportunity sizing
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 15,
        'Multi-Layered Cannibalization in Google''s AI Search Answers',
        'Google is expanding AI-generated answers at the top of search results. The PM models the impact: AI answers satisfy 30% of queries without a click, but increase overall search volume by 10% as users ask more complex questions. Google''s revenue is $175B/year from search ads, and 85% comes from clicks to advertiser links. The PM must size the net revenue impact considering all forms of cannibalization. Which analysis captures ALL relevant cannibalization effects?',
        'advanced',
        'Google',
        'AI-generated answers (SGE) impact on search advertising revenue',
        'D',
        'This scenario has multiple, interacting cannibalization layers. First-order effect: 30% of queries lose clicks → 30% × 85% of revenue at risk = 25.5% of $175B = ~$44.6B at risk. Second-order effect: 10% more queries × 70% that still generate clicks partially offsets this. Third-order effect: AI answers may shift the mix of queries (simpler queries go to AI, complex queries remain), and complex queries may have different CPCs. Fourth-order effect: advertisers may bid differently knowing some queries won''t show ads, changing auction dynamics. Only Option D captures all four layers. Option A only looks at the direct click loss. Option B naively nets volume growth against click loss. Option C considers query mix shift but misses auction dynamics. The key lesson: in platform businesses, cannibalization cascades through multiple interconnected systems (user behavior, content mix, advertiser behavior, auction mechanics).',
        ARRAY['cannibalization_risk', 'revenue_modeling', 'sensitivity_analysis', 'impact_estimation']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 15;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Direct click cannibalization only: 30% of queries × 85% click-revenue share = ~25% revenue at risk, offset by volume growth', false),
        (v_question_id, 'B', 'Net volume approach: (10% more queries × 70% click-through) minus (30% zero-click queries) to find net impression change', false),
        (v_question_id, 'C', 'Query-mix shift: simple queries move to AI answers (lower CPC) while complex queries remain (higher CPC), changing the revenue-per-query average', false),
        (v_question_id, 'D', 'All layers: direct click loss, volume offset, query-mix CPC shift, AND advertiser bidding behavior changes as they adjust to new click-through expectations', true);

    -- ============================================
    -- QUESTION 16 (intermediate) — Notion
    -- Topic: Resource allocation decisions based on sizing
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 16,
        'Resource Allocation Based on Opportunity Sizing at Notion',
        'Notion has three features competing for one engineering squad (6 engineers) next quarter. Feature A: API improvements (sized at $5M ARR from developer integrations, 90% confidence). Feature B: AI writing assistant (sized at $25M ARR from premium upsells, 40% confidence). Feature C: Offline mode (sized at $8M ARR from enterprise contracts requiring it, 70% confidence). How should the PM use opportunity sizing to allocate resources?',
        'intermediate',
        'Notion',
        'Engineering resource allocation across competing features',
        'B',
        'The correct approach is to use expected value (EV), which multiplies projected revenue by confidence/probability. Feature A EV: $5M × 90% = $4.5M. Feature B EV: $25M × 40% = $10M. Feature C EV: $8M × 70% = $5.6M. By expected value, Feature B still wins despite low confidence. However, a sophisticated PM would also consider: (1) whether confidence can be improved cheaply (e.g., a 2-week prototype to validate AI demand), (2) strategic optionality (API improvements compound over time), and (3) commitment-level (enterprise contracts may have deadlines). Option A picks the highest raw revenue, ignoring confidence. Option C picks the safest bet, ignoring that even risk-adjusted, Feature B is 2× larger. Option D uses an arbitrary rule. Expected value weighting is the foundation of resource allocation — it prevents both overweighting risky moonshots and underweighting high-upside bets.',
        ARRAY['resource_allocation', 'impact_estimation', 'business_case', 'sizing_assumptions']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 16;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Choose Feature B ($25M ARR) because the highest-revenue opportunity should always be prioritized regardless of confidence', false),
        (v_question_id, 'B', 'Use expected value: weight each estimate by confidence (A: $4.5M, B: $10M, C: $5.6M), then also assess whether confidence for top options can be improved before committing', true),
        (v_question_id, 'C', 'Choose Feature A ($5M at 90% confidence) because high-confidence estimates are more reliable for quarterly planning', false),
        (v_question_id, 'D', 'Split the team: 3 engineers on Feature B and 3 on Feature C to hedge across the two largest opportunities', false);

    -- ============================================
    -- QUESTION 17 (foundational) — WhatsApp
    -- Topic: Sizing non-revenue opportunities (engagement impact)
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 17,
        'Sizing an Engagement Opportunity for WhatsApp Status',
        'WhatsApp''s PM wants to size the opportunity for adding music to Status updates (similar to Instagram Stories). The feature doesn''t directly generate revenue since WhatsApp has no ads. The PM must justify the investment to Meta''s leadership. What is the BEST framework for sizing a non-revenue feature opportunity?',
        'foundational',
        'WhatsApp',
        'Adding music capability to WhatsApp Status updates',
        'A',
        'For non-revenue features, the best approach is to translate engagement gains into downstream business value. This means: (1) estimate the engagement uplift (e.g., 20% more Status creation → 15% more daily opens → 5 more minutes per session), (2) map to retention impact (higher engagement historically correlates with X% lower churn at WhatsApp), (3) value the retained users using Meta''s cross-platform monetization (WhatsApp users on Instagram/Facebook generate $X in ad revenue), and (4) consider strategic value (Status engagement competes with TikTok/Instagram for attention). Option B treats development cost as the key variable, which is incomplete. Option C relies on comparable products but doesn''t value WhatsApp''s specific context. Option D punts on quantification entirely. Even for non-revenue products, PMs must quantify impact through proxy metrics that connect to business value.',
        ARRAY['impact_estimation', 'business_case', 'feature_impact']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 17;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Map engagement uplift → retention impact → LTV of retained users across Meta''s ecosystem (cross-platform monetization value)', true),
        (v_question_id, 'B', 'Calculate the engineering cost and approve if it''s below a threshold, since non-revenue features can''t be sized by impact', false),
        (v_question_id, 'C', 'Benchmark Instagram Stories with music adoption rates and assume WhatsApp will see proportional engagement gains', false),
        (v_question_id, 'D', 'Present it as a competitive necessity against Telegram and Signal, avoiding quantified sizing entirely', false);

    -- ============================================
    -- QUESTION 18 (intermediate) — Figma
    -- Topic: Common mistake — ignoring adoption curves
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 18,
        'Adoption Curve Modeling for Figma''s Dev Mode',
        'Figma launched Dev Mode at $25/month per developer seat. The PM projected Year 1 revenue by assuming all 4M registered developer users would adopt within the first year: 4M × $25 × 12 = $1.2B. Actual Year 1 revenue was $150M. What is the MOST likely explanation for the 8× gap between projection and reality?',
        'intermediate',
        'Figma',
        'Dev Mode paid feature adoption for developer collaboration',
        'C',
        'The 8× gap is classic adoption curve neglect. The PM assumed instant, full adoption — that all 4M developers would convert to paid Dev Mode in Year 1. In reality, product adoption follows an S-curve: innovators (2-5%) adopt quickly, early majority follows, and many users never convert. Typical enterprise tool adoption in Year 1 might be 10-15% of the eligible base, growing over 3-5 years. Additionally, "registered developer users" includes inactive accounts, free-tier-only users, and users in organizations that won''t pay for the upgrade. The realistic Year 1 calculation should have been: 4M × 15% conversion × $25 × 12 × (average 6 months of billing in year 1) = ~$90M, much closer to the $150M actual. Option A addresses pricing but doesn''t explain 8× gap. Option B blames competition but the gap is too large for that alone. Option D suggests measurement error, which is unlikely at this scale.',
        ARRAY['sizing_assumptions', 'impact_estimation', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 18;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'The $25/month price point was too high, causing widespread resistance among developer teams', false),
        (v_question_id, 'B', 'Competitors like Zeplin launched competing features that captured most of the market', false),
        (v_question_id, 'C', 'The projection ignored the adoption S-curve — only 10-15% of eligible users convert in Year 1, and "registered users" overstates the true addressable base', true),
        (v_question_id, 'D', 'Figma''s analytics overcounted developer users by including inactive and duplicate accounts', false);

    -- ============================================
    -- QUESTION 19 (advanced) — Snap
    -- Topic: Sensitivity analysis with tornado diagram
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 19,
        'Tornado Diagram for Snap''s AR Commerce Feature',
        'Snap is building an AR try-on feature for commerce (virtual shoe/clothing try-on). The PM built a revenue model with five inputs: (1) eligible users: 100M, (2) feature trial rate: 20%, (3) purchase conversion from AR try-on: 8%, (4) average order value: $85, (5) Snap''s affiliate commission: 12%. Running a tornado diagram (±30% on each variable), the PM finds all variables contribute equally to the revenue range. What does this tell the PM about the model?',
        'advanced',
        'Snap',
        'AR-powered virtual try-on for e-commerce conversions',
        'B',
        'When all variables in a tornado diagram contribute equally to the output range, it means the model is purely multiplicative (Revenue = A × B × C × D × E) with no interactions, thresholds, or non-linearities. This is a red flag. Real-world product models should have non-linear relationships — for example, purchase conversion should depend on AR quality (which has a threshold: below a certain quality, conversion drops to near-zero). Trial rate should depend on onboarding friction (which has diminishing returns). The model being perfectly multiplicative suggests the PM hasn''t captured the actual causal structure of how AR commerce works. Option A is wrong because equal sensitivity doesn''t mean the model is "well-balanced" — it means it''s oversimplified. Option C is wrong because you can''t validate all variables simultaneously. Option D draws the wrong conclusion. A good model would show some variables dominating the tornado diagram because real products have bottleneck variables.',
        ARRAY['sensitivity_analysis', 'sizing_assumptions', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 19;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'The model is well-balanced — no single assumption dominates risk, so the overall estimate is reliable', false),
        (v_question_id, 'B', 'The model is oversimplified — a purely multiplicative model with no non-linear interactions suggests the PM hasn''t captured real-world causal dynamics', true),
        (v_question_id, 'C', 'All five variables need equal validation effort, so the PM should run five parallel experiments', false),
        (v_question_id, 'D', 'The feature is low-risk because no single assumption can dramatically swing the outcome', false);

    -- ============================================
    -- QUESTION 20 (intermediate) — Duolingo
    -- Topic: Conversion lift calculation
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 20,
        'Sizing the Impact of Duolingo''s Streak Freeze Feature',
        'Duolingo is sizing the opportunity for making "Streak Freeze" (protects learning streaks when users miss a day) available as a subscription perk in Super Duolingo. Current data: 50M DAUs, 8% are Super subscribers ($7/month), average Super subscriber retains for 6 months. Users who lose streaks have a 40% higher churn rate in the following month. The PM estimates Streak Freeze will reduce streak-loss events by 60% for Super subscribers. What is the most complete way to size this opportunity?',
        'intermediate',
        'Duolingo',
        'Streak Freeze as a subscription retention and conversion driver',
        'D',
        'The complete sizing must capture both retention and acquisition effects. Retention side: 50M × 8% = 4M Super subscribers. Streak Freeze reduces streak losses by 60%, which reduces the elevated churn (40% higher than baseline) for those events. This extends average subscriber lifetime, increasing LTV. Acquisition side: If non-subscribers see that Super Duolingo protects their streaks, some percentage of the 46M free users will convert — streaks are Duolingo''s most powerful engagement mechanic, so protecting them is a compelling value proposition. Option A only captures retention. Option B only captures acquisition. Option C calculates correctly but uses the wrong metric (engagement instead of revenue). The complete sizing requires modeling both the LTV extension for existing subscribers AND the incremental conversion from free users motivated by streak protection.',
        ARRAY['impact_estimation', 'revenue_modeling', 'feature_impact', 'incremental_revenue']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 20;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Retention only: calculate how many fewer Super subscribers churn due to streak protection, then value the extended LTV', false),
        (v_question_id, 'B', 'Acquisition only: estimate what percentage of 46M free users will convert to Super for streak protection, at $7/month', false),
        (v_question_id, 'C', 'Engagement: calculate 60% fewer streak-loss events × impact on DAU and session length, then value via ad impressions', false),
        (v_question_id, 'D', 'Both retention (extended LTV from reduced churn among 4M existing subscribers) AND acquisition (incremental conversions from free users motivated by streak protection)', true);

    -- ============================================
    -- QUESTION 21 (foundational) — Canva
    -- Topic: Simple ROI for a product initiative
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 21,
        'Simple ROI for Canva''s Brand Kit Feature',
        'Canva''s PM wants to size the ROI of building a "Brand Kit" feature for teams (save brand colors, fonts, logos). Development cost: $800K (4 engineers × 4 months). The feature is expected to convert 2% of Canva''s 5M team accounts from Free to Canva Pro ($12.99/month), with 80% annual retention. What is the Year 1 ROI?',
        'foundational',
        'Canva',
        'Brand Kit feature to drive team plan conversions',
        'A',
        'Year 1 calculation: New Pro subscribers = 5M × 2% = 100K teams. Monthly revenue = 100K × $12.99 = $1.299M. Annual revenue = $1.299M × 12 = $15.59M. However, since the feature takes 4 months to build, only 8 months of revenue are captured in Year 1: $1.299M × 8 = $10.39M (assuming all conversions happen at launch; in reality, they''d ramp). Applying 80% retention for the remaining months gives approximately $10.39M in Year 1 revenue. Year 1 ROI = ($10.39M - $0.8M) / $0.8M ≈ 1,199%. Even with conservative adjustments (gradual adoption, lower conversion), this is a high-ROI feature. Option B forgets to account for the build period. Option C applies retention too aggressively (annual retention shouldn''t reduce Year 1 revenue by 20%). Option D significantly underestimates by using monthly instead of annual framing. The lesson: even simple ROI calculations must account for build time reducing the first-year capture window.',
        ARRAY['roi_calculation', 'business_case', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 21;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', '~1,200% ROI: $10.4M revenue (8 months of 100K conversions × $12.99/mo after 4-month build) vs. $800K investment', true),
        (v_question_id, 'B', '~1,849% ROI: $15.59M full-year revenue vs. $800K investment, without adjusting for the 4-month build period', false),
        (v_question_id, 'C', '~960% ROI: $15.59M × 80% retention × (8/12 build adjustment) vs. $800K', false),
        (v_question_id, 'D', '~62% ROI: 100K × $12.99 × 1 month = $1.3M vs. $800K investment', false);

    -- ============================================
    -- QUESTION 22 (intermediate) — Uber Eats
    -- Topic: Double-counting impact
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 22,
        'Avoiding Double-Counting in Uber Eats'' Loyalty Program',
        'Uber Eats is sizing a loyalty program that gives 5% cashback on orders. Three PMs independently sized different impacts: PM 1 sized "increased order frequency" at +$200M/year. PM 2 sized "reduced churn" at +$150M/year. PM 3 sized "higher AOV from larger baskets" at +$80M/year. The VP sums these to $430M/year. What is the problem with this approach?',
        'intermediate',
        'Uber Eats',
        'Cashback loyalty program impact sizing',
        'B',
        'The $430M total almost certainly double-counts impact. These three effects are not independent — they share the same underlying mechanism: users ordering more because of cashback incentives. A user who increases order frequency from 3×/month to 4×/month is simultaneously: (1) counted in "increased frequency" (+$200M), (2) counted as "not churned" in the retention model (+$150M), since more frequent users churn less, and (3) potentially counted in "higher AOV" (+$80M) if their additional orders are larger. The same behavioral change (ordering more) flows through all three models. The correct approach is to build one integrated model of user behavior change, then measure total revenue impact holistically. Option A is incorrect because each estimate may be individually valid. Option C proposes unnecessary conservatism. Option D misses the core issue entirely. This is one of the most common errors in enterprise PM: summing departmental impact estimates without checking for overlap.',
        ARRAY['impact_estimation', 'sizing_assumptions', 'revenue_modeling', 'incremental_revenue']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 22;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Each PM likely overestimated their individual component, so the sum is 3× too high', false),
        (v_question_id, 'B', 'The three effects are causally interconnected (more frequency → less churn, larger baskets → more frequency), so summing them double- or triple-counts the same user behavior change', true),
        (v_question_id, 'C', 'The VP should apply a 50% discount factor to account for modeling uncertainty', false),
        (v_question_id, 'D', 'The 5% cashback cost wasn''t subtracted, so the $430M represents gross impact, not net impact', false);

    -- ============================================
    -- QUESTION 23 (advanced) — Tesla
    -- Topic: Payback period with recurring revenue
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 23,
        'Payback Period for Tesla''s Full Self-Driving Subscription',
        'Tesla is evaluating whether to shift FSD (Full Self-Driving) from a $12K one-time purchase to a $199/month subscription. Currently, 8% of new Tesla buyers purchase FSD. The PM estimates subscriptions will increase adoption to 25% due to lower upfront commitment. Tesla sells 1.8M cars/year. What is the crossover point where cumulative subscription revenue exceeds the one-time purchase model?',
        'advanced',
        'Tesla',
        'FSD monetization model shift from purchase to subscription',
        'C',
        'Current model revenue: 1.8M × 8% = 144K buyers × $12K = $1.728B/year. Subscription model monthly revenue: 1.8M × 25% = 450K subscribers × $199/month = $89.55M/month = $1.075B/year from the first year''s cohort. But subscriptions compound — Year 2 adds another 450K subscribers while retaining some from Year 1. Assuming 70% annual retention, Year 2 revenue = (450K new + 315K retained) × $199 × 12 = $1.83B. The crossover depends critically on retention rate. At 70% retention, cumulative subscription revenue catches up around month 20. At 50% retention, it takes 30+ months. At 90% retention, it happens in ~14 months. Option A ignores the compounding effect. Option B assumes perfect retention. Option D focuses on per-user economics rather than the fleet-level crossover. The key insight: subscription transitions require payback period analysis that accounts for cohort-based retention and compounding effects.',
        ARRAY['payback_period', 'revenue_modeling', 'sensitivity_analysis', 'business_case']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 23;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Never — subscriptions at $199/mo take 60 months to match $12K, but average car ownership is only 6 years', false),
        (v_question_id, 'B', 'Immediately — 450K subscribers × $199 × 12 = $1.07B vs. 144K × $12K = $1.73B, subscription exceeds purchase in Year 2 as cohorts compound', false),
        (v_question_id, 'C', 'Around month 18-24, critically dependent on subscriber retention rate — at 70% annual retention, subscription revenue compounds past the one-time model as cohorts stack', true),
        (v_question_id, 'D', 'At the individual user level, after 60 months of $199/mo payments, but fleet-level analysis is irrelevant', false);

    -- ============================================
    -- QUESTION 24 (intermediate) — Calendly
    -- Topic: Build vs. Buy cost comparison
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 24,
        'Build vs. Buy Analysis for Calendly''s Video Conferencing',
        'Calendly is deciding whether to build native video conferencing or integrate with Zoom/Google Meet. Build: $4M upfront + $1.5M/year in maintenance, ready in 12 months. Buy/Integrate: $200K integration cost, $0.50 per meeting in API fees, currently 20M meetings/month. The PM should consider a 3-year horizon. Which option has lower total cost of ownership?',
        'intermediate',
        'Calendly',
        'Native video conferencing vs. third-party integration',
        'D',
        'Let''s calculate 3-year TCO for each option. Build: $4M upfront + $1.5M × 3 years = $8.5M total. But this is conservative — it doesn''t include the opportunity cost of 12 months of delayed launch or ongoing infrastructure scaling costs. Buy/Integrate: $200K upfront + 20M meetings × $0.50 × 12 months × 3 years = $200K + $360M = $360.2M over 3 years. At first glance, building is vastly cheaper. BUT — this assumes 20M meetings/month stays constant. If Calendly is growing, meeting volume could be 40M/month by Year 3, making the buy option even more expensive. However, the PM must also consider: if Calendly builds video and it''s worse than Zoom, users might leave — that''s the real risk. Option A ignores per-meeting variable costs. Option B ignores growth. Option C correctly identifies the cost crossover but misses the strategic dimension. The key insight: build vs. buy isn''t just about costs — it''s about whether building a commodity feature is strategically valuable.',
        ARRAY['build_vs_buy', 'cost_benefit_analysis', 'opportunity_cost']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 24;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Buy is cheaper: $200K vs. $4M upfront, and integration is ready immediately', false),
        (v_question_id, 'B', 'Build is cheaper at $8.5M vs. $360M over 3 years, making it an obvious choice', false),
        (v_question_id, 'C', 'Build is cheaper on pure TCO, but only if meeting volume stays at or above 20M/month; below 1.4M meetings/month, buy is cheaper', false),
        (v_question_id, 'D', 'Build has much lower TCO ($8.5M vs. $360M), but the real analysis is whether owning video is strategic — if native video quality is inferior, customer churn could dwarf the cost savings', true);

    -- ============================================
    -- QUESTION 25 (foundational) — TikTok
    -- Topic: Feature-level impact estimation basics
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 25,
        'Basic Feature Impact Sizing for TikTok Shop',
        'TikTok is sizing the opportunity for "TikTok Shop" in-feed purchase buttons. The PM has the following data: 1B MAUs, 30% see shopping-eligible content daily, 2% of viewers tap the product tag, 5% of tappers complete a purchase, $35 average order value, and TikTok earns a 5% commission. What is the estimated daily revenue from TikTok Shop?',
        'foundational',
        'TikTok',
        'In-feed commerce with shoppable video content',
        'B',
        'This is a straightforward funnel calculation: Start with daily shopping-eligible viewers: 1B × 30% = 300M. Product tag taps: 300M × 2% = 6M. Completed purchases: 6M × 5% = 300K. Daily GMV: 300K × $35 = $10.5M. TikTok commission: $10.5M × 5% = $525K/day, or ~$191M/year. Option A applies the commission to all tag taps rather than completed purchases. Option C multiplies all conversion rates together incorrectly (using MAU instead of daily eligible users). Option D calculates GMV correctly but forgets to apply the commission rate. The key learning: funnel-based opportunity sizing must apply each conversion rate sequentially to the appropriate stage population, not multiply rates against the initial top-of-funnel number.',
        ARRAY['impact_estimation', 'revenue_modeling', 'feature_impact']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 25;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', '~$10.5M/day: 300M eligible × 2% tap × 5% purchase × $35 × 5% commission — but applies commission to taps not purchases', false),
        (v_question_id, 'B', '~$525K/day: 300M eligible → 6M taps → 300K purchases × $35 AOV × 5% commission = $525K daily (~$191M/year)', true),
        (v_question_id, 'C', '~$5.25M/day: 1B MAUs × 0.03% combined conversion × $35 × 5%, incorrectly using total MAUs instead of daily eligible viewers', false),
        (v_question_id, 'D', '~$10.5M/day: 300K purchases × $35 = $10.5M daily GMV, forgetting to apply the 5% commission rate', false);

    -- ============================================
    -- QUESTION 26 (intermediate) — Grammarly
    -- Topic: Sizing with adoption curve and pricing tiers
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 26,
        'Opportunity Sizing for Grammarly''s Enterprise AI Feature',
        'Grammarly is sizing a new "AI Writing Governance" feature for enterprise (ensures all company communications follow brand voice guidelines). Target market: 50K companies with 1,000+ employees. Pricing: $30/user/month (minimum 500 seats). The PM projects 5% market penetration in Year 1, growing 3× by Year 3. Average deployment is 800 seats per company. However, Grammarly Business already serves 10K of these companies at $15/user/month with 600 seats average. What impact does the existing customer base have on the sizing?',
        'intermediate',
        'Grammarly',
        'Enterprise AI writing governance feature launch',
        'C',
        'The existing 10K customers create both cannibalization risk and upsell opportunity. For these customers, the sizing isn''t "new revenue = $30 × 800 seats" but rather "incremental revenue = ($30 - $15) × 800 seats + $15 × (800 - 600) additional seats." The PM must calculate: Net-new customers: (50K - 10K) × 5% penetration = 2K companies × 800 seats × $30 = $48M/month. Existing customers upselling: 10K × some conversion % × ($15 uplift × 600 seats + $15 × 200 expansion seats) = incremental revenue. The total opportunity is NOT simply 50K × 5% × 800 × $30, because existing customers at $15/user are already generating revenue that shouldn''t be double-counted. Option A ignores existing revenue entirely. Option B treats existing customers as a loss. Option D sizes correctly for new customers but completely ignores the existing base. Cannibalization analysis in upsell scenarios requires netting out the existing revenue stream.',
        ARRAY['cannibalization_risk', 'revenue_modeling', 'incremental_revenue', 'business_case']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 26;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'No impact — the AI Governance product is distinct from Grammarly Business, so all 50K × 5% = 2.5K companies represent net-new revenue', false),
        (v_question_id, 'B', 'Negative impact — existing customers may downgrade from $15 Business to demand AI Governance features at the same price', false),
        (v_question_id, 'C', 'Mixed impact — for the 10K existing customers, size only the incremental revenue ($15/user uplift + seat expansion), while sizing net-new revenue for the remaining 40K prospects', true),
        (v_question_id, 'D', 'Ignore existing customers entirely and size only net-new: 40K addressable × 5% × 800 × $30/month', false);

    -- ============================================
    -- QUESTION 27 (advanced) — Meta/Facebook
    -- Topic: Multi-scenario opportunity sizing
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 27,
        'Multi-Scenario Sizing for Meta''s VR Fitness Subscription',
        'Meta is sizing a VR fitness subscription for Quest headsets ($10/month). The PM presents three scenarios: Bear case: 2M subscribers (5% of 40M Quest users) = $240M/year. Base case: 6M subscribers (15%) = $720M/year. Bull case: 15M subscribers (37.5%) = $1.8B/year. The CFO asks: "What''s the expected value?" The PM averages the three: ($240M + $720M + $1.8B)/3 = $920M. What is wrong with this expected value calculation?',
        'advanced',
        'Meta',
        'VR fitness subscription service for Quest platform',
        'B',
        'Simple averaging of scenarios assumes equal probability (33% each), which is almost never correct. Bear, base, and bull cases typically have asymmetric probabilities — the base case should be most likely (say 50-60%), with bear and bull cases having lower probabilities (15-25% each). Furthermore, the scenarios themselves may not represent the true distribution. If the PM assigns proper probabilities (e.g., 25% bear, 55% base, 20% bull), the expected value = 0.25 × $240M + 0.55 × $720M + 0.20 × $1.8B = $60M + $396M + $360M = $816M. This is materially different from $920M. Option A is wrong because scenario analysis is a valid technique. Option C addresses a real concern but isn''t the primary flaw. Option D suggests wrong numbers but the methodology, not the inputs, is the issue. The key insight: expected value requires probability-weighted scenarios, not simple averages. Most PMs bias toward the bull case by giving it equal weight.',
        ARRAY['sizing_assumptions', 'sensitivity_analysis', 'business_case', 'revenue_modeling']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 27;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Scenario analysis is invalid for subscription products — should use cohort-based LTV models instead', false),
        (v_question_id, 'B', 'Equal-weighting assumes 33% probability for each scenario, but bear/base/bull cases should be probability-weighted (e.g., 25%/55%/20%), which materially changes the expected value', true),
        (v_question_id, 'C', 'The scenarios don''t account for development and marketing costs, so even the bear case overstates profitability', false),
        (v_question_id, 'D', 'The subscriber percentages are arbitrary — 5%, 15%, and 37.5% have no empirical basis for VR fitness', false);

    -- ============================================
    -- QUESTION 28 (intermediate) — Robinhood
    -- Topic: Revenue modeling with indirect effects
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 28,
        'Sizing Direct and Indirect Revenue for Robinhood''s Retirement Accounts',
        'Robinhood launched IRA (retirement) accounts with a 1% match on contributions. Direct economics: 1% match costs Robinhood ~$50M/year while generating minimal direct revenue (low trading frequency in retirement accounts). The PM argues the IRA is still a $200M+ opportunity. What indirect revenue effects justify this claim?',
        'intermediate',
        'Robinhood',
        'IRA retirement accounts with employer match incentive',
        'D',
        'The IRA strategy generates revenue through multiple indirect channels that aren''t captured by direct IRA account economics. First, IRA users deposit regular taxable funds into Robinhood to consolidate finances — cross-sell into brokerage (where Robinhood earns from PFOF and margin interest). Second, IRA deposits are sticky (10% penalty for early withdrawal), increasing Robinhood''s net interest income on uninvested cash. Third, IRA users are higher-value customers (higher income, more financially engaged), improving Robinhood Gold subscription conversion. Fourth, the 1% match is a powerful acquisition tool that reduces CAC for all products. The $200M comes from valuing these cross-sell, interest income, and CAC-reduction effects, not from IRA fee revenue directly. Option A only captures interest income. Option B only captures trading revenue. Option C values the marketing effect only. A complete model must capture all indirect revenue streams.',
        ARRAY['revenue_modeling', 'impact_estimation', 'business_case', 'incremental_revenue']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 28;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Net interest income on IRA cash balances: retirement accounts accumulate cash that earns interest for Robinhood', false),
        (v_question_id, 'B', 'Payment for order flow (PFOF) on occasional IRA trades, scaled across millions of accounts', false),
        (v_question_id, 'C', 'The 1% match as a marketing expense — it lowers customer acquisition cost below what Robinhood spends on ads', false),
        (v_question_id, 'D', 'All of the above combined: cross-sell into taxable brokerage, net interest on sticky deposits, higher Gold subscription conversion, and reduced CAC — the IRA is a loss-leader that lifts total customer LTV', true);

    -- ============================================
    -- QUESTION 29 (foundational) — Lyft
    -- Topic: Simple opportunity cost calculation
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 29,
        'Opportunity Cost of Lyft''s Bike-Share Investment',
        'Lyft spent $250M acquiring a bike-share company. The bikes generate $30M/year in revenue but cost $25M/year to operate (net $5M/year). Meanwhile, Lyft''s core ride-hailing business generates a 15% return on invested capital. What is the annual opportunity cost of the bike-share investment?',
        'foundational',
        'Lyft',
        'Bike-share business acquisition vs. core ride-hailing investment',
        'C',
        'Opportunity cost is the return on the best alternative use of the same capital. If Lyft had invested the $250M in its core ride-hailing business instead, it would earn 15% × $250M = $37.5M per year. The bike-share investment earns $5M/year. The opportunity cost is the difference: $37.5M - $5M = $32.5M per year in foregone returns. Put differently, Lyft is $32.5M/year worse off by owning bikes instead of investing in ride-hailing. Option A calculates only the alternative return without netting the bike-share profit. Option B confuses the acquisition cost with ongoing opportunity cost. Option D ignores the time value and only looks at the initial investment. The lesson: opportunity cost isn''t just what you spent — it''s the ongoing difference between what you''re earning and what you could be earning with the same resources.',
        ARRAY['opportunity_cost', 'cost_benefit_analysis', 'roi_calculation']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 29;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', '$37.5M/year: the 15% return Lyft could have earned on $250M in ride-hailing', false),
        (v_question_id, 'B', '$250M: the total acquisition cost that is now locked up in a low-return asset', false),
        (v_question_id, 'C', '$32.5M/year: the difference between what the $250M would earn in ride-hailing ($37.5M) and what bikes actually earn ($5M)', true),
        (v_question_id, 'D', '$220M: the acquisition price minus the net present value of bike-share profits', false);

    -- ============================================
    -- QUESTION 30 (intermediate) — Discord
    -- Topic: Sizing engagement features without direct monetization
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 30,
        'Sizing Discord''s Activity Feed Feature for Nitro Conversion',
        'Discord is building an "Activity Feed" showing friends'' gaming status, shared clips, and achievements. The feature has no direct revenue, but the PM believes it will drive Nitro subscriptions ($9.99/month) by increasing engagement. Current data: 150M MAUs, 4% Nitro conversion rate, average Nitro subscriber stays 8 months. The PM must size this opportunity. What is the critical link in the logic chain that determines whether the opportunity is $10M or $100M+?',
        'intermediate',
        'Discord',
        'Social activity feed to drive premium subscription conversion',
        'B',
        'The critical missing link is the causal relationship between engagement increase and Nitro conversion. The PM''s logic chain is: Activity Feed → more engagement → higher Nitro conversion. But the key question is: "For every X% increase in engagement, how much does Nitro conversion increase?" If the engagement-to-conversion elasticity is 0.1 (a 10% engagement increase drives a 1% relative increase in Nitro conversion, from 4.0% to 4.04%), the opportunity is modest (~$10M). If the elasticity is 1.0 (10% engagement increase → 10% relative conversion increase, from 4.0% to 4.4%), it''s transformative (~$100M+). Option A addresses the wrong variable (total engagement rather than conversion elasticity). Option C focuses on retention rather than conversion. Option D is about feature usage, not the revenue mechanism. The lesson: for engagement-to-revenue features, the conversion elasticity — how sensitively revenue responds to engagement changes — is the swing variable that determines opportunity size by an order of magnitude.',
        ARRAY['impact_estimation', 'sensitivity_analysis', 'revenue_modeling', 'sizing_assumptions']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 30;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'How many MAUs will actually use the Activity Feed — feature adoption determines the top-of-funnel size', false),
        (v_question_id, 'B', 'The engagement-to-Nitro-conversion elasticity — how much each percentage point of engagement increase translates to incremental Nitro subscribers', true),
        (v_question_id, 'C', 'Whether Activity Feed increases Nitro subscriber retention (extending from 8 months) rather than just initial conversion', false),
        (v_question_id, 'D', 'Whether users prefer Activity Feed over existing Discord features, or if it just redistributes existing engagement', false);

    -- ============================================
    -- QUESTION 31 (advanced) — Walmart
    -- Topic: Complex cost-benefit with multi-year horizon
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 31,
        'Multi-Year Cost-Benefit for Walmart''s Automated Fulfillment Centers',
        'Walmart is evaluating a $3B investment in automated fulfillment centers to support same-day delivery. Projected benefits: $800M/year in labor savings, $500M/year in incremental e-commerce revenue from faster delivery. Projected costs: $3B upfront, $200M/year maintenance, $150M/year in retraining/severance for displaced workers. The technology becomes obsolete in 7 years. Discount rate: 10%. Which factor is MOST likely to make this investment fail the NPV test?',
        'advanced',
        'Walmart',
        'Large-scale automated fulfillment center investment',
        'C',
        'Let''s calculate the basic NPV. Annual net benefit = ($800M + $500M) - ($200M + $150M) = $950M/year. Over 7 years at 10% discount rate, the PV of $950M/year ≈ $950M × 4.87 (7-year annuity factor at 10%) = $4.63B. Minus the $3B upfront investment = NPV of +$1.63B. This looks positive, so what could flip it? The $500M in "incremental e-commerce revenue" is the most vulnerable assumption. This assumes same-day delivery creates net-new Walmart revenue rather than just shifting in-store purchases to online (cannibalization). If even 60% of the e-commerce "lift" is channel shift (customers who would have bought in-store anyway), the incremental revenue drops to $200M, annual net benefit drops to $650M, and NPV drops to $650M × 4.87 - $3B = $166M — barely positive. Adding any cost overruns would flip it negative. Option A (labor savings) is the most certain number. Option B (maintenance) is estimable from industry data. Option D (discount rate) would need to rise above 18% to flip NPV, which is unlikely.',
        ARRAY['npv_analysis', 'cost_benefit_analysis', 'cannibalization_risk', 'sensitivity_analysis']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 31;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Labor savings being lower than projected — automation often takes longer to reach full productivity', false),
        (v_question_id, 'B', 'Maintenance costs escalating as robots age and require replacement parts', false),
        (v_question_id, 'C', 'The $500M "incremental revenue" being largely cannibalization from in-store to online channel, reducing true incremental benefit and potentially flipping the NPV negative', true),
        (v_question_id, 'D', 'The 10% discount rate being too low for a technology investment with 7-year obsolescence', false);

    -- ============================================
    -- QUESTION 32 (intermediate) — Notion
    -- Topic: Incremental revenue from feature gating
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 32,
        'Feature Gating Revenue Sizing for Notion''s AI Add-On',
        'Notion charges $10/user/month for its Plus plan. They''re considering adding AI features as an add-on at $8/user/month. Current data: 2M paid users, 15M free users. The PM estimates 30% of paid users will add AI ($8 × 600K = $4.8M/month) and 5% of free users will upgrade directly to Plus+AI ($18 × 750K = $13.5M/month). But the PM hasn''t considered one critical factor. What is it?',
        'intermediate',
        'Notion',
        'AI features add-on pricing strategy',
        'A',
        'The PM hasn''t accounted for the fact that some percentage of free users who upgrade to Plus+AI would have upgraded to Plus anyway (at $10/month). If 3% of free users were going to convert to Plus regardless, then 450K of the 750K "new" Plus+AI users aren''t truly incremental — they would have generated $10/month without AI. For those users, the incremental revenue is only $8/month (the AI add-on), not $18/month. True incremental revenue from free users = (750K - 450K) × $18 + 450K × $8 = $5.4M + $3.6M = $9M/month, not $13.5M. This is a $4.5M/month overestimation. Option B is a valid concern but secondary. Option C addresses costs, not revenue sizing. Option D is about retention, not the initial sizing. The lesson: when a premium feature accelerates conversions that would have happened naturally, only the AI add-on revenue (not the full plan price) should be counted as incremental for those users.',
        ARRAY['incremental_revenue', 'impact_estimation', 'sizing_assumptions', 'cannibalization_risk']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 32;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Baseline conversion: some free users would have upgraded to Plus ($10/mo) anyway, so their incremental revenue is only the $8 AI add-on, not the full $18', true),
        (v_question_id, 'B', 'AI add-on might cannibalize existing Plus subscriptions if users downgrade to Free+AI instead of keeping Plus', false),
        (v_question_id, 'C', 'The compute costs of serving AI features to 1.35M users could consume most of the revenue', false),
        (v_question_id, 'D', 'The 30% add-on adoption rate among paid users might drop rapidly after initial excitement fades', false);

    -- ============================================
    -- QUESTION 33 (advanced) — Amazon
    -- Topic: Complex build vs. buy with strategic considerations
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 33,
        'Strategic Build vs. Buy for Amazon''s Healthcare Play',
        'Amazon is evaluating entering telehealth: Option A (Build from scratch): $500M over 3 years, 10M users by Year 5, full control. Option B (Acquire a telehealth startup): $3B acquisition, 5M existing users, operational in 6 months. Option C (Partner with existing provider): $50M/year licensing, co-branded, 2M users in Year 1 but limited data ownership. The PM calculates NPV for each option using standard projections. An executive pushes back: "Your analysis is missing the most important factor." What is it?',
        'advanced',
        'Amazon',
        'Telehealth market entry strategy evaluation',
        'D',
        'The missing factor is the strategic value of health data integration with Amazon''s broader ecosystem. Standard NPV analysis treats each option''s revenue stream in isolation. But Amazon''s true competitive advantage comes from integrating health data with its pharmacy (Amazon Pharmacy), Alexa health reminders, Whole Foods nutrition, and Prime membership. Options A and B give Amazon full data ownership, enabling these cross-sell and ecosystem lock-in effects worth potentially billions. Option C (partnership) generates users but the limited data ownership means Amazon can''t build the ecosystem flywheel. The "standard projections" likely model telehealth revenue in isolation ($50-100 ARPU) when the real value is 5-10× higher with ecosystem integration. This is why strategic build-vs-buy requires valuing optionality and platform effects beyond direct revenue NPV. Option A focuses on speed, which is already quantified. Option B addresses competition, which is external. Option C correctly identifies a cost concern but isn''t the "most important" missing factor.',
        ARRAY['build_vs_buy', 'business_case', 'revenue_modeling', 'opportunity_cost']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 33;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Time-to-market risk: healthcare regulation could change during the 3-year build period, making the investment worthless', false),
        (v_question_id, 'B', 'Competitive response: incumbents like Teladoc will aggressively defend their market during Amazon''s entry period', false),
        (v_question_id, 'C', 'The true operating costs of healthcare (liability insurance, compliance, provider salaries) that erode margins below tech-company expectations', false),
        (v_question_id, 'D', 'The ecosystem integration value: owning health data (Options A/B) enables cross-sell with Amazon Pharmacy, Alexa, and Prime — worth multiples of standalone telehealth revenue, making data ownership the decisive factor', true);

    -- ============================================
    -- QUESTION 34 (intermediate) — Spotify
    -- Topic: Sizing with retention and LTV extension
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 34,
        'LTV Impact Sizing for Spotify''s Duo Plan',
        'Spotify is sizing the impact of "Spotify Duo" — a plan for couples at $14.99/month (vs. $10.99 Individual). Data: 50M individual Premium subscribers, 15% are in households with another individual subscriber (7.5M couples paying $21.98/month combined). Duo reduces combined price by 32% to $14.99. The PM must size the net revenue impact. What is the complete analysis?',
        'intermediate',
        'Spotify',
        'Duo subscription plan for couples pricing strategy',
        'C',
        'This requires separating multiple revenue effects. Cannibalization (negative): 7.5M couples currently pay $21.98/month combined. Duo would reduce this to $14.99/month — a loss of $6.99/couple/month = $6.99 × 7.5M = $52.4M/month lost. Retention uplift (positive): Shared plans have higher retention (harder to cancel when two people use it). If Duo extends average subscriber lifetime by 3 months (from 30 to 33 months), the LTV increase per couple is 3 × $14.99 = $44.97. Across 7.5M couples, that''s $337M in total incremental LTV. New acquisition (positive): Duo attracts new subscribers who won''t pay full price individually but will split $14.99. If this adds 1M new couples, that''s $14.99M/month new revenue. The complete sizing shows short-term revenue loss but long-term gain from retention and acquisition. Option A only sees cannibalization. Option B ignores cannibalization. Option D focuses only on new couples. The lesson: bundle/discount pricing analysis must capture cannibalization, retention effects, and new acquisition simultaneously.',
        ARRAY['cannibalization_risk', 'revenue_modeling', 'impact_estimation', 'incremental_revenue']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 34;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Net negative: 7.5M couples lose $6.99/mo each = $52M/month in cannibalization that acquisition can''t offset', false),
        (v_question_id, 'B', 'Net positive: Duo will attract millions of new subscribers who wouldn''t pay $10.99 individually', false),
        (v_question_id, 'C', 'Three-part analysis needed: short-term cannibalization (~$52M/month loss), medium-term retention uplift (couples churn less, adding ~$337M in incremental LTV), and new couple acquisition revenue — the net depends on retention and acquisition assumptions', true),
        (v_question_id, 'D', 'Revenue-neutral: the $7/month discount per couple is offset by the elimination of password sharing among couples', false);

    -- ============================================
    -- QUESTION 35 (advanced) — Google
    -- Topic: Comprehensive opportunity sizing combining multiple frameworks
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 35,
        'Comprehensive Sizing for Google Workspace''s AI Assistant',
        'Google Workspace (Gmail, Docs, Sheets, Meet) has 3B users (free) and 9M paying business customers at an average $12/user/month. Google is considering adding an AI assistant (auto-draft emails, meeting summaries, data analysis) as a premium add-on at $30/user/month. The PM must size the 3-year opportunity. What represents the MOST comprehensive sizing approach?',
        'advanced',
        'Google',
        'AI assistant premium add-on for Google Workspace',
        'D',
        'A comprehensive 3-year sizing for a major platform feature requires integrating five analytical frameworks: (1) Direct revenue: estimate adoption curves across the 9M business customers and 3B free users, applying realistic S-curve adoption (maybe 5% in Year 1, 15% Year 2, 25% Year 3), yielding direct add-on revenue. (2) Cannibalization: some customers would have paid for standard Workspace upgrades — subtract that baseline conversion. (3) Competitive impact: Microsoft 365 Copilot at $30/user is a direct competitor; model market share dynamics. (4) Ecosystem effects: AI assistant drives deeper Workspace integration, increasing switching costs and total Workspace ARPU over time. (5) Cost structure: AI inference costs are ~$0.01-0.05 per query; at scale, compute costs could consume 40-60% of the $30/month revenue. Most PMs would size only #1 (direct revenue). Good PMs add #2 (cannibalization). Great PMs add #3-5 to build a complete picture. Option A covers only direct revenue. Option B adds competition but misses costs. Option C adds costs but misses ecosystem value. Only Option D captures all five dimensions.',
        ARRAY['revenue_modeling', 'cost_benefit_analysis', 'cannibalization_risk', 'sensitivity_analysis', 'business_case']);
    SELECT id INTO v_question_id FROM questions WHERE sub_skill_id = v_sub_skill_id AND question_number = 35;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
        (v_question_id, 'A', 'Adoption-curve revenue model: apply S-curve adoption rates to the 9M business and 3B free user base, projecting annual add-on revenue at $30/user/month', false),
        (v_question_id, 'B', 'Revenue model plus competitive analysis: size direct revenue AND model market share dynamics against Microsoft 365 Copilot at the same price point', false),
        (v_question_id, 'C', 'Revenue model plus unit economics: size direct revenue AND subtract AI compute costs (which at scale could consume 40-60% of the $30/month price)', false),
        (v_question_id, 'D', 'Integrated five-part analysis: (1) adoption-curve direct revenue, (2) cannibalization of baseline upgrades, (3) competitive market share modeling, (4) ecosystem lock-in value from deeper integration, and (5) AI compute cost structure at scale', true);

END $$;
