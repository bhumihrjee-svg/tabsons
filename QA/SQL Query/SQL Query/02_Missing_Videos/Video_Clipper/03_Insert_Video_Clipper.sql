-- ============================================================
-- MISSING VIDEOS — Insert Video into Video Clipper
-- Purpose : Manually insert a missing video record
-- Table   : video_clipper
-- Usage   : Update all values before running
-- ⚠️  INSERT query — verify mp4url and times before executing!
-- ============================================================

INSERT INTO video_clipper (
    channel_code,
    start_time,
    end_time,
    mp4url,
    sub_story_status
)
VALUES (
    1010665,                        -- ⬅ Change Channel Code
    '2026-04-02 19:00:00',          -- ⬅ Change Start Time
    '2026-04-02 19:10:00',          -- ⬅ Change End Time
    'https://storage.googleapis.com/imagestg-bucket-qa/Video/1010665_2026.04.02_19.00.00-2026.04.02_19.10.00.mp',  -- ⬅ Change URL
    1
);
