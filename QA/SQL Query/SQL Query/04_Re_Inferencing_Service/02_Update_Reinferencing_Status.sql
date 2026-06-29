-- ============================================================
-- RE-INFERENCING SERVICE — Update Re-Inferencing Status
-- Purpose : Reset reinferencing_status from 1 to 0
-- Table   : sub_story
-- ⚠️  Run 01_Check_Reinferencing_Count.sql FIRST to verify count
-- ⚠️  UPDATE query — double check before executing!
-- ============================================================

UPDATE sub_story
SET reinferencing_status = 0
WHERE reinferencing_status = 1;
