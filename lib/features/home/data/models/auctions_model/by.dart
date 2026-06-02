class By {
  String? id;
  String? name;
  String? profileImage;

  By({this.id, this.name, this.profileImage});

  factory By.fromJson(Map<String, dynamic> json) => By(
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
