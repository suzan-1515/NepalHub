part of 'hospital_bloc.dart';

@immutable
abstract class HospitalEvent {}

class GetHospitalEvent extends HospitalEvent {}

class SearchHospitalEvent extends HospitalEvent {
  final String searchTerm;

  SearchHospitalEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}
