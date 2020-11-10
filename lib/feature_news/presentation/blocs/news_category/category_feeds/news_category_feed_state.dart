part of 'news_category_feed_bloc.dart';

abstract class NewsCategoryFeedState extends Equatable {
  const NewsCategoryFeedState();
}

class NewsCategoryFeedInitialState extends NewsCategoryFeedState {
  final NewsCategoryUIModel category;
  const NewsCategoryFeedInitialState({@required this.category});

  @override
  List<Object> get props => [category];
}

class NewsCategoryFeedLoadingState extends NewsCategoryFeedState {
  @override
  List<Object> get props => [];
}

class NewsCategoryFeedMoreLoadingState extends NewsCategoryFeedState {
  @override
  List<Object> get props => [];
}

class NewsCategoryFeedLoadSuccessState extends NewsCategoryFeedState {
  final List<NewsFeedUIModel> feeds;
  final bool hasMore;

  NewsCategoryFeedLoadSuccessState({this.feeds, this.hasMore});

  NewsCategoryFeedLoadSuccessState copyWith({
    List<NewsFeedUIModel> feeds,
    bool hasMore,
  }) =>
      NewsCategoryFeedLoadSuccessState(
        feeds: feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class NewsCategoryFeedEmptyState extends NewsCategoryFeedState {
  final String message;

  NewsCategoryFeedEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsCategoryFeedLoadErrorState extends NewsCategoryFeedState {
  final String message;

  NewsCategoryFeedLoadErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class NewsCategoryFeedErrorState extends NewsCategoryFeedState {
  final String message;

  NewsCategoryFeedErrorState({this.message});

  @override
  List<Object> get props => [message];
}
