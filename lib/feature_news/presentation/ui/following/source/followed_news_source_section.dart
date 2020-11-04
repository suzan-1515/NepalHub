import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/source/followed_news_source_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/section_title.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/view_all_button.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class FollowedNewsSourceSection extends StatelessWidget {
  const FollowedNewsSourceSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.sourceBlocProvider(
      child: FadeInUp(
        duration: Duration(milliseconds: 200),
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SectionTitle(
                  context: context,
                  title: 'News Sources',
                  onRefreshTap: () {
                    context
                        .bloc<NewsSourceBloc>()
                        .add(GetFollowedSourcesEvent());
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: FollowedNewsSourceList(),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                ViewAllButton(
                    context: context,
                    onTap: () {
                      GetIt.I
                          .get<NavigationService>()
                          .toFollowedNewsSourceScreen(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
