import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_widget.dart';
import 'package:samachar_hub/pages/news/widgets/news_following_widget.dart';

class NewsFilteringAppBar extends StatelessWidget {
  const NewsFilteringAppBar({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
            leading: BackButton(
              color: Theme.of(context).textTheme.button.color,
            ),
            expandedHeight: 210,
            pinned: true,
            floating: true,
            forceElevated: true,
            backgroundColor: Theme.of(context).backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: NewsFollowingHeader(),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: NewsFilter(),
            )),
      ],
      body: child,
    );
  }
}
