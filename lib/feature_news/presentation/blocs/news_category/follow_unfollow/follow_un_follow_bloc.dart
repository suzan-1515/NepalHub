import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class FollowUnFollowBloc
    extends Bloc<FollowUnFollowEvent, FollowUnFollowState> {
  final UseCase _followNewsCategoryUseCase;
  final UseCase _unFollowNewsCategoryUseCase;
  final NewsCategoryUIModel _newsCategoryUIModel;

  FollowUnFollowBloc(
      {@required UseCase followNewsCategoryUseCase,
      @required UseCase unFollowNewsCategoryUseCase,
      @required NewsCategoryUIModel newsCategoryUIModel})
      : _followNewsCategoryUseCase = followNewsCategoryUseCase,
        _unFollowNewsCategoryUseCase = unFollowNewsCategoryUseCase,
        _newsCategoryUIModel = newsCategoryUIModel,
        super(FollowUnFollowInitialState());

  NewsCategoryUIModel get newsCategoryUIModel => _newsCategoryUIModel;

  @override
  Stream<FollowUnFollowState> mapEventToState(
    FollowUnFollowEvent event,
  ) async* {
    if (state is FollowUnFollowInProgressState) return;
    if (event is FollowUnFollowFollowEvent) {
      yield FollowUnFollowInProgressState();
      try {
        final NewsCategoryEntity newsCategoryEntity =
            await _followNewsCategoryUseCase.call(
                FollowNewsCategoryUseCaseParams(
                    category: newsCategoryUIModel.category));
        if (newsCategoryEntity != null)
          newsCategoryUIModel.category = newsCategoryUIModel.category.copyWith(
              isFollowed: newsCategoryEntity.isFollowed,
              followerCount: newsCategoryEntity.followerCount);
        yield FollowUnFollowFollowedState(
            message: 'Category followed successfully.');
      } catch (e) {
        log('News category follow load error.', error: e);
        yield FollowUnFollowErrorstate(message: 'Unable to follow.');
      }
    } else if (event is FollowUnFollowUnFollowEvent) {
      yield FollowUnFollowInProgressState();
      try {
        final NewsCategoryEntity newsCategoryEntity =
            await _unFollowNewsCategoryUseCase.call(
                UnFollowNewsCategoryUseCaseParams(
                    category: newsCategoryUIModel.category));
        if (newsCategoryEntity != null)
          newsCategoryUIModel.category = newsCategoryUIModel.category.copyWith(
              isFollowed: newsCategoryEntity.isFollowed,
              followerCount: newsCategoryEntity.followerCount);
        yield FollowUnFollowUnFollowedState(
            message: 'Category unFollowed successfully.');
      } catch (e) {
        log('News categories load unknown error.', error: e);
        yield FollowUnFollowErrorstate(message: 'Unable to unfollow.');
      }
    }
  }
}
