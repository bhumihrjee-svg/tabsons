-- ============================================================
-- MISSING VIDEOS — Substory Duplicate Overlap With Records
-- Purpose : Find duplicate and overlapping substory records
-- Table   : sub_story
-- Usage   : Update date range and channel_code list before running
-- ============================================================

WITH base AS (
    SELECT
        s.*,
        LAG(start_time) OVER (
            PARTITION BY channel_code
            ORDER BY start_time
        ) AS prev_start_time,
        LAG(end_time) OVER (
            PARTITION BY channel_code
            ORDER BY start_time
        ) AS prev_end_time
    FROM sub_story s
    WHERE source = 'nct'
      AND start_time >= '2026-02-24 05:00:00'    -- ⬅ Change Start Time
      AND start_time <  '2026-02-24 23:59:59'    -- ⬅ Change End Time
      AND channel_code IN (
            1010443,1010298,1010022,1010034,1015487,1010115,1010676,1010196,
            1010020,1010271,1010707,1010129,1010123,1010576,1010281,1010297,
            1010665,1015370,1010345,1015368,1010004,1010488,1010185,1015496,
            1010768,1010702,1010485
      )
),
dups AS (
    SELECT
        channel_code, start_time, end_time
    FROM base
    GROUP BY channel_code, start_time, end_time
    HAVING COUNT(*) > 1
)
SELECT *
FROM base
WHERE
      (channel_code, start_time, end_time) IN (
          SELECT channel_code, start_time, end_time FROM dups
      )
   OR
      (prev_end_time IS NOT NULL AND start_time < prev_end_time)
ORDER BY channel_code, start_time;
