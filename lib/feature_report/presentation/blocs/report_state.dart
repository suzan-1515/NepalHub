part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitialState extends ReportState {}

class ReportInProgressState extends ReportState {}

class ReportSuccessState extends ReportState {
  final ReportUIModel reportUIModel;

  ReportSuccessState({@required this.reportUIModel});
  @override
  List<Object> get props => [reportUIModel];
}

class ReportErrorState extends ReportState {
  final String message;

  ReportErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
