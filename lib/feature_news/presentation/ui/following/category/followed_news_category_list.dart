import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';
import 'package:samachar_hub/utils/extensions.dart';

class FollowedNewsCategoryList extends StatefulWidget {
  const FollowedNewsCategoryList({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsCategoryListState createState() =>
      _FollowedNewsCategoryListState();
}

class _FollowedNewsCategoryListState extends State<FollowedNewsCategoryList> {
  NewsCategoryBloc _newsCategoryBloc;

  @override
  void initState() {
    super.initState();
    _newsCategoryBloc = context.bloc<NewsCategoryBloc>();
    _newsCategoryBloc.add(GetFollowedCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
      cubit: _newsCategoryBloc,
      listener: (context, state) {
        if (state is Error) {
          context.showMessage(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadSuccess) {
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
                    title: categoryModel.category.title,
                    icon: categoryModel.category.icon,
                    onTap: () {
                      context
                          .repository<NavigationService>()
                          .toNewsCategoryFeedScreen(context, categoryModel);
                    },
                  );
                },
              ),
            ),
          );
        } else if (state is Error) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () {
                _newsCategoryBloc.add(GetFollowedCategories());
              },
            ),
          );
        } else if (state is Empty) {
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
