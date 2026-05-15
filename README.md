# 🚚 Transport Wala

> **A Modern Flutter Transportation Platform**

A premium, production-ready Flutter application connecting transporters and vehicle owners for seamless logistics management. Built with cutting-edge technologies including GetX state management, real-time communication, and cloud integration.

---

## 🌟 Features

### 🔐 **Authentication System**
- Secure user registration with role-based selection
- Phone-based OTP verification
- Persistent token management with secure storage
- Automatic session restoration on app launch
- Support for multiple user types (Transporter, Vehicle Owner)

### 👤 **User Management**
- Complete user profile management
- Dynamic profile picture uploads
- GetStorage-based persistence for offline access
- Reactive user data with GetX observables
- Automatic data synchronization across app

### 🎨 **Beautiful UI/UX**
- Responsive design with Flutter ScreenUtil
- Custom brand-themed components
- Smooth animations with Lottie
- Material Design 3 compliance
- Consistent typography and color scheme

### 📱 **Core Features**
- **Onboarding Flow** - Smooth app introduction
- **Home Dashboard** - Real-time information display
- **Smart Navigation** - GetX-powered routing
- **Dynamic Drawer** - User-specific navigation
- **Custom Loaders** - Premium animated loading states

### 🌐 **Connectivity**
- Real-time connectivity monitoring
- Graceful offline handling
- Automatic retry mechanisms
- Network-aware UI updates

### 🎯 **Developer Experience**
- Clean MVC architecture
- Reusable widget library
- Type-safe API integration
- Comprehensive error handling
- Production-ready code standards

---

## 📊 Tech Stack

### **Framework & State Management**
| Technology | Version | Purpose |
|---|---|---|
| Flutter | 3.24.0+ | Cross-platform UI framework |
| Dart | 3.10.0+ | Programming language |
| GetX | ^4.6.6 | State management & routing |
| GetStorage | ^2.1.1 | Local persistence |

### **API & Networking**
| Technology | Version | Purpose |
|---|---|---|
| Dio | ^5.7.0 | HTTP client |
| Firebase Core | ^4.5.0 | Backend services |

### **UI/UX Libraries**
| Technology | Version | Purpose |
|---|---|---|
| Flutter ScreenUtil | ^5.9.3 | Responsive design |
| Lottie | ^3.3.2 | Animations |
| Cached Network Image | ^3.4.1 | Image caching |
| Flutter SVG | ^2.2.3 | SVG rendering |
| Pinput | ^6.0.2 | OTP input |

### **Device & Platform**
| Technology | Version | Purpose |
|---|---|---|
| Connectivity Plus | ^6.0.3 | Network monitoring |
| Device Info Plus | ^12.2.0 | Device information |
| Package Info Plus | ^9.0.0 | App version info |
| Permission Handler | ^12.0.1 | Runtime permissions |
| Image Picker | ^1.2.1 | Image selection |
| Image Cropper | ^11.0.0 | Image editing |

---

## 📁 Project Structure

```
transport_wala/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── bindings/                          # GetX bindings
│   │   └── initial_binding.dart          # Initial controller binding
│   ├── controllers/                       # Business logic layer
│   │   ├── auth/
│   │   │   ├── login_controller.dart
│   │   │   ├── register_controller.dart
│   │   │   └── otp_controller.dart
│   │   ├── home/
│   │   │   └── home_controller.dart
│   │   └── onboarding/
│   │       └── onboarding_controller.dart
│   ├── screens/                           # UI layer
│   │   ├── splash/
│   │   │   └── splash.dart
│   │   ├── onboarding/
│   │   │   └── onboarding.dart
│   │   ├── auth/
│   │   │   ├── login.dart
│   │   │   ├── register.dart
│   │   │   └── otp.dart
│   │   └── home/
│   │       └── home.dart
│   ├── widgets/                           # Reusable components
│   │   ├── custom_appbar.dart
│   │   ├── auth_text_field.dart
│   │   ├── home_drawer.dart
│   │   └── custom_loader.dart
│   ├── model/                             # Data models
│   │   ├── user_model.dart
│   │   ├── login_model.dart
│   │   └── profile_model.dart
│   ├── network_call/                      # API layer
│   │   ├── dio_helper/
│   │   │   └── dio_helper.dart
│   │   └── apis/
│   │       └── apis_endpoint.dart
│   ├── prefs/                             # GetStorage wrapper
│   │   └── prefs.dart
│   ├── resources/                         # Assets & styling
│   │   ├── res.dart                       # Assets constants
│   │   ├── mColours.dart                  # Color palette
│   │   └── text_styes/
│   │       └── custome_text.dart
│   ├── routes/                            # Navigation routes
│   │   └── app_routes.dart
│   ├── helpers/                           # Utility helpers
│   │   ├── custome_loader.dart
│   │   └── response_handler.dart
│   ├── service/                           # Business services
│   │   └── api_service.dart
│   └── utility/                           # Common utilities
│       ├── const.dart
│       └── utility.dart
├── assets/
│   ├── icons/                             # SVG & PNG icons
│   ├── images/                            # UI images
│   ├── logos/                             # Brand logos
│   ├── fonts/                             # Custom fonts
│   └── animetion_file/                    # Lottie animations
├── android/                               # Android native code
├── ios/                                   # iOS native code
├── web/                                   # Web platform
├── pubspec.yaml                           # Dependencies
├── analysis_options.yaml                  # Linter rules
└── README.md                              # This file
```

