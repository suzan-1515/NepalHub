import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_topic_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_topic_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class FollowUnFollowBloc
    extends Bloc<FollowUnFollowEvent, FollowUnFollowState> {
  final UseCase _followNewsTopicUseCase;
  final UseCase _unFollowNewsTopicUseCase;

  FollowUnFollowBloc({
    @required UseCase followNewsTopicUseCase,
    @required UseCase unFollowNewsTopicUseCase,
  })  : _followNewsTopicUseCase = followNewsTopicUseCase,
        _unFollowNewsTopicUseCase = unFollowNewsTopicUseCase,
        super(InitialState());

  @override
  Stream<FollowUnFollowState> mapEventToState(
    FollowUnFollowEvent event,
  ) async* {
    final currentState = state;
    if (event is FollowEvent && !(currentState is InProgressState)) {
      yield InProgressState();
      try {
        await _followNewsTopicUseCase
            .call(FollowNewsTopicUseCaseParams(topic: event.topicModel.topic));
        yield FollowedState(message: 'Topic followed successfully.');
      } catch (e) {
        log('News topic follow error.', error: e);
        yield ErrorState(message: 'Unable to follow.');
      }
    } else if (event is UnFollowEvent && !(currentState is InProgressState)) {
      yield InProgressState();
      try {
        await _unFollowNewsTopicUseCase.call(
            UnFollowNewsTopicUseCaseParams(topic: event.topicModel.topic));
        yield UnFollowedState(message: 'Topic unFollowed successfully.');
      } catch (e) {
        log('News categories error.', error: e);
        yield ErrorState(message: 'Unable to unfollow.');
      }
    }
  }
}
