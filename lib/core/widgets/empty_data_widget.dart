import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyDataView extends StatelessWidget {
  final String text;
  const EmptyDataView({Key key, this.text = 'Empty Data!'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.boxOpen,
          size: 48,
          color: Theme.of(context).hintColor,
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
