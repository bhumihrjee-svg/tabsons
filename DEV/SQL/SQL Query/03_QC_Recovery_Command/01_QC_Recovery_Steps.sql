-- ============================================================
-- QC RECOVERY COMMAND
-- Purpose : Recover QC records from shadow table
-- Tables  : sub_story_shadow_table, sub_story_log_detail, sub_story
-- Usage   : Update channel_codes, date range, source before running
-- ============================================================

-- STEP 1: Check records in shadow table
SELECT *
FROM sub_story_shadow_table
WHERE channel_code IN (1010259, 1010088)          -- ⬅ Change Channel Codes
  AND start_time >= '2026-06-19 00:00:00'         -- ⬅ Change Start Date
  AND start_time <  '2026-06-20 00:00:00'         -- ⬅ Change End Date
  AND source IN ('Equinox', 'Xentaurix');          -- ⬅ Change Source if needed

-- ============================================================

-- STEP 2: Check log count per substory
SELECT
    l.substory_id,
    COUNT(*) AS log_count
FROM sub_story_log_detail l
WHERE l.substory_id IN (
    SELECT id
    FROM sub_story_shadow_table
    WHERE channel_code IN (1010259, 1010088)      -- ⬅ Change Channel Codes
      AND start_time >= '2026-06-19 00:00:00'     -- ⬅ Change Start Date
      AND start_time <  '2026-06-20 00:00:00'     -- ⬅ Change End Date
      AND source IN ('Equinox', 'Xentaurix')
)
GROUP BY l.substory_id
ORDER BY log_count DESC;

-- ============================================================

-- STEP 3: Count total QC records (by channel + date)
SELECT COUNT(*) AS total_qc_records
FROM sub_story_log_detail l
JOIN sub_story_shadow_table s
    ON l.substory_id = s.substory_id
WHERE s.channel_code IN (1010259, 1010088)        -- ⬅ Change Channel Codes
  AND s.start_time >= '2026-06-19 00:00:00'       -- ⬅ Change Start Date
  AND s.start_time <  '2026-06-20 00:00:00'       -- ⬅ Change End Date
  AND s.source IN ('Equinox', 'Xentaurix')
  AND l.action_name = 'QC';

-- ============================================================

-- STEP 4: Count total QC records (by created_on date)
SELECT COUNT(*) AS total_qc_records
FROM sub_story_log_detail l
JOIN sub_story_shadow_table s
    ON l.substory_id = s.substory_id
WHERE s.created_on >= '2026-06-19 00:00:00'       -- ⬅ Change Start Date
  AND s.created_on <  '2026-06-20 00:00:00'       -- ⬅ Change End Date
  AND l.action_name = 'QC';

-- ============================================================

-- STEP 5: Verify records in sub_story
SELECT *
FROM sub_story
WHERE channel_code IN (1010259, 1010088)          -- ⬅ Change Channel Codes
  AND start_time >= '2026-06-19 00:00:00'         -- ⬅ Change Start Date
  AND start_time <  '2026-06-20 00:00:00'         -- ⬅ Change End Date
  AND source IN ('Equinox', 'Xentaurix');
