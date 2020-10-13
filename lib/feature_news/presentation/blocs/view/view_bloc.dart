import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/view_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'view_event.dart';
part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final UseCase _viewNewsFeedUseCase;
  final NewsFeedUIModel _feedUIModel;

  ViewBloc({
    @required UseCase viewNewsFeedUseCase,
    @required NewsFeedUIModel feedUIModel,
  })  : _viewNewsFeedUseCase = viewNewsFeedUseCase,
        _feedUIModel = feedUIModel,
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
        await _viewNewsFeedUseCase
            .call(ViewNewsUseCaseParams(feed: _feedUIModel.feed));
        yield ViewSuccess(message: 'Feed viewd successfully.');
      } catch (e) {
        log('News feed view error.', error: e);
        yield ViewError(message: 'Unable to view.');
      }
    }
  }
}
