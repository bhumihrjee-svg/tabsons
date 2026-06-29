-- ============================================================
-- RE-INFERENCING SERVICE — Check Count
-- Purpose : Count records where reinferencing_status = 1
-- Table   : sub_story
-- Usage   : Run as-is to check before updating
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM sub_story
WHERE reinferencing_status = 1;
