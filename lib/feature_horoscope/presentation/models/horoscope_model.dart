import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class HoroscopeUIModel extends Model {
  HoroscopeEntity _horoscopeEntity;
  HoroscopeUIModel(this._horoscopeEntity);
  set entity(HoroscopeEntity horoscopeEntity) {
    this._horoscopeEntity = horoscopeEntity;
    notifyListeners();
  }

  HoroscopeEntity get entity => this._horoscopeEntity;
}
