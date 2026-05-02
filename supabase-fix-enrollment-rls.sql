-- Fix: course_enrollments missing RLS + policies
-- Run in Supabase SQL Editor

ALTER TABLE course_enrollments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own enrollments"
  ON course_enrollments FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own enrollments"
  ON course_enrollments FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own enrollments"
  ON course_enrollments FOR DELETE USING (auth.uid() = user_id);
