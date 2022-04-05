import 'package:intl/intl.dart';

String parseTimeStamp(int value) {
  if (value != null) {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    var d12 = DateFormat('dd MMM yyyy, HH:mm ss').format(date);
    return d12;
  }
  return '';
}
