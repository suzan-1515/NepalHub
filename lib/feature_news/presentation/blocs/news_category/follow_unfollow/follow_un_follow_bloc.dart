import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class CategoryFollowUnFollowBloc
    extends Bloc<CategoryFollowUnfollowEvent, CategoryFollowUnFollowState> {
  final UseCase _followNewsCategoryUseCase;
  final UseCase _unFollowNewsCategoryUseCase;

  StreamSubscription _feedEventStreamSubscription;

  CategoryFollowUnFollowBloc(
      {@required UseCase followNewsCategoryUseCase,
      @required UseCase unFollowNewsCategoryUseCase})
      : _followNewsCategoryUseCase = followNewsCategoryUseCase,
        _unFollowNewsCategoryUseCase = unFollowNewsCategoryUseCase,
        super(CategoryFollowInitialState()) {
    this._feedEventStreamSubscription =
        GetIt.I.get<EventBus>().on<NewsChangeEvent>().listen((event) {
      switch (event.eventType) {
        case 'category_follow':
          add(UpdateFollowEvent(category: event.data));
          break;
        case 'category_unfollow':
          add(UpdateUnfollowEvent(category: event.data));
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _feedEventStreamSubscription?.cancel();
    return super.close();
  }

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
    } else if (event is UpdateFollowEvent) {
      yield* _mapUpdateFollowEventToState(event);
    } else if (event is UpdateUnfollowEvent) {
      yield* _mapUpdateUnFollowEventToState(event);
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

  Stream<CategoryFollowUnFollowState> _mapUpdateFollowEventToState(
    UpdateFollowEvent event,
  ) async* {
    try {
      if (event.category.isFollowed) return;
      final category = event.category.copyWith(
          isFollowed: true, followerCount: event.category.followerCount + 1);
      yield CategoryFollowSuccessState(category: category);
    } catch (e) {
      log('Update category follow error: ', error: e);
    }
  }

  Stream<CategoryFollowUnFollowState> _mapUpdateUnFollowEventToState(
    UpdateUnfollowEvent event,
  ) async* {
    try {
      if (!event.category.isFollowed) return;
      final category = event.category.copyWith(
          isFollowed: false, followerCount: event.category.followerCount - 1);
      yield CategoryUnFollowSuccessState(category: category);
    } catch (e) {
      log('Update category unfollow error: ', error: e);
    }
  }
}
