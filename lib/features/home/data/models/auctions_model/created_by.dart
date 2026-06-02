class CreatedBy {
  String? id;
  String? name;
  String? profileImage;

  CreatedBy({this.id, this.name, this.profileImage});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        profileImage: json['profileImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'profileImage': profileImage,
      };
}
