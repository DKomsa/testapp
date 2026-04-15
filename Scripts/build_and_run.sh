#!/usr/bin/env bash
set -euo pipefail

SCHEME="CalmMoment"
PROJECT="CalmMoment.xcodeproj"
SIMULATOR="iPhone 16"
DESTINATION="platform=iOS Simulator,name=${SIMULATOR}"

xcodebuild -project "$PROJECT" -scheme "$SCHEME" -destination "$DESTINATION" build
xcodebuild -project "$PROJECT" -scheme "$SCHEME" -destination "$DESTINATION" test
