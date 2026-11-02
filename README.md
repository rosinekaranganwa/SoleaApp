# Sōlea

Your wellness sanctuary a Flutter app for cycle tracking, phase-aware training & nutrition, an AI health assistant, doctor consultations, and a women's-health community.

Sōlea helps you track your menstrual cycle, eat and train for your current phase, talk to a doctor from home, and learn and share with a supportive community.

Features

- Onboarding** — splash, sign up, and log in screens with a soft mesh-gradient look.
- **Home** — daily greeting, week strip, weekly goal progress, mood check-in, and a recommended-for-today timeline.
- **Cycle tracking** — a phase ring (menstrual / follicular / ovulatory / luteal), period prediction, a month calendar, and a symptom & flow logger.
- **Ask Sōlea (AI)** — a chat assistant with cycle-aware answers, a voice input screen, and a doctors chat with booked video consultations.
- **Wellness hub** — Training and Nutrition tabs: coach card, program progress, weekly plan, video library, daily macro goals, meal plan, and a shopping list.
- **Community** — Posts feed with phase filters and likes, plus Blogs & articles from verified experts.

## Screens

| Area | Files |
| --- | --- |
| Onboarding | `splash_screen.dart`, `signup_screen.dart`, `login_screen.dart` |
| Home | `home_screen.dart` |
| Cycle | `cycle_screen.dart` |
| Ask AI | `ask_ai_screen.dart`, `voice_screen.dart`, `doctors_screen.dart` |
| Wellness hub | `wellness_hub_screen.dart`, `weekly_plan_screen.dart`, `shopping_list_screen.dart` |
| Community | `community_screen.dart` |

## Tech stack

- **Flutter** (Dart SDK `^3.11.0`), Material 3
- No third-party UI packages — all visuals (mesh gradients, phase rings, dashed borders, waveforms) are built with Flutter's `CustomPaint` and core widgets
- `cupertino_icons` for iconography

## Getting started

### Prerequisites
- [Flutter](https://docs.flutter.dev/get-started/install) (stable channel)
- A device or emulator (iOS Simulator, Android emulator, or Chrome for web)

### Run

```bash
git clone <your-repo-url>
cd solea_app
flutter pub get
flutter run
```

### Other commands

```bash
flutter analyze      # static analysis (lint)
flutter test         # run tests
flutter build apk    # Android release build
flutter build ios    # iOS release build
```

## Project structure

```
lib/
├── main.dart                   # App entry point, theme, home = SplashScreen
├── splash_screen.dart          # Onboarding splash
├── signup_screen.dart          # Create account
├── login_screen.dart           # Log in
├── home_screen.dart            # Dashboard + bottom navigation
├── cycle_screen.dart           # Cycle tracking + symptom logger
├── ask_ai_screen.dart          # Ask Sōlea AI chat
├── voice_screen.dart           # Voice input ("Listening…")
├── doctors_screen.dart         # Doctor chat + consultation
├── wellness_hub_screen.dart    # Training / Nutrition hub
├── weekly_plan_screen.dart     # Weekly training plan
├── shopping_list_screen.dart   # Meal-plan shopping list
└── community_screen.dart       # Posts + Blogs & articles
```

Navigation flows: **Splash → Sign up / Log in → Home**, with the bottom bar linking Home, Cycle, Wellness hub, Community, and the **Ask** (AI) button.

## Notes

- This is a **UI build** — screens are populated with sample data and interactive state (toggles, chips, checkboxes, likes). Action buttons and API/backend integration are left as empty handlers ready to wire up.
- Icons use the closest Material built-ins; swap in custom assets for a pixel-exact brand look.
- The app ships with a default system font. For the exact geometric typeface, add a custom font under `pubspec.yaml`.

## License

Add a license of your choice (e.g. MIT) before publishing.
