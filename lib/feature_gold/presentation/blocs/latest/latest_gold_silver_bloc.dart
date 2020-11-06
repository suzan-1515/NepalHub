import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_gold/presentation/extensions/gold_silver_extensions.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';

part 'latest_gold_silver_event.dart';
part 'latest_gold_silver_state.dart';

class GoldSilverBloc extends Bloc<GoldSilverEvent, GoldSilverState> {
  final UseCase _getLatestGoldSilverUseCase;
  GoldSilverBloc({@required UseCase getLatestGoldSilverUseCase})
      : _getLatestGoldSilverUseCase = getLatestGoldSilverUseCase,
        super(GoldSilverInitialState());

  @override
  Stream<GoldSilverState> mapEventToState(
    GoldSilverEvent event,
  ) async* {
    if (event is GetLatestGoldSilverEvent) {
      yield* mapGetLatestGoldSilverEventToState(event);
    } else if (event is RefreshLatestGoldSilverEvent) {
      yield* mapRefreshLatestGoldSilverEventToState(event);
    }
  }

  Stream<GoldSilverState> mapGetLatestGoldSilverEventToState(
    GetLatestGoldSilverEvent event,
  ) async* {
    if (state is GoldSilverLoadingState) return;
    yield GoldSilverLoadingState();
    try {
      final List<GoldSilverEntity> goldSilverList =
          await _getLatestGoldSilverUseCase.call(
        GetLatestGoldSilverUseCaseParams(
          language: event.language,
        ),
      );

      if (goldSilverList == null || goldSilverList.isEmpty) {
        yield GoldSilverEmptyState(message: 'Gold/Silver data not available.');
      } else {
        GoldSilverEntity defaultGoldSilver = goldSilverList.firstWhere(
          (element) => element.category.code == 'Gold Hallmark',
        );
        if (defaultGoldSilver == null) defaultGoldSilver = goldSilverList.first;
        yield GoldSilverLoadSuccessState(
            goldSilverList: goldSilverList.toUIModel,
            defaultGoldSilver: defaultGoldSilver.toUIModel);
      }
    } catch (e) {
      log('Latest goldSilver load error: ', error: e);
      yield GoldSilverLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.');
    }
  }

  Stream<GoldSilverState> mapRefreshLatestGoldSilverEventToState(
    RefreshLatestGoldSilverEvent event,
  ) async* {
    try {
      final List<GoldSilverEntity> goldSilverList =
          await _getLatestGoldSilverUseCase.call(
        GetLatestGoldSilverUseCaseParams(
          language: event.language,
        ),
      );

      if (goldSilverList != null && goldSilverList.isNotEmpty) {
        var defaultGoldSilver = goldSilverList.firstWhere(
          (element) => element.category.code == 'Gold Hallmark',
        );
        if (defaultGoldSilver == null) defaultGoldSilver = goldSilverList.first;
        yield GoldSilverLoadSuccessState(
            goldSilverList: goldSilverList.toUIModel,
            defaultGoldSilver: defaultGoldSilver.toUIModel);
      } else
        yield GoldSilverErrorState(message: 'Unable to refresh data');
    } catch (e) {
      log('Latest goldSilver refresh error: ', error: e);
      yield GoldSilverErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to Internet.');
    }
  }
}
