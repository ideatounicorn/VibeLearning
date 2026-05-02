-- Phase 4 Migration: Certificates, Assessment Topics, Path Enrollment

-- ============================================================
-- CERTIFICATES TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS certificates (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type          TEXT NOT NULL CHECK (type IN ('course', 'path', 'assessment')),
  reference_id  UUID NOT NULL,      -- course_id, path_id, or assessment_id
  reference_name TEXT NOT NULL,     -- course/path/assessment title at time of issue
  issued_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  certificate_number TEXT NOT NULL UNIQUE DEFAULT 'VL-' || upper(substring(gen_random_uuid()::text, 1, 8)),
  recipient_name TEXT,              -- snapshot of user's full_name at time of issue
  UNIQUE(user_id, type, reference_id)
);

ALTER TABLE certificates ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own certificates" ON certificates
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Public can read certificates by id" ON certificates
  FOR SELECT USING (true);

CREATE POLICY "Service role can insert certificates" ON certificates
  FOR INSERT WITH CHECK (true);

-- ============================================================
-- ASSESSMENT QUESTIONS: add topic field for report breakdown
-- ============================================================
ALTER TABLE assessment_questions
  ADD COLUMN IF NOT EXISTS topic TEXT;

-- ============================================================
-- PATH ENROLLMENTS TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS path_enrollments (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  path_id     UUID NOT NULL REFERENCES paths(id) ON DELETE CASCADE,
  enrolled_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, path_id)
);

ALTER TABLE path_enrollments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own path enrollments" ON path_enrollments
  FOR ALL USING (auth.uid() = user_id);

-- ============================================================
-- COURSE INTRO SEEN: track if user has seen the intro
-- (we always show it per your requirement, so this is just for
--  potential future "skip intro" feature)
-- ============================================================
CREATE TABLE IF NOT EXISTS course_intro_views (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id  UUID NOT NULL,
  viewed_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, course_id)
);

ALTER TABLE course_intro_views ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage own intro views" ON course_intro_views
  FOR ALL USING (auth.uid() = user_id);
