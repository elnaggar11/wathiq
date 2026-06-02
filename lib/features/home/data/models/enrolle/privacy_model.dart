class PrivacyModel {
  final String message;
  final DataModel data;

  PrivacyModel({required this.message, required this.data});

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyModel(
      message: json['message'],
      data: DataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class DataModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  DataModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}
