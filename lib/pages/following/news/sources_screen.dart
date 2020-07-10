import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/pages/following/widgets/news_source_list_item.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';

class FollowingNewsSourceScreen extends StatefulWidget {
  @override
  _FollowingNewsSourceScreenState createState() =>
      _FollowingNewsSourceScreenState();
}

class _FollowingNewsSourceScreenState extends State<FollowingNewsSourceScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FollowingStore>(context, listen: false);
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

  Widget _buildSourceList(FollowingStore favouritesStore) {
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
              var sourceModel = snapshot.data[index];
              return FollowedNewsSourceListItem(
                title: sourceModel.name,
                icon: sourceModel.icon,
                onTap: () {
                  Provider.of<NavigationService>(context, listen: false)
                      .toNewsSourceFeedScreen(context, sourceModel);
                },
                onFollowTap: () {
                  context
                      .read<NavigationService>()
                      .toNewsSourceSelectionScreen(context: context);
                },
                followers: 200,
                isSubscribed: sourceModel.enabled.value,
              );
            },
            separatorBuilder: (_, int index) => Divider(),
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
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<FollowingStore>(
            builder: (_, _favouriteskStore, child) {
              return _buildSourceList(_favouriteskStore);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<NavigationService>()
              .toNewsSourceSelectionScreen(context: context)
              .then((value) {
            if (value) context.read<FollowingStore>().retryNewsSources();
          });
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
