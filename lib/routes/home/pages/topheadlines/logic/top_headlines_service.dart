import 'package:samachar_hub/data/api.dart' as Api;
import 'package:samachar_hub/data/model/top_headlines.dart';

class TopHeadlinesService {

  Future<TopHeadlines> getTopHeadlines({Api.NewsCategory newsCategory}) async {
    return await Api.getTopHeadlines(category: newsCategory);
  }
}