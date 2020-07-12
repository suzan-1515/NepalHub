import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_detail_store.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';

class HoroscopeDetailScreen extends StatefulWidget {
  final String sign;
  final String signIcon;
  final String zodiac;

  const HoroscopeDetailScreen(
      {Key key,
      @required this.sign,
      @required this.signIcon,
      @required this.zodiac})
      : super(key: key);
  @override
  _HoroscopeDetailScreenState createState() => _HoroscopeDetailScreenState();
}

class _HoroscopeDetailScreenState extends State<HoroscopeDetailScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<HoroscopeDetailStore>(context, listen: false);
    final metaStore = Provider.of<PostMetaStore>(context, listen: false);
    _setupObserver(store);
    metaStore.loadPostMeta();
    metaStore.postView();

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

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.message;
        _showMessage(message);
      }),
    ];
  }

  Widget _buildContent(BuildContext context, HoroscopeDetailStore store) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: widget.sign,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).canvasColor,
            backgroundImage: NetworkImage(widget.signIcon),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
                text: widget.sign,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                      text: '\n${store.horoscopeModel.todate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontStyle: FontStyle.italic)),
                  TextSpan(
                      text: '\n\n${widget.zodiac}',
                      style: Theme.of(context).textTheme.subtitle1),
                ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAdView(context, store) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 60,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(child: Text('Ad section')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HoroscopeDetailStore, PostMetaStore>(
      builder: (_, HoroscopeDetailStore store, PostMetaStore metaStore, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(widget.sign),
            actions: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.shareAlt),
                onPressed: () {
                  if (store.horoscopeModel != null)
                    context.read<ShareService>().share(
                        postId: widget.sign,
                        title: widget.sign,
                        data:
                            '${widget.sign}\n${widget.zodiac}\nLast Updated: ${store.horoscopeModel.todate}');
                  metaStore.postShare();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  _buildContent(context, store),
                  SizedBox(height: 16),
                  _buildAdView(context, store),
                ],
              )),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Consumer<AuthenticationStore>(
              builder: (_, authenticationStore, __) {
                return Observer(
                  builder: (_) {
                    return CommentBar(
                      userProfileImageUrl: authenticationStore.user.avatar,
                      commentsCount:
                          metaStore.postMeta?.commentCount?.toString() ?? '0',
                      likesCount:
                          metaStore.postMeta?.likeCount?.toString() ?? '0',
                      isLiked: metaStore.postMeta?.isUserLiked ?? false,
                      onCommentTap: () {
                        context.read<NavigationService>().onViewCommentsTapped(
                            context: context,
                            title: 'Horoscope',
                            postId: 'horoscope');
                      },
                      onLikeTap: (value) {
                        if (value) {
                          metaStore.removeLike().then((value) {
                            // store.feed.liked.value = !value;
                          });
                        } else {
                          metaStore.postLike().then((value) {
                            // store.feed.liked.value = value;
                          });
                        }
                      },
                      onShareTap: () {
                        if (store.horoscopeModel != null)
                          context.read<ShareService>().share(
                              postId: widget.sign,
                              title: widget.sign,
                              data:
                                  '${widget.sign}${widget.zodiac}\nLast Updated: ${store.horoscopeModel.todate}');
                        metaStore.postShare();
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
