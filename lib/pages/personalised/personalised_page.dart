import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_type_list_view/multi_type_list_view.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/personalised/personalised_item_builder.dart';
import 'package:samachar_hub/pages/personalised/personalised_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class PersonalisedPage extends StatefulWidget {
  @override
  _PersonalisedPageState createState() => _PersonalisedPageState();
}

class _PersonalisedPageState extends State<PersonalisedPage>
    with AutomaticKeepAliveClientMixin {
// Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<PersonalisedFeedStore>(context, listen: false);
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
      Scaffold.of(context).showSnackBar(
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

  Widget _buildList() {
    return Consumer<PersonalisedFeedStore>(
        builder: (context, personalisedStore, child) {
      return StreamBuilder<List>(
          stream: personalisedStore.dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: ErrorDataView(
                  onRetry: () => personalisedStore.retry(),
                ),
              );
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: ProgressView());
              default:
                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(
                    child: EmptyDataView(
                      onRetry: () => personalisedStore.retry(),
                    ),
                  );
                }
                return RefreshIndicator(
                  child: MultiTypeListView(
                    items: snapshot.data,
                    widgetBuilders: <MultiTypeWidgetBuilder>[
                      SectionHeadingItemBuilder(),
                      NewsCategoryMenuItemBuilder(),
                      NewsSourceMenuItemBuilder(),
                      NewsTagsItemBuilder(),
                      LatestFeedItemBuilder(),
                      ProgressItemBuilder(),
                      EmptyItemBuilder(
                          onRetry: () => personalisedStore.refresh()),
                      ErrorItemBuilder(
                          onRetry: () => personalisedStore.retry()),
                    ],
                    showDebugPlaceHolder: true,
                  ),
                  onRefresh: () async => await personalisedStore.refresh(),
                );
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PageHeading(
            title: 'Top Stories',
          ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
