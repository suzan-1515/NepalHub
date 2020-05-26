import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/dto.dart';

class NewsMapper {
  static Feed fromFeedApi(FeedApiResponse response) {
    return Feed(response,
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

  static Feed fromFeedFirestore(FeedFirestoreResponse response) {
    return Feed(response,
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
        related: response.related?.map((f) => fromFeedApi(f))?.toList(),
        bookmarked: response.bookmarked,
        liked: response.liked);
  }

  static NewsTopics fromTagsApi(NewsTopicsApiResponse response) {
    return NewsTopics(response.tags);
  }

  static FeedSource fromSourceApi(FeedSourceApiResponse response) {
    return FeedSource(
      id: response.id,
      name: response.name,
      code: response.code,
      favicon: response.favicon,
      icon: response.icon,
      priority: response.priority,
      rawData: response,
    );
  }

  static FeedCategory fromCategoryApi(FeedCategoryApiResponse response) {
    return FeedCategory(
      id: response.id,
      name: response.name,
      code: response.code,
      icon: response.icon,
      priority: response.priority,
      rawData: response,
    );
  }
}
