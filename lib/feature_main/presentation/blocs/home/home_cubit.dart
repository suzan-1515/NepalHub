import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/extensions/home_extensions.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeFeedUseCase _getHomeFeedUseCase;
  HomeCubit({@required GetHomeFeedUseCase getHomeFeedUseCase})
      : _getHomeFeedUseCase = getHomeFeedUseCase,
        super(HomeInitialState());

  getHomeFeed({Language language = Language.NEPALI}) async {
    if (state is HomeLoadingState) return;
    emit(HomeLoadingState());
    try {
      final homeEntity = await _getHomeFeedUseCase
          .call(GetHomeFeedUseCaseParams(language: language));
      if (homeEntity == null) {
        emit(HomeEmptyState(message: 'Data not available.'));
      } else {
        emit(HomeLoadSuccessState(homeModel: homeEntity.toUIModel));
      }
    } catch (e) {
      log('Home feed load error: ', error: e);
      emit(HomeLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.'));
    }
  }

  refreshHomeFeed({Language language = Language.NEPALI}) async {
    if (state is HomeLoadingState) return;
    try {
      final homeEntity = await _getHomeFeedUseCase
          .call(GetHomeFeedUseCaseParams(language: language));
      if (homeEntity != null) {
        emit(HomeLoadSuccessState(homeModel: homeEntity.toUIModel));
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
}
