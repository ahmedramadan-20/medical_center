# 🏥 Medical Center - Flutter Healthcare Application

A comprehensive Flutter-based healthcare management application with Firebase backend integration. The app provides seamless user authentication, appointment booking, doctor discovery, and an advanced administrative dashboard.

**Current Version:** 1.1.0  
**Flutter SDK:** >=3.1.3 <4.0.0  
**Repository:** [ahmedramadan-20/medical_center](https://github.com/ahmedramadan-20/medical_center)

---

## 📋 Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Project Architecture](#project-architecture)
- [Project Structure](#project-structure)
- [Installation & Setup](#installation--setup)
- [Dependencies](#dependencies)
- [Key Technologies](#key-technologies)
- [Routing](#routing)
- [Localization](#localization)
- [Firebase Integration](#firebase-integration)
- [Development Guidelines](#development-guidelines)
- [Building & Deployment](#building--deployment)

---

## ✨ Features

### 👤 User Features
- **Authentication**
  - Secure Sign Up/Sign In with Firebase
  - Password recovery flow
  - Robust null-safe user profiles
- **Doctor Discovery**
  - Browse doctors by specialty
  - Real-time category filtering
  - Detailed doctor profiles with robust scheduling
- **Appointments**
  - **Today's Booking**: Intelligent booking enabled based on real-time doctor schedules.
  - **Patient Profiles**: Flexible booking for self or family members.
  - **My Appointments**: Real-time list to track status (Pending/Confirmed/Cancelled).
- **Health Management**
  - Profile customization
  - Blood type tracking and records

### 🛡️ Admin Features
- **Dynamic Dashboard**
  - High-level overview of system statistics
  - Quick action shortcuts
- **User Management**
  - Promote/Demote administrators
  - Securely delete user accounts
- **Doctor & Specialty Management**
  - Full CRUD for doctors with advanced scheduling logic
  - Manage specialties and blood records
- **Data Integrity**
  - Robust error handling for empty/null Firestore fields

### 🛠️ Technical Features
- **Clean Architecture**: Modular and testable code structure.
- **Multi-language**: Fully localized in English (en) & Arabic (ar).
- **V2 Navigation**: Migrated to `persistent_bottom_nav_bar_v2`.
- **Offline First**: Local caching with Shared Preferences.
- **Premium UI**: Modern design with Lottie animations and glassmorphism elements.

---

## 📸 Screenshots

<div align="center">

| Admin Dashboard | User Management | Doctor Booking |
|:---:|:---:|:---:|
| <img width="280" height="500" alt="Admin Dashboard" src="https://github.com/user-attachments/assets/1766059401281" /> | <img width="280" height="500" alt="User Management" src="https://github.com/user-attachments/assets/1766059612490" /> | <img width="280" height="500" alt="Booking Screen" src="https://github.com/user-attachments/assets/c1f93798-b42f-4e27-b582-6cc986e8afc3" /> |

</div>

---

## 🏗️ Project Architecture

The project follows **Clean Architecture** principles with **BLoC/Cubit** for state management:

```
medical_center/
├── Presentation Layer    (UI, Pages, Widgets, BLoCs/Cubits)
├── Data Layer           (Models, Repositories, Data Sources)
├── Domain Layer         (Entities, Use Cases, Repository Interfaces)
└── Core Layer           (Database, Services, Utilities, Routes)
```

---

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/                              # Shared utilities & services
│   ├── routes/app_router.dart         # Go Router configuration
│   └── widgets/                       # Shared/reusable widgets
├── features/                          # Feature modules
│   ├── admin/                         # Admin dashboard & management
│   ├── appointments/                  # Reservation system
│   ├── home/                          # Doctor discovery & home view
│   ├── auth/                          # Authentication flow
│   ├── blood_type/                    # Blood record management
│   ├── profile/                       # User profile management
│   └── on_boarding/                  # First-time user experience
└── l10n/                              # Localization files (AR/EN)
```

---

## 📦 Key Dependencies

- **State Management**: `flutter_bloc`, `bloc`
- **Dependency Injection**: `get_it`
- **Navigation**: `go_router`, `persistent_bottom_nav_bar_v2`
- **Backend**: `firebase_core`, `firebase_auth`, `cloud_firestore`
- **Animations**: `lottie`, `flutter_animate`
- **Utilities**: `shared_preferences`, `intl`, `uuid`, `cached_network_image`

---

## 🚀 Quick Setup

1. **Pub Get**: `flutter pub get`
2. **Localization**: `flutter pub run intl_utils:generate`
3. **Run**: `flutter run`

---

## 📊 Project Statistics

- **Features**: 8 Major modules
- **Screens**: 15+ Advanced screens
- **Localization**: Full English & Arabic support
- **Safety**: 100% Robust null-handling for Firebase data

---

## 📝 License

Maintainer: [ahmedramadan-20](https://github.com/ahmedramadan-20)  
**Last Updated:** December 2024  
**Status:** Feature Rich & Stable
