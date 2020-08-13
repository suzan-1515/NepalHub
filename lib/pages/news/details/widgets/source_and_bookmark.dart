import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';

class SourceAndBookmark extends StatelessWidget {
  const SourceAndBookmark({
    Key key,
    @required this.context,
    @required this.store,
    @required this.metaStore,
  }) : super(key: key);

  final BuildContext context;
  final NewsDetailStore store;
  final PostMetaStore metaStore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 48,
          width: 48,
          child: CachedImage(store.feed.source.favicon),
        ),
        SizedBox(width: 8),
        Text(
          'Article\nPublished on\n${store.feed.source.name}',
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        SizedBox(width: 8),
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
                        if (!authStore.isLoggedIn)
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
                SizedBox(
                  height: 4,
                ),
                Text('Bookmark', textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
