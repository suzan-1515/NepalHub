import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String title;

  const Heading({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(title, style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
