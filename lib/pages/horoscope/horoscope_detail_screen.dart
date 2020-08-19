import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/post_meta_model.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/horoscope/horoscope_detail_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/utils/extensions.dart';

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
  final ValueNotifier<bool> likeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> likeCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> commentCountNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    final store = context.read<HoroscopeDetailStore>();
    final metaStore = context.read<PostMetaStore>();
    _setupObserver(store, metaStore);
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
    likeNotifier.dispose();
    likeCountNotifier.dispose();
    commentCountNotifier.dispose();
    super.dispose();
  }

  _setupObserver(store, metaStore) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.message;
        if (message != null) context.showMessage(message);
      }),
      autorun((_) {
        final PostMetaModel metaModel = metaStore.postMeta;
        _updateMeta(metaModel);
      }),
    ];
  }

  void _updateMeta(PostMetaModel metaModel) {
    if (metaModel.isUserLiked != null)
      this.likeNotifier.value = metaModel.isUserLiked;
    if (metaModel.likeCount != null)
      this.likeCountNotifier.value = metaModel.likeCount;
    if (metaModel.commentCount != null)
      this.commentCountNotifier.value = metaModel.commentCount;
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
            backgroundImage:
                AdvancedNetworkImage(widget.signIcon, useDiskCache: true),
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
                  if (store.horoscopeModel != null) {
                    context
                        .read<ShareService>()
                        .share(
                          postId: widget.sign,
                          contentType: 'horoscope',
                          data:
                              '${widget.sign}\n${widget.zodiac}\nLast Updated: ${store.horoscopeModel.todate}',
                        )
                        .then((value) => metaStore.postShare());
                  }
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: _buildContent(context, store),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Consumer<AuthenticationStore>(
              builder: (_, authenticationStore, __) {
                return Observer(
                  builder: (_) {
                    return IgnorePointer(
                      ignoring: metaStore.postMeta == null,
                      child: CommentBar(
                        userProfileImageUrl: authenticationStore.user.avatar,
                        commentCountNotifier: this.commentCountNotifier,
                        likeCountNotifier: this.likeCountNotifier,
                        likeNotifier: this.likeNotifier,
                        onCommentTap: () {
                          context.read<NavigationService>().toCommentsScreen(
                              context: context,
                              title: 'Horoscope',
                              postId: 'horoscope');
                        },
                        onLikeTap: (value) {
                          likeNotifier.value = !value;
                          if (value) {
                            metaStore.removeLike().then((value) {
                              likeNotifier.value = !value;
                            });
                          } else {
                            metaStore.postLike().then((value) {
                              likeNotifier.value = value;
                            });
                          }
                        },
                        onShareTap: () {
                          if (store.horoscopeModel != null)
                            context
                                .read<ShareService>()
                                .share(
                                    postId: widget.sign,
                                    contentType: 'horoscope',
                                    data:
                                        '${widget.sign}${widget.zodiac}\nLast Updated: ${store.horoscopeModel.todate}')
                                .then((value) => metaStore.postShare());
                        },
                      ),
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
