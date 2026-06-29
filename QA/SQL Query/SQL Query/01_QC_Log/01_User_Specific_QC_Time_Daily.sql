-- ============================================================
-- QC LOG — User Specific QC Time (Daily)
-- Purpose : Time each user spent on QC per channel per day
-- Table   : sub_story_log_detail
-- Usage   : Update channel_date before running
-- ============================================================

SELECT
    l.channel_name,
    l.source,
    l.channel_date,
    l.created_by AS user,

    MIN(l.log_datetime) AS first_log_time,
    MAX(l.log_datetime) AS last_log_time,

    COUNT(DISTINCT l.substory_id) AS number_of_records,

    SEC_TO_TIME(
        TIMESTAMPDIFF(
            SECOND,
            MIN(l.log_datetime),
            MAX(l.log_datetime)
        )
    ) AS duration_hhmmss

FROM sub_story_log_detail l

WHERE l.channel_date = '2026-06-12'          -- ⬅ Change Date
  AND l.source IN ('NCT', 'Xentaurix', 'Equinox')
  AND l.action_name = 'qc'

GROUP BY
    l.channel_name,
    l.source,
    l.created_by,
    l.channel_date;
