String calculateTimeDifference(String timestampStr) {
  try {
    DateTime timestamp = DateTime.parse(timestampStr);
    DateTime now = DateTime.now();
    Duration difference = now.difference(timestamp);

    if (difference.isNegative) {
      return "في المستقبل";
    }

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    if (days > 0) {
      if (days == 1) {
        return "منذ يوم واحد";
      } else if (days == 2) {
        return "منذ يومين";
      } else if (days >= 3 && days <= 10) {
        return "منذ $days أيام";
      } else {
        return "منذ $days يوم";
      }
    } else if (hours > 0) {
      if (hours == 1) {
        return "منذ ساعة واحدة";
      } else if (hours == 2) {
        return "منذ ساعتين";
      } else if (hours >= 3 && hours <= 10) {
        return "منذ $hours ساعات";
      } else {
        return "منذ $hours ساعة";
      }
    } else if (minutes > 0) {
      if (minutes == 1) {
        return "منذ دقيقة واحدة";
      } else if (minutes == 2) {
        return "منذ دقيقتين";
      } else if (minutes >= 3 && minutes <= 10) {
        return "منذ $minutes دقائق";
      } else {
        return "منذ $minutes دقيقة";
      }
    } else {
      return "الآن";
    }
  } catch (e) {
    print("Error parsing timestamp: $e");
    return "خطأ في الوقت";
  }
}
