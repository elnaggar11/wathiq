import '../utils/app_strings.dart';

String getAuctionStatusText(String? status) {
  if (status == AppStrings.auctionsOnGoing) {
    return 'قائم';
  } else if (status == AppStrings.auctionsInProgress) {
    return 'مستقبلي';
  } else {
    return 'منتهي';
  }
}

String getAuctionTimerText(String? status) {
  if (status == AppStrings.auctionsOnGoing) {
    return 'ينتهي بعد';
  } else if (status == AppStrings.auctionsInProgress) {
    return 'قادم بعد';
  } else {
    return 'مزاد منتهي';
  }
}

String getAuctionTypeText(String? type) {
  print(type);
  if (type == AppStrings.online) {
    return 'مزاد الكتروني';
  } else if (type == AppStrings.hybrid) {
    return 'مزاد هجين';
  } else {
    return 'مزاد حضوري';
  }
}
