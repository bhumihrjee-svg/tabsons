-- ============================================================
-- MISSING VIDEOS — Update sub_story_status in Video Clipper
-- Purpose : Reset sub_story_status to 0 for a time window
-- Table   : video_clipper
-- Usage   : Update channel_code and time range before running
-- ⚠️  UPDATE query — double check before executing!
-- ============================================================

UPDATE video_clipper
SET sub_story_status = '0'
WHERE channel_code = '1010665'                    -- ⬅ Change Channel Code
  AND start_time >= '2026-05-21 19:10:00'         -- ⬅ Change Start Time
  AND end_time   <= '2026-05-21 22:30:00';        -- ⬅ Change End Time
