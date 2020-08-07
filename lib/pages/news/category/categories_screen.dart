import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/news/category/widgets/news_category_list.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/news/category/category_store.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsCategoriesScreen extends StatefulWidget {
  @override
  _NewsCategoriesScreenState createState() => _NewsCategoriesScreenState();
}

class _NewsCategoriesScreenState extends State<NewsCategoriesScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = context.read<NewsCategoriesStore>();
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
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      })
    ];
  }

  Widget _buildCategoryList(NewsCategoriesStore favouritesStore) {
    return StreamBuilder<List<NewsCategory>>(
      stream: favouritesStore.dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retry();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(
                text: 'You are not following any news categories.',
              ),
            );
          }
          return NewsCategoryList(data: snapshot.data, store: favouritesStore);
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
          'News Categories',
        ),
        leading: BackButton(
          onPressed: () {
            context.read<NewsSettingNotifier>().notify(NewsSetting.CATEGORY);
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<NewsCategoriesStore>(
            builder: (_, _favouriteskStore, child) {
              return _buildCategoryList(_favouriteskStore);
            },
          ),
        ),
      ),
    );
  }
}
