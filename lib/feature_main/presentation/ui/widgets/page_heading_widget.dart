import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String title;

  const PageHeading({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(title,
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w800,
              )),
    );
  }
}
