import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart' as Validator;

class NewsFeed extends Equatable {
  final String id;
  final NewsSource source;
  final NewsCategory category;
  final String author;
  final String title;
  final String description;
  final String link;
  final String image;
  final DateTime publishedDate;
  final String momentPublishedDate;
  final String content;
  final String uuid;
  final List<NewsFeed> related;
  final String userId;
  final String timestamp;
  final String tag = Uuid().v4();
  final ValueNotifier<bool> bookmarkNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> likeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> likeCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> bookmarkCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> shareCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> commentCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> viewCountNotifier = ValueNotifier<int>(0);

  NewsFeed(
      {@required this.id,
      @required this.source,
      @required this.category,
      @required this.author,
      @required this.title,
      @required this.description,
      @required this.link,
      @required this.image,
      @required this.publishedDate,
      @required this.momentPublishedDate,
      @required this.content,
      @required this.uuid,
      @required this.related,
      this.userId,
      this.timestamp,
      @required bool isBookmarked,
      @required bool isLiked,
      @required int likeCount,
      @required int bookmarkCount,
      @required int shareCount,
      @required int commentCount,
      @required int viewCount}) {
    this.bookmarkNotifier.value = isBookmarked ?? false;
    this.likeNotifier.value = isLiked ?? false;
    this.bookmarkCountNotifier.value = bookmarkCount ?? 0;
    this.likeCountNotifier.value = likeCount ?? 0;
    this.shareCountNotifier.value = shareCount ?? 0;
    this.commentCountNotifier.value = commentCount ?? 0;
    this.viewCountNotifier.value = viewCount ?? 0;
  }

  bool get isValidLink => Validator.isURL(link);

  bool get isValidImage => Validator.isURL(image);
  bool get isBookmarked => bookmarkNotifier.value;
  bool get isLiked => likeNotifier.value;
  int get likeCount => likeCountNotifier.value;
  int get commentCount => commentCountNotifier.value;
  int get shareCount => shareCountNotifier.value;
  int get viewCount => viewCountNotifier.value;
  int get bookmarkCount => bookmarkCountNotifier.value;

  set like(bool value) {
    this.likeNotifier.value = value;
    this.likeCountNotifier.value = value ? likeCount + 1 : likeCount - 1;
  }

  set bookmark(bool value) {
    this.bookmarkNotifier.value = value;
    this.bookmarkCountNotifier.value =
        value ? bookmarkCount + 1 : bookmarkCount - 1;
  }

  set comment(bool value) {
    this.commentCountNotifier.value =
        value ? commentCount + 1 : commentCount - 1;
  }

  set view(bool value) {
    this.viewCountNotifier.value = viewCount + 1;
  }

  set share(bool value) {
    this.shareCountNotifier.value = shareCount + 1;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'source': this.source.toJson(),
        'category': this.category.toJson(),
        'author': this.author,
        'title': this.title,
        'description': this.description,
        'link': this.link,
        'image': this.image,
        'pub_date': this.publishedDate.toIso8601String(),
        'content': this.content,
        'uuid': this.uuid,
      };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        source,
        category,
        author,
        title,
        description,
        link,
        image,
        publishedDate,
        content,
        uuid,
        related,
        bookmarkNotifier.value,
        likeNotifier.value,
        likeCountNotifier.value,
        bookmarkCountNotifier.value,
        shareCountNotifier.value,
        commentCountNotifier.value,
        tag
      ];
}

class NewsSource extends Equatable {
  final int id;
  final String name;
  final String code;
  final String icon;
  final int priority;
  final String favicon;
  final ValueNotifier<bool> followNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> followerCountNotifier = ValueNotifier<int>(0);

  NewsSource({
    this.id,
    this.name,
    this.code,
    this.icon,
    this.priority,
    this.favicon,
    bool isFollowed,
    int followerCount,
  }) {
    this.followNotifier.value = isFollowed ?? false;
    this.followerCountNotifier.value = followerCount ?? 0;
  }

  bool get isValidIcon => Validator.isURL(icon);

  bool get isValidFavIcon => Validator.isURL(favicon);
  bool get isFollowed => followNotifier.value;
  int get followerCount => followerCountNotifier.value;

  set follow(bool value) {
    this.followNotifier.value = value;
    this.followerCountNotifier.value =
        value ? followerCount + 1 : followerCount - 1;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'code': this.code,
        'icon': this.icon,
        'priority': this.priority,
        'favicon': this.favicon,
        'is_followed': this.isFollowed,
      };

  @override
  List<Object> get props => [
        id,
        name,
        code,
        icon,
        priority,
        favicon,
        followNotifier.value,
        followerCountNotifier.value
      ];

