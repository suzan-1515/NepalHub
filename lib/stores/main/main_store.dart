import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  @observable
  String message;

  @observable
  int selectedPage = 0;

  @observable
  int lastSelectedPage = 0;

  @action
  setPage(int pageIndex) {
    lastSelectedPage = selectedPage;
    selectedPage = pageIndex;
  }

  dispose() {}
}
