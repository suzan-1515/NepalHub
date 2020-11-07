import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:samachar_hub/core/models/language.dart';

class CurrencyEntity extends Equatable {
  CurrencyEntity({
    @required this.id,
    @required this.code,
    @required this.title,
    @required this.language,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.icon,
  });

  final String id;
  final String code;
  final String title;
  final Language language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String icon;

  CurrencyEntity copyWith({
    String id,
    String code,
    String title,
    Language language,
    DateTime createdAt,
    DateTime updatedAt,
    String icon,
  }) =>
      CurrencyEntity(
        id: id ?? this.id,
        code: code ?? this.code,
        title: title ?? this.title,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        icon: icon ?? this.icon,
      );

  @override
  List<Object> get props => [id, code, title, language, createdAt, updatedAt];

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "title": title,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": {"url": icon},
      };

  @override
  bool get stringify => true;
}
