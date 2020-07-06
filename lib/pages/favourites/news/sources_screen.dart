import 'package:cached_network_image/cached_network_image.dart';
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

class FavouriteNewsSourceScreen extends StatefulWidget {
  @override
  _FavouriteNewsSourceScreenState createState() =>
      _FavouriteNewsSourceScreenState();
}

class _FavouriteNewsSourceScreenState extends State<FavouriteNewsSourceScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FavouritesStore>(context, listen: false);
    _setupObserver(store);
    store.loadFollowedNewsSourceData();
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

  Widget _buildSourceList(FavouritesStore favouritesStore) {
    return StreamBuilder<List<NewsSourceModel>>(
      stream: favouritesStore.newsSourceFeedStream,
      initialData: favouritesStore.sourceData,
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
          return ListView.separated(
            itemCount: snapshot.data.length,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              var categoryModel = snapshot.data[index];
              return Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () {
                    Provider.of<NavigationService>(context, listen: false)
                        .toNewsSourceFeedScreen(context, categoryModel);
                  },
                  leading: Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: CachedNetworkImage(
                      imageUrl: categoryModel.icon,
                      errorWidget: (context, url, error) => Opacity(
                          opacity: 0.7,
                          child: Icon(FontAwesomeIcons.exclamationCircle)),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoryModel.name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  trailing: Opacity(
                      opacity: 0.6,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.ellipsisV,
                          size: 18,
                        ),
                        onPressed: () {
                          context
                              .read<NavigationService>()
                              .toNewsSourceSelectionScreen(context: context);
                        },
                      )),
                ),
              );
            },
            separatorBuilder: (_, int index) {
              return Divider();
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
          'News Sources',
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Consumer<FavouritesStore>(
              builder: (_, _favouriteskStore, child) {
                return _buildSourceList(_favouriteskStore);
              },
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<NavigationService>()
              .toNewsSourceSelectionScreen(context: context)
              .then((value) {
            if (!value) context.read<FavouritesStore>().retryNewsSources();
          });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
