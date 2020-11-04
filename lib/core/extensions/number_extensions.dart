import 'package:intl/intl.dart';

extension NumberExtension on int {
  String get compactFormat => NumberFormat.compact().format(this);
}
