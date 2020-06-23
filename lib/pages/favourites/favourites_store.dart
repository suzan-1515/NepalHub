import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/favourites_repository.dart';

part 'favourites_store.g.dart';

class FavouritesStore = _FavouritesStore with _$FavouritesStore;

abstract class _FavouritesStore with Store {
  final FavouritesRepository _favouritesRepository;

  _FavouritesStore(
    this._favouritesRepository,
  );

  // List<NewsFeedModel> _feedData = List<NewsFeedModel>();

  static const int DATA_LIMIT = 20;

  bool _hasMoreData = false;
  bool _isLoadingMore = false;
  // StreamController<List<NewsFeedModel>> _feedStreamController =
  //     StreamController<List<NewsFeedModel>>.broadcast();

  // Stream<List<NewsFeedModel>> get feedStream => _feedStreamController.stream;

  @observable
  String error;

  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

  @action
  Future<void> loadData() async {
    // _favouritesRepository
    //     .getFavouritessAsStream(userId: userModel.uId)
    //     .where((data) => data != null)
    //     .listen((onData) {
    //   _feedData.clear();
    //   _feedData.addAll(onData);
    //   _feedStreamController.add(_feedData);
    //   _hasMoreData = onData.length == DATA_LIMIT;
    // }, onError: (e) {
    //   print(e.toString());
    //   _feedStreamController.addError(e);
    // });
  }

  dispose() {
    // _feedStreamController.close();
  }
}
