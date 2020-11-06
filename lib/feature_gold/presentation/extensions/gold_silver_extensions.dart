import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';

extension GoldSilverEntityX on GoldSilverEntity {
  GoldSilverUIModel get toUIModel => GoldSilverUIModel(this);
}

extension GoldSilverEntitiesX on List<GoldSilverEntity> {
  List<GoldSilverUIModel> get toUIModel =>
      this.map((e) => e.toUIModel).toList();
}

extension GoldSilverStringX on String {
  String get label => this == 'tola' ? 'Tola' : '10 gms';
}
