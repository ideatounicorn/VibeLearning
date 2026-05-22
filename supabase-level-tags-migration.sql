-- ============================================================
-- Migration: Add level and tags columns to courses table
-- Run this in your Supabase SQL Editor (prod + staging)
-- ============================================================

-- Add 'level' column if it doesn't exist
ALTER TABLE courses
  ADD COLUMN IF NOT EXISTS level TEXT DEFAULT 'beginner'
  CHECK (level IN ('beginner', 'intermediate', 'advanced'));

-- Add 'tags' column if it doesn't exist
ALTER TABLE courses
  ADD COLUMN IF NOT EXISTS tags TEXT[] DEFAULT '{}';

-- Create an index on tags for faster array searches
CREATE INDEX IF NOT EXISTS idx_courses_tags ON courses USING gin(tags);

-- Create an index on level for faster filtering
CREATE INDEX IF NOT EXISTS idx_courses_level ON courses (level);

-- Optional: backfill sensible defaults for existing courses based on order_index
-- Courses with lower order_index are typically beginner-level
UPDATE courses SET level = 'beginner'   WHERE order_index < 3  AND level = 'beginner';
UPDATE courses SET level = 'intermediate' WHERE order_index >= 3 AND order_index < 6 AND level = 'beginner';
UPDATE courses SET level = 'advanced'     WHERE order_index >= 6 AND level = 'beginner';

-- Also create the waitlist table (used by the Data Analysis waitlist form)
CREATE TABLE IF NOT EXISTS waitlist (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email       TEXT NOT NULL,
  path_slug   TEXT NOT NULL DEFAULT 'data-analysis',
  created_at  TIMESTAMPTZ DEFAULT now(),
  UNIQUE(email, path_slug)
);

-- RLS: no user needs to read the waitlist, only insert
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can join waitlist"
  ON waitlist FOR INSERT
  WITH CHECK (true);
