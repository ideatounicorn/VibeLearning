-- ============================================
-- QUESTION BANK: Product Sense > Product Intuition
-- Sub-skill slug: product-intuition
-- Total questions: 35
-- Difficulty: 10 foundational, 18 intermediate, 7 advanced
-- Products: Netflix, Spotify, Instagram, Uber, Twitter/X,
--           Slack, Airbnb, TikTok, LinkedIn, Amazon,
--           Duolingo, WhatsApp, YouTube, Notion, Figma,
--           Snapchat, Pinterest, Apple, Zoom, Google Maps
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_question_id UUID;
BEGIN
    -- Look up the sub_skill ID for product-intuition
    SELECT ss.id INTO v_sub_skill_id
    FROM sub_skills ss
    JOIN categories c ON c.id = ss.category_id
    WHERE ss.slug = 'product-intuition'
      AND c.slug = 'product-sense';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill "product-intuition" under "product-sense" not found. Seed categories first.';
    END IF;

    -- ============================================
    -- QUESTION 1 (Foundational) — Instagram
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 1,
        'Instagram Hides Public Like Counts',
        'Instagram decides to hide public like counts on posts, so only the post creator can see how many likes they received. As a PM evaluating this decision, you need to predict the most significant first-order behavioral change among content creators on the platform.',
        'foundational',
        'Instagram',
        'Social media platform with 2B+ monthly active users, heavily reliant on engagement metrics',
        'B',
        'When Instagram hides public like counts, the most significant first-order effect on creators is a shift in content strategy away from "safe" viral formats toward more authentic, personal content. Without the social proof pressure of visible like counts, creators feel less anxious about posting content that might not perform well numerically. Option A is a second-order effect that would follow over time. Option C overestimates the immediate impact—most creators won''t leave a platform with 2B users over this change. Option D confuses correlation with causation; posting frequency is driven by many factors beyond like visibility.',
        ARRAY['user_behavior_prediction', 'product_taste', 'user_psychology']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Advertisers will immediately reduce spending due to lack of engagement transparency', false),
    (v_question_id, 'B', 'Creators will experiment with more diverse and authentic content types since social proof pressure is reduced', true),
    (v_question_id, 'C', 'Most power creators will migrate to platforms that still show public like counts', false),
    (v_question_id, 'D', 'Average posting frequency will drop dramatically because creators lose motivation without visible validation', false);

    -- ============================================
    -- QUESTION 2 (Foundational) — Netflix
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 2,
        'Netflix Introduces an Ad-Supported Tier',
        'Netflix launches a lower-priced ad-supported subscription tier at $6.99/month (compared to $15.49 for Standard). As a PM, you need to predict which user segment will be the primary adopter of this tier and why.',
        'foundational',
        'Netflix',
        'Streaming service with 230M+ subscribers globally, facing market saturation and rising churn',
        'C',
        'The primary adopters of an ad-supported tier are price-sensitive users who were previously churning or sharing passwords, not existing premium subscribers downgrading. This reflects the behavioral economics principle that people value loss aversion—existing subscribers have already mentally budgeted for the higher price and accepted the ad-free experience. Asking them to accept ads feels like a loss. Meanwhile, churned users and password-sharers gain access they previously lacked, making the ad-supported tier feel like a pure gain. Option A overestimates downgrade behavior. Option B focuses too narrowly. Option D ignores that cord-cutters already have free ad-supported alternatives.',
        ARRAY['user_behavior_prediction', 'behavioral_economics', 'product_market_fit']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Existing premium subscribers who want to reduce their monthly bill', false),
    (v_question_id, 'B', 'Heavy binge-watchers who want any Netflix access at any price', false),
    (v_question_id, 'C', 'Price-sensitive users who were previously churning or sharing passwords, since the tier represents a gain rather than a loss', true),
    (v_question_id, 'D', 'Traditional TV viewers transitioning to streaming for the first time', false);

    -- ============================================
    -- QUESTION 3 (Foundational) — Uber
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 3,
        'Uber Removes Surge Pricing Display',
        'Uber is considering hiding the surge multiplier from riders and instead showing only the final upfront price. As a PM, what is the most likely user behavior change?',
        'foundational',
        'Uber',
        'Ride-hailing platform operating in 70+ countries with dynamic pricing model',
        'A',
        'When users see a 3.5x surge multiplier, they experience sticker shock and often wait or switch to alternatives. By showing only the upfront price, Uber removes the anchoring effect of the multiplier. Users evaluate the price in absolute terms rather than relative terms, which reduces perceived unfairness. A $45 ride feels more acceptable than seeing "3.5x surge" even if the normal price is $13. This is a well-documented anchoring bias in behavioral economics. Option B overestimates user sophistication in real-time price comparison. Option C confuses transparency with trust—users care more about predictability. Option D misunderstands that the underlying pricing model remains unchanged.',
        ARRAY['behavioral_economics', 'user_psychology', 'product_judgment', 'ux_friction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Ride acceptance rates during high-demand periods will increase because users evaluate absolute prices without the anchoring effect of a multiplier', true),
    (v_question_id, 'B', 'Users will start comparing prices across ride-hailing apps more frequently before each trip', false),
    (v_question_id, 'C', 'User trust will decrease significantly because they perceive hidden pricing as deceptive', false),
    (v_question_id, 'D', 'Driver supply during peak hours will decrease because drivers no longer see surge incentives', false);

    -- ============================================
    -- QUESTION 4 (Foundational) — Spotify
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 4,
        'Spotify Wrapped''s Viral Success',
        'Spotify Wrapped generates massive organic social sharing every December. As a PM analyzing why this feature works so well, which insight best explains its viral success from a product intuition perspective?',
        'foundational',
        'Spotify',
        'Music streaming platform with 600M+ users, freemium model',
        'D',
        'Spotify Wrapped succeeds because it transforms personal data into shareable identity signals. People share their Wrapped not because of the data itself, but because it helps them express "who they are" to their social networks. It leverages the psychological need for self-expression and identity construction. The annual cadence creates scarcity and anticipation, while the personalized nature makes each person''s Wrapped feel unique and authentic. Option A captures a partial truth but misses the identity dimension. Option B overemphasizes FOMO as the driver. Option C is a feature description, not an insight into why it works virally.',
        ARRAY['product_taste', 'user_psychology', 'product_judgment']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'It provides users with novel data insights they couldn''t access elsewhere throughout the year', false),
    (v_question_id, 'B', 'The annual timing creates FOMO that drives users to share before the content expires', false),
    (v_question_id, 'C', 'The colorful, pre-formatted Stories templates make sharing frictionless across platforms', false),
    (v_question_id, 'D', 'It transforms passive consumption data into active identity signals, letting users express who they are through their music taste', true);

    -- ============================================
    -- QUESTION 5 (Foundational) — WhatsApp
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 5,
        'WhatsApp''s Blue Check Marks Controversy',
        'When WhatsApp introduced blue double-check marks (read receipts) in 2014, it sparked significant user backlash. As a PM, which product intuition best explains why a seemingly helpful feature created such negative reactions?',
        'foundational',
        'WhatsApp',
        'Messaging platform with 2B+ users, known for simplicity and privacy focus',
        'B',
        'Read receipts violated an unspoken social contract in messaging: the plausible deniability of not having seen a message. Before blue checks, users could read messages and respond at their own pace without social pressure. The feature created an obligation loop—once someone sees you''ve read their message, delayed responses feel like intentional ignoring. This demonstrates a crucial product intuition: features that add information transparency can destroy valuable social ambiguity. Option A is partially true but misses the behavioral core. Option C is a surface-level observation. Option D overestimates technical concerns versus social ones.',
        ARRAY['unintended_consequences', 'user_psychology', 'product_critique', 'design_tradeoff']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Users felt it was a privacy violation because WhatsApp was sharing their online activity data', false),
    (v_question_id, 'B', 'It destroyed valuable social ambiguity—the ability to read messages without the obligation to respond immediately—creating unwanted social pressure', true),
    (v_question_id, 'C', 'Users were frustrated because the feature was enabled by default without their explicit consent', false),
    (v_question_id, 'D', 'The feature consumed additional battery and data, creating a tangible negative impact on device performance', false);

    -- ============================================
    -- QUESTION 6 (Foundational) — TikTok
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 6,
        'TikTok''s Full-Screen Vertical Video Format',
        'TikTok popularized full-screen, vertical, sound-on short videos when competitors like Instagram and YouTube used horizontal or mixed formats. From a product intuition standpoint, what is the most important reason this format decision was critical to TikTok''s explosive growth?',
        'foundational',
        'TikTok',
        'Short-form video platform with 1.5B+ monthly active users',
        'A',
        'TikTok''s full-screen vertical format eliminates all UI chrome and competing content, creating an immersive experience that maximizes the psychological state of flow. When a video fills the entire screen, the viewer''s attention is fully captured with zero distraction. This dramatically increases watch-through rates and emotional engagement per video, which feeds the recommendation algorithm with stronger signals. The format decision was not just a design choice—it was a product architecture decision that created a fundamentally different attention dynamic. Option B is true but secondary. Option C reverses causation. Option D describes a consequence, not the core reason.',
        ARRAY['product_taste', 'product_judgment', 'design_tradeoff', 'user_psychology']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Full-screen eliminates all competing UI elements, maximizing attentional capture and creating a flow state that dramatically increases per-video engagement signals', true),
    (v_question_id, 'B', 'Vertical video matched how people naturally hold their phones, reducing the physical friction of rotating devices', false),
    (v_question_id, 'C', 'It made content creation easier because phone cameras default to vertical recording', false),
    (v_question_id, 'D', 'It differentiated TikTok from YouTube and Instagram, giving it a unique visual identity in the market', false);

    -- ============================================
    -- QUESTION 7 (Foundational) — Duolingo
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 7,
        'Duolingo''s Streak Mechanism and Loss Aversion',
        'Duolingo''s streak counter (consecutive days of practice) is one of its most effective retention features. The app sends increasingly urgent notifications as a streak is at risk. As a PM, which behavioral economics principle best explains why streaks drive retention more effectively than positive rewards like badges?',
        'foundational',
        'Duolingo',
        'Language learning app with 80M+ monthly active users, gamified learning approach',
        'C',
        'Duolingo''s streak leverages loss aversion—the psychological principle that the pain of losing something is roughly twice as powerful as the pleasure of gaining something equivalent. A user with a 50-day streak doesn''t open the app for the positive reward of reaching day 51; they open it to avoid the devastating loss of their 50-day investment. This asymmetry between loss and gain is why streak mechanics outperform badge systems: badges offer gains, while streaks threaten losses. The longer the streak, the higher the perceived cost of breaking it, creating an escalating commitment loop. Option A describes a different phenomenon. Option B is too simplistic. Option D describes a real effect but not the primary driver.',
        ARRAY['behavioral_economics', 'user_psychology', 'product_judgment', 'feature_evaluation']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The endowment effect—users feel ownership over their streak and overvalue it compared to its objective worth', false),
    (v_question_id, 'B', 'Habit formation—the streak creates a daily routine that becomes automatic over time', false),
    (v_question_id, 'C', 'Loss aversion—the psychological pain of losing an accumulated streak is roughly twice as motivating as the pleasure of extending it by one day', true),
    (v_question_id, 'D', 'Social comparison—users are motivated by seeing their streak relative to friends'' streaks on leaderboards', false);

    -- ============================================
    -- QUESTION 8 (Foundational) — Slack
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 8,
        'Slack''s Emoji Reactions as Product Innovation',
        'Slack introduced emoji reactions to messages, which became one of its most-used features. Many competitors had only "like" buttons. As a PM, which product intuition best explains why emoji reactions were a superior product decision compared to a simple like button?',
        'foundational',
        'Slack',
        'Enterprise messaging platform with 30M+ daily active users',
        'D',
        'Emoji reactions are brilliant because they provide a full spectrum of low-effort acknowledgment without generating notification noise or cluttering conversation threads. A simple "like" button is binary—you either liked it or you didn''t respond. Emoji reactions allow nuanced communication (agreement via ✅, humor via 😂, concern via 😟, celebration via 🎉) that would otherwise require a typed reply. This reduces message volume while increasing signal density. In a workplace context, this distinction is critical because excess messages create notification fatigue. Option A captures partial value. Option B is tangential. Option C overstates the fun factor relative to the functional value.',
        ARRAY['product_taste', 'design_tradeoff', 'product_judgment', 'ux_friction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Emoji reactions gamified workplace communication and made Slack feel more fun than email', false),
    (v_question_id, 'B', 'They provided managers with better data on message engagement and team sentiment', false),
    (v_question_id, 'C', 'They made Slack visually distinctive from competitors with a playful, modern brand personality', false),
    (v_question_id, 'D', 'They enabled nuanced, low-friction acknowledgment that reduced unnecessary reply messages while preserving rich communication signals', true);

    -- ============================================
    -- QUESTION 9 (Foundational) — Amazon
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 9,
        'Amazon''s 1-Click Purchase and Friction Reduction',
        'Amazon patented 1-Click purchasing in 1999, and it became one of the most valuable product innovations in e-commerce history. A junior PM argues the feature''s success was simply about saving time. As a senior PM, which deeper product insight explains why 1-Click was transformative?',
        'foundational',
        'Amazon',
        'E-commerce platform with 300M+ active customer accounts, $500B+ annual revenue',
        'B',
        'The genius of 1-Click wasn''t just time savings—it was eliminating the "consideration window" where rational thinking leads to cart abandonment. Multi-step checkouts create cognitive pause points where users reconsider their purchase, compare prices, or decide they don''t really need the item. Each step in a checkout flow is an opportunity for the rational brain to override the emotional impulse to buy. 1-Click collapses the entire decision-reconsideration window into a single moment of impulse. This is why it disproportionately increased conversion on discretionary purchases. Option A is a surface-level observation. Option C overstates the trust mechanism. Option D confuses a technical detail with the behavioral insight.',
        ARRAY['product_taste', 'behavioral_economics', 'ux_friction', 'product_judgment']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'It saved users approximately 30 seconds per purchase, and at Amazon''s scale that compounded into millions of hours saved', false),
    (v_question_id, 'B', 'It eliminated the cognitive "reconsideration window" in multi-step checkouts where rational deliberation leads to cart abandonment', true),
    (v_question_id, 'C', 'It built trust by signaling that Amazon had already securely stored payment information, reducing anxiety about data entry', false),
    (v_question_id, 'D', 'It gave Amazon a defensible patent moat that prevented competitors from offering similarly frictionless checkout', false);

    -- ============================================
    -- QUESTION 10 (Foundational) — LinkedIn
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 10,
        'LinkedIn''s "Who Viewed Your Profile" Feature',
        'LinkedIn''s "Who Viewed Your Profile" is consistently one of its most-visited features and a key driver of premium subscriptions. As a PM, which product intuition best explains why this feature is so compelling to users?',
        'foundational',
        'LinkedIn',
        'Professional networking platform with 900M+ members',
        'A',
        'The "Who Viewed Your Profile" feature exploits reciprocal curiosity—a deeply hardwired social instinct. When someone tells you that a person looked at you, you almost can''t help but look back. This creates a self-reinforcing engagement loop: User A views User B''s profile → User B gets notified → User B views User A''s profile → User A gets notified → cycle continues. The feature is essentially a built-in engagement flywheel that requires no content creation. LinkedIn then gates the full list behind Premium, creating the most natural upsell in SaaS: monetizing a fundamental human curiosity. Option B partially explains appeal but misses the loop mechanism. Option C is backwards—the feature drives engagement, not vice versa. Option D overstates job-seeking motivation.',
        ARRAY['user_psychology', 'product_taste', 'value_proposition', 'product_judgment']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'It exploits reciprocal curiosity—a hardwired social instinct that creates a self-reinforcing engagement loop when users view each other''s profiles', true),
    (v_question_id, 'B', 'It provides professional validation, as each profile view signals that the user is relevant and in-demand in their industry', false),
    (v_question_id, 'C', 'It gives users a reason to keep their profile updated, which increases content freshness across the platform', false),
    (v_question_id, 'D', 'It helps job seekers identify which recruiters are interested in them, serving LinkedIn''s core job marketplace value proposition', false);

    -- ============================================
    -- QUESTION 11 (Intermediate) — Twitter/X
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 11,
        'Twitter/X Edit Button Second-Order Effects',
        'Twitter/X finally introduces an edit button that allows users to modify tweets within 30 minutes of posting. As a PM, you need to predict the most significant second-order effect this will have on the platform ecosystem.',
        'intermediate',
        'Twitter/X',
        'Microblogging platform with 550M+ monthly active users, real-time public conversation focus',
        'B',
        'The most significant second-order effect of an edit button is the undermining of quote tweets and screenshots as a trust mechanism. Twitter''s conversational dynamics rely heavily on the immutability of tweets—when someone quote-tweets a controversial statement, the original cannot be changed. With editing enabled, a new attack vector emerges: post something provocative, wait for engagement and quote tweets, then edit the original to something benign, making the people who criticized it look unreasonable. This "bait-and-switch" dynamic fundamentally changes the trust model of public discourse on the platform. Option A overestimates the behavioral change. Option C focuses on a minor quality improvement. Option D describes a possible but unlikely advertiser response to a feature most users want.',
        ARRAY['second_order_effects', 'unintended_consequences', 'product_judgment', 'user_behavior_prediction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Users will post more frequently because the psychological cost of typos and mistakes is reduced', false),
    (v_question_id, 'B', 'Quote tweets and screenshot-based accountability will be undermined because users can bait engagement and then edit the original to make critics look unreasonable', true),
    (v_question_id, 'C', 'The overall quality of discourse will improve as users refine their thoughts instead of posting hasty hot takes', false),
    (v_question_id, 'D', 'Advertisers will reduce spend because edited tweets create brand safety concerns around changing content', false);

    -- ============================================
    -- QUESTION 12 (Intermediate) — Airbnb
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 12,
        'Airbnb''s Star Rating Inflation Problem',
        'Airbnb data shows that 72% of all listings have a rating of 4.7 or higher, making it nearly impossible for guests to differentiate quality. A PM proposes switching from a 5-star system to a binary "Would you recommend?" system. What is the most likely outcome?',
        'intermediate',
        'Airbnb',
        'Short-term rental marketplace operating in 190+ countries',
        'C',
        'Switching to a binary system would actually decrease overall information value for guests while increasing host anxiety. In the current system, the difference between 4.7 and 4.9 still provides some signal despite compression at the top. A binary system collapses this remaining gradient into just two buckets. Additionally, social pressure to say "yes, I''d recommend" is even stronger than the pressure to give 5 stars—binary negative feedback feels more personal and confrontational. The real solution to rating inflation is to change the question granularity (rate specific aspects like cleanliness, accuracy, location separately) rather than changing the scale. Option A overestimates the rationality of the change. Option B is wishful thinking. Option D misidentifies the primary risk.',
        ARRAY['product_critique', 'user_psychology', 'design_tradeoff', 'product_judgment']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Quality differentiation will improve because the binary choice eliminates the ambiguity of star gradations', false),
    (v_question_id, 'B', 'Guests will provide more honest feedback because the binary format feels less consequential than star ratings', false),
    (v_question_id, 'C', 'Information value will decrease because binary recommendation has even stronger social pressure to say "yes" than 5-star ratings, while eliminating the subtle gradient between 4.7 and 4.9', true),
    (v_question_id, 'D', 'Host churn will spike dramatically as many currently high-rated hosts receive their first "not recommended" ratings', false);

    -- ============================================
    -- QUESTION 13 (Intermediate) — YouTube
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 13,
        'YouTube Removes Public Dislike Counts',
        'YouTube removed the public dislike count in late 2021, showing only likes. As a PM performing a product critique of this decision, which is the most important unintended consequence to flag?',
        'intermediate',
        'YouTube',
        'Video platform with 2.5B+ monthly active users, creator economy ecosystem',
        'D',
        'The most significant unintended consequence is the degradation of dislike counts as a crowdsourced quality signal for informational and tutorial content. Before the change, users could quickly assess whether a tutorial, how-to, or instructional video was accurate and helpful by checking the like-to-dislike ratio. A coding tutorial with 50K likes and 25K dislikes was a clear signal of problematic content. Without visible dislikes, users must watch the video to discover it''s misleading, wasting their time and potentially following bad advice. This disproportionately harms viewers of educational and informational content, which is a core YouTube use case. Option A overstates creator behavior change. Option B describes a minor effect. Option C is speculative about advertiser behavior.',
        ARRAY['unintended_consequences', 'product_critique', 'second_order_effects', 'design_tradeoff']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Creators will become complacent about quality since they no longer receive public negative feedback signals', false),
    (v_question_id, 'B', 'Comment sections will become more toxic as users shift from disliking to writing negative comments', false),
    (v_question_id, 'C', 'Advertisers will lose confidence in placement quality without dislike signals as a proxy for brand safety', false),
    (v_question_id, 'D', 'Viewers lose a critical crowdsourced quality signal for informational content, making it harder to identify misleading tutorials and scam videos', true);

    -- ============================================
    -- QUESTION 14 (Intermediate) — Snapchat
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 14,
        'Snapchat''s Disappearing Messages as Product Insight',
        'Snapchat''s core innovation was ephemeral messaging—content that disappears after viewing. As a PM reverse-engineering why this product decision was so successful with teenagers, which insight demonstrates the deepest product intuition?',
        'intermediate',
        'Snapchat',
        'Multimedia messaging app, pioneered ephemeral content',
        'B',
        'Snapchat''s disappearing messages succeeded because they reduced the stakes of every interaction. On permanent platforms like Facebook, every post becomes part of a permanent record, creating "performance anxiety" where users carefully curate what they share. Ephemeral content inverts this dynamic: because nothing persists, users feel free to be spontaneous, silly, and authentic. This is particularly powerful for teenagers who are developing their identity and don''t want today''s content judged in the future. The insight isn''t about privacy from parents or novelty—it''s about fundamentally lowering the psychological cost of sharing, which dramatically increases sharing volume and frequency. Option A captures a secondary benefit. Option C is a surface-level observation. Option D overemphasizes parental dynamics.',
        ARRAY['product_taste', 'user_psychology', 'product_judgment', 'value_proposition']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Teenagers valued privacy from parents and authority figures, and disappearing content provided that security', false),
    (v_question_id, 'B', 'Ephemerality reduced the psychological cost of every interaction by eliminating the permanent record, encouraging spontaneous and authentic sharing at much higher volumes', true),
    (v_question_id, 'C', 'The novelty of disappearing content was inherently viral and drove word-of-mouth adoption among teens', false),
    (v_question_id, 'D', 'Teenagers wanted a platform their parents didn''t understand, and the unintuitive UX served as a natural age filter', false);

    -- ============================================
    -- QUESTION 15 (Intermediate) — Pinterest
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 15,
        'Pinterest''s Shift to Shopping and Feature Cannibalization',
        'Pinterest aggressively adds shopping features—buyable pins, product catalogs, price tracking—to monetize its platform. As a PM, what is the primary cannibalization risk this creates?',
        'intermediate',
        'Pinterest',
        'Visual discovery and bookmarking platform with 450M+ monthly active users',
        'A',
        'Pinterest''s core value proposition is aspirational browsing—users come to dream, plan, and discover without purchase pressure. The platform''s unique strength is the "inspiration" phase of the consumer journey, which feels fundamentally different from "shopping." By aggressively injecting transactional elements, Pinterest risks transforming the browsing experience from aspirational to commercial, which may cannibalize the very engagement patterns that make it valuable. Users who feel they''re being sold to will browse less freely, pin less often, and spend less time on the platform. This is the classic tension between monetization and core value preservation. Option B overstates competitive dynamics. Option C reverses the likely outcome. Option D focuses on a narrow use case.',
        ARRAY['feature_cannibalization', 'product_critique', 'value_proposition', 'design_tradeoff']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Shopping features may cannibalize Pinterest''s core "aspirational browsing" experience by making the platform feel transactional, reducing the exploratory engagement that makes it unique', true),
    (v_question_id, 'B', 'Pinterest will lose users to Instagram Shopping and TikTok Shop because those platforms have stronger social proof mechanisms for purchases', false),
    (v_question_id, 'C', 'Conversion rates will be very low because Pinterest users have no purchase intent, wasting engineering resources', false),
    (v_question_id, 'D', 'Wedding and home decor planners—Pinterest''s power users—will feel the platform has become too commercial for planning purposes', false);

    -- ============================================
    -- QUESTION 16 (Intermediate) — Notion
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 16,
        'Notion''s Flexibility vs. Simplicity Trade-off',
        'Notion prides itself on being an "all-in-one workspace" where users can build almost any workflow. However, the PM team notices that new user retention at Day 7 is significantly lower than competitors like Todoist or Trello. As a PM, what product intuition best explains this gap?',
        'intermediate',
        'Notion',
        'All-in-one workspace tool with 30M+ users, known for extreme flexibility',
        'B',
        'Notion suffers from the "blank canvas problem"—the paradox of choice applied to productivity tools. When a new user opens Todoist, the value proposition is immediately clear: add a task, check it off. When a new user opens Notion, they face an empty page with infinite possibilities and no clear starting point. The cognitive load of deciding how to structure their workspace creates paralysis that leads to abandonment. This is a classic tension in product design: flexibility is a power-user retention driver but a new-user conversion killer. The product intuition here is that the same feature (extreme flexibility) can be simultaneously the biggest strength for retained users and the biggest weakness for new users. Option A oversimplifies the problem. Option C misidentifies the issue. Option D focuses on a narrow competitive point.',
        ARRAY['design_tradeoff', 'ux_friction', 'product_critique', 'feature_adoption_prediction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Notion''s learning curve is too steep because its interface uses unfamiliar UI patterns unlike standard productivity apps', false),
    (v_question_id, 'B', 'Extreme flexibility creates a "blank canvas problem" where the cognitive load of deciding how to structure a workspace causes new user paralysis and abandonment', true),
    (v_question_id, 'C', 'Notion tries to replace too many tools simultaneously, and users prefer best-in-class point solutions for each use case', false),
    (v_question_id, 'D', 'Notion''s free tier is too limited compared to Trello''s, creating a paywall barrier before users experience the product''s value', false);

    -- ============================================
    -- QUESTION 17 (Intermediate) — Apple
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 17,
        'Apple''s Removal of the Headphone Jack',
        'In 2016, Apple removed the 3.5mm headphone jack from the iPhone 7, facing massive backlash. As a PM looking back with product intuition, which insight best explains why this was ultimately a strong product decision despite short-term criticism?',
        'intermediate',
        'Apple',
        'Consumer electronics company, iOS ecosystem with 1.5B+ active devices',
        'C',
        'Apple''s headphone jack removal was a platform-level decision that created an ecosystem forcing function. By removing the jack, Apple didn''t just sell more AirPods—it accelerated the entire wireless audio ecosystem, created a new product category that generated $12B+ in annual revenue, and established audio as a new platform for Apple services (spatial audio, hearing health, etc.). The key product intuition is recognizing when removing a feature creates more value than adding one. Apple sacrificed a universally understood input for a wireless future that enabled new product categories, new services, and deeper ecosystem lock-in. Short-term backlash was the cost of long-term platform expansion. Option A is too narrow. Option B is a contributing factor, not the strategic insight. Option D overemphasizes the hardware design element.',
        ARRAY['product_judgment', 'product_taste', 'design_tradeoff', 'second_order_effects']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'It was primarily a cost-cutting measure that simplified manufacturing and improved water resistance', false),
    (v_question_id, 'B', 'It forced industry-wide adoption of Bluetooth audio, improving the wireless audio experience for all users over time', false),
    (v_question_id, 'C', 'It was a platform-level forcing function that created a new product category (AirPods), new service opportunities, and deeper ecosystem lock-in worth far more than the jack itself', true),
    (v_question_id, 'D', 'It freed internal space for a larger battery and Taptic Engine, directly improving the core phone experience', false);

    -- ============================================
    -- QUESTION 18 (Intermediate) — Zoom
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 18,
        'Zoom''s "Join Without Account" as Growth Driver',
        'Zoom grew from 10M to 300M daily meeting participants in early 2020. While the pandemic was the catalyst, many video tools existed. As a PM, which product decision was most critical in enabling Zoom to capture disproportionate market share during this moment?',
        'intermediate',
        'Zoom',
        'Video conferencing platform, rapid growth during COVID-19 pandemic',
        'B',
        'Zoom''s decision to let participants join meetings without creating an account was the critical growth enabler. When a teacher sent a Zoom link to 30 students'' parents, every parent could click and join instantly regardless of technical ability. Compare this with competitors that required account creation, app downloads, or plugin installations—each step filtered out less technical users. In a moment where adoption speed determined market share, Zoom''s zero-friction join flow meant that every meeting invitation was essentially a one-click product trial. This is a powerful product intuition: in communication tools, the barrier to join (not the barrier to host) determines viral growth. Option A conflates quality with adoption speed. Option C overestimates brand impact. Option D is accurate but secondary.',
        ARRAY['product_taste', 'ux_friction', 'product_market_fit', 'feature_adoption_prediction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Zoom''s superior video quality and reliability made it the technically best option available during the surge', false),
    (v_question_id, 'B', 'Allowing participants to join via a link without creating an account removed the critical friction point—in communication tools, the join barrier (not the host barrier) determines viral growth', true),
    (v_question_id, 'C', 'Zoom''s strong brand recognition from enterprise use pre-pandemic gave it top-of-mind awareness when consumers needed video calling', false),
    (v_question_id, 'D', 'Zoom''s generous free tier (40-minute meetings, 100 participants) eliminated the cost barrier that competitors maintained', false);

    -- ============================================
    -- QUESTION 19 (Intermediate) — Spotify
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 19,
        'Spotify''s Podcast Expansion and Platform Risk',
        'Spotify invested $1B+ in podcast acquisitions (Gimlet, Anchor, Joe Rogan exclusives) to become an audio platform beyond music. As a PM evaluating this product strategy, what is the most critical product intuition about why this bet could backfire?',
        'intermediate',
        'Spotify',
        'Audio streaming platform, 600M+ users, historically music-focused',
        'D',
        'The deepest product risk is that podcasts and music have fundamentally different consumption patterns that may conflict in a single app experience. Music listening is passive, ambient, and repeatable—you play the same songs hundreds of times. Podcast listening is active, sequential, and one-time—you listen to each episode once, in order. These opposing patterns create UX tension: the ideal music interface (shuffle, radio, discover) conflicts with the ideal podcast interface (subscribe, queue, resume). Cramming both into one app risks creating a compromised experience for both use cases, satisfying neither power music listeners nor dedicated podcast consumers. Option A is a valid concern but secondary to the product design challenge. Option B underestimates Spotify''s distribution advantage. Option C misidentifies the strategic risk.',
        ARRAY['product_critique', 'design_tradeoff', 'feature_cannibalization', 'product_judgment']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Exclusive podcast deals will anger creators who value platform independence and open distribution', false),
    (v_question_id, 'B', 'Podcasts generate lower ad revenue per hour than music streams, diluting Spotify''s overall revenue per user', false),
    (v_question_id, 'C', 'Apple Podcasts has too strong a first-mover advantage in podcast discovery for Spotify to overcome', false),
    (v_question_id, 'D', 'Music and podcasts have fundamentally opposing consumption patterns (passive/repeatable vs. active/sequential), creating UX tension that risks compromising both experiences in a single app', true);

    -- ============================================
    -- QUESTION 20 (Intermediate) — Google Maps
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 20,
        'Google Maps Adding Social Features',
        'Google Maps adds social features: the ability to follow friends, see where they''ve been, and share real-time location permanently. As a PM, what is the most likely reason this feature will see low adoption despite Google''s massive user base?',
        'intermediate',
        'Google Maps',
        'Navigation and mapping app with 1B+ monthly active users',
        'A',
        'Google Maps is a utility with a clear task-oriented mental model: "I need to get from A to B" or "I need to find a restaurant nearby." Users open Maps with a specific intent and close it when the task is done. Adding social features conflicts with this mental model because users don''t think of Maps as a place to connect with friends. This is the product intuition of "job-to-be-done" mismatch—users hire Google Maps for navigation, not socialization. Even if the social feature is well-built, users won''t discover or engage with it because it doesn''t match their intent when they open the app. The feature asks users to change their mental model of what Maps is for, which is extremely difficult. Option B overstates privacy concerns relative to mental model mismatch. Option C focuses on competition rather than the core issue. Option D is too narrow.',
        ARRAY['user_behavior_prediction', 'product_judgment', 'feature_adoption_prediction', 'user_psychology']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Users'' mental model of Maps is task-oriented (navigation/search), and social features conflict with the "job-to-be-done" they hire the app for, so they won''t engage despite availability', true),
    (v_question_id, 'B', 'Privacy concerns about location sharing will override any social benefit, as users consider location data too sensitive to share permanently', false),
    (v_question_id, 'C', 'Users already have social location sharing on Instagram, Snapchat, and WhatsApp, so Maps offers no unique value', false),
    (v_question_id, 'D', 'Google''s poor track record with social products (Google+, Allo, Buzz) has trained users to ignore Google''s social features', false);

    -- ============================================
    -- QUESTION 21 (Intermediate) — Uber
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 21,
        'Uber Eats Cannibalization of Core Rides Business',
        'Uber Eats grew to generate more revenue than Uber Rides in some markets. As a PM, what is the most nuanced product intuition about how Uber Eats could cannibalize the Rides business in an unexpected way?',
        'intermediate',
        'Uber',
        'Ride-hailing and delivery platform, multi-sided marketplace',
        'C',
        'The most nuanced cannibalization risk is on the supply side: delivery driving is more appealing to many drivers because they don''t need to interact with passengers, can work at their own pace, and face less confrontation risk. If Uber Eats offers comparable earnings with less social friction, drivers will preferentially shift to deliveries during peak meal times, which often overlap with peak ride demand (lunch, dinner). This supply-side competition between the two services could increase ride wait times and prices exactly when ride demand is highest, degrading the core Rides experience. This is a subtle form of internal marketplace cannibalization that financial metrics might miss. Option A focuses on demand, not the supply-side conflict. Option B overstates user perception. Option D describes a separate concern.',
        ARRAY['feature_cannibalization', 'second_order_effects', 'product_judgment', 'unintended_consequences']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Users who order food delivery may reduce their dining-out occasions, reducing the need for rides to restaurants', false),
    (v_question_id, 'B', 'The Uber brand becomes associated with food delivery rather than premium transportation, diluting brand value', false),
    (v_question_id, 'C', 'Drivers preferentially shift to delivery during peak meal times because it involves less social friction, reducing driver supply for rides exactly when ride demand is highest', true),
    (v_question_id, 'D', 'Uber Eats'' lower margins could drag down overall company profitability, forcing price increases on the Rides side', false);

    -- ============================================
    -- QUESTION 22 (Intermediate) — Figma
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 22,
        'Figma''s Real-Time Multiplayer as Competitive Moat',
        'Figma disrupted Sketch and Adobe XD despite being a browser-based tool with initially fewer features. As a PM analyzing why Figma won, which product intuition reveals the deepest understanding of the competitive dynamics?',
        'intermediate',
        'Figma',
        'Browser-based collaborative design tool, acquired by Adobe for $20B (deal later abandoned)',
        'C',
        'Figma won because real-time multiplayer collaboration created a network effect that no amount of individual features could overcome. When a designer uses Figma, every stakeholder they invite—PMs, engineers, marketers—becomes a Figma user. Each new collaborator makes Figma more valuable for the entire team, and switching costs increase with every shared project. Sketch was a superior individual tool, but it was a single-player experience in a multiplayer world. The product intuition here is that in B2B tools, the product that optimizes for collaboration over individual power will eventually win because it captures the entire workflow graph, not just the designer node. This is why Figma could win with fewer features—it competed on a different dimension entirely. Option A is partially true but misses the network effect mechanism. Option B is true but is a technical enabler, not the strategic insight. Option D is too narrow.',
        ARRAY['product_taste', 'product_judgment', 'product_market_fit', 'value_proposition']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Figma''s browser-based architecture eliminated installation friction, making it easier to try than Sketch', false),
    (v_question_id, 'B', 'Figma''s performance in the browser eventually matched native apps, neutralizing Sketch''s technical advantage', false),
    (v_question_id, 'C', 'Real-time multiplayer created a network effect where each invited stakeholder increased switching costs and expanded Figma''s footprint across the entire workflow—competing on collaboration rather than features', true),
    (v_question_id, 'D', 'Figma''s generous free tier allowed individual designers to adopt it before convincing their organizations to switch', false);

    -- ============================================
    -- QUESTION 23 (Intermediate) — Amazon
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 23,
        'Amazon Prime''s Behavioral Lock-in Effect',
        'Amazon Prime has 200M+ subscribers globally. As a PM, which product intuition best explains why Prime is so effective at retaining subscribers beyond the free shipping benefit?',
        'intermediate',
        'Amazon',
        'E-commerce platform with bundled subscription service (Prime)',
        'B',
        'Prime creates a sunk cost psychology that fundamentally alters purchase behavior. Once users pay $139/year, they feel compelled to "get their money''s worth" by purchasing more from Amazon than they otherwise would, even when alternatives might be cheaper. This creates a self-reinforcing loop: paying for Prime → shopping more on Amazon → receiving more value → justifying the next renewal. The annual fee isn''t just a revenue stream—it''s a behavioral commitment device that shifts the default from "should I buy this on Amazon?" to "I''m already paying for Prime, so I should buy this on Amazon." The bundled benefits (Video, Music, Reading) reinforce this by making the perceived value always exceed the fee. Option A is true but describes a feature, not the behavioral mechanism. Option C is partially correct but secondary. Option D misidentifies the primary driver.',
        ARRAY['behavioral_economics', 'user_psychology', 'product_judgment', 'value_proposition']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The bundled benefits (Video, Music, Reading) create a perceived value that always exceeds the subscription cost', false),
    (v_question_id, 'B', 'The annual fee creates sunk cost psychology that shifts the purchase default from "should I buy on Amazon?" to "I need to maximize my Prime investment," driving more frequent purchases', true),
    (v_question_id, 'C', 'Two-day shipping creates a speed expectation that makes waiting 5-7 days from competitors feel unacceptable, raising switching costs', false),
    (v_question_id, 'D', 'Prime members develop a trust relationship with Amazon that reduces their willingness to try new shopping platforms', false);

    -- ============================================
    -- QUESTION 24 (Intermediate) — TikTok
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 24,
        'TikTok''s Algorithm vs. Social Graph Advantage',
        'TikTok''s "For You Page" surfaces content from strangers based on interests, while Instagram and Facebook prioritize content from people you follow. As a PM, what is the most important product intuition about why the algorithmic approach creates a structural advantage?',
        'intermediate',
        'TikTok',
        'Short-form video platform, algorithm-first content distribution',
        'D',
        'TikTok''s algorithmic approach eliminates the cold start problem for creators, which is the most powerful structural advantage in a content platform. On Instagram, a new creator posts to zero followers and gets zero views, creating a brutal chicken-and-egg problem that discourages new creator supply. On TikTok, a brand-new user''s first video can get 100K views if the algorithm detects strong engagement signals. This means TikTok has essentially unlimited creator supply because the barrier to getting an audience is zero. This abundance of creators means more diverse content, which means better algorithmic matching for viewers, which means higher engagement, which attracts more creators. Option A describes the consumer experience but not the structural advantage. Option B is partially true but secondary. Option C overstates the diversity angle without connecting it to the mechanism.',
        ARRAY['product_taste', 'product_judgment', 'product_market_fit', 'user_behavior_prediction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Users discover more serendipitous content they enjoy, increasing session times compared to social-graph-based feeds', false),
    (v_question_id, 'B', 'TikTok doesn''t need to solve the friend-finding onboarding challenge, so new users get value immediately without adding connections', false),
    (v_question_id, 'C', 'Content diversity is higher because the algorithm surfaces niche creators that social graphs would filter out', false),
    (v_question_id, 'D', 'It eliminates the cold start problem for creators—anyone''s first video can go viral, creating essentially unlimited creator supply and a self-reinforcing content flywheel', true);

    -- ============================================
    -- QUESTION 25 (Intermediate) — Airbnb
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 25,
        'Airbnb''s Professional Photography Program',
        'Early Airbnb noticed that listings with professional photos received 2-3x more bookings. They launched a free professional photography program for hosts. As a PM, what is the second-order product insight that makes this program far more valuable than just "better photos"?',
        'intermediate',
        'Airbnb',
        'Short-term rental marketplace, trust is a critical growth barrier',
        'A',
        'Professional photos don''t just improve individual listing performance—they raise the quality floor of the entire marketplace, which changes how all prospective guests perceive Airbnb''s brand. When a potential guest browses Airbnb and sees professional-quality photos throughout the platform, they unconsciously elevate their trust in the marketplace as a whole. This is a second-order effect: improving supply quality doesn''t just benefit the photographed listings—it increases the conversion rate of every listing on the platform by raising the perceived trustworthiness of "staying in a stranger''s home." The program essentially subsidized a platform-wide brand upgrade through individual listing investments. Option B focuses on a narrow operational benefit. Option C describes a side effect, not the core insight. Option D is a valid observation but misses the platform-level impact.',
        ARRAY['second_order_effects', 'product_judgment', 'product_taste', 'product_market_fit']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Professional photos raise the quality floor of the entire marketplace, increasing trust in the "stay in a stranger''s home" concept and improving conversion rates platform-wide, not just for photographed listings', true),
    (v_question_id, 'B', 'The photography visits allow Airbnb to verify listing accuracy in person, reducing fraud and bad experiences', false),
    (v_question_id, 'C', 'Hosts who receive free photography feel indebted to Airbnb and are less likely to list on competing platforms like VRBO', false),
    (v_question_id, 'D', 'Professional photos standardize what "good" looks like on Airbnb, helping new hosts understand quality expectations', false);

    -- ============================================
    -- QUESTION 26 (Intermediate) — Slack
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 26,
        'Slack''s Message Searchability as Hidden Value',
        'Slack makes all messages fully searchable, unlike email where finding old conversations is painful. A PM argues this is Slack''s most underappreciated competitive advantage. As a senior PM, which product intuition validates or challenges this claim?',
        'intermediate',
        'Slack',
        'Enterprise messaging platform, freemium model with message history limits on free tier',
        'C',
        'Searchability creates a powerful and counterintuitive lock-in effect: the more a team uses Slack, the more institutional knowledge is stored in its messages, making Slack increasingly difficult to leave. This is different from typical switching costs (data migration, retraining). Slack becomes the team''s institutional memory—containing decisions, context, rationale, and tribal knowledge that exists nowhere else. After a year of use, switching messaging tools means abandoning this searchable knowledge base, which teams are psychologically unwilling to do. The free tier''s message limit is essentially Slack saying "your institutional knowledge has a price." This validates the PM''s claim, but the insight is about lock-in through accumulated value rather than daily utility. Option A is partially true but misses the strategic implication. Option B challenges the claim without the right reasoning. Option D is a surface-level comparison.',
        ARRAY['product_judgment', 'value_proposition', 'product_taste', 'product_critique']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'The claim is valid because instant search reduces the time teams spend looking for information, directly improving productivity', false),
    (v_question_id, 'B', 'The claim is overstated because most users never search old messages and value real-time communication over archival', false),
    (v_question_id, 'C', 'The claim is valid but for a deeper reason: searchable message history becomes an irreplaceable institutional knowledge base, creating lock-in that increases with every day of use', true),
    (v_question_id, 'D', 'The claim is valid because Slack''s search is technically superior to email search, which is a concrete feature advantage users can evaluate', false);

    -- ============================================
    -- QUESTION 27 (Intermediate) — Netflix
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 27,
        'Netflix''s Auto-Play Next Episode Decision',
        'Netflix auto-plays the next episode after a brief countdown. As a PM critiquing this feature from a long-term product health perspective, what is the most important tension to identify?',
        'intermediate',
        'Netflix',
        'Streaming service optimizing for engagement metrics',
        'B',
        'The auto-play feature creates a short-term vs. long-term engagement trade-off. In the short term, auto-play demonstrably increases episodes watched per session by exploiting status quo bias—it''s easier to do nothing and let the next episode play than to actively decide to stop. However, this can lead to "regretful engagement" where users watch more than they intended, feel guilty about binge-watching, and develop a negative association with the platform. Over time, this guilt-driven negative sentiment can increase churn, particularly among users who value their time. The product intuition is that maximizing session engagement can actually decrease long-term retention if users feel the platform is working against their own interests. This tension between dark-pattern engagement and genuine user value is one of the most important judgments a PM must make. Option A overstates the immediate churn risk. Option C misidentifies the primary concern. Option D is a minor consideration.',
        ARRAY['design_tradeoff', 'user_psychology', 'product_critique', 'unintended_consequences']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Auto-play will cause users to run out of content faster, leading to subscription cancellations when they feel they''ve "finished" Netflix', false),
    (v_question_id, 'B', 'It creates a tension between short-term engagement metrics and long-term retention by exploiting status quo bias, which can lead to "regretful engagement" that builds negative platform sentiment over time', true),
    (v_question_id, 'C', 'Auto-play undermines content quality perception because users watch lower-quality episodes they would have otherwise skipped', false),
    (v_question_id, 'D', 'It creates bandwidth and infrastructure costs by streaming content users aren''t actively choosing to watch', false);

    -- ============================================
    -- QUESTION 28 (Intermediate) — Instagram
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 28,
        'Instagram Reels vs. Stories Cannibalization',
        'Instagram launched Reels (short-form video competing with TikTok) while already having Stories, IGTV, and Feed posts. As a PM, what is the most significant product intuition about the internal cannibalization dynamics?',
        'intermediate',
        'Instagram',
        'Photo/video sharing platform with multiple content formats',
        'A',
        'Reels cannibalize Stories disproportionately because they compete for the same "quick, casual content" creation energy. A user who might have shared a fun moment as a Story now considers whether it would perform better as a Reel. This decision fatigue—"which format should I use?"—adds friction to what used to be a simple sharing impulse. More importantly, Reels'' algorithmic distribution (reaching non-followers) makes them more attractive than Stories (visible only to followers), which could gradually hollow out Stories engagement. The irony is that Stories was Instagram''s most successful feature for reducing posting anxiety, and Reels reintroduces performance pressure by adding public view counts and algorithmic ranking. Option B overestimates the IGTV impact. Option C focuses on the wrong dimension. Option D misidentifies the consumption dynamic.',
        ARRAY['feature_cannibalization', 'product_critique', 'design_tradeoff', 'user_behavior_prediction']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Reels cannibalize Stories disproportionately by competing for the same "casual sharing" impulse, while reintroducing the performance pressure that Stories originally eliminated through ephemeral, follower-only distribution', true),
    (v_question_id, 'B', 'Reels will primarily cannibalize IGTV since both are video-first formats, leaving Stories and Feed relatively unaffected', false),
    (v_question_id, 'C', 'The main cannibalization risk is viewer attention: time spent watching Reels directly reduces time spent scrolling the Feed, lowering ad impression per session', false),
    (v_question_id, 'D', 'Reels will complement Stories rather than cannibalize them because they serve different content types (polished vs. raw)', false);

    -- ============================================
    -- QUESTION 29 (Advanced) — Twitter/X
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 29,
        'Twitter/X Paid Verification Third-Order Effects',
        'Twitter/X replaces identity-based verification (blue check = notable person) with paid verification (blue check = $8/month subscriber). As a PM, predict the most damaging third-order effect on the platform ecosystem.',
        'advanced',
        'Twitter/X',
        'Public conversation platform, blue check mark historically signaled notability',
        'C',
        'The third-order effect is the collapse of Twitter''s unique value as a real-time information network during crises. Twitter''s "information utility" value during breaking news, natural disasters, and emergencies depended on users quickly identifying authoritative sources. Verification was the trust layer that made this possible. When anyone can buy a blue check, the trust signal becomes noise: during a crisis, fake accounts with blue checks can spread misinformation that''s indistinguishable from official sources. This erodes Twitter''s most defensible use case—the one no competitor could replicate. First-order effect: verification becomes meaningless. Second-order effect: misinformation from fake "verified" accounts increases. Third-order effect: Twitter loses its unique position as a trusted real-time information utility, and institutions (journalists, emergency services, government agencies) migrate official communications to other platforms. Option A is a first-order effect. Option B is a second-order effect. Option D mischaracterizes the economic dynamics.',
        ARRAY['second_order_effects', 'unintended_consequences', 'product_judgment', 'product_critique']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Celebrity and journalist engagement will decrease as their verified status is diluted among paid subscribers', false),
    (v_question_id, 'B', 'Impersonation attacks will increase as malicious actors buy blue checks to pose as trusted institutions', false),
    (v_question_id, 'C', 'Twitter''s unique value as a real-time information utility during crises collapses because the trust layer (verification = authority) is destroyed, causing institutions to migrate official communications elsewhere', true),
    (v_question_id, 'D', 'The two-tier user system (paid vs. free) will create class resentment that fragments the conversation and reduces the open discourse that makes Twitter valuable', false);

    -- ============================================
    -- QUESTION 30 (Advanced) — Spotify
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 30,
        'Spotify''s Algorithmic Recommendations and Artist Economics',
        'Spotify''s Discover Weekly and algorithmic playlists now drive 30%+ of all streams. As a PM, identify the most subtle unintended consequence of algorithmic curation becoming the dominant music discovery mechanism.',
        'advanced',
        'Spotify',
        'Music streaming platform, algorithmic discovery is a core feature',
        'B',
        'The subtlest unintended consequence is the homogenization of music creation itself. When algorithms optimize for engagement metrics (completion rate, skip rate, save rate), they reward certain sonic characteristics: songs with short intros, immediate hooks, predictable structures, and specific tempo/energy ranges. Artists and labels learn what the algorithm favors and begin producing music optimized for algorithmic distribution rather than artistic expression. Over time, this creates a musical monoculture where songs converge on algorithmically-optimal templates. This is a third-order feedback loop: algorithm shapes discovery → discovery shapes what gets popular → popularity shapes what gets created → what gets created reinforces the algorithm''s preferences. The platform that was supposed to democratize music discovery may actually be narrowing it. Option A describes a real but more obvious effect. Option C is a valid concern but less subtle. Option D overestimates the speed of this effect.',
        ARRAY['unintended_consequences', 'second_order_effects', 'product_critique', 'product_judgment']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Established artists with large catalogs dominate recommendations because the algorithm has more data to work with, disadvantaging emerging artists', false),
    (v_question_id, 'B', 'Music creation itself homogenizes as artists optimize for algorithmic engagement metrics (short intros, immediate hooks, specific tempos), creating a feedback loop that narrows musical diversity over time', true),
    (v_question_id, 'C', 'Users develop "algorithm dependency" and lose the ability to discover music independently, making them vulnerable to churn if recommendation quality degrades', false),
    (v_question_id, 'D', 'Record labels gain disproportionate power by reverse-engineering the algorithm, crowding out independent artists in recommendations', false);

    -- ============================================
    -- QUESTION 31 (Advanced) — WhatsApp
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 31,
        'WhatsApp''s Platform vs. Feature Dilemma',
        'WhatsApp has 2B+ users but monetizes minimally compared to Instagram or Facebook. Meta considers turning WhatsApp into a super-app (payments, shopping, business services) like WeChat. As a PM with deep product intuition, what is the most critical risk of this platform expansion strategy?',
        'advanced',
        'WhatsApp',
        'Messaging platform with minimal monetization, part of Meta ecosystem',
        'D',
        'The most critical risk is destroying WhatsApp''s core value proposition of radical simplicity. WhatsApp achieved 2B users precisely because it does one thing exceptionally well: reliable messaging with minimal cognitive overhead. Its lack of features is its feature—parents, grandparents, and tech-unsavvy users worldwide adopted it because it''s as simple as texting. Super-app expansion introduces feature bloat that would alienate the vast majority of users who chose WhatsApp for its simplicity. WeChat succeeded as a super-app because it grew into those features in a market (China) with different competitive dynamics and user expectations. Grafting a super-app onto WhatsApp''s existing user base—which was acquired under a simplicity contract—is fundamentally different from building a super-app from scratch. The product intuition is that some products are powerful precisely because of what they don''t do. Option A overstates regulatory risk relative to product risk. Option B misidentifies the competitive dynamic. Option C is valid but secondary.',
        ARRAY['design_tradeoff', 'product_judgment', 'product_taste', 'value_proposition']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Regulatory scrutiny in India and Brazil (WhatsApp''s largest markets) will block payments and commerce features from scaling', false),
    (v_question_id, 'B', 'WeChat-style super-apps only work in markets without strong incumbent apps for payments, shopping, and services—Western markets already have those alternatives', false),
    (v_question_id, 'C', 'WhatsApp''s end-to-end encryption makes it technically difficult to build commerce features that require transaction visibility', false),
    (v_question_id, 'D', 'WhatsApp achieved 2B users through radical simplicity—its lack of features is its feature—and super-app expansion risks destroying the implicit simplicity contract with users who chose it precisely because it does one thing well', true);

    -- ============================================
    -- QUESTION 32 (Advanced) — Netflix
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 32,
        'Netflix''s Password Sharing Crackdown Prediction',
        'Netflix announces a crackdown on password sharing, requiring users to pay extra for out-of-household access. As a PM, which prediction about user behavior demonstrates the strongest product intuition?',
        'advanced',
        'Netflix',
        'Streaming service with estimated 100M+ password-sharing households globally',
        'C',
        'The strongest product intuition recognizes that password-sharing households are not a monolithic segment. The crackdown will create a trimodal response: (1) Some sharers will convert to paid subscriptions—these are users who value Netflix enough to pay but had been free-riding on the easiest path. (2) Some will churn entirely—these are marginal users who wouldn''t pay at any price point. (3) The largest and most interesting segment will convert but downgrade to cheaper tiers, revealing their true willingness-to-pay. The net revenue impact depends heavily on the ratio between these segments, and the transition period will see temporary churn spikes that stabilize as users realize Netflix is still worth paying for. The key insight is that password sharers are not "stolen revenue"—they''re a price-sensitivity signal, and the right move is to offer them a price they''re willing to pay rather than demanding the full price. Option A overestimates churn. Option B is too optimistic. Option D misidentifies the competitive dynamic.',
        ARRAY['user_behavior_prediction', 'behavioral_economics', 'product_judgment', 'product_market_fit']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Most password sharers will churn because they never valued Netflix enough to pay, and the sharing was what kept them in the ecosystem', false),
    (v_question_id, 'B', 'Nearly all password sharers will convert to paid subscribers because Netflix''s content library is irreplaceable and they have no viable alternatives', false),
    (v_question_id, 'C', 'A trimodal response will emerge: some convert at full price, many convert to cheaper tiers (revealing true willingness-to-pay), and a minority churns—password sharing was a price-sensitivity signal, not theft', true),
    (v_question_id, 'D', 'Password sharers will migrate to competitor platforms like Disney+ and HBO Max, accelerating the streaming fragmentation trend', false);

    -- ============================================
    -- QUESTION 33 (Advanced) — Instagram
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 33,
        'Instagram''s Algorithmic Feed vs. Chronological Feed',
        'Instagram switched from a chronological feed to an algorithmic feed in 2016, despite massive user protest. As a PM, which advanced product intuition explains why Instagram was correct to make this change despite user backlash, and why users'' stated preferences were misleading?',
        'advanced',
        'Instagram',
        'Photo-sharing platform, switched from chronological to algorithmic feed',
        'B',
        'This is a classic case of revealed preference vs. stated preference divergence. Users vocally demanded chronological feeds because they value the feeling of control and completeness. However, behavioral data showed that users were missing 70% of posts from their close friends in chronological feeds because they didn''t scroll far enough. The algorithmic feed ensured users saw content from people they cared about most, increasing the emotional value per session even though users felt they had less control. The product intuition is that users optimize for perceived control (chronological = "I choose what to see") while platforms should optimize for delivered value (algorithmic = "you see what matters most"). Users will always say they want chronological, but they''ll always engage more with algorithmic—because what people want to want and what they actually want are different things. Option A is true but doesn''t explain the preference divergence. Option C overstates the creator impact. Option D is a secondary consideration.',
        ARRAY['user_psychology', 'product_judgment', 'product_taste', 'behavioral_economics']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Algorithmic feeds allow Instagram to insert more ads at optimal positions, which funds content creator programs that improve the ecosystem', false),
    (v_question_id, 'B', 'Users'' stated preference for chronological feeds reflects a desire for control, but their revealed behavior shows higher engagement with algorithmic feeds that surface missed content from close connections—what people want to want differs from what they actually want', true),
    (v_question_id, 'C', 'Algorithmic feeds reward high-quality content over recency, which incentivizes creators to invest more effort in each post, raising overall content quality', false),
    (v_question_id, 'D', 'As follower counts grew, chronological feeds became technically unsustainable and would have required infinite scroll to deliver complete coverage', false);

    -- ============================================
    -- QUESTION 34 (Advanced) — Uber
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 34,
        'Uber''s Upfront Pricing and Information Asymmetry',
        'Uber transitions from metered pricing (price determined by actual route taken) to upfront pricing (price quoted before the ride, based on predicted route). As a PM, what is the most sophisticated product intuition about how this changes the competitive dynamics?',
        'advanced',
        'Uber',
        'Ride-hailing platform, transitioning pricing models',
        'D',
        'Upfront pricing gives Uber a powerful information asymmetry advantage. When the price is determined by actual route, Uber and Lyft offer functionally identical products—same route, same distance, same price. But with upfront pricing, Uber can use its superior data (more rides, more routes, better ML models) to price more aggressively on competitive routes while maintaining higher margins on routes where users are less price-sensitive. This is algorithmic price discrimination that''s invisible to consumers and impossible for Lyft to replicate without equivalent data scale. Uber can subsidize competitive pricing on airport routes (where users compare) by charging more on suburban routes (where users don''t compare), using their data advantage to optimize margin allocation. The pricing model shift wasn''t about user experience—it was about creating a data-driven pricing moat. Option A is the surface-level narrative. Option B identifies a real risk but not the competitive insight. Option C misidentifies the driver-side impact.',
        ARRAY['product_judgment', 'second_order_effects', 'behavioral_economics', 'product_taste']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Upfront pricing reduces user anxiety about unexpected costs, improving the rider experience and increasing conversion rates', false),
    (v_question_id, 'B', 'Upfront pricing creates a risk of losses when actual routes are longer than predicted, requiring Uber to build sophisticated hedging models', false),
    (v_question_id, 'C', 'Drivers benefit from predictable earnings, which improves driver satisfaction and reduces supply-side churn', false),
    (v_question_id, 'D', 'Upfront pricing creates an information asymmetry moat—Uber can use superior route data to price competitively on comparison-heavy routes while maintaining margins on routes where users don''t price-compare, a data advantage competitors can''t replicate without equivalent scale', true);

    -- ============================================
    -- QUESTION 35 (Advanced) — Apple
    -- ============================================
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (
        v_sub_skill_id, 35,
        'Apple''s App Tracking Transparency Impact',
        'Apple''s App Tracking Transparency (ATT) framework requires apps to get explicit user permission before tracking across apps. As a PM with deep product intuition, what is the most sophisticated prediction about ATT''s long-term impact on the app ecosystem?',
        'advanced',
        'Apple',
        'iOS ecosystem, privacy-focused platform changes affecting the app economy',
        'C',
        'ATT''s most sophisticated long-term impact is that it will fundamentally restructure the app business model landscape, accelerating the shift from ad-supported to subscription-based apps. When 80%+ of users opt out of tracking, the precision of targeted advertising degrades significantly, making ad-supported free apps less profitable. This creates a business model pressure that pushes developers toward subscriptions, in-app purchases, and premium pricing. Apple benefits enormously from this shift because Apple takes a 15-30% commission on all App Store transactions but takes zero commission on ad revenue. ATT isn''t just a privacy feature—it''s a platform economic strategy that redirects app revenue through Apple''s commission tollbooth. The product intuition is recognizing that privacy features can be both genuinely user-beneficial AND strategically self-serving, and that the most powerful platform moves are those that align ethical positioning with economic interest. Option A is a first-order observation. Option B is partially true but misses the economic restructuring. Option D overestimates the short-term impact.',
        ARRAY['second_order_effects', 'product_judgment', 'unintended_consequences', 'product_taste']
    ) RETURNING id INTO v_question_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_question_id, 'A', 'Facebook and other ad-dependent platforms will lose significant revenue, reducing their ability to invest in competitive features', false),
    (v_question_id, 'B', 'Users will become more privacy-conscious across all platforms, creating a broader market demand for privacy-first products', false),
    (v_question_id, 'C', 'ATT restructures app economics by degrading ad-supported business models and pushing developers toward subscriptions/IAP—which flow through Apple''s 15-30% commission—making privacy both genuinely user-beneficial and strategically self-serving', true),
    (v_question_id, 'D', 'App quality will decrease as ad-funded free apps lose revenue and either shut down or reduce investment in product development', false);

END $$;
