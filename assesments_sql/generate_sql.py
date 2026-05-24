import os

questions = [
    {
        "num": 1,
        "title": "Spotify's SBI Feedback",
        "scenario": "A junior PM on Spotify's Playlist team consistently interrupts engineers during standups. The Group Product Manager (GPM) needs to deliver constructive feedback to correct this behavior without demoralizing the PM.\n\nWhich approach applies the Situation-Behavior-Impact (SBI) framework correctly?",
        "diff": "foundational",
        "company": "Spotify",
        "context": "Music streaming platform",
        "correct": "B",
        "exp": "Option B perfectly follows the SBI model: Situation (yesterday's standup), Behavior (you interrupted the frontend lead twice), and Impact (it caused the meeting to run long and made the engineers feel unheard). Option A focuses on personality rather than objective behavior. Option C assumes intent ('you rush') rather than stating facts. Option D is a compliment sandwich that dilutes the core feedback.",
        "tags": ["performance_feedback", "communication", "sbi_model"],
        "options": {
            "A": "Tell the PM: 'You are coming across as aggressive in standups. You need to be more collaborative.'",
            "B": "Tell the PM: 'In yesterday's standup, you interrupted the frontend lead twice. This caused the meeting to run over and made the team feel unheard.'",
            "C": "Tell the PM: 'When you rush through standups, the engineers feel like you don't care about their constraints.'",
            "D": "Tell the PM: 'You are doing great on specs, but maybe try to let others speak more. Keep up the good work.'"
        }
    },
    {
        "num": 2,
        "title": "Slack's Delegation Strategy",
        "scenario": "A new Lead PM at Slack is overwhelmed because they are still writing detailed API specs for the messaging team while managing two junior PMs. The Lead PM complains they don't have time for strategy.\n\nWhat is the most appropriate coaching advice for this Lead PM?",
        "diff": "foundational",
        "company": "Slack",
        "context": "Workplace communication tool",
        "correct": "C",
        "exp": "Option C correctly applies delegation for development. Moving from an Individual Contributor (IC) to a Manager requires letting go of execution tasks like API specs to focus on strategy and coaching. Option A leads directly to burnout. Option B is backwards; managers own strategy and delegate execution. Option D solves the wrong problem by reducing management load instead of fixing time allocation.",
        "tags": ["delegation", "ic_to_manager", "time_management"],
        "options": {
            "A": "Tell the Lead PM to work longer hours temporarily until the junior PMs are fully ramped up.",
            "B": "Advise the Lead PM to delegate the strategic planning to the junior PMs so they can focus on specs.",
            "C": "Coach the Lead PM to delegate the API spec writing to the junior PMs, using it as a developmental opportunity.",
            "D": "Suggest transferring one of the junior PMs to another team to reduce management overhead."
        }
    },
    {
        "num": 3,
        "title": "Airbnb's Prioritization Coaching",
        "scenario": "An Associate PM at Airbnb has a backlog of 50 host-facing features and is struggling to prioritize. They ask their mentor to just tell them which three features to build next.\n\nHow should the mentor respond?",
        "diff": "foundational",
        "company": "Airbnb",
        "context": "Vacation rental marketplace",
        "correct": "B",
        "exp": "Option B represents effective coaching by asking open-ended questions that guide the mentee to the answer, building their autonomous problem-solving skills. Option A solves the problem for them, which creates dependency and prevents learning. Option C delegates core PM responsibilities to engineering. Option D is unnecessarily punitive for a junior APM seeking help.",
        "tags": ["mentorship", "prioritization", "skill_building"],
        "options": {
            "A": "Review the backlog and select the top three features for the APM to save time.",
            "B": "Ask the APM: 'What framework have you considered using to evaluate these, and what is our current goal?'",
            "C": "Tell the APM to ask the engineering team which features are easiest to build.",
            "D": "Escalate to the APM's manager that they lack basic prioritization skills."
        }
    },
    {
        "num": 4,
        "title": "Uber's Developmental Goals",
        "scenario": "A PM on Uber's driver app is excellent at execution but struggles with cross-functional influence. During performance review goal-setting, the manager needs to set a developmental goal.\n\nWhich goal is most effective?",
        "diff": "foundational",
        "company": "Uber",
        "context": "Ride-hailing platform",
        "correct": "C",
        "exp": "Option C is a specific, actionable developmental goal that directly tackles the PM's weakness (cross-functional influence) in a measurable, applied way. Option A is a standard performance/delivery goal, not a developmental one. Option B is passive and lacks application. Option D is negatively framed and doesn't actively build the skill of influence.",
        "tags": ["career_development", "goal_setting", "performance_management"],
        "options": {
            "A": "'Deliver the new driver earnings dashboard on time and under budget.'",
            "B": "'Read three books on leadership and influence by the end of Q3.'",
            "C": "'Lead the next quarterly planning session and secure buy-in from marketing and ops without escalations.'",
            "D": "'Avoid getting into any arguments with the ops team for the next six months.'"
        }
    },
    {
        "num": 5,
        "title": "Notion's Active Listening",
        "scenario": "During a 1:1, a PM at Notion expresses frustration that their engineering pod is pushing back on a new block type feature. The manager immediately interrupts to say, 'Here is how I handled pushback when I was a PM.'\n\nWhy is this a poor coaching practice?",
        "diff": "foundational",
        "company": "Notion",
        "context": "Productivity and note-taking workspace",
        "correct": "A",
        "exp": "Option A is correct. Effective coaching starts with active listening to understand the root cause before offering solutions. Jumping in with advice shuts down the PM's ability to process and problem-solve. Options B and C are bad management practices that undermine the PM's autonomy. Option D is incorrect; past experience can be relevant, but the timing of sharing it is wrong.",
        "tags": ["active_listening", "mentorship", "communication"],
        "options": {
            "A": "The manager is failing to practice active listening and jumping straight to 'solutioning'.",
            "B": "The manager should have escalated the issue to the engineering manager first.",
            "C": "The manager should have told the PM to drop the feature if engineering is pushing back.",
            "D": "The manager's past experience as a PM is entirely irrelevant to Notion's current architecture."
        }
    },
    {
        "num": 6,
        "title": "Netflix's IC to Manager Transition",
        "scenario": "A top-performing Senior PM at Netflix has just been promoted to Group PM. In their first month, they rewrite a PRD created by one of their direct reports because 'it wasn't up to my standard.'\n\nWhat feedback should the Director of Product give the GPM?",
        "diff": "foundational",
        "company": "Netflix",
        "context": "Video streaming platform",
        "correct": "B",
        "exp": "Option B correctly identifies the mindset shift required from IC to Manager. The manager's output is now the output of their team. Rewriting the PRD creates a bottleneck and prevents learning. Option A encourages micromanagement. Option C is extreme and violates coaching principles. Option D misses the core developmental problem.",
        "tags": ["ic_to_manager", "delegation", "skill_building"],
        "options": {
            "A": "'Great job ensuring high quality. Keep rewriting them until the team learns.'",
            "B": "'Your job is no longer to write perfect PRDs, but to coach your team. Next time, leave comments.'",
            "C": "'You should fire PMs who cannot write PRDs to your standard.'",
            "D": "'Only rewrite the PRD if the feature is launching within the next two weeks.'"
        }
    },
    {
        "num": 7,
        "title": "Stripe's Burnout Recognition",
        "scenario": "A highly productive PM at Stripe has started missing deadlines, skipping optional meetings, and responding cynically to user feedback. The PM previously had a flawless track record.\n\nWhat is the most appropriate first step for their manager?",
        "diff": "foundational",
        "company": "Stripe",
        "context": "Payment processing platform",
        "correct": "B",
        "exp": "Option B addresses the clear signs of burnout with empathy and fact-finding. A sudden drop in performance from a high achiever usually indicates burnout or personal issues, not a sudden loss of competence. Option A is punitive. Option C undermines their autonomy without discussion. Option D assumes the solution without understanding the root cause.",
        "tags": ["burnout_management", "empathy", "team_leadership"],
        "options": {
            "A": "Put the PM on a formal Performance Improvement Plan (PIP).",
            "B": "Schedule a 1:1 to ask open-ended questions about their workload, energy levels, and well-being.",
            "C": "Reassign half of their projects to another PM immediately without discussion.",
            "D": "Tell the PM they need to take a mandatory two-week vacation."
        }
    },
    {
        "num": 8,
        "title": "Shopify's Speaking Up Coaching",
        "scenario": "A Junior PM at Shopify has great insights in 1:1s but stays completely silent during large cross-functional reviews. \n\nHow can the manager best coach them to speak up?",
        "diff": "foundational",
        "company": "Shopify",
        "context": "E-commerce platform",
        "correct": "C",
        "exp": "Option C builds confidence incrementally by creating a safe, prepared space for the Junior PM to contribute. Option A uses threats, which increases anxiety and stifles performance. Option B puts them on the spot, potentially causing embarrassment and further retreat. Option D isolates them and removes the opportunity for growth.",
        "tags": ["confidence_building", "career_development", "mentorship"],
        "options": {
            "A": "Tell them: 'If you don't speak up in the next meeting, you won't get promoted.'",
            "B": "Call on them unexpectedly during the next large meeting to force them to talk.",
            "C": "Pre-align with them before the meeting to present one specific, small slide they are comfortable with.",
            "D": "Stop inviting them to large meetings until they are more confident."
        }
    },
    {
        "num": 9,
        "title": "Discord's Effective Praise",
        "scenario": "A PM on Discord's Trust & Safety team successfully launched a complex moderation tool on time. The manager wants to provide positive reinforcement.\n\nWhich approach is the most effective form of praise?",
        "diff": "foundational",
        "company": "Discord",
        "context": "Voice and text chat platform",
        "correct": "B",
        "exp": "Option B uses specific, behavior-based praise that reinforces exactly why the PM was successful. This ensures the PM knows what behaviors to repeat. Option A praises fixed traits, which can induce imposter syndrome. Option C relies solely on extrinsic motivation. Option D immediately pivots, minimizing the achievement.",
        "tags": ["performance_feedback", "positive_reinforcement", "communication"],
        "options": {
            "A": "'You are the smartest PM on the team, great job.'",
            "B": "'Great job launching the tool. Your ability to align legal and engineering was the key to this success.'",
            "C": "'Thanks for getting the tool out. Here is a $50 gift card.'",
            "D": "'Good work on the launch. Now let's focus on the next feature.'"
        }
    },
    {
        "num": 10,
        "title": "Tinder's Coaching vs Mentoring",
        "scenario": "A seasoned PM at Tinder is asked to help a new PM. Sometimes the new PM needs to learn how to write a SQL query. Other times, they need help figuring out their 5-year career path.\n\nHow should the seasoned PM approach this?",
        "diff": "foundational",
        "company": "Tinder",
        "context": "Dating app",
        "correct": "C",
        "exp": "Option C correctly differentiates the modalities. SQL is a hard skill that requires teaching/training. Career pathing requires coaching (asking questions to uncover goals) and mentoring (sharing experience). Options A and B confuse coaching (non-directive inquiry) with teaching. Option D abdicates leadership responsibility.",
        "tags": ["mentorship", "situational_leadership", "skill_building"],
        "options": {
            "A": "Use a mentoring approach for SQL, and a coaching approach for the 5-year career path.",
            "B": "Use a coaching approach for SQL, and a mentoring approach for the 5-year career path.",
            "C": "Use a teaching approach for SQL, and a coaching/mentoring approach for the career path.",
            "D": "Direct them to engineering for SQL, and HR for their career path."
        }
    },
    {
        "num": 11,
        "title": "Figma's Underperformance Management",
        "scenario": "A Mid-level PM at Figma has missed their OKRs for two consecutive quarters. They blame engineering delays and shifting company priorities. The manager has provided SBI feedback, but nothing has changed.\n\nWhat is the most appropriate next step?",
        "diff": "intermediate",
        "company": "Figma",
        "context": "Collaborative design tool",
        "correct": "B",
        "exp": "Option B represents the correct escalation for sustained underperformance after feedback has failed. A PIP provides clarity on expectations and a fair chance to improve. Option A skips the formal HR process. Option C just moves the problem to another team. Option D penalizes engineering for the PM's inability to manage scope.",
        "tags": ["handling_underperformance", "performance_management", "accountability"],
        "options": {
            "A": "Fire the PM immediately to maintain team standards.",
            "B": "Place the PM on a structured PIP with clear, achievable 30-day milestones and weekly check-ins.",
            "C": "Shift the PM to an internal tools team where OKRs are less strict.",
            "D": "Tell engineering leadership to prioritize this PM's tickets to help them succeed."
        }
    },
    {
        "num": 12,
        "title": "LinkedIn's Early Promotion Desire",
        "scenario": "A PM at LinkedIn with 1 year of experience demands a promotion to Senior PM, citing that they shipped three major features this year. Their manager knows they lack the strategic thinking required for the Senior level.\n\nHow should the manager handle this?",
        "diff": "intermediate",
        "company": "LinkedIn",
        "context": "Professional networking platform",
        "correct": "C",
        "exp": "Option C uses a transparent, objective framework (competency matrix) to show the PM exactly where they stand and what behaviors they need to demonstrate. It validates their wins while addressing the gap. Option A relies on tenure, not merit. Option B lowers the bar for the Senior title. Option D is unnecessarily combative.",
        "tags": ["career_pathing", "performance_feedback", "expectation_management"],
        "options": {
            "A": "Tell them 'no' and explain that they need at least 3 years of tenure for a promotion.",
            "B": "Agree to promote them to keep them motivated, but give them a smaller bonus.",
            "C": "Review the Senior matrix together, acknowledge execution wins, and identify specific strategic gaps.",
            "D": "Tell them their shipped features weren't actually that impactful."
        }
    },
    {
        "num": 13,
        "title": "Pinterest's Situational Leadership",
        "scenario": "An expert PM at Pinterest (high competence) has recently seemed disengaged and bored (low motivation). \n\nUsing the Situational Leadership model, which management style should their leader adopt?",
        "diff": "intermediate",
        "company": "Pinterest",
        "context": "Visual discovery engine",
        "correct": "C",
        "exp": "Option C correctly applies the Supporting style (high relationship, low task behavior) for an individual who is highly capable but lacking motivation. Directing (Option A) and Coaching (Option B) are for low-competence individuals. Delegating (Option D) works for high-competence, high-motivation individuals, but will exacerbate disengagement here.",
        "tags": ["situational_leadership", "motivation", "team_leadership"],
        "options": {
            "A": "Directing: Give them highly specific tasks with tight deadlines.",
            "B": "Coaching: Teach them how to do their job better.",
            "C": "Supporting: Engage in two-way dialogue to uncover what is causing disengagement and find a new challenge.",
            "D": "Delegating: Leave them completely alone until they figure it out."
        }
    },
    {
        "num": 14,
        "title": "Zoom's Peer Feedback",
        "scenario": "During a 360-review cycle at Zoom, a PM receives feedback from an engineering manager that they are 'too dictatorial.' The PM is defensive and says, 'I just have high standards.'\n\nHow should the PM's manager coach them through this?",
        "diff": "intermediate",
        "company": "Zoom",
        "context": "Video conferencing platform",
        "correct": "C",
        "exp": "Option C separates intent from impact, guiding the PM to self-reflect on their behaviors without immediately validating their defensiveness. Option A damages cross-functional relationships. Option B is a cliché that shuts down conversation. Option D reflects a fundamental misunderstanding of the PM role.",
        "tags": ["peer_feedback", "conflict_resolution", "self_reflection"],
        "options": {
            "A": "Defend the PM and tell the engineering manager they need to be more resilient.",
            "B": "Tell the PM: 'Perception is reality. If they think you are dictatorial, you are.'",
            "C": "Ask the PM: 'What specific behaviors might have led the EM to this conclusion?'",
            "D": "Ignore the feedback since product managers are supposed to dictate what to build."
        }
    },
    {
        "num": 15,
        "title": "GitHub's Failed Launch Coaching",
        "scenario": "A Mid-level PM at GitHub launched a new repository management feature that caused severe user backlash. The PM is demoralized and feels like a failure.\n\nWhat is the most effective coaching approach for the manager?",
        "diff": "intermediate",
        "company": "GitHub",
        "context": "Developer collaboration platform",
        "correct": "B",
        "exp": "Option B leverages a blameless post-mortem to turn a failure into a learning opportunity, removing personal guilt and focusing on process improvement. Option A is overly punitive and destroys psychological safety. Option C avoids accountability entirely. Option D creates learned helplessness.",
        "tags": ["failure_management", "psychological_safety", "mentorship"],
        "options": {
            "A": "Give them a formal warning and reassign their next launch to a Senior PM.",
            "B": "Conduct a blameless post-mortem to analyze systemic failures and identify lessons learned together.",
            "C": "Tell them to ignore the user backlash because users complain about every change.",
            "D": "Take over their upcoming projects until they regain their confidence."
        }
    },
    {
        "num": 16,
        "title": "Peloton's Feature Attachment",
        "scenario": "A PM at Peloton has spent six months building a new social workout feature. Early beta data shows horrible retention, but the PM refuses to kill it, arguing they just need more time to polish the UI.\n\nHow should the manager coach them?",
        "diff": "intermediate",
        "company": "Peloton",
        "context": "Interactive fitness platform",
        "correct": "C",
        "exp": "Option C directly challenges the sunk cost fallacy using a data-driven framework (opportunity cost). It forces the PM to objectively weigh the failing feature against other high-impact work. Option A acts too unilaterally. Option B enables the fallacy. Option D attacks the person rather than the decision.",
        "tags": ["sunk_cost_fallacy", "data_driven_decisions", "coaching_frameworks"],
        "options": {
            "A": "Log into the admin console and kill the feature yourself to save engineering time.",
            "B": "Give them one more month to polish the UI to see if retention improves.",
            "C": "Ask them: 'If we took the engineering resources from this feature and applied them to our top backlog item, which yields higher ROI?'",
            "D": "Tell them they are being too emotional and need to detach from their work."
        }
    },
    {
        "num": 17,
        "title": "Canva's Technical PM Empathy",
        "scenario": "A PM at Canva who transitioned from engineering is obsessed with system architecture and backend performance. However, they frequently ignore user research and UX friction.\n\nHow can the Group PM develop this PM's user empathy?",
        "diff": "intermediate",
        "company": "Canva",
        "context": "Graphic design platform",
        "correct": "B",
        "exp": "Option B uses experiential learning. By forcing the PM to directly observe users struggling, it builds genuine empathy and highlights the importance of UX. Option A relies on reading, which rarely changes deep-seated mindsets. Option C reinforces their existing technical bias. Option D creates a silo.",
        "tags": ["user_empathy", "skill_building", "cross_functional_mgmt"],
        "options": {
            "A": "Assign them three books on UX design to read over the weekend.",
            "B": "Require them to sit in on five user testing sessions and synthesize the UX friction points.",
            "C": "Praise their technical skills and encourage them to focus exclusively on backend infrastructure.",
            "D": "Tell the UX designer to handle all user-facing decisions without the PM."
        }
    },
    {
        "num": 18,
        "title": "DoorDash's XFN Conflict",
        "scenario": "A PM at DoorDash and the Operations Lead are in a heated conflict. The PM wants to batch orders to improve profitability, while Ops wants single deliveries to decrease wait times. The PM asks their manager to intervene and force Ops to comply.\n\nWhat is the best coaching response?",
        "diff": "intermediate",
        "company": "DoorDash",
        "context": "Food delivery platform",
        "correct": "A",
        "exp": "Option A coaches the PM on stakeholder management and understanding cross-functional incentives. It empowers the PM to solve the conflict themselves. Option B acts as a savior, which prevents the PM from developing conflict resolution skills. Option C tells the PM to surrender. Option D escalates prematurely.",
        "tags": ["conflict_resolution", "stakeholder_management", "cross_functional_mgmt"],
        "options": {
            "A": "Ask the PM: 'What are the Ops Lead's primary KPIs, and how can we frame our proposal as a win-win?'",
            "B": "Set up a meeting with the Ops Lead yourself and negotiate the compromise on the PM's behalf.",
            "C": "Tell the PM to drop the initiative since Ops is the primary stakeholder for delivery times.",
            "D": "Escalate the issue to the VP of Product immediately."
        }
    },
    {
        "num": 19,
        "title": "Airbnb's Strategic Thinking",
        "scenario": "An execution-focused PM at Airbnb consistently delivers features on time but struggles to define a long-term vision. The manager wants to build the PM's strategic thinking skills.\n\nWhich assignment is most appropriate?",
        "diff": "intermediate",
        "company": "Airbnb",
        "context": "Vacation rental marketplace",
        "correct": "B",
        "exp": "Option B provides an open-ended, ambiguous problem ('reduce host churn by 10%') rather than a predefined solution, forcing the PM to analyze data, identify root causes, and build a strategic roadmap. Option A is pure execution. Option C is a task, not a strategy exercise. Option D is too broad and sets them up for failure.",
        "tags": ["strategic_thinking", "career_development", "skill_building"],
        "options": {
            "A": "Ask them to write detailed API documentation for the new payment gateway.",
            "B": "Give them an ambiguous goal like 'reduce host churn by 10%' and ask them to present a 6-month roadmap.",
            "C": "Have them shadow the VP of Product for a week to see what strategy looks like.",
            "D": "Tell them to invent a completely new business model for Airbnb by next month."
        }
    },
    {
        "num": 20,
        "title": "Spotify's PM as Bottleneck",
        "scenario": "A PM at Spotify insists on personally QAing every ticket and reviewing every PR description before engineering can merge. Velocity has plummeted.\n\nHow should the manager coach this PM?",
        "diff": "intermediate",
        "company": "Spotify",
        "context": "Music streaming platform",
        "correct": "C",
        "exp": "Option C directly addresses the trust and delegation issue by helping the PM implement guardrails (agreed-upon standards) instead of manual gates. Option A just tells them to work harder. Option B moves the problem to the EM. Option D ignores the root behavioral issue.",
        "tags": ["delegation", "trust_building", "process_improvement"],
        "options": {
            "A": "Tell the PM they need to work weekends to clear the QA backlog.",
            "B": "Tell the Engineering Manager to stop listening to the PM and just merge code.",
            "C": "Coach the PM to establish clear 'Definition of Done' criteria with the team so they don't have to manually review everything.",
            "D": "Praise the PM for their high attention to detail."
        }
    },
    {
        "num": 21,
        "title": "Slack's Overpromising PM",
        "scenario": "A PM on Slack's enterprise team frequently promises unapproved features to the Sales team to help them close large deals. Engineering is frustrated by the constant context switching.\n\nWhat is the manager's best coaching approach?",
        "diff": "intermediate",
        "company": "Slack",
        "context": "Workplace communication tool",
        "correct": "A",
        "exp": "Option A provides a practical framework (saying 'not right now' instead of 'no') to manage stakeholder expectations without blowing up deals, while protecting engineering bandwidth. Option B ruins the relationship with Sales. Option C validates bad behavior. Option D is a band-aid solution.",
        "tags": ["stakeholder_management", "expectation_management", "sales_alignment"],
        "options": {
            "A": "Roleplay scenarios with the PM on how to say 'not right now' and share the existing roadmap instead of making new promises.",
            "B": "Tell Sales leadership that they are no longer allowed to speak to product managers.",
            "C": "Tell engineering they just need to be more agile to support enterprise deals.",
            "D": "Revoke the PM's access to Salesforce so they can't see the deals."
        }
    },
    {
        "num": 22,
        "title": "Shopify's Eng to PM Transition",
        "scenario": "A recently transitioned PM (former engineer) at Shopify is struggling. During sprint planning, they spend 45 minutes debating database schema with the tech lead instead of explaining the user problem.\n\nHow should the manager correct this?",
        "diff": "intermediate",
        "company": "Shopify",
        "context": "E-commerce platform",
        "correct": "B",
        "exp": "Option B clearly defines the boundary between Product (the 'what' and 'why') and Engineering (the 'how'), which is the most common hurdle for former engineers. Option A restricts communication too heavily. Option C encourages bad PM habits. Option D is an extreme overreaction.",
        "tags": ["role_clarity", "ic_to_manager", "cross_functional_mgmt"],
        "options": {
            "A": "Forbid the PM from talking about technology during any meetings.",
            "B": "Explain the boundary: 'Product owns the problem (the what and why), Engineering owns the solution (the how). Focus on the user impact.'",
            "C": "Tell the tech lead to let the PM design the database schema since they have an engineering background.",
            "D": "Transition the PM back to an engineering role immediately."
        }
    },
    {
        "num": 23,
        "title": "Stripe's Autonomy vs Intervention",
        "scenario": "A Group PM at Stripe notices a direct report is about to launch an A/B test with a slightly flawed hypothesis. The flaw won't break the product, but the test will likely fail to reach statistical significance.\n\nWhat is the best coaching decision?",
        "diff": "intermediate",
        "company": "Stripe",
        "context": "Payment processing platform",
        "correct": "C",
        "exp": "Option C leverages the concept of 'allowing safe failures.' By letting the PM run the test and review the results together, the manager provides a powerful experiential learning moment. Swooping in (Option A) prevents learning. Option B is passive-aggressive. Option D removes autonomy entirely.",
        "tags": ["situational_leadership", "delegation", "failure_management"],
        "options": {
            "A": "Immediately intervene and rewrite the hypothesis for them before the test launches.",
            "B": "Let the test run, but document the failure in their performance review.",
            "C": "Let the test run, and use the post-test analysis as a coaching moment to discuss statistical significance and hypothesis design.",
            "D": "Require the PM to get VP approval for all future A/B tests."
        }
    },
    {
        "num": 24,
        "title": "Notion's 90-day Onboarding",
        "scenario": "A manager is designing a 30-60-90 day onboarding plan for a new Senior PM at Notion. \n\nWhich structure best sets the PM up for long-term success?",
        "diff": "intermediate",
        "company": "Notion",
        "context": "Productivity and note-taking workspace",
        "correct": "A",
        "exp": "Option A follows best practices for senior hires: absorb context and build relationships first (30), take on small wins (60), and then drive strategy (90). Option B rushes execution before context is built. Option C delays impact too long. Option D is an unstructured approach that leads to failure.",
        "tags": ["onboarding", "career_pathing", "team_leadership"],
        "options": {
            "A": "30 days: Listen, learn, and build relationships. 60 days: Ship a small, well-defined feature. 90 days: Propose a new strategic initiative.",
            "B": "30 days: Ship a major feature. 60 days: Reorganize the engineering pod. 90 days: Rewrite the annual roadmap.",
            "C": "30 days: Shadow engineers. 60 days: Shadow marketing. 90 days: Shadow customer support.",
            "D": "Provide no structure and let the Senior PM figure it out themselves."
        }
    },
    {
        "num": 25,
        "title": "Uber's Difficult EM",
        "scenario": "A PM at Uber is struggling with an Engineering Manager (EM) who constantly dismisses product requirements as 'unnecessary.' The PM is frustrated and wants to escalate.\n\nHow should the manager coach the PM?",
        "diff": "intermediate",
        "company": "Uber",
        "context": "Ride-hailing platform",
        "correct": "C",
        "exp": "Option C coaches the PM on lateral leadership and empathy. By understanding the EM's pressures (e.g., tech debt, deadlines), the PM can reframe their requests. Option A damages the relationship. Option B abdicates PM responsibility. Option D is an escalation that makes the PM look incapable of handling conflict.",
        "tags": ["conflict_resolution", "empathy", "stakeholder_management"],
        "options": {
            "A": "Tell the PM to document every time the EM says no and send it to HR.",
            "B": "Advise the PM to just build whatever the EM agrees to, to keep the peace.",
            "C": "Coach the PM to schedule a 1:1 to understand the EM's underlying pressures and constraints before pushing back.",
            "D": "Escalate immediately to the VP of Engineering."
        }
    },
    {
        "num": 26,
        "title": "Netflix's Psychological Safety",
        "scenario": "Following a highly publicized bug in the recommendation algorithm, the Netflix PM team has become risk-averse, only proposing trivial, safe features.\n\nHow can the Product Director coach the team to restore psychological safety?",
        "diff": "intermediate",
        "company": "Netflix",
        "context": "Video streaming platform",
        "correct": "B",
        "exp": "Option B actively models vulnerability, which is the fastest way a leader can rebuild psychological safety. By sharing their own failures, the leader proves that risk-taking is safe. Option A is just rhetoric. Option C increases fear. Option D changes the process without addressing the underlying fear.",
        "tags": ["psychological_safety", "team_culture", "leadership"],
        "options": {
            "A": "Send an email telling the team that risk-taking is a core company value.",
            "B": "Share a story in an all-hands meeting about a massive failure the Director personally caused, and what was learned.",
            "C": "Threaten to lower performance ratings if PMs don't propose bigger ideas.",
            "D": "Implement a mandatory 'innovative idea' quota for every sprint."
        }
    },
    {
        "num": 27,
        "title": "Figma's Imposter Syndrome",
        "scenario": "A high-performing PM at Figma confides in their manager that they feel like a fraud and are terrified the team will realize they 'don't know what they are doing.'\n\nWhat is the most effective coaching response?",
        "diff": "intermediate",
        "company": "Figma",
        "context": "Collaborative design tool",
        "correct": "C",
        "exp": "Option C counters the emotional distortion of imposter syndrome with objective, documented evidence of success. Option A is dismissive of their feelings. Option B feeds the anxiety by agreeing with the premise that they are deficient. Option D is an extreme, unhelpful reaction.",
        "tags": ["imposter_syndrome", "mentorship", "empathy"],
        "options": {
            "A": "'Don't worry, everyone feels that way sometimes. Just ignore it.'",
            "B": "'If you feel that way, you should probably take a course on product management.'",
            "C": "Review their recent wins together and anchor their self-perception to objective, data-driven impact they delivered.",
            "D": "Suggest they take a leave of absence for mental health reasons."
        }
    },
    {
        "num": 28,
        "title": "LinkedIn's Executive Presence",
        "scenario": "A Senior PM at LinkedIn has brilliant strategic ideas but rambles nervously during executive reviews, causing the VP to cut them off. \n\nHow should their manager coach them?",
        "diff": "intermediate",
        "company": "LinkedIn",
        "context": "Professional networking platform",
        "correct": "B",
        "exp": "Option B provides a concrete, actionable framework (Minto Pyramid / BLUF) to structure communication for executives. Option A tells them *what* to do but not *how*. Option C protects them but prevents growth. Option D shifts the blame to the VP.",
        "tags": ["communication", "executive_presence", "career_development"],
        "options": {
            "A": "Tell them to 'just be more confident' in the next meeting.",
            "B": "Coach them on the 'Bottom Line Up Front' (BLUF) framework and do mock presentations before the next review.",
            "C": "Take over presenting their slides for them from now on.",
            "D": "Tell them the VP is just impatient and not to worry about it."
        }
    },
    {
        "num": 29,
        "title": "Discord's Toxic High Performer",
        "scenario": "A Principal PM at Discord consistently delivers 3x the revenue impact of their peers but routinely belittles designers and engineers in public channels. Several engineers have threatened to quit.\n\nHow should the VP of Product handle this?",
        "diff": "advanced",
        "company": "Discord",
        "context": "Voice and text chat platform",
        "correct": "B",
        "exp": "Option B addresses the 'brilliant jerk' problem. In healthy tech orgs, behavioral standards are just as important as revenue impact. Tolerating toxicity destroys overall team velocity and retention. Option A prioritizes short-term revenue over long-term health. Option C gives them an excuse. Option D avoids the conflict.",
        "tags": ["handling_toxicity", "performance_management", "team_culture"],
        "options": {
            "A": "Ignore the behavior because their revenue impact is too valuable to lose.",
            "B": "Deliver strict SBI feedback on the behavioral issues, making it clear that continued toxicity will result in termination regardless of impact.",
            "C": "Tell the engineers that the PM is just passionate and they need thicker skin.",
            "D": "Move the PM to a standalone strategy role with no team interaction."
        }
    },
    {
        "num": 30,
        "title": "Pinterest's Calibrating Scope",
        "scenario": "During performance calibration at Pinterest, Manager A argues for promoting a PM who launched a flashy AI feature. Manager B argues for promoting a PM who quietly refactored the data pipeline, saving $2M/year. \n\nHow should the Director coach the managers to calibrate fairly?",
        "diff": "advanced",
        "company": "Pinterest",
        "context": "Visual discovery engine",
        "correct": "C",
        "exp": "Option C ensures fairness by abstracting away the 'flashiness' of the work and evaluating both PMs against a standardized matrix of complexity, autonomy, and business impact. Option A biases toward visibility over value. Option B creates arbitrary quotas. Option D punishes both candidates due to management indecision.",
        "tags": ["performance_calibration", "leadership", "fairness"],
        "options": {
            "A": "Promote the AI PM because AI is the company's current strategic priority.",
            "B": "Tell them neither gets promoted unless they both agree on one candidate.",
            "C": "Force both managers to map their PMs' work against the standard competency matrix to evaluate impact and complexity objectively.",
            "D": "Promote neither to avoid showing favoritism."
        }
    },
    {
        "num": 31,
        "title": "Zoom's Role Ambiguity",
        "scenario": "After a reorg at Zoom, two Senior PMs find their product areas overlapping. They are stepping on each other's toes and escalating minor disputes to the Director.\n\nHow should the Director resolve this?",
        "diff": "advanced",
        "company": "Zoom",
        "context": "Video conferencing platform",
        "correct": "C",
        "exp": "Option C forces the two Senior PMs to act like leaders by collaboratively defining their own boundaries (RACI matrix). This builds their conflict resolution skills. Option A dictates the solution, missing a coaching opportunity. Option B creates an unhealthy gladiator dynamic. Option D ignores the problem.",
        "tags": ["role_clarity", "conflict_resolution", "organizational_design"],
        "options": {
            "A": "Write a detailed document clearly defining who owns what and email it to them.",
            "B": "Tell them whoever ships the next feature faster gets to own the overlapping area.",
            "C": "Require them to collaboratively draft a RACI matrix defining their boundaries and present it to you for approval.",
            "D": "Tell them to figure it out themselves and stop bothering you."
        }
    },
    {
        "num": 32,
        "title": "GitHub's Succession Planning",
        "scenario": "A Director of Product at GitHub is planning to transition to a VP role in 12 months. They need to prepare one of their Group PMs to take over their role.\n\nWhat is the best approach to succession planning?",
        "diff": "advanced",
        "company": "GitHub",
        "context": "Developer collaboration platform",
        "correct": "B",
        "exp": "Option B is the correct approach to succession planning. It involves identifying candidates early and giving them 'stretch assignments' (acting at the next level) to safely test and build their readiness. Option A is a recipe for failure due to lack of prep. Option C creates a toxic, highly competitive environment. Option D delegates leadership to HR.",
        "tags": ["succession_planning", "career_development", "leadership"],
        "options": {
            "A": "Wait until month 11, then pick the favorite Group PM and promote them.",
            "B": "Identify top candidates now, assign them stretch projects representing Director-level scope, and coach them through the execution.",
            "C": "Tell all Group PMs they are competing for the role to see who works the hardest.",
            "D": "Ask HR to handle the succession planning process."
        }
    },
    {
        "num": 33,
        "title": "Peloton's Resistant Seasoned PM",
        "scenario": "A highly experienced PM hired from Amazon refuses to use Peloton's standard PRD templates, claiming 'at Amazon we did 6-pagers, which are vastly superior.' Their refusal is creating friction with engineering.\n\nHow should the manager handle this?",
        "diff": "advanced",
        "company": "Peloton",
        "context": "Interactive fitness platform",
        "correct": "C",
        "exp": "Option C acknowledges their experience while focusing on the underlying goal (effective communication with engineering). It opens a dialogue rather than forcing compliance or fully capitulating. Option A forces rigid compliance, which alienates senior talent. Option B breaks team consistency entirely. Option D is an overreaction.",
        "tags": ["change_management", "conflict_resolution", "process_improvement"],
        "options": {
            "A": "Tell them: 'You are at Peloton now, use our templates or face disciplinary action.'",
            "B": "Allow them to use 6-pagers, and tell engineering they just need to adapt.",
            "C": "Discuss the 'why' behind Peloton's templates, identify what they believe is missing, and align on a format that serves engineering effectively.",
            "D": "Fire them for lack of culture fit."
        }
    },
    {
        "num": 34,
        "title": "DoorDash's Misaligned Career Goals",
        "scenario": "A top-performing PM at DoorDash wants to transition into an AI/ML product role. However, the company currently has zero AI initiatives, and the PM's skills are desperately needed on core growth.\n\nHow should the manager coach them?",
        "diff": "advanced",
        "company": "DoorDash",
        "context": "Food delivery platform",
        "correct": "B",
        "exp": "Option B is honest and balances the employee's career goals with business reality. Finding adjacent opportunities keeps them engaged without making false promises. Option A makes a promise the company cannot keep, destroying trust. Option C is dismissive. Option D encourages top talent to leave immediately.",
        "tags": ["career_pathing", "retention", "expectation_management"],
        "options": {
            "A": "Promise them that DoorDash will start an AI team next quarter to keep them happy.",
            "B": "Be transparent about business needs, but try to find small ways to incorporate ML models into their current growth experiments.",
            "C": "Tell them AI is just a fad and they should stick to growth.",
            "D": "Tell them they should probably start interviewing at OpenAI."
        }
    },
    {
        "num": 35,
        "title": "Canva's Coaching the Coaches",
        "scenario": "A Director of Product at Canva notices that one of their Group PMs is essentially acting as a 'super-IC,' micromanaging their direct reports and giving them exact solutions instead of coaching them.\n\nHow should the Director coach the Group PM?",
        "diff": "advanced",
        "company": "Canva",
        "context": "Graphic design platform",
        "correct": "C",
        "exp": "Option C teaches the manager 'how to fish.' By providing a framework (Socratic questioning) and requiring them to practice it, the Director is coaching the coach. Option A tells them what to do without teaching them how. Option B is passive. Option D publicly undermines the Group PM's authority.",
        "tags": ["coaching_the_coach", "leadership_development", "delegation"],
        "options": {
            "A": "Tell the Group PM to stop micromanaging immediately.",
            "B": "Send the Group PM a book on effective delegation.",
            "C": "Roleplay 1:1 scenarios, teaching the Group PM how to use open-ended Socratic questions to guide their reports to the answer.",
            "D": "Skip-level to the direct reports and tell them to ignore the Group PM's micro-tasks."
        }
    }
]

