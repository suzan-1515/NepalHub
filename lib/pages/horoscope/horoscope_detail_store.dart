import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/horoscope_model.dart';

part 'horoscope_detail_store.g.dart';

class HoroscopeDetailStore = _HoroscopeDetailStore with _$HoroscopeDetailStore;

abstract class _HoroscopeDetailStore with Store {
  final HoroscopeModel horoscopeModel;

  _HoroscopeDetailStore(this.horoscopeModel);

  @observable
  String message;

  dispose() {}
}
