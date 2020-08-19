import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class AuthorAndBookmark extends StatelessWidget {
  const AuthorAndBookmark({
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
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                text: '\n${store.feed.momentPublishedDate}',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        FadeInLeft(
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                ValueListenableBuilder<bool>(
                  valueListenable: store.feed.bookmarkNotifier,
                  builder: (_, value, __) {
                    return IconButton(
                      icon: Icon(
                        value
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        size: 36,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        final authStore = context.read<AuthenticationStore>();
                        if (!authStore.isLoggedIn || authStore.user.isAnonymous)
                          return context
                              .read<NavigationService>()
                              .loginRedirect(context);
                        if (value) {
                          store.removeBookmarkedFeed(authStore.user.uId);
                        } else {
                          store.bookmarkFeed(authStore.user);
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 4),
                Text('Bookmark', textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
