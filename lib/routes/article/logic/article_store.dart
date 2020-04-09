import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/model/article.dart';
import 'package:samachar_hub/routes/article/logic/article_service.dart';

part 'article_store.g.dart';

class ArticleStore = _ArticleStore with _$ArticleStore;

abstract class _ArticleStore with Store {
  _ArticleStore(this.article) : _articleService = ArticleService();

  final ArticleService _articleService;
  final Article article;

  @observable
  String message;

  @action
  share() {
    if (null != article.url)
      try {
        _articleService.shareArticle(article.title, article.url);
      } on Exception catch (e) {
        message = 'Error - ' + e.toString();
      }
  }

  @action
  openLink() {
    if (null != article.url)
      try {
        _articleService.openLink(article.url);
      } on Exception catch (e) {
        message = 'Error - ' + e.toString();
      }
  }
}
