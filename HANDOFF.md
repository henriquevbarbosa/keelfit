# Mac Handoff Checklist — Keel P1.4

## Context
This folder contains the final scaffolded architecture for Keel (Skip.dev project).
All source files are ready; only Mac/Xcode steps remain.

---

# P2.5 Update — RevenueCat Paywall Integration

## New / Modified Files for This Task

### New Files
- `Sources/Keel/Shared/Services/RevenueCatService.swift` — Observable service with RevenueCat SDK abstraction, entitlements, purchase + restore flows, stub for Android/Skip
- `Sources/Keel/UI/Components/PaywallSheet.swift` — RevenueCat-driven sheet with loading/error states, restore button, dismiss toolbar
- `Sources/Keel/UI/Components/PaywallCard.swift` — Reusable pricing card with features list, popular badge, CTA
- `Tests/KeelTests/RevenueCatServiceTests.swift` — 18 unit tests (singleton, initial state, offerings, entitlements, purchase/restore flow, callbacks, error state)
- `Tests/KeelTests/RevenueCatSnapshotTests.swift` — 6 rendering tests (PaywallSheet, PaywallCard popular/standard, Settings free/pro, error state)

### Modified Files
- `Package.swift` — Added `purchases-ios` dependency (RevenueCat 5.0+)
- `Sources/Keel/App/KeelApp.swift` — AppDelegate configures RevenueCat with sandbox key placeholder
- `Sources/Keel/UI/Screens/SettingsView.swift` — Added subscription status card (free vs pro), restore purchases button, entitlement rows
- `Sources/Keel/UI/Screens/HistoryView.swift` — Refactored to import `PaywallSheet` from Components; removed duplicate inline sheet definition
- `Sources/Keel/Shared/Services/HistoryViewModel.swift` — Added `SubscriptionStatus` enum for View binding
- `HANDOFF.md` — updated with P2.5 checklist

## RevenueCatService Features
1. **SDK Guarded** — All RevenueCat types behind `#if !SKIP`; Android gets stub with $7.99/$59.99 offerings
2. **Entitlements** — `history_unlimited`, `analytics`, `export` mapped from RevenueCat `CustomerInfo`
3. **Purchase Flow** — `purchase(product:)` with callback, error propagation, loading state
4. **Restore Flow** — `restorePurchases()` with success/failure callback and alert-friendly messages
5. **Auto-refresh** — `PurchasesDelegate` updates entitlements in real time

## PaywallSheet Features
1. **RevenueCat-driven** — Fetches offerings dynamically; shows loading/error/empty states
2. **Two pricing tiers** — Monthly ($7.99) + Annual ($59.99), sorted with "popular" first
3. **Restore** — Dedicated restore button with disabled state during processing
4. **Dismiss** — X button in navigation toolbar
5. **Dark mode** — Uses Keel tokens throughout

## SettingsView Features
1. **Status Card** — Shows PRO crown + active entitlements, or free plan with upgrade CTA
2. **Restore** — Button row with spinner; alerts success or "no purchases found"
3. **Entitlement Rows** — Check/x icons for each feature based on RevenueCat state

## Skip Transpile Checks
- ✅ `reduce(0.0)` used everywhere
- ✅ `Color(red:green:blue:)` used (no `Color(hex:)`)
- ✅ `#Preview` wrapped in `#if !SKIP`
- ✅ All RevenueCat symbols guarded with `#if !SKIP`
- ✅ No tuple destructuring
- ✅ `UUID()` available in Foundation

---

# P2.4 Update — History Screen + Paywall Gate

## New / Modified Files for This Task

### New Files
- `Sources/Keel/Shared/Services/HistoryViewModel.swift` — Observable ViewModel with 7-day free limit, paywall trigger logic, macro consistency score, subscription status
- `Sources/Keel/UI/Screens/HistoryView.swift` — Full history screen with expandable day cards, paywall gate, dark mode, Keel tokens
- `Tests/KeelTests/HistoryViewModelTests.swift` — 12 unit tests covering free limit, paywall trigger, macro consistency, sorted order, day merging
- `Tests/KeelTests/HistoryViewSnapshotTests.swift` — 6 rendering tests (UIHostingController load tests for HistoryView, RecordCard, PaywallSheet)

