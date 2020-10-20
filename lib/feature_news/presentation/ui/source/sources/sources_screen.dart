import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/widgets/news_source_list.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsSourcesScreen extends StatefulWidget {
  @override
  _NewsSourcesScreenState createState() => _NewsSourcesScreenState();
}

class _NewsSourcesScreenState extends State<NewsSourcesScreen> {
  NewsSourceBloc _newsSourceBloc;
  @override
  void initState() {
    super.initState();
    _newsSourceBloc = NewsProvider.sourceBlocProvider(context: context);
    _newsSourceBloc.add(GetSourcesEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _newsSourceBloc?.close();
  }

  Widget _buildSourceList() {
    return BlocConsumer<NewsSourceBloc, NewsSourceState>(
        listener: (context, state) {
      if (state is InitialState) {
        context.bloc<NewsSourceBloc>().add(GetSourcesEvent());
      } else if (state is ErrorState) {
        context.showMessage(state.message);
      }
    }, builder: (context, state) {
      if (state is LoadSuccessState) {
        return NewsSourceList(data: state.sources);
      } else if (state is ErrorState) {
        return Center(
          child: ErrorDataView(
            onRetry: () {
              context.bloc<NewsSourceBloc>().add(GetSourcesEvent());
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsSourceBloc>.value(
      value: _newsSourceBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News Sources',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: _buildSourceList(),
          ),
        ),
      ),
    );
  }
}
