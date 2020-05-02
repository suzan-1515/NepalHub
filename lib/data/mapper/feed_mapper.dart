import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/api/response/api_response.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';

class FeedMapper {
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
}
