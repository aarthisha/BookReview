-- Create books table
CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    isbn VARCHAR(20),
    description TEXT,
    average_rating DECIMAL(3,2) DEFAULT 0,
    total_reviews INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create reviews table for BookReview application
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(id) ON DELETE CASCADE,
    book_title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT NOT NULL,
    reviewer_name VARCHAR(255),
    reviewer_email VARCHAR(255),
    helpful_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create users table (for future authentication)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255),
    full_name VARCHAR(255),
    bio TEXT,
    avatar_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user_reviews table (to track which user wrote which review)
CREATE TABLE IF NOT EXISTS user_reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    review_id INTEGER REFERENCES reviews(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, review_id)
);

-- Create ratings table (for tracking individual ratings separately)
CREATE TABLE IF NOT EXISTS ratings (
    id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(book_id, user_id)
);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_book_title ON books(title);
CREATE INDEX IF NOT EXISTS idx_book_author ON books(author);
CREATE INDEX IF NOT EXISTS idx_review_book_id ON reviews(book_id);
CREATE INDEX IF NOT EXISTS idx_review_rating ON reviews(rating);
CREATE INDEX IF NOT EXISTS idx_review_created_at ON reviews(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_user_reviews_user_id ON user_reviews(user_id);
CREATE INDEX IF NOT EXISTS idx_user_reviews_review_id ON user_reviews(review_id);
CREATE INDEX IF NOT EXISTS idx_ratings_book_id ON ratings(book_id);
CREATE INDEX IF NOT EXISTS idx_ratings_user_id ON ratings(user_id);

-- Create view for average book ratings
CREATE OR REPLACE VIEW book_stats AS
SELECT 
    b.id,
    b.title,
    b.author,
    COUNT(DISTINCT r.id) as total_reviews,
    AVG(r.rating::DECIMAL) as average_rating,
    COUNT(DISTINCT ra.id) as total_ratings
FROM books b
LEFT JOIN reviews r ON b.id = r.book_id
LEFT JOIN ratings ra ON b.id = ra.book_id
GROUP BY b.id, b.title, b.author;
