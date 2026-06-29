-- ============================================================
-- MISSING VIDEOS — Select from Video Clipper
-- Purpose : Check existing video clipper records for a channel
-- Table   : video_clipper
-- Usage   : Update channel_code and date before running
-- ============================================================

SELECT *
FROM video_clipper
WHERE channel_code = 1010665              -- ⬅ Change Channel Code
  AND DATE(start_time) = '2026-05-21'    -- ⬅ Change Date
ORDER BY start_time DESC
LIMIT 1000;
