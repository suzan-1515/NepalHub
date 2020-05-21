import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SectionHeadingView extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  const SectionHeadingView({
    Key key,
    this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: title,
                style: Theme.of(context).textTheme.subhead,
                children: <TextSpan>[
                  TextSpan(text: '\n'),
                  TextSpan(
                      text: subtitle,
                      style: Theme.of(context).textTheme.subtitle)
                ],
              ),
            ),
            Spacer(),
            if (onTap != null)
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.chevronRight,
                  ),
                  onPressed: () => onTap())
          ],
        ),
      ),
    );
  }
}