### Modified Files
- `HANDOFF.md` — updated with P2.4 checklist

## HistoryView Features
1. **Day List** — Scrollable list of past days, newest first, merged from `WorkoutSession` + `MealEntry`
2. **Macro Consistency Score** — Per-day score based on P/C/G ideal split (30/40/30), shown on expand
3. **Tap to Expand** — Collapsible `RecordCard` with workout details + meal summary
4. **Paywall Gate** — Free tier shows only last 7 days; locked row triggers paywall sheet
5. **Paywall Trigger** — First time user sees >7 days, auto-triggered via `onAppear`; dismissed once
6. **Dark Mode** — `background` #0A0A0A, `surface` #141414, accent #C8FF00 throughout
7. **Previews** — `#Preview` wrapped in `#if !SKIP`

## Skip Transpile Checks
- ✅ `reduce(0.0)` used everywhere (not `reduce(0)`)
- ✅ `Color(red:green:blue:)` used (no `Color(hex:)`)
- ✅ `#Preview` wrapped in `#if !SKIP`
- ✅ `@Model` guarded with `#if !SKIP`
- ✅ No tuple destructuring
- ✅ `UUID()` available in Foundation

---

# P2.3 Update — Macro Tracking Screen (NutritionView)

## New / Modified Files for This Task

### New Files
- `Sources/Keel/Shared/Services/NutritionViewModel.swift` — Observable ViewModel with meal management, macro totals, progress calculation, formula breakdown
- `Tests/KeelTests/NutritionViewModelTests.swift` — 17 unit tests covering calculations, meal CRUD, progress, formula, and integration scenarios
- `Tests/KeelTests/NutritionViewSnapshotTests.swift` — 6 rendering tests (UIHostingController load tests for NutritionView, components, and banners)

### Modified Files
- `Sources/Keel/UI/Screens/NutritionView.swift` — Full macro tracking screen implementation
- `Sources/Keel/Shared/Models/MealEntry.swift` — Added `id` field (UUID) for stable ForEach identity

## NutritionView Features
1. **Contextual Banner** — `NutritionBanner` shows workout-based message using `lastWorkout` from UserDefaults
2. **Progress Bars** — P/C/G with Keel tokens (red protein, teal carbs, yellow fat), daily totals, calorie counter
3. **Meal Input** — `MealInputRow` component reused; name + P/C/G grams, validated, adds to SwiftData-compatible `MealEntry`
4. **Meal List** — Shows all logged meals with macro summary per item, delete button, empty state
5. **Formula Transparency** — Expandable section shows Mifflin-St Jeor → TDEE → macro breakdown with monospaced text
6. **Dark Mode** — All colors use `Color(red:green:blue:)` (Skip-safe), `background` = #0A0A0A, `surface` = #141414
7. **Preview** — Single `#Preview` wrapped in `#if !SKIP`

## Skip Transpile Checks
- ✅ `reduce(0.0)` used everywhere (not `reduce(0)`)
- ✅ `Color(red:green:blue:)` used (no `Color(hex:)`)
- ✅ `#Preview` wrapped in `#if !SKIP`
- ✅ `@Model` guarded with `#if !SKIP`
- ✅ No tuple destructuring
- ✅ `UUID()` available in Foundation

## Next Steps (Mac)
1. Copy all files from this workspace to your keelfit repo
2. Build in Xcode: `SKIP_ZERO=1 xcodebuild -workspace Project.xcworkspace -scheme "Keel App" -destination 'platform=iOS Simulator,name=iPhone 16' build`
3. Run tests: `xcodebuild ... test`
4. Android: `cd Android && ./gradlew :KeelApp:assembleDebug`

## Step 1: Create GitHub repo (Mac)
```bash
gh repo create henriquevbarbosa/keelfit --public --confirm
git clone https://github.com/henriquevbarbosa/keelfit.git ~/Developer/keelfit
cd ~/Developer/keelfit
```

## Step 2: Verify environment
```bash
export PATH="/opt/homebrew/bin:$PATH"
skip doctor                  # must be all green
xcode-select -p             # must show /Applications/Xcode.app/Contents/Developer
```

## Step 3: Initialize Skip project
```bash
skip init --app-id com.henriquevbarbosa.keel --name "Keel" .
```
This creates:
- `Project.xcworkspace`
- `Keel/` (iOS target)
- `Android/KeelApp/` (Android module)
- `Package.swift` (overwrites ours)
- `skip.yml` (overwrites ours)

