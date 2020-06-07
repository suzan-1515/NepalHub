import 'package:samachar_hub/data/api/response/post_meta_firestore_response.dart';
import 'package:samachar_hub/data/models/post_meta_model.dart';

class PostMetaMapper {
  static PostMetaModel fromPostMetaFirestore(PostMetaFirestoreResponse response,
      List<PostMetaActivityFirestoreResponse> activityResponse) {
    bool isLiked = false;
    bool isShared = false;
    bool isCommented = false;
    bool isViewed = false;
    bool isBookmarked = false;
    var activities = activityResponse?.map((e) {
      return PostMetaMapper.fromPostMetaActivityFirestore(e);
    })?.map((e) {
      if (e.metaName == 'like') {
        isLiked = true;
      } else if (e.metaName == 'share') {
        isShared = true;
      } else if (e.metaName == 'comment') {
        isCommented = true;
      } else if (e.metaName == 'bookmark') {
        isBookmarked = true;
      }
      else if (e.metaName == 'view') {
        isViewed = true;
      }
      return e;
    })?.toList();
    return PostMetaModel(
      likeCount: response.likeCount,
      shareCount: response.shareCount,
      commentCount: response.commentCount,
      viewCount: response.viewCount,
      postId: response.postId,
      isUserLiked: isLiked,
      isUserShared: isShared,
      isUserCommented: isCommented,
      isUserViewed: isViewed,
      isUserBookmarked: isBookmarked,
      activities: activities,
    );
  }

  static PostMetaActivityModel fromPostMetaActivityFirestore(
      PostMetaActivityFirestoreResponse response) {
    return PostMetaActivityModel(response.id, response.postId, response.userId,
        response.metaName, response.timestamp);
  }
}
