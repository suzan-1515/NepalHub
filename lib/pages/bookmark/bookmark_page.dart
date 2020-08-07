import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/bookmark/widgets/bookmarked_news_list.dart';
import 'package:samachar_hub/stores/news/bookmark/bookmark_store.dart';
import 'package:samachar_hub/utils/extensions.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = context.read<BookmarkStore>();
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

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<BookmarkStore>(
            builder: (_, _bookmarkStore, child) {
              return BookmarkedNewsList(
                bookmarkStore: _bookmarkStore,
              );
            },
          ),
        ),
      ),
    );
  }
}
