class CountriesModel {
  final String message;
  final Pagination pagination;
  final List<Area> data;

  CountriesModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      message: json['message'],
      pagination: Pagination.fromJson(json['pagination']),
      data: List<Area>.from(json['data'].map((x) => Area.fromJson(x))),
    );
  }
}

class Pagination {
  final int currentPage;
  final int resultCount;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.resultCount,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      resultCount: json['resultCount'],
      totalPages: json['totalPages'],
    );
  }
}

class Area {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String name;

  Area({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
    );
  }
}
