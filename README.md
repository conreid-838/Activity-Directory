# KidsList - Find Children's Activities, Camps & Childcare Nationwide

**KidsList** is a mobile-first web application that helps parents discover camps, classes, childcare, and enrichment programs for their children across major U.S. metropolitan areas.

## 🎯 Overview

KidsList is a comprehensive directory featuring 10,000+ activities across 12 major metro areas including Charlotte, Atlanta, New York, Los Angeles, Chicago, Dallas, Miami, Boston, Denver, Seattle, Washington DC, and Phoenix.

### Key Features

- 🔍 **Comprehensive Search** - Browse and filter activities by category, age, location, timeframe
- 🌈 **Diversity Focus** - Dedicated filters for multicultural and inclusive programs
- 💰 **Budget Transparency** - Clear pricing with free program filtering
- 📍 **National Coverage** - 12 major metro areas with custom location search
- ✅ **Inclusion Highlights** - Transparency around scholarships, accessibility, diversity initiatives
- 📱 **Mobile-First Design** - Optimized for on-the-go parents

## 🚀 Live Demo

**Web Preview:** [View Live App](https://5060-ikdoqd1rin09ej4kkyw2i-0e616f0a.sandbox.novita.ai)

## 📱 Download

- **Google Play Store:** *(Coming Soon)*
- **Direct APK:** [Download Release APK](https://github.com/conreid-838/Activity-Directory/releases)

## 🛠️ Tech Stack

- **Framework:** Flutter 3.35.4
- **Language:** Dart 3.9.2
- **State Management:** Provider
- **Local Storage:** shared_preferences
- **UI Design:** Material Design 3
- **Target Platforms:** Android, Web

## 🎨 Design

- **Style:** Minimalist with youthful aesthetic
- **Colors:**
  - Primary Blue: `#1272E5`
  - Accent Green: `#54C174`
  - Background: `#FFFFFF`
- **Graphics:** Education-themed only (books, apples, school buildings, icons)
- **Typography:** Modern sans-serif with high readability

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── activity.dart           # Activity data model
│   └── location.dart           # Location model
├── providers/
│   └── activities_provider.dart # State management
├── screens/
│   ├── landing_page.dart       # Marketing landing page
│   ├── location_selection_screen.dart
│   ├── home_screen.dart        # Main home with search
│   ├── browse_screen.dart      # Filter & browse activities
│   ├── activity_detail_screen.dart
│   └── submit_activity_screen.dart
├── widgets/
│   └── [shared widgets]
├── data/
│   └── sample_activities.dart  # Sample listings
└── theme/
    └── app_theme.dart          # Design system
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.35.4 or compatible
- Dart SDK 3.9.2 or compatible
- Android SDK (for Android builds)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/conreid-838/Activity-Directory.git
   cd Activity-Directory
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Web (development)
   flutter run -d chrome
   
   # Web (release build)
   flutter build web --release
   
   # Android
   flutter run
   ```

## 🔧 Build Commands

### Web Build
```bash
flutter build web --release
python3 -m http.server 5060 --directory build/web --bind 0.0.0.0
```

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: 6.1.5+1           # State management
  shared_preferences: 2.5.3   # Local storage
  url_launcher: 6.3.1         # External links
  cupertino_icons: ^1.0.8     # iOS-style icons
```

## 🌟 Core Features

### 1. Location Selection
- 12 featured major metro areas
- Custom city search
- Location persistence
- Easy location switching

### 2. Smart Filtering
- **Categories:** After School, Camps, Sports, Arts, Multicultural, Childcare
- **Age Groups:** Toddler, Elementary, Teen
- **Timeframe:** Summer, School Year, Year-Round, Drop-In
- **Diversity:** Dedicated multicultural filter
- **Budget:** Free programs, custom price ranges
- **Location:** By city/neighborhood

### 3. Sorting Options
- Alphabetical A-Z
- Price (Low to High)
- Price (High to Low)
- Most Viewed
- Newest First

### 4. Activity Details
- Full program descriptions
- Contact information (phone, email, website)
- Inclusion highlights
- Map integration
- Click/view tracking

### 5. Provider Portal
- Simple submission form
- Free listing submission
- Connect with thousands of parents

## 🎯 Target Audience

- Working parents juggling schedules
- Families new to an area
- Parents seeking diverse programming
- Budget-conscious families
- Homeschooling families
- Parents of children with special needs

## 📊 Sample Data

The app includes 11 pre-loaded sample activities across 5 major metros:
- **Charlotte, NC:** 7 activities (Discovery Place, YMCA, Charlotte Ballet, etc.)
- **Atlanta, GA:** 1 activity
- **New York, NY:** 1 activity
- **Los Angeles, CA:** 1 activity
- **Chicago, IL:** 1 activity

## 🔐 Security Notes

**⚠️ IMPORTANT:** The following files are excluded from version control for security:
- `android/release-key.jks` (Android signing keystore)
- `android/key.properties` (Keystore credentials)

**Backup these files securely!** They are required for publishing app updates.

## 📈 Roadmap

- [ ] Backend integration (Firebase/Supabase)
- [ ] User accounts and saved favorites
- [ ] Provider dashboards with analytics
- [ ] Email alerts for new activities
- [ ] Push notifications
- [ ] Reviews and ratings system
- [ ] Advanced search (radius, amenities)
- [ ] Expand to 20+ major metros

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📧 Contact

**Project Owner:** Constance Reid  
**Email:** *(Add your contact email)*  
**Website:** *(Add your website URL)*

## 🙏 Acknowledgments

- Built with Flutter and Material Design 3
- Education icons and graphics by Material Icons
- Sample data represents real Charlotte, NC area programs

---

**Made with ❤️ for parents seeking amazing activities for their kids**
