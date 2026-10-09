# Model Patterns

## Location

`lib/src/domain/models/{feature}.dart`

---

## Basic Freezed Model

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{feature}.freezed.dart';

@freezed
sealed class MyFeature with _$MyFeature {
  const factory MyFeature({
    int? id,
    String? name,
    String? code,
    bool? isActive,
    DateTime? createdAt,
  }) = _MyFeature;

  factory MyFeature.fromJson(Map<String, dynamic> json) {
    return MyFeature(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      name: json['name']?.toString(),
      code: json['code']?.toString() ?? '',
      isActive: json['isActive'] as bool?,
      createdAt: convertJsonDate(json['createdAt']),
    );
  }

  // Static payload builders — never instance methods
  static Map<String, dynamic> toJson(MyFeature item) {
    return {
      'id': item.id,
      'name': item.name,
      'code': item.code,
    };
  }

  static Map<String, dynamic> createPayload(MyFeature item) {
    return {
      'name': item.name,
      'code': item.code,
      'isActive': item.isActive ?? true,
    }..removeWhere((key, value) => value == null);
  }

  static Map<String, dynamic> updatePayload(MyFeature item) {
    return {
      'id': item.id,
      'name': item.name,
      'code': item.code,
      'isActive': item.isActive,
    }..removeWhere((key, value) => value == null);
  }
}
```

---

## Model with Methods or Computed Getters

When a model needs getters or instance methods, add the private constructor:

```dart
@freezed
sealed class Employe with _$Employe {
  const Employe._();   // REQUIRED — enables methods on Freezed class

  const factory Employe({
    int? id,
    String? firstName,
    String? lastName,
  }) = _Employe;

  // Now instance getters/methods are allowed:
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
  bool get isComplete => firstName != null && lastName != null;

  factory Employe.fromJson(Map<String, dynamic> json) { ... }
}
```

**Rule:** If you only need `copyWith` and data holding — no private constructor.
If you need any getter or method — always add `const Model._()`.

---

## fromJson Rules

```dart
factory MyFeature.fromJson(Map<String, dynamic> json) {
  return MyFeature(
    // Int from JSON (API may return string or int)
    id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

    // String with fallback
    name: json['name']?.toString() ?? '',

    // Nullable string (no fallback)
    description: json['description']?.toString(),

    // Bool (direct cast)
    isActive: json['isActive'] as bool?,

    // DateTime (use project utility — handles ISO 8601, custom formats, unix)
    createdAt: convertJsonDate(json['createdAt']),

    // Nested model
    department: json['department'] != null
        ? Department.fromJson(json['department'] as Map<String, dynamic>)
        : null,

    // List of nested models
    tags: json['tags'] != null
        ? List<Tag>.from((json['tags'] as List).map((e) => Tag.fromJson(e)))
        : [],

    // Enum from string
    type: MyFeatureType.fromString(json['type']?.toString()),
  );
}
```

---

## Enum Pattern

```dart
enum MyFeatureType {
  typeA,
  typeB,
  typeC;

  // Display label (localized)
  String label(AppLocalizations l10n) {
    switch (this) {
      case MyFeatureType.typeA: return l10n.typeA;
      case MyFeatureType.typeB: return l10n.typeB;
      case MyFeatureType.typeC: return l10n.typeC;
    }
  }

  // Parse from API string
  static MyFeatureType fromString(String? value) {
    if (value == null) return MyFeatureType.typeA;
    switch (value.toUpperCase()) {
      case 'TYPE_A': return MyFeatureType.typeA;
      case 'TYPE_B': return MyFeatureType.typeB;
      default: return MyFeatureType.typeA;
    }
  }

  // Serialize to API string
  String toStringValue() {
    switch (this) {
      case MyFeatureType.typeA: return 'TYPE_A';
      case MyFeatureType.typeB: return 'TYPE_B';
      case MyFeatureType.typeC: return 'TYPE_C';
    }
  }
}
```

---

## Utility Functions (from `constant.dart`)

```dart
// Format DateTime for API query params
String? formatDateForApi(DateTime? dateTime) {
  return dateTime == null
      ? null
      : DateFormat('yyyy-MM-dd', 'fr_FR').format(dateTime);
}

// Parse dates from API (handles ISO 8601, custom formats, Unix timestamps)
DateTime? convertJsonDate(value) {
  if (value == null || value.toString().isEmpty) return null;
  return DateTime.tryParse(value.toString());
  // Falls back to custom parsing if tryParse fails
}
```

---

## Rules

- ALL models MUST use `@freezed` and be declared `sealed class` (Freezed 3+)
- Freezed 4 (Dart 3.13): no `final` keyword inside factory constructor parameters
- Models are imported through the app barrel: add each new model to `domain/models/models.dart`
- `fromJson` is a factory constructor on the class
- `toJson` and `createPayload` are **static methods** — never instance methods
- Payload builders use `..removeWhere((key, value) => value == null)` to strip nulls
- Use `convertJsonDate()` for all DateTime fields — never `DateTime.parse()` directly
- Use `int.tryParse(x.toString())` for int fields — API may return strings
- Enums MUST implement `fromString()` and `toStringValue()` for API serialization
- Enums MUST implement `label(l10n)` for display
