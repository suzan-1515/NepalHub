import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/service/article_service.dart';

part 'article_store.g.dart';

class ArticleStore = _ArticleStore with _$ArticleStore;

abstract class _ArticleStore with Store {
  _ArticleStore(this.article) : _articleService = ArticleService();

  final ArticleService _articleService;
  final Feed article;

  @observable
  String message;

  @action
  share() {
    if (null != article.link)
      try {
        _articleService.shareArticle(article.title, article.link);
      } on Exception catch (e) {
        message = 'Error - ' + e.toString();
      }
  }

  @action
  openLink() {
    if (null != article.link)
      try {
        _articleService.openLink(article.link);
      } on Exception catch (e) {
        message = 'Error - ' + e.toString();
      }
  }

}
