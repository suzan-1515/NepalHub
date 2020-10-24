import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/home_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
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
  NewsCategoryBloc _newsCategoryBloc;
  @override
  void initState() {
    super.initState();
    _newsCategoryBloc = GetIt.I.get<NewsCategoryBloc>();
    _newsCategoryBloc.add(GetFollowedCategories());
  }

  @override
  void dispose() {
    super.dispose();
    _newsCategoryBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<NewsCategoryBloc>.value(
      value: _newsCategoryBloc,
      child: BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
        listener: (context, state) {
          if (state is Empty || state is Error) {
            widget.homeUIModel.showNewsCategory = false;
          }
        },
        builder: (context, state) {
          if (state is LoadSuccess) {
            widget.homeUIModel.showNewsCategory = true;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SectionHeading(
                  title: 'Discover',
                  subtitle: 'Get the latest news on your favourite category',
                  onTap: () => GetIt.I
                      .get<NavigationService>()
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
                          onTap: () => GetIt.I
                              .get<NavigationService>()
                              .toNewsCategoryFeedScreen(
                                  context, categoryModel.category),
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
