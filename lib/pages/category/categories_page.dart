import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/category/category_store.dart';
import 'package:samachar_hub/pages/category/category_view.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/content_view_type_menu_widget.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // Reaction disposers
  List<ReactionDisposer> _disposers;
  TabController _tabController;

  @override
  void initState() {
    final store = context.read<CategoriesStore>();
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

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(apiError: apiError);
        },
      );
  }

  _setupObserver(CategoriesStore store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      }),
    ];
  }

  List<Tab> _buildTabs(List<NewsCategoryModel> data) {
    return data
        .map(
          (e) => Tab(key: ValueKey<String>(e.code), text: e.name),
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

  Widget _buildContent(CategoriesStore store, NewsRepository newsRepository) {
    return StreamBuilder<List<NewsCategoryModel>>(
      stream: store.dataStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<NewsCategoryModel>> snapshot) {
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
                        .map((e) => Provider<CategoryStore>(
                              create: (_) => CategoryStore(newsRepository,
                                  (e.key as ValueKey<String>).value),
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Consumer2<CategoriesStore, NewsRepository>(
        builder: (context, store, newsRepository, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 8, left: 16, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Categories',
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
