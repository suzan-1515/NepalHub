import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_detail_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final NewsFeedUIModel feed;
  final String feedId;
  final UseCase _getDetailNewsUseCase;

  NewsDetailBloc(
      {this.feedId, this.feed, @required UseCase getDetailNewsUseCase})
      : _getDetailNewsUseCase = getDetailNewsUseCase,
        super(InitialState(feed: feed, feedId: feedId));

  @override
  Stream<NewsDetailState> mapEventToState(
    NewsDetailEvent event,
  ) async* {
    if (state is LoadingState) return;
    if (event is GetNewsDetailEvent) {
      yield LoadingState();
      try {
        if (feed != null) {
          yield LoadSuccessState(feed);
        } else if (feedId != null && feedId.isNotEmpty) {
          final NewsFeedEntity feed = await _getDetailNewsUseCase
              .call(GetNewsDetailUseCaseParams(feedId: feedId));
          if (feed == null)
            yield EmptyState(message: 'News detail not available.');
          else
            yield LoadSuccessState(feed.toUIModel);
        } else
          yield LoadErrorState(message: 'Unknown feed.');
      } catch (e) {
        log('News detail load error.', error: e);
        yield LoadErrorState(message: 'Unable to load data.');
      }
    }
  }
}
