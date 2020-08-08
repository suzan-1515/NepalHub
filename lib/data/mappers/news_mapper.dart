import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/utils/news_category.dart';

class NewsMapper {
  static NewsFeed fromBookmarkFeed(BookmarkFirestoreResponse response, likes,
      unFollowedSources, unFollowedCategories) {
    return NewsFeed(
      id: response.id,
      source: fromSourceApi(
          response.source, !unFollowedSources.contains(response.uuid)),
      category: fromCategoryApi(
          response.category, !unFollowedCategories.contains(response.uuid)),
      author: response.formatedAuthor,
      title: response.title,
      description: response.description,
      link: response.link,
      image: response.image,
      publishedDate: response.getPublishedDate,
      momentPublishedDate: response.formatedPublishedDate,
      content: response.content,
      uuid: response.uuid,
      related: null,
      userId: response.userid,
      timestamp: response.timestamp,
      bookmarkCount: 0,
      commentCount: 0,
      shareCount: 0,
      likeCount: likes.contains(response.uuid) ? 1 : 0,
      isBookmarked: true,
      viewCount: 0,
      isLiked: likes.contains(response.uuid),
    );
  }

  static NewsTopic fromTopicApi(String tag, bool isFollowed) {
    return NewsTopic(
      followerCount: 0,
      icon: null,
      isFollowed: isFollowed,
      title: tag,
    );
  }

  static NewsFeed fromFeedApi(FeedApiResponse response, bookmarks, likes,
      unFollowedSources, unFollowedCategories) {
    return NewsFeed(
      id: response.id,
      source: fromSourceApi(
          response.source, !unFollowedSources.contains(response.uuid)),
      category: fromCategoryApi(
          response.category, !unFollowedCategories.contains(response.uuid)),
      author: response.formatedAuthor,
      title: response.title,
      description: response.description,
      link: response.link,
      image: response.image,
      publishedDate: response.getPublishedDate,
      momentPublishedDate: response.formatedPublishedDate,
      content: response.content,
      uuid: response.uuid,
      related: response.related
          ?.map((f) => fromFeedApi(
              f, bookmarks, likes, unFollowedSources, unFollowedCategories))
          ?.toList(),
      bookmarkCount: bookmarks.contains(response.uuid) ? 1 : 0,
      commentCount: 0,
      shareCount: 0,
      likeCount: likes.contains(response.uuid) ? 1 : 0,
      isBookmarked: bookmarks.contains(response.uuid),
      viewCount: 0,
      isLiked: likes.contains(response.uuid),
    );
  }

  static NewsSource fromSourceApi(
      FeedSourceApiResponse response, bool isFollowed) {
    return NewsSource(
      id: response.id,
      name: response.name,
      code: response.code,
      favicon: response.favicon,
      icon: response.icon,
      priority: response.priority,
      followerCount: 200,
      isFollowed: isFollowed,
    );
  }

  static NewsCategory fromCategoryApi(
      FeedCategoryApiResponse response, bool isFollowed) {
    return NewsCategory(
      id: response.id,
      name: response.name,
      code: response.code,
      icon: newsCategoryIcons[response.code],
      priority: response.priority,
      followerCount: 0,
      isFollowed: isFollowed,
    );
  }
}
