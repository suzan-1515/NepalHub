part of 'news_category_feed_bloc.dart';

abstract class NewsCategoryFeedEvent extends Equatable {
  const NewsCategoryFeedEvent();
}

class GetCategoryNewsEvent extends NewsCategoryFeedEvent {
  final Language language;

  GetCategoryNewsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}

class GetMoreCategoryNewsEvent extends NewsCategoryFeedEvent {
  final Language language;

  GetMoreCategoryNewsEvent({this.language = Language.NEPALI});

  @override
  List<Object> get props => [language];
}

class RefreshCategoryNewsEvent extends NewsCategoryFeedEvent {
  final Language language;

  RefreshCategoryNewsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}
