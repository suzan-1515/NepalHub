import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_related_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'related_news_event.dart';
part 'related_news_state.dart';

class RelatedNewsBloc extends Bloc<RelatedNewsEvent, RelatedNewsState> {
  final NewsFeedUIModel feed;
  final UseCase _getRelatedNewsUseCase;

  RelatedNewsBloc({this.feed, @required UseCase getDetailNewsUseCase})
      : _getRelatedNewsUseCase = getDetailNewsUseCase,
        super(InitialState());

  @override
  Stream<RelatedNewsState> mapEventToState(
    RelatedNewsEvent event,
  ) async* {
    if (state is LoadingState) return;
    if (event is GetRelatedNewsEvent) {
      yield LoadingState();
      try {
        final List<NewsFeedEntity> feeds = await _getRelatedNewsUseCase
            .call(GetRelatedNewsUseCaseParams(feed: feed.feed));
        if (feeds == null || feeds.isEmpty)
          yield EmptyState(message: 'Related feed not available.');
        else
          yield LoadSuccessState(feeds.toUIModels);
      } catch (e) {
        log('Related news load error.', error: e);
        yield LoadErrorState(message: 'Unable to load related feeds.');
      }
    }
  }
}
