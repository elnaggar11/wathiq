import 'by.dart';

class Updated {
  By? by;
  DateTime? at;

  Updated({this.by, this.at});

  factory Updated.fromJson(Map<String, dynamic> json) => Updated(
        by: json['by'] == null
            ? null
            : By.fromJson(json['by'] as Map<String, dynamic>),
        at: json['at'] == null ? null : DateTime.parse(json['at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'by': by?.toJson(),
        'at': at?.toIso8601String(),
      };
}
