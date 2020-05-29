import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/services.dart';

part 'news_detail_store.g.dart';

class NewsDetailStore = _NewsDetailStore with _$NewsDetailStore;

abstract class _NewsDetailStore with Store {
  final ShareService shareService;
  final UserModel user;

  _NewsDetailStore(this.shareService, this.user);

  @observable
  NewsFeedModel feed;

  @observable
  String message;

  @action
  setFeed(NewsFeedModel feed) {
    this.feed = feed;
  }

  dispose() {}
}
