import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:validators/validators.dart' as Validator;

class NewsTopicEntity extends Equatable {
  final String id;
  final String title;
  final String icon;
  final List<NewsCategoryEntity> categories;
  final bool isFollowed;
  final int followerCount;
  final bool isBlocked;
  final Language language;
  final DateTime updatedAt;
  final DateTime createdAt;

  NewsTopicEntity({
    @required this.id,
    @required this.title,
    this.icon,
    this.categories,
    @required this.isFollowed,
    @required this.followerCount,
    @required this.isBlocked,
    @required this.language,
    @required this.updatedAt,
    @required this.createdAt,
  });

  bool get isValidIcon => Validator.isURL(icon);

  NewsTopicEntity copyWith({
    String id,
    String title,
    String icon,
    List<NewsCategoryEntity> categories,
    bool isFollowed,
    int followerCount,
    bool isBlocked,
    Language language,
    DateTime updatedAt,
    DateTime createdAt,
  }) =>
      NewsTopicEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        categories: categories ?? this.categories,
        isFollowed: isFollowed ?? this.isFollowed,
        followerCount: followerCount ?? this.followerCount,
        language: language ?? this.language,
        isBlocked: isBlocked ?? this.isBlocked,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => [
        id,
        title,
        icon,
        isFollowed,
        followerCount,
        language,
        isBlocked,
        categories
      ];

  @override
  bool get stringify => true;
}
