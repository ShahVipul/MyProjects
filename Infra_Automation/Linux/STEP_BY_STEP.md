# ================================================================
# COMPLETE STEP-BY-STEP SETUP GUIDE
# AI Banking Query App — Windows 11
# Stack: Python + Antigravity + Google Gemini + MySQL + Flask
# ================================================================

## ══════════════════════════════════════════
## STEP 1 — INSTALL PYTHON ON WINDOWS
## ══════════════════════════════════════════

1. Go to: https://www.python.org/downloads/
2. Download Python 3.11 or higher
3. Run the installer
   ✅ IMPORTANT: Check "Add Python to PATH" at the bottom!
4. Click "Install Now"
5. Verify in Command Prompt (Win+R → type cmd):
   > python --version
   Should show: Python 3.11.x


## ══════════════════════════════════════════
## STEP 2 — INSTALL MYSQL COMMUNITY SERVER
## ══════════════════════════════════════════

1. Go to: https://dev.mysql.com/downloads/mysql/
2. Download "MySQL Community Server" (Windows MSI)
3. During install choose: Developer Default
4. Set a root password — REMEMBER THIS (you need it for .env)
5. Verify installation:
   > mysql -u root -p
   Enter your password → you should see mysql>


## ══════════════════════════════════════════
## STEP 3 — INSTALL SQL DEVELOPER (Oracle)
## ══════════════════════════════════════════

SQL Developer can connect to MySQL using JDBC.

1. Download SQL Developer: https://www.oracle.com/tools/downloads/sqldev-downloads.html
2. Extract the zip, run sqldeveloper.exe
3. Add MySQL JDBC Driver:
   - Tools → Preferences → Database → Third Party JDBC Drivers
   - Download MySQL JDBC jar: https://dev.mysql.com/downloads/connector/j/
   - Add the downloaded .jar file
4. Create new connection in SQL Developer:
   - Click the "+" (New Connection) button
   - Connection Name: BankDB_Local
   - Database Type: MySQL
   - Username: root
   - Password: (your MySQL root password)
   - Hostname: localhost
   - Port: 3306
   - Database: bank_db
   - Test → Connect → Save


## ══════════════════════════════════════════
## STEP 4 — LOAD SAMPLE DATABASE DATA
## ══════════════════════════════════════════

Option A — Using MySQL Command Line:
   > mysql -u root -p < sql/sample_data.sql

Option B — Using MySQL Workbench:
   1. Open MySQL Workbench
   2. Connect to local instance
   3. File → Open SQL Script → select sql/sample_data.sql
   4. Click the lightning bolt ⚡ to run all

Option C — Using SQL Developer:
   1. Open the connection you created
   2. Open Worksheet
   3. Paste contents of sql/sample_data.sql
   4. Run (F5 or Ctrl+Enter)

✅ You should see 4 tables: customers, accounts, transactions, fraud_alerts


## ══════════════════════════════════════════
## STEP 5 — GET FREE GOOGLE GEMINI API KEY
## ══════════════════════════════════════════

1. Go to: https://aistudio.google.com/app/apikey
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy the key (starts with "AIza...")
5. The free tier gives you:
   - 15 requests per minute
   - 1 million tokens per day
   - No credit card needed!


## ══════════════════════════════════════════
## STEP 6 — SET UP THE PROJECT
## ══════════════════════════════════════════

1. Create your project folder:
   > mkdir C:\Projects\ai_query_app
   > cd C:\Projects\ai_query_app

2. Copy all project files into this folder
   (maintain the folder structure shown in README)

3. Create a Python virtual environment:
   > python -m venv venv
   > venv\Scripts\activate
   (You'll see (venv) in your prompt — that's correct!)

4. Install all dependencies:
   > pip install -r requirements.txt

   This installs:
   - flask             → Web server
   - flask-cors        → Allow HTML frontend to call API
   - mysql-connector-python → MySQL driver
   - google-generativeai    → Google Gemini AI
   - python-dotenv          → Load .env config file
   - antigravity            → Python Easter egg 🚀


## ══════════════════════════════════════════
## STEP 7 — CONFIGURE YOUR CREDENTIALS
## ══════════════════════════════════════════

Open conf/.env in Notepad and fill in:

   DB_HOST=localhost
   DB_PORT=3306
   DB_NAME=bank_db
   DB_USER=root
   DB_PASSWORD=YourActualMySQLPassword   ← change this
   GEMINI_API_KEY=AIzaXXXXXXXXXXXXXXXX  ← paste your key here

Save the file.


## ══════════════════════════════════════════
## STEP 8 — RUN THE APP
## ══════════════════════════════════════════

Option A — Double-click run.bat (easiest)

Option B — Command line:
   > cd C:\Projects\ai_query_app
   > venv\Scripts\activate
   > python -m backend.app

You should see:
   🚀 Antigravity module loaded — we're flying!
   * Running on http://0.0.0.0:5000


## ══════════════════════════════════════════
## STEP 9 — OPEN THE FRONTEND
## ══════════════════════════════════════════

1. Open frontend/index.html in Chrome or Edge
   (Just double-click the file — no server needed for frontend)
2. You'll see the BankAI dashboard
3. The green dot at top-right means DB is connected
4. Type a question and hit Run Query or Ctrl+Enter


## ══════════════════════════════════════════
## SAMPLE PROMPTS TO TRY
## ══════════════════════════════════════════

Customer Queries:
  • "Show all customers from Mumbai"
  • "Find customer with email ravi@example.com"
  • "List customers who joined this month"

Account Queries:
  • "Show all frozen or closed accounts"
  • "Which accounts have balance below 5000?"
  • "List all credit accounts"

Transaction Queries:
  • "Show all failed transactions"
  • "Why are transactions failing? Group by error code"
  • "Count of success vs failed transactions"
  • "Show failed transactions for customer Ravi Sharma"
  • "List all pending transactions with customer names"

Fraud Queries:
  • "Show all high severity fraud alerts"
  • "Which customers have critical fraud alerts?"
  • "Count of fraud alerts by type"
  • "Show fraud alerts from the last 7 days"

Combined/Complex:
  • "Show customers with both failed transactions and fraud alerts"
  • "Which error causes the most transaction failures?"
  • "Top 5 customers by total transaction amount"


## ══════════════════════════════════════════
## TROUBLESHOOTING
## ══════════════════════════════════════════

❌ "Cannot reach Flask server"
→ Make sure python -m backend.app is running
→ Check port 5000 is not blocked by firewall

❌ "Database error: Access denied"
→ Check DB_USER and DB_PASSWORD in conf/.env
→ Verify MySQL is running: services.msc → MySQL

❌ "Gemini API key not configured"
→ Open conf/.env and add your API key

❌ ModuleNotFoundError
→ Make sure virtual environment is activated: venv\Scripts\activate
→ Run: pip install -r requirements.txt

❌ "Only SELECT queries are allowed"
→ This is a safety feature. The AI should not generate non-SELECT queries.
→ Rephrase your question to ask for data retrieval only.
