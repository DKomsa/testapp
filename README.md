# CalmMoment (iOS SwiftUI MVP)

CalmMoment is an iPhone-first SwiftUI app for moments of overwhelm. The MVP focuses on three fast support states:

1. **Too much around me** (sensory overload)
2. **My brain is overheating** (mental overheating)
3. **I’m stuck** (task paralysis)

The app is intentionally minimal: one main action per screen, short copy, large tap targets, low visual noise, and local/offline-first behavior.

## What was built

- SwiftUI iOS app project (`CalmMoment.xcodeproj`) with one app target + unit and UI tests.
- Short onboarding (3 screens max) with non-alarmist safety note.
- Home screen with 3 state cards + “I’m not sure” triage flow.
- Full state flows for sensory, mental, and stuck paths:
  - recognition
  - protocol selection
  - guided protocol
  - check-in branching
- Saved local relief tools:
  - helpful protocols
  - favorite tiny first steps
  - preferred timer lengths
- Local-only persistence via `UserDefaults` (`ReliefToolsStore`).
- Dark mode and Dynamic Type-friendly SwiftUI components.
- Build/test script using `xcodebuild`.

## Project structure

```text
CalmMoment/
  CalmMomentApp.swift
  App/
    RootView.swift
  Models/
    AppModels.swift
  Content/
    LocalContent.swift
  ViewModels/
    AppViewModel.swift
  Services/
    ReliefToolsStore.swift
    TriageResolver.swift
  Components/
    PrimaryButton.swift
    StateCard.swift
    StepListView.swift
  Views/
    Onboarding/OnboardingView.swift
    Home/HomeView.swift
    Triage/TriageView.swift
    StateFlow/
      RecognitionView.swift
      ProtocolSelectionView.swift
      ProtocolGuideView.swift
      CheckInView.swift
    Saved/SavedToolsView.swift
    Settings/SettingsView.swift
CalmMomentTests/
  TriageResolverTests.swift
  AppViewModelTests.swift
CalmMomentUITests/
  CalmMomentUITests.swift
Scripts/
  build_and_run.sh
```

## Architecture notes

- `AppViewModel` holds routing state and app-level business logic.
- `LocalContent` centralizes editable user-facing protocol copy and state definitions.
- Reusable UI primitives live in `Components/`.
- `TriageResolver` isolates triage routing logic for unit testing.
- `ReliefToolsStore` handles local persistence for saved tools/preferences.

## Run

### Open in Xcode

1. Open `CalmMoment.xcodeproj` in Xcode 16+.
2. Select scheme: **CalmMoment**.
3. Select simulator: **iPhone 16** (or another iPhone simulator).
4. Run.

### CLI build and test

```bash
./Scripts/build_and_run.sh
```

Or directly:

```bash
xcodebuild -project CalmMoment.xcodeproj -scheme CalmMoment -destination "platform=iOS Simulator,name=iPhone 16" build
xcodebuild -project CalmMoment.xcodeproj -scheme CalmMoment -destination "platform=iOS Simulator,name=iPhone 16" test
```

## Tests

### Unit tests

- `TriageResolverTests`
  - sensory-first priority
  - stuck routing when cannot start
  - fallback mental routing
- `AppViewModelTests`
  - unload sorting buckets
  - check-in follow-up actions

### UI test

- `CalmMomentUITests.testHappyPathHomeToCheckIn`
  - onboarding (if present)
  - home → sensory recognition → protocol → check-in screen

## Product safety scope

This MVP explicitly includes a brief note that it is a self-regulation support tool and **not emergency support or medical treatment**.

It intentionally excludes backend/auth/accounts/community/analytics/notifications/crisis escalation in v1.
