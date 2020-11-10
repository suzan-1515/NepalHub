import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsFilteringAppBar extends StatelessWidget {
  const NewsFilteringAppBar({
    Key key,
    @required this.body,
    @required this.header,
  }) : super(key: key);

  final Widget body;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
            leading: BackButton(
              color: Theme.of(context).textTheme.button.color,
            ),
            expandedHeight: 230,
            pinned: true,
            floating: true,
            snap: true,
            forceElevated: true,
            backgroundColor: Theme.of(context).backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: header,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: BlocBuilder<NewsFilterBloc, NewsFilterState>(
                builder: (context, state) => IgnorePointer(
                  ignoring: state is SourceLoadingState,
                  child: NewsFilterView(
                    sources: context.watch<NewsFilterBloc>().sources,
                    selectedSource:
                        context.watch<NewsFilterBloc>().selectedSource,
                    selectedSortby:
                        context.watch<NewsFilterBloc>().selectedSortBy,
                  ),
                ),
              ),
            )),
      ],
      body: body,
    );
  }
}
