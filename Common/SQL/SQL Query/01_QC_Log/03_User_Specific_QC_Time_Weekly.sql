-- ============================================================
-- QC LOG — User Specific QC Time (Weekly)
-- Purpose : Time each user spent on QC across a date range
-- Table   : sub_story_log_detail
-- Usage   : Update BETWEEN dates before running
-- ============================================================

SELECT
    l.channel_name,
    l.source,
    l.created_by AS user,

    MIN(l.log_datetime) AS first_log_time,
    MAX(l.log_datetime) AS last_log_time,

    COUNT(DISTINCT l.substory_id) AS number_of_records,

    CONCAT(
        TIMESTAMPDIFF(
            DAY,
            MIN(l.log_datetime),
            MAX(l.log_datetime)
        ),
        ' Days, ',
        TIME_FORMAT(
            SEC_TO_TIME(
                MOD(
                    TIMESTAMPDIFF(
                        SECOND,
                        MIN(l.log_datetime),
                        MAX(l.log_datetime)
                    ),
                    86400
                )
            ),
            '%H:%i:%s'
        )
    ) AS time_taken_to_complete_qc

FROM sub_story_log_detail l

WHERE l.channel_date BETWEEN '2026-05-30' AND '2026-06-05'  -- ⬅ Change Date Range
  AND l.source IN ('NCT', 'Xentaurix', 'Equinox')
  AND l.action_name = 'qc'

GROUP BY
    l.channel_name,
    l.source,
    l.created_by

ORDER BY
    l.channel_name,
    l.created_by;
