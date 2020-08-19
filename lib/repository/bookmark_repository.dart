import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/bookmark_firestore_service.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/services.dart';

class BookmarkRepository {
  final BookmarkFirestoreService _bookmarkService;
  final PostMetaRepository _postMetaRepository;
  final PreferenceService _preferenceService;

  static const int DATA_LIMIT = 20;

  BookmarkRepository(
      this._bookmarkService, this._postMetaRepository, this._preferenceService);

  String generateBookmarkId(String postId, String userId) => '$postId:$userId';

  Future<void> postBookmark(
      {@required String userId, @required NewsFeed feed}) {
    var bookmarkId = generateBookmarkId(feed.uuid, userId);

    var data = feed.toJson();
    data['user_id'] = userId;
    data['timestamp'] = DateTime.now().toIso8601String();
    data.remove('related');
    return _bookmarkService
        .addBookmark(
      bookmarkId: bookmarkId,
      bookmarkData: data,
    )
        .then((value) {
      return _postMetaRepository
          .postBookmark(postId: feed.uuid, userId: userId)
          .whenComplete(() {
        var bookmarks = _preferenceService.bookmarkedFeeds;
        bookmarks.add(feed.uuid);
        _preferenceService.bookmarkedFeeds = bookmarks;
      });
    });
  }

  Future<void> removeBookmark({
    @required String postId,
    @required String userId,
  }) async {
    var bookmarkId = generateBookmarkId(postId, userId);
    return _bookmarkService
        .removeBookmark(bookmarkId: bookmarkId)
        .then((value) {
      return _postMetaRepository
          .removeBookmark(postId: postId, userId: userId)
          .whenComplete(() {
        var bookmarks = _preferenceService.bookmarkedFeeds;
        bookmarks.remove(postId);
        _preferenceService.bookmarkedFeeds = bookmarks;
      });
    });
  }

  Future<bool> doesBookmarkExist(
      {@required String postId, @required String userId}) async {
    return await _bookmarkService.doesBookmarkExist(
        bookmarkId: generateBookmarkId(postId, userId));
  }

  Future<List<NewsFeed>> getBookmarks({@required String userId, String after}) {
    var likes = _preferenceService.likedFeeds;
    var unFollowedSources = _preferenceService.unFollowedNewsSources;
    var unFollowedCategories = _preferenceService.unFollowedNewsCategories;
    return _bookmarkService
        .fetchBookmarks(userId: userId, limit: DATA_LIMIT, after: after)
        .then((value) {
      if (value != null && value.isNotEmpty) {
        return value
            .map((response) => NewsMapper.fromBookmarkFeed(
                response, likes, unFollowedSources, unFollowedCategories))
            .toList();
      }
      return List<NewsFeed>();
    });
  }

  Stream<List<NewsFeed>> getBookmarksAsStream({@required String userId}) {
    var likes = _preferenceService.likedFeeds;
    var unFollowedSources = _preferenceService.unFollowedNewsSources;
    var unFollowedCategories = _preferenceService.unFollowedNewsCategories;
    return _bookmarkService
        .fetchBookmarksAsStream(userId: userId, limit: DATA_LIMIT)
        .map((value) {
      if (value != null && value.isNotEmpty) {
        return value
            .map((response) => NewsMapper.fromBookmarkFeed(
                response, likes, unFollowedSources, unFollowedCategories))
            .toList();
      }
      return List<NewsFeed>();
    });
  }
}
