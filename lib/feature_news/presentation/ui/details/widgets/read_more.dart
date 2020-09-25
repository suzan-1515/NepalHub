import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/utils/link_utils.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key key,
    @required this.context,
    @required this.feedUIModel,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedUIModel feedUIModel;

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
                if (newsReadMode == 2)
                  return LinkUtils.openLink(feedUIModel.feed.link);
                context.repository<NavigationService>().toWebViewScreen(
                      feedUIModel.feed.title,
                      feedUIModel.feed.link,
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
