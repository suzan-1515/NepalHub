import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/pages/news/widgets/report_article.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/auth/auth_store.dart';

class NewsFeedMoreOption extends StatelessWidget {
  final NewsFeed feed;

  const NewsFeedMoreOption({
    Key key,
    @required this.feed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          leading: Icon(
            Icons.share,
            size: 18,
          ),
          title: Text(
            'Share',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
          ),
          onTap: () {
            final authStore = context.read<AuthenticationStore>();
            context
                .read<ShareService>()
                .share(postId: feed.uuid, title: feed.title, data: feed.link);
            if (authStore.isLoggedIn)
              context
                  .read<PostMetaRepository>()
                  .postShare(postId: feed.uuid, userId: authStore.user.uId);
            Navigator.pop(context);
          },
        ),
        ListTile(
          visualDensity: VisualDensity.compact,
          leading: Icon(
            Icons.open_in_browser,
            size: 18,
          ),
          title: Text(
            'Browse ${feed.source.name}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          visualDensity: VisualDensity.compact,
          leading: Icon(
            Icons.remove_circle_outline,
            size: 18,
          ),
          title: Text(
            'Block ${feed.source.name}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          visualDensity: VisualDensity.compact,
          leading: Icon(
            Icons.thumb_down,
            size: 18,
          ),
          title: Text(
            'Show less of such content',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ExpansionTile(
          leading: Icon(Icons.report),
          trailing: Icon(
            Icons.chevron_right,
            size: 18,
          ),
          title: Text(
            'Report',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
          ),
          children: [
            ReportArticle(
              articleId: feed.uuid,
              articleType: 'news',
            ),
          ],
        ),
      ],
    );
  }
}
