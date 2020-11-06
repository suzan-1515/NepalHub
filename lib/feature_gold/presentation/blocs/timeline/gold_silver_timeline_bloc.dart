import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';

part 'gold_silver_timeline_event.dart';
part 'gold_silver_timeline_state.dart';

class GoldSilverTimelineBloc
    extends Bloc<GoldSilverTimelineEvent, GoldSilverTimelineState> {
  final UseCase _getGoldSilverTimelineUseCase;
  GoldSilverTimelineBloc({
    @required UseCase getGoldSilverTimelineUseCase,
  })  : _getGoldSilverTimelineUseCase = getGoldSilverTimelineUseCase,
        super(GoldSilverTimelineInitialState());

  @override
  Stream<GoldSilverTimelineState> mapEventToState(
    GoldSilverTimelineEvent event,
  ) async* {
    if (event is GetGoldSilverTimelineEvent) {
      yield* _mapGetTimelineEventEventToState(event);
    } else if (event is RefreshGoldSilverTimelineEvent) {
      yield* _mapRefreshTimelineEventEventToState(event);
    }
  }

  Stream<GoldSilverTimelineState> _mapGetTimelineEventEventToState(
    GetGoldSilverTimelineEvent event,
  ) async* {
    if (state is GoldSilverTimeLineLoadingState) return;
    yield GoldSilverTimeLineLoadingState();
    try {
      final List<GoldSilverEntity> goldSilverList =
          await _getGoldSilverTimelineUseCase.call(
        GetGoldSilverTimelineUseCaseParams(
            language: event.language,
            categoryId: event.goldSilver.category.id,
            unit: event.goldSilver.unit,
            numOfDays: 60),
      );
      if (goldSilverList == null || goldSilverList.isEmpty) {
        yield GoldSilverTimelineEmptyState(
            message: 'Gold/Silver data not available.');
      } else {
        yield GoldSilverTimelineLoadSuccessState(
            goldSilverList: goldSilverList.reversed.toList());
      }
    } catch (e) {
      log('GoldSilver (${event.goldSilver.category.title}) timeline load error: ',
          error: e);
      yield GoldSilverTimelineLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.');
    }
  }

  Stream<GoldSilverTimelineState> _mapRefreshTimelineEventEventToState(
    RefreshGoldSilverTimelineEvent event,
  ) async* {
    if (state is GoldSilverTimeLineLoadingState) return;
    try {
      final List<GoldSilverEntity> goldSilverList =
          await _getGoldSilverTimelineUseCase.call(
        GetGoldSilverTimelineUseCaseParams(
            language: event.language,
            categoryId: event.goldSilver.category.id,
            unit: event.goldSilver.unit,
            numOfDays: 60),
      );
      if (goldSilverList != null && goldSilverList.isNotEmpty) {
        yield GoldSilverTimelineLoadSuccessState(
            goldSilverList: goldSilverList.reversed.toList());
      } else
        yield GoldSilverTimelineErrorState(message: 'Unable to refresh data.');
    } catch (e) {
      log('GoldSilver (${event.goldSilver.category.title}) timeline load error: ',
          error: e);
      yield GoldSilverTimelineErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.');
    }
  }
}
