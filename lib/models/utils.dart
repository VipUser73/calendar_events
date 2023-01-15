import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd('ru').format(dateTime);
    return date;
  }

  static String toTime(DateTime? dateTime) {
    if (dateTime != null) {
      final time = DateFormat.Hm().format(dateTime);
      return time;
    }
    return '';
  }
}
