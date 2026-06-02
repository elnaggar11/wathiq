import 'by.dart';

class AuctionReviewStatus {
  String? status;
  dynamic reason;
  DateTime? at;
  By? by;

  AuctionReviewStatus({this.status, this.reason, this.at, this.by});

  factory AuctionReviewStatus.fromJson(Map<String, dynamic> json) {
    return AuctionReviewStatus(
      status: json['status'] as String?,
      reason: json['reason'] as dynamic,
      at: json['at'] == null ? null : DateTime.parse(json['at'] as String),
      by: json['by'] == null
          ? null
          : By.fromJson(json['by'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'reason': reason,
        'at': at?.toIso8601String(),
        'by': by?.toJson(),
      };
}
