-- ============================================================
-- MISSING SUBSTORIES — Missing Video Clipper (Full Day)
-- Purpose : Find all missing gaps in video_clipper for a full day
-- Tables  : video_clipper, channel_schedule
-- Usage   : Update all 3 date references before running
-- ============================================================

WITH all_data AS (

    -- Actual records
    SELECT
        channel_code,
        start_time,
        end_time
    FROM video_clipper
    WHERE channel_code IN (
        SELECT channel_code
        FROM channel_schedule
        WHERE active = 1
    )
      AND start_time >= '2026-06-22 00:00:00'     -- ⬅ Change Start Date
      AND start_time <  '2026-06-23 00:00:00'     -- ⬅ Change End Date

    UNION ALL

    -- Dummy row to detect gap before first clip of the day
    SELECT
        channel_code,
        '2026-06-22 05:50:00' AS start_time,      -- ⬅ Match Start Date (broadcast start)
        '2026-06-22 05:50:00' AS end_time
    FROM channel_schedule
    WHERE active = 1
),

ordered_data AS (
    SELECT
        channel_code,
        start_time,
        end_time,
        COALESCE(
            LEAD(start_time) OVER (
                PARTITION BY channel_code
                ORDER BY start_time
            ),
            '2026-06-23 00:00:00'                 -- ⬅ Match End Date
        ) AS next_start_time
    FROM all_data
)

SELECT
    channel_code,
    end_time          AS missed_duration_start,
    next_start_time   AS missed_duration_end,
    TIME_FORMAT(
        TIMEDIFF(next_start_time, end_time),
        '%H:%i:%s'
    ) AS gap_duration
FROM ordered_data
WHERE TIMESTAMPDIFF(
          SECOND,
          end_time,
          next_start_time
      ) >= 1
ORDER BY TIMEDIFF(next_start_time, end_time) DESC;
