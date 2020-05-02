// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsApiResponse _$NewsApiResponseFromJson(Map<String, dynamic> json) {
  return NewsApiResponse(
    json['version'] as int,
    (json['feeds'] as List)
        ?.map((e) => e == null
            ? null
            : FeedApiResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewsApiResponseToJson(NewsApiResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'feeds': instance.feeds,
    };

FeedSourcesApiResponse _$FeedSourcesApiResponseFromJson(
    Map<String, dynamic> json) {
  return FeedSourcesApiResponse(
    (json['sources'] as List)
        ?.map((e) => e == null
            ? null
            : FeedSourceApiResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['categories'] as List)
        ?.map((e) => e == null
            ? null
            : FeedCategoryApiResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FeedSourcesApiResponseToJson(
        FeedSourcesApiResponse instance) =>
    <String, dynamic>{
      'sources': instance.sources,
      'categories': instance.categories,
    };

FeedApiResponse _$FeedApiResponseFromJson(Map<String, dynamic> json) {
  return FeedApiResponse(
    json['id'] as String,
    json['source'] == null
        ? null
        : FeedSourceApiResponse.fromJson(
            json['source'] as Map<String, dynamic>),
    json['category'] == null
        ? null
        : FeedCategoryApiResponse.fromJson(
            json['category'] as Map<String, dynamic>),
    json['author'] as String,
    json['title'] as String,
    json['description'] as String,
    json['link'] as String,
    json['image'] as String,
    json['pub_date'] as String,
    json['content'] as String,
    (json['related'] as List)
        ?.map((e) => e == null
            ? null
            : FeedApiResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['uuid'] as String,
  );
}

Map<String, dynamic> _$FeedApiResponseToJson(FeedApiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'category': instance.category,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'link': instance.link,
      'image': instance.image,
      'pub_date': instance.publishedAt,
      'content': instance.content,
      'uuid': instance.uuid,
      'related': instance.related,
    };

FeedSourceApiResponse _$FeedSourceApiResponseFromJson(
    Map<String, dynamic> json) {
  return FeedSourceApiResponse(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    json['icon'] as String,
    json['priority'] as int,
    json['favicon'] as String,
  );
}

Map<String, dynamic> _$FeedSourceApiResponseToJson(
        FeedSourceApiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'icon': instance.icon,
      'priority': instance.priority,
      'favicon': instance.favicon,
    };

FeedCategoryApiResponse _$FeedCategoryApiResponseFromJson(
    Map<String, dynamic> json) {
  return FeedCategoryApiResponse(
    json['id'] as int,
    json['name'] as String,
    json['name_np'] as String,
    json['code'] as String,
    json['icon'] as String,
    json['priority'] as int,
    json['enable'] as String,
  );
}

Map<String, dynamic> _$FeedCategoryApiResponseToJson(
        FeedCategoryApiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_np': instance.nameNp,
      'code': instance.code,
      'icon': instance.icon,
      'priority': instance.priority,
      'enable': instance.enable,
    };
