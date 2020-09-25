import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/news_topic_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';
import 'package:samachar_hub/utils/extensions.dart';

class FollowedNewsTopicList extends StatefulWidget {
  const FollowedNewsTopicList({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsTopicListState createState() => _FollowedNewsTopicListState();
}

class _FollowedNewsTopicListState extends State<FollowedNewsTopicList> {
  NewsTopicBloc _newsTopicBloc;

  @override
  void initState() {
    super.initState();
    _newsTopicBloc = context.bloc<NewsTopicBloc>();
    _newsTopicBloc.add(GetFollowedTopicsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsTopicBloc, NewsTopicState>(
      cubit: _newsTopicBloc,
      listener: (context, state) {
        if (state is ErrorState) {
          context.showMessage(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadSuccessState) {
          return FadeInUp(
            duration: Duration(milliseconds: 200),
            child: LimitedBox(
              maxHeight: 100,
              child: ListView.builder(
                primary: false,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemCount: state.topics.length,
                itemBuilder: (_, index) {
                  var topicModel = state.topics[index];
                  return NewsMenuItem(
                    title: topicModel.topic.title,
                    icon: topicModel.topic.icon,
                    onTap: () {
                      context
                          .repository<NavigationService>()
                          .toNewsTopicFeedScreen(
                              context: context, topicModel: topicModel.topic);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is ErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () {
                _newsTopicBloc.add(GetFollowedTopicsEvent());
              },
            ),
          );
        } else if (state is EmptyState) {
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
