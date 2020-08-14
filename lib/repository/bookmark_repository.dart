import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/bookmark_firestore_service.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/services.dart';

class BookmarkRepository {
  final BookmarkFirestoreService _bookmarkService;
  final AnalyticsService _analyticsService;
  final PostMetaRepository _postMetaRepository;
  final PreferenceService _preferenceService;

  static const int DATA_LIMIT = 20;

  BookmarkRepository(this._bookmarkService, this._postMetaRepository,
      this._analyticsService, this._preferenceService);

  String generateBookmarkId(String postId, String userId) => '$postId:$userId';

  Future<void> postBookmark(
      {@required String userId, @required NewsFeed feed}) {
    var metaData = {
      'bookmark_count': FieldValue.increment(1),
    };
    var activityId =
        _postMetaRepository.generateActivityId(feed.uuid, userId, 'bookmark');
    var metaActivityData = {
      'id': activityId,
      'meta_name': 'bookmark',
      'post_id': feed.uuid,
      'user_id': userId,
      'timestamp': DateTime.now().toIso8601String(),
    };
    var bookmarkId = generateBookmarkId(feed.uuid, userId);

    var data = feed.toJson();
    data['user_id'] = userId;
    data['timestamp'] = DateTime.now().toString();
    data.remove('related');
    return _bookmarkService
        .addBookmark(
            bookmarkId: bookmarkId,
            metaActivityData: metaActivityData,
            metaData: metaData,
            bookmarkData: data,
            metaActivityDocumentRef: _postMetaRepository
                .metaActivityCollectionReference(feed.uuid)
                .document(activityId),
            metaDocumentRef:
                _postMetaRepository.metaCollectionReference.document(feed.uuid))
        .then((value) {
      var bookmarks = _preferenceService.bookmarkedFeeds;
      bookmarks.add(feed.uuid);
      _preferenceService.bookmarkedFeeds = bookmarks;
      _analyticsService.logFeedBookmarkAdded(feedId: feed.uuid);
    });
  }

  Future<void> removeBookmark({
    @required String postId,
    @required String userId,
  }) async {
    var data = {'bookmark_count': FieldValue.increment(-1)};
    var bookmarkId = generateBookmarkId(postId, userId);
    var activityId =
        _postMetaRepository.generateActivityId(postId, userId, 'bookmark');
    return _bookmarkService
        .removeBookmark(
            bookmarkId: bookmarkId,
            metaActivityDocumentRef: _postMetaRepository
                .metaActivityCollectionReference(postId)
                .document(activityId),
            metaDocumentRef:
                _postMetaRepository.metaCollectionReference.document(postId),
            metaData: data)
        .then((value) {
      var bookmarks = _preferenceService.bookmarkedFeeds;
      bookmarks.remove(postId);
      _preferenceService.bookmarkedFeeds = bookmarks;
      _analyticsService.logFeedBookmarkRemoved(feedId: postId);
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
    }).then((value) {
      _analyticsService.logFeedBookmarkFetched(page: after);
      return value;
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
    }).map((value) {
      _analyticsService.logFeedBookmarkFetched(page: '0');
      return value;
    });
  }
}
