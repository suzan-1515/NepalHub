part of 'nepal_district_bloc.dart';

@immutable
abstract class NepalDistrictEvent {}

class GetDistrictEvent extends NepalDistrictEvent {}

class SearchDistrictEvent extends NepalDistrictEvent {
  final String searchTerm;

  SearchDistrictEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}
