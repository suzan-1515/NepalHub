import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';

part 'news_category_event.dart';
part 'news_category_state.dart';

class NewsCategoryBloc extends Bloc<NewsCategoryEvent, NewsCategoryState> {
  final UseCase _getNewsCategoriesUseCase;
  final UseCase _getNewsFollowedCategoriesUseCase;
  final CategoryFollowUnFollowBloc _followUnFollowBloc;

  StreamSubscription _followStreamSubscription;

  NewsCategoryBloc({
    @required UseCase getNewsCategoriesUseCase,
    @required UseCase getNewsFollowedCategoriesUseCase,
    @required CategoryFollowUnFollowBloc followUnFollowBloc,
  })  : _getNewsCategoriesUseCase = getNewsCategoriesUseCase,
        _getNewsFollowedCategoriesUseCase = getNewsFollowedCategoriesUseCase,
        _followUnFollowBloc = followUnFollowBloc,
        super(NewsCategoryInitialState()) {
    this._followStreamSubscription = _followUnFollowBloc.listen((followState) {
      if (followState is CategoryFollowSuccessState) {
        add(UpdateCategoryChangeEvent(
            category: followState.category, eventType: 'follow'));
      } else if (followState is CategoryUnFollowSuccessState) {
        add(UpdateCategoryChangeEvent(
            category: followState.category, eventType: 'unfollow'));
      }
    });
  }

  @override
  Future<void> close() {
    _followStreamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<NewsCategoryState> mapEventToState(
    NewsCategoryEvent event,
  ) async* {
    if (event is GetCategories) {
      yield* _mapGetCategoriesEventToState(event);
    } else if (event is GetFollowedCategories) {
      yield* _mapGetFollowedCategoriesEventToState(event);
    } else if (event is RefreshCategories) {
      yield* _mapRefreshCategoriesEventToState(event);
    } else if (event is UpdateCategoryChangeEvent) {
      yield* _mapUpdateFollowEventToState(event);
    }
  }

  Stream<NewsCategoryState> _mapRefreshCategoriesEventToState(
      RefreshCategories event) async* {
    yield NewsCategoryRefreshingState();
    try {
      final List<NewsCategoryEntity> newsList = await _getNewsCategoriesUseCase
          .call(GetNewsCategoriesUseCaseParams(language: event.language));
      if (newsList != null || newsList.isNotEmpty)
        yield NewsCategoryLoadSuccessState(newsList);
      else
        yield NewsCategoryErrorState(message: 'Unable to refresh data.');
    } catch (e) {
      log('News categories load error.', error: e);
      yield NewsCategoryErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to Internet.');
    }
  }

  Stream<NewsCategoryState> _mapGetCategoriesEventToState(
      GetCategories event) async* {
    if (state is NewsCategoryLoadingState) return;
    yield NewsCategoryLoadingState();
    try {
      final List<NewsCategoryEntity> newsList = await _getNewsCategoriesUseCase
          .call(GetNewsCategoriesUseCaseParams(language: event.language));
      if (newsList == null || newsList.isEmpty)
        yield NewsCategoryLoadEmptyState(
            message: 'News categories not available.');
      else
        yield NewsCategoryLoadSuccessState(newsList);
    } catch (e) {
      log('News categories load error.', error: e);
      yield NewsCategoryLoadErrorState(
          message:
              'Unable to load categories. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsCategoryState> _mapGetFollowedCategoriesEventToState(
      GetFollowedCategories event) async* {
    if (state is NewsCategoryLoadingState) return;
    yield NewsCategoryLoadingState();
    try {
      final List<NewsCategoryEntity> categoryList =
          await _getNewsCategoriesUseCase
              .call(GetNewsCategoriesUseCaseParams(language: event.language));
      if (categoryList == null || categoryList.isEmpty)
        yield NewsCategoryLoadEmptyState(
            message: 'News categories not available.');
      else {
        List<NewsCategoryEntity> followedCategories =
            categoryList.where((e) => e.isFollowed).toList();
        if (followedCategories == null || followedCategories.isEmpty) {
          yield NewsCategoryLoadEmptyState(
              message: 'You have not followed any categories yet.');
        } else
          yield NewsCategoryLoadSuccessState(followedCategories);
      }
    } catch (e) {
      log('News followed categories load error.', error: e);
      yield NewsCategoryLoadErrorState(
          message:
              'Unable to load categories. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsCategoryState> _mapUpdateFollowEventToState(
      UpdateCategoryChangeEvent event) async* {
    try {
      final currentState = state;
      if (currentState is NewsCategoryLoadSuccessState) {
        final index = currentState.categories
            .indexWhere((element) => element.id == event.category.id);
        if (index != -1) {
          var categories =
              List<NewsCategoryEntity>.from(currentState.categories);
          categories[index] = event.category;
          yield NewsCategoryLoadSuccessState(categories);
        }
      }
    } catch (e) {
      log('Update category ${event.eventType} event error: ', error: e);
    }
  }
}
