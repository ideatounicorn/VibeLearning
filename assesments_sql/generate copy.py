import json

questions = [
    {
        "num": 1,
        "title": "Spotify's Feature Kickoff",
        "scenario": "Spotify is kicking off a new collaborative playlist feature. The PM, Engineering Lead, and Product Designer are in the first planning meeting. The designer immediately starts sketching wireframes while the engineering lead discusses database schema changes. As the PM, what is the most critical cross-functional alignment action to take right now?",
        "difficulty": "foundational",
        "company": "Spotify",
        "context": "Consumer audio streaming",
        "correct": "C",
        "explanation": "The primary role of a PM in early cross-functional alignment is establishing the 'why' (goals, user problem) and 'what' (scope, success metrics). Option C correctly anchors the team on the user problem and goals before solutioning. Option A is premature optimization. Option B is micromanagement. Option D is a project management task that should follow goal alignment.",
        "tags": ["kickoff", "role_clarity", "alignment"],
        "options": {
            "A": "Pause them and create a detailed RACI matrix to ensure no overlapping responsibilities during the project.",
            "B": "Instruct the designer to stop sketching and focus on writing user stories with you instead.",
            "C": "Steer the conversation back to aligning on the target user, the specific problem being solved, and the success metrics.",
            "D": "Open a Jira board and immediately start creating epics to capture their technical and design ideas."
        }
    },
    {
        "num": 2,
        "title": "Uber's Legal Translation",
        "scenario": "Uber's Legal team mandates that a new driver background check disclosure must be shown in the app within 2 weeks due to a new state law. The Legal team provides a 5-page PDF of dense legal text. How should the PM best handle this cross-functional handoff to Engineering and Design?",
        "difficulty": "foundational",
        "company": "Uber",
        "context": "Rideshare marketplace",
        "correct": "B",
        "explanation": "A key PM cross-functional skill is 'translating' between domains. Option B shows the PM extracting the functional requirements for Design/Eng while maintaining the core compliance need. Option A abdicates the PM responsibility, leading to poor UX. Option C is risky because PMs shouldn't rewrite legal text unilaterally. Option D is unnecessarily confrontational and ignores the compliance mandate.",
        "tags": ["legal_compliance", "translation", "stakeholder_management"],
        "options": {
            "A": "Attach the PDF to a Jira ticket and assign it to the frontend engineering lead to implement as a scrollable text box.",
            "B": "Extract the specific constraints (e.g., must be a forced-scroll, explicit opt-in button) and brief Design to create a compliant but user-friendly flow.",
            "C": "Rewrite the legal text to be concise and user-friendly, then send it directly to Engineering to implement.",
            "D": "Push back on Legal, explaining that 5 pages of text violates Uber's design principles, and refuse to build it until it's shortened."
        }
    },
    {
        "num": 3,
        "title": "Slack's Launch Timeline Conflict",
        "scenario": "Slack is launching a new 'Huddles' feature. Product Marketing (PMM) has secured a major TechCrunch exclusive for October 15th. On October 1st, Engineering informs the PM that a critical edge-case bug will take until October 18th to fix. What is the best cross-functional approach to resolve this?",
        "difficulty": "foundational",
        "company": "Slack",
        "context": "B2B SaaS communication",
        "correct": "D",
        "explanation": "Cross-functional tradeoffs require evaluating risk vs. reward with all context. Option D brings the right stakeholders together to make an informed business decision (launch with known bug, descale, or delay PR). Option A assumes Eng makes business decisions. Option B assumes PR trumps product quality without discussion. Option C is dishonest and damages trust.",
        "tags": ["gtm_alignment", "launch_readiness", "tradeoffs"],
        "options": {
            "A": "Tell Marketing they must delay the PR piece to October 18th because Engineering owns the release criteria.",
            "B": "Tell Engineering to skip the bug fix and launch anyway, as PR commitments cannot be broken.",
            "C": "Hide the bug from Marketing so they don't panic, and ask Engineering to work weekends to finish it secretly.",
            "D": "Facilitate a meeting with Eng and PMM to assess the bug's severity vs. the cost of moving the PR date, and jointly agree on a tradeoff."
        }
    },
    {
        "num": 4,
        "title": "Airbnb's Pixel Perfection",
        "scenario": "An Airbnb product squad is building a new booking flow. The Lead Designer is frustrated because the Engineering team's implementation is missing subtle animations and the padding is off by a few pixels. Engineering says fixing it will delay the launch by a week. How should the PM intervene?",
        "difficulty": "foundational",
        "company": "Airbnb",
        "context": "Travel marketplace",
        "correct": "C",
        "explanation": "The PM's role is to mediate conflicts by anchoring on user value and business impact. Option C evaluates whether the design details actually impact the goal, allowing for a rational prioritization decision. Option A blindly favors speed. Option B blindly favors design. Option D introduces unnecessary process overhead for a simple alignment issue.",
        "tags": ["design_eng_alignment", "prioritization", "conflict_resolution"],
        "options": {
            "A": "Side with Engineering; shipping fast is always more important than pixel-perfect design.",
            "B": "Side with Design; Airbnb's brand relies on premium aesthetics, so the launch must be delayed.",
            "C": "Assess with both teams if the missing polish impacts usability or core metrics, and decide whether it's a launch blocker or a fast-follow.",
            "D": "Require the Designer and Engineer to write a joint memo explaining their disagreement to the VP of Product."
        }
    },
    {
        "num": 5,
        "title": "Shopify's Customer Escalation",
        "scenario": "A Shopify Customer Success Manager (CSM) constantly messages a PM directly on Slack, bypassing the standard Jira intake process to demand immediate bug fixes for their largest enterprise merchant. The PM's engineering team is getting distracted. What is the best action for the PM?",
        "difficulty": "foundational",
        "company": "Shopify",
        "context": "E-commerce platform",
        "correct": "B",
        "explanation": "Establishing and enforcing cross-functional processes is key to protecting the team's focus. Option B addresses the behavior directly but empathetically, explaining the 'why' behind the process. Option A rewards the bad behavior. Option C is unnecessarily hostile. Option D is passive-aggressive and damages the relationship.",
        "tags": ["process_enforcement", "stakeholder_management", "customer_success"],
        "options": {
            "A": "Log the bugs in Jira on the CSM's behalf to ensure the engineers see them without breaking process.",
            "B": "Have a 1:1 with the CSM to explain how direct messaging bypasses triage and hurts the team's ability to prioritize effectively, and enforce the Jira process.",
            "C": "Escalate the CSM to the VP of Customer Success for violating the product development protocol.",
            "D": "Ignore the Slack messages completely until the CSM realizes they need to use the proper channels."
        }
    },
    {
        "num": 6,
        "title": "Notion's Data Instrumentation",
        "scenario": "Notion is releasing a new block type. The PM asks the Data Analyst to build a dashboard for launch. The Analyst replies, 'The engineers didn't add any telemetry to this feature, so I have no data to query.' The engineers say, 'Telemetry wasn't in the PRD.' Where did the cross-functional process fail?",
        "difficulty": "foundational",
        "company": "Notion",
        "context": "Productivity SaaS",
        "correct": "C",
        "explanation": "Data requirements are product requirements. Option C correctly identifies that the PM failed to include data/analytics as a cross-functional requirement during the planning and spec phase. Option A blames the engineers for the PM's omission. Option B misunderstands the Analyst's role. Option D implies telemetry is optional.",
        "tags": ["data_alignment", "prd", "requirements_gathering"],
        "options": {
            "A": "Engineering failed to proactively add telemetry, which is a standard engineering best practice.",
            "B": "The Data Analyst failed to review the engineering code to ensure their data needs were met.",
            "C": "The PM failed to define tracking requirements and include the Data Analyst during the planning and spec phase.",
            "D": "The process didn't fail; telemetry should be a post-launch fast-follow to ensure launch speed."
        }
    },
    {
        "num": 7,
        "title": "Stripe's Engineering Pushback",
        "scenario": "A Stripe PM wants to build a new payment reconciliation dashboard. The Engineering Lead pushes back, stating the current backend architecture can't support the real-time data the PM is asking for without a 3-month refactor. What is the best immediate response?",
        "difficulty": "foundational",
        "company": "Stripe",
        "context": "Fintech payment infrastructure",
        "correct": "B",
        "explanation": "When facing technical constraints, great PMs negotiate scope by focusing on the underlying user need rather than the specific solution. Option B seeks a compromise that delivers value without the massive cost. Option A ignores the technical reality. Option C gives up too easily. Option D forces an engineering decision without PM context.",
        "tags": ["technical_constraints", "scope_negotiation", "eng_alignment"],
        "options": {
            "A": "Insist that real-time data is a hard requirement and escalate to the VP of Engineering to secure the 3-month timeline.",
            "B": "Ask the Engineering Lead if a slightly delayed data sync (e.g., hourly batches) would solve the user need while avoiding the 3-month refactor.",
            "C": "Cancel the dashboard project since the technical cost is too high to justify the feature.",
            "D": "Ask the Engineering Lead to design the dashboard UI since they know the backend constraints best."
        }
    },
    {
        "num": 8,
        "title": "DoorDash's Marketing Disconnect",
        "scenario": "DoorDash is launching a new 'DashPass for Students' tier. One week before launch, the PM sees the Marketing team's draft email campaign. It promises 'Free delivery on all restaurants,' but the product only supports free delivery on 'Eligible restaurants.' What should the PM do?",
        "difficulty": "foundational",
        "company": "DoorDash",
        "context": "Food delivery marketplace",
        "correct": "A",
        "explanation": "PMs must ensure GTM materials accurately reflect the product to avoid user trust issues and legal risks. Option A addresses the discrepancy immediately to prevent false advertising. Option B is technically impossible in a week. Option C hopes the problem goes away. Option D creates a terrible user experience.",
        "tags": ["gtm_alignment", "marketing", "launch_readiness"],
        "options": {
            "A": "Immediately contact Marketing to correct the copy to 'Eligible restaurants' to avoid false advertising and user frustration.",
            "B": "Tell Engineering they must urgently update the product to support 'All restaurants' to match the Marketing copy.",
            "C": "Let the email go out; the terms of service in the app will legally cover the 'Eligible restaurants' restriction.",
            "D": "Ask Design to make the 'Eligible' badge very small in the app so users don't notice the discrepancy."
        }
    },
    {
        "num": 9,
        "title": "Figma's Sales Enablement",
        "scenario": "Figma's Enterprise Sales team is struggling to sell a new advanced security feature because they don't understand how it works technically. They keep asking the PM to jump on sales calls. The PM is overwhelmed with calls. What is the most scalable cross-functional solution?",
        "difficulty": "foundational",
        "company": "Figma",
        "context": "Collaborative design software",
        "correct": "C",
        "explanation": "PMs must enable Sales scalably, not become a permanent crutch. Option C creates reusable assets and trains the trainers (Sales Enablement), fixing the root cause. Option A doesn't solve the immediate problem. Option B scales poorly and distracts Eng. Option D is an unsustainable hero complex.",
        "tags": ["sales_enablement", "scalability", "cross_functional_communication"],
        "options": {
            "A": "Tell the Sales team to read the technical API documentation on the developer portal.",
            "B": "Assign an Engineer to join the sales calls instead, as they understand the technical details better.",
            "C": "Partner with Product Marketing to create a comprehensive sales playbook, battle cards, and host a live training session for the Sales team.",
            "D": "Continue taking the calls; being the primary technical salesperson is a core part of the Enterprise PM role."
        }
    },
    {
        "num": 10,
        "title": "Amazon's Ops Alignment",
        "scenario": "An Amazon PM is launching a new digital feature that allows Prime members to request a specific 2-hour delivery window. The digital experience is built, but the PM hasn't spoken to the fulfillment center operations team. Why is this a critical failure?",
        "difficulty": "foundational",
        "company": "Amazon",
        "context": "E-commerce and logistics",
        "correct": "C",
        "explanation": "In operations-heavy companies, digital features often have physical constraints. Option C identifies that a digital button is useless if the physical world cannot fulfill the promise. Option A is false (Ops is heavily involved). Option B is a secondary concern compared to capability. Option D relies on a mechanism that Ops must build/support.",
        "tags": ["ops_alignment", "physical_digital_bridge", "dependency_management"],
        "options": {
            "A": "Fulfillment center teams typically report to Product, so they should have been in the daily standups.",
            "B": "The Operations team needs to approve the UI design of the delivery window selector.",
            "C": "The digital feature creates a real-world operational requirement; if Ops isn't staffed or equipped for precise windows, the feature will fail completely.",
            "D": "Operations needs to know so they can manually email customers if the 2-hour window is missed."
        }
    },
    {
        "num": 11,
        "title": "Netflix's ML Integration",
        "scenario": "A Netflix PM is overseeing a new recommendation UI. The Data Science (DS) team has built a highly accurate model, but it takes 1.5 seconds to return results. The Frontend Engineering (FE) team says this violates the 300ms latency SLA for rendering the homepage. How should the PM navigate this?",
        "difficulty": "intermediate",
        "company": "Netflix",
        "context": "Streaming media",
        "correct": "B",
        "explanation": "Cross-functional PMs must facilitate trade-offs between accuracy (DS) and performance (FE). Option B explores caching or async loading, solving both needs (accuracy + perceived performance). Option A ignores the UX impact. Option C ignores the DS value. Option D relies on a potentially impossible mandate.",
        "tags": ["data_science", "engineering", "latency_vs_accuracy", "tradeoffs"],
        "options": {
            "A": "Tell FE to accept the 1.5s latency because recommendation accuracy is the primary driver of retention.",
            "B": "Facilitate a discussion between DS and FE to explore caching strategies, pre-computing recommendations, or using UI skeleton states.",
            "C": "Tell DS to scrap the model and use a simpler, less accurate algorithm that returns in 200ms.",
            "D": "Dictate that DS must optimize their model to 300ms by next week, regardless of how they do it."
        }
    },
    {
        "num": 12,
        "title": "Shopify's Matrix Conflict",
        "scenario": "A PM on Shopify's 'Checkout' team wants to use a new, faster UI framework. However, the 'Platform' team mandates that all teams use the older, standardized internal UI library to maintain global consistency. The Checkout PM knows the new framework will increase conversion by 2%. What is the best approach?",
        "difficulty": "intermediate",
        "company": "Shopify",
        "context": "E-commerce platform",
        "correct": "D",
        "explanation": "Matrix orgs require navigating platform standards vs. local team goals. Option D shows structural negotiation—partnering with the platform team to prove value and potentially update the standard for everyone, rather than going rogue or giving up. Option A creates massive technical debt. Option C is passive. Option B escalates prematurely.",
        "tags": ["matrix_organization", "platform_vs_product", "negotiation"],
        "options": {
            "A": "Secretly build the checkout feature using the new framework; it's easier to ask forgiveness than permission.",
            "B": "Escalate immediately to the CEO to force the Platform team to make an exception for Checkout.",
            "C": "Abandon the new framework and accept the lower conversion rate to comply with Platform standards.",
            "D": "Propose an A/B test with the new framework to the Platform team, using the data to justify either an exception or upgrading the global standard."
        }
    },
    {
        "num": 13,
        "title": "GitHub's Misaligned Incentives",
        "scenario": "GitHub's Enterprise PM team is mandated to increase paid seat licenses (Sales-driven OKR). Meanwhile, the Open Source community PM team is mandated to remove friction for free collaborative projects (Growth-driven OKR). A proposed feature limits repository collaborators for free users. How should the cross-functional PM group resolve this?",
        "difficulty": "intermediate",
        "company": "GitHub",
        "context": "Developer tooling platform",
        "correct": "C",
        "explanation": "Conflicting OKRs between product lines require elevating the discussion to company-level strategy. Option C frames the conflict correctly as a strategic trade-off, not a localized squabble. Option A relies on false compromise. Option B makes the user experience chaotic. Option D assumes one team's OKRs inherently trump the other's without executive alignment.",
        "tags": ["okr_conflict", "portfolio_management", "strategic_alignment"],
        "options": {
            "A": "Compromise by limiting free collaborators, but making the limit high enough that it barely affects anyone.",
            "B": "A/B test the limitation on 50% of users to see which team's metric improves more.",
            "C": "Escalate the structural conflict to Product Leadership to clarify the company's macro-prioritization between Enterprise revenue and Open Source market share.",
            "D": "The Enterprise PM should override the Open Source PM, as revenue-generating features always take precedence."
        }
    },
    {
        "num": 14,
        "title": "Discord's Trust & Safety Block",
        "scenario": "A Discord Growth PM is launching a one-click server creation flow. Two days before launch, Trust & Safety (T&S) blocks the release, citing a high risk of spam bot proliferation. The Growth PM's OKR depends on this launch. What is the most constructive step?",
        "difficulty": "intermediate",
        "company": "Discord",
        "context": "Community communication platform",
        "correct": "B",
        "explanation": "T&S and Growth often conflict. Good PMs treat T&S as a partner, not a blocker. Option B collaboratively seeks a solution (rate limits/captchas) that satisfies T&S guardrails while preserving most of the Growth goal. Option A is reckless. Option C is defeatist. Option D wastes time arguing rather than problem-solving.",
        "tags": ["trust_and_safety", "growth", "risk_mitigation"],
        "options": {
            "A": "Launch anyway; Growth OKRs are paramount, and T&S can clean up the spam bots later.",
            "B": "Work with T&S to define acceptable risk thresholds and implement fast-follow mitigations like rate-limiting or CAPTCHAs for suspicious IPs.",
            "C": "Cancel the launch and miss the OKR, acknowledging that T&S has ultimate veto power.",
            "D": "Demand T&S provide concrete proof that spam bots will increase before accepting their block."
        }
    },
    {
        "num": 15,
        "title": "Airbnb's Local Market Launch",
        "scenario": "Airbnb is launching 'Experiences' in Tokyo. The PM needs alignment from Product, Local Ops, Legal, and Marketing. Ops says they need 3 months to onboard hosts. Marketing wants to announce in 1 month during a major festival. Engineering says the app localization takes 2 months. How should the PM sequence this?",
        "difficulty": "intermediate",
        "company": "Airbnb",
        "context": "Travel marketplace",
        "correct": "D",
        "explanation": "Complex cross-functional launches require identifying the critical path and aligning all functions around reality, not desire. Option D correctly identifies Ops as the long pole (3 months) and forces Marketing to align with the actual delivery date. Option A creates a disastrous user experience. Option B is a disjointed launch. Option C ignores engineering constraints.",
        "tags": ["launch_sequencing", "critical_path", "gtm_alignment"],
        "options": {
            "A": "Launch the Marketing campaign in 1 month, let users download the unlocalized app, and tell Ops to rush onboarding.",
            "B": "Let Marketing launch in 1 month, Engineering in 2 months, and Ops in 3 months so each team hits their own goals.",
            "C": "Force Ops to finish in 1 month to meet the Marketing deadline, regardless of host quality.",
            "D": "Identify Ops (3 months) as the critical path, align all teams to a single launch date in 3 months, and ask Marketing to pivot their campaign."
        }
    },
    {
        "num": 16,
        "title": "Spotify's Hardware Integration",
        "scenario": "Spotify is building software for a new partner smartwatch. The external hardware partner operates on a strict waterfall schedule with a 6-month code freeze prior to manufacturing. The Spotify agile software squad is used to weekly sprints and CI/CD. How does the PM manage this impedance mismatch?",
        "difficulty": "intermediate",
        "company": "Spotify",
        "context": "Audio streaming",
        "correct": "C",
        "explanation": "Integrating agile software with waterfall hardware requires hybrid planning. Option C bridges the gap by mapping agile milestones to the hardware's rigid milestones (code freeze). Option A is impossible for the hardware partner. Option B destroys the software team's velocity. Option D creates massive integration risk at the end.",
        "tags": ["agile_vs_waterfall", "partner_management", "process_adaptation"],
        "options": {
            "A": "Force the hardware partner to adopt two-week sprints so they align with the software squad's cadence.",
            "B": "Switch the software squad to a 6-month waterfall process to perfectly mirror the partner.",
            "C": "Maintain software sprints, but establish a cross-functional milestone roadmap that aligns specific software deliverables to the partner's rigid integration and freeze dates.",
            "D": "Let the software squad work independently and hand over the code one week before the hardware partner's manufacturing date."
        }
    },
    {
        "num": 17,
        "title": "Slack's Executive Swoop",
        "scenario": "During a sprint, the CEO of Slack directly messages an engineer, bypassing the PM, asking them to immediately change the color of the notification badge because 'it feels off.' The engineer drops their planned sprint work to do this. How should the PM handle this cross-functional disruption?",
        "difficulty": "intermediate",
        "company": "Slack",
        "context": "B2B SaaS",
        "correct": "C",
        "explanation": "Executive swooping destroys team focus. The PM must shield the team while managing up. Option C addresses the engineer's reaction (coaching them on process) and manages the CEO (redirecting requests through the PM). Option A is passive. Option B is overly confrontational. Option D ignores the process breakdown.",
        "tags": ["executive_management", "sprint_protection", "communication_channels"],
        "options": {
            "A": "Accept that the CEO has ultimate authority and adjust the sprint backlog to accommodate the lost time.",
            "B": "Publicly call out the CEO in the #general channel for breaking sprint protocol and distracting the team.",
            "C": "Privately ask the engineer to route future executive requests to you, and sync with the CEO to understand the context and funnel requests through the backlog.",
            "D": "Tell the engineer to revert the code change immediately until the CEO writes a PRD for the color change."
        }
    },
    {
        "num": 18,
        "title": "Stripe's API Versioning Dilemma",
        "scenario": "Stripe is deprecating an old API. Core Engineering wants to shut it down in 30 days to remove tech debt. Developer Relations (DevRel) says merchants need at least 6 months to migrate or Stripe will face massive churn. As the PM, how do you resolve this?",
        "difficulty": "intermediate",
        "company": "Stripe",
        "context": "Developer API / Fintech",
        "correct": "D",
        "explanation": "Deprecating APIs is a high-stakes cross-functional negotiation between Eng efficiency and customer impact. Option D uses data to bridge the gap, targeting the timeline based on actual migration difficulty rather than arbitrary dates. Option A ignores customer pain. Option B ignores engineering costs. Option C assumes a false dichotomy.",
        "tags": ["deprecation", "devrel", "engineering_alignment", "data_driven"],
        "options": {
            "A": "Side with Engineering; 30 days is standard, and merchants who don't migrate are acceptable churn.",
            "B": "Side with DevRel; the API must be supported indefinitely to ensure zero churn.",
            "C": "Split the difference and agree on exactly 3.5 months to make both sides equally unhappy.",
            "D": "Pull API usage data to quantify the revenue at risk, categorize merchants by migration complexity, and build a phased shutdown plan with DevRel and Eng."
        }
    },
    {
        "num": 19,
        "title": "Notion's Crowded Rituals",
        "scenario": "A Notion squad has grown to include 1 PM, 6 Engineers, 2 Designers, 1 QA, 1 Data Analyst, 1 PMM, and 1 User Researcher. Their daily standup now takes 45 minutes, and engineers are complaining it's a waste of time. How should the PM fix this cross-functional ritual?",
        "difficulty": "intermediate",
        "company": "Notion",
        "context": "Productivity SaaS",
        "correct": "B",
        "explanation": "Not all cross-functional partners need to be in every daily operational ritual. Option B correctly identifies that standups are for the core delivery team (Eng/Design/QA) and separates broader stakeholder alignment into a different cadence. Option A doesn't solve the bloated group size. Option C eliminates visibility entirely. Option D creates fragmented silos.",
        "tags": ["agile_rituals", "team_topology", "process_efficiency"],
        "options": {
            "A": "Implement a strict 1-minute timer per person during the standup.",
            "B": "Limit the daily standup to the core delivery team (Eng, Design, QA), and set up a separate weekly sync for broader cross-functional alignment (Data, PMM, UXR).",
            "C": "Cancel the daily standup and move all updates to a Slack thread to save time.",
            "D": "Split the team into three different standups (Eng standup, Design standup, Business standup)."
        }
    },
    {
        "num": 20,
        "title": "DoorDash's Promo Chaos",
        "scenario": "A DoorDash PM notices a sudden 500% spike in orders for a specific ice cream chain, causing massive delivery delays and driver shortages in 3 cities. After digging, the PM realizes Marketing launched a '99-cent ice cream' push notification without telling Product or Ops. What is the key systemic fix?",
        "difficulty": "intermediate",
        "company": "DoorDash",
        "context": "Logistics marketplace",
        "correct": "C",
        "explanation": "When teams operate in silos and cause system strain, the PM must build guardrails. Option C establishes a systemic cross-functional review process for high-impact actions. Option A is a band-aid. Option B limits marketing artificially. Option D removes marketing autonomy entirely.",
        "tags": ["systemic_fixes", "marketing_ops_alignment", "guardrails"],
        "options": {
            "A": "Write a script to automatically cancel orders when driver supply drops below a certain threshold.",
            "B": "Demand that Marketing never run discounts greater than 10% in the future.",
            "C": "Establish a cross-functional 'campaign review' process where Ops and Product must sign off on promotions projected to increase local volume by >20%.",
            "D": "Revoke Marketing's access to the push notification tool and require the PM to send all emails."
        }
    },
    {
        "num": 21,
        "title": "Instagram's Algorithm Conflict",
        "scenario": "Instagram's Feed PM is evaluating a new ranking algorithm. Data Science proves it increases time-in-app by 5%. However, User Research (UXR) shares a qualitative study showing the algorithm makes users feel 'anxious and overwhelmed.' How should the PM weigh this cross-functional input?",
        "difficulty": "intermediate",
        "company": "Instagram",
        "context": "Social media",
        "correct": "D",
        "explanation": "Quantitative data (DS) tells you *what* is happening; qualitative data (UXR) tells you *why*. A PM must synthesize both. Option D investigates the root cause of the anxiety, suspecting that short-term engagement might lead to long-term churn. Option A blindly follows metrics. Option B blindly ignores metrics. Option C is a disjointed user experience.",
        "tags": ["data_vs_uxr", "qual_vs_quant", "synthesis"],
        "options": {
            "A": "Ship the algorithm; quantitative metrics at scale always trump small-sample qualitative research.",
            "B": "Block the algorithm entirely; user sentiment is always more important than engagement metrics.",
            "C": "Ship the algorithm, but add a prominent 'Take a Break' button to solve the anxiety issue.",
            "D": "Synthesize the findings: hypothesize that the 5% increase is 'doomscrolling' which may cause long-term churn, and ask DS to measure long-term retention of the test cohort."
        }
    },
    {
        "num": 22,
        "title": "WhatsApp's Privacy PR Crisis",
        "scenario": "WhatsApp is updating its privacy policy to allow minimal data sharing with business accounts. Legal requires the update. Product builds the consent flow. When it launches, users panic, thinking WhatsApp is reading their private messages. What cross-functional step was missed?",
        "difficulty": "intermediate",
        "company": "WhatsApp",
        "context": "Messaging application",
        "correct": "A",
        "explanation": "Legal changes often require Comms/PR alignment to manage user perception. Option A correctly identifies that Legal mandates the text, but Comms/PMM must wrap it in a narrative that prevents panic. Option B blames Engineering for a communications issue. Option C blames Legal for doing their job. Option D focuses on UX, not the core narrative.",
        "tags": ["comms_pr", "legal", "crisis_prevention"],
        "options": {
            "A": "The PM failed to loop in Communications/PR to craft a proactive narrative explaining what is NOT changing (e.g., end-to-end encryption remains).",
            "B": "Engineering failed to make the 'Accept' button prominent enough, leading to user frustration.",
            "C": "Legal failed to write the policy in a way that users would enthusiastically accept.",
            "D": "Design failed to add enough illustrations to the consent screen to make it feel friendly."
        }
    },
    {
        "num": 23,
        "title": "Figma's Acquisition Integration",
        "scenario": "Figma acquires a small whiteboard startup to help build FigJam. The startup engineers are used to shipping straight to production with no QA. Figma's core engineers require strict peer reviews and QA sign-off. Tension is rising. As the integration PM, how do you manage this culture clash?",
        "difficulty": "intermediate",
        "company": "Figma",
        "context": "Design software acquisition",
        "correct": "B",
        "explanation": "Post-acquisition integration requires blending cultures deliberately. Option B acknowledges the value of both (speed vs. quality) and actively facilitates a new shared norm. Option A crushes the startup's agility. Option C lowers Figma's quality bar dangerously. Option D creates two separate, resentful subcultures.",
        "tags": ["acquisition_integration", "engineering_culture", "process_alignment"],
        "options": {
            "A": "Immediately enforce Figma's strict processes on the startup engineers; they must adapt to the acquirer.",
            "B": "Facilitate a joint engineering workshop to define a 'middle-ground' process for the FigJam team, balancing the startup's velocity with Figma's reliability standards.",
            "C": "Let the startup engineers bypass QA entirely to maintain their morale and velocity.",
            "D": "Keep the two engineering teams completely separated so they don't have to interact."
        }
    },
    {
        "num": 24,
        "title": "Discord's Platform Dependency",
        "scenario": "A Discord PM is building a new 'Voice Effects' feature, which relies heavily on the 'Core Audio' platform team to provide a new API. The Core Audio team keeps delaying the API due to their own OKRs. The Voice Effects PM is blocked. What is the most effective escalation path?",
        "difficulty": "intermediate",
        "company": "Discord",
        "context": "Platform dependencies",
        "correct": "C",
        "explanation": "When blocked by a dependency, PMs must elevate the conversation from a localized conflict to a company-priority level. Option C brings the respective leaders together to align on which project is more important to the company. Option A is passive. Option B violates codebase boundaries and risks instability. Option D wastes time on bureaucracy.",
        "tags": ["dependency_management", "escalation", "platform_teams"],
        "options": {
            "A": "Wait patiently until the Core Audio team finishes their OKRs; you cannot rush platform teams.",
            "B": "Have your engineers fork the Core Audio codebase and build the API themselves to unblock the feature.",
            "C": "Escalate to the Product/Engineering Directors above both teams to get a ruling on which team's OKR is the higher company priority.",
            "D": "Create a highly detailed Gantt chart showing the delay and email it to the Core Audio team daily."
        }
    },
    {
        "num": 25,
        "title": "Shopify's Sales Promise",
        "scenario": "Shopify's VP of Enterprise Sales promises a massive prospective merchant that a custom inventory feature will be ready in 3 weeks if they sign the contract. The Sales VP then tells the PM to drop everything and build it. The feature would take 8 weeks. How should the PM respond?",
        "difficulty": "intermediate",
        "company": "Shopify",
        "context": "Enterprise SaaS sales",
        "correct": "B",
        "explanation": "PMs must manage rogue sales promises by injecting reality without killing the deal. Option B seeks to understand the root need and offers a realistic workaround (manual process + real timeline) to save the deal without destroying engineering capacity. Option A submits to bullying. Option C kills the deal aggressively. Option D relies on deceit.",
        "tags": ["sales_alignment", "managing_up", "scope_negotiation"],
        "options": {
            "A": "Tell engineering to work nights and weekends to hit the 3-week deadline to secure the major contract.",
            "B": "Meet with the Sales VP, explain the 8-week reality, and propose a manual workaround (concierge onboarding) for the first 5 weeks while the feature is built.",
            "C": "Refuse to build the feature, stating that Sales cannot dictate the product roadmap under any circumstances.",
            "D": "Tell the Sales VP it will be ready in 3 weeks, but launch a completely fake UI button to buy time."
        }
    },
    {
        "num": 26,
        "title": "Amazon's Two-Pizza Team Gap",
        "scenario": "An Amazon squad is operating as a 'two-pizza team' building a new checkout widget. They have Eng, Design, and QA, but no dedicated Product Marketing Manager (PMM). Launch is in two weeks, and they need a go-to-market plan. What should the PM do?",
        "difficulty": "intermediate",
        "company": "Amazon",
        "context": "Resource constraints",
        "correct": "D",
        "explanation": "When a cross-functional role is missing, the PM must fill the gap or find fractional support. Option D shows the PM stepping up to draft the materials and utilizing a central team for review, ensuring the work gets done adequately. Option A ignores the GTM need. Option B is an unrealistic demand. Option C asks the wrong discipline to do the job.",
        "tags": ["role_gaps", "gtm_alignment", "adaptability"],
        "options": {
            "A": "Skip the marketing plan; if there's no PMM, it's not the squad's responsibility to market the feature.",
            "B": "Delay the launch indefinitely until HR hires a dedicated PMM for the squad.",
            "C": "Assign the UX Designer to write the marketing emails and blog posts, as they are the most creative person on the team.",
            "D": "Draft the GTM plan and copy yourself, and ask the centralized Marketing team for a 30-minute review to ensure brand compliance."
        }
    },
    {
        "num": 27,
        "title": "GitHub's Open Source vs Enterprise",
        "scenario": "GitHub is rolling out a new CI/CD interface. The Open Source (OS) PM and the Enterprise PM disagree. OS wants the UI to default to public actions. Enterprise wants it to default to strict internal environments. How do you resolve this design conflict?",
        "difficulty": "intermediate",
        "company": "GitHub",
        "context": "Multi-segment product",
        "correct": "C",
        "explanation": "When user segments have conflicting needs, the solution is often contextual configuration rather than a one-size-fits-all compromise. Option C leverages the context (account type) to deliver the right default for each segment. Option A alienates Enterprise. Option B alienates OS. Option D creates unnecessary UI friction for everyone.",
        "tags": ["segment_conflict", "design_alignment", "product_strategy"],
        "options": {
            "A": "Default to public actions, as GitHub's roots are in open source.",
            "B": "Default to strict internal environments, as Enterprise pays the bills.",
            "C": "Work with Engineering to build a context-aware default: it defaults to public for free accounts, and internal for enterprise SSO accounts.",
            "D": "Force every user to manually select their default setting every time they open the page."
        }
    },
    {
        "num": 28,
        "title": "Uber's Ops Heavy Launch",
        "scenario": "Uber is launching a feature requiring drivers to upload a photo of their vehicle inspection. Ops must manually verify these photos. The PM expects 10,000 uploads on day 1. Ops currently has 5 reviewers who can do 100 per day each. What is the PM's failure here?",
        "difficulty": "intermediate",
        "company": "Uber",
        "context": "Operations scaling",
        "correct": "A",
        "explanation": "Digital products with human-in-the-loop workflows must calculate operational capacity. Option A correctly identifies the math failure (10k demand vs 500 capacity). A PM must align feature rollout speed with Ops scaling (e.g., phased rollout, auto-approval heuristics). Option B blames Ops. Option C is a UX problem. Option D is irrelevant.",
        "tags": ["capacity_planning", "ops_alignment", "human_in_the_loop"],
        "options": {
            "A": "The PM failed to model the operational capacity constraints and didn't design a phased rollout to match Ops' throughput.",
            "B": "Ops failed to proactively hire 95 more reviewers in anticipation of the product launch.",
            "C": "The PM failed to make the photo upload button prominent enough.",
            "D": "Engineering failed to compress the photo files, which will slow down the reviewers."
        }
    },
    {
        "num": 29,
        "title": "Netflix's Competing OKRs",
        "scenario": "Netflix's Q3 OKRs are locked. The PM's OKR is 'Increase feature adoption by 15%.' The Engineering Lead's OKR, set by the VP of Eng, is 'Reduce technical debt by migrating 40% of microservices.' The engineering team only has capacity for one. How should the PM navigate this structural misalignment?",
        "difficulty": "advanced",
        "company": "Netflix",
        "context": "Executive misalignment",
        "correct": "B",
        "explanation": "When OKRs conflict structurally at the VP level, PMs cannot resolve it at the squad level. Option B correctly identifies this as a leadership alignment issue and forces the VPs to clarify the priority. Option A guarantees failure for the PM. Option C relies on shadow work. Option D damages the relationship with the Eng Lead.",
        "tags": ["okr_alignment", "executive_escalation", "matrix_conflict"],
        "options": {
            "A": "Accept that technical debt is more important and pause all feature work, knowing you will fail your own OKR.",
            "B": "Draft a joint memo with the Eng Lead outlining the capacity conflict, and escalate to both the VP of Product and VP of Eng to decide the macro-priority.",
            "C": "Convince the engineers to work on features during the day and migrate microservices at night.",
            "D": "Ignore the Eng Lead's OKR and write Jira tickets for features, forcing the engineers to pick them up."
        }
    },
    {
        "num": 30,
        "title": "Airbnb's VP Design Disagreement",
        "scenario": "Airbnb's VP of Design halts a major checkout redesign one week before launch, claiming it 'lacks the Airbnb soul,' despite the PM and VP of Eng showing data that it increases conversion by 4%. The squad is demoralized. How do you handle this high-level cross-functional roadblock?",
        "difficulty": "advanced",
        "company": "Airbnb",
        "context": "Executive stakeholder management",
        "correct": "C",
        "explanation": "Advanced PMs know how to isolate subjective executive feedback into actionable constraints. Option C respectfully acknowledges the VP's authority but forces them to pinpoint exactly what 'soul' means in this context, translating subjective emotion into objective design criteria. Option A is insubordination. Option B accepts a vague critique. Option D wastes time starting from scratch.",
        "tags": ["executive_stakeholders", "design_leadership", "translation"],
        "options": {
            "A": "Launch the feature anyway, citing the 4% conversion increase as justification.",
            "B": "Apologize to the VP, scrap the redesign, and tell the squad to try harder next time.",
            "C": "Schedule an emergency review to ask the VP of Design to specifically identify which components lack 'soul', translating the subjective feedback into actionable fixes.",
            "D": "Ask Engineering to rebuild the old checkout flow immediately."
        }
    },
    {
        "num": 31,
        "title": "Uber's Emergency Regulatory Shutdown",
        "scenario": "A European city abruptly passes a law banning Uber's core service effective in 48 hours. The PM must orchestrate a shutdown. Legal needs to comply. Ops needs to notify drivers. Comms needs a PR statement. Eng needs to geo-fence the app. What is the PM's immediate move?",
        "difficulty": "advanced",
        "company": "Uber",
        "context": "Crisis management",
        "correct": "D",
        "explanation": "In an existential cross-functional crisis, asynchronous communication fails. You need a war room. Option D establishes immediate, synchronous alignment, assigns a clear DRI for the incident, and sequences the dependent steps. Option A is too slow. Option B is chaotic. Option C is incomplete.",
        "tags": ["crisis_management", "war_room", "orchestration"],
        "options": {
            "A": "Create a Slack channel, invite everyone, and ask them to post their status updates by end of day.",
            "B": "Immediately tell Engineering to turn off the app in that city, then figure out Comms and Ops later.",
            "C": "Focus entirely on writing the PR statement, as the public fallout is the biggest risk.",
            "D": "Call an immediate cross-functional 'war room' meeting to establish a runbook, designate an incident commander, and sequence the shutdown steps hour-by-hour."
        }
    },
    {
        "num": 32,
        "title": "Stripe's Multi-Year Initiative",
        "scenario": "A Stripe PM is leading a 2-year initiative to rebuild the billing engine. After 8 months, cross-functional momentum is dying. Engineering velocity has dropped, Marketing has stopped asking about it, and Sales thinks it's a myth. How do you reinvigorate cross-functional alignment?",
        "difficulty": "advanced",
        "company": "Stripe",
        "context": "Long-term program management",
        "correct": "C",
        "explanation": "Massive, multi-year projects die of exhaustion if they lack intermediate milestones. Option C solves this by carving out a tangible, shipable piece of value to prove momentum and re-engage stakeholders. Option A just adds meetings. Option B shifts blame. Option D abandons a strategic initiative due to poor management.",
        "tags": ["long_term_projects", "momentum", "milestones"],
        "options": {
            "A": "Schedule a weekly 2-hour status meeting with all stakeholders to force them to pay attention.",
            "B": "Write a memo to the CEO complaining that the cross-functional teams lack commitment.",
            "C": "Work with Engineering to carve out a 'v0.1' milestone that delivers tangible value to a small subset of users in 6 weeks, and host an internal demo day.",
            "D": "Cancel the initiative, as 8 months is too long to go without launching."
        }
    },
    {
        "num": 33,
        "title": "Spotify's Re-org Transition",
        "scenario": "Spotify announces a massive re-org, moving from functional silos (all engineers report to Eng Managers) to cross-functional autonomous 'Squads' (Eng, Design, PM report to a single Squad Leader). Your new squad is confused about who owns what. How do you establish the new operating model?",
        "difficulty": "advanced",
        "company": "Spotify",
        "context": "Organizational design",
        "correct": "B",
        "explanation": "Re-orgs create chaos. A PM must explicitly redefine the rules of engagement. Option B uses a structured framework (RACI/DACI) to explicitly map out the new realities of decision-making, removing ambiguity. Option A relies on hope. Option C is an authoritarian land grab. Option D defers to leadership for team-level norms.",
        "tags": ["re_org", "raci", "team_formation"],
        "options": {
            "A": "Let the team figure it out organically over a few sprints; imposing structure early kills autonomy.",
            "B": "Facilitate a DACI/RACI workshop with the new squad to explicitly define who is the driver, approver, and contributor for product, technical, and design decisions.",
            "C": "Announce that as the PM, you are the CEO of the squad and have final say on all engineering and design decisions.",
            "D": "Ask HR to provide a document explaining how squads are supposed to work."
        }
    },
    {
        "num": 34,
        "title": "Slack's Escalation Structure",
        "scenario": "Slack's Enterprise squad is constantly disrupted by Sales escalating 'critical' missing features for high-value prospects. The PM spends 60% of their time arguing with Sales Directors over Jira tickets. What is the advanced systemic solution?",
        "difficulty": "advanced",
        "company": "Slack",
        "context": "Systemic process design",
        "correct": "C",
        "explanation": "When escalation becomes the norm, the intake process is broken. Option C builds a quantified, objective rubric aligned with company strategy, moving the conversation from 'who yells loudest' to 'what is the ARR impact.' Option A ignores the business reality of enterprise sales. Option B creates a parallel, inefficient track. Option D burns out the PM.",
        "tags": ["sales_escalations", "process_design", "intake_rubric"],
        "options": {
            "A": "Block all Sales Directors on Slack and tell them to submit ideas through a generic Google Form.",
            "B": "Dedicate 50% of engineering capacity to a 'Sales Demands' track to keep them happy.",
            "C": "Partner with Sales Leadership to build a quantified intake rubric (e.g., minimum ARR threshold, strategic fit) that all requests must pass before reaching the squad.",
            "D": "Continue fighting ticket-by-ticket; defending the backlog is just the reality of enterprise PMing."
        }
    },
    {
        "num": 35,
        "title": "Figma's Shadow PMing",
        "scenario": "A highly respected Staff Engineer at Figma starts 'shadow PMing'—writing PRDs, defining scope, and promising features to marketing without consulting the PM. The team loves this engineer. How do you re-establish your PM role without creating an enemy?",
        "difficulty": "advanced",
        "company": "Figma",
        "context": "Role boundaries and ego",
        "correct": "B",
        "explanation": "Advanced PMs handle 'shadow PMs' not by fighting them, but by judo-ing their energy. Option B validates the engineer's passion while clearly delineating responsibilities, turning a competitor into a powerful partner. Option A creates a turf war. Option C abdicates the PM role. Option D destroys team morale.",
        "tags": ["shadow_pm", "role_boundaries", "engineering_partnership"],
        "options": {
            "A": "Publicly call out the engineer in the next team meeting for overstepping their boundaries.",
            "B": "Have a private 1:1, praise their product sense, and propose dividing and conquering: they own the technical architecture and feasibility, you own the user problem and GTM alignment.",
            "C": "Let the engineer act as the PM, and transition yourself to more of a project management/scrum master role.",
            "D": "Report the engineer to their manager for violating the standard career ladder expectations."
        }
    }
]

