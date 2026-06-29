-- ============================================================
-- QC STATUS — Select Count & Update QC Flag (Multi-Channel)
-- Purpose : Check count then update qc_flag for channels
-- Table   : sub_story
-- Usage   : Update channel_codes, date range, source before running
-- ============================================================

-- STEP 1: Check count before updating
SELECT COUNT(*) AS total_records
FROM sub_story
WHERE channel_code IN (1010185, 1010123, 1010488)  -- ⬅ Change Channel Codes
  AND start_time >= '2026-06-09 00:00:00'           -- ⬅ Change Start Date
  AND start_time <  '2026-06-11 00:00:00'           -- ⬅ Change End Date
  AND source = 'NCT';                               -- ⬅ Change Source if needed

-- ============================================================

-- STEP 2: Update qc_flag
-- ⚠️  Run STEP 1 first to verify count before executing this!
UPDATE sub_story
SET qc_flag = 1
WHERE channel_code IN (1010185, 1010123, 1010488)  -- ⬅ Change Channel Codes
  AND start_time >= '2026-06-09 00:00:00'           -- ⬅ Change Start Date
  AND start_time <  '2026-06-11 00:00:00'           -- ⬅ Change End Date
  AND source = 'NCT';                               -- ⬅ Change Source if needed