  @override
  bool get stringify => true;
}

class NewsCategory extends Equatable {
  final int id;
  final String name;
  final String code;
  final IconData icon;
  final int priority;
  final ValueNotifier<bool> followNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> followerCountNotifier = ValueNotifier<int>(0);

  NewsCategory({
    this.id,
    this.name,
    this.code,
    this.icon,
    this.priority,
    bool isFollowed,
    int followerCount,
  }) {
    this.followNotifier.value = isFollowed ?? false;
    this.followerCountNotifier.value = followerCount ?? 0;
  }

  // bool get isValidIcon => Validator.isURL(icon);

  bool get isFollowed => followNotifier.value;
  int get followerCount => followerCountNotifier.value;

  set follow(bool value) {
    this.followNotifier.value = value;
    this.followerCountNotifier.value =
        value ? followerCount + 1 : followerCount - 1;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'code': this.code,
        // 'icon': this.icon,
        'priority': this.priority,
        'is_followed': this.isFollowed,
      };

  @override
  List<Object> get props => [
        id,
        name,
        code,
        // icon,
        priority,
        followNotifier.value,
        followerCountNotifier.value
      ];

  @override
  bool get stringify => true;
}

class NewsTopic extends Equatable {
  final String title;
  final String icon;
  final ValueNotifier<bool> followNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> followerCountNotifier = ValueNotifier<int>(0);

  NewsTopic({
    this.title,
    this.icon,
    bool isFollowed,
    int followerCount,
  }) {
    this.followNotifier.value = isFollowed ?? false;
    this.followerCountNotifier.value = followerCount ?? 0;
  }

  bool get isValidIcon => Validator.isURL(icon);
  bool get isFollowed => followNotifier.value;
  int get followerCount => followerCountNotifier.value;

  set follow(bool value) {
    this.followNotifier.value = value;
    this.followerCountNotifier.value =
        value ? followerCount + 1 : followerCount - 1;
  }

  @override
  List<Object> get props =>
      [title, icon, followNotifier.value, followerCountNotifier.value];

  @override
  bool get stringify => true;
}

class BookmarkedNewsFeed extends Equatable {
  final String id;
  final NewsSource source;
  final NewsCategory category;
  final String author;
  final String title;
  final String description;
  final String link;
  final String image;
  final DateTime publishedDate;
  final String content;
  final String uuid;
  final ValueNotifier<bool> bookmarkNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> likeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> likeCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> bookmarkCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> shareCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> commentCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> viewCountNotifier = ValueNotifier<int>(0);
  final String timestamp;
  final String userId;

  BookmarkedNewsFeed({
    @required this.id,
    @required this.source,
    @required this.category,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.link,
    @required this.image,
    @required this.publishedDate,
    @required this.content,
    @required this.uuid,
    @required this.userId,
    @required this.timestamp,
    @required bool isBookmarked,
    @required bool isLiked,
    @required int likeCount,
    @required int bookmarkCount,
    @required int shareCount,
    @required int commentCount,
    @required int viewCount,
  }) {
    this.bookmarkNotifier.value = isBookmarked ?? false;
    this.likeNotifier.value = isLiked ?? false;
    this.bookmarkCountNotifier.value = bookmarkCount ?? 0;
    this.likeCountNotifier.value = likeCount ?? 0;
    this.shareCountNotifier.value = shareCount ?? 0;
    this.commentCountNotifier.value = commentCount ?? 0;
    this.viewCountNotifier.value = viewCount ?? 0;
  }

  bool get isValidLink => Validator.isURL(link);

  bool get isValidImage => Validator.isURL(image);
  bool get isBookmarked => bookmarkNotifier.value;
  bool get isLiked => likeNotifier.value;
  int get likeCount => likeCountNotifier.value;
  int get commentCount => commentCountNotifier.value;
  int get shareCount => shareCountNotifier.value;
  int get viewCount => viewCountNotifier.value;

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'source': this.source.toJson(),
        'category': this.category.toJson(),
        'author': this.author,
        'title': this.title,
        'description': this.description,
        'link': this.link,
        'image': this.image,
        'pub_date': this.publishedDate.toIso8601String(),
        'content': this.content,
        'uuid': this.uuid,
      };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        source,
        category,
        author,
        title,
        description,
        link,
        image,
        publishedDate,
        content,
        uuid,
        bookmarkNotifier.value,
        likeNotifier.value,
        likeCountNotifier.value,
        bookmarkCountNotifier.value,
        shareCountNotifier.value,
        commentCountNotifier.value,
      ];
}
