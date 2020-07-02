import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/favourites/favourites_store.dart';
import 'package:samachar_hub/pages/favourites/widgets/add_list_item.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/widgets/mini_card_list_item.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FavouritesStore>(context, listen: false);
    _setupObserver(store);
    store.loadFollowedNewsSourceData();
    store.loadFollowedNewsCategoryData();
    store.loadFollowedNewsTopicData();
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

  Widget _buildViewAndManageButton({Function onTap}) {
    return FlatButton(
      onPressed: onTap,
      child: Text(
        'View all and Manage',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.blue),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildNewsSourcesList(FavouritesStore favouritesStore) {
    return StreamBuilder<List<NewsSourceModel>>(
      stream: favouritesStore.newsSourceFeedStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retryNewsSources();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          return LimitedBox(
            maxHeight: 100,
            child: ListView.builder(
              primary: false,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AddListItem(
                      context: context,
                      onTap: () {
                        Provider.of<NavigationService>(context, listen: false)
                            .toNewsSourceSelectionScreen(context: context);
                      });
                }

                var sourceModel = snapshot.data[index - 1];
                return MiniCardListItem(
                    context: context,
                    name: sourceModel.name,
                    icon: sourceModel.icon,
                    onTap: () {
                      Provider.of<NavigationService>(context, listen: false)
                          .toNewsSourceFeedScreen(context, sourceModel);
                    });
              },
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }

  Widget _buildNewsSourcesSection(FavouritesStore favouritesStore) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildSectionTitle('News Sources'),
            SizedBox(
              height: 8,
            ),
            Flexible(
                fit: FlexFit.loose,
                child: _buildNewsSourcesList(favouritesStore)),
            SizedBox(
              height: 8,
            ),
            Divider(),
            _buildViewAndManageButton(onTap: () {
              Provider.of<NavigationService>(context, listen: false)
                  .toFavouriteNewsSourceScreen(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCategoriesList(FavouritesStore favouritesStore) {
    return StreamBuilder<List<NewsCategoryModel>>(
      stream: favouritesStore.newsCategoryFeedStream,
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
          return LimitedBox(
            maxHeight: 100,
            child: ListView.builder(
              primary: false,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AddListItem(
                      context: context,
                      onTap: () {
                        Provider.of<NavigationService>(context, listen: false)
                            .toNewsCategorySelectionScreen(context);
                      });
                }

                var categoryModel = snapshot.data[index - 1];
                return MiniCardListItem(
                    context: context,
                    name: categoryModel.name,
                    icon: categoryModel.icon,
                    onTap: () {
                      Provider.of<NavigationService>(context, listen: false)
                          .toNewsCategoryScreen(context, categoryModel);
                    });
              },
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }

  Widget _buildNewsCategorySection(FavouritesStore favouritesStore) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildSectionTitle('News Categories'),
            SizedBox(
              height: 8,
            ),
            Flexible(
                fit: FlexFit.loose,
                child: _buildNewsCategoriesList(favouritesStore)),
            SizedBox(
              height: 8,
            ),
            Divider(),
            _buildViewAndManageButton(onTap: () {
              Provider.of<NavigationService>(context, listen: false)
                  .toFavouriteNewsCategoryScreen(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsTopicsList(FavouritesStore favouritesStore) {
    return StreamBuilder<NewsTopicModel>(
      stream: favouritesStore.newsTopicFeedStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                favouritesStore.retryNewsTopic();
              },
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.tags?.isEmpty ?? true) {
            return Center(child: EmptyDataView());
          }

          return Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List<Widget>.generate(
                snapshot.data.tags.length,
                (index) => NewsTagItem(
                      title: snapshot.data.tags[index],
                      onTap: (value) {
                        Provider.of<NavigationService>(context, listen: false)
                            .toNewsTopicScreen(title: value, context: context);
                      },
                    )),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }

  Widget _buildNewsTopicsSection(FavouritesStore favouritesStore) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildSectionTitle('News Topics'),
            SizedBox(
              height: 8,
            ),
            Flexible(
                fit: FlexFit.loose,
                child: _buildNewsTopicsList(favouritesStore)),
            SizedBox(
              height: 8,
            ),
            Divider(),
            _buildViewAndManageButton(onTap: () {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Consumer<FavouritesStore>(
        builder: (_, _favouriteskStore, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PageHeading(
                title: 'My Favourites',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: _buildNewsSourcesSection(_favouriteskStore)),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: _buildNewsCategorySection(_favouriteskStore)),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: _buildNewsTopicsSection(_favouriteskStore)),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
