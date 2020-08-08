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

  NewsFeed get feed => _feed;
  List<NewsFeed> get relatedFeeds => _feed.related;

  bool get hasRelatedFeeds => _feed.related != null && _feed.related.isNotEmpty;

  @action
  bookmarkFeed(UserModel userModel) {
    feed.bookmark = true;
    _bookmarkRepository
        .postBookmark(postId: feed.uuid, user: userModel, bookmarkFeed: feed)
        .catchError((onError) {
      message = 'Unable to bookmark';
      feed.bookmark = false;
    });
  }

  @action
  removeBookmarkedFeed(String userId) {
    feed.bookmark = false;
    _bookmarkRepository
        .removeBookmark(postId: feed.uuid, userId: userId)
        .catchError((onError) {
      message = 'Unable to remove bookmark';
      feed.bookmark = true;
    });
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
