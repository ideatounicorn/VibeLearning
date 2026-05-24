-- ============================================
-- SKILLREPORT QUESTION BANK — SUPABASE SCHEMA
-- Run this FIRST before any question inserts.
-- ============================================

-- ============================================
-- ENUMS
-- ============================================

CREATE TYPE difficulty_level AS ENUM ('foundational', 'intermediate', 'advanced');
CREATE TYPE proficiency_level AS ENUM ('weak', 'developing', 'proficient', 'strong');

-- ============================================
-- TABLE 1: categories
-- ============================================
-- Top-level skill categories (e.g., "Product Sense", "Product Analytics")

CREATE TABLE categories (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            TEXT NOT NULL UNIQUE,
    slug            TEXT NOT NULL UNIQUE,
    description     TEXT,
    display_order   INTEGER NOT NULL DEFAULT 0,
    icon_url        TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_categories_display_order ON categories(display_order);

-- ============================================
-- TABLE 2: sub_skills
-- ============================================
-- Individual assessable skills within a category
-- (e.g., "Cohort Analysis" under "Product Analytics")

CREATE TABLE sub_skills (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id     UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    name            TEXT NOT NULL,
    slug            TEXT NOT NULL,
    description     TEXT,
    display_order   INTEGER NOT NULL DEFAULT 0,
    
    -- Assessment configuration
    total_questions         INTEGER NOT NULL DEFAULT 35,
    display_questions       INTEGER NOT NULL DEFAULT 25,
    time_limit_minutes      INTEGER NOT NULL DEFAULT 45,
    passing_score_pct       INTEGER NOT NULL DEFAULT 60,
    proficient_score_pct    INTEGER NOT NULL DEFAULT 75,
    strong_score_pct        INTEGER NOT NULL DEFAULT 90,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    UNIQUE(category_id, slug)
);

CREATE INDEX idx_sub_skills_category ON sub_skills(category_id);
CREATE INDEX idx_sub_skills_display_order ON sub_skills(category_id, display_order);

-- ============================================
-- TABLE 3: questions
-- ============================================
-- Individual MCQ questions linked to a sub-skill

CREATE TABLE questions (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sub_skill_id        UUID NOT NULL REFERENCES sub_skills(id) ON DELETE CASCADE,
    
    -- Question content
    question_number     INTEGER NOT NULL,
    title               TEXT NOT NULL,
    scenario            TEXT NOT NULL,
    difficulty          difficulty_level NOT NULL DEFAULT 'intermediate',
    
    -- Product context
    product_company     TEXT NOT NULL,
    product_context     TEXT,
    
    -- Correct answer
    correct_option      CHAR(1) NOT NULL CHECK (correct_option IN ('A', 'B', 'C', 'D')),
    
    -- Explanation
    explanation         TEXT NOT NULL,
    
    -- Metadata
    tags                TEXT[] DEFAULT '{}',
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    version             INTEGER NOT NULL DEFAULT 1,
    
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    UNIQUE(sub_skill_id, question_number)
);

CREATE INDEX idx_questions_sub_skill ON questions(sub_skill_id);
CREATE INDEX idx_questions_difficulty ON questions(sub_skill_id, difficulty);
CREATE INDEX idx_questions_product ON questions(product_company);
CREATE INDEX idx_questions_active ON questions(sub_skill_id, is_active);
CREATE INDEX idx_questions_tags ON questions USING GIN(tags);

-- ============================================
-- TABLE 4: question_options
-- ============================================
-- The 4 options (A, B, C, D) for each question

CREATE TABLE question_options (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    question_id     UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    option_label    CHAR(1) NOT NULL CHECK (option_label IN ('A', 'B', 'C', 'D')),
    option_text     TEXT NOT NULL,
    is_correct      BOOLEAN NOT NULL DEFAULT FALSE,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    UNIQUE(question_id, option_label)
);

CREATE INDEX idx_options_question ON question_options(question_id);

-- ============================================
-- TABLE 5: user_responses
-- ============================================
-- Tracks individual user answers for scoring and analytics

CREATE TABLE user_responses (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL,
    question_id     UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    sub_skill_id    UUID NOT NULL REFERENCES sub_skills(id) ON DELETE CASCADE,
    
    selected_option CHAR(1) NOT NULL CHECK (selected_option IN ('A', 'B', 'C', 'D')),
    is_correct      BOOLEAN NOT NULL,
    time_taken_secs INTEGER,
    
    session_id      UUID NOT NULL,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_responses_user ON user_responses(user_id);
CREATE INDEX idx_responses_session ON user_responses(session_id);
CREATE INDEX idx_responses_sub_skill ON user_responses(sub_skill_id, user_id);
CREATE INDEX idx_responses_question ON user_responses(question_id);

-- ============================================
-- TABLE 6: assessment_results
-- ============================================
-- Stores the final score per assessment attempt

CREATE TABLE assessment_results (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id             UUID NOT NULL,
    sub_skill_id        UUID NOT NULL REFERENCES sub_skills(id) ON DELETE CASCADE,
    session_id          UUID NOT NULL UNIQUE,
    
    total_questions     INTEGER NOT NULL,
    correct_answers     INTEGER NOT NULL,
    score_pct           NUMERIC(5,2) NOT NULL,
    proficiency         proficiency_level NOT NULL,
    time_taken_secs     INTEGER,
    
    -- Difficulty breakdown
    foundational_correct    INTEGER DEFAULT 0,
    foundational_total      INTEGER DEFAULT 0,
    intermediate_correct    INTEGER DEFAULT 0,
    intermediate_total      INTEGER DEFAULT 0,
    advanced_correct        INTEGER DEFAULT 0,
    advanced_total          INTEGER DEFAULT 0,
    
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_results_user ON assessment_results(user_id);
CREATE INDEX idx_results_sub_skill ON assessment_results(sub_skill_id);
CREATE INDEX idx_results_user_sub_skill ON assessment_results(user_id, sub_skill_id);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE sub_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE assessment_results ENABLE ROW LEVEL SECURITY;

-- Public read for questions (anyone can take assessments)
CREATE POLICY "Public read categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Public read sub_skills" ON sub_skills FOR SELECT USING (true);
CREATE POLICY "Public read questions" ON questions FOR SELECT USING (is_active = true);
CREATE POLICY "Public read options" ON question_options FOR SELECT USING (true);

-- Users can only see their own responses and results
CREATE POLICY "Users read own responses" ON user_responses 
    FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users insert own responses" ON user_responses 
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users read own results" ON assessment_results 
    FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users insert own results" ON assessment_results 
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ============================================
-- HELPER FUNCTION: Get random questions for assessment
-- ============================================

CREATE OR REPLACE FUNCTION get_assessment_questions(p_sub_skill_id UUID)
RETURNS TABLE (
    question_id UUID,
    question_number INTEGER,
    title TEXT,
    scenario TEXT,
    difficulty difficulty_level,
    product_company TEXT,
    option_a TEXT,
    option_b TEXT,
    option_c TEXT,
    option_d TEXT
) AS $$
DECLARE
    v_display_questions INTEGER;
BEGIN
    SELECT display_questions INTO v_display_questions
    FROM sub_skills WHERE id = p_sub_skill_id;
    
    RETURN QUERY
    SELECT 
        q.id AS question_id,
        q.question_number,
        q.title,
        q.scenario,
        q.difficulty,
        q.product_company,
        MAX(CASE WHEN qo.option_label = 'A' THEN qo.option_text END) AS option_a,
        MAX(CASE WHEN qo.option_label = 'B' THEN qo.option_text END) AS option_b,
        MAX(CASE WHEN qo.option_label = 'C' THEN qo.option_text END) AS option_c,
        MAX(CASE WHEN qo.option_label = 'D' THEN qo.option_text END) AS option_d
    FROM questions q
    JOIN question_options qo ON qo.question_id = q.id
    WHERE q.sub_skill_id = p_sub_skill_id
      AND q.is_active = true
    GROUP BY q.id, q.question_number, q.title, q.scenario, q.difficulty, q.product_company
    ORDER BY RANDOM()
    LIMIT v_display_questions;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- HELPER FUNCTION: Calculate proficiency from score
-- ============================================

CREATE OR REPLACE FUNCTION calculate_proficiency(score_pct NUMERIC)
RETURNS proficiency_level AS $$
BEGIN
    IF score_pct >= 90 THEN RETURN 'strong';
    ELSIF score_pct >= 75 THEN RETURN 'proficient';
    ELSIF score_pct >= 60 THEN RETURN 'developing';
    ELSE RETURN 'weak';
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
