-- ============================================
-- ASSESSMENT: Go-to-Market Strategy
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
    WHERE slug = 'go-to-market-strategy';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug go-to-market-strategy not found. Run the seed data first.';
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
        'Slack''s Private Beta Access',
        'Slack is launching a new asynchronous video clip sharing feature ("Slack Clips") to its user base. The PM must decide between releasing a private beta to a cohort of 50 enterprise customers or running an open public beta for all free and paid teams.

What is the primary strategic risk of choosing an open public beta instead of a private beta for this type of collaborative feature?',
        'foundational',
        'Slack',
        'Collaboration Platform',
        'C',
        'For highly visible collaborative tools, an open public beta exposes unpolished features to the entire market. If the feature experiences bugs, lack of adoption, or poor user experience, it can publicly damage the product''s reputation before the team has a chance to iterate. A private beta allows the PM to control the feedback loop, work closely with high-value customers to refine the value proposition, and iron out technical bugs in a low-stakes environment. While scaling issues (Option B) and support load (Option D) are operational concerns, they are secondary to the strategic risk of brand degradation and premature market positioning failure.',
        ARRAY['launch_planning', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The feature will not gather enough diverse usage telemetry to optimize the UI.', false),
    (v_q_id, 'B', 'Technical scaling limits will be reached immediately due to high video processing overhead.', false),
    (v_q_id, 'C', 'Negative feedback or bugs will be amplified publicly before product-market fit or stability is proven.', true),
    (v_q_id, 'D', 'The customer support team will be overwhelmed by tickets from non-paying users.', false);

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
        'Netflix''s India Market Entry',
        'When Netflix entered the Indian market, they initially launched with their standard global pricing tiers, which were significantly higher than local competitors like Hotstar. Churn was high and adoption was slow. The PM team is considering launching a low-cost, mobile-only streaming plan.

What is the primary strategic trade-off Netflix must accept when introducing this market-entry pricing tier?',
        'foundational',
        'Netflix',
        'Video Streaming Service',
        'B',
        'When introducing a cheaper tier to capture a highly price-sensitive market, the primary strategic risk is "cannibalization" — existing subscribers who would have paid for the higher tier downgrading to the cheaper one, thereby diluting ARPU. Netflix mitigated this by restricting the mobile-only plan to standard-definition streaming on a single mobile screen, ensuring that users who value the high-definition, multi-screen living room experience remain on the higher tiers. This strategic constraint limits the overlap in value proposition, minimizing cannibalization while opening up a new demographic segment.',
        ARRAY['market_entry', 'pricing_models', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Increased infrastructure costs due to high mobile bandwidth consumption.', false),
    (v_q_id, 'B', 'Potential average revenue per user (ARPU) dilution from existing users downgrading to the cheaper mobile plan.', true),
    (v_q_id, 'C', 'Severe brand dilution from moving away from a premium positioning.', false),
    (v_q_id, 'D', 'A high volume of customer support tickets requesting TV streaming access from mobile accounts.', false);

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
        'Zoom''s 40-Minute Free Limit',
        'Zoom''s freemium model allows users to host unlimited one-on-one meetings but imposes a 40-minute limit on meetings with three or more participants.

As the GTM PM for Zoom''s self-serve growth team, why is this specific 40-minute limit on group meetings an effective freemium conversion gate compared to limiting the total number of meetings per month?',
        'foundational',
        'Zoom',
        'Video Conferencing Software',
        'B',
        'An effective freemium gate limits usage along the dimension of highest business value rather than trying to cut off basic habits. Group meetings of three or more people are typically professional, work-related discussions (e.g., team meetings, client pitches), whereas one-on-one meetings are often casual or low-stakes. By cutting off group meetings at 40 minutes, Zoom creates natural, high-urgency friction right when a team is trying to collaborate. This prompts the host to upgrade to a paid tier to avoid future interruptions in front of colleagues or clients, without preventing individual users from habituating to the tool for personal one-on-one calls.',
        ARRAY['pricing_models', 'gtm_strategy', 'self_serve_vs_sales']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It targets individual consumers who have the highest propensity to pay.', false),
    (v_q_id, 'B', 'It creates friction precisely at the moment of highest business value (collaboration involving multiple stakeholders), prompting conversion when urgency is high.', true),
    (v_q_id, 'C', 'It reduces Zoom''s bandwidth costs for long meetings, which is the primary driver of freemium gross margins.', false),
    (v_q_id, 'D', 'It prevents non-paying users from building a habit of using Zoom for regular team check-ins.', false);

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
        'Stripe''s Self-Serve Developer Channels',
        'Stripe launched its payment APIs by bypassing traditional corporate procurement (CFO/CIO negotiations) and focusing entirely on a direct-to-developer self-serve distribution model.

What is the primary GTM benefit of this developer-first distribution channel strategy?',
        'foundational',
        'Stripe',
        'Payments Infrastructure',
        'B',
        'By focusing on developers, Stripe built a frictionless self-serve flow with clean documentation, enabling engineers to integrate Stripe in hours without talking to a sales representative. This bottom-up adoption allowed Stripe to enter companies via engineering teams who championed the product to their leadership, dramatically lowering CAC and speeding up market penetration. While Stripe eventually built enterprise sales teams to capture large-scale contracts, the developer-first self-serve channel was the foundational driver of their early velocity and market disruption.',
        ARRAY['distribution_channels', 'self_serve_vs_sales', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Bypassing the need for regulatory compliance checks during merchant onboarding.', false),
    (v_q_id, 'B', 'Reducing Customer Acquisition Cost (CAC) by leveraging developer advocacy to drive bottom-up adoption inside organizations.', true),
    (v_q_id, 'C', 'Maximizing initial contract value from enterprise clients who sign up through the website.', false),
    (v_q_id, 'D', 'Eliminating the need to build a sales team or provide customer support.', false);

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
        'Duolingo''s Streak Sharing Mechanics',
        'Duolingo''s product team wants to launch a new "Streak Sharing" feature, allowing users to share their language learning milestones directly to Instagram Stories and Twitter/X with a referral link.

What GTM distribution goal is this feature primarily designed to achieve?',
        'foundational',
        'Duolingo',
        'Language Learning App',
        'C',
        'Streak sharing serves as an organic acquisition loop (virality) that leverages the existing users'' pride in their consistency. When users share their streaks on social media, they are effectively advertising Duolingo to their social networks. The embedded referral links create a low-friction entry point for new users, thereby reducing the blended Customer Acquisition Cost (CAC) of the platform. This is a classic Product-Led Growth (PLG) distribution tactic that weaponizes user engagement for customer acquisition.',
        ARRAY['distribution_channels', 'launch_success', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Increasing the average daily active user count of existing premium subscribers.', false),
    (v_q_id, 'B', 'Enhancing the instructional quality of Duolingo''s gamified learning experience.', false),
    (v_q_id, 'C', 'Driving low-cost organic user acquisition via a viral loop built directly into the core user habit.', true),
    (v_q_id, 'D', 'Boosting the conversion rate from free accounts to paid Super Duolingo subscriptions.', false);

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
        'Spotify''s Family Plan Packaging',
        'Spotify packages its premium service into Single, Duo, and Family plans. The Family plan allows up to six accounts living under the same roof to share a subscription for a price that is less than the cost of two individual subscriptions.

What is the primary GTM metric that this packaging strategy aims to optimize?',
        'foundational',
        'Spotify',
        'Audio Streaming Platform',
        'A',
        'While the Spotify Family plan has a lower ARPU per head compared to individual plans, it is highly strategic for reducing churn. When multiple family members rely on a single subscription, the collective switching cost increases significantly. If one family member wants to switch to a competitor (like Apple Music), they face the friction of migrating playlists and preferences for the entire household or convincing the account holder to cancel. This strong multi-user lock-in makes the family tier a powerful retention engine for Spotify.',
        ARRAY['packaging', 'bundling_strategy', 'pricing_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Minimizing churn rates by increasing household dependency and switching costs.', true),
    (v_q_id, 'B', 'Maximizing Average Revenue Per User (ARPU) across all premium accounts.', false),
    (v_q_id, 'C', 'Maximizing ad-supported revenue from family members who do not stream music.', false),
    (v_q_id, 'D', 'Reducing licensing royalty payments to record labels.', false);

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
        'Notion''s Personal vs. Team Positioning',
        'Notion originally launched as a personal wiki and notes app for individuals. As they planned their Go-to-Market strategy to capture the enterprise market, they had to define a new value proposition.

Which of the following best describes the shift in value proposition Notion needed to convey to appeal to enterprise buyers?',
        'foundational',
        'Notion',
        'Collaborative Workspace Document Tool',
        'B',
        'To enter the business/enterprise market, a product must shift its positioning from individual utility (which appeals to practitioners) to organizational efficiency (which appeals to buyers/managers). Enterprise buyers do not buy tools for aesthetic personalization; they buy tools to solve operational pain points like information silos, duplicate tool spend, and lack of cross-functional alignment. Notion''s GTM pivoted toward "The All-in-One Workspace" for teams, focusing on collaborative databases, shared wikis, and project tracking to establish their business-grade value proposition.',
        ARRAY['value_proposition', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Emphasizing the aesthetic customization options, custom fonts, and emoji layouts of the workspace.', false),
    (v_q_id, 'B', 'Pivoting from "organize your personal life" to "unify your company''s scattered knowledge and break down team silos."', true),
    (v_q_id, 'C', 'Highlighting the low monthly price of a personal subscription compared to competitors.', false),
    (v_q_id, 'D', 'Focusing on offline-first editing capabilities for remote travelers.', false);

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
        'HubSpot''s MQL to SQL Handover',
        'HubSpot''s marketing team is launching a new inbound marketing campaign for their Sales Hub. To ensure high conversion rates, the product marketing PM must define the criteria for transitioning leads from Marketing Qualified Leads (MQLs) to Sales Qualified Leads (SQLs).

What is the primary purpose of defining a clear MQL-to-SQL handover process in a GTM plan?',
        'foundational',
        'HubSpot',
        'Inbound Marketing and Sales Software',
        'B',
        'A common point of failure in GTM execution is alignment between marketing and sales. If marketing passes every lead (e.g., someone who just downloaded a free ebook) directly to sales, the sales team becomes overwhelmed with cold leads, leading to low conversion rates and wasted sales time. Defining SQL criteria ensures that only leads with clear buying intent (e.g., booked a demo, fits target company size, requested pricing) are routed to sales reps, optimizing sales efficiency and maintaining GTM campaign ROI.',
        ARRAY['self_serve_vs_sales', 'launch_success']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To automate the billing setup for newly closed deals.', false),
    (v_q_id, 'B', 'To ensure sales representatives spend their time only on prospects who meet specific demographic and intent criteria, preventing lead fatigue and low sales efficiency.', true),
    (v_q_id, 'C', 'To force marketing to spend their entire budget on outbound advertising channels.', false),
    (v_q_id, 'D', 'To eliminate the need for product usage telemetry inside the CRM.', false);

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
        'Airbnb''s City Launch Metrics',
        'Airbnb is launching in a new metropolitan city. In a two-sided marketplace, the GTM PM must focus on supply-demand dynamics.

Which metric is the most critical leading indicator of a successful geographic launch during the first 30 days?',
        'foundational',
        'Airbnb',
        'Short-Term Rental Marketplace',
        'B',
        'For two-sided marketplaces, supply liquidity is the ultimate leading indicator of market viability. If users download the app (Option A) but find no available or appealing listings, they will churn immediately and may never return. A healthy ratio of active listings to search volume ensures that the early demand (searches) is met with adequate supply options, leading to successful match rates (bookings). Over time, this builds the liquidity flywheel that sustains the market.',
        ARRAY['launch_success', 'market_entry']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The total number of mobile app downloads in the target city.', false),
    (v_q_id, 'B', 'The ratio of active, high-quality room listings to search volume in the city.', true),
    (v_q_id, 'C', 'The gross booking value (GBV) generated from international tourists.', false),
    (v_q_id, 'D', 'The customer satisfaction score (CSAT) of support tickets submitted.', false);

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
        'Shopify''s Transaction Fee Structure',
        'Shopify charges merchants a monthly subscription fee (e.g., $39/mo for Basic) but also charges a credit card processing fee (e.g., 2.9% + 30¢ per transaction) unless they use Shopify Payments.

What is the main strategic rationale for aligning Shopify''s GTM pricing models around both subscription and transaction-based charges?',
        'foundational',
        'Shopify',
        'E-commerce Platform',
        'B',
        'By combining subscription fees with usage/transaction fees, Shopify creates a pricing structure that aligns with merchant success. A low flat subscription fee lowers the barrier to entry for new, small businesses, increasing market penetration. As those merchants grow and process more sales, Shopify captures more revenue via transaction processing fees. This allows Shopify to capture a share of the massive business value they help generate, without pricing out small merchants who are just starting.',
        ARRAY['pricing_models', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To subsidize the cost of hosting large e-commerce websites on their servers.', false),
    (v_q_id, 'B', 'To capture more value as the customer scales (monetizing value) while keeping the entry barrier low for new merchants.', true),
    (v_q_id, 'C', 'To discourage merchants from growing too large and requiring enterprise support resources.', false),
    (v_q_id, 'D', 'To match the exact pricing structures of legacy physical hardware POS systems.', false);

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
        'Canva''s Pro Feature Packaging',
        'Canva''s growth team is evaluating where to draw the line between their Free and Pro packages. Currently, they are deciding whether the "One-Click Magic Resizer" (which allows users to instantly convert an Instagram post size into a presentation size) should be a Pro feature or free. The product data shows:
- Resizing is highly requested by power users who design for multiple channels.
- Basic canvas design tools are used by 95% of active users.
- 60% of free users drop off if they encounter too many pop-up premium gates during their first design session.

Where should the PM place the "Magic Resizer" gate, and why?',
        'intermediate',
        'Canva',
        'Graphic Design Platform',
        'B',
        'Effective packaging requires separating features that drive basic value and retention (core canvas editing) from features that drive premium expansion (efficiency tools for professionals, like bulk resizing). If Canva gates the core editor, they will destroy their growth flywheel (60% drop-off). However, "Magic Resizing" is specifically valuable to marketing professionals and business owners who need to repurpose content across platforms — a cohort that has a high willingness to pay. Placing this behind the Pro gate targets the right monetization profile without harming the top-of-funnel active user loop.',
        ARRAY['packaging', 'pricing_models', 'self_serve_vs_sales']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep it free to maximize early user activation and daily active usage.', false),
    (v_q_id, 'B', 'Put it behind the Pro gate because it solves a high-value, professional pain point (multi-channel publishing) that separates casual creators from monetization-ready power users, without blocking basic activation.', true),
    (v_q_id, 'C', 'Make it a usage-based microtransaction where users pay $0.50 per resize.', false),
    (v_q_id, 'D', 'Put it in the free tier but limit users to 1 resize per year to create a teaser effect.', false);

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
        'Uber''s Surge Pricing vs. Competitor Entry',
        'A local ride-sharing competitor enters a city where Uber has 80% market share. The competitor is subsidizing rides, offering flat 30% discounts to riders and guaranteed higher hourly pay for drivers. Uber''s dynamic surge pricing model is automatically triggering during peak hours, making Uber rides double the cost of the competitor.

How should the Uber GTM PM adjust their pricing strategy to defend market share?',
        'intermediate',
        'Uber',
        'Ride-Hailing Marketplace',
        'B',
        'Disabling surge pricing (Option A) destroys the market-clearing mechanism of the marketplace, leading to severe supply shortages (no drivers during peak hours) and long wait times, which harms the user experience more than high prices. Alternatively, raising rates (Option C) speeds up rider defection. The correct GTM response is to defend the liquidity flywheel. Uber should maintain the dynamic pricing algorithm to balance supply/demand but deploy tactical marketing promotions (discounts for frequent riders) and temporary driver bonuses (earnings guarantees) to keep both sides of the marketplace active until the competitor''s subsidy budget runs out.',
        ARRAY['pricing_models', 'market_entry', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Permanently disable surge pricing in that city to match the competitor''s flat rates.', false),
    (v_q_id, 'B', 'Maintain surge pricing but launch a targeted loyalty promotion for high-value riders and temporary driver incentives to protect marketplace liquidity.', true),
    (v_q_id, 'C', 'Immediately increase surge multipliers to maximize revenue from the remaining loyal riders.', false),
    (v_q_id, 'D', 'Force drivers into exclusive contracts that legally forbid them from driving for other platforms.', false);

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
        'Salesforce''s AppExchange Partner Strategy',
        'Salesforce is planning the GTM strategy for their new Service Cloud features. Instead of building integrations for every niche customer service tool in-house, they leverage their AppExchange directory, allowing third-party developers to build and sell integrations.

What is the primary distribution benefit of this indirect channel strategy?',
        'intermediate',
        'Salesforce',
        'Enterprise CRM Platform',
        'B',
        'An app store or ecosystem model (like Salesforce AppExchange) is an indirect distribution channel that drives platform stickiness. By allowing partners to build vertical-specific solutions, Salesforce can address long-tail customer requirements without diluting their internal engineering focus. This creates a massive moat: customers get the exact integrations they need, making it nearly impossible for them to switch to a competitor without breaking their entire software stack. While partners pay a rev-share, the primary driver is platform lock-in and expanded market reach, not direct listing revenue.',
        ARRAY['distribution_channels', 'gtm_strategy', 'bundling_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It shifts the responsibility of data security compliance entirely to the third-party partners.', false),
    (v_q_id, 'B', 'It expands Salesforce''s functional footprint into niche industries at zero R&D cost, creating platform network effects and high customer switching costs.', true),
    (v_q_id, 'C', 'It allows Salesforce to fire their direct sales force and rely entirely on partners to close deals.', false),
    (v_q_id, 'D', 'It guarantees that Salesforce receives 100% of the revenue generated by third-party app listings.', false);

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
        'GitHub''s Advanced Security Packaging',
        'GitHub is launching "GitHub Advanced Security" (GHAS), which includes automated code scanning, secret detection, and dependency review. Standard GitHub enterprise seats cost $21/user/month. Market research indicates that Chief Information Security Officers (CISOs) are highly concerned about security breaches, whereas developers prioritize speed and integration.

How should GitHub package GHAS?',
        'intermediate',
        'GitHub',
        'Developer Platform',
        'B',
        'GTM success relies on matching packaging and pricing to the buyer''s value perception. CISOs (the security buyers) have a high willingness to pay for risk mitigation and compliance, whereas developers (the end users) care about workflow integration. Selling it as a premium add-on per developer seat (Option B) allows GitHub to capture this high willingness to pay from enterprise budgets without forcing smaller, price-sensitive teams to absorb a massive price hike. Offering it for free (Option A) would leave significant revenue on the table, while a usage-based scan fee (Option C) would discourage developers from running security checks, undermining the product''s core utility.',
        ARRAY['packaging', 'pricing_models', 'value_proposition']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Include all advanced security features in the base Enterprise plan for free to drive developer adoption.', false),
    (v_q_id, 'B', 'Package GHAS as a separate, premium add-on billed per active developer seat, target security buyers, and tie value to enterprise risk mitigation rather than developer productivity.', true),
    (v_q_id, 'C', 'Charge developers a microtransaction fee every time a security scan runs.', false),
    (v_q_id, 'D', 'Sell it exclusively as a standalone product that runs outside of the main GitHub repository interface.', false);

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
        'Notion AI''s Waitlist Strategy',
        'Notion is launching "Notion AI," a suite of generative writing tools. Given the unpredictable server costs of LLM APIs and the risk of poor early generation quality, the GTM PM decides to launch with a waitlist and a phased rollout to free and paid workspaces.

Why is a phased waitlist rollout strategically optimal for this product launch?',
        'intermediate',
        'Notion',
        'AI-Assisted Document Workspace',
        'B',
        'High-cost, high-compute features like LLM generation carry significant financial and performance risks. An unthrottled GA (General Availability) launch could result in slow response times, massive server bills, and low-quality outputs, leading to negative reviews. A phased rollout via a waitlist helps the product team control usage volume, optimize token usage and unit economics, and refine the quality of the model outputs based on real-world inputs. It also builds anticipation (viral waitlists) while acting as a vital operational buffer.',
        ARRAY['launch_planning', 'launch_success', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It forces all users to upgrade to the highest paid plan before they can join the queue.', false),
    (v_q_id, 'B', 'It allows the team to match infrastructure capacity with demand, gather telemetry on LLM API unit economics, and iterate on prompt templates based on early user feedback to prevent public churn.', true),
    (v_q_id, 'C', 'It creates artificial scarcity that allows Notion to double the price of its base subscription.', false),
    (v_q_id, 'D', 'It prevents competitors from seeing the AI features before the general public release.', false);

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
        'Spotify''s Ad-Supported Tier in Emerging Markets',
        'Spotify is expanding into several low-ARPU (Average Revenue Per User) Southeast Asian markets where credit card penetration is under 15% and consumers are highly price-sensitive. Local music streaming competitors offer free ad-supported tiers. The finance team advises launching only a paid premium tier to avoid paying high licensing royalties for free listeners.

Why should the GTM PM push back and insist on launching the ad-supported free tier?',
        'intermediate',
        'Spotify',
        'Music Streaming App',
        'B',
        'In markets with low digital payment infrastructure and high price sensitivity, forcing a subscription-only model severely limits the addressable market. The ad-supported free tier is a vital distribution channel. It allows Spotify to capture massive market share, learn local consumer tastes, build a localized recommendation algorithm, and gain leverage with local music labels. Over time, as payment options expand (mobile wallets, carrier billing), Spotify can convert these users. Without the free tier, Spotify would lose the market to local incumbents who offer free alternatives.',
        ARRAY['market_entry', 'distribution_channels', 'pricing_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Free users in these markets will convert to premium plans at the exact same rates as Western European markets within 3 months.', false),
    (v_q_id, 'B', 'The ad-supported tier serves as a low-barrier-to-entry acquisition funnel that drives massive brand awareness, local market content localization, and eventual monetization through alternative payment methods (e.g., e-wallets, carrier billing).', true),
    (v_q_id, 'C', 'Record labels waive all royalty fees for streams that occur on mobile devices in emerging markets.', false),
    (v_q_id, 'D', 'Advertisers in low-ARPU markets pay higher rates per impression than advertisers in North America.', false);

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
        'Loom''s Video Sharing Viral Loop',
        'Loom is a video messaging tool designed for work. When a user records a video, they send a link to a recipient. The recipient does not need to have a Loom account to watch the video.

As the GTM PM, how do you optimize this viewing experience to maximize new user acquisition without introducing friction that stops the recipient from watching?',
        'intermediate',
        'Loom',
        'Video Communication Tool',
        'B',
        'The strength of Loom''s growth loop lies in its low friction. If you force the recipient to sign up just to view a message (Option A), you break the value proposition for the sender (easy communication) and annoy the recipient, causing the link to be ignored. Instead, by keeping the viewing experience free and frictionless, you get the product in front of a prospective user. Placing CTAs and interactive features (like reactions or comments) behind a low-barrier signup gate converts interested viewers into creators, completing the viral acquisition loop.',
        ARRAY['distribution_channels', 'launch_success', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Require the recipient to sign up and log in before they can press play on the video.', false),
    (v_q_id, 'B', 'Allow immediate viewing of the video, but display clear, contextual calls-to-action (CTAs) around the video player, and prompt sign-up if they try to react or leave a comment.', true),
    (v_q_id, 'C', 'Charge the video creator $0.10 for every external view their video receives to offset storage costs.', false),
    (v_q_id, 'D', 'Only allow video links to be shared inside Slack or Microsoft Teams.', false);

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
        'Figma''s Enterprise Plan Sales-Led Expansion',
        'Figma historically grew through self-serve, bottom-up adoption by design teams. The GTM team wants to launch an Enterprise Plan to drive top-down sales.

Which product-usage trigger is the most effective signal for a Sales Development Representative (SDR) to reach out to an account and pitch the Enterprise Plan?',
        'intermediate',
        'Figma',
        'Collaborative Design Tool',
        'B',
        'The transition from self-serve (PLG) to sales-led (enterprise) relies on finding "organizational sprawl." When multiple separate teams within the same company (e.g., targetcompany.com) are paying for individual team plans or collaborating in silos, it creates security, administrative, and compliance risks for the company''s IT department. A sales outreach pitching unified billing, Single Sign-On (SSO), advanced workspace administration, and shared design libraries directly addresses these CIO/IT pain points, making it the perfect trigger for an enterprise upgrade.',
        ARRAY['self_serve_vs_sales', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A user creates more than 10 personal draft files in their free account.', false),
    (v_q_id, 'B', 'Multiple users with the same corporate email domain are collaborating across separate, siloed professional workspaces, and crossing billing thresholds.', true),
    (v_q_id, 'C', 'A single designer exports a design mockup to a PNG format more than 50 times in a week.', false),
    (v_q_id, 'D', 'The customer support team receives a ticket from a user who forgot their password.', false);

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
        'Stripe''s Corporate Card Interchange Fees',
        'Stripe launched "Stripe Card Issuing," allowing businesses to generate physical or virtual debit cards for their employees. Instead of charging a SaaS subscription fee for the software, Stripe monetizes the product by retaining a portion of the "interchange fee" (the small percentage card networks charge merchants on swipe transactions).

Why is this pricing model strategically aligned with Stripe''s GTM?',
        'intermediate',
        'Stripe',
        'Card Issuing Infrastructure',
        'B',
        'This is an example of usage-based monetization aligned with customer value. Startups and scaling companies are highly sensitive to fixed SaaS overhead. By offering the card issuing software for free and monetizing via interchange fees paid by vendors, Stripe removes all upfront purchase barriers. As the customer scales and spends more money via Stripe cards, Stripe''s revenue scales proportionally. This monetization model aligns product adoption with revenue growth, making it a frictionless GTM entry strategy.',
        ARRAY['pricing_models', 'gtm_strategy', 'self_serve_vs_sales']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'SaaS fees are illegal for financial products under federal banking regulations.', false),
    (v_q_id, 'B', 'It makes the product free to use for startups, eliminating buyer friction and aligning Stripe''s revenue directly with the transactional volume of their customers.', true),
    (v_q_id, 'C', 'Card transaction processing costs nothing, allowing Stripe to enjoy 100% gross margins.', false),
    (v_q_id, 'D', 'It forces customers to spend more money on employee expenses than they normally would.', false);

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
        'Netflix''s Subscription Price Increase',
        'Netflix plans to raise the price of its Standard tier in North America from $15.49 to $16.99. Based on historic cohort data, the GTM analytics team models the price elasticity of demand.

If they expect standard tier churn to increase from 2.5% to 3.0% post-launch, what calculation must the PM perform to verify if the price hike will be net-revenue positive?',
        'intermediate',
        'Netflix',
        'SVOD Service',
        'A',
        'To evaluate a price increase, the PM must calculate price elasticity. The price is increasing by ~9.7% ($1.50 / $15.49). If the increase in churn from 2.5% to 3.0% (and associated drop-off in new signups) results in a cumulative loss of less than 9.7% of the subscriber base, the price increase will result in higher total revenue. This is a classic trade-off between volume and margin. The PM must model the subscriber lifecycle LTV shift to ensure the higher margin per user offsets the volume loss.',
        ARRAY['pricing_models', 'launch_success', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Verify if the percentage increase in price (approx 9.7%) is greater than the percentage drop in paying subscribers caused by the increased churn over the fiscal year.', true),
    (v_q_id, 'B', 'Ensure that the Customer Acquisition Cost (CAC) decreases by 9.7% to compensate for the higher churn.', false),
    (v_q_id, 'C', 'Check if the number of new sign-ups in the first month is double the number of churned users.', false),
    (v_q_id, 'D', 'Confirm that competitor platforms (Disney+, Max) immediately match the exact same price point.', false);

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
        'Zoom''s Telecommunications Partnerships',
        'Zoom wants to accelerate penetration into government and public education sectors in the APAC region. These sectors have strict local data sovereignty regulations and tend to buy exclusively through long-term government procurement contracts.

What distribution channel strategy should Zoom''s GTM PM prioritize to win this market?',
        'intermediate',
        'Zoom',
        'Communications Technology',
        'B',
        'Highly regulated sectors like government and education rarely buy software through self-serve channels or direct sales cold outreach. They buy through trusted, pre-approved channel partners, system integrators, and telecom providers that already have security clearances and MSAs in place. Partnering with these local incumbents allows Zoom to piggyback on existing relationships, bypass long procurement cycles, and meet local compliance requirements (the partner often manages the local data centers or support), making it the fastest GTM path to market.',
        ARRAY['distribution_channels', 'market_entry', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A heavy digital marketing campaign offering free 1-year Zoom codes via Facebook ads.', false),
    (v_q_id, 'B', 'Establishing indirect distribution channels by partnering with local telecommunications incumbents and regional system integrators who already hold master services agreements (MSAs) with these agencies.', true),
    (v_q_id, 'C', 'Building a self-serve portal that accepts local digital wallets and bypassing sales teams.', false),
    (v_q_id, 'D', 'Lobbying local governments to ban all competing video conferencing software.', false);

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
        'Slack Connect''s Network Activation Metric',
        'Slack is launching "Slack Connect," allowing different companies to collaborate in the same shared channel. Because it is a network-effects feature, the GTM team must track launch success.

Which of the following metrics is the best indicator that Slack Connect is establishing a self-sustaining viral growth loop?',
        'intermediate',
        'Slack',
        'Workplace Communication Software',
        'B',
        'A self-sustaining viral growth loop occurs when a user''s action naturally exposes the product to a non-user, who then adopts the product and repeats the cycle. If Organization A invites Organization B, and then Organization B (now activated) goes on to initiate a channel with Organization C, it demonstrates true multi-sided viral network propagation. Tracking this multi-hop invite behavior (Option B) directly measures the strength and health of the product''s organic distribution engine, whereas sales-created channels (Option A) measure sales effort, and emoji usage (Option C) measures engagement, not viral acquisition.',
        ARRAY['launch_success', 'distribution_channels', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The total number of Slack Connect channels created by internal Slack sales reps.', false),
    (v_q_id, 'B', 'The percentage of shared channels where the invited external organization goes on to invite a third, unrelated organization to a new shared channel.', true),
    (v_q_id, 'C', 'The daily average count of emojis sent in shared channels.', false),
    (v_q_id, 'D', 'The total number of PDF files uploaded to Slack Connect channels.', false);

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
        'Airbnb''s Long-Term Stays Positioning',
        'During a global travel downturn, Airbnb saw short-term tourist bookings plummet by 80%. PM analytics showed a small, resilient cohort of users booking stays of 30 days or longer to work remotely. The GTM team wants to reposition Airbnb to capture this segment.

Which positioning adjustments should the GTM team prioritize on the product landing pages?',
        'intermediate',
        'Airbnb',
        'Travel Marketplace',
        'B',
        'When repositioning for a new target segment (long-term remote workers vs. vacationers), the product''s value proposition must change. Remote workers care about living and working comfort, not just sightseeing. Showcasing monthly discounts makes long stays financially viable, while Wi-Fi verification and dedicated workspaces solve the practical pain point of working remotely. This value proposition directly addresses the customer''s functional needs, facilitating product-market fit adaptation during a market shift.',
        ARRAY['value_proposition', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Feature luxury villas with infinity pools and highlight proximity to popular tourist attractions.', false),
    (v_q_id, 'B', 'Highlight monthly discounts, verify reliable Wi-Fi speeds via host speed tests, and showcase dedicated workspaces and kitchen amenities.', true),
    (v_q_id, 'C', 'Reduce booking fees to 0% for all weekend stays.', false),
    (v_q_id, 'D', 'Focus marketing copy entirely on road-trips and car rentals.', false);

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
        'Shopify''s Shop Pay Installments Launch',
        'Shopify is launching "Shop Pay Installments" (a Buy Now, Pay Later service) to its merchant base. The product team needs to design the marketing and enablement campaign to drive adoption.

Which value proposition will resonate most with Shopify merchants to convince them to activate this payment option?',
        'intermediate',
        'Shopify',
        'Merchant Solutions',
        'B',
        'Effective sales enablement and product marketing must translate product features (installment loans) into business outcomes (revenue growth). Merchants care about selling more products. By showing that Buy Now, Pay Later (BNPL) options increase checkout conversion rates (reducing cart abandonment) and increase AOV (customers buy more because they can pay over time), Shopify directly appeals to the merchant''s bottom-line goals. Highlighting consumer credit scoring algorithms (Option A) is too technical and irrelevant to the merchant''s core business motivation.',
        ARRAY['value_proposition', 'launch_success', 'packaging']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Explaining the complex financial underwriting algorithms used to score consumer credit.', false),
    (v_q_id, 'B', 'Demonstrating how adding Shop Pay Installments increases average order value (AOV) and cart conversion rates for online stores.', true),
    (v_q_id, 'C', 'Offering merchants free Google Ad credits if they use the installment feature.', false),
    (v_q_id, 'D', 'Highlighting that it shifts the merchant''s checkout button to a different color.', false);

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
        'HubSpot''s Free CRM PQL Scoring',
        'HubSpot offers a free CRM. The self-serve GTM team wants to pass "Product Qualified Leads" (PQLs) to the sales team when a free account shows signals of buying intent.

Which usage behavior combination constitutes the strongest PQL score for an upgrade to the Sales Hub Starter/Professional plans?',
        'intermediate',
        'HubSpot',
        'CRM Platform',
        'B',
        'A Product Qualified Lead (PQL) is an active user who has realized value from the product and reached a usage threshold that signals expansion need. Importing contacts and inviting colleagues indicates strong product activation and team collaboration. Hitting the monthly email limit shows that they are hitting the boundaries of the free tier and need additional capacity. This combination of high utility, team penetration, and feature constraint makes them highly receptive to a sales conversation. Inactive accounts (Option D) or low-engagement actions (Option A, Option C) do not indicate current product qualification.',
        ARRAY['self_serve_vs_sales', 'launch_success', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A user logs in once, views the settings page, and updates their profile picture.', false),
    (v_q_id, 'B', 'A team imports 500+ contacts, invites 3 colleagues, and hits the monthly email sending limit within their first 14 days.', true),
    (v_q_id, 'C', 'A user reads 5 HubSpot academy articles and leaves a 5-star review on the App Store.', false),
    (v_q_id, 'D', 'An account has been inactive for 90 days but has a high corporate revenue profile.', false);

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
        'Duolingo''s Premium Tier Bundling',
        'Duolingo offers a premium tier called "Super Duolingo" ($12.99/mo) which removes ads and gives unlimited hearts. They want to launch a new, more expensive tier, "Duolingo Max" ($29.99/mo), which includes generative AI features like "Explain My Answer" and "Roleplay."

How should the GTM team package Duolingo Max to minimize user confusion and maximize conversion?',
        'intermediate',
        'Duolingo',
        'Language Learning App',
        'B',
        'A classic "Good-Better-Best" packaging strategy helps structure pricing for different levels of user needs. By keeping Super Duolingo as the "Better" tier and positioning Duolingo Max as the "Best" tier (which includes all Super features plus the AI features), Duolingo provides a clear, logical upgrade path. Replacing Super entirely (Option C) would spark heavy customer backlash and churn. Selling features à la carte (Option A) creates decision fatigue and administrative complexity, lowering total conversion.',
        ARRAY['packaging', 'bundling_strategy', 'pricing_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Sell "Explain My Answer" as an individual micro-subscription ($5.99/mo) separate from Super Duolingo.', false),
    (v_q_id, 'B', 'Position Duolingo Max as an all-inclusive super-bundle that contains all Super Duolingo benefits plus the new AI features, maintaining a clear good-better-best tier structure.', true),
    (v_q_id, 'C', 'Replace the Super Duolingo tier entirely with Duolingo Max, forcing all paid users to double their monthly payment.', false),
    (v_q_id, 'D', 'Make Duolingo Max the free tier and charge for the basic app instead.', false);

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
        'Atlassian''s Jira Product Discovery Launch',
        'Atlassian is launching "Jira Product Discovery" (JPD) to compete in the product management roadmapping space against incumbents like Productboard. Atlassian''s core advantage is Jira''s dominance in engineering workflows.

What positioning strategy should the JPD team use to win over product managers?',
        'intermediate',
        'Atlassian',
        'Agile PM Software',
        'B',
        'In competitive GTM positioning, you must play to your unique, unfair advantage. Atlassian''s competitive advantage is the ubiquitous presence of Jira Software in engineering workflows. Positioning JPD as the bridge that connects PM ideation directly to Jira development tickets solves the friction of syncing roadmaps with developer task boards — a major pain point for PMs using standalone alternatives like Productboard. This integration-first value proposition creates a compelling reason to buy for existing Jira customers.',
        ARRAY['value_proposition', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Position JPD as a completely standalone tool that requires no connection to Jira Software.', false),
    (v_q_id, 'B', 'Position JPD as the only roadmapping tool that seamlessly closes the gap between product discovery (ideas) and execution (development tasks), keeping teams aligned in one ecosystem.', true),
    (v_q_id, 'C', 'Offering JPD at a price that is 10 times higher than Productboard to signal premium quality.', false),
    (v_q_id, 'D', 'Focusing marketing messages on how JPD helps designers build UI mockups.', false);

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
        'Vercel''s Bandwidth and Serverless Seat Mix',
        'Vercel offers a developer hosting platform. Their GTM pricing model originally charged only per seat. They noticed that enterprise customers with high-traffic sites had small developer teams, allowing them to host massive sites while paying very little. Conversely, large dev teams building low-traffic internal projects paid high seat fees despite consuming zero bandwidth.

How should Vercel adjust its pricing structure?',
        'intermediate',
        'Vercel',
        'Cloud Hosting Platform',
        'B',
        'Hybrid pricing models (seat-based + usage-based) are standard in developer tools and cloud infrastructure. Seats monetize collaboration value (adding developers, reviews, integrations), while usage metrics monetize utility value (hosting traffic, processing serverless runs). This multi-axis pricing structure ensures Vercel captures fair value from both high-traffic/small-team companies and low-traffic/large-team organizations, preventing revenue leakage and maintaining margin alignment.',
        ARRAY['pricing_models', 'gtm_strategy', 'packaging']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Transition to a 100% usage-based billing system and eliminate seat costs entirely.', false),
    (v_q_id, 'B', 'Implement a hybrid pricing model that charges a flat seat license fee for collaborative developer seats, combined with usage-based metrics (e.g., bandwidth, serverless function execution) to capture value from high-traffic applications.', true),
    (v_q_id, 'C', 'Charge a flat monthly rate regardless of the number of developers or traffic volume.', false),
    (v_q_id, 'D', 'Block all traffic to websites that exceed 10GB of bandwidth on free plans without offering an upgrade path.', false);

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
        'Stripe''s Local Payment Methods Launch',
        'Stripe is expanding its services in the European Union. In Europe, local payment methods (e.g., iDEAL in the Netherlands, Giropay in Germany) account for over 60% of online transaction volume. Rather than building separate API endpoints for every local scheme, Stripe GTM decides to launch the "Payment Element" — a single dynamic UI component that automatically displays the most relevant local payment methods based on the buyer''s location and device.

What is the primary GTM benefit of this product architecture?',
        'advanced',
        'Stripe',
        'Global Payments API',
        'B',
        'GTM friction is often technical. If a merchant has to write custom code for 20 different European payment methods, they will delay integration or look for localized competitors. By abstracting this complexity into a single dynamic UI component (the Payment Element), Stripe solves the merchant''s integration bottleneck. Merchants write one integration, and Stripe automatically serves the right local options. This accelerates the merchant''s speed-to-market, improves checkout conversion rates, and reduces integration friction, which is a major distribution advantage.',
        ARRAY['market_entry', 'distribution_channels', 'value_proposition', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It allows Stripe to bypass local European banking licenses and PCI-compliance audits.', false),
    (v_q_id, 'B', 'It drastically reduces the integration effort for merchants from weeks to hours, boosting checkout conversion rates out-of-the-box and accelerating merchant acquisition.', true),
    (v_q_id, 'C', 'It forces consumers to use American credit cards, which carry higher interchange fees for Stripe.', false),
    (v_q_id, 'D', 'It eliminates the need for Stripe to negotiate financial terms with individual European banks.', false);

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
        'Slack''s Top-Down vs. Bottom-Up Alignment',
        'Slack Connect has achieved rapid bottom-up adoption, with individual team leads inviting external vendors to shared channels. However, the Chief Information Officer (CIO) of a major financial client requests to block Slack Connect entirely due to data leakage concerns.

How should the GTM PM resolve this tension to protect enterprise contract renewals?',
        'advanced',
        'Slack',
        'Collaboration Security',
        'B',
        'Bottom-up (PLG) strategies often hit a wall in enterprise sales when corporate governance, security, or compliance constraints are violated. The GTM response should not be to shut down the viral feature (Option A) or ignore the executive buyer (Option C). Instead, the PM must introduce "enterprise gates" (Option B) — giving the administrative buyer the security tools they need (whitelisting, compliance logs) to feel comfortable authorizing the product. This aligns the user''s desire for collaboration with the CIO''s mandate for data protection, enabling enterprise adoption.',
        ARRAY['self_serve_vs_sales', 'packaging', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Disable the Slack Connect invite feature for all users within financial domains.', false),
    (v_q_id, 'B', 'Launch enterprise administrative controls (e.g., domain whitelisting, approval workflows, and e-discovery logs for shared channels) to give CIOs control and visibility over what data leaves the organization, while preserving the user''s ability to invite collaborators.', true),
    (v_q_id, 'C', 'Ignore the CIO''s request and focus on growing the number of individual team signups.', false),
    (v_q_id, 'D', 'Send a sales representative to convince the CIO that data security is not important in modern workplaces.', false);

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
        'Netflix''s Ad-Supported Tier Cannibalization',
        'Netflix is modeling the launch of an ad-supported subscription tier ("Standard with Ads") priced at $6.99/mo. The current ad-free Standard plan is $15.49/mo. Financial analysts warn that if standard subscribers downgrade to the ad tier, Netflix will lose $8.50 in monthly subscription revenue per user.

Under what conditions is the ad tier strategically viable?',
        'advanced',
        'Netflix',
        'Streaming Monetization',
        'B',
        'The viability of a lower-priced, ad-supported tier relies on two factors: ad monetization capacity and cannibalization control. If Netflix can generate $8.50+ per month per user in advertising revenue (Ad ARPU), a downgrading subscriber is actually ARPU-neutral or positive. To protect the higher-margin $15.49/mo tier from excessive cannibalization, Netflix must use "value fences" (lower resolution, limits on simultaneous streams, disabling offline downloads). This ensures that users who value premium performance remain on the ad-free tiers, while price-sensitive users choose the ad tier, maximizing total ARPU.',
        ARRAY['pricing_models', 'packaging', 'bundling_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The ad-supported tier must show at least 45 minutes of commercials per hour to recover the revenue gap.', false),
    (v_q_id, 'B', 'The ad-supported tier must generate a blended monthly Ad ARPU of at least $8.50 per user, and have sufficient feature gating to prevent high-propensity-to-pay users from downgrading.', true),
    (v_q_id, 'C', 'The ad-supported tier should only be offered to users who have previously churned from Netflix.', false),
    (v_q_id, 'D', 'The ad-supported tier must be priced at $0/mo to maximize ad impressions and market share.', false);

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
        'Uber Freight''s Two-Sided Cold Start',
        'Uber is launching "Uber Freight," a B2B marketplace connecting truck drivers with shippers. In B2B logistics, shippers will only post jobs if they are guaranteed that a driver will show up, while truck drivers will only check the app if there are high-paying loads nearby.

How should the Uber Freight GTM team solve this chicken-and-egg cold start problem in their first target region?',
        'advanced',
        'Uber',
        'Logistics Marketplace',
        'C',
        'In two-sided marketplaces, the cold start problem is solved by focus and subsidy. The GTM team must pick a narrow geographic corridor and focus on bootstrapping one side of the market. Usually, supply (truckers) is harder to retain if they get zero utility. By guaranteeing rates, Uber ensures early drivers remain active and loyal. Meanwhile, securing anchor shippers ensures a baseline of load volume. Doing manual matchmaking ("concierge MVP") in the background simulates liquidity until the automated matching engine has enough data and users to run programmatically.',
        ARRAY['market_entry', 'launch_success', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run national TV commercials targeted at consumer audiences to build brand awareness.', false),
    (v_q_id, 'B', 'Buy a fleet of trucks and hire full-time drivers to manually move loads for shippers.', false),
    (v_q_id, 'C', 'Subsidize the supply side by offering guaranteed high rates to early drivers (even if Uber loses money on the load) to build reliable capacity, while securing long-term load volume from 2-3 anchor shippers by manually matching jobs behind the scenes.', true),
    (v_q_id, 'D', 'Wait for both drivers and shippers to sign up organically through app store optimization before launching operations.', false);

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
        'Amazon Prime''s Default Ad-Supported Transition',
        'Amazon Prime Video is transitioning its base Prime subscription tier to include ads by default, requiring users to pay an additional $2.99/mo to opt-out and keep their ad-free experience.

As the GTM PM leading this transition, what is the primary risk of using an "opt-out" rather than an "opt-in" model, and how do you justify the choice to leadership?',
        'advanced',
        'Amazon',
        'Prime Video Subscriptions',
        'B',
        'The default effect is highly powerful. By making the ad-supported tier the default and requiring an opt-out fee to remove ads, Amazon instantly converts the vast majority of its massive Prime base into an ad-supported audience. While this risks customer backlash (as users feel they are getting less value for the same price), it solves the cold-start problem for Amazon''s ad sales team by providing scale to advertisers on Day 1. An opt-in model would result in low adoption, making it difficult to attract high-budget brand advertisers.',
        ARRAY['value_proposition', 'pricing_models', 'gtm_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The opt-out model will result in low initial ad inventory because users will not see ads.', false),
    (v_q_id, 'B', 'The opt-out model risk is customer backlash and regulatory scrutiny for changing the terms of service, but it is justified because it immediately creates a massive, high-scale ad-viewer audience that makes Prime Video a viable destination for premium advertisers.', true),
    (v_q_id, 'C', 'The opt-in model is legally required in all global jurisdictions, making the opt-out model impossible to launch.', false),
    (v_q_id, 'D', 'The opt-out model is less profitable because users prefer paying $2.99/mo to seeing ads.', false);

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
        'Salesforce''s Customer 360 Bundling Architecture',
        'During a major enterprise deal negotiation with an auto manufacturer, the client''s procurement department is requesting a 40% discount on Sales Cloud licenses. They are also considering buying Slack and MuleSoft. The Salesforce GTM account team wants to offer a discount.

What is the most effective discounting strategy for the PM to recommend to preserve Customer Lifetime Value (LTV) and prevent margin erosion?',
        'advanced',
        'Salesforce',
        'Enterprise B2B SaaS',
        'B',
        'In enterprise GTM, unconditioned discounting of core products (Option A) sets a bad precedent, erodes margin, and signals low value. Instead, strategic PMs use bundling and contract length concessions to protect long-term value. Bundling additional products (Slack, MuleSoft) at a discount increases multi-product adoption, which makes the customer highly sticky and difficult to displace. Tying the discount to a longer contract term (3 years) secures recurring revenue predictability.',
        ARRAY['bundling_strategy', 'packaging', 'pricing_models', 'self_serve_vs_sales']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Grant the 40% discount on the core Sales Cloud licenses without any conditions.', false),
    (v_q_id, 'B', 'Maintain a firm price on Sales Cloud but offer a bundled discount where the manufacturer receives a 30% discount across Sales Cloud, Slack, and MuleSoft if they sign a 3-year contract, thereby increasing total contract value (TCV) and platform dependency.', true),
    (v_q_id, 'C', 'Give Slack and MuleSoft away for free indefinitely.', false),
    (v_q_id, 'D', 'Suggest the client buy competitor tools (like HubSpot) to see if they prefer their pricing.', false);

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
        'Spotify''s Audiobook GTM Monetization Mix',
        'Spotify is entering the audiobook market, dominated by Amazon''s Audible. Audible charges a subscription fee for 1 credit/month (1 book). Spotify decides to bundle 15 hours of audiobook listening per month into its existing Premium subscription at no extra cost, while charging users for additional hours or individual purchases.

What is the primary GTM rationale for this hybrid packaging compared to Audible''s credit system?',
        'advanced',
        'Spotify',
        'Audiobook Launch',
        'B',
        'Spotify''s GTM strategy relies on leveraging its massive distribution advantage (200M+ Premium subscribers) to cross-sell a new format. Offering 15 free hours acts as a low-risk trial mechanism for users who might hesitate to purchase a standalone audiobook or an Audible subscription. Once users habituate to consuming audiobooks inside Spotify, they will reach the 15-hour limit and purchase extra hours or books, generating high-margin incremental revenue. This allows Spotify to disrupt Audible''s lock on the market by utilizing its existing active subscriber footprint.',
        ARRAY['bundling_strategy', 'market_entry', 'value_proposition', 'pricing_models']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It is cheaper for Spotify to buy individual audiobook files than music files.', false),
    (v_q_id, 'B', 'It lowers the barrier to trial for millions of existing music subscribers who have never listened to audiobooks, building the habit within Spotify''s app before monetizing top-up usage, while maintaining a price advantage over Audible.', true),
    (v_q_id, 'C', 'It forces publishers to accept a lower revenue-share agreement than they get from Amazon.', false),
    (v_q_id, 'D', 'It targets heavy book listeners who listen to over 100 hours of books a month, who are Spotify''s most profitable segment.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Go-to-Market Strategy';

END $$;
