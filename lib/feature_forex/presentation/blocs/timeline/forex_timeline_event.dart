part of 'forex_timeline_bloc.dart';

abstract class ForexTimelineEvent extends Equatable {
  const ForexTimelineEvent();

  @override
  List<Object> get props => [];
}

class GetForexTimelineEvent extends ForexTimelineEvent {
  final Language language;
  final ForexEntity forex;

  GetForexTimelineEvent(
      {@required this.forex, this.language = Language.ENGLISH});

  @override
  List<Object> get props => [language, forex];
}

class RefreshForexTimelineEvent extends ForexTimelineEvent {
  final Language language;
  final ForexEntity forex;

  RefreshForexTimelineEvent(
      {this.language = Language.ENGLISH, @required this.forex});

  @override
  List<Object> get props => [language, forex];
}
