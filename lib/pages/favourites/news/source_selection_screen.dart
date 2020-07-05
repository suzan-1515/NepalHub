import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/favourites/news/news_source_selection_item.dart';
import 'package:samachar_hub/pages/favourites/news/source_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class NewsSourceSelectionScreen extends StatefulWidget {
  @override
  _NewsSourceSelectionScreenState createState() =>
      _NewsSourceSelectionScreenState();
}

class _NewsSourceSelectionScreenState extends State<NewsSourceSelectionScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<FavouriteNewsSourceStore>(context, listen: false);
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
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      })
    ];
  }

  Widget _buildList(FavouriteNewsSourceStore store) {
    return StreamBuilder<List<NewsSourceModel>>(
      stream: store.dataStream,
      builder: (_, AsyncSnapshot<List<NewsSourceModel>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () => store.retry(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 16 / 9,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0),
            itemCount: snapshot.data.length,
            itemBuilder: (_, int index) {
              var categoryModel = snapshot.data[index];
              return NewsSourceSelectionItem(
                icon: categoryModel.icon,
                name: categoryModel.name,
                isSelected: categoryModel.enabled.value,
                onTap: (value) {
                  log('Source ${categoryModel.name} selection status: $value');
                },
              );
            },
          );
        }
        return Center(child: ProgressView());
      },
    );
  }

  Widget _buildHeader() {
    return RichText(
      text: TextSpan(
        text: 'Choose News Sources',
        style: Theme.of(context).textTheme.headline6,
        children: <TextSpan>[
          TextSpan(
            text: '\nPlease select at least 3 news sources',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Sources'),
        leading: BackButton(
          onPressed: () {
            Provider.of<FavouriteNewsSourceStore>(context, listen: false)
                .updateFollowedNewsSources();
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).backgroundColor,
          child: Consumer<FavouriteNewsSourceStore>(builder: (_, store, __) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverToBoxAdapter(child: _buildHeader())),
              ],
              body: _buildList(store),
            );
          }),
        ),
      ),
    );
  }
}
