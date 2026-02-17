# 📌 DEPLOYMENT QUICK REFERENCE CARD

## 🥇 RECOMMENDED: Vercel + Railway

### What It Is:
```
Vercel = Your Next.js app lives here
Railway = Your PostgreSQL database lives here
```

### Cost & Time:
```
Cost: $5-10/month
Setup: 15 minutes
```

### Process:

#### 1️⃣ GitHub (5 min)
```bash
git add .
git commit -m "Ready for deployment"
git push origin main
```

#### 2️⃣ Railway Database (5 min)
1. Go to railway.app
2. Click "New Project"
3. Click "Provision PostgreSQL"
4. Copy connection string

**Connection String:**
```
postgresql://postgres:password@host:5432/book_review
```

#### 3️⃣ Vercel Hosting (5 min)
1. Go to vercel.com
2. Click "Import Project"
3. Select your GitHub repo
4. Add env variables:
   - DB_HOST = (from Railway)
   - DB_PORT = 5432
   - DB_NAME = book_review
   - DB_USER = postgres
   - DB_PASSWORD = (from Railway)
   - NEXT_PUBLIC_API_URL = https://your-app.vercel.app

5. Click "Deploy"

**Your app is LIVE! 🎉**

#### 4️⃣ Database Setup (1 min)
```bash
node scripts/init-db.js
```

---

## 📊 All Cloud Options

| Platform | Price | Setup | Best For |
|----------|-------|-------|----------|
| **Vercel + Railway** | $5 | 15m | ⭐ RECOMMENDED |
| Railway All-in-One | $10 | 10m | Simple |
| Render | $20 | 15m | Easy |
| Heroku | $75 | 20m | Classic |
| AWS | $25+ | 60m | Powerful |

---

## ✅ Test After Deploy

1. **Open your app:**
   ```
   https://your-app.vercel.app/book-review-demo.html
   ```

2. **Try the form:**
   - Click "Write a Review"
   - Fill in book details
   - Submit
   - See success message ✅

3. **Check database:**
   ```bash
   node scripts/test-db.js
   ```

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| Can't deploy | Check code: `npm run build` |
| Form won't submit | Check env vars are correct |
| No database connection | Verify DB_HOST, DB_PASSWORD |
| App is slow | Check database indexes |

---

## 📁 Key Files

- **CLOUD_DEPLOYMENT_SUMMARY.md** ← Start here!
- **DEPLOYMENT_GUIDE.md** ← Full details
- **DEPLOYMENT_CHECKLIST.md** ← Use as checklist
- **vercel.json** ← Vercel config
- **railway.json** ← Railway config

---

## 💡 Pro Tips

✅ Push to GitHub first  
✅ Use `.env.local.example` for documentation  
✅ Enable backups  
✅ Set up monitoring (UptimeRobot free)  
✅ Test after deploying  

---

## 🎯 30-Minute Deployment

```
0-5m:   Push to GitHub
5-10m:  Create Railway account & database
10-15m: Create Vercel account & deploy app
15-16m: Set environment variables
16-17m: Database initialization
17-30m: Testing & verification
```

**LIVE!** 🚀

---

## 📱 Your App URLs After Deploy

```
Website: https://your-app.vercel.app
Demo:    https://your-app.vercel.app/book-review-demo.html
API:     https://your-app.vercel.app/api/reviews
Health:  https://your-app.vercel.app/api/health
```

---

## 🔑 Environment Variables Needed

```
DB_HOST          required
DB_PORT          = 5432
DB_NAME          = book_review
DB_USER          = postgres
DB_PASSWORD      required
NEXT_PUBLIC_API_URL = your domain
```

---

**Questions?** See CLOUD_DEPLOYMENT_SUMMARY.md or DEPLOYMENT_GUIDE.md

**Ready?** Pick Vercel + Railway and follow the 4 steps above!

🎉 Good luck deploying!
