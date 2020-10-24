import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';

class ForexCurrencyModel extends CurrencyEntity {
  ForexCurrencyModel({
    @required String id,
    @required String code,
    @required String title,
    @required Language language,
    @required DateTime createdAt,
    @required DateTime updatedAt,
    @required String icon,
  }) : super(
            id: id,
            code: code,
            title: title,
            language: language,
            createdAt: createdAt,
            updatedAt: updatedAt,
            icon: icon);
  factory ForexCurrencyModel.fromJson(String str) =>
      ForexCurrencyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForexCurrencyModel.fromMap(Map<String, dynamic> json) =>
      ForexCurrencyModel(
        id: json["id"].toString(),
        code: json["code"],
        title: json["title"],
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: json["icon"]["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "title": title,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": {"url": icon},
      };
}
