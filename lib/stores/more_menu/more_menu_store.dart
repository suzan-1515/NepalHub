import 'package:mobx/mobx.dart';
import 'package:samachar_hub/services/services.dart';

part 'more_menu_store.g.dart';

class MoreMenuStore = _MoreMenuStore with _$MoreMenuStore;

abstract class _MoreMenuStore with Store {
  PreferenceService _preferenceService;

  @observable
  String message;

  _MoreMenuStore(this._preferenceService);
}
