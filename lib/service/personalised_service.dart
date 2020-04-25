import 'package:samachar_hub/data/api.dart' as Api;
import 'package:samachar_hub/data/model/news.dart';

class PersonalisedFeedService {
  Future<News> getLatestFeeds() async {
    return await Api.getLatestNews();
  }
}
