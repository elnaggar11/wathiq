class Logo {
  String? id;
  String? logo;
  bool? active;

  Logo({this.id, this.logo, this.active});

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        id: json['_id'] as String?,
        logo: json['logo'] as String?,
        active: json['active'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'logo': logo,
        'active': active,
      };
}
