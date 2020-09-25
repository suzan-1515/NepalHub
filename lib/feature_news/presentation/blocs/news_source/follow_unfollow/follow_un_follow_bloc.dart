import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_source_use_case.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class FollowUnFollowBloc
    extends Bloc<FollowUnFollowEvent, FollowUnFollowState> {
  final UseCase _followNewsSourceUseCase;
  final UseCase _unFollowNewsSourceUseCase;

  FollowUnFollowBloc({
    @required UseCase followNewsSourceUseCase,
    @required UseCase unFollowNewsSourceUseCase,
  })  : _followNewsSourceUseCase = followNewsSourceUseCase,
        _unFollowNewsSourceUseCase = unFollowNewsSourceUseCase,
        super(InitialState());

  @override
  Stream<FollowUnFollowState> mapEventToState(
    FollowUnFollowEvent event,
  ) async* {
    final currentState = state;
    if (event is FollowEvent && !(currentState is InProgressState)) {
      yield InProgressState();
      try {
        await _followNewsSourceUseCase
            .call(FollowNewsSourceUseCaseParams(source: event.sourceModel));
        yield FollowedState(message: 'Source followed successfully.');
      } catch (e) {
        log('News source follow load error.', error: e);
        yield ErrorState(message: 'Unable to follow.');
      }
    } else if (event is UnFollowEvent && !(currentState is InProgressState)) {
      yield InProgressState();
      try {
        await _unFollowNewsSourceUseCase
            .call(UnFollowNewsSourceUseCaseParams(source: event.sourceModel));
        yield UnFollowedState(message: 'Source unFollowed successfully.');
      } catch (e) {
        log('News categories load error.', error: e);
        yield ErrorState(message: 'Unable to unfollow.');
      }
    }
  }
}
