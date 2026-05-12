# Makefile for Keel — Skip.dev project

SCHEME_IOS := Keel App
SCHEME_ANDROID := KeelApp
DESTINATION_IOS := platform=iOS Simulator,name=iPhone 16

.PHONY: help build-ios build-android test lint run-ios run-android clean setup

help:
	@echo "Keel — Available commands:"
	@echo "  make build-ios      Build iOS Simulator"
	@echo "  make build-android  Build Android APK"
	@echo "  make test           Run Swift unit tests"
	@echo "  make lint           Run SwiftLint (strict)"
	@echo "  make run-ios        Build and run on iOS Simulator"
	@echo "  make run-android    Build and run on Android Emulator"
	@echo "  make clean          Clean all build artifacts"
	@echo "  make setup          Verify environment (skip doctor)"

build-ios:
	@echo "Building iOS..."
	SKIP_ZERO=1 SWIFT_TREAT_WARNINGS_AS_ERRORS=YES \
	xcodebuild -workspace Project.xcworkspace \
		-scheme "$(SCHEME_IOS)" \
		-destination '$(DESTINATION_IOS)' \
		-derivedDataPath build/derived \
		-configuration Debug \
		build

build-android:
	@echo "Building Android..."
	cd Android && ./gradlew :$(SCHEME_ANDROID):assembleDebug

test:
	@echo "Running tests..."
	SWIFT_TREAT_WARNINGS_AS_ERRORS=YES swift test 2>/dev/null || \
		SKIP_ZERO=1 SWIFT_TREAT_WARNINGS_AS_ERRORS=YES xcodebuild -workspace Project.xcworkspace \
			-scheme "$(SCHEME_IOS)" \
			-destination '$(DESTINATION_IOS)' \
			-derivedDataPath build/derived \
			test

lint:
	@echo "Running SwiftLint..."
	@which swiftlint > /dev/null || (echo "SwiftLint not installed. Run: brew install swiftlint" && exit 1)
	swiftlint lint --strict

run-ios:
	@echo "Running on iOS Simulator..."
	SKIP_ZERO=1 xcodebuild -workspace Project.xcworkspace \
		-scheme "$(SCHEME_IOS)" \
		-destination '$(DESTINATION_IOS)' \
		-derivedDataPath build/derived \
		-configuration Debug \
		build run

run-android:
	@echo "Installing Android APK..."
	cd Android && ./gradlew :$(SCHEME_ANDROID):installDebug
	@echo "Installed. Launch from emulator."

clean:
	@echo "Cleaning..."
	rm -rf build/ derived/ .build/
	xcodebuild -workspace Project.xcworkspace -scheme "$(SCHEME_IOS)" clean 2>/dev/null || true
	cd Android && ./gradlew clean 2>/dev/null || true

setup:
	@echo "Verifying environment..."
	@which skip > /dev/null || (echo "skip not installed. Run: brew install skiptools/skip/skip" && exit 1)
	@which swiftlint > /dev/null || (echo "swiftlint not installed. Run: brew install swiftlint" && exit 0)
	@skip doctor
	@echo "Environment verified."
