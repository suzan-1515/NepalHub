part of 'forex_timeline_bloc.dart';

abstract class ForexTimelineEvent extends Equatable {
  const ForexTimelineEvent();

  @override
  List<Object> get props => [];
}

class GetForexTimelineEvent extends ForexTimelineEvent {
  final Language language;

  GetForexTimelineEvent({this.language = Language.ENGLISH});

  @override
  List<Object> get props => [language];
}
