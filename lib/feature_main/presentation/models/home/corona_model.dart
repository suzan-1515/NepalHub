import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';

class CoronaUIModel {
  CoronaEntity coronaEntity;
  String formattedUpdatedDate;

  CoronaUIModel({@required this.coronaEntity}) {
    formattedUpdatedDate =
        DateFormat.yMd().add_jm().format(coronaEntity.lastUpdated);
  }
}
