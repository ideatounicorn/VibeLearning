-- ============================================
-- ASSESSMENT: Technical Documentation
-- CATEGORY: Execution
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
    WHERE slug = 'technical-documentation';

    IF v_sub_skill_id IS NULL THEN
        RAISE EXCEPTION 'Sub-skill with slug technical-documentation not found. Run the seed data first.';
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
        'Slack''s Non-Functional Requirements',
        E'Scenario: Slack''s PM for Slack Connect is writing a PRD. They specify that "messages sent to an external organization must appear within 200 milliseconds of sending, even under peak load of 10,000 messages per second."\n\nWhat part of the technical documentation should this statement reside in?',
        'foundational',
        'Slack',
        'Enterprise messaging and collaboration platform',
        'B',
        'While functional requirements describe what a system must do (e.g., "send a message"), non-functional requirements (NFRs) describe how well the system must perform that function. Latency, scalability, reliability, and security are classic NFRs. A PM must explicitly document these because they heavily influence the underlying engineering architecture. If a PM only specifies the functional requirement, engineers might build a system that works for 10 users but crashes at 10,000. Options C and D are incorrect because UAC is for testing criteria, and the TDD is written by engineering, not the PM.',
        ARRAY['prd', 'nfrs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The functional requirements section, as it describes how the system functions.', false),
    (v_q_id, 'B', 'The non-functional requirements (NFRs) section, as it dictates performance and latency targets.', true),
    (v_q_id, 'C', 'The user acceptance criteria (UAC), as users will test this directly.', false),
    (v_q_id, 'D', 'The technical design document (TDD), as it requires engineering architecture choices.', false);

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
        'Stripe''s API Reference Documentation',
        E'Scenario: Stripe''s PM is reviewing the external API documentation for a new Subscription API endpoint. They notice the `trial_end` parameter is listed without indicating what happens if a developer omits it.\n\nWhat is the most critical fix the PM should request for this API documentation?',
        'foundational',
        'Stripe',
        'Payment processing and API platform',
        'B',
        'A core principle of technical API documentation is eliminating ambiguity for the developer. If a parameter''s required/optional status is undocumented, developers are forced to use trial and error, leading to a poor developer experience (DX) and potential production errors. Explicitly stating default behaviors when optional parameters are omitted is critical for predictable integrations. Option A is helpful but doesn''t fix the core missing logic. Option D is an aggressive product change, not a documentation fix. Option C just hides the problem.',
        ARRAY['api_documentation', 'developer_experience']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add code snippets for five different programming languages showing how to pass the parameter.', false),
    (v_q_id, 'B', 'Explicitly document whether the parameter is required or optional, and define its default behavior if omitted.', true),
    (v_q_id, 'C', 'Move the parameter to a separate "advanced configurations" page to reduce cognitive load.', false),
    (v_q_id, 'D', 'Require engineers to enforce the parameter as mandatory to avoid ambiguous states.', false);

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
        'Notion''s Edge Case Documentation',
        E'Scenario: Notion''s PM is documenting requirements for a new "Formula" property type. They need to document how the system behaves if a user creates a circular reference (Formula A references Formula B, which references Formula A).\n\nWhich format is best for documenting these complex, non-standard user paths?',
        'foundational',
        'Notion',
        'Productivity and database workspace',
        'B',
        'Complex features like Notion''s formulas create numerous permutations of user behavior that fall outside the "happy path." An edge case and error handling matrix forces the PM and engineering team to systematically evaluate inputs, expected system responses, and the exact error messages presented to the user. A happy-path user story (Option A) intentionally ignores these complexities. A database schema (Option D) defines data structure, not behavioral edge cases. Identifying and documenting these states prevents system crashes and user frustration.',
        ARRAY['edge_cases', 'error_handling']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A happy-path user story.', false),
    (v_q_id, 'B', 'An edge case and error handling matrix.', true),
    (v_q_id, 'C', 'A marketing release note.', false),
    (v_q_id, 'D', 'A database schema diagram.', false);

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
        'GitHub''s Release Notes Tone',
        E'Scenario: GitHub''s PM is drafting public release notes for a patch that fixes a severe security vulnerability in GitHub Actions.\n\nHow should the PM document this fix for external users?',
        'foundational',
        'GitHub',
        'Code hosting and collaboration platform',
        'C',
        'When dealing with security vulnerabilities, external release notes must strike a balance between transparency and safety. Providing a clear summary of the impact and the required remediation steps (like updating a runner) empowers users to protect themselves. Option B is highly dangerous as it provides a tutorial for bad actors to exploit users who haven''t patched yet. Option A violates user trust by obfuscating a critical security flaw. Option D is unprofessional and irrelevant to the user''s need to secure their system.',
        ARRAY['release_notes', 'security']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Obscure the security details completely and label it a "general performance improvement" to avoid panic.', false),
    (v_q_id, 'B', 'Detail the exact method to exploit the vulnerability so users understand the severity.', false),
    (v_q_id, 'C', 'Provide a clear, factual summary of the vulnerability, the potential impact, and the recommended action without providing an exploitation tutorial.', true),
    (v_q_id, 'D', 'Blame the third-party dependency that caused the issue to protect GitHub''s reputation.', false);

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
        'Datadog''s Acceptance Criteria',
        E'Scenario: Datadog''s PM is writing a user story for a new dashboard widget. They write: "Given a user is on the dashboard, When they click ''Export to PDF'', Then a PDF is downloaded within 5 seconds."\n\nWhat documentation format is the PM using?',
        'foundational',
        'Datadog',
        'Cloud monitoring and analytics platform',
        'A',
        'The "Given [context], When [action], Then [outcome]" format is the standard syntax for Behavior-Driven Development (BDD), often called Gherkin syntax. This format is highly favored in technical documentation because it creates clear, unambiguous test cases that can often be automated by QA teams using tools like Cucumber. It forces the PM to define the initial state, the trigger, and the exact expected result. JTBD (Option B) focuses on user motivations, not technical acceptance criteria. OAS (Option D) is for APIs, and C4 (Option C) is for architecture diagrams.',
        ARRAY['bdd', 'acceptance_criteria']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Gherkin syntax (Given/When/Then) for Behavior-Driven Development (BDD).', true),
    (v_q_id, 'B', 'Jobs-to-be-Done (JTBD) framework.', false),
    (v_q_id, 'C', 'C4 architecture modeling.', false),
    (v_q_id, 'D', 'OpenAPI Specification (OAS).', false);

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
        'Twilio''s Migration Guide',
        E'Scenario: Twilio is releasing v2 of their SMS API, which completely changes the authentication payload. The PM needs to write a migration guide for existing v1 developers.\n\nWhat is the primary goal of this migration guide?',
        'foundational',
        'Twilio',
        'Cloud communications platform',
        'B',
        'The primary purpose of a migration guide for a breaking API change (like v1 to v2) is to reduce the friction of upgrading. Developers are often reluctant to rewrite working code, so the documentation must act as a precise map translating old concepts to new ones. If the guide fails to do this, developers may simply refuse to upgrade, leaving the company supporting costly legacy infrastructure. Option A is a marketing goal, not a technical documentation goal. Option D creates unnecessary panic and hostility; deprecations should be phased.',
        ARRAY['migration_guide', 'api_versioning']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To convince developers that the v2 API is technologically superior and uses modern frameworks.', false),
    (v_q_id, 'B', 'To provide a step-by-step map of how v1 concepts and fields translate to v2, minimizing developer effort to upgrade.', true),
    (v_q_id, 'C', 'To list every single bug fix included in the v2 release.', false),
    (v_q_id, 'D', 'To warn developers that v1 will be shut down tomorrow and they must act immediately.', false);

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
        'Shopify''s RFC Review',
        E'Scenario: Shopify''s PM is asked to review an engineering RFC (Request for Comments) for a new cart checkout architecture.\n\nWhat is the PM''s primary responsibility during this technical RFC review?',
        'foundational',
        'Shopify',
        'E-commerce platform',
        'C',
        'While a PM does not typically dictate the specific technical implementation (like choosing PostgreSQL over MongoDB), they are the ultimate voice of the customer and the business strategy in a technical review. The PM must read the Request for Comments (RFC) to ensure the proposed architecture actually supports the product''s non-functional requirements, scaling needs, and future roadmap. If the engineering proposal is fast to build but blocks a critical feature planned for next year, the PM must flag this tradeoff. Options A, B, and D represent overstepping into engineering execution or pedantic editing rather than strategic alignment.',
        ARRAY['rfc', 'architecture']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'To rewrite the pseudocode to ensure it is optimized for Big O time complexity.', false),
    (v_q_id, 'B', 'To approve the choice of database (e.g., PostgreSQL vs MongoDB).', false),
    (v_q_id, 'C', 'To ensure the proposed architecture supports the product''s long-term roadmap, scale, and user requirements.', true),
    (v_q_id, 'D', 'To correct grammar and spelling mistakes in the engineering document.', false);

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
        'Zoom''s State Machine Diagram',
        E'Scenario: Zoom''s PM is writing a PRD for the "Waiting Room" feature. A user can be ''waiting'', ''admitted'', ''rejected'', or ''disconnected''.\n\nWhat is the most effective way to document how a user transitions between these statuses?',
        'foundational',
        'Zoom',
        'Video conferencing platform',
        'A',
        'State machine diagrams are the standard technical documentation tool for features where an entity (like a user in a waiting room) transitions between distinct, mutually exclusive statuses. They clearly map out the allowed transitions, the triggers for those transitions, and the illegal states (e.g., a user cannot go from ''disconnected'' directly to ''admitted'' without being ''waiting'' first). This level of precision is impossible to achieve cleanly with just a bulleted list (Option B) or wireframes (Option C). It ensures engineers build robust backend logic that prevents invalid states.',
        ARRAY['state_machine', 'system_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A state machine diagram (or state transition diagram).', true),
    (v_q_id, 'B', 'A bulleted list of user personas.', false),
    (v_q_id, 'C', 'A wireframe of the host''s screen.', false),
    (v_q_id, 'D', 'A REST API payload example.', false);

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
        'Plaid''s One-Pager',
        E'Scenario: Plaid''s PM wants to pitch a new integration with European banks. Before writing a 15-page PRD, they write a 1-pager.\n\nWhat is the purpose of the 1-pager vs the full PRD?',
        'foundational',
        'Plaid',
        'Financial API network',
        'B',
        'A one-pager is a strategic alignment document used early in the product lifecycle. Its goal is to succinctly articulate the user problem, the proposed solution, and the business value to secure buy-in from stakeholders and engineering leadership before investing weeks into writing a comprehensive PRD. Once alignment is achieved, the PM writes the full PRD detailing the exact technical and functional requirements (the "how" and "what"). Option A is false; one-pagers do not replace PRDs. Option C is false; one-pagers are typically internal documents.',
        ARRAY['one_pager', 'product_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The 1-pager replaces the PRD to save engineering time.', false),
    (v_q_id, 'B', 'The 1-pager is for aligning stakeholders on the "why" and problem, while the PRD details the "how" and specific requirements.', true),
    (v_q_id, 'C', 'The 1-pager is exclusively for external marketing, while the PRD is internal.', false),
    (v_q_id, 'D', 'The 1-pager contains the API specs, while the PRD contains the business logic.', false);

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
        'Vercel''s Ubiquitous Language',
        E'Scenario: Vercel''s PM notices that sales calls them "Projects", engineering calls them "Deployments", and design calls them "Sites". The PM creates a glossary document.\n\nWhat is the PM trying to establish?',
        'foundational',
        'Vercel',
        'Frontend cloud and hosting platform',
        'A',
        'In Domain-Driven Design (DDD), a "Ubiquitous Language" is a shared vocabulary used consistently across all domains of the business—from sales to product to engineering codebases. When different departments use different terms for the same concept (e.g., Projects vs. Deployments), it creates massive communication overhead, technical debt, and bugs. By creating a glossary and enforcing a ubiquitous language in all technical documentation, the PM aligns the entire organization. Options B, C, and D are unrelated concepts.',
        ARRAY['ubiquitous_language', 'glossary']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Domain-Driven Design''s concept of a "Ubiquitous Language" to reduce cross-functional friction.', true),
    (v_q_id, 'B', 'A microservices architecture boundary.', false),
    (v_q_id, 'C', 'A Go-to-Market pricing strategy.', false),
    (v_q_id, 'D', 'A Service Level Agreement (SLA).', false);

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
        'AWS EC2 Deprecation Docs',
        E'Scenario: AWS is deprecating the `m4.large` instance type. The PM must draft the deprecation documentation for customers.\n\nWhat critical elements MUST be included in a technical deprecation notice?',
        'intermediate',
        'AWS',
        'Cloud computing infrastructure',
        'B',
        'Deprecating technical infrastructure is a highly sensitive process that can break customer applications. A PM must provide a clear, unambiguous timeline that includes the exact date of termination, so customers can plan their engineering sprints accordingly. Furthermore, providing a direct migration path (e.g., moving to m5.large) is essential for minimizing customer churn and support tickets. Option A is unprofessional and irrelevant to the customer''s needs. Option D is actively hostile to the user experience and will overwhelm the account management team.',
        ARRAY['deprecation', 'lifecycle_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The internal reasons why AWS is shutting it down and the names of the engineers responsible.', false),
    (v_q_id, 'B', 'A clear timeline, the exact date of termination, recommended alternative (e.g., m5.large), and instructions for migration.', true),
    (v_q_id, 'C', 'A discount code for the new instances to apologize for the inconvenience.', false),
    (v_q_id, 'D', 'Only the termination date, so customers are forced to reach out to their account managers for details.', false);

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
        'Spotify''s ML Specification',
        E'Scenario: Spotify''s PM is writing requirements for a new "Discover Weekly" algorithm tweak. Unlike traditional software, the exact output cannot be deterministically defined.\n\nHow should the PM document the acceptance criteria for this machine learning feature?',
        'intermediate',
        'Spotify',
        'Audio streaming service',
        'B',
        'Unlike traditional deterministic software (where clicking ''A'' always results in ''B''), machine learning models are probabilistic. A PM cannot specify exact outputs (like a specific song) because the model dynamically adapts to live data. Instead, the technical documentation must define success via statistical thresholds, such as precision, recall, or engagement metrics, accompanied by guardrail metrics (e.g., "don''t drop overall streaming hours"). Option A demonstrates a fundamental misunderstanding of ML. Option C applies to traditional logic, not neural networks.',
        ARRAY['machine_learning', 'acceptance_criteria']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Document the exact songs that must appear in a test user''s playlist.', false),
    (v_q_id, 'B', 'Define statistical thresholds for success (e.g., "Precision@10 must increase by 5% without dropping overall streaming hours").', true),
    (v_q_id, 'C', 'Write standard Given/When/Then statements for the ML model''s internal layers.', false),
    (v_q_id, 'D', 'Skip acceptance criteria since ML models are unpredictable by nature.', false);

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
        'Netflix''s Error Handling Matrix',
        E'Scenario: Netflix''s PM is documenting the video player behavior. They use a matrix showing what happens if: 1) DRM fails, 2) bandwidth drops below 500kbps, 3) the user goes offline.\n\nWhy is an error handling matrix superior to a narrative paragraph for this documentation?',
        'intermediate',
        'Netflix',
        'Video streaming service',
        'B',
        'An error handling matrix is an essential technical documentation tool for systems with complex state permutations. It forces the PM and engineering team to systematically evaluate what happens when multiple failure states overlap (e.g., offline AND expired DRM). This matrix translates directly into automated unit testing and integration testing scenarios for engineers, significantly reducing the chance of unhandled exceptions in production. A narrative paragraph often misses overlapping edge cases. Option C is incorrect; designers still need to create the UI for these states.',
        ARRAY['error_handling', 'edge_cases']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'It looks more professional to senior leadership.', false),
    (v_q_id, 'B', 'It forces exhaustive thinking about edge cases and maps directly to unit testing scenarios for engineers.', true),
    (v_q_id, 'C', 'It prevents designers from having to create error state mockups.', false),
    (v_q_id, 'D', 'It automatically generates the required backend code.', false);

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
        'Uber''s Regulatory NFRs',
        E'Scenario: Uber''s PM is writing a PRD for dynamic surge pricing. A local law caps surge pricing at 2.0x during states of emergency.\n\nHow should this be documented in the technical requirements?',
        'intermediate',
        'Uber',
        'Ridesharing and mobility platform',
        'B',
        'Regulatory constraints are classic non-functional requirements (NFRs) that act as external dependencies on the system architecture. A PM must document these not as hardcoded logic, but as business rules that require configurable system parameters (like an admin override or a geofenced rules engine). Hardcoding legal limits (Option A) creates immense technical debt when laws inevitably change. Option C abdicates the PM''s responsibility to ensure the product is legally compliant by design.',
        ARRAY['nfrs', 'regulatory_compliance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'As a hardcoded if/else statement in the PRD for engineers to copy-paste.', false),
    (v_q_id, 'B', 'As an external dependency/constraint and a functional requirement for a configurable "surge cap" admin override.', true),
    (v_q_id, 'C', 'It should be left out of the PRD and handled by the legal team manually.', false),
    (v_q_id, 'D', 'As a footnote in the marketing launch plan.', false);

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
        'Snowflake''s Doc Information Architecture',
        E'Scenario: Snowflake''s product wiki has grown to 5,000 pages. Engineers complain they can''t find the latest PRDs, often reading outdated V1 docs instead of V2.\n\nWhat is the best way for the PM organization to fix this documentation architecture?',
        'intermediate',
        'Snowflake',
        'Cloud data warehousing platform',
        'B',
        'Documentation debt is a massive drag on engineering velocity. When a wiki becomes unmanageable, a PM must establish a strict Information Architecture (IA) and a "Single Source of Truth" policy. Implementing standard naming conventions, clearly demarking archived documents, and utilizing status labels ensures engineers don''t waste time building against deprecated requirements. Option A is destructive, as historical context is often needed for debugging legacy systems. Option C conflates ticket tracking with long-form documentation.',
        ARRAY['documentation_architecture', 'knowledge_management']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Delete all V1 PRDs immediately so only V2 exists.', false),
    (v_q_id, 'B', 'Implement a "Single Source of Truth" hierarchy, standardize naming conventions, use "Archived" folders, and add status labels to all pages.', true),
    (v_q_id, 'C', 'Stop using wikis and move all PRDs into Jira tickets.', false),
    (v_q_id, 'D', 'Hire a full-time librarian to manually email PRDs to engineers when requested.', false);

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
        'Supabase''s Public Roadmap',
        E'Scenario: Supabase (an open-source Firebase alternative) maintains a public-facing roadmap on GitHub. The PM must update it for the next quarter.\n\nWhat is the best practice for a technical product''s public roadmap documentation?',
        'intermediate',
        'Supabase',
        'Open-source database and backend platform',
        'C',
        'A public roadmap for a technical product is a strategic communication tool, not a project management tracker. Best practice dictates focusing on broad themes (e.g., "GraphQL Support" or "Q3: Security Enhancements") to give developers confidence in the platform''s direction without locking the engineering team into strict, unforgiving deadlines. Committing to exact dates (Option A) almost always backfires due to the unpredictable nature of software development. Option B provides useless noise, and Option D defeats the purpose of a forward-looking roadmap.',
        ARRAY['public_roadmap', 'communication']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Include exact release dates and commit to them to build trust.', false),
    (v_q_id, 'B', 'List granular backend refactoring tasks so developers know you are working hard.', false),
    (v_q_id, 'C', 'Focus on broad themes, upcoming capabilities, and user value (e.g., "GraphQL Support"), avoiding strict deadlines unless 100% certain.', true),
    (v_q_id, 'D', 'Only publish items that are already finished to avoid tipping off competitors.', false);

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
        'OpenAI''s Rate Limit Policy',
        E'Scenario: OpenAI''s PM is updating the API documentation to introduce new rate limits (Tokens Per Minute - TPM).\n\nHow should the PM document this to ensure developers can gracefully handle the limits?',
        'intermediate',
        'OpenAI',
        'Artificial intelligence research and API platform',
        'B',
        'Rate limits are a fundamental reality of building on APIs, but hitting them is a poor developer experience. High-quality technical documentation must clearly define the exact limits, explain the HTTP status codes returned (usually 429 Too Many Requests), and proactively provide best practices like exponential backoff algorithms. This empowers developers to build resilient integrations that gracefully handle throttling. Option A is lazy and infuriating for developers. Option C is hostile, and Option D hides critical architectural constraints from the people who need them most.',
        ARRAY['api_documentation', 'rate_limiting']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Just state "Rate limits apply" and let developers figure out the threshold via trial and error.', false),
    (v_q_id, 'B', 'Document the exact TPM limits, explain the HTTP 429 response format, and provide a code snippet for implementing exponential backoff.', true),
    (v_q_id, 'C', 'Threaten to ban accounts that hit the rate limit in bold red text.', false),
    (v_q_id, 'D', 'Provide the limits only in the billing dashboard, not the technical API reference.', false);

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
        'Cloudflare''s Incident Post-Mortem',
        E'Scenario: Cloudflare experienced a 20-minute outage. The PM is co-authoring the post-mortem (RCA - Root Cause Analysis) with the engineering lead.\n\nWhat is the hallmark of a high-quality, actionable technical post-mortem?',
        'intermediate',
        'Cloudflare',
        'Web performance and security platform',
        'B',
        'A technical post-mortem (or RCA) is useless if it focuses on assigning blame, as this encourages engineers to hide future mistakes. The hallmark of a great post-mortem is a blameless culture that seeks to understand the systemic failures that allowed a human error to take down the system. It must include a detailed timeline, root cause analysis (like the Five Whys), and most importantly, prioritized technical action items to prevent the specific failure from ever recurring. Option A creates a toxic culture. Options C and D are PR spin, not technical documentation.',
        ARRAY['post_mortem', 'rca']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Identifying the specific engineer who made the mistake and detailing their punishment.', false),
    (v_q_id, 'B', 'Blameless analysis, a detailed timeline of events, the "Five Whys" to find the root cause, and prioritized action items to prevent recurrence.', true),
    (v_q_id, 'C', 'A short apology letter to customers minimizing the impact of the outage.', false),
    (v_q_id, 'D', 'A complex architectural diagram proving that the system design was flawless and it was a freak accident.', false);

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
        'Figma''s Sequence Diagrams',
        E'Scenario: Figma''s PM is working on a new multiplayer feature where users can simultaneously edit a component. The PM needs to align with engineering on the client-server sync logic.\n\nWhich type of documentation is most appropriate for visualizing the order of messages passed between Client A, the Server, and Client B?',
        'intermediate',
        'Figma',
        'Collaborative design platform',
        'B',
        'A UML Sequence Diagram is specifically designed to document the sequential flow of messages and data between different components or actors over time. In a real-time multiplayer environment like Figma, understanding the exact order of operations (e.g., Client A sends delta, Server resolves conflict, Server broadcasts to Client B) is critical for preventing race conditions. Gantt charts (Option A) are for project schedules. ER diagrams (Option C) define static database relationships, not real-time interactions.',
        ARRAY['sequence_diagram', 'system_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Gantt chart.', false),
    (v_q_id, 'B', 'A UML Sequence Diagram.', true),
    (v_q_id, 'C', 'An Entity-Relationship (ER) diagram.', false),
    (v_q_id, 'D', 'A SWOT analysis.', false);

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
        'Airbnb''s A/B Test Documentation',
        E'Scenario: Airbnb''s PM is documenting a complex A/B test for the checkout flow.\n\nBeyond just the "Control" and "Variant" UI designs, what MUST be documented in the technical test plan for engineers?',
        'intermediate',
        'Airbnb',
        'Travel and hospitality marketplace',
        'B',
        'When documenting an A/B test for engineering, the UI changes are only half the requirement. The PM must meticulously document the telemetry: exactly which tracking events need to fire, how users are assigned to variants (exposure logging), and the guardrail metrics that ensure the test doesn''t break core functionality. Without this technical documentation, the data scientists will receive garbage data, rendering the test invalid. Option D is handled by the analytics platform, not the feature engineers. Option A is irrelevant to the core product code.',
        ARRAY['ab_testing', 'experimentation_docs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The marketing copy for the associated email campaign.', false),
    (v_q_id, 'B', 'The tracking events/telemetry to fire, the exposure logging mechanism, and the guardrail metrics.', true),
    (v_q_id, 'C', 'The names of the data scientists who will analyze the test.', false),
    (v_q_id, 'D', 'The exact statistical formulas (e.g., t-test) the analytics tool will use.', false);

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
        'DoorDash''s Legacy Migration',
        E'Scenario: DoorDash is migrating from a monolithic order-routing system to microservices. The PM is writing the PRD for the migration.\n\nWhat is the most critical requirement pattern the PM should document for Phase 1 of this migration?',
        'intermediate',
        'DoorDash',
        'Food delivery logistics platform',
        'A',
        'When migrating core infrastructure, the standard best practice for Phase 1 is "Feature Parity." The PM must document the existing system''s exact behaviors, including its quirks and edge cases, to ensure the new microservices architecture perfectly replicates the old monolith''s output. Attempting to add new features or completely redesign the system during a massive backend migration (Option B) introduces too many variables and dramatically increases the risk of a catastrophic failure. Option D is an engineering constraint, not a functional requirement pattern.',
        ARRAY['system_migration', 'feature_parity']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', '"Feature Parity" — documenting existing behavior to ensure the new system perfectly replicates the old system''s output before adding new features.', true),
    (v_q_id, 'B', '"Blue-Sky Ideation" — taking the opportunity to completely redesign how orders are routed.', false),
    (v_q_id, 'C', '"Marketing Launch" — planning how to pitch the microservices architecture to end consumers.', false),
    (v_q_id, 'D', '"Cost Reduction" — ensuring the new system uses exactly half the cloud resources of the old one.', false);

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
        'Discord''s Epic Slicing',
        E'Scenario: Discord''s PM has an Epic titled "Voice Channel Scaling to 10,000 Users". The engineering team says the Epic is too large to estimate.\n\nHow should the PM adjust the technical documentation in Jira?',
        'intermediate',
        'Discord',
        'Voice, video, and text communication platform',
        'B',
        'Large, monolithic Epics are a primary cause of stalled engineering velocity because they are impossible to accurately estimate or test. A PM must break down (or "slice") the Epic into smaller, vertically integrated User Stories that deliver incremental value or reduce technical risk (e.g., proving the audio encoding works before building the UI). This allows the team to ship iteratively and adapt to feedback. Option A just masks the problem. Option C violates agile principles of continuous delivery.',
        ARRAY['epic_slicing', 'agile']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Change the estimate field to a larger number.', false),
    (v_q_id, 'B', 'Break the Epic down into vertically sliced User Stories that deliver incremental value or test risk.', true),
    (v_q_id, 'C', 'Keep the Epic intact but give the engineering team three extra months to finish it.', false),
    (v_q_id, 'D', 'Delete the Epic and tell engineering to just start coding.', false);

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
        'Robinhood''s Traceability Matrix',
        E'Scenario: Robinhood''s PM is writing documentation for a new options trading feature that is highly regulated by FINRA.\n\nThe compliance team requires proof that every regulatory rule has been implemented and tested. What should the PM create?',
        'intermediate',
        'Robinhood',
        'Financial services and trading platform',
        'A',
        'In highly regulated industries like fintech or healthcare, auditors require definitive proof that compliance rules were actually built and tested. A Requirements Traceability Matrix (RTM) is a technical documentation artifact that maps a specific regulatory rule to its corresponding PRD requirement, the Jira ticket where it was built, and the QA test case that validated it. This ensures zero gaps in compliance. An affidavit (Option B) is not proof of implementation. Option D is a project management view, not a traceability tool.',
        ARRAY['traceability_matrix', 'compliance']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A Requirements Traceability Matrix (RTM) linking specific regulatory rules to PRD requirements, engineering tickets, and QA test cases.', true),
    (v_q_id, 'B', 'A signed affidavit from the VP of Engineering stating the system is compliant.', false),
    (v_q_id, 'C', 'A user persona document detailing the demographic of the compliance officers.', false),
    (v_q_id, 'D', 'A Kanban board showing the velocity of the compliance features.', false);

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
        'Atlassian''s Docs-as-Code',
        E'Scenario: Atlassian''s Jira PM notices that external API documentation is frequently out of sync with the actual API because docs are updated manually in a wiki.\n\nWhat technical documentation methodology should the PM advocate for?',
        'intermediate',
        'Atlassian',
        'Enterprise software and developer tools',
        'B',
        'The "Docs-as-code" methodology treats technical documentation with the same rigor as application code. By integrating tools like Swagger or OpenAPI into the CI/CD pipeline, API reference documentation is automatically generated directly from the codebase comments and structure. This guarantees that the documentation is always a perfect, single source of truth reflection of the actual production API. Manual updates (Option A) inevitably lead to drift and outdated docs. Option C is a terrible developer experience.',
        ARRAY['docs_as_code', 'ci_cd']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Hiring more technical writers to manually check the wiki daily.', false),
    (v_q_id, 'B', '"Docs-as-code," integrating API documentation generation directly into the engineering CI/CD pipeline.', true),
    (v_q_id, 'C', 'Removing the API documentation entirely and offering a support phone number instead.', false),
    (v_q_id, 'D', 'Moving all documentation to physical printed manuals to avoid versioning issues.', false);

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
        'Shopify''s Developer Experience (DX) Docs',
        E'Scenario: Shopify''s PM is evaluating their developer platform documentation. They notice high API usage but extremely low adoption of their new Webhook system.\n\nUpon reviewing the webhook docs, what is the PM most likely to find lacking that ruins the Developer Experience (DX)?',
        'intermediate',
        'Shopify',
        'E-commerce API and developer platform',
        'C',
        'Developer Experience (DX) relies heavily on reducing the "time to first hello world." For complex systems like webhooks, conceptual documentation isn''t enough; developers need tactical tools to test their integrations. High-quality technical documentation for platforms must include clear payload examples, copy-pasteable snippets, and sandbox environments or testing endpoints so developers can simulate events without writing a full backend. Options A, B, and D provide zero technical value to a developer trying to integrate an API.',
        ARRAY['developer_experience', 'api_documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A history of Shopify''s founding.', false),
    (v_q_id, 'B', 'The company''s internal OKRs for the quarter.', false),
    (v_q_id, 'C', 'Clear getting-started tutorials, payload examples, and a sandbox/testing tool for webhooks.', true),
    (v_q_id, 'D', 'A list of every engineer who worked on the webhook system.', false);

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
        'Reddit''s RBAC Permissions Matrix',
        E'Scenario: Reddit''s PM is designing a new moderation tool. There are Admins, Super Mods, Mods, and Users.\n\nWhat is the most robust way to document who can do what (e.g., delete posts, ban users, view logs)?',
        'intermediate',
        'Reddit',
        'Community discussion platform',
        'B',
        'Role-Based Access Control (RBAC) involves complex, intersecting permissions that are difficult to parse in narrative form. An RBAC matrix is the industry standard for this technical documentation. It provides a visual grid mapping user roles to specific system actions, allowing engineers to easily implement backend authorization middleware and QA to systematically test every permission permutation. A narrative essay (Option A) is prone to ambiguity and contradictions. A sequence diagram (Option C) shows flow, not static permission states.',
        ARRAY['rbac', 'permissions']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A 10-page narrative essay describing how each role feels about the tools.', false),
    (v_q_id, 'B', 'An RBAC (Role-Based Access Control) matrix mapping roles to distinct system actions.', true),
    (v_q_id, 'C', 'A sequence diagram showing a user logging in.', false),
    (v_q_id, 'D', 'An API schema definition.', false);

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
        'Tinder''s Handoff Documentation',
        E'Scenario: Tinder''s PM is handing off a new "Super Like" animation feature to engineering. Design has provided a Figma file.\n\nWhat missing technical documentation is required to ensure engineers build exactly what design intended?',
        'intermediate',
        'Tinder',
        'Dating app and social network',
        'B',
        'Micro-interactions and animations are notoriously difficult to hand off from design to engineering. Simply providing a Figma file is insufficient because it lacks the technical parameters required for implementation. A PM and Designer must document the specific easing curves (e.g., cubic-bezier), duration in milliseconds, precise trigger events, and how the animation interacts with system state (e.g., network latency). Without these specs (Option B), engineers will guess, resulting in a clunky user experience. Option A is standard but insufficient for motion.',
        ARRAY['handoff', 'design_specs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The hex codes for the colors.', false),
    (v_q_id, 'B', 'Animation specifications including easing curves, duration in milliseconds, and trigger events.', true),
    (v_q_id, 'C', 'The total number of Super Likes expected per day.', false),
    (v_q_id, 'D', 'A list of users who requested the feature.', false);

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
        'Peloton''s Hardware/Software Specs',
        E'Scenario: Peloton''s PM is writing a PRD for the bike''s resistance knob syncing with the tablet UI.\n\nWhat specific type of non-functional requirement is absolutely critical to document in this hardware-software interaction?',
        'intermediate',
        'Peloton',
        'Connected fitness hardware and software',
        'A',
        'When software interacts with physical hardware, latency is the most critical non-functional requirement. If a user turns a physical resistance knob and the digital UI takes half a second to respond, the product feels broken and disconnected. The PM must explicitly document the maximum acceptable latency (e.g., <50ms) so engineers can architect the firmware and software communication protocols (like WebSockets or local Bluetooth) to meet that strict performance threshold. Options B, C, and D do not address the core software-hardware sync challenge.',
        ARRAY['hardware_software', 'latency_nfrs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Maximum acceptable latency (e.g., "UI must update within 50ms of knob turn") to ensure real-time responsiveness.', true),
    (v_q_id, 'B', 'The brand name of the plastic used for the knob.', false),
    (v_q_id, 'C', 'The battery life of the tablet.', false),
    (v_q_id, 'D', 'The number of calories burned per resistance level.', false);

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
        'Stripe''s RFC Trade-offs',
        E'Scenario: Stripe''s PM is reviewing an engineering RFC. The engineers propose a highly scalable Event Sourcing architecture, but the PM notes it will take 6 months to build. A simpler CRUD architecture takes 1 month but scales poorly after 2 years.\n\nHow should the PM use documentation to resolve this?',
        'advanced',
        'Stripe',
        'Financial infrastructure platform',
        'C',
        'A senior PM''s role in an architectural RFC is not to dictate the code, but to evaluate technical trade-offs against business objectives. By requiring a formal "Alternatives Considered" section with a trade-off matrix, the PM forces engineering to articulate the costs of their choices (e.g., Time-to-market vs. long-term scalability). The PM then aligns the final decision with the company''s current strategic priority. Option A is an overstep of PM authority. Option D is a failure of PM responsibility, as architecture directly impacts product viability.',
        ARRAY['rfc', 'architectural_tradeoffs']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Demand the engineers build the 1-month solution because PMs always dictate architecture.', false),
    (v_q_id, 'B', 'Update the PRD to mandate Event Sourcing but demand a 1-month timeline.', false),
    (v_q_id, 'C', 'Require the RFC to document "Alternatives Considered" with a trade-off matrix, aligning the decision with strategic priorities.', true),
    (v_q_id, 'D', 'Ignore the RFC; architecture is strictly an engineering problem.', false);

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
        'GitHub''s Deprecation Strategy',
        E'Scenario: GitHub is deprecating the v3 REST API in favor of GraphQL. Millions of repos use v3.\n\nWhat advanced documentation strategy should the PM employ to ensure a smooth transition over a 2-year period?',
        'advanced',
        'GitHub',
        'Developer and code hosting platform',
        'B',
        'Deprecating a massive public API requires a meticulously planned, multi-year technical documentation strategy. A phased approach—starting with announcements, moving to "brownouts" (where the API is intentionally turned off for short, scheduled windows to alert developers who ignore emails), and ending with final sunsetting—is essential. Dedicated migration documentation must accompany each phase. Option A is a surefire way to destroy developer trust and cause massive outages. Option C is malicious and unprofessional.',
        ARRAY['deprecation_strategy', 'api_lifecycle']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Send a single email on day 1 and shut down the API on day 730.', false),
    (v_q_id, 'B', 'Create a phased deprecation technical plan (Announce -> Brownouts -> Sunsetting) with dedicated migration docs for each phase.', true),
    (v_q_id, 'C', 'Edit the v3 documentation to randomly insert errors so developers get frustrated and switch.', false),
    (v_q_id, 'D', 'Keep v3 running forever but hide the documentation so no new users find it.', false);

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
        'AWS''s Cross-Service Dependency Matrix',
        E'Scenario: AWS''s PM is launching a new feature in AWS Lambda that requires changes in IAM, CloudWatch, and S3.\n\nWhat advanced documentation artifact is necessary to manage this launch?',
        'advanced',
        'AWS',
        'Cloud infrastructure services',
        'B',
        'When launching a feature that spans multiple distinct microservices or teams, a single PRD is insufficient. A senior PM must utilize a cross-service dependency matrix. This artifact rigorously documents the API contracts between the services, required deployment sequencing (e.g., IAM must deploy before Lambda), and integration testing plans. This prevents cascading failures during launch. Option A ignores the complexity of distributed systems. Option D is a communication channel, not a structured technical artifact.',
        ARRAY['dependency_management', 'launch_readiness']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'A single PRD stored in the Lambda team''s folder.', false),
    (v_q_id, 'B', 'A cross-service dependency matrix detailing API contracts, deployment sequencing, and integration test plans.', true),
    (v_q_id, 'C', 'A marketing press release highlighting how well AWS teams work together.', false),
    (v_q_id, 'D', 'A Slack channel where engineers from all four teams can chat.', false);

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
        'Twilio''s API Friction Analysis',
        E'Scenario: Twilio''s PM is analyzing documentation analytics and support tickets. They find that developers spend an average of 45 minutes on the "Auth Token" documentation page and generate 30% of all support tickets from it.\n\nWhat is the most systemic way the PM should address this via documentation and product?',
        'advanced',
        'Twilio',
        'Communications API platform',
        'C',
        'High time-on-page and high support ticket volume for a specific documentation page are strong signals of bad Developer Experience (DX). While rewriting the docs can provide a band-aid, a senior PM recognizes that if a concept takes 45 minutes to explain, the underlying API architecture is likely overly complex. The systemic solution is to propose an RFC to simplify the product itself, while improving the docs with quick-start examples in the short term. Options A and D are superficial fixes that ignore the root cause.',
        ARRAY['developer_experience', 'api_design']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Add a popup chat window to the doc page asking if they need help.', false),
    (v_q_id, 'B', 'Delete the page so developers rely strictly on StackOverflow.', false),
    (v_q_id, 'C', 'Treat the high time-on-page as a symptom of a flawed API design; propose an RFC to simplify auth, and add quick-start SDK examples.', true),
    (v_q_id, 'D', 'Make the text larger and bold the most important sentences.', false);

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
        'Datadog''s Data Migration Spec',
        E'Scenario: Datadog is changing how they store log retention data, moving from a 30-day cold storage model to a tiered model.\n\nWhat crucial element must the PM ensure is documented in the technical migration plan?',
        'advanced',
        'Datadog',
        'Monitoring and analytics platform',
        'B',
        'Data migrations carry the highest risk of catastrophic failure (data loss). Technical migration documentation must go beyond just the "new state." It absolutely must detail how backward compatibility will be maintained during the transition, the logic for backfilling legacy data into the new schema, and most critically, a step-by-step rollback strategy if the migration corrupts data mid-flight. Option A is irrelevant to engineering execution. Option C is dangerous, as dropping tables should be the absolute last step, not the focus of the plan.',
        ARRAY['data_migration', 'rollback_strategy']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'The marketing messaging for why the new model is better.', false),
    (v_q_id, 'B', 'Backward compatibility handling, data backfill logic, and a rollback strategy if data corruption occurs.', true),
    (v_q_id, 'C', 'The exact SQL queries used to drop the old database tables.', false),
    (v_q_id, 'D', 'The Jira ticket numbers of the engineers who originally built the 30-day model.', false);

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
        'Vercel''s Living PRD',
        E'Scenario: Vercel operates in a highly agile environment where requirements shift weekly based on beta customer feedback. The initial PRD becomes outdated quickly.\n\nHow should a senior PM manage the "Living PRD" to maintain a single source of technical truth without creating documentation overhead?',
        'advanced',
        'Vercel',
        'Frontend application platform',
        'C',
        'In highly agile environments, static PRDs quickly become "dead" documents that no one reads. A senior PM transitions the PRD into an evergreen product spec that acts as the single source of truth. By maintaining a changelog at the top of the document, the PM tracks major strategic pivots and their rationale, providing crucial context for engineers without forcing them to read a new document every week. Option A leads to chaos and lost context. Option B is rigid waterfall thinking that rejects user feedback.',
        ARRAY['living_prd', 'agile_documentation']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Stop writing PRDs entirely and just tell engineers what to do in daily standups.', false),
    (v_q_id, 'B', 'Lock the PRD after week 1 and refuse to accept any changes to scope.', false),
    (v_q_id, 'C', 'Transition the PRD into an evergreen product spec, using a changelog to track major decision pivots and rationale.', true),
    (v_q_id, 'D', 'Create a new PRD document from scratch every single week.', false);

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
        'Slack''s Zero-Downtime Rollback Plan',
        E'Scenario: Slack is migrating its primary messaging database cluster. The PRD specifies zero downtime.\n\nDuring the technical design review, the PM notices the RFC lacks a rollback procedure. Why is the PM correct to block the document''s approval?',
        'advanced',
        'Slack',
        'Enterprise communications platform',
        'B',
        'Zero-downtime migrations are incredibly complex and prone to unpredictable edge cases. If telemetry indicates a failure (e.g., latency spikes, dropped messages), the team cannot waste time figuring out how to revert; the process must be pre-defined. A senior PM must block RFCs that lack a detailed rollback procedure because the absence of one represents an unacceptable risk to business continuity. Option A is bureaucratic box-checking. Option D reflects a toxic, blame-oriented culture rather than a focus on system resilience.',
        ARRAY['zero_downtime', 'rollback_plan']
    )
    RETURNING id INTO v_q_id;

    INSERT INTO question_options (question_id, option_label, option_text, is_correct) VALUES
    (v_q_id, 'A', 'Because standard agile templates require a rollback field to be filled out.', false),
    (v_q_id, 'B', 'Because a zero-downtime operation MUST define the exact threshold and process for reverting changes safely if telemetry indicates failure.', true),
    (v_q_id, 'C', 'Because the PM wants to ensure QA has enough time to write test cases.', false),
    (v_q_id, 'D', 'Because the PM needs to know who to fire if the migration fails.', false);

    RAISE NOTICE 'Successfully inserted 35 questions for technical-documentation';

END $$;
