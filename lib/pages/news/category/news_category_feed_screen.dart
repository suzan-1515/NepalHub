import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/news/category/widgets/news_category_feed_list.dart';
import 'package:samachar_hub/pages/news/widgets/follow_unfollow_button.dart';
import 'package:samachar_hub/pages/news/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/repository/following_repository.dart';
import 'package:samachar_hub/stores/news/category/news_category_feed_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsCategoryFeedScreen extends StatefulWidget {
  const NewsCategoryFeedScreen({Key key}) : super(key: key);
  @override
  _NewsCategoryFeedScreenState createState() => _NewsCategoryFeedScreenState();
}

class _NewsCategoryFeedScreenState extends State<NewsCategoryFeedScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<NewsCategoryFeedStore>();
    _setupObserver(store);
    store.loadInitialData();
    store.loadNewsSources();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Consumer2<NewsCategoryFeedStore, AuthenticationStore>(
            builder: (_, store, authStore, __) {
          return Observer(
            builder: (_) {
              return NewsFilteringAppBar(
                icon: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                  fit: BoxFit.cover,
                ),
                followUnFollowButton: ValueListenableBuilder<bool>(
                  valueListenable: store.categoryModel.followNotifier,
                  builder: (context, value, child) => FollowUnFollowButton(
                    followerCount: store.categoryModel.followerCount,
                    isFollowed: value,
                    onTap: (isFollowed) {
                      store.categoryModel.follow = !value;
                      if (isFollowed)
                        context
                            .read<FollowingRepository>()
                            .unFollowCategory(store.categoryModel)
                            .catchError((onError) =>
                                store.categoryModel.follow = isFollowed)
                            .whenComplete(() => context
                                .read<NewsSettingNotifier>()
                                .notify(NewsSetting.CATEGORY));
                      else
                        context
                            .read<FollowingRepository>()
                            .followCategory(store.categoryModel)
                            .catchError((onError) =>
                                store.categoryModel.follow = isFollowed)
                            .whenComplete(() => context
                                .read<NewsSettingNotifier>()
                                .notify(NewsSetting.CATEGORY));
                    },
                  ),
                ),
                onSortByChanged: (value) {
                  store.setSortBy(value);
                },
                onSourceChanged: (value) {
                  store.setSource(value);
                },
                sources: store.sources,
                title: store.categoryModel.name,
                initialSortBy: store.sort,
                initialSource: store.selectedSource,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewsCategoryFeedList(
                      context: context,
                      store: store,
                      authenticationStore: authStore),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
