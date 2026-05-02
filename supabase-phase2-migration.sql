-- =============================================
-- VibeLearn Phase 2 Migration
-- Run in Supabase SQL Editor
-- =============================================

-- ============ PROFILES: New columns ============

ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS bio TEXT,
  ADD COLUMN IF NOT EXISTS cover_image_url TEXT,
  ADD COLUMN IF NOT EXISTS available_for_work BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS toolstack TEXT[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS social_links JSONB DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS topic_snippets_enabled BOOLEAN DEFAULT TRUE,
  ADD COLUMN IF NOT EXISTS sound_effects_enabled BOOLEAN DEFAULT TRUE;

-- ============ BOOKMARKS ============

CREATE TABLE IF NOT EXISTS bookmarks (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  content_type TEXT NOT NULL CHECK (content_type IN ('lesson', 'course', 'path')),
  content_id   UUID NOT NULL,
  created_at   TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, content_type, content_id)
);

CREATE INDEX IF NOT EXISTS bookmarks_user_id_idx ON bookmarks(user_id);

ALTER TABLE bookmarks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own bookmarks"
  ON bookmarks FOR ALL USING (auth.uid() = user_id);

-- ============ ACHIEVEMENTS ============

CREATE TABLE IF NOT EXISTS achievements (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  type       TEXT NOT NULL,
  awarded_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, type)
);

ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own achievements"
  ON achievements FOR ALL USING (auth.uid() = user_id);

-- ============ UPDATE profile trigger to handle Google OAuth names ============
-- Google puts display name in raw_user_meta_data->>'full_name' OR 'name'

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (
    new.id,
    COALESCE(
      new.raw_user_meta_data->>'full_name',
      new.raw_user_meta_data->>'name',
      split_part(new.email, '@', 1)
    )
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============ P1 Tables (run when ready) ============
-- Uncomment when building assessments + leagues

-- CREATE TABLE IF NOT EXISTS skill_assessments (
--   id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   title          TEXT NOT NULL,
--   slug           TEXT UNIQUE NOT NULL,
--   description    TEXT,
--   topic          TEXT,
--   level          TEXT CHECK (level IN ('beginner','intermediate','advanced')),
--   question_count INT DEFAULT 10,
--   thumbnail_url  TEXT,
--   is_published   BOOLEAN DEFAULT FALSE,
--   order_index    INT
-- );

-- CREATE TABLE IF NOT EXISTS assessment_questions (
--   id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   assessment_id  UUID REFERENCES skill_assessments(id) ON DELETE CASCADE,
--   question       TEXT NOT NULL,
--   option_a TEXT, option_b TEXT, option_c TEXT, option_d TEXT,
--   correct_option CHAR(1) CHECK (correct_option IN ('a','b','c','d')),
--   explanation    TEXT,
--   order_index    INT
-- );

-- CREATE TABLE IF NOT EXISTS assessment_attempts (
--   id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   user_id       UUID REFERENCES auth.users(id) ON DELETE CASCADE,
--   assessment_id UUID REFERENCES skill_assessments(id),
--   score         INT,
--   total         INT,
--   completed_at  TIMESTAMPTZ DEFAULT now(),
--   xp_awarded    INT DEFAULT 0
-- );

-- CREATE TABLE IF NOT EXISTS league_members (
--   id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   user_id    UUID REFERENCES auth.users(id) ON DELETE CASCADE,
--   league     TEXT DEFAULT 'bronze',
--   weekly_xp  INT DEFAULT 0,
--   week_start DATE,
--   UNIQUE(user_id, week_start)
-- );
