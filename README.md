# BookReview - Share Your Reading Journey

A modern web application for sharing and discovering book reviews. Connect with readers worldwide and build your personal library.

## Features

- **Book Reviews**: Write and share detailed reviews of books you've read
- **Rating System**: Rate books on a 5-star scale
- **User Profiles**: Create a profile to showcase your reading history
- **Discovery**: Find new books based on community recommendations
- **Community**: Connect with other readers and see what they're reading
- **Search & Filter**: Find books by title, author, genre, and rating

## Tech Stack

- **Frontend**: Next.js 16 with TypeScript
- **Styling**: Tailwind CSS
- **Database**: PostgreSQL
- **Authentication**: NextAuth.js (to be integrated)
- **API**: Next.js API Routes

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn
- PostgreSQL database

### Installation

1. Install dependencies:
```bash
npm install
```

2. Create a `.env.local` file with your configuration:
```env
DATABASE_URL=postgresql://user:password@localhost:5432/bookreview
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000
```

3. Run the development server:
```bash
npm run dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser

## Project Structure

```
src/
├── app/                 # Next.js app router
│   ├── layout.tsx       # Root layout
│   └── page.tsx         # Home page
├── components/          # React components
├── lib/                 # Utility functions
├── styles/              # Global styles
└── types/               # TypeScript types
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm start` - Run production server
- `npm run lint` - Run ESLint

## Database Schema

### Books Table
- id, title, author, isbn, description, cover_url, published_at

### Reviews Table
- id, book_id, user_id, rating (1-5), title, content, created_at, updated_at

### Users Table
- id, email, name, password_hash, bio, profile_image, created_at

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - feel free to use this project for your own purposes.

## Roadmap

- [ ] User authentication
- [ ] Book management (create/read/update/delete reviews)
- [ ] Advanced search and filtering
- [ ] User profiles and follow system
- [ ] Rating and recommendation algorithms
- [ ] Mobile app
