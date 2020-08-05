import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/news/category_store.dart';
import 'package:samachar_hub/pages/following/widgets/news_category_list_item.dart';
import 'package:samachar_hub/services/services.dart';

class FollowNewsCategoryList extends StatelessWidget {
  const FollowNewsCategoryList({
    Key key,
    @required this.data,
    @required this.store,
  }) : super(key: key);

  final List<NewsCategory> data;
  final FollowNewsCategoryStore store;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await store.refresh();
      },
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: data.length,
        itemBuilder: (context, index) {
          var categoryModel = data[index];
          return ValueListenableBuilder<bool>(
            valueListenable: categoryModel.followNotifier,
            builder: (context, value, child) => FollowedNewsCategoryListItem(
              title: categoryModel.name,
              icon: categoryModel.icon,
              onTap: () {
                context
                    .read<NavigationService>()
                    .toNewsCategoryFeedScreen(context, categoryModel);
              },
              onFollowTap: () {
                final currentValue = value;
                categoryModel.follow = !categoryModel.isFollowed;
                if (currentValue) {
                  store.unFollowedNewsCategory(categoryModel).catchError(
                      (onError) => categoryModel.follow = currentValue);
                } else {
                  store.followedNewsCategory(categoryModel).catchError(
                      (onError) => categoryModel.follow = currentValue);
                }
              },
              followers: categoryModel.followerCount,
              isSubscribed: value,
            ),
          );
        },
        separatorBuilder: (_, int index) => Divider(),
      ),
    );
  }
}
