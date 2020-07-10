import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/following/news/category_store.dart';
import 'package:samachar_hub/pages/following/news/news_category_selection_item.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class NewsCategorySelectionScreen extends StatefulWidget {
  @override
  _NewsCategorySelectionScreenState createState() =>
      _NewsCategorySelectionScreenState();
}

class _NewsCategorySelectionScreenState
    extends State<NewsCategorySelectionScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  final ValueNotifier<int> shouldSaveNotifier = ValueNotifier<int>(-1);

  @override
  void initState() {
    final store = Provider.of<FollowNewsCategoryStore>(context, listen: false);
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
    shouldSaveNotifier.dispose();
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

  Widget _buildList(FollowNewsCategoryStore store) {
    return StreamBuilder<List<NewsCategoryModel>>(
      stream: store.dataStream,
      builder: (_, AsyncSnapshot<List<NewsCategoryModel>> snapshot) {
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
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0),
            itemCount: snapshot.data.length,
            itemBuilder: (_, int index) {
              var categoryModel = snapshot.data[index];
              return NewsCategorySelectionItem(
                icon: categoryModel.icon,
                name: categoryModel.name,
                isSelected: categoryModel.enabled.value,
                onTap: (value) {
                  categoryModel.enabled.value = value;
                  if (shouldSaveNotifier.value != 0)
                    shouldSaveNotifier.value = 0;
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
        text: 'Choose News Categories',
        style: Theme.of(context).textTheme.headline6,
        children: <TextSpan>[
          TextSpan(
            text: '\nPlease select at least 3 news categories',
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
        title: Text('News Categories'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(shouldSaveNotifier.value == 1);
          },
        ),
        actions: <Widget>[
          ValueListenableBuilder(
            valueListenable: shouldSaveNotifier,
            builder: (_, value, __) {
              return IgnorePointer(
                ignoring: value != 0,
                child: Opacity(
                  opacity: value == 0 ? 1 : .4,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.check,
                      size: 22,
                    ),
                    onPressed: () {
                      var store = context.read<FollowNewsCategoryStore>();
                      store.updateFollowedNewsCategory().whenComplete(() {
                        shouldSaveNotifier.value = 1;
                        context
                            .read<NewsSettingNotifier>()
                            .notify(NewsSetting.CATEGORY);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).backgroundColor,
          child: Consumer<FollowNewsCategoryStore>(builder: (_, store, __) {
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
