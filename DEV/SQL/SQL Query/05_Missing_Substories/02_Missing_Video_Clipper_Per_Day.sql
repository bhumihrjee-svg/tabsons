-- ============================================================
-- MISSING SUBSTORIES — Missing Video Clipper Per Day (Quick)
-- Purpose : Find missing gaps for a specific time window
-- Table   : video_clipper
-- Usage   : Update time window before running
-- ============================================================

WITH ordered AS (
    SELECT
        channel_code,
        start_time,
        end_time,
        LEAD(start_time) OVER (
            PARTITION BY channel_code
            ORDER BY start_time
        ) AS next_start
    FROM video_clipper
    WHERE start_time > '2026-06-26 06:00:00'      -- ⬅ Change Start Time
      AND start_time < '2026-06-26 23:59:59'      -- ⬅ Change End Time
),
gaps AS (
    SELECT
        channel_code,
        end_time      AS missing_from,
        next_start    AS missed_until,
        TIMEDIFF(next_start, end_time) AS missing_duration
    FROM ordered
    WHERE next_start IS NOT NULL
      AND next_start > end_time
)

SELECT
    channel_code,
    missing_from,
    missed_until,
    missing_duration
FROM gaps
ORDER BY channel_code, missing_from;
