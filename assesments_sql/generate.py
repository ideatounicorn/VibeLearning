import json

questions = [
    {
        "title": "Uber's Stakeholder Power/Interest",
        "scenario": "An Uber Product Manager is launching a minor update to the driver earnings dashboard UI. The VP of Global Operations has immense power over the driver platform but has very low interest in this specific, minor UI tweak.\n\nAccording to the Power/Interest grid, how should the PM engage this VP?",
        "difficulty": "foundational",
        "company": "Uber",
        "context": "Minor UI update to driver earnings",
        "correct": "C",
        "explanation": "In stakeholder mapping, a stakeholder with High Power but Low Interest should be 'Kept Satisfied'. This means providing brief, high-level updates to ensure they are aware, but avoiding overwhelming them with deep details. Option A (Manage Closely) is for High Power/High Interest. Option B (Keep Informed) is for Low Power/High Interest. Option D is a common junior mistake; ignoring high-power stakeholders risks them blocking the project later if they feel blindsided.",
        "tags": ["stakeholder_mapping", "power_interest_grid"],
        "options": {
            "A": "Manage them closely by inviting them to weekly tactical design reviews.",
            "B": "Keep them informed by sending detailed daily progress reports.",
            "C": "Keep them satisfied with brief, high-level updates and avoid overwhelming them.",
            "D": "Monitor them passively and do not communicate unless they ask."
        }
    },
    {
        "title": "Spotify's Roadmap vs. Sales",
        "scenario": "Spotify's VP of Ad Sales urgently requests a new interactive podcast ad format by Q3 to close a major sponsor. However, the engineering team estimates the underlying infrastructure won't be ready until Q4.\n\nHow should the PM handle this mismatch?",
        "difficulty": "foundational",
        "company": "Spotify",
        "context": "Ad format delivery timeline mismatch",
        "correct": "B",
        "explanation": "Great PMs look beyond the specific feature request to understand the underlying business need. By understanding that Sales needs to close a specific sponsor, the PM can work to find an interim solution that satisfies the sponsor without destroying the engineering timeline. Option A damages trust with Sales. Option C guarantees failure and burnout for Engineering. Option D creates a dysfunctional 'pass the buck' culture.",
        "tags": ["managing_expectations", "roadmap_alignment", "sales_product_alignment"],
        "options": {
            "A": "Say 'no' immediately because the engineering roadmap is already locked.",
            "B": "Understand the sponsor's underlying goal and explore a lighter, interim solution for Q3.",
            "C": "Commit to the Q3 date for Sales and push the engineering team to work weekends.",
            "D": "Tell Sales that Engineering is at fault so they should negotiate with the CTO directly."
        }
    },
    {
        "title": "Notion's HiPPO Swoop",
        "scenario": "Midway through a critical two-week sprint, Notion's CEO (the Highest Paid Person's Opinion) drops into the team Slack channel and says, 'I was playing around with the app this weekend. We should really move the template gallery to the left sidebar right now.'\n\nWhat is the best immediate response from the PM?",
        "difficulty": "foundational",
        "company": "Notion",
        "context": "CEO suggesting abrupt UX changes",
        "correct": "B",
        "explanation": "When dealing with a HiPPO, outright rejection (Option C) causes friction, while immediate capitulation (Option A) ruins sprint predictability and team morale. The best approach is to acknowledge the feedback, extract the underlying problem they are trying to solve, and evaluate it against current priorities. Option D is passive-aggressive and assumes the CEO is wrong before understanding their perspective.",
        "tags": ["hippo", "managing_up", "sprint_protection"],
        "options": {
            "A": "Stop the current sprint work and immediately add the sidebar change to Jira.",
            "B": "Acknowledge the feedback, ask what user problem prompted it, and evaluate it for the next sprint.",
            "C": "Politely tell the CEO that the sprint is locked and they must submit a formal request.",
            "D": "Ignore the Slack message until the sprint is over to protect the engineering team."
        }
    },
    {
        "title": "Stripe's Legal Roadblock",
        "scenario": "Two days before the launch of a new Stripe invoicing feature, the Legal team flags a compliance risk regarding EU tax regulations and says, 'You cannot launch this.'\n\nHow should the PM respond?",
        "difficulty": "foundational",
        "company": "Stripe",
        "context": "Late-stage legal block on launch",
        "correct": "D",
        "explanation": "Legal is a crucial stakeholder, not an enemy. When Legal blocks a launch, the PM must sit down with them to understand the specific risk and co-create a mitigation strategy (like a copy change or scoping out the EU temporarily). Option A is reckless and risks massive fines. Option B is passive and delays the launch unnecessarily. Option C is confrontational and ruins cross-functional relationships.",
        "tags": ["cross_functional", "legal_compliance", "launch_blockers"],
        "options": {
            "A": "Launch anyway and assume the risk, as time-to-market is the primary PM responsibility.",
            "B": "Cancel the launch immediately and wait for Legal to draft new requirements.",
            "C": "Escalate to the CEO and complain that Legal is acting as a bottleneck to revenue.",
            "D": "Meet with Legal immediately to understand the exact risk and collaborate on a mitigation plan."
        }
    },
    {
        "title": "Slack's Conflicting VPs",
        "scenario": "Slack's VP of Enterprise wants strict, heavy admin approval flows for inviting external guests. The VP of Growth wants a frictionless, one-click viral invite flow. Both claim their request is the company's top priority.\n\nWhat is the most effective way for the PM to resolve this?",
        "difficulty": "foundational",
        "company": "Slack",
        "context": "Conflicting feature requests from equal-power stakeholders",
        "correct": "C",
        "explanation": "When stakeholders of equal power have directly conflicting goals, the PM must act as a facilitator. Bringing them together with data outlining the trade-offs (security vs. viral growth) allows the decision to be made based on company-wide OKRs. Option A splits the difference poorly, likely pleasing no one. Option B relies on personal preference rather than strategy. Option D abdicates product leadership.",
        "tags": ["conflict_resolution", "trade_offs", "okr_alignment"],
        "options": {
            "A": "Build exactly half of what Enterprise wants and half of what Growth wants to compromise.",
            "B": "Side with the VP you have a better relationship with to ensure political backing.",
            "C": "Bring both VPs together with data on the trade-offs and align the decision to company-level OKRs.",
            "D": "Tell Engineering to build whatever is technically easier and inform the VPs afterward."
        }
    },
    {
        "title": "Shopify's Launch Date Dilemma",
        "scenario": "Shopify's Marketing team needs a firm launch date for a massive merchant campaign. Engineering is dealing with unexpected technical debt and refuses to commit to a specific date.\n\nHow should the PM bridge this gap?",
        "difficulty": "foundational",
        "company": "Shopify",
        "context": "Marketing needs a date, Engineering won't commit",
        "correct": "C",
        "explanation": "Marketing needs predictability, while Engineering needs flexibility for unknowns. Providing a confidence-based range and a firm 'go/no-go' checkpoint gives Marketing enough info to prepare while protecting Engineering from a death march. Option A forces Engineering into a rigid date they didn't agree to. Option B alienates Marketing. Option D is dishonest and sets everyone up for failure.",
        "tags": ["managing_expectations", "engineering_alignment", "marketing_alignment"],
        "options": {
            "A": "Pick a date halfway between the best-case and worst-case scenarios and commit to it.",
            "B": "Tell Marketing they cannot run the campaign until the code is completely finished.",
            "C": "Provide a confidence-based date range and establish a 'go/no-go' deadline for the campaign.",
            "D": "Commit to Marketing's preferred date, then silently cut core features to hit it."
        }
    },
    {
        "title": "Netflix's Support Escalation",
        "scenario": "The Director of Customer Support at Netflix insists that Product must build an auto-reply feature for billing issues. The PM knows this is not on the roadmap and does not align with the strategy of fixing root-cause billing errors.\n\nHow should the PM say 'no'?",
        "difficulty": "foundational",
        "company": "Netflix",
        "context": "Rejecting a feature request from Support",
        "correct": "D",
        "explanation": "Saying 'no' requires validating the stakeholder's underlying pain (high ticket volume) while showing how the roadmap already addresses it (fixing the root cause). Agreeing to monitor metrics shows ongoing partnership. Option A is a blunt rejection that ruins relationships. Option B is a classic PM lie ('the backlog') that creates false hope. Option C abandons the product strategy.",
        "tags": ["saying_no", "backlog_management", "customer_support"],
        "options": {
            "A": "Say 'No, this does not align with our strategic priorities' and end the conversation.",
            "B": "Add it to the backlog to make the Director happy, knowing you will never build it.",
            "C": "Pause the current roadmap to quickly build the auto-reply feature to keep Support happy.",
            "D": "Validate their pain point, explain how current roadmap items address the root cause, and agree to monitor ticket volume."
        }
    },
    {
        "title": "Figma's New Engineering Manager",
        "scenario": "A PM at Figma gets a new Engineering Manager (EM) who is highly skeptical of Product. The EM constantly demands to see raw user interview transcripts before agreeing to any technical architecture.\n\nWhat is the best way to build trust with this EM?",
        "difficulty": "foundational",
        "company": "Figma",
        "context": "Building trust with a skeptical EM",
        "correct": "B",
        "explanation": "A skeptical EM usually wants to understand the 'why' behind product decisions. Transparently sharing frameworks and inviting them into the discovery process builds shared context and deep trust. Option A creates an adversarial 'stay in your lane' dynamic. Option C leads to analysis paralysis. Option D avoids the root issue of trust.",
        "tags": ["engineering_alignment", "building_trust", "discovery"],
        "options": {
            "A": "Remind the EM that Product defines the 'what' and Engineering defines the 'how'.",
            "B": "Share decision-making frameworks and invite the EM to sit in on upcoming user interviews.",
            "C": "Refuse to move forward until the EM has read every single user interview transcript.",
            "D": "Escalate to the Director of Engineering and request a more compliant EM."
        }
    },
    {
        "title": "Airbnb's Stakeholder Mapping",
        "scenario": "An Airbnb PM is starting a massive, highly controversial project to overhaul Host cancellation policies globally.\n\nWhat is the most critical first step in stakeholder management for this project?",
        "difficulty": "foundational",
        "company": "Airbnb",
        "context": "Starting a complex, high-stakes project",
        "correct": "A",
        "explanation": "For complex projects, the PM must proactively map out all cross-functional groups (Legal, Support, Comms, Policy) to understand their influence and interest early. Option B assumes the PM has all the answers without consulting experts. Option C limits input to engineering, ignoring vital business stakeholders. Option D is an anti-pattern; you don't build first and seek alignment later on controversial policies.",
        "tags": ["stakeholder_mapping", "project_kickoff", "cross_functional"],
        "options": {
            "A": "Identify all impacted cross-functional teams and map their influence to tailor an engagement plan.",
            "B": "Write a final PRD and send it to all executives for a one-time sign-off.",
            "C": "Focus solely on aligning the engineering team, as execution is the only thing that matters.",
            "D": "Build an MVP quietly and launch it as an A/B test before telling any stakeholders."
        }
    },
    {
        "title": "Discord's Escalation Path",
        "scenario": "A critical Discord Trust & Safety feature is delayed because the Data Science (DS) team hasn't delivered the required ML model. The DS manager keeps saying 'we are busy.'\n\nHow should the PM escalate this issue?",
        "difficulty": "foundational",
        "company": "Discord",
        "context": "Escalating a blocked cross-functional dependency",
        "correct": "B",
        "explanation": "Escalation should always be framed around the impact to the business goals, not personal complaints about a colleague. By presenting the impact on safety goals to a mutual leader, you force a prioritization decision. Option A is unprofessional. Option C makes the PM the bottleneck. Option D is weak and accepts failure without trying to resolve the resource constraint.",
        "tags": ["escalation", "cross_functional_dependencies", "trust_and_safety"],
        "options": {
            "A": "Send a company-wide email blaming the DS team for the delay.",
            "B": "Escalate to the mutual leader, framing the conversation around the impact to company safety goals.",
            "C": "Attempt to write the ML model yourself to prove it can be done quickly.",
            "D": "Accept the delay and tell the Trust & Safety team that the feature is cancelled."
        }
    },
    {
        "title": "DoorDash's Custom Sales Promise",
        "scenario": "A DoorDash Sales Rep promised a major restaurant chain a highly customized, white-label reporting dashboard by next month to close a $5M deal. This feature is nowhere on the Product roadmap.\n\nHow should the PM handle this?",
        "difficulty": "intermediate",
        "company": "DoorDash",
        "context": "Sales promised an un-roadmapped custom feature",
        "correct": "C",
        "explanation": "The PM must solve the immediate business problem ($5M at risk) without destroying the product architecture with custom code. Finding a manual workaround solves the short-term, while establishing a strict policy with Sales Leadership prevents this from recurring. Option A reinforces bad behavior. Option B loses a major deal unnecessarily. Option D is a hollow threat.",
        "tags": ["sales_product_alignment", "custom_requests", "roadmapping"],
        "options": {
            "A": "Drop the current roadmap and build the custom dashboard because revenue is king.",
            "B": "Refuse to build it and tell the Sales Rep they will have to lose the $5M deal.",
            "C": "Find a manual workaround for this client, then partner with Sales Leadership to enforce a 'no custom promises' policy.",
            "D": "Build the feature but threaten the Sales Rep that you will never do it again."
        }
    },
    {
        "title": "Amazon's PR/FAQ Buy-In",
        "scenario": "An Amazon PM is proposing a highly controversial new Prime benefit that will initially reduce margins but drive long-term lock-in. They need to get buy-in from skeptical SVPs.\n\nWhat is the most effective way to structure the PR/FAQ document?",
        "difficulty": "intermediate",
        "company": "Amazon",
        "context": "Getting buy-in for a controversial idea using a PR/FAQ",
        "correct": "A",
        "explanation": "At Amazon (and for PMs generally), the best way to disarm skeptics is to anticipate their exact arguments. The FAQ section should explicitly address the hardest questions (e.g., 'Won't this ruin our margins?') with data-backed answers. Option B avoids the hard questions, making it look like the PM hasn't done their homework. Option C is marketing fluff. Option D focuses purely on implementation, not strategic value.",
        "tags": ["pr_faq", "executive_buy_in", "objection_handling"],
        "options": {
            "A": "Clearly articulate customer value and use the FAQ to explicitly address the most likely executive objections regarding margins.",
            "B": "Focus the FAQ strictly on the technical architecture so executives know the engineering is sound.",
            "C": "Omit the margin reduction data to ensure the narrative focuses purely on the positive customer experience.",
            "D": "List all the features in bullet points and avoid mentioning potential risks to keep the tone positive."
        }
    },
    {
        "title": "Zoom's Passive-Aggressive Dependency",
        "scenario": "A PM at Zoom relies on another product team to build an API. The other PM initially agreed, but keeps missing deadlines, citing 'other shifting priorities' in status updates while avoiding direct communication.\n\nWhat is the best approach to resolve this?",
        "difficulty": "intermediate",
        "company": "Zoom",
        "context": "Handling passive resistance from another PM",
        "correct": "D",
        "explanation": "Passive-aggressive delays usually stem from unspoken resource constraints or misaligned incentives. A 1:1 conversation seeks to understand their reality and find a mutually beneficial path forward. Option A is an escalation that damages trust before attempting a peer resolution. Option B is passive. Option C is aggressive and counterproductive.",
        "tags": ["peer_management", "cross_functional_dependencies", "conflict_resolution"],
        "options": {
            "A": "Immediately escalate to their VP to force them to adhere to the original timeline.",
            "B": "Continue pushing your own team's work and hope the other team eventually delivers the API.",
            "C": "Call them out publicly in the next all-hands meeting for blocking your team.",
            "D": "Schedule a 1:1 to uncover their underlying resource constraints and redefine a mutually viable timeline."
        }
    },
    {
        "title": "GitHub's Mid-Project Pivot",
        "scenario": "A GitHub PM spent 2 months getting executive buy-in for a massive 6-month initiative. In month 2, a beta test definitively proves the core user hypothesis is completely wrong.\n\nHow should the PM handle the stakeholders?",
        "difficulty": "intermediate",
        "company": "GitHub",
        "context": "Communicating a pivot after securing buy-in",
        "correct": "A",
        "explanation": "Great PMs prioritize truth over ego. If data invalidates the hypothesis, the PM must proactively admit it, present the new data, and propose a pivot. This builds immense credibility. Option B is the sunk cost fallacy. Option C is deceptive and manipulative. Option D is weak and lacks leadership.",
        "tags": ["pivoting", "executive_communication", "sunk_cost_fallacy"],
        "options": {
            "A": "Proactively assemble stakeholders, present the invalidating data, and propose a pivoted strategy.",
            "B": "Push forward with the original plan because cancelling it now would cost too much political capital.",
            "C": "Slowly alter the project scope over the next 4 months so executives don't notice the pivot.",
            "D": "Wait for the executive sponsor to review the beta data and tell you what to do next."
        }
    },
    {
        "title": "HubSpot's Legal vs. Growth Conflict",
        "scenario": "HubSpot's Growth team wants to implement an auto-opt-in checkbox for marketing emails to boost conversions. The Legal team states this strictly violates GDPR and cannot be done.\n\nHow should the PM proceed?",
        "difficulty": "intermediate",
        "company": "HubSpot",
        "context": "Legal blocking a growth initiative",
        "correct": "B",
        "explanation": "Legal is not a blocker; they are a partner in risk management. The PM should accept the constraint (no auto-opt-in) and brainstorm alternative UX patterns (like compelling copy or explicit value props) that drive conversions while remaining legally compliant. Option A is illegal. Option C is combative. Option D abandons the Growth goal entirely.",
        "tags": ["legal_compliance", "growth_design", "stakeholder_collaboration"],
        "options": {
            "A": "Implement the auto-opt-in only for non-EU users without telling Legal.",
            "B": "Treat Legal as a partner and brainstorm alternative UX patterns that drive high opt-ins while strictly following GDPR.",
            "C": "Tell the Growth team that Legal is ruining the product and escalate to the CEO.",
            "D": "Abandon the opt-in initiative entirely and move on to a different project."
        }
    },
    {
        "title": "Tinder's Design vs. Eng Trade-off",
        "scenario": "Tinder's Lead Designer wants a fluid, complex 3D animation for a new matching feature. The Tech Lead says building it will delay the launch by 3 weeks and severely impact app load times on older Android devices.\n\nHow should the PM resolve this stakeholder conflict?",
        "difficulty": "intermediate",
        "company": "Tinder",
        "context": "Resolving a direct Design vs. Engineering conflict",
        "correct": "C",
        "explanation": "PMs resolve stalemates by bringing the focus back to the user and the North Star metrics. If the animation hurts load times (which hurts retention on Android), the PM must guide the team to a compromise that balances aesthetics with performance and timeline. Option A blindly follows Design. Option B blindly follows Engineering. Option D relies on executive fiat rather than team collaboration.",
        "tags": ["trade_offs", "design_eng_alignment", "performance"],
        "options": {
            "A": "Side with Design because a dating app relies entirely on premium aesthetics and user delight.",
            "B": "Side with Engineering because hitting the deadline is the only metric that matters to leadership.",
            "C": "Frame the decision around user impact, highlighting the Android performance hit, and facilitate a compromise on a simpler animation.",
            "D": "Let the two of them argue it out, and if they can't decide, escalate to the CPO."
        }
    },
    {
        "title": "LinkedIn's Bypassed PM",
        "scenario": "A LinkedIn Marketing Manager bypassed you (the PM) and directly direct-messaged an engineer to change the copy on a signup button. The engineer made the change, which inadvertently broke an ongoing A/B test.\n\nWhat is the appropriate action?",
        "difficulty": "intermediate",
        "company": "LinkedIn",
        "context": "A stakeholder bypassing the PM process",
        "correct": "B",
        "explanation": "The PM must address both sides of the bypass. First, educate the engineer on why the PM intake process exists (to protect things like A/B tests). Second, firmly align with the Marketing Manager on the correct process for future requests, ensuring they understand the negative impact of their bypass. Option A ignores the root cause. Option C is an overreaction. Option D addresses the stakeholder but ignores the engineer's complicity.",
        "tags": ["process_enforcement", "team_protection", "stakeholder_boundaries"],
        "options": {
            "A": "Fix the A/B test silently and don't mention it, to avoid causing drama with Marketing.",
            "B": "Educate the engineer on protecting tests, then firmly align with Marketing on the proper intake process.",
            "C": "Formally reprimand the engineer for taking unauthorized work and report the marketer to HR.",
            "D": "Tell Marketing they are banned from requesting copy changes for the rest of the quarter."
        }
    },
    {
        "title": "Pinterest's Vanity Executive Request",
        "scenario": "Pinterest's Chief Product Officer (CPO) saw a competitor launch 'Stories' and demands the team build it immediately. However, your data clearly shows users are begging for better search filtering, not Stories.\n\nHow do you handle the CPO's request?",
        "difficulty": "intermediate",
        "company": "Pinterest",
        "context": "Executive pushing a vanity feature against data",
        "correct": "D",
        "explanation": "When an executive pushes a vanity feature, flatly saying no is politically dangerous, but blindly executing is product negligence. Using the 'disagree and commit' framework—showing the opportunity cost with data, offering a low-cost test, and letting the exec make the final call—protects the product while respecting hierarchy. Option A is blind obedience. Option B is insubordination. Option C creates a bloated roadmap.",
        "tags": ["managing_up", "hippo", "disagree_and_commit"],
        "options": {
            "A": "Drop the search improvements and immediately begin building Stories.",
            "B": "Refuse the request entirely, citing the data as the ultimate authority.",
            "C": "Try to build both Stories and Search Filtering simultaneously to keep everyone happy.",
            "D": "Show the opportunity cost using data, propose a small timeboxed test of Stories, and let the CPO make the final call."
        }
    },
    {
        "title": "Duolingo's Bad News Delivery",
        "scenario": "A highly anticipated, heavily resourced gamification feature at Duolingo has just concluded its A/B test. The results are bad: it decreased Day 1 retention by 4%. You have a meeting with the exec team tomorrow.\n\nHow do you present this?",
        "difficulty": "intermediate",
        "company": "Duolingo",
        "context": "Presenting failed experiment results to executives",
        "correct": "A",
        "explanation": "Great PMs do not hide bad news. They report it objectively, accompanied by a deep analysis of *why* it failed and what the organization learned. This turns a failure into a strategic asset. Option B is deceptive data manipulation. Option C is defensive and unprofessional. Option D wastes time by not arriving with an analysis.",
        "tags": ["managing_up", "experimentation", "delivering_bad_news"],
        "options": {
            "A": "Report the negative result clearly, alongside a deep dive into why it failed and actionable learnings for the next iteration.",
            "B": "Focus the presentation on secondary metrics that went up, downplaying the drop in Day 1 retention.",
            "C": "Blame the engineering team for poor execution, suggesting the feature would have worked if built better.",
            "D": "Cancel the meeting until you can run a completely different test to show positive numbers."
        }
    },
    {
        "title": "Peloton's Hardware Dependency",
        "scenario": "Your software feature at Peloton requires integration with a new bike sensor. The Hardware team just announced they are 2 months behind schedule, meaning you cannot test your software on the actual device.\n\nHow do you manage this dependency?",
        "difficulty": "intermediate",
        "company": "Peloton",
        "context": "Managing a heavily delayed cross-functional dependency",
        "correct": "C",
        "explanation": "When a physical dependency is delayed, the PM must decouple the workflows. Using simulators allows the software team to continue making progress and de-risking the logic, while resetting expectations with leadership. Option A wastes software engineering capacity. Option B guarantees integration failures later. Option D is petty and unhelpful.",
        "tags": ["cross_functional_dependencies", "hardware_software", "unblocking_teams"],
        "options": {
            "A": "Pause all software development and put the engineers on a different project for 2 months.",
            "B": "Assume the hardware will work exactly as specced and launch the software without testing.",
            "C": "Decouple the workflows by using software simulators to test logic, and communicate the revised timeline to leadership.",
            "D": "Write an angry email to the Head of Hardware demanding they speed up their manufacturing."
        }
    },
    {
        "title": "Robinhood's Micromanager VP",
        "scenario": "A VP of Product at Robinhood wants to review every single Jira ticket, PRD comment, and UI copy string before the team is allowed to write code. This is causing a massive bottleneck.\n\nHow should the PM address this?",
        "difficulty": "intermediate",
        "company": "Robinhood",
        "context": "Handling a highly micromanaging executive",
        "correct": "B",
        "explanation": "Micromanagement usually stems from anxiety or lack of visibility. The PM should propose a new operating rhythm that provides the VP with the high-level assurance they need (e.g., weekly syncs, design sign-offs) while gently explaining how ticket-level reviews are blocking execution. Option A enables the bottleneck. Option C is passive-aggressive. Option D damages the relationship.",
        "tags": ["managing_up", "micromanagement", "process_improvement"],
        "options": {
            "A": "Accept the process and schedule 3 hours every day to review tickets with the VP.",
            "B": "Propose a new rhythm: offer high-level weekly syncs and design sign-offs, explaining how ticket review slows execution.",
            "C": "Stop writing Jira tickets entirely so there is nothing for the VP to review.",
            "D": "Tell the VP they are a micromanager and you refuse to participate in their process."
        }
    },
    {
        "title": "Booking.com's Late Requirement",
        "scenario": "Two weeks before a major Booking.com launch, the VP of Europe demands you add a complex multi-currency checkout flow. It would take 4 weeks to build.\n\nHow do you respond?",
        "difficulty": "intermediate",
        "company": "Booking.com",
        "context": "Stakeholder introducing massive scope creep right before launch",
        "correct": "B",
        "explanation": "Late-stage scope creep must be managed with absolute clarity on trade-offs. The PM must outline the cost (a 4-week delay) vs. the benefit, and strongly recommend launching V1 on time, slotting the new request into a fast-follow V2. Option A rewards scope creep. Option C is antagonistic. Option D ruins the codebase.",
        "tags": ["scope_creep", "launch_management", "trade_offs"],
        "options": {
            "A": "Delay the launch by 4 weeks to accommodate the VP's request.",
            "B": "Outline the 4-week delay cost, recommend launching V1 on time, and prioritize the currency flow for V2.",
            "C": "Ignore the request entirely because the PRD was signed off months ago.",
            "D": "Ask Engineering to hack together a buggy version in 2 weeks to appease the VP."
        }
    },
    {
        "title": "Canva's Competing North Stars",
        "scenario": "At Canva, Marketing insists the North Star Metric is 'New Signups'. Engineering insists it's 'System Uptime'. Product insists it's 'Successful Designs Exported'.\n\nHow do you align these disparate stakeholders?",
        "difficulty": "intermediate",
        "company": "Canva",
        "context": "Aligning different departments on a single North Star",
        "correct": "D",
        "explanation": "A true North Star metric represents core value delivery. The PM must facilitate an understanding that 'Designs Exported' is the leading indicator of long-term value, while acknowledging that Signups and Uptime are critical 'health metrics' or guardrails. Option A results in a lack of focus. Option B is dictatorial. Option C passes the buck.",
        "tags": ["north_star_metric", "alignment", "kpi_setting"],
        "options": {
            "A": "Create a blended formula that averages Signups, Uptime, and Exports together.",
            "B": "Declare that Product owns the metric and force everyone to adopt 'Designs Exported'.",
            "C": "Let the CEO decide the metric since the departments cannot agree.",
            "D": "Facilitate a workshop showing 'Designs Exported' as the core value, while tracking Signups and Uptime as crucial health metrics."
        }
    },
    {
        "title": "Twitter/X's Post-Mortem Trust",
        "scenario": "You pushed a feature at Twitter/X that caused a 2-hour site-wide outage. Stakeholders are furious and now demand to personally approve all of your future code releases.\n\nHow do you rebuild trust and regain autonomy?",
        "difficulty": "intermediate",
        "company": "Twitter",
        "context": "Rebuilding stakeholder trust after a massive failure",
        "correct": "C",
        "explanation": "Trust is rebuilt through extreme ownership and systemic improvement. Publishing a detailed post-mortem with actionable preventative measures, and asking for a short probationary period, proves you have learned from the mistake. Option A avoids responsibility. Option B accepts a permanent, inefficient bottleneck. Option D is arrogant.",
        "tags": ["trust_building", "post_mortem", "incident_management"],
        "options": {
            "A": "Blame the QA team for missing the bug and assure stakeholders it won't happen again.",
            "B": "Agree to their demands and let stakeholders approve all releases indefinitely.",
            "C": "Take extreme ownership, publish a detailed post-mortem with preventative steps, and ask for a probationary period.",
            "D": "Remind them that 'moving fast and breaking things' is standard industry practice."
        }
    },
    {
        "title": "Salesforce's Silent Blocker",
        "scenario": "The Enterprise Security Lead at Salesforce ignored all your project update emails and skipped all review meetings. The day before launch, they review the code, find a flaw, and block the release.\n\nHow do you handle the immediate situation and the long-term process?",
        "difficulty": "intermediate",
        "company": "Salesforce",
        "context": "Dealing with a stakeholder who ignores process but blocks at the end",
        "correct": "A",
        "explanation": "In enterprise SaaS, security is non-negotiable. You must delay the launch to fix the flaw. Long-term, you must fix the systemic issue by instituting a mandatory sign-off gate *early* in the process, forcing the 'silent' stakeholder to engage. Option B risks massive enterprise churn. Option C focuses on blame, not solutions. Option D is unrealistic.",
        "tags": ["enterprise_software", "security", "process_improvement"],
        "options": {
            "A": "Delay the launch to fix the flaw, then update project kickoffs to mandate explicit Security sign-off during the design phase.",
            "B": "Launch anyway, document the security flaw in the backlog, and fix it in sprint 2.",
            "C": "Escalate to the CEO, demanding the Security Lead be fired for missing meetings.",
            "D": "Force the engineering team to stay up all night to rewrite the entire security architecture."
        }
    },
    {
        "title": "Reddit's Community as Stakeholder",
        "scenario": "You are a PM at Reddit launching a new API pricing model. It will hit aggressive revenue goals but you know the power-user community and moderators will hate it.\n\nHow should you manage this unique stakeholder group?",
        "difficulty": "intermediate",
        "company": "Reddit",
        "context": "Managing highly vocal external user communities as stakeholders",
        "correct": "B",
        "explanation": "For community-driven products, power users are essentially external stakeholders. Briefing them early (even under NDA), validating their concerns, and giving them time to prepare is crucial for mitigating massive backlash. Option A guarantees a user revolt. Option C compromises company strategy. Option D is cowardly.",
        "tags": ["community_management", "external_stakeholders", "rollout_strategy"],
        "options": {
            "A": "Launch it silently on a Friday night to minimize initial media coverage.",
            "B": "Treat moderators as key stakeholders: brief them early, gather feedback, and let them prepare the community.",
            "C": "Cancel the feature completely; user happiness must always supersede revenue.",
            "D": "Create fake Reddit accounts to post positive comments about the pricing change."
        }
    },
    {
        "title": "Dropbox's Influence Without Authority",
        "scenario": "You are a PM at Dropbox. You desperately need the Infrastructure team to migrate a database for your new feature. You do not manage them, they are busy, and your feature is not in their OKRs.\n\nHow do you get them to do the work?",
        "difficulty": "intermediate",
        "company": "Dropbox",
        "context": "Gaining buy-in from a busy team you don't manage",
        "correct": "C",
        "explanation": "Influencing without authority requires understanding what the other person cares about. By understanding the Infra team's goals (like reducing tech debt or server costs) and framing your request in a way that helps *them* achieve *their* goals, you create a win-win. Option A relies on positional authority you don't have. Option B is bribery. Option D is whining.",
        "tags": ["influencing_without_authority", "cross_functional", "negotiation"],
        "options": {
            "A": "Tell them you are the PM and therefore the 'CEO of the product', so they must comply.",
            "B": "Offer to buy their team pizza if they stay late to do your migration.",
            "C": "Understand their team's OKRs and frame your database request in terms of how it helps reduce their technical debt.",
            "D": "Complain to your manager that the company culture is uncollaborative."
        }
    },
    {
        "title": "Instagram's Visionary Founder",
        "scenario": "You are presenting a new feed ranking algorithm to an Instagram founder who relies heavily on intuition and visibly tunes out during data-heavy, spreadsheet-driven presentations.\n\nHow should you adjust your stakeholder management style?",
        "difficulty": "intermediate",
        "company": "Instagram",
        "context": "Managing up to a highly intuitive, non-analytical executive",
        "correct": "D",
        "explanation": "Stakeholder management requires adapting to the audience. For a visionary, intuition-driven leader, you must lead with narrative, user experience, and prototypes. Data should be kept in the appendix or used only to back up the narrative, not as the primary communication vehicle. Option A is stubborn. Option B abandons the rigor of data entirely. Option C is condescending.",
        "tags": ["managing_up", "communication_styles", "visionary_leaders"],
        "options": {
            "A": "Force them to look at the spreadsheets; data is the only objective truth.",
            "B": "Stop analyzing data completely and just build whatever the founder intuitively feels is right.",
            "C": "Speak very slowly and explain basic statistical concepts so they can understand the data.",
            "D": "Lead with a compelling user narrative and visual prototypes, using data subtly to back up the story."
        }
    },
    {
        "title": "Stripe's Executive Risk Disagreement",
        "scenario": "Stripe is expanding into a complex new market. The Head of Legal demands a 0% compliance risk approach (takes 2 years to build). The Head of Growth demands a launch in 3 months, arguing the revenue will outpace any regulatory fines.\n\nAs the PM, how do you resolve this advanced standoff?",
        "difficulty": "advanced",
        "company": "Stripe",
        "context": "Resolving fundamental disagreements on company risk appetite",
        "correct": "C",
        "explanation": "When C-level executives fundamentally disagree on the company's risk appetite, a PM cannot resolve it via compromise. The PM must construct a tiered risk framework (quantifying the exact cost of fines vs. revenue) and escalate to the CEO/Board, as defining corporate risk tolerance is a CEO-level duty. Option A sides with Growth recklessly. Option B sides with Legal conservatively. Option D relies on a meaningless average.",
        "tags": ["risk_management", "executive_escalation", "strategic_alignment"],
        "options": {
            "A": "Side with Growth; moving fast and breaking things is essential in fintech.",
            "B": "Side with Legal; compliance is paramount and cannot be risked.",
            "C": "Model the financial scenarios (fines vs revenue) for 3 tiers of risk, and escalate to the CEO for a definitive ruling on company risk appetite.",
            "D": "Compromise by launching in 1 year, cutting the difference down the middle."
        }
    },
    {
        "title": "WhatsApp's Global vs. Local Priorities",
        "scenario": "The WhatsApp India GM desperately needs a low-bandwidth text feature to capture rural users. The WhatsApp US GM needs high-fidelity video reactions to combat iMessage. You only have engineering capacity for one.\n\nHow do you align these stakeholders?",
        "difficulty": "advanced",
        "company": "WhatsApp",
        "context": "Prioritizing across vastly different global market needs",
        "correct": "B",
        "explanation": "In global organizations, comparing raw numbers (India MAU vs US Revenue) often leads to stalemates. The PM must tie the decision back to the company's macro-narrative for the year (e.g., is this the year of 'Next Billion Users' or 'Mature Market Monetization'?). Option A reduces strategy to a simple math problem, ignoring strategic intent. Option C is a political cop-out. Option D results in two half-baked features.",
        "tags": ["global_strategy", "prioritization", "strategic_narrative"],
        "options": {
            "A": "Calculate the projected ARR of both features and simply pick the highest number.",
            "B": "Base the decision on the company's stated macro-narrative for the year (e.g., 'Next Billion Users' vs 'Defending US Market Share').",
            "C": "Tell the two GMs to debate it and get back to you when one of them concedes.",
            "D": "Split the engineering team in half and attempt to build V1s of both features simultaneously."
        }
    },
    {
        "title": "Uber's Unilateral Decision",
        "scenario": "A cross-functional group of 5 Uber stakeholders (Ops, Pricing, Eng, Data, Product) have been locked in analysis paralysis for 4 weeks over a minor change to the surge pricing algorithm. No consensus is in sight.\n\nWhat is the strongest leadership move for the PM?",
        "difficulty": "advanced",
        "company": "Uber",
        "context": "Breaking analysis paralysis when consensus fails",
        "correct": "A",
        "explanation": "Consensus is a tool, not a religion. When consensus fails and causes paralysis, a senior PM must step up, declare the debate over, make a unilateral decision based on the best available data, and take full accountability for the outcome. Option B prolongs the paralysis. Option C introduces a new, uninvested decision-maker. Option D is weak and avoids making a choice.",
        "tags": ["decision_making", "breaking_consensus", "accountability"],
        "options": {
            "A": "Declare that consensus has failed, make a unilateral decision based on data, and take full accountability for the results.",
            "B": "Schedule another 4 weeks of meetings to ensure everyone feels heard before deciding.",
            "C": "Bring in a 6th stakeholder from outside the project to act as a tie-breaker.",
            "D": "Cancel the project since the team cannot reach an agreement."
        }
    },
    {
        "title": "Airbnb's Lost Executive Sponsor",
        "scenario": "You are 6 months into a 12-month platform rewrite at Airbnb. The VP who sponsored the project suddenly leaves the company. The new VP thinks the rewrite is a 'waste of time' and wants to kill it.\n\nHow do you save the project?",
        "difficulty": "advanced",
        "company": "Airbnb",
        "context": "Managing the loss of an executive sponsor mid-project",
        "correct": "D",
        "explanation": "A new executive has new priorities. You cannot rely on the old VP's mandate. You must pause, understand what the new VP cares about (e.g., conversion rates, speed to market), and re-pitch the technical rewrite entirely in terms of the new VP's business goals to secure renewed sponsorship. Option A relies on obsolete authority. Option B is deceptive. Option C gives up too easily.",
        "tags": ["executive_sponsorship", "managing_up", "change_management"],
        "options": {
            "A": "Remind the new VP that the old VP already approved the budget, so they cannot cancel it.",
            "B": "Hide the project budget under a different initiative so the new VP doesn't notice it.",
            "C": "Agree with the new VP immediately and throw away 6 months of engineering work.",
            "D": "Repackage the platform's technical progress into the specific business value metrics the new VP cares about and re-pitch it."
        }
    },
    {
        "title": "Shopify's Systemic Misalignment",
        "scenario": "Shopify's Product strategy is moving aggressively toward standardized, self-serve SaaS. However, the Sales team is compensated heavily on selling customized, bespoke enterprise implementations, leading them to constantly demand custom features.\n\nHow do you resolve this?",
        "difficulty": "advanced",
        "company": "Shopify",
        "context": "Identifying and escalating systemic incentive misalignments",
        "correct": "B",
        "explanation": "This is a systemic organizational issue, not a standard product requirement conflict. People do what they are paid to do. The PM must recognize the misaligned incentive structure and escalate to the highest levels (CRO/CPO) to align the sales compensation model with the new product strategy. Option A treats a systemic issue as a series of tactical arguments. Option C subverts the company strategy. Option D ignores the root cause.",
        "tags": ["incentive_structures", "sales_alignment", "organizational_design"],
        "options": {
            "A": "Argue with the Sales team on a feature-by-feature basis every week.",
            "B": "Recognize this as a systemic incentive problem and escalate to the CRO and CPO to realign the sales compensation model.",
            "C": "Change the product strategy back to customized enterprise software to support the Sales team.",
            "D": "Refuse all meetings with Sales until they stop asking for custom features."
        }
    },
    {
        "title": "Figma's Strategic Concession",
        "scenario": "A powerful, tenured executive at Figma is adamant about adding a confusing dropdown to your core UI. You know it's bad UX. However, next month you need this exact executive's support to approve a massive, risky architectural change.\n\nWhat is the most strategic move?",
        "difficulty": "advanced",
        "company": "Figma",
        "context": "Making calculated trade-offs for long-term political capital",
        "correct": "C",
        "explanation": "Senior PMs play the long game. Sometimes, you must lose a small battle (a bad dropdown) to win the war (a massive architectural change). Making a calculated concession builds political capital with the executive, ensuring their support when you need it most. Option A wins the battle but loses the war. Option B is passive-aggressive. Option D is unethical.",
        "tags": ["political_capital", "strategic_concessions", "managing_up"],
        "options": {
            "A": "Fight the executive to the death over the dropdown to protect the UX at all costs.",
            "B": "Build the dropdown but make it completely hidden so users can't find it.",
            "C": "Concede on the dropdown as a calculated trade-off to build political capital for the upcoming architectural vote.",
            "D": "Tell the executive you will build it, but secretly tell engineering to ignore the ticket."
        }
    },
    {
        "title": "Netflix's Board-Level Metric Conflict",
        "scenario": "The Netflix Board of Directors demands a 10% increase in 'Minutes Watched' next quarter. Your data science team models out the required changes (more clickbait, autoplaying trailers) and proves this will cannibalize 12-month subscriber retention.\n\nHow do you handle this executive directive?",
        "difficulty": "advanced",
        "company": "Netflix",
        "context": "Pushing back on harmful Board-level directives with data",
        "correct": "B",
        "explanation": "Blindly following a flawed metric directive from a Board destroys long-term company value. A senior PM must partner with Data Science to create a compelling visualization showing how optimizing the short-term proxy metric ('Minutes') destroys the ultimate North Star (LTV/Retention), and propose a healthier alternative. Option A blindly destroys value. Option C is insubordinate. Option D is deceptive.",
        "tags": ["executive_alignment", "metric_cannibalization", "data_storytelling"],
        "options": {
            "A": "Execute the clickbait features immediately; Board directives cannot be questioned.",
            "B": "Present a unified case with Data Science showing the LTV destruction, and propose a healthier proxy metric to the C-suite.",
            "C": "Send an email directly to the Board of Directors explaining why they are wrong.",
            "D": "Fake the 'Minutes Watched' data on the next quarterly report to protect retention."
        }
    }
]

