import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';
import 'package:samachar_hub/feature_stats/presentation/models/thread_stats_model.dart';

extension ThreadStatsX on ThreadStatsEntity {
  ThreadStatsUIModel get toUIModel => ThreadStatsUIModel(this);
}
