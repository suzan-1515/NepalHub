import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/pages/more_menu/widgets/more_menu_list_item.dart';
import 'package:samachar_hub/services/services.dart';

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
          onTap: () => context
              .read<NavigationService>()
              .toBookmarkedNewsScreen(context: context),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Forex',
          icon: FontAwesomeIcons.chartLine,
          onTap: () => context.read<NavigationService>().toForexScreen(context),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Horoscope',
          icon: FontAwesomeIcons.starOfDavid,
          onTap: () =>
              context.read<NavigationService>().toHoroscopeScreen(context),
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Gold/Silver',
          icon: FontAwesomeIcons.ring,
          onTap: () => context.read<MoreMenuStore>().message =
              'This feature is comming soon!',
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Stock Market',
          icon: FontAwesomeIcons.poll,
          onTap: () => context.read<MoreMenuStore>().message =
              'This feature is comming soon!',
        ),
      ],
    );
  }
}
