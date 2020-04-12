// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return Feed(
    json['id'] as String,
    json['source'] == null
        ? null
        : FeedSource.fromJson(json['source'] as Map<String, dynamic>),
    json['category'] == null
        ? null
        : FeedCategory.fromJson(json['category'] as Map<String, dynamic>),
    json['author'] as String,
    json['title'] as String,
    json['description'] as String,
    json['link'] as String,
    json['image'] as String,
    json['pub_date'] as String,
    json['content'] as String,
    (json['related'] as List)
        ?.map(
            (e) => e == null ? null : Feed.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
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
      'related': instance.related,
    };

FeedSource _$FeedSourceFromJson(Map<String, dynamic> json) {
  return FeedSource(
    json['id'] as int,
    json['name'] as String,
    json['code'] as String,
    json['icon'] as String,
    json['priority'] as int,
    json['favicon'] as String,
  );
}

Map<String, dynamic> _$FeedSourceToJson(FeedSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'icon': instance.icon,
      'priority': instance.priority,
      'favicon': instance.favicon,
    };

FeedCategory _$FeedCategoryFromJson(Map<String, dynamic> json) {
  return FeedCategory(
    json['id'] as int,
    json['name'] as String,
    json['name_np'] as String,
    json['code'] as String,
    json['icon'] as String,
    json['priority'] as int,
    json['enable'] as String,
  );
}

Map<String, dynamic> _$FeedCategoryToJson(FeedCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_np': instance.nameNp,
      'code': instance.code,
      'icon': instance.icon,
      'priority': instance.priority,
      'enable': instance.enable,
    };
