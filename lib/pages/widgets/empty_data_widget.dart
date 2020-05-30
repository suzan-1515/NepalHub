import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyDataView extends StatelessWidget {
  final Function onRetry;

  const EmptyDataView({Key key, this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(FontAwesomeIcons.handMiddleFinger,size: 64,),
        Text(
          'Empty Data!',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
