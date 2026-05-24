-- ============================================
-- ASSESSMENT: Influencing Without Authority
-- CATEGORY: Leadership
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
    WHERE slug = 'influencing-without-authority';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug influencing-without-authority not found. Run the seed data first.';
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
        'Spotify''s Data-Driven Influence',
        E'A Spotify PM wants to redesign the ''Create Playlist'' flow, but the engineering lead thinks it''s a waste of time. The PM has no authority over the engineers. What is the most effective first step to influence the engineering lead?',
        'foundational',
        'Spotify',
        'Audio streaming platform',
        'B',
        'In product management, data is the great equalizer. Pulling user drop-off data moves the conversation from opinions to objective reality, providing a compelling, evidence-based reason for the change. Escalation burns bridges and should only be a last resort. Brainstorming is premature if they don''t even agree there is a problem. Promises of recognition are transactional and don''t address the core disagreement about the value of the work.',
        ARRAY['data_driven', 'engineering_alignment', 'evidence_based']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Escalate to the Director of Engineering to mandate the work.', false),
    (v_q_id, 'B', 'Pull user drop-off data showing that 40% of users abandon the current flow.', true),
    (v_q_id, 'C', 'Organize a brainstorming session with the team to ideate.', false),
    (v_q_id, 'D', 'Promise the engineering lead a shoutout in the next all-hands.', false);

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
        'Airbnb''s Engineering Alignment',
        E'An Airbnb PM needs the host calendar team to expose an API for a new co-hosting feature. The calendar team is swamped and hesitant. What is the best way to get them to prioritize the API work?',
        'foundational',
        'Airbnb',
        'Home sharing and travel platform',
        'A',
        'The core of influencing without authority is finding mutual benefit. Aligning the request with shared OKRs demonstrates how the work benefits the calendar team''s goals, creating a win-win scenario. Taking on their bugs is unsustainable and doesn''t scale. Name-dropping executives relies on borrowed authority rather than genuine influence and can build resentment. Threatening to build duplicate systems creates technical debt and organizational conflict.',
        ARRAY['engineering_alignment', 'okr_alignment', 'win_win']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Show how the co-hosting feature will increase overall platform bookings, directly contributing to their shared team OKRs.', true),
    (v_q_id, 'B', 'Offer to take on some of their bug tickets in exchange for the API work.', false),
    (v_q_id, 'C', 'Tell them that the VP of Product has personally requested this feature.', false),
    (v_q_id, 'D', 'Threaten to build a duplicate calendar system if they don''t comply.', false);

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
        'Stripe''s Managing Up',
        E'A Stripe PM wants to deprecate a legacy payment API, but the VP of Sales strongly opposes it, fearing it will anger enterprise clients. How should the PM approach the VP to gain support?',
        'foundational',
        'Stripe',
        'Financial infrastructure platform',
        'B',
        'Empathy and addressing specific stakeholder concerns are key to managing up. By presenting a migration plan with white-glove support, the PM directly mitigates the VP''s fear of client anger while achieving the product goal. Quietly proceeding destroys trust. Sending articles is condescending and dismissive of the VP''s valid business concerns. Escalating to the CEO damages the relationship with the VP and shows an inability to resolve conflicts independently.',
        ARRAY['managing_up', 'stakeholder_empathy', 'sales_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Proceed with the deprecation quietly, assuming the VP will eventually accept it.', false),
    (v_q_id, 'B', 'Present a clear migration plan that includes white-glove support for key enterprise clients, mitigating the VP''s specific fears.', true),
    (v_q_id, 'C', 'Send the VP an article about how legacy code slows down engineering velocity.', false),
    (v_q_id, 'D', 'Ask the CEO to override the VP of Sales.', false);

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
        'Slack''s Influencing Design',
        E'A Slack PM believes a new channel organization feature needs a more prominent button, but the Lead Designer argues it clutters the UI. How should the PM resolve this?',
        'foundational',
        'Slack',
        'Workplace communication platform',
        'A',
        'When PMs and designers clash, bringing the user''s voice into the room is the most effective way to break the tie. A usability test provides objective feedback on the trade-off between discoverability and clutter. Asserting authority undermines the partnership and often backfires. Compromising with a hidden menu might solve the disagreement but results in a poor user experience. Undermining the Lead Designer is toxic and destroys trust.',
        ARRAY['design_alignment', 'usability_testing', 'user_centricity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conduct a quick usability test with wireframes showing both versions to see which performs better with users.', true),
    (v_q_id, 'B', 'Remind the designer that the PM ultimately owns the product decisions.', false),
    (v_q_id, 'C', 'Compromise by putting the button in a hidden menu.', false),
    (v_q_id, 'D', 'Ask another designer on the team to do the work secretly.', false);

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
        'Uber''s Cross-Functional Kickoff',
        E'An Uber PM is kicking off a complex new airport pickup feature involving Ops, Legal, and Engineering. Everyone seems skeptical about the aggressive timeline. How should the PM build early momentum?',
        'foundational',
        'Uber',
        'Ride-hailing platform',
        'B',
        'Inspiration and clear purpose are fundamental tools for influence. Starting with a compelling user story aligns the cross-functional team on the problem''s importance (the ''why''), making them more willing to tackle the challenging timeline (the ''how''). Demanding commitment or assigning tasks preemptively ignores their skepticism and builds resentment. Using performance reviews as a threat is coercive and creates a fear-based environment, not genuine buy-in.',
        ARRAY['cross_functional', 'storytelling', 'kickoff_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Demand that everyone commit to the timeline immediately to establish authority.', false),
    (v_q_id, 'B', 'Start the kickoff by sharing a compelling user story about the pain of airport pickups, aligning everyone on the ''why''.', true),
    (v_q_id, 'C', 'Assign detailed tasks to each person before they have a chance to object.', false),
    (v_q_id, 'D', 'Warn the team that their performance reviews depend on hitting this deadline.', false);

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
        'Shopify''s Disagreeing Stakeholders',
        E'A Shopify PM needs to update the merchant dashboard. The Marketing lead wants more promotional space, while the Support lead wants more prominent help docs. The PM cannot satisfy both. How should the PM proceed?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'C',
        'When stakeholders have competing demands, the PM must facilitate alignment rather than act as a simple order-taker or dictator. Bringing them together to review data forces a collaborative discussion focused on the user''s needs, rather than departmental silos. Yielding to title or relying solely on intuition ignores the merits of the arguments. A 50/50 split is a weak compromise that usually results in a cluttered, ineffective product.',
        ARRAY['stakeholder_conflict', 'data_driven_alignment', 'facilitation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Give in to whichever stakeholder has a higher title.', false),
    (v_q_id, 'B', 'Ignore both requests and design the dashboard based solely on PM intuition.', false),
    (v_q_id, 'C', 'Bring both leads together to review merchant behavior data and collectively agree on the primary goal of the dashboard.', true),
    (v_q_id, 'D', 'Split the dashboard exactly 50/50 to be fair.', false);

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
        'Netflix''s Customer Feedback',
        E'A Netflix PM wants to introduce a feature allowing users to hide specific genres. The algorithm team believes their personalized recommendations are already sufficient and resists building the feature. How can the PM influence them?',
        'foundational',
        'Netflix',
        'Streaming media platform',
        'A',
        'Qualitative data (like quotes and support tickets) is a powerful tool for building empathy and highlighting gaps in quantitative models. Sharing user feedback shows the algorithm team that despite their model''s sophistication, real users still feel a lack of control, providing a compelling reason to build the feature. Attacking the team''s work triggers defensiveness. Going rogue or threatening budgets are highly destructive behaviors that ruin cross-functional relationships.',
        ARRAY['qualitative_data', 'engineering_alignment', 'user_empathy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Compile quotes and support tickets from users explicitly asking for manual control over their feeds.', true),
    (v_q_id, 'B', 'Tell the algorithm team their model is fundamentally flawed and needs fixing.', false),
    (v_q_id, 'C', 'Build a rogue version of the feature using a third-party vendor.', false),
    (v_q_id, 'D', 'Threaten to reduce the algorithm team''s headcount budget.', false);

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
        'GitHub''s Building a Coalition',
        E'A GitHub PM wants to revamp the pull request UI. The engineering manager is hesitant due to the massive refactoring required. Who should the PM seek out first to build a coalition?',
        'foundational',
        'GitHub',
        'Developer collaboration platform',
        'B',
        'Building a coalition requires identifying key influencers within the target group. A respected senior engineer has the technical credibility to persuade the engineering manager and the intrinsic motivation (frustration with legacy code) to support the PM''s vision. A junior engineer lacks the necessary influence. Approaching the CFO or PR is entirely premature before getting engineering on board.',
        ARRAY['coalition_building', 'influencing_engineering', 'stakeholder_mapping']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The most junior engineer on the team, who is eager for new projects.', false),
    (v_q_id, 'B', 'A highly respected senior engineer on the team who is known to be frustrated with the current legacy code.', true),
    (v_q_id, 'C', 'The CFO, to get budgetary approval.', false),
    (v_q_id, 'D', 'The PR team, to start drafting the launch announcement.', false);

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
        'Notion''s Competing Priorities',
        E'A Notion PM needs the core infrastructure team to upgrade the database schema for a new feature. The infra team says they are completely booked for the quarter with reliability improvements. What is the PM''s best move?',
        'foundational',
        'Notion',
        'Productivity and workspace tool',
        'C',
        'Effective influence often involves finding synergies between seemingly competing priorities. By understanding the infra team''s roadmap, the PM might find that the schema upgrade actually supports or can be efficiently bundled with their reliability goals. Complaining damages relationships. Asking them to ''squeeze it in'' disrespects their planning. Claiming product features are more important than reliability is a dangerous assumption that alienates infrastructure teams.',
        ARRAY['dependency_management', 'win_win_negotiation', 'roadmap_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Complain to the Head of Product that the infra team is blocking product velocity.', false),
    (v_q_id, 'B', 'Ask the infra team to just squeeze it in, promising it won''t take long.', false),
    (v_q_id, 'C', 'Work with the infra team to understand their roadmap and see if the schema upgrade can be bundled with their planned reliability work.', true),
    (v_q_id, 'D', 'Tell the infra team their feature is more important than reliability.', false);

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
        'Figma''s Communicating Tradeoffs',
        E'A Figma PM has to delay a highly anticipated commenting feature by a month to fix critical bugs. How should the PM communicate this to the Sales team, who have been promising it to clients?',
        'foundational',
        'Figma',
        'Collaborative design platform',
        'B',
        'Managing stakeholders through bad news requires transparency, empathy, and clear reasoning. Meeting with Sales leadership allows the PM to reframe the delay as protecting the client relationship (avoiding buggy software), which aligns with Sales'' ultimate goals. Sending a Friday email is cowardly. Blaming engineering destroys team trust. Launching a buggy product sacrifices long-term trust for short-term appeasement.',
        ARRAY['sales_alignment', 'communication_strategy', 'managing_bad_news']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send an automated email late on a Friday announcing the delay.', false),
    (v_q_id, 'B', 'Meet with Sales leadership, explain the risk of shipping a buggy feature to enterprise clients, and provide a firm new timeline.', true),
    (v_q_id, 'C', 'Blame the engineering team for being too slow.', false),
    (v_q_id, 'D', 'Downplay the bugs and launch the feature anyway to keep Sales happy.', false);

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
        'DoorDash''s Ops Influence',
        E'A DoorDash PM wants to test a new batching algorithm that might slightly delay some deliveries but increase overall driver efficiency. City Operations managers are furious, worrying it will cause customer complaints. How should the PM handle the Ops managers?',
        'intermediate',
        'DoorDash',
        'Food delivery platform',
        'B',
        'When stakeholders are risk-averse, the best way to influence them is by de-risking the proposal. A localized pilot with clear abort metrics acknowledges the Ops managers'' concerns, gives them a sense of control, and provides a safe environment to gather data. Forcing a global test is reckless. Condescending to stakeholders guarantees resistance. Escalating to the CEO bypasses necessary localized alignment and forces compliance without true buy-in.',
        ARRAY['risk_mitigation', 'pilot_programs', 'operations_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run the test globally anyway, as the overall efficiency metrics are what matters.', false),
    (v_q_id, 'B', 'Propose a localized pilot in a single mid-sized city, with clear abort metrics if customer complaints exceed a agreed-upon threshold.', true),
    (v_q_id, 'C', 'Tell the Ops managers they don''t understand the complex math behind the algorithm.', false),
    (v_q_id, 'D', 'Ask the CEO to send a company-wide memo mandating the test.', false);

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
        'Atlassian''s Legacy Resistance',
        E'An Atlassian PM wants to transition Jira users to a new, simpler interface. The enterprise customer success (CS) team strongly resists, arguing that power users hate change and will churn. How can the PM effectively influence the CS team?',
        'intermediate',
        'Atlassian',
        'Enterprise software tools',
        'B',
        'When stakeholders fear the impact of a change on their daily work or relationships, the most powerful influence strategy is co-creation. Inviting CS reps to co-design the transition plan turns them from opponents into partners, leveraging their deep customer knowledge to build a better rollout strategy. Pointing to competitors doesn''t address their specific fear of churn. Financial incentives don''t solve the underlying UX concerns. Pushing the update blindly risks alienating key clients and validating the CS team''s fears.',
        ARRAY['change_management', 'co_creation', 'customer_success_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Point out that competitors are modernizing their UIs and Atlassian must keep up.', false),
    (v_q_id, 'B', 'Invite key CS reps to co-design the transition plan, giving them the power to shape the rollout phases and training materials.', true),
    (v_q_id, 'C', 'Promise the CS team a bonus for every customer they successfully migrate.', false),
    (v_q_id, 'D', 'Ignore the CS team and push the update to 10% of users to prove them wrong.', false);

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
        'Peloton''s Unfavorable Data',
        E'A Peloton PM runs an A/B test for a new social feature. The results show no increase in engagement, but the VP of Product loves the feature and is pushing to launch it. How should the PM approach the VP?',
        'intermediate',
        'Peloton',
        'Connected fitness platform',
        'B',
        'Influencing leadership with negative data requires tact and a forward-looking mindset. Presenting the objective data alongside a constructive path forward demonstrates intellectual honesty while showing that the PM is still committed to solving the underlying user problem the VP cares about. Refusing to launch is insubordinate. Massaging data destroys the PM''s credibility and the company''s data culture. ''Quiet quitting'' on the feature creates technical debt and avoids the necessary difficult conversation.',
        ARRAY['managing_up', 'data_integrity', 'handling_failed_tests']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Refuse to launch the feature and lock the code repository.', false),
    (v_q_id, 'B', 'Present the data objectively, highlighting the lack of engagement, but suggest a targeted pivot or iteration based on user feedback gathered during the test.', true),
    (v_q_id, 'C', 'Massage the data to highlight a minor, statistically insignificant positive metric to appease the VP.', false),
    (v_q_id, 'D', 'Launch the feature but quietly stop supporting it in future sprints.', false);

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
        'Zoom''s Resource Negotiation',
        E'A Zoom PM for the ''Webinar'' product needs a specialized video-encoding engineer who currently reports to the ''Meetings'' product team. The Meetings PM is reluctant to share the engineer. How can the Webinar PM negotiate effectively?',
        'intermediate',
        'Zoom',
        'Video conferencing platform',
        'A',
        'Resource negotiation between peers requires finding mutually beneficial trades (horse-trading). Offering a front-end developer acknowledges the Meetings PM''s need to maintain velocity and provides tangible value in exchange for the specialized resource. Escalating damages peer relationships. Poaching the engineer directly is highly unprofessional and creates political turmoil. Threatening to block integrations actively harms the company and users out of spite.',
        ARRAY['resource_allocation', 'peer_negotiation', 'horse_trading']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Offer to trade one of the Webinar team''s front-end developers for a month in exchange for the encoding engineer.', true),
    (v_q_id, 'B', 'Escalate to the Director of Engineering to force the reassignment.', false),
    (v_q_id, 'C', 'Secretly message the engineer and try to convince them to request a transfer.', false),
    (v_q_id, 'D', 'Threaten to block the Meetings team''s upcoming integration with the Webinar platform.', false);

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
        'Duolingo''s Marketing Push',
        E'A Duolingo PM wants to launch a new gamified streak feature. Marketing wants to delay the launch by a month to align with a massive back-to-school ad campaign. The PM worries the delay will hurt Q3 engagement metrics. What is the most balanced approach?',
        'intermediate',
        'Duolingo',
        'Language learning platform',
        'B',
        'Finding a compromise that satisfies both parties'' core objectives is key to cross-functional influence. A soft launch allows the PM to start gathering vital engagement data (satisfying product needs) while preserving the surprise and scale of the full rollout for the back-to-school campaign (satisfying marketing needs). Launching secretly ruins trust. Dismissing marketing''s importance shows a lack of business acumen. Canceling the feature is an extreme overreaction to a scheduling conflict.',
        ARRAY['marketing_alignment', 'launch_strategy', 'finding_compromise']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Launch the feature immediately without telling Marketing.', false),
    (v_q_id, 'B', 'Agree to delay the full launch, but propose a "soft launch" to a small percentage of users now to gather engagement data and iron out bugs before the massive campaign.', true),
    (v_q_id, 'C', 'Tell Marketing that product metrics are more important than marketing campaigns.', false),
    (v_q_id, 'D', 'Cancel the feature entirely since the timelines don''t align.', false);

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
        'Instagram''s Politically Charged Feature',
        E'An Instagram PM is proposing a feature to hide ''Likes'' to improve user mental health. The Monetization team vehemently opposes it, citing potential drops in ad engagement. How should the PM build a case?',
        'intermediate',
        'Instagram',
        'Social media platform',
        'B',
        'To influence stakeholders with opposing incentives, you must frame your argument in terms they care about. The Monetization team cares about revenue, so framing the mental health feature as a driver of long-term retention and LTV translates an ethical argument into a compelling business case. Focusing purely on ethics often fails to persuade revenue-driven teams. Bypassing them creates powerful enemies. Compromising arbitrarily might not solve the core user problem or the business concern.',
        ARRAY['monetization_conflict', 'framing_the_narrative', 'ltv_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Focus exclusively on the ethical obligation to protect users, arguing that revenue is secondary.', false),
    (v_q_id, 'B', 'Frame the proposal around long-term retention, arguing that improved mental health will prevent user churn and ultimately sustain higher lifetime value (LTV).', true),
    (v_q_id, 'C', 'Ignore the Monetization team and pitch directly to the CEO, hoping for a top-down mandate.', false),
    (v_q_id, 'D', 'Agree to only hide Likes for users under 18.', false);

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
        'Airbnb''s Reframing the Narrative',
        E'An Airbnb PM realizes that a planned ''Experiences'' feature is overly complex and will miss the summer launch window. The executive team is highly invested in this launch. How should the PM reframe the narrative when bringing this bad news?',
        'intermediate',
        'Airbnb',
        'Home sharing and travel platform',
        'B',
        'Managing up during a crisis involves presenting solutions, not just problems. Reframing the delay as an opportunity for a leaner, lower-risk MVP shifts the narrative from ''we failed'' to ''we are making a strategic adjustment to capture value.'' Apologizing profusely is fine but lacks a solution. Blaming others is toxic. Suggesting mandatory weekend work is unsustainable, damages morale, and often leads to lower-quality output.',
        ARRAY['crisis_management', 'managing_up', 'mvp_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Apologize profusely and accept full blame for the poor planning.', false),
    (v_q_id, 'B', 'Reframe the delay as an opportunity to release a stripped-down MVP earlier, ensuring they capture the core summer market while reducing technical risk.', true),
    (v_q_id, 'C', 'Blame the complexity on the design team''s unrealistic mockups.', false),
    (v_q_id, 'D', 'Present the complex feature and suggest everyone work weekends to hit the deadline.', false);

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
        'Stripe''s Passive-Aggressive Stakeholder',
        E'A Stripe PM is dealing with a Compliance Officer who constantly nods along in meetings but later subtly blocks the PM''s initiatives via email. How should the PM address this passive-aggressive resistance?',
        'intermediate',
        'Stripe',
        'Financial infrastructure platform',
        'B',
        'Passive-aggressive behavior usually stems from unvoiced concerns or a feeling of not being heard safely in public forums. Scheduling a direct, private 1:1 confronts the behavior professionally while opening the door to understand the root cause of their resistance. Publicly calling them out will only make them more defensive and hostile. Excluding them ensures they will block the project later. CCing their manager is an escalation that should only be used if direct communication repeatedly fails.',
        ARRAY['conflict_resolution', 'handling_resistance', 'compliance_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Reply-all to the Officer''s emails, aggressively calling out their contradictory behavior.', false),
    (v_q_id, 'B', 'Schedule a 1:1 meeting, point out the discrepancy between the meetings and emails, and directly ask what underlying concerns are not being addressed.', true),
    (v_q_id, 'C', 'Stop inviting the Compliance Officer to meetings.', false),
    (v_q_id, 'D', 'CC the Compliance Officer''s manager on all future emails to force accountability.', false);

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
        'Spotify''s Deadlock',
        E'A Spotify PM is caught between the Engineering Lead, who wants to rewrite the audio playback engine for long-term stability, and the Design Lead, who wants to build new social sharing features immediately. The team is paralyzed. How does the PM break the deadlock?',
        'intermediate',
        'Spotify',
        'Audio streaming platform',
        'B',
        'When faced with competing ''right'' answers (tech debt vs. new features), a PM must use strategic frameworks to break the tie. Mapping initiatives against company OKRs removes emotion and uses agreed-upon company goals to prioritize, while the 20% allocation ensures the losing side still makes incremental progress. Relying on gut feeling or ease of build lacks strategic rigor. Voting turns product strategy into a popularity contest and leaves the minority resentful.',
        ARRAY['breaking_deadlocks', 'okr_alignment', 'cross_functional_conflict']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Make the final decision based on their own gut feeling.', false),
    (v_q_id, 'B', 'Facilitate a session to map both initiatives against the company''s quarterly OKRs to see which drives the most immediate strategic value, while allocating a strict 20% time budget for the other.', true),
    (v_q_id, 'C', 'Tell the team they will work on whichever project is easiest to build.', false),
    (v_q_id, 'D', 'Have Engineering and Design vote, and go with the majority.', false);

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
        'Slack''s Missed SLA',
        E'A Slack PM''s new integration is blocked because the platform API team missed their promised delivery date by two weeks. The API team seems unbothered. How should the PM influence them to deliver?',
        'intermediate',
        'Slack',
        'Workplace communication platform',
        'B',
        'When dependencies fail, aggressive tactics usually backfire. Meeting to understand their blockers and explaining the downstream impact builds empathy. The API team might not realize the severe consequences of their delay; explaining the impact contextualizes the urgency without being combative. Public shaming and threats destroy psychological safety and cross-team collaboration. Silently waiting is an abdication of the PM''s responsibility to deliver their product.',
        ARRAY['dependency_management', 'empathy_building', 'accountability']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Publicly shame the API team in the `#general` Slack channel to create pressure.', false),
    (v_q_id, 'B', 'Meet with the API team manager to understand their blockers, explain the specific downstream impact on the integration launch, and collaboratively reprioritize.', true),
    (v_q_id, 'C', 'Threaten to report them to the VP of Engineering.', false),
    (v_q_id, 'D', 'Silently wait, as PMs have no authority over engineering timelines.', false);

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
        'Uber''s Tech Debt Buy-In',
        E'An Uber PM wants to pause feature development for a month to refactor the driver payout system. It''s not currently broken, but engineers warn it won''t scale next year. How does the PM convince the business-focused General Manager (GM)?',
        'intermediate',
        'Uber',
        'Ride-hailing platform',
        'C',
        'Non-technical stakeholders rarely care about tech debt purely for the sake of code quality; they care about business risk. Framing the refactor as an ''insurance policy'' and quantifying the cost of an outage translates a technical issue into a business risk that the GM understands and can prioritize. Explaining architecture will bore them. Lying about engineering refusal or promising magical velocity increases destroys trust and sets unrealistic expectations.',
        ARRAY['tech_debt', 'business_alignment', 'risk_framing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Explain the intricate details of the microservices architecture that need fixing.', false),
    (v_q_id, 'B', 'Tell the GM that engineering refuses to build new features until this is done.', false),
    (v_q_id, 'C', 'Frame the refactor as an "insurance policy" against catastrophic payout failures during the upcoming busy holiday season, quantifying the potential revenue loss of an outage.', true),
    (v_q_id, 'D', 'Promise the GM that the refactor will magically double engineering velocity afterward.', false);

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
        'Shopify''s Kill Feature',
        E'A Shopify PM wants to deprecate a rarely used inventory sorting tool. A vocal minority of vocal, high-paying merchants love it, and the Sales team is terrified of churn. How should the PM sell this "kill feature" decision?',
        'intermediate',
        'Shopify',
        'E-commerce platform',
        'B',
        'Deprecating features requires balancing broad product health against specific user pain. By showing the maintenance cost vs. usage data, the PM justifies the business decision, and by offering a transition path to a third-party app, they provide a tangible solution for the vocal minority and the anxious Sales team. Immediate deprecation is hostile to users. Dismissing Sales'' concerns is arrogant. Hiding the feature maintains the technical debt while worsening the UX.',
        ARRAY['feature_deprecation', 'sales_alignment', 'data_driven_decisions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Deprecate it immediately and offer the merchants a small discount as an apology.', false),
    (v_q_id, 'B', 'Provide data showing the high maintenance cost of the tool compared to its low usage, and offer a clear transition path to a more robust, third-party app ecosystem solution.', true),
    (v_q_id, 'C', 'Tell the Sales team to stop worrying, as these merchants probably won''t actually churn.', false),
    (v_q_id, 'D', 'Keep the feature but hide it deep in the settings menu so new users don''t see it.', false);

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
        'GitHub''s Swoop and Poop',
        E'A GitHub VP swoops into a final design review and demands a massive change to the layout based on a competitor''s new release. The team is demoralized. How should the PM handle the VP?',
        'intermediate',
        'GitHub',
        'Developer collaboration platform',
        'C',
        'Handling "swoop and poop" (late-stage executive interference) requires tactful deflection. Acknowledging the idea and committing to investigate it makes the VP feel heard, while proposing the current version as V1 protects the team''s momentum and avoids throwing away weeks of validated work. Immediate acceptance demoralizes the team and bypasses validation. Arguing publicly is unprofessional. Ignoring the VP is career suicide.',
        ARRAY['managing_up', 'executive_interference', 'protecting_the_team']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Immediately accept the VP''s changes to show respect for leadership.', false),
    (v_q_id, 'B', 'Argue aggressively with the VP in front of the entire team to protect the designers.', false),
    (v_q_id, 'C', 'Acknowledge the VP''s suggestion, commit to investigating it, but propose launching the current well-tested version as a V1 while scoping the VP''s idea for V2.', true),
    (v_q_id, 'D', 'Ignore the VP''s feedback entirely and launch as planned.', false);

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
        'Notion''s Opposing OKRs',
        E'A Notion PM wants to launch a viral sharing loop to drive acquisition. However, the Security team''s OKR is to reduce unauthorized data sharing, and they threaten to block the launch. How can the PM align these opposing forces?',
        'intermediate',
        'Notion',
        'Productivity and workspace tool',
        'B',
        'True cross-functional leadership involves finding solutions that satisfy seemingly opposed constraints. By designing guardrails and secure defaults, the PM addresses Security''s OKRs while still achieving the acquisition goal, turning a blocker into a collaborative partner. Escalating forces a top-down mandate rather than a systemic solution. Launching quietly is a fireable offense. Dismissing their concerns shows a lack of respect for user safety.',
        ARRAY['security_alignment', 'okr_conflict', 'creative_problem_solving']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Escalate to the CEO since Acquisition is more important than Security this quarter.', false),
    (v_q_id, 'B', 'Work with Security to design "guardrail metrics" and secure defaults into the sharing loop, ensuring it drives acquisition without violating their safety OKRs.', true),
    (v_q_id, 'C', 'Launch the feature quietly over the weekend when Security isn''t watching.', false),
    (v_q_id, 'D', 'Tell Security that virality is inherently a little unsafe and they need to accept the risk.', false);

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
        'Figma''s Research Synthesis',
        E'A Figma PM receives user research showing that casual users find the tool too complex, but power users love the complexity. The team is split on whether to simplify the UI. How should the PM use this research to influence the team''s direction?',
        'intermediate',
        'Figma',
        'Collaborative design platform',
        'C',
        'Raw research rarely provides a single answer; it must be synthesized into a strategy. Using personas and proposing a "progressive disclosure" strategy provides a nuanced framework that acknowledges the validity of both user groups'' needs, moving the team past a binary "simple vs. complex" debate. Siding purely with one group ignores half the data and alienates part of the team. Throwing out the research is a waste of valuable insights.',
        ARRAY['research_synthesis', 'ux_strategy', 'team_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Side with the power users, since they pay for the enterprise licenses.', false),
    (v_q_id, 'B', 'Side with the casual users, since there are more of them and they represent future growth.', false),
    (v_q_id, 'C', 'Facilitate a workshop to synthesize the research into personas, using them to propose a "progressive disclosure" UI strategy that serves both groups.', true),
    (v_q_id, 'D', 'Throw out the research since it doesn''t provide a clear, unified answer.', false);

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
        'Netflix''s International Demands',
        E'The Netflix Japan regional manager strongly insists on a unique, culturally specific browsing interface. The core product team in California wants to maintain a unified global UI to save engineering costs. How should the PM navigate this?',
        'intermediate',
        'Netflix',
        'Streaming media platform',
        'C',
        'When local demands clash with global efficiency, a PM must force a rigorous ROI conversation. Asking the regional manager to quantify the impact changes the conversation from "cultural necessity" to a business case. If the projected growth outweighs the engineering cost, it might be worth it; if not, the data itself shuts down the request objectively. Enforcing a global UI bluntly may miss local nuances. Building custom UIs blindly creates unsustainable technical debt. Hiding costs is unethical.',
        ARRAY['global_vs_local', 'roi_analysis', 'stakeholder_negotiation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Enforce the global UI, telling the Japan manager that local customization doesn''t scale.', false),
    (v_q_id, 'B', 'Build the completely custom UI for Japan to ensure market penetration in a key growth area.', false),
    (v_q_id, 'C', 'Ask the Japan manager to quantify the expected subscriber growth from a custom UI, and compare that against the engineering cost of maintaining a fork.', true),
    (v_q_id, 'D', 'Tell the engineering team to build it but hide the cost in another budget.', false);

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
        'DoorDash''s Legal Alignment',
        E'A DoorDash PM is designing a new tipping feature that allows customers to tip kitchen staff directly. They anticipate Legal will be concerned about labor laws. When should the PM involve Legal?',
        'intermediate',
        'DoorDash',
        'Food delivery platform',
        'B',
        'Stakeholders like Legal and Compliance are often viewed as "blockers" only when they are brought in too late. Involving Legal during ideation allows the PM to understand the constraints early, turning Legal into a design partner rather than a late-stage auditor who forces costly rewrites. Waiting until it''s built or about to be tested virtually guarantees a delayed launch and wasted engineering effort. Ignoring them puts the company at massive legal risk.',
        ARRAY['legal_compliance', 'early_alignment', 'risk_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Only after the feature is fully built and ready to launch, to avoid early roadblocks.', false),
    (v_q_id, 'B', 'At the very beginning during the ideation phase, to understand the legal boundaries and design within them from day one.', true),
    (v_q_id, 'C', 'Right before A/B testing begins.', false),
    (v_q_id, 'D', 'Never, unless Legal explicitly asks about it.', false);

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
        'Atlassian''s Rebuilding Trust',
        E'An Atlassian PM recently pushed a buggy release that caused significant downtime for Jira users. The engineering team is angry, and stakeholders are highly skeptical of the PM''s next project. What is the first step to rebuild trust?',
        'intermediate',
        'Atlassian',
        'Enterprise software tools',
        'C',
        'Rebuilding trust requires vulnerability, accountability, and a focus on systemic improvement. Hosting a blameless post-mortem and owning the process failures demonstrates maturity and a commitment to not repeating the same mistakes, which is the foundation of regaining credibility. Moving on quickly makes the PM look oblivious or evasive. Blaming QA is unprofessional and toxic. Resigning immediately is an abdication of leadership.',
        ARRAY['rebuilding_trust', 'accountability', 'post_mortem']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Move on quickly and pitch an exciting new vision to distract everyone from the failure.', false),
    (v_q_id, 'B', 'Blame the QA team for missing the bugs during testing.', false),
    (v_q_id, 'C', 'Host a blameless post-mortem, own the process failures that led to the buggy release, and present a concrete plan to improve release quality going forward.', true),
    (v_q_id, 'D', 'Resign from the project and ask to be transferred to a new team.', false);

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
        'Airbnb''s Multi-Stakeholder Alliance',
        E'An Airbnb PM wants to launch "Flexible Dates," a massive architectural shift requiring alignment from Search (needs new algorithms), Pricing (needs dynamic models), and Host Tools (needs new calendar views). Each team has its own roadmap. What is the most effective meta-strategy for influence?',
        'advanced',
        'Airbnb',
        'Home sharing and travel platform',
        'B',
        'In complex, multi-layered initiatives, a "big bang" approach rarely works. Mapping the landscape and securing a "linchpin" leader privately builds a powerful coalition before the public debate even begins. Once the Head of Search is on board, Pricing and Host Tools are much more likely to follow. A massive simultaneous pitch invites chaos and compounding objections. A top-down mandate secures compliance but destroys true collaboration. Assigning tickets completely ignores the necessary strategic alignment phase.',
        ARRAY['coalition_building', 'stakeholder_mapping', 'complex_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Call a massive all-hands meeting with all three teams to pitch the vision simultaneously.', false),
    (v_q_id, 'B', 'Map the stakeholder landscape, identify the most influential "linchpin" leader (e.g., the Head of Search), secure their buy-in privately first, and use their support to cascade influence to the others.', true),
    (v_q_id, 'C', 'Go directly to the CEO, secure a mandate, and then distribute orders to the three teams.', false),
    (v_q_id, 'D', 'Create a slack channel with all engineers from all teams and start assigning tickets.', false);

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
        'Stripe''s Strategic Influence',
        E'A Stripe PM believes the company needs to pivot from focusing purely on developers to building no-code tools for merchants, representing a major strategic shift. How should the PM begin influencing the executive team toward this shift?',
        'advanced',
        'Stripe',
        'Financial infrastructure platform',
        'C',
        'Influencing major strategic shifts requires a combination of low-risk validation and executive framing. A skunkworks project with early data de-risks the idea, and framing it around TAM expansion speaks directly to executive concerns (growth). A 50-page manifesto will likely go unread. Building a full product unauthorized is a massive waste of resources if it fails to align with ultimate business goals. Open criticism is combative and undermines the PM''s credibility.',
        ARRAY['strategic_influence', 'managing_up', 'market_expansion']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Write a 50-page manifesto and email it to the entire executive team.', false),
    (v_q_id, 'B', 'Build a fully functional, unauthorized no-code product in their spare time to prove it works.', false),
    (v_q_id, 'C', 'Start a "skunkworks" project, gather early validation data from a small cohort of merchants, and present an executive memo framing the opportunity as an expansion of the total addressable market (TAM).', true),
    (v_q_id, 'D', 'Openly criticize the current developer-focused strategy in company all-hands meetings.', false);

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
        'Uber''s External Influence Prep',
        E'An Uber PM is building a feature for driver background checks that will be scrutinized by city regulators. The PM needs the internal Public Policy team to advocate for the feature to the regulators. How should the PM equip the Policy team?',
        'advanced',
        'Uber',
        'Ride-hailing platform',
        'C',
        'Influencing external stakeholders (via internal proxies) requires understanding the external party''s incentives. Regulators care about public safety, not Uber''s technical architecture or revenue. Co-creating a narrative focused on shared safety goals and backing it with solid simulations gives the Policy team the exact ammunition they need. API docs are irrelevant to regulators. Revenue data will actively make regulators hostile. Leaning only on economic contribution is a blunt political threat, not a product argument.',
        ARRAY['external_stakeholders', 'public_policy', 'narrative_framing']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Give them the technical API documentation so they can explain exactly how it works.', false),
    (v_q_id, 'B', 'Provide them with internal data showing how the feature will increase Uber''s revenue.', false),
    (v_q_id, 'C', 'Co-create a narrative focused on shared goals with the regulators (e.g., public safety metrics), backed by statistically sound simulations of the feature''s impact.', true),
    (v_q_id, 'D', 'Tell the Policy team to remind regulators of Uber''s economic contribution to the city.', false);

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
        'Slack''s Acquisition Integration',
        E'Following an acquisition, a Slack PM needs to integrate the acquired company''s calendar tool into Slack. The acquired team''s engineers are deeply protective of their codebase and resistant to adopting Slack''s engineering standards. How should the PM proceed?',
        'advanced',
        'Slack',
        'Workplace communication platform',
        'C',
        'Integrating acquired teams is fraught with cultural friction and identity loss. Forcing immediate compliance or firing people destroys the value of the acquisition by ruining morale. Identifying a "bridge builder" and fostering peer-to-peer influence respects the acquired team''s expertise while slowly introducing the parent company''s culture in a non-threatening, collaborative way. Allowing permanent independence prevents the synergies that justified the acquisition in the first place.',
        ARRAY['acquisition_integration', 'cultural_change', 'peer_influence']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Mandate that they adopt Slack''s standards immediately, as they are now part of the parent company.', false),
    (v_q_id, 'B', 'Fire the most resistant engineers to set an example.', false),
    (v_q_id, 'C', 'Identify a respected "bridge builder" engineer on the acquired team, pair them with a senior Slack engineer on a low-stakes joint project, and let the standards integration happen organically through peer influence.', true),
    (v_q_id, 'D', 'Allow the acquired team to operate completely independently forever.', false);

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
        'Spotify''s Cultural Resistance',
        E'A Spotify PM wants to move their squad from a highly agile, iterative process to a slightly more structured, predictable release cadence to align with hardware partners. The squad views this as a betrayal of Spotify''s autonomous culture. How can the PM influence them?',
        'advanced',
        'Spotify',
        'Audio streaming platform',
        'B',
        'When proposing a change that touches on deeply held company culture, a PM must navigate carefully. Acknowledging the tension and explaining the external business necessity (hardware partners) provides the ''why''. Asking the team to design their own process to meet the new constraints preserves their autonomy (the ''how''), mitigating the feeling of betrayal. Quoting manifestos is pedantic. Threats and HR escalations completely destroy the team''s psychological safety and motivation.',
        ARRAY['cultural_resistance', 'process_change', 'autonomy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Quote the Agile Manifesto to prove that structured releases are still agile.', false),
    (v_q_id, 'B', 'Acknowledge the cultural tension, explain the specific business necessity of the hardware partnerships, and ask the team to design their own lightweight process that meets the predictability requirements.', true),
    (v_q_id, 'C', 'Tell the team they must change or they will be replaced.', false),
    (v_q_id, 'D', 'Escalate to HR about the team''s lack of adaptability.', false);

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
        'Shopify''s Broken Dependencies',
        E'A sudden Shopify reorg means the platform team the PM relies on for a major Q4 launch has been dissolved. The PM now needs help from three different, unfamiliar teams who have their own roadmaps. What is the PM''s immediate crisis-influence strategy?',
        'advanced',
        'Shopify',
        'E-commerce platform',
        'C',
        'In a structural crisis, you lack established relationships and need rapid alignment. Creating a concise brief on the business impact and securing VP sponsorship borrows the necessary authority to get the new teams to the table. Facilitating a re-planning workshop then shifts the dynamic back to collaboration. Panicking shows weak leadership. Handing down a prescriptive plan will be rejected by teams who weren''t consulted. Hiring contractors is usually too slow and risky for core platform work.',
        ARRAY['crisis_management', 'borrowed_authority', 'rapid_alignment']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Panic and tell stakeholders the Q4 launch is impossible.', false),
    (v_q_id, 'B', 'Draft a highly detailed, prescriptive project plan and hand it to the new teams.', false),
    (v_q_id, 'C', 'Create a concise "crisis brief" outlining the critical business impact of the Q4 launch, secure immediate sponsorship from a VP who oversees the new teams, and facilitate a rapid re-planning workshop.', true),
    (v_q_id, 'D', 'Try to hire contractors to do the work instead.', false);

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
        'GitHub''s Subtle Inception',
        E'A GitHub PM strongly believes a specific architectural change is needed, but the VP of Engineering is known to be territorial and rejects ideas not generated by their own team. How can the PM practice "inception" to get the VP to support the change?',
        'advanced',
        'GitHub',
        'Developer collaboration platform',
        'B',
        '"Inception" (making someone think an idea is theirs) is a powerful, advanced influence technique for dealing with highly territorial stakeholders. Using targeted questions to guide the VP to recognize the problem and articulate the solution ensures their total ownership and buy-in, as they are defending "their" idea. Falsely crediting an engineer is unethical and easily exposed. Leaking to a competitor is absurd and fireable. Implementing during a vacation is deeply insubordinate and will be immediately reverted.',
        ARRAY['inception', 'managing_up', 'handling_egos']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Present the solution directly but credit it to one of the VP''s favorite engineers.', false),
    (v_q_id, 'B', 'Ask the VP a series of targeted, leading questions about the current architecture''s scaling limits during a 1:1, guiding the VP to articulate the problem and propose the solution themselves.', true),
    (v_q_id, 'C', 'Leak the idea to a competitor, hoping the VP will copy it.', false),
    (v_q_id, 'D', 'Wait until the VP goes on vacation and implement the change.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for Influencing Without Authority';

END $$;
