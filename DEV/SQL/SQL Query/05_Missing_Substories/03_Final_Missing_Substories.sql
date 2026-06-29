-- ============================================================
-- MISSING SUBSTORIES — Final Missing Substories ✅ (Recommended)
-- Purpose : Find missing substory gaps per channel (per day)
-- Tables  : sub_story, channel_schedule
-- Source  : nct
-- Usage   : Update date range before running
-- ============================================================

WITH ordered_data AS (
    SELECT
        channel_code,
        start_time,
        end_time,
        COALESCE(
            LEAD(start_time) OVER (
                PARTITION BY channel_code
                ORDER BY start_time
            ),
            '2026-06-18 00:00:00'                 -- ⬅ Match End Date
        ) AS next_start_time
    FROM sub_story
    WHERE channel_code IN (
        SELECT channel_code
        FROM channel_schedule
        WHERE active = 1
    )
      AND source = 'nct'
      AND start_time >= '2026-06-17 00:00:00'     -- ⬅ Change Start Date
      AND start_time <  '2026-06-18 00:00:00'     -- ⬅ Change End Date
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
ORDER BY gap_duration DESC;
