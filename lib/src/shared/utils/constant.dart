import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:intl/intl.dart';

bool isStandalone = false;
GlobalKey<NavigatorState>? rootNavKey;

const String defaultAddress = '';
const String fakeToken =
    'eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMDY5ZjA2ZC1hOGQ4LTRjMGQtOGY2My0xNWNhNmU0Yzg3MGIiLCJzdWIiOiJwYXVsMjEiLCJzY29wZXMiOltdLCJpYXQiOjE3NDQ3OTMyMDAsImV4cCI6NjkyODc5MzIwMCwidGVuYW50SWQiOiJwYXVsMjEiLCJsYW5ndWUiOiJGUiIsInVzZXJOYW1lIjoicGF1bDIxIiwidXNlcklkIjoiMiIsImVtYWlsIjoiamlvemFuZ3RoZW9waGFuZXBhdWwyM0BnbWFpbC5jb20ifQ.03X-XYaL4nn0uCfS_KxhAjlbXE6eexZiw4cyiBNnBeTd_RmApMgHE3QRB4aHcoRkk2kVq4ezOhRQtSn-JuLoSw';
const String fakeTenant = '';
 final  customColors = MyAppColors(
    primary: Colors.blue,
    secondary: Colors.orange,
    background: Colors.white,
    surface: Colors.grey,
    error: Colors.redAccent,
    success: Colors.green,
    warning: Colors.yellow,
    black1: Color(0xFF000000));
String? formatDateForApi(DateTime? dateTime) {
  return dateTime == null
      ? null
      : DateFormat('yyyy-MM-dd', 'fr_FR').format(dateTime);
}

DateTime? convertJsonDate(value) {
  if (value == null || value.toString().isEmpty || value.toString() == 'null') {
    return null;
  }

  final str = value.toString();

  // 1. Try ISO 8601 parsing
  final isoDate = DateTime.tryParse(str);
  if (isoDate != null) return isoDate;

  // 2. Try custom format (dd/MM/yyyy HH:mm:ss)
  try {
    return DateFormat('dd/MM/yyyy HH:mm:ss').parse(str);
  } catch (_) {
    // ignore and continue
  }

  // 3. Try Unix timestamp (seconds or milliseconds)
  try {
    final num ts = num.parse(str);
    if (str.length == 10) {
      // seconds since epoch
      return DateTime.fromMillisecondsSinceEpoch(ts.toInt() * 1000);
    } else if (str.length == 13) {
      // milliseconds since epoch
      return DateTime.fromMillisecondsSinceEpoch(ts.toInt());
    }
  } catch (_) {
    // not a number
  }

  // 4. If all parsing fails
  return null;
}

double? convertToDouble(value, {bool canBeNull = false}) {
  double? doubleValue = value == null || value == ''
      ? canBeNull
          ? null
          : 0.0
      : (value is int)
          ? value.toDouble()
          : value;
  return doubleValue;
}

String formatPrice(double? price, String currency) {
  if (price == null) {
    return 'N/A';
  }
  return '${NumberFormat('#,###.#').format(price)} $currency';
}

String formatDate(DateTime? date,
    {bool withTime = false, bool withDay = false}) {
  if (date == null) return '';
  return withTime
      ? DateFormat('d MMM yyyy - HH:mm', 'fr_FR').format(date)
      : withDay
          ? DateFormat('EEE d MMM yyyy', 'fr_FR').format(date)
          : DateFormat('d MMM yyyy', 'fr_FR').format(date);
}
