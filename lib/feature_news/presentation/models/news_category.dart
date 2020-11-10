import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsCategoryUIModel extends Model {
  NewsCategoryEntity _categoryEntity;

  NewsCategoryUIModel(this._categoryEntity);

  set entity(NewsCategoryEntity categoryEntity) {
    this._categoryEntity = categoryEntity;
    notifyListeners();
  }

  NewsCategoryEntity get entity => this._categoryEntity;

  unFollow() => this.entity = this.entity.copyWith(
      isFollowed: false, followerCount: this.entity.followerCount - 1);

  follow() => this.entity = this
      .entity
      .copyWith(isFollowed: true, followerCount: this.entity.followerCount + 1);
}
