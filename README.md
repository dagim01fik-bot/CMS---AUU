# CMS AAU - College Management System

A production-grade College Management System for AAU, built with Flutter, ASP.NET Core, PostgreSQL, Redis, and MinIO.

## Project Structure

```
CMS-AAU/
├── backend/               # ASP.NET Core Clean Architecture backend
│   ├── src/
│   │   ├── CmsAau.Domain/      # Domain layer (entities, value objects)
│   │   ├── CmsAau.Application/ # Application layer (use cases, DTOs)
│   │   ├── CmsAau.Infrastructure/ # Infrastructure layer (EF Core, Redis, MinIO)
│   │   └── CmsAau.Api/         # REST API controllers
│   └── tests/
├── mobile/                # Flutter mobile apps
│   ├── student_app/       # Student app (in progress)
│   ├── security_app/      # Security guard app (QR scanning, visitor management)
│   └── instructor_app/    # Instructor app (attendance, grading, etc.)
├── web/                   # React + TypeScript web portals
│   ├── admin_portal/      # Admin portal
│   ├── hr_portal/         # HR portal
│   ├── college_portal/    # College management portal
│   ├── library_portal/    # Library management portal
│   └── finance_portal/    # Finance portal
├── tools/                 # Tools and utilities
│   ├── student_tools/
│   ├── instructor_tools/
│   └── library_uploads/
├── docs/                  # Documentation
├── docker/                # Docker configurations
└── docker-compose.yml
```

## Getting Started

### Option 1: Self-hosted (Docker)
Requires Docker and Docker Compose installed.

1. Start PostgreSQL, Redis, and MinIO:
   ```bash
   docker-compose up -d
   ```

2. Run the backend API (from `backend/` directory):
   ```bash
   dotnet restore
   dotnet run --project src/CmsAau.Api/CmsAau.Api.csproj
   ```

3. Run the Flutter student app (from `mobile/student_app/` directory):
   ```bash
   flutter pub get
   flutter run
   ```

### Option 2: Supabase (No Docker, Low RAM)
1. Create a free Supabase account: https://supabase.com
2. Create a new project
3. Use the Supabase Flutter package in `mobile/student_app/pubspec.yaml`

## Tech Stack
- **Mobile**: Flutter (Riverpod, GoRouter, Hive)
- **Web**: React + TypeScript
- **Backend**: ASP.NET Core 8 (Clean Architecture)
- **Database**: PostgreSQL
- **Cache/Sessions**: Redis
- **File Storage**: MinIO (or Supabase Storage)
- **Realtime**: SignalR

## Features (Planned)
- Student Mobile App (Attendance, Grades, Finance, Digital ID)
- Security Guard App (QR Scanning, Visitor Management)
- Instructor App (Attendance, Grading, OMR Exams)
- Admin Portal (User Management, Reports, Audit Logs)
- Finance Portal (Invoices, Payments, Verification)
- Library Portal (Book Management, Checkouts)
- HR Portal (Staff Management)

## License
MIT License
