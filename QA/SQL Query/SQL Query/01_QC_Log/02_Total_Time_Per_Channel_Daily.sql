-- ============================================================
-- QC LOG — Total Time Taken to Complete Each Channel QC (Daily)
-- Purpose : Overall time per channel (no user breakdown)
-- Table   : sub_story_log_detail
-- Usage   : Update channel_date before running
-- ============================================================

SELECT
    l.channel_name,
    l.source,
    l.channel_date,

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

WHERE l.channel_date = '2026-06-06'          -- ⬅ Change Date
  AND l.source IN ('NCT', 'Xentaurix', 'Equinox')
  AND l.action_name = 'qc'

GROUP BY
    l.channel_name,
    l.source,
    l.channel_date;
