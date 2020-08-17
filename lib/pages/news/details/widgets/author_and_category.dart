import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/stores/stores.dart';

class AuthorAndCategory extends StatelessWidget {
  const AuthorAndCategory({
    Key key,
    @required this.store,
    @required this.context,
  }) : super(key: key);

  final NewsDetailStore store;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidUserCircle),
        SizedBox(width: 6),
        RichText(
          text: TextSpan(
              text: 'By ${store.feed.author}',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 13),
              children: <TextSpan>[
                TextSpan(
                  text: '\n${store.feed.momentPublishedDate}',
                  style: Theme.of(context).textTheme.caption,
                )
              ]),
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: SizedBox(
            width: 8,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(
            store.feed.category.name,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
