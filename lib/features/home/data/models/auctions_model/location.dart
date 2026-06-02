class Location {
  int? longitude;
  int? latitude;
  String? title;

  Location({this.longitude, this.latitude, this.title});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        longitude: json['longitude'] as int?,
        latitude: json['latitude'] as int?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'longitude': longitude,
        'latitude': latitude,
        'title': title,
      };
}
