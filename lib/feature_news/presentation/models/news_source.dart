import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsSourceUIModel extends Model {
  NewsSourceEntity _sourceUIModel;

  NewsSourceUIModel(this._sourceUIModel);

  set entity(NewsSourceEntity categoryEntity) {
    this._sourceUIModel = categoryEntity;
    notifyListeners();
  }

  NewsSourceEntity get entity => this._sourceUIModel;

  unFollow() => this.entity = this.entity.copyWith(
      isFollowed: false, followerCount: this.entity.followerCount - 1);

  follow() => this.entity = this
      .entity
      .copyWith(isFollowed: true, followerCount: this.entity.followerCount + 1);
}
