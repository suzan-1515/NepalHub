import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/dislike_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/undislike_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'dislike_event.dart';
part 'dislike_state.dart';

class DislikeBloc extends Bloc<DislikeUndislikeEvent, DislikeState> {
  final UseCase _dislikeNewsFeedUseCase;
  final UseCase _undislikeNewsFeedUseCase;
  final NewsFeedUIModel _newsFeedUIModel;

  DislikeBloc({
    @required UseCase dislikeNewsFeedUseCase,
    @required UseCase undislikeNewsFeedUseCase,
    @required NewsFeedUIModel newsFeedUIModel,
  })  : _dislikeNewsFeedUseCase = dislikeNewsFeedUseCase,
        _undislikeNewsFeedUseCase = undislikeNewsFeedUseCase,
        _newsFeedUIModel = newsFeedUIModel,
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
        await _dislikeNewsFeedUseCase
            .call(DislikeNewsUseCaseParams(feed: _newsFeedUIModel.feedEntity));
        yield DislikeSuccess(message: 'Feed disliked successfully.');
      } catch (e) {
        log('News feed dislike error.', error: e);
        yield DislikeError(message: 'Unable to like.');
      }
    } else if (event is UndislikeEvent) {
      yield DislikeInProgress();
      try {
        await _undislikeNewsFeedUseCase.call(
            UndislikeNewsUseCaseParams(feed: _newsFeedUIModel.feedEntity));
        yield UndislikeSuccess(message: 'News feed undisliked successfully.');
      } catch (e) {
        log('News feed undislike error.', error: e);
        yield DislikeError(message: 'Unable to undislike.');
      }
    }
  }
}
