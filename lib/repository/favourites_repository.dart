import 'dart:developer';

import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/favourites_firestore_service.dart';
import 'package:samachar_hub/services/services.dart';

class FavouritesRepository {
  final FavouritesFirestoreService _favouritesService;
  final AnalyticsService _analyticsService;
  final PreferenceService _preferenceService;

  FavouritesRepository(
      this._favouritesService, this._analyticsService, this._preferenceService);

  Future<void> followSource(NewsSourceModel sourceModel) {
    if (sourceModel == null) return Future.value();
    var followedSources = _preferenceService.followedNewsSources;
    followedSources.remove(sourceModel.code);
    _preferenceService.followedNewsSources = followedSources;
    _analyticsService.logNewsSourceFollowed(sourceCode: sourceModel.code);
  }

  Future<void> unFollowSource(NewsSourceModel sourceModel) {
    if (sourceModel == null) return Future.value();
    var followedSources = _preferenceService.followedNewsSources;
    followedSources.add(sourceModel.code);
    _preferenceService.followedNewsSources = followedSources;
    _analyticsService.logNewsSourceUnFollowed(sourceCode: sourceModel.code);
  }

  Future<void> followSources(List<NewsSourceModel> sourceModel) {
    if (sourceModel == null || sourceModel.isEmpty) return Future.value();
    var followedSources = _preferenceService.followedNewsSources;
    sourceModel.map(
        (e) => followedSources.removeWhere((element) => element == e.code));
    _preferenceService.followedNewsSources = followedSources;
    _analyticsService.logNewsSourceFollowed(sourceCodes: followedSources);
  }

  Future<void> unFollowSources(List<NewsSourceModel> sourceModel) async {
    if (sourceModel != null) {
      _preferenceService.followedNewsSources =
          sourceModel.map((e) => e.code).toList();
    }
  }

  Future<void> followCategory(NewsCategoryModel categoriesModel) {
    if (categoriesModel == null) return Future.value();
    var followedCategories = _preferenceService.followedNewsCategories;
    followedCategories.remove(categoriesModel.code);
    _preferenceService.followedNewsCategories = followedCategories;
    _analyticsService.logNewsCategoryFollowed(sourceCode: categoriesModel.code);
  }

  Future<void> unFollowCategory(NewsCategoryModel categoriesModel) {
    if (categoriesModel == null) return Future.value();
    var followedCategories = _preferenceService.followedNewsCategories;
    followedCategories.add(categoriesModel.code);
    _preferenceService.followedNewsCategories = followedCategories;
    _analyticsService.logNewsCategoryUnFollowed(
        categoryCode: categoriesModel.code);
  }

  Future<void> followCategories(List<NewsCategoryModel> categoriesModel) {
    if (categoriesModel == null || categoriesModel.isEmpty)
      return Future.value();
    var followedCategories = _preferenceService.followedNewsCategories;
    categoriesModel.map(
        (e) => followedCategories.removeWhere((element) => element == e.code));
    _preferenceService.followedNewsCategories = followedCategories;
    _analyticsService.logNewsCategoryFollowed(sourceCodes: followedCategories);
  }

  Future<void> unFollowCategories(
      List<NewsCategoryModel> categoriesModel) async {
    if (categoriesModel != null) {
      _preferenceService.followedNewsCategories =
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
