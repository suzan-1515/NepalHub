import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';

class NewsCompactView extends StatelessWidget {
  final NewsFeedUIModel feedUIModel;
  NewsCompactView({@required this.feedUIModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      child: InkWell(
        onTap: () => GetIt.I
            .get<NavigationService>()
            .toFeedDetail(feedUIModel.feedEntity, context),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CachedImage(
                  feedUIModel.feedEntity.isValidImage
                      ? feedUIModel.feedEntity.image
                      : '',
                  tag: feedUIModel.feedEntity.hashCode.toString()),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(100, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: 28,
                              height: 28,
                              alignment: Alignment.center,
                              color: Colors.grey[100],
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: feedUIModel
                                        .newsSourceUIModel.source.favicon ??
                                    '',
                                placeholder: (context, _) =>
                                    Icon(FontAwesomeIcons.image),
                                errorWidget: (context, url, error) =>
                                    Icon(FontAwesomeIcons.image),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(
                              text: feedUIModel.newsSourceUIModel.source.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '\n${feedUIModel.publishedDateMomentAgo}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Colors.white))
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Text(
                              feedUIModel.feedEntity.category.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        feedUIModel.feedEntity.title,
                        maxLines: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
