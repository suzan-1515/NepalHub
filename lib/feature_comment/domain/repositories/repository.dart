import 'package:meta/meta.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';

mixin Repository {
  Future<List<CommentEntity>> getComments(
      {@required String threadId,
      @required CommentThreadType threadType,
      @required int page});
  Future<CommentEntity> postComment(
      {@required String threadId,
      @required CommentThreadType threadType,
      @required String comment});
  Future<CommentEntity> likeComment({@required CommentEntity comment});
  Future<CommentEntity> unlikeComment({@required CommentEntity comment});
  Future<CommentEntity> deleteComment({@required CommentEntity comment});
  Future<CommentEntity> updateComment({@required CommentEntity comment});
}
