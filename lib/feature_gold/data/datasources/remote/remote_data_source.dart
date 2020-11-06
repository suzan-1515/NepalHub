import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_gold/data/models/gold_silver_category.dart';
import 'package:samachar_hub/feature_gold/data/models/gold_silver_model.dart';

mixin RemoteDataSource {
  Future<List<GoldSilverModel>> fetchLatestGoldSilver(
      {@required Language language, @required String token});
  Future<List<GoldSilverModel>> fetchGoldSilverTimeline(
      {@required String categoryId,
      @required String unit,
      @required Language language,
      @required int numOfDays,
      @required String token});
  Future<List<GoldSilverCategoryModel>> fetchCategories(
      {@required Language language, @required String token});
  Future<GoldSilverModel> like(
      {@required String goldSilverId, @required String token});
  Future<GoldSilverModel> unlike(
      {@required String goldSilverId, @required String token});

  Future<GoldSilverModel> dislike(
      {@required String goldSilverId, @required String token});
  Future<GoldSilverModel> undislike(
      {@required String goldSilverId, @required String token});

  Future<GoldSilverModel> share(
      {@required String goldSilverId, @required String token});
  Future<GoldSilverModel> view(
      {@required String goldSilverId, @required String token});
}
