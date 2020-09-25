part of 'news_category_feed_bloc.dart';

abstract class NewsCategoryFeedState extends Equatable {
  const NewsCategoryFeedState();
}

class Initial extends NewsCategoryFeedState {
  final NewsCategoryUIModel categoryModel;
  const Initial({@required this.categoryModel});

  @override
  List<Object> get props => [categoryModel.category];
}

class Loading extends NewsCategoryFeedState {
  @override
  List<Object> get props => [];
}

class LoadMoreLoading extends NewsCategoryFeedState {
  @override
  List<Object> get props => [];
}

class LoadSuccess extends NewsCategoryFeedState {
  final List<NewsFeedUIModel> feeds;
  final bool hasMore;

  LoadSuccess({this.feeds, this.hasMore});

  LoadSuccess copyWith({
    List<NewsFeedUIModel> feeds,
    bool hasMore,
  }) =>
      LoadSuccess(
        feeds: feeds ?? this.feeds,
        hasMore: hasMore ?? this.hasMore,
      );

  @override
  List<Object> get props => [feeds, hasMore];
}

class Empty extends NewsCategoryFeedState {
  final String message;

  Empty({this.message});

  @override
  List<Object> get props => [message];
}

class ErrorState extends NewsCategoryFeedState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadMoreError extends NewsCategoryFeedState {
  final String message;

  LoadMoreError({this.message});

  @override
  List<Object> get props => [message];
}

class Refreshing extends NewsCategoryFeedState {
  @override
  List<Object> get props => [];
}

class RefreshError extends NewsCategoryFeedState {
  final String message;

  RefreshError({this.message});

  @override
  List<Object> get props => [message];
}
