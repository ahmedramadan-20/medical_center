# 🏥 Medical Center - Flutter Healthcare Application

A comprehensive Flutter-based healthcare management application with Firebase backend integration. The app provides seamless user authentication, appointment booking, doctor discovery, and patient profile management features.

**Current Version:** 1.0.0+1  
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

### Core Functionality
- **User Authentication**
  - Sign Up with email validation
  - Sign In with credentials
  - Password recovery (Forgot Password)
  - Firebase Authentication integration

- **Onboarding**
  - Interactive onboarding screens
  - Smooth page transitions using animations
  - User preferences setup

- **Home & Discovery**
  - Homepage with featured doctors
  - Doctor browsing and filtering
  - Blood type management
  - Profile customization

- **Appointments**
  - Browse and book appointments
  - View appointment history
  - Calendar integration

- **User Profile**
  - View and edit profile information
  - Manage personal health data
  - Blood type tracking

### Technical Features
- **Multi-language Support** (English & Arabic)
- **Persistent State Management** (Cached preferences)
- **Smooth Animations** (Lottie animations, Flutter Animate)
- **Responsive UI** (Scales across different devices)
- **Offline Support** (Shared preferences caching)

---

## 📸 Screenshots

<div align="center">

| Splash Screen | Onboarding 1 | Onboarding 2 |
|:---:|:---:|:---:|
| <img width="280" height="500" alt="Splash Screen" src="https://github.com/user-attachments/assets/eb2d09f5-8965-436d-973e-5a36803ea556" /> | <img width="280" height="500" alt="Onboarding 1" src="https://github.com/user-attachments/assets/9436a27f-c4ac-4441-8a12-6d825e3faf53" /> | <img width="280" height="500" alt="Onboarding 2" src="https://github.com/user-attachments/assets/79ae1c87-33f3-4b9b-8e5e-6ee3fa18b978" /> |

| Onboarding 3 | Sign In | Sign Up |
|:---:|:---:|:---:|
| <img width="280" height="500" alt="Onboarding 3" src="https://github.com/user-attachments/assets/f7e6c382-8494-4d9b-a94c-4a19981dd76e" /> | <img width="280" height="500" alt="Sign In" src="https://github.com/user-attachments/assets/acb0428b-f5de-406b-9048-7160ed770bac" /> | <img width="280" height="500" alt="Sign Up" src="https://github.com/user-attachments/assets/c1f93798-b42f-4e27-b582-6cc986e8afc3" /> |

| Forget Password |
|:---:|
| <img width="280" height="500" alt="Forget Password" src="https://github.com/user-attachments/assets/181c05c3-953f-4281-bc01-ce45af13065f" /> |

</div>

---

## 🏗️ Project Architecture

The project follows **Clean Architecture** principles with **BLoC** pattern for state management:

```
medical_center/
├── Presentation Layer    (UI, Pages, Widgets, BLoCs/Cubits)
├── Data Layer           (Models, Repositories, Data Sources)
├── Domain Layer         (Entities, Use Cases, Repository Interfaces)
└── Core Layer           (Database, Services, Utilities, Routes)
```

### Design Patterns Used
- **BLoC/Cubit** - State management
- **Repository Pattern** - Data abstraction
- **Service Locator (GetIt)** - Dependency injection
- **Go Router** - Navigation
- **Firebase** - Backend services

