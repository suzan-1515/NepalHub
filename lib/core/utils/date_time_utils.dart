import 'package:timeago/timeago.dart' as timeago;

String relativeTimeString(DateTime dateTime) {
  return timeago.format(dateTime.toLocal());
}

String timeContextGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}

bool isMorning() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return true;
  }

  return false;
}

bool isEarlyMorning() {
  var hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return true;
  }

  return false;
}
