import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/more_menu/more_menu_store.dart';
import 'package:samachar_hub/pages/more_menu/widgets/auth_info_widget.dart';
import 'package:samachar_hub/pages/more_menu/widgets/more_menu_list_item.dart';
import 'package:samachar_hub/services/navigation_service.dart';

class MoreMenuScreen extends StatefulWidget {
  @override
  _MoreMenuScreenState createState() => _MoreMenuScreenState();
}

class _MoreMenuScreenState extends State<MoreMenuScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    super.initState();
    final store = context.read<MoreMenuStore>();
    _setupObserver(store);
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
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

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.message;
        _showMessage(message);
      }),
    ];
  }

  Widget _buildOtherMenus(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MoreMenuListItem(
          title: 'Following',
          icon: FontAwesomeIcons.plusSquare,
          onTap: () {},
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Saved',
          icon: FontAwesomeIcons.bookmark,
          onTap: () {
            context
                .read<NavigationService>()
                .toBookmarkedNewsScreen(context: context);
          },
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Forex',
          icon: FontAwesomeIcons.chartLine,
          onTap: () {
            context.read<NavigationService>().toForexScreen(context);
          },
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Horoscope',
          icon: FontAwesomeIcons.starOfDavid,
          onTap: () {
            context.read<NavigationService>().toHoroscopeScreen(context);
          },
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Gold/Silver',
          icon: FontAwesomeIcons.ring,
          onTap: () {
            context.read<MoreMenuStore>().message =
                'This feature is comming soon!';
          },
        ),
        Divider(),
        MoreMenuListItem(
          title: 'Stock Market',
          icon: FontAwesomeIcons.poll,
          onTap: () {
            context.read<MoreMenuStore>().message =
                'This feature is comming soon!';
          },
        ),
      ],
    );
  }

  Widget _buildSettingsMenu(BuildContext context) {
    return MoreMenuListItem(
      title: 'Settings',
      icon: FontAwesomeIcons.poll,
      onTap: () {
        context.read<NavigationService>().toSettingsScreen(context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 8),
          AuthInfo(),
          Divider(
            thickness: 4,
          ),
          _buildOtherMenus(context),
          Divider(
            thickness: 4,
          ),
          _buildSettingsMenu(context),
          Divider(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
