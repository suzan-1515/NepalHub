import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTagItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function(String) onTap;

  const NewsTagItem({Key key, this.title, this.icon, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        title,
        style: Theme.of(context).textTheme.button,
      ),
      avatar: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(icon),
      ),
      onPressed: () => onTap(title),
    );
  }
}
