import 'package:samachar_hub/core/utils/date_time_utils.dart';

extension DateTimeParsingX on String {
  DateTime get toDate => DateTime.parse(this);
}

extension DateTimeX on DateTime {
  String get momentAgo => relativeTimeString(this);
}
