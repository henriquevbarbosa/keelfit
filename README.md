# Keel — Workout + Macro Tracker

> Log your workout in 30 seconds. Know your macros for the day instantly.

Single codebase iOS + Android app built with [Skip.dev](https://skip.tools) (SwiftUI → Jetpack Compose transpiler).

## Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI (iOS) / Jetpack Compose (Android) via Skip |
| Data | SwiftData (iOS) / Room (Android) via Skip |
| Monetization | RevenueCat |
| Analytics | PostHog (free tier) |

## Quick Start

Requires **macOS + Xcode 15+** + Android Studio.

```bash
# 1. Install Skip
brew install skiptools/skip/skip
skip doctor

# 2. Open in Xcode
open Package.swift

# 3. Build both platforms
make build-ios      # iOS Simulator
make build-android  # Android Emulator
```

## Project Structure

```
Keel/
├── Keel/              ← iOS app target
├── KeelApp/           ← Android app module (Skip auto-generates)
├── Shared/            ← Single source of truth
│   ├── UI/
│   │   ├── Components/   # Reusable SwiftUI components
│   │   ├── Screens/      # One per flow
│   │   └── Theme/        # DESIGN.md tokens as Swift
│   ├── Models/           # SwiftData @Model entities
│   └── Services/         # Business logic
│       ├── WorkoutService/
│       ├── NutritionService/
│       └── HevyImportService/
├── Package.swift
├── skip.yml
├── Makefile
├── .swiftlint.yml
├── DESIGN.md
└── portfolio/
    └── fitness-nutrition-app-case-study.md
```

## Commands

| Command | What it does |
|---|---|
| `make build-ios` | Build for iOS Simulator |
| `make build-android` | Build Android APK (debug) |
| `make test` | Run Swift tests |
| `make lint` | Run SwiftLint |
| `make run-ios` | Run on iOS Simulator |
| `make run-android` | Install + run on Android Emulator |
| `make clean` | Clean build artifacts |

## Build Settings

- `SWIFT_TREAT_WARNINGS_AS_ERRORS = YES` — zero warnings policy
- `ENABLE_PREVIEWS = YES` — SwiftUI live previews
- `SKIP_EMBED_SKIP_BRIDGE = YES` — Android bridge

## Design

See [`DESIGN.md`](DESIGN.md) for the complete design system (tokens, typography, spacing, dark-mode-first).

## Portfolio

This is a **Level 3–4 AI case study**. See [`portfolio/fitness-nutrition-app-case-study.md`](portfolio/fitness-nutrition-app-case-study.md) for the full case study structure.

---

**License:** MIT
