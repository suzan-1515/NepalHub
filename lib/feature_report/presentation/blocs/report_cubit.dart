import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_entity.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/domain/usecases/post_report_use_case.dart';
import 'package:samachar_hub/feature_report/presentation/models/report_model.dart';
import 'package:samachar_hub/feature_report/presentation/extensions/report_extensions.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final UseCase _postReportUseCase;

  ReportCubit({@required UseCase postReportUseCase})
      : _postReportUseCase = postReportUseCase,
        super(ReportInitialState());

  Future report(
      {@required String threadId,
      @required ReportThreadType threadType,
      String description,
      @required String tag}) async {
    if (state is ReportInProgressState) return;
    try {
      final ReportEntity reportEntity =
          await _postReportUseCase.call(PostReportUseCaseParams(
        threadId: threadId,
        threadType: threadType,
        description: description,
        tag: tag,
      ));
      if (reportEntity != null) {
        emit(ReportSuccessState(reportUIModel: reportEntity.toUIModel));
      } else
        emit(ReportSuccessState(reportUIModel: null));
    } catch (e) {
      log('Report post error: ', error: e);
      emit(ReportErrorState(
          message:
              'Unable to report. Make sure you are connected to the Internet.'));
    }
  }
}
