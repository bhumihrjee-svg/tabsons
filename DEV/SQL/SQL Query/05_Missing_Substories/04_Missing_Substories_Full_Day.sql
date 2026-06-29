-- ============================================================
-- MISSING SUBSTORIES — Missing Substories Full Day (with Dummy Row)
-- Purpose : Detect gaps including before first substory of the day
-- Tables  : sub_story, channel_schedule
-- Source  : nct
-- Usage   : Update all 3 date references before running
-- ============================================================

WITH all_data AS (

    -- Actual substory records
    SELECT
        channel_code,
        start_time,
        end_time
    FROM sub_story
    WHERE channel_code IN (
        SELECT channel_code
        FROM channel_schedule
        WHERE active = 1
    )
      AND source = 'nct'
      AND start_time >= '2026-06-22 00:00:00'     -- ⬅ Change Start Date
      AND start_time <  '2026-06-23 00:00:00'     -- ⬅ Change End Date

    UNION ALL

    -- Dummy row to detect gap before first substory of the day
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
