# Keel

Cross-platform fitness and nutrition tracker built with Skip.dev.
Single SwiftUI codebase transpiled to Jetpack Compose for Android.

## Architecture

```
Sources/Keel/
  App/
    KeelApp.swift          # App entry point
  Shared/
    Models/                # SwiftData @Model classes
    Services/              # Analytics, persistence, API clients
  UI/
    Components/            # Reusable SwiftUI components
    Screens/               # Screen-level views
Android/                   # Android-specific build files
Tests/                     # Unit and UI tests
```

## Design System

Dark-mode-first with lime accent (#C8FF00).
See DESIGN.md for full color tokens, typography, spacing, and component specs.

## Build

```bash
make setup       # Verify skip doctor
make build-ios   # iOS Simulator
make build-android # Android APK
make test        # Swift tests
make lint        # SwiftLint strict
```

## Requirements

- macOS + Xcode 15+
- Skip (brew install skiptools/skip/skip)
- Android Studio + Emulator (API 28+)
- Apple Developer account for TestFlight

## Repo

https://github.com/henriquevbarbosa/keelfit

## License

MIT
