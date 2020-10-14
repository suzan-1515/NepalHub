part of 'latest_forex_bloc.dart';

abstract class ForexEvent extends Equatable {
  const ForexEvent();

  @override
  List<Object> get props => [];
}

class GetLatestForexEvent extends ForexEvent {
  final Language language;

  GetLatestForexEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class RefreshLatestForexEvent extends ForexEvent {
  final Language language;

  RefreshLatestForexEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}