# Ensure we have 35 questions. I have 35 now. Wait, let me count.
# I have exactly 35. I will duplicate or add more if needed.
# Let's count them: 35 dicts. Wait, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35. Let me check the exact count.
import os

sql_template = """-- ============================================
-- ASSESSMENT: Stakeholder Management
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
    WHERE slug = 'stakeholder-management';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug stakeholder-management not found. Run the seed data first.';
    END IF;
"""

def escape_sql_string(s):
    return s.replace("'", "''")

def format_tags(tags):
    return "ARRAY[" + ", ".join(f"'{escape_sql_string(t)}'" for t in tags) + "]"

for i, q in enumerate(questions):
    q_num = i + 1
    
    # We use E-string for scenario to handle newlines
    scenario_escaped = escape_sql_string(q['scenario']).replace('\n', '\\n')
    
    sql_template += f"""
    -- ----------------------------------------
    -- QUESTION {q_num} ({q['difficulty'].capitalize()})
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        {q_num},
        '{escape_sql_string(q['title'])}',
        E'{scenario_escaped}',
        '{q['difficulty']}',
        '{escape_sql_string(q['company'])}',
        '{escape_sql_string(q['context'])}',
        '{q['correct']}',
        '{escape_sql_string(q['explanation'])}',
        {format_tags(q['tags'])}
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
"""
    options_sql = []
    for label in ['A', 'B', 'C', 'D']:
        is_correct = 'true' if label == q['correct'] else 'false'
        opt_text = escape_sql_string(q['options'][label])
        options_sql.append(f"    (v_q_id, '{label}', '{opt_text}', {is_correct})")
    
    sql_template += ",\n".join(options_sql) + ";\n"

sql_template += """
    RAISE NOTICE 'Successfully inserted 35 questions for Stakeholder Management';

END $$;
"""

with open('/Users/chirag/Startups/Assesments/sql/31_leadership_stakeholder_management.sql', 'w') as f:
    f.write(sql_template)
print("File generated successfully!")
