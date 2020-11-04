import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/dislike_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/undislike_news_use_case.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeNewsFeedUseCase;
  final UseCase _undislikeNewsFeedUseCase;

  DislikeBloc({
    @required UseCase dislikeNewsFeedUseCase,
    @required UseCase undislikeNewsFeedUseCase,
  })  : _dislikeNewsFeedUseCase = dislikeNewsFeedUseCase,
        _undislikeNewsFeedUseCase = undislikeNewsFeedUseCase,
        super(DislikeInitial());
  @override
  Stream<DislikeState> mapEventToState(
    DislikeUndislikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is DislikeInProgress) return;
    if (event is DislikeEvent) {
      yield DislikeInProgress();
      try {
        final NewsFeedEntity newsFeedEntity = await _dislikeNewsFeedUseCase
            .call(DislikeNewsUseCaseParams(feed: event.feed));
        if (newsFeedEntity != null)
          yield DislikeSuccess(feed: newsFeedEntity);
        else
          yield DislikeError(message: 'Unable to dislike');
      } catch (e) {
        log('News feed dislike error.', error: e);
        yield DislikeError(message: 'Unable to dislike.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        final NewsFeedEntity newsFeedEntity = await _undislikeNewsFeedUseCase
            .call(UndislikeNewsUseCaseParams(feed: event.feed));
        if (newsFeedEntity != null)
          yield UndislikeSuccess(feed: newsFeedEntity);
        else
          yield DislikeError(message: 'Unable to remove dislike');
      } catch (e) {
        log('News feed undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