import os
import sys

sql_template = """-- ============================================
-- ASSESSMENT: {sub_skill_name}
-- CATEGORY: {category_name}
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
    WHERE slug = '{sub_skill_slug}';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug {sub_skill_slug} not found. Run the seed data first.';
    END IF;

{questions_sql}

    RAISE NOTICE 'Successfully inserted 35 questions for {sub_skill_name}';

END $$;
"""

question_template = """    -- ----------------------------------------
    -- QUESTION {num} ({difficulty})
    -- ----------------------------------------
    INSERT INTO questions (
        sub_skill_id, question_number, title, scenario,
        difficulty, product_company, product_context,
        correct_option, explanation, tags
    ) VALUES (
        v_sub_skill_id,
        {num},
        '{title}',
        E'{scenario}',
        '{difficulty}',
        '{company}',
        '{context}',
        '{correct}',
        E'{explanation}',
        ARRAY[{tags_sql}]
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', E'{opt_a}', {is_a_correct}),
    (v_q_id, 'B', E'{opt_b}', {is_b_correct}),
    (v_q_id, 'C', E'{opt_c}', {is_c_correct}),
    (v_q_id, 'D', E'{opt_d}', {is_d_correct});
"""

questions_sql = ""

for q in questions:
    def escape(s):
        return s.replace("'", "''")

    tags_sql = ", ".join([f"'{escape(t)}'" for t in q['tags']])
    
    questions_sql += question_template.format(
        num=q['num'],
        difficulty=q['difficulty'],
        title=escape(q['title']),
        scenario=escape(q['scenario']).replace('\n', '\\n'),
        company=escape(q['company']),
        context=escape(q['context']),
        correct=q['correct'],
        explanation=escape(q['explanation']).replace('\n', '\\n'),
        tags_sql=tags_sql,
        opt_a=escape(q['options']['A']),
        is_a_correct='true' if q['correct'] == 'A' else 'false',
        opt_b=escape(q['options']['B']),
        is_b_correct='true' if q['correct'] == 'B' else 'false',
        opt_c=escape(q['options']['C']),
        is_c_correct='true' if q['correct'] == 'C' else 'false',
        opt_d=escape(q['options']['D']),
        is_d_correct='true' if q['correct'] == 'D' else 'false',
    )

final_sql = sql_template.format(
    sub_skill_name="Cross-functional Management",
    category_name="Execution",
    sub_skill_slug="cross-functional-mgmt",
    questions_sql=questions_sql
)

with open("/Users/chirag/Startups/Assesments/sql/28_execution_cross_functional_management.sql", "w") as f:
    f.write(final_sql)

print("SQL generated successfully.")
