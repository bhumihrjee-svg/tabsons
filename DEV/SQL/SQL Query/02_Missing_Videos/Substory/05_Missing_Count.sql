-- ============================================================
-- MISSING VIDEOS — Substory Missing Count
-- Purpose : Count total missing gaps in substory
-- Table   : sub_story
-- Usage   : Update date range before running
-- ============================================================

WITH ordered_clips AS (
    SELECT
        channel_code,
        start_time,
        end_time,
        LAG(end_time) OVER (
            PARTITION BY channel_code
            ORDER BY start_time
        ) AS prev_end_time
    FROM sub_story
    WHERE source = 'nct'
      AND start_time >= '2026-02-24 05:00:00'    -- ⬅ Change Start Time
      AND start_time <= '2026-02-24 23:59:59'    -- ⬅ Change End Time
)
SELECT
    COUNT(*) AS missing_clip_count
FROM ordered_clips
WHERE prev_end_time IS NOT NULL
  AND start_time > prev_end_time
  AND TIMESTAMPDIFF(SECOND, prev_end_time, start_time) > 2;
