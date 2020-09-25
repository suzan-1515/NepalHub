import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/exceptions/app_exceptions.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class FollowUnFollowBloc
    extends Bloc<FollowUnFollowEvent, FollowUnFollowState> {
  final UseCase _followNewsCategoryUseCase;
  final UseCase _unFollowNewsCategoryUseCase;

  FollowUnFollowBloc({
    @required UseCase followNewsCategoryUseCase,
    @required UseCase unFollowNewsCategoryUseCase,
  })  : _followNewsCategoryUseCase = followNewsCategoryUseCase,
        _unFollowNewsCategoryUseCase = unFollowNewsCategoryUseCase,
        super(Initial());

  @override
  Stream<FollowUnFollowState> mapEventToState(
    FollowUnFollowEvent event,
  ) async* {
    if (state is InProgress) return;
    if (event is Follow) {
      yield InProgress();
      try {
        await _followNewsCategoryUseCase.call(FollowNewsCategoryUseCaseParams(
            category: event.categoryModel.category));
        yield Followed(message: 'Category followed successfully.');
      } catch (e) {
        log('News category follow load error.', error: e);
        yield Error(message: 'Unable to follow.');
      }
    } else if (event is UnFollow) {
      yield InProgress();
      try {
        await _unFollowNewsCategoryUseCase.call(
            UnFollowNewsCategoryUseCaseParams(
                category: event.categoryModel.category));
        yield UnFollowed(message: 'Category unFollowed successfully.');
      } catch (e) {
        log('News categories load unknown error.', error: e);
        yield Error(message: 'Unable to unfollow.');
      }
    }
  }
}
