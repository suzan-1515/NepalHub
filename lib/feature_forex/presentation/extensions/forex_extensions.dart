import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';

extension ForexX on ForexEntity {
  ForexUIModel get toUIModel => ForexUIModel(this);
}

extension ForexListX on List<ForexEntity> {
  List<ForexUIModel> get toUIModels => this.map((e) => e.toUIModel).toList();
}

extension ForexDateTimeX on DateTime {
  String get formatttedString =>
      DateFormat('dd MMMM, yyyy').format(this.toLocal());
}
