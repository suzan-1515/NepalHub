import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_detail_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final NewsFeedUIModel feed;
  final UseCase _getDetailNewsUseCase;

  NewsDetailBloc({@required this.feed, @required UseCase getDetailNewsUseCase})
      : _getDetailNewsUseCase = getDetailNewsUseCase,
        super(InitialState(feed: feed));

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
        }
        final NewsFeedEntity feedEntity = await _getDetailNewsUseCase
            .call(GetNewsDetailUseCaseParams(feedId: feed.feedEntity.id));
        if (feedEntity != null) yield LoadSuccessState(feedEntity.toUIModel);
      } catch (e) {
        log('News detail load error.', error: e);
        yield ErrorState(message: 'Unable to load data.');
      }
    }
  }
}
