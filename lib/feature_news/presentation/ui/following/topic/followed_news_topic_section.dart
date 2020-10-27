import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/news_topic_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/topic/followed_news_topic_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/section_title.dart';

class FollowedNewsTopicSection extends StatefulWidget {
  const FollowedNewsTopicSection({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsTopicSectionState createState() =>
      _FollowedNewsTopicSectionState();
}

class _FollowedNewsTopicSectionState extends State<FollowedNewsTopicSection> {
  NewsTopicBloc _newsTopicBloc = GetIt.I.get<NewsTopicBloc>();
  @override
  void initState() {
    super.initState();
    _newsTopicBloc.add(GetFollowedTopicsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _newsTopicBloc?.close();
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
              SectionTitle(
                context: context,
                title: 'News Topics',
                onRefreshTap: () {
                  _newsTopicBloc.add(GetFollowedTopicsEvent());
                },
              ),
              SizedBox(
                height: 8,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: BlocProvider<NewsTopicBloc>.value(
                  value: _newsTopicBloc,
                  child: FollowedNewsTopicList(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              // Divider(),
              // ViewAllButton(context: context, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
