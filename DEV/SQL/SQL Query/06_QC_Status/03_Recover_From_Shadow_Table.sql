-- ============================================================
-- QC STATUS — Recover Deleted Records from Shadow Table
-- Purpose : Find deleted substory records for a channel
-- Table   : sub_story_shadow_table
-- Usage   : Update channel_code, source, date range before running
-- ============================================================

SELECT sst.*
FROM sub_story_shadow_table sst
WHERE sst.channel_code = 1010269                   -- ⬅ Change Channel Code
  AND UPPER(sst.source) = 'XENTAURIX'             -- ⬅ Change Source if needed
  AND sst.event = 'delete'
  AND sst.start_time >= '2026-06-19 00:00:00'     -- ⬅ Change Start Date
  AND sst.start_time <  '2026-06-20 00:00:00'     -- ⬅ Change End Date
ORDER BY sst.start_time;
