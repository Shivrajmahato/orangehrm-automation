# OrangeHRM Automation Framework

## 💻 How to Setup
```bash
pip install -r requirements.txt
```

## ▶️ Start Mock API
```bash
python mock_api/mock_api.py
```

## ✅ Run Tests
```bash
robot -d reports tests/ui_tests.robot
robot -d reports tests/api_tests.robot
```

## Folder Structure
- `resources/` - Shared keywords & variables
- `tests/` - UI + API test cases
- `mock_api/` - Flask mock server
- `reports/` - Robot Framework output
