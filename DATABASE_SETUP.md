# BookReview Database Setup Guide

## ✅ Database Initialization Complete

The PostgreSQL database has been successfully set up with all necessary tables and indexes.

### Database Connection Details
- **Host**: localhost
- **Port**: 5432
- **Database**: book_review
- **User**: postgres
- **Config File**: `.env.local`

### Tables Created

#### 1. **books**
Stores book information
```sql
- id (Primary Key)
- title (VARCHAR, UNIQUE)
- author (VARCHAR)
- genre (VARCHAR)
- isbn (VARCHAR)
- description (TEXT)
- average_rating (DECIMAL)
- total_reviews (INTEGER)
- created_at, updated_at (TIMESTAMP)
```

#### 2. **reviews**
Stores user reviews for books
```sql
- id (Primary Key)
- book_id (Foreign Key → books.id)
- book_title, author, genre (VARCHAR)
- rating (INTEGER: 1-5 stars)
- review_text (TEXT)
- reviewer_name, reviewer_email (VARCHAR)
- helpful_count (INTEGER)
- created_at, updated_at (TIMESTAMP)
```

#### 3. **users**
Stores user account information (for future authentication)
```sql
- id (Primary Key)
- username, email (VARCHAR, UNIQUE)
- password_hash (VARCHAR)
- full_name, bio (VARCHAR/TEXT)
- avatar_url (VARCHAR)
- created_at, updated_at (TIMESTAMP)
```

#### 4. **user_reviews**
Links users to their reviews
```sql
- id (Primary Key)
- user_id (Foreign Key → users.id)
- review_id (Foreign Key → reviews.id)
- created_at (TIMESTAMP)
```

#### 5. **ratings**
Separate ratings tracking for analytics
```sql
- id (Primary Key)
- book_id (Foreign Key → books.id)
- user_id (Foreign Key → users.id)
- rating (INTEGER: 1-5 stars)
- created_at, updated_at (TIMESTAMP)
```

### Views Created

#### **book_stats**
Provides aggregated statistics for books
```sql
SELECT:
- id, title, author (book details)
- total_reviews (COUNT of reviews)
- average_rating (AVG of ratings)
- total_ratings (COUNT of ratings)
```

### Indexes Created
- `idx_book_title` - Search books by title
- `idx_book_author` - Search books by author
- `idx_review_book_id` - Fetch reviews for a book
- `idx_review_rating` - Filter reviews by rating
- `idx_review_created_at` - Sort reviews by date
- `idx_ratings_book_id` - Track ratings per book
- `idx_ratings_user_id` - Track ratings per user
- `idx_user_reviews_*` - Link users to their reviews

## How the Review Form Works

### 1. User submits review via modal form (HTML)
```
Book Title → Author → Genre → Rating → Review Text
```

### 2. Form sends POST request to `/api/reviews`
```javascript
POST /api/reviews
Content-Type: application/json
{
  "bookTitle": "...",
  "author": "...",
  "genre": "...",
  "rating": 1-5,
  "reviewText": "..."
}
```

### 3. API Route (`/src/app/api/reviews/route.ts`) processes:
- Validates all required fields
- Creates book record if it doesn't exist
- Inserts review into reviews table
- Returns review with ID and timestamp

### 4. Review is stored in PostgreSQL database
```
reviews table:
ID | book_id | title | author | rating | review_text | created_at
```

## Useful Queries

### Get all reviews with book info:
```sql
SELECT r.id, r.book_title, r.author, r.rating, r.review_text, r.created_at
FROM reviews r
LEFT JOIN books b ON r.book_id = b.id
ORDER BY r.created_at DESC;
```

### Get book statistics:
```sql
SELECT * FROM book_stats
ORDER BY total_reviews DESC;
```

### Get reviews by rating:
```sql
SELECT * FROM reviews
WHERE rating >= 4
ORDER BY created_at DESC;
```

### Get top-rated books:
```sql
SELECT * FROM book_stats
WHERE average_rating >= 4
ORDER BY total_reviews DESC;
```

## Environment Variables (.env.local)
```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=book_review
DB_USER=postgres
DB_PASSWORD=postgres
NEXT_PUBLIC_API_URL=http://localhost:3000
```

## Running Database Initialization Script

To reinitialize the database or verify tables:
```bash
node scripts/init-db.js
```

## Next Steps

1. ✅ Database tables created
2. ✅ API routes configured
3. ✅ Form integrated with database
4. 🔄 **Test the form submission** - Click "Write a Review" on the demo page
5. 📊 **Verify data in database** using provided queries
6. 🔐 Implement user authentication (future)
7. 📈 Add review analytics dashboard (future)

## Connection Test

The database connection was successful:
```
✓ Connected to PostgreSQL
✓ Database "book_review" already exists
✓ Connected to "book_review" database
✓ 5 tables created successfully
✓ 10+ indexes created for performance
✓ 1 view created for statistics
```

---

**Status**: ✅ Ready to use
**Last Updated**: February 17, 2026
