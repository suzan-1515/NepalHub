import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/widgets/news_category_list_item.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsCategoryListBuilder extends StatelessWidget {
  const NewsCategoryListBuilder({
    Key key,
    @required this.data,
    @required this.onRefresh,
  }) : super(key: key);

  final List<NewsCategoryUIModel> data;
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
          itemBuilder: (context, index) =>
              NewsProvider.categoryItemBlocProvider(
            child: ScopedModel<NewsCategoryUIModel>(
              model: data[index],
              child: BlocListener<CategoryFollowUnFollowBloc,
                  CategoryFollowUnFollowState>(
                listener: (context, state) {
                  if (state is CategoryFollowSuccessState) {
                    ScopedModel.of<NewsCategoryUIModel>(context).entity =
                        state.category;
                  } else if (state is CategoryUnFollowSuccessState) {
                    ScopedModel.of<NewsCategoryUIModel>(context).entity =
                        state.category;
                  }
                },
                child: const NewsCategoryListItem(),
              ),
            ),
          ),
          separatorBuilder: (_, int index) => Divider(),
        ),
      ),
    );
  }
}
