part of 'forex_currency_bloc.dart';

abstract class ForexCurrencyState extends Equatable {
  const ForexCurrencyState();

  @override
  List<Object> get props => [];
}

class ForexCurrencyInitialState extends ForexCurrencyState {}

class ForexCurrencyLoadingState extends ForexCurrencyState {}

class ForexCurrencyLoadSuccessState extends ForexCurrencyState {
  final List<CurrencyEntity> currencies;

  ForexCurrencyLoadSuccessState({@required this.currencies});
  @override
  List<Object> get props => [currencies];
}

class ForexCurrencyEmptyState extends ForexCurrencyState {
  final String message;

  ForexCurrencyEmptyState({this.message});
  @override
  List<Object> get props => [message];
}

class ForexCurrencyLoadErrorState extends ForexCurrencyState {
  final String message;

  ForexCurrencyLoadErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class ForexCurrencyErrorState extends ForexCurrencyState {
  final String message;

  ForexCurrencyErrorState({this.message});
  @override
  List<Object> get props => [message];
}
