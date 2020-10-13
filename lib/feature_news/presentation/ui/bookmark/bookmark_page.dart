import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_bookmarked_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_news_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/bookmark/widgets/bookmarked_news_list.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookmarkNewsBloc>(
      create: (context) => BookmarkNewsBloc(
        getBookmarkNewsUseCase: context.repository<GetBookmarkedNewsUseCase>(),
      )..add(GetBookmarkedNews()),
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
