import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';

class NewsCompactView extends StatelessWidget {
  final NewsFeed feed;
  NewsCompactView({@required this.feed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      elevation: 0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              context.read<NavigationService>().toFeedDetail(feed, context),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CachedImage(feed.isValidImage ? feed.image : null,
                    tag: feed.tag),
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
                                  imageUrl: feed.source.favicon,
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
                                text: feed.source.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n${feed.momentPublishedDate}',
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
                                feed.category.name,
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
                          feed.title,
                          maxLines: 2,
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
      ),
    );
  }
}
