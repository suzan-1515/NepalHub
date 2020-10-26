import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/data/models/user_model.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_entity.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';

class ReportModel extends ReportEntity {
  ReportModel({
    @required String id,
    @required String threadId,
    @required ReportThreadType threadType,
    @required String description,
    @required String tag,
    @required UserModel user,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  }) : super(
            id: id,
            threadId: threadId,
            threadType: threadType,
            description: description,
            tag: tag,
            user: user,
            createdAt: createdAt,
            updatedAt: updatedAt);

  String toJson() => json.encode(toMap());

  factory ReportModel.fromMap(Map<String, dynamic> json) => ReportModel(
        id: json["id"].toString(),
        threadId: json["thread_id"],
        threadType: (json["thread_type"] as String).toReportThreadType,
        description: json["description"],
        tag: json["tag"],
        user: UserModel.fromMap(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "thread_id": threadId,
        "thread_type": threadType.value,
        "description": description,
        "tag": tag,
        "user": (user as UserModel).toMap(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
