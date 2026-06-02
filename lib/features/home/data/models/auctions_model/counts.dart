class Counts {
  int? inProgressCount;
  int? onGoingCount;
  int? completedCount;

  Counts({this.inProgressCount, this.onGoingCount, this.completedCount});

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
        inProgressCount: json['inProgressCount'] as int?,
        onGoingCount: json['onGoingCount'] as int?,
        completedCount: json['completedCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'inProgressCount': inProgressCount,
        'onGoingCount': onGoingCount,
        'completedCount': completedCount,
      };
}
