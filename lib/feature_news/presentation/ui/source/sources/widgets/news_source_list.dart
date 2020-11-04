import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/widgets/news_source_list_builder.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsSourceList extends StatefulWidget {
  const NewsSourceList({
    Key key,
  }) : super(key: key);

  @override
  _NewsSourceListState createState() => _NewsSourceListState();
}

class _NewsSourceListState extends State<NewsSourceList> {
  Completer<void> _refreshCompleter;
  NewsSourceBloc _newsSourceBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsSourceBloc = context.bloc<NewsSourceBloc>();
    _newsSourceBloc.add(GetSourcesEvent());
  }

  @override
  void dispose() {
    _refreshCompleter?.complete();
    super.dispose();
  }

  Future<void> _onRefresh() {
    _newsSourceBloc.add(RefreshSourceEvent());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsSourceBloc, NewsSourceState>(
      cubit: _newsSourceBloc,
      listenWhen: (previous, current) =>
          !(current is NewsSourceLoadingState) &&
          !(current is NewsSourceRefreshingState),
      listener: (context, state) {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
        if (state is NewsSourceLoadErrorState) {
          context.showMessage(state.message);
        } else if (state is NewsSourceErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) =>
          !(current is NewsSourceErrorState) &&
          !(current is NewsSourceRefreshingState),
      builder: (context, state) {
        if (state is NewsSourceLoadSuccessState) {
          return NewsSourceListBuilder(
            data: state.sources,
            onRefresh: _onRefresh,
          );
        } else if (state is NewsSourceLoadErrorState) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                _newsSourceBloc.add(GetSourcesEvent());
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
