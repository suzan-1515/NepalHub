import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/like_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unlike_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeNewsFeedUseCase;
  final UseCase _unLikeNewsFeedUseCase;

  LikeUnlikeBloc({
    @required UseCase likeNewsFeedUseCase,
    @required UseCase unLikeNewsFeedUseCase,
  })  : _likeNewsFeedUseCase = likeNewsFeedUseCase,
        _unLikeNewsFeedUseCase = unLikeNewsFeedUseCase,
        super(InitialState());

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    final currentState = state;
    if (currentState is InProgressState) return;
    if (event is LikeEvent) {
      yield InProgressState();
      try {
        await _likeNewsFeedUseCase
            .call(LikeNewsUseCaseParams(feed: event.feedModel.feed));
        yield LikedState(message: 'Feed liked successfully.');
      } catch (e) {
        log('News feed like error.', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      yield InProgressState();
      try {
        await _unLikeNewsFeedUseCase
            .call(UnlikeNewsUseCaseParams(feed: event.feedModel.feed));
        yield UnlikedState(message: 'News feed unliked successfully.');
      } catch (e) {
        log('News feed unlike error.', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
