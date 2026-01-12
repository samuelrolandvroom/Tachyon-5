# Tachyon-5: Project Brainstorm & Architecture

**Date**: January 11, 2026  
**Status**: Pre-Development (Brainstorm Phase)  
**Version**: 1.0

---

## 🎯 Project Overview

**Tachyon-5** is a cross-platform, real-time note-taking, task management, and reminder application built with Flutter for mobile & desktop, Jaspr for web, and Dart Frog for backend orchestration. The app emphasizes speed, reliability, and seamless synchronization across devices.

### Core Purpose
Empower users to capture, organize, and synchronize thoughts, tasks, and reminders with enterprise-grade security and consumer-friendly UX.

### Platform Support
- **Mobile**: iOS & Android (Flutter)
- **Desktop**: Windows & macOS (Flutter)
- **Web**: Cross-browser compatible (Dart Jaspr)
- **Backend**: Dart Frog with Dart

---

## 📋 Feature Requirements

### Phase 1: MVP (Boilerplate & Foundation)
- [ ] User authentication & session management
- [ ] Create/Read/Update/Delete notes
- [ ] Create/Read/Update/Delete tasks with due dates
- [ ] Create/Read/Update/Delete reminders with notifications
- [ ] Real-time sync across devices
- [ ] Offline-first architecture (local caching)

### Phase 2: Enhanced Features (Post-Launch)
- [ ] Task categories & tags
- [ ] Note search & filters
- [ ] Shared notebooks & collaborative editing
- [ ] Recurring reminders
- [ ] Rich text editor with markdown support
- [ ] File attachments

### Phase 3: Intelligence & Analytics
- [ ] AI-powered task suggestions
- [ ] Productivity analytics dashboard
- [ ] Smart reminders based on context
- [ ] Natural language parsing for quick captures

---

## 🏗️ Technical Architecture

### Database Schema (PostgreSQL)

```
Tables:
├── users
│   ├── id (UUID, PK)
│   ├── email (unique, indexed)
│   ├── password_hash (bcrypt)
│   ├── full_name
│   ├── created_at
│   ├── updated_at
│   └── deleted_at (soft delete)
│
├── notes
│   ├── id (UUID, PK)
│   ├── user_id (FK → users)
│   ├── title
│   ├── content (text)
│   ├── created_at
│   ├── updated_at
│   ├── deleted_at (soft delete)
│   └── is_synced (boolean)
│
├── tasks
│   ├── id (UUID, PK)
│   ├── user_id (FK → users)
│   ├── title
│   ├── description (optional)
│   ├── due_date (nullable)
│   ├── completed_at (nullable)
│   ├── priority (enum: low, medium, high)
│   ├── created_at
│   ├── updated_at
│   ├── deleted_at (soft delete)
│   └── is_synced (boolean)
│
└── reminders
    ├── id (UUID, PK)
    ├── user_id (FK → users)
    ├── title
    ├── description (optional)
    ├── scheduled_for (timestamp)
    ├── triggered_at (nullable)
    ├── is_dismissed (boolean)
    ├── created_at
    ├── updated_at
    ├── deleted_at (soft delete)
    └── is_synced (boolean)
```

**Remote Database**: PostgreSQL 14+  
**Connection String**: `postgresql://mypostgres:mypassword@10.0.0.33:5432/tachyon-5`

---

## 🎨 Brand Integration

### Visual Identity (Leveraging Brand Strategy)
- **Primary Color**: Atlantis Blue (`#00D4FF`) → Action buttons, active states
- **Secondary Color**: Event Horizon (`#0A192F`) → Main background
- **Accent Color**: Zero-Point Amber (`#FFB800`) → Reminders, high-priority tasks
- **Success**: `#10B981` → Completed tasks, sync success
- **Error**: `#EF4444` → Failed sync, validation errors
- **Status**: Shield Violet (`#6D28D9`) → Encryption indicators

### Typography
- **Headings**: Michroma (Google Fonts)
- **Body**: Inter (Google Fonts)
- **Monospace**: JetBrains Mono (for code blocks)

