import 'package:flutter/material.dart';

class NewsFilterHeader extends StatefulWidget {
  const NewsFilterHeader({
    Key key,
    @required this.isFollowed,
    @required this.title,
    @required this.icon,
    @required this.onFollowTap,
  }) : super(key: key);

  final bool isFollowed;
  final String title;
  final DecorationImage icon;
  final Function(bool) onFollowTap;

  @override
  _NewsFilterHeaderState createState() => _NewsFilterHeaderState();
}

class _NewsFilterHeaderState extends State<NewsFilterHeader> {
  bool _isFollowed;
  final ValueNotifier<bool> _followProgressNotifier =
      ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    this._isFollowed = widget.isFollowed;
  }

  @override
  void dispose() {
    super.dispose();
    _followProgressNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).cardColor,
                image: widget.icon,
                border: Border.all(color: Theme.of(context).dividerColor)),
          ),
          SizedBox(height: 8),
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          RaisedButton(
            visualDensity: VisualDensity.compact,
            textColor: Colors.white,
            color: _isFollowed ? Colors.grey : Colors.blue,
            child: Text(_isFollowed ? 'Followed' : 'Follow'),
            onPressed: () {
              setState(() {
                _isFollowed = !_isFollowed;
              });
              widget.onFollowTap(_isFollowed);
            },
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
