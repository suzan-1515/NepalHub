import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/view_news_use_case.dart';

part 'view_event.dart';
part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final UseCase _viewNewsFeedUseCase;
  final NewsFeedEntity _feed;

  ViewBloc({
    @required UseCase viewNewsFeedUseCase,
    @required NewsFeedEntity feed,
  })  : _viewNewsFeedUseCase = viewNewsFeedUseCase,
        _feed = feed,
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
        final NewsFeedEntity newsFeedEntity =
            await _viewNewsFeedUseCase.call(ViewNewsUseCaseParams(feed: _feed));
        if (newsFeedEntity != null) yield ViewSuccess(feed: newsFeedEntity);
      } catch (e) {
        log('News feed view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
