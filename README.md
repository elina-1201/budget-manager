# Budget Manager

> **Work in Progress**: This project is actively being developed. Some features are not yet fully implemented.

A full-stack personal & group expense tracking application built with **Flutter** (cross-platform mobile) and **Spring Boot** (REST API).

---

## About

**Budget Manager** helps users track their daily expenses, organize them into custom categories, and visualize spending patterns. The app supports both **offline-first** local storage and **online** cloud synchronization via a REST API, giving users flexibility regardless of internet connectivity. It also features user groups for shared expense management it's ideal for households, roommates, or small teams.

---

## Features

### Implemented
- **User Authentication**: Register and login with JWT-based authentication (access + refresh tokens).
- **Expense CRUD**: Create, view, delete expense items with name, description, amount, and category.
- **Custom Categories**: Create and manage personalized spending categories.
- **User Groups**: Create groups and share expenses among members.
- **Invitations**: Invite other users to join a group in app.
- **REST API with OpenAPI docs**: Fully documented API endpoints via Swagger UI.
- **PostgreSQL + H2**: PostgreSQL in production, H2 in-memory database for local dev fallback.

### In Progress / Planned
- **Statistics Dashboard**: Pie chart breakdown of spending by category.
- **Spending Trends**: Monthly spending trend visualization over time.
- **Offline-First Mode**: Local SQLite database (sqflite) with seamless online sync when connectivity is available.
- **Edit & Update Items**: Backend endpoint and frontend UI for modifying existing expenses.
- **UI/UX**: Material Design UI with bottom navigation tabs, swipe gestures, and responsive forms.

---

## Tech Stack

### Backend
| Technology | Purpose |
|---|---|
| **Java 17** | Language |
| **Spring Boot 4.0** | Web framework |
| **Spring Security + OAuth2** | Authentication & authorization |
| **JWT (RS256)** | Token-based auth |
| **Spring Data JPA** | Database ORM |
| **PostgreSQL** | Production database |
| **H2** | Local dev database |
| **MapStruct** | Entity-DTO mapping |
| **Lombok** | Boilerplate reduction |
| **OpenAPI / Swagger** | API documentation |

### Frontend
| Technology | Purpose |
|---|---|
| **Flutter** + **Dart** | Cross-platform UI framework |
| **Riverpod** | State management |
| **GoRouter** | Navigation & routing |
| **Dio** | HTTP client for API calls |
| **sqflite** | Local SQLite database (offline) |
| **flutter_secure_storage** | Secure token storage |
| **shared_preferences** | Local key-value settings |

### Infrastructure
| Tool | Purpose |
|---|---|
| **Docker Compose** | PostgreSQL container setup |
| **Gradle** | Backend build tool |
| **Pub** | Frontend dependency manager |

---

## Getting Started

### Prerequisites
- Java 17+
- Flutter SDK ^3.12.0
- Docker (optional, for PostgreSQL)

### Backend (Spring Boot)

```bash
cd backend

# Run with H2 (default, no database setup needed)
./gradlew bootRun

# Or run with PostgreSQL via Docker
docker compose up -d
DB_URL=jdbc:postgresql://localhost:5432/budget ./gradlew bootRun
```

API will be available at `http://localhost:8080`.  
Swagger UI at `http://localhost:8080/swagger-ui/index.html`.

### Frontend (Flutter)

```bash
cd frontend
flutter pub get
flutter run
```

---

## API Overview

| Method | Endpoint | Description | Auth |
|---|---|---|---|
| POST | `/auth/register` | Register new user | No |
| POST | `/auth/token` | Login (get JWT) | Basic |
| POST | `/auth/refresh` | Refresh JWT token | No |
| GET/POST | `/item` | List / Create expenses | JWT |
| DELETE | `/item/{id}` | Delete an expense | JWT |
| GET/POST | `/category` | List / Create categories | JWT |
| GET/POST | `/group` | List / Create groups | JWT |
| POST | `/invitation` | Send group invitation | JWT |