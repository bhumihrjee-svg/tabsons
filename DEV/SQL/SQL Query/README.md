# TABSONS — SQL Query Reference
> Complete Query Library | All 7 Sheets Organized

---

## 📁 Folder Structure

```
TABSONS_SQL/
├── 01_QC_Log/
│   ├── 01_User_Specific_QC_Time_Daily.sql         → QC time per user per day
│   ├── 02_Total_Time_Per_Channel_Daily.sql         → Total QC time per channel per day
│   ├── 03_User_Specific_QC_Time_Weekly.sql         → Weekly QC time per user
│   └── 04_WEEKLY_Total_Time_Per_Channel.sql        → Weekly total QC time per channel
│
├── 02_Missing_Videos/
│   ├── Video_Clipper/
│   │   ├── 01_Select_Video_Clipper.sql             → Check existing records
│   │   ├── 02_Update_Sub_Story_Status.sql          → Reset sub_story_status to 0
│   │   └── 03_Insert_Video_Clipper.sql             → Insert missing video manually
│   └── Substory/
│       ├── 01_Select_Sub_Story.sql                 → Check existing substory records
│       ├── 02_Missing_With_Records.sql             → Find missing gaps with details
│       ├── 03_Duplicate_Overlap_With_Records.sql   → Find duplicates and overlaps
│       ├── 04_Duplicate_Overlap_Count.sql          → Count duplicates + overlaps
│       └── 05_Missing_Count.sql                    → Count total missing gaps
│
├── 03_QC_Recovery_Command/
│   └── 01_QC_Recovery_Steps.sql                   → 5-step recovery from shadow table
│
├── 04_Re_Inferencing_Service/
│   ├── 01_Check_Reinferencing_Count.sql            → Check count before update
│   └── 02_Update_Reinferencing_Status.sql          → Reset reinferencing_status to 0
│
├── 05_Missing_Substories/
│   ├── 01_Missing_Video_Clipper_Full_Day.sql       → Full day gaps in video_clipper
│   ├── 02_Missing_Video_Clipper_Per_Day.sql        → Quick time window gaps
│   ├── 03_Final_Missing_Substories.sql             → ✅ Best substory missing query
│   └── 04_Missing_Substories_Full_Day.sql          → Full day gaps with dummy row trick
│
├── 06_QC_Status/
│   ├── 01_Select_Count_And_Update_QC_Flag.sql      → Multi-channel count + update
│   ├── 02_Single_Channel_Update_And_Verify.sql     → Single channel update + verify
│   └── 03_Recover_From_Shadow_Table.sql            → Recover deleted substories
│
└── 07_Channel_Master_Updation/
    └── 01_Channel_Master_Operations.sql            → Update URL, create table, insert
```

---

## ⚡ Quick Guide — What to Change Before Running

Every file has `-- ⬅ Change` comments. Just update the marked values.

| Folder | Common Parameters to Change |
|---|---|
| 01_QC_Log | `channel_date`, date range (`BETWEEN`) |
| 02_Missing_Videos | `channel_code`, `DATE(start_time)`, time range |
| 03_QC_Recovery | `channel_code IN (...)`, date range, `source` |
| 04_Re_Inferencing | No changes needed — run as-is |
| 05_Missing_Substories | Date range (3 places), broadcast start time |
| 06_QC_Status | `channel_code`, date range, `source` |
| 07_Channel_Master | `channel_code`, `stream_url`, `api_url` |

---

## ⚠️ Safety Rules

- Always run **SELECT / COUNT** before any **UPDATE / INSERT**
- Files marked `⚠️` contain write operations — double-check before executing
- For `05_Missing_Substories` — update **all 3 date references** in dummy row queries

---

## 📌 Most Used Queries

| Task | File |
|---|---|
| Daily QC report | `01_QC_Log/01_User_Specific_QC_Time_Daily.sql` |
| Missing substories today | `05_Missing_Substories/03_Final_Missing_Substories.sql` ✅ |
| Missing video clipper | `05_Missing_Substories/01_Missing_Video_Clipper_Full_Day.sql` |
| Reset reinferencing | `04_Re_Inferencing_Service/02_Update_Reinferencing_Status.sql` |
| Recover deleted records | `06_QC_Status/03_Recover_From_Shadow_Table.sql` |
| Weekly QC summary | `01_QC_Log/04_WEEKLY_Total_Time_Per_Channel.sql` |

---

## 🔧 Common Channel Codes

```
1010443, 1010298, 1010022, 1010034, 1015487, 1010115, 1010676, 1010196,
1010020, 1010271, 1010707, 1010129, 1010123, 1010576, 1010281, 1010297,
1010665, 1015370, 1010345, 1015368, 1010004, 1010488, 1010185, 1015496,
1010768, 1010702, 1010485
```

## 🔧 Common Sources
`NCT` · `Xentaurix` · `Equinox` · `nct` *(lowercase for sub_story)*
