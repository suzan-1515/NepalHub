import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/bookmark_repository.dart';

part 'news_detail_store.g.dart';

class NewsDetailStore = _NewsDetailStore with _$NewsDetailStore;

abstract class _NewsDetailStore with Store {
  final BookmarkRepository _bookmarkRepository;
  final NewsFeed _feed;

  _NewsDetailStore(this._bookmarkRepository, this._feed);

  @observable
  String message;

  bool _inProgress = false;

  bool get inProgress => _inProgress;
  NewsFeed get feed => _feed;
  List<NewsFeed> get relatedFeeds => _feed.related;

  bool get hasRelatedFeeds => _feed.related != null && _feed.related.isNotEmpty;

  @action
  bookmarkFeed(UserModel userModel) {
    if (inProgress) return;
    _inProgress = true;
    feed.bookmark = true;
    _bookmarkRepository
        .postBookmark(userId: userModel.uId, feed: feed)
        .catchError((onError) {
      message = 'Unable to bookmark';
      feed.bookmark = false;
    }).whenComplete(() => _inProgress = false);
  }

  @action
  removeBookmarkedFeed(String userId) {
    if (inProgress) return;
    _inProgress = true;
    feed.bookmark = false;
    _bookmarkRepository
        .removeBookmark(postId: feed.uuid, userId: userId)
        .catchError((onError) {
      message = 'Unable to remove bookmark';
      feed.bookmark = true;
    }).whenComplete(() => _inProgress = false);
  }

  @action
  updateMeta(PostMetaModel metaModel) {
    if (metaModel == null) return;
    if (metaModel.isUserBookmarked != null)
      this.feed.bookmarkNotifier.value = metaModel.isUserBookmarked;
    if (metaModel.isUserLiked != null)
      this.feed.likeNotifier.value = metaModel.isUserLiked;
    if (metaModel.commentCount != null)
      this.feed.commentCountNotifier.value = metaModel.commentCount;
    if (metaModel.likeCount != null)
      this.feed.likeCountNotifier.value = metaModel.likeCount;
    if (metaModel.shareCount != null)
      this.feed.shareCountNotifier.value = metaModel.shareCount;
    if (metaModel.viewCount != null)
      this.feed.viewCountNotifier.value = metaModel.viewCount;
  }

  dispose() {}
}
