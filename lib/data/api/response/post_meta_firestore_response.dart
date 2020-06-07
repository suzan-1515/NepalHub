class PostMetaFirestoreResponse {
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int viewCount;
  final String postId;
  List<PostMetaActivityFirestoreResponse> activities =
      List<PostMetaActivityFirestoreResponse>();

  PostMetaFirestoreResponse(this.likeCount, this.commentCount, this.shareCount,
      this.viewCount, this.postId,
      {this.activities});

  factory PostMetaFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      PostMetaFirestoreResponse(
        json['like_count'],
        json['comment_count'],
        json['share_count'],
        json['view_count'],
        json['post_id'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'like_count': this.likeCount,
        'comment_count': this.commentCount,
        'view_count': this.viewCount,
        'share_count': this.shareCount,
      };
}

class PostMetaActivityFirestoreResponse {
  final String id;
  final String postId;
  final String userId;
  final String metaName;
  final String timestamp;

  PostMetaActivityFirestoreResponse(
      this.id, this.postId, this.userId, this.metaName, this.timestamp);

  factory PostMetaActivityFirestoreResponse.fromJson(
          Map<String, dynamic> json) =>
      PostMetaActivityFirestoreResponse(
        json['id'],
        json['post_id'],
        json['user_id'],
        json['meta_name'],
        json['timestamp'],
      );

  toJson() => <String, dynamic>{
        'id': this.id,
        'post_id': this.postId,
        'user_id': this.userId,
        'meta_name': this.metaName,
        'timestamp': this.timestamp
      };
}
