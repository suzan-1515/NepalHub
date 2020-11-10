import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/widgets/news_topic_list_item.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsTopicListBuilder extends StatelessWidget {
  const NewsTopicListBuilder({
    Key key,
    @required this.data,
    @required this.onRefresh,
  }) : super(key: key);

  final List<NewsTopicUIModel> data;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FadeInUp(
        duration: Duration(milliseconds: 200),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: data.length,
          itemBuilder: (context, index) => NewsProvider.topicItemBlocProvider(
            child: ScopedModel<NewsTopicUIModel>(
              model: data[index],
              child: BlocListener<TopicFollowUnFollowBloc,
                  TopicFollowUnFollowState>(
                listener: (context, state) {
                  if (state is TopicFollowSuccessState) {
                    ScopedModel.of<NewsTopicUIModel>(context).entity =
                        state.topic;
                  } else if (state is TopicUnFollowSuccessState) {
                    ScopedModel.of<NewsTopicUIModel>(context).entity =
                        state.topic;
                  }
                },
                child: const NewsTopicListItem(),
              ),
            ),
          ),
          separatorBuilder: (_, int index) => Divider(),
        ),
      ),
    );
  }
}
