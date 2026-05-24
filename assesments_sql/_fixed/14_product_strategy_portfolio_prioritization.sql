-- ============================================
-- ASSESSMENT: Portfolio Prioritization
-- CATEGORY: Product Strategy
-- TOTAL QUESTIONS: 35
-- DIFFICULTY: 10 foundational, 18 intermediate, 7 advanced
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_q_id UUID;
BEGIN
    -- Look up the sub-skill ID
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'portfolio-prioritization';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug portfolio-prioritization not found. Run the seed data first.';
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
        'Duolingo''s Resource Allocation — 70-20-10 Model',
        E'Duolingo is planning its annual resource allocation. The product leadership team wants to use the classic 70-20-10 model to distribute engineering and design resources.\n\nThe portfolio contains:\n1. Core language learning lessons (gamification, leaderboard, path system)\n2. The Duolingo English Test (DET) (standardized testing for university admissions)\n3. Experimental AI-powered conversational avatars for speaking practice\n\nWhich of the following represents the correct distribution of resources across these three initiatives according to the 70-20-10 model?',
        'foundational',
        'Duolingo',
        'Duolingo is a leading language learning app expanding its product offerings.',
        'B',
        'The 70-20-10 model is a classic portfolio management framework. It allocates 70% of resources to core businesses (in Duolingo''s case, the main language app), 20% to adjacent opportunities (such as DET, which leverages Duolingo''s assessment tech but targets a new market like university admissions), and 10% to transformational/experimental bets (like AI-powered conversational avatars). Option B correctly maps this distribution. Option A reverses the priorities, allocating the bulk of resources to high-risk experimental bets. Options C and D misclassify the initiatives'' relationship to the core business model.',
        ARRAY['resource_allocation', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '70% to AI-powered conversational avatars (transformational), 20% to DET (adjacent), and 10% to Core lessons (core).', false),
    (v_q_id, 'B', '70% to Core lessons (core), 20% to DET (adjacent), and 10% to AI-powered conversational avatars (transformational).', true),
    (v_q_id, 'C', '70% to DET (adjacent), 20% to Core lessons (core), and 10% to AI-powered conversational avatars (transformational).', false),
    (v_q_id, 'D', '70% to Core lessons (core), 20% to AI-powered conversational avatars (transformational), and 10% to DET (adjacent).', false);

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
        'Spotify''s Horizon Planning — Defining the Horizons',
        E'Spotify''s VP of Product is organizing a portfolio review using McKinsey''s Horizon Planning framework. The PM for the Podcasts team is asked to classify three initiatives:\n- Initiative X: Enhancing the core music recommendation engine (Collaborative Filtering).\n- Initiative Y: Building a new marketplace for live audiobooks purchasing.\n- Initiative Z: Developing direct brain-computer interface (BCI) streaming concepts for 10 years out.\n\nHow should these initiatives be mapped to Horizons 1, 2, and 3 respectively?',
        'foundational',
        'Spotify',
        'Spotify is a leading music and audio streaming service.',
        'A',
        'Horizon 1 represents core businesses that generate immediate cash flow and require ongoing optimization (Initiative X, music recommendation). Horizon 2 represents emerging adjacent opportunities that are scaling and starting to generate new revenue streams (Initiative Y, audiobooks marketplace). Horizon 3 represents long-term, highly speculative ideas that could redefine the company''s future (Initiative Z, BCI streaming). Option A correctly identifies this mapping. Option B reverses the horizons. Options C and D confuse the maturity levels of the core app enhancements versus the new business lines.',
        ARRAY['horizon_planning', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Initiative X to Horizon 1; Initiative Y to Horizon 2; Initiative Z to Horizon 3.', true),
    (v_q_id, 'B', 'Initiative X to Horizon 3; Initiative Y to Horizon 2; Initiative Z to Horizon 1.', false),
    (v_q_id, 'C', 'Initiative X to Horizon 2; Initiative Y to Horizon 1; Initiative Z to Horizon 3.', false),
    (v_q_id, 'D', 'Initiative X to Horizon 1; Initiative Y to Horizon 3; Initiative Z to Horizon 2.', false);

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
        'Notion''s Product Lifecycle — Resource Reallocation',
        E'Notion''s core editor product has reached the ''Maturity'' stage of its product lifecycle, with high, stable retention but slowing user acquisition growth. Meanwhile, Notion Calendar (a newer product) is in the ''Growth'' stage, exhibiting high user acquisition but requiring heavy development. \n\nHow should a Portfolio PM adjust resource allocation between these two products?',
        'foundational',
        'Notion',
        'Notion is an all-in-one collaborative workspace product.',
        'C',
        'During the maturity stage, the core product requires fewer net-new feature developments and more focus on stability, infrastructure optimization, and efficiency to defend market share. This frees up resources to fund growth-stage products (like Notion Calendar) that are scaling quickly and need feature expansion to capture the market. Option C reflects this balanced portfolio approach. Option A is dangerous because completely starving a mature cash-cow product can lead to premature decline. Option B ignores the lifecycle stages and growth rates. Option D is incorrect because you cannot easily push a mature product back to the introduction stage by simply doubling headcount.',
        ARRAY['product_lifecycle', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reallocate all engineers from the core editor to Notion Calendar to maximize the high-growth phase.', false),
    (v_q_id, 'B', 'Keep resource allocation equal (50/50) to ensure both products receive the same level of attention.', false),
    (v_q_id, 'C', 'Shift a portion of engineering from the core editor to Notion Calendar, while retaining a lean team on core editor focused on efficiency, infrastructure, and incremental retention gains.', true),
    (v_q_id, 'D', 'Double the headcount on the core editor to aggressively push it back into the ''Introduction'' stage.', false);

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
        'Uber''s Cannibalization — UberX vs. Uber Share',
        E'The Uber Rides portfolio PM is preparing to relaunch ''Uber Share'' (formerly Uber Pool) in a major city. UberX is highly profitable, while Uber Share will have lower margins but higher seat utilization. \n\nWhat is the primary portfolio prioritization risk that the PM must evaluate and manage?',
        'foundational',
        'Uber',
        'Uber is a global mobility-as-a-service provider.',
        'B',
        'Cannibalization management is a critical aspect of portfolio prioritization. When launching a lower-priced product (Uber Share) that competes with an existing profitable product (UberX), the PM must ensure the new offering expands the total market (e.g., brings in price-sensitive riders who wouldn''t use UberX) or increases overall trip frequency, rather than simply shifting existing high-margin UberX users to a lower-margin service. Option B correctly identifies this risk. Option A is an execution risk, not a portfolio risk. Option C is a driver adoption risk. Option D is a market external risk, but not the primary internal portfolio priority risk.',
        ARRAY['cannibalization_mgmt', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The engineering complexity of integrating shared ride matching algorithms into the driver application.', false),
    (v_q_id, 'B', 'The risk of Uber Share cannibalizing profitable UberX rides without expanding the total addressable ride volume or rider frequency.', true),
    (v_q_id, 'C', 'The risk that drivers will reject Uber Share rides due to passenger coordination difficulties.', false),
    (v_q_id, 'D', 'The competitor response from taxi services who might lower prices in response to Uber Share.', false);

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
        'Netflix''s Interactive Storytelling — Sunk Cost Fallacy',
        E'Netflix invested $15M into developing a specialized interactive storytelling technology (similar to Bandersnatch) for its kids'' content. After 12 months, user data shows that only 3% of kids complete interactive episodes, and retention metrics are flat. The engineering lead argues: ''We''ve spent $15M and 12 months of developer time; we must launch three more interactive series to get our return on investment.''\n\nHow should the Portfolio PM respond?',
        'foundational',
        'Netflix',
        'Netflix is a global subscription streaming service.',
        'B',
        'The sunk cost fallacy occurs when decision-makers continue investing in a failing project because they have already spent significant resources (money, time) on it. In portfolio management, past investments (the $15M) are irrelevant to future decisions; only the expected future cost and return matter. Since the current data shows flat retention and low completion, the PM should recommend sunsetting or pausing the project, as option B states. Option A falls directly into the sunk cost trap. Options C and D make risky assumptions about product-market fit without backing them up with user research or customer discovery.',
        ARRAY['sunk_cost_fallacy', 'kill_decision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree with the engineering lead, as launching more series distributes the initial $15M fixed cost over more content assets, lowering average cost.', false),
    (v_q_id, 'B', 'Recommend pausing or sunsetting the interactive branch because the $15M spent is a sunk cost; future resource decisions must be based on expected future value versus future costs.', true),
    (v_q_id, 'C', 'Pivot the interactive technology to adult horror series where the completion rates might be higher, without doing additional user testing.', false),
    (v_q_id, 'D', 'Ask for an additional $10M to rebuild the user interface, assuming the poor completion rate is purely a UI issue.', false);

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
        'Slack''s Core Platform — Cross-Product Dependency',
        E'Slack is organizing its portfolio. The team building ''Slack Huddles'' and the team building ''Slack Canvas'' both rely on the ''Real-time Messaging (RTM) Infrastructure'' team to support their sync operations. The RTM Infrastructure team has a backlog bottleneck.\n\nWhich prioritization approach best handles this dependency at the portfolio level?',
        'foundational',
        'Slack',
        'Slack is an enterprise communication platform.',
        'C',
        'In portfolio management, platform or infrastructure teams represent shared dependencies. Portfolio PMs must optimize for the total aggregate value across the portfolio rather than letting individual feature teams work in silos or duplicate work. Option C is the correct strategic approach. Option A leads to poor collaboration and suboptimal results. Option B creates technical debt and duplication of effort. Option D is an overreaction that halts product delivery unnecessarily.',
        ARRAY['portfolio_management', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Let Huddles and Canvas PMs fight for the RTM team''s capacity, prioritizing the team with the loudest voice.', false),
    (v_q_id, 'B', 'Have both Huddles and Canvas teams hire their own infrastructure engineers to duplicate the infrastructure and bypass the RTM team.', false),
    (v_q_id, 'C', 'Run a portfolio-level review to evaluate the combined business impact of the Huddles and Canvas roadmaps, and allocate RTM capacity to the bottleneck dependencies that yield the highest aggregate portfolio value.', true),
    (v_q_id, 'D', 'Freeze development on both Huddles and Canvas until RTM infrastructure completes a full platform rewrite.', false);

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
        'Stripe''s Capital Allocation — Billing vs. Terminal',
        E'Stripe has a surprise surplus of $50M in R&D budget. The VP of Product must allocate it between:\n1. Stripe Billing (SaaS recurring billing software: high gross margins, high growth, highly competitive software market)\n2. Stripe Terminal (physical card reader hardware: low margins, low growth, but critical for omni-channel customer lock-in)\n\nAccording to capital allocation principles for maximizing long-term enterprise value, how should the PM team recommend distributing the budget?',
        'foundational',
        'Stripe',
        'Stripe is a financial infrastructure platform for the internet.',
        'C',
        'Capital allocation should maximize long-term enterprise value by balancing high-growth, high-margin opportunities with strategic moats. Stripe Billing is a high-growth, high-margin SaaS product that can capture market share, making it the primary target for capital. However, Stripe Terminal provides an essential lock-in moat for large omnichannel merchants. Thus, option C is the most balanced and strategic allocation. Option A ignores high-margin software returns. Option B ignores the strategic importance of the physical checkout point. Option D is a political compromise, not a strategic decision.',
        ARRAY['capital_allocation', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allocate 100% to Stripe Terminal because hardware is physically tangible and harder for competitors to replicate.', false),
    (v_q_id, 'B', 'Allocate 100% to Stripe Billing because SaaS software has higher gross margins, ignoring the omnichannel strategic benefit of Terminal.', false),
    (v_q_id, 'C', 'Allocate the majority of the funding to Stripe Billing to capture high-margin market growth, while reserving a strategic portion for Stripe Terminal to maintain the omni-channel moat.', true),
    (v_q_id, 'D', 'Split the funding 50/50 to avoid political conflicts between the software and hardware product lines.', false);

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
        'Zoom''s Sunsetting — Legacy Chrome Extension',
        E'Zoom has developed a modern Google Workspace Add-in that replaces their legacy Zoom Chrome Extension. The legacy extension is used by 8% of weekly active users, but it has severe security vulnerabilities and costs $200k/month in legacy server maintenance.\n\nWhat is the most appropriate portfolio decision?',
        'foundational',
        'Zoom',
        'Zoom is a video communications platform.',
        'B',
        'Sunsetting legacy features/products is a critical portfolio management skill. Maintaining legacy integrations indefinitely drains resources and creates security risks (Option A). However, shutting down an integration with only 24 hours notice (Option C) will cause massive customer frustration. Option B represents the industry standard for a graceful kill decision: set a clear EOL date, offer a migration path, and stop onboarding new users. Option D is an inefficient allocation of resources to double down on an outdated tool.',
        ARRAY['product_lifecycle', 'kill_decision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep both integrations active indefinitely to avoid upsetting the 8% of users.', false),
    (v_q_id, 'B', 'Sunset the legacy extension by setting a clear end-of-life (EOL) date, proactively prompting users to migrate to the new Workspace Add-in, and disabling new installations of the legacy extension.', true),
    (v_q_id, 'C', 'Deprecate the legacy extension immediately with a 24-hour notice to force instant migration.', false),
    (v_q_id, 'D', 'Reallocate 30% of the core app''s engineers to redesign and secure the legacy extension.', false);

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
        'Amazon Echo — Risk Management Across Products',
        E'The Amazon Devices portfolio PM is managing the Alexa-enabled hardware roadmap. The portfolio includes the mature Echo Dot (low risk, predictable sales), the Echo Show (medium risk, growing adoption), and the experimental Astro robot (high risk, unproven market).\n\nHow should the PM manage risk across this portfolio?',
        'foundational',
        'Amazon',
        'Amazon develops smart home devices under the Echo brand.',
        'C',
        'Portfolio risk management involves balancing predictable, cash-generating products (mature core products like Echo Dot) with high-growth adjacent bets (Echo Show) and speculative, high-upside innovations (Astro). This is the essence of maintaining a balanced portfolio (Option C). Option A eliminates long-term innovation. Option B ignores future growth opportunities. Option D fails to align resources with the strategic role and stage of each product in the portfolio.',
        ARRAY['portfolio_management', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Cancel the Astro robot because high-risk projects lower the overall predictability of the hardware division''s quarterly revenue.', false),
    (v_q_id, 'B', 'Allocate all R&D budget to the Echo Dot because it has the highest historical ROI.', false),
    (v_q_id, 'C', 'Balance the portfolio by using steady cash flows from the mature Echo Dot to fund incremental upgrades for Echo Show and higher-risk, high-upside bets like Astro.', true),
    (v_q_id, 'D', 'Keep all three products at the exact same funding level to diversify risk evenly.', false);

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
        'Figma''s Headcount Reallocation — Executive Alignment',
        E'The Lead PM for Figma Slides wants to request 15 additional engineers for the upcoming fiscal year. These engineers must be reallocated from Figma Design (the core editor). The VP of Product is skeptical about reducing core editor resources.\n\nHow should the PM align the VP on this portfolio shift?',
        'foundational',
        'Figma',
        'Figma is a leading collaborative interface design tool.',
        'B',
        'To align executives on portfolio resource shifts, a PM must build a strategic business case. Framing the decision around market saturation of the core product and the TAM expansion of an adjacent opportunity (Slides) is a classic portfolio strategy argument (Option B). Option A is incorrect because core products are rarely ''done'' and need ongoing support. Option C is unprofessional and toxic. Option D makes unsubstantiated promises that damage PM credibility.',
        ARRAY['portfolio_management', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Argue that the core editor is ''done'' and does not need any more engineers.', false),
    (v_q_id, 'B', 'Frame the request around how the core editor''s market is near saturation, and how reallocating resources to Slides unlocks a massive adjacent market (presentations) that increases Figma''s total addressable market (TAM).', true),
    (v_q_id, 'C', 'Complain that the core editor team is lazy and has too many resources.', false),
    (v_q_id, 'D', 'Promise that Slides will reach profitability in less than 3 months without presenting any supporting market data.', false);

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
        'DoorDash''s Core Defence vs. 70-20-10 Model',
        E'DoorDash operates under a standard 70-20-10 resource allocation model: 70% on core food delivery, 20% on adjacent verticals (Groceries, Convenience), and 10% on transformational bets (Autonomous Drone Delivery).\n\nA new competitor enters the core food delivery market with aggressive pricing, causing DoorDash''s core customer retention to drop by 5%. How should the Chief Product Officer (CPO) adjust the portfolio allocation?',
        'intermediate',
        'DoorDash',
        'DoorDash operates a leading food delivery marketplace.',
        'B',
        'While models like 70-20-10 are helpful guidelines, they are not dogmas. If the core business (which funds all other bets) is under existential threat, the PM/CPO must defend it by temporarily shifting resources from adjacent and transformational bets back to the core (Option B). Drones (H3) and groceries (H2) are funded by the cash flows generated by the core food delivery business. Option A is too rigid. Option C is a long-term bet that won''t solve the immediate 5% retention drop. Option D is an extreme, permanent action that destroys long-term growth for a short-term marketing fix.',
        ARRAY['resource_allocation', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Strictly maintain the 70-20-10 allocation because portfolio models must be adhered to regardless of short-term market dynamics.', false),
    (v_q_id, 'B', 'Suspend the 70-20-10 model temporarily and reallocate resources from H3 drones and H2 grocery to H1 core food delivery to defend the core business.', true),
    (v_q_id, 'C', 'Reallocate resources from core food delivery to drone delivery to leapfrog the competitor technologically.', false),
    (v_q_id, 'D', 'Shut down the grocery business entirely and invest all proceeds into marketing discounts.', false);

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
        'Netflix Games vs. Video — Lifecycle Resource Decision',
        E'Netflix''s portfolio includes Netflix Video Streaming (Mature stage) and Netflix Games (Introduction stage). The games PM requests an increase in budget. The CFO points out that Netflix Games has an extremely high CAC and currently generates no direct revenue, whereas Video Streaming has a very low CAC and high LTV.\n\nWhat framework should the Portfolio PM use to justify the investment in Netflix Games?',
        'intermediate',
        'Netflix',
        'Netflix provides video streaming and has recently entered mobile gaming.',
        'B',
        'Early-stage products (Introduction/Horizon 3) cannot be evaluated using the same metrics as mature cash-cows. Netflix Games is bundled with the core subscription to increase engagement and reduce core video churn. Evaluating it purely on standalone direct LTV/CAC ignores its ecosystem value and its early-stage maturity level (Option B). Option A is unrealistic; video streaming is not shutting down in 2 years. Option C would likely kill early adoption of the games. Option D applies mature-product standards to an early-stage bet, which prevents innovation.',
        ARRAY['product_lifecycle', 'capital_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Defend the budget by showing that mature products must eventually be shut down, so games will replace video streaming as Netflix''s main revenue source within 2 years.', false),
    (v_q_id, 'B', 'Explain that early-stage portfolio bets (Introduction stage) should not be evaluated on current unit economics (LTV/CAC) but on their strategic value (e.g., churn reduction for the core bundle) and potential to build a future growth engine.', true),
    (v_q_id, 'C', 'Suggest charging a separate subscription fee for Netflix Games immediately to match the unit economics of the video streaming service.', false),
    (v_q_id, 'D', 'Agree with the CFO and cut the games budget until its direct LTV/CAC ratio exceeds that of video.', false);

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
        'Spotify Podcasts — Cannibalization vs. Incremental Value',
        E'Spotify is prioritizing a new premium podcast subscription feature. The Ads PM is concerned that charging users for premium podcasts will cannibalize the highly profitable ad-supported free podcast listening.\n\nWhat analysis should the Portfolio PM run to make the priority decision?',
        'intermediate',
        'Spotify',
        'Spotify offers music streaming and ad-supported/premium podcasts.',
        'A',
        'When introducing a product that may cannibalize another, the PM must model the net economic impact. If the subscription revenue (minus costs) from users who upgrade exceeds the ad revenue they would have generated, the cannibalization is ''positive'' and increases total net margin (Option A). Option B is a vanity metric that ignores financial viability. Option C ignores the financial trade-off completely. Option D is an operational rule that might hurt content supply and does not address the underlying economic analysis.',
        ARRAY['cannibalization_mgmt', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Model the net margin contribution by comparing the projected subscription revenue minus content acquisition costs against the lost ad revenue from users who switch to the paid tier.', true),
    (v_q_id, 'B', 'Measure only the total subscriber count of the new premium podcast tier, as subscriber growth is the only metric that matters.', false),
    (v_q_id, 'C', 'Compare the total listener hours of free podcasts versus paid podcasts, ignoring monetization models.', false),
    (v_q_id, 'D', 'Implement a policy where creators cannot list their podcasts on both the free and premium tiers, preventing any customer overlap.', false);

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
        'Uber Autonomous — Transitioning Across Horizons',
        E'Uber''s Autonomous Driving Unit has been operating as an H3 (Horizon 3) exploratory research initiative. The technology has matured, and a pilot program in Phoenix shows that autonomous rides are now cheaper to operate than human rides on 5 specific routes.\n\nHow should the Portfolio PM manage this transition?',
        'intermediate',
        'Uber',
        'Uber has partnered with autonomous vehicle providers for ride-hailing.',
        'B',
        'Once a Horizon 3 (experimental/exploratory) project achieves proof of concept and viable unit economics in a pilot, it must transition to Horizon 2 (growth/scaling). This requires shifting the resource mix from research to go-to-market, integration, and operational scaling (Option B). Option A keeps the tech locked in R&D, wasting its commercial potential. Option C is premature, as the tech is only proven on 5 specific routes in one city, and a global rollout would fail. Option D is a strategic divestment that is not supported by the pilot''s success.',
        ARRAY['horizon_planning', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the initiative in Horizon 3 indefinitely to avoid disrupting human driver relations in other cities.', false),
    (v_q_id, 'B', 'Transition the initiative to Horizon 2, reallocating budget from purely scientific research to operational scaling, product integration with the main Uber app, and local marketing in Phoenix.', true),
    (v_q_id, 'C', 'Move the initiative straight to Horizon 1 and immediately replace 50% of human drivers globally with autonomous vehicles.', false),
    (v_q_id, 'D', 'Sell the autonomous technology to a third party to avoid the complexity of managing a dual-supply marketplace.', false);

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
        'Stripe''s API v1 Deprecation — The Kill Decision',
        E'Stripe''s core payments team wants to deprecate v1 of the Stripe checkout API. This legacy API is used by 4% of active merchants, representing $12M in annual processing volume. However, maintaining the legacy infrastructure requires 15% of the payments engineering capacity and blocks the rollout of v3, which offers advanced fraud protection and is expected to drive $100M in new volume.\n\nWhat is the most rational portfolio decision?',
        'intermediate',
        'Stripe',
        'Stripe manages APIs used by millions of online merchants.',
        'B',
        'In this case, the opportunity cost of maintaining the legacy API (blocking a v3 rollout worth $100M in volume) is far higher than the legacy revenue ($12M volume, of which Stripe only takes a small percentage in fees). Sunsetting v1 with a generous migration period and tools (Option B) is the correct strategic decision. Option A ignores opportunity cost. Option C is a hostile customer experience and doesn''t solve the engineering bottleneck. Option D allows a small minority of laggards to stall the company''s growth.',
        ARRAY['kill_decision', 'product_lifecycle']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep v1 active indefinitely because $12M in processing volume is too large to risk losing.', false),
    (v_q_id, 'B', 'Deprecate v1, set a 6-month migration timeline, offer automated migration scripts to the affected 4% of merchants, and reallocate the engineering capacity to the v3 rollout.', true),
    (v_q_id, 'C', 'Charge the 4% of merchants a massive ''maintenance fee'' to offset the 15% engineering cost, keeping v1 active.', false),
    (v_q_id, 'D', 'Pause the rollout of v3 until all 4% of merchants voluntarily migrate off v1.', false);

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
        'Slack Huddles — Overcoming Sunk Cost in Governance',
        E'Slack''s Huddles team spent 9 months and $1.2M developing a proprietary video compression algorithm. Right before launch, Salesforce (Slack''s parent company) acquires a video infrastructure company that provides a superior, fully integrated video engine at zero internal cost. The Huddles PM wants to launch their proprietary algorithm anyway to ''not waste 9 months of hard work.''\n\nAs the Portfolio Director, how should you govern this decision?',
        'intermediate',
        'Slack',
        'Slack is an enterprise workspace product owned by Salesforce.',
        'B',
        'This is a classic sunk cost fallacy in product governance. The $1.2M and 9 months are gone. The best decision for the company going forward is to use the superior, free Salesforce video engine, which will deliver a better user experience and free up valuable Slack engineering capacity to focus on other high-value tasks (Option B). Option A succumbs to sunk cost and damages the product. Option C uses a lower-performing engine just to validate past work. Option D delays strategic synergy benefits for emotional reasons.',
        ARRAY['sunk_cost_fallacy', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Approve the launch of the proprietary algorithm because the team''s morale will suffer if their work is discarded.', false),
    (v_q_id, 'B', 'Reject the proprietary algorithm, integrate Salesforce''s shared engine, and reallocate the Huddles engineers to core user experience improvements.', true),
    (v_q_id, 'C', 'Run an A/B test with both engines and launch the proprietary one if it performs at least 50% as well as the Salesforce engine.', false),
    (v_q_id, 'D', 'Delay the Salesforce integration by 1 year to allow the proprietary algorithm to have a ''market trial.''', false);

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
        'Zoom''s Capital Allocation Matrix',
        E'Zoom is allocating its annual R&D capital across two main product lines: Zoom Phone (Enterprise VOIP) and Zoom Events (Virtual conferences).\n- Zoom Phone: High market growth, Zoom has high market share (Cash Cow transitioning to star).\n- Zoom Events: Low market growth, Zoom has low market share (Dog / Question Mark).\n\nHow should the Portfolio PM structure the capital allocation?',
        'intermediate',
        'Zoom',
        'Zoom offers video communications, cloud phone, and events systems.',
        'B',
        'Based on the BCG Matrix or GE-McKinsey portfolio analysis, resources should be funneled into high-share, high-growth business units (Zoom Phone) to maximize returns and defend market position. Low-share, low-growth business units (Zoom Events) should either be divested, sunset, or kept on minimal maintenance budgets (Option B). Option A is a waste of capital on low-potential lines. Option C (''funding the weak'') is a common PM trap that starves successful products to rescue failing ones. Option D is strategically irrational as low growth and low share indicate a poor investment.',
        ARRAY['capital_allocation', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allocate equal funding to both to maintain a balanced product catalog.', false),
    (v_q_id, 'B', 'Allocate the majority of R&D capital to Zoom Phone to solidify market leadership and scale recurring revenue, while minimizing Zoom Events funding to maintenance levels or sunsetting it.', true),
    (v_q_id, 'C', 'Shift 80% of funding to Zoom Events because it needs the capital more to catch up to competitors.', false),
    (v_q_id, 'D', 'Allocate 100% of capital to Zoom Events because it is in a low-growth market, indicating it has less competition.', false);

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
        'Airbnb''s Portfolio Risk Management',
        E'Airbnb''s Portfolio PM is evaluating three new product concepts for the upcoming roadmap:\n1. Airbnb Luxury Escapes (high-end villa rentals)\n2. Airbnb Corporate Retreats (team-building accommodation packages)\n3. Airbnb Local Experiences (tours led by locals)\n\nAll three concepts rely heavily on international business travel and high disposable income. How should the PM address the risk correlation within this portfolio?',
        'intermediate',
        'Airbnb',
        'Airbnb is a marketplace for vacation rentals and experiences.',
        'B',
        'A well-managed portfolio should avoid high correlation of risk among its bets. Since all three initial concepts depend on international corporate travel and high disposable income, they are highly vulnerable to a single external shock (like a recession or travel restrictions). Hedging the portfolio with a counter-cyclical or domestic-focused product (like Airbnb Roadtrips) provides risk diversification (Option B). Option A is incorrect because the bets are highly correlated, so they do not provide real diversification. Options C and D do not solve the portfolio risk correlation problem.',
        ARRAY['portfolio_management', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Proceed with all three because launching three products instead of one inherently diversifies risk.', false),
    (v_q_id, 'B', 'Redesign the portfolio to include a counter-cyclical or domestic-focused bet (e.g., Airbnb Roadtrips) to hedge against a macroeconomic downturn that impacts international business travel.', true),
    (v_q_id, 'C', 'Cancel Airbnb Local Experiences because it has the lowest average order value.', false),
    (v_q_id, 'D', 'Fund only Airbnb Luxury Escapes because wealthy travelers are immune to economic recessions.', false);

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
        'Duolingo''s Monetization vs. Retention Portfolio Tension',
        E'Duolingo''s executive board is pushing for short-term revenue growth to hit quarterly earnings targets. The Monetization PM proposes adding unskippable video ads after every lesson. The Core Experience PM shows data that this will drop 14-day user retention by 8%.\n\nHow should the Portfolio PM resolve this conflict?',
        'intermediate',
        'Duolingo',
        'Duolingo monetizes via ads and premium subscriptions.',
        'C',
        'Portfolio management requires balancing short-term financial demands (monetization) with long-term asset health (retention/engagement). Option C represents a sophisticated portfolio solution: using data to segment users (limiting negative retention impact to highly engaged users) and offering a premium ad-free tier as a value-add alternative. Option A sacrifices long-term growth for short-term gains. Option B is too dogmatic and ignores business realities. Option D is an arbitrary rule not supported by product logic.',
        ARRAY['portfolio_management', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Agree with the monetization proposal because hitting quarterly executive targets is always the highest priority.', false),
    (v_q_id, 'B', 'Reject the monetization proposal entirely because user retention must never be compromised under any circumstances.', false),
    (v_q_id, 'C', 'Propose a compromise where unskippable ads are shown only to users who have a retention probability score above 90%, while testing a premium ''Ad-Free'' subscription upsell to capture revenue without destroying core retention.', true),
    (v_q_id, 'D', 'Implement the unskippable ads but only on weekends when users have more free time to watch them.', false);

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
        'Shopify Payments vs. Markets — Resolving Dependencies',
        E'Shopify Markets (supporting international cross-border merchants) needs local payment methods integrated into Shopify checkout to launch in Latin America. However, the Shopify Payments core engineering team has prioritized rebuilding their ledger backend to support high-volume US merchants. Both initiatives are highly valuable.\n\nHow should the Portfolio PM resolve this roadmap conflict?',
        'intermediate',
        'Shopify',
        'Shopify is an e-commerce platform with merchant services.',
        'C',
        'When two high-value initiatives conflict due to dependencies, a portfolio PM should evaluate the opportunity costs of delaying either project (Option C). Furthermore, to unblock the bottleneck without creating technical debt or duplicating gateways (Option B), the PM can suggest a cross-functional ''tiger team'' that writes code to the core Payments team''s standards, ensuring both speed and architectural alignment. Option A ignores the massive risk of delaying core infrastructure. Option D is an unnecessary escalation that avoids analytical decision-making.',
        ARRAY['portfolio_management', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Force the Shopify Payments team to drop the US ledger project, as international expansion is more exciting.', false),
    (v_q_id, 'B', 'Tell the Shopify Markets team to build their own independent payments gateway for Latin America, bypassing Shopify Payments entirely.', false),
    (v_q_id, 'C', 'Run a trade-off analysis comparing the opportunity cost of delaying the US ledger project (potential outages or lost large merchants in the US) versus delaying the LatAm market entry, and consider allocating a temporary cross-functional ''tiger team'' to handle the LatAm integrations under the Payments team''s architecture guidelines.', true),
    (v_q_id, 'D', 'Escalate to the CEO and ask them to pick which region they like better.', false);

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
        'Figma''s Legacy Vector Import — Sunsetting Backlash',
        E'Figma''s PM for Core Editor decides to sunset a legacy vector import tool that is used by only 0.5% of monthly active users. However, this 0.5% consists of highly vocal enterprise agency design directors who threaten to migrate their teams to Sketch if the feature is removed.\n\nHow should the PM proceed?',
        'intermediate',
        'Figma',
        'Figma features vector design capabilities.',
        'C',
        'Even if a feature has low overall adoption, it may have high value or critical importance to a high-value customer segment (e.g., enterprise agency design directors). Simply deleting it (Option A) can cause catastrophic churn. The PM should engage with these users to understand the underlying need, provide a modern alternative or migration path, and manage the transition gracefully (Option C). Option B is unsustainable. Option D is not technically feasible for a cloud-based SaaS product like Figma.',
        ARRAY['kill_decision', 'product_lifecycle']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately delete the feature and ignore the users, as 0.5% is statistically insignificant.', false),
    (v_q_id, 'B', 'Keep the legacy feature forever, accepting the permanent maintenance overhead.', false),
    (v_q_id, 'C', 'Delay sunsetting and engage directly with these power users to understand their specific workflow, provide a modern alternative (e.g., a plugin or updated importer), and offer a phased transition period.', true),
    (v_q_id, 'D', 'Make the feature open-source so that users can maintain the code themselves on their own local servers.', false);

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
        'Notion Sites — Cannibalization or Expansion?',
        E'Notion is launching ''Notion Sites'' (allowing users to publish workspaces as public websites). The PM for the core Workspace product is worried this will cannibalize paid team subscriptions, as companies might just use free Notion pages published as websites instead of buying structured content tools.\n\nHow should the PM design the portfolio offering to mitigate this risk?',
        'intermediate',
        'Notion',
        'Notion supports web publishing from workspaces.',
        'B',
        'To manage cannibalization, companies must design clear product tiers where advanced or professional use-cases are monetized, while basic use-cases remain free or cheap to drive the funnel. Gating custom domains, SEO, and analytics under a paid add-on or plan (Option B) allows Notion to capture new revenue from website creators without cannibalizing standard internal team workspaces. Option A and C destroy product value and growth. Option D ignores the commercial viability of the portfolio.',
        ARRAY['cannibalization_mgmt', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Charge a high flat fee for any public page publishing, ensuring that nobody uses it.', false),
    (v_q_id, 'B', 'Gate professional website features (custom domains, SEO settings, analytics) under a paid ''Sites'' add-on or higher-tier plan, while keeping basic page sharing free, thereby converting site-publishers into paying customers.', true),
    (v_q_id, 'C', 'Disallow public page sharing completely to protect paid team workspace subscription revenue.', false),
    (v_q_id, 'D', 'Make Notion Sites completely free and unlimited to drive maximum adoption, ignoring the revenue impact on core workspaces.', false);

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
        'Google Workspace — Horizon Alignment in AI Era',
        E'In Google Workspace, PMs are managing a portfolio of AI initiatives:\n- Initiative A: Adding generative template options to Google Docs (H1 - Core enhancement).\n- Initiative B: Developing automated AI email drafting in Gmail (H2 - Growth/Adjacent).\n- Initiative C: Building autonomous AI virtual agents that attend meetings, take actions, and execute tasks across apps (H3 - Transformational).\n\nThe VP wants to shift 90% of R&D headcount to Initiative C to catch up with startup competitors. What is the main risk of this allocation?',
        'intermediate',
        'Google',
        'Google Workspace includes Gmail, Docs, Drive, and AI integrations.',
        'B',
        'While Horizon 3 (transformational) bets are crucial for long-term survival, starving the core (H1) and adjacent (H2) products of resources (Option B) leaves them vulnerable to competitors. Google Docs and Gmail generate the active users and revenue that fund H3 research. Shifting 90% of resources to H3 is an unbalanced portfolio strategy that risks immediate business decline. Option A is incorrect because H3 bets have high failure rates. Option C is a futuristic fantasy. Option D is incorrect; revenue visibility is an accounting function, not an R&D resource constraint.',
        ARRAY['horizon_planning', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'There is no risk; Horizon 3 projects should always receive 90% of resources in high-growth technology markets.', false),
    (v_q_id, 'B', 'It starves Horizons 1 and 2 of the resources needed to maintain market share and user trust in core Google Docs and Gmail, exposing Google to immediate churn to fast-following competitors.', true),
    (v_q_id, 'C', 'Autonomous agents do not require engineering resources because they write their own code.', false),
    (v_q_id, 'D', 'The executive team will lose visibility into the company''s daily revenue.', false);

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
        'AWS EC2 Latency vs. Serverless — Capital Allocation',
        E'AWS has $100M in capital to invest. The product team has two competing proposals:\n1. Project Hyper-Speed: Optimizing latency on existing EC2 instances (Core H1 business, NPV of $150M, high certainty).\n2. Project Quantum-Cloud: Building a futuristic quantum-computing serverless platform (H3 business, NPV of $40M, low certainty, but strategic positioning).\n\nHow should the AWS portfolio lead recommend allocating the capital?',
        'intermediate',
        'Amazon',
        'Amazon Web Services (AWS) provides cloud infrastructure services.',
        'C',
        'A healthy portfolio allocation balances high-certainty core optimization (H1) with long-term strategic bets (H3). Funding only the core (Option B) leads to future irrelevance when technology shifts. Funding only the long-term bet (Option A) ignores immediate high-value returns (NPV of $150M) and cash flows. The balanced approach (Option C) ensures near-term stability while investing in future capabilities. Option D is an unnecessary deferral of capital allocation.',
        ARRAY['capital_allocation', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Allocate the entire $100M to Project Quantum-Cloud to appear innovative to investors.', false),
    (v_q_id, 'B', 'Allocate the entire $100M to Project Hyper-Speed because it has a higher NPV and higher certainty.', false),
    (v_q_id, 'C', 'Allocate the majority of the capital (e.g., $80M) to Project Hyper-Speed to secure the core revenue and high-certainty return, and allocate the remainder ($20M) to Project Quantum-Cloud to establish a foothold in quantum computing.', true),
    (v_q_id, 'D', 'Postpone both projects and return the $100M to the corporate treasury.', false);

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
        'Airbnb Split Stays — Sunsetting Niche Features',
        E'Airbnb launched ''Split Stays'' (allowing users to split long stays across two different homes). Data shows that only 1.2% of bookings use Split Stays, but those users have an NPS of +85 (extremely high satisfaction). The engineering maintenance cost is $50k/month.\n\nWhat should the PM do?',
        'intermediate',
        'Airbnb',
        'Airbnb allows users to split bookings between multiple properties.',
        'C',
        'When evaluating niche features for sunsetting, PMs must look beyond simple adoption rates to understand the depth of value (NPS) and economic impact (LTV, referrals). If the feature drives disproportionate value for a high-value cohort, keeping it might make sense. If the maintenance cost is too high, the PM should look to simplify the technical implementation (lowering maintenance) before killing it outright (Option C). Option A is too hasty. Option B ignores the ongoing cost. Option D is a coercive UX pattern that will destroy user experience.',
        ARRAY['kill_decision', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Kill the feature immediately to save the $50k/month maintenance cost.', false),
    (v_q_id, 'B', 'Keep the feature as-is and do nothing, as +85 NPS is too high to lose.', false),
    (v_q_id, 'C', 'Evaluate whether the high satisfaction of this 1.2% cohort leads to increased lifetime value (LTV) or word-of-mouth referrals that offset the $50k/month cost, and if not, design a simplified, lower-maintenance version of the feature before making a final kill decision.', true),
    (v_q_id, 'D', 'Force all users to split their stays to artificially increase the adoption rate of the feature.', false);

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
        'Stripe Tax — The Pivot vs. Kill Decision',
        E'Stripe Tax has been in development for 2 years and has consumed $8M in R&D. Since launch, adoption has been 10x lower than projected. Sales teams report that enterprise customers refuse to buy it because it lacks support for multi-state VAT compliance, which would cost another $3M and 9 months to build.\n\nHow should the Portfolio PM evaluate this situation?',
        'intermediate',
        'Stripe',
        'Stripe Tax automates sales tax, VAT, and GST compliance.',
        'B',
        'This scenario tests the ability to resist the sunk cost fallacy (the $8M spent) and make a rational governance decision. Before committing another $3M (Option A), the PM must validate the future market opportunity and ensure that VAT compliance is indeed the only blocker (Option B). If the market analysis is negative, the project should be shut down or pivoted. Option C blames the team instead of addressing the portfolio strategy. Option D would likely drive away the few remaining customers.',
        ARRAY['sunk_cost_fallacy', 'kill_decision']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Invest the $3M immediately because the company has already spent $8M, so stopping now would mean wasting the initial investment.', false),
    (v_q_id, 'B', 'Pause further development, conduct a rigorous competitive and customer segment analysis to validate if adding VAT support will actually unlock the enterprise market, and write off the $8M if the market opportunity is no longer viable.', true),
    (v_q_id, 'C', 'Fire the engineering team for failing to build VAT compliance in the first place.', false),
    (v_q_id, 'D', 'Double the price of Stripe Tax to recover the $8M R&D cost from the few existing customers.', false);

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
        'DoorDash Drive — Shared Constraint Risk',
        E'DoorDash has two main business lines: DoorDash Consumer App (marketplace delivery) and DoorDash Drive (white-label delivery for merchants like Walmart). Both lines rely on the same pool of delivery drivers. During peak hours (5 PM - 8 PM), driver supply is constrained, leading to unfulfilled orders on both sides.\n\nHow should the Portfolio PM manage this shared constraint?',
        'intermediate',
        'DoorDash',
        'DoorDash shares logistics drivers between direct orders and white-label delivery.',
        'A',
        'When multiple products in a portfolio share a constrained resource (like drivers), the PM must optimize for the total portfolio''s value and strategic commitments. Option A balances short-term profitability (dynamic allocation based on net margin) with contractual risk management (ensuring SLA thresholds are met for enterprise partners). Option B violates B2B SLAs. Option C is a rigid allocation that ignores demand fluctuations and margins. Option D increases operational complexity and costs, defeating the purpose of a shared logistics network.',
        ARRAY['portfolio_management', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Prioritize driver allocation dynamically to whichever order has the highest net margin contribution to DoorDash, while setting SLA thresholds for Drive merchants to protect contract agreements.', true),
    (v_q_id, 'B', 'Reserve 100% of drivers for the Consumer App because DoorDash owns the customer relationship.', false),
    (v_q_id, 'C', 'Split the driver pool 50/50 during peak hours, regardless of order volume or profit margins.', false),
    (v_q_id, 'D', 'Hire exclusive drivers for DoorDash Drive who are legally barred from delivering Consumer App orders.', false);

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
        'Shopify POS vs. Online Store — Roadmap Dependency',
        E'Shopify POS (Point of Sale for physical retail) and Shopify Online Store are separate product lines, but both require updates to the core ''Inventory Sync API'' (managed by the Shared Platform Team) to support multi-location stock tracking. The Platform Team can only support one integration this quarter.\n\nHow should the Shopify Portfolio PM resolve this?',
        'intermediate',
        'Shopify',
        'Shopify synchronizes retail and web inventory.',
        'C',
        'Rather than picking one product line over another based on historical bias (Option A) or temporary events (Option B), a platform portfolio approach focuses on building reusable, extensible capabilities. By designing an extensible API (Option C), the platform team solves the underlying issue for both product lines and avoids future bottlenecks. Option D creates technical debt and breaks inventory consistency across the platform.',
        ARRAY['portfolio_management', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Choose the Online Store because Shopify is historically an e-commerce platform.', false),
    (v_q_id, 'B', 'Prioritize the POS team because they have a physical retail conference coming up next month.', false),
    (v_q_id, 'C', 'Evaluate the business value (e.g., GMV impact, churn risk) of both integrations, and have the Platform Team build a unified, extensible API that allows both POS and Online teams to self-serve their integrations over the next two quarters.', true),
    (v_q_id, 'D', 'Cancel the Inventory Sync API update and ask both teams to build their own local database tables.', false);

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
        'Netflix R&D Budget — Strategic Allocation Framework',
        E'Netflix''s VP of Product is allocating a $150M R&D budget for the next fiscal year. The proposals are:\n- Proposal A: Core Video Streaming (compression, CDN latency) -> Mature. Projected to reduce global churn by 0.1% (Value: $40M).\n- Proposal B: Ad-Supported Tech (programmatic ad-bidding integrations) -> Growth. Projected to capture $80M in incremental ad revenue.\n- Proposal C: Cloud Gaming Infrastructure (expanding server capacity) -> Introduction. Revenue is highly uncertain, but strategic positioning is vital to combat long-term competition from social media.\n\nThe current budget allocation proposal is $50M to each. How should the VP optimize this portfolio?',
        'advanced',
        'Netflix',
        'Netflix manages large budgets across streaming, ad-tech, and games.',
        'C',
        'Advanced portfolio prioritization requires optimizing capital allocation based on the lifecycle stage and expected returns of each bet. Core Video is mature and highly optimized; spending $50M for a $40M return suggests diminishing returns, so a leaner budget ($30M) focusing on efficiency is appropriate. Ad-Supported Tech is in its growth phase with high customer demand, justifying a larger allocation ($90M) to capture the market opportunity rapidly. Cloud Gaming is an H3 exploratory bet; it needs funding to build core capabilities, but allocating $50M is too high given the uncertainty—limiting it to $30M maintains capital discipline (Option C). Option A is a lazy political compromise. Option B ignores long-term strategic threats. Option D kills future growth engines prematurely.',
        ARRAY['capital_allocation', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the equal $50M split because equal funding ensures fairness and prevents internal political conflicts between product divisions.', false),
    (v_q_id, 'B', 'Allocate 100% to Ad-Supported Tech because it has the highest near-term financial return ($80M).', false),
    (v_q_id, 'C', 'Shift funding to allocate $30M to Core (highly optimized efficiency), $90M to Ad-Supported Tech (capturing massive near-term growth market), and $30M to Cloud Gaming (securing H3 capability while maintaining capital discipline).', true),
    (v_q_id, 'D', 'Cancel Cloud Gaming entirely and shift its $50M to Core Video Streaming to maximize user video quality.', false);

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
        'Spotify Audiobooks — Net Portfolio Value Modeling',
        E'Spotify is considering adding 15 hours of free audiobook listening per month to the existing Spotify Premium tier ($15/month). The finance team provides the following projections:\n- Incremental content licensing cost: $1.20 per user per month.\n- Projected music streaming cannibalization: Music consumption will drop by 8%, saving Spotify $0.30 per user per month in music royalties.\n- Premium subscriber churn reduction: Churn will decrease from 2.0% to 1.8% per month. (Average Premium user LTV is $300).\n\nAssuming a cohort of 10 million Premium subscribers, what is the net portfolio financial impact of this decision, and should the PM prioritize it?',
        'advanced',
        'Spotify',
        'Spotify is analyzing the financial feasibility of bundling audiobooks.',
        'A',
        'Let''s calculate the net portfolio impact: 1) Net monthly cost increase per user = $1.20 - $0.30 (music royalty savings) = $0.90 per user. For 10M subscribers, the monthly cost increase is 10M * $0.90 = $9,000,000. 2) Churn reduction is 0.2% per month (from 2.0% to 1.8%). Subscribers saved per month = 10,000,000 * 0.002 = 20,000 subscribers. LTV of a subscriber is $300. Total saved value per month = 20,000 * $300 = $6,000,000. 3) Net monthly portfolio impact = Saved Value ($6M) - Net Cost ($9M) = -$3,000,000 (a net loss of $3M/month). Option A correctly calculates this loss and advises rejecting the free bundle (Option A). Option B ignores music royalty savings. Option C incorrectly uses the monthly fee instead of LTV. Option D ignores the licensing cost.',
        ARRAY['cannibalization_mgmt', 'portfolio_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Yes. The monthly net cost increase is $0.90 per user ($9M/month total). The 0.2% monthly churn reduction saves 20,000 subscribers per month. At an LTV of $300, this saves $6M/month in customer value. This leads to a net negative portfolio value of -$3M/month, so the PM should reject the feature.', true),
    (v_q_id, 'B', 'Yes. The monthly net cost increase is $1.20 per user ($12M/month total). The 0.2% monthly churn reduction saves 20,000 subscribers per month. At an LTV of $300, this saves $6M/month. This leads to a net loss of -$6M/month, so the PM should reject it.', false),
    (v_q_id, 'C', 'Yes. The monthly net cost increase is $0.90 per user ($9M/month total). The 0.2% churn reduction means saving 20,000 subscribers. Their monthly subscription revenue is $15 ($300k/month total). This leads to a net loss of -$8.7M/month, so the PM should reject it.', false),
    (v_q_id, 'D', 'No. The music cannibalization saving of $0.30/user ($3M/month total) is the only factor that matters, making it immediately profitable.', false);

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
        'YouTube Shorts — Horizon Transition & Resource Reallocation',
        E'YouTube Shorts has transitioned from an H3 experimental project to an H1 core product, driving 50 billion daily views. The VP of Product wants to reallocate 40 engineers from the YouTube Desktop Watch Page team (highly profitable, mature, stable) to the Shorts Monetization team. The Desktop PM team strongly objects, arguing that a decline in Desktop performance will directly harm YouTube''s main ad-revenue generator.\n\nHow should the Portfolio PM design the resource transition plan?',
        'advanced',
        'Google',
        'YouTube manages transition from experimental formats to core video platforms.',
        'B',
        'Transitioning resources from a mature cash cow (Desktop) to a high-growth scale-up (Shorts) is a critical portfolio alignment challenge. Simply pulling 40 engineers on day one (Option C) can lead to operational failures on the core platform. A phased approach (Option B) ensures that the mature product''s stability is preserved by focusing first on automation and efficiency, before transferring headcount. Option A violates budget constraints. Option D ignores the strategic growth of Shorts.',
        ARRAY['horizon_planning', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Cancel the transition and hire 40 new engineers from the outside, ignoring budget caps.', false),
    (v_q_id, 'B', 'Implement a phased reallocation where the Desktop team is first tasked with optimizing their platform for low-maintenance automation, and then transition engineers to Shorts in batches as specific operational-efficiency milestones are met.', true),
    (v_q_id, 'C', 'Reallocate all 40 engineers immediately on day one, and tell the Desktop team to ''do more with less.''', false),
    (v_q_id, 'D', 'Freeze the Shorts Monetization roadmap and focus entirely on Desktop until desktop traffic stops declining.', false);

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
        'Airbnb PMS API Sunsetting — Managing Strategic Risk',
        E'Airbnb is sunsetting its legacy v2 SOAP API, which is used by 300 Property Management Systems (PMS) representing 15% of Airbnb''s global listing inventory. The new GraphQL API offers real-time synchronization, which reduces double-bookings by 40%. However, migrating to the GraphQL API requires the PMS companies to rewrite their integrations, costing them up to $50k each. Several large PMS systems threaten to pull their listings and prioritize Booking.com if forced to migrate.\n\nWhat is the optimal portfolio risk-mitigation strategy?',
        'advanced',
        'Airbnb',
        'Airbnb manages API developer platforms for property management systems (PMS).',
        'B',
        'Sunsetting a legacy integration that controls 15% of listings requires a proactive risk-mitigation plan. Gating the migration timeline (12 months) and subsidizing/supporting the high-impact partners (the Pareto principle: top 20 represent 80% of volume) minimizes the risk of partner churn while ensuring the technology platform progresses (Option B). Option A allows technical debt to halt platform progress. Option C is commercially destructive. Option D creates permanent technical debt, negating the benefits of sunsetting the SOAP API.',
        ARRAY['kill_decision', 'product_lifecycle']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the SOAP API active indefinitely to avoid losing the 15% listing inventory.', false),
    (v_q_id, 'B', 'Provide a dedicated integration support team, offer developer grants (financial subsidies) to the top 20 PMS systems that represent 80% of the risk volume, and set a hard deprecation date of 12 months out.', true),
    (v_q_id, 'C', 'Shut down the SOAP API immediately and sue any PMS system that pulls their listings for breach of contract.', false),
    (v_q_id, 'D', 'Build a middleware layer that translates SOAP calls to GraphQL indefinitely, absorbing the technical debt internally.', false);

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
        'Uber Freight — Sunk Cost Fallacy & Strategic Buy vs. Build',
        E'Uber Freight spent $120M over 3 years building an internal warehouse management platform. Right before launch, a competitor launches a superior open-source warehouse system that has become the industry standard. A third-party SaaS vendor offers an enterprise integration of this system for $2M/year.\n\nThe Uber Freight VP insists: ''We spent $120M of Uber''s capital on this platform. If we don''t launch it, we will have to write down $120M on the balance sheet, which will hurt our stock price. We must launch and maintain our own platform.''\n\nWhat is the correct portfolio governance action?',
        'advanced',
        'Uber',
        'Uber Freight provides logistics and fleet management software.',
        'B',
        'The $120M spent is already a sunk cost. From an accounting perspective, keeping a failing or inferior asset active to avoid a write-down is a form of window-dressing that leads to ongoing operational inefficiency. Integrating the superior SaaS solution and redirecting engineering to core proprietary moats (routing algorithms) creates the highest long-term enterprise value (Option B). Option A perpetuates the sunk cost fallacy and hurts product competitiveness. Option C is highly inefficient and increases costs. Option D is unrealistic as no competitor would pay $120M for an inferior system.',
        ARRAY['sunk_cost_fallacy', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Support the VP''s launch plan because writing off $120M will trigger negative investor sentiment and lower stock value.', false),
    (v_q_id, 'B', 'Recommend integrating the third-party SaaS platform, writing off the $120M internal asset, and reallocating the internal maintenance engineers to building proprietary routing algorithms (which represent Uber''s real moat).', true),
    (v_q_id, 'C', 'Launch the internal platform, but also pay the $2M/year SaaS fee to run both systems in parallel for backup.', false),
    (v_q_id, 'D', 'Sell the internal platform to a competitor for $120M to break even.', false);

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
        'Airbnb Logistics vs. Capital — Portfolio Correlation',
        E'Airbnb is considering launching two major initiatives:\n1. Airbnb Logistics: A network of co-hosted storage units for hosts to store extra linens and cleaning supplies.\n2. Airbnb Capital: A merchant cash advance program for hosts to purchase properties or fund renovations.\n\nDuring a macroeconomic stress test, the PM models that a severe travel recession would lead to: a 30% drop in Airbnb bookings, a 25% default rate on Airbnb Capital loans (as hosts lose income), and a 40% vacancy rate in Airbnb Logistics units. How should the Portfolio PM adjust the investment levels of these initiatives?',
        'advanced',
        'Airbnb',
        'Airbnb models systemic portfolio risk under macroeconomic constraints.',
        'B',
        'Advanced portfolio management requires evaluating how macroeconomic shocks impact correlated risks. Both Airbnb Capital and Airbnb Logistics are pro-cyclical bets that are highly correlated with travel volumes. If travel drops, loans default and warehouses sit empty. To manage this systemic risk, the PM should hedge the portfolio by reducing exposure to credit risk (Airbnb Capital), utilizing asset-light models for operations (Logistics), and focusing resources on counter-cyclical or resilient segments like domestic staycations (Option B). Option A ignores risk management. Option C is a reckless pivot that abandons the core asset. Option D is not a viable business strategy.',
        ARRAY['portfolio_management', 'strategic_investment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Fund both fully because the high profit margins during boom years will cover any recession losses.', false),
    (v_q_id, 'B', 'Hedge the portfolio by reducing the allocation to Airbnb Capital (high credit risk correlation with travel volume) and shift resources to developing domestic staycation features, while scaling Airbnb Logistics slowly using an asset-light partnership model.', true),
    (v_q_id, 'C', 'Shut down the core accommodation business and pivot 100% of the company into merchant cash lending.', false),
    (v_q_id, 'D', 'Rely on government bailouts to cover host defaults, keeping the portfolio allocation unchanged.', false);

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
        'Slack Workflows — Platformization vs. Feature Roadmaps',
        E'Slack''s platform team proposes a complete architectural rewrite of ''Workflow Builder.'' This rewrite will take 2 quarters and consume 100% of their engineering capacity. During this time, three feature teams (Slack Huddles, Slack Canvas, and Enterprise Grid) will be blocked from launching any integrations.\n\nHow should the VP of Product evaluate this platform bet?',
        'advanced',
        'Slack',
        'Slack trades off platform infrastructure rewrites against feature team speed.',
        'C',
        'This tests the advanced ability to trade off platform infrastructure investments against immediate business feature delivery. A platform rewrite is a long-term efficiency play. The VP of Product should evaluate it using net present value (NPV) or a similar quantitative framework: does the long-term acceleration and reduction of technical debt (e.g., integration time dropping from 6 weeks to 1 week) outweigh the near-term cost of blocking features for 2 quarters? Option C represents this rigorous, value-driven prioritization. Option A and B are dogmatic responses that ignore either business value or technical health. Option D represents a ''middle-ground'' trap that increases the duration of pain for all teams and reduces focus.',
        ARRAY['portfolio_management', 'resource_allocation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reject the rewrite because a 2-quarter block on three active product lines will slow down near-term feature delivery.', false),
    (v_q_id, 'B', 'Approve the rewrite immediately because technical platform hygiene always takes precedence over business features.', false),
    (v_q_id, 'C', 'Require the platform team to present a business case detailing how the new architecture will reduce future integration time for Huddles, Canvas, and Enterprise Grid (e.g., from 6 weeks to 1 week), and only approve the rewrite if the long-term acceleration NPV exceeds the opportunity cost of the 2-quarter delay.', true),
    (v_q_id, 'D', 'Split the platform team''s resources: 50% on the rewrite and 50% supporting the blocked teams, prolonging the rewrite to 6 quarters.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Portfolio Prioritization';

END $$;