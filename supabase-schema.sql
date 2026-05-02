-- =============================================
-- VibeLearn — Full Supabase Schema
-- Run this in Supabase SQL Editor (Project → SQL Editor → New Query)
-- =============================================

-- ============ TABLES ============

CREATE TABLE IF NOT EXISTS paths (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT NOT NULL,
  slug             TEXT UNIQUE NOT NULL,
  description      TEXT,
  category         TEXT,           -- 'AI', 'Design', 'Product', 'Marketing', 'Data'
  image_url        TEXT,
  hero_color       TEXT,           -- hex, e.g. '#6366F1'
  total_hours      NUMERIC,
  total_modules    INT,
  is_published     BOOLEAN DEFAULT FALSE,
  is_coming_soon   BOOLEAN DEFAULT FALSE,
  order_index      INT,
  salary_range     TEXT,           -- e.g. '$50K–$120K/yr'
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS courses (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  path_id      UUID REFERENCES paths(id) ON DELETE CASCADE,
  title        TEXT NOT NULL,
  slug         TEXT NOT NULL,
  description  TEXT,
  thumbnail_url TEXT,
  order_index  INT,
  is_hidden    BOOLEAN DEFAULT FALSE,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS modules (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id   UUID REFERENCES courses(id) ON DELETE CASCADE,
  legacy_id   TEXT,               -- original MongoDB _id
  title       TEXT NOT NULL,
  slug        TEXT,
  description TEXT,
  order_index INT,
  is_free     BOOLEAN DEFAULT FALSE,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX IF NOT EXISTS modules_course_slug_idx ON modules(course_id, slug);

CREATE TABLE IF NOT EXISTS lessons (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id        UUID REFERENCES modules(id) ON DELETE CASCADE,
  legacy_id        TEXT,
  title            TEXT NOT NULL,
  youtube_url      TEXT NOT NULL,
  youtube_video_id TEXT,          -- NULL for playlist URLs
  order_index      INT,
  duration_minutes NUMERIC,
  why_this_video   TEXT,          -- Gemini-generated
  skills_gained    TEXT[],        -- Gemini-generated tags
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS quizzes (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id      UUID REFERENCES modules(id) ON DELETE CASCADE,
  question       TEXT NOT NULL,
  option_a       TEXT NOT NULL,
  option_b       TEXT NOT NULL,
  option_c       TEXT NOT NULL,
  option_d       TEXT NOT NULL,
  correct_option TEXT NOT NULL CHECK (correct_option IN ('a','b','c','d')),
  explanation    TEXT,
  order_index    INT DEFAULT 1,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS profiles (
  id                    UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name             TEXT,
  selected_path_id      UUID REFERENCES paths(id),
  career_goal           TEXT,
  experience_level      TEXT,    -- 'beginner' | 'some' | 'intermediate'
  daily_goal_minutes    INT DEFAULT 30,
  onboarding_completed  BOOLEAN DEFAULT FALSE,
  xp_total              INT DEFAULT 0,
  streak_days           INT DEFAULT 0,
  last_activity_date    DATE,
  created_at            TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS lesson_progress (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID REFERENCES profiles(id) ON DELETE CASCADE,
  lesson_id    UUID REFERENCES lessons(id) ON DELETE CASCADE,
  started_at   TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  UNIQUE(user_id, lesson_id)
);

CREATE TABLE IF NOT EXISTS module_progress (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID REFERENCES profiles(id) ON DELETE CASCADE,
  module_id    UUID REFERENCES modules(id) ON DELETE CASCADE,
  completed_at TIMESTAMPTZ,
  quiz_score   INT,
  quiz_passed  BOOLEAN,
  quiz_attempts INT DEFAULT 0,
  xp_awarded   INT DEFAULT 0,
  UNIQUE(user_id, module_id)
);

CREATE TABLE IF NOT EXISTS subscriptions (
  id                     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                UUID REFERENCES profiles(id) ON DELETE CASCADE,
  polar_subscription_id  TEXT UNIQUE,
  polar_customer_id      TEXT,
  status                 TEXT NOT NULL,  -- 'active'|'cancelled'|'expired'|'past_due'
  tier                   TEXT DEFAULT 'pro',
  current_period_end     TIMESTAMPTZ,
  created_at             TIMESTAMPTZ DEFAULT NOW(),
  updated_at             TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS course_enrollments (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID REFERENCES profiles(id) ON DELETE CASCADE,
  course_id    UUID REFERENCES courses(id) ON DELETE CASCADE,
  enrolled_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, course_id)
);

CREATE TABLE IF NOT EXISTS onboarding_responses (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 UUID REFERENCES profiles(id) ON DELETE CASCADE,
  career_goal             TEXT,
  known_tools             TEXT[],
  experience_answers      JSONB,
  recommended_path_slug   TEXT,
  created_at              TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS reflections (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES profiles(id) ON DELETE CASCADE,
  lesson_id  UUID REFERENCES lessons(id) ON DELETE CASCADE,
  text       TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, lesson_id)
);

-- ============ ROW LEVEL SECURITY ============

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own profile"
  ON profiles FOR ALL USING (auth.uid() = id);

ALTER TABLE lesson_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own lesson progress"
  ON lesson_progress FOR ALL USING (auth.uid() = user_id);

ALTER TABLE module_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own module progress"
  ON module_progress FOR ALL USING (auth.uid() = user_id);

ALTER TABLE reflections ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own reflections"
  ON reflections FOR ALL USING (auth.uid() = user_id);

ALTER TABLE onboarding_responses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own onboarding"
  ON onboarding_responses FOR ALL USING (auth.uid() = user_id);

ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own subscriptions"
  ON subscriptions FOR ALL USING (auth.uid() = user_id);

-- Public read for content tables (no RLS) — access control done in API layer
-- paths, courses, modules, lessons, quizzes: public read

-- ============ AUTO-CREATE PROFILE ON SIGNUP ============

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (new.id, new.raw_user_meta_data->>'full_name')
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE handle_new_user();
