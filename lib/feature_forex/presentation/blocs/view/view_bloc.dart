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
  final UseCase _viewNewsFeedUseCase;
  final ForexEntity _forexEntity;

  ViewBloc({
    @required UseCase viewNewsFeedUseCase,
    @required ForexEntity forexEntity,
  })  : _viewNewsFeedUseCase = viewNewsFeedUseCase,
        _forexEntity = forexEntity,
        super(ViewInitial());

  ForexEntity get forexEntity => _forexEntity;

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ViewInProgress) return;
    if (event is View) {
      yield ViewInProgress();
      try {
        await _viewNewsFeedUseCase
            .call(ViewForexUseCaseParams(forexEntity: forexEntity));
        yield ViewSuccess(message: 'Forex viewd successfully.');
      } catch (e) {
        log('Forex view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
