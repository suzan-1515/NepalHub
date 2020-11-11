import 'package:flutter/material.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_detail/news_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/body.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/comment.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsDetailScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/news-detail';

  const NewsDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsFeedUIModel feedUIModel =
        ModalRoute.of(context).settings.arguments;
    return NewsProvider.detailMultiBlocProvider(
      feed: feedUIModel,
      child: ScopedModel<NewsFeedUIModel>(
        model: feedUIModel,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: BlocBuilder<NewsDetailBloc, NewsDetailState>(
              buildWhen: (previous, current) =>
                  !(current is NewsDetailErrorState),
              builder: (context, state) {
                if (state is NewsDetailInitialState) {
                  ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
                  return const NewsDetailBody();
                } else if (state is NewsDetailLoadSuccessState) {
                  ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
                  return const NewsDetailBody();
                } else if (state is NewsDetailLoadErrorState) {
                  return Center(
                    child: ErrorDataView(
                      onRetry: () => context
                          .read<NewsDetailBloc>()
                          .add(GetNewsDetailEvent()),
                      message: state.message,
                    ),
                  );
                } else if (state is NewsDetailEmptyState) {
                  return Center(
                    child: EmptyDataView(
                      text: state.message,
                    ),
                  );
                }

                return const Center(
                  child: const ProgressView(),
                );
              }),
          bottomNavigationBar: BottomAppBar(
            child: const NewsDetailComment(),
          ),
        ),
      ),
    );
  }
}

class NewsDetailScreenArgs {
  final NewsFeedUIModel newsFeedUIModel;
  final String feedId;

  NewsDetailScreenArgs({this.newsFeedUIModel, this.feedId});
}
