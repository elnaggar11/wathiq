class Timer {
  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  Timer({this.days, this.hours, this.minutes, this.seconds});

  factory Timer.fromJson(Map<String, dynamic> json) => Timer(
        days: json['days'] as int?,
        hours: json['hours'] as int?,
        minutes: json['minutes'] as int?,
        seconds: json['seconds'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds,
      };
}