## Step 4: Copy our scaffold over Skip defaults

After `skip init`, **copy only our source/config files** (replace Skip defaults):

```bash
# In your terminal, from the folder where you extracted the handoff:
cp Package.swift ~/Developer/keelfit/Package.swift
cp skip.yml ~/Developer/keelfit/skip.yml
cp .swiftlint.yml ~/Developer/keelfit/.swiftlint.yml
cp Makefile ~/Developer/keelfit/Makefile
cp README.md ~/Developer/keelfit/README.md
cp DESIGN.md ~/Developer/keelfit/DESIGN.md

# Source tree
mkdir -p ~/Developer/keelfit/Sources/Keel/Shared/Models
mkdir -p ~/Developer/keelfit/Sources/Keel/Shared/Services
mkdir -p ~/Developer/keelfit/Sources/Keel/UI/Components
mkdir -p ~/Developer/keelfit/Sources/Keel/UI/Screens
mkdir -p ~/Developer/keelfit/Sources/Keel/App
mkdir -p ~/Developer/keelfit/Sources/Keel/Resources
cp Sources/Keel/Shared/Models/*.swift ~/Developer/keelfit/Sources/Keel/Shared/Models/
cp Sources/Keel/Shared/Services/*.swift ~/Developer/keelfit/Sources/Keel/Shared/Services/
cp Sources/Keel/UI/Components/*.swift ~/Developer/keelfit/Sources/Keel/UI/Components/
cp Sources/Keel/UI/Screens/*.swift ~/Developer/keelfit/Sources/Keel/UI/Screens/
cp Sources/Keel/App/*.swift ~/Developer/keelfit/Sources/Keel/App/
```

## Step 5: Commit baseline
```bash
cd ~/Developer/keelfit
git add .
git commit -m "scaffold: P1.4 architecture + Skip init"
git push origin main
```

## Step 6: Xcode workspace setup
**Critical:** Open `Project.xcworkspace` (not Package.swift directly).

1. File → Open → `~/Developer/keelfit/Project.xcworkspace`
2. Select scheme: `Keel App` → Destination: iPhone 16
3. Build (⌘+B)

## Step 7: Run verification commands
```bash
cd ~/Developer/keelfit

# iOS Simulator (headless)
SKIP_ZERO=1 xcodebuild -workspace Project.xcworkspace \
    -scheme "Keel App" \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    -skipPackagePluginValidation \
    build

# iOS test
SKIP_ZERO=1 xcodebuild -workspace Project.xcworkspace \
    -scheme "Keel App" \
    -destination 'platform=iOS Simulator,name=iPhone 16' \
    -skipPackagePluginValidation \
    test

# Android build
cd Android
./gradlew :KeelApp:assembleDebug
```

All three must show: **BUILD SUCCEEDED** / **BUILD SUCCESSFUL**.

## Known Skip Transpile Fixes Already Applied
Our source files already incorporate these known Skip workarounds:

1. **Color(hex:)** → `Color(red:green:blue:)` — Skip cannot add constructors to external types
2. **#Preview** → wrapped in `#if !SKIP / #endif` — Skip ignores preview macros
3. **reduce(0) with Double** → `reduce(0.0)` — Kotlin infers Int from literal 0
4. **Tuple destructuring** → replaced with separate declarations in MacroTarget
5. **@Model** → guarded with `#if !SKIP` import of SwiftData
6. **Font.system(...)** instead of custom `.accent` — uses standard APIs
7. **WkoutIntensity** enum moved to Models to avoid duplication

## Warnings-as-Errors
The `Makefile` and `Package.swift` have `SWIFT_TREAT_WARNINGS_AS_ERRORS=YES` enabled.
If you need to lower the bar during first build, edit `Makefile` and remove the env var.

## Next Handoff
After build succeeds, push final state:
```bash
cd ~/Developer/keelfit
git add . && git commit -m "fix: clean Skip build iOS + Android"
git push origin main
```

Then report back with:
- `skip doctor` output
- iOS build: BUILD SUCCEEDED / FAILED
- Android build: BUILD SUCCESSFUL / FAILED
- Any errors encountered