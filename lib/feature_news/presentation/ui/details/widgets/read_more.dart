import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/utils/link_utils.dart';
import 'package:samachar_hub/core/widgets/webview_widget.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:scoped_model/scoped_model.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key key,
  }) : super(key: key);

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
              context.read<SettingsCubit>().settings.newsReadMode ?? 0;
          final feed = ScopedModel.of<NewsFeedUIModel>(context);
          if (newsReadMode == 2) {
            return LinkUtils.openLink(feed.entity.link);
          } else
            Navigator.pushNamed(context, InBuiltWebViewScreen.ROUTE_NAME,
                arguments: InBuiltWebViewScreenArgs(
                    title: feed.entity.title, url: feed.entity.link));
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
