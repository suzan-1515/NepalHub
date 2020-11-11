import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/forex_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/gold_silver_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope/horoscope_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/more_menu/widgets/more_menu_list_item.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_news/presentation/ui/bookmark/bookmark_page.dart';

class MenuList extends StatelessWidget {
  const MenuList({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MoreMenuListItem(
          title: 'Bookmarks',
          icon: FontAwesomeIcons.bookmark,
          onTap: () => Navigator.pushNamed(context, BookmarkScreen.ROUTE_NAME),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Forex',
          icon: FontAwesomeIcons.chartLine,
          onTap: () => Navigator.pushNamed(context, ForexScreen.ROUTE_NAME),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Horoscope',
          icon: FontAwesomeIcons.starOfDavid,
          onTap: () => Navigator.pushNamed(context, HoroscopeScreen.ROUTE_NAME),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Gold/Silver',
          icon: FontAwesomeIcons.ring,
          onTap: () =>
              Navigator.pushNamed(context, GoldSilverScreen.ROUTE_NAME),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Stock Market',
          icon: FontAwesomeIcons.poll,
          onTap: () {
            context.showMessage('This feature is comming soon!');
          },
        ),
      ],
    );
  }
}
