import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class ForexUIModel extends Model {
  ForexEntity _forexEntity;
  ForexUIModel(this._forexEntity);

  set entity(ForexEntity forexEntity) {
    this._forexEntity = forexEntity;
    notifyListeners();
  }

  ForexEntity get entity => this._forexEntity;
}
