# Car Store — Flutter App

A Flutter application for browsing cars, viewing car details, searching and filtering listings, managing favorites, and accessing user profile features.

## Features

- User authentication and registration.
- Email verification and password recovery flows.
- Google Sign-In integration.
- Browse car listings and featured cars.
- Search and filter available cars.
- View car details, images, specifications, features, and seller information.
- Add and manage favorite cars.
- Access profile and logout functionality.

## Tech Stack

- **Flutter & Dart** — Cross-platform application development.
- **flutter_bloc / Cubit** — State management.
- **Dio** — HTTP requests and API communication.
- **GoRouter** — Navigation and routing.
- **GetIt** — Dependency injection.
- **Google Sign-In** — Google authentication integration.
- **flutter_native_splash** — Native splash screen configuration.

## Project Structure

The application is organized by features, with shared components and services inside `core/`.

```text
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── routing/
│   ├── styles/
│   ├── theme/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── cars/
│   ├── favorites/
│   ├── home/
│   └── profile/
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK compatible with the version specified in `pubspec.yaml`.
- Dart SDK included with Flutter.
- An Android or iOS development environment, or another supported Flutter platform.

### Installation

1. Clone the repository:

   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:

   ```bash
   cd car_store
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Configure the required authentication settings, including the Google Sign-In client ID, according to your development environment.

5. Run the application:

   ```bash
   flutter run
   ```

> Replace `<repository-url>` with the actual repository URL. Make sure required configuration values are set before running the application.

## API Integration

The application communicates with the Car Store API:

`https://carstore-api.vercel.app/api`

Authentication and car-related features use API requests to retrieve data and submit user actions. Actual behavior depends on the API responses and backend implementation.

## Validation

Run the following commands from the project root:

```bash
flutter analyze
flutter test
```

These commands check for static analysis issues and run the project's automated tests.

## Development Notes

During development, AI tools were used to assist with parts of implementation. Reviewing the generated code highlighted the importance of clear naming, error handling, and validating behavior beyond successful compilation.

For example, an API endpoint constant should clearly identify itself as a path rather than a token value. Authentication interceptors also need careful handling of concurrent requests when an access token expires.

## Known Issues and API Observations

### Password Reset and Email Verification

During testing, logging in after a successful password reset returned an `Email not verified` response with `requiresVerification: true`. After verifying the email through the website, logging in with the new password worked.

The Flutter application handles the verification-required response. The underlying cause has not been confirmed and requires further investigation of the backend's account-verification state.

### Reset Token Handling

The `POST /auth/verify-reset-otp` endpoint returns a `resetToken`. During Postman testing, the `POST /auth/reset-password` endpoint succeeded when the request included `email` and `newPassword`, without a `resetToken`.

The intended role of the returned token and the backend's password-reset authorization requirements should be clarified. Password-reset operations should rely on an appropriately validated and secure verification mechanism.

### Concurrent Token Refresh

The current authentication interceptor uses an `_isRefreshing` flag to prevent multiple refresh attempts from starting simultaneously. However, the implementation does not yet queue other failed requests while a refresh is in progress. Concurrent requests may therefore receive `401` errors instead of waiting for the refreshed access token and retrying.

This behavior is a potential improvement for a future iteration.

## License

No license has been specified yet.
