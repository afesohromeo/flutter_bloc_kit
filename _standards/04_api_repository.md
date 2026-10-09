# API Provider & Repository Patterns

> For a **Serverpod** backend, the API provider wraps the generated client instead of Dio: see [14_serverpod.md](14_serverpod.md). Everything about repositories below still applies.

## Infrastructure (already in the kit)

| File | Role |
|------|------|
| `data/api/config/api_provider.dart` | `ApiProvider()` singleton holding the one `Dio` instance. `initialize()` is called once in `AppInitializer.preAppRun()`. |
| `data/api/config/dio_interceptor.dart` | Adds `Authorization: Bearer <token>` (from `SecureStorageHelper.getToken()`) and `Accept-Language`; logs requests/responses **in debug builds only**; calls `onUnauthorized` on 401. |
| `data/api/config/api_error_handler.dart` | `ApiErrorHandler.handle(DioException)` → `HttpException400` / `HttpException401` / `HttpException410` / `NetworkException` (message taken from the response body's `message`, `error` or `detail`). |
| `core/environment.dart` | `Environment.baseUrl`, passed at build time: `--dart-define=BASE_URL=https://api.example.com` |

```dart
// core/app_initializer.dart
Future<void> preAppRun() async {
  ApiProvider().initialize(onUnauthorized: () {
    // e.g. tell the AuthenticationBloc the session ended
  });
}
```

---

## API Provider

**Location:** `lib/src/data/api/{domain}/{feature}_api_provider.dart`

### Canonical Template

```dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:my_app/my_app.dart';

class MyFeatureApiProvider {
  Dio get _dio => ApiProvider().dio;

  // --- Paginated fetch ---
  Future<AppApiResponse> fetchMyFeatures(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    try {
      final response = await _dio.get(
        '/my-features',
        queryParameters: {
          'size': size ?? 20,
          'page': pageKey,
          'keyword': keyword,
          'sort': 'DESC',
        }..removeWhere((key, value) => value == null),
      );
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Create ---
  Future<AppApiResponse> createMyFeature(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/my-features', data: jsonEncode(data));
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Update ---
  Future<AppApiResponse> updateMyFeature(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/my-features/$id', data: jsonEncode(data));
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- Delete ---
  Future<AppApiResponse> deleteMyFeature(int id) async {
    try {
      final response = await _dio.delete('/my-features/$id');
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  // --- File upload variant ---
  Future<AppApiResponse> createMyFeatureWithFile(
    Map<String, dynamic> data, {
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
      });
      final response = await _dio.post('/my-features', data: formData);
      return AppApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
```

### Rules

- Dio instance accessed via lazy getter: `Dio get _dio => ApiProvider().dio;`
- Paths are relative to `Environment.baseUrl` (no host in API providers)
- Query params MUST use `..removeWhere((key, value) => value == null)` for optional fields
- POST/PUT bodies MUST use `jsonEncode(data)`, not a raw Map
- File uploads use `FormData.fromMap({...data, 'field': MultipartFile.fromBytes(...)})`
- ALL methods catch ONLY `DioException` and throw `ApiErrorHandler.handle(e)`
- NEVER add business logic here: data transformation belongs in the repository

---

## AppApiResponse

```dart
class AppApiResponse {
  final bool success;   // true if json['success'] == true OR json['code'] == 200
  final String message;
  final Data? data;     // Paginated container (list endpoints)
  final dynamic data2;  // Raw payload (single-object endpoints)

  Map<String, dynamic>? get data2AsMap;  // data2 when it is a JSON object, else null
}

class Data {                 // Paginated container
  final List<Map<String, dynamic>> content;  // Raw JSON items
  final Pagination pagination;
}

class Pagination {
  final int? totalElement;
  final int? totalPages;
  final int? size;           // page size the server actually used
}

class PaginatedList<T> {     // What repositories return for lists
  final Pagination pagination;
  final List<T> content;
}
```

- Use `apiResponse.data` for list endpoints
- Use `apiResponse.data2AsMap` for create/update endpoints that return a single object (never cast `data2` at the call site)

---

## Repository

**Location:** `lib/src/domain/repository/{feature}_repository.dart`

### Canonical Template

```dart
import 'dart:developer';
import 'package:my_app/my_app.dart';

class MyFeatureRepository {
  MyFeatureRepository({MyFeatureApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? MyFeatureApiProvider();

  final MyFeatureApiProvider _apiProvider;

  // --- Paginated fetch → PaginatedList<T>? ---
  Future<PaginatedList<MyFeature>?> fetchMyFeatures(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    try {
      final res = await _apiProvider.fetchMyFeatures(
        pageKey,
        keyword: keyword,
        size: size,
      );
      if (res.success && res.data != null) {
        return PaginatedList(
          pagination: res.data!.pagination,
          content: res.data!.content.map(MyFeature.fromJson).toList(),
        );
      }
      return null;
    } catch (e) {
      log('Error fetching my features: $e');
      rethrow;
    }
  }

  // --- Create → Model? ---
  Future<MyFeature?> createMyFeature(Map<String, dynamic> data) async {
    try {
      final res = await _apiProvider.createMyFeature(data);
      final json = res.data2AsMap;
      if (res.success && json != null) return MyFeature.fromJson(json);
      throw Exception(LocalizationService.localization.errorCreatingMyFeature);
    } catch (e) {
      log('Error creating my feature: $e');
      rethrow;
    }
  }

  // --- Delete → bool ---
  Future<bool> deleteMyFeature(int id) async {
    try {
      final res = await _apiProvider.deleteMyFeature(id);
      if (res.success) return true;
      throw Exception(LocalizationService.localization.errorDeletingMyFeature);
    } catch (e) {
      log('Error deleting my feature: $e');
      rethrow;
    }
  }
}
```

### Rules

- The API provider is injected through an **optional constructor parameter** defaulting to a new instance: production code calls `MyFeatureRepository()`, tests pass a mock (15).
- Return types:
  - List endpoint → `PaginatedList<Model>?` (null = failure)
  - Create/Update → `Model?` (null = failure; throws when the API reports `success: false`)
  - Delete → `bool` (throws if the API returns `success: false`)
- ALWAYS `log('Error ...: $e')` then `rethrow`: never swallow exceptions
- Error messages from `LocalizationService.localization.*`, **one key per error case** (`errorCreatingMyFeature`, not a generic `operationError`)
- Payload maps are passed in from the BLoC (which gets them from the model's static payload builder)
