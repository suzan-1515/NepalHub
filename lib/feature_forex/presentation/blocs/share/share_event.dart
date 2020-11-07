part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
  @override
  List<Object> get props => [];
}

class Share extends ShareEvent {
  final ForexEntity forex;

  Share({@required this.forex});

  @override
  List<Object> get props => [forex];
}