---

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry point
├── firebase_options.dart              # Firebase configuration
├── injection_container.dart           # Dependency injection setup
│
├── app/
│   ├── medical_center_app.dart       # Root app widget
│   ├── global_cubit/                 # Global state (Locale, Theme, etc.)
│   ├── repositories/                 # App-level repositories
│   └── usecases/                     # App-level use cases
│
├── core/                              # Shared utilities & services
│   ├── database/
│   │   └── cache/
│   │       └── cache_helper.dart     # Local storage management
│   ├── errors/                       # Error handling & exceptions
│   ├── functions/
│   │   └── check_user_state.dart    # User auth state checks
│   ├── routes/
│   │   └── app_router.dart          # Navigation routes (Go Router)
│   ├── services/
│   │   └── service_locator.dart     # GetIt service setup
│   ├── usecases/                    # Core/shared use cases
│   ├── utils/
│   │   ├── app_colors.dart          # Color constants
│   │   └── [other utilities]
│   └── widgets/                      # Shared/reusable widgets
│
├── features/                          # Feature modules (Clean Architecture)
│   ├── splash/
│   │   └── presentation/
│   │       └── views/splash_view.dart
│   │
│   ├── on_boarding/
│   │   ├── presentation/
│   │   │   ├── views/on_boarding_view.dart
│   │   │   ├── widgets/
│   │   │   └── view_model/cubit/on_boarding_cubit.dart
│   │   └── data/
│   │
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── views/
│   │   │   │   ├── sign_up_view.dart
│   │   │   │   ├── sign_in_view.dart
│   │   │   │   └── forgot_password_view.dart
│   │   │   ├── widgets/
│   │   │   └── auth_cubit/auth_cubit.dart
│   │   └── data/
│   │
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── views/
│   │   │   │   └── doctor_view.dart
│   │   │   └── widgets/home_nav_bar_widget.dart
│   │   └── data/
│   │       └── models/doctors_model.dart
│   │
│   ├── appointments/
│   │   ├── presentation/
│   │   └── data/
│   │
│   ├── profile/
│   │   ├── presentation/
│   │   └── data/
│   │
│   └── blood_type/
│       ├── presentation/
│       └── data/
│
├── generated/                        # Auto-generated files
│   ├── l10n.dart                    # Localization strings
│   └── intl/
│
└── l10n/                            # Localization files
    ├── intl_en.arb                  # English translations
    └── intl_ar.arb                  # Arabic translations

assets/
├── images/                          # App graphics & animations
│   ├── banner1.json                # Lottie animations
│   ├── onBoarding1.json
│   ├── onBoarding2.json
│   ├── onBoarding3.json
│   ├── password1.json
│   ├── splashlogo.json
│   └── no-data.json
└── fonts/
    ├── Poppins-Regular.ttf          # Custom fonts
    └── Cairo-VariableFont_slnt,wght.ttf

android/                            # Android native configuration
├── app/google-services.json         # Firebase Android config
└── [gradle build files]

