import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.boxOpen,
          size: 48,
          color: Theme.of(context).hintColor,
        ),
        SizedBox(height: 8),
        Text(
          'Empty Data!',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
