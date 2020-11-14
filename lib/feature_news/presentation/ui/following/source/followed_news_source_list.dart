import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/news_source_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class FollowedNewsSourceList extends StatefulWidget {
  const FollowedNewsSourceList({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsSourceListState createState() => _FollowedNewsSourceListState();
}

class _FollowedNewsSourceListState extends State<FollowedNewsSourceList> {
  @override
  void initState() {
    super.initState();
    context.read<NewsSourceBloc>().add(GetFollowedSourcesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsSourceBloc, NewsSourceState>(
      listener: (context, state) {
        if (state is NewsSourceErrorState) {
          context.showMessage(state.message);
        } else if (state is NewsSourceLoadErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) => !(current is NewsSourceErrorState),
      builder: (context, state) {
        if (state is NewsSourceLoadSuccessState) {
          return FadeInUp(
            duration: Duration(milliseconds: 200),
            child: LimitedBox(
              maxHeight: 100,
              child: ListView.builder(
                primary: false,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemCount: state.sources.length,
                itemBuilder: (_, index) {
                  var source = state.sources[index];
                  return NewsMenuItem(
                    title: source.entity.title,
                    icon: source.entity.icon,
                    onTap: () {
                      Navigator.pushNamed(
                          context, NewsSourceFeedScreen.ROUTE_NAME,
                          arguments: source);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is NewsSourceLoadErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () {
                context.read<NewsSourceBloc>().add(GetFollowedSourcesEvent());
              },
            ),
          );
        } else if (state is NewsSourceLoadEmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
