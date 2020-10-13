part of 'forex_currency_bloc.dart';

abstract class ForexCurrencyEvent extends Equatable {
  const ForexCurrencyEvent();

  @override
  List<Object> get props => [];
}

class GetForexCurrencies extends ForexCurrencyEvent {
  final Language language;

  GetForexCurrencies({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}
