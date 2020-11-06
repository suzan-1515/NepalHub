import 'package:flutter/material.dart';

class GoldSilverTableHeader extends StatelessWidget {
  const GoldSilverTableHeader({
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
            'Gold-Silver Type',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            'Unit',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text('Price', style: Theme.of(context).textTheme.subtitle1),
        ),
      ],
    );
  }
}
