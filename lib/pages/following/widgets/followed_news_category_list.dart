import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/news_category_horz_list_item.dart';

class FollowedNewsCategoryList extends StatelessWidget {
  const FollowedNewsCategoryList({
    Key key,
    @required this.context,
    @required this.favouritesStore,
  }) : super(key: key);

  final BuildContext context;
  final FollowingStore favouritesStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewsCategory>>(
      stream: favouritesStore.newsCategoryFeedStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retryNewsCategory();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text(
                'You are not following any categories.',
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
                var categoryModel = snapshot.data[index];
                return NewsCategoryHorzListItem(
                    context: context,
                    name: categoryModel.name,
                    icon: categoryModel.icon,
                    onTap: () {
                      context
                          .read<NavigationService>()
                          .toNewsCategoryFeedScreen(context, categoryModel);
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
