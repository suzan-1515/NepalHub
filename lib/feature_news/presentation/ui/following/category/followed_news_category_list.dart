import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_followed_news_categories_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class FollowedNewsCategoryList extends StatelessWidget {
  const FollowedNewsCategoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCategoryBloc>(
      create: (context) => NewsCategoryBloc(
        getNewsCategoriesUseCase:
            context.repository<GetNewsCategoriesUseCase>(),
        getNewsFollowedCategoriesUseCase:
            context.repository<GetFollowedNewsCategoriesUseCase>(),
      )..add(GetFollowedCategories()),
      child: BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
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
                  context.bloc<NewsCategoryBloc>().add(GetFollowedCategories());
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
      ),
    );
  }
}