### Design Principles
- Dark mode first (Event Horizon background)
- 8px grid system for spacing
- Minimum 44px touch targets (mobile)
- WCAG 2.1 Level AA contrast compliance
- Animations: 200–400ms with ease-in-out easing
- Logo usage: Minimum 40px digital, with 1x clear space

---

## 🛠️ Tech Stack

### Backend (Dart Frog)
- **Framework**: Dart Frog (Dart)
- **Database**: PostgreSQL 14+ (Remote: 10.0.0.33:5432)
- **ORM**: Dart Frog's built-in ORM
- **Authentication**: JWT tokens with refresh mechanism
- **API**: RESTful endpoints + WebSocket for real-time sync
- **Deployment**: Docker container (future: AWS/GCP)

### Frontend (Flutter)
- **Framework**: Flutter 3.27+ (latest stable)
- **State Management**: Riverpod or Provider
- **Local Storage**: Hive or sqflite
- **HTTP Client**: dio or http
- **WebSocket**: web_socket_channel
- **Platforms**: iOS, Android, Windows, macOS

### Frontend (Web - Jaspr)
- **Framework**: Dart Jaspr
- **State Management**: Shared Riverpod from Flutter app
- **Styling**: Tailwind CSS or Jaspr's built-in CSS
- **Build Output**: JavaScript (compiled from Dart)
- **Browsers**: Chrome, Firefox, Safari, Edge (latest 2 versions)

### Shared Dart Libraries
- `tachyon_core`: Models, utilities, constants
- `tachyon_api`: Client for Dart Frog API
- `tachyon_ui`: Reusable UI components (Material/Cupertino)

---

## 📁 Project Structure

```
tachyon-5/
├── docs/
│   ├── brand-strategy.md
│   ├── brainstorm.md (this file)
│   ├── logo.png
│   ├── API_SPEC.md (future)
│   └── DEPLOYMENT.md (future)
│
├── backend/
│   └── tachyon_server/ (Dart Frog project)
│       ├── lib/
│       │   ├── server.dart
│       │   ├── endpoints/ (RPC endpoints)
│       │   └── models/ (data models)
│       ├── migrations/ (database migrations)
│       ├── test/
│       ├── pubspec.yaml
│       └── config/
│           └── docker-compose.yml
│
├── frontend_mobile/
│   └── tachyon_app/ (Flutter project)
│       ├── lib/
│       │   ├── main.dart
│       │   ├── screens/ (UI screens)
│       │   ├── widgets/ (reusable components)
│       │   ├── models/ (state models)
│       │   ├── services/ (API, local storage)
│       │   └── theme/ (branding colors, typography)
│       ├── test/
│       ├── windows/ (Windows-specific code)
│       ├── ios/ (iOS-specific code)
│       ├── android/ (Android-specific code)
│       └── pubspec.yaml
│
├── frontend_web/
│   └── tachyon_web/ (Jaspr project)
│       ├── lib/
│       │   ├── main.dart
│       │   ├── pages/ (web pages)
│       │   ├── components/ (reusable UI)
│       │   ├── services/ (API, state)
│       │   └── theme/ (styling, colors)
│       ├── test/
│       ├── web/ (HTML template)
│       └── pubspec.yaml
│
├── packages/ (Shared Dart libraries)
│   ├── tachyon_core/
│   │   ├── lib/
│   │   │   ├── models/ (Note, Task, Reminder, User)
│   │   │   ├── constants/ (app config, colors, strings)
│   │   │   └── utils/ (helpers, extensions)
│   │   └── pubspec.yaml
│   │
│   ├── tachyon_api/
│   │   ├── lib/
│   │   │   ├── client/ (Dart Frog client)
│   │   │   └── serialization/ (JSON/proto serialization)
│   │   └── pubspec.yaml
│   │
│   └── tachyon_ui/
│       ├── lib/
│       │   ├── components/ (buttons, inputs, cards)
│       │   ├── theme/ (color scheme, typography)
│       │   └── animations/ (transitions, micro-interactions)
│       └── pubspec.yaml
│
├── .gitignore
├── .github/
│   └── workflows/ (CI/CD: tests, builds, deploys)
├── README.md
└── pubspec.yaml (root workspace)
```

