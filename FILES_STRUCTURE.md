# 📁 BookReview Project - Files Structure

## 🗂️ Project Directory

```
c:\Users\shankara\Tech Conference\book-review\
├── 📄 package.json                 (Dependencies & scripts)
├── 📄 .env.local                   (Database configuration)
├── 📄 tsconfig.json                (TypeScript config)
├── 📄 next.config.js               (Next.js config)
├── 📄 tailwind.config.ts           (Tailwind CSS config)
├── 📄 postcss.config.mjs           (PostCSS config)
├── 📄 .eslintrc.json               (ESLint config)
│
├── 📁 src/
│   ├── 📁 app/
│   │   ├── 📄 layout.tsx           (Root layout)
│   │   ├── 📄 page.tsx             (Home page)
│   │   │
│   │   └── 📁 api/
│   │       └── 📁 reviews/
│   │           └── 📄 route.ts     (API endpoint for reviews)
│   │
│   └── 📁 styles/
│       └── 📄 globals.css          (Global styles)
│
├── 📁 scripts/
│   ├── 📄 init-db.js               (Database initialization)
│   ├── 📄 init-db.ts               (TypeScript version)
│   └── 📄 test-db.js               (Database connection test)
│
├── 📄 book-review-demo.html        (Standalone demo page)
├── 📄 schema-reviews.sql           (Database schema)
│
├── 📄 DATABASE_SETUP.md            (Database setup guide)
├── 📄 SETUP_COMPLETE.md            (Complete setup summary)
└── 📄 FILES_STRUCTURE.md           (This file)
```

---

## 📋 File Descriptions

### Core Configuration Files
| File | Purpose |
|------|---------|
| `package.json` | npm dependencies: Next.js, React, postgres, Tailwind |
| `.env.local` | Database connection credentials |
| `tsconfig.json` | TypeScript compiler options |
| `next.config.js` | Next.js framework configuration |
| `tailwind.config.ts` | Tailwind CSS theme customization |
| `postcss.config.mjs` | PostCSS plugins (Tailwind) |
| `.eslintrc.json` | Code linting rules |

### Frontend Files
| File | Type | Purpose |
|------|------|---------|
| `src/app/layout.tsx` | TypeScript/React | Root layout with metadata |
| `src/app/page.tsx` | TypeScript/React | Home page with inline styles |
| `src/styles/globals.css` | CSS | Global Tailwind directives |
| `book-review-demo.html` | HTML | Standalone demo with modal form |

### Backend Files
| File | Type | Purpose |
|------|------|---------|
| `src/app/api/reviews/route.ts` | TypeScript | API endpoint for reviews |
| | | - POST: Save review to database |
| | | - GET: Fetch reviews from database |

### Database Files
| File | Type | Purpose |
|------|------|---------|
| `schema-reviews.sql` | SQL | Table definitions and indexes |
| `scripts/init-db.js` | JavaScript | Database initialization script |
| `scripts/init-db.ts` | TypeScript | TypeScript version |
| `scripts/test-db.js` | JavaScript | Connection verification |

### Documentation Files
| File | Purpose |
|------|---------|
| `DATABASE_SETUP.md` | Detailed database configuration guide |
| `SETUP_COMPLETE.md` | Complete setup summary with examples |
| `FILES_STRUCTURE.md` | This file - project structure |

---

## 🔌 API Endpoint Details

### POST /api/reviews
**Purpose**: Save a book review to the database

**Request Body**:
```json
{
  "bookTitle": "string (required)",
  "author": "string (required)",
  "genre": "string (optional)",
  "rating": "number 1-5 (required)",
  "reviewText": "string (required)"
}
```

**Response (201 Created)**:
```json
{
  "success": true,
  "message": "Review saved successfully to database",
  "data": {
    "id": 1,
    "book_id": 1,
    "book_title": "Dune",
    "author": "Frank Herbert",
    "genre": "Science Fiction",
    "rating": 5,
    "review_text": "An epic masterpiece...",
    "created_at": "2026-02-17T10:45:30.000Z"
  }
}
```

### GET /api/reviews
**Purpose**: Fetch reviews from the database

**Query Parameters**: None (currently returns last 50)

**Response (200 OK)**:
```json
{
  "success": true,
  "count": 5,
  "data": [
    {
      "id": 1,
      "book_id": 1,
      "book_title": "Dune",
      "author": "Frank Herbert",
      "rating": 5,
      "review_text": "...",
      "created_at": "2026-02-17T10:45:30.000Z"
    }
  ]
}
```

---

## 💾 Database Tables

### books
- `id` (PK)
- `title` (VARCHAR, UNIQUE)
- `author` (VARCHAR)
- `genre` (VARCHAR)
- `isbn` (VARCHAR)
- `description` (TEXT)
- `average_rating` (DECIMAL)
- `total_reviews` (INTEGER)
- `created_at`, `updated_at` (TIMESTAMP)

### reviews
- `id` (PK)
- `book_id` (FK → books)
- `book_title`, `author`, `genre` (VARCHAR)
- `rating` (INTEGER 1-5)
- `review_text` (TEXT)
- `reviewer_name`, `reviewer_email` (VARCHAR)
- `helpful_count` (INTEGER)
- `created_at`, `updated_at` (TIMESTAMP)

### users (for future auth)
- `id` (PK)
- `username`, `email` (VARCHAR, UNIQUE)
- `password_hash` (VARCHAR)
- `full_name`, `bio` (VARCHAR/TEXT)
- `avatar_url` (VARCHAR)
- `created_at`, `updated_at` (TIMESTAMP)

### user_reviews
- `id` (PK)
- `user_id` (FK → users)
- `review_id` (FK → reviews)
- `created_at` (TIMESTAMP)

### ratings
- `id` (PK)
- `book_id` (FK → books)
- `user_id` (FK → users)
- `rating` (INTEGER 1-5)
- `created_at`, `updated_at` (TIMESTAMP)

### book_stats (VIEW)
- Aggregated statistics per book
- Shows: title, author, total_reviews, average_rating, total_ratings

---

## 🔧 Available Commands

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Run production build
npm start

# Lint code
npm run lint

# Initialize database
node scripts/init-db.js

# Test database connection
node scripts/test-db.js
```

---

## 🌐 Access Points

| URL | Purpose |
|-----|---------|
| `http://localhost:3000` | Next.js home page |
| `http://localhost:3000/api/reviews` | API endpoint |
| `http://localhost:3000/book-review-demo.html` | Standalone demo |

---

## 📦 Dependencies

### Production Dependencies
- `next@16.1.6` - React framework
- `react@19.0.0` - UI library
- `react-dom@19.0.0` - DOM rendering
- `pg@8.12.0` - PostgreSQL driver
- `typescript@5.0.0` - Type checking

### Development Dependencies
- `@typescript-eslint/*@7.18.0` - TypeScript linting
- `eslint@8.57.1` - Code linting
- `tailwindcss@3.4.0` - CSS utility framework
- `postcss@8.4.48` - CSS processing
- `autoprefixer@10.4.20` - CSS vendor prefixes

---

## ✅ Installation & Setup Checklist

- [x] PostgreSQL database created
- [x] Database tables created with indexes
- [x] Environment variables configured (.env.local)
- [x] npm dependencies installed
- [x] API routes configured
- [x] HTML form integrated with API
- [x] Development server running
- [x] Database connection verified
- [x] Ready for production deployment

---

**Last Updated**: February 17, 2026  
**Status**: ✅ Complete and Ready to Use
