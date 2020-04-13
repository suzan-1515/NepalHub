// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
