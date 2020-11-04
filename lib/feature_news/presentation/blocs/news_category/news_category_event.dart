part of 'news_category_bloc.dart';

abstract class NewsCategoryEvent extends Equatable {
  const NewsCategoryEvent();
}

class GetCategories extends NewsCategoryEvent {
  final Language language;

  GetCategories({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class GetFollowedCategories extends NewsCategoryEvent {
  final Language language;

  GetFollowedCategories({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class RefreshCategories extends NewsCategoryEvent {
  final Language language;

  RefreshCategories({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class UpdateCategoryChangeEvent extends NewsCategoryEvent {
  final NewsCategoryEntity category;
  final String eventType;

  UpdateCategoryChangeEvent(
      {@required this.category, @required this.eventType});
  @override
  List<Object> get props => [category, eventType];
}
