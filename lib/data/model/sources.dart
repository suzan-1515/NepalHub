import 'package:json_annotation/json_annotation.dart';
import 'package:samachar_hub/data/model/feed.dart';

part 'sources.g.dart';

@JsonSerializable()
class Sources {
  final List<FeedSource> sources;
  final List<FeedCategory> categories;

  Sources(this.sources, this.categories);

  factory Sources.fromJson(Map<String, dynamic> json) => _$SourcesFromJson(json);
  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}
