import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/pages/following/widgets/followed_news_source_list.dart';
import 'package:samachar_hub/pages/following/widgets/section_title.dart';
import 'package:samachar_hub/pages/following/widgets/view_all_button.dart';
import 'package:samachar_hub/services/services.dart';

class FollowedNewsSourceSection extends StatelessWidget {
  const FollowedNewsSourceSection({
    Key key,
    @required this.context,
    @required this.favouritesStore,
  }) : super(key: key);

  final BuildContext context;
  final FollowingStore favouritesStore;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SectionTitle(context: context, title: 'News Sources'),
              SizedBox(
                height: 8,
              ),
              Flexible(
                  fit: FlexFit.loose,
                  child: FollowedNewsSourceList(
                      context: context, favouritesStore: favouritesStore)),
              SizedBox(
                height: 8,
              ),
              Divider(),
              ViewAllButton(
                  context: context,
                  onTap: () {
                    context
                        .read<NavigationService>()
                        .toFavouriteNewsSourceScreen(context)
                        .whenComplete(() => favouritesStore.retryNewsSources());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
