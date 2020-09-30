part of 'latest_forex_bloc.dart';

abstract class ForexEvent extends Equatable {
  const ForexEvent();

  @override
  List<Object> get props => [];
}

class GetLatestForexEvent extends ForexEvent {
  final Language language;
  final String defaultCurrencyId;

  GetLatestForexEvent(
      {@required this.defaultCurrencyId, this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language, defaultCurrencyId];
}

class RefreshLatestForexEvent extends ForexEvent {
  final Language language;
  final String defaultCurrencyId;

  RefreshLatestForexEvent(
      {@required this.defaultCurrencyId, this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language, defaultCurrencyId];
}
