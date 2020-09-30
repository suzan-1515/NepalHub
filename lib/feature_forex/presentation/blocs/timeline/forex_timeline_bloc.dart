import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/get_forex_timeline_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/extensions/forex_extensions.dart';

part 'forex_timeline_event.dart';
part 'forex_timeline_state.dart';

class ForexTimelineBloc extends Bloc<ForexTimelineEvent, ForexTimelineState> {
  final UseCase _getForexTimelineUseCase;
  final String _currencyId;
  ForexTimelineBloc(
      {@required UseCase getForexTimelineUseCase, @required String currencyId})
      : _getForexTimelineUseCase = getForexTimelineUseCase,
        _currencyId = currencyId,
        super(ForexTimelineInitialState());

  String get currencyId => _currencyId;

  @override
  Stream<ForexTimelineState> mapEventToState(
    ForexTimelineEvent event,
  ) async* {
    if (state is ForexTimeLineLoadingState) return;
    if (event is GetForexTimelineEvent) {
      yield ForexTimeLineLoadingState();
      try {
        final List<ForexEntity> forexList = await _getForexTimelineUseCase.call(
          GetForexTimelineUseCaseParams(
              language: event.language, currencyId: currencyId, numOfDays: 30),
        );
        if (forexList == null || forexList.isEmpty) {
          yield ForexTimelineEmptyState(message: 'Forex data not available.');
        } else {
          yield ForexTimelineLoadSuccessState(forexList: forexList.toUIModels);
        }
      } catch (e) {
        log('Forex ($currencyId) timeline load error: ', error: e);
        yield ForexTimelineLoadErrorState(
            message:
                'Unable to load data. Make sure you are connected to Internet.');
      }
    }
  }
}
