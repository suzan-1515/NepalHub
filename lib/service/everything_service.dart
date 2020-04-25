import 'package:samachar_hub/data/api.dart' as Api;
import 'package:samachar_hub/data/model/news.dart';

class EverythingService {
  Future<News> getFeedsByCategory({Api.NewsCategory newsCategory, String lastFeedId}) async {
    return await Api.getNewsByCategory(newsCategory,lastFeedId: lastFeedId);
  }
}
