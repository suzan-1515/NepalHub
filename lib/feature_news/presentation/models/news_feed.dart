import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsFeedUIModel extends Model {
  NewsFeedEntity _feedUIModel;

  NewsFeedUIModel(this._feedUIModel);

  set entity(NewsFeedEntity feedEntity) {
    this._feedUIModel = feedEntity;
    notifyListeners();
  }

  NewsFeedEntity get entity => this._feedUIModel;

  followSource() => this.entity = this.entity.copyWith(
      source: this.entity.source.copyWith(
          isFollowed: true,
          followerCount: this.entity.source.followerCount + 1));

  unFollowSource() => this.entity = this.entity.copyWith(
      source: this.entity.source.copyWith(
          isFollowed: false,
          followerCount: this.entity.source.followerCount - 1));

  bookmark() => this.entity = this.entity.copyWith(
      isBookmarked: true, bookmarkCount: this.entity.bookmarkCount + 1);

  unBookmark() => this.entity = this.entity.copyWith(
      isBookmarked: false, bookmarkCount: this.entity.bookmarkCount - 1);

  unLike() => this.entity = this
      .entity
      .copyWith(isLiked: false, likeCount: this.entity.likeCount - 1);
  like() => this.entity =
      this.entity.copyWith(isLiked: true, likeCount: this.entity.likeCount + 1);
}
