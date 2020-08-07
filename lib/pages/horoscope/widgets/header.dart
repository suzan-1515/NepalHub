import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.title,
    @required this.context,
  }) : super(key: key);

  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
