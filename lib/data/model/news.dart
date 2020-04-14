import 'package:json_annotation/json_annotation.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/data/model/sources.dart';

class News {
  final int version;
  final List<Feed> feeds;
  @JsonKey(ignore: true)
  final Sources sources;

  News(this.version, this.feeds, this.sources);

  factory News.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> sourceJson) {
    var sources = Sources.fromJson(sourceJson);
    return News(
      json['version'] as int,
      (json['feeds'] as List)?.map((e) {
        if (e == null) return null;
        var feed = e as Map<String, dynamic>;
        
        if (feed.containsKey('source')) {
          try {
            var source = sources.sources
                .where((source) =>
                    source.code != null &&
                    source.code == (feed['source'] as String))
                .first;
            feed.update('source', (update) => source.toJson());
          } catch (e) {
            feed.update('source', (update) => Map<String,dynamic>.from({'name':feed['source'],'code':feed['source']}));
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
            feed.update('category', (update) => Map<String,dynamic>.from({'name':feed['category'],'code':feed['category']}));
          }
        }

        return Feed.fromJson(feed,sources);
      })?.toList(),
      sources
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'version': this.version,
        'feeds': this.feeds,
      };
}
