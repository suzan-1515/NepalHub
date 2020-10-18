import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final String _defaultLocalNotificationKey = 'defaultLocalNotification';

  final SharedPreferences _sharedPreferences;

  const PreferenceService(this._sharedPreferences);

  set defaultLocalNotifications(bool value) {
    _sharedPreferences.setBool(_defaultLocalNotificationKey, value);
  }

  bool get defaultLocalNotifications =>
      _sharedPreferences.getBool(_defaultLocalNotificationKey);
}
