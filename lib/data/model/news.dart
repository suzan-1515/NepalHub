import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/data/model/sources.dart';

class News {
  final int version;
  final List<Feed> feeds;

  News(this.version, this.feeds);

  factory News.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> sourceJson) {
    var sources = Sources.fromJson(sourceJson);
    return News(
      json['version'] as int,
      (json['feeds'] as List)?.map((e) {
        if (e == null) return null;
        Map<String, dynamic> feed = Map.fromEntries((e as Map<String, dynamic>).entries);
        
        if (feed.containsKey('source')) {
          try {
            var source = sources.sources
                .where((source) =>
                    source.code != null &&
                    source.code == (feed['source'] as String))
                .first;
            feed.update('source', (update) => source.toJson());
          } catch (e) {
            print("Source not available");
          }
        }
        if (feed.containsKey('category')) {
          try {
            var category = sources.categories
                .where((category) =>
                    category.code != null &&
                    category.code == feed['category'] as String)
                .first;
            feed.update('category', (update) => category.toJson());
          } catch (e) {
            print("Category not available");
          }
        }
        return Feed.fromJson(feed);
      })?.toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'version': this.version,
        'feeds': this.feeds,
      };
}
