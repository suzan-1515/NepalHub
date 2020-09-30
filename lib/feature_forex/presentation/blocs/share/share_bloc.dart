import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/share_forex_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final UseCase _shareForexUseCase;
  final ForexEntity _forexEntity;

  ShareBloc({
    @required UseCase shareNewsFeedUseCase,
    @required ForexEntity forexEntity,
  })  : _shareForexUseCase = shareNewsFeedUseCase,
        _forexEntity = forexEntity,
        super(ShareInitial());

  ForexEntity get forexEntity => _forexEntity;

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    final currentState = state;
    if (currentState is ShareInProgress) return;
    if (event is Share) {
      yield ShareInProgress();
      try {
        await _shareForexUseCase
            .call(ShareForexUseCaseParams(forexEntity: forexEntity));
        yield ShareSuccess(message: 'Forex shared successfully.');
      } catch (e) {
        log('Forex share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
