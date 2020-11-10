import 'package:flutter/material.dart';

import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/widgets/article_detail.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_feed_more_option.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsDetailBody extends StatelessWidget {
  const NewsDetailBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = ScopedModel.of<NewsFeedUIModel>(context);
    return OrientationBuilder(
      builder: (_, Orientation orientation) {
        switch (orientation) {
          case Orientation.landscape:
            return SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: CachedImage(
                      feed.entity.image,
                      tag: '${feed.entity.id}-${feed.entity.type}',
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: const ArticleDetail(),
                    ),
                  ),
                ],
              ),
            );
            break;
          default:
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedImage(
                          feed.entity.image,
                          tag: '${feed.entity.id}-${feed.entity.type}',
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black45,
                                Colors.black12,
                                Colors.transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.more_vert),
                      onPressed: () => context.showBottomSheet(
                        child: NewsFeedMoreOption(
                          context: context,
                        ),
                      ),
                    ),
                  ],
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: const ArticleDetail(),
                ),
              ],
            );
            break;
        }
      },
    );
  }
}
