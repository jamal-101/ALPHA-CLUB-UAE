# Alpha Club - Flutter Mobile Application

A feature-rich Flutter application for managing club memberships, events, offers, and exclusive benefits. Built with GetX for state management and Dio for API integration.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [API Configuration](#api-configuration)
- [Key Components](#key-components)
- [Development Guidelines](#development-guidelines)

---

## 🎯 Project Overview

**Alpha Club** is a comprehensive membership management platform that enables users to:
- Manage digital membership cards
- Browse and register for exclusive events
- Access partner offers and discounts
- Discover clubs and facilities
- Manage family memberships
- Track membership benefits

**Version:** 1.0.0+1  
**Minimum SDK:** Dart 3.10.0  
**Target Platforms:** Android, iOS, Web, Windows, macOS, Linux

---

## 🏗️ Architecture

The project follows a **modular feature-based architecture** with clear separation of concerns:

```
lib/
├── core/                    # Shared infrastructure
│   ├── binding/            # GetX dependency injection
│   ├── global/             # Reusable widgets
│   ├── route/              # Navigation & routing
│   ├── service/            # API & HTTP client
│   ├── stroge/             # Local storage (SharedPreferences)
│   ├── theme/              # App theming
│   └── utils/              # Colors, images, strings
│
└── features/               # Feature modules
    ├── auth_flow/          # Authentication
    ├── home_flow/          # Home & dashboard
    ├── clubs/              # Club browsing
    ├── event_flow/         # Events management
    ├── offer_flow/         # Offers & discounts
    ├── profile_flow/       # User profile & settings
    ├── favorite/           # Favorites
    ├── common_bottom_nav_bar/  # Navigation
    └── splash_view/        # Splash screen
```

### Design Pattern: MVVM + GetX

Each feature module contains:
- **controller/** - Business logic (GetX Controllers)
- **presentation/** - UI screens and widgets

---

## ✨ Features

### 1. **Authentication Flow**
- Mobile number-based login
- OTP verification
- Password reset functionality
- Member registration form
- Direct navigation to home after sign-in

### 2. **Home Dashboard**
- Latest stories and news
- Partner offers showcase
- Sponsor listings
- Quick access to main features

### 3. **Membership Management**
- Digital membership card display
- Multiple membership tiers:
  - **ALPHA** - Individual membership
  - **ALPHA FAMILY** - Family membership (up to 3 members)
- Membership comparison tool
- Membership benefits overview
- Family member management

### 4. **Events**
- Browse upcoming events
- Event details and descriptions
- Event registration
- Sponsor information for events

### 5. **Offers & Discounts**
- Browse exclusive offers
- Filter offers by category and distance
- Offer details and terms
- Partner information

### 6. **Clubs**
- Discover clubs and facilities
- Club details and descriptions
- Club sponsor information
- Membership options per club

### 7. **User Profile**
- Personal information management
- Digital membership card
- Membership details
- Family member information
- Settings and preferences
- Change password
- Contact information
- FAQ section
- About us
- Privacy policy
- Terms & conditions
- Logout functionality

### 8. **Favorites**
- Save favorite clubs, events, and offers
- Quick access to bookmarked items

---

## 🛠️ Tech Stack

### Core Framework
- **Flutter** - UI framework
- **Dart** - Programming language

### State Management & Navigation
- **GetX** (^4.7.3) - State management, routing, dependency injection

### UI & Responsive Design
- **flutter_screenutil** (^5.9.3) - Responsive design
- **google_fonts** (^6.3.3) - Typography
- **flutter_launcher_icons** (^0.14.4) - App icons

### API & Networking
- **Dio** (^5.9.0) - HTTP client with interceptors
- **intl** (^0.20.2) - Internationalization

### Local Storage
- **shared_preferences** (^2.5.4) - Local data persistence

### UI Components
- **flutter_pinput** (^1.0.3) - PIN input widget
- **convex_bottom_bar** (^3.2.0) - Bottom navigation
- **stylish_bottom_bar** (^1.1.1) - Styled bottom bar
- **flutter_widget_from_html** (^0.17.1) - HTML rendering

### Other
- **cupertino_icons** (^1.0.8) - iOS-style icons

---

## 📁 Project Structure

### Core Module

#### `lib/core/global/`
Reusable UI components:
- `common_button.dart` - Standard button widget
- `common_text_field.dart` - Input field widget
- `common_app_bar.dart` - App bar widget
- `custom_search_bar.dart` - Search functionality
- `message_field.dart` - Message input
- `commont_text.dart` - Text widget

#### `lib/core/service/api/`
API integration:
- `api_service.dart` - Dio HTTP client with interceptors
- `api_enpoint.dart` - API endpoints and base URL
- `api_response.dart` - Response model and handling

**Base URL:** `http://10.10.7.11:7000/api/v1`

#### `lib/core/stroge/`
Local storage management:
- `storage_service.dart` - SharedPreferences wrapper
- `stroge_key.dart` - Storage key constants

**Stored Data:**
- Token (Bearer authentication)
- User ID
- User profile data (name, email, image)
- Login status

#### `lib/core/utils/`
Application constants:
- `app_color/` - Color palette
- `app_image/` - Asset paths
- `app_string/` - UI strings and labels

#### `lib/core/route/`
Navigation configuration:
- `app_route.dart` - GetX route definitions

#### `lib/core/theme/`
- `app_theme.dart` - Material theme configuration

### Features Module

#### Authentication Flow (`lib/features/auth_flow/`)
**Screens:**
- `login_screen.dart` - Mobile & password login
- `sing_in_otp.dart` - OTP verification
- `sing_in_verify.dart` - Verification screen
- `new_password_screen.dart` - Password reset
- `member_form_screen.dart` - Member registration

**Controllers:**
- `new_passWord_controller.dart` - Password reset logic

#### Home Flow (`lib/features/home_flow/`)
**Screens:**
- `home_screen.dart` - Main dashboard
- `our_sponsor_screen.dart` - Sponsor listings

**Widgets:**
- `home_tab_bar.dart` - Tab navigation
- `latast_stories_list_screen.dart` - Stories feed
- `latest_stories_details_screen.dart` - Story details
- `partner_offers_list.dart` - Partner offers
- `sponsor_widget_screen.dart` - Sponsor display

**Controllers:**
- `home_controller.dart` - Home logic

#### Clubs (`lib/features/clubs/`)
**Screens:**
- `club_screen.dart` - Club listing
- `club_details_screen.dart` - Club details
- `club_sponsor_screen.dart` - Club sponsors

**Widgets:**
- `discover_club.dart` - Club discovery

#### Events (`lib/features/event_flow/`)
**Screens:**
- `event_screen.dart` - Event listing
- `event_details_screen.dart` - Event details
- `event_register_screen.dart` - Event registration
- `event_our_sponsor_screen.dart` - Event sponsors

**Widgets:**
- `upcomingEvent.dart` - Upcoming events display

#### Offers (`lib/features/offer_flow/`)
**Screens:**
- `offer_screen.dart` - Offer listing
- `offer_details_screen.dart` - Offer details

**Widgets:**
- `offer_gridView_builder.dart` - Offer grid
- `filter_bottomSheet.dart` - Filtering options

**Controllers:**
- `offer_controller.dart` - Offer logic

#### Profile Flow (`lib/features/profile_flow/`)
**Profile Screens:**
- `profile_screen.dart` - Main profile
- `edite_profile_screen.dart` - Edit profile
- `personal_information.dart` - Personal details
- `change_password_screen.dart` - Password change
- `contact_info_screen.dart` - Contact details
- `about_us_screen.dart` - About information
- `privacy_policy_screen.dart` - Privacy policy
- `terms_and_condition_screen.dart` - Terms
- `faq_screen.dart` - FAQ

**Membership Screens:**
- `member_ship_screen.dart` - Membership overview
- `alpha_screen.dart` - ALPHA membership
- `alfha_family_screen.dart` - ALPHA FAMILY membership

**Information Screens:**
- `information_screen.dart` - Information listing
- `information_details_screen.dart` - Information details

**Widgets:**
- `digital_memberShip_container.dart` - Digital card
- `member_ship_info_container.dart` - Membership info
- `profile_data_container.dart` - Profile data display
- `logout_dialog.dart` - Logout confirmation
- `custom_list_view.dart` - Custom list
- `custom_check_list.dart` - Checklist widget
- `what_offer_widget.dart` - Offers display
- `activite_family_member.dart` - Family member activity
- `contact_us_container.dart` - Contact container
- `membershipInfoCard.dart` - Membership card
- `custom_brand_card.dart` - Brand card

#### Favorites (`lib/features/favorite/`)
**Screens:**
- `favorite_screen.dart` - Favorites listing

**Widgets:**
- `favorite_gridView_builder.dart` - Favorites grid

#### Common Bottom Navigation (`lib/features/common_bottom_nav_bar/`)
**Screens:**
- `common_bottom_nab_var.dart` - Bottom navigation bar

**Controllers:**
- `nab_controller.dart` - Navigation logic

#### Splash View (`lib/features/splash_view/`)
**Screens:**
- `splash_screen.dart` - App splash screen

**Controllers:**
- `splash_controller.dart` - Splash logic

---

## 🚀 Setup & Installation

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.10.0 or higher)
- Android Studio / Xcode (for mobile development)
- FVM (Flutter Version Manager) - optional but recommended

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/mahmud-15/Alpha-Club.git
   cd Alpha-Club
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate launcher icons** (if needed)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 🔌 API Configuration

### Base URL
```
http://10.10.7.11:7000/api/v1
```

### API Endpoints
- `/stories` - Stories/news feed
- `/sponsor` - Sponsor information

### Authentication
- **Type:** Bearer Token
- **Header:** `Authorization: Bearer {token}`
- **Storage:** Token stored in SharedPreferences

### API Service Features
- Automatic token injection in headers
- Request/response logging
- Error handling with custom messages
- Timeout management (30 seconds)
- Multipart form data support
- Interceptor-based request/response processing

### Response Model
```dart
ApiResponseModel {
  statusCode: int,
  data: Map,
  message: String,
  isSuccess: bool
}
```

---

## 🔑 Key Components

### GetX Controllers
Controllers manage business logic and state:
- `HomeController` - Home screen logic
- `OfferController` - Offer filtering and display
- `NabController` - Bottom navigation state
- `NewPasswordController` - Password reset logic

### Local Storage Keys
```dart
token              // Bearer token
refreshToken       // Refresh token
isLogIn            // Login status
userId             // User ID
myImage            // User profile image
myName             // User name
myEmail            // User email
myRoll             // User role
```

### Color Palette
- **Primary:** Blue (#233A66)
- **Accent:** Gold (#DFBB0B, #DFB97A)
- **Background:** White (#FFFFFF)
- **Text:** Dark Blue (#233A66)
- **Borders:** Light Gray (#F1F1F1)

### Typography
- **Font Family:** SF Pro (custom)
- **Fallback:** System default
- **Weights:** Regular, Medium, Semibold, Bold

---

## 📝 Development Guidelines

### Code Style
- Follow Dart style guide
- Use meaningful variable names
- Add comments for complex logic
- Keep methods focused and small

### File Naming
- Screens: `*_screen.dart`
- Widgets: `*_widget.dart`
- Controllers: `*_controller.dart`
- Models: `*_model.dart`

### Navigation
Use GetX named routes:
```dart
Get.toNamed(AppRoute.homeScreen);
Get.offNamed(AppRoute.loginScreen);
Get.offAllNamed(AppRoute.splashScreen);
```

### State Management
Use GetX controllers:
```dart
class MyController extends GetxController {
  var count = 0.obs;
  
  void increment() {
    count++;
  }
}
```

### API Calls
Use ApiService:
```dart
final response = await ApiService.get('/endpoint');
response.handleResponse(
  onSuccess: (data) {
    // Handle success
  }
);
```

### Local Storage
Use LocalStorage:
```dart
await LocalStorage.setString('key', 'value');
String value = LocalStorage.token;
```

---

## 🐛 Troubleshooting

### Common Issues

**1. API Connection Error**
- Verify base URL in `api_enpoint.dart`
- Check if backend server is running
- Ensure device has internet connection

**2. Layout Overflow**
- Use `SingleChildScrollView` for scrollable content
- Check `flutter_screenutil` configuration
- Verify responsive design values

**3. Token Expiration**
- Implement token refresh logic
- Handle 401 responses in API interceptor
- Clear storage and redirect to login

**4. Build Issues**
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

---

## 📞 Support & Contact

For issues, questions, or contributions:
- **Repository:** https://github.com/mahmud-15/Alpha-Club
- **Issues:** GitHub Issues
- **Email:** Contact team

---

## 📄 License

This project is private and not licensed for public use.

---

## 👥 Team

- **Project Lead:** Mahmud
- **Contributors:** Atik, Jamal

---

## 🔄 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-01-06 | Initial release with core features |

---

**Last Updated:** January 6, 2025
