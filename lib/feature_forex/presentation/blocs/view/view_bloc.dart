import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/view_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';

part 'view_event.dart';
part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final UseCase _viewForexUseCase;
  final ForexUIModel _forexUIModel;

  ViewBloc({
    @required UseCase viewForexUseCase,
    @required ForexUIModel forexUIModel,
  })  : _viewForexUseCase = viewForexUseCase,
        _forexUIModel = forexUIModel,
        super(ViewInitial());

  ForexUIModel get forexUIModel => _forexUIModel;

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ViewInProgress) return;
    if (event is View) {
      yield ViewInProgress();
      try {
        final ForexEntity forexEntity = await _viewForexUseCase.call(
            ViewForexUseCaseParams(forexEntity: forexUIModel.forexEntity));
        if (forexEntity != null) forexUIModel.forexEntity = forexEntity;
        yield ViewSuccess(message: 'Forex viewd successfully.');
      } catch (e) {
        log('Forex view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
