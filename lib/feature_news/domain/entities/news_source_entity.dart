import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:validators/validators.dart' as Validator;

class NewsSourceEntity extends Equatable {
  final String id;
  final String title;
  final String code;
  final String icon;
  final int priority;
  final String favicon;
  final bool isFollowed;
  final int followerCount;
  final bool isBlocked;
  final Language language;
  final DateTime updatedAt;
  final DateTime createdAt;

  NewsSourceEntity({
    @required this.id,
    @required this.title,
    @required this.code,
    this.icon,
    @required this.priority,
    this.favicon,
    @required this.isFollowed,
    @required this.followerCount,
    @required this.language,
    @required this.isBlocked,
    @required this.updatedAt,
    @required this.createdAt,
  });

  bool get isValidIcon => Validator.isURL(icon);

  bool get isValidFavIcon => Validator.isURL(favicon);

  NewsSourceEntity copyWith({
    String id,
    String title,
    String code,
    String icon,
    int priority,
    String favicon,
    bool isFollowed,
    int followerCount,
    bool isBlocked,
    Language language,
    DateTime updatedAt,
    DateTime createdAt,
  }) =>
      NewsSourceEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        icon: icon ?? this.icon,
        priority: priority ?? this.priority,
        isFollowed: isFollowed ?? this.isFollowed,
        followerCount: followerCount ?? this.followerCount,
        isBlocked: isBlocked ?? this.isBlocked,
        language: language ?? this.language,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => [
        id,
        title,
        code,
        icon,
        priority,
        favicon,
        isFollowed,
        followerCount,
        isBlocked,
        language
      ];

  @override
  bool get stringify => true;
}
