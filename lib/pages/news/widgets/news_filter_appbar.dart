import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/domain/sort.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_widget.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_header.dart';

class NewsFilteringAppBar extends StatelessWidget {
  const NewsFilteringAppBar({
    Key key,
    @required this.child,
    @required this.title,
    @required this.icon,
    @required this.isFollowed,
    @required this.sources,
    @required this.onFollowTap,
    @required this.onSourceChanged,
    @required this.onSortByChanged,
    this.initialSortBy,
    this.initialSource,
  }) : super(key: key);

  final Widget child;
  final String title;
  final DecorationImage icon;
  final bool isFollowed;
  final List<NewsSourceModel> sources;
  final Function(bool) onFollowTap;
  final Function(NewsSourceModel) onSourceChanged;
  final Function(SortBy) onSortByChanged;
  final SortBy initialSortBy;
  final NewsSourceModel initialSource;

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
              background: NewsFilterHeader(
                icon: icon,
                isFollowed: isFollowed,
                onFollowTap: onFollowTap,
                title: title,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: NewsFilterView(
                onSortChanged: onSortByChanged,
                onSourceChanged: onSourceChanged,
                sources: sources,
                initialSortBy: initialSortBy,
                initialSource: initialSource,
              ),
            )),
      ],
      body: child,
    );
  }
}
