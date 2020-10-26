import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class FollowUnFollowBloc
    extends Bloc<FollowUnFollowEvent, FollowUnFollowState> {
  final UseCase _followNewsSourceUseCase;
  final UseCase _unFollowNewsSourceUseCase;
  final NewsSourceUIModel _newsSourceUIModel;

  FollowUnFollowBloc(
      {@required UseCase followNewsSourceUseCase,
      @required UseCase unFollowNewsSourceUseCase,
      @required NewsSourceUIModel newsSourceUIModel})
      : _followNewsSourceUseCase = followNewsSourceUseCase,
        _unFollowNewsSourceUseCase = unFollowNewsSourceUseCase,
        _newsSourceUIModel = newsSourceUIModel,
        super(FollowUnFollowInitialState());

  NewsSourceUIModel get newsSourceUIModel => _newsSourceUIModel;

  @override
  Stream<FollowUnFollowState> mapEventToState(
    FollowUnFollowEvent event,
  ) async* {
    final currentState = state;
    if (event is FollowUnFollowFollowEvent &&
        !(currentState is FollowUnFollowInProgressState)) {
      yield FollowUnFollowInProgressState();
      try {
        final NewsSourceEntity newsSourceEntity =
            await _followNewsSourceUseCase.call(FollowNewsSourceUseCaseParams(
                source: newsSourceUIModel.source));
        if (newsSourceEntity != null)
          newsSourceUIModel.source = newsSourceUIModel.source.copyWith(
              isFollowed: newsSourceEntity.isFollowed,
              followerCount: newsSourceEntity.followerCount);
        yield FollowUnFollowFollowedState(
            message: 'Source followed successfully.');
      } catch (e) {
        log('News source follow load error.', error: e);
        yield FollowUnFollowErrorState(message: 'Unable to follow.');
      }
    } else if (event is FollowUnFollowUnFollowEvent &&
        !(currentState is FollowUnFollowInProgressState)) {
      yield FollowUnFollowInProgressState();
      try {
        final NewsSourceEntity newsSourceEntity =
            await _unFollowNewsSourceUseCase.call(
                UnFollowNewsSourceUseCaseParams(
                    source: newsSourceUIModel.source));
        if (newsSourceEntity != null)
          newsSourceUIModel.source = newsSourceUIModel.source.copyWith(
              isFollowed: newsSourceEntity.isFollowed,
              followerCount: newsSourceEntity.followerCount);
        yield FollowUnFollowUnFollowedState(
            message: 'Source unFollowed successfully.');
      } catch (e) {
        log('News categories load error.', error: e);
        yield FollowUnFollowErrorState(message: 'Unable to unfollow.');
      }
    }
  }
}
