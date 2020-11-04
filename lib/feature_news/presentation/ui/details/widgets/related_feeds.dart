import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/related_news/related_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/related_news_list.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class RelatedNews extends StatelessWidget {
  const RelatedNews({Key key, @required this.feed})
      : assert(feed != null, 'Parent feed cannot be null'),
        super(key: key);
  final NewsFeedEntity feed;
  @override
  Widget build(BuildContext context) {
    return NewsProvider.relatedNewsBlocProvider(
      feed: feed,
      child: BlocConsumer<RelatedNewsBloc, RelatedNewsState>(
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
          }),
    );
  }
}
