import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/routes/home/widgets/article_image_widget.dart';

class ArticleInfoWidget extends StatelessWidget {
  ArticleInfoWidget(this.article);

  final Feed article;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: article.source?.getFavicon(),
                  placeholder: (context, _) =>
                      Icon(FontAwesomeIcons.image, size: 28),
                  errorWidget: (context, url, error) =>
                      Icon(FontAwesomeIcons.image, size: 28),
                ),
              ),
              SizedBox(
                width: 8,
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  text: article.formatedSource(),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(
                        text: '\n${article.formatedPublishedDate()}',
                        style: Theme.of(context).textTheme.display4)
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 4,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Text(
                  article.formatedCategory(),
                  style: Theme.of(context)
                      .textTheme
                      .display4
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 8,
        ),
        Opacity(
          opacity: 0.9,
          child: Text(
            article.description ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              child: Icon(FontAwesomeIcons.heart,size: 16,),
              onTap: (){},
              
            ),
            InkWell(
              child: Icon(FontAwesomeIcons.shareAlt,size: 16,),
              onTap: (){},
            ),
            InkWell(
              child: Icon(FontAwesomeIcons.comment,size: 16,),
              onTap: (){},
            ),
            InkWell(
              child: Icon(FontAwesomeIcons.bookmark,size: 16,),
              onTap: (){},
            ),
            InkWell(
              child: Icon(FontAwesomeIcons.ellipsisV,size: 18,),
              onTap: (){},
            ),
          ],
        ),
      ],
    );
  }
}
