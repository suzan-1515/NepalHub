import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/news/details/widgets/heading.dart';
import 'package:samachar_hub/pages/news/details/widgets/round_button.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/share_service.dart';
import 'package:samachar_hub/stores/stores.dart';

class Share extends StatefulWidget {
  final NewsDetailStore store;
  final PostMetaStore metaStore;

  const Share({Key key, this.store, this.metaStore}) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  bool _likeInProgress = false;

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget _buildLikeButton() {
    return ValueListenableBuilder<int>(
      valueListenable: widget.store.feed.likeCountNotifier,
      builder: (context, value, child) => RoundIconButton(
        color: Theme.of(context).accentColor.withOpacity(0.7),
        icon: widget.store.feed.isLiked
            ? FontAwesomeIcons.solidThumbsUp
            : FontAwesomeIcons.thumbsUp,
        onTap: () {
          if (_likeInProgress) return;
          _likeInProgress = true;
          final isLiked = widget.store.feed.isLiked;
          widget.store.feed.like = !isLiked;
          final authStore = context.read<AuthenticationStore>();
          if (isLiked)
            context
                .read<PostMetaRepository>()
                .removeLike(
                  postId: widget.store.feed.uuid,
                  userId: authStore.user.uId,
                )
                .catchError((onError) => widget.store.feed.like = isLiked)
                .whenComplete(() => _likeInProgress = false);
          else
            context
                .read<PostMetaRepository>()
                .postLike(
                  postId: widget.store.feed.uuid,
                  userId: authStore.user.uId,
                )
                .catchError((onError) => widget.store.feed.like = isLiked)
                .whenComplete(() => _likeInProgress = false);
        },
        text: value == 0 ? 'Like' : '${widget.store.feed.likeCountFormatted}',
      ),
    );
  }

  Widget _buildFacebookShareButton() {
    return RoundIconButton(
      color: Color.fromARGB(255, 66, 103, 178),
      icon: FontAwesomeIcons.facebookF,
      onTap: () => context
          .read<ShareService>()
          .shareToFacebook(
              postId: widget.store.feed.uuid,
              title: widget.store.feed.title,
              url: widget.store.feed.link,
              contentType: 'news')
          .then((value) {
        widget.metaStore.postShare();
      }),
      text: 'Share',
    );
  }

  Widget _buildTwitterShareButton() {
    return RoundIconButton(
      color: Color.fromARGB(255, 29, 161, 242),
      icon: FontAwesomeIcons.twitter,
      onTap: () => context
          .read<ShareService>()
          .shareToTwitter(
              postId: widget.store.feed.uuid,
              title: widget.store.feed.title,
              url: widget.store.feed.link,
              contentType: 'news')
          .then((value) {
        widget.metaStore.postShare();
      }),
      text: 'Share',
    );
  }

  Widget _buildSystemShareButton() {
    return RoundIconButton(
      color: Theme.of(context).primaryColor,
      icon: Icons.share,
      onTap: () => context
          .read<ShareService>()
          .share(
              postId: widget.store.feed.uuid,
              data: '${widget.store.feed.title}\n${widget.store.feed.link}',
              contentType: 'news')
          .then((value) {
        widget.metaStore.postShare();
      }),
      text: 'Share',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Heading(title: 'Share news'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLikeButton(),
              Container(height: 42, child: VerticalDivider()),
              _buildFacebookShareButton(),
              _buildTwitterShareButton(),
              _buildSystemShareButton(),
            ],
          ),
        ],
      ),
    );
  }
}
