import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/share_news_use_case.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final UseCase _shareNewsFeedUseCase;

  ShareBloc({
    @required UseCase shareNewsFeedUseCase,
  })  : _shareNewsFeedUseCase = shareNewsFeedUseCase,
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
        final NewsFeedEntity newsFeedEntity = await _shareNewsFeedUseCase
            .call(ShareNewsUseCaseParams(feed: event.feed));
        if (newsFeedEntity != null)
          yield ShareSuccess(feed: newsFeedEntity);
        else
          yield ShareError(message: 'Unable to share.');
      } catch (e) {
        log('News feed share error.', error: e);
        yield ShareError(message: 'Unable to share.');
      }
    }
  }
}
