import 'package:samachar_hub/data/api/api_provider.dart' as Api;
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/data/mapper/feed_mapper.dart';

class PersonalisedFeedService {
  Future<List<Feed>> getLatestFeeds() async {
    return await Api.getLatestNews().then((onValue) =>
        onValue.feeds?.map((f) => FeedMapper.fromFeedApi(f))?.toList());
  }
}
