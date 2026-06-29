-- ============================================================
-- MISSING VIDEOS — Select from Sub Story
-- Purpose : Check existing sub_story records for a channel
-- Table   : sub_story
-- Usage   : Update channel_code, date and source before running
-- ============================================================

SELECT *
FROM sub_story
WHERE channel_code = 1010665              -- ⬅ Change Channel Code
  AND DATE(start_time) = '2026-05-21'    -- ⬅ Change Date
  AND source = 'NCT'                     -- ⬅ Change Source if needed
ORDER BY start_time DESC
LIMIT 3000;
