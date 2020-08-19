import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/cached_image_widget.dart';

class Source extends StatefulWidget {
  const Source({
    Key key,
    @required this.context,
    @required this.store,
    @required this.metaStore,
  }) : super(key: key);

  final BuildContext context;
  final NewsDetailStore store;
  final PostMetaStore metaStore;

  @override
  _SourceState createState() => _SourceState();
}

class _SourceState extends State<Source> {
  final ValueNotifier<bool> _sourceFollowProgressNotifier =
      ValueNotifier<bool>(false);

  @override
  void dispose() {
    _sourceFollowProgressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 42,
          width: 42,
          child: CachedImage(widget.store.feed.source.favicon),
        ),
        SizedBox(width: 8),
        ValueListenableBuilder<int>(
          valueListenable: widget.store.feed.source.followerCountNotifier,
          builder: (context, value, child) => RichText(
            text: TextSpan(
                text: '${widget.store.feed.source.name}',
                style: Theme.of(context).textTheme.subtitle2,
                children: [
                  TextSpan(text: '\n'),
                  TextSpan(
                      text:
                          '${widget.store.feed.source.followerCountFormatted} followers',
                      style: Theme.of(context).textTheme.caption),
                ]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 4),
        Spacer(),
        ZoomIn(
          duration: const Duration(milliseconds: 200),
          child: ValueListenableBuilder<bool>(
            valueListenable: widget.store.feed.source.followNotifier,
            builder: (context, value, child) => ValueListenableBuilder<bool>(
              valueListenable: _sourceFollowProgressNotifier,
              builder: (context, inProgress, child) => IgnorePointer(
                ignoring: inProgress,
                child: FlatButton(
                  visualDensity: VisualDensity.compact,
                  color: value ? Colors.blue : null,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(6),
                        right: Radius.circular(6),
                      )),
                  onPressed: () {
                    _sourceFollowProgressNotifier.value = true;
                    final isFollowed = value;
                    widget.store.feed.source.follow = !value;
                    if (isFollowed)
                      context
                          .read<FollowingRepository>()
                          .unFollowSource(widget.store.feed.source)
                          .catchError((onError) =>
                              widget.store.feed.source.follow = isFollowed)
                          .whenComplete(() =>
                              _sourceFollowProgressNotifier.value = false);
                    else
                      context
                          .read<FollowingRepository>()
                          .followSource(widget.store.feed.source)
                          .catchError((onError) =>
                              widget.store.feed.source.follow = isFollowed)
                          .whenComplete(() =>
                              _sourceFollowProgressNotifier.value = false);
                  },
                  child: Row(
                    children: [
                      Icon(
                        value ? Icons.star : Icons.star_border,
                        color: value ? Colors.white : Colors.blue,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        value ? 'Following' : 'Follow',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: value ? Colors.white : Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
