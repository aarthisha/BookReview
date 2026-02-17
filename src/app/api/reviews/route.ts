import { Pool } from 'pg';
import { NextRequest, NextResponse } from 'next/server';

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME || 'book_review',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
});

export async function POST(request: NextRequest) {
  let client;
  try {
    const { bookTitle, author, genre, rating, reviewText } = await request.json();

    // Validate required fields
    if (!bookTitle || !author || !rating || !reviewText) {
      return NextResponse.json(
        { error: 'Missing required fields: bookTitle, author, rating, reviewText' },
        { status: 400 }
      );
    }

    client = await pool.connect();
    await client.query('BEGIN');

    try {
      // Check if book exists, if not create it
      let bookId;
      const bookCheck = await client.query(
        'SELECT id FROM books WHERE title = $1 AND author = $2',
        [bookTitle, author]
      );

      if (bookCheck.rows.length > 0) {
        bookId = bookCheck.rows[0].id;
      } else {
        const bookInsert = await client.query(
          `INSERT INTO books (title, author, genre) 
           VALUES ($1, $2, $3) 
           RETURNING id`,
          [bookTitle, author, genre || null]
        );
        bookId = bookInsert.rows[0].id;
      }

      // Insert review
      const reviewInsert = await client.query(
        `INSERT INTO reviews (book_id, book_title, author, genre, rating, review_text) 
         VALUES ($1, $2, $3, $4, $5, $6) 
         RETURNING id, book_id, book_title, author, genre, rating, review_text, created_at`,
        [bookId, bookTitle, author, genre || null, rating, reviewText]
      );

      await client.query('COMMIT');
      client.release();

      return NextResponse.json(
        {
          success: true,
          message: 'Review saved successfully to database',
          data: reviewInsert.rows[0],
        },
        { status: 201 }
      );
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    }
  } catch (error) {
    if (client) client.release();
    console.error('Error saving review:', error);
    return NextResponse.json(
      { error: 'Failed to save review. Please try again.' },
      { status: 500 }
    );
  }
}

export async function GET(request: NextRequest) {
  try {
    const query = `
      SELECT 
        r.id,
        r.book_id,
        r.book_title,
        r.author,
        r.genre,
        r.rating,
        r.review_text,
        r.created_at,
        b.average_rating,
        b.total_reviews
      FROM reviews r
      LEFT JOIN books b ON r.book_id = b.id
      ORDER BY r.created_at DESC
      LIMIT 50
    `;

    const result = await pool.query(query);

    return NextResponse.json(
      {
        success: true,
        count: result.rows.length,
        data: result.rows,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error('Error fetching reviews:', error);
    return NextResponse.json(
      { error: 'Failed to fetch reviews' },
      { status: 500 }
    );
  }
}
