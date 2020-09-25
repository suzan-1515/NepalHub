import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';

extension CommentX on CommentEntity {
  CommentUIModel get toUIModel => CommentUIModel(this);
}

extension CommentListX on List<CommentEntity> {
  List<CommentUIModel> get toUIModels => this.map((e) => e.toUIModel).toList();
}
