import 'package:flutter/material.dart';

class NewsTagItem extends StatelessWidget {
  final String title;
  final Function onTap;

  const NewsTagItem({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        title,
        style: Theme.of(context).textTheme.display4,
      ),
      onPressed:()=> onTap(title),
      labelPadding: const EdgeInsets.all(4.0),
    );
  }
}
