import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';

part 'view_event.dart';
part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final UseCase _viewGoldSilverUseCase;

  ViewBloc({
    @required UseCase viewGoldSilverUseCase,
  })  : _viewGoldSilverUseCase = viewGoldSilverUseCase,
        super(ViewInitial());

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ViewInProgress) return;
    if (event is View) {
      yield ViewInProgress();
      try {
        final GoldSilverEntity goldSilverEntity =
            await _viewGoldSilverUseCase.call(ViewGoldSilverUseCaseParams(
                goldSilverEntity: event.goldSilver));
        if (goldSilverEntity != null)
          yield ViewSuccess(goldSilver: goldSilverEntity);
        else
          yield ViewError(message: 'Unable to view.');
      } catch (e) {
        log('GoldSilver view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
