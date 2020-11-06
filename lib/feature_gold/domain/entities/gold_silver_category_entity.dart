import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:samachar_hub/core/models/language.dart';

class GoldSilverCategoryEntity {
  GoldSilverCategoryEntity({
    @required this.id,
    @required this.title,
    @required this.code,
    @required this.language,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.icon,
  });

  final String id;
  final String title;
  final String code;
  final Language language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String icon;

  GoldSilverCategoryEntity copyWith({
    String id,
    String title,
    String code,
    Language language,
    DateTime createdAt,
    DateTime updatedAt,
    String icon,
  }) =>
      GoldSilverCategoryEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        icon: icon ?? this.icon,
      );

  String toJson() => json.encode(toMap());

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
