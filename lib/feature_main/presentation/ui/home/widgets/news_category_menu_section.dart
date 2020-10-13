import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_followed_news_categories_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_menu_item.dart';

class NewsCategoryMenuSection extends StatefulWidget {
  const NewsCategoryMenuSection({
    Key key,
    @required this.homeUIModel,
  }) : super(key: key);

  final HomeUIModel homeUIModel;

  @override
  _NewsCategoryMenuSectionState createState() =>
      _NewsCategoryMenuSectionState();
}

class _NewsCategoryMenuSectionState extends State<NewsCategoryMenuSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<NewsCategoryBloc>(
      create: (context) => NewsCategoryBloc(
        getNewsCategoriesUseCase:
            context.repository<GetNewsCategoriesUseCase>(),
        getNewsFollowedCategoriesUseCase:
            context.repository<GetFollowedNewsCategoriesUseCase>(),
      )..add(GetFollowedCategories()),
      child: BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
        listener: (context, state) {
          if (state is Empty || state is Error) {
            widget.homeUIModel.shouldShowNewsCategorySection = false;
          }
        },
        builder: (context, state) {
          if (state is LoadSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SectionHeading(
                  title: 'Discover',
                  subtitle: 'Get the latest news on your favourite category',
                  onTap: () => context
                      .repository<NavigationService>()
                      .toFollowedNewsCategoryScreen(context),
                ),
                LimitedBox(
                  maxHeight: 100,
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: ListView.builder(
                      itemExtent: 120,
                      primary: false,
                      itemCount: state.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var categoryModel = state.categories[index];
                        return NewsMenuItem(
                          title: categoryModel.category.title,
                          icon: categoryModel.category.icon,
                          onTap: () => context
                              .repository<NavigationService>()
                              .toNewsCategoryFeedScreen(context, categoryModel),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
