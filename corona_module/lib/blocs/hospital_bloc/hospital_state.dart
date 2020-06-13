part of 'hospital_bloc.dart';

@immutable
abstract class HospitalState {}

class InitialHospitalState extends HospitalState {}

class LoadingHospitalState extends HospitalState {}

class LoadedHospitalState extends HospitalState {
  final List<Hospital> hospitals;

  LoadedHospitalState({
    @required this.hospitals,
  }) : assert(hospitals != null);
}

class ErrorHospitalState extends HospitalState {
  final String message;

  ErrorHospitalState({
    @required this.message,
  }) : assert(message != null);
}
