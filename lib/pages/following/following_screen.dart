import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/following/following_store.dart';
import 'package:samachar_hub/pages/following/widgets/followed_news_category_section.dart';
import 'package:samachar_hub/pages/following/widgets/followed_news_source_section.dart';
import 'package:samachar_hub/pages/following/widgets/followed_news_topic_section.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/utils/extensions.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage>
    with AutomaticKeepAliveClientMixin {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<FollowingStore>(context, listen: false);
    _setupObserver(store);
    store.loadFollowedNewsSourceData();
    store.loadFollowedNewsCategoryData();
    store.loadFollowedNewsTopicData();
    super.initState();
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
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Consumer<FollowingStore>(
        builder: (_, _favouriteskStore, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PageHeading(
                title: 'Following',
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _favouriteskStore.refresh();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: FollowedNewsSourceSection(
                                context: context,
                                favouritesStore: _favouriteskStore)),
                        SizedBox(
                          height: 8,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: FollowedNewsCategorySection(
                                context: context,
                                favouritesStore: _favouriteskStore)),
                        SizedBox(
                          height: 8,
                        ),
                        Flexible(
                            fit: FlexFit.loose,
                            child: FollowedNewsTopicSection(
                                context: context,
                                favouritesStore: _favouriteskStore)),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
