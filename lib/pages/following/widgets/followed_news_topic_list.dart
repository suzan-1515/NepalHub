import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';

class FollowedNewsTopicList extends StatelessWidget {
  const FollowedNewsTopicList({
    Key key,
    @required this.favouritesStore,
  }) : super(key: key);

  final FollowingStore favouritesStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewsTopic>>(
      stream: favouritesStore.newsTopicFeedStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retryNewsTopic();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(child: EmptyDataView());
          }

          return Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: snapshot.data
                .map((e) => NewsTagItem(
                      title: e.title,
                      onTap: (value) {
                        context.read<NavigationService>().toNewsTopicFeedScreen(
                            context: context, topicModel: e);
                      },
                    ))
                .toList(),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
