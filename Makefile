# Makefile for Keel (Skip.dev project)

SCHEME_IOS    := Keel App
SCHEME_ANDROID := assembleDebug
WORKSPACE     := Project.xcworkspace
DESTINATION   := platform=iOS Simulator,name=iPhone 17 Pro
DEVELOPER_DIR := /Applications/Xcode.app/Contents/Developer
ANDROID_HOME  := $(HOME)/Library/Android/sdk
JAVA_HOME     := /opt/homebrew/Cellar/openjdk/25.0.2/libexec/openjdk.jdk/Contents/Home

export DEVELOPER_DIR ANDROID_HOME JAVA_HOME

.PHONY: help build-ios build-android test lint run-ios run-android clean setup

help:
	@echo "Keel — Available commands:"
	@echo "  make build-ios      Build for iOS Simulator"
	@echo "  make build-android  Build Android debug APK"
	@echo "  make test           Run Swift tests"
	@echo "  make lint           Run SwiftLint"
	@echo "  make run-ios        Build and run on iOS Simulator"
	@echo "  make run-android    Build and run on Android Emulator"
	@echo "  make clean          Clean all build artifacts"
	@echo "  make setup          Verify tooling environment"

build-ios:
	@echo "Building iOS..."
	SKIP_ZERO=1 xcodebuild -workspace $(WORKSPACE) \
		-scheme "$(SCHEME_IOS)" \
		-destination "$(DESTINATION)" \
		-derivedDataPath build/derived \
		-configuration Debug \
		-skipPackagePluginValidation \
		\
		build

build-android:
	@echo "Building Android..."
	cd Android && ./gradlew $(SCHEME_ANDROID)

test:
	@echo "Running tests..."
	xcodebuild -workspace $(WORKSPACE) \
		-scheme "$(SCHEME_IOS)" \
		-destination "$(DESTINATION)" \
		-derivedDataPath build/derived \
		test

lint:
	@echo "Running SwiftLint..."
	@which swiftlint > /dev/null || (echo "SwiftLint not installed. Run: brew install swiftlint" && exit 1)
	swiftlint lint --strict

run-ios:
	@echo "Running on iOS Simulator..."
	xcodebuild -workspace $(WORKSPACE) \
		-scheme "$(SCHEME_IOS)" \
		-destination "$(DESTINATION)" \
		-derivedDataPath build/derived \
		-configuration Debug \
		\
		build run

run-android:
	@echo "Running on Android Emulator..."
	cd Android && ./gradlew installDebug
	@echo "Installed. Launch from emulator."

clean:
	@echo "Cleaning..."
	rm -rf build/ .build/
	xcodebuild -workspace $(WORKSPACE) -scheme "$(SCHEME_IOS)" clean 2>/dev/null || true
	cd Android && ./gradlew clean 2>/dev/null || true

setup:
	@echo "Verifying environment..."
	@which skip > /dev/null || (echo "skip not installed. Run: brew install skiptools/skip/skip" && exit 1)
	@which swiftlint > /dev/null || echo "swiftlint not installed. Run: brew install swiftlint"
	skip doctor
	@echo "Environment OK."
