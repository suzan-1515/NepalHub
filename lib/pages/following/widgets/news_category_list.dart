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
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        var categoryModel = widget.data[index];
        return FollowedNewsCategoryListItem(
          title: categoryModel.name,
          icon: categoryModel.icon,
          onTap: () {
            Provider.of<NavigationService>(context, listen: false)
                .toNewsCategoryScreen(context, categoryModel);
          },
          onFollowTap: () {
            if (categoryModel.enabled.value) {
              widget.store.unFollowedNewsCategory(categoryModel);
            } else {
              widget.store.followedNewsCategory(categoryModel);
            }
            setState(() {
              categoryModel.enabled.value = !categoryModel.enabled.value;
            });
          },
          followers: 200,
          isSubscribed: categoryModel.enabled.value,
        );
      },
      separatorBuilder: (_, int index) => Divider(),
    );
  }
}
