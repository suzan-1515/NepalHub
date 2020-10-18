import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/category_feeds/news_category_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/widgets/news_category_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsCategoryFeedScreen extends StatelessWidget {
  final NewsCategoryEntity newsCategoryEntity;
  const NewsCategoryFeedScreen({Key key, @required this.newsCategoryEntity})
      : super(key: key);

  Widget _buildHeader(
      BuildContext context, NewsCategoryUIModel categoryUIModel) {
    return BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
      builder: (context, state) {
        return NewsFilterHeader(
          icon: DecorationImage(
            image: AssetImage(categoryUIModel.category.isValidIcon
                ? categoryUIModel.category.icon
                : 'assets/images/user.png'),
            fit: BoxFit.cover,
          ),
          title: categoryUIModel.category.title,
          isFollowed: categoryUIModel.category.isFollowed,
          onTap: () {
            if (categoryUIModel.category.isFollowed) {
              categoryUIModel.unfollow();
              context
                  .bloc<FollowUnFollowBloc>()
                  .add(FollowUnFollowUnFollowEvent());
            } else {
              categoryUIModel.follow();
              context
                  .bloc<FollowUnFollowBloc>()
                  .add(FollowUnFollowFollowEvent());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsProvider.categoryFeedBlocProvider(
      newsCategoryUIModel: newsCategoryEntity.toUIModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: NewsFilteringAppBar(
            header: _buildHeader(
                context, context.bloc<NewsCategoryFeedBloc>().categoryModel),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewsCategoryFeedList(),
            ),
          ),
        ),
      ),
    );
  }
}
