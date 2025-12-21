# Mealio

Meal.io is an AI-powered application designed for personalized weekly meal planning. It helps users organize their meals, generate shopping lists, and discover new recipes tailored to their preferences.

## Features

*   **AI-Powered Meal Planning**: Personalized meal suggestions based on user preferences.
*   **Authentication**: Secure user authentication system including:
    *   Login
    *   Signup
    *   OTP Verification
*   **Get Started Flow**: distinct onboarding experience for new users.

## Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/)
*   **Language**: [Dart](https://dart.dev/)
*   **Routing**: [go_router](https://pub.dev/packages/go_router)
*   **Assets**: [flutter_svg](https://pub.dev/packages/flutter_svg) for SVG support.
*   **Networking**: [http](https://pub.dev/packages/http)

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
*   An IDE (VS Code, Android Studio, etc.) configured for Flutter development.

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/your-username/mealio.git
    cd mealio
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run the app**
    ```bash
    flutter run
    ```

## Folder Structure

The project follows a feature-based architecture:

```
lib/
├── src/
│   ├── core/           # Core functionality and shared resources
│   └── features/       # Feature-specific code
│       ├── authentication/
│       │   └── presentation/
│       │       ├── screens/    # Login, Signup, OTP screens
│       │       ├── models/
│       │       └── widgets/
│       └── getstarted/
│           └── presentation/
│               ├── screens/    # Get Started screen
│               └── widgets/
└── main.dart           # Entry point of the application
```
