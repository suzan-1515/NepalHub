import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_source_use_case.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class SourceFollowUnFollowBloc
    extends Bloc<SourceFollowUnFollowEvent, SourceFollowUnFollowState> {
  final UseCase _followNewsSourceUseCase;
  final UseCase _unFollowNewsSourceUseCase;

  SourceFollowUnFollowBloc({
    @required UseCase followNewsSourceUseCase,
    @required UseCase unFollowNewsSourceUseCase,
  })  : _followNewsSourceUseCase = followNewsSourceUseCase,
        _unFollowNewsSourceUseCase = unFollowNewsSourceUseCase,
        super(SourceFollowInitialState());

  @override
  Stream<Transition<SourceFollowUnFollowEvent, SourceFollowUnFollowState>>
      transformEvents(Stream<SourceFollowUnFollowEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<SourceFollowUnFollowState> mapEventToState(
    SourceFollowUnFollowEvent event,
  ) async* {
    if (event is SourceFollowEvent) {
      yield* _mapFollowEventToState(event);
    } else if (event is SourceUnFollowEvent) {
      yield* _mapUnFollowEventToState(event);
    }
  }

  Stream<SourceFollowUnFollowState> _mapFollowEventToState(
    SourceFollowEvent event,
  ) async* {
    if (state is SourceFollowInProgressState) return;
    yield SourceFollowInProgressState();
    try {
      final NewsSourceEntity newsSourceEntity = await _followNewsSourceUseCase
          .call(FollowNewsSourceUseCaseParams(source: event.source));
      if (newsSourceEntity != null)
        yield SourceFollowSuccessState(source: newsSourceEntity);
      else
        yield SourceFollowErrorState(message: 'Unable to follow.');
    } catch (e) {
      log('News source follow load error.', error: e);
      yield SourceFollowErrorState(message: 'Unable to follow.');
    }
  }

  Stream<SourceFollowUnFollowState> _mapUnFollowEventToState(
    SourceUnFollowEvent event,
  ) async* {
    if (state is SourceFollowInProgressState) return;
    yield SourceFollowInProgressState();
    try {
      final NewsSourceEntity newsSourceEntity = await _unFollowNewsSourceUseCase
          .call(UnFollowNewsSourceUseCaseParams(source: event.source));
      if (newsSourceEntity != null)
        yield SourceUnFollowSuccessState(source: newsSourceEntity);
      else
        yield SourceFollowErrorState(message: 'Unable to unfollow.');
    } catch (e) {
      log('News sources unfollow error.', error: e);
      yield SourceFollowErrorState(message: 'Unable to unfollow.');
    }
  }
}
