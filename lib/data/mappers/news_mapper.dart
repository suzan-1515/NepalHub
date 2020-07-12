import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/util/news_category.dart';

class NewsMapper {
  static NewsFeedModel fromFeedApi(FeedApiResponse response) {
    return NewsFeedModel(response.toJson(),
        id: response.id,
        source: response.formatedSource,
        sourceFavicon: response.sourceFavicon,
        category: response.formatedCategory,
        author: response.formatedAuthor,
        title: response.title,
        description: response.description,
        link: response.link,
        image: response.image,
        publishedAt: response.formatedPublishedDate,
        content: response.content,
        uuid: response.uuid,
        related: response.related?.map((f) => fromFeedApi(f))?.toList());
  }

  static NewsFeedModel fromBookmarkFeed(BookmarkFirestoreResponse response) {
    return NewsFeedModel(response.toJson(),
        id: response.id,
        source: response.formatedSource,
        sourceFavicon: response.sourceFavicon,
        category: response.formatedCategory,
        author: response.formatedAuthor,
        title: response.title,
        description: response.description,
        link: response.link,
        image: response.image,
        publishedAt: response.formatedPublishedDate,
        content: response.content,
        uuid: response.uuid,
        related: null,
        bookmarked: true);
  }

  static NewsTopicModel fromTagsApi(NewsTopicsApiResponse response) {
    return NewsTopicModel(response.tags);
  }

  static NewsSourceModel fromSourceApi(
      FeedSourceApiResponse response, bool isFollowed) {
    return NewsSourceModel(
      id: response.id,
      name: response.name,
      code: response.code,
      favicon: response.favicon,
      icon: response.icon,
      priority: response.priority,
      rawData: response,
      followerCount: 0,
      isFollowed: isFollowed,
    );
  }

  static NewsCategoryModel fromCategoryApi(
      FeedCategoryApiResponse response, bool isFollowed) {
    return NewsCategoryModel(
      id: response.id,
      name: response.name,
      code: response.code,
      icon: newsCategoryIcons[response.code],
      priority: response.priority,
      rawData: response,
      followerCount: 0,
      isFollowed: isFollowed,
    );
  }
}
