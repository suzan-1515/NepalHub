part of 'latest_forex_bloc.dart';

abstract class ForexEvent extends Equatable {
  const ForexEvent();

  @override
  List<Object> get props => [];
}

class GetLatestForexEvent extends ForexEvent {
  final Language language;
  final String defaultCurrencyCode;

  GetLatestForexEvent(
      {this.language = Language.ENGLISH, @required this.defaultCurrencyCode});
  @override
  List<Object> get props => [language, defaultCurrencyCode];
}

class RefreshLatestForexEvent extends ForexEvent {
  final Language language;
  final String defaultCurrencyCode;

  RefreshLatestForexEvent(
      {this.language = Language.ENGLISH, @required this.defaultCurrencyCode});
  @override
  List<Object> get props => [language, defaultCurrencyCode];
}
