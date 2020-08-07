import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/bookmark_repository.dart';
import 'package:samachar_hub/services/services.dart';

part 'news_detail_store.g.dart';

class NewsDetailStore = _NewsDetailStore with _$NewsDetailStore;

abstract class _NewsDetailStore with Store {
  final ShareService shareService;
  final UserModel user;
  final BookmarkRepository _bookmarkRepository;
  final NewsFeed feed;

  _NewsDetailStore(
      this.shareService, this.user, this._bookmarkRepository, this.feed);

  @observable
  String message;

  @action
  bookmarkFeed() {
    feed.bookmark = true;
    _bookmarkRepository
        .postBookmark(postId: feed.uuid, user: user, bookmarkFeed: feed)
        .catchError((onError) {
      message = 'Unable to bookmark';
      feed.bookmark = false;
    });
  }

  @action
  removeBookmarkedFeed() {
    feed.bookmark = false;
    _bookmarkRepository
        .removeBookmark(postId: feed.uuid, userId: user.uId)
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
