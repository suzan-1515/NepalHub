import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/pages/more_menu/widgets/auth_info_widget.dart';
import 'package:samachar_hub/pages/more_menu/widgets/menu_list.dart';
import 'package:samachar_hub/pages/more_menu/widgets/more_menu_list_item.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/utils/extensions.dart';

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

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.message;
        if (message != null) context.showMessage(message);
      }),
    ];
  }

  Widget _buildSettingsMenu(BuildContext context) {
    return MoreMenuListItem(
      title: 'Settings',
      icon: FontAwesomeIcons.cog,
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
          MenuList(context: context),
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
