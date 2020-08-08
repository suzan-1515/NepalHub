import 'package:flutter/material.dart';

class RelatedFeedHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        'Related news',
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            color:
                Theme.of(context).textTheme.subtitle1.color.withOpacity(0.6)),
      ),
    );
  }
}
