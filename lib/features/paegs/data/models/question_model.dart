class QuestionsModel {
  final String message;
  final Pagination pagination;
  final List<Data> data;

  QuestionsModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      message: json['message'] as String,
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List<dynamic>)
          .map((item) => Data.fromJson(item))
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
  final int totalPages;
  final int resultCount;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.resultCount,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      resultCount: json['resultCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'resultCount': resultCount,
    };
  }
}

class Data {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String question;
  final String answer;
  final Category category;

  Data({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.question,
    required this.answer,
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'question': question,
      'answer': answer,
      'category': category.toJson(),
    };
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
