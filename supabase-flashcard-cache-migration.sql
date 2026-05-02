-- Add flashcard_data cache column to courses
ALTER TABLE courses ADD COLUMN IF NOT EXISTS flashcard_data JSONB;
