import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// The envelope every API answer comes in:
/// `{ "success": true, "message": "...", "data": ... }`.
///
/// - [data]: the page container, for list endpoints
/// - [data2AsMap]: the object, for single-object endpoints
class AppApiResponse {
  const AppApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.data2,
  });

  factory AppApiResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return AppApiResponse(
      success: json.containsKey('success')
          ? json['success'] == true
          : json['code'] == 200,
      message: json['message']?.toString() ?? '',
      data: rawData is Map<String, dynamic> && rawData['content'] is List
          ? Data.fromJson(rawData)
          : null,
      data2: rawData,
    );
  }

  final bool success;
  final String message;
  final Data? data;

  /// The raw `data` payload. Prefer [data2AsMap].
  final Object? data2;

  /// [data2] when it is a JSON object, else `null` (never cast [data2]).
  Map<String, dynamic>? get data2AsMap =>
      data2 is Map<String, dynamic> ? data2 as Map<String, dynamic> : null;
}

/// A page of raw JSON items plus its [Pagination].
class Data {
  const Data({required this.content, required this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      content: List<Map<String, dynamic>>.from(
        (json['content'] as List).whereType<Map<String, dynamic>>(),
      ),
      pagination: Pagination.fromJson(json),
    );
  }

  final List<Map<String, dynamic>> content;
  final Pagination pagination;
}
