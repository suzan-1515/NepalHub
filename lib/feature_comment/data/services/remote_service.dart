mixin RemoteService {
  Future fetchComments(
      {String threadId, String threadType, int page, String token});
  Future postComment(
      {String threadId, String threadType, String comment, String token});
  Future likeComment({String commentId, String token});
  Future unlikeComment({String commentId, String token});
  Future deleteComment({String commentId, String token});
  Future updateComment({String commentId, String comment, String token});
}
