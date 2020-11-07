import 'package:flutter/material.dart';

class ErrorDataView extends StatelessWidget {
  final Function onRetry;
  final String message;

  const ErrorDataView(
      {Key key, this.onRetry, this.message = 'Oops something went wrong'})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        RaisedButton(
          child: Text('Retry'),
          onPressed: () {
            onRetry();
          },
        ),
      ],
    );
  }
}
