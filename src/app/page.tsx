export default function Home() {
  return (
    <main style={{ minHeight: '100vh', background: 'linear-gradient(to bottom right, #f0f4ff, #e0e7ff)' }}>
      {/* Navigation */}
      <nav style={{ background: 'white', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
        <div style={{ maxWidth: '80rem', margin: '0 auto', padding: '0 1rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center', height: '4rem' }}>
          <div>
            <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#2563eb' }}>📚 BookReview</h1>
          </div>
          <div style={{ display: 'flex', gap: '1rem' }}>
            <button style={{ padding: '0.5rem 1rem', background: 'white', border: 'none', cursor: 'pointer' }}>
              Sign In
            </button>
            <button style={{ padding: '0.5rem 1rem', background: '#2563eb', color: 'white', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}>
              Sign Up
            </button>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section style={{ maxWidth: '80rem', margin: '0 auto', padding: '5rem 1rem', textAlign: 'center' }}>
        <h2 style={{ fontSize: '2.25rem', fontWeight: 'bold', color: '#111827', marginBottom: '1rem' }}>
          Share Your Reading Journey
        </h2>
        <p style={{ fontSize: '1.25rem', color: '#4b5563', marginBottom: '2rem', maxWidth: '42rem', margin: '0 auto 2rem' }}>
          Discover great books, write thoughtful reviews, and connect with readers who share your passion for literature.
        </p>
        <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center' }}>
          <button style={{ padding: '0.75rem 1.5rem', background: '#2563eb', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
            Explore Reviews
          </button>
          <button style={{ padding: '0.75rem 1.5rem', border: '2px solid #2563eb', color: '#2563eb', background: 'white', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>
            Write a Review
          </button>
        </div>
      </section>

      {/* Features Section */}
      <section style={{ background: 'white', padding: '5rem 1rem' }}>
        <div style={{ maxWidth: '80rem', margin: '0 auto' }}>
          <h3 style={{ fontSize: '1.875rem', fontWeight: 'bold', textAlign: 'center', color: '#111827', marginBottom: '3rem' }}>
            Why Join BookReview?
          </h3>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem' }}>
            {[
              {
                icon: '⭐',
                title: 'Rate & Review',
                description: 'Share your honest thoughts about books you love',
              },
              {
                icon: '🔍',
                title: 'Discover',
                description: 'Find your next favorite book from community recommendations',
              },
              {
                icon: '👥',
                title: 'Connect',
                description: 'Join a community of passionate readers',
              },
            ].map((feature) => (
              <div
                key={feature.title}
                style={{ padding: '1.5rem', border: '1px solid #e5e7eb', borderRadius: '0.5rem' }}
              >
                <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>{feature.icon}</div>
                <h4 style={{ fontSize: '1.25rem', fontWeight: '600', color: '#111827', marginBottom: '0.5rem' }}>
                  {feature.title}
                </h4>
                <p style={{ color: '#4b5563' }}>{feature.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer style={{ background: '#111827', color: 'white', padding: '2rem 1rem', textAlign: 'center' }}>
        <p>&copy; 2026 BookReview. All rights reserved.</p>
      </footer>
    </main>
  )
}
