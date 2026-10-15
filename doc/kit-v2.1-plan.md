# Kit update v2.1: Plotwatch advancements

> **Status:** Approved 2026-10-15
> **Branch:** `refresh/v2.1` (pushed only after the developer's review)
> **Source:** Plotwatch (Serverpod 4 hackathon, submitted 2026-10-14). Its `_standards/` and `.claude/` had not changed since 2026-10-04 (already in v2.0.0); the new material comes from its `CLAUDE.md`, milestone docs (M3 to M8) and code.

## A. Agent workflow and tooling
1. `lib/driver.dart`: Flutter driver entry point for agent-driven app checks (`enableTextEntryEmulation`).
2. Process lessons in `CLAUDE.md`: UI must match approved mockups; batch test runs at the end when the developer asks (long runs).
3. `.claude/SKILLS.md`: skill sources (`flutter/skills`, `google-labs-code/stitch-skills`) and the Serverpod/Relic skills from `serverpod create --ide claude`.

## B. Standards
4. `14_serverpod.md`: who runs what, Serverpod MCP tools (read-only vs state-changing), never edit generated code, checklist after changes, MCP registration on Windows, Google sign-in setup and one-account-per-email linking, upload hang on the Android emulator, `config.json` for web keys and server URL.
5. `07_routing.md`: `ReloadOnReturn` with nested routes.
6. `12_internationalization.md`: `labelColon`, ICU plurals, French pass with the screenshot harness.
7. `15_testing.md`: field helpers, one end-to-end test of the core flow, screenshot harness (`tool/screenshots/`).
8. New `16_release_checklist.md`: privacy policy, account deletion, SHA-1/SHA-256, data safety, release builds with `--dart-define`, reviewer demo accounts.

## C. Components (kit colours, with tests ported from Plotwatch)
9. `PasswordVisibilityButton`, `SubmitButton`, `showConfirmDialog`.
10. `ReloadOnReturn`.
11. `FilterChips` / `FilterPill` / `PickerPill` / `FilterChoice`, `SortButton`.
12. `AppBarMenu`.
13. `Breadcrumb`.
14. `ContentLayout` + `SegmentedPanels` / `SegmentedSwitch`, `AuthFormLayout`.
15. `OneLineText` (from `OneLineAmount`), `IgnoreIntrinsicHeight`.
16. Money utilities (`formatMoney`, `formatMoneyInput`, `formatMoneyShort`, `parseMoney`, `currencyDigits`, `currencySymbol`) and `MoneyField`.
17. `ClipboardProvider` (example device provider in `data/device/`).

## Not included (Plotwatch-specific)
Plotwatch theme and design system; verification, stage, ledger and activity widgets and extensions; page skeletons; the web Google Maps loader (documented instead).

## Definition of done
`flutter analyze` clean, all tests green, Android and web builds pass, CHANGELOG and standards updated, the developer reviews before push and tag `v2.1.0`.
