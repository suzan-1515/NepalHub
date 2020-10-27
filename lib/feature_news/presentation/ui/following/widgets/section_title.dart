import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.context,
    @required this.title,
    @required this.onRefreshTap,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final VoidCallback onRefreshTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8,
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Theme.of(context).accentColor,
          ),
          onPressed: onRefreshTap,
        ),
      ],
    );
  }
}
