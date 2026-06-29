# Tabsons

A structured project workspace organized by environment and team, with task tracking and documentation.

---

## 📁 Repository Structure

```
tabsons/
├── Common/                        # Shared resources used across environments
├── DEV/                           # Development environment files and configs
├── QA/                            # Quality Assurance environment files and test assets
├── Documents/                     # Project documentation and reference materials
├── Tabsons task And hours.xlsx    # Task tracking and hour logging spreadsheet
└── .vscode/                       # VS Code workspace settings
```

### Folder Descriptions

| Folder | Purpose |
|--------|---------|
| `Common/` | Shared utilities, configs, or assets used by both DEV and QA |
| `DEV/` | Development-specific files, scripts, or environment setup |
| `QA/` | Test cases, QA scripts, and quality assurance resources |
| `Documents/` | Project documentation, specifications, and reference materials |

---

## 📊 Task & Hours Tracking

The file **`Tabsons task And hours.xlsx`** is used to log:
- Tasks assigned to team members
- Estimated vs. actual hours
- Task status and progress

Open this file to view or update the current workload and time tracking.

---

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/bhumihrjee-svg/tabsons.git
   cd tabsons
   ```

2. **Open in VS Code** (recommended — workspace settings are included)
   ```bash
   code .
   ```

3. Navigate to the relevant folder based on your role:
   - **Developers** → `DEV/`
   - **QA Engineers** → `QA/`
   - **All team members** → `Common/` and `Documents/`

---

## 🤝 Contributing

1. Create a new branch for your work:
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. Make your changes and commit with a clear message:
   ```bash
   git commit -m "Add: description of your change"
   ```
3. Push and open a Pull Request against `main`.

---

## 📌 Notes

- Keep the `Common/` folder clean — only add files that are genuinely shared across environments.
- Update `Tabsons task And hours.xlsx` regularly to keep task tracking accurate.
- For any project documentation updates, use the `Documents/` folder.

---

*Maintained by [@bhumihrjee-svg](https://github.com/bhumihrjee-svg)*
