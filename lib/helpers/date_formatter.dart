

import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String? date){
    try {
      DateTime dateTime = DateTime.parse(date ?? '');
      return DateFormat.yMMMMd('pt').format(dateTime);
    } catch (e) {
      return '';
    }

  }
}