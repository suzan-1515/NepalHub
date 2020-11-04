part of 'share_bloc.dart';

abstract class ShareState extends Equatable {
  const ShareState();
}

class ShareInitial extends ShareState {
  @override
  List<Object> get props => [];
}

class ShareInProgress extends ShareState {
  @override
  List<Object> get props => [];
}

class ShareSuccess extends ShareState {
  final NewsFeedEntity feed;

  ShareSuccess({this.feed});

  @override
  List<Object> get props => [feed];
}

class ShareError extends ShareState {
  final String message;

  ShareError({this.message});

  @override
  List<Object> get props => [message];
}
