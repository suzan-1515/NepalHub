part of 'country_detail_bloc.dart';

@immutable
abstract class CountryDetailState {}

class InitialCountryDetailState extends CountryDetailState {}

class LoadingCountryDetailState extends CountryDetailState {}

class LoadedCountryDetailState extends CountryDetailState {
  final Country country;

  LoadedCountryDetailState({
    @required this.country,
  }) : assert(country != null);
}

class ErrorCountryDetailState extends CountryDetailState {
  final String message;

  ErrorCountryDetailState({
    @required this.message,
  }) : assert(message != null);
}
