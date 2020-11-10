import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/widgets/news_source_list_item.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsSourceListBuilder extends StatelessWidget {
  const NewsSourceListBuilder({
    Key key,
    @required this.data,
    @required this.onRefresh,
  }) : super(key: key);

  final List<NewsSourceUIModel> data;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FadeInUp(
        duration: Duration(milliseconds: 200),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: data.length,
          itemBuilder: (context, index) => NewsProvider.sourceItemBlocProvider(
            child: ScopedModel<NewsSourceUIModel>(
              model: data[index],
              child: BlocListener<SourceFollowUnFollowBloc,
                  SourceFollowUnFollowState>(
                listener: (context, state) {
                  if (state is SourceFollowSuccessState) {
                    ScopedModel.of<NewsSourceUIModel>(context).entity =
                        state.source;
                  }
                  if (state is SourceUnFollowSuccessState) {
                    ScopedModel.of<NewsSourceUIModel>(context).entity =
                        state.source;
                  }
                },
                child: const NewsSourceListItem(),
              ),
            ),
          ),
          separatorBuilder: (_, int index) => Divider(),
        ),
      ),
    );
  }
}
