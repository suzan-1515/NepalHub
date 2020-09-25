import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';

part 'news_category_event.dart';
part 'news_category_state.dart';

class NewsCategoryBloc extends Bloc<NewsCategoryEvent, NewsCategoryState> {
  final UseCase _getNewsCategoriesUseCase;
  final UseCase _getNewsFollowedCategoriesUseCase;

  NewsCategoryBloc(
      {@required getNewsCategoriesUseCase,
      @required getNewsFollowedCategoriesUseCase})
      : _getNewsCategoriesUseCase = getNewsCategoriesUseCase,
        _getNewsFollowedCategoriesUseCase = getNewsFollowedCategoriesUseCase,
        super(Initial());

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
    }
  }

  Stream<NewsCategoryState> _mapRefreshCategoriesEventToState(
      RefreshCategories event) async* {
    try {
      final List<NewsCategoryEntity> newsList = await _getNewsCategoriesUseCase
          .call(GetNewsCategoriesUseCaseParams(language: event.language));
      if (newsList != null || newsList.isNotEmpty)
        yield LoadSuccess(newsList.toUIModels);
    } catch (e) {
      log('News categories load error.', error: e);
    }
  }

  Stream<NewsCategoryState> _mapGetCategoriesEventToState(
      GetCategories event) async* {
    if (state is Loading) return;
    yield Loading();
    try {
      final List<NewsCategoryEntity> newsList = await _getNewsCategoriesUseCase
          .call(GetNewsCategoriesUseCaseParams(language: event.language));
      if (newsList == null || newsList.isEmpty)
        yield Empty(message: 'News categories not available.');
      else
        yield LoadSuccess(newsList.toUIModels);
    } catch (e) {
      log('News categories load error.', error: e);
      yield Error(
          message:
              'Unable to load categories. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsCategoryState> _mapGetFollowedCategoriesEventToState(
      GetFollowedCategories event) async* {
    if (state is Loading) return;
    yield Loading();
    try {
      final List<NewsCategoryEntity> categoryList =
          await _getNewsCategoriesUseCase
              .call(GetNewsCategoriesUseCaseParams(language: event.language));
      if (categoryList == null || categoryList.isEmpty)
        yield Empty(message: 'News categories not available.');
      else {
        List<NewsCategoryEntity> followedCategories =
            categoryList.where((e) => e.isFollowed).toList();
        if (followedCategories == null || followedCategories.isEmpty) {
          yield Empty(message: 'You have not followed any categories yet.');
        } else
          yield LoadSuccess(followedCategories.toUIModels);
      }
    } catch (e) {
      log('News followed categories load error.', error: e);
      yield Error(
          message:
              'Unable to load categories. Make sure you are connect to Internet.');
    }
  }
}
