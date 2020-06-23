import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_list_item.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_store.dart';
import 'package:samachar_hub/pages/favourites/favourites_store.dart';
import 'package:samachar_hub/pages/news/sources/news_source_store.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<NewsSourceStore>(context, listen: false);
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
      child: Text('View all and Manage'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildAddItem({Function onTap}) {
    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Theme.of(context).accentColor.withOpacity(.7),
                  size: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsSourceItem(
      NewsSourceModel sourceModel, NewsSourceStore _sourceStore) {
    return Card(
      elevation: 1,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: sourceModel.icon,
                errorWidget: (context, url, error) => Opacity(
                    opacity: 0.7,
                    child: Icon(FontAwesomeIcons.exclamationCircle)),
                progressIndicatorBuilder: (context, url, progress) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sourceModel.name,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .color
                        .withOpacity(.6)),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsSourcesList(FavouritesStore favouritesStore) {
    return Consumer<NewsSourceStore>(
      builder: (_, _sourceStore, child) {
        return StreamBuilder<List<NewsSourceModel>>(
          stream: _sourceStore.dataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: ErrorDataView(
                  onRetry: () {
                    _sourceStore.retry();
                  },
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Center(child: EmptyDataView());
              }

              return LimitedBox(
                maxHeight: 100,
                child: ListView.builder(
                  primary: false,
                  itemExtent: 120,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildAddItem(onTap: () {});
                    }
                    return _buildNewsSourceItem(
                        snapshot.data[index-1], _sourceStore);
                  },
                ),
              );
            }
            return Center(child: ProgressView());
          },
        );
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
            _buildViewAndManageButton(onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCategorySection(FavouritesStore favouritesStore) {}
  Widget _buildNewsTopicsSection(FavouritesStore favouritesStore) {}

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
                          child: _buildNewsSourcesSection(_favouriteskStore)),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: _buildNewsSourcesSection(_favouriteskStore)),
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
