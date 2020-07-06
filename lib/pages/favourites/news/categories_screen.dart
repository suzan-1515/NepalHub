import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/favourites/favourites_store.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';

class FavouriteNewsCategoryScreen extends StatefulWidget {
  @override
  _FavouriteNewsCategoryScreenState createState() =>
      _FavouriteNewsCategoryScreenState();
}

class _FavouriteNewsCategoryScreenState
    extends State<FavouriteNewsCategoryScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FavouritesStore>(context, listen: false);
    _setupObserver(store);
    store.loadFollowedNewsCategoryData();
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

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
    ];
  }

  Widget _buildCategoryList(FavouritesStore favouritesStore) {
    return StreamBuilder<List<NewsCategoryModel>>(
      stream: favouritesStore.newsCategoryFeedStream,
      initialData: favouritesStore.categoryData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retryNewsCategory();
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
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var categoryModel = snapshot.data[index];
              return Material(
                child: ListTile(
                  onTap: () {
                    Provider.of<NavigationService>(context, listen: false)
                        .toNewsCategoryScreen(context, categoryModel);
                  },
                  leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                            ),
                          ],
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Icon(
                        categoryModel.icon,
                        size: 32,
                        color: Theme.of(context).accentColor.withOpacity(.8),
                      )),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoryModel.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  trailing: Opacity(
                      opacity: 0.6,
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.ellipsisV),
                        onPressed: () {},
                      )),
                ),
              );
            },
          );
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
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<FavouritesStore>(
            builder: (_, _favouriteskStore, child) {
              return _buildCategoryList(_favouriteskStore);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<NavigationService>()
              .toNewsCategorySelectionScreen(context)
              .then((value) {
            if (!value) context.read<FavouritesStore>().retryNewsCategory();
          });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
