import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_category_entity.dart';

class GoldSilverCategoryModel extends GoldSilverCategoryEntity {
  GoldSilverCategoryModel({
    @required String id,
    @required String title,
    @required String code,
    @required Language language,
    @required DateTime createdAt,
    @required DateTime updatedAt,
    @required String icon,
  }) : super(
            id: id,
            title: title,
            code: code,
            language: language,
            createdAt: createdAt,
            updatedAt: updatedAt,
            icon: icon);

  factory GoldSilverCategoryModel.fromJson(String str) =>
      GoldSilverCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoldSilverCategoryModel.fromMap(Map<String, dynamic> json) =>
      GoldSilverCategoryModel(
        id: json["id"].toString(),
        title: json["title"],
        code: json["code"],
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: (json["icon"] == null) ? null : json["icon"]["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "code": code,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": {"url": icon},
      };
}
