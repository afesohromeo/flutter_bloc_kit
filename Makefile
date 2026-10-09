.PHONY: codegen i18n format analyze test check clean-ios build-android build-ios

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
	fvm flutter clean
	rm -rf ios/Pods ios/Podfile.lock
	fvm flutter pub get
	cd ios && pod install && cd ..

build-android:
	@echo "Building Android..."
	fvm flutter build appbundle --release

build-ios:
	@echo "Building iOS..."
	fvm flutter build ios
