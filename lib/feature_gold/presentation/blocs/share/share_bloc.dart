import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final UseCase _shareGoldSilverUseCase;

  ShareBloc({
    @required UseCase shareGoldSilverUseCase,
  })  : _shareGoldSilverUseCase = shareGoldSilverUseCase,
        super(ShareInitial());

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ShareInProgress) return;
    if (event is Share) {
      yield ShareInProgress();
      try {
        final GoldSilverEntity goldSilverEntity =
            await _shareGoldSilverUseCase.call(ShareGoldSilverUseCaseParams(
                goldSilverEntity: event.goldSilver));
        if (goldSilverEntity != null)
          yield ShareSuccess(goldSilver: goldSilverEntity);
        else
          yield ShareError(message: 'Unable to share.');
      } catch (e) {
        log('GoldSilver share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
