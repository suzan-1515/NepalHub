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
  final int page;

  GetMoreCategoryNewsEvent(
      {this.language = Language.NEPALI, @required this.page});

  @override
  List<Object> get props => [language, page];
}

class RetryCategoryNewsEvent extends NewsCategoryFeedEvent {
  final Language language;
  final int page;

  RetryCategoryNewsEvent({this.language = Language.NEPALI, this.page = 1});
  @override
  List<Object> get props => [language, page];
}

class RefreshCategoryNewsEvent extends NewsCategoryFeedEvent {
  final Language language;

  RefreshCategoryNewsEvent({this.language = Language.NEPALI});
  @override
  List<Object> get props => [language];
}
