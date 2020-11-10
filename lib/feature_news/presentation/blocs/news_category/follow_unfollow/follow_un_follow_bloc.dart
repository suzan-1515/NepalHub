import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_category_use_case.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class CategoryFollowUnFollowBloc
    extends Bloc<CategoryFollowUnfollowEvent, CategoryFollowUnFollowState> {
  final UseCase _followNewsCategoryUseCase;
  final UseCase _unFollowNewsCategoryUseCase;

  CategoryFollowUnFollowBloc(
      {@required UseCase followNewsCategoryUseCase,
      @required UseCase unFollowNewsCategoryUseCase})
      : _followNewsCategoryUseCase = followNewsCategoryUseCase,
        _unFollowNewsCategoryUseCase = unFollowNewsCategoryUseCase,
        super(CategoryFollowInitialState());

  @override
  Stream<Transition<CategoryFollowUnfollowEvent, CategoryFollowUnFollowState>>
      transformEvents(
          Stream<CategoryFollowUnfollowEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<CategoryFollowUnFollowState> mapEventToState(
    CategoryFollowUnfollowEvent event,
  ) async* {
    if (event is CategoryFollowEvent) {
      yield* _mapFollowEventToState(event);
    } else if (event is CategoryUnFollowEvent) {
      yield* _mapUnFollowEventToState(event);
    }
  }

  Stream<CategoryFollowUnFollowState> _mapFollowEventToState(
    CategoryFollowEvent event,
  ) async* {
    if (state is CategoryFollowInProgressState) return;
    yield CategoryFollowInProgressState();
    try {
      final NewsCategoryEntity newsCategoryEntity =
          await _followNewsCategoryUseCase
              .call(FollowNewsCategoryUseCaseParams(category: event.category));
      if (newsCategoryEntity != null)
        yield CategoryFollowSuccessState(category: newsCategoryEntity);
      else
        yield CategoryFollowErrorstate(message: 'Unable to follow.');
    } catch (e) {
      log('News category follow error.', error: e);
      yield CategoryFollowErrorstate(message: 'Unable to follow.');
    }
  }

  Stream<CategoryFollowUnFollowState> _mapUnFollowEventToState(
    CategoryUnFollowEvent event,
  ) async* {
    if (state is CategoryFollowInProgressState) return;
    yield CategoryFollowInProgressState();
    try {
      final NewsCategoryEntity newsCategoryEntity =
          await _unFollowNewsCategoryUseCase.call(
              UnFollowNewsCategoryUseCaseParams(category: event.category));
      if (newsCategoryEntity != null)
        yield CategoryUnFollowSuccessState(category: newsCategoryEntity);
      else
        yield CategoryFollowErrorstate(message: 'Unable to follow.');
    } catch (e) {
      log('News category unfollow error.', error: e);
      yield CategoryFollowErrorstate(message: 'Unable to unfollow.');
    }
  }
}
