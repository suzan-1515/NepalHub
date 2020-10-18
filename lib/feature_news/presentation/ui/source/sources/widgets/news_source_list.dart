import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/news_sources_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/widgets/news_source_list_item.dart';

class NewsSourceList extends StatefulWidget {
  const NewsSourceList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<NewsSourceUIModel> data;

  @override
  _NewsSourceListState createState() => _NewsSourceListState();
}

class _NewsSourceListState extends State<NewsSourceList> {
  Completer<void> _refreshCompleter;

  UseCase _followNewsSourceUseCase;
  UseCase _unfollowNewsSourceUseCase;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _followNewsSourceUseCase = context.repository<FollowNewsSourceUseCase>();
    _unfollowNewsSourceUseCase =
        context.repository<UnFollowNewsSourceUseCase>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsSourceBloc, NewsSourceState>(
      listener: (context, state) {
        if (!(state is LoadingState)) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          context.bloc<NewsSourceBloc>().add(RefreshSourceEvent());
          return _refreshCompleter.future;
        },
        child: FadeInUp(
          duration: Duration(milliseconds: 200),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              var sourceModel = widget.data[index];
              return BlocProvider<FollowUnFollowBloc>(
                create: (context) => FollowUnFollowBloc(
                    newsSourceUIModel: sourceModel,
                    followNewsSourceUseCase: _followNewsSourceUseCase,
                    unFollowNewsSourceUseCase: _unfollowNewsSourceUseCase),
                child: NewsSourceListItem(
                  sourceUIModel: sourceModel,
                ),
              );
            },
            separatorBuilder: (_, int index) => Divider(),
          ),
        ),
      ),
    );
  }
}
