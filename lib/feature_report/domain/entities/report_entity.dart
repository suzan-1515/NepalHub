import 'package:equatable/equatable.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';

class ReportEntity extends Equatable {
  final String id;
  final String threadId;
  final ReportThreadType threadType;
  final String description;
  final String tag;
  final UserEntity user;
  final DateTime createdAt;
  final DateTime updatedAt;
  ReportEntity({
    this.id,
    this.threadId,
    this.threadType,
    this.description,
    this.tag,
    this.user,
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object> get props {
    return [
      id,
      threadId,
      threadType,
      description,
      tag,
      user,
      createdAt,
      updatedAt,
    ];
  }

  ReportEntity copyWith({
    String id,
    String threadId,
    ReportThreadType threadType,
    String description,
    String tag,
    UserEntity user,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return ReportEntity(
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      threadType: threadType ?? this.threadType,
      description: description ?? this.description,
      tag: tag ?? this.tag,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;
}
