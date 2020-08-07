import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/news/source/widgets/news_source_list.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsSourcesScreen extends StatefulWidget {
  @override
  _NewsSourcesScreenState createState() => _NewsSourcesScreenState();
}

class _NewsSourcesScreenState extends State<NewsSourcesScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = context.read<NewsSourceStore>();
    _setupObserver(store);
    store.loadInitialData();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
    ];
  }

  Widget _buildSourceList(NewsSourceStore favouritesStore) {
    return StreamBuilder<List<NewsSource>>(
      stream: favouritesStore.dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {},
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(
                text: 'You are not following any news sources.',
              ),
            );
          }
          return NewsSourceList(data: snapshot.data, store: favouritesStore);
        }
        return Center(child: ProgressView());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Sources',
        ),
        leading: BackButton(
          onPressed: () {
            context.read<NewsSettingNotifier>().notify(NewsSetting.SOURCE);
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<NewsSourceStore>(
            builder: (_, _favouriteskStore, child) {
              return _buildSourceList(_favouriteskStore);
            },
          ),
        ),
      ),
    );
  }
}
