import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/bookmarks/bookmark_unbookmark/bookmark_un_bookmark_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_detail/news_detail_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/share/share_bloc.dart'
    as shareBloc;
import 'package:samachar_hub/feature_news/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/author_and_bookmark.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/disclaimer.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/read_more.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/related_feeds.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/share.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/source.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:scoped_model/scoped_model.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<ViewBloc, ViewState>(
          listener: (context, state) {
            if (state is ViewSuccess) {
              ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
            }
          },
        ),
        BlocListener<shareBloc.ShareBloc, shareBloc.ShareState>(
          listener: (context, state) {
            if (state is shareBloc.ShareSuccess) {
              ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
            }
          },
        ),
        BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
          listener: (context, state) {
            if (state is NewsLikeSuccessState) {
              ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
            } else if (state is NewsUnLikeSuccessState) {
              ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
            }
          },
        ),
        BlocListener<BookmarkUnBookmarkBloc, BookmarkUnBookmarkState>(
          listener: (context, state) {
            if (state is BookmarkSuccess) {
              ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
            } else if (state is UnbookmarkSuccess) {
              ScopedModel.of<NewsFeedUIModel>(context).entity = state.feed;
            }
          },
        ),
        BlocListener<SourceFollowUnFollowBloc, SourceFollowUnFollowState>(
          listener: (context, state) {
            if (state is SourceFollowSuccessState) {
              final entity = ScopedModel.of<NewsFeedUIModel>(context).entity;
              ScopedModel.of<NewsFeedUIModel>(context).entity =
                  entity.copyWith(source: state.source);
            } else if (state is SourceUnFollowSuccessState) {
              final entity = ScopedModel.of<NewsFeedUIModel>(context).entity;
              ScopedModel.of<NewsFeedUIModel>(context).entity =
                  entity.copyWith(source: state.source);
            }
          },
        ),
        BlocListener<NewsDetailBloc, NewsDetailState>(
          listener: (context, state) {
            if (state is NewsDetailErrorState) {
              context.showMessage(state.message);
            } else if (state is NewsDetailLoadErrorState) {
              context.showMessage(state.message);
            }
          },
        ),
      ],
      child: FadeInUp(
        duration: Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                feed.entity.title,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w600), //Todo: Use proper style
              ),
              const SizedBox(height: 16),
              const Source(),
              const SizedBox(height: 16),
              const AuthorAndBookmark(),
              const SizedBox(height: 16),
              Text(
                feed.entity.description ?? 'Article content not available.',
                style:
                    Theme.of(context).textTheme.subtitle1.copyWith(height: 1.5),
              ),
              // _buildAdRow(),
              const ReadMore(),
              const SizedBox(height: 8),
              const Divider(),
              const Share(),
              const SizedBox(height: 16),
              const Disclaimer(),
              const RelatedNews(),
            ],
          ),
        ),
      ),
    );
  }
}
