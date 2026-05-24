-- ============================================
-- QUESTION BANK: Product Sense > Competitive Analysis
-- Sub-skill slug: competitive-analysis
-- Total questions: 35 (10 foundational, 18 intermediate, 7 advanced)
-- Generated for SkillReport Assessment Platform
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_question_id UUID;
BEGIN
    -- Look up the sub_skill ID
    SELECT id INTO v_sub_skill_id
    FROM sub_skills
    WHERE slug = 'competitive-analysis'
      AND category_id = (SELECT id FROM categories WHERE slug = 'product-sense');

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill competitive-analysis not found. Please run seed data first.';
    END IF;

    -- ============================================
    -- QUESTION 1 (Foundational) — Netflix vs Blockbuster
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 1,
        'Netflix''s Disruption of Blockbuster',
        'In the early 2000s, Netflix offered a DVD-by-mail subscription while Blockbuster dominated physical video rental with 9,000+ stores. Blockbuster eventually launched its own online service but failed to catch up. As a PM analyzing this case, what was the PRIMARY reason Blockbuster failed to effectively respond to Netflix''s disruption?',
        'foundational',
        'Netflix',
        'DVD-by-mail subscription service disrupting physical video rental',
        'B',
        'Blockbuster''s failure is a textbook example of the Innovator''s Dilemma. The company could not cannibalize its lucrative late-fee revenue (~$800M/year) and franchise model because doing so would destroy its existing profit structure. Netflix''s subscription model was initially inferior in convenience (wait for mail vs. instant pickup) but removed the hated late fees. Blockbuster''s leadership recognized the threat but organizational incentives prevented a meaningful response — store managers resisted online because it reduced foot traffic. This illustrates how incumbents fail not from ignorance but from rational self-preservation of existing business models.',
        ARRAY['disruption_theory', 'competitive_response', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Blockbuster lacked the technical talent to build an online platform', false),
    (v_question_id, 'B', 'Blockbuster could not cannibalize its late-fee revenue model and franchise structure without destroying its existing profit engine', true),
    (v_question_id, 'C', 'Consumers preferred Netflix''s brand over Blockbuster''s brand from the start', false),
    (v_question_id, 'D', 'Blockbuster''s management was unaware of the Netflix threat until it was too late', false);

    -- ============================================
    -- QUESTION 2 (Foundational) — Apple vs Android Ecosystem
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 2,
        'Apple''s Competitive Moat in Mobile',
        'Apple''s iPhone holds roughly 27% global market share by units but captures over 80% of smartphone industry profits. Android has 72% market share. A PM at a mobile app startup is deciding platform prioritization. What does this market dynamic primarily reveal about Apple''s competitive moat?',
        'foundational',
        'Apple',
        'iPhone ecosystem and App Store competitive advantage',
        'C',
        'Apple''s disproportionate profit capture despite lower unit share demonstrates the power of ecosystem lock-in and premium brand positioning as competitive moats. Apple controls the entire vertical stack — hardware, OS, App Store, services — enabling premium pricing and high margins. Android OEMs compete on price, eroding their margins. For the startup PM, this means iOS users typically have higher willingness to pay, making iOS-first a rational strategy for monetization despite Android''s larger user base. The moat isn''t just brand — it''s the integrated ecosystem that creates switching costs.',
        ARRAY['competitive_moat', 'platform_competition', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Apple has stronger network effects than Android because it has fewer but more loyal users', false),
    (v_question_id, 'B', 'Android''s open-source model is strategically inferior to Apple''s closed approach in every market', false),
    (v_question_id, 'C', 'Apple''s integrated ecosystem and vertical control create switching costs and pricing power that translate market share into disproportionate profit capture', true),
    (v_question_id, 'D', 'Apple''s market dominance is primarily driven by superior hardware specifications compared to Android devices', false);

    -- ============================================
    -- QUESTION 3 (Foundational) — Slack vs Microsoft Teams
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 3,
        'Microsoft Teams'' Bundling Strategy Against Slack',
        'After Slack pioneered enterprise messaging, Microsoft launched Teams in 2017 and bundled it free with Office 365. By 2020, Teams had surpassed Slack in daily active users. A PM at Slack is analyzing why their early lead evaporated. Which competitive concept BEST explains Microsoft''s successful strategy?',
        'foundational',
        'Slack',
        'Enterprise messaging competition with Microsoft Teams',
        'A',
        'Microsoft''s success against Slack is a classic example of bundling strategy by an incumbent with an existing distribution advantage. Microsoft didn''t need to build a superior product — they needed a "good enough" product distributed for free to 200M+ Office 365 users. Enterprise buyers already had Microsoft contracts, so Teams was a zero-marginal-cost addition. This reduced Slack''s addressable market to companies willing to pay extra for a standalone messaging tool. Slack''s product superiority couldn''t overcome Microsoft''s distribution and bundling advantage — a critical lesson about how distribution often beats product in enterprise markets.',
        ARRAY['bundling_strategy', 'competitive_response', 'platform_competition']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Bundling a "good enough" product with an existing distribution channel to eliminate the standalone competitor''s pricing advantage', true),
    (v_question_id, 'B', 'Building a technically superior product that outperformed Slack on every core feature', false),
    (v_question_id, 'C', 'Leveraging stronger network effects since Teams users could only communicate with other Teams users', false),
    (v_question_id, 'D', 'Acquiring Slack''s key enterprise customers through aggressive price undercutting on messaging-only contracts', false);

    -- ============================================
    -- QUESTION 4 (Foundational) — Uber vs Lyft
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 4,
        'Multi-Homing in Ride-Sharing',
        'Both Uber and Lyft operate in the US ride-sharing market. Research shows that 60%+ of riders have both apps installed and compare prices before each ride. Most drivers also drive for both platforms simultaneously. A PM at Lyft is evaluating why this market hasn''t tipped to a single winner despite strong network effects. What is the PRIMARY competitive dynamic preventing winner-take-all?',
        'foundational',
        'Lyft',
        'US ride-sharing market competition with Uber',
        'B',
        'Multi-homing — where both riders and drivers use multiple competing platforms simultaneously — is the key force preventing winner-take-all in ride-sharing. When multi-homing costs are low (downloading a second app is free, switching takes seconds), network effects become "shared" rather than exclusive. A driver on both platforms doesn''t strengthen one network at the expense of the other. This creates a winner-take-most rather than winner-take-all dynamic. For Lyft''s PM, this means competing on differentiation (e.g., brand values, driver experience) rather than trying to achieve network-effect lock-in, because users can always price-compare.',
        ARRAY['multi_homing', 'network_effects', 'winner_take_all', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Government regulation prevents any single company from monopolizing ride-sharing', false),
    (v_question_id, 'B', 'Low multi-homing costs for both riders and drivers dilute exclusive network effects and enable users to comparison-shop across platforms', true),
    (v_question_id, 'C', 'Uber and Lyft have identical pricing algorithms, making it impossible for either to gain an advantage', false),
    (v_question_id, 'D', 'The ride-sharing market lacks network effects entirely, so there is no mechanism for market tipping', false);

    -- ============================================
    -- QUESTION 5 (Foundational) — Notion vs Confluence
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 5,
        'Notion''s Competitive Positioning Against Confluence',
        'Notion has grown rapidly in the team collaboration space, competing against Atlassian''s Confluence, which has deep enterprise penetration. Notion positions itself as an "all-in-one workspace" combining docs, wikis, databases, and project management. A PM at Atlassian is analyzing how Notion is winning new customers. Which competitive positioning strategy is Notion primarily employing?',
        'foundational',
        'Notion',
        'All-in-one workspace competing with specialized enterprise tools',
        'D',
        'Notion is employing a rebundling strategy — combining functionality that was previously spread across multiple specialized tools (Confluence for docs, Trello for boards, Google Sheets for tables, Airtable for databases) into a single flexible product. This positioning attacks Confluence by redefining what a "workspace tool" means, rather than competing directly on any single feature. Notion''s block-based architecture enables this flexibility. For Atlassian''s PM, the threat is that Notion redefines the category entirely, making Confluence look like a "just a wiki" rather than a complete workspace solution. The competitive response cannot be incremental feature matching.',
        ARRAY['market_positioning', 'bundling_strategy', 'competitive_response']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Low-cost disruption by offering identical features to Confluence at a lower price point', false),
    (v_question_id, 'B', 'New-market disruption by targeting non-consumers who never used knowledge management tools', false),
    (v_question_id, 'C', 'Head-to-head competition on Confluence''s core wiki features with a technically superior engine', false),
    (v_question_id, 'D', 'Rebundling multiple tool categories into a single flexible workspace, redefining the competitive category itself', true);

    -- ============================================
    -- QUESTION 6 (Foundational) — Google Search
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 6,
        'Google Search''s Data Moat',
        'Despite multiple challengers (Bing, DuckDuckGo, Yahoo), Google has maintained 90%+ global search market share for over a decade. Microsoft has invested billions in Bing with minimal share gain. A PM at a search startup is evaluating why this market is so difficult to enter. Which type of competitive moat is MOST responsible for Google''s sustained dominance?',
        'foundational',
        'Google',
        'Search engine dominance and competitive defensibility',
        'C',
        'Google''s search dominance is primarily sustained by a scale-driven data moat that creates a virtuous cycle: more users generate more search queries, which produce more click data, which improves search relevance, which attracts more users. This flywheel has been compounding for 20+ years, creating a data advantage that no competitor can replicate by simply building better technology. Bing can match Google''s engineering but cannot replicate the trillions of behavioral signals Google has accumulated. Additionally, Google reinforces this with distribution deals (default search on Safari, Chrome, Android), creating a multi-layered moat. For the startup PM, this means competing on search quality alone is futile — you need to find a wedge market or alternative approach.',
        ARRAY['competitive_moat', 'barrier_to_entry', 'network_effects']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Brand loyalty — users prefer Google because of emotional attachment to the brand', false),
    (v_question_id, 'B', 'Regulatory capture — Google has lobbied governments to prevent competitor entry', false),
    (v_question_id, 'C', 'A scale-driven data flywheel where more usage generates better relevance signals, compounding Google''s quality advantage over time', true),
    (v_question_id, 'D', 'Switching costs — users have invested too much time customizing their Google experience to switch', false);

    -- ============================================
    -- QUESTION 7 (Foundational) — Amazon Prime
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 7,
        'Amazon Prime as a Competitive Weapon',
        'Amazon Prime bundles free shipping, video streaming, music, and other benefits for $139/year. Prime members spend approximately 2.3x more than non-Prime members on Amazon. A PM at a competing e-commerce startup is analyzing why it''s so difficult to win customers away from Amazon. What competitive function does Prime PRIMARILY serve?',
        'foundational',
        'Amazon',
        'Amazon Prime membership as competitive strategy',
        'B',
        'Amazon Prime functions primarily as a switching cost mechanism. Once a customer has paid $139/year, the sunk cost psychology drives them to maximize their Prime membership by buying more from Amazon (hence the 2.3x spending increase). This creates a powerful lock-in: a customer considering a competitor must mentally "write off" their Prime investment. The bundled benefits (video, music, reading) compound the perceived value, making it even harder to justify switching. For the competing PM, this means you cannot win on price alone — you must offer value that justifies paying for two memberships, or target the ~50% of US households that aren''t Prime members.',
        ARRAY['switching_costs', 'competitive_moat', 'bundling_strategy']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'A loss-leader pricing strategy designed to undercut competitors on shipping costs alone', false),
    (v_question_id, 'B', 'A switching cost mechanism that locks in customer spending through sunk cost psychology and bundled value perception', true),
    (v_question_id, 'C', 'A pure network effect play where more Prime members attract more sellers to the platform', false),
    (v_question_id, 'D', 'A content strategy primarily designed to compete with Netflix and Spotify in entertainment', false);

    -- ============================================
    -- QUESTION 8 (Foundational) — Zoom vs Established Players
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 8,
        'Zoom''s Competitive Entry Strategy',
        'Zoom entered the video conferencing market in 2013 against established players like Cisco WebEx, Microsoft Skype for Business, and Google Hangouts — all backed by companies with massive distribution advantages. By 2020, Zoom had become the dominant video platform. A PM analyzing this case notices that Zoom''s initial growth came primarily from individual users within enterprises, not top-down IT purchases. Which competitive strategy did Zoom use to overcome the incumbents'' distribution advantage?',
        'foundational',
        'Zoom',
        'Video conferencing market entry against incumbents',
        'A',
        'Zoom employed a bottom-up, product-led growth strategy to bypass the enterprise IT procurement gatekeepers that favored incumbents. By making it trivially easy for any individual to start a free meeting (no download, no IT approval, simple URL sharing), Zoom spread virally within organizations. Once enough employees were using Zoom, IT departments were forced to officially adopt it. This is a classic example of how a product-led competitor can overcome distribution disadvantages through superior ease of use and viral mechanics. The incumbents'' enterprise sales motions actually became a liability because they couldn''t match Zoom''s bottoms-up adoption speed.',
        ARRAY['market_positioning', 'competitive_response', 'barrier_to_entry']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Bottom-up product-led growth that bypassed enterprise IT gatekeepers through frictionless individual adoption and viral sharing', true),
    (v_question_id, 'B', 'Top-down enterprise sales with aggressive pricing that undercut Cisco and Microsoft on contract value', false),
    (v_question_id, 'C', 'Building a technically superior codec that delivered dramatically better video quality than any competitor', false),
    (v_question_id, 'D', 'Strategic partnership with a major cloud provider that gave Zoom preferential distribution access', false);

    -- ============================================
    -- QUESTION 9 (Foundational) — Spotify
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 9,
        'Spotify''s Competitive Position in Music Streaming',
        'Spotify competes with Apple Music, Amazon Music, and YouTube Music — each backed by tech giants with deeper pockets. Despite this, Spotify maintains market leadership with ~31% market share. A PM at Spotify is evaluating the company''s long-term defensibility. Apple Music is pre-installed on every iPhone, Amazon Music is bundled with Prime, and YouTube Music leverages YouTube''s massive user base. What is Spotify''s MOST significant competitive vulnerability?',
        'foundational',
        'Spotify',
        'Music streaming market competitive dynamics',
        'D',
        'Spotify''s most significant vulnerability is its lack of distribution leverage compared to competitors who bundle music as part of a larger ecosystem. Apple Music is pre-installed on 1B+ iPhones. Amazon Music comes free with Prime''s 200M+ members. YouTube Music leverages 2B+ YouTube monthly users. Spotify must pay for every user acquisition independently. While Spotify has advantages in discovery algorithms and playlist curation, content itself is a commodity — all services have essentially the same music catalog. This means Spotify''s differentiation rests on product experience, which is incrementally copyable. The lack of an OS, hardware, or broader platform ecosystem makes Spotify structurally disadvantaged in customer acquisition costs.',
        ARRAY['competitive_moat', 'platform_competition', 'bundling_strategy']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Spotify''s recommendation algorithm is easily replicable by competitors with similar engineering talent', false),
    (v_question_id, 'B', 'Spotify''s free tier creates a pricing ceiling that limits revenue growth potential', false),
    (v_question_id, 'C', 'Spotify lacks exclusive content deals, making its catalog identical to competitors', false),
    (v_question_id, 'D', 'Spotify lacks an OS, hardware, or broader platform ecosystem, forcing it to acquire users independently while competitors bundle music into existing distribution channels', true);

    -- ============================================
    -- QUESTION 10 (Foundational) — TikTok vs Instagram
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 10,
        'TikTok''s Disruption of Instagram',
        'TikTok grew from zero to 1 billion monthly active users faster than any social media platform in history, despite Instagram (Meta) having massive network effects, brand recognition, and established creator relationships. A PM at Meta is analyzing why Instagram''s network effects didn''t prevent TikTok''s rapid rise. What is the BEST explanation?',
        'foundational',
        'TikTok',
        'Short-form video disruption of established social networks',
        'C',
        'TikTok''s algorithm-driven content graph fundamentally changed the competitive dynamics of social media. Traditional platforms like Instagram rely on social graph network effects — you follow friends and creators, and your experience improves as your network grows. TikTok''s "For You Page" uses interest-based recommendations that deliver entertaining content without requiring any social connections. This means a new TikTok user gets an excellent experience from their first session, bypassing the cold-start problem that normally protects incumbent social networks. TikTok''s innovation made Instagram''s network effects less of a moat because the consumption experience no longer depended on who you follow. Meta recognized this threat and launched Reels, essentially copying TikTok''s core mechanic.',
        ARRAY['network_effects', 'disruption_theory', 'competitive_moat', 'competitive_response']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'TikTok had a larger marketing budget and outspent Instagram on user acquisition in every market', false),
    (v_question_id, 'B', 'Instagram''s network effects were always weak because users don''t truly value their social connections on the platform', false),
    (v_question_id, 'C', 'TikTok''s algorithm-driven content graph replaced social graph dependency, making network effects less relevant for content consumption quality', true),
    (v_question_id, 'D', 'TikTok exclusively targeted Gen Z demographics that Instagram had no presence in', false);

    -- ============================================
    -- QUESTION 11 (Intermediate) — Figma vs Adobe
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 11,
        'Figma''s Competitive Strategy Against Adobe',
        'Figma displaced Adobe XD as the dominant product design tool despite Adobe having 40+ years of brand equity, deep Creative Cloud ecosystem integration, and massive enterprise relationships. Adobe''s attempted acquisition of Figma for $20B was blocked by regulators. A PM analyzing this case identifies that Figma''s key decisions included: (1) browser-based with zero install, (2) multiplayer real-time collaboration, (3) free tier for individuals, (4) community-driven component marketplace. Which Porter''s Five Forces dynamic did Figma MOST effectively exploit?',
        'intermediate',
        'Figma',
        'Cloud-based design tool disrupting Adobe''s design monopoly',
        'B',
        'Figma exploited low switching costs for new market entrants (the threat of new entrants force). Adobe''s moat was perceived to be ecosystem lock-in, but Figma realized that for product/UI design specifically, switching costs were actually low — design files could be reimported, and the core skill (design thinking) was tool-agnostic. Figma''s browser-based approach further reduced switching costs to zero (no IT approval, no downloads). The free tier eliminated financial barriers. Once inside organizations via individual designers, Figma''s collaboration features created NEW network effects within teams. Adobe''s bundling strategy (Creative Cloud) actually hurt them because teams paying for Photoshop+Illustrator didn''t necessarily need XD if Figma was free and better for their specific workflow.',
        ARRAY['porter_five_forces', 'barrier_to_entry', 'switching_costs', 'competitive_moat']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Buyer power — Figma gave procurement teams leverage to negotiate lower prices across all design tools', false),
    (v_question_id, 'B', 'Threat of new entrants — Figma identified that switching costs in product design were lower than Adobe assumed, reducing barriers to entry', true),
    (v_question_id, 'C', 'Supplier power — Figma secured exclusive partnerships with font and asset suppliers that Adobe couldn''t match', false),
    (v_question_id, 'D', 'Threat of substitutes — Figma positioned design work as unnecessary, substituting it with no-code tools', false);

    -- ============================================
    -- QUESTION 12 (Intermediate) — Airbnb vs Hotels
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 12,
        'Airbnb''s Indirect Competition with Hotels',
        'Airbnb grew to challenge the hotel industry without owning any properties. However, a PM at Marriott observes that Airbnb''s impact varies dramatically by segment: leisure travel has been significantly disrupted, while business travel remains hotel-dominated. Marriott is considering its competitive response. Using value chain analysis, which strategic response would be MOST effective for Marriott?',
        'intermediate',
        'Airbnb',
        'Sharing economy disruption of traditional hospitality',
        'C',
        'Value chain analysis reveals that Airbnb''s advantage lies in asset-light supply acquisition (leveraging existing homes) and unique-experience discovery. However, Airbnb is structurally weak in the areas where business travelers value consistency: standardized quality, loyalty programs, same-day booking reliability, expense management integration, and on-site amenities (gym, conference rooms). Rather than competing with Airbnb on experience uniqueness (where Marriott is structurally disadvantaged), Marriott should double down on the value chain activities where it has inherent advantage. The Bonvoy loyalty program, guaranteed standards, and corporate billing integration are defensible differentiators that Airbnb cannot easily replicate because they require owned and operated properties.',
        ARRAY['value_chain_analysis', 'competitive_response', 'market_positioning']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Launch Marriott''s own home-sharing platform to directly compete with Airbnb on its core value proposition', false),
    (v_question_id, 'B', 'Aggressively cut room prices to make hotels cheaper than Airbnb listings in leisure travel markets', false),
    (v_question_id, 'C', 'Strengthen value chain activities where Airbnb is structurally weak — loyalty programs, standardized quality, corporate integrations, and reliability guarantees', true),
    (v_question_id, 'D', 'Lobby governments to regulate short-term rentals out of existence in all major markets', false);

    -- ============================================
    -- QUESTION 13 (Intermediate) — WhatsApp Network Effects
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 13,
        'WhatsApp''s Network Effect Dynamics',
        'WhatsApp dominates messaging in 180+ countries with 2B+ users. However, a PM at a competing messaging startup notices that WhatsApp''s dominance is not universal — in markets like the US, Japan, and South Korea, other messaging apps (iMessage, LINE, KakaoTalk) dominate. This challenges the assumption that messaging is a global winner-take-all market. What does this market structure reveal about messaging network effects?',
        'intermediate',
        'WhatsApp',
        'Global messaging market network effect analysis',
        'B',
        'Messaging network effects are local and cluster-based, not global. A messaging app''s value depends on whether YOUR specific contacts are on it, not total global users. This creates geographic clustering: WhatsApp dominates where it achieved early critical mass (India, Brazil, Europe), while LINE dominates Japan and KakaoTalk dominates South Korea. Within each cluster, the network effect creates near-monopoly dynamics, but across clusters, different apps can coexist. This means messaging is winner-take-all at the geographic/social cluster level but winner-take-most globally. For a competitor, this implies that winning a specific geographic market or demographic cluster is achievable even against WhatsApp, but you need concentrated adoption — spreading thin globally won''t work.',
        ARRAY['network_effects', 'winner_take_all', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Messaging has weak network effects overall, which is why no single app dominates globally', false),
    (v_question_id, 'B', 'Messaging network effects are local and cluster-based — value depends on your specific contacts, creating geographic winner-take-all dynamics that don''t aggregate globally', true),
    (v_question_id, 'C', 'Government regulations in Japan and South Korea prevent WhatsApp from entering those markets', false),
    (v_question_id, 'D', 'WhatsApp chose not to expand into the US, Japan, and South Korea for strategic business reasons', false);

    -- ============================================
    -- QUESTION 14 (Intermediate) — Shopify vs Amazon
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 14,
        'Shopify''s Competitive Positioning Against Amazon',
        'Shopify powers over 4 million merchants and has positioned itself as "arming the rebels" against Amazon''s marketplace dominance. A PM at Shopify is analyzing the competitive landscape. Amazon offers merchants access to 300M+ active customers but commoditizes brands (consumers search for products, not brands). Shopify lets merchants own their customer relationships but merchants must drive their own traffic. How should this PM frame the competitive positioning?',
        'intermediate',
        'Shopify',
        'E-commerce platform competition and positioning',
        'D',
        'Shopify and Amazon represent fundamentally different value propositions in the e-commerce value chain, making them both competitors and complements. Amazon is an aggregator that owns the customer relationship — merchants trade brand identity for traffic. Shopify enables direct-to-consumer (DTC) ownership but merchants bear the customer acquisition cost. The competitive frame isn''t "Shopify vs Amazon" — it''s "brand ownership vs. traffic access." Many merchants use both, selling commodity items on Amazon for volume while building brand identity on Shopify. For Shopify''s PM, the correct positioning is as a complement that strengthens when Amazon''s commoditization pushes merchants toward wanting their own brand identity, not as a direct substitute that replaces Amazon entirely.',
        ARRAY['market_positioning', 'value_chain_analysis', 'platform_competition']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Direct competitor — Shopify should aim to replicate Amazon''s marketplace features including built-in traffic and fulfillment', false),
    (v_question_id, 'B', 'Substitute competitor — merchants will eventually choose either Amazon or Shopify but not both', false),
    (v_question_id, 'C', 'Irrelevant comparison — Shopify and Amazon serve completely different merchant types with no overlap', false),
    (v_question_id, 'D', 'Complementary competitor — they compete on the brand ownership vs. traffic access axis, and many merchants rationally use both for different strategic purposes', true);

    -- ============================================
    -- QUESTION 15 (Intermediate) — LinkedIn
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 15,
        'LinkedIn''s Winner-Take-All Professional Network',
        'LinkedIn has no meaningful direct competitor in professional networking despite minimal product innovation for years. A PM at a startup considering entering the professional networking space is evaluating whether this market could support a second player. Which combination of factors MOST strongly explains why LinkedIn exhibits winner-take-all dynamics?',
        'intermediate',
        'LinkedIn',
        'Professional networking market dynamics and moat analysis',
        'A',
        'LinkedIn''s dominance is maintained by a triple moat: (1) Cross-side network effects between job seekers and recruiters — recruiters go where professionals are, professionals go where recruiters are. (2) High switching costs from years of accumulated professional identity — connections, endorsements, recommendations, and content history cannot be exported. (3) Data network effects — LinkedIn''s understanding of professional graphs, career trajectories, and skill markets improves with scale, powering better recommendations. The combination of all three makes this market nearly impossible to enter. Individual features (better UI, better content) don''t overcome the bootstrapping problem: a new professional network with zero recruiters has zero value to job seekers. This is why even Google+ (with Google''s resources) failed to crack professional networking.',
        ARRAY['winner_take_all', 'network_effects', 'switching_costs', 'competitive_moat']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Cross-side network effects between job seekers and recruiters, high switching costs from accumulated professional identity, and data network effects from career graph intelligence', true),
    (v_question_id, 'B', 'LinkedIn''s superior technology infrastructure and engineering talent that competitors cannot match', false),
    (v_question_id, 'C', 'Microsoft''s acquisition of LinkedIn gave it bundling advantages that made competition impossible', false),
    (v_question_id, 'D', 'First-mover advantage alone — LinkedIn simply arrived first and brand recognition prevents competition', false);

    -- ============================================
    -- QUESTION 16 (Intermediate) — Canva vs Adobe
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 16,
        'Canva''s Market Entry Strategy',
        'Canva built a $40B+ design company by targeting people who are NOT professional designers — marketers, social media managers, teachers, and small business owners. Adobe''s Creative Cloud tools (Photoshop, Illustrator) require significant skill investment. A PM at Adobe is evaluating the Canva threat. Which disruption pattern does Canva MOST closely follow?',
        'intermediate',
        'Canva',
        'Simplified design tool market entry against Adobe',
        'B',
        'Canva follows Christensen''s new-market disruption pattern. Rather than building a cheaper version of Photoshop for existing designers (low-end disruption), Canva created a product for non-consumers — people who would never learn Photoshop but still need to create visual content. The explosion of social media and content marketing created a massive underserved market of non-designers who needed "good enough" visual content quickly. Canva''s template-first, drag-and-drop approach dramatically lowered the skill floor. This is textbook new-market disruption: the product initially seems non-threatening to the incumbent (Adobe wouldn''t lose existing Photoshop subscribers), but over time Canva improves upmarket and begins to replace Adobe for less demanding use cases.',
        ARRAY['disruption_theory', 'market_positioning', 'competitive_response']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Low-end disruption — Canva offers a stripped-down version of Photoshop at a fraction of the price for budget-conscious designers', false),
    (v_question_id, 'B', 'New-market disruption — Canva created a product for non-consumers (non-designers) who would never use Adobe''s professional tools', true),
    (v_question_id, 'C', 'Sustaining innovation — Canva built a technically superior design tool that professional designers prefer over Adobe', false),
    (v_question_id, 'D', 'Adjacent market entry — Canva started in a completely different industry and pivoted into design tools', false);

    -- ============================================
    -- QUESTION 17 (Intermediate) — Stripe vs PayPal
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 17,
        'Stripe''s Developer-First Competitive Advantage',
        'Stripe entered the payments market against PayPal, Square, and traditional payment processors (Chase Paymentech, Worldpay). While PayPal focused on consumer-facing checkout, Stripe targeted developers with a simple API — "7 lines of code to accept payments." Stripe is now valued at $65B+. A PM at PayPal is analyzing how Stripe built such a strong competitive position. What competitive insight did Stripe exploit?',
        'intermediate',
        'Stripe',
        'Developer-focused payments platform competition',
        'C',
        'Stripe identified that in the payment value chain, the developer was the unserved decision-maker. Traditional processors and PayPal optimized for business buyers (procurement/finance teams) and consumer checkout experiences. But in the startup ecosystem and increasingly in enterprise, DEVELOPERS chose the payments infrastructure. By making integration trivially easy, Stripe created massive switching costs once embedded — ripping out a payments API is enormously costly and risky. This insight — that the decision-maker was shifting from business buyer to developer — allowed Stripe to build a wedge in the market that PayPal''s consumer-facing strategy couldn''t address. Stripe then expanded from this developer foothold into a full financial infrastructure platform.',
        ARRAY['value_chain_analysis', 'competitive_moat', 'switching_costs', 'market_positioning']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Stripe offered significantly lower transaction fees than PayPal and traditional processors', false),
    (v_question_id, 'B', 'Stripe built a consumer-facing checkout experience that was smoother than PayPal''s', false),
    (v_question_id, 'C', 'Stripe recognized that developers were the emerging decision-makers in payment infrastructure, and built deep switching costs through API integration', true),
    (v_question_id, 'D', 'Stripe partnered exclusively with Y Combinator startups to get initial distribution advantage', false);

    -- ============================================
    -- QUESTION 18 (Intermediate) — Twitter/X vs Threads
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 18,
        'Threads'' Competitive Attack on Twitter/X',
        'Meta launched Threads in July 2023, gaining 100M sign-ups in 5 days by leveraging Instagram''s existing user base. However, daily active usage dropped ~80% within weeks of launch. A PM analyzing this competitive situation is evaluating whether Threads can sustain its attack on X (Twitter). What is the MOST critical competitive challenge Threads faces in displacing X?',
        'intermediate',
        'Meta',
        'Threads vs X (Twitter) competitive dynamics in microblogging',
        'B',
        'Threads'' core challenge is bootstrapping a content creation ecosystem, not just user accounts. Twitter/X''s value comes from its real-time public discourse layer — journalists, politicians, domain experts, and commentators have built audiences and content creation habits there over 15+ years. Threads can import Instagram''s social graph (followers), but it cannot import the content creation behavior, norms, and "town square" culture that makes Twitter/X valuable. Users signed up for Threads quickly (low switching cost for account creation) but didn''t have a reason to stay (no differentiated content). This illustrates that in content networks, the supply side (creators, voices, culture) is harder to bootstrap than the demand side (audience). Meta learned this same lesson with Facebook Watch vs. YouTube.',
        ARRAY['network_effects', 'competitive_response', 'switching_costs', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Threads lacks the technical infrastructure to handle real-time conversations at Twitter/X scale', false),
    (v_question_id, 'B', 'Threads can import Instagram''s social graph but cannot import the content creation behaviors, creator incentives, and discourse culture that drive daily engagement on X', true),
    (v_question_id, 'C', 'X''s brand loyalty is so strong that users will never consider an alternative regardless of product quality', false),
    (v_question_id, 'D', 'Meta''s advertising model makes it impossible to build a chronological, text-first content experience', false);

    -- ============================================
    -- QUESTION 19 (Intermediate) — DoorDash vs UberEats
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 19,
        'DoorDash''s Suburban Strategy',
        'DoorDash overtook Uber Eats and Grubhub to become the #1 US food delivery platform with ~65% market share. A key strategic decision was DoorDash''s early focus on suburban markets while competitors fought over dense urban areas. A PM evaluating this competitive outcome is asked: why was the suburban-first strategy competitively advantageous?',
        'intermediate',
        'DoorDash',
        'Food delivery market share competition and geographic strategy',
        'D',
        'DoorDash''s suburban strategy was competitively brilliant because it targeted underserved markets where network effects could be built without direct competitive pressure. In dense urban areas, multiple delivery platforms compete for the same restaurants and drivers, making it hard for any single player to achieve dominant network effects. In suburban markets, DoorDash faced little competition, so each restaurant and driver it added disproportionately improved the consumer experience. This created local market dominance with strong network effects before expanding to urban areas from a position of strength. Additionally, suburban customers had fewer restaurant options and higher order values, making the economics better. The strategy illustrates that competitive advantage often comes from choosing WHERE to compete, not just HOW.',
        ARRAY['market_positioning', 'network_effects', 'competitive_moat', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Suburban customers are wealthier and therefore more likely to tip, improving driver economics', false),
    (v_question_id, 'B', 'Suburban restaurants had no existing delivery infrastructure, forcing them to accept higher commission rates', false),
    (v_question_id, 'C', 'Uber Eats and Grubhub were contractually prohibited from operating in suburban markets', false),
    (v_question_id, 'D', 'Suburban markets were underserved by competitors, allowing DoorDash to build local network effects without competitive pressure and achieve market dominance before expanding to contested urban areas', true);

    -- ============================================
    -- QUESTION 20 (Intermediate) — Salesforce
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 20,
        'Salesforce''s Platform Moat Evolution',
        'Salesforce started as a simple cloud CRM but evolved into a platform with its own app marketplace (AppExchange), development platform (Lightning/Apex), and integration ecosystem. A PM at a CRM startup is analyzing why it''s increasingly difficult to displace Salesforce in enterprise accounts, even when the startup''s core CRM is objectively superior. What competitive concept BEST explains Salesforce''s increasing defensibility over time?',
        'intermediate',
        'Salesforce',
        'Enterprise CRM platform and ecosystem lock-in',
        'A',
        'Salesforce exemplifies ecosystem lock-in through platform effects. As enterprises customize Salesforce with custom objects, workflows, Apex code, and third-party AppExchange integrations, the switching cost grows exponentially. A company with 50 custom automations, 15 third-party integrations, and thousands of trained users would need to rebuild all of this on any competing CRM. The platform has evolved from a product sale to an infrastructure dependency. This is qualitatively different from simple feature competition — even a CRM with superior core features cannot offer migration for the accumulated customizations. For the startup PM, this means targeting greenfield accounts (companies adopting CRM for the first time) rather than trying to displace entrenched Salesforce installations.',
        ARRAY['switching_costs', 'platform_competition', 'competitive_moat', 'barrier_to_entry']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Ecosystem lock-in — accumulated customizations, integrations, and trained workflows create exponentially growing switching costs that a superior product alone cannot overcome', true),
    (v_question_id, 'B', 'Brand loyalty — enterprise buyers trust Salesforce and refuse to evaluate alternatives regardless of capability differences', false),
    (v_question_id, 'C', 'Contractual lock-in — Salesforce uses multi-year contracts with steep penalties that prevent customers from switching', false),
    (v_question_id, 'D', 'Feature superiority — Salesforce maintains technical leadership across every CRM capability and no competitor can match its feature set', false);

    -- ============================================
    -- QUESTION 21 (Intermediate) — Tesla
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 21,
        'Tesla''s First-Mover Advantage Assessment',
        'Tesla is often cited as having first-mover advantage in EVs. However, a PM at a competing automaker notes that legacy automakers (VW, Toyota, GM) are now launching competitive EVs and Tesla''s market share has been declining in some markets. Is Tesla''s first-mover advantage truly durable? Which analysis is MOST accurate?',
        'intermediate',
        'Tesla',
        'Electric vehicle market competitive dynamics and first-mover advantage',
        'C',
        'Tesla''s first-mover advantage is partially durable but under significant competitive pressure. The durable elements include the Supercharger network (physical infrastructure that took years and billions to build), brand association with EVs, and over-the-air update capabilities. However, the car itself is increasingly commoditized as legacy automakers leverage decades of manufacturing expertise, existing dealer networks, and brand loyalty in specific segments. Tesla''s data advantage from autonomous driving miles is real but hasn''t yet translated into a shipped full self-driving product. The correct analysis recognizes that first-mover advantage is not monolithic — some components (charging infrastructure, brand) are durable while others (vehicle quality, manufacturing efficiency) are catchable by fast followers with deeper resources.',
        ARRAY['competitive_moat', 'barrier_to_entry', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Tesla''s first-mover advantage is fully durable — Supercharger network, software expertise, and brand make it impossible for legacy automakers to compete meaningfully', false),
    (v_question_id, 'B', 'Tesla has no first-mover advantage — EVs are commodities and legacy automakers with more manufacturing experience will inevitably dominate', false),
    (v_question_id, 'C', 'Tesla''s first-mover advantage is partially durable — infrastructure (Supercharger) and brand association are hard to replicate, but vehicle manufacturing and core EV technology are catchable by well-resourced fast followers', true),
    (v_question_id, 'D', 'Tesla''s only real advantage is Elon Musk''s personal brand, and the company will decline once that brand association fades', false);

    -- ============================================
    -- QUESTION 22 (Intermediate) — Pinterest
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 22,
        'Pinterest''s Competitive Differentiation from Instagram',
        'Pinterest and Instagram both feature visual content, but Pinterest has maintained a distinct market position with 450M+ MAU despite Instagram''s 2B+ MAU dominance. A PM at Pinterest is defending the company''s strategic direction to the board, arguing that Pinterest is NOT competing in the same market as Instagram. What is the STRONGEST competitive framing for Pinterest''s differentiated position?',
        'intermediate',
        'Pinterest',
        'Visual discovery platform differentiation from social media',
        'B',
        'Pinterest''s strongest competitive framing positions it as a visual search and commercial intent platform rather than a social media network. Instagram serves social expression (sharing moments with followers), while Pinterest serves planning and purchase intent (saving ideas for future action — home renovation, recipes, fashion, weddings). This intent difference has massive implications: Pinterest users arrive with commercial intent, making Pinterest advertising more transactional and higher-ROAS than Instagram ads. The competitive moat is in the intent graph — Pinterest knows what users WANT to do in the future, while Instagram knows what users DID in the past. This framing protects Pinterest from the "Instagram will eat everything visual" narrative and justifies independent existence.',
        ARRAY['market_positioning', 'competitive_moat', 'competitive_intelligence']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Pinterest has a more privacy-focused brand than Instagram, attracting users who distrust Meta', false),
    (v_question_id, 'B', 'Pinterest serves future-oriented commercial intent (planning and discovery) while Instagram serves past-oriented social expression, creating a fundamentally different intent graph and higher advertising ROAS', true),
    (v_question_id, 'C', 'Pinterest has a technically superior image recognition algorithm that makes visual search more accurate', false),
    (v_question_id, 'D', 'Pinterest focuses on older demographics (35+) while Instagram focuses on younger users, so they serve different age groups', false);

    -- ============================================
    -- QUESTION 23 (Intermediate) — Dropbox
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 23,
        'Dropbox''s Competitive Erosion',
        'Dropbox was once valued at $12B+ and pioneered consumer cloud storage. By 2024, its growth had significantly slowed as Google Drive, iCloud, and OneDrive — all bundled free with their parent ecosystems — captured most new users. A PM analyzing Dropbox''s competitive decline is identifying what went wrong strategically. What was Dropbox''s MOST critical competitive mistake?',
        'intermediate',
        'Dropbox',
        'Cloud storage competitive dynamics and bundling vulnerability',
        'D',
        'Dropbox''s critical strategic failure was remaining a single-purpose product (file storage/sync) in a market where cloud storage became a bundled commodity. When Google, Apple, and Microsoft integrated storage into their ecosystems (Gmail/Docs, iPhone/Mac, Windows/Office), standalone storage lost its standalone value. Dropbox had a window to evolve into a collaborative workspace (which it attempted with Paper, later Dropbox Dash) but moved too slowly. The lesson is that a product competing against a feature bundled free by platform owners must either (1) become a platform itself, (2) specialize deeply in a niche the platforms don''t serve well, or (3) build switching costs that transcend the core feature. Dropbox didn''t do any of these quickly enough.',
        ARRAY['bundling_strategy', 'platform_competition', 'competitive_response', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Dropbox failed to match Google, Apple, and Microsoft on storage capacity and pricing', false),
    (v_question_id, 'B', 'Dropbox''s technology was inferior, with more sync errors and slower upload speeds than competitors', false),
    (v_question_id, 'C', 'Dropbox over-invested in enterprise sales instead of maintaining its consumer product advantage', false),
    (v_question_id, 'D', 'Dropbox remained a single-purpose product in a market where storage became a bundled commodity within larger ecosystems, and failed to evolve into a platform fast enough', true);

    -- ============================================
    -- QUESTION 24 (Intermediate) — Walmart vs Amazon
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 24,
        'Walmart''s Competitive Response to Amazon',
        'Walmart has been the most successful brick-and-mortar retailer in responding to Amazon''s e-commerce threat, growing its online revenue to $80B+ through strategic acquisitions (Jet.com) and leveraging its 4,700 US stores. A PM is analyzing which competitive response strategy Walmart used. What competitive response framework BEST describes Walmart''s approach?',
        'intermediate',
        'Walmart',
        'Omnichannel retail strategy as competitive response to Amazon',
        'C',
        'Walmart''s strategy is a textbook "leverage existing asymmetric advantages" competitive response. Rather than trying to out-Amazon Amazon (matching on selection, delivery speed, or technology), Walmart leveraged its unique asset: 4,700 physical locations within 10 miles of 90% of Americans. These stores became fulfillment centers for same-day delivery, curbside pickup points, and return centers — capabilities Amazon cannot easily replicate because building equivalent physical infrastructure would cost hundreds of billions. Walmart redefined the competitive battlefield from "e-commerce vs. physical retail" to "omnichannel convenience," playing to its structural advantages. This is more effective than matching (copying Prime), ignoring (continuing pure brick-and-mortar), or disrupting (building something entirely new).',
        ARRAY['competitive_response', 'competitive_moat', 'value_chain_analysis']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Match strategy — Walmart copied Amazon''s core model with Walmart+ as a direct Prime competitor', false),
    (v_question_id, 'B', 'Leapfrog strategy — Walmart built technologically superior e-commerce infrastructure that surpassed Amazon', false),
    (v_question_id, 'C', 'Redefine strategy — Walmart leveraged its asymmetric physical store advantage to create an omnichannel model that Amazon cannot easily replicate', true),
    (v_question_id, 'D', 'Ignore strategy — Walmart focused purely on its physical retail strength and treated e-commerce as a secondary channel', false);

    -- ============================================
    -- QUESTION 25 (Intermediate) — GitHub Copilot
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 25,
        'GitHub Copilot''s Competitive Position in AI Coding',
        'GitHub Copilot launched as the first widely-adopted AI coding assistant, reaching 1.8M+ paid subscribers. Competitors like Cursor, Codeium, Amazon CodeWhisperer, and Google''s Gemini Code Assist have entered the market. A PM at GitHub is assessing whether Copilot''s early mover advantage is sustainable. Which competitive factor is MOST likely to determine the long-term winner in AI coding assistants?',
        'intermediate',
        'GitHub',
        'AI coding assistant market competition and moat analysis',
        'B',
        'In AI coding assistants, the key competitive differentiator will be deep integration with the developer workflow ecosystem, not model quality alone. LLM quality is converging across providers (GPT-4, Claude, Gemini are all strong), so the model becomes commoditized. GitHub''s advantage is its ownership of the developer workflow: repositories, pull requests, issues, Actions CI/CD, and code review. Copilot embedded in this workflow creates switching costs that a standalone coding assistant cannot. However, Cursor''s approach of building a superior IDE experience (replacing VS Code rather than plugging into it) challenges this by changing the integration surface. The long-term winner will be whoever owns the most comprehensive developer workflow, not whoever has the best standalone AI model.',
        ARRAY['competitive_moat', 'switching_costs', 'platform_competition', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Raw AI model quality — the company with the most accurate code generation model will dominate regardless of other factors', false),
    (v_question_id, 'B', 'Deep workflow integration and ecosystem ownership — the winner will own the broadest developer workflow surface, not just the best AI model', true),
    (v_question_id, 'C', 'Pricing — AI coding assistants will commoditize and the lowest-cost provider will win through volume', false),
    (v_question_id, 'D', 'Training data exclusivity — the company with the most proprietary code training data will have an insurmountable model quality advantage', false);

    -- ============================================
    -- QUESTION 26 (Intermediate) — Duolingo
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 26,
        'Duolingo''s Competitive Moat Analysis',
        'Duolingo dominates language learning with 100M+ MAU while competitors like Babbel, Rosetta Stone, and Busuu struggle. A PM at a competing language app is evaluating Duolingo''s moat. Duolingo has invested heavily in gamification (streaks, leagues, XP), a mascot-driven brand (Duo the owl), and an ML-powered adaptive curriculum. Which element of Duolingo''s strategy creates the STRONGEST competitive moat?',
        'intermediate',
        'Duolingo',
        'Language learning app competitive dynamics and retention moats',
        'A',
        'Duolingo''s gamification system — particularly streaks — creates the strongest competitive moat because it generates behavioral switching costs that are psychologically expensive to abandon. A user with a 365-day streak has a powerful incentive to continue using Duolingo rather than switch to a competitor, regardless of educational quality. This is reinforced by loss aversion: breaking a streak feels like losing an achievement. The ML-adaptive curriculum creates a secondary moat (the app becomes better for you over time), but the streak/gamification loop is more defensible because it''s harder to copy effectively — competitors can implement streaks, but Duolingo''s years of iteration on behavioral psychology and game mechanics have created a polished system that''s hard to replicate. Brand (Duo the owl) creates awareness but not retention.',
        ARRAY['competitive_moat', 'switching_costs', 'brand_advantage']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Gamification and streak mechanics — they create behavioral switching costs through accumulated psychological investment that users are reluctant to abandon', true),
    (v_question_id, 'B', 'The Duo mascot brand — viral marketing through the owl character creates awareness that competitors cannot match', false),
    (v_question_id, 'C', 'ML-powered curriculum — Duolingo''s proprietary language learning algorithm delivers objectively superior educational outcomes', false),
    (v_question_id, 'D', 'Free tier availability — Duolingo''s freemium model makes it impossible for paid competitors to attract any users', false);

    -- ============================================
    -- QUESTION 27 (Intermediate) — Waze vs Google Maps
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 27,
        'Google''s Acquisition of Waze',
        'In 2013, Google acquired Waze for $1.15B despite Google Maps already being the dominant mapping platform. A PM is evaluating this acquisition from a competitive strategy perspective. Apple Maps and other competitors were investing in mapping. What was the PRIMARY competitive rationale for Google acquiring Waze rather than letting it continue as an independent company?',
        'intermediate',
        'Google',
        'Strategic acquisition of Waze as competitive defense',
        'B',
        'Google''s Waze acquisition was primarily a defensive competitive move to prevent a competitor — most likely Apple or Facebook — from acquiring the crowdsourced real-time traffic data that Waze''s community generated. Waze had built a unique asset: a community of users who actively reported road conditions, police locations, accidents, and closures in real-time. This data could have significantly boosted a rival maps product. Apple Maps had launched in 2012 to embarrassing quality issues and desperately needed better traffic data. Facebook was exploring local services. By acquiring Waze, Google simultaneously (1) denied competitors a critical data source, (2) improved Google Maps with real-time community data, and (3) maintained its mapping moat. This is a textbook "acqui-prevent" strategy in competitive markets.',
        ARRAY['competitive_intelligence', 'competitive_response', 'competitive_moat']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Google wanted Waze''s engineering team because Google Maps lacked the talent to build real-time features', false),
    (v_question_id, 'B', 'Preventing a competitor (Apple, Facebook) from acquiring Waze''s crowdsourced traffic data, which could have significantly strengthened a rival mapping product', true),
    (v_question_id, 'C', 'Waze had a larger user base than Google Maps and Google needed the users to maintain market share', false),
    (v_question_id, 'D', 'Google planned to shut down Google Maps and replace it entirely with Waze''s community-driven approach', false);

    -- ============================================
    -- QUESTION 28 (Intermediate) — Discord
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 28,
        'Discord''s Expansion Beyond Gaming',
        'Discord started as a voice/text chat platform for gamers but expanded to education, communities, and professional use cases. Slack, Microsoft Teams, and Telegram could all be considered competitors depending on use case. A PM at Discord is defining the competitive landscape. What is the MOST strategically useful way to identify Discord''s actual competitors?',
        'intermediate',
        'Discord',
        'Community platform competitive landscape analysis',
        'C',
        'The most strategically useful competitive analysis maps competitors by jobs-to-be-done rather than product category. Discord serves multiple jobs: real-time voice hangout (competes with FaceTime, in-person), community management (competes with Reddit, Facebook Groups), async messaging (competes with Slack, Telegram), content creator fan engagement (competes with Patreon, Substack). Different users use Discord for different jobs, meaning the competitive set varies by segment. Mapping by product category ("communication tools") would incorrectly suggest Zoom and Webex are close competitors when they serve fundamentally different jobs. Mapping by user demographics alone misses the behavioral segmentation. Jobs-to-be-done analysis reveals Discord''s true competitive advantages and vulnerabilities in each segment.',
        ARRAY['competitive_intelligence', 'market_positioning', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'By product category — list all communication/messaging tools and rank them by market share', false),
    (v_question_id, 'B', 'By company size — categorize competitors based on revenue and employee count to identify the most threatening', false),
    (v_question_id, 'C', 'By jobs-to-be-done — map competitors for each specific user job Discord fulfills, since different use cases have different competitive sets', true),
    (v_question_id, 'D', 'By user demographics — identify which platforms target the same age groups as Discord', false);

    -- ============================================
    -- QUESTION 29 (Advanced) — Platform Competition Theory
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 29,
        'Uber''s Platform Envelopment Strategy',
        'Uber has expanded from ride-sharing to food delivery (Uber Eats), grocery delivery, freight, and financial services. Meanwhile, Grab in Southeast Asia and Gojek in Indonesia built super-apps combining ride-sharing, food delivery, payments, and financial services from the start. A PM at Uber is evaluating whether to pursue a super-app strategy in the US market. Analyzing this through the lens of platform envelopment theory, why have super-apps succeeded in Southeast Asia but NOT in the US?',
        'advanced',
        'Uber',
        'Super-app strategy and platform envelopment theory in different markets',
        'D',
        'Platform envelopment — where one platform leverages its user base to absorb adjacent platform markets — succeeds when the target markets lack strong incumbents. In Southeast Asia, Grab and Gojek expanded into payments and financial services because the existing financial infrastructure was underdeveloped (low banking penetration, limited digital payments). There were few entrenched incumbents to overcome. In the US, every adjacent market Uber might enter already has dominant, well-funded incumbents with strong network effects: payments (Apple Pay, Venmo, banks), grocery (Instacart, Amazon Fresh), financial services (established banks, fintech). Platform envelopment theory predicts success when the target market has weak incumbents and the enveloping platform can leverage shared users — not when target markets have strong standalone incumbents. This is why the super-app strategy is market-dependent, not universally applicable.',
        ARRAY['platform_competition', 'market_dynamics', 'competitive_moat', 'barrier_to_entry']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'US users prefer single-purpose apps while Southeast Asian users prefer consolidated experiences due to cultural differences', false),
    (v_question_id, 'B', 'US regulatory environment prevents any company from operating across multiple vertical markets simultaneously', false),
    (v_question_id, 'C', 'Super-apps require government partnerships that are only available in developing markets with state-influenced economies', false),
    (v_question_id, 'D', 'Adjacent markets in Southeast Asia lacked strong incumbents (low banking penetration, limited digital infrastructure), while US adjacent markets have entrenched incumbents with strong network effects, making platform envelopment structurally harder', true);

    -- ============================================
    -- QUESTION 30 (Advanced) — Multi-Front Competition
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 30,
        'Apple''s Multi-Front Competitive Strategy in Services',
        'Apple has launched services (Apple Music, TV+, News+, Fitness+, Arcade) that compete directly with Spotify, Netflix, major news publishers, Peloton, and gaming platforms. None of these services individually dominates its category. A PM at Spotify is analyzing Apple''s competitive intent. Using competitive strategy analysis, what is Apple''s ACTUAL strategic objective with these services, and why is it the most dangerous type of competitive threat?',
        'advanced',
        'Apple',
        'Apple services strategy and multi-front competitive dynamics',
        'C',
        'Apple''s services strategy represents the most dangerous competitive threat because Apple doesn''t need any individual service to win its category — the strategic objective is ecosystem reinforcement. Each service increases the total value of staying in the Apple ecosystem, making the aggregate switching cost from Apple higher without any single service being the decisive factor. For Spotify, this means Apple Music doesn''t need to "beat" Spotify — it just needs to make leaving the Apple ecosystem incrementally harder. The competitive analysis mistake is evaluating each service independently (Apple Music vs. Spotify, TV+ vs. Netflix). The correct analysis recognizes that Apple is competing on ecosystem totality. This is why the One subscription bundle is so strategic — it makes the marginal cost of each additional service nearly zero for existing Apple users, undermining standalone competitors'' pricing power.',
        ARRAY['bundling_strategy', 'platform_competition', 'competitive_response', 'switching_costs']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Apple aims to dominate each service category (music, video, news, fitness) and will invest until each service achieves market leadership', false),
    (v_question_id, 'B', 'Apple''s services are primarily a revenue diversification play to reduce dependence on iPhone hardware sales', false),
    (v_question_id, 'C', 'Apple''s strategic objective is ecosystem reinforcement — no individual service needs to win its category because the aggregate increases total switching costs from the Apple ecosystem, undermining standalone competitors'' pricing power', true),
    (v_question_id, 'D', 'Apple is using services as loss leaders to drive iPhone sales, and will discontinue underperforming services once hardware market share is secured', false);

    -- ============================================
    -- QUESTION 31 (Advanced) — Vertical Integration Competition
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 31,
        'Netflix''s Vertical Integration in Content',
        'Netflix transitioned from licensing content to producing original content, spending $17B+ annually on originals. This put Netflix in competition with the very studios that used to license content to it (Disney, Warner Bros., NBC/Universal). Each studio then launched its own streaming service and pulled content from Netflix. A PM is analyzing whether Netflix''s vertical integration into content production was the correct competitive response. Given that studios pulling content was a PREDICTABLE consequence, why was vertical integration still the right strategic move?',
        'advanced',
        'Netflix',
        'Content vertical integration and competitive dynamics in streaming',
        'B',
        'Netflix''s vertical integration was strategically necessary because the alternative — continued dependency on studio-licensed content — was a terminal competitive position. Once streaming proved viable, studios were ALWAYS going to launch their own services and pull content, regardless of what Netflix did. Netflix''s content spending actually accelerated the inevitable, but the timeline advantage was crucial. By investing in originals early (House of Cards in 2013), Netflix built brand associations with original content, developed production expertise, and accumulated a library of owned IP before the streaming wars intensified in 2019-2020. Waiting would have meant starting original production at the same time as Disney+, HBO Max, and Peacock — from behind. The vertical integration eliminated supplier power (Porter''s force) over Netflix''s most critical input. The cost was massive capital expenditure, but the alternative was strategically untenable dependence on competitors-turned-suppliers.',
        ARRAY['value_chain_analysis', 'porter_five_forces', 'competitive_response', 'competitive_moat']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Netflix''s original content is objectively better than studio content, so vertical integration improved product quality', false),
    (v_question_id, 'B', 'Studios were going to pull content regardless — early investment in originals gave Netflix a timeline advantage in building owned IP and production expertise before the streaming wars intensified', true),
    (v_question_id, 'C', 'Original content is cheaper to produce than licensing fees, so vertical integration was primarily a cost reduction play', false),
    (v_question_id, 'D', 'Netflix needed to integrate vertically because it had run out of licensed content and had no other option for catalog growth', false);

    -- ============================================
    -- QUESTION 32 (Advanced) — Competitive Intelligence
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 32,
        'Competitive Intelligence Methodology at Scale',
        'A PM at Databricks is building a competitive intelligence program to track Snowflake''s product moves, pricing changes, and customer wins. The PM needs to make strategic recommendations about product roadmap priorities based on competitive positioning. Which competitive intelligence approach will yield the MOST strategically actionable insights while remaining ethical?',
        'advanced',
        'Databricks',
        'Competitive intelligence program design in enterprise data platforms',
        'D',
        'The most strategically actionable competitive intelligence comes from triangulating win/loss analysis, public signals, and customer feedback. Win/loss analysis (systematically interviewing customers who chose Snowflake over Databricks, and vice versa) provides direct insight into competitive positioning gaps. This data, combined with public signals (product announcements, job postings indicating investment areas, patents, conference talks, customer case studies), creates a multi-dimensional view. The key insight is that competitive intelligence should drive product decisions, not just awareness. Knowing that you lose deals because of feature X is more actionable than knowing Snowflake launched feature Y. Purely technology-focused approaches miss the market positioning angle, and channel monitoring alone lacks depth. A structured program combines quantitative (win rates by segment) with qualitative (why we lose) for genuine strategic insight.',
        ARRAY['competitive_intelligence', 'competitive_response', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Hire a dedicated analyst to monitor Snowflake''s public blog and social media channels for product announcements', false),
    (v_question_id, 'B', 'Subscribe to industry analyst reports (Gartner, Forrester) and use their competitive positioning as the primary input', false),
    (v_question_id, 'C', 'Conduct regular deep-dive technical benchmarks comparing Databricks and Snowflake performance across standard workloads', false),
    (v_question_id, 'D', 'Triangulate structured win/loss analysis with public signal monitoring and customer feedback to understand not just what competitors launch, but why you win or lose specific deals', true);

    -- ============================================
    -- QUESTION 33 (Advanced) — Market Tipping Analysis
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 33,
        'Predicting Market Tipping in AI Foundation Models',
        'A PM at Anthropic is analyzing the competitive dynamics of the foundation model market (OpenAI/GPT, Google/Gemini, Anthropic/Claude, Meta/Llama, Mistral). The market is rapidly evolving with billions in investment. The PM needs to assess whether this market will tip toward winner-take-all or remain fragmented. Which analytical framework will yield the MOST accurate prediction of market structure?',
        'advanced',
        'Anthropic',
        'Foundation model market competitive structure prediction',
        'C',
        'Predicting market structure requires evaluating the specific conditions that drive winner-take-all outcomes: (1) strength of network effects — in AI models, direct network effects are weak because one user''s use doesn''t improve another''s experience; however, data network effects from fine-tuning could create some advantage. (2) Multi-homing costs — developers can easily use multiple AI APIs, switching between models with minimal code changes, which resists tipping. (3) Differentiation sustainability — if models converge in capability (commoditization), the market fragments on price; if leaders maintain capability gaps, it concentrates. (4) Regulatory moats — compliance requirements may limit the field. Analyzing these four factors together suggests the foundation model market is more likely winner-take-most than winner-take-all, because low multi-homing costs and moderate network effects prevent tipping. This is more rigorous than using analogies, single-factor analysis, or pure financial analysis.',
        ARRAY['winner_take_all', 'network_effects', 'multi_homing', 'market_dynamics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Analyze which company has raised the most funding — capital advantage will determine the winner in a capital-intensive market', false),
    (v_question_id, 'B', 'Use historical analogies (search engine market, social media market) to predict that AI models will follow the same concentration pattern', false),
    (v_question_id, 'C', 'Evaluate the four tipping conditions — network effect strength, multi-homing costs, differentiation sustainability, and regulatory moats — to predict whether the market concentrates or fragments', true),
    (v_question_id, 'D', 'Track current benchmark performance (MMLU, HumanEval) and project the leader will maintain its advantage due to research talent accumulation', false);

    -- ============================================
    -- QUESTION 34 (Advanced) — Ecosystem War Strategy
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 34,
        'Atlassian''s Ecosystem Defense Strategy',
        'Atlassian (Jira, Confluence, Bitbucket) faces coordinated competitive threats: Monday.com and Linear are attacking project management, Notion is attacking documentation, GitHub is attacking code repositories, and Slack/Teams are attacking collaboration. Each competitor is best-in-class in their specific vertical. A PM at Atlassian is developing a competitive defense strategy. Given that Atlassian cannot be best-in-class in every vertical, what is the MOST effective competitive defense?',
        'advanced',
        'Atlassian',
        'Multi-front ecosystem defense against specialized competitors',
        'B',
        'When facing coordinated attacks from best-in-class vertical competitors, the most effective defense is strengthening cross-product integration to make the whole greater than the sum of parts. Atlassian cannot win a feature-by-feature comparison against Monday.com (project management), Notion (docs), or GitHub (repos) individually. However, Atlassian''s unique advantage is that Jira issues can be linked to Confluence docs, tracked in Bitbucket commits, and visible across products. Strengthening these integration points creates a "mesh" switching cost — adopting Monday.com for PM means losing the Jira-Confluence-Bitbucket integration layer. The marketplace (1,000+ apps) adds another integration layer. This strategy accepts being "good enough" in each vertical while being uniquely strong at the integration layer. Trying to win every vertical independently would spread resources too thin.',
        ARRAY['platform_competition', 'competitive_response', 'switching_costs', 'bundling_strategy']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Invest heavily in each product to achieve feature parity with every vertical competitor simultaneously', false),
    (v_question_id, 'B', 'Strengthen cross-product integration and workflow connectivity to make the integrated suite more valuable than the sum of individual best-in-class competitors', true),
    (v_question_id, 'C', 'Acquire each vertical competitor (Monday.com, Notion, etc.) to eliminate the competitive threats directly', false),
    (v_question_id, 'D', 'Focus all resources on Jira as the core product and deprecate Confluence and Bitbucket to avoid spreading resources thin', false);

    -- ============================================
    -- QUESTION 35 (Advanced) — Strategic Countermoves
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 35,
        'Google''s Competitive Response to ChatGPT',
        'When OpenAI launched ChatGPT in November 2022, Google faced its most significant competitive threat in search since its founding. Google had the AI technology (developed transformers, had LaMDA/Bard) but had not launched a consumer AI product. A PM at Google is retrospectively analyzing Google''s competitive response options. Which strategic consideration makes responding to ChatGPT fundamentally different from responding to a traditional search competitor like Bing?',
        'advanced',
        'Google',
        'Generative AI competitive threat to search monopoly',
        'D',
        'Google''s response to ChatGPT is fundamentally different from responding to Bing because ChatGPT threatens to disrupt the search BUSINESS MODEL, not just take search market share. Google Search generates revenue through advertising shown alongside search results. An AI assistant that gives direct answers reduces the number of links users click, potentially destroying the ad-supported model that generates $175B+ in annual revenue. This is the Innovator''s Dilemma at unprecedented scale: Google''s most rational AI response (direct answers) cannibalizes its most profitable business (search ads). A traditional competitor like Bing still operates within the same search-and-ads business model, so matching its features doesn''t threaten Google''s revenue. ChatGPT redefines the competitive frame from "which search engine" to "search engine vs. AI assistant" — a much more existential challenge. Google must simultaneously defend search revenue while investing in AI that might destroy it.',
        ARRAY['disruption_theory', 'competitive_response', 'market_dynamics', 'competitive_moat']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'ChatGPT has better underlying AI technology than Google, making it impossible for Google to compete on model quality', false),
    (v_question_id, 'B', 'ChatGPT''s brand awareness among consumers is so strong that Google''s brand advantage in search has been neutralized', false),
    (v_question_id, 'C', 'OpenAI has more training data than Google because ChatGPT users provide billions of conversation examples for fine-tuning', false),
    (v_question_id, 'D', 'ChatGPT threatens to disrupt Google''s ad-supported business model by reducing link clicks, creating an Innovator''s Dilemma where Google''s best AI response cannibalizes its most profitable revenue stream', true);

END $$;
