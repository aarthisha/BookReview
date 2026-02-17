#!/bin/bash

# BookReview Vercel + Railway Deployment Script
# This script automates deployment to Vercel and Railway

echo "🚀 BookReview Cloud Deployment Setup"
echo "=================================="
echo ""

# Check if required tools are installed
check_command() {
  if ! command -v $1 &> /dev/null; then
    echo "❌ $1 is not installed. Please install it first."
    echo "   Visit: $2"
    exit 1
  fi
}

echo "📋 Checking prerequisites..."
check_command "git" "https://git-scm.com"
check_command "node" "https://nodejs.org"
check_command "npm" "https://www.npmjs.com"

echo "✓ All prerequisites found"
echo ""

# Step 1: Prepare for deployment
echo "📦 Step 1: Preparing code for deployment..."
echo ""

# Create .env.local.example
cat > .env.local.example << 'EOF'
# Database Configuration
DB_HOST=your-railway-postgres-host
DB_PORT=5432
DB_NAME=book_review
DB_USER=postgres
DB_PASSWORD=your-secure-password

# API Configuration
NEXT_PUBLIC_API_URL=https://your-vercel-app.vercel.app
EOF

echo "✓ Created .env.local.example"

# Check if git is initialized
if [ ! -d .git ]; then
  echo "📝 Initializing Git repository..."
  git init
  git add .
  git commit -m "Initial commit: BookReview application"
  echo "✓ Git repository initialized"
else
  echo "✓ Git repository already initialized"
fi

echo ""
echo "📚 Step 2: Deployment Options"
echo ""
echo "Choose your deployment method:"
echo ""
echo "1️⃣  Vercel + Railway (RECOMMENDED)"
echo "   - Next.js hosting: Vercel"
echo "   - Database hosting: Railway"
echo "   - Easiest setup, lowest cost"
echo ""
echo "2️⃣  Railway All-in-One"
echo "   - Both hosting and database on Railway"
echo "   - Simplest option"
echo ""
echo "3️⃣  Heroku (Classic)"
echo "   - All-in-one deployment"
echo "   - More expensive"
echo ""
echo "4️⃣  Manual Configuration"
echo "   - Just prepare code, you configure manually"
echo ""

read -p "Select option (1-4): " choice

case $choice in
  1)
    echo ""
    echo "🚀 Setting up Vercel + Railway deployment..."
    echo ""
    echo "1. Install Vercel CLI:"
    echo "   npm install -g vercel"
    echo ""
    echo "2. Install Railway CLI:"
    echo "   npm install -g @railway/cli"
    echo ""
    echo "3. Deploy database to Railway:"
    echo "   a) Go to https://railway.app"
    echo "   b) Create new project"
    echo "   c) Add PostgreSQL plugin"
    echo "   d) Copy connection string"
    echo ""
    echo "4. Deploy app to Vercel:"
    echo "   a) vercel login"
    echo "   b) vercel"
    echo "   c) Add environment variables from .env.local.example"
    echo ""
    echo "5. Initialize database:"
    echo "   node scripts/init-db.js"
    echo ""
    echo "6. Your app will be live at: https://your-app.vercel.app"
    echo ""
    ;;
  
  2)
    echo ""
    echo "🚀 Setting up Railway all-in-one deployment..."
    echo ""
    echo "1. Install Railway CLI:"
    echo "   npm install -g @railway/cli"
    echo ""
    echo "2. Login to Railway:"
    echo "   railway login"
    echo ""
    echo "3. Create new project:"
    echo "   railway init"
    echo ""
    echo "4. Add PostgreSQL:"
    echo "   a) Go to https://railway.app"
    echo "   b) Create new project"
    echo "   c) Add PostgreSQL plugin"
    echo ""
    echo "5. Set environment variables:"
    echo "   railway env"
    echo ""
    echo "6. Deploy:"
    echo "   railway up"
    echo ""
    echo "7. Your app will be live at: https://your-app.railway.app"
    echo ""
    ;;
  
  3)
    echo ""
    echo "🚀 Setting up Heroku deployment..."
    echo ""
    echo "1. Install Heroku CLI:"
    echo "   npm install -g heroku"
    echo ""
    echo "2. Login to Heroku:"
    echo "   heroku login"
    echo ""
    echo "3. Create Heroku app:"
    echo "   heroku create your-app-name"
    echo ""
    echo "4. Add PostgreSQL addon:"
    echo "   heroku addons:create heroku-postgresql:hobby-dev"
    echo ""
    echo "5. Deploy:"
    echo "   git push heroku main"
    echo ""
    echo "6. Initialize database:"
    echo "   heroku run node scripts/init-db.js"
    echo ""
    echo "7. Your app will be live at: https://your-app-name.herokuapp.com"
    echo ""
    ;;
  
  4)
    echo ""
    echo "✓ Code is ready for deployment!"
    echo ""
    echo "Next steps:"
    echo "1. Push code to GitHub"
    echo "2. Choose a cloud platform"
    echo "3. Create accounts on platform + database service"
    echo "4. Set environment variables"
    echo "5. Deploy!"
    echo ""
    ;;
esac

echo ""
echo "📚 Additional Resources:"
echo "- Deployment Guide: DEPLOYMENT_GUIDE.md"
echo "- Quick Start: QUICK_START.md"
echo "- Database Setup: DATABASE_SETUP.md"
echo ""
echo "✅ Setup complete!"