sql_template = """-- ============================================
-- ASSESSMENT: Coaching & Mentoring
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
    WHERE slug = 'coaching-mentoring';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug coaching-mentoring not found. Run the seed data first.';
    END IF;
"""

def escape_sql(text):
    return text.replace("'", "''")

with open('/Users/chirag/Startups/Assesments/sql/36_leadership_coaching_mentoring.sql', 'w') as f:
    f.write(sql_template)
    for q in questions:
        tags_str = ", ".join(["'" + t + "'" for t in q["tags"]])
        f.write(f'''
    -- ----------------------------------------
    -- QUESTION {q["num"]} ({q["diff"].capitalize()})
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        {q["num"]},
        '{escape_sql(q["title"])}',
        E'{escape_sql(q["scenario"].replace(chr(10), '\\n'))}',
        '{q["diff"]}',
        '{escape_sql(q["company"])}',
        '{escape_sql(q["context"])}',
        '{q["correct"]}',
        '{escape_sql(q["exp"])}',
        ARRAY[{tags_str}]
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '{escape_sql(q["options"]["A"])}', {str(q["correct"] == "A").lower()}),
    (v_q_id, 'B', '{escape_sql(q["options"]["B"])}', {str(q["correct"] == "B").lower()}),
    (v_q_id, 'C', '{escape_sql(q["options"]["C"])}', {str(q["correct"] == "C").lower()}),
    (v_q_id, 'D', '{escape_sql(q["options"]["D"])}', {str(q["correct"] == "D").lower()});
''')
    
    f.write("""
    RAISE NOTICE 'Successfully inserted 35 questions for Coaching & Mentoring';
END $$;
""")
