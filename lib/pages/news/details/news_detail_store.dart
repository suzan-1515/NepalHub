import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/share_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';

part 'news_detail_store.g.dart';

class NewsDetailStore = _NewsDetailStore with _$NewsDetailStore;

abstract class _NewsDetailStore with Store {
  final ShareService shareService;
  _NewsDetailStore(this.feed, this.shareService);

  final Feed feed;

  @observable
  String message;

  @action
  share() {
    shareService
        .share(title: feed.title, data: feed.link)
        .then((value) => message = 'Shared successfully.')
        .catchError((onError) => message = onError.toString());
  }
}