---

## 🚀 Getting Started

### **Prerequisites**

Before you begin, ensure you have the following installed:

- **Flutter SDK**: v3.24.0 or higher ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Dart SDK**: v3.10.0 or higher (comes with Flutter)
- **Android Studio** or **Xcode** (for mobile development)
- **Git**: For version control
- **VS Code** or **Android Studio**: For code editing

### **Installation Steps**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/transport_wala.git
   cd transport_wala
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **iOS-only Setup** (for macOS users)
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the Application**
   ```bash
   # Run on connected device
   flutter run
   
   # Run on specific device
   flutter run -d <device_id>
   
   # Run in release mode
   flutter run --release
   ```

5. **Build APK** (Android)
   ```bash
   flutter build apk
   # or signed APK
   flutter build apk --split-per-abi
   ```

6. **Build for iOS**
   ```bash
   flutter build ios
   ```

---

## 📱 Project Configuration

### **API Configuration**

Create or update API endpoints in `lib/network_call/apis/apis_endpoint.dart`:

```dart
class ApiEndpoints {
  static const String baseUrl = "https://api.transport-wala.com";
  static const String register = "$baseUrl/api/auth/register";
  static const String verifyOtp = "$baseUrl/api/auth/verify-otp";
  static const String login = "$baseUrl/api/auth/login";
  static const String getUserProfile = "$baseUrl/api/user/profile";
}
```

### **Firebase Configuration**

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Add Android and iOS apps
3. Download configuration files:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

### **Application ID Setup**

Update in `android/app/build.gradle.kts`:

```kotlin
defaultConfig {
    applicationId = "com.transportwala.app"  // Your unique package ID
    minSdk = 21
    targetSdk = 34
}
```

---

## 🔄 Authentication Flow

### **Registration Process**
```
Register Screen → Enter Name, Phone, Role → OTP Verification 
→ Save User Data → Navigate to Login Screen
```

### **Login Process**
```
Login Screen → Submit Phone → OTP Verification 
→ Save Token & User Data → Navigate to Home
```

### **Session Management**
```
App Launch → Check Token in Storage → Restore Session 
→ Auto-login or Show Login Screen
```

---

## 💾 Data Persistence with GetStorage

### **User Data Management**

```dart
// Save user after successful login/registration
final userModel = UserModel(
  userId: response.payload.user.userId,
  name: response.payload.user.name,
  phone: response.payload.user.phone,
  userType: response.payload.user.userType,
  profilePic: response.payload.user.profilePic,
);

Prefs.setUserData(userModel);
```

### **Retrieve User Data**

```dart
// Get user in UI
final user = Prefs.userRx.value;
final userName = Prefs.userRx.value?.name ?? "User";

// Use in Widgets
Obx(() => Text(Prefs.userRx.value?.name ?? "User"))
```

### **Clear User Data (Logout)**

```dart
Prefs.clearUserData();
Prefs.clearToken();
Get.offAllNamed(AppRoutes.loginPage);
```

---

## 🎯 State Management with GetX

### **Using GetX Observables**

```dart
// In Controller
class MyController extends GetxController {
  final count = 0.obs;
  final user = Rx<UserModel?>(null);
  
  void increment() => count.value++;
  void setUser(UserModel u) => user.value = u;
}

// In UI
class MyView extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('${controller.count.value}'));
  }
}
```

### **Using GetX Controller Lifecycle**

```dart
class MyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Initialize data
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}
```

### **Navigation with GetX**

```dart
// Named navigation
Get.toNamed(AppRoutes.registerPage);

// Navigate and replace
Get.offNamed(AppRoutes.homePage);

// Navigate with parameters
Get.toNamed(AppRoutes.detailPage, arguments: {'id': 123});

// Pop with result
Get.back(result: 'Success');
```

---

## 🎨 UI Components & Widgets

### **Custom AppBar**

```dart
Scaffold(
  appBar: CustomAppBar(
    title: "Home",
    showBack: true,
    showNotification: true,
    onBack: () => Get.back(),
  ),
  body: // content
)
```

### **Custom Loader**

```dart
// Show loader
Loader.show();

// Hide loader
Loader.hide();

// Show loader inside bottom sheet
Loader.show(insideBottomSheet: true);
```

### **Auth TextField**

```dart
AuthTextField(
  controller: nameController,
  hint: "Enter your name",
  keyboardType: TextInputType.name,
)
```

---

## 📡 API Integration

### **Making API Calls**

