import 'package:intl/intl.dart';

class DateUtils {
  static String formattedNow() {
    return DateFormat("dd/MM/yyyy").format(DateTime.now());
  }
}
