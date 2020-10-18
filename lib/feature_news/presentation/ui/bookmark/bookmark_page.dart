import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/bookmark/widgets/bookmarked_news_list.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsProvider.bookmarkBlocProvider(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Bookmarks'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BookmarkedNewsList(),
          ),
        ),
      ),
    );
  }
}
