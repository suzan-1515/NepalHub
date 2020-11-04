import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  const SectionHeading({
    Key key,
    this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: (subtitle == null)
                  ? Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    )
                  : RichText(
                      text: TextSpan(
                        text: title,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: subtitle,
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
                      softWrap: true,
                    ),
            ),
            if (onTap != null)
              IconButton(
                  iconSize: 20,
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
