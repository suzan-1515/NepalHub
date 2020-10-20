import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/category/followed_news_category_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/section_title.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/widgets/view_all_button.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class FollowedNewsCategorySection extends StatefulWidget {
  const FollowedNewsCategorySection({
    Key key,
  }) : super(key: key);

  @override
  _FollowedNewsCategorySectionState createState() =>
      _FollowedNewsCategorySectionState();
}

class _FollowedNewsCategorySectionState
    extends State<FollowedNewsCategorySection> {
  NewsCategoryBloc _newsCategoryBloc;
  @override
  void initState() {
    super.initState();
    _newsCategoryBloc = NewsProvider.categoryBlocProvider(context: context);
    _newsCategoryBloc.add(GetFollowedCategories());
  }

  @override
  void dispose() {
    super.dispose();
    _newsCategoryBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
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
              SectionTitle(context: context, title: 'News Categories'),
              SizedBox(
                height: 8,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: BlocProvider<NewsCategoryBloc>.value(
                  value: _newsCategoryBloc,
                  child: FollowedNewsCategoryList(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              ViewAllButton(
                  context: context,
                  onTap: () {
                    context
                        .repository<NavigationService>()
                        .toFollowedNewsCategoryScreen(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
