import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/widgets/news_category_list_item.dart';

class NewsCategoryList extends StatefulWidget {
  const NewsCategoryList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<NewsCategoryUIModel> data;

  @override
  _NewsCategoryListState createState() => _NewsCategoryListState();
}

class _NewsCategoryListState extends State<NewsCategoryList> {
  Completer<void> _refreshCompleter;

  UseCase _followNewsCategoryUseCase;
  UseCase _unfollowNewsCategoryUseCase;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _followNewsCategoryUseCase = GetIt.I.get<FollowNewsCategoryUseCase>();
    _unfollowNewsCategoryUseCase = GetIt.I.get<UnFollowNewsCategoryUseCase>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsCategoryBloc, NewsCategoryState>(
      listener: (context, state) {
        if (!(state is Loading)) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          context.bloc<NewsCategoryBloc>().add(RefreshCategories());
          return _refreshCompleter.future;
        },
        child: FadeInUp(
          duration: Duration(milliseconds: 200),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              var categoryModel = widget.data[index];
              return BlocProvider<FollowUnFollowBloc>(
                create: (context) => FollowUnFollowBloc(
                    followNewsCategoryUseCase: _followNewsCategoryUseCase,
                    unFollowNewsCategoryUseCase: _unfollowNewsCategoryUseCase,
                    newsCategoryUIModel: categoryModel),
                child: NewsCategoryListItem(
                  categoryUIModel: categoryModel,
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
