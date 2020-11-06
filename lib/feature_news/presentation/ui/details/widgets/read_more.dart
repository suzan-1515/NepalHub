import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/utils/link_utils.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key key,
    @required this.context,
    @required this.feed,
  }) : super(key: key);

  final BuildContext context;
  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(8),
        onPressed: () {
          final int newsReadMode =
              context.bloc<SettingsCubit>().settings.newsReadMode ?? 0;
          if (newsReadMode == 2) return LinkUtils.openLink(feed.link);
          GetIt.I.get<NavigationService>().toWebViewScreen(
                feed.title,
                feed.link,
                context,
              );
        },
        icon: Icon(
          FontAwesomeIcons.link,
          color: Theme.of(context).cardColor,
        ),
        label: Text('Read Full Article',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).cardColor)),
      ),
    );
  }
}
