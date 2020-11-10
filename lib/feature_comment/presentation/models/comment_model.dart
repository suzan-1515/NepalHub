import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class CommentUIModel extends Model {
  CommentEntity _commentEntity;
  CommentUIModel(this._commentEntity);

  CommentEntity get entity => this._commentEntity;
  set entity(CommentEntity comment) {
    this._commentEntity = comment;
    notifyListeners();
  }

  like() =>
      this.entity.copyWith(isLiked: true, likeCount: this.entity.likeCount + 1);

  unlike() => this
      .entity
      .copyWith(isLiked: false, likeCount: this.entity.likeCount - 1);
}
