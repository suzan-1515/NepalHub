import 'package:flutter/material.dart';
import 'package:multi_type_list_view/multi_type_list_view.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/data/dto/news_category_menu_dto.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/pages/widgets/news_list_view.dart';
import 'package:samachar_hub/pages/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/pages/widgets/news_tags_widget.dart';
import 'package:samachar_hub/pages/widgets/news_thumbnail_view.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class SectionHeadingItemBuilder extends MultiTypeWidgetBuilder<SectionHeading> {
  @override
  Widget buildWidget(BuildContext context, SectionHeading item, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
      child: RichText(
        text: TextSpan(
          text: item.title,
          style: Theme.of(context).textTheme.subhead,
          children: <TextSpan>[
            TextSpan(text: '\n'),
            TextSpan(
                text: item.subtitle,
                style: Theme.of(context).textTheme.subtitle)
          ],
        ),
      ),
    );
  }
}

class NewsCategoryMenuItemBuilder
    extends MultiTypeWidgetBuilder<List<NewsCategoryMenu>> {
  @override
  Widget buildWidget(
      BuildContext context, List<NewsCategoryMenu> item, int index) {
    return Consumer2<HomeScreenStore, NavigationService>(
        builder: (context, homeScreenStore, navigationService, child) {
      return LimitedBox(
        maxHeight: 100,
        child: Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: NewsCategoryMenuView(
                items: item,
                onMenuTap: (categoryMenu) =>
                    navigationService.onNewsCategoryMenuTapped(
                      category: categoryMenu,
                      context: context,
                    ),
                onViewAllTap: () => homeScreenStore.setPage(1))),
      );
    });
  }
}

class NewsSourceMenuItemBuilder
    extends MultiTypeWidgetBuilder<List<FeedSource>> {
  @override
  Widget buildWidget(BuildContext context, List<FeedSource> item, int index) {
    return Consumer2<HomeScreenStore, NavigationService>(
        builder: (context, homeScreenStore, navigationService, child) {
      return LimitedBox(
        maxHeight: 160,
        child: Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: NewsSourceMenuView(
                items: item,
                onMenuTap: (sourceMenu) =>
                    navigationService.onNewsSourceMenuTapped(
                      source: sourceMenu,
                      context: context,
                    ),
                onViewAllTap: () => navigationService.onSourceViewAllTapped())),
      );
    });
  }
}

class NewsTagsItemBuilder extends MultiTypeWidgetBuilder<NewsTags> {
  @override
  Widget buildWidget(BuildContext context, NewsTags item, int index) {
    return Consumer<NavigationService>(
        builder: (context, navigationService, child) {
      return Container(
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: NewsTagsView(
            item: item,
            onTap: (tag) =>
                navigationService.onNewsTagTapped(title: tag, context: context),
          ));
    });
  }
}

class LatestFeedItemBuilder extends MultiTypeWidgetBuilder<Feed> {
  @override
  Widget buildWidget(BuildContext context, Feed item, int index) {
    Widget feedWidget;
    if (index % 3 == 0) {
      feedWidget = NewsThumbnailView(item);
    } else {
      feedWidget = NewsListView(feed: item);
    }
    return feedWidget;
  }
}

class ProgressItemBuilder extends MultiTypeWidgetBuilder<LoadingState> {
  @override
  Widget buildWidget(BuildContext context, LoadingState item, int index) {
    return Center(child: ProgressView());
  }
}

class EmptyItemBuilder extends MultiTypeWidgetBuilder<EmptyState> {
  final Function onRetry;

  EmptyItemBuilder({@required this.onRetry});
  @override
  Widget buildWidget(BuildContext context, EmptyState item, int index) {
    return Center(
        child: EmptyDataView(
      onRetry: onRetry,
    ));
  }
}

class ErrorItemBuilder extends MultiTypeWidgetBuilder<ErrorState> {
  final Function onRetry;

  ErrorItemBuilder({@required this.onRetry});
  @override
  Widget buildWidget(BuildContext context, ErrorState item, int index) {
    return Center(
      child: ErrorDataView(
        onRetry: onRetry,
      ),
    );
  }
}
