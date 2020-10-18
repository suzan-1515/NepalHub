import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NewsProvider.sourceBlocProvider(
      child: BlocConsumer<NewsSourceBloc, NewsSourceState>(
        listener: (context, state) {
          if (state is InitialState) {
            context.bloc<NewsSourceBloc>().add(GetFollowedSourcesEvent());
          } else if (state is ErrorState || state is EmptyState) {
            widget.homeUIModel.shouldShowNewsSourceSection = false;
          }
        },
        builder: (context, state) {
          if (state is LoadSuccessState) {
            widget.homeUIModel.shouldShowNewsSourceSection = true;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SectionHeading(
                  title: 'Discover',
                  subtitle: 'Get the latest news on your favourite source',
                  onTap: () => context
                      .repository<NavigationService>()
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
                          onTap: () => context
                              .repository<NavigationService>()
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
