import 'package:samachar_hub/common/preference_service.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final PreferenceService _preferenceService;

  const AuthService(this._preferenceService);

  String get userId {
    if (_preferenceService.userId == null)
      _preferenceService.userId = Uuid().v4();
    return _preferenceService.userId;
  }
}
