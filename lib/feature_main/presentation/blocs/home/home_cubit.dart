import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_type.dart';
import 'package:samachar_hub/feature_main/presentation/extensions/home_extensions.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeFeedUseCase _getHomeFeedUseCase;
  HomeCubit({@required GetHomeFeedUseCase getHomeFeedUseCase})
      : _getHomeFeedUseCase = getHomeFeedUseCase,
        super(HomeInitialState());

  getHomeFeed(
      {Language language = Language.NEPALI,
      String defaultForexCurrencyCode}) async {
    if (state is HomeLoadingState) return;
    emit(HomeLoadingState());
    try {
      final homeEntity = await _getHomeFeedUseCase.call(
          GetHomeFeedUseCaseParams(
              language: language,
              defaultForexCurrencyCode: defaultForexCurrencyCode));
      if (homeEntity == null) {
        emit(HomeEmptyState(message: 'Data not available.'));
      } else {
        emit(HomeLoadSuccessState(home: homeEntity.toUIModel));
      }
    } catch (e) {
      log('Home feed load error: ', error: e);
      emit(HomeLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.'));
    }
  }

  refreshHomeFeed(
      {Language language = Language.NEPALI,
      String defaultForexCurrencyCode = 'USD'}) async {
    if (state is HomeLoadingState) return;
    try {
      final homeEntity = await _getHomeFeedUseCase.call(
          GetHomeFeedUseCaseParams(
              language: language,
              defaultForexCurrencyCode: defaultForexCurrencyCode));
      if (homeEntity != null) {
        emit(HomeLoadSuccessState(home: homeEntity.toUIModel));
      } else {
        emit(HomeErrorState(message: 'Unable to refresh data.'));
      }
    } catch (e) {
      log('Home feed load error: ', error: e);
      emit(HomeErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.'));
    }
  }

  // dataChangeEvent({@required data, eventType}) {
  //   try {
  //     final currentState = state;
  //     if (currentState is HomeLoadSuccessState) {
  //       if (eventType == 'feed') {
  //         final feed = (data as NewsFeedEntity);
  //         if (feed.type == NewsType.LATEST) {
  //           final index = currentState.home.latestNews
  //               .indexWhere((element) => element.id == feed.id);
  //           if (index != -1) {
  //             final feeds =
  //                 List<NewsFeedEntity>.from(currentState.home.latestNews);
  //             feeds[index] = feed;
  //             emit(HomeLoadSuccessState(
  //                 home: currentState.home.copyWith(latestNews: feeds)));
  //           }
  //         } else if (feed.type == NewsType.TRENDING) {
  //           final index = currentState.home.trendingNews
  //               .indexWhere((element) => element.id == feed.id);
  //           if (index != -1) {
  //             final feeds =
  //                 List<NewsFeedEntity>.from(currentState.home.trendingNews);
  //             feeds[index] = feed;
  //             emit(HomeLoadSuccessState(
  //                 home: currentState.home.copyWith(trendingNews: feeds)));
  //           }
  //         }
  //       } else if (eventType == 'source') {
  //         final source = (data as NewsSourceEntity);
  //         final feeds = currentState.home.latestNews.map<NewsFeedEntity>((e) {
  //           if (e.source.id == source.id) {
  //             return e.copyWith(source: source);
  //           }
  //           return e;
  //         }).toList();

  //         emit(HomeLoadSuccessState(
  //             home: currentState.home.copyWith(latestNews: feeds)));
  //       }
  //     }
  //   } catch (e) {
  //     log('Update change event of $eventType error: ', error: e);
  //   }
  // }
}
