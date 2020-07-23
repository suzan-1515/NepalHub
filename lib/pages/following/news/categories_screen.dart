import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/following/news/category_store.dart';
import 'package:samachar_hub/pages/following/widgets/news_category_list.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class FollowingNewsCategoryScreen extends StatefulWidget {
  @override
  _FollowingNewsCategoryScreenState createState() =>
      _FollowingNewsCategoryScreenState();
}

class _FollowingNewsCategoryScreenState
    extends State<FollowingNewsCategoryScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FollowNewsCategoryStore>(context, listen: false);
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

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(
            apiError: apiError,
          );
        },
      );
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      })
    ];
  }

  Widget _buildCategoryList(FollowNewsCategoryStore favouritesStore) {
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
          return FollowNewsCategoryList(
              data: snapshot.data, store: favouritesStore);
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
          child: Consumer<FollowNewsCategoryStore>(
            builder: (_, _favouriteskStore, child) {
              return _buildCategoryList(_favouriteskStore);
            },
          ),
        ),
      ),
    );
  }
}
