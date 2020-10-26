import 'package:equatable/equatable.dart';

class ThreadStatsEntity extends Equatable {
  final int likeCount;
  final int viewCount;
  final int shareCount;
  final int commentCount;
  final int bookmarkCount;
  final int followerCount;
  ThreadStatsEntity({
    this.likeCount,
    this.viewCount,
    this.shareCount,
    this.commentCount,
    this.bookmarkCount,
    this.followerCount,
  });
  @override
  List<Object> get props {
    return [
      likeCount,
      viewCount,
      shareCount,
      commentCount,
      bookmarkCount,
      followerCount,
    ];
  }

  ThreadStatsEntity copyWith({
    int likeCount,
    int viewCount,
    int shareCount,
    int commentCount,
    int bookmarkCount,
    int followerCount,
  }) {
    return ThreadStatsEntity(
      likeCount: likeCount ?? this.likeCount,
      viewCount: viewCount ?? this.viewCount,
      shareCount: shareCount ?? this.shareCount,
      commentCount: commentCount ?? this.commentCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
      followerCount: followerCount ?? this.followerCount,
    );
  }

  @override
  bool get stringify => true;
}
