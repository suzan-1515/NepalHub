import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/widgets/news_category_horz_list_item.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_tag_item.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/widgets/mini_card_list_item.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage>
    with AutomaticKeepAliveClientMixin {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FollowingStore>(context, listen: false);
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

  Widget _buildNewsSourcesList(
      BuildContext context, FollowingStore favouritesStore) {
    return StreamBuilder<List<NewsSourceModel>>(
      stream: favouritesStore.newsSourceFeedStream,
      builder: (_, snapshot) {
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
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text(
                'You are not following any news sources.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
          }
          return LimitedBox(
            maxHeight: 100,
            child: ListView.builder(
              primary: false,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                var sourceModel = snapshot.data[index];
                return MiniCardListItem(
                    context: context,
                    name: sourceModel.name,
                    icon: sourceModel.icon,
                    onTap: () {
                      context
                          .read<NavigationService>()
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

  Widget _buildNewsSourcesSection(
      BuildContext context, FollowingStore favouritesStore) {
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
                child: _buildNewsSourcesList(context, favouritesStore)),
            SizedBox(
              height: 8,
            ),
            Divider(),
            _buildViewAndManageButton(onTap: () {
              context
                  .read<NavigationService>()
                  .toFavouriteNewsSourceScreen(context)
                  .whenComplete(() => favouritesStore.retryNewsSources());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCategoriesList(
      BuildContext context, FollowingStore favouritesStore) {
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
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text(
                'You are not following any categories.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
          }
          return LimitedBox(
            maxHeight: 100,
            child: ListView.builder(
              primary: false,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                var categoryModel = snapshot.data[index];
                return NewsCategoryHorzListItem(
                    context: context,
                    name: categoryModel.name,
                    icon: categoryModel.icon,
                    onTap: () {
                      context
                          .read<NavigationService>()
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

  Widget _buildNewsCategorySection(
      BuildContext context, FollowingStore favouritesStore) {
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
                child: _buildNewsCategoriesList(context, favouritesStore)),
            SizedBox(
              height: 8,
            ),
            Divider(),
            _buildViewAndManageButton(onTap: () {
              Provider.of<NavigationService>(context, listen: false)
                  .toFavouriteNewsCategoryScreen(context)
                  .whenComplete(() => favouritesStore.retryNewsCategory());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsTopicsList(FollowingStore favouritesStore) {
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

  Widget _buildNewsTopicsSection(
      BuildContext context, FollowingStore favouritesStore) {
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
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Consumer<FollowingStore>(
        builder: (_, _favouriteskStore, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PageHeading(
                title: 'Following',
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
                          child: _buildNewsSourcesSection(
                              context, _favouriteskStore)),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: _buildNewsCategorySection(
                              context, _favouriteskStore)),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: _buildNewsTopicsSection(
                              context, _favouriteskStore)),
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

  @override
  bool get wantKeepAlive => true;
}
