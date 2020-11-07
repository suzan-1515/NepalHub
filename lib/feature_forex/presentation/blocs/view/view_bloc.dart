import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/view_forex_use_case.dart';

part 'view_event.dart';
part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final UseCase _viewForexUseCase;

  ViewBloc({
    @required UseCase viewForexUseCase,
  })  : _viewForexUseCase = viewForexUseCase,
        super(ViewInitial());

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    if (state is ViewInProgress) return;
    if (event is View) {
      yield ViewInProgress();
      try {
        final ForexEntity forexEntity = await _viewForexUseCase
            .call(ViewForexUseCaseParams(forexEntity: event.forex));
        if (forexEntity != null)
          yield ViewSuccess(forex: forexEntity);
        else
          yield ViewError(message: 'Unable to view.');
      } catch (e) {
        log('Forex view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
