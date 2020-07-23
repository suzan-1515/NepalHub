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
  final NewsFeed feed;

  _NewsDetailStore(
      this.shareService, this.user, this._bookmarkRepository, this.feed);

  @observable
  String message;

  @action
  bookmarkFeed() {
    feed.bookmarkNotifier.value = true;
    _bookmarkRepository
        .postBookmark(postId: feed.uuid, user: user, bookmarkFeed: feed)
        .catchError((onError) {
      message = 'Unable to bookmark';
      feed.bookmarkNotifier.value = false;
    });
  }

  @action
  removeBookmarkedFeed() {
    feed.bookmarkNotifier.value = false;
    _bookmarkRepository
        .removeBookmark(postId: feed.uuid, userId: user.uId)
        .catchError((onError) {
      message = 'Unable to remove bookmark';
      feed.bookmarkNotifier.value = true;
    });
  }

  dispose() {}
}