```dart
class ApiService {
  // Register API
  static Future<ApiResponse> register(String name, String phone, String role) async {
    final response = await DioHelper.post(
      ApiEndpoints.register,
      data: {
        "name": name,
        "phone": phone,
        "user_type": role,
      },
    );
    return ApiResponse.fromJson(response);
  }

  // Login API
  static Future<ApiResponse<LoginModel>> login(String phone) async {
    final response = await DioHelper.post(
      ApiEndpoints.login,
      data: {"phone": phone},
    );
    return ApiResponse<LoginModel>.fromJson(response);
  }
}
```

### **Error Handling**

```dart
try {
  final response = await ApiService.login(phone);
  if (response.isSuccess) {
    // Handle success
  } else {
    Get.snackbar("Error", response.message ?? "Something went wrong");
  }
} catch (e) {
  Get.snackbar("Error", "Network error occurred");
}
```

---

## 🔒 Security Best Practices

1. **Token Security**
   - Tokens are stored securely in GetStorage
   - Always validate tokens before API calls
   - Clear tokens on logout

2. **API Security**
   - Use HTTPS only for all API calls
   - Include authorization headers in requests
   - Validate SSL certificates

3. **User Data**
   - Never log sensitive user information
   - Encrypt sensitive data before storage
   - Clear cache on logout

4. **Code Security**
   - Keep dependencies updated
   - Review security warnings from `flutter analyze`
   - Use proper null safety throughout

---

## 🧪 Testing

### **Run Tests**

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### **Build & Release Checklist**

- [ ] All tests passing
- [ ] No lint warnings (`flutter analyze`)
- [ ] Update version in `pubspec.yaml`
- [ ] Update CHANGELOG
- [ ] Test on real devices
- [ ] Test on multiple screen sizes
- [ ] Verify offline functionality
- [ ] Check localization (if applicable)

---

## 📦 Building for Production

### **Android Release**

```bash
# Create signed APK
flutter build apk --release

# Create App Bundle for Play Store
flutter build appbundle --release
```

### **iOS Release**

```bash
# Create ipa file
flutter build ios --release

# Create for App Store
flutter build ipa --release
```

### **Versioning**

Update version in `pubspec.yaml`:
```yaml
version: 1.2.0+5  # versionName+versionCode
```

---

## 🐛 Troubleshooting

### **Common Issues**

| Issue | Solution |
|-------|----------|
| `gradle build failed` | Run `flutter clean` and `flutter pub get` |
| `Pod install issues` | Delete `ios/Pods` and run `pod install` again |
| `API connection timeout` | Check network connectivity and API endpoint |
| `GetX controller not found` | Ensure controller is bound in `InitialBinding` |
| `GetStorage data not persisting` | Check file permissions and storage quota |

### **Debug Mode**

```bash
# Enable verbose logging
flutter run -v

# Enable debug info in DioHelper
DioHelper.enableDebugLogging = true;
```

---

## 📚 Code Conventions

### **Naming Conventions**

```dart
// Classes: PascalCase
class UserModel {}

// Methods & Variables: camelCase
void getUserData() {}
final userName = 'John';

// Constants: camelCase
const apiTimeout = Duration(seconds: 30);

// Private members: _camelCase
var _privateVariable;
```

### **File Organization**

- Keep files under 400 lines
- Group related functionality together
- Use meaningful comments for complex logic
- Follow DRY principle (Don't Repeat Yourself)

### **Code Quality**

```bash
# Format code
dart format lib/

# Analyze code
flutter analyze

# Generate documentation
dartdoc
```

---

## 🔄 State Management Best Practices

### **Controller Organization**

```dart
class HomeController extends GetxController {
  // 1. Variables & Observables
  final users = <UserModel>[].obs;
  final isLoading = false.obs;

  // 2. Lifecycle
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // 3. API Calls
  void fetchUsers() async {
    isLoading.value = true;
    try {
      users.value = await ApiService.getUsers();
    } finally {
      isLoading.value = false;
    }
  }

  // 4. Helper Methods
  void refreshUsers() => fetchUsers();

  @override
  void onClose() {
    super.onClose();
  }
}
```

---

## 📖 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Documentation](https://github.com/jonataslaw/getx)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design](https://material.io/design)

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### **Code Review Process**

- All PRs require at least 1 approval
- Must pass all automated tests
- No breaking changes without discussion
- Update documentation as needed

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📧 Support & Contact

- **Email**: support@transport-wala.com
- **Issues**: [GitHub Issues](https://github.com/yourusername/transport_wala/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/transport_wala/discussions)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX community for excellent state management
- All contributors and testers
- Firebase for backend infrastructure

---

## 📊 Project Status

- ✅ Authentication System
- ✅ User Management
- ✅ GetStorage Persistence
- ✅ GetX State Management
- ✅ API Integration
- 🚧 Real-time Communication
- 🚧 Payment Integration
- 🔄 Upcoming: Notification System

---

<div align="center">

**Made with ❤️ by [Prosenjit Swarnkar](https://github.com/PROSENJIT-RONI)**

⭐ If you find this project helpful, please give it a star!

</div>
