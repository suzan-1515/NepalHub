import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsCategoryFeedHeader extends StatelessWidget {
  const NewsCategoryFeedHeader();

  @override
  Widget build(BuildContext context) {
    final category =
        ScopedModel.of<NewsCategoryUIModel>(context, rebuildOnChange: true);
    return NewsFilterHeader(
      icon: DecorationImage(
        image: category.entity.isValidIcon
            ? AdvancedNetworkImage(category.entity.icon)
            : AssetImage('assets/images/user.png'),
        fit: BoxFit.cover,
      ),
      title: category.entity.title,
      isFollowed: category.entity.isFollowed,
      onTap: () {
        if (category.entity.isFollowed) {
          category.unFollow();
          context
              .read<CategoryFollowUnFollowBloc>()
              .add(CategoryUnFollowEvent(category: category.entity));
        } else {
          category.follow();
          context
              .read<CategoryFollowUnFollowBloc>()
              .add(CategoryFollowEvent(category: category.entity));
        }
      },
    );
  }
}
