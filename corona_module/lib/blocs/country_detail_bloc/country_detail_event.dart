part of 'country_detail_bloc.dart';

@immutable
abstract class CountryDetailEvent {}

class GetCountryDetailEvent extends CountryDetailEvent {
  final Country country;

  GetCountryDetailEvent({
    @required this.country,
  }) : assert(country != null);
}
