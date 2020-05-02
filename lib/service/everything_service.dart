import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/data/mapper/feed_mapper.dart';

class EverythingService {
  Future<List<Feed>> getFeedsByCategory(
      {Api.NewsCategory newsCategory, String lastFeedId}) async {
    return await Api.getNewsByCategory(newsCategory, lastFeedId: lastFeedId)
        .then((onValue) =>
            onValue.feeds?.map((f) => FeedMapper.fromFeedApi(f))?.toList());
  }
}
