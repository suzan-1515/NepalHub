import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

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
        backgroundImage: AdvancedNetworkImage(icon, useDiskCache: true),
      ),
      onPressed: () => onTap(title),
    );
  }
}
