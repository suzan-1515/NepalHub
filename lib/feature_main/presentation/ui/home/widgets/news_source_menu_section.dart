import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsSourceMenuSection extends StatefulWidget {
  const NewsSourceMenuSection({
    Key key,
    @required this.homeUIModel,
  }) : super(key: key);

  final HomeUIModel homeUIModel;

  @override
  _NewsSourceMenuSectionState createState() => _NewsSourceMenuSectionState();
}

class _NewsSourceMenuSectionState extends State<NewsSourceMenuSection>
    with AutomaticKeepAliveClientMixin {
  NewsSourceBloc _newsSourceBloc;
  @override
  void initState() {
    super.initState();
    _newsSourceBloc = GetIt.I.get<NewsSourceBloc>();
    _newsSourceBloc.add(GetFollowedSourcesEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _newsSourceBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<NewsSourceBloc>.value(
      value: _newsSourceBloc,
      child: BlocConsumer<NewsSourceBloc, NewsSourceState>(
        listener: (context, state) {
          if (state is ErrorState || state is EmptyState) {
            widget.homeUIModel.showNewsSource = false;
          }
        },
        builder: (context, state) {
          if (state is LoadSuccessState) {
            widget.homeUIModel.showNewsSource = true;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SectionHeading(
                  title: 'Discover',
                  subtitle: 'Get the latest news on your favourite source',
                  onTap: () => GetIt.I
                      .get<NavigationService>()
                      .toFollowedNewsSourceScreen(context),
                ),
                LimitedBox(
                  maxHeight: 100,
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: ListView.builder(
                      itemExtent: 120,
                      primary: false,
                      itemCount: state.sources.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var sourceModel = state.sources[index];
                        return NewsMenuItem(
                          title: sourceModel.source.title,
                          icon: sourceModel.source.icon,
                          onTap: () => GetIt.I
                              .get<NavigationService>()
                              .toNewsSourceFeedScreen(
                                  context: context, source: sourceModel.source),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
