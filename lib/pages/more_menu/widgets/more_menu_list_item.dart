import 'package:flutter/material.dart';

class MoreMenuListItem extends StatelessWidget {
  const MoreMenuListItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Opacity(opacity: 0.7, child: Icon(icon)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
