part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {}

class GetCountryEvent extends CountryEvent {}

class SearchCountryEvent extends CountryEvent {
  final String searchTerm;

  SearchCountryEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}

class FilterCountryEvent extends CountryEvent {
  final CountryFilterType filterType;

  FilterCountryEvent({
    @required this.filterType,
  }) : assert(filterType != null);
}
