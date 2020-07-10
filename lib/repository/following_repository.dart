import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/following_firestore_service.dart';
import 'package:samachar_hub/services/services.dart';

class FollowingRepository {
  final FollowingFirestoreService _favouritesService;
  final AnalyticsService _analyticsService;
  final PreferenceService _preferenceService;

  FollowingRepository(
      this._favouritesService, this._analyticsService, this._preferenceService);

  Future<void> followSource(NewsSourceModel sourceModel) async {
    if (sourceModel == null) return Future.value();
    var followedSources = _preferenceService.unFollowedNewsSources;
    followedSources.remove(sourceModel.code);
    _preferenceService.unFollowedNewsSources = followedSources;
    _analyticsService.logNewsSourceFollowed(sourceCode: sourceModel.code);
  }

  Future<void> unFollowSource(NewsSourceModel sourceModel) async {
    if (sourceModel == null) return Future.value();
    var followedSources = _preferenceService.unFollowedNewsSources;
    followedSources.add(sourceModel.code);
    _preferenceService.unFollowedNewsSources = followedSources;
    _analyticsService.logNewsSourceUnFollowed(sourceCode: sourceModel.code);
  }

  Future<void> unFollowSources(List<NewsSourceModel> sourceModel) async {
    if (sourceModel != null) {
      _preferenceService.unFollowedNewsSources =
          sourceModel.map((e) => e.code).toList();
    }
  }

  Future<void> followCategory(NewsCategoryModel categoryModel) async {
    if (categoryModel == null) return Future.value();
    var unFollowedCategories = _preferenceService.unFollowedNewsCategories;
    unFollowedCategories.remove(categoryModel.code);
    _preferenceService.unFollowedNewsCategories = unFollowedCategories;
    _analyticsService.logNewsCategoryFollowed(sourceCode: categoryModel.code);
  }

  Future<void> unFollowCategory(NewsCategoryModel categoryModel) async {
    if (categoryModel == null) return Future.value();
    var unFollowedCategories = _preferenceService.unFollowedNewsCategories;
    unFollowedCategories.add(categoryModel.code);
    _preferenceService.unFollowedNewsCategories = unFollowedCategories;
    _analyticsService.logNewsCategoryUnFollowed(
        categoryCode: categoryModel.code);
  }

  Future<void> unFollowCategories(
      List<NewsCategoryModel> categoriesModel) async {
    if (categoriesModel != null) {
      _preferenceService.unFollowedNewsCategories =
          categoriesModel.map((e) => e.code).toList();
    }
  }

  Future<void> followTopic(String topic) async {
    if (topic != null) {
      var followedTopics = _preferenceService.followedNewsTopics;
      followedTopics.add(topic);
      _preferenceService.followedNewsTopics = followedTopics;
      _analyticsService.logNewsTopicFollowed(topic: topic);
    }
  }

  Future<void> unFollowTopic(String topic) async {
    if (topic != null) {
      var followedTopics = _preferenceService.followedNewsTopics;
      followedTopics.remove(topic);
      _preferenceService.followedNewsTopics = followedTopics;
      _analyticsService.logNewsTopicUnFollowed(topic: topic);
    }
  }

  Future<NewsTopicModel> getFollowedTopics({String userId}) {
    return Future.value(_preferenceService.followedNewsTopics)
        .then((value) => NewsTopicModel(value));
  }
}
