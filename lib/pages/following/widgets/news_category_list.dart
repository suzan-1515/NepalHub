import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/news/category_store.dart';
import 'package:samachar_hub/pages/following/widgets/news_category_list_item.dart';
import 'package:samachar_hub/services/services.dart';

class FollowNewsCategoryList extends StatefulWidget {
  const FollowNewsCategoryList({
    Key key,
    @required this.data,
    @required this.store,
  }) : super(key: key);

  final List<NewsCategoryModel> data;
  final FollowNewsCategoryStore store;

  @override
  _FollowNewsCategoryListState createState() => _FollowNewsCategoryListState();
}

class _FollowNewsCategoryListState extends State<FollowNewsCategoryList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.store.refresh();
      },
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          var categoryModel = widget.data[index];
          return FollowedNewsCategoryListItem(
            title: categoryModel.name,
            icon: categoryModel.icon,
            onTap: () {
              context
                  .read<NavigationService>()
                  .toNewsCategoryScreen(context, categoryModel);
            },
            onFollowTap: () {
              if (categoryModel.isFollowed) {
                widget.store.unFollowedNewsCategory(categoryModel);
              } else {
                widget.store.followedNewsCategory(categoryModel);
              }
              setState(() {
                widget.data[index] = categoryModel.copyWith(
                    isFollowed: !categoryModel.isFollowed);
              });
            },
            followers: categoryModel.followerCount,
            isSubscribed: categoryModel.isFollowed,
          );
        },
        separatorBuilder: (_, int index) => Divider(),
      ),
    );
  }
}
