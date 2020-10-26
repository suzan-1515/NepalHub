import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_topic_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_topic_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class FollowUnFollowBloc
    extends Bloc<FollowUnFollowEvent, FollowUnFollowState> {
  final UseCase _followNewsTopicUseCase;
  final UseCase _unFollowNewsTopicUseCase;
  final NewsTopicUIModel _newsTopicUIModel;

  FollowUnFollowBloc(
      {@required UseCase followNewsTopicUseCase,
      @required UseCase unFollowNewsTopicUseCase,
      @required NewsTopicUIModel newsTopicUIModel})
      : _followNewsTopicUseCase = followNewsTopicUseCase,
        _unFollowNewsTopicUseCase = unFollowNewsTopicUseCase,
        _newsTopicUIModel = newsTopicUIModel,
        super(FollowUnFollowInitialState());

  NewsTopicUIModel get newsTopicUIModel => _newsTopicUIModel;

  @override
  Stream<FollowUnFollowState> mapEventToState(
    FollowUnFollowEvent event,
  ) async* {
    final currentState = state;
    if (event is FollowUnFollowFollowEvent &&
        !(currentState is FollowUnFollowInProgressState)) {
      yield FollowUnFollowInProgressState();
      try {
        final NewsTopicEntity newsTopicEntity = await _followNewsTopicUseCase
            .call(FollowNewsTopicUseCaseParams(topic: newsTopicUIModel.topic));
        if (newsTopicEntity != null)
          newsTopicUIModel.topic = newsTopicUIModel.topic.copyWith(
              isFollowed: newsTopicEntity.isFollowed,
              followerCount: newsTopicEntity.followerCount);
        yield FollowUnFollowFollowedState(
            message: 'Topic followed successfully.');
      } catch (e) {
        log('News topic follow error.', error: e);
        yield FollowUnFollowErrorState(message: 'Unable to follow.');
      }
    } else if (event is FollowUnFollowUnFollowEvent &&
        !(currentState is FollowUnFollowInProgressState)) {
      yield FollowUnFollowInProgressState();
      try {
        final NewsTopicEntity newsTopicEntity =
            await _unFollowNewsTopicUseCase.call(
                UnFollowNewsTopicUseCaseParams(topic: newsTopicUIModel.topic));
        if (newsTopicEntity != null)
          newsTopicUIModel.topic = newsTopicUIModel.topic.copyWith(
              isFollowed: newsTopicEntity.isFollowed,
              followerCount: newsTopicEntity.followerCount);
        yield FollowUnFollowUnFollowedState(
            message: 'Topic unFollowed successfully.');
      } catch (e) {
        log('News categories error.', error: e);
        yield FollowUnFollowErrorState(message: 'Unable to unfollow.');
      }
    }
  }
}
