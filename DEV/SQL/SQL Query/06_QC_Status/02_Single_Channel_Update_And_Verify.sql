-- ============================================================
-- QC STATUS — Single Channel Update & Verify
-- Purpose : Update qc_flag for a single channel + verify count
-- Table   : sub_story
-- Usage   : Update channel_code, date range, source before running
-- ============================================================

-- STEP 1: Update qc_flag for single channel
-- ⚠️  UPDATE query — double check before executing!
UPDATE sub_story
SET qc_flag = 1
WHERE channel_code = 1010013                        -- ⬅ Change Channel Code
  AND start_time >= '2026-06-06 00:00:00'           -- ⬅ Change Start Date
  AND start_time <  '2026-06-13 00:00:00'           -- ⬅ Change End Date
  AND source IN ('Equinox', 'Xentaurix');           -- ⬅ Change Source if needed

-- ============================================================

-- STEP 2: Verify updated count
SELECT COUNT(*) AS total_records
FROM sub_story
WHERE channel_code = 1010013                        -- ⬅ Change Channel Code
  AND start_time >= '2026-06-06 00:00:00'           -- ⬅ Change Start Date
  AND start_time <  '2026-06-13 00:00:00'           -- ⬅ Change End Date
  AND source IN ('Equinox', 'Xentaurix');
