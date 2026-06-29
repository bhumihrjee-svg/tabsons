-- ============================================================
-- MISSING VIDEOS — Substory Missing With Records
-- Purpose : Find gaps between substory records per channel
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
    channel_code,
    prev_end_time AS missing_from,
    start_time    AS missing_to,
    SEC_TO_TIME(
        TIMESTAMPDIFF(SECOND, prev_end_time, start_time)
    ) AS duration_hms
FROM ordered_clips
WHERE prev_end_time IS NOT NULL
  AND start_time > prev_end_time
  AND TIMESTAMPDIFF(SECOND, prev_end_time, start_time) > 2
ORDER BY channel_code ASC;