ios/                                # iOS native configuration
├── Runner/
│   ├── GoogleService-Info.plist    # Firebase iOS config
│   └── Info.plist
└── [Xcode project files]
```

---

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK: >=3.1.3 <4.0.0
- Dart SDK: Latest version
- Android SDK (for Android development)
- Xcode (for iOS development)
- Firebase Project setup

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/ahmedramadan-20/medical_center.git
   cd medical_center
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate localization files**
   ```bash
   flutter pub run intl_utils:generate
   ```

4. **Build generated files**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Set up Firebase**
   - Download `google-services.json` from Firebase Console and place it in `android/app/`
   - Download `GoogleService-Info.plist` and place it in `ios/Runner/`

6. **Run the app**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

### Core Framework
- **flutter** - UI framework
- **cupertino_icons** (^1.0.2) - iOS-style icons

### State Management & DI
- **flutter_bloc** (^9.1.1) - BLoC pattern implementation
- **bloc** (^9.0.1) - Business Logic Component
- **get_it** (^8.2.0) - Service locator for dependency injection

### Navigation & Routing
- **go_router** (^16.2.4) - Modern routing solution
- **persistent_bottom_nav_bar** (^5.0.2) - Bottom navigation bar

### Firebase Services
- **firebase_core** (^4.1.1) - Firebase initialization
- **firebase_auth** (^6.1.0) - Authentication
- **cloud_firestore** (^6.0.2) - Cloud database

### UI/UX Components
- **flutter_svg** (^2.0.7) - SVG rendering
- **lottie** (^3.3.2) - Animation library
- **flutter_animate** (^4.2.0+1) - Animation utilities
- **smooth_page_indicator** (^1.1.0) - Page indicators
- **cached_network_image** (^3.3.0) - Image caching
- **like_button** (^2.0.5) - Like/favorite button widget
- **fluttertoast** (^9.0.0) - Toast notifications

### Data & Storage
- **shared_preferences** (^2.2.1) - Local data persistence
- **intl** (^0.20.2) - Localization

### Utilities
- **equatable** (^2.0.5) - Value equality support
- **dartz** (^0.10.1) - Functional programming (Either type)
- **flutter_localization** (^0.3.3) - Localization support

---

## 🌍 Key Technologies

| Component | Technology |
|-----------|-----------|
| **Language** | Dart 3.1.3+ |
| **Framework** | Flutter |
| **State Management** | BLoC / Cubit |
| **Backend** | Firebase (Auth, Firestore) |
| **Database** | Cloud Firestore |
| **Local Storage** | Shared Preferences |
| **Navigation** | Go Router |
| **DI Container** | GetIt |
| **Functional Programming** | Dartz (Either pattern) |
| **Localization** | Intl (EN, AR) |
| **UI Pattern** | Clean Architecture |

---

## 🗺️ Routing

The app uses **Go Router** for navigation with the following routes:

| Route | View | Purpose |
|-------|------|---------|
| `/` | Splash Screen | Initial loading screen |
| `/onBoarding` | Onboarding | First-time user flow |
| `/signUp` | Sign Up | User registration |
| `/signIn` | Sign In | User login |
| `/homeNavBar` | Home Navigation | Main app interface |
| `/doctor` | Doctor Details | Individual doctor info |
| `/forgotPassword` | Forgot Password | Password recovery |

**Route Configuration:** `lib/core/routes/app_router.dart`

---

## 🌐 Localization

The app supports **English** and **Arabic** with dynamic language switching via **LocaleCubit**.

**Supported Locales:**
- 🇺🇸 English (en)
- 🇸🇦 Arabic (ar)

**Translation Files:**
- `lib/l10n/intl_en.arb` - English strings
- `lib/l10n/intl_ar.arb` - Arabic strings

**Generated Files:**
- `lib/generated/l10n.dart` - Auto-generated localization class

### Adding New Translations

1. Edit the `.arb` files with new key-value pairs
2. Run: `flutter pub run intl_utils:generate`
3. Use `S.of(context).keyName` in your widgets

---

## 🔥 Firebase Integration

### Services Used
- **Firebase Authentication** - User account management
- **Cloud Firestore** - Real-time database for doctors, appointments, etc.
- **Firebase Core** - Initialization & configuration

### Configuration Files
- **Android:** `android/app/google-services.json`
- **iOS:** `ios/Runner/GoogleService-Info.plist`

### Firebase Options
Configured in: `lib/firebase_options.dart`

---

## 💻 Development Guidelines

### Code Structure
- Follow **Clean Architecture** principles
- Separate concerns: Presentation → Domain → Data
- Use **BLoC/Cubit** for state management
- Implement **Repository Pattern** for data access

### File Naming Conventions
- **Screens:** `*_view.dart` (e.g., `sign_in_view.dart`)
- **Widgets:** `*_widget.dart` (e.g., `app_button_widget.dart`)
- **BLoCs:** `*_cubit.dart` or `*_bloc.dart`
- **Models:** `*_model.dart`
- **Entities:** `*_entity.dart`

### Best Practices
✅ Use const constructors  
✅ Implement proper error handling  
✅ Cache images with `cached_network_image`  
✅ Use responsive layouts (MediaQuery, LayoutBuilder)  
✅ Add null safety checks  
✅ Document complex logic with comments  

---

## 🔨 Building & Deployment

### Debug Build
```bash
flutter run
```

### Build APK (Android)
```bash
flutter build apk --release
```

### Build App Bundle (Android - Play Store)
```bash
flutter build appbundle --release
```

### Build IPA (iOS)
```bash
flutter build ios --release
```

### Build Web
```bash
flutter build web --release
```

---

## 📊 Project Statistics

- **Features:** 7 major modules (Splash, Onboarding, Auth, Home, Appointments, Profile, Blood Type)
- **Screens:** 8+ screens
- **Supported Platforms:** Android, iOS, Web, macOS, Linux, Windows
- **Localization:** 2 languages
- **Dependencies:** 25+ packages

---

## 🤝 Contributing

Contributions are welcome! Please ensure to:
1. Follow the project structure
2. Implement features using Clean Architecture
3. Add appropriate documentation
4. Test thoroughly before submitting PR

---

## 📝 License

This project is private and maintained by [ahmedramadan-20](https://github.com/ahmedramadan-20)

---

## 🆘 Support & Resources

- [Flutter Documentation](https://flutter.dev)
- [BLoC Pattern](https://bloclibrary.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Clean Architecture Guide](https://medium.com/flutter-community)

---

**Last Updated:** November 2025  
**Version:** 1.0.0+1  
**Status:** Active Development
