import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class GoldSilverUIModel extends Model {
  GoldSilverEntity _goldSilverEntity;
  GoldSilverUIModel(this._goldSilverEntity);

  set entity(GoldSilverEntity goldSilverEntity) {
    this._goldSilverEntity = goldSilverEntity;
    notifyListeners();
  }

  GoldSilverEntity get entity => this._goldSilverEntity;
}
