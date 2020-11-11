import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/news_categories_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/category/followed_news_category_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/section_title.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/view_all_button.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class FollowedNewsCategorySection extends StatelessWidget {
  const FollowedNewsCategorySection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsProvider.categoryBlocProvider(
      child: Builder(
        builder: (context) => FadeInUp(
          duration: Duration(milliseconds: 200),
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SectionTitle(
                    context: context,
                    title: 'News Categories',
                    onRefreshTap: () {
                      context
                          .read<NewsCategoryBloc>()
                          .add(GetFollowedCategories());
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FollowedNewsCategoryList(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  ViewAllButton(
                      context: context,
                      onTap: () {
                        Navigator.pushNamed(
                            context, NewsCategoriesScreen.ROUTE_NAME);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
