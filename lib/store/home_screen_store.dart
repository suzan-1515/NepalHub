import 'package:mobx/mobx.dart';
import 'package:samachar_hub/service/preference_service.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {

  _HomeScreenStore(PreferenceService preferenceService);

  @observable
  int selectedPage = 0;

  @action
  setPage(int pageIndex) {
    selectedPage = pageIndex;
  }
}
