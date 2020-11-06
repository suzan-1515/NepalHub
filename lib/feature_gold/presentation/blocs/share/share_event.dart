part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
  @override
  List<Object> get props => [];
}

class Share extends ShareEvent {
  final GoldSilverEntity goldSilver;

  Share({@required this.goldSilver});
  @override
  List<Object> get props => [goldSilver];
}
