-- =============================================
-- Phase 5: Course Generation Pipeline Tables
-- Run in Supabase SQL Editor
-- =============================================

-- Contributing YouTube creators per course
CREATE TABLE IF NOT EXISTS course_creators (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id     UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  channel_name  TEXT NOT NULL,
  channel_url   TEXT NOT NULL,
  avatar_url    TEXT,
  video_count   INT DEFAULT 1,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(course_id, channel_url)
);
CREATE INDEX IF NOT EXISTS idx_course_creators_course_id ON course_creators(course_id);

-- Raw YouTube transcripts per lesson (needed for LLM content generation)
CREATE TABLE IF NOT EXISTS lesson_transcripts (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id        UUID NOT NULL UNIQUE REFERENCES lessons(id) ON DELETE CASCADE,
  transcript_text  TEXT NOT NULL DEFAULT '',
  segments_jsonb   JSONB DEFAULT '[]',
  fetched_at       TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_lesson_transcripts_lesson_id ON lesson_transcripts(lesson_id);

-- Pause-and-apply exercises per lesson
CREATE TABLE IF NOT EXISTS exercises (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id        UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  type             TEXT NOT NULL DEFAULT 'pause-apply'
                   CHECK (type IN ('pause-apply', 'screenshot', 'practice', 'reflection')),
  prompt           TEXT NOT NULL,
  screenshot_hint  TEXT,
  order_index      INT DEFAULT 0,
  created_at       TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_exercises_lesson_id ON exercises(lesson_id);

-- Module recap: key takeaways + exercises shown after all lessons done
CREATE TABLE IF NOT EXISTS module_recaps (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id        UUID NOT NULL UNIQUE REFERENCES modules(id) ON DELETE CASCADE,
  key_takeaways    TEXT[] DEFAULT '{}',
  exercises_jsonb  JSONB DEFAULT '[]',
  created_at       TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_module_recaps_module_id ON module_recaps(module_id);

-- Generic intro slides for course-level and module-level onboarding
CREATE TABLE IF NOT EXISTS intro_screens (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  scope         TEXT NOT NULL CHECK (scope IN ('course', 'module')),
  scope_id      UUID NOT NULL,
  order_index   INT NOT NULL DEFAULT 0,
  slide_type    TEXT NOT NULL,
  content_jsonb JSONB NOT NULL DEFAULT '{}',
  created_at    TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_intro_screens_scope_id ON intro_screens(scope, scope_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_intro_screens_unique_slide ON intro_screens(scope, scope_id, order_index);

-- ── RLS Policies ─────────────────────────────────────────────────────────────
-- Note: CREATE POLICY has no IF NOT EXISTS — drop first if re-running

ALTER TABLE course_creators ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "course_creators_select" ON course_creators;
CREATE POLICY "course_creators_select" ON course_creators FOR SELECT USING (true);

ALTER TABLE lesson_transcripts ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "transcripts_select" ON lesson_transcripts;
CREATE POLICY "transcripts_select" ON lesson_transcripts FOR SELECT USING (auth.role() = 'authenticated');

ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "exercises_select" ON exercises;
CREATE POLICY "exercises_select" ON exercises FOR SELECT USING (true);

ALTER TABLE module_recaps ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "module_recaps_select" ON module_recaps;
CREATE POLICY "module_recaps_select" ON module_recaps FOR SELECT USING (true);

ALTER TABLE intro_screens ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "intro_screens_select" ON intro_screens;
CREATE POLICY "intro_screens_select" ON intro_screens FOR SELECT USING (true);
