import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/news/news_detail_service.dart';

part 'news_detail_store.g.dart';

class NewsDetailStore = _NewsDetailStore with _$NewsDetailStore;

abstract class _NewsDetailStore with Store {
  _NewsDetailStore(this.feed, this._newsDetailService);

  final NewsDetailService _newsDetailService;
  final Feed feed;

  @observable
  String message;

  @action
  share() {
    if (null != feed.link)
      try {
        _newsDetailService.shareArticle(feed.title, feed.link);
      } on Exception catch (e) {
        message = 'Error - ' + e.toString();
      }
  }

  @action
  openLink() {
    if (null != feed.link)
      try {
        _newsDetailService.openLink(feed.link);
      } on Exception catch (e) {
        message = 'Error - ' + e.toString();
      }
  }
}
