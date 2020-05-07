import 'package:flutter/material.dart';

class EmptyDataView extends StatelessWidget {
  final Function onRetry;

  const EmptyDataView({Key key, this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Empty Data!'),
        RaisedButton(
            child: Text('Retry'),
            onPressed: () async {
              onRetry();
            }),
      ],
    );
  }
}
