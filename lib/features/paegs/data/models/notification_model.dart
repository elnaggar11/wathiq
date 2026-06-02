class NotificationModel {
  NotificationModel({
    this.id,
    this.sender,
    this.type,
    this.reference,
    this.status,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.message,
  });

  NotificationModel.fromJson(dynamic json) {
    id = json['_id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    type = json['type'];
    reference = json['reference'] != null
        ? Reference.fromJson(json['reference'])
        : null;
    status = json['status'];
    readAt = json['readAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    message = json['message'];
  }
  String? id;
  Sender? sender;
  String? type;
  Reference? reference;
  String? status;
  dynamic readAt;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? message;

  static List<NotificationModel> notificationListFromJson(
          List<dynamic> json) =>
      json.map((e) => NotificationModel.fromJson(e)).toList();

}

class Reference {
  Reference({
    this.model,
    this.id,
  });

  Reference.fromJson(dynamic json) {
    model = json['model'];
    id = json['id'];
  }
  dynamic model;
  dynamic id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model'] = model;
    map['id'] = id;
    return map;
  }
}

class Sender {
  Sender({
    this.profileImage,
  });

  Sender.fromJson(dynamic json) {
    profileImage = json['profileImage'];
  }
  dynamic profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profileImage'] = profileImage;
    return map;
  }
}
