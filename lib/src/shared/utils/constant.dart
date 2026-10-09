import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:intl/intl.dart';

/// The app's colour palette: replace these values with the app's brand.
/// Pages and components use `customColors`, never `Colors.xxx`
/// (_standards/06, RULE-038).
final customColors = MyAppColors(
  primary: Colors.blue,
  secondary: Colors.orange,
  background: Colors.white,
  surface: Colors.grey,
  error: Colors.redAccent,
  success: Colors.green,
  warning: Colors.yellow,
  black1: const Color(0xFF000000),
);

/// `yyyy-MM-dd`, the format most APIs expect for dates in query parameters.
String? formatDateForApi(DateTime? dateTime) {
  return dateTime == null ? null : DateFormat('yyyy-MM-dd').format(dateTime);
}

/// Parses a date from an API value: ISO 8601, `dd/MM/yyyy HH:mm:ss`, or a
/// Unix timestamp in seconds (10 digits) or milliseconds (13 digits).
DateTime? convertJsonDate(Object? value) {
  final str = value?.toString() ?? '';
  if (str.isEmpty || str == 'null') return null;

  final isoDate = DateTime.tryParse(str);
  if (isoDate != null) return isoDate;

  try {
    return DateFormat('dd/MM/yyyy HH:mm:ss').parseStrict(str);
  } on FormatException {
    // Not that format either: try a timestamp.
  }

  final timestamp = int.tryParse(str);
  if (timestamp != null) {
    if (str.length == 10) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }
    if (str.length == 13) return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  return null;
}

double? convertToDouble(Object? value, {bool canBeNull = false}) {
  if (value == null || value == '') return canBeNull ? null : 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? (canBeNull ? null : 0.0);
}

/// `1,234.5 EUR` in the app's language; empty when [price] is null.
String formatPrice(double? price, String currency) {
  if (price == null) return '';
  return '${NumberFormat('#,###.#').format(price)} $currency';
}

/// A date in the app's language (`Intl.defaultLocale`, set by
/// `ApplicationView`): `3 Oct 2026`, with [withDay] `Sat 3 Oct 2026`, with
/// [withTime] `3 Oct 2026 - 14:05`.
String formatDate(
  DateTime? date, {
  bool withTime = false,
  bool withDay = false,
}) {
  if (date == null) return '';
  if (withTime) return DateFormat('d MMM yyyy - HH:mm').format(date);
  if (withDay) return DateFormat('EEE d MMM yyyy').format(date);
  return DateFormat('d MMM yyyy').format(date);
}
