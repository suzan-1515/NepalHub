import 'package:samachar_hub/data/api/response/news_api_response.dart';

class NewsApiParser {
  static NewsApiResponse parse(
      {Map<String, dynamic> feeds, Map<String, dynamic> sources}) {
    feeds.update(
        'feeds',
        (update) => (feeds['feeds'] as List)
                ?.where((feed) => feed != null)
                ?.map((feed) {
              return _parseFeed(feed: feed, sources: sources);
            })?.toList());
    return NewsApiResponse.fromJson(feeds);
  }

  static NewsApiResponse parseTagNews(
      {Map<String, dynamic> feeds, Map<String, dynamic> sources}) {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['version'] = 1;
    json['feeds'] = (feeds['hits']['hits'] as List)
        ?.where((feed) => feed != null)
        ?.map((feed) {
      feed.update('_source', (up) {
        feed['_source']['id'] = feed['_id'];
        return feed['_source'];
      });
      return _parseFeed(feed: feed['_source'], sources: sources);
    })?.toList();
    return NewsApiResponse.fromJson(json);
  }

  static _mergeSources({feed, sources}) {
    if (feed.containsKey('source')) {
      try {
        var source = sources['sources']
            .where((source) =>
                source['code'] != null && source['code'] == feed['source'])
            .first;
        feed.update('source', (update) => source);
      } catch (e) {
        feed.update(
            'source',
            (update) => Map<String, dynamic>.from({
                  'name': feed['source'],
                  'code': feed['source'],
                }));
      }
    }
    if (feed.containsKey('category')) {
      try {
        var category = sources['categories']
            .where((category) =>
                category['code'] != null &&
                category['code'] == feed['category'])
            .first;
        feed.update('category', (update) => category);
      } catch (e) {
        feed.update(
            'category',
            (update) => Map<String, dynamic>.from(
                {'name': feed['category'], 'code': feed['category']}));
      }
    }

    return feed;
  }

  static _parseFeed({feed, sources}) {
    feed = _mergeSources(feed: feed, sources: sources);
    if (feed.containsKey('related'))
      feed.update(
          'related',
          (update) => (feed['related'] as List)
              ?.where((f) => f != null)
              ?.map((f) => _parseFeed(feed: f, sources: sources))
              ?.toList());
    return feed;
  }
}
