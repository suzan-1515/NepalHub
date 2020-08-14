import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_source_menu_item.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';

class FollowedNewsSourceList extends StatelessWidget {
  const FollowedNewsSourceList({
    Key key,
    @required this.context,
    @required this.favouritesStore,
  }) : super(key: key);

  final BuildContext context;
  final FollowingStore favouritesStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewsSource>>(
      stream: favouritesStore.newsSourceFeedStream,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retryNewsSources();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text(
                'You are not following any news sources.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
          }
          return LimitedBox(
            maxHeight: 100,
            child: ListView.builder(
              primary: false,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                var sourceModel = snapshot.data[index];
                return NewsSourceMenuItem(
                    source: sourceModel,
                    onTap: () {
                      context.read<NavigationService>().toNewsSourceFeedScreen(
                          context: context, source: sourceModel);
                    });
              },
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
