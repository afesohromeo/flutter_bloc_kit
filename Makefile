.PHONY: codegen i18n format analyze test check clean-ios build-android build-web build-ios

codegen:
	@echo "Generating code (Freezed, assets)..."
	dart run build_runner build --delete-conflicting-outputs

i18n:
	@echo "Generating localizations (lib/src/core/l10n)..."
	flutter gen-l10n

format:
	dart format lib test

analyze:
	flutter analyze

test:
	flutter test

# Run before every commit: formatting, analyzer, tests.
check: format analyze test

clean-ios:
	@echo "Cleaning iOS build files..."
	flutter clean
	rm -rf ios/Pods ios/Podfile.lock
	flutter pub get
	cd ios && pod install && cd ..

# Release builds. Pass the production values, e.g.
#   make build-android BASE_URL=https://api.example.com
# Android signs with android/key.properties when it exists (see _standards/16).
ENV ?= prod
BASE_URL ?=
DEFINES = --dart-define=env=$(ENV) --dart-define=BASE_URL=$(BASE_URL)

build-android:
	@echo "Building Android (env=$(ENV))..."
	flutter build appbundle --release $(DEFINES)

build-web:
	@echo "Building web (env=$(ENV))..."
	flutter build web --release $(DEFINES)

build-ios:
	@echo "Building iOS (env=$(ENV))..."
	flutter build ipa --release $(DEFINES)
