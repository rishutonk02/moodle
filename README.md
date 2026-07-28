# Moodle Mobile Coursework

Flutter implementation of a mobile-first Moodle-style learning application for the University of Portsmouth coursework.

Student: Rishu Tonk  
UP number: UP2286527

## Project Overview

This app completes the provided incomplete coursework repository without moving the coursework into a separate Flutter project. It presents a Moodle-inspired dashboard, course catalogue, course details, assessments, calendar, notifications, announcements, profile and login flow. The app initializes Firebase before startup, opens the dashboard for returning authenticated users, and otherwise opens the login screen. Demo mode remains available from login for local assessment without Google Sign-In.

## Features

- Material Design 3 Moodle-style interface with consistent colour, spacing and reusable cards.
- Responsive mobile, tablet and desktop layouts using `LayoutBuilder` and constrained content widths.
- Navigation drawer, app bar actions, named routes and button/list navigation.
- Dynamic courses with models, service classes, search and category filtering.
- Course details with dynamic topics, resources, assignments and expandable sections.
- Assignment submission page with online text input, file picker, local persisted submission state and submitted status.
- Calendar page with coursework deadline and date filtering.
- Notifications and announcements pages populated from local data or Firestore when configured.
- Google Sign-In and Firebase Authentication service integration with graceful demo fallback.
- Firestore integration for user profiles and submitted assignments.
- Persistent login: previously authenticated Firebase users return directly to the dashboard.
- Global app bar search across courses, assignments, resources and notifications.
- Widget and unit tests for navigation, filtering, models and search.

## Folder Structure

```text
lib/
  main.dart
  constants.dart
  models/       Data models for courses, assignments, submissions and notices
  routes/       Named route definitions
  services/     Course, auth, Firebase, search, notification and submission logic
  theme/        Material 3 theme configuration
  utils/        Student details and shared utility values
  views/        App screens
  widgets/      Reusable UI components
test/
  widget_test.dart
android/
  app/google-services.json
ios/
  Runner/
web/
  index.html
```

## Technologies Used

- Flutter 3.44.8
- Dart 3.12.2
- Material Design 3
- Firebase Core
- Firebase Authentication
- Cloud Firestore
- Google Sign-In
- File Picker
- Shared Preferences

## Dependencies

Run:

```bash
flutter pub get
```

Main packages are declared in `pubspec.yaml`:

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `google_sign_in`
- `file_picker`
- `shared_preferences`

## Requirements

- Flutter SDK installed and available on PATH.
- VS Code with Flutter and Dart extensions.
- Chrome for web testing.
- Android Studio or Xcode if running on Android or iOS.
- Firebase project configured for Web and Android.

## VS Code Setup

1. Open this repository folder in VS Code.
2. Install the Flutter and Dart extensions when prompted.
3. Open a terminal in the repository root.
4. Run `flutter pub get`.
5. Select a device from the VS Code status bar.
6. Run the app with `flutter run`.

## How To Run

```bash
flutter pub get
flutter run
```

Run on Chrome:

```bash
flutter run -d chrome --no-web-resources-cdn
```

Run on Android:

```bash
flutter devices
flutter run -d <android-device-id>
```

Run on iOS:

```bash
flutter devices
flutter run -d <ios-device-id>
```

## Testing

```bash
flutter test
flutter analyze
```

## Build Commands

Build web:

```bash
flutter build web --no-web-resources-cdn
```

Build Android APK:

```bash
flutter build apk
```

Build iOS:

```bash
flutter build ios
```

## Firebase Setup

Firebase has been configured for this coursework project for Web and Android:

- Project id: `moodle-coursework`
- Android package name: `uk.ac.port.rishutonk.moodle`
- Web app id: `1:781794007547:web:502966230b42142a80135e`
- Android app id: `1:781794007547:android:2ef6e57e062fef3480135e`
- Generated options: `lib/firebase_options.dart`
- Android config file: `android/app/google-services.json`

Use these steps if the Firebase project needs to be recreated or configured on another machine.

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Install Firebase CLI:

```bash
npm install -g firebase-tools
firebase login
```

3. Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

4. Register apps in Firebase:

- Android app using package name `uk.ac.port.rishutonk.moodle`.
- Web app for Chrome builds.
- iOS app using the iOS bundle identifier.

5. Download platform credential files:

- Place `google-services.json` in `android/app/`.
- Place `GoogleService-Info.plist` in `ios/Runner/`.
- Web configuration is generated into `firebase_options.dart` by FlutterFire.

6. Run FlutterFire configuration for Android and Web:

```bash
flutterfire configure \
  --project=moodle-coursework \
  --platforms=android,web \
  --android-package-name=uk.ac.port.rishutonk.moodle \
  --web-app-id=1:781794007547:web:502966230b42142a80135e \
  --android-out=android/app/google-services.json \
  --out=lib/firebase_options.dart
```

7. Confirm Firebase initialization uses the generated options:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

`main.dart` waits for this initialization before calling `runApp`.

8. Enable Firebase Authentication:

- Open Firebase Console.
- Go to Authentication.
- Enable Google provider.
- Add required support email.
- Add authorized domains for web, including localhost for testing.

9. Enable Cloud Firestore:

- Create a Firestore database.
- Start in test mode only for local development.
- Add collections as the app writes data:
  - `users`
  - `submitted_assignments`
  - `notifications`

10. Suggested Firestore security rules for authenticated users:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    match /submitted_assignments/{submissionId} {
      allow read, write: if request.auth != null;
    }

    match /notifications/{notificationId} {
      allow read: if request.auth != null;
      allow write: if false;
    }
  }
}
```

11. Verify Firebase:

```bash
flutter pub get
flutter run -d chrome --no-web-resources-cdn
```

Then open Login, choose Google Sign-In, confirm the profile screen displays the authenticated user's name, email and profile image, submit an assignment and check Firestore.

## Android Setup

The coursework root now contains restored Flutter platform folders:

- `android/`
- `ios/`

The accidental nested `flutter_application_1/` template project is ignored and is not used.

Run on Android:

```bash
flutter pub get
flutter devices
flutter run -d <android-device-id>
```

Build Android APK:

```bash
flutter build apk
```

## Web Setup

Run on Chrome:

```bash
flutter pub get
flutter run -d chrome --no-web-resources-cdn
```

The web app uses `DefaultFirebaseOptions.web` from `lib/firebase_options.dart`.
The `--no-web-resources-cdn` flag is important on networks where `www.gstatic.com` is blocked or slow, because it serves Flutter CanvasKit from the local Flutter SDK instead of the CDN.

## Manual Steps Still Required

- Replace `TODO: add UP number` in `lib/utils/student_details.dart` and this README when the actual UP number is available.
- Add iOS Firebase configuration only if iOS live Firebase login is required for demonstration.

## Verification

Completed local checks:

```bash
flutter analyze
flutter test
flutter build web --no-web-resources-cdn
```
