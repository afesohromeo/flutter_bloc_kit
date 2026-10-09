import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';

/// Reference model for the kit's `items` feature (_standards/05).
/// Replace it with your own models, or delete the `items` feature.
@freezed
sealed class Item with _$Item {
  const factory Item({
    required int id,
    required String name,
    String? description,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
    );
  }
}
