class QestionsCategoriesModel {
  final String message;
  final Pagination pagination;
  final List<QestionsCategory> data;

  QestionsCategoriesModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory QestionsCategoriesModel.fromJson(Map<String, dynamic> json) {
    return QestionsCategoriesModel(
      message: json['message'] as String,
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List<dynamic>)
          .map((item) => QestionsCategory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'pagination': pagination.toJson(),
      'data': data.map((item) => item.toJson()).toList(),
    };
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
      currentPage: json['currentPage'] as int,
      resultCount: json['resultCount'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'resultCount': resultCount,
      'totalPages': totalPages,
    };
  }
}

class QestionsCategory {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String name;

  QestionsCategory({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory QestionsCategory.fromJson(Map<String, dynamic> json) {
    return QestionsCategory(
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'name': name,
    };
  }
}
