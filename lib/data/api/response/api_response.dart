import 'package:json_annotation/json_annotation.dart';
import 'package:samachar_hub/util/helper.dart';

part 'api_response.g.dart';

@JsonSerializable()
class NewsApiResponse {
  final int version;
  final List<FeedApiResponse> feeds;

  NewsApiResponse(this.version, this.feeds);

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NewsApiResponseToJson(this);
}

@JsonSerializable()
class FeedSourcesApiResponse {
  final List<FeedSourceApiResponse> sources;
  final List<FeedCategoryApiResponse> categories;

  FeedSourcesApiResponse(this.sources, this.categories);

  factory FeedSourcesApiResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedSourcesApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedSourcesApiResponseToJson(this);
}

@JsonSerializable()
class FeedApiResponse {
  final String id;
  final FeedSourceApiResponse source;
  final FeedCategoryApiResponse category;
  final String author;
  final String title;
  final String description;
  final String link;
  final String image;
  @JsonKey(name: "pub_date")
  final String publishedAt;
  final String content;
  final String uuid;
  @JsonKey(required: false)
  final List<FeedApiResponse> related;

  FeedApiResponse(
    this.id,
    this.source,
    this.category,
    this.author,
    this.title,
    this.description,
    this.link,
    this.image,
    this.publishedAt,
    this.content,
    this.related,
    this.uuid,);

  String get formatedSource =>
      (source == null || source.name == null || source.name.isEmpty)
          ? 'N/A'
          : source.name;
  String get sourceFavicon =>
      (source == null || source.favicon == null || source.favicon.isEmpty)
          ? ''
          : source.favicon;
  String get formatedCategory =>
      (category == null || category.name == null || category.name.isEmpty)
          ? 'N/A'
          : category.name;
  String get formatedAuthor =>
      (author == null || author.isEmpty) ? formatedSource : author;
  String get formatedPublishedDate {
    var fomattedDate = publishedAt;
    try {
      fomattedDate = publishedAt.isEmpty
          ? 'N/A'
          : relativeTimeString(DateTime.parse(publishedAt));
    } catch (e) {
      fomattedDate = publishedAt;
    }
    return fomattedDate;
  }

  factory FeedApiResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedApiResponseFromJson(json);
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'source': this.source.toJson(),
        'category': this.category.toJson(),
        'author': this.author,
        'title': this.title,
        'description': this.description,
        'link': this.link,
        'image': this.image,
        'pub_date': this.publishedAt,
        'content': this.content,
        'related': this.related?.map((e) {
          if (e == null) return [];
          return e.toJson();
        })?.toList(),
        'uuid': this.uuid,
      };
}

@JsonSerializable()
class FeedSourceApiResponse {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final String favicon;

  FeedSourceApiResponse(
      this.id, this.name, this.code, this.icon, this.priority, this.favicon);

  factory FeedSourceApiResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedSourceApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedSourceApiResponseToJson(this);
}

@JsonSerializable()
class FeedCategoryApiResponse {
  final int id;
  final String name;
  @JsonKey(name: "name_np")
  final String nameNp;
  final String code;
  final String icon;
  final int priority;
  final String enable;

  FeedCategoryApiResponse(this.id, this.name, this.nameNp, this.code, this.icon,
      this.priority, this.enable);

  factory FeedCategoryApiResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedCategoryApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedCategoryApiResponseToJson(this);
}

@JsonSerializable()
class NewsTagsApiResponse{
  final List<String> tags;

  NewsTagsApiResponse(this.tags);

factory NewsTagsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsTagsApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NewsTagsApiResponseToJson(this);

}
