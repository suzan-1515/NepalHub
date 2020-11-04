import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_detail_use_case.dart';

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final NewsFeedEntity feed;
  final UseCase _getDetailNewsUseCase;

  NewsDetailBloc({@required this.feed, @required UseCase getDetailNewsUseCase})
      : _getDetailNewsUseCase = getDetailNewsUseCase,
        super(NewsDetailInitialState(feed: feed));

  @override
  Stream<NewsDetailState> mapEventToState(
    NewsDetailEvent event,
  ) async* {
    if (state is NewsDetailLoadingState) return;
    if (event is GetNewsDetailEvent) {
      yield NewsDetailLoadingState();
      try {
        if (feed != null) {
          yield NewsDetailLoadSuccessState(feed);
        }
        final NewsFeedEntity feedEntity = await _getDetailNewsUseCase
            .call(GetNewsDetailUseCaseParams(feedId: feed.id));
        if (feedEntity != null) yield NewsDetailLoadSuccessState(feedEntity);
      } catch (e) {
        log('News detail load error.', error: e);
        yield NewsDetailErrorState(message: 'Unable to load data.');
      }
    } else if (event is FeedChangeEvent) {
      try {
        final currentState = state;
        if (currentState is NewsDetailLoadSuccessState) {
          if (event.eventType == 'feed') {
            final feed = (event.data as NewsFeedEntity);
            if (feed.id == this.feed.id) {
              yield NewsDetailLoadSuccessState(feed);
            }
          } else if (event.eventType == 'source') {
            final source = (event.data as NewsSourceEntity);
            if (source.id == this.feed.source.id) {
              yield NewsDetailLoadSuccessState(
                  currentState.feed.copyWith(source: source));
            }
          }
        }
      } catch (e) {
        log('Update change event of ${event.eventType} error: ', error: e);
      }
    }
  }
}
