import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_entity.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/domain/repositories/repository.dart';

class PostReportUseCase
    implements UseCase<ReportEntity, PostReportUseCaseParams> {
  final Repository _repository;

  PostReportUseCase(this._repository);

  @override
  Future<ReportEntity> call(PostReportUseCaseParams params) {
    try {
      return this._repository.reportPost(
          tag: params.tag,
          threadId: params.threadId,
          threadType: params.threadType);
    } catch (e) {
      log('PostReportUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class PostReportUseCaseParams extends Equatable {
  final String threadId;
  final ReportThreadType threadType;
  final String description;
  final String tag;

  PostReportUseCaseParams({
    @required this.threadId,
    @required this.threadType,
    @required this.description,
    @required this.tag,
  });

  @override
  List<Object> get props => [threadId, threadType, description, tag];
}
