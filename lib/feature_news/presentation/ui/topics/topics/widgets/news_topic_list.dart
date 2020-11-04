import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_topic/news_topic_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/widgets/news_topic_list_builder.dart';

class NewsTopicList extends StatefulWidget {
  const NewsTopicList({
    Key key,
  }) : super(key: key);

  @override
  _NewsTopicListState createState() => _NewsTopicListState();
}

class _NewsTopicListState extends State<NewsTopicList> {
  Completer<void> _refreshCompleter;
  NewsTopicBloc _newsTopicBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsTopicBloc = context.bloc<NewsTopicBloc>();
    _newsTopicBloc.add(GetTopicsEvent());
  }

  @override
  void dispose() {
    _refreshCompleter?.complete();
    super.dispose();
  }

  Future<void> _onRefresh() {
    _newsTopicBloc.add(RefreshTopicsEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsTopicBloc, NewsTopicState>(
      cubit: _newsTopicBloc,
      listenWhen: (previous, current) =>
          !(current is NewsTopicLoadingState) &&
          !(current is NewsTopicRefreshingState),
      listener: (context, state) {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
        if (state is NewsTopicLoadErrorState) {
          context.showMessage(state.message);
        } else if (state is NewsTopicErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) =>
          !(current is NewsTopicErrorState) &&
          !(current is NewsTopicRefreshingState),
      builder: (context, state) {
        if (state is NewsTopicLoadSuccessState) {
          return NewsTopicListBuilder(
            data: state.topics,
            onRefresh: _onRefresh,
          );
        } else if (state is NewsTopicLoadErrorState) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                _newsTopicBloc.add(GetTopicsEvent());
              },
            ),
          );
        } else if (state is NewsTopicLoadEmptyState) {
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
