import 'package:flutter/material.dart';

class ForexTableHeader extends StatelessWidget {
  const ForexTableHeader({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            'Foreign Exchange',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Text(
            'Unit',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Text('Buy', style: Theme.of(context).textTheme.subtitle1),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Text('Sell', style: Theme.of(context).textTheme.subtitle1),
        ),
      ],
    );
  }
}
