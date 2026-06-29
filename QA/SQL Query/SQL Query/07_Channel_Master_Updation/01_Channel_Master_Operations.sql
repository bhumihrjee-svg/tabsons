-- ============================================================
-- CHANNEL MASTER UPDATION
-- Purpose : Update stream URL, create table, check and insert
-- Tables  : channel_master, channel_api_map
-- ============================================================

-- ============================================================
-- STEP 1: Update UDP / Stream URL
-- ⚠️  UPDATE query — verify channel_code and URL before executing!
-- ============================================================

UPDATE channel_master
SET stream_url = 'udp://239.4.1.65:1465?localaddr=10.18.18.98'  -- ⬅ Change URL
WHERE channel_code = '1016029';                                   -- ⬅ Change Channel Code

-- ============================================================
-- STEP 2: Create channel_api_map Table (run once if not exists)
-- ============================================================

CREATE TABLE IF NOT EXISTS channel_api_map (
    channel_code VARCHAR(32)  NOT NULL PRIMARY KEY,
    api_url      VARCHAR(255) NOT NULL
);

-- ============================================================
-- STEP 3: Check Existing Values in channel_api_map
-- ============================================================

SELECT * FROM channel_api_map;

-- ============================================================
-- STEP 4: Insert New Channel into channel_api_map
-- ⚠️  INSERT query — verify channel_code and api_url before executing!
-- ============================================================

INSERT INTO channel_api_map (channel_code, api_url)
VALUES (
    '1010034',                                          -- ⬅ Change Channel Code
    'https://cdapi3.tabsons.co.in/api/api.asmx'        -- ⬅ Change API URL
);
