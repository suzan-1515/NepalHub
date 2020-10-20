import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/source/followed_news_source_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/section_title.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/view_all_button.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class FollowedNewsSourceSection extends StatefulWidget {
  const FollowedNewsSourceSection({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsSourceSectionState createState() =>
      _FollowedNewsSourceSectionState();
}

class _FollowedNewsSourceSectionState extends State<FollowedNewsSourceSection> {
  NewsSourceBloc _newsSourceBloc;
  @override
  void initState() {
    super.initState();
    _newsSourceBloc = NewsProvider.sourceBlocProvider(context: context);
    _newsSourceBloc.add(GetFollowedSourcesEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _newsSourceBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
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
              SectionTitle(context: context, title: 'News Sources'),
              SizedBox(
                height: 8,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: BlocProvider<NewsSourceBloc>.value(
                  value: _newsSourceBloc,
                  child: FollowedNewsSourceList(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              ViewAllButton(
                  context: context,
                  onTap: () {
                    context
                        .repository<NavigationService>()
                        .toFollowedNewsSourceScreen(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
