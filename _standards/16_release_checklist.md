# Release Checklist (Google Play, App Store, Web)

What every app built from the kit needs before its first public release. Built from Plotwatch's submission checklist and PlusLocate's Play Store preparation. Copy it into the project's `doc/` and tick the boxes; anything that doesn't apply, cross out with the reason.

> Store rules change. Re-check the current Google Play and App Store policies before each first release.

---

## 1. Legal pages and data
- [ ] **Privacy policy**, in every language of the app (EN/FR):
  - what is collected, why, who processes it (e.g. Firebase, Google Maps), how long it is kept, how to delete it, a contact email;
  - reachable **from inside the app** (Profile/Settings and the welcome page) and at a **public URL** for the store listing.
  - Web apps and Serverpod apps: a static page in `web/privacy.html` (French part at `#fr`), so it works on every environment. Apps without a web build: a page in the repository or on the portfolio site.
- [ ] **Account deletion**, if the app has accounts (required by both stores):
  - in the app (Profile › Delete account), with a confirmation (`showConfirmDialog`);
  - decide what happens to shared data (e.g. blocked while the user owns a shared project, or data attributed to "Deleted user") and test it;
  - a web URL or email for deletion requests from people who no longer have the app.
- [ ] **Google Play data safety form** (and App Store privacy labels). Key rules:
  - *Collected* = sent off the device by the app or an SDK in it; data that stays on the phone is not collected.
  - *Shared* = given to a third party; a service provider processing data on your behalf (e.g. Crashlytics) is not sharing.
  - Declare everything the app's features can send (location, search text, crash logs, device IDs). Under-declaring is what gets apps rejected.
  - The answers must match the privacy policy.

## 2. Signing, keys and links
- [ ] **Release signing key** (upload key) created and stored outside the repository; its passwords in a password manager. `android/key.properties` (gitignored) points at it:
  ```properties
  storePassword=…
  keyPassword=…
  keyAlias=upload
  storeFile=C:/path/outside/the/repo/upload-keystore.jks
  ```
  `android/app/build.gradle` signs release builds with it; **without the file, release builds fall back to the debug key, which Play rejects.**
- [ ] **SHA-1 of the release key** added wherever the debug one is registered: Google sign-in Android client, Firebase, Maps API key restrictions.
- [ ] **App Links / Universal Links:** the release key's **SHA-256** in `assetlinks.json` (served at `https://<domain>/.well-known/assetlinks.json`); iOS `apple-app-site-association`.
- [ ] **API keys restricted** (Android package + SHA-1, iOS bundle ID, web referrers). No secret in the app or the repository (RULE: secrets via `--dart-define` or server config).
- [ ] **OAuth consent screen published** (Google Auth Platform › Audience › Publish app), or reviewers can't sign in with Google.

## 3. Builds
- [ ] `make check` green (format, analyze, all tests), and the **end-to-end test** of the core flow (15).
- [ ] **French pass** done (12): every screen checked in French with the screenshot harness.
- [ ] Release builds with the production configuration:
  ```bash
  make build-android BASE_URL=https://api.example.com   # flutter build appbundle --release --dart-define=env=prod ...
  make build-web BASE_URL=https://api.example.com
  ```
  (Serverpod: `--dart-define=SERVER_URL=...`, see 14.)
- [ ] Version bumped in `pubspec.yaml` (`version: x.y.z+build`).
- [ ] **Crash reporting** plugged into `AppInitializer.recordError` (Crashlytics or Sentry) and checked with a test crash.
- [ ] App icon, splash screen (`flutter_native_splash`), app name in every language.

## 4. Manual acceptance on real targets
- [ ] The acceptance criteria of the MVP / release, by hand, on **Android** (the release build) and on the **web**, with two accounts where roles exist.
- [ ] Offline and bad network: airplane mode during the main flow; the app recovers without duplicates or endless spinners.
- [ ] Sign-in methods (email, Google) on every platform, including Google with the email of an existing password account.
- [ ] Account deletion with a throwaway account.
- [ ] Privacy policy opens from the app and from its public URL.

## 5. Store listing
- [ ] **New personal Play developer accounts:** before production access, a **closed test with at least 12 testers for 14 days** in a row. Start it early: it decides the earliest release date. (Organisation accounts are exempt; check the current Play policy.)
- [ ] Short and full description, in every language; screenshots per device class (the screenshot harness gives a starting point).
- [ ] Privacy policy URL, developer email, target audience (e.g. 13+, consistent with the policy), ads: yes/no, category.
- [ ] **Demo account for reviewers** if the app needs sign-in (email + password in the review notes), with sample data that shows the main features.
- [ ] Content rating questionnaire.

## 6. After release
- [ ] Tag the release in Git (`vX.Y.Z`) and update `CHANGELOG.md`.
- [ ] Watch crash reports for the first days.
- [ ] Add the store links to the README, the CV and the portfolio.
