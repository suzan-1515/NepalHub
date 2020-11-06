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

class GoldSilverUIModels extends Model {
  List<GoldSilverEntity> _goldSilverEntities;
  GoldSilverUIModels(this._goldSilverEntities);

  set entity(List<GoldSilverEntity> goldSilverEntities) {
    this._goldSilverEntities = goldSilverEntities;
    notifyListeners();
  }

  List<GoldSilverEntity> get entities => this._goldSilverEntities;
}
