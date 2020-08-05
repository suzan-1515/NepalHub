import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/news/source_store.dart';
import 'package:samachar_hub/pages/following/widgets/news_source_list_item.dart';
import 'package:samachar_hub/services/services.dart';

class FollowNewsSourceList extends StatefulWidget {
  const FollowNewsSourceList({
    Key key,
    @required this.data,
    @required this.store,
  }) : super(key: key);

  final List<NewsSource> data;
  final FollowNewsSourceStore store;

  @override
  _FollowNewsSourceListState createState() => _FollowNewsSourceListState();
}

class _FollowNewsSourceListState extends State<FollowNewsSourceList> {
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
          var sourceModel = widget.data[index];
          return ValueListenableBuilder<bool>(
            valueListenable: sourceModel.followNotifier,
            builder: (context, value, child) => FollowedNewsSourceListItem(
              title: sourceModel.name,
              icon: sourceModel.icon,
              onTap: () {
                context.read<NavigationService>().toNewsSourceFeedScreen(
                    context: context,
                    source: sourceModel,
                    sources: widget.data);
              },
              onFollowTap: () {
                final currentValue = value;
                sourceModel.follow = !value;
                if (currentValue) {
                  widget.store.unFollowedNewsSource(sourceModel).catchError(
                      (onError) => sourceModel.follow = currentValue);
                } else {
                  widget.store.followedNewsSource(sourceModel).catchError(
                      (onError) => sourceModel.follow = currentValue);
                }
              },
              followers: sourceModel.followerCount,
              isSubscribed: sourceModel.isFollowed,
            ),
          );
        },
        separatorBuilder: (_, int index) => Divider(),
      ),
    );
  }
}
