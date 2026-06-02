import 'package:intl/intl.dart';

String getDayNameArabic(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String dayName = DateFormat('EEEE', 'ar').format(dateTime);
  return dayName;
}