---

## 🔄 Development Workflow

### Phase 1: Foundation & Boilerplate
1. **Flutter Mobile App** ✓ (boilerplate only)
   - Project setup with iOS, Android, Windows, macOS support
   - Basic navigation structure
   - Theme & branding applied
   - Empty home screen with app bar

2. **Jaspr Web App** ✓ (boilerplate only)
   - Project setup with web build
   - Matching theme from Flutter app
   - Basic routing
   - Landing page skeleton

3. **Dart Frog Backend** ✓ (boilerplate only)
   - Dart Frog project initialized
   - PostgreSQL remote connection configured
   - Basic authentication endpoint
   - Health check endpoint

### Phase 2: Core Features
4. Build shared Dart packages (models, UI components)
5. Implement database schema & migrations
6. Build API endpoints (notes, tasks, reminders CRUD)
7. Implement authentication flow
8. Build Flutter screens (list, detail, create views)
9. Build Jaspr pages (matching Flutter screens)
10. Integrate WebSocket for real-time sync

### Phase 3: Testing & Deployment
11. Unit & integration testing
12. CI/CD pipeline setup
13. Docker containerization for backend
14. Production deployment

---

## 🔐 Security Considerations

- **Authentication**: JWT tokens with 24-hour expiration + refresh tokens
- **Database**: Connection pooling, parameterized queries, encrypted passwords
- **API**: Rate limiting, CORS configuration, HTTPS/WSS only
- **Client**: Encrypted local storage (Hive encryption), secure token storage
- **Data**: Soft deletes, audit logging, user data isolation

---

## 📦 Dependencies & Tools

### Version Constraints
- **Dart**: 3.3+
- **Flutter**: 3.27+ (latest stable)
- **PostgreSQL**: 14+
- **Docker**: 24.0+ (for backend)

### Key Packages
- **Backend**: `Dart Frog`, `Dart Frog_cli`, `postgres`
- **Mobile**: `flutter`, `riverpod`, `hive`, `dio`, `connectivity_plus`
- **Web**: `jaspr`, `riverpod_web`, `web`
- **Shared**: `dartx`, `freezed`, `json_serializable`

---

## 🚀 Deployment Strategy

### Backend (Dart Frog)
- **Local Dev**: Docker Compose with PostgreSQL container
- **Production**: Kubernetes cluster or managed container service
- **Database**: Remote PostgreSQL on 10.0.0.33:5432

### Flutter App
- **iOS**: TestFlight for beta, App Store for release
- **Android**: Firebase App Distribution for beta, Play Store for release
- **Windows**: Direct download or Microsoft Store
- **macOS**: Direct download or Mac App Store

### Web (Jaspr)
- **Hosting**: Vercel, Netlify, or static hosting (CDN)
- **Build**: Automated via GitHub Actions

---

## 📊 Success Metrics

- ✅ All 3 components (Flutter, Jaspr, Dart Frog) buildable & testable in isolation
- ✅ Seamless data sync across platforms within 2 seconds
- ✅ 99.9% uptime for backend
- ✅ Sub-500ms API response times
- ✅ WCAG 2.1 Level AA compliance on all platforms
- ✅ > 95% test coverage on critical paths

---

## 📝 Next Steps

1. Initialize Flutter project with boilerplate (iOS, Android, Windows, macOS)
2. Verify Flutter app runs without errors on all platforms
3. Initialize Jaspr web project with matching branding
4. Verify Jaspr build succeeds and runs in browser
5. Initialize Dart Frog backend with PostgreSQL connection
6. Verify Dart Frog runs and connects to remote database
7. Set up CI/CD pipeline in GitHub Actions
8. Begin Phase 2: Core feature implementation

---

**Maintained by**: Development Team  
**Last Updated**: January 11, 2026
