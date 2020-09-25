import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/related_news/related_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/related_news_list.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class RelatedNews extends StatelessWidget {
  const RelatedNews({Key key, @required this.feedUIModel})
      : assert(feedUIModel != null, 'Parent feed cannot be null'),
        super(key: key);
  final NewsFeedUIModel feedUIModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelatedNewsBloc, RelatedNewsState>(
        listener: (context, state) {
          if (state is LoadErrorState) {
            context.showMessage(state.message);
          }
        },
        buildWhen: (previous, current) =>
            (current is InitialState) ||
            (current is LoadingState) ||
            (current is LoadSuccessState),
        builder: (context, state) {
          if (state is LoadSuccessState) {
            return RelatedNewsList(
              data: state.feeds,
            );
          }

          return SizedBox.shrink();
        });
  }
}
