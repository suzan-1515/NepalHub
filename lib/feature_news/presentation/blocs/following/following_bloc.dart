import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  FollowingBloc() : super(FollowingInitial());

  @override
  Stream<FollowingState> mapEventToState(
    FollowingEvent event,
  ) async* {}
}
