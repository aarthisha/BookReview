import { Pool } from 'pg';
import dotenv from 'dotenv';
import * as fs from 'fs';
import * as path from 'path';

// Load environment variables
dotenv.config({ path: '.env.local' });

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  database: 'postgres', // Connect to default database first
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
});

async function initializeDatabase() {
  let client;
  try {
    client = await pool.connect();
    console.log('✓ Connected to PostgreSQL');

    // Create database if it doesn't exist
    const dbName = process.env.DB_NAME || 'book_review';
    try {
      await client.query(`CREATE DATABASE "${dbName}";`);
      console.log(`✓ Database "${dbName}" created`);
    } catch (error: any) {
      if (error.code === '42P04') {
        console.log(`✓ Database "${dbName}" already exists`);
      } else {
        throw error;
      }
    }

    client.release();

    // Connect to the actual database
    const bookPool = new Pool({
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT || '5432'),
      database: dbName,
      user: process.env.DB_USER || 'postgres',
      password: process.env.DB_PASSWORD || 'postgres',
    });

    const bookClient = await bookPool.connect();
    console.log(`✓ Connected to "${dbName}" database`);

    // Read and execute schema
    const schemaPath = path.join(__dirname, 'schema-reviews.sql');
    const schema = fs.readFileSync(schemaPath, 'utf-8');
    
    await bookClient.query(schema);
    console.log('✓ Tables created successfully');

    // Verify tables
    const tablesResult = await bookClient.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
    `);

    console.log('\n✓ Created tables:');
    tablesResult.rows.forEach((row) => {
      console.log(`  - ${row.table_name}`);
    });

    bookClient.release();
    await bookPool.end();
    await pool.end();

    console.log('\n✓ Database initialization completed successfully!');
    process.exit(0);
  } catch (error) {
    console.error('✗ Error initializing database:', error);
    if (client) client.release();
    await pool.end();
    process.exit(1);
  }
}

initializeDatabase();
