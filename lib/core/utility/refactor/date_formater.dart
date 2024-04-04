import 'package:intl/intl.dart';

String formatCustomDate(DateTime date) {
  final DateFormat formatter = DateFormat('MMM-dd-yyyy');
  return formatter.format(date);
}
