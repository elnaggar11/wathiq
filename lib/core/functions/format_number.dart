import 'package:intl/intl.dart';

String formatNumber(num value) {
  final formatter = NumberFormat("#,##0");
  return formatter.format(value);
}

num parseFormattedNumber(String formatted) {
  final cleaned = formatted.replaceAll(',', '');
  return num.parse(cleaned);
}
