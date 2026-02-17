#!/usr/bin/env node

const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env.local') });

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  database: 'postgres',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
});

async function initializeDatabase() {
  let client;
  try {
    console.log('🔄 Connecting to PostgreSQL...');
    client = await pool.connect();
    console.log('✓ Connected to PostgreSQL');

    // Create database if it doesn't exist
    const dbName = process.env.DB_NAME || 'book_review';
    try {
      await client.query(`CREATE DATABASE "${dbName}";`);
      console.log(`✓ Database "${dbName}" created`);
    } catch (error) {
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

    console.log(`🔄 Connecting to "${dbName}" database...`);
    const bookClient = await bookPool.connect();
    console.log(`✓ Connected to "${dbName}" database`);

    // Read and execute schema
    const schemaPath = path.join(__dirname, '..', 'schema-reviews.sql');
    console.log('🔄 Creating tables...');
    const schema = fs.readFileSync(schemaPath, 'utf-8');
    
    await bookClient.query(schema);
    console.log('✓ Tables and indexes created successfully');

    // Verify tables
    const tablesResult = await bookClient.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name
    `);

    console.log('\n📊 Created tables:');
    tablesResult.rows.forEach((row) => {
      console.log(`  ✓ ${row.table_name}`);
    });

    // Verify indexes
    const indexResult = await bookClient.query(`
      SELECT indexname 
      FROM pg_indexes 
      WHERE schemaname = 'public'
      ORDER BY indexname
    `);

    console.log('\n📇 Created indexes:');
    indexResult.rows.forEach((row) => {
      console.log(`  ✓ ${row.indexname}`);
    });

    // Verify views
    const viewResult = await bookClient.query(`
      SELECT table_name 
      FROM information_schema.views 
      WHERE table_schema = 'public'
      ORDER BY table_name
    `);

    if (viewResult.rows.length > 0) {
      console.log('\n📈 Created views:');
      viewResult.rows.forEach((row) => {
        console.log(`  ✓ ${row.table_name}`);
      });
    }

    bookClient.release();
    await bookPool.end();
    await pool.end();

    console.log('\n✅ Database initialization completed successfully!');
    process.exit(0);
  } catch (error) {
    console.error('\n❌ Error initializing database:', error.message);
    if (client) client.release();
    pool.end();
    process.exit(1);
  }
}

initializeDatabase();
