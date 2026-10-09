/// Page information returned with a list.
class Pagination {
  const Pagination({this.totalElement, this.totalPages, this.size});

  /// Reads Spring-style page fields: `totalElements`, `totalPages`, `size`.
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalElement: int.tryParse('${json['totalElements']}'),
      totalPages: int.tryParse('${json['totalPages']}'),
      size: int.tryParse('${json['size']}'),
    );
  }

  final int? totalElement;
  final int? totalPages;

  /// The page size the server actually used (it may differ from the request).
  final int? size;
}
