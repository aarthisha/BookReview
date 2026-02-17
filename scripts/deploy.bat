@echo off
REM BookReview Cloud Deployment Script for Windows
REM This script helps you deploy to Vercel, Railway, or Heroku

echo.
echo 🚀 BookReview Cloud Deployment Setup
echo ====================================
echo.

REM Check if Node is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed
    echo    Download from: https://nodejs.org
    pause
    exit /b 1
)

echo ✓ Node.js found
echo ✓ npm found
echo.

REM Create .env.local.example
echo 📦 Creating .env.local.example...

(
    echo # Database Configuration
    echo DB_HOST=your-railway-postgres-host
    echo DB_PORT=5432
    echo DB_NAME=book_review
    echo DB_USER=postgres
    echo DB_PASSWORD=your-secure-password
    echo.
    echo # API Configuration
    echo NEXT_PUBLIC_API_URL=https://your-vercel-app.vercel.app
) > .env.local.example

echo ✓ Created .env.local.example
echo.

REM Check if git is initialized
if not exist .git (
    echo 📝 Initializing Git repository...
    git init
    git add .
    git commit -m "Initial commit: BookReview application"
    echo ✓ Git repository initialized
) else (
    echo ✓ Git repository already initialized
)

echo.
echo 📚 Deployment Options
echo ====================================
echo.
echo 1️⃣  Vercel + Railway (RECOMMENDED^)
echo    - Next.js hosting: Vercel
echo    - Database hosting: Railway
echo    - Cost: ~$5/month
echo.
echo 2️⃣  Railway All-in-One
echo    - Both app and database on Railway
echo    - Cost: ~$10/month
echo.
echo 3️⃣  Render
echo    - All-in-one simple deployment
echo    - Cost: ~$20/month
echo.
echo 4️⃣  Heroku
echo    - Classic PaaS option
echo    - Cost: ~$75/month
echo.
echo 5️⃣  AWS
echo    - Most scalable
echo    - Cost: ~$25+/month
echo.
echo 6️⃣  Show detailed guide
echo    - Opens DEPLOYMENT_GUIDE.md
echo.

set /p choice="Select option (1-6): "

if "%choice%"=="1" (
    cls
    echo.
    echo 🚀 Vercel + Railway Deployment
    echo ===============================
    echo.
    echo Step 1: Install CLI tools
    echo npm install -g vercel @railway/cli
    echo.
    echo Step 2: Create accounts
    echo - https://vercel.com (sign up with GitHub^)
    echo - https://railway.app (sign up with GitHub^)
    echo.
    echo Step 3: Deploy database to Railway
    echo railway login
    echo railway init
    echo - Add PostgreSQL plugin
    echo - Copy connection string
    echo.
    echo Step 4: Deploy app to Vercel
    echo vercel
    echo - Add environment variables from .env.local.example
    echo.
    echo Step 5: Initialize database
    echo node scripts/init-db.js
    echo.
    echo Your app: https://your-app.vercel.app
    echo.
    pause
    
) else if "%choice%"=="2" (
    cls
    echo.
    echo 🚀 Railway All-in-One Deployment
    echo ==================================
    echo.
    echo Step 1: Go to https://railway.app
    echo.
    echo Step 2: Create new project from GitHub
    echo - Connect your GitHub repository
    echo.
    echo Step 3: Add PostgreSQL plugin
    echo - Click "Add" -^> "PostgreSQL"
    echo.
    echo Step 4: Configure environment variables
    echo - DATABASE_URL (auto-provided^)
    echo - Add others from .env.local.example
    echo.
    echo Step 5: Deploy
    echo - Railway auto-deploys on git push
    echo.
    echo Step 6: Initialize database
    echo railway run node scripts/init-db.js
    echo.
    echo Your app: https://your-project.railway.app
    echo.
    pause
    
) else if "%choice%"=="3" (
    cls
    echo.
    echo 🚀 Render Deployment
    echo ====================
    echo.
    echo Step 1: Go to https://render.com
    echo - Sign up with GitHub
    echo.
    echo Step 2: Create PostgreSQL Database
    echo - New -^> PostgreSQL
    echo - Copy connection string
    echo.
    echo Step 3: Create Web Service
    echo - New -^> Web Service
    echo - Connect GitHub repository
    echo - Build: npm install
    echo - Start: npm run build ^&^& npm run start
    echo.
    echo Step 4: Set environment variables
    echo - DATABASE_URL
    echo - Others from .env.local.example
    echo.
    echo Step 5: Deploy
    echo - Click "Deploy"
    echo.
    echo Your app: https://your-app.onrender.com
    echo.
    pause
    
) else if "%choice%"=="4" (
    cls
    echo.
    echo 🚀 Heroku Deployment
    echo ====================
    echo.
    echo Step 1: Install Heroku CLI
    echo Download: https://devcenter.heroku.com/articles/heroku-cli
    echo.
    echo Step 2: Login to Heroku
    echo heroku login
    echo.
    echo Step 3: Create app
    echo heroku create your-app-name
    echo.
    echo Step 4: Add PostgreSQL
    echo heroku addons:create heroku-postgresql:hobby-dev
    echo.
    echo Step 5: Set environment variables
    echo heroku config:set DB_HOST=your-host
    echo heroku config:set DB_PORT=5432
    echo heroku config:set DB_NAME=your-db
    echo heroku config:set DB_USER=postgres
    echo heroku config:set DB_PASSWORD=your-password
    echo.
    echo Step 6: Deploy
    echo git push heroku main
    echo.
    echo Step 7: Initialize database
    echo heroku run node scripts/init-db.js
    echo.
    echo Your app: https://your-app-name.herokuapp.com
    echo.
    pause
    
) else if "%choice%"=="5" (
    cls
    echo.
    echo 🚀 AWS Deployment
    echo =================
    echo.
    echo This requires more steps. Please see DEPLOYMENT_GUIDE.md for:
    echo - Setting up RDS PostgreSQL
    echo - Deploying to EC2/ECS
    echo - Configuring domain names
    echo - Setting up SSL certificates
    echo.
    echo AWS CLI reference:
    echo - https://aws.amazon.com/cli/
    echo.
    pause
    
) else if "%choice%"=="6" (
    echo.
    echo Opening DEPLOYMENT_GUIDE.md...
    echo.
    if exist DEPLOYMENT_GUIDE.md (
        start DEPLOYMENT_GUIDE.md
    ) else (
        echo ❌ DEPLOYMENT_GUIDE.md not found
    )
    pause
) else (
    echo Invalid option
    pause
)

echo.
echo ✅ Setup complete!
echo.
echo 📚 More information:
echo - DEPLOYMENT_GUIDE.md - Detailed deployment guide
echo - QUICK_START.md - Quick reference
echo - DATABASE_SETUP.md - Database configuration
echo.
pause
