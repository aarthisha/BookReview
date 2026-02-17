const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'book_review',
  user: 'postgres',
  password: 'postgres',
});

async function testDatabase() {
  try {
    console.log('🔄 Testing database connection...\n');

    // Test connection
    const result = await pool.query('SELECT NOW()');
    console.log('✓ Database connected successfully');
    console.log('  Server time:', result.rows[0].now);

    // Get table list
    const tables = await pool.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      ORDER BY table_name
    `);

    console.log('\n📊 Tables created:');
    tables.rows.forEach(t => console.log(`  ✓ ${t.table_name}`));

    // Get row counts
    console.log('\n📈 Row counts:');
    for (const table of tables.rows) {
      const count = await pool.query(`SELECT COUNT(*) FROM ${table.table_name}`);
      console.log(`  ${table.table_name}: ${count.rows[0].count} rows`);
    }

    console.log('\n✅ Database is ready for book reviews!');
    await pool.end();
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

testDatabase();
