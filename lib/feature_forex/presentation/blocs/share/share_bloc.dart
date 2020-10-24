import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/share_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final UseCase _shareForexUseCase;
  final ForexUIModel _forexUIModel;

  ShareBloc({
    @required UseCase shareForexUseCase,
    @required ForexUIModel forexUIModel,
  })  : _shareForexUseCase = shareForexUseCase,
        _forexUIModel = forexUIModel,
        super(ShareInitial());

  ForexUIModel get forexUIModel => _forexUIModel;

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ShareInProgress) return;
    if (event is Share) {
      yield ShareInProgress();
      try {
        final ForexEntity forexEntity = await _shareForexUseCase.call(
            ShareForexUseCaseParams(forexEntity: forexUIModel.forexEntity));
        if (forexEntity != null) forexUIModel.forexEntity = forexEntity;
        yield ShareSuccess(message: 'Forex shared successfully.');
      } catch (e) {
        log('Forex share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
