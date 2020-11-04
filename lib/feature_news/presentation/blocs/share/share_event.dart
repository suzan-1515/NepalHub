part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
  @override
  List<Object> get props => [];
}

class Share extends ShareEvent {
  final NewsFeedEntity feed;

  Share({@required this.feed});

  @override
  List<Object> get props => [feed];
}
