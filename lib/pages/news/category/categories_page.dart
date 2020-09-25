import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/news/category/widgets/category_view.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:samachar_hub/pages/widgets/content_view_type_menu_widget.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/news/category/category_screen_store.dart';
import 'package:samachar_hub/stores/news/category/news_category_feed_store.dart';
import 'package:samachar_hub/utils/extensions.dart';

class NewsCategoriesPage extends StatefulWidget {
  @override
  _NewsCategoriesPageState createState() => _NewsCategoriesPageState();
}

class _NewsCategoriesPageState extends State<NewsCategoriesPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // Reaction disposers
  List<ReactionDisposer> _disposers;
  TabController _tabController;

  @override
  void initState() {
    final store = context.read<NewsCategoryScreenStore>();
    _setupObserver(store);
    store.loadData();

    final newsSettingNotifier = context.read<NewsSettingNotifier>();
    newsSettingNotifier.addListener(() {
      if (newsSettingNotifier.setting == NewsSetting.CATEGORY) {
        store.refresh();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    _tabController.dispose();
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
      }),
    ];
  }

  List<Tab> _buildTabs(List<NewsCategory> data) {
    return data
        .map(
          (e) => Tab(key: ValueKey<NewsCategory>(e), text: e.name),
        )
        .toList();
  }

  TabController _setupTabController(List<Tab> tabs) {
    if (_tabController != null) _tabController.dispose();
    return TabController(
      initialIndex: 0,
      vsync: this,
      length: tabs.length,
    );
  }

  Widget _buildContent(
      NewsCategoryScreenStore store, NewsRepository newsRepository) {
    return StreamBuilder<List<NewsCategory>>(
      stream: store.dataStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<NewsCategory>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () => store.retry(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(
                text:
                    'News categories not available at the moment. Explore other news from home screen.',
              ),
            );
          }
          final tabs = _buildTabs(snapshot.data);
          _tabController = _setupTabController(tabs);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TabBar(
                controller: _tabController,
                tabs: tabs,
                isScrollable: true,
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: tabs
                        .map((e) => Provider<NewsCategoryFeedStore>(
                              create: (_) => NewsCategoryFeedStore(
                                  newsRepository,
                                  (e.key as ValueKey<NewsCategory>).value),
                              dispose: (context, value) => value.dispose(),
                              child: NewsCategoryView(),
                            ))
                        .toList()),
              ),
            ],
          );
        }

        return Center(
          child: ProgressView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Consumer2<NewsCategoryScreenStore, NewsRepository>(
        builder: (context, store, newsRepository, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Headlines',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return ViewTypePopupMenu(
                          onSelected: store.setView,
                          selectedViewType: store.view,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: _buildContent(store, newsRepository)),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
