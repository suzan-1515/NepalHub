import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SectionHeadingView extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionHeadingView({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.subhead,
          children: <TextSpan>[
            TextSpan(text: '\n'),
            TextSpan(
                text: subtitle, style: Theme.of(context).textTheme.subtitle)
          ],
        ),
      ),
    );
  }
}
