part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
}

class Share extends ShareEvent {
  final NewsFeedUIModel feedModel;

  Share({@required this.feedModel});

  @override
  List<Object> get props => [feedModel.feed];
}
