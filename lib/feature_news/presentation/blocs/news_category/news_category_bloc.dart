import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';

part 'news_category_event.dart';
part 'news_category_state.dart';

class NewsCategoryBloc extends Bloc<NewsCategoryEvent, NewsCategoryState> {
  final UseCase _getNewsCategoriesUseCase;
  final UseCase _getNewsFollowedCategoriesUseCase;

  NewsCategoryBloc({
    @required UseCase getNewsCategoriesUseCase,
    @required UseCase getNewsFollowedCategoriesUseCase,
  })  : _getNewsCategoriesUseCase = getNewsCategoriesUseCase,
        _getNewsFollowedCategoriesUseCase = getNewsFollowedCategoriesUseCase,
        super(NewsCategoryInitialState());

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
        yield NewsCategoryLoadSuccessState(newsList.toUIModels);
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
        yield NewsCategoryLoadSuccessState(newsList.toUIModels);
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
          yield NewsCategoryLoadSuccessState(followedCategories.toUIModels);
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
            .indexWhere((element) => element.entity.id == event.category.id);
        if (index != -1) {
          var categories =
              List<NewsCategoryEntity>.from(currentState.categories);
          categories[index] = event.category;
          yield NewsCategoryLoadSuccessState(categories.toUIModels);
        }
      }
    } catch (e) {
      log('Update category ${event.eventType} event error: ', error: e);
    }
  }
}
