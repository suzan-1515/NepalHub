import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_category_entity.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';

mixin Repository {
  Future<List<GoldSilverEntity>> getLatestGoldSilver({Language language});
  Future<List<GoldSilverEntity>> getGoldSilverTimeline(
      {@required String categoryId,
      @required String unit,
      Language language,
      int numOfDays});
  Future<List<GoldSilverCategoryEntity>> getCategories({Language language});
  Future<GoldSilverEntity> like(GoldSilverEntity feed);
  Future<GoldSilverEntity> unlike(GoldSilverEntity feed);

  Future<GoldSilverEntity> dislike(GoldSilverEntity feed);
  Future<GoldSilverEntity> undislike(GoldSilverEntity feed);

  Future<GoldSilverEntity> share(GoldSilverEntity feed);
  Future<GoldSilverEntity> view(GoldSilverEntity feed);
}
