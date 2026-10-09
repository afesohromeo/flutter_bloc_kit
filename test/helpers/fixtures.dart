import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// A sample [Item] with sensible defaults; override what the test is about.
Item anItem({int id = 1, String name = 'Item 1', String? description}) =>
    Item(id: id, name: name, description: description);

/// The JSON body of a paginated list response, as the API returns it.
Map<String, dynamic> pageJson(
  List<Map<String, dynamic>> content, {
  int size = 20,
  int totalElements = 0,
  int totalPages = 1,
}) => {
  'success': true,
  'message': '',
  'data': {
    'content': content,
    'totalElements': totalElements,
    'totalPages': totalPages,
    'size': size,
  },
};
