import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/notifier/news_setting_notifier.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/category/category_view.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/util/news_category.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  // Reaction disposers
  List<ReactionDisposer> _disposers;
  TabController _tabController;
  final List<Tab> _tabs = <Tab>[
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.tops),
        text: newsCategoryNameByCode[NewsCategory.tops]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.pltc),
        text: newsCategoryNameByCode[NewsCategory.pltc]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.sprt),
        text: newsCategoryNameByCode[NewsCategory.sprt]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.scte),
        text: newsCategoryNameByCode[NewsCategory.scte]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.wrld),
        text: newsCategoryNameByCode[NewsCategory.wrld]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.busi),
        text: newsCategoryNameByCode[NewsCategory.busi]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.entm),
        text: newsCategoryNameByCode[NewsCategory.entm]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.hlth),
        text: newsCategoryNameByCode[NewsCategory.hlth]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.blog),
        text: newsCategoryNameByCode[NewsCategory.blog]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.advs),
        text: newsCategoryNameByCode[NewsCategory.advs]),
    Tab(
        key: ValueKey<NewsCategory>(NewsCategory.oths),
        text: newsCategoryNameByCode[NewsCategory.oths]),
  ];

  @override
  void initState() {
    final store = Provider.of<CategoriesStore>(context, listen: false);
    _setupObserver(store);
    _tabController = TabController(
      initialIndex: _tabs.indexWhere((element) =>
          ((element.key as ValueKey<NewsCategory>)
              .value
              .toString()
              .split('.')
              .last) ==
          store.activeCategoryTab),
      vsync: this,
      length: _tabs.length,
    );
    _tabController.addListener(() {
      store.loadInitialFeeds(
          (_tabs[_tabController.index].key as ValueKey<NewsCategory>).value);
    });
    store.loadInitialFeeds(
        (_tabs[_tabController.index].key as ValueKey<NewsCategory>).value);

    final newsSettingNotifier = context.read<NewsSettingNotifier>();
    newsSettingNotifier.addListener(() {
      store.refresh(
          (_tabs[_tabController.index].key as ValueKey<NewsCategory>).value);
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
      Scaffold.of(context).showSnackBar(
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

  Widget _newsPopupMenuItem(icon, color, title, value) {
    return PopupMenuItem<MenuItem>(
      value: value,
      child: Row(
        children: <Widget>[
          Icon(icon, color: color),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Consumer<CategoriesStore>(
        builder: (context, topHeadlinesStore, child) {
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
                    Opacity(
                      opacity: 0.65,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: PopupMenuButton<MenuItem>(
                          icon: Icon(FontAwesomeIcons.ellipsisV),
                          onSelected: topHeadlinesStore.setView,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<MenuItem>>[
                            //Todo: Create a separate widget for PopupMenuItem
                            _newsPopupMenuItem(
                                FontAwesomeIcons.list,
                                topHeadlinesStore.view == MenuItem.LIST_VIEW
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).iconTheme.color,
                                'List View',
                                MenuItem.LIST_VIEW),
                            _newsPopupMenuItem(
                                FontAwesomeIcons.addressCard,
                                topHeadlinesStore.view ==
                                        MenuItem.THUMBNAIL_VIEW
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).iconTheme.color,
                                'Thumbnail View',
                                MenuItem.THUMBNAIL_VIEW),
                            _newsPopupMenuItem(
                                FontAwesomeIcons.image,
                                topHeadlinesStore.view == MenuItem.COMPACT_VIEW
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).iconTheme.color,
                                'Compact View',
                                MenuItem.COMPACT_VIEW),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: _tabs,
                isScrollable: true,
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: _tabs
                        .map((e) => NewsCategoryView(
                            (e.key as ValueKey<NewsCategory>).value))
                        .toList()),
              ),
            ],
          );
        },
      ),
    );
  }
}

enum MenuItem {
  LIST_VIEW,
  THUMBNAIL_VIEW,
  COMPACT_VIEW,
}
