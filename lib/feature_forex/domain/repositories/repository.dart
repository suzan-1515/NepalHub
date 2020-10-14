import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';

mixin Repository {
  Future<List<ForexEntity>> getLatestForex({Language language});
  Future<List<ForexEntity>> getForexTimeline(
      {@required String currencyId, Language language, int numOfDays});
  Future<List<CurrencyEntity>> getCurrencies({Language language});
  Future<ForexEntity> like(ForexEntity feed);
  Future<ForexEntity> unlike(ForexEntity feed);

  Future<ForexEntity> dislike(ForexEntity feed);
  Future<ForexEntity> undislike(ForexEntity feed);

  Future<ForexEntity> share(ForexEntity feed);
  Future<ForexEntity> view(ForexEntity feed);

  Future<String> getDefaultCurrencyCode();
}
