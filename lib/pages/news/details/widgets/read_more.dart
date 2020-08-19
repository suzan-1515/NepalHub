import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/services/services.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key key,
    @required this.context,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final NewsDetailStore store;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              'To read the complete article, you can use external web browser or default inbuilt browser. You can change from settings.',
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: OutlineButton.icon(
              onPressed: () {
                final int newsReadMode =
                    context.read<SettingsStore>().newsReadMode;
                if (newsReadMode == 2) return store.openLink(store.feed.link);
                context.read<NavigationService>().toWebViewScreen(
                      store.feed.title,
                      store.feed.link,
                      context,
                    );
              },
              icon: Icon(FontAwesomeIcons.link),
              label: Text('Read'),
            ),
          ),
        ],
      ),
    );
  }
}
