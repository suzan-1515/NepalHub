import 'package:intl/intl.dart';

extension NumberExtension on int {
  String get compactFormat => NumberFormat.compact().format(this);
}

extension DoubleX on double {
  String get formattedString => NumberFormat.currency(symbol: '').format(this);
}
