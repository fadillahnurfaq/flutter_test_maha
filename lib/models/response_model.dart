class ResponseModel<T> {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final T? data;

  ResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, Function(dynamic) dataFromJson) {
    return ResponseModel(
      page: json["page"] ?? 0,
      perPage: json["per_page"] ?? 0,
      total: json["total"] ?? 0,
      totalPages: json["total_pages"] ?? 0,
      data: json['data'] != null && json['data'].isNotEmpty
          ? dataFromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson(Function(T) dataToJson) => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        'data': data != null ? dataToJson(data as T) : null,
      };
}
