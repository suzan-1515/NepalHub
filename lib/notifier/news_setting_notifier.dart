import 'package:flutter/material.dart';

class NewsSettingNotifier extends ChangeNotifier {
  NewsSetting _setting;

  NewsSetting get setting => _setting;

  notify(NewsSetting setting) {
    this._setting = setting;
    notifyListeners();
  }
}

enum NewsSetting { SOURCE, CATEGORY }

// class FollowedNewsCategoryNotifier extends NewsSettingNotifier {}

// class FollowedNewsSourceNotifier extends ChangeNotifier {}
