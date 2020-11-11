import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/news_category_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class FollowedNewsCategoryList extends StatefulWidget {
  const FollowedNewsCategoryList({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsCategoryListState createState() =>
      _FollowedNewsCategoryListState();
}

class _FollowedNewsCategoryListState extends State<FollowedNewsCategoryList> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCategoryBloc>().add(GetFollowedCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
      listener: (context, state) {
        if (state is NewsCategoryErrorState) {
          context.showMessage(state.message);
        } else if (state is NewsCategoryLoadErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) => !(current is NewsCategoryErrorState),
      builder: (context, state) {
        if (state is NewsCategoryLoadSuccessState) {
          return FadeInUp(
            duration: Duration(milliseconds: 200),
            child: LimitedBox(
              maxHeight: 100,
              child: ListView.builder(
                primary: false,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (_, index) {
                  var categoryModel = state.categories[index];
                  return NewsMenuItem(
                    title: categoryModel.entity.title,
                    icon: categoryModel.entity.icon,
                    onTap: () {
                      Navigator.pushNamed(
                          context, NewsCategoryFeedScreen.ROUTE_NAME,
                          arguments: categoryModel);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is NewsCategoryLoadErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () {
                context.read<NewsCategoryBloc>().add(GetFollowedCategories());
              },
            ),
          );
        } else if (state is NewsCategoryLoadEmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
