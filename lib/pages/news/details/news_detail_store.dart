import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_repository.dart';
import 'package:samachar_hub/services/services.dart';

part 'news_detail_store.g.dart';

class NewsDetailStore = _NewsDetailStore with _$NewsDetailStore;

abstract class _NewsDetailStore with Store {
  final ShareService shareService;
  final UserModel user;
  final BookmarkRepository _bookmarkRepository;
  final NewsFeedModel feed;

  _NewsDetailStore(
      this.shareService, this.user, this._bookmarkRepository, this.feed);

  @observable
  bool bookmarkStatus = false;

  @observable
  String message;

  @action
  isBookmarked() {
    _bookmarkRepository
        .doesBookmarkExist(postId: feed.uuid, userId: user.uId)
        .then((value) {
      bookmarkStatus = value;
    }).catchError((onError) => bookmarkStatus = false);
  }

  @action
  bookmarkFeed() {
    _bookmarkRepository
        .postBookmark(postId: feed.uuid, user: user, bookmarkFeed: feed)
        .then((onValue) {
      bookmarkStatus = true;
      feed.bookmarked.value = true;
    }, onError: (e) {
      message = 'Unable to bookmark';
      bookmarkStatus = false;
      feed.bookmarked.value = false;
    });
  }

  @action
  removeBookmarkedFeed() {
    _bookmarkRepository
        .removeBookmark(postId: feed.uuid, userId: user.uId)
        .then((onValue) {
      bookmarkStatus = true;
      feed.bookmarked.value = true;
    }, onError: (e) {
      message = 'Unable to remove bookmark';
      bookmarkStatus = false;
      feed.bookmarked.value = false;
    });
  }

  dispose() {}
}
