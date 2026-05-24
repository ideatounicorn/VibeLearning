-- ============================================
-- ASSESSMENT: User Research
-- CATEGORY: Product Sense
-- TOTAL QUESTIONS: 35
-- DIFFICULTY: ~10 foundational, ~18 intermediate, ~7 advanced
-- ============================================

DO $$
DECLARE
    v_sub_skill_id UUID;
    v_q_id UUID;
BEGIN
    SELECT id INTO v_sub_skill_id FROM sub_skills WHERE slug = 'user-research';
    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug user-research not found. Run seed data first.';
    END IF;

    -- ========== FOUNDATIONAL QUESTIONS (1-10) ==========

    -- QUESTION 1 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 1,
    'Spotify''s Playlist Abandonment Research',
    'Spotify''s PM notices that 40% of users who start creating a playlist abandon it before adding a fifth song. The PM has no prior research on this behavior and wants to understand the root causes before proposing any solutions. The team has two weeks and a modest research budget.',
    'foundational', 'Spotify', 'Music streaming playlist creation flow',
    'B',
    'Semi-structured user interviews are the best starting point when the PM has no prior understanding of a behavior and needs to explore ''why'' users abandon playlists. Sending a survey (Option A) is premature because the PM doesn''t yet know the right questions to ask—surveys are best used to validate or quantify hypotheses, not to discover them. A/B testing new flows (Option C) skips the research phase entirely and risks building the wrong solution. Analyzing only backend logs (Option D) can show ''what'' is happening (e.g., where users drop off) but cannot explain ''why'' users are leaving. In discovery research, qualitative methods like interviews come first to generate hypotheses, which can then be tested quantitatively.',
    ARRAY['user_interview', 'qualitative_research', 'discovery_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send a multiple-choice survey to all users who abandoned a playlist asking them to select a reason from a predefined list', false),
    (v_q_id, 'B', 'Conduct semi-structured interviews with 8-12 users who recently abandoned a playlist to explore their motivations and context', true),
    (v_q_id, 'C', 'A/B test three different playlist creation UIs and measure which one has the lowest abandonment rate', false),
    (v_q_id, 'D', 'Pull backend event logs to analyze the exact step where users drop off and redesign that step immediately', false);

    -- QUESTION 2 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 2,
    'Uber''s Driver Satisfaction Survey Design',
    'Uber''s driver experience PM wants to measure overall driver satisfaction across 15 cities. The team plans to send a survey to 50,000 drivers. A junior researcher drafts a question: "Don''t you agree that Uber''s new pay structure is fair and competitive?" The PM needs to evaluate whether this question is well-designed.',
    'foundational', 'Uber', 'Driver experience and pay satisfaction measurement',
    'C',
    'The drafted question is a textbook example of a leading question—it uses "Don''t you agree" framing and embeds the assumption that the pay structure is "fair and competitive," which biases respondents toward agreement. Option C correctly identifies this as a double-barreled and leading question. Option A is wrong because the question actually introduces significant response bias rather than being comprehensive. Option B is incorrect because the problem isn''t about emotional language—it''s about the leading structure and double-barreled nature (asking about both "fair" and "competitive" simultaneously). Option D misidentifies the issue; the question format could work as a Likert scale, but that doesn''t fix the biased framing. Good survey design requires neutral wording and single-concept questions.',
    ARRAY['survey_design', 'research_bias', 'leading_questions']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The question is well-designed because it is specific about the topic and will generate clear, actionable data', false),
    (v_q_id, 'B', 'The question should be revised to remove emotional language but can keep its current structure', false),
    (v_q_id, 'C', 'The question is both leading and double-barreled—it should be split into two neutral questions about fairness and competitiveness separately', true),
    (v_q_id, 'D', 'The question is fine for a Likert scale format but would be problematic as an open-ended question', false);

    -- QUESTION 3 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 3,
    'Slack''s New User Onboarding Research',
    'Slack''s PM wants to understand why new enterprise customers take an average of 3 weeks to fully onboard their teams, compared to the target of 1 week. The PM is deciding between running a usability study of the onboarding flow versus conducting discovery interviews with IT admins who recently completed onboarding.',
    'foundational', 'Slack', 'Enterprise team onboarding experience',
    'D',
    'Discovery interviews are the right first step because the PM doesn''t yet know whether the problem is a usability issue, a process issue, an organizational issue, or something else entirely. A usability study (Option A) assumes the problem is in the product''s UI, which may not be the case—the delay could stem from internal approval processes, security reviews, or change management challenges that have nothing to do with Slack''s interface. Option B is incorrect because while combining methods is eventually good practice, it doesn''t address which to do first when resources and time are limited. Option C puts the cart before the horse—you need to understand the problem space before measuring task completion rates. Discovery interviews will reveal the actual barriers, after which the PM can decide if a usability study is warranted.',
    ARRAY['user_interview', 'discovery_research', 'usability_study']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run the usability study first because it will produce quantifiable metrics on where users get stuck in the onboarding flow', false),
    (v_q_id, 'B', 'Run both simultaneously to save time and get a holistic picture from the start', false),
    (v_q_id, 'C', 'Run a moderated usability study with task completion rates to identify exactly which steps are causing the 2-week delay', false),
    (v_q_id, 'D', 'Start with discovery interviews because the root cause might not be a usability issue—it could be organizational, procedural, or technical barriers outside the product', true);

    -- QUESTION 4 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 4,
    'Netflix''s Content Discovery Research Method',
    'Netflix''s PM wants to understand how users decide what to watch on a Friday evening. The PM is considering three research methods: (1) an in-app survey asking users what factors influence their choice, (2) a diary study where users log their decision process over 4 weekends, or (3) analyzing clickstream data from the browse-to-play funnel.',
    'foundational', 'Netflix', 'Content discovery and viewing decision process',
    'B',
    'A diary study is the best method here because the decision of what to watch is a contextual, in-the-moment process influenced by mood, social setting, time of day, and prior viewing—factors that users struggle to recall accurately after the fact. An in-app survey (Option A) suffers from recall bias and social desirability bias; users will rationalize their decisions rather than accurately describe the messy, emotional process. Clickstream data (Option C) shows ''what'' users clicked but not ''why''—it can''t capture the deliberation, the shows they considered but rejected, or the social dynamics (e.g., negotiating with a partner). Option D is wrong because while clickstream data is useful, it fundamentally cannot capture the cognitive and emotional decision-making process the PM needs to understand. Diary studies excel at capturing behaviors and decisions in their natural context over time.',
    ARRAY['diary_study', 'qualitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The in-app survey because it can reach the largest number of users and provide statistically significant results quickly', false),
    (v_q_id, 'B', 'The diary study because it captures the in-context decision-making process including emotional state, social setting, and real-time reasoning that users cannot accurately recall later', true),
    (v_q_id, 'C', 'The clickstream analysis because behavioral data is more reliable than self-reported data and reveals the actual decision path', false),
    (v_q_id, 'D', 'Start with clickstream analysis to identify patterns, then validate every finding with a large-scale survey to ensure statistical significance', false);

    -- QUESTION 5 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 5,
    'Airbnb''s Host Interview Sampling',
    'Airbnb''s PM is planning user interviews to understand why new hosts in rural France are listing their properties but not getting any bookings. The PM asks the research team to recruit interview participants. The researcher suggests recruiting 15 hosts—all from the PM''s existing contact list of engaged hosts who regularly attend Airbnb community events.',
    'foundational', 'Airbnb', 'Rural France host listing and booking challenges',
    'A',
    'The researcher''s recruitment approach introduces severe selection bias. Hosts who regularly attend community events are already highly engaged and are likely not representative of the typical new rural host who is struggling with bookings. Option A correctly identifies that the sample should include hosts recruited through the platform itself, representing a range of engagement levels and listing types. Option B is wrong because increasing the sample size doesn''t fix a biased sample—a larger biased sample just gives you more biased data with false confidence. Option C suggests random sampling, which sounds good in theory but doesn''t address the need to specifically recruit hosts who match the target profile (new, rural, few bookings). Option D prioritizes convenience over representativeness, which is the exact problem with the original approach. In user research, who you talk to is just as important as what you ask them.',
    ARRAY['sample_bias', 'recruitment_strategy', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Recruit from the platform''s database of new rural hosts with low booking rates, ensuring a mix of property types, listing durations, and engagement levels', true),
    (v_q_id, 'B', 'Keep the same recruitment source but increase the sample size to 30 hosts to improve statistical reliability', false),
    (v_q_id, 'C', 'Use a completely random sample of all Airbnb hosts globally to eliminate any selection bias', false),
    (v_q_id, 'D', 'Use the PM''s contact list since these hosts are already willing to participate, which will increase response rates and reduce recruitment time', false);

    -- QUESTION 6 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 6,
    'Duolingo''s Streak Motivation Research',
    'Duolingo''s PM hypothesizes that users who lose their streak become demotivated and churn. Before building a "streak recovery" feature, the PM wants to validate this hypothesis. A junior PM suggests asking churned users directly: "Did you stop using Duolingo because you lost your streak?" What is the primary issue with this approach?',
    'foundational', 'Duolingo', 'User retention and streak feature impact',
    'C',
    'Asking users directly why they churned is problematic because of post-hoc rationalization bias. Users are notoriously poor at accurately identifying the real reasons behind their own behavior changes. When asked "Did you stop because of X?", many will agree simply because it sounds like a reasonable explanation, even if the actual cause was something entirely different—like a busy schedule, boredom with content, or switching to a competitor. Option A is wrong because the problem isn''t about reaching churned users (though that''s also challenging); it''s about the question design itself. Option B incorrectly focuses on sample size when the fundamental issue is methodological. Option D suggests the question is fine, which ignores well-established research on self-report reliability. A better approach would be to combine behavioral data analysis (comparing engagement patterns of streak-losers who churned vs. those who didn''t) with open-ended interviews that explore the broader context of why users stopped.',
    ARRAY['research_bias', 'qualitative_research', 'survey_design']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The question is fine but the PM will struggle to reach churned users since they no longer open the app', false),
    (v_q_id, 'B', 'The sample size of churned users will be too small to draw meaningful conclusions', false),
    (v_q_id, 'C', 'The direct question invites post-hoc rationalization—users are poor at accurately self-diagnosing the true cause of their behavior change', true),
    (v_q_id, 'D', 'The approach is valid because users are the best source of information about their own motivations and decisions', false);

    -- QUESTION 7 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 7,
    'Notion''s Qualitative vs Quantitative Decision',
    'Notion''s PM has data showing that 60% of new teams stop using the product within 30 days. Product analytics reveal that these teams create an average of 2.1 pages versus 8.7 pages for retained teams. The PM now needs to decide the next research step to inform the product roadmap.',
    'foundational', 'Notion', 'Team collaboration and retention in productivity tool',
    'B',
    'The quantitative data has already told the PM ''what'' is happening—teams that create fewer pages churn faster. The next logical step is to understand ''why'' these teams aren''t creating more pages. Qualitative interviews with churned teams will uncover whether the problem is a confusing blank-page experience, lack of templates, unclear team value proposition, or something else entirely. Option A is wrong because building more templates is jumping to a solution without understanding the problem. Option C (more analytics) would just produce more ''what'' data when the PM already has a clear signal. Option D proposes a survey, but at this stage the PM doesn''t yet know the right response options to include—open-ended qualitative exploration should precede structured quantitative inquiry. This illustrates the classic qual-quant research sequence: use quant to identify patterns, then qual to explain them.',
    ARRAY['qualitative_research', 'quantitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Build and A/B test a library of pre-made templates to see if it increases page creation among new teams', false),
    (v_q_id, 'B', 'Conduct qualitative interviews with recently churned teams to understand the barriers preventing them from creating more pages', true),
    (v_q_id, 'C', 'Run deeper quantitative analysis segmenting churned teams by company size, industry, and referral source to find the highest-risk segments', false),
    (v_q_id, 'D', 'Send a structured survey with predefined reasons for churn to the 60% of teams that stopped using the product', false);

    -- QUESTION 8 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 8,
    'Figma''s Usability Testing Approach',
    'Figma''s PM is preparing to launch a redesigned component library feature. The team wants to run a usability study with 5 participants before launch. A stakeholder asks: "5 participants? That''s not statistically significant. We need at least 100 users to make any conclusions." How should the PM respond?',
    'foundational', 'Figma', 'Design tool component library usability evaluation',
    'A',
    'Jakob Nielsen''s research has consistently shown that 5 participants uncover approximately 85% of usability issues in a qualitative usability study. The PM should explain that usability testing and statistical surveys serve fundamentally different purposes. Usability studies are qualitative—they identify interaction problems, not measure prevalence. Option A correctly frames this distinction. Option B is wrong because agreeing to 100 users would waste resources and time without meaningfully improving the quality of usability findings (you''d see the same issues repeated). Option C incorrectly suggests 5 is too few—while more participants can help in specialized cases, 5 is well-established as sufficient for identifying major usability problems. Option D conflates usability testing with A/B testing, which serves a different purpose (measuring the impact of changes, not discovering usability issues). The key principle is that qualitative usability research reaches diminishing returns quickly because usability problems tend to be systematic, not random.',
    ARRAY['usability_study', 'qualitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Explain that qualitative usability testing aims to identify interaction problems, not measure prevalence, and 5 users typically uncover 85% of major usability issues', true),
    (v_q_id, 'B', 'Agree with the stakeholder and expand the study to 100 participants to ensure statistically significant results', false),
    (v_q_id, 'C', 'Compromise by increasing to 15 participants, which is the minimum for any research study to be credible', false),
    (v_q_id, 'D', 'Replace the usability study with an A/B test between the old and new design using 1,000+ users for reliable metrics', false);

    -- QUESTION 9 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 9,
    'WhatsApp''s Privacy Perception Research',
    'WhatsApp''s PM is conducting user interviews about privacy perceptions after a recent policy update that caused user backlash. During an interview, a user says: "I don''t really care about privacy." The interviewer should:',
    'foundational', 'WhatsApp', 'Privacy perception and messaging app trust',
    'D',
    'When a user makes a broad claim like "I don''t care about privacy," a skilled interviewer probes deeper with behavioral follow-ups rather than accepting the statement at face value. People''s stated preferences often differ dramatically from their actual behaviors—this is the say-do gap in user research. Option D correctly uses a behavioral follow-up to surface what the user actually does, which is far more revealing than their stated attitude. Option A (accepting at face value) misses a crucial research opportunity and treats self-reported attitudes as ground truth. Option B (challenging the user) would make the participant defensive and contaminate the rest of the interview. Option C (moving to the next question) wastes a valuable moment of potential insight. The best user researchers treat surprising statements as doors to deeper understanding, not as data points to record and move past.',
    ARRAY['user_interview', 'qualitative_research', 'research_bias']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Accept the statement, note it as a data point, and continue with the interview script as planned', false),
    (v_q_id, 'B', 'Challenge the user by explaining why they should care about privacy given the recent policy changes', false),
    (v_q_id, 'C', 'Skip the remaining privacy questions since the user has indicated the topic isn''t relevant to them', false),
    (v_q_id, 'D', 'Probe with a behavioral follow-up: "Can you walk me through what happened the last time an app asked for a permission you weren''t comfortable with?"', true);

    -- QUESTION 10 (Foundational)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 10,
    'TikTok''s Creator Research Presentation',
    'TikTok''s PM has completed 20 interviews with creators who stopped posting after their first month. The PM needs to present findings to the VP of Product. The research revealed 5 major themes, each supported by 3-6 direct quotes. The PM is deciding how to structure the presentation for maximum impact.',
    'foundational', 'TikTok', 'Creator retention and content creation motivation',
    'B',
    'The most effective way to present qualitative research findings to senior leadership is to lead with synthesized themes supported by representative quotes, behavioral patterns, and clear implications for the product roadmap. Option B follows the best practice of structured synthesis: themes first, evidence second, implications third. Option A (reading all quotes) would overwhelm the audience and fail to demonstrate analytical synthesis—a VP doesn''t have time for 20+ raw quotes. Option C (only quantitative summaries) strips away the richness that makes qualitative research valuable and may misrepresent findings by over-quantifying small-sample qualitative data. Option D (sending a written report only) misses the opportunity for real-time discussion and alignment that a presentation enables. Great research communication combines synthesized insights with enough raw evidence to be credible, always connecting findings to actionable product decisions.',
    ARRAY['research_synthesis', 'voice_of_customer', 'stakeholder_communication']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Read through all 20 interview transcripts with the VP, highlighting key quotes to let the raw data speak for itself', false),
    (v_q_id, 'B', 'Present the 5 synthesized themes, each with 1-2 representative quotes and a clear product implication, then facilitate a discussion on prioritization', true),
    (v_q_id, 'C', 'Convert all findings into quantitative summaries (e.g., "75% of creators mentioned algorithm confusion") to make the data feel rigorous', false),
    (v_q_id, 'D', 'Send a detailed written report asynchronously and skip the live presentation since the VP can review the findings at their own pace', false);

    -- ========== INTERMEDIATE QUESTIONS (11-28) ==========

    -- QUESTION 11 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 11,
    'Shopify''s Merchant Jobs-to-be-Done Analysis',
    'Shopify''s PM is using the Jobs-to-be-Done framework to understand why small merchants choose Shopify over competitors. In interviews, a merchant says: "I chose Shopify because it has a good website builder." Using JTBD methodology, the PM should interpret this statement as:',
    'intermediate', 'Shopify', 'Small merchant e-commerce platform selection',
    'C',
    'In Jobs-to-be-Done methodology, a product feature or attribute (like "good website builder") is never the job itself—it''s a solution the customer has hired to accomplish a deeper goal. The PM should probe beyond the feature to understand the underlying job: perhaps the merchant needs to "look professional and credible to customers without hiring a developer" or "launch an online store quickly enough to capture a seasonal demand." Option C correctly identifies that the statement describes a solution, not a job, and requires deeper exploration. Option A incorrectly accepts the feature as the job. Option B overcomplicates the interpretation with emotional dimensions that aren''t warranted from a single statement. Option D prematurely pivots to competitive analysis rather than understanding the merchant''s fundamental need. Clayton Christensen''s JTBD framework teaches that customers don''t buy products—they hire them to make progress in specific circumstances.',
    ARRAY['jobs_to_be_done', 'user_interview', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A clear articulation of the core job—the merchant''s primary job-to-be-done is "build a good website"', false),
    (v_q_id, 'B', 'Evidence of a social and emotional job dimension that needs to be mapped across the JTBD canvas immediately', false),
    (v_q_id, 'C', 'A surface-level feature preference that needs deeper probing to uncover the underlying job, such as "appear professional and credible to customers without technical skills"', true),
    (v_q_id, 'D', 'A competitive positioning insight that should be shared with the marketing team for messaging refinement', false);

    -- QUESTION 12 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 12,
    'LinkedIn''s Job Seeker Survey Sample Size',
    'LinkedIn''s PM wants to understand job seeker satisfaction across 8 different industries. The PM plans to run a survey and needs to determine sample size. The research team has access to 500 million users. A data analyst suggests surveying 50 users per industry (400 total), while a researcher recommends 385 per industry (3,080 total) based on a 95% confidence level and 5% margin of error. Which approach should the PM take?',
    'intermediate', 'LinkedIn', 'Job seeker satisfaction measurement across industries',
    'B',
    'The researcher''s recommendation of 385 per industry is correct for achieving statistically meaningful results that can be compared across industries. Option B is the right approach because if the PM wants to make industry-specific claims and comparisons, each industry subgroup needs sufficient sample size independently. The standard formula for a 95% confidence level with 5% margin of error yields approximately 385 respondents per segment when the population is large. Option A (50 per industry) would produce margins of error around ±14%, making cross-industry comparisons unreliable and potentially misleading. Option C sounds efficient but loses the ability to compare across industries—the PM can''t make industry-specific decisions from a pooled sample. Option D confuses the purpose of a pilot study with a full survey launch. In survey research, the sample size is determined by the level of analysis you need, not the total population size—this is a common misconception among PMs.',
    ARRAY['survey_design', 'quantitative_research', 'sample_bias']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use 50 per industry since the total sample of 400 is large enough to draw conclusions about job seekers overall', false),
    (v_q_id, 'B', 'Use 385 per industry since each industry subgroup needs independent statistical power for meaningful cross-industry comparisons', true),
    (v_q_id, 'C', 'Survey 385 total users with proportional representation from each industry, since the confidence level applies to the overall sample', false),
    (v_q_id, 'D', 'Start with 50 per industry as a pilot, then scale to 385 per industry only if the pilot reveals significant differences between industries', false);

    -- QUESTION 13 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 13,
    'Pinterest''s Visual Search Field Study',
    'Pinterest''s PM wants to understand how users engage with visual search in physical retail environments (e.g., pointing their phone at a piece of furniture to find similar items on Pinterest). The PM is choosing between a lab-based usability study and a field study conducted in actual furniture stores. The feature currently has low adoption despite positive usability test results in the lab.',
    'intermediate', 'Pinterest', 'Visual search feature adoption in retail contexts',
    'C',
    'The disconnect between positive lab results and low real-world adoption is a classic signal that contextual factors are at play—factors that only a field study can capture. In a lab, participants are primed to use visual search, the lighting is good, they''re focused, and there''s no social awkwardness. In a real store, users face issues like poor lighting, feeling self-conscious pointing their phone at products, being interrupted by sales staff, inconsistent Wi-Fi, and competing priorities. Option C correctly identifies that field research captures these environmental and social barriers. Option A is wrong because repeating lab studies with more users won''t uncover contextual barriers. Option B focuses on marketing, which may help but won''t address fundamental adoption barriers. Option D suggests analytics, but if adoption is low, there''s insufficient behavioral data to analyze. Ethnographic field research excels at revealing the gap between controlled-environment performance and real-world behavior.',
    ARRAY['field_study', 'ethnographic_research', 'usability_study']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Run a larger lab-based usability study with 30+ participants to get more reliable metrics on task success rates', false),
    (v_q_id, 'B', 'Focus on improving feature discoverability through marketing rather than conducting more research', false),
    (v_q_id, 'C', 'Conduct a field study in actual retail stores to observe environmental barriers, social dynamics, and contextual friction that lab studies cannot replicate', true),
    (v_q_id, 'D', 'Analyze in-app behavioral data to identify where users attempt visual search but fail, then fix those technical issues', false);

    -- QUESTION 14 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 14,
    'Canva''s NPS Score Interpretation',
    E'Canva''s PM receives the following NPS data from their quarterly survey:\n\n| Segment | NPS Score | Response Rate | Sample Size |\n|---------|-----------|---------------|-------------|\n| Free Users | +45 | 2% | 800 |\n| Pro Users | +62 | 35% | 2,100 |\n| Enterprise | +28 | 60% | 180 |\n\nThe PM is preparing a report for the CEO. What is the most important caveat the PM should highlight?',
    'intermediate', 'Canva', 'Cross-segment customer satisfaction measurement',
    'A',
    'The most critical caveat is the 2% response rate among Free Users, which introduces severe non-response bias. When only 2% of free users respond to an NPS survey, the respondents are almost certainly not representative—they''re likely the most engaged, most satisfied free users, meaning the +45 NPS is probably significantly inflated. Option A correctly identifies this as the biggest threat to data validity. Option B is wrong because while Enterprise NPS is lower, a +28 NPS is still positive and the 60% response rate makes it more trustworthy. Option C misapplies sample size concerns—800 responses is statistically adequate, but the low response rate means those 800 are self-selected. Option D suggests the numbers are directly comparable, ignoring the vastly different response rates and self-selection biases across segments. The PM should report Free User NPS with a strong caveat about non-response bias and avoid making direct cross-segment comparisons without normalizing for response rate differences.',
    ARRAY['nps_interpretation', 'quantitative_research', 'sample_bias', 'survey_design']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The Free Users'' 2% response rate likely introduces severe non-response bias, making the +45 NPS unreliable as it probably represents only the most engaged free users', true),
    (v_q_id, 'B', 'The Enterprise NPS of +28 is alarmingly low and requires immediate intervention since enterprise customers generate the most revenue', false),
    (v_q_id, 'C', 'The Pro Users'' NPS is the most reliable because 2,100 is the largest sample size, making cross-segment comparisons most meaningful against this benchmark', false),
    (v_q_id, 'D', 'All three segments have strong positive NPS scores, indicating healthy satisfaction across the entire user base with no significant concerns', false);

    -- QUESTION 15 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 15,
    'Zoom''s Meeting Fatigue Ethnographic Study',
    'Zoom''s PM wants to deeply understand "Zoom fatigue" to inform the next generation of meeting experiences. The team is considering an ethnographic study where researchers would remotely observe participants during their workday, including all video calls, for 5 consecutive workdays. A privacy-conscious researcher raises concerns about this approach.',
    'intermediate', 'Zoom', 'Remote work meeting fatigue and experience design',
    'D',
    'Ethnographic research in workplace settings presents significant ethical and practical challenges. Observing all video calls for 5 days would require consent not just from the participant but from everyone else on their calls—a logistical nightmare that could also alter behavior through the Hawthorne effect. Option D provides a practical alternative that respects privacy while still capturing contextual data: participants self-document through structured diary entries and selected screen recordings they control, combined with end-of-day reflection interviews. Option A ignores legitimate privacy concerns, which could lead to ethical violations and biased data (people won''t behave naturally if uncomfortable). Option B (just surveys) would lose the rich, contextual data that ethnographic methods uniquely provide. Option C overly limits the scope—observing only Zoom-hosted calls misses the full picture of how meetings fit into the participant''s broader workday. Ethical research design balances depth of insight with participant autonomy.',
    ARRAY['ethnographic_research', 'diary_study', 'field_study', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Proceed with the full observation plan since participants will have signed consent forms and the research insights justify the privacy trade-off', false),
    (v_q_id, 'B', 'Replace the ethnographic study with an anonymous survey to avoid all privacy concerns while still gathering fatigue-related data', false),
    (v_q_id, 'C', 'Limit observations to only Zoom-hosted meetings (excluding competitor tools) and blur all other participants'' faces', false),
    (v_q_id, 'D', 'Redesign as a participant-led study: have users keep a structured diary of their meeting experiences and share selected screen recordings, paired with end-of-day debrief interviews', true);

    -- QUESTION 16 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 16,
    'DoorDash''s Confirmation Bias in Research',
    'DoorDash''s PM strongly believes that delivery speed is the #1 factor driving customer satisfaction. The PM designs a research study that includes: (1) interview questions like "How important is delivery speed to you?", (2) a survey where delivery speed is the first satisfaction dimension listed, and (3) analysis that segments users by delivery speed satisfaction first. A senior researcher reviews the study design and flags a concern.',
    'intermediate', 'DoorDash', 'Customer satisfaction driver analysis for food delivery',
    'B',
    'The entire research design is structured around the PM''s pre-existing belief that delivery speed is the primary satisfaction driver, creating confirmation bias at every stage. The interview questions prime participants to think about speed, the survey order creates primacy bias (respondents rate the first item they see more favorably), and the analysis framework centers speed as the primary lens. Option B correctly identifies this as systematic confirmation bias embedded in the research design. Option A is wrong because while delivery speed may indeed matter, the research design cannot objectively test this since it''s structured to confirm the hypothesis. Option C incorrectly suggests that having multiple methods (triangulation) fixes the bias—if all three methods are biased in the same direction, triangulation doesn''t help. Option D mischaracterizes the issue as merely a question ordering problem when the bias is systemic across the entire study. Good research design requires the researcher to actively design against their own hypotheses, using open-ended exploration, randomized question ordering, and analysis frameworks that don''t privilege any single dimension.',
    ARRAY['research_bias', 'survey_design', 'user_interview', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The design is sound because it comprehensively explores the delivery speed dimension through multiple research methods, providing triangulated evidence', false),
    (v_q_id, 'B', 'The entire study design exhibits confirmation bias—the interview questions, survey ordering, and analysis framework are all structured to validate the PM''s pre-existing belief about delivery speed', true),
    (v_q_id, 'C', 'The study is methodologically strong because it uses mixed methods (interviews, surveys, data analysis), which inherently controls for researcher bias', false),
    (v_q_id, 'D', 'The only issue is the survey question ordering; randomizing the satisfaction dimensions would fix the study design', false);

    -- QUESTION 17 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 17,
    'Stripe''s Developer Experience Interview Protocol',
    'Stripe''s PM is planning user interviews with developers who integrate Stripe''s payment API. The PM has prepared a structured interview guide with 25 predetermined questions and no room for deviation. The interviews are scheduled for 30 minutes each. A senior researcher suggests modifying the approach.',
    'intermediate', 'Stripe', 'Developer payment API integration experience',
    'C',
    'A rigid 25-question structured interview in 30 minutes leaves roughly 72 seconds per question—barely enough time for a developer to explain complex integration challenges, let alone for the interviewer to probe interesting threads. Option C correctly recommends switching to a semi-structured format: have 5-7 core questions that ensure coverage of key topics, but allow flexibility to explore unexpected insights. Developer experience research is particularly ill-suited to rigid protocols because integration challenges are highly contextual—one developer''s pain point might be documentation, another''s might be error handling, and a third might struggle with testing. Option A is wrong because maintaining a strict structure prevents the PM from following up on the most valuable insights. Option B makes the problem worse by expanding the structured question set. Option D (unstructured) swings too far—without any guide, the PM risks inconsistent coverage across interviews and difficulty synthesizing findings. Semi-structured interviews balance consistency with flexibility, which is the gold standard for exploratory product research.',
    ARRAY['user_interview', 'qualitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Keep the 25-question structure but extend interviews to 60 minutes so each question gets adequate time', false),
    (v_q_id, 'B', 'Add 10 more questions to ensure comprehensive coverage of all possible integration pain points', false),
    (v_q_id, 'C', 'Switch to a semi-structured format with 5-7 core questions and flexible follow-up probes, allowing the conversation to explore the developer''s specific context and challenges', true),
    (v_q_id, 'D', 'Switch to a fully unstructured format where the developer leads the conversation entirely, ensuring their authentic experience is captured without researcher influence', false);

    -- QUESTION 18 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 18,
    'Instagram''s Reels Intercept Survey Strategy',
    'Instagram''s PM wants to understand real-time reactions to Reels content. The team designs an intercept survey that appears immediately after a user watches a Reel, asking 8 questions about their experience. After a 2-day pilot with 10,000 users, the PM notices: (1) survey completion rate is only 12%, (2) average session time drops 15% for surveyed users, and (3) NPS from surveyed users is 10 points lower than the app''s overall NPS.',
    'intermediate', 'Instagram', 'Short-form video content experience measurement',
    'D',
    'This is a classic case of survey-induced negative experience. An 8-question intercept survey is far too long for a context where users are in a flow state consuming short-form content. The interruption itself is degrading the experience (explaining the NPS drop and session time decrease), and the low completion rate suggests most users find the survey burdensome. Option D correctly recommends reducing to 1-2 questions and showing the survey only occasionally and to a random subset, minimizing disruption while still gathering signal. Option A (increasing incentives) would improve completion but not fix the disruption—users would still have a worse experience, and incentives introduce response bias. Option B (targeting power users) doesn''t solve the core design problem and creates selection bias. Option C (removing the survey entirely) is an overreaction—intercept surveys can work when designed appropriately. The principle is that intercept surveys must be ultra-brief, contextually appropriate, and shown to a small random sample to avoid contaminating the experience being measured.',
    ARRAY['intercept_survey', 'survey_design', 'quantitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Increase the survey incentive (e.g., offer a badge or feature unlock) to improve the 12% completion rate without changing the survey length', false),
    (v_q_id, 'B', 'Target the survey only to power users who are more invested in the product and more likely to complete 8 questions', false),
    (v_q_id, 'C', 'Remove the intercept survey entirely since it''s negatively impacting the user experience and rely solely on behavioral analytics', false),
    (v_q_id, 'D', 'Reduce to 1-2 questions maximum, display to a small random sample, and rotate questions across users to cover all 8 topics without burdening any single user', true);

    -- QUESTION 19 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 19,
    'Dropbox''s Survivorship Bias in Research',
    'Dropbox''s PM conducts 15 interviews with long-term power users (5+ years, using 80%+ of storage) to understand what makes Dropbox valuable. Every interviewee mentions "seamless file syncing" as the primary value. The PM concludes that file syncing is the #1 driver of Dropbox''s value proposition and recommends doubling engineering investment in sync reliability. What is the primary research flaw?',
    'intermediate', 'Dropbox', 'Cloud storage value proposition and user retention',
    'A',
    'This is a textbook example of survivorship bias. By interviewing only long-term power users, the PM is hearing exclusively from people for whom Dropbox''s file syncing already works well. The PM is missing the perspectives of users who tried Dropbox and left (perhaps because syncing didn''t meet their needs, or because they valued collaboration features Dropbox lacked), users who considered Dropbox but chose competitors, and casual users who use Dropbox differently. Option A correctly identifies survivorship bias as the primary flaw. Option B is wrong because 15 interviews can be sufficient for qualitative research—the problem is who was interviewed, not how many. Option C incorrectly suggests that long-term users are inherently the right population for value proposition research. Option D misidentifies the issue as interview technique rather than sampling design. To understand the true value proposition, the PM should interview a spectrum: churned users, light users, power users, and prospects who chose competitors.',
    ARRAY['sample_bias', 'research_bias', 'user_interview', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Survivorship bias—by interviewing only successful power users, the PM misses the perspectives of churned users, light users, and prospects who chose competitors', true),
    (v_q_id, 'B', 'The sample size of 15 is too small to make product strategy recommendations; the PM needs at least 50 interviews', false),
    (v_q_id, 'C', 'No significant flaw—long-term power users are the best source for understanding core product value since they''ve experienced the product most deeply', false),
    (v_q_id, 'D', 'The interview questions were likely leading, causing users to anchor on file syncing rather than expressing their authentic priorities', false);

    -- QUESTION 20 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 20,
    'Google Maps'' Accessibility Research Design',
    'Google Maps'' PM wants to improve navigation for visually impaired users. The PM plans to conduct usability research. The initial plan is to recruit sighted users, have them wear a blindfold, and test the voice navigation feature. A researcher on the team objects to this approach.',
    'intermediate', 'Google Maps', 'Navigation accessibility for visually impaired users',
    'B',
    'Testing accessibility features with sighted users wearing blindfolds is a well-known methodological error in accessibility research. Sighted users who are temporarily blindfolded have fundamentally different mental models, coping strategies, and technology proficiency than users who are actually visually impaired. A blindfolded sighted user has a visual spatial memory of their environment that a person born blind would not have, and they lack the screen reader expertise, haptic navigation skills, and adaptive strategies that visually impaired users have developed. Option B correctly recommends recruiting actual visually impaired users and partnering with accessibility organizations. Option A endorses a flawed methodology. Option C replaces real user research with expert evaluation, which misses the lived experience of actual users. Option D combines the blindfold simulation with limited real user testing, but the simulation data would still be invalid and potentially misleading. The principle: always research with representative users, especially for accessibility—simulating a disability produces fundamentally different and unreliable data.',
    ARRAY['usability_study', 'recruitment_strategy', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The blindfold approach is valid because it creates an equivalent experience and is much easier to recruit for', false),
    (v_q_id, 'B', 'Recruit actual visually impaired users through accessibility organizations, as they have different mental models, screen reader expertise, and adaptive strategies that cannot be simulated', true),
    (v_q_id, 'C', 'Skip user testing entirely and instead conduct an expert heuristic evaluation using WCAG accessibility guidelines', false),
    (v_q_id, 'D', 'Use the blindfold approach for initial testing, then validate findings with 2-3 visually impaired users as a final check', false);

    -- QUESTION 21 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 21,
    'Robinhood''s Feature Prioritization Research',
    E'Robinhood''s PM is deciding between three potential features for the next quarter. The PM runs a survey asking 5,000 users to rank these features by importance:\n\n| Feature | Ranked #1 | Ranked #2 | Ranked #3 |\n|---------|-----------|-----------|-----------|\n| Options Trading Tutorials | 45% | 30% | 25% |\n| Portfolio Comparison Tool | 25% | 40% | 35% |\n| Tax Document Automation | 30% | 30% | 40% |\n\nThe PM prepares to prioritize Options Trading Tutorials based on the #1 ranking. What should a senior PM advise?',
    'intermediate', 'Robinhood', 'Feature prioritization for retail investing platform',
    'C',
    'Relying solely on stated preference surveys for feature prioritization is a common PM mistake. Users often rank features based on what sounds appealing in the abstract, not what would actually change their behavior or create value. Option C correctly advises combining the stated preference data with behavioral signals and willingness-to-pay analysis. For example, users might rank Options Trading Tutorials #1 because it sounds educational, but behavioral data might show that very few users actually engage with existing tutorials—suggesting the stated preference wouldn''t translate to real usage. Option A takes the survey data at face value without critical evaluation. Option B uses an overly simplistic threshold to eliminate a feature that 30% of users ranked first. Option D correctly notes a limitation but proposes an overly complex solution (conjoint analysis) when simpler behavioral validation would suffice. The best PMs triangulate stated preferences with revealed preferences (what users actually do) and business impact analysis.',
    ARRAY['survey_design', 'quantitative_research', 'research_synthesis']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The data clearly supports prioritizing Options Trading Tutorials since it has the highest percentage of #1 rankings at 45%', false),
    (v_q_id, 'B', 'Eliminate Tax Document Automation since it has the lowest #1 ranking and focus the decision between the other two features', false),
    (v_q_id, 'C', 'Stated preference rankings often don''t predict actual behavior—complement with behavioral data (e.g., feature usage patterns, support tickets) and consider willingness-to-pay or effort-to-adopt signals', true),
    (v_q_id, 'D', 'The ranking methodology is flawed because it forces a rank order; the PM should rerun the survey using a conjoint analysis to measure true feature trade-offs', false);

    -- QUESTION 22 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 22,
    'Peloton''s Post-Pandemic Usage Research',
    'Peloton''s PM is conducting research to understand how user behavior changed from pandemic-era to post-pandemic. The PM has access to both behavioral data (usage frequency, class types, workout duration) and plans to conduct interviews. The PM schedules 20 interviews and asks users: "How has your Peloton usage changed since the pandemic ended?" In the first 5 interviews, every user says their usage hasn''t really changed. But the behavioral data shows a 40% decline in average session frequency. What should the PM do?',
    'intermediate', 'Peloton', 'Fitness platform usage behavior post-pandemic shift',
    'D',
    'The discrepancy between what users say (usage hasn''t changed) and what the data shows (40% decline) is a classic say-do gap. Users are not intentionally lying—they likely don''t perceive the gradual decline in their own behavior, or they''re describing their intention rather than their actual behavior. Option D correctly adjusts the interview approach to present users with their actual data and use it as a conversation starter, which helps bridge the say-do gap by grounding the discussion in reality. Option A (trusting the qualitative data) ignores clear quantitative evidence. Option B (abandoning interviews) throws away the opportunity to understand ''why'' usage declined. Option C (assuming users are lying) is both wrong and counterproductive—the gap isn''t about dishonesty but about the well-documented limitations of self-reported behavior recall. When behavioral data contradicts user self-reports, the best researchers use the data as a probe in interviews: "Our records show you went from 5 sessions/week to 3. What changed?" This respectful confrontation often unlocks the richest insights.',
    ARRAY['qualitative_research', 'quantitative_research', 'research_bias', 'user_interview']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Trust the interview data since users have the most accurate understanding of their own behavior and the quantitative data may have measurement errors', false),
    (v_q_id, 'B', 'Abandon the interviews since users clearly cannot self-report accurately and rely entirely on behavioral data analysis', false),
    (v_q_id, 'C', 'Assume users are being dishonest about their usage decline and redesign the interview to catch inconsistencies in their responses', false),
    (v_q_id, 'D', 'Revise the interview protocol to share users'' actual usage data with them during the interview, then explore their reactions and the reasons behind the discrepancy', true);

    -- QUESTION 23 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 23,
    'Grammarly''s Enterprise Research Synthesis',
    E'Grammarly''s PM has completed a mixed-methods research study on enterprise adoption. The findings include:\n\n- **Interviews (n=18):** IT admins cite SSO integration and compliance as top concerns\n- **Survey (n=1,200):** End users rank "tone detection" as the most desired feature (68%)\n- **Support tickets (n=5,000):** Most common complaint is "suggestions not relevant to my industry jargon"\n- **Usage data:** Teams that customize the style guide have 3x higher retention\n\nThe PM needs to synthesize these findings into a single, coherent recommendation. What is the best approach?',
    'intermediate', 'Grammarly', 'Enterprise writing assistant adoption and retention',
    'B',
    'Effective research synthesis requires recognizing that different stakeholders (IT admins vs end users) have different concerns, and different data sources answer different questions. Option B correctly identifies that the findings reveal a coherent story when viewed as a system: enterprise adoption requires clearing IT admin gatekeepers (SSO/compliance), but retention and satisfaction depend on end-user value (customization and relevance). The PM should recommend an adoption-then-retention roadmap that addresses both. Option A cherry-picks one data source (survey) and ignores the others. Option C over-indexes on a single metric (retention correlation with style guide) without considering the adoption barrier. Option D fragments the findings into separate workstreams rather than synthesizing them into a coherent strategy. The hallmark of great research synthesis is finding the narrative that connects disparate data points into a unified strategic insight, not treating each finding as an independent action item.',
    ARRAY['research_synthesis', 'qualitative_research', 'quantitative_research', 'voice_of_customer']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Prioritize tone detection since it has the highest demand signal at 68% in the survey, which has the largest sample size', false),
    (v_q_id, 'B', 'Synthesize across sources: SSO/compliance are adoption gates, while industry customization and style guides drive retention—recommend an adoption-first, retention-second roadmap', true),
    (v_q_id, 'C', 'Focus on style guide customization since usage data shows 3x retention lift, which is the strongest quantitative signal in the dataset', false),
    (v_q_id, 'D', 'Present each data source''s findings separately to the leadership team and let them decide which signal to prioritize based on business strategy', false);

    -- QUESTION 24 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 24,
    'Lyft''s Rider Safety Perception Research',
    'Lyft''s PM is researching rider safety perceptions, particularly among women riders who use the service at night. The PM considers three approaches: (1) an in-app survey after nighttime rides, (2) focus groups with 8-10 women riders, or (3) 1-on-1 interviews in a private setting. The topic involves potentially sensitive personal safety experiences.',
    'intermediate', 'Lyft', 'Rider safety perception and experience for women users',
    'C',
    'For sensitive topics like personal safety experiences, 1-on-1 interviews in a private setting are significantly more appropriate than focus groups or in-app surveys. Option C is correct because safety experiences often involve vulnerability, fear, and potentially traumatic events that participants are unlikely to share in a group setting due to social pressure, embarrassment, or fear of judgment. In-app surveys (Option A) are too impersonal and constrained for exploring the nuanced, emotional nature of safety experiences—they can''t capture the full context or follow up on important threads. Focus groups (Option B) create social dynamics where participants may suppress or modify their experiences based on others'' reactions, and a single dominant voice can influence the group. Option D suggests online anonymity helps, but it loses the ability to build rapport, probe deeper, and read non-verbal cues—all critical for sensitive research. The principle: match the research method to the emotional sensitivity and privacy needs of the topic.',
    ARRAY['user_interview', 'qualitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The in-app survey, because it captures feedback immediately after the experience when memory is freshest and can reach the largest sample', false),
    (v_q_id, 'B', 'Focus groups, because hearing other women''s experiences will encourage participants to open up and share more candidly through group dynamics', false),
    (v_q_id, 'C', '1-on-1 interviews in a private setting, because safety experiences are sensitive and personal—participants are more likely to share vulnerable experiences without the social pressure of a group', true),
    (v_q_id, 'D', 'An anonymous online forum discussion, because anonymity will encourage the most honest sharing about sensitive safety topics', false);

    -- QUESTION 25 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 25,
    'Calendly''s International Expansion Research',
    'Calendly''s PM is planning to expand into Japan and needs to understand how Japanese professionals schedule meetings. The PM''s initial plan is to translate the existing English-language survey (validated in the US market) into Japanese and distribute it. A researcher with experience in cross-cultural research suggests this approach may be insufficient.',
    'intermediate', 'Calendly', 'Scheduling tool international expansion to Japan',
    'D',
    'Simply translating a survey instrument fails to account for cultural differences in work practices, communication norms, and the concept of scheduling itself. In Japan, meeting scheduling involves complex hierarchical considerations (seniority dictates scheduling flexibility), cultural norms around indirect communication (respondents may not provide negative feedback directly), and different technology adoption patterns. Option D correctly recommends starting with exploratory ethnographic research to understand the cultural context before adapting any research instruments. Option A (just translating) commits the classic localization fallacy—assuming the same questions are relevant across cultures. Option B (back-translation) improves linguistic accuracy but doesn''t address whether the questions themselves are culturally relevant. Option C adds Japanese researchers to the team, which helps but doesn''t change the fundamentally flawed approach of applying Western survey constructs to a Japanese context. Cross-cultural research requires understanding the cultural framework first, then designing culturally appropriate research instruments—not translating existing ones.',
    ARRAY['field_study', 'ethnographic_research', 'survey_design', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The translation approach is sufficient as long as a professional translator with business expertise handles the localization', false),
    (v_q_id, 'B', 'Use back-translation (translate to Japanese, then have a different translator convert back to English) to verify accuracy, then distribute the survey', false),
    (v_q_id, 'C', 'Add Japanese-speaking researchers to the team to conduct the translated survey and interpret cultural nuances in the responses', false),
    (v_q_id, 'D', 'Start with exploratory ethnographic research and contextual interviews with Japanese professionals to understand local scheduling practices before designing a culturally appropriate research instrument', true);

    -- QUESTION 26 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 26,
    'Miro''s Remote Collaboration Diary Study Design',
    'Miro''s PM wants to understand how remote design teams use whiteboarding tools throughout a product development sprint. The PM decides to conduct a 2-week diary study with 25 participants from different companies. The PM needs to decide on the data collection method: participants could (1) fill out a daily end-of-day survey, (2) log each whiteboarding session in real-time via a mobile prompt, or (3) participate in a weekly interview where they recall the week''s activities.',
    'intermediate', 'Miro', 'Remote design team whiteboarding behavior over time',
    'B',
    'Real-time logging via mobile prompts (experience sampling method) is the best approach for a diary study tracking discrete events like whiteboarding sessions. Option B is correct because it captures each session as it happens, minimizing recall bias and providing accurate data about frequency, context, duration, and emotional state. End-of-day surveys (Option A) introduce significant recall bias—participants will forget shorter or less impactful whiteboarding sessions, remember the last session most vividly (recency bias), and may not accurately reconstruct the day''s timeline. Weekly interviews (Option C) compound the recall problem even further and require participants to reconstruct 5 working days of activities from memory, which research shows produces highly unreliable data. Option D proposes automated tracking, which can capture frequency but misses the subjective experience, context, and purpose—the core value of a diary study. The gold standard for diary studies is event-contingent sampling (logging at the time of the event) for discrete, identifiable activities.',
    ARRAY['diary_study', 'qualitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Daily end-of-day surveys since they provide a natural reflection point and are less disruptive to participants'' workflow', false),
    (v_q_id, 'B', 'Real-time mobile prompts triggered by each whiteboarding session, capturing context, purpose, and experience while the event is fresh', true),
    (v_q_id, 'C', 'Weekly interviews because the researcher can probe deeper into each event and build rapport with participants over the study period', false),
    (v_q_id, 'D', 'Automatic screen recording of all whiteboarding sessions to capture objective behavioral data without relying on participant self-reporting', false);

    -- QUESTION 27 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 27,
    'Amazon''s Alexa Voice Research Challenges',
    'Amazon''s PM for Alexa is analyzing voice interaction research. The team ran two studies: (1) a lab study where users completed 10 tasks using voice commands with a 92% success rate, and (2) a field study in users'' homes where the success rate was only 61%. The PM needs to explain this gap to leadership and recommend the path forward.',
    'intermediate', 'Amazon', 'Voice assistant interaction in real-world environments',
    'C',
    'The 31-percentage-point gap between lab and field performance reveals that real-world conditions fundamentally differ from controlled lab environments. Option C correctly identifies the key factors: ambient noise (TV, conversations, kitchen appliances), multi-user households (children interrupting, multiple people speaking), varied acoustic environments (kitchen vs bedroom vs car), and user context (divided attention, multitasking). In a lab, users are focused, the room is quiet, and there are no interruptions. Option A incorrectly claims 61% field performance is acceptable, which would mean ~4 in 10 voice commands fail—a terrible user experience. Option B recommends more lab testing, which would only confirm the already-known high lab performance and wouldn''t address the real-world gap. Option D blames user behavior rather than the system''s ability to handle real-world complexity. The PM should recommend engineering investment in noise robustness, context-aware processing, and multi-speaker handling, informed by more detailed field observations to catalog specific failure modes.',
    ARRAY['field_study', 'usability_study', 'research_synthesis']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The field study success rate of 61% is within acceptable bounds for voice interfaces and shouldn''t raise concerns since lab results confirm the technology works', false),
    (v_q_id, 'B', 'Conduct more lab studies with larger sample sizes to get a more reliable baseline metric before addressing the field gap', false),
    (v_q_id, 'C', 'The gap reveals real-world factors (ambient noise, multi-user households, divided attention, varied acoustics) that lab conditions cannot replicate—recommend deeper field observation to catalog specific failure modes', true),
    (v_q_id, 'D', 'The gap is likely due to users using more complex or colloquial commands at home versus the scripted tasks in the lab, so focus on improving natural language understanding', false);

    -- QUESTION 28 (Intermediate)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 28,
    'Asana''s Research Democratization Strategy',
    'Asana''s PM team has grown to 15 PMs but has only 2 dedicated user researchers. To scale research capacity, the Head of Product proposes "democratizing research" by training all PMs to conduct their own user interviews. The research lead has concerns about quality control. What is the best approach?',
    'intermediate', 'Asana', 'Scaling user research practice across PM organization',
    'B',
    'Research democratization is a real trend in product organizations, but it requires guardrails to maintain quality. Option B strikes the right balance: PMs can conduct tactical interviews (feature feedback, usability tests) with training and lightweight support from researchers, while strategic research (foundational studies, persona development, market research) remains with the professional researchers. Option A (full delegation to PMs) risks systematic research quality issues—leading questions, confirmation bias, poor synthesis—that could lead to bad product decisions. Option C (keeping research exclusively with 2 researchers) creates a bottleneck that slows down all 15 PMs and means most product decisions will be made without research. Option D proposes an unrealistic review process—if the 2 researchers have to review every interview, the bottleneck remains. The framework should categorize research by risk/complexity: low-risk tactical research (PMs with templates), medium-risk (PMs with researcher coaching), and high-risk strategic research (researcher-led).',
    ARRAY['research_method_selection', 'stakeholder_communication', 'qualitative_research']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Train all PMs to conduct all types of research independently, freeing researchers to focus on analysis and synthesis', false),
    (v_q_id, 'B', 'Create a tiered system: PMs conduct tactical research (feature validation, usability tests) with templates and training, while researchers lead strategic foundational studies', true),
    (v_q_id, 'C', 'Keep research exclusively with the 2 researchers to maintain quality and have PMs submit research requests through a centralized intake process', false),
    (v_q_id, 'D', 'Allow PMs to conduct interviews but require a researcher to review every interview recording and provide feedback before findings are shared', false);

    -- ========== ADVANCED QUESTIONS (29-35) ==========

    -- QUESTION 29 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 29,
    'Airbnb''s Multi-Stakeholder Experience Research',
    'Airbnb''s PM is redesigning the booking dispute resolution process, which involves three stakeholders: guests, hosts, and Airbnb''s trust & safety team. The current CSAT for dispute resolution is 2.1/5 for guests and 1.8/5 for hosts. The PM needs to design a comprehensive research program that captures all three perspectives and their interactions. The budget allows for 8 weeks of research and one dedicated researcher.',
    'advanced', 'Airbnb', 'Multi-sided marketplace dispute resolution experience',
    'C',
    'Multi-stakeholder research in a marketplace requires understanding not just each stakeholder''s independent perspective, but how their perspectives interact and conflict. Option C is the most sophisticated approach: it starts with individual interviews for each stakeholder group (guests, hosts, trust & safety agents) to understand their unique pain points and mental models, then uses journey mapping workshops where all three groups see each other''s experiences, and finally conducts role-play simulations to test new process designs with realistic stakeholder dynamics. Option A only interviews one side (guests and hosts) and misses the internal trust & safety perspective, which is crucial since they mediate disputes. Option B uses surveys, which are too shallow for understanding the complex, emotionally charged dispute process. Option D interviews all three groups independently but never brings the perspectives together, missing the interaction effects and competing needs that are central to marketplace dynamics. The principle: in multi-sided platforms, research must capture both individual perspectives and the systemic dynamics between stakeholders.',
    ARRAY['user_interview', 'research_method_selection', 'qualitative_research', 'research_synthesis']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Interview 10 guests and 10 hosts who recently went through dispute resolution, map both journey maps, and identify overlapping pain points', false),
    (v_q_id, 'B', 'Send CSAT surveys to all three groups with open-text fields to gather a large volume of verbatim feedback for thematic analysis', false),
    (v_q_id, 'C', 'Phase 1: Individual deep-dive interviews with each stakeholder group. Phase 2: Cross-stakeholder journey mapping workshops. Phase 3: Role-play simulations of redesigned processes with representatives from all three groups', true),
    (v_q_id, 'D', 'Conduct 15 interviews split equally across all three groups, synthesize each group''s findings independently, then present three separate sets of recommendations to leadership', false);

    -- QUESTION 30 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 30,
    'Spotify''s Research-Driven Persona Validation',
    E'Spotify''s PM team has been using 4 listener personas for 3 years to guide product decisions. A new VP of Product questions whether the personas are still valid. The PM reviews the original research and finds:\n\n| Persona | Original Research Base | Last Validated | Market Changes Since |\n|---------|----------------------|----------------|---------------------|\n| "The Curator" | 12 interviews, US only | 3 years ago | Rise of AI playlists |\n| "The Explorer" | 8 interviews, US only | 3 years ago | Podcast integration |\n| "The Loyalist" | 10 interviews, US + UK | 2 years ago | Social listening features |\n| "The Background Listener" | 6 interviews, US only | 3 years ago | Car/smart speaker integration |\n\nWhat should the PM recommend?',
    'advanced', 'Spotify', 'Listener persona framework validation and evolution',
    'D',
    'The persona framework has multiple critical validity issues. First, all personas were built from small qualitative samples (6-12 interviews each) that were geographically limited to 1-2 English-speaking markets—yet Spotify operates in 180+ markets. Second, the personas haven''t been validated in 2-3 years during a period of massive market shifts (AI playlists, podcasts, smart speakers) that likely changed user behavior fundamentally. Option D correctly recommends a comprehensive validation: quantitative segmentation analysis across markets to test whether the persona archetypes exist at scale, combined with qualitative refresh interviews across diverse geographies. Option A is wrong because simply "refreshing" through more interviews without quantitative validation would perpetuate the small-sample, geographically limited foundation. Option B assumes the personas are invalid without evidence—they might still be directionally correct. Option C adds geographic diversity but maintains the qualitative-only approach, which can''t validate whether the personas represent real, sizable user segments. The best practice for persona validation combines attitudinal/behavioral survey data (to confirm segments exist at scale) with qualitative depth (to update the narrative and nuance within each segment).',
    ARRAY['research_synthesis', 'quantitative_research', 'qualitative_research', 'sample_bias']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Conduct 12 new interviews per persona in the US market to refresh the existing personas with current behavioral patterns', false),
    (v_q_id, 'B', 'Retire all 4 personas immediately since they are based on outdated, small-sample research and start the persona development process from scratch', false),
    (v_q_id, 'C', 'Expand the interview base to include 5+ international markets and increase to 20 interviews per persona for stronger qualitative grounding', false),
    (v_q_id, 'D', 'Run a large-scale quantitative segmentation study across key global markets to validate whether the persona archetypes still exist, then conduct targeted qualitative research to update the narrative and nuance within validated segments', true);

    -- QUESTION 31 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 31,
    'Tesla''s Over-the-Air Update Research Ethics',
    'Tesla''s PM wants to understand how owners react to and adopt over-the-air software updates that change vehicle behavior (e.g., Autopilot adjustments, regenerative braking changes). The PM proposes three research approaches: (1) instrumenting the car to passively collect driving behavior data before and after updates without explicit per-study consent (covered under Tesla''s broad data policy), (2) recruiting owners for a longitudinal study with explicit consent and compensation, (3) analyzing online forum discussions and social media posts about updates. The PM asks the research team which approach to use.',
    'advanced', 'Tesla', 'Vehicle software update adoption and behavioral impact',
    'B',
    'This scenario involves complex research ethics around informed consent, passive data collection, and the boundary between product analytics and research. Option B correctly recommends the longitudinal study with explicit consent as the primary method, supplemented by forum analysis for broader context. This is the ethically strongest approach because participants knowingly opt in, understand how their data will be used, and are compensated for their time. Option A (passive instrumentation) is ethically problematic even with a broad data policy—using driving behavior data for research purposes without per-study consent crosses ethical boundaries, especially for safety-critical driving data. Drivers may not realize their braking patterns are being analyzed by researchers, not just engineers. Option C (forum analysis only) provides a biased sample of highly vocal users and misses the silent majority. Option D combines all three methods without addressing the ethical issues with passive data collection. The principle: when research involves safety-critical systems or sensitive behavioral data, explicit informed consent for each study is an ethical imperative, not a nice-to-have—regardless of what existing data policies permit.',
    ARRAY['ethnographic_research', 'qualitative_research', 'research_method_selection', 'diary_study']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Use approach 1 (passive instrumentation) since it provides the most objective behavioral data and is already covered under Tesla''s data collection policy', false),
    (v_q_id, 'B', 'Use approach 2 (longitudinal study with explicit consent) as the primary method, supplemented by approach 3 (forum analysis) for broader context, while avoiding passive data collection for research purposes', true),
    (v_q_id, 'C', 'Use approach 3 (forum analysis) exclusively since it''s the least intrusive method and provides authentic, unsolicited user reactions', false),
    (v_q_id, 'D', 'Combine all three approaches for methodological triangulation since the ethical concerns are already addressed by Tesla''s existing user data agreement', false);

    -- QUESTION 32 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 32,
    'Figma''s Conflicting Research Signals Resolution',
    E'Figma''s PM has collected research data on a proposed "AI-powered auto-layout" feature from four sources, and the signals conflict:\n\n| Source | Finding | Sample |\n|--------|---------|--------|\n| Usability study (n=8) | 7/8 designers completed tasks faster with AI auto-layout | Recruited from Figma Community |\n| Survey (n=2,500) | 52% of respondents said they would "probably not use" AI auto-layout | Sent to all Figma users |\n| Beta program (n=200) | DAU/MAU of 0.72 among beta users over 6 weeks | Self-selected beta opt-in |\n| Customer advisory board (n=12) | 10/12 enterprise design leads expressed strong concerns about AI unpredictability | Top-tier enterprise accounts |\n\nThe PM needs to make a launch decision. How should these conflicting signals be weighted?',
    'advanced', 'Figma', 'AI feature launch decision with conflicting research data',
    'C',
    'This is a senior PM''s crucible: synthesizing conflicting signals by understanding the biases and limitations of each source. Option C is correct because it recognizes that the beta program''s behavioral data (DAU/MAU of 0.72 is exceptional—indicating daily habitual use) is the strongest signal since it measures actual behavior over time, not stated preferences or controlled-task performance. However, the enterprise advisory board concern about AI unpredictability shouldn''t be dismissed—it represents strategic risk with high-value accounts. The correct synthesis: the feature clearly delivers value (beta behavior proves this), but the enterprise concerns need to be addressed through transparency and control features before a full launch. Option A over-indexes on the survey, which suffers from hypothetical bias (users judging a feature they haven''t used). Option B prioritizes the usability study, which has the smallest sample and only measures task performance, not willingness to adopt. Option D lets the enterprise board drive the decision, giving disproportionate weight to 12 users over 200 beta users'' revealed preferences. The key principle: revealed behavior (what users do) > stated preference (what users say they''ll do) > stated opinion (what users think about a concept).',
    ARRAY['research_synthesis', 'quantitative_research', 'qualitative_research', 'sample_bias']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Weight the survey most heavily since it has the largest sample size and represents the broadest user base—52% resistance means the feature should not launch', false),
    (v_q_id, 'B', 'Weight the usability study most heavily since it directly measures productivity improvement, which is Figma''s core value proposition', false),
    (v_q_id, 'C', 'Weight the beta behavioral data most heavily (high DAU/MAU indicates strong revealed preference), but address enterprise concerns about predictability/control before broad launch', true),
    (v_q_id, 'D', 'Weight the enterprise advisory board most heavily since these are the highest-value accounts and their concerns about AI unpredictability represent existential churn risk', false);

    -- QUESTION 33 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 33,
    'Uber''s Longitudinal Behavioral Research Design',
    'Uber''s PM is designing a 6-month longitudinal research program to understand how rider behavior evolves as a new "subscription" model is introduced. The subscription offers unlimited rides under 5 miles for $49/month. The PM needs to track how this changes transportation patterns, competing service usage, and lifestyle decisions. The research must capture both behavioral changes and the reasoning behind them across 100 participants in 3 cities.',
    'advanced', 'Uber', 'Subscription model impact on rider behavior over time',
    'D',
    'A 6-month longitudinal study tracking 100 participants across 3 cities requires a sophisticated mixed-methods design that accounts for participant attrition, temporal dynamics, and the interplay between behavioral data and subjective experience. Option D is correct because it layers multiple methods strategically: continuous behavioral data tracking provides the objective ''what'' (ride frequency, distance, timing, modal shift), monthly diary entries capture the subjective ''why'' as behavior evolves, and quarterly in-depth interviews at key inflection points allow the researcher to probe significant behavioral changes. The quarterly check-ins also help with participant retention. Option A relies solely on app data, missing the ''why'' and competing service usage. Option B uses only monthly surveys, which suffer from recall bias and can''t capture the gradual, often unconscious behavioral shifts that longitudinal research should reveal. Option C is researcher-intensive (monthly interviews with 100 people = ~33 interviews/month) and impractical, while missing the between-interview behavioral changes. The best longitudinal designs combine passive behavioral tracking with periodic active research touchpoints, increasing depth at key moments while maintaining lightweight continuous data collection.',
    ARRAY['diary_study', 'quantitative_research', 'qualitative_research', 'research_method_selection']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Track ride data from the Uber app for all 100 participants over 6 months and run a statistical analysis of before-vs-after subscription behavioral changes', false),
    (v_q_id, 'B', 'Conduct monthly online surveys with all 100 participants asking about their transportation habits, satisfaction, and lifestyle changes', false),
    (v_q_id, 'C', 'Conduct monthly 60-minute interviews with all 100 participants, recording their evolving experiences and decision-making rationale', false),
    (v_q_id, 'D', 'Layer methods: continuous behavioral data tracking via the app, monthly brief diary entries on transportation decisions and competing service usage, and quarterly in-depth interviews at key inflection points with a purposeful subsample', true);

    -- QUESTION 34 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 34,
    'Notion''s Research Insight Operationalization',
    E'Notion''s PM has completed a 3-month research program that produced 47 insights about how teams use Notion for project management. The insights range from tactical (''users can''t find the template gallery'') to strategic (''teams fundamentally misunderstand Notion''s database model, which limits their ability to build sophisticated workflows''). The PM needs to operationalize these insights across 4 product teams, each with different roadmaps and sprint cycles. Historical pattern shows that previous research insights had a 15% implementation rate after 6 months.',
    'advanced', 'Notion', 'Research insight operationalization across product teams',
    'B',
    'The 15% historical implementation rate signals a systemic operationalization problem, not a research quality problem. Option B addresses this with a structured framework: categorizing insights by urgency and scope, embedding the most relevant insights directly into each product team''s existing planning processes (rather than creating a separate research backlog that gets ignored), assigning clear owners, and establishing a quarterly review cadence. This approach recognizes that research insights fail to get implemented not because they''re bad insights, but because they''re disconnected from the decision-making processes where resource allocation actually happens. Option A (comprehensive report) is the traditional approach that produces the 15% implementation rate—a single document gets read once and forgotten. Option C over-indexes on immediate impact by converting all insights to Jira tickets, which creates backlog noise and treats strategic insights like tactical bugs. Option D is useful for buy-in but doesn''t solve the operationalization gap—presentations inspire action momentarily but don''t create accountability. The key principle: research operationalization requires embedding insights into existing workflows, not creating new artifacts that compete for attention.',
    ARRAY['research_synthesis', 'stakeholder_communication', 'voice_of_customer']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Create a comprehensive research report documenting all 47 insights with recommendations, share it with all 4 teams, and track which insights get addressed', false),
    (v_q_id, 'B', 'Categorize insights by urgency and scope, embed the highest-priority insights into each team''s existing planning and prioritization processes, assign insight owners, and establish a quarterly review cadence', true),
    (v_q_id, 'C', 'Convert all 47 insights into Jira tickets distributed across the 4 teams'' backlogs, prioritized by estimated user impact', false),
    (v_q_id, 'D', 'Present the top 10 insights in a company-wide all-hands to generate excitement and organic adoption across teams', false);

    -- QUESTION 35 (Advanced)
    INSERT INTO questions (sub_skill_id, question_number, title, scenario, difficulty, product_company, product_context, correct_option, explanation, tags)
    VALUES (v_sub_skill_id, 35,
    'Slack''s Mixed-Methods Research at Scale',
    E'Slack''s PM leads a research initiative to understand how hybrid work teams coordinate across time zones. The research plan includes:\n\n| Phase | Method | Timeline | Output |\n|-------|--------|----------|--------|\n| 1 | Quantitative analysis of message patterns across 10,000 teams | Weeks 1-3 | Behavioral segments |\n| 2 | Diary study with 40 participants across 4 segments | Weeks 4-7 | Contextual usage patterns |\n| 3 | Co-design workshops with 6 teams | Weeks 8-10 | Solution prototypes |\n| 4 | Concept testing survey with 3,000 users | Weeks 11-13 | Validated concepts |\n\nA VP asks: "Why can''t we skip Phases 1-2 and go straight to co-design workshops and concept testing? We already know hybrid work is a problem." How should the PM respond?',
    'advanced', 'Slack', 'Hybrid work coordination research program design',
    'C',
    'This question tests whether a PM understands the sequential logic of a mixed-methods research program—why each phase builds on the previous one. Option C correctly explains that Phase 1 (quantitative behavioral analysis) is essential for identifying real behavioral segments (not assumed ones), which determines who to include in Phase 2. Phase 2 (diary studies) reveals the contextual ''why'' behind the behavioral patterns, which ensures the co-design workshops in Phase 3 solve real problems rather than assumed ones. Skipping to co-design without this foundation means the PM would be designing solutions based on assumptions about hybrid work problems rather than observed reality. Option A uses authority ("trust the research team") without explaining the rationale, which doesn''t build stakeholder understanding. Option B incorrectly suggests running all phases simultaneously, which is impossible because each phase''s design depends on the previous phase''s outputs—you can''t select diary study participants without the behavioral segments, and you can''t run co-design workshops without understanding the problems discovered in diary studies. Option D agrees to skip phases, which would compromise the entire research program''s validity. The principle: in mixed-methods research, the sequence matters because each phase generates the inputs needed to design the next phase—skipping phases doesn''t just reduce depth, it risks solving the wrong problems entirely.',
    ARRAY['research_method_selection', 'quantitative_research', 'qualitative_research', 'research_synthesis']);
    RETURNING id INTO v_q_id;
    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Trust the research team''s expertise—this is the standard methodology and we should follow it as planned without modifications"', false),
    (v_q_id, 'B', '"We can compress the timeline by running all four phases simultaneously with different teams, delivering results in 4 weeks instead of 13"', false),
    (v_q_id, 'C', '"Each phase generates critical inputs for the next: Phase 1 identifies real behavioral segments for sampling, Phase 2 reveals actual problems to solve in co-design. Skipping them risks designing solutions for assumed rather than observed problems"', true),
    (v_q_id, 'D', '"You''re right—we can skip to Phase 3 and use our existing customer journey maps and support ticket analysis as a substitute for Phases 1-2"', false);

    RAISE NOTICE 'Successfully inserted 35 questions for User Research';
END $$;
