import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';

mixin Repository {
  Future<HoroscopeEntity> getDaily({Language language});
  Future<HoroscopeEntity> getWeekly({Language language});
  Future<HoroscopeEntity> getMonthly({Language language});
  Future<HoroscopeEntity> getYearly({Language language});

  Future<HoroscopeEntity> like(HoroscopeEntity feed);
  Future<HoroscopeEntity> unlike(HoroscopeEntity feed);

  Future<HoroscopeEntity> dislike(HoroscopeEntity feed);
  Future<HoroscopeEntity> undislike(HoroscopeEntity feed);

  Future<HoroscopeEntity> share(HoroscopeEntity feed);
  Future<HoroscopeEntity> view(HoroscopeEntity feed);
}
